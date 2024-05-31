Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FA8C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 10:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B6B10E03D;
	Fri, 31 May 2024 10:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PQoaY1T8";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2775310E31F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 10:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMT2clK8I648s8jQx9MIpLVnAVAxkRWea4rzV5YEr9sOSsXFyLatbD3b5P0wgdyvQ97KAzgcJabq2cvkVweVxBe2tYO4h+Uyroa+6Zt/CpQJ1Ry0SeNhq7tvrOpDBn88ZeQQU2aYejFIL04E/4PdE1zlFnq3BuHmb4hc/nCj1spUZDGxh2tfMgVTnWRsmOP4sJLhARZf6/MttoSR+4fd27yLFMzsbn2JW0ywy19eNQpGAGIbNzB7UcFDJHroJf0YYf4m4L00rwxs0UTE5uFgiBBQakefrNorsELXJY65KGxzQfFf2kCWzuuVNMq7EVUxVYbhUctCIio1FS56haisbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwULceuS0Ne8+AKa8bjgrk2J4gWXuPvtBgrVjtF6lMs=;
 b=iHoWwRpCEOWiVDBTlq8dHv+U55ljOrl1T+GjZlp+9C5a6cuneqU11vBMYIdlaI1Gsb2UcPPaSoTrTKp9paIEcY9v8b3R0Dh4PHFEYRnt9ERaBivpsQkpCtUT8K4mrsBl/UFdgYyDnHKuVKiu0tXt9bi76WNlcjoTbPvnu5fTLMwu5ypkOzyD9tYL1uo7r00qtJdBqkDkzvViFeHwHV5Oq9cB8eOxMJDnV1M12u7U3pk0jiRk3Po/4LhezVuN8faZjiiIDgLMmfa2GY6PdNefNRkRhLFP3UFRz0yqbFerEOa0nBwCYCaGFjxph7hUGtWk1LCvGxtvT2fU5IIBPLxCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwULceuS0Ne8+AKa8bjgrk2J4gWXuPvtBgrVjtF6lMs=;
 b=PQoaY1T8sxVhULK26XpgCsDbe4LI7U5CpxoinHlniqCof6/mzVgK2U+3oOJjavkLolM7cQA+6UKuz5DI6mCcBp4A8c8dhObSpiM6BGNAgqhwXrgdQ1iHM38QhZkeUjTG8saEJt9m51VrT51sPNQYrf2BehqhTj4A/AUTV7utVpU=
