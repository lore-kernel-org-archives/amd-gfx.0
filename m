Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82EDC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 07:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD93C10E755;
	Fri, 22 Jul 2022 07:35:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 966D910E755
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 07:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNmaxRtxcti+sLG/cx4+13GPWA76/TarycpWxIggMjrrGcOkHJ44VUmHYKZK1vomkFXXpL6cQJ6rJ9ynNUffQVAGOMdqRydDiVBXeIM7FFGN8yz/TgUYR3dqRiQkCnfyv+UTcfi8kLRSOP/e5N69plWUNGWkf4TjabBrQnTf7+ujcO/H0TsdUPg7EQE1P2UHJAPXz2Absf+OPs5qNWgON1izVEll8VB8g6j8cdvXxJ/bkCpVy6U+/5UzJzA0MOMWeWInN6MyF9Ze6z8MROSa3/zZow80PNarsuO/Z7ZRr/Jip7OOuymVRVx8IadNECl4v3xouBx5ZIJyxjrEV3QPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE73m+TcLZHBU6xc2Vv6Nfl/+ihigaG0wOlg70Aub2M=;
 b=V/Qx8EoluIEkgJ+2T9BP/UOsisAsPEJB40lzP8diTfAH7DHIAs95ZzNxaIxjL/uo9ei1rxX7SLGb0DUekgyT3mO76TUlClea2UTguAqc+SvDaLnee1ls7N2Gc4BT2UW0ILBY28oCOek/39z71kgQDw/8VR+AOVUdrBGDjpyx8UFRjvUS8Av05dgOcA/SlKbyr18Fpl4pO9OY7yR9mIXMC2rSE+Zm7eri7Ihpw1N0FkH3kvU1MF2L/dyHCp6BLyJivUJD6jrcp42m+/Ked4LEfzSbGgCE9c5qpJdaci4v0YHwT8bdGoN36f1RAm+bpSfHgiBuiBFSa7cfbMY+Wa1n3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE73m+TcLZHBU6xc2Vv6Nfl/+ihigaG0wOlg70Aub2M=;
 b=zufIYPlH0/mD4aqmeoYtCPpsOpWuLu2JqY03qFa7amHGh2RMR0JX1n6vLgH2GF/ItuRCPuWd1FnZvHmS2KGzjrUv/tjfFXx+mHNbsaA/7ZZiIpgzoy1mCoWe9sHsaac06+9/z2k11T9QcH54uHqYzBd8LYL60eHSO59WCrHIKc8=
