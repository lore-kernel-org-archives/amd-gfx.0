Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0341DC36013
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15BFA10E775;
	Wed, 26 Mar 2025 19:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tf3des2K";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3FB110E1B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJDU+vqbV6tvyTHnMFxNfMtRxFrM97IzS8M6lL/AcOV4X30bo84zKdprwwBda6sAOXpsO251a9TcLTLIPgyQZ304l777uLVBEAjDBHxm6LxtuZqepJqW3ZpmncPq4f6Uyfz6E/14AlZgxTsdXGLD4XhJ3AaST2vA9J300VWwv5QMFxuD0cJpyp5LCC74P6UJBh09MKiZgPgmnUPWIqrMOO047POTHidoahTjUeeIN4YrsaBGlKg/bY7V+ilujuNWud0t3DcVu7hCNPTm5vfy/vjSd3Ibkfu1wbsQHNO9n3oXBqowssrSLoys+d7G0yJNCtAKCIKVEtPyKIIwqX0r7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEA369ExY6jO/UyS6v2C7tG9mbJootGsWhI9iAj4Caw=;
 b=LM6G5vbbPk6bcHWUe5vyxzhPgDJyVbMgrMrcOdsxt6sRWuaF9EL3Oa/4Rb0pis+et8iuhX0480BY3yuaNaC3hXo8XKzBpzRgsOSr048GsXcf9Bl0mWAMG/doDlZ4zQC5NrLzaZICHMFERARI3kv7R2UY8nKBQ/5wDeN9HoeBoMncOAhoutYI2dgAttECGkZmt5+rlgp4nfwjovITthtKEf3Brl9OpkKDnHJoFl1C8LeR17coYQXHnYC/Sa3JMwglknFKMD0osCMpbmIx9aI1ChW3nAoe5roP/icKAnm+qCzIAlRxbQrHNZdlGlorFaBKNfFoYrnEVHq1qcog8XwYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEA369ExY6jO/UyS6v2C7tG9mbJootGsWhI9iAj4Caw=;
 b=tf3des2K9rPvrcNLy+ISy/R+GzSyuYoYO6aEYLsOLoXXcV/4SmMlCZrHe2EA/JLu7oFrGMMQTX7MRBfd41S4KapkkJlFWRdX2dBiNiNtWBcfaQcteTxenc/r2UuQuEsdGT3i31TTd8V2HqEOusgoY8QRB2PLH1e8DZzRKIQGPWM=
Received: from SJ0PR13CA0161.namprd13.prod.outlook.com (2603:10b6:a03:2c7::16)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 19:53:12 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::76) by SJ0PR13CA0161.outlook.office365.com
 (2603:10b6:a03:2c7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 19:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:09 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:08 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 04/17] drm/amd/display: convert more DRM_ERROR to drm_err
Date: Wed, 26 Mar 2025 15:49:01 -0400
Message-ID: <20250326195202.17343-5-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f136d3b-bd2e-4353-4b9b-08dd6c9fd6d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?irum9cXSacxl3iFUBduKpkZiIWh5qzzhlHJzkIAJUP8vfjVT1Jv8keSr9INk?=
 =?us-ascii?Q?ZF9dLf5VqTwhC/v68HFcAtGBWfab/ZR021ruzTY4HeDrxEwXmbBnZ/hhuZyv?=
 =?us-ascii?Q?EKuaVCoK/hP73Lv3rX3c91rk0SrdoNWJzgt5EDs3m8bCmvn3ngciz7Uyiipf?=
 =?us-ascii?Q?ol+AW+awOo2yc9Gwn0IuVfSo4JUyQxS2S5aHEgoLTImW0S6euJBEPzoy2Faw?=
 =?us-ascii?Q?l/EOlWqhPXiGcU9J2Fux8S88iSNtnlnmS7MjdEo90A0uhMqUBSudLoWyhvgX?=
 =?us-ascii?Q?fk+eW7vyOFWln/VUQsWaw3PjMSLF/F15CYyVZITq0QIb1elQkjWOxRFEFUaL?=
 =?us-ascii?Q?fnesHrhV4gyVuFGwr/6NeR2UaVKpGC+83wnQVJrcVblv+QJCIrwb4uEiYFJ0?=
 =?us-ascii?Q?wDQJ2sUzYu9jba0GcsJCPcKAfGm1snYNka5P/DOckETxGKnlV/2Ysqkimu05?=
 =?us-ascii?Q?eFOOa6OPWmfavekAIp+coc2RE7jIl4bRrWHR3y18nt1Uis9KDBvB0D9BHT9V?=
 =?us-ascii?Q?UTv/zc8kAiFd1IcSN8XjNEwmI4KR+1UPaZv7T1AanGcy0IYgSKTrWmDofmVD?=
 =?us-ascii?Q?5iD2mAMzdQLANVfYqasr86V76Oqh2v/+fn7aLH68vcyBt51LXtWDMaF2lZhg?=
 =?us-ascii?Q?xrYzHOuCi/wxXRRf7A69UDq1wXGGkk2QxwKtMaRBnnVTxe+2kJuIC4B81H2c?=
 =?us-ascii?Q?peTanWHQbxGj8D7teYaJb749vtsLpEqMsVt8WCYgl9EKGHD3ujVaOnfJS3ep?=
 =?us-ascii?Q?sAQO7lZ7URTwz4ovbdP/rVlihBxJBT00D2AC+iMFseoFcOtRuTo4G7dWtDVE?=
 =?us-ascii?Q?UoBx+cAsfwrBrQ2xXuMD07YLiRD4iC9hv2eCTuhWFy9AugPoHqZLk9fto6oD?=
 =?us-ascii?Q?5Q7QwxQmsjRwW5chEIuDlFwtUH2rXao7vaWL0B0jAsFN7CHRBfdR8gyca5PQ?=
 =?us-ascii?Q?F/H5pRHJS8xHLlYnrPNppP1qpJ7tPVJWyRJ24vC6Pme6TexiFsLbQIT3RWm/?=
 =?us-ascii?Q?M56rtDxTRqDvKRq2h1pbucxLU1BndUT+cd068e/0vfaxGJ4tJs0jKZjWO9BX?=
 =?us-ascii?Q?OLRTEL1hYeNQzuwI87psCbX4TTBmcjkdDR5nMQTYaiZuWyObY6CL1P68iaPc?=
 =?us-ascii?Q?XNTG+l27YVhpvn5v1sDjwsP4kH4GG2oJY6GEyhj7WFDCWa8d5aVUf1CBpNqz?=
 =?us-ascii?Q?oBK83S/TA8pCYBvqD7SPUiIWBpN5BK8Nd2Si0EISezVi/hj8YOwLeuls0pwJ?=
 =?us-ascii?Q?tkpIRv8Pfcui8EsfbIIxx1JW+2ASMiWG+G0Uvok0boQJyWf7cP8gZo5GYAfQ?=
 =?us-ascii?Q?UxCzaIvkEHo5MyGKm0W3RxhCK84+jfpVvvFHZbOgSLbiekskXxRolYTO1n/p?=
 =?us-ascii?Q?uhTCeGXpbsaZO1FWCIp/nm3jxg0Opp3RrZpZlG1xWNlP7vutM/I/4/0g8dX/?=
 =?us-ascii?Q?X1IXePVPktmFl/J13Y/xO0QEMILZP4bk25l4IYmzWpkgIJvNrsaMBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:11.5690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f136d3b-bd2e-4353-4b9b-08dd6c9fd6d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

