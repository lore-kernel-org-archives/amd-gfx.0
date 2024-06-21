Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D07C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 09:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A98010F124;
	Fri, 21 Jun 2024 09:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y2WeL4uO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D233010F124
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 09:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6kWapL45x17jGCuJcFZdH9SZ2ZAqAblIXFTWkErIw7Icp86UvQ7GPzoDAbO+8nzHATXitT1AHQw7ZHifSryIhuq9OhiD4aaEWyGtwaB/4lv89Pv5V4pE81YK0kz5ccL8p4odw9vGB/3a4+9Tp8HGwulYK0iWEHvayuAUKcwPkNKYetVOlL7a/jVoI1pz+LpXIkqtcDkYXS8oguFwUOYhr3TDZM1Rb+eNy65dNgg6d8lFk+nm2rNL1RnvjTDBioSkpvoLLwpr3zYDgcVRgviXSbOWYTiynLm3NHq4PD1JMl6sAuuSKGpEaw/Rn9kzD7zP1XUk7siLU8HoE5nlRRPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBQU1g5ojKN9qhVz1FbBekims0EQTxHfLfaqsjFFZIs=;
 b=LXU4BkXraTlnhTqrr5kcOB5NBuqDx0BtKo7SpJsYlF4IV3OnHstzj+dLXaB2UKJXqgfYWDvu/D5DFbMWpid8PmL69gvDVqLH1hUgqJmSAGr6On5R7PMYLN+JVsvtjt3yTmivv6Frs1Zm36M3hb7PfjgLmm9qwBfDcEuKinvsVZXP7raltu34ejYk4yUuQnTLdS5Vp6hF6Yvm1OTQCTf8RdmddLZt3v7a2EApRBw4ufjBk7U2COipzjc87r8cN24JZtKuKJbmyW6q7fm8kbB4SxSugcdxr0wRa03pmqL2ownXjZfDkw8bWqSTfPimcIFYtOOvpAdEHe/Yzl8cCdvQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBQU1g5ojKN9qhVz1FbBekims0EQTxHfLfaqsjFFZIs=;
 b=Y2WeL4uOYi/H9VzyA0OOdcXq8c63nBuMoIM1ImWMitGnifv4FNZxM02wVqSygkgu5xt1K0z2JHAoxxD8K9hifvL2ltNyx8Djy4dhX6c5iCMTwFbuig8d5kTYI95ZpoP1Ur0Gn4udHh6V5tU6iXOSxCnY62y600OoWbMU2AYYEZE=
