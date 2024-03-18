Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DDCC54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 07:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA33F10F431;
	Mon, 18 Mar 2024 07:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jqfwQMqi";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE63C10F42F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 07:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRC6cupkLnuZR43lxH9KXucUWbqWxYzWZ+/hF5OgOUdG0LdcsTe2tnmSN02sH5ZiEru46j6VU1JiZfSq6Jzhbb2vfQn/wkzZTithFyFdD9/AZyT1J98mB0s04DBe65UQQiQNmxljHnEfB9LuwymVasUTuK6yy50+QTd1t9rrgANvMUuj4oEXnjA+0BD+tbJFO04uWTzUbLUCcSBjsRFgEHS26HqOsNSO9b8Lvb/zDXboF5iaBdRusshJHZvyHm0W0W0oqCpcap7WkqqLd9pZRTWpkRDR5BHOqZ4mSZvKZZzLdidnr9+3Y+3IPc6bDMCJxhfAOv5XWVYg6nqSzskLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKAuK+AkLe3UYaFGrFO12Akbya149Qni+TXMYP4RHuc=;
 b=mYYW/hcOFO5uDS6a0hH15E+h4NYGRgEG3Aav0t726ZKSt0Pe1YUH0rs5DNSrfUg84teeOL4mZF2O6LBOgs1gM7yi+/6eKMKkUAAKCOW14Snyjj0XdC+vP8wbSfITbsMPLzRAyPbsZE0/o0C9Mv7uHvNjq/OuLZycp6U6UwRpL3M8wAX/tVn36PpDh3WnPS9B0wh0bZlmS2JeZbWsKWbdUuOPlZ2sAiLsF8vEYEHsts9ZxKyeb+lgmAg27trPXUk8fR0WY9H3FCEHVO3CTd1J+/rN6DJdW0gWSXQV33ZosZDwNxgUleTF56kHtLuNT4CEhmHL5yNqTfP7YnSDTuRQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKAuK+AkLe3UYaFGrFO12Akbya149Qni+TXMYP4RHuc=;
 b=jqfwQMqiIQTh9Kqd73l2LBDYYdyYTxHMnrbZnDjWlvm9cD4GVKFceddLcoMV4gT7b8fo7A7rGiyWGB7g6ITkC+TIJBogJm1DUT7gxxTHfiCQf3/Ktixq4qPzwPe9lucxtQOkGYq+ytrZrluEDJ0hm5vz8CfHooZppuRklfyFF7c=
