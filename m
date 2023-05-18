Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E145C7EE24
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 07:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA4A10E4E1;
	Thu, 18 May 2023 07:05:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3811A10E4E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 07:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtNUXHnzEYB1pDh1kM1hfkMpLogYkcEo5UioD6HIbPr7+s3kLIaYul/PFmlcgHwTj+KKPjm3rM2iLNOnqMFOlhV+MHullWBz3HP+pqvoqjybdSPsm9+5Cay2HZFzXrPxfLFfsVjjhosh/nJaPu5zo1OPlc6cCflpH2k8FYyGQs1XV0j/RJpDzU2BBpvtS6b1UUhCOgk2PFvUs4UOfK61eeEba6BpRMTynaklnoUr9D7GyZ9LjA5xSSA18y+PdrzYCSb1e6pPquUVH1ltpD4gGWpTXloD7necyrvk3On0iL6X2WxJZy/2iejF4aBKaP87RALmE1RVo9yhqKAEG57iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwGOb3ueaUvKbw4Jf/XuuyAdttDSM6rKjImw1qcscrU=;
 b=LAOf1Kvb5V3MiQyGPQJJFyyUe7FMM+1vPdloTkxQnZfU6GWqHJTXrg5Nea/L2Qfz6kIcoUNI0PeXuBzTkF9xr+dJQvv7U+PcUB4OLuaGNHnK+ydoPiaXbdQBYPOG1O6fAQJ5Qz7gZ7Eg5GeDc/2ZInZE5g9PaapwBfdUL+pj40bptbppTTpXY62T9SUwBdFLEj+AsZMpbQPOOtWY9gWfOQHCMi/8RlovIAUbxpXM4fb7kBGoGrTcPdB5CaZjtNlfDWK3iUehNYzzOKpj3Spd0j/UFFPIbq5ky3Upe+F7zSiqafqhejS+VblospCa3uh9wZcxOaKU3D5i93hhoydp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwGOb3ueaUvKbw4Jf/XuuyAdttDSM6rKjImw1qcscrU=;
 b=Xij+EKuhFYcmTDj2DV33Dk1FxpqF+uC4MA+maOgB/xrQvXC/Hs/bvGl4zgleHiFQgPNDwy7bPr5kVeu+p2sRh4jbhG2UOW57y51YCbEJFcEEw1ZMyoHPBlvXF3b7nI3kmLGoEv3YCwp7MBeQK6ByzWhpxvVEFqHUUDlvxolYEu8=
Received: from MW4PR04CA0237.namprd04.prod.outlook.com (2603:10b6:303:87::32)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 07:04:55 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::7c) by MW4PR04CA0237.outlook.office365.com
 (2603:10b6:303:87::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 07:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 07:04:54 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 18 May 2023 02:04:51 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx: set sched.ready status after ring/IB test
 in gfx
Date: Thu, 18 May 2023 15:02:14 +0800
Message-ID: <20230518070215.3556653-3-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518070215.3556653-1-guchun.chen@amd.com>
References: <20230518070215.3556653-1-guchun.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8e0f85-6a3a-49ba-7351-08db576e2f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5JdvW/3HnLTVkEEGCY6F2x928KYY4uZ+Haqd6Ped2VFhC6Zpi7GXhiFAQFaoMewpTtKpszp1OVgzPXxCHxE+VilHKHv3MVERTSm7+iHlH2gPaFUL/tVUVjs9uzoBufnwAjfUBcbKsEQlEpbUx61gpCVJ1UZDFjMl76qX4TeyQ1VXRY83ceDsE/TuBjMCJuus/2D7V52nGsqoCLkS1SLoWL1zA+mnqCp9Tgl4IIaBAt2/zSmNGPien7AEY+PdincsLgfH7gANTaoYYadaKimrdAPAuLVZ7lmRDyJjegF1ki275JaoLf+USr4Tf304430bUwV+VmdGP2hNgvf7vPJy3WaA71X7NOsGVoQeHUr0GizU987BLy3o5EtKuzQnIRH8NSOGwwpjWxouacjLFz1UnY+lhGyHyAtO5M1T89fIfIYr3YV808C4FyqUDsAJ7BSaT11QxXhYep4qhOjD3GTeohwtZPwWQ/tT0GtDKvvbdVjdV3RTf+3upPRro2mNVU95NUqLzs8atOYRggsZ97gmK8R0jLFLsvu3+zLRxM8uggDb1oU2M296t3UDrJL/Mv0GP972LXXHMJiug9/9NofyrascJHGV2HcZ4FskV4HosNlC1g0oylVq9LivVYAHDzBc4j6PasGAPoiOL9RjUW3Z7mv197OIaJh1cdpIBMbEUvm5jMeg1Gw4NQbJVtGWIRSKLqzMzk4xOsc+/PhIeeTc3hk2UOk3wUv3EmdHwBOv6hJaSKUeqBoaUPaUwaEr/W8OpNuoEejjBAokS5fCIsNPSbKV9mZyrGE/aOjvjp+7SA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(26005)(1076003)(8936002)(336012)(186003)(16526019)(36860700001)(5660300002)(83380400001)(47076005)(426003)(70206006)(4326008)(70586007)(2616005)(44832011)(6636002)(41300700001)(110136005)(6666004)(7696005)(2906002)(8676002)(478600001)(316002)(356005)(81166007)(36756003)(86362001)(82310400005)(82740400003)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 07:04:54.8359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8e0f85-6a3a-49ba-7351-08db576e2f02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sched.ready is nothing with ring initialization, it needs to set
to be true after ring/IB test in amdgpu_ring_test_helper to tell
the ring is ready for submission.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 24 ++++--------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 25 ++++---------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  1 -
 5 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8e86b2c23c0a..d57671c729bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6073,7 +6073,6 @@ static int gfx_v10_0_cp_gfx_resume(struct amdgpu_device *adev)
 	u32 tmp;
 	u32 rb_bufsz;
 	u64 rb_addr, rptr_addr, wptr_gpu_addr;
-	u32 i;
 
 	/* Set the write pointer delay */
 	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_DELAY, 0);