Received: from DS0PR17CA0020.namprd17.prod.outlook.com (2603:10b6:8:191::27)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 09:25:04 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::8c) by DS0PR17CA0020.outlook.office365.com
 (2603:10b6:8:191::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 09:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 09:25:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 04:25:01 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Jun 2024 04:24:59 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Tim.Huang@amd.com>,
 <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, Bob Zhou <bob.zhou@amd.com>
Subject: [PATCH] drm/amdgpu: add missing error handling for amdgpu_ring_alloc()
Date: Fri, 21 Jun 2024 17:24:54 +0800
Message-ID: <20240621092454.42879-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e68cd1-cb28-45b6-6142-08dc91d40859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|82310400023|36860700010|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NYtNL2ak52s9a7YcwVc++ms61bucV1riDhBXsOj3fxk5OHo0/ceZNcN0gpld?=
 =?us-ascii?Q?GfGcx1j7una/OHo/gO/zJB2omGQUtaUbdHO9Vg5CfsZ3cRBvqqb5Tq28pPFB?=
 =?us-ascii?Q?RXUgy1YO1eKPmXTWBpL9ObiPVTEHRii7mGB0zL7W87ITK5C7HNtXj9PGgnIs?=
 =?us-ascii?Q?HnsXlJBlwvew3qK5Io1b+ayQMyU19dhJX7GKnb17QhW8s033fZfqcUY0rJBQ?=
 =?us-ascii?Q?fRpjjV7ajArS/+yerj9SUOfKZj49PKFcnqLFi4UScegPLjtnWHlLBlROWi3+?=
 =?us-ascii?Q?s4nK77xbIzd89DWFch0zf1tbQWvP4Qegza5TcF5Zj6WvFnJ5v0bkzAIc/rD1?=
 =?us-ascii?Q?RzftB/5689+CGam1mNbRcXx2u86/vxGzktx7kzhTcNiw3B55qZ5F9jTWm7oj?=
 =?us-ascii?Q?1SBjdt50Jl7TZrrAGW5rJudFVi16ZOaf/KFAgBJk+a5h0TxUiLCmZDBU1UnE?=
 =?us-ascii?Q?+ZNJ0EozlJ6M33xnW623AkAuPSvisjsOfc6uzp82QusSl514EvIaQyhyuBGA?=
 =?us-ascii?Q?MRTKUpI+JBvi/VsUkfcXPR2UP5eaCHQ3KdngoYy557ZLUFhHpzV5kMJdCYgh?=
 =?us-ascii?Q?oWTqrBJD83TeJbw3qtSsugsZ54l2iZU8PCgjU+8JctmhVZQpF12AP6c9uwBb?=
 =?us-ascii?Q?dA8PQuP+op04uvjQDFVviSSAKOdmLIYOhQBVv3ukKSj2+voJXlHVUVHP7okk?=
 =?us-ascii?Q?29x0sKnnEoGlb9swhbkdTFW7tlNAbtFDEHNz4TzmJWa/rMbogVvW/IOWJ+0l?=
 =?us-ascii?Q?+hLLgHm9brgm5y6D3ff3bfYMa52zuMFqhk4RFqkUMxDE5r2ABfsrE618CbsU?=
 =?us-ascii?Q?BcSS3Or/8zxyAldrWGN6g7pPw0bULVPP6oqwaN8xnAp/O9qKijUpelUVjx09?=
 =?us-ascii?Q?JOapI+whrlsLTlpYlO+Ee8Z4qrSQMI6oSY3E5pGaF0G70OQotWNGzTUtUUAb?=
 =?us-ascii?Q?e7X4J/ExSyIeM9KJPw0IDmWLSA62SFdPL179y7d3CQ/UwH9APMKJujyqDr7H?=
 =?us-ascii?Q?GR2JqvdcnkvC4ubCPlZhtESTuos6omOYSJG5QFPcSHJqeRTqPWfhZPMMHYqf?=
 =?us-ascii?Q?1mMB4aWP2vRPK/OaimXazm9HtXoufWNC1bit2xFY9TVxiXqfshrF1rzB/Tpk?=
 =?us-ascii?Q?6dYkCv9MUEjIsSq1e/waZsaMmPsrmXALagsJ0en6N1FflfAff09UvQW0bjJs?=
 =?us-ascii?Q?sU/FVL+9p9N9NzxS80+Vk9lJB1n/nHutR2xf7czJR57dl7+CyxijQ8Uz7b4B?=
 =?us-ascii?Q?t0YXz3oDvircjHjSHWErNLjg2ERBeE6Ad8z9f0nPGBdhjDvHTvhtcZLv9J7N?=
 =?us-ascii?Q?ZqEU+k5koIk596ybM4784xRSBxVpJKI1z2BYKtpqqcYwiMhyM1ivrgVDKMQL?=
 =?us-ascii?Q?1ioQMl2m9FvRHEq0OD8hosox2uCRNs5QiBkchbh5NVrG8yQsSg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(82310400023)(36860700010)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 09:25:03.7843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e68cd1-cb28-45b6-6142-08dc91d40859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the unchecked return value warning reported by Coverity,
so add error handling.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c      | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c      | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c      | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c       | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c       | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c       | 6 +++++-
 8 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 82452606ae6c..25cab6a8d478 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1005,7 +1005,8 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 		pr_err("critical bug! too many kiq readers\n");
 		goto failed_unlock;
 	}
-	amdgpu_ring_alloc(ring, 32);
+	if (amdgpu_ring_alloc(ring, 32))
+		goto failed_unlock;
 	amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
 	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
 	if (r)
