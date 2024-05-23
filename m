Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236DAC25B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 10:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7657D10E4E5;
	Thu, 23 May 2024 10:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QQ6/bzrN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFB510E4E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 10:02:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB1qUVChC9KzJYuluWJKzTmjysYQ/NrohBpwXerODyTSO15hcv1BopjPCQakUoC/mk+ZXq5fPHPJPeaTmYOf3S1S4sZ8/rHhmujN8obeZdFL9PaRQ5B40QZofAUPvVv2FW5KbG8NOP3p2/44YfT467R5gfxFsZLmIGXCKW18Ds0CQuY3NkI3WwC+ihRK5T4b+CPX4dZaaT5msi8L5otzUnyntJayZcIFZ8x2HOJ2ons+A7MoHUeChObRrWm3rEzekHPP/6FtjNUHh7Mu3EamW8Ao5vjqcCjRHf2FCLdVFvISlnAd9hNKdFy74u+JUOsnDwpHgxWofJpvzVBOyrlXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr+f3T5aYXsFJ8SPOdRfb8LQy7HiqKbcfRM+gSqtBI0=;
 b=KlW80UEyJ0yPS5NAIaFkoSPHV/6nKZdQz+3Ow+RPp0SnfmpHa2D0o25kA6f3L3z5Pm7WZnsQViV9JquuH0IApm/yWbheRxkcF4t2imlp8tBw6cO23EdzmERvbCugTQ2OQYXsWWuVuLV/X7xRrC5SqWmPjN2ztYkX8xhn160c1PAz6fuAyPvPJ02uEz1ArMaGba4WFd1Qs51yx1CNJnWVL+NFPk6HLnaxP+MrFQvt1b6H4LFtKcFPDRVLwkRKcTE7MAG2gMzLizdcpkh8xpNY0cH3GEcAUoXsoNjKvnXmHgFv/gnFXduzww9vE5X/lkD4eIxQmW1zz4BwaEqh36O2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr+f3T5aYXsFJ8SPOdRfb8LQy7HiqKbcfRM+gSqtBI0=;
 b=QQ6/bzrNdeE9g5vWkjgzChi4TVA/0pZ/MCBYzTJBZWS9LSAy/oQsUIdS6ED/awj3jJSn9tcXQm5OvSvDBnN28VqKOZ0pQfIybBlyImqL9Gj9ZuULRCbdaX0CKGj2fFHHOLlZkV0l1yVMCbaD1XoEKuY7wEXFsta1bR/zEq228a0=
