Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D62ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 07:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A3A410E59F;
	Tue,  6 Sep 2022 07:48:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BC410E59F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 07:48:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P184Adjg8c2K0iO3LBBrAfLwrgAnRpLEwIDhWSRthG+rHzKghf//LH+9fuG6BXcHQA59QjpQbfEZNYJCgnHIVsvoceGy+BtMAzj/AmqUudPD6+rI/jJvocAlRlKgdMDmmERE4Cqsg9zaG+aZ23htu03rFcxpXHr/ClQcmtZu3vlnU/D3Y6v3xdHeuZuwHO4sDX4WPVuNy6T9UA/4tkeI2/0hd9K19coQq5lvsuYzdKqRq/tkZK53qE0RJIjRFSwAu+zvbBRDGu30ugZKgVm/MeTLRVAYcoqvK1QAzxNi46QRYpdIuf5DjBoHmTWaB9o2MF/hssv2h9xXRGojZyvy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsP5YzmhO8CZv+beIHTJwNw5VIsMeDTpbux+exxRJIs=;
 b=BtfOZDgRW+giPdUrvdkgZaDnJnNSe+bpiojUEiJdCflGgtFeyGjJu21CqMIOYnQ4CtsXBcVq0KnK4jMKGlaC+llu4CHlD/gdZih+nmwgAmjFGL/KuyVz+mFrWeVo8MUiE1t1PuEnztAfH9hAFNnN896uqyeRQGLG2kWhM0r+KSvQ3EqNBqYvTlbg+CVRQF96k7qsfBzSZz6N9Xx3vBXq4HJM4RDY/kMjD0v2NXIis6/e7evQfb+pxmhLN6mkp54kEUSkTGzPg3anJBeAsv5uzJ9ZEMvi0pU26BL66yFoHSi8H9YT79v5I8iI45GGVtVXdwyC1/2ZfGe5VduY2IPY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsP5YzmhO8CZv+beIHTJwNw5VIsMeDTpbux+exxRJIs=;
 b=fRz9RrSTgz5jVM9gcXG4ZdY90BuYjtdHgzjugqQYbShn1VK7m9ic6p5Ki+xeefEgOdI0B2lmSPkiEtGNnHgXjYlAEMWfHa9++15XG9rewoJHBmuqTfzsV6pfbwBwwBgrcojF8LSZcl/mooSGqw8FK75sTVvzpFzHtlNvJeamyOI=
Received: from BN0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:e4::15)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 6 Sep
 2022 07:48:44 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::58) by BN0PR02CA0010.outlook.office365.com
 (2603:10b6:408:e4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 6 Sep 2022 07:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 07:48:44 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 6 Sep
 2022 02:48:41 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amdgpu: Adjust removal control flow for smu v13_0_2
Date: Tue, 6 Sep 2022 15:48:22 +0800
Message-ID: <20220906074822.3885626-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5bdc33d-247a-476d-5f46-08da8fdc392b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4997:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZB+8sAwuCNrZwo4NS7AZhy8fA2P1EeSn3GO9AsNhkvdy0fxN5IMUxfgSRqrru5HA/9AopXduIMxnin3GhUBDDeOYPJT9RMK90LbmV1Yl8MaFRzAgcYSSHKnNwkdkFDaoC/1orNR5+KLzbXJmnBe9OmTx3NZZ0mW6B/EoFMoOAI7ySO1cZpFBvDtkT4pFHF1HRnYFGR7ggCbTnuidvGUT6SJFUpskeCvb5t+kWE+r+aRGyOf/0RfL77EXskXwzq9nSj6x9MuKFmOkQmEqsiE8QbjbFBPHFQi0HeTijH5hhh12SAJ8MIstax3LdVl1k0L0M0F7Y26BFUVB/lTz8teqIofZBdSqbBzz7zmas7TIbagIhlldAuKuzldYhzavcVGTtUFCZ4Axo5xhFh761YSnOrzvP25NZDfX/ddy8c6zPWidXDVlWNfcKDi0fy+SoHp6EfOJqPc7MJrWfh/0NUaEQ4BnEoPbAVbJzx5MfCSzEba9fFDX+IL7afUjkDeN4Amg7ld+5LQ9WKbt0NkEUQoZ9BmLK+aGX1ArfKicaicM+Yf1KBNah1JYwVYsM08K3sjc8nPObL02PGAcuf3nlddNbTLJWrew//eJ2wwej1fpyxqFzs5IKSUQpnH6H8DecodRonFgLmD6EyUxK4b6gopUOa50a8i24aCJ1CiYWPBFt/Hx513I/VmTXFgy4xsYqVFF51R92lavVNJc9JXdC4b/AVk0Us39scHpufpApgM0puNMQkF8Bq11nROc1GCHCB1pSImCpvf08rt5l6dBIw2wclXyY7XtyDOLPUe11kyYSsymyN1125McfGsU/rzBFlR0Yoh2kBlB67G9yDtLmO3cGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(40470700004)(46966006)(41300700001)(356005)(186003)(478600001)(82740400003)(54906003)(26005)(7696005)(2616005)(1076003)(47076005)(426003)(16526019)(6666004)(336012)(4326008)(316002)(5660300002)(82310400005)(40460700003)(2906002)(70206006)(86362001)(83380400001)(70586007)(6916009)(81166007)(36860700001)(40480700001)(36756003)(8936002)(8676002)(36900700001)(473944003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 07:48:44.0286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bdc33d-247a-476d-5f46-08da8fdc392b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
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

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 35 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 16 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c         |  6 +++-
 7 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 79bb6fd83094..465295318830 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -997,6 +997,9 @@ struct amdgpu_device {
 	bool				in_s4;
 	bool				in_s0ix;
 
+	/* uninstall */
+	bool				in_remove;
+
 	enum pp_mp1_state               mp1_state;
 	struct amdgpu_doorbell_index doorbell_index;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62b26f0e37b0..1402717673f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2999,6 +2999,13 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			DRM_ERROR("suspend of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
 		}
+
+		/* If in_remove is true, psp_hw_fini should be executed after
+		 *  psp_suspend to free psp shared buffers.
+		 */
+		if (adev->in_remove && (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP))
+			continue;
+
 		adev->ip_blocks[i].status.hw = false;
 		/* handle putting the SMC in the appropriate state */
 		if(!amdgpu_sriov_vf(adev)){
@@ -4739,6 +4746,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	struct amdgpu_device *tmp_adev = NULL;
 	bool need_full_reset, skip_hw_reset, vram_lost = false;
 	int r = 0;
+	bool gpu_reset_for_dev_remove = 0;
 
 	/* Try reset handler method first */
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
@@ -4758,6 +4766,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 	skip_hw_reset = test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->flags);
 
+	gpu_reset_for_dev_remove =
+		test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context->flags) &&
+			test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
+
 	/*
 	 * ASIC reset has to be done on all XGMI hive nodes ASAP
 	 * to allow proper links negotiation in FW (within 1 sec)
@@ -4802,6 +4814,16 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		amdgpu_ras_intr_cleared();
 	}
 
+	/* Fixed the problem that BIOS signature errors and psp bootloader
+	 * failure to load kdb on next amdgpu install.
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
@@ -5124,6 +5146,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
@@ -5159,8 +5186,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 */
 	INIT_LIST_HEAD(&device_list);
 	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
-		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			list_add_tail(&tmp_adev->reset_list, &device_list);
+			if (adev->in_remove)
+				tmp_adev->in_remove = true;
+		}
 		if (!list_is_first(&adev->reset_list, &device_list))
 			list_rotate_to_front(&adev->reset_list, &device_list);
 		device_list_handle = &device_list;
