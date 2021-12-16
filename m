Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD3DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 15:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA9810E3BB;
	Thu, 16 Dec 2021 15:40:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C114F10E3BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 15:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nq7FFxDqRuBekkHWY3OeruGLpM6JiM8iZGHApy4EnEAE8Aq7WU0Z0f39CFjWHb6QKsWejIJdiJpya9UPmI3F53/Tov1tQlnTVyfcjK55G/x1mDcSywLzlqvKANa6mXJDI6AjuCfdbWJnMEfBF7Z4px3BUz0+kyMeJsHHxXYDfQGrvwpwNJrbwW66A5TNshOy9fJF+IDz47VrjxWwzOoXWtjTQpJ/gE1oljNoD3lkgtHAzczGKq+JXFYOvlx4NZ0JS8c5GlLMyCuYnQQ+sX28k4CbVQvm5QxdE0W7JCNtxgHg0j3KIv9/1vMAMtCuzwzegAF7Ou1UVBcuUlXQIRnAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRzSvcf9tY+AAiopOAnJEDAtszRliONocgTIDlRomhE=;
 b=R3wemDOOyhFewfNzstJjgtIKF/tlcGs8Xu9O655EX1H3KBwgsVqlSNnuUhxmIaQdZVEatqrn+inz0/etNTsN9fXF+ermDZ0HrdHmit+be25kzZ3jKGzsl7jnbeYMocqIXEhlyr1P5nsIfUrkmJ2PhKGteLw0mjG3iaFkbf3XyUfbjftn0EjisGN1lPkcUMj1tprbar0FJF8Oz8YX7L7sGnwUC5rw510y9nQdqw6m+GG0pck3b+BmeRl7cndOBwhGaTE7iDHZ0RtqPCCgnx23v7Twcn0F+299eeMNH/aUWWT7d3cxBWl/RVhs+sS7o1sl3LCxHsr/DWmgES27AZ/Rkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRzSvcf9tY+AAiopOAnJEDAtszRliONocgTIDlRomhE=;
 b=tYLC6di2YtkuEohDcAy4sWxq5mFobLUj6HdT9fsrfUgPnmNocrFq7AYK/j0fPebFZUCQtI6XdSrCkAq5zBUGR54rtRtOH1QDmH0SdRJJNvMRau0hJXpyn9rHl3iBsAYzSFAAdWXCrMdqxFxM8AqXHYt9KGHkOO8s6bLPiI7OgOM=
