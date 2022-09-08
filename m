Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F56C38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 08:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C1FB10E9A6;
	Thu,  8 Sep 2022 08:43:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C5010E9A6
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 08:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2MP9oe/iRoCMrxumTvVZT06/05mGl1cmnstjtadfzBlGO8O0gr/NROTGzbcXQzpO/7+TQtUPCgjP28cu5D6qF958gNeBNIQ6s0HwVyTAucD3pZ0x3tWG/mLVUPkDniRJNzmf07ni1xioVU1JNssHIIhhAtL7hBFHoBThw3pwmp150A5pfaVV4a4w9ZOat2CMXUWgtTqyL2XonNMpyImwyTbPSXfKkxKbQBy2q5daGludOSKIXVL96nQWHe//TDxhRIs+RrApJSeDCvGYh463ARoc3oiaY2FxHbMG0kpJ7wQFpFq+GZUugbTu+B5QokaHcGJv+7K/imhykqckcitZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iueEGf1tO0gqhD+q6bdJeLO5NDopPfRVYFeqVCE7wkg=;
 b=HaByAKQ8X0G2hYcW41oyXECh/NrifKjjYy0yqM9DQOMaJFPVhGaPyxLGOSCUykLxUBhzSb5h1K++fSXiNKcgxvvXvAg0gQ2vvnUkJ3gx4BNkgn+Cf9YR50MqRYcHiPf3busMQsirl401jTuAntBg2CtvTu6BoZhiMq9NflEN6AYl7uaiZmbaPbCcn5QTW+EA9wQcenrVlnzrTCbo8vcwL6CtleMQeTkaQL+qmMiNgDGP8IPqLa7O+kD68qNGxleskAdRrNWSS7IrCK4ScimFaIeNrQLnIlWF4m19hqptJE6+scAc/B7hscBOPnSQDptOWQOHkesZGLivlTTZDQ7nrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iueEGf1tO0gqhD+q6bdJeLO5NDopPfRVYFeqVCE7wkg=;
 b=sc59SNd7i4BYrhfz/IrBvcoXbY6j528pCZu3cnmzmXphhzNMWgITDFQIPJsPMZqJNDdH2G4L/3wMbtZ88Nq8WMkNareZV0D6NhGQpkAK4ZpAgM0H2eYJok3K0PdP1Pj8WDmo4xQAXpuYocI94CueyxijNS+49BIrs0qhy/IqdfM=
Received: from BN0PR04CA0024.namprd04.prod.outlook.com (2603:10b6:408:ee::29)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 08:43:50 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::20) by BN0PR04CA0024.outlook.office365.com
 (2603:10b6:408:ee::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Thu, 8 Sep 2022 08:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 08:43:50 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 03:43:48 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 1/3] drm/amdgpu: Adjust removal control flow for smu v13_0_2