Received: from BN9PR03CA0476.namprd03.prod.outlook.com (2603:10b6:408:139::31)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18; Thu, 23 May
 2024 10:02:05 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::93) by BN9PR03CA0476.outlook.office365.com
 (2603:10b6:408:139::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 10:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 10:02:05 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 05:02:02 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: trigger mode1 reset for RAS RMA status
Date: Thu, 23 May 2024 18:01:48 +0800
Message-ID: <20240523100148.2457-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523100148.2457-1-tao.zhou1@amd.com>
References: <20240523100148.2457-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be38d8c-916b-412d-b11d-08dc7b0f66a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E5Hk96bM3J1ap3OiWZeBUGk3cqJZT9slZn7PCxBzifKdKwb3NwZu6e7zFIvR?=
 =?us-ascii?Q?RCbXBOjVSNYcx6nPercAgG+PslJ9ONhZHpzM/z9zbMj5V2dm9nOQuvhZiTPx?=
 =?us-ascii?Q?liaTHY/wcx3iJXM0hH70rSXBn4Mc4t8bQd12IMRKT0sr/Nd6xUnC5bfQGjeI?=
 =?us-ascii?Q?5NJPrSX4hx32SoFVvcrG+AdX6ORBCcqA4rjKJMjoUlqMvmn3tgSOyaEgD7VA?=
 =?us-ascii?Q?qQqdR7hTuDj/Z4An8tsZpZhIv8rKDOfSGT8+JSK74MsxrZiDEDVm5o+JaIbF?=
 =?us-ascii?Q?3mLzvSVkJaHO/hnG9a6vfJU+tmy5XYUV53BcPKzNQvwYHAxKhbs9ic5tIYs9?=
 =?us-ascii?Q?jcFLKzZ7kdmtOCIttd+FHGqmsd2N2grhG+NsDaIFdxf+uWxPpM6Tk19cdbHw?=
 =?us-ascii?Q?8tjYGsknISlyr9G9STKCq0U3yreU3QDFvBZ7fzP+DGMsoVaHsoBTC+Kerb3p?=
 =?us-ascii?Q?rqfoa3xmbxtHCmo+5H61JwlZCYTapbEZFM3x3kAfBfIcTJ2fEzHVUWydEFRO?=
 =?us-ascii?Q?/Ev6p2coJ2Y42nzlD53Nug1ltD1DmKsP53/cyGDkIDFhs+DGR3RrPsLj1s8u?=
 =?us-ascii?Q?EszRj6ut29ru9HSLe4W8HC6oRTU+cFy1hVIuGf7enP+OHWX9Sr2omMJrTI+3?=
 =?us-ascii?Q?KQCMUjy245l2pRp+JY1ZaK73LfCYArVocjGMpx0Rt/Ky0NkX1O9Wu+0q2vmS?=
 =?us-ascii?Q?Nd42kDdNN1lo77R6v3R8QInGPPZEZ+kDbBuwzNb0sphq9cGC2CDvS+7cb4X+?=
 =?us-ascii?Q?fZowEDk4vxAk37j5qOfppDoIaZNWNsp5x5lAWXr5Jqpu2Vc7L/HvHoJB/iaS?=
 =?us-ascii?Q?mdScSbd/Gf8XWuQdSWMuWoyeCNTBtQIxgCOOGaaoqdvsyMbI8GtVQ2FkWxMe?=
 =?us-ascii?Q?hoxjpKK0yLUWrHehjm5fkSdJQ9Fszl/It2CMZUBIsl8p8rXxsJ24B9Y8iZQW?=
 =?us-ascii?Q?JtDYeY+kCH8msmN8/YXFbFQmxVNfD+OKJHygIldXmZMQT/rbYCg74+jqrgkb?=
 =?us-ascii?Q?tIGSm3x1yBfvRQQchyH3aKlAx2p/ti1WVKELQuT/6uRZ5yoadOnokND3y2eV?=
 =?us-ascii?Q?ymJgXvRFRxDzNyQPlLQDBPN6zlp67Mscy/JJhwjxnMde//Grb/2D9hvUvssT?=
 =?us-ascii?Q?WvJNjqAef8FgNuJuYMPdk9i58IDdqBFN/vk7WDbBVLN3wxqW9uaZMxUI38pp?=
 =?us-ascii?Q?bEUmxTNTq3eNSJed66iyxwdQeQqoY5aERwipnQc9pgUhZ4V1puNrsBRM6tYo?=
 =?us-ascii?Q?C64YADm2irKZSP9DnKTGBDALOpm+WxLhmFad7jTAzJneg+f4ph+0TFSmaeo6?=
 =?us-ascii?Q?LQ6G9EhQANIA7i4+kJO+lEpXZMwB+6FSZTxY9K0tAhkZZ+Os2kHcSY4v1f0o?=
 =?us-ascii?Q?WYyAyXL/CfHI6KECV39GM3UltJ+j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 10:02:05.6225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be38d8c-916b-412d-b11d-08dc7b0f66a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  7 +++----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 934dfb2bf9e5..a6da44ac3fbd 100644
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
@@ -2074,7 +2075,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
 
 	/* gpu reset is fallback for failed and default cases */
-	if (poison_stat) {
+	if (poison_stat || con->is_rma) {
 		dev_info(adev->dev, "GPU reset for %s RAS poison consumption is issued!\n",
 				block_obj->ras_comm.name);
 		amdgpu_ras_reset_gpu(adev);
@@ -2817,6 +2818,9 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 		schedule_delayed_work(&con->page_retirement_dwork,
 			msecs_to_jiffies(AMDGPU_RAS_RETIRE_PAGE_INTERVAL));
 	mutex_unlock(&con->umc_ecc_log.lock);
+
+	if (err_data->err_addr_cnt && con->is_rma)
+		amdgpu_ras_reset_gpu(adev);
 }
 
 static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
@@ -2867,7 +2871,7 @@ static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
 	if (poison_msg->pasid_fn)
 		poison_msg->pasid_fn(adev, pasid, poison_msg->data);
 
-	if (reset) {
+	if (reset && !con->is_rma) {
 		flush_delayed_work(&con->page_retirement_dwork);
 
 		con->gpu_reset_flags |= reset;
@@ -3983,6 +3987,12 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
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
index 1dbe69eabb9a..5f3866548cb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -195,7 +195,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
 	amdgpu_umc_handle_bad_pages(adev, ras_error_status);
 
-	if (err_data->ue_count && reset) {
+	if ((err_data->ue_count && (reset || con->is_rma)) {
 		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
 	}
@@ -211,6 +211,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
 		.block = AMDGPU_RAS_BLOCK__UMC,
 	};
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	uint32_t timeout = timeout_ms;
 
 	memset(&err_data, 0, sizeof(err_data));
@@ -243,9 +244,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
 
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
 
-	if (reset) {
-		struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-
+	if (reset || (err_data.err_addr_cnt && con->is_rma) {
 		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
 	}
-- 
2.34.1

