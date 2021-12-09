Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AFCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F0A10FB62;
	Thu,  9 Dec 2021 16:55:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B11C10E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 16:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qqgql2DWCrNO3i2hXBVpIM38YEQSt8c3be5RtiL3ma1W9BJwKPSHKLmr6j+wC7hpKbauHeFpcL0ip8GlF2BFPqZDWWAleF0CxzeoBVtc/Ts/gj083A832lopGXhoRpdqYwLdyNdUSRD2oCrnS1C+HUB9uUlG1tLfRJTzmsyrJibTzCsj8q+a8bYzn1elCYa6AAdKOB+vSpIcaoJdWDa17fcYK3Le1DUNxba7PsHfxASw5ITv77Qrso6lJezA0rv5bCL01m9cluuhf8t0yCAJHR4qqvBf0OHrjwxf14DUK6Cj05qFLHRB4V1++YugkcaXN9f4eyt2fzA1j9TPjl+epg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FALiHg/DkKW/WX2jeVk9otZRp5vQGkNZp+NwscFHiHk=;
 b=RWB0oGu6Vyyo/dU/FAKM0XtXG6lmNiDP+LF2sQm2oy1qUxQ4FX5c5ZLd8xk/dmwRhDH6vZ+fGVZIAB8yCqKTDVQiGDjVetg0qXnGr+rW/Vm5Ib1KvIWzaHpYhkLvysY2FxGKk+ccHXmp2zwVr9XM9uhjw1GYKnteTjH737yCOJpj9Nn6misUw573PhioOffQpzfbpWdUr6vzzhWXlVnzLx2pRcG/YnDt5rn5SbxcU5g04liPFOjSWCiazAprMfvbhfEZ4+ydCm9Id8j45O37S7H+F0MpUUX7YZx5TaOhyyI3LVLVsVO8vU5Zo3EkJ+f6r/wLCYVF/5pYJyufjcEjLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FALiHg/DkKW/WX2jeVk9otZRp5vQGkNZp+NwscFHiHk=;
 b=wKNA52W63q0XmS0g0oJpctxe0w0YgN8uoK0vwkfO+R5FdPhRgLWYY8j8MqGdUjDmfnyEBcr8cA0uWw05PXeRWEZSxR9m/hdR1CjOV+Kxzz4VuqQK4BbD9h64eszCyOIjyZ9SbpECGHJsZcCkAO7mTh6f8eBJ7dLUEOIj5jtGoOY=
Received: from DM5PR06CA0031.namprd06.prod.outlook.com (2603:10b6:3:5d::17) by
 DM6PR12MB3913.namprd12.prod.outlook.com (2603:10b6:5:1cc::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20; Thu, 9 Dec 2021 16:48:21 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::ae) by DM5PR06CA0031.outlook.office365.com
 (2603:10b6:3:5d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Thu, 9 Dec 2021 16:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 16:48:21 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 9 Dec
 2021 10:48:20 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Separate vf2pf work item init from virt data
 exchange
Date: Thu, 9 Dec 2021 16:48:08 +0000
Message-ID: <20211209164809.504378-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ad3ad94-5e3b-49f6-8c90-08d9bb33b5bc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3913:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB39132B6C53E3B4551CE29E378B709@DM6PR12MB3913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I85RsYb1yluOq16c+vAbKrJE771fwNTQJP6GLmsaYxeVcHy/X6JJkHOJaDo2DVWbUdH7pKErBlW7RZMkDtUoRNVcFRzQpftf0Gxr11AabqR//DQxuRE4TWCkfeBj7hwQZ0KOIdUMU7NW5bY0TYyDE9wgEe3jiTd20Y0oUFDPfjYc4fBMz18d5qleoc9yI9q1h9+USYj1MqRt0Hs+a6hunXfOX1Q4HDKB/LGKoQQ+fBBQDRYDoOQ/aQ8ul4vY8pqRNjIW0jcbrckOm1+Prpp0gcLZKDcoFSFyCpIvDK0VEM2oREABUiqiLQy2e/MW7U+103hvJWd8W72m8FVMv1TG8Mifd3ys0jbtRxjXH2L6WTb3mbnN1IMk12F9EBueDT/wVM3tKMsL6GMS0hnO4CGW9G+4U8SjQhZ7nQQwhTFpF6HY6srsLXy3wNLVdT8TXqPGWzz83IFm9TJB0/uMdqejYO5G+WkFXt6fAkygqTIlg7H6hiuyksC3951rewjI5eKIgOpFPqrRqX/G53samuP5LostJ02BHOkUpVB91U42+ZiQyouDPv+ldXQKIMWLfDzVOCM5jFf8Sr4+moxLea8KptRYmJzeqkEjgnxomkQNRiCa3t3glCNkQm6zt3FtTZplFsNlLHHq9sEtwBAtgNYKu77+rwc8XMbheDI6g6Hkl5eYS7N2sjxBfFL0ttrodmUYiCy3qSjDC5mTHYizc66QFWzOMWrijjtHrng0LG0Z2OAXcdCivMJDEP8LG2hVVomQGh66qP1To/6VLnURboTBaItfGJvRqC7krghku6ISu4Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(1076003)(36860700001)(36756003)(40460700001)(86362001)(6916009)(26005)(6666004)(2616005)(186003)(508600001)(336012)(426003)(82310400004)(7696005)(4326008)(8676002)(70206006)(70586007)(8936002)(5660300002)(2906002)(16526019)(356005)(316002)(81166007)(44832011)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 16:48:21.5321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad3ad94-5e3b-49f6-8c90-08d9bb33b5bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
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

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 42 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  5 +--
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  2 +-
 5 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ce9bdef185c0..3992c4086d26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2181,7 +2181,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
 			/*get pf2vf msg info at it's earliest time*/
 			if (amdgpu_sriov_vf(adev))
-				amdgpu_virt_init_data_exchange(adev);
+				amdgpu_virt_exchange_data(adev);
 
 		}
 	}