prefer drm_err instead of DRM_ERROR since the former prints the
associated DRM device, which is helpful when debugging multi-gpu
use cases.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 207 +++++++++---------
 1 file changed, 104 insertions(+), 103 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 639b1c01cbf9..0f65766261cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -279,7 +279,7 @@ static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 	acrtc = adev->mode_info.crtcs[crtc];
 
 	if (!acrtc->dm_irq_params.stream) {
-		DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
+		drm_err(adev_to_drm(adev), "dc_stream_state is NULL for crtc '%d'!\n",
 			  crtc);
 		return 0;
 	}
@@ -300,7 +300,7 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 	acrtc = adev->mode_info.crtcs[crtc];
 
 	if (!acrtc->dm_irq_params.stream) {
-		DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
+		drm_err(adev_to_drm(adev), "dc_stream_state is NULL for crtc '%d'!\n",
 			  crtc);
 		return 0;
 	}
@@ -771,12 +771,12 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 		return;
 
 	if (notify == NULL) {
-		DRM_ERROR("DMUB HPD callback notification was NULL");
+		drm_err(adev_to_drm(adev), "DMUB HPD callback notification was NULL");
 		return;
 	}
 
 	if (notify->link_index > adev->dm.dc->link_count) {
-		DRM_ERROR("DMUB HPD index (%u)is abnormal", notify->link_index);
+		drm_err(adev_to_drm(adev), "DMUB HPD index (%u)is abnormal", notify->link_index);
 		return;
 	}
 
@@ -870,7 +870,7 @@ static void dm_handle_hpd_work(struct work_struct *work)
 	dmub_hpd_wrk = container_of(work, struct dmub_hpd_work, handle_hpd_work);
 
 	if (!dmub_hpd_wrk->dmub_notify) {
-		DRM_ERROR("dmub_hpd_wrk dmub_notify is NULL");
+		drm_err(adev_to_drm(dmub_hpd_wrk->adev), "dmub_hpd_wrk dmub_notify is NULL");
 		return;
 	}
 