@@ -1071,7 +1072,8 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 	}
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
-	amdgpu_ring_alloc(ring, 32);
+	if (amdgpu_ring_alloc(ring, 32))
+		goto failed_unlock;
 	amdgpu_ring_emit_wreg(ring, reg, v);
 	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
 	if (r)
@@ -1107,6 +1109,7 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 
 failed_undo:
 	amdgpu_ring_undo(ring);
+failed_unlock:
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_write:
 	dev_err(adev->dev, "failed to write reg:%x\n", reg);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3a7622611916..778941f47c96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -768,7 +768,8 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 	}
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
-	amdgpu_ring_alloc(ring, 32);
+	if (amdgpu_ring_alloc(ring, 32))
+		goto failed_unlock;
 	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
 					    ref, mask);
 	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
@@ -798,6 +799,7 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 
 failed_undo:
 	amdgpu_ring_undo(ring);
+failed_unlock:
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq:
 	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index d234b7ccfaaf..01864990a192 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -63,12 +63,14 @@ static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
 		return;
 	}
 	if (start > end) {
-		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start);
+		if (amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start))
+			return;
 		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start],
 					   (ring->ring_size >> 2) - start);
 		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
 	} else {
-		amdgpu_ring_alloc(real_ring, end - start);
+		if (amdgpu_ring_alloc(real_ring, end - start))
+			return;
 		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index bad232859972..d7d68e61506d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -610,7 +610,8 @@ static int vpe_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	/* emit the trailing fence */
 	ring->trail_seq += 1;
-	amdgpu_ring_alloc(ring, 10);
+	if (amdgpu_ring_alloc(ring, 10))
+		return -ENOMEM;
 	vpe_ring_emit_fence(ring, ring->trail_fence_gpu_addr, ring->trail_seq, 0);
 	amdgpu_ring_commit(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2929c8972ea7..810f7f7e279d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4093,7 +4093,8 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 		pr_err("critical bug! too many kiq readers\n");
 		goto failed_unlock;
 	}
-	amdgpu_ring_alloc(ring, 32);
+	if (amdgpu_ring_alloc(ring, 32))
+		goto failed_unlock;
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 9 |	/* src: register*/
 				(5 << 8) |	/* dst: memory */
@@ -5639,7 +5640,10 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
 
 	ring->trail_seq += 1;
-	amdgpu_ring_alloc(ring, 13);
+	if (amdgpu_ring_alloc(ring, 13)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
 	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
 				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC | AMDGPU_FENCE_FLAG_INT);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index b7d33d78bce0..07ca9264085b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1490,7 +1490,11 @@ static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	/* emit the trailing fence */
 	ring->trail_seq += 1;
-	amdgpu_ring_alloc(ring, 10);
+	r = amdgpu_ring_alloc(ring, 10);
+	if (r) {
+		DRM_ERROR("ring %d failed to be allocated\n", ring->idx);
+		return r;
+	}
 	sdma_v5_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
 				  ring->trail_seq, 0);
 	amdgpu_ring_commit(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index cc9e961f0078..d51d5bd7de30 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1345,7 +1345,11 @@ static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	/* emit the trailing fence */
 	ring->trail_seq += 1;
-	amdgpu_ring_alloc(ring, 10);
+	r = amdgpu_ring_alloc(ring, 10);
+	if (r) {
+		DRM_ERROR("ring %d failed to be allocated\n", ring->idx);
+		return r;
+	}
 	sdma_v5_2_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
 				  ring->trail_seq, 0);
 	amdgpu_ring_commit(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index c833b6b8373b..e82426459cc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1371,7 +1371,11 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	/* emit the trailing fence */
 	ring->trail_seq += 1;
-	amdgpu_ring_alloc(ring, 10);
+	r = amdgpu_ring_alloc(ring, 10);
+	if (r) {
+		DRM_ERROR("ring %d failed to be allocated\n", ring->idx);
+		return r;
+	}
 	sdma_v6_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
 				  ring->trail_seq, 0);
 	amdgpu_ring_commit(ring);
-- 
2.34.1