Received: from CH0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:610:b0::21)
 by CH2PR12MB4278.namprd12.prod.outlook.com (2603:10b6:610:ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 10:49:23 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::81) by CH0PR03CA0016.outlook.office365.com
 (2603:10b6:610:b0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Fri, 31 May 2024 10:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 10:49:23 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 05:49:20 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: trigger mode1 reset for RAS RMA status
Date: Fri, 31 May 2024 18:49:08 +0800
Message-ID: <20240531104911.14748-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531104911.14748-1-tao.zhou1@amd.com>
References: <20240531104911.14748-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CH2PR12MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2162d0-386c-4347-74eb-08dc815f5539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BYwsx7PWWYiC1scgmpxicS1+jdElngugd9mvIrcMBPsXefKdiiyURwzjPo1V?=
 =?us-ascii?Q?L6cnUtIH9f8h7pwIS8zvx9JI4/ig2aSm79X1Dn7KkdhDfr4A59kw1oMKiP/f?=
 =?us-ascii?Q?1QZYULYCfxExpqx+7+BNGuJIt68PQdFbEQX4We9NCIjcvcBx/l0pADKCS94+?=
 =?us-ascii?Q?DTe793Qg0sOQnkpzhHUo7XQGzusserCnM+XbWxJSV6cT3nWEN+hf67tF+EcU?=
 =?us-ascii?Q?oP8l4RkVx79ohXlNKPfQHRAqu6bebOjWCTinnpCYFzSZe+jjmLktI7uu5iEc?=
 =?us-ascii?Q?UAnnS8vNIFgnVc2hdZvQFVZ3PhnlFUL7GdrZQc0+TLMMAQQtSbq+WHBMtRb7?=
 =?us-ascii?Q?MhOWZlL9NLHqNl15eTPfelUjXOMWfwjSC41FoE+y3lMUtBXxb+N3ggfDJ9Cw?=
 =?us-ascii?Q?V8j4InX3wyaJWQpQxdANyloxQ7C2b8a5kpABfFiqTDlr0oGPua2OBc3c665k?=
 =?us-ascii?Q?wyAWr3INTu9etXeviouHsMTZi+ePlDB/wXSH6Q1HTlTPFj8vwJOqAE5h/xAw?=
 =?us-ascii?Q?jKMRfobn/23SatEaINwth4rfvhzE/ixuyBqlk4sZilUwYhQiNsX8vBDkGVwQ?=
 =?us-ascii?Q?mjJYpOcyWz9UCxEl9LwPmwTUc5cdhGirqfYLY3QXy5670YC6DmWGJApaChKc?=
 =?us-ascii?Q?Bgfnc3DH/WBj1P1dy8EymH4CCDVCfo0TMaNXkgu+UW5YSlDXDsoP0h19C6BG?=
 =?us-ascii?Q?m6EFJONt0VLl30tkMI8qhAfVOHs7pzU5/Gh1QK5sFyYrNWdL+nx4uQGak9lR?=
 =?us-ascii?Q?iSLFAucLlsQIQ5QPiGOto1cIiIMcqMnF9tv0vOVNxfbWmgnS7hzOYrhy0J6s?=
 =?us-ascii?Q?adnjW56Uu/xZDClPKENUuOTEwwgd3lRoxb6h15gtytixEqvNrZICnbIQxiE8?=
 =?us-ascii?Q?uB0MyWDFVczPhMB26m+knr7cUmuHVb0o5GaWAZEUy28k7Vsb+20Gv/+5mL8V?=
 =?us-ascii?Q?c6Eb4+PUHci+4sAsoOgkLhqcxS9VvhYc+vI+wor6QXfYmSzVLlBK/h5qUJ7H?=
 =?us-ascii?Q?MoXcJemo3nuNcDoDB2zhT38h0sbZ6bcY+MmZxgbHAVTz4PwU3f+vBCxdo3mI?=
 =?us-ascii?Q?HWwgirMNZF/WGs3Yqc1aXjQpvqF613NzknGhpcSnKfCzighYM0T3/dpoi5rg?=
 =?us-ascii?Q?TwXZaGC8oWfUZCf5HdcRlAqUkUHSNy33afu18K93Hy1COK4XLNAo3vdP9DIc?=
 =?us-ascii?Q?IA5Rh6lsFy5zmPeelK1G5+R6s2cnNsadJaYVU302vBxlArW7lbdiTUxLbifs?=
 =?us-ascii?Q?dXWAGalEiLN4V5uI4s0cEjGtf5AKdAgMyXbBBZeinnywBmmrE7q3VB9LRPGR?=
 =?us-ascii?Q?9x4k572+e/YbRzfilzwmOjDcZ0IhJLzRkdtLNnNxtcPnUagjNgcmPO7uVCZK?=
 =?us-ascii?Q?d2hhdBImAaI/CtvK0TTq7qIjcdEV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 10:49:23.0691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2162d0-386c-4347-74eb-08dc815f5539
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4278
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

Check RMA status in bad page retirement flow.

v2: fix coding bugs in v1.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 28 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c  |  8 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c |  4 +++-
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 616dc2387f34..10cbcc0d1a1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2049,8 +2049,9 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	struct amdgpu_device *adev = obj->adev;
 	struct amdgpu_ras_block_object *block_obj =
 		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	if (!block_obj)
+	if (!block_obj || !con)
 		return;
 
 	/* both query_poison_status and handle_poison_consumption are optional,
@@ -2073,14 +2074,17 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consumption)
 		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
 
-	/* gpu reset is fallback for failed and default cases */
-	if (poison_stat) {
+	/* gpu reset is fallback for failed and default cases.
+	 * For RMA case, amdgpu_umc_poison_handler will handle gpu reset.
+	 */
+	if (poison_stat && !con->is_rma) {
 		dev_info(adev->dev, "GPU reset for %s RAS poison consumption is issued!\n",
 				block_obj->ras_comm.name);
 		amdgpu_ras_reset_gpu(adev);
-	} else {
-		amdgpu_gfx_poison_consumption_handler(adev, entry);
 	}
+
+	if (!poison_stat)
+		amdgpu_gfx_poison_consumption_handler(adev, entry);
 }
 
 static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj,
@@ -2801,6 +2805,7 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 					      page_retirement_dwork.work);
 	struct amdgpu_device *adev = con->adev;
 	struct ras_err_data err_data;