Date: Thu, 8 Sep 2022 16:42:34 +0800
Message-ID: <20220908084236.110566-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: ce085bdb-611b-4adc-6f12-08da917640f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekYkoNOnkFAbg4yg/wmZjhk0LIUldpQz5ZTDYP/S55PGjWgH/x09drkHE5E+d5POqGwF7Owu53ZroUq4q94tLukOz8Ti6RWGdLz1o1w90qMK762vBYZlhMJ1lIMHB7GBFUAVLS1TcwilUhLR3yOLwy1jbYRrdNG+ZhS/Tepb/scri1gqOZ14f/J/mLaj0PbStDVJE1FzpFphQ7cBChUKxc4DzJDX4oVh94YNAP3AIXXBsAyUywpQUMrzL6j4A2JwGEFDj38uQ2h2N9aHUU80mQIt7YtZLAaV+BsSyxN2gYeFDiF6ybUneWIcy47FU/LVA5vflJNeHZDUYTUfZ8shozt8RauDODN3xZGS/meeB6VRVxxZaZ9kI+PDQmLOu3xU+3Du4NDaNR8xSQ+g2RObttokqQZ9dIMCTI1ofJYx/NwuyY2Cw4EFq7thx9ERP8Dbv5UhdRxJrcsZeSSB2p81+uhV1HKDla5Dms9b9hm4X1ybiEP+oUytvyQ1OWYf1Zt8r0IMve/1lJdDLpVWlbtRfLOoKO1mJ3AnEzwPT3w4SYhQRKleBE1NIbFRwj6u9n+OKy0B2zL5EY/KppMdNOjt9gPWE4Hl5GJKV9dmrowS+nD7Trap3sIL7veR/BNDYq2kxYGv3u0kKwlVyigmIIeFoVHo0qpDBbKyhe9OHYsEw099K6BLoafmr+6mVFlMF75ZFN+GX3pI3sPoIdXAf1vQapSaoO3I61Q9CNqQndVX3e3s2M8IUKjHIQ0RWiZN68vwAhseKwZ4Y21o8PW9kxChX7LPGzQfwPak6XRkOwXxZp1+hjYPv7fDT8UuFGl2PHiMPOKmaxnUhvIdnSkz1IUPUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966006)(40470700004)(36840700001)(47076005)(40480700001)(426003)(83380400001)(336012)(1076003)(186003)(2616005)(16526019)(5660300002)(2906002)(316002)(36860700001)(6916009)(54906003)(70206006)(70586007)(8676002)(8936002)(4326008)(36756003)(356005)(81166007)(26005)(7696005)(478600001)(82310400005)(86362001)(41300700001)(40460700003)(82740400003)(6666004)(36900700001)(473944003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 08:43:50.7232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce085bdb-611b-4adc-6f12-08da917640f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>,
 KevinYang.Wang@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adjust removal control flow for smu v13_0_2:
   During amdgpu uninstallation, when removing the first
device, the kernel needs to first send a mode1reset message
to all gpu devices. Otherwise, smu initialization will fail
the next time amdgpu is installed.

V2:
1. Update commit comments.
2. Remove the global variable amdgpu_device_remove_cnt
   and add a variable to the structure amdgpu_hive_info.
3. Use hive to detect the first removed device instead of
   a global variable.

V3:
 1. Update commit comments.
 2. Split a patch into multiple patches.
 3. The current patch does:
    a. Add a work mode of AMDGPU_RESET_FOR_DEVICE_REMOVE into
       the existing gpu recover path, which make all devices
       in hive list only have HW reset but no resume (except
       the base IP).
    b. Call AMDGPU_RESET_FOR_DEVICE_REMOVE and
       AMDGPU_NEED_FULL_RESET mode of amdgpu_device_gpu_recover
       in amdgpu_pci_remove when removing the first device in
       hive list.
    c. When removing the first device, the IP blocks keyword
       function call sequence is as follows:
.suspend->mode1reset->.resume(basic ip)->.hw_fini->.early_fini->.sw_fini.
   ^                           |
   |-<----------<---------<----|
	The first three sequences are because of a call to
        amdgpu_device_gpu_recover. The three sequences will be
        executed in a loop until all devices in the hive list
        are iterated.
        The sequences starting from .hw_fini only apply to the
        first device. Since .suspend has been called before,
        except the resumed phase1 basic ip blocks, all other ip
        blocks .hw_fini of current device will do nothing.
     d. When removing other devices, the calling sequences is the
        same as legacy:
	   .hw_fini -> .early_fini -> .sw_fini.
	Since .suspend has been called when removing the first device,
        except the resumed phase1 basic ip blocks, all of other ip
        blocks .hw_fini of current device will do nothing.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 29 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  1 +
 4 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62b26f0e37b0..a2614b881128 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2999,6 +2999,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			DRM_ERROR("suspend of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
 		}
+
 		adev->ip_blocks[i].status.hw = false;
 		/* handle putting the SMC in the appropriate state */
 		if(!amdgpu_sriov_vf(adev)){
@@ -4739,6 +4740,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	struct amdgpu_device *tmp_adev = NULL;
 	bool need_full_reset, skip_hw_reset, vram_lost = false;
 	int r = 0;
+	bool gpu_reset_for_dev_remove = 0;
 
 	/* Try reset handler method first */
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
@@ -4758,6 +4760,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 	skip_hw_reset = test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->flags);
 
+	gpu_reset_for_dev_remove =
+		test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context->flags) &&
+			test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
+
 	/*
 	 * ASIC reset has to be done on all XGMI hive nodes ASAP
 	 * to allow proper links negotiation in FW (within 1 sec)
@@ -4802,6 +4808,19 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		amdgpu_ras_intr_cleared();
 	}
 
+
+	/* Since the mode1 reset affects base ip blocks, the
+	 * phase1 ip blocks need to be resumed. Otherwise there
+	 * will be a BIOS signature error and the psp bootloader
+	 * can't load kdb on the next amdgpu install.
+	 */
+	if (gpu_reset_for_dev_remove) {
+		list_for_each_entry(tmp_adev, device_list_handle, reset_list)
+			amdgpu_device_ip_resume_phase1(tmp_adev);
+
+		goto end;
+	}
+
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		if (need_full_reset) {
 			/* post card */
@@ -5124,6 +5143,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
 	int tmp_vram_lost_counter;
+	bool gpu_reset_for_dev_remove = false;
+
+	gpu_reset_for_dev_remove =
+			test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context->flags) &&
+				test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 
 	/*
 	 * Special case: RAS triggered and full reset isn't supported
@@ -5243,6 +5267,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+		if (gpu_reset_for_dev_remove) {
+			/* Workaroud for ASICs need to disable SMC first */
+			amdgpu_device_smu_fini_early(tmp_adev);
+		}
 		r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context);
 		/*TODO Should we stop ?*/
 		if (r) {
@@ -5276,6 +5304,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			adev->asic_reset_res = 0;
 			goto retry;
 		}
