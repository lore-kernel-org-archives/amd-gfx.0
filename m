Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615AAD6DDD8
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 06:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11DB610E39D;
	Fri, 15 Nov 2024 06:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jMZNEN3/";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E1C10E39D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 06:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgqpJLwvIW0n1qDV7oDXNOz0/Qu84u83SiElt86CU9tJ2gKj+gf1MGa3zxop9eBCNG7x13w/SKCbVO4Rs1hFfhBobgcphXwVAG5ckF0i4xZQ122PVttJEbhX9+Lnv2E3yEFMWteqwKy4gcCy2ljmMth4NFQeIgKLvPWRbcsUQ49tMg1+1SeEp+bCZm3K9wHhoz6ottuAlJzBqzaIpblaewDJoVH58jKm7ztvqBI8EuPtnKPvn9N225Ymt2O3y5fqO+F/YjYAWLsE+WP2YNX5zK3LqR9HAdo54IZjG+YmpgkW4yp5bYOeXQjEhwZhxZbEL3den8ybp1jVyftKkJ3Fvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br+ht9j2u5dNXznCYbmQLM3ThDaNQPQgcl7mVv5o5EU=;
 b=xPNXLz43VHIO4MGKrZvGCI6uqQ9fv30AlEC/8ZXy7NDEmZ8HjUDG3Cev5Sx1gLuF7Q+j6rfmfgOpwNhvq4jI5spKRnwMy7RpfkAjmG3daIpnBY58wk5p2XGSZ9tAFZhqgQK7iGyBLCLtFdMJn1BsV+4z2yk0nMiF+Qst11gey2S3SkfNLCP0ixkPsfbufMfbtL96IAImGdlnEUtGKjac4tigRyem6hvnUx33ccY5IPAbbfHu/oUTOtCzWKQBxLZ3RQYyj8Z1EgEzhZ67AACzkR6vzN5fxMfLyetjwJUETxCb3qY2Ww5JJ9bOewBdzzPgIC9aVtQglnUif7Ivf2qZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br+ht9j2u5dNXznCYbmQLM3ThDaNQPQgcl7mVv5o5EU=;
 b=jMZNEN3/Rd2HLJqV8kgZrSKcERTxvvSoT8kHuTecpVcVcxfx4NheVYo7Zo3scvLkUbaVP4je2psu3C1BHQcRXDO/ep9Ogl8Dq97sBDa4sp2kLBpmKmxXRAi8cEM9TcsBtWx2qoYVhvT3DuuRPdAW/Ez9Nm7s+VScnHBNR5gZ+hs=
Received: from SJ0PR13CA0117.namprd13.prod.outlook.com (2603:10b6:a03:2c5::32)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 06:09:44 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::51) by SJ0PR13CA0117.outlook.office365.com
 (2603:10b6:a03:2c5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 06:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:09:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:09:39 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/5] drm/amd/display: convert all DRM_ERROR and DRM_WARN to
 drm_*
Date: Fri, 15 Nov 2024 00:09:23 -0600
Message-ID: <20241115060924.1805-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115060924.1805-1-mario.limonciello@amd.com>
References: <20241115060924.1805-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: e850a461-2e97-4849-827c-08dd053c1955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zBEbP4Z7MkQCh1jT/cnWFL+lkoFGnEv985S1/iJISyQ9ztTHHpGdOBnElnfd?=
 =?us-ascii?Q?yZGULrLxGKP8GWh/Q1Xt72XfCzY1KoE4gmw1OZ3hHwGnQCr+gs99b6ZvmkBw?=
 =?us-ascii?Q?3MSyfr+uGHKcmadAXCqGk+hpjYZdMPON8ixuAosQ8M5bQGMcEhMApriZw1TZ?=
 =?us-ascii?Q?IwzWUwWHyj4ncEjKrIl+j9KgA65jFXYegXUUlOchbXCPBF+N6Ou6bhIUtg3f?=
 =?us-ascii?Q?+fAxLyMKHvkmPPbdFCnGAG0unsZEeu4iCqS5Vzmmqe+qSIWilo9fcV85McZ/?=
 =?us-ascii?Q?DQRc6B7XnpHzNUOZrKEnQ+ycZN9NiCnym6Ji54VFkn2Cg9AWpbtRh69oV+pj?=
 =?us-ascii?Q?p0fwjSNtjV7VkSaFmTVIwSqPNiEYK1DXcn+CtG4hGSV05yQc7b7vevfz/K7R?=
 =?us-ascii?Q?zU5dloU08LeZacZJDQ3nJiZy9YDwfjGLGS71OntTOC6RdT8Ov+TCskJ1FDuh?=
 =?us-ascii?Q?am4M9w0hsJ0HZ1GsknvQl4oL1doJ5WADyPQzd4RPLs9AIeMcv5oqRKg01Wgc?=
 =?us-ascii?Q?Msnrn7dTGXV/4lUmGWt83A69LPYs1dYwrIaYw7zRxSgua86R5PIzCgSkkSeu?=
 =?us-ascii?Q?xHDnQpvSOQYIo1zmJWWQOGcV6AQ7w6m2r9iQ8Iy1gWXVKR4dV4samfShEmx1?=
 =?us-ascii?Q?v01sr0QMidLXkWEAw3LMMDv0nAl97ZMKv1BE5NxJJVvYGIgUo/UBWiQARMor?=
 =?us-ascii?Q?fuonKSRRTCG77trXLFtHquZCiHmjzN2jC5sFwsV9qtKXq+14OF7JzNnOXVEQ?=
 =?us-ascii?Q?SdDl5/K8/UJKqMq5Iih0gHegAFWLwTky9Ko81wzKYzJG1zDUoJCN3mOfLpJ4?=
 =?us-ascii?Q?B73l8tCah3Cn6zOhnFZwaSULVyAUEuOcHAFK5FMNxBAj2vCX2ZwiiRV5SEum?=
 =?us-ascii?Q?b9B10RiLuGvfwNFaa6d3EJ2ex4Mfwq8MnAI3QRLQgkoTRu8bvD1CIFB7GKWj?=
 =?us-ascii?Q?JNO0Hg1Rt/DYlYX5Ow3LJxPJoELYi0Z8whcRYogT46sZnhpbzmOuV/5DHl3D?=
 =?us-ascii?Q?EglF4EpgTDgle1oRph6SxjnxlE0hbu9RpQne4v0RQ3lITRYYyR800WqMMuhi?=
 =?us-ascii?Q?sn9xDbOmOPQjNgX2JXWVjYyCNBmSFr2llu9H3MyfI7djNtsbUX9npUe1lYdS?=
 =?us-ascii?Q?wLmigcju2mbHjq3FFO2fso3jeEwIzMr8XOHxPphpbp7H5qGTqrISVcskWWkK?=
 =?us-ascii?Q?KH3/mtNWavbxZrdpod3QlN1eQjFm+gZa4MybBIu6nyzwxMYr7hBT1jYY6SKI?=
 =?us-ascii?Q?PhHMI/+hUDiq9TEete30a0Aqj4qgh74G/A5M54uMxhvf+jtAlg0UzyiOmodu?=
 =?us-ascii?Q?yj2THup1cmU+R39W1GqzisRjj1nvQ/1aFC6pRB5zD6q9Mf8QcC7ixMotWxF1?=
 =?us-ascii?Q?avh++/qB/qv1IMMgL3/f5EM1gzP7zM8QqmPZMGXrsb9cu8+C3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:09:43.5033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e850a461-2e97-4849-827c-08dd053c1955
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
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

drm_* helpers will display the device the message is emitted for and
are thus generally more helpful in multi GPU systems.

Change all `DRM_ERROR` and `DRM_WARN` calls over to drm_err() and
drm_warn() respectively.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 338 ++++++++++--------
 1 file changed, 183 insertions(+), 155 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3081418fc255a..95807d035a153 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -269,7 +269,7 @@ static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 	acrtc = adev->mode_info.crtcs[crtc];
 
 	if (!acrtc->dm_irq_params.stream) {
-		DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
+		drm_err(adev->dm.ddev, "dc_stream_state is NULL for crtc '%d'!\n",
 			  crtc);
 		return 0;
 	}