@@ -934,7 +934,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 		do {
 			dc_stat_get_dmub_notification(adev->dm.dc, &notify);
 			if (notify.type >= ARRAY_SIZE(dm->dmub_thread_offload)) {
-				DRM_ERROR("DM: notify type %d invalid!", notify.type);
+				drm_err(adev_to_drm(adev), "DM: notify type %d invalid!", notify.type);
 				continue;
 			}
 			if (!dm->dmub_callback[notify.type]) {
@@ -945,14 +945,14 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 			if (dm->dmub_thread_offload[notify.type] == true) {
 				dmub_hpd_wrk = kzalloc(sizeof(*dmub_hpd_wrk), GFP_ATOMIC);
 				if (!dmub_hpd_wrk) {
-					DRM_ERROR("Failed to allocate dmub_hpd_wrk");
+					drm_err(adev_to_drm(adev), "Failed to allocate dmub_hpd_wrk");
 					return;
 				}
 				dmub_hpd_wrk->dmub_notify = kmemdup(&notify, sizeof(struct dmub_notification),
 								    GFP_ATOMIC);
 				if (!dmub_hpd_wrk->dmub_notify) {
 					kfree(dmub_hpd_wrk);
-					DRM_ERROR("Failed to allocate dmub_hpd_wrk->dmub_notify");
+					drm_err(adev_to_drm(adev), "Failed to allocate dmub_hpd_wrk->dmub_notify");
 					return;
 				}
 				INIT_WORK(&dmub_hpd_wrk->handle_hpd_work, dm_handle_hpd_work);
@@ -1010,7 +1010,7 @@ static void amdgpu_dm_fbc_init(struct drm_connector *connector)
 			    &compressor->gpu_addr, &compressor->cpu_addr);
 
 		if (r)
-			DRM_ERROR("DM: Failed to initialize FBC\n");
+			drm_err(adev_to_drm(adev), "DM: Failed to initialize FBC\n");
 		else {
 			adev->dm.dc->ctx->fbc_gpu_addr = compressor->gpu_addr;
 			DRM_INFO("DM: FBC alloc %lu\n", max_size*4);
@@ -1176,13 +1176,13 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 		return 0;
 
 	if (!fb_info) {
-		DRM_ERROR("No framebuffer info for DMUB service.\n");
+		drm_err(adev_to_drm(adev), "No framebuffer info for DMUB service.\n");
 		return -EINVAL;
 	}
 
 	if (!dmub_fw) {
 		/* Firmware required for DMUB support. */
-		DRM_ERROR("No firmware provided for DMUB.\n");
+		drm_err(adev_to_drm(adev), "No firmware provided for DMUB.\n");
 		return -EINVAL;
 	}
 
@@ -1192,7 +1192,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 
 	status = dmub_srv_has_hw_support(dmub_srv, &has_hw_support);
 	if (status != DMUB_STATUS_OK) {
-		DRM_ERROR("Error checking HW support for DMUB: %d\n", status);
+		drm_err(adev_to_drm(adev), "Error checking HW support for DMUB: %d\n", status);
 		return -EINVAL;
 	}
 
@@ -1294,7 +1294,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 
 	status = dmub_srv_hw_init(dmub_srv, &hw_params);
 	if (status != DMUB_STATUS_OK) {
-		DRM_ERROR("Error initializing DMUB HW: %d\n", status);
+		drm_err(adev_to_drm(adev), "Error initializing DMUB HW: %d\n", status);
 		return -EINVAL;
 	}
 
@@ -1312,7 +1312,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	if (!adev->dm.dc->ctx->dmub_srv)
 		adev->dm.dc->ctx->dmub_srv = dc_dmub_srv_create(adev->dm.dc, dmub_srv);
 	if (!adev->dm.dc->ctx->dmub_srv) {
-		DRM_ERROR("Couldn't allocate DC DMUB server!\n");
+		drm_err(adev_to_drm(adev), "Couldn't allocate DC DMUB server!\n");
 		return -ENOMEM;
 	}
 
@@ -1370,7 +1370,7 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
 		/* Perform the full hardware initialization. */
 		r = dm_dmub_hw_init(adev);
 		if (r)
-			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
+			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
 	}
 }
 
@@ -1948,7 +1948,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	mutex_init(&adev->dm.audio_lock);
 
 	if (amdgpu_dm_irq_init(adev)) {
-		DRM_ERROR("amdgpu: failed to initialize DM IRQ support.\n");
+		drm_err(adev_to_drm(adev), "amdgpu: failed to initialize DM IRQ support.\n");
 		goto error;
 	}
 
@@ -2117,7 +2117,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	r = dm_dmub_hw_init(adev);
 	if (r) {
-		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
+		drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
 		goto error;
 	}
 
@@ -2125,7 +2125,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev);
 	if (!adev->dm.hpd_rx_offload_wq) {
-		DRM_ERROR("amdgpu: failed to create hpd rx offload workqueue.\n");
+		drm_err(adev_to_drm(adev), "amdgpu: failed to create hpd rx offload workqueue.\n");
 		goto error;
 	}
 
@@ -2140,7 +2140,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	adev->dm.freesync_module = mod_freesync_create(adev->dm.dc);
 	if (!adev->dm.freesync_module) {
-		DRM_ERROR(
+		drm_err(adev_to_drm(adev),
 		"amdgpu: failed to initialize freesync_module.\n");
 	} else
 		DRM_DEBUG_DRIVER("amdgpu: freesync_module init done %p.\n",
@@ -2152,7 +2152,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		adev->dm.vblank_control_workqueue =
 			create_singlethread_workqueue("dm_vblank_control_workqueue");
 		if (!adev->dm.vblank_control_workqueue)
-			DRM_ERROR("amdgpu: failed to initialize vblank_workqueue.\n");
+			drm_err(adev_to_drm(adev), "amdgpu: failed to initialize vblank_workqueue.\n");
 	}
 
 	if (adev->dm.dc->caps.ips_support &&
@@ -2163,7 +2163,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		adev->dm.hdcp_workqueue = hdcp_create_workqueue(adev, &init_params.cp_psp, adev->dm.dc);
 
 		if (!adev->dm.hdcp_workqueue)
-			DRM_ERROR("amdgpu: failed to initialize hdcp_workqueue.\n");
+			drm_err(adev_to_drm(adev), "amdgpu: failed to initialize hdcp_workqueue.\n");
 		else
 			DRM_DEBUG_DRIVER("amdgpu: hdcp_workqueue init done %p.\n", adev->dm.hdcp_workqueue);
 
@@ -2179,14 +2179,14 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 		adev->dm.delayed_hpd_wq = create_singlethread_workqueue("amdgpu_dm_hpd_wq");
 		if (!adev->dm.delayed_hpd_wq) {
-			DRM_ERROR("amdgpu: failed to create hpd offload workqueue.\n");
+			drm_err(adev_to_drm(adev), "amdgpu: failed to create hpd offload workqueue.\n");
 			goto error;
 		}
 
 		amdgpu_dm_outbox_init(adev);
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_AUX_REPLY,
 			dmub_aux_setconfig_callback, false)) {
-			DRM_ERROR("amdgpu: fail to register dmub aux callback");
+			drm_err(adev_to_drm(adev), "amdgpu: fail to register dmub aux callback");
 			goto error;
 		}
 		/* Enable outbox notification only after IRQ handlers are registered and DMUB is alive.
@@ -2203,7 +2203,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_dm_initialize_drm_device(adev)) {
-		DRM_ERROR(
+		drm_err(adev_to_drm(adev),
 		"amdgpu: failed to initialize sw for display support.\n");
 		goto error;
 	}
@@ -2218,7 +2218,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev_to_drm(adev)->mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
 
 	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
-		DRM_ERROR(
+		drm_err(adev_to_drm(adev),
 		"amdgpu: failed to initialize sw for display support.\n");
 		goto error;
 	}
@@ -2226,7 +2226,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	amdgpu_dm_crtc_secure_display_create_contexts(adev);
 	if (!adev->dm.secure_display_ctx.crtc_ctx)
-		DRM_ERROR("amdgpu: failed to initialize secure display contexts.\n");
+		drm_err(adev_to_drm(adev), "amdgpu: failed to initialize secure display contexts.\n");
 
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(4, 0, 1))
 		adev->dm.secure_display_ctx.support_mul_roi = true;
@@ -2406,7 +2406,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		default:
 			break;
 		}
-		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
+		drm_err(adev_to_drm(adev), "Unsupported ASIC type: 0x%X\n", adev->asic_type);
 		return -EINVAL;
 	}
 
@@ -2558,7 +2558,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	dmub_srv = adev->dm.dmub_srv;
 
 	if (!dmub_srv) {
-		DRM_ERROR("Failed to allocate DMUB service!\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate DMUB service!\n");
 		return -ENOMEM;
 	}
 
@@ -2571,7 +2571,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	/* Create the DMUB service. */
 	status = dmub_srv_create(dmub_srv, &create_params);
 	if (status != DMUB_STATUS_OK) {
-		DRM_ERROR("Error creating DMUB service: %d\n", status);
+		drm_err(adev_to_drm(adev), "Error creating DMUB service: %d\n", status);
 		return -EINVAL;
 	}
 
