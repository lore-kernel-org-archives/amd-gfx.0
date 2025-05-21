Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B4FC54E71
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 15:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE4810EAAD;
	Wed, 21 May 2025 15:30:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I5qLwU8x";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB08010EAC8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 15:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E532MZptgEThdwgE4lalX9UgEZmQsRFjsmpreoEoNViy3idnK5a4b2TWIwJafGlBuyUnOjGOlZ7Ub0Hx/6gv4K1f7xPVF3xXOEw3QkC/HJBMMK+z+jh3KH1W/dfNydkGk+c+ZI3Nr7dKi4Cf+lsbOozIns0gVDCmEAUC9y8MLH6Y2KHeeLT67OwIfIfB70JWj017sx+3L3D61JzSuPuM7105xDrk/pgo+AEBMgxXwBrEzrM1oeNrWUWQ9VRnt8uZezXhgVp3KOWgYPxqMhg52KjstuE5LwdQPec84thngyPcJ0b3bGo+CZDus3Z4KRcAaXKVmM3im4+HEOUJZ2lS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLOyK1C9mm15Ir6Y4ZEwsGmOXnghkAQf+DADJOrKa4c=;
 b=OiuNe7T9NuzxOLA3wa6Ph57KbBdipXOUr2cLctD1xFh/9p48Bp8hbF0wu8QEkdLSVIZsH3mo7gRiQ0EohRSwrsZZAB1Z2G/b7XoUMITA55QWWKAnzU+z+jigI0tKM+mFhmlM/tO2pel6baaGimLwGDZz/5cmYdy0p23pmIiRQoBUPMI/YgamMYQZciXVwABfgiQp/mMQnM9zAQm8j2cbmlNZLYnzi4K+xaojHbjetaFwMD9YfF0RRd7rtUl+kbzEJOmc77NTmBiR7rwwe4m9CxLIjE58aeNASmWU/I/MQe5S7X4DG5xZh5u3hPtZNMR6f4ix2TCbSYNWxZiAYbZlqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLOyK1C9mm15Ir6Y4ZEwsGmOXnghkAQf+DADJOrKa4c=;
 b=I5qLwU8xtGiN6N1V8CXwDwcSHruTbyPV0O+KrWSbLi0OLJblCz6GDSj08fbzXTpEYj02g91fJeN3Fujk2g/i+5WTfuxu/4iLlSUPuugwazNsc6yiJY9SUw+49oNeEGphkJSC/xAaU7PAOiRoL2xgmS3ciM+sPAPpCqBvAeg1De0=
Received: from PH8PR21CA0008.namprd21.prod.outlook.com (2603:10b6:510:2ce::29)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 21 May
 2025 15:29:47 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::b2) by PH8PR21CA0008.outlook.office365.com
 (2603:10b6:510:2ce::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.9 via Frontend Transport; Wed,
 21 May 2025 15:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 15:29:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 10:29:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/10] drm/amdgpu/gfx12: adjust ring reset sequences