@@ -290,7 +290,7 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 	acrtc = adev->mode_info.crtcs[crtc];
 
 	if (!acrtc->dm_irq_params.stream) {
-		DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
+		drm_err(adev->dm.ddev, "dc_stream_state is NULL for crtc '%d'!\n",
 			  crtc);
 		return 0;
 	}
@@ -761,18 +761,18 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 		return;
 
 	if (notify == NULL) {
-		DRM_ERROR("DMUB HPD callback notification was NULL");
+		drm_err(adev->dm.ddev, "DMUB HPD callback notification was NULL");
 		return;
 	}
 
 	if (notify->link_index > adev->dm.dc->link_count) {
-		DRM_ERROR("DMUB HPD index (%u)is abnormal", notify->link_index);
+		drm_err(adev->dm.ddev, "DMUB HPD index (%u)is abnormal", notify->link_index);
 		return;
 	}
 
 	/* Skip DMUB HPD IRQ in suspend/resume. We will probe them later. */
 	if (notify->type == DMUB_NOTIFICATION_HPD && adev->in_suspend) {
-		DRM_INFO("Skip DMUB HPD IRQ callback in suspend/resume\n");
+		drm_info(adev->dm.ddev, "Skip DMUB HPD IRQ callback in suspend/resume\n");
 		return;
 	}
 
@@ -789,12 +789,14 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (link && aconnector->dc_link == link) {
 			if (notify->type == DMUB_NOTIFICATION_HPD)
-				DRM_INFO("DMUB HPD IRQ callback: link_index=%u\n", link_index);
+				drm_info(adev->dm.ddev, "DMUB HPD IRQ callback: link_index=%u\n",
+					link_index);
 			else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ)
-				DRM_INFO("DMUB HPD RX IRQ callback: link_index=%u\n", link_index);
+				drm_info(adev->dm.ddev, "DMUB HPD RX IRQ callback: link_index=%u\n",
+					link_index);
 			else
-				DRM_WARN("DMUB Unknown HPD callback type %d, link_index=%u\n",
-						notify->type, link_index);
+				drm_warn(adev->dm.ddev, "DMUB Unknown HPD callback type %d, link_index=%u\n",
+					notify->type, link_index);
 
 			hpd_aconnector = aconnector;
 			break;
@@ -805,7 +807,8 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 	if (hpd_aconnector) {
 		if (notify->type == DMUB_NOTIFICATION_HPD) {
 			if (hpd_aconnector->dc_link->hpd_status == (notify->hpd_status == DP_HPD_PLUG))
-				DRM_WARN("DMUB reported hpd status unchanged. link_index=%u\n", link_index);
+				drm_warn(adev->dm.ddev, "DMUB reported hpd status unchanged. link_index=%u\n",
+					link_index);
 			handle_hpd_irq_helper(hpd_aconnector);
 		} else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ) {
 			handle_hpd_rx_irq(hpd_aconnector);
@@ -824,7 +827,7 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 static void dmub_hpd_sense_callback(struct amdgpu_device *adev,
 			      struct dmub_notification *notify)
 {
-	DRM_DEBUG_DRIVER("DMUB HPD SENSE callback.\n");
+	drm_dbg(adev_to_drm(adev), "DMUB HPD SENSE callback.\n");
 }
 
 /**
@@ -860,7 +863,7 @@ static void dm_handle_hpd_work(struct work_struct *work)
 	dmub_hpd_wrk = container_of(work, struct dmub_hpd_work, handle_hpd_work);
 
 	if (!dmub_hpd_wrk->dmub_notify) {
-		DRM_ERROR("dmub_hpd_wrk dmub_notify is NULL");
+		drm_err(dmub_hpd_wrk->adev->dm.ddev, "dmub_hpd_wrk dmub_notify is NULL");
 		return;
 	}
 
@@ -924,25 +927,25 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 		do {
 			dc_stat_get_dmub_notification(adev->dm.dc, &notify);
 			if (notify.type >= ARRAY_SIZE(dm->dmub_thread_offload)) {
-				DRM_ERROR("DM: notify type %d invalid!", notify.type);
+				drm_err(adev->dm.ddev, "DM: notify type %d invalid!", notify.type);
 				continue;
 			}
 			if (!dm->dmub_callback[notify.type]) {
-				DRM_WARN("DMUB notification skipped due to no handler: type=%s\n",
+				drm_warn(adev->dm.ddev, "DMUB notification skipped due to no handler: type=%s\n",
 					event_type[notify.type]);
 				continue;
 			}
 			if (dm->dmub_thread_offload[notify.type] == true) {
 				dmub_hpd_wrk = kzalloc(sizeof(*dmub_hpd_wrk), GFP_ATOMIC);
 				if (!dmub_hpd_wrk) {
-					DRM_ERROR("Failed to allocate dmub_hpd_wrk");
+					drm_err(adev->dm.ddev, "Failed to allocate dmub_hpd_wrk");
 					return;
 				}
 				dmub_hpd_wrk->dmub_notify = kmemdup(&notify, sizeof(struct dmub_notification),
 								    GFP_ATOMIC);
 				if (!dmub_hpd_wrk->dmub_notify) {
 					kfree(dmub_hpd_wrk);
-					DRM_ERROR("Failed to allocate dmub_hpd_wrk->dmub_notify");
+					drm_err(adev->dm.ddev, "Failed to allocate dmub_hpd_wrk->dmub_notify");
 					return;
 				}
 				INIT_WORK(&dmub_hpd_wrk->handle_hpd_work, dm_handle_hpd_work);
@@ -1000,7 +1003,7 @@ static void amdgpu_dm_fbc_init(struct drm_connector *connector)
 			    &compressor->gpu_addr, &compressor->cpu_addr);
 
 		if (r)
-			DRM_ERROR("DM: Failed to initialize FBC\n");
+			drm_err(adev->dm.ddev, "DM: Failed to initialize FBC\n");
 		else {
 			adev->dm.dc->ctx->fbc_gpu_addr = compressor->gpu_addr;
 			DRM_INFO("DM: FBC alloc %lu\n", max_size*4);
@@ -1166,13 +1169,13 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 		return 0;
 
 	if (!fb_info) {
-		DRM_ERROR("No framebuffer info for DMUB service.\n");
+		drm_err(adev->dm.ddev, "No framebuffer info for DMUB service.\n");
 		return -EINVAL;
 	}
 
 	if (!dmub_fw) {
 		/* Firmware required for DMUB support. */
-		DRM_ERROR("No firmware provided for DMUB.\n");
+		drm_err(adev->dm.ddev, "No firmware provided for DMUB.\n");
 		return -EINVAL;
 	}
 
@@ -1182,19 +1185,19 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 
 	status = dmub_srv_has_hw_support(dmub_srv, &has_hw_support);
 	if (status != DMUB_STATUS_OK) {
-		DRM_ERROR("Error checking HW support for DMUB: %d\n", status);
+		drm_err(adev->dm.ddev, "Error checking HW support for DMUB: %d\n", status);
 		return -EINVAL;
 	}
 
 	if (!has_hw_support) {
-		DRM_INFO("DMUB unsupported on ASIC\n");
+		drm_info(adev->dm.ddev, "DMUB unsupported on ASIC\n");
 		return 0;
 	}
 
 	/* Reset DMCUB if it was previously running - before we overwrite its memory. */
 	status = dmub_srv_hw_reset(dmub_srv);
 	if (status != DMUB_STATUS_OK)
-		DRM_WARN("Error resetting DMUB HW: %d\n", status);
+		drm_warn(adev->dm.ddev, "Error resetting DMUB HW: %d\n", status);
 
 	hdr = (const struct dmcub_firmware_header_v1_0 *)dmub_fw->data;
 