@@ -2596,7 +2596,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 					   &region_info);
 
 	if (status != DMUB_STATUS_OK) {
-		DRM_ERROR("Error calculating DMUB region info: %d\n", status);
+		drm_err(adev_to_drm(adev), "Error calculating DMUB region info: %d\n", status);
 		return -EINVAL;
 	}
 
@@ -2625,14 +2625,14 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	fb_info = adev->dm.dmub_fb_info;
 
 	if (!fb_info) {
-		DRM_ERROR(
+		drm_err(adev_to_drm(adev),
 			"Failed to allocate framebuffer info for DMUB service!\n");
 		return -ENOMEM;
 	}
 
 	status = dmub_srv_calc_mem_info(dmub_srv, &memory_params, fb_info);
 	if (status != DMUB_STATUS_OK) {
-		DRM_ERROR("Error calculating DMUB FB info: %d\n", status);
+		drm_err(adev_to_drm(adev), "Error calculating DMUB FB info: %d\n", status);
 		return -EINVAL;
 	}
 
@@ -2649,7 +2649,7 @@ static int dm_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->dm.cgs_device = amdgpu_cgs_create_device(adev);
 
 	if (!adev->dm.cgs_device) {
-		DRM_ERROR("amdgpu: failed to create cgs device.\n");
+		drm_err(adev_to_drm(adev), "amdgpu: failed to create cgs device.\n");
 		return -EINVAL;
 	}
 
@@ -2955,7 +2955,7 @@ static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
 
 	ret = amdgpu_dpm_write_watermarks_table(adev);
 	if (ret) {
-		DRM_ERROR("Failed to update WMTABLE!\n");
+		drm_err(adev_to_drm(adev), "Failed to update WMTABLE!\n");
 		return ret;
 	}
 
@@ -4080,19 +4080,19 @@ static int register_hpd_handlers(struct amdgpu_device *adev)
 	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD,
 			dmub_hpd_callback, true)) {
-			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
+			drm_err(adev_to_drm(adev), "amdgpu: fail to register dmub hpd callback");
 			return -EINVAL;
 		}
 
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_IRQ,
 			dmub_hpd_callback, true)) {
-			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
+			drm_err(adev_to_drm(adev), "amdgpu: fail to register dmub hpd callback");
 			return -EINVAL;
 		}
 
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_SENSE_NOTIFY,
 			dmub_hpd_sense_callback, true)) {
-			DRM_ERROR("amdgpu: fail to register dmub hpd sense callback");
+			drm_err(adev_to_drm(adev), "amdgpu: fail to register dmub hpd sense callback");
 			return -EINVAL;
 		}
 	}
@@ -4113,7 +4113,7 @@ static int register_hpd_handlers(struct amdgpu_device *adev)
 			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 				int_params.irq_source  < DC_IRQ_SOURCE_HPD1 ||
 				int_params.irq_source  > DC_IRQ_SOURCE_HPD6) {
-				DRM_ERROR("Failed to register hpd irq!\n");
+				drm_err(adev_to_drm(adev), "Failed to register hpd irq!\n");
 				return -EINVAL;
 			}
 
@@ -4131,7 +4131,7 @@ static int register_hpd_handlers(struct amdgpu_device *adev)
 			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 				int_params.irq_source  < DC_IRQ_SOURCE_HPD1RX ||
 				int_params.irq_source  > DC_IRQ_SOURCE_HPD6RX) {
-				DRM_ERROR("Failed to register hpd rx irq!\n");
+				drm_err(adev_to_drm(adev), "Failed to register hpd rx irq!\n");
 				return -EINVAL;
 			}
 