Received: from MN2PR14CA0013.namprd14.prod.outlook.com (2603:10b6:208:23e::18)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 07:26:36 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::1) by MN2PR14CA0013.outlook.office365.com
 (2603:10b6:208:23e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 07:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 07:26:36 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 02:26:34 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS poison
Date: Mon, 18 Mar 2024 15:26:23 +0800
Message-ID: <20240318072623.352614-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318072623.352614-1-tao.zhou1@amd.com>
References: <20240318072623.352614-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 962b68dd-cf94-4adb-24b5-08dc471cbeb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILINpBOtoG8Lr5bPFLb8hNVjxEB3Nv+5TXcsEt4YzWHf7/lC3FqZWZZXDqW58b/5mEEENjBKOE1r30MDiQczFBPOyJBCKngvaardSlTl35OF8YAbXS0EbxJ/JVArt3oxaj1zxcs+/mlOvMCmt9V+1D21bQFt3NlZPJwObI9XaXeYCMmPBGZp2GS0nuq6UL7glYdPqKo3OnHx7+74xnqAK9m2klJRl/2HvzmKvS6otq+rz+wNiMtIC2JFI3TWAubyCbu5DhYGe9wC9upDulcZk8sWrCSjrqUxgJtxNGewfalKJEQdqUJV0R5DKLGWge4Kl+GvBp28dlsg3PuhkiLkBT/yWDlA9bzNVYGusOADbCkV250RtpEayIA9538K2Ol+fDBr+4E02P0TB5OLUzhTxrG1y4bRHaj0iJCNQW0PfEwWk2Fz7KLMvpB4+8owj9mogDsYgojA4Yhv6zhyllHAv4LJImjW/FsS/0iekM0wyBemLGpnsEyIC1Ypb2k8Zy9+NjCQAOIqLYDXEOgHmZQXVd0zo70E7MBDP55XN/M5N6EWOm0wW0Z8lGHpiU3Ex4J9j2q7mAJgFMHaqT73AP4PNqYynVGEnhN+TixQdFAuR3R9PEhqBB3xsrjiAPcwIjRuOfJaNdLjpE9sbHDO1XRwC5oiiN4HOrEiQ94j4WYNUZEjGLcvmcvwlHrQelb8aOhq/fYrxIdpY2Sesl6lY14IKQhzEpZGJ289tE+nckZNC3ncBb4Odexme6CyrdxW28qd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 07:26:36.3523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 962b68dd-cf94-4adb-24b5-08dc471cbeb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
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

Each RAS block has different requirement for gpu reset in poison
consumption handling.
Add support for mmhub RAS poison consumption handling.

v2: remove the mmhub poison support for kfd int v10.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       | 14 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  4 ++--
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  | 13 +++++++-----
 .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  9 +++++----
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 20 ++++++++++++++-----
 8 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0b4910108f61..66753940bb4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -760,7 +760,7 @@ bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev)
 }
 
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
-	enum amdgpu_ras_block block, bool reset)
+	enum amdgpu_ras_block block, uint32_t reset)
 {
 	amdgpu_umc_poison_handler(adev, block, reset);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 03bf20e0e3da..ad50c7bbc326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -400,7 +400,7 @@ void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev);
 int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
 				struct tile_config *config);
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
-			enum amdgpu_ras_block block, bool reset);
+			enum amdgpu_ras_block block, uint32_t reset);
 bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
 bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem);
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e32a186c2de1..58fe7bebdf1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2045,7 +2045,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 		}
 	}
 
-	amdgpu_umc_poison_handler(adev, obj->head.block, false);
+	amdgpu_umc_poison_handler(adev, obj->head.block, 0);
 
 	if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consumption)
 		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
@@ -2698,7 +2698,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 		atomic_dec(&con->page_retirement_req_cnt);
 
 		amdgpu_umc_bad_page_polling_timeout(adev,
-				false, MAX_UMC_POISON_POLLING_TIME_ASYNC);
+				0, MAX_UMC_POISON_POLLING_TIME_ASYNC);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 20436f81856a..2c02585dcbff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -186,9 +186,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 	amdgpu_umc_handle_bad_pages(adev, ras_error_status);
 
 	if (err_data->ue_count && reset) {
-		/* use mode-2 reset for poison consumption */
-		if (!entry)
-			con->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
 	}
 
@@ -196,7 +194,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 }
 
 int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
-			bool reset, uint32_t timeout_ms)
+			uint32_t reset, uint32_t timeout_ms)
 {
 	struct ras_err_data err_data;
 	struct ras_common_if head = {
@@ -238,8 +236,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
 	if (reset) {
 		struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-		/* use mode-2 reset for poison consumption */
-		con->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
 	}
 
@@ -247,7 +244,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
 }
 
 int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-			enum amdgpu_ras_block block, bool reset)
+			enum amdgpu_ras_block block, uint32_t reset)
 {
 	int ret = AMDGPU_RAS_SUCCESS;
 
@@ -311,7 +308,8 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 		void *ras_error_status,
 		struct amdgpu_iv_entry *entry)
 {
-	return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry, true);
+	return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry,
+				AMDGPU_RAS_GPU_RESET_MODE1_RESET);
 }
 
 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 26d2ae498daf..4365a20eeb49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -103,7 +103,7 @@ struct amdgpu_umc {
 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-			enum amdgpu_ras_block block, bool reset);
+			enum amdgpu_ras_block block, uint32_t reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry);
@@ -123,5 +123,5 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 			umc_func func, void *data);
 
 int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