+	unsigned long err_cnt;
 
 	if (amdgpu_in_reset(adev) || atomic_read(&con->in_recovery))
 		return;
@@ -2808,9 +2813,13 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 	amdgpu_ras_error_data_init(&err_data);
 
 	amdgpu_umc_handle_bad_pages(adev, &err_data);
+	err_cnt = err_data.err_addr_cnt;
 
 	amdgpu_ras_error_data_fini(&err_data);
 
+	if (err_cnt && con->is_rma)
+		amdgpu_ras_reset_gpu(adev);
+
 	mutex_lock(&con->umc_ecc_log.lock);
 	if (radix_tree_tagged(&con->umc_ecc_log.de_page_tree,
 				UMC_ECC_NEW_DETECTED_TAG))
@@ -2867,7 +2876,8 @@ static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
 	if (poison_msg->pasid_fn)
 		poison_msg->pasid_fn(adev, pasid, poison_msg->data);
 
-	if (reset) {
+	/* for RMA, amdgpu_ras_poison_creation_handler will trigger gpu reset */
+	if (reset && !con->is_rma) {
 		flush_delayed_work(&con->page_retirement_dwork);
 
 		con->gpu_reset_flags |= reset;
@@ -3983,6 +3993,12 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
+	/* mode1 is the only selection for RMA status */
+	if (ras->is_rma) {
+		ras->gpu_reset_flags = 0;
+		ras->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+	}
+
 	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
 		amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras->recovery_work);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 1dbe69eabb9a..4a72ff8d8d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -195,7 +195,8 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
 	amdgpu_umc_handle_bad_pages(adev, ras_error_status);
 
-	if (err_data->ue_count && reset) {
+	if ((err_data->ue_count || err_data->de_count) &&
+	    (reset || (con && con->is_rma))) {
 		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
 	}
@@ -211,6 +212,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
 		.block = AMDGPU_RAS_BLOCK__UMC,
 	};
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	uint32_t timeout = timeout_ms;
 
 	memset(&err_data, 0, sizeof(err_data));
@@ -243,9 +245,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
 
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
 
-	if (reset) {
-		struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-
+	if (reset || (err_data.err_addr_cnt && con && con->is_rma)) {
 		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
index 9e7ce1e6bc06..9cd221ed240c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -85,6 +85,7 @@ static int gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device *adev,
 	if (entry && (entry->client_id == SOC21_IH_CLIENTID_GFX) &&
 	    (entry->src_id == GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT) &&
 	     !entry->vmid && !entry->pasid) {
+		struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 		uint32_t rlc_status0 = 0;
 
 		rlc_status0 = RREG32_SOC15(GC, 0, regRLC_RLCS_FED_STATUS_0);
@@ -96,7 +97,8 @@ static int gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device *adev,
 			ras->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		}
 
-		amdgpu_ras_reset_gpu(adev);
+		if (con && !con->is_rma)
+			amdgpu_ras_reset_gpu(adev);
 	}
 
 	return 0;
-- 
2.34.1