@@ -4173,7 +4173,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
 		r = amdgpu_irq_add_id(adev, client_id, i + 1, &adev->crtc_irq);
 		if (r) {
-			DRM_ERROR("Failed to add crtc irq id!\n");
+			drm_err(adev_to_drm(adev), "Failed to add crtc irq id!\n");
 			return r;
 		}
 
@@ -4184,7 +4184,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
 			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
-			DRM_ERROR("Failed to register vblank irq!\n");
+			drm_err(adev_to_drm(adev), "Failed to register vblank irq!\n");
 			return -EINVAL;
 		}
 
@@ -4203,7 +4203,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 			i <= VISLANDS30_IV_SRCID_D6_GRPH_PFLIP; i += 2) {
 		r = amdgpu_irq_add_id(adev, client_id, i, &adev->pageflip_irq);
 		if (r) {
-			DRM_ERROR("Failed to add page flip irq id!\n");
+			drm_err(adev_to_drm(adev), "Failed to add page flip irq id!\n");
 			return r;
 		}
 
@@ -4214,7 +4214,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
 			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
-			DRM_ERROR("Failed to register pflip irq!\n");
+			drm_err(adev_to_drm(adev), "Failed to register pflip irq!\n");
 			return -EINVAL;
 		}
 
@@ -4232,7 +4232,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 	r = amdgpu_irq_add_id(adev, client_id,
 			VISLANDS30_IV_SRCID_HOTPLUG_DETECT_A, &adev->hpd_irq);
 	if (r) {
-		DRM_ERROR("Failed to add hpd irq id!\n");
+		drm_err(adev_to_drm(adev), "Failed to add hpd irq id!\n");
 		return r;
 	}
 
@@ -4274,7 +4274,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	for (i = VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0; i <= VISLANDS30_IV_SRCID_D6_VERTICAL_INTERRUPT0; i++) {
 		r = amdgpu_irq_add_id(adev, client_id, i, &adev->crtc_irq);
 		if (r) {
-			DRM_ERROR("Failed to add crtc irq id!\n");
+			drm_err(adev_to_drm(adev), "Failed to add crtc irq id!\n");
 			return r;
 		}
 
@@ -4285,7 +4285,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
 			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
-			DRM_ERROR("Failed to register vblank irq!\n");
+			drm_err(adev_to_drm(adev), "Failed to register vblank irq!\n");
 			return -EINVAL;
 		}
 
@@ -4303,7 +4303,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	for (i = VISLANDS30_IV_SRCID_D1_V_UPDATE_INT; i <= VISLANDS30_IV_SRCID_D6_V_UPDATE_INT; i += 2) {
 		r = amdgpu_irq_add_id(adev, client_id, i, &adev->vupdate_irq);
 		if (r) {
-			DRM_ERROR("Failed to add vupdate irq id!\n");
+			drm_err(adev_to_drm(adev), "Failed to add vupdate irq id!\n");
 			return r;
 		}
 
@@ -4314,7 +4314,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
 			int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
-			DRM_ERROR("Failed to register vupdate irq!\n");
+			drm_err(adev_to_drm(adev), "Failed to register vupdate irq!\n");
 			return -EINVAL;
 		}
 
@@ -4333,7 +4333,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 			i <= VISLANDS30_IV_SRCID_D6_GRPH_PFLIP; i += 2) {
 		r = amdgpu_irq_add_id(adev, client_id, i, &adev->pageflip_irq);
 		if (r) {
-			DRM_ERROR("Failed to add page flip irq id!\n");
+			drm_err(adev_to_drm(adev), "Failed to add page flip irq id!\n");
 			return r;
 		}
 
@@ -4344,7 +4344,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
 			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
-			DRM_ERROR("Failed to register pflip irq!\n");
+			drm_err(adev_to_drm(adev), "Failed to register pflip irq!\n");
 			return -EINVAL;
 		}
 
@@ -4362,7 +4362,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	r = amdgpu_irq_add_id(adev, client_id,
 			VISLANDS30_IV_SRCID_HOTPLUG_DETECT_A, &adev->hpd_irq);
 	if (r) {
-		DRM_ERROR("Failed to add hpd irq id!\n");
+		drm_err(adev_to_drm(adev), "Failed to add hpd irq id!\n");
 		return r;
 	}
 
@@ -4412,7 +4412,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->crtc_irq);
 
 		if (r) {
-			DRM_ERROR("Failed to add crtc irq id!\n");
+			drm_err(adev_to_drm(adev), "Failed to add crtc irq id!\n");
 			return r;
 		}
 
@@ -4423,7 +4423,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
 			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
-			DRM_ERROR("Failed to register vblank irq!\n");
+			drm_err(adev_to_drm(adev), "Failed to register vblank irq!\n");
 			return -EINVAL;
 		}
 
@@ -4444,7 +4444,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 				vrtl_int_srcid[i], &adev->vline0_irq);
 
 		if (r) {
-			DRM_ERROR("Failed to add vline0 irq id!\n");
+			drm_err(adev_to_drm(adev), "Failed to add vline0 irq id!\n");
 			return r;
 		}
 
@@ -4455,7 +4455,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source < DC_IRQ_SOURCE_DC1_VLINE0 ||
 			int_params.irq_source > DC_IRQ_SOURCE_DC6_VLINE0) {
-			DRM_ERROR("Failed to register vline0 irq!\n");
+			drm_err(adev_to_drm(adev), "Failed to register vline0 irq!\n");
 			return -EINVAL;
 		}
 
@@ -4483,7 +4483,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->vupdate_irq);
 
 		if (r) {
-			DRM_ERROR("Failed to add vupdate irq id!\n");
+			drm_err(adev_to_drm(adev), "Failed to add vupdate irq id!\n");
 			return r;
 		}
 