@@ -1282,7 +1285,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 
 	status = dmub_srv_hw_init(dmub_srv, &hw_params);
 	if (status != DMUB_STATUS_OK) {
-		DRM_ERROR("Error initializing DMUB HW: %d\n", status);
+		drm_err(adev->dm.ddev, "Error initializing DMUB HW: %d\n", status);
 		return -EINVAL;
 	}
 
@@ -1300,7 +1303,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	if (!adev->dm.dc->ctx->dmub_srv)
 		adev->dm.dc->ctx->dmub_srv = dc_dmub_srv_create(adev->dm.dc, dmub_srv);
 	if (!adev->dm.dc->ctx->dmub_srv) {
-		DRM_ERROR("Couldn't allocate DC DMUB server!\n");
+		drm_err(adev->dm.ddev, "Couldn't allocate DC DMUB server!\n");
 		return -ENOMEM;
 	}
 
@@ -1470,7 +1473,7 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 	aconnector = offload_work->offload_wq->aconnector;
 
 	if (!aconnector) {
-		DRM_ERROR("Can't retrieve aconnector in hpd_rx_irq_offload_work");
+		drm_err(adev->dm.ddev, "Can't retrieve aconnector in hpd_rx_irq_offload_work");
 		goto skip;
 	}
 
@@ -1479,7 +1482,7 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 
 	mutex_lock(&aconnector->hpd_lock);
 	if (!dc_link_detect_connection_type(dc_link, &new_connection_type))
-		DRM_ERROR("KMS: Failed to detect connector\n");
+		drm_err(adev->dm.ddev, "KMS: Failed to detect connector\n");
 	mutex_unlock(&aconnector->hpd_lock);
 
 	if (new_connection_type == dc_connection_none)
@@ -1548,7 +1551,8 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 
 }
 
-static struct hpd_rx_irq_offload_work_queue *hpd_rx_irq_create_workqueue(struct dc *dc)
+static struct hpd_rx_irq_offload_work_queue *hpd_rx_irq_create_workqueue(struct drm_device *drm,
+									 struct dc *dc)
 {
 	int max_caps = dc->caps.max_links;
 	int i = 0;
@@ -1565,7 +1569,7 @@ static struct hpd_rx_irq_offload_work_queue *hpd_rx_irq_create_workqueue(struct
 				    create_singlethread_workqueue("amdgpu_dm_hpd_rx_offload_wq");
 
 		if (hpd_rx_offload_wq[i].wq == NULL) {
-			DRM_ERROR("create amdgpu_dm_hpd_rx_offload_wq fail!");
+			drm_err(drm, "create amdgpu_dm_hpd_rx_offload_wq fail!");
 			goto out_err;
 		}
 
@@ -1879,7 +1883,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	mutex_init(&adev->dm.audio_lock);
 
 	if (amdgpu_dm_irq_init(adev)) {
-		DRM_ERROR("amdgpu: failed to initialize DM IRQ support.\n");
+		drm_err(adev->dm.ddev, "amdgpu: failed to initialize DM IRQ support.\n");
 		goto error;
 	}
 
@@ -1964,7 +1968,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_device_seamless_boot_supported(adev)) {
 		init_data.flags.seamless_boot_edp_requested = true;
 		init_data.flags.allow_seamless_boot_optimization = true;
-		DRM_INFO("Seamless boot condition check passed\n");
+		drm_info(adev_to_drm(adev), "Seamless boot condition check passed\n");
 	}
 
 	init_data.flags.enable_mipi_converter_optimization = true;
@@ -2001,10 +2005,13 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev->dm.dc = dc_create(&init_data);
 
 	if (adev->dm.dc) {
-		DRM_INFO("Display Core v%s initialized on %s\n", DC_VER,
-			 dce_version_to_string(adev->dm.dc->ctx->dce_version));
+		drm_info(adev_to_drm(adev),
+			"Display Core v%s initialized on %s\n",
+			DC_VER, dce_version_to_string(adev->dm.dc->ctx->dce_version));
 	} else {
-		DRM_INFO("Display Core failed to initialize with v%s!\n", DC_VER);
+		drm_err(adev_to_drm(adev),
+			"Display Core failed to initialize with v%s!\n",
+			DC_VER);
 		goto error;
 	}
 
@@ -2041,19 +2048,21 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev->dm.dc->debug.ignore_cable_id = true;
 
 	if (adev->dm.dc->caps.dp_hdmi21_pcon_support)
-		DRM_INFO("DP-HDMI FRL PCON supported\n");
+		drm_info(adev_to_drm(adev), "DP-HDMI FRL PCON supported\n");
 
 	r = dm_dmub_hw_init(adev);
 	if (r) {
-		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
+		drm_err(adev_to_drm(adev),
+			"DMUB interface failed to initialize: status=%d\n", r);
 		goto error;
 	}
 
 	dc_hardware_init(adev->dm.dc);
 
-	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev->dm.dc);
+	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev_to_drm(adev), adev->dm.dc);
 	if (!adev->dm.hpd_rx_offload_wq) {
-		DRM_ERROR("amdgpu: failed to create hpd rx offload workqueue.\n");
+		drm_err(adev_to_drm(adev),
+			"amdgpu: failed to create hpd rx offload workqueue.\n");
 		goto error;
 	}
 
@@ -2068,11 +2077,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	adev->dm.freesync_module = mod_freesync_create(adev->dm.dc);
 	if (!adev->dm.freesync_module) {
-		DRM_ERROR(
-		"amdgpu: failed to initialize freesync_module.\n");
+		drm_err(adev_to_drm(adev),
+			"amdgpu: failed to initialize freesync_module.\n");
 	} else
-		DRM_DEBUG_DRIVER("amdgpu: freesync_module init done %p.\n",
-				adev->dm.freesync_module);
+		drm_dbg(adev_to_drm(adev),
+			"amdgpu: freesync_module init done %p.\n",
+			adev->dm.freesync_module);
 
 	amdgpu_dm_init_color_mod();
 
@@ -2080,7 +2090,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		adev->dm.vblank_control_workqueue =
 			create_singlethread_workqueue("dm_vblank_control_workqueue");
 		if (!adev->dm.vblank_control_workqueue)
-			DRM_ERROR("amdgpu: failed to initialize vblank_workqueue.\n");
+			drm_err(adev_to_drm(adev),
+				"amdgpu: failed to initialize vblank_workqueue.\n");
 	}
 
 	if (adev->dm.dc->caps.ips_support &&
@@ -2091,9 +2102,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		adev->dm.hdcp_workqueue = hdcp_create_workqueue(adev, &init_params.cp_psp, adev->dm.dc);
 
 		if (!adev->dm.hdcp_workqueue)
-			DRM_ERROR("amdgpu: failed to initialize hdcp_workqueue.\n");
+			drm_err(adev_to_drm(adev),
+				"amdgpu: failed to initialize hdcp_workqueue.\n");
 		else
-			DRM_DEBUG_DRIVER("amdgpu: hdcp_workqueue init done %p.\n", adev->dm.hdcp_workqueue);
+			drm_dbg(adev_to_drm(adev),
+				"amdgpu: hdcp_workqueue init done %p.\n", adev->dm.hdcp_workqueue);
 
 		dc_init_callbacks(adev->dm.dc, &init_params);
 	}