@@ -6168,11 +6167,6 @@ static int gfx_v10_0_cp_gfx_resume(struct amdgpu_device *adev)
 	/* start the ring */
 	gfx_v10_0_cp_gfx_start(adev);
 
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-		ring->sched.ready = true;
-	}
-
 	return 0;
 }
 
@@ -6470,7 +6464,7 @@ static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 
 		r = amdgpu_bo_reserve(ring->mqd_obj, false);
 		if (unlikely(r != 0))
-			goto done;
+			return r;
 
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
@@ -6480,23 +6474,14 @@ static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 		}
 		amdgpu_bo_unreserve(ring->mqd_obj);
 		if (r)
-			goto done;
+			return r;
 	}
 
 	r = amdgpu_gfx_enable_kgq(adev, 0);
 	if (r)
-		goto done;
-
-	r = gfx_v10_0_cp_gfx_start(adev);
-	if (r)
-		goto done;
+		return r;
 
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-		ring->sched.ready = true;
-	}
-done:
-	return r;
+	return gfx_v10_0_cp_gfx_start(adev);
 }
 
 static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
@@ -6810,7 +6795,6 @@ static int gfx_v10_0_kiq_resume(struct amdgpu_device *adev)
 	amdgpu_bo_kunmap(ring->mqd_obj);
 	ring->mqd_ptr = NULL;
 	amdgpu_bo_unreserve(ring->mqd_obj);
-	ring->sched.ready = true;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f77779c31043..b9a4ef396628 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3228,7 +3228,6 @@ static int gfx_v11_0_cp_gfx_resume(struct amdgpu_device *adev)
 	u32 tmp;
 	u32 rb_bufsz;
 	u64 rb_addr, rptr_addr, wptr_gpu_addr;
-	u32 i;
 
 	/* Set the write pointer delay */
 	WREG32_SOC15(GC, 0, regCP_RB_WPTR_DELAY, 0);
@@ -3320,11 +3319,6 @@ static int gfx_v11_0_cp_gfx_resume(struct amdgpu_device *adev)
 	/* start the ring */
 	gfx_v11_0_cp_gfx_start(adev);
 
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-		ring->sched.ready = true;
-	}
-
 	return 0;
 }
 
@@ -3370,8 +3364,6 @@ static void gfx_v11_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, data);
 	}
 
-	adev->gfx.kiq[0].ring.sched.ready = enable;
-
 	udelay(50);
 }
 
@@ -3711,7 +3703,7 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 
 		r = amdgpu_bo_reserve(ring->mqd_obj, false);
 		if (unlikely(r != 0))
-			goto done;
+			return r;
 
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
@@ -3721,23 +3713,14 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 		}
 		amdgpu_bo_unreserve(ring->mqd_obj);
 		if (r)
-			goto done;
+			return r;
 	}
 
 	r = amdgpu_gfx_enable_kgq(adev, 0);
 	if (r)
-		goto done;
-
-	r = gfx_v11_0_cp_gfx_start(adev);
-	if (r)
-		goto done;
+		return r;
 
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-		ring->sched.ready = true;
-	}
-done:
-	return r;
+	return gfx_v11_0_cp_gfx_start(adev);
 }
 
 static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 2ae7f167985f..22828bdb5c70 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4283,7 +4283,6 @@ static int gfx_v8_0_cp_gfx_resume(struct amdgpu_device *adev)
 	/* start the ring */
 	amdgpu_ring_clear_ring(ring);
 	gfx_v8_0_cp_gfx_start(adev);
-	ring->sched.ready = true;
 
 	return 0;
 }
@@ -4693,7 +4692,6 @@ static int gfx_v8_0_kiq_resume(struct amdgpu_device *adev)
 	amdgpu_bo_kunmap(ring->mqd_obj);
 	ring->mqd_ptr = NULL;
 	amdgpu_bo_unreserve(ring->mqd_obj);
-	ring->sched.ready = true;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e093e83ae739..dcfaf3176da4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3144,7 +3144,6 @@ static int gfx_v9_0_cp_gfx_resume(struct amdgpu_device *adev)
 
 	/* start the ring */
 	gfx_v9_0_cp_gfx_start(adev);
-	ring->sched.ready = true;
 
 	return 0;
 }
@@ -3621,7 +3620,6 @@ static int gfx_v9_0_kiq_resume(struct amdgpu_device *adev)
 	amdgpu_bo_kunmap(ring->mqd_obj);
 	ring->mqd_ptr = NULL;
 	amdgpu_bo_unreserve(ring->mqd_obj);
-	ring->sched.ready = true;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 9d17dcfae130..fa97c8c603f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1829,7 +1829,6 @@ static int gfx_v9_4_3_kiq_resume(struct amdgpu_device *adev, int xcc_id)
 	amdgpu_bo_kunmap(ring->mqd_obj);
 	ring->mqd_ptr = NULL;
 	amdgpu_bo_unreserve(ring->mqd_obj);
-	ring->sched.ready = true;
 	return 0;
 }
 
-- 
2.25.1