@@ -4494,7 +4494,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
 			int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
-			DRM_ERROR("Failed to register vupdate irq!\n");
+			drm_err(adev_to_drm(adev), "Failed to register vupdate irq!\n");
 			return -EINVAL;
 		}
 
@@ -4514,7 +4514,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 			i++) {
 		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->pageflip_irq);
 		if (r) {
-			DRM_ERROR("Failed to add page flip irq id!\n");
+			drm_err(adev_to_drm(adev), "Failed to add page flip irq id!\n");
 			return r;
 		}
 
@@ -4525,7 +4525,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
 			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
-			DRM_ERROR("Failed to register pflip irq!\n");
+			drm_err(adev_to_drm(adev), "Failed to register pflip irq!\n");
 			return -EINVAL;
 		}
 
@@ -4543,7 +4543,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DC_HPD1_INT,
 			&adev->hpd_irq);
 	if (r) {
-		DRM_ERROR("Failed to add hpd irq id!\n");
+		drm_err(adev_to_drm(adev), "Failed to add hpd irq id!\n");
 		return r;
 	}
 
@@ -4565,7 +4565,7 @@ static int register_outbox_irq_handlers(struct amdgpu_device *adev)
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT,
 			&adev->dmub_outbox_irq);
 	if (r) {
-		DRM_ERROR("Failed to add outbox irq id!\n");
+		drm_err(adev_to_drm(adev), "Failed to add outbox irq id!\n");
 		return r;
 	}
 
@@ -5010,7 +5010,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	dm->brightness[aconnector->bl_idx] = props.brightness;
 
 	if (IS_ERR(dm->backlight_dev[aconnector->bl_idx])) {
-		DRM_ERROR("DM: Backlight registration failed!\n");
+		drm_err(drm, "DM: Backlight registration failed!\n");
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
 	} else
 		DRM_DEBUG_DRIVER("DM: Registered Backlight device: %s\n", bl_name);
@@ -5027,7 +5027,7 @@ static int initialize_plane(struct amdgpu_display_manager *dm,
 
 	plane = kzalloc(sizeof(struct drm_plane), GFP_KERNEL);
 	if (!plane) {
-		DRM_ERROR("KMS: Failed to allocate plane\n");
+		drm_err(adev_to_drm(dm->adev), "KMS: Failed to allocate plane\n");
 		return -ENOMEM;
 	}
 	plane->type = plane_type;
@@ -5045,7 +5045,7 @@ static int initialize_plane(struct amdgpu_display_manager *dm,
 	ret = amdgpu_dm_plane_init(dm, plane, possible_crtcs, plane_cap);
 
 	if (ret) {
-		DRM_ERROR("KMS: Failed to initialize plane\n");
+		drm_err(adev_to_drm(dm->adev), "KMS: Failed to initialize plane\n");
 		kfree(plane);
 		return ret;
 	}
@@ -5114,14 +5114,14 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 	link_cnt = dm->dc->caps.max_links;
 	if (amdgpu_dm_mode_config_init(dm->adev)) {
-		DRM_ERROR("DM: Failed to initialize mode config\n");
+		drm_err(adev_to_drm(adev), "DM: Failed to initialize mode config\n");
 		return -EINVAL;
 	}
 
 	/* There is one primary plane per CRTC */
 	primary_planes = dm->dc->caps.max_streams;
 	if (primary_planes > AMDGPU_MAX_PLANES) {
-		DRM_ERROR("DM: Plane nums out of 6 planes\n");
+		drm_err(adev_to_drm(adev), "DM: Plane nums out of 6 planes\n");
 		return -EINVAL;
 	}
 
@@ -5134,7 +5134,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 		if (initialize_plane(dm, mode_info, i,
 				     DRM_PLANE_TYPE_PRIMARY, plane)) {
-			DRM_ERROR("KMS: Failed to initialize primary plane\n");
+			drm_err(adev_to_drm(adev), "KMS: Failed to initialize primary plane\n");
 			goto fail;
 		}
 	}
@@ -5166,14 +5166,14 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 		if (initialize_plane(dm, NULL, primary_planes + i,
 				     DRM_PLANE_TYPE_OVERLAY, plane)) {
-			DRM_ERROR("KMS: Failed to initialize overlay plane\n");
+			drm_err(adev_to_drm(adev), "KMS: Failed to initialize overlay plane\n");
 			goto fail;
 		}
 	}
 
 	for (i = 0; i < dm->dc->caps.max_streams; i++)
 		if (amdgpu_dm_crtc_init(dm, mode_info->planes[i], i)) {
-			DRM_ERROR("KMS: Failed to initialize crtc\n");
+			drm_err(adev_to_drm(adev), "KMS: Failed to initialize crtc\n");
 			goto fail;
 		}
 
@@ -5193,7 +5193,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case IP_VERSION(3, 6, 0):
 	case IP_VERSION(4, 0, 1):
 		if (register_outbox_irq_handlers(dm->adev)) {
-			DRM_ERROR("DM: Failed to initialize IRQ\n");
+			drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
 			goto fail;
 		}
 		break;