+
+		if (!r && gpu_reset_for_dev_remove)
+			goto recover_end;
 	}
 
 skip_hw_reset:
@@ -5349,6 +5380,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_device_unset_mp1_state(tmp_adev);
 	}
 
+recover_end:
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 					    reset_list);
 	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 728a0933ea6f..8933f8f63d13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2186,6 +2186,35 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 		pm_runtime_forbid(dev->dev);
 	}
 
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) {
+		bool need_to_reset_gpu = false;
+
+		if (adev->gmc.xgmi.num_physical_nodes > 1) {
+			struct amdgpu_hive_info *hive;
+
+			hive = amdgpu_get_xgmi_hive(adev);
+			if (hive->device_remove_count == 0)
+				need_to_reset_gpu = true;
+			hive->device_remove_count++;
+			amdgpu_put_xgmi_hive(hive);
+		} else
+			need_to_reset_gpu = true;
+
+		/* Workaround for ASICs need to reset SMU.
+		 * Called only when the first device is removed.
+		 */
+		if (need_to_reset_gpu) {
+			struct amdgpu_reset_context reset_context;
+
+			memset(&reset_context, 0, sizeof(reset_context));
+			reset_context.method = AMD_RESET_METHOD_NONE;
+			reset_context.reset_req_dev = adev;
+			set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+			set_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context.flags);
+			amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+		}
+	}
+
 	amdgpu_driver_unload_kms(dev);
 
 	drm_dev_unplug(dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index f71b83c42590..dc43fcb93eac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -31,6 +31,7 @@ enum AMDGPU_RESET_FLAGS {
 	AMDGPU_NEED_FULL_RESET = 0,
 	AMDGPU_SKIP_HW_RESET = 1,
 	AMDGPU_SKIP_MODE2_RESET = 2,
+	AMDGPU_RESET_FOR_DEVICE_REMOVE = 3,
 };
 
 struct amdgpu_reset_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 552e6fb55aa8..30dcc1681b4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -43,6 +43,7 @@ struct amdgpu_hive_info {
 	} pstate;
 
 	struct amdgpu_reset_domain *reset_domain;
+	uint32_t device_remove_count;
 };
 
 struct amdgpu_pcs_ras_field {
-- 
2.25.1