@@ -2101,20 +2114,23 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		init_completion(&adev->dm.dmub_aux_transfer_done);
 		adev->dm.dmub_notify = kzalloc(sizeof(struct dmub_notification), GFP_KERNEL);
 		if (!adev->dm.dmub_notify) {
-			DRM_INFO("amdgpu: fail to allocate adev->dm.dmub_notify");
+			drm_info(adev_to_drm(adev),
+				"amdgpu: fail to allocate adev->dm.dmub_notify");
 			goto error;
 		}
 
 		adev->dm.delayed_hpd_wq = create_singlethread_workqueue("amdgpu_dm_hpd_wq");
 		if (!adev->dm.delayed_hpd_wq) {
-			DRM_ERROR("amdgpu: failed to create hpd offload workqueue.\n");
+			drm_err(adev_to_drm(adev),
+				"amdgpu: failed to create hpd offload workqueue.\n");
 			goto error;
 		}
 
 		amdgpu_dm_outbox_init(adev);
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_AUX_REPLY,
 			dmub_aux_setconfig_callback, false)) {
-			DRM_ERROR("amdgpu: fail to register dmub aux callback");
+			drm_err(adev_to_drm(adev),
+				"amdgpu: fail to register dmub aux callback");
 			goto error;
 		}
 		/* Enable outbox notification only after IRQ handlers are registered and DMUB is alive.
@@ -2131,7 +2147,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_dm_initialize_drm_device(adev)) {
-		DRM_ERROR(
+		drm_err(adev_to_drm(adev),
 		"amdgpu: failed to initialize sw for display support.\n");
 		goto error;
 	}
@@ -2146,7 +2162,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev_to_drm(adev)->mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
 
 	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
-		DRM_ERROR(
+		drm_err(adev_to_drm(adev),
 		"amdgpu: failed to initialize sw for display support.\n");
 		goto error;
 	}
@@ -2154,7 +2170,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	adev->dm.secure_display_ctxs = amdgpu_dm_crtc_secure_display_create_contexts(adev);
 	if (!adev->dm.secure_display_ctxs)
-		DRM_ERROR("amdgpu: failed to initialize secure display contexts.\n");
+		drm_err(adev_to_drm(adev), "amdgpu: failed to initialize secure display contexts.\n");
 #endif
 
 	DRM_DEBUG_DRIVER("KMS initialized.\n");
@@ -2331,7 +2347,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		default:
 			break;
 		}
-		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
+		drm_err(adev->dm.ddev, "Unsupported ASIC type: 0x%X\n", adev->asic_type);
 		return -EINVAL;
 	}
 
@@ -2479,7 +2495,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	dmub_srv = adev->dm.dmub_srv;
 
 	if (!dmub_srv) {
-		DRM_ERROR("Failed to allocate DMUB service!\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate DMUB service!\n");
 		return -ENOMEM;
 	}
 
@@ -2492,7 +2508,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	/* Create the DMUB service. */
 	status = dmub_srv_create(dmub_srv, &create_params);
 	if (status != DMUB_STATUS_OK) {
-		DRM_ERROR("Error creating DMUB service: %d\n", status);
+		drm_err(adev_to_drm(adev), "Error creating DMUB service: %d\n", status);
 		return -EINVAL;
 	}
 
@@ -2517,7 +2533,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 					   &region_info);
 
 	if (status != DMUB_STATUS_OK) {
-		DRM_ERROR("Error calculating DMUB region info: %d\n", status);
+		drm_err(adev_to_drm(adev), "Error calculating DMUB region info: %d\n", status);
 		return -EINVAL;
 	}
 
@@ -2546,14 +2562,14 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
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
 
@@ -2570,7 +2586,7 @@ static int dm_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->dm.cgs_device = amdgpu_cgs_create_device(adev);
 
 	if (!adev->dm.cgs_device) {
-		DRM_ERROR("amdgpu: failed to create cgs device.\n");
+		drm_err(adev_to_drm(adev), "amdgpu: failed to create cgs device.\n");
 		return -EINVAL;
 	}
 
@@ -2834,7 +2850,7 @@ static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
 
 	ret = amdgpu_dpm_write_watermarks_table(adev);
 	if (ret) {
-		DRM_ERROR("Failed to update WMTABLE!\n");
+		drm_err(adev->dm.ddev, "Failed to update WMTABLE!\n");
 		return ret;
 	}
 
@@ -2911,7 +2927,8 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
 			rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
 			if (rc)
-				DRM_WARN("Failed to %s pflip interrupts\n",
+				drm_warn(adev_to_drm(adev),
+					"Failed to %s pflip interrupts\n",
 					 enable ? "enable" : "disable");
 
 			if (enable) {
@@ -2921,14 +2938,18 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 				rc = amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, false);
 
 			if (rc)
-				DRM_WARN("Failed to %sable vupdate interrupt\n", enable ? "en" : "dis");
+				drm_warn(adev_to_drm(adev),
+					"Failed to %sable vupdate interrupt\n",
+					enable ? "en" : "dis");
 
 			irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
 			/* During gpu-reset we disable and then enable vblank irq, so
 			 * don't use amdgpu_irq_get/put() to avoid refcount change.
 			 */
 			if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
-				DRM_WARN("Failed to %sable vblank interrupt\n", enable ? "en" : "dis");
+				drm_warn(adev_to_drm(adev),
+					"Failed to %sable vblank interrupt\n",
+					enable ? "en" : "dis");
 		}
 	}
 
@@ -3224,7 +3245,8 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 		r = dm_dmub_hw_init(adev);
 		if (r)
-			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
+			drm_err(adev->dm.ddev,
+				"DMUB interface failed to initialize: status=%d\n", r);
 
 		dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D0);
 		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
@@ -3315,7 +3337,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 		mutex_lock(&aconnector->hpd_lock);
 		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
-			DRM_ERROR("KMS: Failed to detect connector\n");
+			drm_err(adev->dm.ddev, "KMS: Failed to detect connector\n");
 
 		if (aconnector->base.force && new_connection_type == dc_connection_none) {
 			emulated_link_detect(aconnector->dc_link);
@@ -3674,7 +3696,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	aconnector->timing_changed = false;
 
 	if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
-		DRM_ERROR("KMS: Failed to detect connector\n");
+		drm_err(adev->dm.ddev, "KMS: Failed to detect connector\n");
 
 	if (aconnector->base.force && new_connection_type == dc_connection_none) {
 		emulated_link_detect(aconnector->dc_link);
@@ -3718,9 +3740,10 @@ static void schedule_hpd_rx_offload_work(struct hpd_rx_irq_offload_work_queue *o
 {
 	struct hpd_rx_irq_offload_work *offload_work =
 				kzalloc(sizeof(*offload_work), GFP_KERNEL);
+	struct drm_connector *conn_base = &offload_wq->aconnector->base;
 
 	if (!offload_work) {
-		DRM_ERROR("Failed to allocate hpd_rx_irq_offload_work.\n");
+		drm_err(conn_base->dev, "Failed to allocate hpd_rx_irq_offload_work.\n");
 		return;
 	}
 
@@ -3729,7 +3752,7 @@ static void schedule_hpd_rx_offload_work(struct hpd_rx_irq_offload_work_queue *o
 	offload_work->offload_wq = offload_wq;
 
 	queue_work(offload_wq->wq, &offload_work->work);
-	DRM_DEBUG_KMS("queue work to handle hpd_rx offload work");
+	drm_dbg_kms(conn_base->dev, "queue work to handle hpd_rx offload work");
 }
 
 static void handle_hpd_rx_irq(void *param)
@@ -3817,7 +3840,7 @@ static void handle_hpd_rx_irq(void *param)
 	if (result && !is_mst_root_connector) {
 		/* Downstream Port status changed. */
 		if (!dc_link_detect_connection_type(dc_link, &new_connection_type))
-			DRM_ERROR("KMS: Failed to detect connector\n");
+			drm_err(adev->dm.ddev, "KMS: Failed to detect connector\n");
 
 		if (aconnector->base.force && new_connection_type == dc_connection_none) {
 			emulated_link_detect(dc_link);
@@ -3880,19 +3903,19 @@ static int register_hpd_handlers(struct amdgpu_device *adev)
 	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD,
 			dmub_hpd_callback, true)) {
-			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
+			drm_err(adev->dm.ddev, "amdgpu: fail to register dmub hpd callback");
 			return -EINVAL;
 		}
 
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_IRQ,
 			dmub_hpd_callback, true)) {
-			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
+			drm_err(adev->dm.ddev, "amdgpu: fail to register dmub hpd callback");
 			return -EINVAL;
 		}
 
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_SENSE_NOTIFY,
 			dmub_hpd_sense_callback, true)) {
-			DRM_ERROR("amdgpu: fail to register dmub hpd sense callback");
+			drm_err(adev->dm.ddev, "amdgpu: fail to register dmub hpd sense callback");
 			return -EINVAL;
 		}
 	}