@@ -5243,7 +5243,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	}
 
 	if (link_cnt > MAX_LINKS) {
-		DRM_ERROR(
+		drm_err(adev_to_drm(adev),
 			"KMS: Cannot support more than %d display indexes\n",
 				MAX_LINKS);
 		goto fail;
@@ -5259,12 +5259,12 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			struct amdgpu_dm_wb_connector *wbcon = kzalloc(sizeof(*wbcon), GFP_KERNEL);
 
 			if (!wbcon) {
-				DRM_ERROR("KMS: Failed to allocate writeback connector\n");
+				drm_err(adev_to_drm(adev), "KMS: Failed to allocate writeback connector\n");
 				continue;
 			}
 
 			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
-				DRM_ERROR("KMS: Failed to initialize writeback connector\n");
+				drm_err(adev_to_drm(adev), "KMS: Failed to initialize writeback connector\n");
 				kfree(wbcon);
 				continue;
 			}
@@ -5284,12 +5284,12 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 
 		if (amdgpu_dm_encoder_init(dm->ddev, aencoder, i)) {
-			DRM_ERROR("KMS: Failed to initialize encoder\n");
+			drm_err(adev_to_drm(adev), "KMS: Failed to initialize encoder\n");
 			goto fail;
 		}
 
 		if (amdgpu_dm_connector_init(dm, aconnector, i, aencoder)) {
-			DRM_ERROR("KMS: Failed to initialize connector\n");
+			drm_err(adev_to_drm(adev), "KMS: Failed to initialize connector\n");
 			goto fail;
 		}
 
@@ -5298,7 +5298,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 				aconnector;
 
 		if (!dc_link_detect_connection_type(link, &new_connection_type))
-			DRM_ERROR("KMS: Failed to detect connector\n");
+			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
 		if (aconnector->base.force && new_connection_type == dc_connection_none) {
 			emulated_link_detect(link);
@@ -5335,7 +5335,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case CHIP_VERDE:
 	case CHIP_OLAND:
 		if (dce60_register_irq_handlers(dm->adev)) {
-			DRM_ERROR("DM: Failed to initialize IRQ\n");
+			drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
 			goto fail;
 		}
 		break;
@@ -5357,7 +5357,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
 		if (dce110_register_irq_handlers(dm->adev)) {
-			DRM_ERROR("DM: Failed to initialize IRQ\n");
+			drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
 			goto fail;
 		}
 		break;
@@ -5385,12 +5385,12 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 0, 1):
 			if (dcn10_register_irq_handlers(dm->adev)) {
-				DRM_ERROR("DM: Failed to initialize IRQ\n");
+				drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
 				goto fail;
 			}
 			break;
 		default:
-			DRM_ERROR("Unsupported DCE IP versions: 0x%X\n",
+			drm_err(adev_to_drm(adev), "Unsupported DCE IP versions: 0x%X\n",
 					amdgpu_ip_version(adev, DCE_HWIP, 0));
 			goto fail;
 		}
@@ -5663,7 +5663,7 @@ static int dm_early_init(struct amdgpu_ip_block *ip_block)
 			adev->mode_info.num_dig = 4;
 			break;
 		default:
-			DRM_ERROR("Unsupported DCE IP versions: 0x%x\n",
+			drm_err(adev_to_drm(adev), "Unsupported DCE IP versions: 0x%x\n",
 					amdgpu_ip_version(adev, DCE_HWIP, 0));
 			return -EINVAL;
 		}
@@ -5812,7 +5812,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616;
 		break;
 	default:
-		DRM_ERROR(
+		drm_err(adev_to_drm(adev),
 			"Unsupported screen format %p4cc\n",
 			&fb->format->format);
 		return -EINVAL;
@@ -7408,6 +7408,7 @@ static void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
 	struct dc_sink *dc_em_sink = aconnector->dc_em_sink;
 	const struct drm_edid *drm_edid;
 	struct i2c_adapter *ddc;
+	struct drm_device *dev = connector->dev;
 
 	if (dc_link && dc_link->aux_mode)
 		ddc = &aconnector->dm_dp_aux.aux.ddc;
@@ -7417,7 +7418,7 @@ static void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
 	drm_edid = drm_edid_read_ddc(connector, ddc);
 	drm_edid_connector_update(connector, drm_edid);
 	if (!drm_edid) {
-		DRM_ERROR("No EDID found on connector: %s.\n", connector->name);
+		drm_err(dev, "No EDID found on connector: %s.\n", connector->name);
 		return;
 	}
 
@@ -7476,7 +7477,7 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 	drm_edid = drm_edid_read_ddc(connector, ddc);
 	drm_edid_connector_update(connector, drm_edid);
 	if (!drm_edid) {
-		DRM_ERROR("No EDID found on connector: %s.\n", connector->name);
+		drm_err(connector->dev, "No EDID found on connector: %s.\n", connector->name);
 		return;
 	}
 
@@ -7684,7 +7685,7 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 
 	if (dc_sink == NULL && aconnector->base.force != DRM_FORCE_ON_DIGITAL &&
 				aconnector->base.force != DRM_FORCE_ON) {
-		DRM_ERROR("dc_sink is NULL!\n");
+		drm_err(connector->dev, "dc_sink is NULL!\n");
 		goto fail;
 	}
 
@@ -8587,7 +8588,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 
 	i2c = create_i2c(link->ddc, false);
 	if (!i2c) {
-		DRM_ERROR("Failed to create i2c adapter data\n");
+		drm_err(adev_to_drm(dm->adev), "Failed to create i2c adapter data\n");
 		return -ENOMEM;
 	}
 
@@ -8595,7 +8596,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	res = i2c_add_adapter(&i2c->base);
 
 	if (res) {
-		DRM_ERROR("Failed to register hw i2c %d\n", link->link_index);
+		drm_err(adev_to_drm(dm->adev), "Failed to register hw i2c %d\n", link->link_index);
 		goto out_free;
 	}
 
@@ -8609,7 +8610,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 			&i2c->base);
 
 	if (res) {
-		DRM_ERROR("connector_init failed\n");
+		drm_err(adev_to_drm(dm->adev), "connector_init failed\n");
 		aconnector->connector_id = -1;
 		goto out_free;
 	}
@@ -9194,13 +9195,13 @@ static void amdgpu_dm_update_cursor(struct drm_plane *plane,
 	if (crtc_state->stream) {
 		if (!dc_stream_set_cursor_attributes(crtc_state->stream,
 						     &attributes))
-			DRM_ERROR("DC failed to set cursor attributes\n");
+			drm_err(adev_to_drm(adev), "DC failed to set cursor attributes\n");
 
 		update->cursor_attributes = &crtc_state->stream->cursor_attributes;
 
 		if (!dc_stream_set_cursor_position(crtc_state->stream,
 						   &position))
-			DRM_ERROR("DC failed to set cursor position\n");
+			drm_err(adev_to_drm(adev), "DC failed to set cursor position\n");
 
 		update->cursor_position = &crtc_state->stream->cursor_position;
 	}
@@ -9451,7 +9452,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		bundle->surface_updates[planes_count].surface = dc_plane;
 
 		if (!bundle->surface_updates[planes_count].surface) {
-			DRM_ERROR("No surface for CRTC: id=%d\n",
+			drm_err(dev, "No surface for CRTC: id=%d\n",
 					acrtc_attach->crtc_id);
 			continue;
 		}
@@ -9967,20 +9968,20 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 
 	wb_info = kzalloc(sizeof(*wb_info), GFP_KERNEL);
 	if (!wb_info) {
-		DRM_ERROR("Failed to allocate wb_info\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate wb_info\n");
 		return;
 	}
 
 	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
 	if (!acrtc) {
-		DRM_ERROR("no amdgpu_crtc found\n");
+		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
 		kfree(wb_info);
 		return;
 	}
 
 	afb = to_amdgpu_framebuffer(new_con_state->writeback_job->fb);
 	if (!afb) {
-		DRM_ERROR("No amdgpu_framebuffer found\n");
+		drm_err(adev_to_drm(adev), "No amdgpu_framebuffer found\n");
 		kfree(wb_info);
 		return;
 	}
@@ -10293,7 +10294,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		 */
 		dummy_updates = kzalloc(sizeof(struct dc_surface_update) * MAX_SURFACES, GFP_ATOMIC);
 		if (!dummy_updates) {
-			DRM_ERROR("Failed to allocate memory for dummy_updates.\n");
+			drm_err(adev_to_drm(adev), "Failed to allocate memory for dummy_updates.\n");
 			continue;
 		}
 		for (j = 0; j < status->plane_count; j++)
@@ -10528,7 +10529,7 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 out:
 	drm_atomic_state_put(state);
 	if (ret)
-		DRM_ERROR("Restoring old state failed with %i\n", ret);
+		drm_err(ddev, "Restoring old state failed with %i\n", ret);
 
 	return ret;
 }
@@ -10612,7 +10613,7 @@ static int do_aquire_global_lock(struct drm_device *dev,
 					&commit->flip_done, 10*HZ);
 
 		if (ret == 0)
-			DRM_ERROR("[CRTC:%d:%s] hw_done or flip_done timed out\n",
+			drm_err(dev, "[CRTC:%d:%s] hw_done or flip_done timed out\n",
 				  crtc->base.id, crtc->name);
 
 		drm_crtc_commit_put(commit);
@@ -11728,7 +11729,7 @@ static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
 		old_plane_state = drm_atomic_get_plane_state(state, plane);
 
 		if (IS_ERR(new_plane_state) || IS_ERR(old_plane_state)) {
-			DRM_ERROR("Failed to get plane state for plane %s\n", plane->name);
+			drm_err(dev, "Failed to get plane state for plane %s\n", plane->name);
 			return false;
 		}
 
@@ -12297,7 +12298,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 
 	res = dc_wake_and_execute_dmub_cmd(dm->dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY);
 	if (!res) {
-		DRM_ERROR("EDID CEA parser failed\n");
+		drm_err(adev_to_drm(dm->adev), "EDID CEA parser failed\n");
 		return false;
 	}
 
@@ -12305,7 +12306,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 
 	if (output->type == DMUB_CMD__EDID_CEA_ACK) {
 		if (!output->ack.success) {
-			DRM_ERROR("EDID CEA ack failed at offset %d\n",
+			drm_err(adev_to_drm(dm->adev), "EDID CEA ack failed at offset %d\n",
 					output->ack.offset);
 		}
 	} else if (output->type == DMUB_CMD__EDID_CEA_AMD_VSDB) {
@@ -12533,7 +12534,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
 
 	if (!connector->state) {
-		DRM_ERROR("%s - Connector has no state", __func__);
+		drm_err(adev_to_drm(adev), "%s - Connector has no state", __func__);
 		goto update;
 	}
 
@@ -12718,7 +12719,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 	}
 
 	if (!wait_for_completion_timeout(&adev->dm.dmub_aux_transfer_done, 10 * HZ)) {
-		DRM_ERROR("wait_for_completion_timeout timeout!");
+		drm_err(adev_to_drm(adev), "wait_for_completion_timeout timeout!");
 		*operation_result = AUX_RET_ERROR_TIMEOUT;
 		goto out;
 	}
@@ -12781,7 +12782,7 @@ int amdgpu_dm_process_dmub_set_config_sync(
 		ret = 0;
 		*operation_result = adev->dm.dmub_notify->sc_status;
 	} else {
-		DRM_ERROR("wait_for_completion_timeout timeout!");
+		drm_err(adev_to_drm(adev), "wait_for_completion_timeout timeout!");
 		ret = -1;
 		*operation_result = SET_CONFIG_UNKNOWN_ERROR;
 	}
-- 
2.43.0

