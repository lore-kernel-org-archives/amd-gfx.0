Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22814C25B47
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 14:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC76310E65F;
	Wed, 25 Oct 2023 14:02:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CCCA10E661
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 14:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiikssXNLJQvAtCJit+OrpPAX+QoVTRrR2OwgGo8xf1u+Icz1/qY/UZD17xwE0/GBPfFFFt1TSfsFHX3eXPb1x7CmVTPt1qejrGGhAIpnNaApz9OLJtg13hRvhOgOX2ySCrsDNY69GX8yfZcqPs0nWltWIj8de9tNMGvc7NFV0iyPji/zsl5dF31vtolOCXVwnH0Xzq0sq9GGA5Ubky2Y0sSGB/cwclfM075Zm3OsJUozM2pWZKe0THNZnX3MS5bEZXEXxQUkK+7P60BCj4SX3TsjS6Bd98mHB0qRzPZLu3j24gwNGX/AsOFmqF1rkvj+8hbAxSOiJHtI8jlfdlS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOaowMYFXuqlj7ISvzasI2ZCYwq7Kfg+5msADv54F5Y=;
 b=VJC2zAHnQ+dzrx1NqrMDk9+cbyf3PzyAYkWSXcqDvhXp3SkCqcz57AucraurKu9P20N3B6CH4vyXrFoCYFdMU4BybR6SLL7DhiG3k2npht8yEvD7oGC9FntrOMdb4v6huUQJE4pJ2qgyEdM1kmbhLsUe8AfOEn8s/TFY8gG9TmWwHEbtmqfZJsgF/hcUDG3nbwuj7Fr8/OJZp7VwXJk7neefrYY5mkEVCe8jmJ4OOEMyR+6ryKxTWTdx1a9wko+AOidd8UEohVoMdACOkfeiZod5CuVRV/wU+kWtjYYA7aPvJzf7dOPaC81X+3WiBfdvxRzv0gWYlxK6/ANG/gr/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOaowMYFXuqlj7ISvzasI2ZCYwq7Kfg+5msADv54F5Y=;
 b=aVr7ySD1ffFK8iriKW/o4grtX6EZGsAXhBSx+ZYNx0nM4s7OCMXptbeiKuWFRWgQR97BqObTVwbfBONnNGSFps2QcrZILGLOiPabKtOOerfkhaysN3+2Dtxgxv8eTRLqQ23TFFYCN1+VtmzxFG50JToCQflX8N1PW0dHKzteQDE=