Received: from DM6PR01CA0010.prod.exchangelabs.com (2603:10b6:5:296::15) by
 BN7PR12MB2660.namprd12.prod.outlook.com (2603:10b6:408:29::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Thu, 16 Dec 2021 15:39:20 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::c9) by DM6PR01CA0010.outlook.office365.com
 (2603:10b6:5:296::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Thu, 16 Dec 2021 15:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 15:39:19 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 09:39:18 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Shaoyun.Liu@amd.com>,
 <David.Nieto@amd.com>
Subject: [PATCH v2] drm/amdgpu: Separate vf2pf work item init from virt data
 exchange
Date: Thu, 16 Dec 2021 15:39:01 +0000
Message-ID: <20211216153901.17820-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39917dec-1de8-43a2-e37f-08d9c0aa39cd
X-MS-TrafficTypeDiagnostic: BN7PR12MB2660:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB26601F2ACF14600F4B6DC27E8B779@BN7PR12MB2660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VKSgn1kJ9tCsbv1DgTZFEyXBkiLBcI9p5RShC+osiAcidMShUgYeL2iICSlY0XA0ru40GkYcClQyuAptXaNROQ379lJCFB6FrFhdPbpSF7+D/swuacD7yypYEd9gWdvtrJL8Yx1IUS9YtGMPUSTn4PIPAnlqDwtuP92UvIZTJ85B/kvHxcYPOuSJAl9ThpLE66ilSPjRQFTmJlrSmz9T2Q33IMHenJln2jL54LcgBptzy5FNgZ74u/NLBAFB7i2hUVP3hgQYAwOt4ZSXVYW7Of2y/r67ZGUNkzDnVC43ECLMPl7sbKAb62OhhERmYLVvmMNqrZWa31EOelpeCsPW2FIuxVp0AxjxWg7787gNJvRCkCHnZ0VBR4+p686eNzxtoGlTzszG9nPYSpHoE9ghRTbEfxTaZJAiCLyiamdLHyfsdlOnssUnK4+uETOcTYhNZvgFu0VvJv/8p0iDPfc+4tsVFACJrcff8+c+ngL/CUasJlxJmMjM1apAqLAfkpY8CmKieIxDGloor0J8yP2P2LCDD6Bkyi83nZYINb8ZMGXSDMdkTmP/UHWgwV0B/koF5dL28hlLUDGUDNQT3OYwUmd9Tdbv/jdtjsQTE9iNjyAsTrfCTZS2NH6+nFG2xW79wDvLovaUckG8Xs9HtAErQhf9rf2iODpuFpoeViSDXYfVihHu/sKU2sGDJaSPsLZT7sgKQhjcTVstSjEKAYFMCqKb7M8jxo2DEd0tVZiM7B+IBPGAOYrM0aidLWrMBR6IsgiuPBztJEXGPLV2f/8W48BSz4VowBYMgs8j/k4/tk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(4326008)(110136005)(316002)(6636002)(2906002)(7696005)(426003)(8936002)(70206006)(70586007)(1076003)(44832011)(26005)(6666004)(86362001)(36756003)(2616005)(8676002)(36860700001)(336012)(508600001)(16526019)(186003)(5660300002)(47076005)(83380400001)(40460700001)(356005)(82310400004)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 15:39:19.5622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39917dec-1de8-43a2-e37f-08d9c0aa39cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2660
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We want to be able to call virt data exchange conditionally
after gmc sw init to reserve bad pages as early as possible.
Since this is a conditional call, we will need to call
it again unconditionally later in the init sequence.

Refactor the data exchange function so it can be
called multiple times without re-initializing the work item.

v2: Cleaned up the code. Kept the original call to init_exchange_data()
inside early init to initialize the work item, afterwards call
exchange_data() when needed.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 36 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 48aeca3b8f16..ddc67b900587 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2316,6 +2316,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 		/* need to do gmc hw init early so we can allocate gpu mem */
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
+			/* Try to reserve bad pages early */
+			if (amdgpu_sriov_vf(adev))
+				amdgpu_virt_exchange_data(adev);
+
 			r = amdgpu_device_vram_scratch_init(adev);
 			if (r) {
 				DRM_ERROR("amdgpu_vram_scratch_init failed %d\n", r);
@@ -2347,7 +2351,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_init_data_exchange(adev);
+		amdgpu_virt_exchange_data(adev);
 
 	r = amdgpu_ib_pool_init(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3fc49823f527..f8e574cc0e22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -622,17 +622,35 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 {
-	uint64_t bp_block_offset = 0;
-	uint32_t bp_block_size = 0;
-	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
-
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
 
-	if (adev->mman.fw_vram_usage_va != NULL) {
+	if (adev->bios != NULL) {
 		adev->virt.vf2pf_update_interval_ms = 2000;
 
+		adev->virt.fw_reserve.p_pf2vf =
+			(struct amd_sriov_msg_pf2vf_info_header *)
+			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+
+		amdgpu_virt_read_pf2vf_data(adev);
+	}
+
+	if (adev->virt.vf2pf_update_interval_ms != 0) {
+		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
+		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
+	}
+}
+
+
+void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
+{
+	uint64_t bp_block_offset = 0;
+	uint32_t bp_block_size = 0;
+	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
+
+	if (adev->mman.fw_vram_usage_va != NULL) {
+
 		adev->virt.fw_reserve.p_pf2vf =
 			(struct amd_sriov_msg_pf2vf_info_header *)
 			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
@@ -663,16 +681,10 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
 
 		amdgpu_virt_read_pf2vf_data(adev);
-
-		return;
-	}
-
-	if (adev->virt.vf2pf_update_interval_ms != 0) {
-		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
-		schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
 	}
 }
 
+
 void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 {
 	uint32_t reg;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 8d4c20bb71c5..9adfb8d63280 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -308,6 +308,7 @@ int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
 void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
 void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev);
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
+void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
 void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
 void amdgpu_detect_virtualization(struct amdgpu_device *adev);
 
-- 
2.25.1