@@ -5243,6 +5273,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+		if (gpu_reset_for_dev_remove) {
+			/* Workaroud for ASICs need to disable SMC first */
+			amdgpu_device_smu_fini_early(tmp_adev);
+		}
 		r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context);
 		/*TODO Should we stop ?*/
 		if (r) {
@@ -5276,6 +5310,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			adev->asic_reset_res = 0;
 			goto retry;
 		}
+
+		if (!r && gpu_reset_for_dev_remove)
+			goto recover_end;
 	}
 
 skip_hw_reset:
@@ -5349,6 +5386,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_device_unset_mp1_state(tmp_adev);
 	}
 
+recover_end:
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 					    reset_list);
 	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 728a0933ea6f..9271f219d8fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2175,6 +2175,19 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	return ret;
 }
 
+static void amdgpu_device_gpu_reset(struct amdgpu_device *adev)
+{
+	struct amdgpu_reset_context reset_context;
+
+	memset(&reset_context, 0, sizeof(reset_context));
+	reset_context.method = AMD_RESET_METHOD_NONE;
+	reset_context.reset_req_dev = adev;
+	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	set_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context.flags);
+
+	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+}
+
 static void
 amdgpu_pci_remove(struct pci_dev *pdev)
 {
@@ -2186,6 +2199,28 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 		pm_runtime_forbid(dev->dev);
 	}
 
+	if (adev->asic_type == CHIP_ALDEBARAN) {
+		bool need_to_reset_gpu = false;
+
+		adev->in_remove = true;
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
+		if (need_to_reset_gpu)
+			amdgpu_device_gpu_reset(adev);
+	}
+
 	amdgpu_driver_unload_kms(dev);
 
 	drm_dev_unplug(dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 28ca0a94b8a5..1f19f9fa4396 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2647,7 +2647,15 @@ static int psp_hw_fini(void *handle)
 	psp_asd_terminate(psp);
 	psp_tmr_terminate(psp);
 
-	psp_ring_destroy(psp, PSP_RING_TYPE__KM);
+	/* If in_remove is true, psp_suspend is called before
+	 *  psp_hw_fini. psp ring has been stopped in psp_suspend.
+	 */
+	if (adev->in_remove && psp->km_ring.ring_mem)
+		amdgpu_bo_free_kernel(&adev->firmware.rbuf,
+				&psp->km_ring.ring_mem_mc_addr,
+				(void **)&psp->km_ring.ring_mem);
+	else
+		psp_ring_destroy(psp, PSP_RING_TYPE__KM);
 
 	psp_free_shared_bufs(psp);
 
@@ -2715,6 +2723,12 @@ static int psp_suspend(void *handle)
 	}
 
 out:
+	/* If in_remove is true, psp_hw_fini will be called after
+	 * psp_suspend. Psp shared buffer will be freed in psp_hw_fini.
+	 */
+	if (adev->in_remove)
+		return ret;
+
 	psp_free_shared_bufs(psp);
 
 	return ret;
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
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5e318b3f6c0f..6be90076c9f3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3405,7 +3405,11 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 {
-	if (adev->pm.dpm_enabled == 0)
+	/* If in_remove is true, the check for pm.dpm_enabled
+	 * needs to be skipped, since smu_suspend is called before
+	 * amdgpu_pm_sysfs_fini in the device removal path.
+	 */
+	if ((adev->pm.dpm_enabled == 0) && !adev->in_remove)
 		return;
 
 	if (adev->pm.int_hwmon_dev)
-- 
2.25.1