Received: from CH2PR18CA0040.namprd18.prod.outlook.com (2603:10b6:610:55::20)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 14:02:25 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::fa) by CH2PR18CA0040.outlook.office365.com
 (2603:10b6:610:55::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Wed, 25 Oct 2023 14:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 14:02:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 09:02:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: move buffer funcs setting up a level
Date: Wed, 25 Oct 2023 10:02:10 -0400
Message-ID: <20231025140210.2500185-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e327ac7-9695-4496-6850-08dbd56303e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6+T8YWgGcLmM4PSDt9el13pOSDM+a9bdqAKOb/T16PUSo0+8ARUzBCqlw8ZJcdL7PKqtGWuvZADfrfkx9IVej5grF/Xw3GaF69LBsTnwsKqcb4Z1MkGw6DA14qoqnQNVRxyMDvBC3McbSds6ylZUN7l0fQzs0s6GXT11GaITbK4NSwRchRGfXPR3rWfxgF8DXDawVFyQjHy1lmfO23iGu7AzdYhfoq4p8ji8E0XOGEI1I47Vh4Qdu9rgUeHlenN/AOuY6xHfLhKYRogjCjT0QAzIvr9fOQNrcG/PnWX3OUzFmUwvYDiahZy4hHjnW2So6PMN3JZ3OXE4L48I25Dz5mJaElIDJPRS75pio12LMcK6T6mDCdIXZJ0Nybl8sLz8Zm2wN0PoukgZmoYBFhETw4OoSCsTtQjgMyEQFXd31sCuYnuPt51Uw6uEaJmEFLEyxBGOtx7hprec4MZRWkohwoXsHWJv75D86hJ5K7KIfdUdJtbymZ288qKfmudbt4/nliiiz0he6CuiZHiAI2sV7Dll/Xjv0kCbtgnEuHB0gvhRd43+nNyWBpFOFNT2K3/HINVt6cS4G+mt421IsBKxWaZAq7H0XMgNEylZy3Xv1o2rlODjVbVwB1CdcjScv2X9UqkzaisPzRjB6v9A42lsqa0WkVJ718Tn65Ec85hn0Ml6uQqzikXwF7YzxWB/9tfykgUTB+3ygWcT3o37XJfAhfI0RKFXnbueUZPoKyHARG+tbMtIiBgmnnmyslffOgKHiGqnTLk5nHq8QKTKipWyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(16526019)(7696005)(2616005)(47076005)(70206006)(6666004)(336012)(1076003)(83380400001)(8936002)(8676002)(4326008)(41300700001)(54906003)(5660300002)(36860700001)(2906002)(478600001)(30864003)(70586007)(86362001)(6916009)(356005)(316002)(81166007)(82740400003)(426003)(26005)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:02:24.5314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e327ac7-9695-4496-6850-08dbd56303e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rather than doing this in the IP code for the SDMA paging
engine, move it up to the core device level init level.
This should fix the scheduler init ordering.

v2: drop extra parens

Tested-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 23 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  5 -----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  5 -----
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  5 -----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 16 +--------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 10 +---------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     | 10 +---------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 10 +---------
 drivers/gpu/drm/amd/amdgpu/si_dma.c        |  5 -----
 11 files changed, 40 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2031a467b721..046216f516bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2662,6 +2662,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
+	amdgpu_sdma_set_buffer_funcs_helper(adev);
+
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (!adev->gmc.xgmi.pending_reset) {
 		kgd2kfd_init_zone_device(adev);
@@ -3260,6 +3262,8 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
 		amdgpu_virt_request_full_gpu(adev, false);
 	}
 
+	amdgpu_sdma_unset_buffer_funcs_helper(adev);
+
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
 		return r;
@@ -3449,6 +3453,8 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 
 	r = amdgpu_device_ip_resume_phase2(adev);
 
+	amdgpu_sdma_set_buffer_funcs_helper(adev);
+
 	return r;
 }
 
@@ -4236,6 +4242,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	/* disable ras feature must before hw fini */
 	amdgpu_ras_pre_fini(adev);
 
+	amdgpu_sdma_unset_buffer_funcs_helper(adev);
+
 	amdgpu_device_ip_fini_early(adev);
 
 	amdgpu_irq_fini_hw(adev);
@@ -4407,6 +4415,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_ras_suspend(adev);
 
+	amdgpu_sdma_unset_buffer_funcs_helper(adev);
+
 	amdgpu_device_ip_suspend_phase1(adev);
 
 	if (!adev->in_s0ix)
@@ -5178,6 +5188,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				if (r)
 					goto out;
 
+				amdgpu_sdma_set_buffer_funcs_helper(tmp_adev);
+
 				if (vram_lost)
 					amdgpu_device_fill_reset_magic(tmp_adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index e8cbc4142d80..d4dc00e5a328 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -292,6 +292,29 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 	return err;
 }
 
+void amdgpu_sdma_set_buffer_funcs_helper(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *sdma;
+	int i;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (adev->sdma.has_page_queue) {
+			sdma = &adev->sdma.instance[i].page;
+			if (adev->mman.buffer_funcs_ring == sdma &&
+			    sdma->sched.ready) {
+				amdgpu_ttm_set_buffer_funcs_status(adev, true);
+				break;
+			}
+		}
+		sdma = &adev->sdma.instance[i].ring;
+		if (adev->mman.buffer_funcs_ring == sdma &&
+		    sdma->sched.ready) {
+			amdgpu_ttm_set_buffer_funcs_status(adev, true);
+			break;
+		}
+	}
+}
+
 void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *sdma;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 513ac22120c1..33209593e974 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -169,6 +169,7 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
 			       bool duplicate);
 void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
         bool duplicate);