@@ -2345,8 +2345,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		}
 	}
 
-	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_init_data_exchange(adev);
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_exchange_data(adev);
+		amdgpu_virt_init_vf2pf_work_item(adev);
+	}
 
 	r = amdgpu_ib_pool_init(adev);
 	if (r) {
@@ -2949,7 +2951,7 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
 	int r;
 
 	if (amdgpu_sriov_vf(adev)) {
-		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_fini_vf2pf_work_item(adev);
 		amdgpu_virt_request_full_gpu(adev, false);
 	}
 
@@ -3839,7 +3841,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	 * */
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_request_full_gpu(adev, false);
-		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_fini_vf2pf_work_item(adev);
 	}
 
 	/* disable all interrupts */
@@ -4317,7 +4319,9 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	amdgpu_virt_init_data_exchange(adev);
+	amdgpu_virt_exchange_data(adev);
+	amdgpu_virt_init_vf2pf_work_item(adev);
+
 	/* we need recover gart prior to run SMC/CP/SDMA resume */
 	amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
 
@@ -4495,7 +4499,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	if (amdgpu_sriov_vf(adev)) {
 		/* stop the data exchange thread */
-		amdgpu_virt_fini_data_exchange(adev);
+		amdgpu_virt_fini_vf2pf_work_item(adev);
 	}
 
 	/* block all schedulers and reset given job's ring */
@@ -4898,7 +4902,7 @@ static void amdgpu_device_recheck_guilty_jobs(
 retry:
 			/* do hw reset */
 			if (amdgpu_sriov_vf(adev)) {
-				amdgpu_virt_fini_data_exchange(adev);
+				amdgpu_virt_fini_vf2pf_work_item(adev);
 				r = amdgpu_device_reset_sriov(adev, false);
 				if (r)
 					adev->asic_reset_res = r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3fc49823f527..b6e3d379a86a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -611,16 +611,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
 }
 
-void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
-{
-	if (adev->virt.vf2pf_update_interval_ms != 0) {
-		DRM_INFO("clean up the vf2pf work item\n");
-		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
-		adev->virt.vf2pf_update_interval_ms = 0;
-	}
-}
-
-void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
+void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 {
 	uint64_t bp_block_offset = 0;
 	uint32_t bp_block_size = 0;
@@ -628,11 +619,8 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
-	adev->virt.vf2pf_update_interval_ms = 0;
 
 	if (adev->mman.fw_vram_usage_va != NULL) {
-		adev->virt.vf2pf_update_interval_ms = 2000;
-
 		adev->virt.fw_reserve.p_pf2vf =
 			(struct amd_sriov_msg_pf2vf_info_header *)
 			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
@@ -666,13 +654,39 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 
 		return;
 	}
+}
+
+void amdgpu_virt_init_vf2pf_work_item(struct amdgpu_device *adev)
+{
+	if (adev->mman.fw_vram_usage_va != NULL) {
+
+		/* Inverval value is passed from the host.
+		 * Correct too large or too little interval value
+		 */
+		if (adev->virt.vf2pf_update_interval_ms < 200 || adev->virt.vf2pf_update_interval_ms > 10000)
+			adev->virt.vf2pf_update_interval_ms = 2000;
+
+		adev->virt.fw_reserve.p_pf2vf =
+			(struct amd_sriov_msg_pf2vf_info_header *)
+			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+		adev->virt.fw_reserve.p_vf2pf =
+			(struct amd_sriov_msg_vf2pf_info_header *)
+			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
 
-	if (adev->virt.vf2pf_update_interval_ms != 0) {
 		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
 		schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
 	}
 }
 
+void amdgpu_virt_fini_vf2pf_work_item(struct amdgpu_device *adev)
+{
+	if (adev->virt.vf2pf_update_interval_ms != 0) {
+		DRM_INFO("clean up the vf2pf work item\n");
+		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
+		adev->virt.vf2pf_update_interval_ms = 0;
+	}
+}
+
 void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 {
 	uint32_t reg;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 8d4c20bb71c5..c18a7daab693 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -307,8 +307,9 @@ int amdgpu_virt_wait_reset(struct amdgpu_device *adev);
 int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
 void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
 void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev);
-void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
-void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
+void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
+void amdgpu_virt_init_vf2pf_work_item(struct amdgpu_device *adev);
+void amdgpu_virt_fini_vf2pf_work_item(struct amdgpu_device *adev);
 void amdgpu_detect_virtualization(struct amdgpu_device *adev);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 23b066bcffb2..cd2719bc0139 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -255,7 +255,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	if (!down_write_trylock(&adev->reset_sem))
 		return;
 
-	amdgpu_virt_fini_data_exchange(adev);
+	amdgpu_virt_fini_vf2pf_work_item(adev);
 	atomic_set(&adev->in_gpu_reset, 1);
 
 	xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index a35e6d87e537..2bc93808469a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -284,7 +284,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	if (!down_write_trylock(&adev->reset_sem))
 		return;
 
-	amdgpu_virt_fini_data_exchange(adev);
+	amdgpu_virt_fini_vf2pf_work_item(adev);
 	atomic_set(&adev->in_gpu_reset, 1);
 
 	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
-- 
2.25.1