@@ -3913,7 +3936,7 @@ static int register_hpd_handlers(struct amdgpu_device *adev)
 			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 				int_params.irq_source  < DC_IRQ_SOURCE_HPD1 ||
 				int_params.irq_source  > DC_IRQ_SOURCE_HPD6) {
-				DRM_ERROR("Failed to register hpd irq!\n");
+				drm_err(adev->dm.ddev, "Failed to register hpd irq!\n");
 				return -EINVAL;
 			}
 
@@ -3931,7 +3954,7 @@ static int register_hpd_handlers(struct amdgpu_device *adev)
 			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 				int_params.irq_source  < DC_IRQ_SOURCE_HPD1RX ||
 				int_params.irq_source  > DC_IRQ_SOURCE_HPD6RX) {
-				DRM_ERROR("Failed to register hpd rx irq!\n");
+				drm_err(adev->dm.ddev, "Failed to register hpd rx irq!\n");
 				return -EINVAL;
 			}
 
@@ -3973,7 +3996,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
 		r = amdgpu_irq_add_id(adev, client_id, i + 1, &adev->crtc_irq);
 		if (r) {
-			DRM_ERROR("Failed to add crtc irq id!\n");
+			drm_err(adev->dm.ddev, "Failed to add crtc irq id!\n");
 			return r;
 		}
 
@@ -3984,7 +4007,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
 			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
-			DRM_ERROR("Failed to register vblank irq!\n");
+			drm_err(adev->dm.ddev, "Failed to register vblank irq!\n");
 			return -EINVAL;
 		}
 
@@ -4003,7 +4026,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 			i <= VISLANDS30_IV_SRCID_D6_GRPH_PFLIP; i += 2) {
 		r = amdgpu_irq_add_id(adev, client_id, i, &adev->pageflip_irq);
 		if (r) {
-			DRM_ERROR("Failed to add page flip irq id!\n");
+			drm_err(adev->dm.ddev, "Failed to add page flip irq id!\n");
 			return r;
 		}
 
@@ -4014,7 +4037,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
 			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
-			DRM_ERROR("Failed to register pflip irq!\n");
+			drm_err(adev->dm.ddev, "Failed to register pflip irq!\n");
 			return -EINVAL;
 		}
 
@@ -4032,7 +4055,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 	r = amdgpu_irq_add_id(adev, client_id,
 			VISLANDS30_IV_SRCID_HOTPLUG_DETECT_A, &adev->hpd_irq);
 	if (r) {
-		DRM_ERROR("Failed to add hpd irq id!\n");
+		drm_err(adev->dm.ddev, "Failed to add hpd irq id!\n");
 		return r;
 	}
 
@@ -4074,7 +4097,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	for (i = VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0; i <= VISLANDS30_IV_SRCID_D6_VERTICAL_INTERRUPT0; i++) {
 		r = amdgpu_irq_add_id(adev, client_id, i, &adev->crtc_irq);
 		if (r) {
-			DRM_ERROR("Failed to add crtc irq id!\n");
+			drm_err(adev->dm.ddev, "Failed to add crtc irq id!\n");
 			return r;
 		}
 
@@ -4085,7 +4108,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
 			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
-			DRM_ERROR("Failed to register vblank irq!\n");
+			drm_err(adev->dm.ddev, "Failed to register vblank irq!\n");
 			return -EINVAL;
 		}
 
@@ -4103,7 +4126,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	for (i = VISLANDS30_IV_SRCID_D1_V_UPDATE_INT; i <= VISLANDS30_IV_SRCID_D6_V_UPDATE_INT; i += 2) {
 		r = amdgpu_irq_add_id(adev, client_id, i, &adev->vupdate_irq);
 		if (r) {
-			DRM_ERROR("Failed to add vupdate irq id!\n");
+			drm_err(adev->dm.ddev, "Failed to add vupdate irq id!\n");
 			return r;
 		}
 
@@ -4114,7 +4137,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
 			int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
-			DRM_ERROR("Failed to register vupdate irq!\n");
+			drm_err(adev->dm.ddev, "Failed to register vupdate irq!\n");
 			return -EINVAL;
 		}
 
@@ -4133,7 +4156,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 			i <= VISLANDS30_IV_SRCID_D6_GRPH_PFLIP; i += 2) {
 		r = amdgpu_irq_add_id(adev, client_id, i, &adev->pageflip_irq);
 		if (r) {
-			DRM_ERROR("Failed to add page flip irq id!\n");
+			drm_err(adev->dm.ddev, "Failed to add page flip irq id!\n");
 			return r;
 		}
 
@@ -4144,7 +4167,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
 			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
-			DRM_ERROR("Failed to register pflip irq!\n");
+			drm_err(adev->dm.ddev, "Failed to register pflip irq!\n");
 			return -EINVAL;
 		}
 
@@ -4162,7 +4185,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	r = amdgpu_irq_add_id(adev, client_id,
 			VISLANDS30_IV_SRCID_HOTPLUG_DETECT_A, &adev->hpd_irq);
 	if (r) {
-		DRM_ERROR("Failed to add hpd irq id!\n");
+		drm_err(adev->dm.ddev, "Failed to add hpd irq id!\n");
 		return r;
 	}
 
@@ -4212,7 +4235,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->crtc_irq);
 
 		if (r) {
-			DRM_ERROR("Failed to add crtc irq id!\n");
+			drm_err(adev->dm.ddev, "Failed to add crtc irq id!\n");
 			return r;
 		}
 
@@ -4223,7 +4246,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
 			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
-			DRM_ERROR("Failed to register vblank irq!\n");
+			drm_err(adev->dm.ddev, "Failed to register vblank irq!\n");
 			return -EINVAL;
 		}
 
@@ -4244,7 +4267,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 				vrtl_int_srcid[i], &adev->vline0_irq);
 
 		if (r) {
-			DRM_ERROR("Failed to add vline0 irq id!\n");
+			drm_err(adev->dm.ddev, "Failed to add vline0 irq id!\n");
 			return r;
 		}
 
@@ -4255,7 +4278,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source < DC_IRQ_SOURCE_DC1_VLINE0 ||
 			int_params.irq_source > DC_IRQ_SOURCE_DC6_VLINE0) {
-			DRM_ERROR("Failed to register vline0 irq!\n");
+			drm_err(adev->dm.ddev, "Failed to register vline0 irq!\n");
 			return -EINVAL;
 		}
 
@@ -4283,7 +4306,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->vupdate_irq);
 
 		if (r) {
-			DRM_ERROR("Failed to add vupdate irq id!\n");
+			drm_err(adev->dm.ddev, "Failed to add vupdate irq id!\n");
 			return r;
 		}
 
@@ -4294,7 +4317,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
 			int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
-			DRM_ERROR("Failed to register vupdate irq!\n");
+			drm_err(adev->dm.ddev, "Failed to register vupdate irq!\n");
 			return -EINVAL;
 		}
 
@@ -4314,7 +4337,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 			i++) {
 		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->pageflip_irq);
 		if (r) {
-			DRM_ERROR("Failed to add page flip irq id!\n");
+			drm_err(adev->dm.ddev, "Failed to add page flip irq id!\n");
 			return r;
 		}
 
@@ -4325,7 +4348,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
 			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
-			DRM_ERROR("Failed to register pflip irq!\n");
+			drm_err(adev->dm.ddev, "Failed to register pflip irq!\n");
 			return -EINVAL;
 		}
 
@@ -4343,7 +4366,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DC_HPD1_INT,
 			&adev->hpd_irq);
 	if (r) {
-		DRM_ERROR("Failed to add hpd irq id!\n");
+		drm_err(adev->dm.ddev, "Failed to add hpd irq id!\n");
 		return r;
 	}
 