+void amdgpu_sdma_set_buffer_funcs_helper(struct amdgpu_device *adev);
 void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
 int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index ee5dce6f6043..a3fccc4c1f43 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -308,8 +308,6 @@ static void cik_sdma_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
 		rb_cntl &= ~SDMA0_GFX_RB_CNTL__RB_ENABLE_MASK;
@@ -498,9 +496,6 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index b58a13bd75db..45377a175250 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -339,8 +339,6 @@ static void sdma_v2_4_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
@@ -474,9 +472,6 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index c5ea32687eb5..2ad615be4bb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -513,8 +513,6 @@ static void sdma_v3_0_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
@@ -746,9 +744,6 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 683d51ae4bf1..3d68dd5523c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -877,8 +877,6 @@ static void sdma_v4_0_gfx_enable(struct amdgpu_device *adev, bool enable)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, enable ? 1 : 0);
@@ -913,8 +911,6 @@ static void sdma_v4_0_page_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_PAGE_RB_CNTL,
@@ -1402,13 +1398,7 @@ static int sdma_v4_0_start(struct amdgpu_device *adev)
 			r = amdgpu_ring_test_helper(page);
 			if (r)
 				return r;
-
-			if (adev->mman.buffer_funcs_ring == page)
-				amdgpu_ttm_set_buffer_funcs_status(adev, true);
 		}
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return r;
@@ -1921,11 +1911,8 @@ static int sdma_v4_0_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* disable the scheduler for SDMA */
-		amdgpu_sdma_unset_buffer_funcs_helper(adev);
+	if (amdgpu_sriov_vf(adev))
 		return 0;
-	}
 
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
 		for (i = 0; i < adev->sdma.num_instances; i++) {
@@ -1964,7 +1951,6 @@ static int sdma_v4_0_resume(void *handle)
 	if (adev->in_s0ix) {
 		sdma_v4_0_enable(adev, true);
 		sdma_v4_0_gfx_enable(adev, true);
-		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 		return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index be5d099c9898..c78027ebdcb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -559,8 +559,6 @@ static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
@@ -825,9 +823,6 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
@@ -1426,11 +1421,8 @@ static int sdma_v5_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* disable the scheduler for SDMA */
-		amdgpu_sdma_unset_buffer_funcs_helper(adev);
+	if (amdgpu_sriov_vf(adev))
 		return 0;
-	}
 
 	sdma_v5_0_ctx_switch_enable(adev, false);
 	sdma_v5_0_enable(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index a3e8b10c071c..2e35f3571774 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -364,8 +364,6 @@ static void sdma_v5_2_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
@@ -625,9 +623,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
@@ -1284,11 +1279,8 @@ static int sdma_v5_2_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* disable the scheduler for SDMA */
-		amdgpu_sdma_unset_buffer_funcs_helper(adev);
+	if (amdgpu_sriov_vf(adev))
 		return 0;
-	}
 
 	sdma_v5_2_ctx_switch_enable(adev, false);
 	sdma_v5_2_enable(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 445a34549d2c..1c6ff511f501 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -348,8 +348,6 @@ static void sdma_v6_0_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 0);
@@ -561,9 +559,6 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
@@ -1308,11 +1303,8 @@ static int sdma_v6_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* disable the scheduler for SDMA */
-		amdgpu_sdma_unset_buffer_funcs_helper(adev);
+	if (amdgpu_sriov_vf(adev))
 		return 0;
-	}
 
 	sdma_v6_0_ctxempty_int_enable(adev, false);
 	sdma_v6_0_enable(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 42c4547f32ec..9aa0e11ee673 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -115,8 +115,6 @@ static void si_dma_stop(struct amdgpu_device *adev)
 	u32 rb_cntl;
 	unsigned i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		/* dma0 */
 		rb_cntl = RREG32(DMA_RB_CNTL + sdma_offsets[i]);
@@ -177,9 +175,6 @@ static int si_dma_start(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
-- 
2.41.0