Received: from BN9PR03CA0725.namprd03.prod.outlook.com (2603:10b6:408:110::10)
 by CH2PR12MB4840.namprd12.prod.outlook.com (2603:10b6:610:c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Fri, 22 Jul
 2022 07:35:07 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::9e) by BN9PR03CA0725.outlook.office365.com
 (2603:10b6:408:110::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Fri, 22 Jul 2022 07:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 07:35:06 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 02:35:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 00:34:57 -0700
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 22 Jul 2022 02:34:56 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: reduce reset time
Date: Fri, 22 Jul 2022 15:34:03 +0800
Message-ID: <20220722073403.5171-5-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722073403.5171-1-Victor.Zhao@amd.com>
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29f5e4db-2c73-4260-7fbd-08da6bb4b31d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4840:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pu8sqm7Mr+edDkgGPQozOLWoYnE7ZE1NNbvQZtRyQmbra5yV1Ze/sizBQeotaOpI+I5Z6/27zyWCwB9gREZybGqatSZWj8cOxpE0t0rgF0XVDdTQqKj5Cc1SYh1iiW0D4tSpimtM5Ik0UijUkckKk4EXKjZbVI+0k/cErFuCN3xwY7xhqxOGLm3XV0e+z4pR3Hk4QCjfVcioQAtJ5mb9pcaeJTmoBurM7b8BwyBqM/k/vKGw/6m2eTKojWKsRj+7bapWPt7ouQFfYhtv2RnrbvBX4/sT9nuQopp0C4i0EUmNgFFeGoPM1WwRY7eK2xMMDvL9fac2f43xIrY6STG3j1SFgpDZVMUSqSvPo/shy8tBk07fivp/NSb7LXZKBwObKIMuqecmchTX5kNm91gneK6uDMMFKnGNDhbtGTnKPBY13iZ7UG0QdVaWvTSFnco9hYmIMroap/uEpGW+ve7ImgAASGTNMDmHKiS/FE5d9Hg0lgfcf5cMmj4OXUWCCugSSyU7UJC/+dHSfp5kShYK9rzCyVO2al6zuzCB8fRcttSFLXglKTm+2fEY6vGTxrQRgt9SBNh5RxrZl59QnnSKmHkji2TeH+5eYNzrlcNS1iyL9GNJNBWj3IpfPoKohJ67aZx6f7iupXFqB03UanAo36q+gDH4QHNPeZPihIMeBEfNgVfG+bI+Xny4iyyxU+/ZDLtUhHfq+ZzxyvBCDpIcjpP+gg7wfA0mZJ1YHcTJ+HsH92Dtioj/y+VtG3Ck17LO9gRsrp4SzWtmc7dHOk39c7KrIx/4QPhda33FW0rzD/qdqwOBcC3J4bv92UsdrmgUK1O9gjv+2troWwTI2H5sAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(40470700004)(36840700001)(46966006)(36756003)(83380400001)(70586007)(356005)(1076003)(82740400003)(36860700001)(86362001)(5660300002)(336012)(47076005)(40460700003)(81166007)(186003)(8936002)(54906003)(478600001)(41300700001)(2906002)(6666004)(316002)(6916009)(426003)(7696005)(4326008)(2616005)(70206006)(82310400005)(8676002)(26005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 07:35:06.9061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f5e4db-2c73-4260-7fbd-08da6bb4b31d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4840
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
Cc: Alexander.Deucher@amd.com, emily.deng@amd.com,
 Victor Zhao <Victor.Zhao@amd.com>, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In multi container use case, reset time is important, so skip ring
tests and cp halt wait during ip suspending for reset as they are
going to fail and cost more time on reset

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 26 +++++++++++++++----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 222d3d7ea076..f872495ccc3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -477,7 +477,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
 		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
 					   RESET_QUEUES, 0, 0);
 
-	if (adev->gfx.kiq.ring.sched.ready)
+	if (adev->gfx.kiq.ring.sched.ready && !amdgpu_in_reset(adev))
 		r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&adev->gfx.kiq.ring_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index fafbad3cf08d..9ae29023e38f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5971,16 +5971,19 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
 	}
 
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
-			break;
-		udelay(1);
-	}
-
-	if (i >= adev->usec_timeout)
-		DRM_ERROR("failed to %s cp gfx\n", enable ? "unhalt" : "halt");
+	if (!amdgpu_in_reset(adev)) {
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
+				break;
+			udelay(1);
+		}
 
+		if (i >= adev->usec_timeout)
+			DRM_ERROR("failed to %s cp gfx\n",
+				  enable ? "unhalt" : "halt");
+	}
 	return 0;
+
 }
 
 static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
@@ -7569,8 +7572,10 @@ static int gfx_v10_0_kiq_disable_kgq(struct amdgpu_device *adev)
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[i],
 					   PREEMPT_QUEUES, 0, 0);
-
-	return amdgpu_ring_test_helper(kiq_ring);
+	if (!amdgpu_in_reset(adev))
+		return amdgpu_ring_test_helper(kiq_ring);
+	else
+		return 0;
 }
 #endif
 
@@ -7610,6 +7615,7 @@ static int gfx_v10_0_hw_fini(void *handle)
 
 		return 0;
 	}
+
 	gfx_v10_0_cp_enable(adev, false);
 	gfx_v10_0_enable_gui_idle_interrupt(adev, false);
 
-- 
2.25.1