@@ -4365,7 +4388,7 @@ static int register_outbox_irq_handlers(struct amdgpu_device *adev)
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT,
 			&adev->dmub_outbox_irq);
 	if (r) {
-		DRM_ERROR("Failed to add outbox irq id!\n");
+		drm_err(adev->dm.ddev, "Failed to add outbox irq id!\n");
 		return r;
 	}
 
@@ -4560,7 +4583,7 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 		    caps.min_input_signal < 0 ||
 		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
 		    spread < AMDGPU_DM_MIN_SPREAD) {
-			DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
+			drm_dbg_kms(dm->ddev, "DM: Invalid backlight caps: min=%d, max=%d\n",
 				      caps.min_input_signal, caps.max_input_signal);
 			caps.caps_valid = false;
 		}
@@ -4663,7 +4686,8 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 		rc = dc_link_set_backlight_level_nits(link, true, brightness,
 						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
 		if (!rc)
-			DRM_DEBUG("DM: Failed to update backlight via AUX on eDP[%d]\n", bl_idx);
+			drm_dbg(dm->ddev, "DM: Failed to update backlight via AUX on eDP[%d]\n",
+				bl_idx);
 	} else {
 		struct set_backlight_level_params backlight_level_params = { 0 };
 
@@ -4672,7 +4696,8 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 
 		rc = dc_link_set_backlight_level(link, &backlight_level_params);
 		if (!rc)
-			DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", bl_idx);
+			drm_dbg(dm->ddev, "DM: Failed to update backlight on eDP[%d]\n",
+				bl_idx);
 	}
 
 	if (dm->dc->caps.ips_support && reallow_idle)
@@ -4787,10 +4812,10 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 					  &amdgpu_dm_backlight_ops, &props);
 
 	if (IS_ERR(dm->backlight_dev[aconnector->bl_idx])) {
-		DRM_ERROR("DM: Backlight registration failed!\n");
+		drm_err(drm, "DM: Backlight registration failed!\n");
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
 	} else
-		DRM_DEBUG_DRIVER("DM: Registered Backlight device: %s\n", bl_name);
+		drm_dbg_kms(drm, "DM: Registered Backlight device: %s\n", bl_name);
 }
 
 static int initialize_plane(struct amdgpu_display_manager *dm,
@@ -4804,7 +4829,7 @@ static int initialize_plane(struct amdgpu_display_manager *dm,
 
 	plane = kzalloc(sizeof(struct drm_plane), GFP_KERNEL);
 	if (!plane) {
-		DRM_ERROR("KMS: Failed to allocate plane\n");
+		drm_err(dm->ddev, "KMS: Failed to allocate plane\n");
 		return -ENOMEM;
 	}
 	plane->type = plane_type;
@@ -4822,7 +4847,7 @@ static int initialize_plane(struct amdgpu_display_manager *dm,
 	ret = amdgpu_dm_plane_init(dm, plane, possible_crtcs, plane_cap);
 
 	if (ret) {
-		DRM_ERROR("KMS: Failed to initialize plane\n");
+		drm_err(dm->ddev, "KMS: Failed to initialize plane\n");
 		kfree(plane);
 		return ret;
 	}
@@ -4892,14 +4917,14 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 	link_cnt = dm->dc->caps.max_links;
 	if (amdgpu_dm_mode_config_init(dm->adev)) {
-		DRM_ERROR("DM: Failed to initialize mode config\n");
+		drm_err(adev->dm.ddev, "DM: Failed to initialize mode config\n");
 		return -EINVAL;
 	}
 
 	/* There is one primary plane per CRTC */
 	primary_planes = dm->dc->caps.max_streams;
 	if (primary_planes > AMDGPU_MAX_PLANES) {
-		DRM_ERROR("DM: Plane nums out of 6 planes\n");
+		drm_err(adev->dm.ddev, "DM: Plane nums out of 6 planes\n");
 		return -EINVAL;
 	}
 
@@ -4912,7 +4937,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 		if (initialize_plane(dm, mode_info, i,
 				     DRM_PLANE_TYPE_PRIMARY, plane)) {
-			DRM_ERROR("KMS: Failed to initialize primary plane\n");
+			drm_err(adev->dm.ddev, "KMS: Failed to initialize primary plane\n");
 			goto fail;
 		}
 	}
@@ -4944,14 +4969,14 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 		if (initialize_plane(dm, NULL, primary_planes + i,
 				     DRM_PLANE_TYPE_OVERLAY, plane)) {
-			DRM_ERROR("KMS: Failed to initialize overlay plane\n");
+			drm_err(adev->dm.ddev, "KMS: Failed to initialize overlay plane\n");
 			goto fail;
 		}
 	}
 
 	for (i = 0; i < dm->dc->caps.max_streams; i++)
 		if (amdgpu_dm_crtc_init(dm, mode_info->planes[i], i)) {
-			DRM_ERROR("KMS: Failed to initialize crtc\n");
+			drm_err(adev->dm.ddev, "KMS: Failed to initialize crtc\n");
 			goto fail;
 		}
 
@@ -4970,12 +4995,12 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case IP_VERSION(3, 5, 1):
 	case IP_VERSION(4, 0, 1):
 		if (register_outbox_irq_handlers(dm->adev)) {
-			DRM_ERROR("DM: Failed to initialize IRQ\n");
+			drm_err(adev->dm.ddev, "DM: Failed to initialize IRQ\n");
 			goto fail;
 		}
 		break;
 	default:
-		DRM_DEBUG_KMS("Unsupported DCN IP version for outbox: 0x%X\n",
+		drm_dbg_kms(adev->dm.ddev, "Unsupported DCN IP version for outbox: 0x%X\n",
 			      amdgpu_ip_version(adev, DCE_HWIP, 0));
 	}
 
@@ -5018,7 +5043,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	}
 
 	if (link_cnt > MAX_LINKS) {
-		DRM_ERROR(
+		drm_err(adev->dm.ddev,
 			"KMS: Cannot support more than %d display indexes\n",
 				MAX_LINKS);
 		goto fail;
@@ -5034,12 +5059,12 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			struct amdgpu_dm_wb_connector *wbcon = kzalloc(sizeof(*wbcon), GFP_KERNEL);
 
 			if (!wbcon) {
-				DRM_ERROR("KMS: Failed to allocate writeback connector\n");
+				drm_err(adev->dm.ddev, "KMS: Failed to allocate writeback connector\n");
 				continue;
 			}
 
 			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
-				DRM_ERROR("KMS: Failed to initialize writeback connector\n");
+				drm_err(adev->dm.ddev, "KMS: Failed to initialize writeback connector\n");
 				kfree(wbcon);
 				continue;
 			}
@@ -5059,12 +5084,12 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 
 		if (amdgpu_dm_encoder_init(dm->ddev, aencoder, i)) {
-			DRM_ERROR("KMS: Failed to initialize encoder\n");
+			drm_err(adev->dm.ddev, "KMS: Failed to initialize encoder\n");
 			goto fail;
 		}
 
 		if (amdgpu_dm_connector_init(dm, aconnector, i, aencoder)) {
-			DRM_ERROR("KMS: Failed to initialize connector\n");
+			drm_err(adev->dm.ddev, "KMS: Failed to initialize connector\n");
 			goto fail;
 		}
 
@@ -5073,7 +5098,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 				aconnector;
 
 		if (!dc_link_detect_connection_type(link, &new_connection_type))
-			DRM_ERROR("KMS: Failed to detect connector\n");
+			drm_err(adev->dm.ddev, "KMS: Failed to detect connector\n");
 
 		if (aconnector->base.force && new_connection_type == dc_connection_none) {
 			emulated_link_detect(link);
@@ -5110,7 +5135,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case CHIP_VERDE:
 	case CHIP_OLAND:
 		if (dce60_register_irq_handlers(dm->adev)) {
-			DRM_ERROR("DM: Failed to initialize IRQ\n");
+			drm_err(adev->dm.ddev, "DM: Failed to initialize IRQ\n");
 			goto fail;
 		}
 		break;
@@ -5132,7 +5157,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
 		if (dce110_register_irq_handlers(dm->adev)) {
-			DRM_ERROR("DM: Failed to initialize IRQ\n");
+			drm_err(adev->dm.ddev, "DM: Failed to initialize IRQ\n");
 			goto fail;
 		}
 		break;
@@ -5159,12 +5184,12 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 5, 1):
 		case IP_VERSION(4, 0, 1):
 			if (dcn10_register_irq_handlers(dm->adev)) {
-				DRM_ERROR("DM: Failed to initialize IRQ\n");
+				drm_err(adev->dm.ddev, "DM: Failed to initialize IRQ\n");
 				goto fail;
 			}
 			break;
 		default:
-			DRM_ERROR("Unsupported DCE IP versions: 0x%X\n",
+			drm_err(adev->dm.ddev, "Unsupported DCE IP versions: 0x%X\n",
 					amdgpu_ip_version(adev, DCE_HWIP, 0));
 			goto fail;
 		}
@@ -5433,7 +5458,7 @@ static int dm_early_init(struct amdgpu_ip_block *ip_block)
 			adev->mode_info.num_dig = 4;
 			break;
 		default:
-			DRM_ERROR("Unsupported DCE IP versions: 0x%x\n",
+			drm_err(adev->dm.ddev, "Unsupported DCE IP versions: 0x%x\n",
 					amdgpu_ip_version(adev, DCE_HWIP, 0));
 			return -EINVAL;
 		}
@@ -5583,7 +5608,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616;
 		break;
 	default:
-		DRM_ERROR(
+		drm_err(adev->dm.ddev,
 			"Unsupported screen format %p4cc\n",
 			&fb->format->format);
 		return -EINVAL;
@@ -6278,7 +6303,7 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 }
 
 static struct dc_sink *
-create_fake_sink(struct dc_link *link)
+create_fake_sink(struct drm_connector *connector, struct dc_link *link)
 {
 	struct dc_sink_init_data sink_init_data = { 0 };
 	struct dc_sink *sink = NULL;
@@ -6288,7 +6313,7 @@ create_fake_sink(struct dc_link *link)
 
 	sink = dc_sink_create(&sink_init_data);
 	if (!sink) {
-		DRM_ERROR("Failed to create sink!\n");
+		drm_err(connector->dev, "Failed to create sink!\n");
 		return NULL;
 	}
 	sink->sink_signal = SIGNAL_TYPE_VIRTUAL;
@@ -6396,6 +6421,7 @@ static struct drm_display_mode *
 get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 		bool use_probed_modes)
 {
+	struct drm_connector *conn_base = &aconnector->base;
 	struct drm_display_mode *m, *m_pref = NULL;
 	u16 current_refresh, highest_refresh;
 	struct list_head *list_head = use_probed_modes ?
@@ -6421,7 +6447,7 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 		m_pref = list_first_entry_or_null(
 				&aconnector->base.modes, struct drm_display_mode, head);
 		if (!m_pref) {
-			DRM_DEBUG_DRIVER("No preferred mode found in EDID\n");
+			drm_dbg(conn_base->dev, "No preferred mode found in EDID\n");
 			return NULL;
 		}
 	}
@@ -6569,6 +6595,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 	u32 max_dsc_target_bpp_limit_override =
 		drm_connector->display_info.max_dsc_bpp;
 	struct dc_dsc_config_options dsc_options = {0};
+	struct drm_connector *connector = &aconnector->base;
 
 	dc_dsc_get_default_config_option(dc, &dsc_options);
 	dsc_options.max_target_bpp_limit_override_x16 = max_dsc_target_bpp_limit_override * 16;
@@ -6596,7 +6623,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 						dc_link_get_highest_encoding_format(aconnector->dc_link),
 						&stream->timing.dsc_cfg)) {
 				stream->timing.flags.DSC = 1;
-				DRM_DEBUG_DRIVER("%s: SST_DSC [%s] DSC is selected from SST RX\n",
+				drm_dbg(connector->dev, "%s: SST_DSC [%s] DSC is selected from SST RX\n",
 							__func__, drm_connector->name);
 			}
 		} else if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