Date: Wed, 21 May 2025 11:29:21 -0400
Message-ID: <20250521152923.401945-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521152923.401945-1-alexander.deucher@amd.com>
References: <20250521152923.401945-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|MW4PR12MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: b51ba9d1-46f8-4a63-95b6-08dd987c51be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M7+Dx6Hrr0CkKwN869FYeVv5f+YxrGtJtyCwFR14T6AT0RNUP+nSL9dKUt41?=
 =?us-ascii?Q?i+6/PtouZQ4cT6BKp9dbeEf3hlZVX90BJ1sb1iTyaf+AsW9fOftAadi8SsKg?=
 =?us-ascii?Q?4wpzxnACzXIkEOrx6AH78Dk8nRZdkNB2R2NfpUCOriDeIMI8Vu0VwTBpEhob?=
 =?us-ascii?Q?B+zcMHJqBiWfpViYQ8oNr725bEu97GaERvR4NnBNqKWnGHXiZLlHJgWwVhAG?=
 =?us-ascii?Q?pNhkxqjEw+vqDQszZ1irqWt8wkDepCNcLiSuk7U+guEsTdsUcV+iCFXERXOL?=
 =?us-ascii?Q?LwuYPobvU7p1ErsM33U+Bb3I0IvYVDYcgc3ojKuaCkXhf8BLvL4TzIQzhonA?=
 =?us-ascii?Q?s+ezbtZw6DihzEFvQ88wMFPwGNjyzpK86kf4V6mhOtUhPKSIsj7vNBL/n3j9?=
 =?us-ascii?Q?3ZCZiCJNBHddaXxCilEo7a4YygDNgPiWof4NHFVcfJD8l8ALOyOPWNFO8qIN?=
 =?us-ascii?Q?KqpdA1Ts7FC4utt7F9XKXA2YQdj5Ka0JuaGY4JuHCh+TmJDp6QxN0l5tlW2r?=
 =?us-ascii?Q?69q5IdU3NLsCJLaEru0+mYeLRyEKfQ+x6E31iV3bw9lgdE2Y9ZcQCV/Y0E9f?=
 =?us-ascii?Q?zg1PiMlu6GxOORobj3S8+QRTbAueGjmRnUHK02rBhDkhiBbSYgx59aZKsa7v?=
 =?us-ascii?Q?KCIAinKib1bNHPE5YQDzjRjUy5xdUi/66lcTxLFI9wkIuy5ZKt40jeUcfTLY?=
 =?us-ascii?Q?qvT3ajWoR0WrHFLiAkz5R0nL0uEKSNCVsv4YuJZ3oj7p5g4khUcS+rxCuaTH?=
 =?us-ascii?Q?0nMW3e5VmakB9W6PFL9P1+5s0dODvZJPyV2AprU9Q2iO+VnfDHDt+11PoEyI?=
 =?us-ascii?Q?xxeIEsCHi52ekfv8kggjW8USzdjgHx/OEr1XVtZ1+MqLtxzEGc5MtjBbtw8l?=
 =?us-ascii?Q?r/gMHuDUi8N370JG/xhOnZouOHSDAEyG0JmghkW3QBrGGpVt1gs+StgnDHzt?=
 =?us-ascii?Q?V/U3+Zkol7WprB1QHl4rvDA0xIEkuAYbBfO/pjOnADbxl4X369cBw0alciG9?=
 =?us-ascii?Q?392kj9pPb1zcjtqyYs9jEQkzk+gkRufoVCf03zK5XGfykQoScRUuerpeITuj?=
 =?us-ascii?Q?v9sKJtyChDEzCBRFhGQeBeENdIrNJCGXTiHud3dX1Tu0PGCsUXqZrX/KB0Qt?=
 =?us-ascii?Q?tUhRPwcdkP2Z4N/q2SmmSk6qjz1RF0MIdpFtM0xIdftNAltXSrkPUlO52AIo?=
 =?us-ascii?Q?p3BnialQc24IMxYleiJGKtXyOxCE4q6Xy0IzFIrehNI15hkDzzp8rqy8Rr9d?=
 =?us-ascii?Q?PzhD9ovxPuaqnYPkWy55s/1DT5t8Bg10SICq6TWF3DEFIpbrDJhDfcOVOxKn?=
 =?us-ascii?Q?YFX0p/aO9/20XNJ+0Xdc41NVODj2QtIxcvJ2RbXYzGtWZQIepxyuPO6UWbVj?=
 =?us-ascii?Q?oDxsq+ZYeVOUVeOqw6PQLx8m6H4eWv/xdPwCBCSn/sonaKirTedt1aJbvzFX?=
 =?us-ascii?Q?D36XZ/qLbEG66Vbulit5fAKhp3Gj/kXLrwxtbujZm8zGNO4q+GtS0G5mQXvk?=
 =?us-ascii?Q?ow0SrpNyhCgbsKxpdpgDcKZwU0KYlnxNFHFM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:29:47.0214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51ba9d1-46f8-4a63-95b6-08dd987c51be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611
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

Write the fence after we reset the ring and use an IB
test to validate the reset.  This is safe since we
have enforce isolation legacy enabled by default.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 855aeb7b1a89d..ee97ca472ac71 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4457,6 +4457,7 @@ static void gfx_v12_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
+	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
 
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
@@ -4464,7 +4465,8 @@ static void gfx_v12_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 				 PACKET3_RELEASE_MEM_GCR_GL2_WB |
 				 PACKET3_RELEASE_MEM_CACHE_POLICY(3) |
 				 PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
-				 PACKET3_RELEASE_MEM_EVENT_INDEX(5)));
+				 PACKET3_RELEASE_MEM_EVENT_INDEX(5) |
+				 (exec ? PACKET3_RELEASE_MEM_EXECUTE_GFX11 : 0)));
 	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_DATA_SEL(write64bit ? 2 : 1) |
 				 PACKET3_RELEASE_MEM_INT_SEL(int_sel ? 2 : 0)));
 
@@ -5344,7 +5346,13 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->fence_drv.sync_seq, 0);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v12_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5457,7 +5465,13 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->fence_drv.sync_seq, 0);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v12_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
-- 
2.49.0