-			bool reset, uint32_t timeout_ms);
+			uint32_t reset, uint32_t timeout_ms);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index 650da18b0d87..740f89aafbc0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -134,6 +134,7 @@ static void event_interrupt_poison_consumption(struct kfd_node *dev,
 {
 	enum amdgpu_ras_block block = 0;
 	int old_poison, ret = -EINVAL;
+	uint32_t reset = 0;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
 
 	if (!p)
@@ -153,6 +154,8 @@ static void event_interrupt_poison_consumption(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_UTCL2:
 		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
 		block = AMDGPU_RAS_BLOCK__GFX;
+		if (ret)
+			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		break;
 	case SOC15_IH_CLIENTID_SDMA0:
 	case SOC15_IH_CLIENTID_SDMA1:
@@ -160,6 +163,7 @@ static void event_interrupt_poison_consumption(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SDMA3:
 	case SOC15_IH_CLIENTID_SDMA4:
 		block = AMDGPU_RAS_BLOCK__SDMA;
+		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		break;
 	default:
 		break;
@@ -170,17 +174,16 @@ static void event_interrupt_poison_consumption(struct kfd_node *dev,
 	/* resetting queue passes, do page retirement without gpu reset
 	 * resetting queue fails, fallback to gpu reset solution
 	 */
-	if (!ret) {
+	if (!ret)
 		dev_warn(dev->adev->dev,
 			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
 			client_id);
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, false);
-	} else {
+	else
 		dev_warn(dev->adev->dev,
 			"RAS poison consumption, fall back to gpu reset flow: client id %d\n",
 			client_id);
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, true);
-	}
+
+	amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, reset);
 }
 
 static bool event_interrupt_isr_v10(struct kfd_node *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index 7e2859736a55..d3d6b5c180b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -193,6 +193,7 @@ static void event_interrupt_poison_consumption_v11(struct kfd_node *dev,
 {
 	enum amdgpu_ras_block block = 0;
 	int ret = -EINVAL;
+	uint32_t reset = 0;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
 
 	if (!p)
@@ -212,10 +213,13 @@ static void event_interrupt_poison_consumption_v11(struct kfd_node *dev,
 		if (dev->dqm->ops.reset_queues)
 			ret = dev->dqm->ops.reset_queues(dev->dqm, pasid);
 		block = AMDGPU_RAS_BLOCK__GFX;
+		if (ret)
+			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		break;
 	case SOC21_INTSRC_SDMA_ECC:
 	default:
 		block = AMDGPU_RAS_BLOCK__GFX;
+		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		break;
 	}
 
@@ -223,10 +227,7 @@ static void event_interrupt_poison_consumption_v11(struct kfd_node *dev,
 
 	/* resetting queue passes, do page retirement without gpu reset
 	   resetting queue fails, fallback to gpu reset solution */
-	if (!ret)
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, false);
-	else
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, true);
+	amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, reset);
 }
 
 static bool event_interrupt_isr_v11(struct kfd_node *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 11641f4645e6..2a37ab7a7150 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -145,6 +145,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 {
 	enum amdgpu_ras_block block = 0;
 	int old_poison, ret = -EINVAL;
+	uint32_t reset = 0;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
 
 	if (!p)
@@ -164,6 +165,15 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_UTCL2:
 		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
 		block = AMDGPU_RAS_BLOCK__GFX;
+		if (ret)
+			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		break;
+	case SOC15_IH_CLIENTID_VMC:
+	case SOC15_IH_CLIENTID_VMC1:
+		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
+		block = AMDGPU_RAS_BLOCK__MMHUB;
+		if (ret)
+			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		break;
 	case SOC15_IH_CLIENTID_SDMA0:
 	case SOC15_IH_CLIENTID_SDMA1:
@@ -171,6 +181,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SDMA3:
 	case SOC15_IH_CLIENTID_SDMA4:
 		block = AMDGPU_RAS_BLOCK__SDMA;
+		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		break;
 	default:
 		break;
@@ -181,17 +192,16 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	/* resetting queue passes, do page retirement without gpu reset
 	 * resetting queue fails, fallback to gpu reset solution
 	 */
-	if (!ret) {
+	if (!ret)
 		dev_warn(dev->adev->dev,
 			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
 			client_id);
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, false);
-	} else {
+	else
 		dev_warn(dev->adev->dev,
 			"RAS poison consumption, fall back to gpu reset flow: client id %d\n",
 			client_id);
-		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, true);
-	}
+
+	amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, reset);
 }
 
 static bool context_id_expected(struct kfd_dev *dev)
-- 
2.34.1