@@ -6616,7 +6643,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 						dc_link_get_highest_encoding_format(aconnector->dc_link),
 						&stream->timing.dsc_cfg)) {
 					stream->timing.flags.DSC = 1;
-					DRM_DEBUG_DRIVER("%s: SST_DSC [%s] DSC is selected from DP-HDMI PCON\n",
+					drm_dbg(connector->dev, "%s: SST_DSC [%s] DSC is selected from DP-HDMI PCON\n",
 									 __func__, drm_connector->name);
 				}
 		}
@@ -6685,7 +6712,7 @@ create_stream_for_sink(struct drm_connector *connector,
 	}
 
 	if (!aconnector || !aconnector->dc_sink) {
-		sink = create_fake_sink(link);
+		sink = create_fake_sink(connector, link);
 		if (!sink)
 			return stream;
 
@@ -6697,7 +6724,7 @@ create_stream_for_sink(struct drm_connector *connector,
 	stream = dc_create_stream_for_sink(sink);
 
 	if (stream == NULL) {
-		DRM_ERROR("Failed to create stream for sink!\n");
+		drm_err(connector->dev, "Failed to create stream for sink!\n");
 		goto finish;
 	}
 
@@ -6729,7 +6756,7 @@ create_stream_for_sink(struct drm_connector *connector,
 		 * case, we call set mode ourselves to restore the previous mode
 		 * and the modelist may not be filled in time.
 		 */
-		DRM_DEBUG_DRIVER("No preferred mode found\n");
+		drm_dbg(connector->dev, "No preferred mode found\n");
 	} else if (aconnector) {
 		recalculate_timing = amdgpu_freesync_vid_mode &&
 				 is_freesync_video_mode(&mode, aconnector);
@@ -7181,7 +7208,7 @@ static void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
 	drm_edid = drm_edid_read(connector);
 	drm_edid_connector_update(connector, drm_edid);
 	if (!drm_edid) {
-		DRM_ERROR("No EDID found on connector: %s.\n", connector->name);
+		drm_err(connector->dev, "No EDID found on connector: %s.\n", connector->name);
 		return;
 	}
 
@@ -7233,7 +7260,7 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 	drm_edid = drm_edid_read(connector);
 	drm_edid_connector_update(connector, drm_edid);
 	if (!drm_edid) {
-		DRM_ERROR("No EDID found on connector: %s.\n", connector->name);
+		drm_err(connector->dev, "No EDID found on connector: %s.\n", connector->name);
 		return;
 	}
 
@@ -7363,7 +7390,7 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 						dm_state, old_stream,
 						requested_bpc);
 		if (stream == NULL) {
-			DRM_ERROR("Failed to create stream for sink!\n");
+			drm_err(connector->dev, "Failed to create stream for sink!\n");
 			break;
 		}
 
@@ -7378,7 +7405,8 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			dc_result = dm_validate_stream_and_context(adev->dm.dc, stream);
 
 		if (dc_result != DC_OK) {
-			DRM_DEBUG_KMS("Mode %dx%d (clk %d) pixel_encoding:%s color_depth:%s failed validation -- %s\n",
+			drm_dbg_kms(connector->dev,
+				    "Mode %dx%d (clk %d) pixel_encoding:%s color_depth:%s failed validation -- %s\n",
 				      drm_mode->hdisplay,
 				      drm_mode->vdisplay,
 				      drm_mode->clock,
@@ -7433,7 +7461,7 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 
 	if (dc_sink == NULL && aconnector->base.force != DRM_FORCE_ON_DIGITAL &&
 				aconnector->base.force != DRM_FORCE_ON) {
-		DRM_ERROR("dc_sink is NULL!\n");
+		drm_err(connector->dev, "dc_sink is NULL!\n");
 		goto fail;
 	}
 
@@ -8301,7 +8329,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 
 	i2c = create_i2c(link->ddc, link->link_index, &res);
 	if (!i2c) {
-		DRM_ERROR("Failed to create i2c adapter data\n");
+		drm_err(dm->ddev, "Failed to create i2c adapter data\n");
 		return -ENOMEM;
 	}
 
@@ -8309,7 +8337,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	res = i2c_add_adapter(&i2c->base);
 
 	if (res) {
-		DRM_ERROR("Failed to register hw i2c %d\n", link->link_index);
+		drm_err(dm->ddev, "Failed to register hw i2c %d\n", link->link_index);
 		goto out_free;
 	}
 
@@ -8323,7 +8351,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 			&i2c->base);
 
 	if (res) {
-		DRM_ERROR("connector_init failed\n");
+		drm_err(dm->ddev, "connector_init failed\n");
 		aconnector->connector_id = -1;
 		goto out_free;
 	}
@@ -8698,7 +8726,7 @@ static void update_freesync_state_on_stream(
 	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
 
 	if (new_crtc_state->freesync_vrr_info_changed)
-		DRM_DEBUG_KMS("VRR packet update: crtc=%u enabled=%d state=%d",
+		drm_dbg_kms(dm->ddev, "VRR packet update: crtc=%u enabled=%d state=%d",
 			      new_crtc_state->base.crtc->base.id,
 			      (int)new_crtc_state->base.vrr_enabled,
 			      (int)vrr_params.state);
@@ -8877,13 +8905,13 @@ static void amdgpu_dm_update_cursor(struct drm_plane *plane,
 	if (crtc_state->stream) {
 		if (!dc_stream_set_cursor_attributes(crtc_state->stream,
 						     &attributes))
-			DRM_ERROR("DC failed to set cursor attributes\n");
+			drm_err(adev->dm.ddev, "DC failed to set cursor attributes\n");
 
 		update->cursor_attributes = &crtc_state->stream->cursor_attributes;
 
 		if (!dc_stream_set_cursor_position(crtc_state->stream,
 						   &position))
-			DRM_ERROR("DC failed to set cursor position\n");
+			drm_err(adev->dm.ddev, "DC failed to set cursor position\n");
 
 		update->cursor_position = &crtc_state->stream->cursor_position;
 	}
@@ -9132,7 +9160,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		bundle->surface_updates[planes_count].surface = dc_plane;
 
 		if (!bundle->surface_updates[planes_count].surface) {
-			DRM_ERROR("No surface for CRTC: id=%d\n",
+			drm_err(state->dev, "No surface for CRTC: id=%d\n",
 					acrtc_attach->crtc_id);
 			continue;
 		}
@@ -9648,20 +9676,20 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 
 	wb_info = kzalloc(sizeof(*wb_info), GFP_KERNEL);
 	if (!wb_info) {
-		DRM_ERROR("Failed to allocate wb_info\n");
+		drm_err(adev->dm.ddev, "Failed to allocate wb_info\n");
 		return;
 	}
 
 	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
 	if (!acrtc) {
-		DRM_ERROR("no amdgpu_crtc found\n");
+		drm_err(adev->dm.ddev, "no amdgpu_crtc found\n");
 		kfree(wb_info);
 		return;
 	}
 
 	afb = to_amdgpu_framebuffer(new_con_state->writeback_job->fb);
 	if (!afb) {
-		DRM_ERROR("No amdgpu_framebuffer found\n");
+		drm_err(adev->dm.ddev, "No amdgpu_framebuffer found\n");
 		kfree(wb_info);
 		return;
 	}
@@ -9962,7 +9990,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		 */
 		dummy_updates = kzalloc(sizeof(struct dc_surface_update) * MAX_SURFACES, GFP_ATOMIC);
 		if (!dummy_updates) {
-			DRM_ERROR("Failed to allocate memory for dummy_updates.\n");
+			drm_err(adev->dm.ddev, "Failed to allocate memory for dummy_updates.\n");
 			continue;
 		}
 		for (j = 0; j < status->plane_count; j++)
@@ -10192,7 +10220,7 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 out:
 	drm_atomic_state_put(state);
 	if (ret)
-		DRM_ERROR("Restoring old state failed with %i\n", ret);
+		drm_err(ddev, "Restoring old state failed with %i\n", ret);
 
 	return ret;
 }
@@ -10276,8 +10304,8 @@ static int do_aquire_global_lock(struct drm_device *dev,
 					&commit->flip_done, 10*HZ);
 
 		if (ret == 0)
-			DRM_ERROR("[CRTC:%d:%s] hw_done or flip_done timed out\n",
-				  crtc->base.id, crtc->name);
+			drm_err(dev, "[CRTC:%d:%s] hw_done or flip_done timed out\n",
+				crtc->base.id, crtc->name);
 
 		drm_crtc_commit_put(commit);
 	}
@@ -11939,7 +11967,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 
 	res = dc_wake_and_execute_dmub_cmd(dm->dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY);
 	if (!res) {
-		DRM_ERROR("EDID CEA parser failed\n");
+		drm_err(dm->ddev, "EDID CEA parser failed\n");
 		return false;
 	}
 
@@ -11947,7 +11975,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 
 	if (output->type == DMUB_CMD__EDID_CEA_ACK) {
 		if (!output->ack.success) {
-			DRM_ERROR("EDID CEA ack failed at offset %d\n",
+			drm_err(dm->ddev, "EDID CEA ack failed at offset %d\n",
 					output->ack.offset);
 		}
 	} else if (output->type == DMUB_CMD__EDID_CEA_AMD_VSDB) {
@@ -11959,7 +11987,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 		vsdb->min_refresh_rate_hz = output->amd_vsdb.min_frame_rate;
 		vsdb->max_refresh_rate_hz = output->amd_vsdb.max_frame_rate;
 	} else {
-		DRM_WARN("Unknown EDID CEA parser results\n");
+		drm_warn(dm->ddev, "Unknown EDID CEA parser results\n");
 		return false;
 	}
 
@@ -12175,7 +12203,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
 
 	if (!connector->state) {
-		DRM_ERROR("%s - Connector has no state", __func__);
+		drm_err(adev->dm.ddev, "%s - Connector has no state", __func__);
 		goto update;
 	}
 
@@ -12356,7 +12384,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 	}
 
 	if (!wait_for_completion_timeout(&adev->dm.dmub_aux_transfer_done, 10 * HZ)) {
-		DRM_ERROR("wait_for_completion_timeout timeout!");
+		drm_err(adev->dm.ddev, "wait_for_completion_timeout timeout!");
 		*operation_result = AUX_RET_ERROR_TIMEOUT;
 		goto out;
 	}
@@ -12367,7 +12395,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 		 * lead to this error. We can ignore this for now.
 		 */
 		if (p_notify->result != AUX_RET_ERROR_PROTOCOL_ERROR) {
-			DRM_WARN("DPIA AUX failed on 0x%x(%d), error %d\n",
+			drm_warn(adev->dm.ddev, "DPIA AUX failed on 0x%x(%d), error %d\n",
 					payload->address, payload->length,
 					p_notify->result);
 		}
@@ -12381,7 +12409,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 			(payload->reply[0] == AUX_TRANSACTION_REPLY_AUX_ACK)) {
 
 		if (payload->length != p_notify->aux_reply.length) {
-			DRM_WARN("invalid read length %d from DPIA AUX 0x%x(%d)!\n",
+			drm_warn(adev->dm.ddev, "invalid read length %d from DPIA AUX 0x%x(%d)!\n",
 				p_notify->aux_reply.length,
 					payload->address, payload->length);
 			*operation_result = AUX_RET_ERROR_INVALID_REPLY;
@@ -12419,7 +12447,7 @@ int amdgpu_dm_process_dmub_set_config_sync(
 		ret = 0;
 		*operation_result = adev->dm.dmub_notify->sc_status;
 	} else {
-		DRM_ERROR("wait_for_completion_timeout timeout!");
+		drm_err(adev->dm.ddev, "wait_for_completion_timeout timeout!");
 		ret = -1;
 		*operation_result = SET_CONFIG_UNKNOWN_ERROR;
 	}
-- 
2.43.0

