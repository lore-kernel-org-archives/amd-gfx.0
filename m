Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E208AE7718B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7322F10F06F;
	Fri, 20 Dec 2024 21:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n3EqlgnG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AB710F073
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKR1T+bu2RYkG0j5Ej2fxKuhvKIrzNYuc8onUMI48RXGWt77dvSQgrpXo+ywqiiWbQxWX9vh51KFdoIRfDWx2JCYClMKzD+f8FLfV325LAZ/m6YwdhVV+oabrDsh9T8woej4gTDq4mOSajbL/JSYlfJ7qiopECDfMTY0WKMJhCMrsTzffG0MB/Bke2T9xyIfUAnnvwXIRUS++/MKGC15Te3lAzajXDq019QXKetpOGSTmeMasE7PNPebfNNbgOdH0FUjFPPUK1Dn+Mo203vd49BhPF1ULYC3CrEQpoWH43UOqem9Y1pxtVZg0JHnTujSOduMAgZ0bpaBEkr/VOLl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbZ7fVtzLrtXjbv2aFTtZXput9cDd91zJJCIUUP0KXI=;
 b=ePvZlft+HGOcCb2BQRnIpCm8GN/8oRNWx2CexMkgH0LXdgn/A4sOwGYH5qFbCJTnxBW3THgDo3uts8CS9ZmLVlm7uD10zc8I9Bl2fZBWsbuVHYJVli9O+qxCZDJFzp0lEgQthrAVj6YkOZV8rtWZUkELQaYbQVCC4cK5ZWAFaGo9BJpZNJjuuQ2OlaKTIyE9PaMIN6H1iY4yZtfAuEIU1Pvxg1LB6PVVTxtjVaDpbyO5TLMQ7OsGbqANYfJTm7Ot6dhse/jnEpj1f7SWef21ZwFADZcn46KCt+VrW7f4++tgXeYka9xd5Vhkq22zBerk+S7bdHtH/UixpDX+5lXt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbZ7fVtzLrtXjbv2aFTtZXput9cDd91zJJCIUUP0KXI=;
 b=n3EqlgnGT00/qCQTV/2AVpIfhOPTS1A12BP9VRG6sqrHl30Z7kdUGIAhbXGZJN4GJTx9E+7NU/UvgfvDvbk5qutC4Luwo3FfQSl8LKqJP7wGeuxY+uqXylgwyVQE1kTYFCHgN/P3hfryk+77lF03Yj53NQE5tCuC9QxcT6XLDLE=
Received: from MW2PR16CA0042.namprd16.prod.outlook.com (2603:10b6:907:1::19)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 21:51:09 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::9) by MW2PR16CA0042.outlook.office365.com
 (2603:10b6:907:1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8114.28 via Frontend Transport; Fri,
 20 Dec 2024 21:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:07 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:07 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:02 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, HaoPing Liu <haoping.liu@amd.com>
Subject: [PATCH 09/28] drm/amd/display: Adjust dm to use supported interfaces
 for setting multiple crc windows
Date: Fri, 20 Dec 2024 16:48:36 -0500
Message-ID: <20241220214855.2608618-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 96066ce1-1e2c-40cc-fa82-08dd21406989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PHd44ceeseC0z1rVPw84OmcbxqJz/SaAtxmD8KnN+3/HfzLwtEm4VVFeVddF?=
 =?us-ascii?Q?gX2W8NFvQ4ew1zeT1CrucVUVRzRma57ijPxfsE8vQzlSKf6V7HH1QD9w1TaF?=
 =?us-ascii?Q?mAVeFwNAgEpxBse8iPTpvm5G+L2mDrRb3kp2MksgYN1WVjMsR9/7lGy93Ovm?=
 =?us-ascii?Q?nkztgp2YyXgwwRqTCaUciNXgd6nodNeHZ6GrLSVjlP0g+y96TccuNmIor5YO?=
 =?us-ascii?Q?QE1Su4QjPK6rQnRFjdtz8MYlb31dodppHlCbv6E4AZ0NRonREYJNXXpaj90v?=
 =?us-ascii?Q?yQjGc0bE7sUxXhSc/LoLEw3NjQT4MkVahhVAxXCVuSmHFnE41Rlr1uZVAkrG?=
 =?us-ascii?Q?HB4xjBgfkC63fClScZDBPO2GgtVuBkJORuFw2dkolvYbSGHtxp0035iZCIYc?=
 =?us-ascii?Q?Joio0ds++rNHPf46bVjgRAWe4dr9R1VrLL77aXfuUHKQnqkzW81tkVSrwlYq?=
 =?us-ascii?Q?a+DfaF5m0qFLLjwQYbF3VISMNeW9jXHf1MT4PpjJpXwk/TwCmW9p3sKX57Q4?=
 =?us-ascii?Q?sqZvf1F9Mu/zbjBFPa1mAjJnF206313whxJvU7IbkqdhXFBxtro8VDOPH3Ai?=
 =?us-ascii?Q?J4vgdQKYgIB1iFJr1S9LRFZW1pQm6LAaJFGEdHM24mMREfyMsKBCDj62FPmL?=
 =?us-ascii?Q?cAzslqSYcza3LjT9XFJTNx7F3lMIww6nbgjsRhkTKDq2IufCNRWLEPbLztgg?=
 =?us-ascii?Q?Ntqx6f2wDhkK9u6Zl5VMv+iucbXitmzTZJ7C0kcuzWl+FS0T/j5eX+0f9Hac?=
 =?us-ascii?Q?md0ks18x2TjCWhenXq9wUS7Fwz1UcBgOmr6CYiRInyjkDrcw6QlA7plFh/bM?=
 =?us-ascii?Q?7NVcH0tnaQD1ByHnj7zrhqQhbjhJc3f3aCXGpIhH+3Uj9fepuCpfIHTEf7ug?=
 =?us-ascii?Q?UkuE2lVIejnNWj+JoZes5WbcjZmwU0QdFawLMibVUaN/aXA3GvQzUqukJIoZ?=
 =?us-ascii?Q?g2dBw0NVJs0fthfq2Rtx7kftHcQ500UpIb1xqzFtJAeyC14WMGoJD2AcZXNL?=
 =?us-ascii?Q?uP/aXyKccykfrQEvCJ374knf6ebVF9zJWKwmTlOWZnilB7NcXbJqoFYroqQa?=
 =?us-ascii?Q?KUosO4eiUU/HNwqJDOMq8/lEWOl0MAYT18f6plxoI9lOnOb3xBlncV0agKb5?=
 =?us-ascii?Q?RgJdtpq95yEjGPayHp7ySSEChev8xPw8B+3UmvTWiq8fGUv/gZKLkdJOmLAY?=
 =?us-ascii?Q?QSigNmKXY+lVqa/vtbgSQkLi9rnn3dPiwpAxpa2GfvbGFFb4XVf9yKEUS38P?=
 =?us-ascii?Q?39lMaXijmuyHM5WU6UfwopLl3jX6LEWMTambaH9G7qnzqOoZ+PNegVLUOebt?=
 =?us-ascii?Q?cu4OiXOZ2ASaGPKYG6aUudgRMv2UgAnhoaxQkZ7A22UhDZoyvgpQNknpK8jy?=
 =?us-ascii?Q?yeGPk7iCMY6GzeFTeKRX1/VDFdOAkuHO5g22ttg1mu1LKW3Pz4VGCXkkrGy/?=
 =?us-ascii?Q?GJxDjz+rLsLr2wbb+Rhl5aBFSxSxXkxwmvFTR5vjzjH3zqFTvzr+1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:08.7033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96066ce1-1e2c-40cc-fa82-08dd21406989
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
We actually have the capability to calculate independent CRC for 2 crc window
at the same time. Extend dm with the capability by having array to
configure/maintain multiple crc windows. Add the flexibility but use 1st CRC
instance only for now. Can change to use the 2nd CRC instance if needed.

Reviewed-by: HaoPing Liu <haoping.liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  23 ++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 176 +++++++++++++-----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |  23 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  31 +--
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   4 +-
 5 files changed, 185 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4f0267b2d5ad..a5fbbee955a2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2155,6 +2155,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	amdgpu_dm_crtc_secure_display_create_contexts(adev);
 	if (!adev->dm.secure_display_ctx.crtc_ctx)
 		DRM_ERROR("amdgpu: failed to initialize secure display contexts.\n");
+
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(4, 0, 1))
+		adev->dm.secure_display_ctx.support_mul_roi = true;
+
 #endif
 
 	DRM_DEBUG_DRIVER("KMS initialized.\n");
@@ -10058,14 +10062,19 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			if (amdgpu_dm_is_valid_crc_source(cur_crc_src)) {
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 				if (amdgpu_dm_crc_window_is_activated(crtc)) {
+					uint8_t cnt;
 					spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-					acrtc->dm_irq_params.window_param.update_win = true;
-
-					/**
-					 * It takes 2 frames for HW to stably generate CRC when
-					 * resuming from suspend, so we set skip_frame_cnt 2.
-					 */
-					acrtc->dm_irq_params.window_param.skip_frame_cnt = 2;
+					for (cnt = 0; cnt < MAX_CRC_WINDOW_NUM; cnt++) {
+						if (acrtc->dm_irq_params.window_param[cnt].enable) {
+							acrtc->dm_irq_params.window_param[cnt].update_win = true;
+
+							/**
+							 * It takes 2 frames for HW to stably generate CRC when
+							 * resuming from suspend, so we set skip_frame_cnt 2.
+							 */
+							acrtc->dm_irq_params.window_param[cnt].skip_frame_cnt = 2;
+						}
+					}
 					spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 				}
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 5cc84dce001d..a13cc6e67006 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -295,33 +295,41 @@ static void amdgpu_dm_set_crc_window_default(struct drm_crtc *crtc, struct dc_st
 	struct drm_device *drm_dev = crtc->dev;
 	struct amdgpu_display_manager *dm = &drm_to_adev(drm_dev)->dm;
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-	bool was_activated;
 	struct amdgpu_dm_connector *aconnector;
+	bool was_activated;
 	uint8_t phy_id;
+	unsigned long flags;
+	int i;
 
-	spin_lock_irq(&drm_dev->event_lock);
-	was_activated = acrtc->dm_irq_params.window_param.activated;
-	acrtc->dm_irq_params.window_param.x_start = 0;
-	acrtc->dm_irq_params.window_param.y_start = 0;
-	acrtc->dm_irq_params.window_param.x_end = 0;
-	acrtc->dm_irq_params.window_param.y_end = 0;
-	acrtc->dm_irq_params.window_param.activated = false;
-	acrtc->dm_irq_params.window_param.update_win = false;
-	acrtc->dm_irq_params.window_param.skip_frame_cnt = 0;
-	spin_unlock_irq(&drm_dev->event_lock);
+	spin_lock_irqsave(&drm_dev->event_lock, flags);
+	was_activated = acrtc->dm_irq_params.crc_window_activated;
+	for (i = 0; i < MAX_CRC_WINDOW_NUM; i++) {
+		acrtc->dm_irq_params.window_param[i].x_start = 0;
+		acrtc->dm_irq_params.window_param[i].y_start = 0;
+		acrtc->dm_irq_params.window_param[i].x_end = 0;
+		acrtc->dm_irq_params.window_param[i].y_end = 0;
+		acrtc->dm_irq_params.window_param[i].enable = false;
+		acrtc->dm_irq_params.window_param[i].update_win = false;
+		acrtc->dm_irq_params.window_param[i].skip_frame_cnt = 0;
+	}
+	acrtc->dm_irq_params.crc_window_activated = false;
+	spin_unlock_irqrestore(&drm_dev->event_lock, flags);
 
 	/* Disable secure_display if it was enabled */
 	if (was_activated) {
 		/* stop ROI update on this crtc */
 		flush_work(&dm->secure_display_ctx.crtc_ctx[crtc->index].notify_ta_work);
 		flush_work(&dm->secure_display_ctx.crtc_ctx[crtc->index].forward_roi_work);
-
 		aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
 
-		if (aconnector && get_phy_id(dm, aconnector, &phy_id))
-			dc_stream_forward_crc_window(stream, NULL, phy_id, true);
-		else
+		if (aconnector && get_phy_id(dm, aconnector, &phy_id)) {
+			if (dm->secure_display_ctx.support_mul_roi)
+				dc_stream_forward_multiple_crc_window(stream, NULL, phy_id, true);
+			else
+				dc_stream_forward_crc_window(stream, NULL, phy_id, true);
+		} else {
 			DRM_DEBUG_DRIVER("%s Can't find matching phy id", __func__);
+		}
 	}
 }
 
@@ -393,6 +401,8 @@ amdgpu_dm_forward_crc_window(struct work_struct *work)
 	struct drm_crtc *crtc;
 	struct dc_stream_state *stream;
 	struct amdgpu_dm_connector *aconnector;
+	struct crc_window roi_cpy[MAX_CRC_WINDOW_NUM];
+	unsigned long flags;
 	uint8_t phy_id;
 
 	crtc_ctx = container_of(work, struct secure_display_crtc_context, forward_roi_work);
@@ -416,9 +426,17 @@ amdgpu_dm_forward_crc_window(struct work_struct *work)
 	}
 	mutex_unlock(&crtc->dev->mode_config.mutex);
 
+	spin_lock_irqsave(&crtc->dev->event_lock, flags);
+	memcpy(roi_cpy, crtc_ctx->roi, sizeof(struct crc_window) * MAX_CRC_WINDOW_NUM);
+	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+
 	mutex_lock(&dm->dc_lock);
-	dc_stream_forward_crc_window(stream, &crtc_ctx->rect,
-		phy_id, false);
+	if (dm->secure_display_ctx.support_mul_roi)
+		dc_stream_forward_multiple_crc_window(stream, roi_cpy,
+			phy_id, false);
+	else
+		dc_stream_forward_crc_window(stream, &roi_cpy[0].rect,
+			phy_id, false);
 	mutex_unlock(&dm->dc_lock);
 }
 
@@ -429,7 +447,7 @@ bool amdgpu_dm_crc_window_is_activated(struct drm_crtc *crtc)
 	bool ret = false;
 
 	spin_lock_irq(&drm_dev->event_lock);
-	ret = acrtc->dm_irq_params.window_param.activated;
+	ret = acrtc->dm_irq_params.crc_window_activated;
 	spin_unlock_irq(&drm_dev->event_lock);
 
 	return ret;
@@ -726,7 +744,15 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 	struct amdgpu_crtc *acrtc = NULL;
 	struct amdgpu_device *adev = NULL;
 	struct secure_display_crtc_context *crtc_ctx = NULL;
+	bool reset_crc_frame_count[MAX_CRC_WINDOW_NUM] = {false};
+	uint32_t crc_r[MAX_CRC_WINDOW_NUM] = {0};
+	uint32_t crc_g[MAX_CRC_WINDOW_NUM] = {0};
+	uint32_t crc_b[MAX_CRC_WINDOW_NUM] = {0};
 	unsigned long flags1;
+	bool forward_roi_change = false;
+	bool notify_ta = false;
+	bool all_crc_ready = true;
+	int i;
 
 	if (crtc == NULL)
 		return;
@@ -740,15 +766,14 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 
 	/* Early return if CRC capture is not enabled. */
 	if (!amdgpu_dm_is_valid_crc_source(cur_crc_src) ||
-		!dm_is_crc_source_crtc(cur_crc_src))
-		goto cleanup;
-
-	if (!acrtc->dm_irq_params.window_param.activated)
-		goto cleanup;
+	    !dm_is_crc_source_crtc(cur_crc_src)) {
+		spin_unlock_irqrestore(&drm_dev->event_lock, flags1);
+		return;
+	}
 
-	if (acrtc->dm_irq_params.window_param.skip_frame_cnt) {
-		acrtc->dm_irq_params.window_param.skip_frame_cnt -= 1;
-		goto cleanup;
+	if (!acrtc->dm_irq_params.crc_window_activated) {
+		spin_unlock_irqrestore(&drm_dev->event_lock, flags1);
+		return;
 	}
 
 	crtc_ctx = &adev->dm.secure_display_ctx.crtc_ctx[acrtc->crtc_id];
@@ -759,32 +784,90 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 		crtc_ctx->crtc = crtc;
 	}
 
-	if (acrtc->dm_irq_params.window_param.update_win) {
-		/* prepare work for dmub to update ROI */
-		crtc_ctx->rect.x = acrtc->dm_irq_params.window_param.x_start;
-		crtc_ctx->rect.y = acrtc->dm_irq_params.window_param.y_start;
-		crtc_ctx->rect.width = acrtc->dm_irq_params.window_param.x_end -
-								acrtc->dm_irq_params.window_param.x_start;
-		crtc_ctx->rect.height = acrtc->dm_irq_params.window_param.y_end -
-								acrtc->dm_irq_params.window_param.y_start;
-		schedule_work(&crtc_ctx->forward_roi_work);
+	for (i = 0; i < MAX_CRC_WINDOW_NUM; i++) {
+		crtc_ctx->roi[i].enable = acrtc->dm_irq_params.window_param[i].enable;
 
-		acrtc->dm_irq_params.window_param.update_win = false;
+		if (!acrtc->dm_irq_params.window_param[i].enable) {
+			crtc_ctx->crc_info.crc[i].crc_ready = false;
+			continue;
+		}
 
-		/* Statically skip 1 frame, because we may need to wait below things
-		 * before sending ROI to dmub:
-		 * 1. We defer the work by using system workqueue.
-		 * 2. We may need to wait for dc_lock before accessing dmub.
-		 */
-		acrtc->dm_irq_params.window_param.skip_frame_cnt = 1;
+		if (acrtc->dm_irq_params.window_param[i].skip_frame_cnt) {
+			acrtc->dm_irq_params.window_param[i].skip_frame_cnt -= 1;
+			crtc_ctx->crc_info.crc[i].crc_ready = false;
+			continue;
+		}
 
-	} else {
-		/* prepare work for psp to read ROI/CRC and send to I2C */
-		schedule_work(&crtc_ctx->notify_ta_work);
+		if (acrtc->dm_irq_params.window_param[i].update_win) {
+			/* prepare work for dmub to update ROI */
+			crtc_ctx->roi[i].rect.x = acrtc->dm_irq_params.window_param[i].x_start;
+			crtc_ctx->roi[i].rect.y = acrtc->dm_irq_params.window_param[i].y_start;
+			crtc_ctx->roi[i].rect.width = acrtc->dm_irq_params.window_param[i].x_end -
+						acrtc->dm_irq_params.window_param[i].x_start;
+			crtc_ctx->roi[i].rect.height = acrtc->dm_irq_params.window_param[i].y_end -
+						acrtc->dm_irq_params.window_param[i].y_start;
+
+			forward_roi_change = true;
+
+			reset_crc_frame_count[i] = true;
+
+			acrtc->dm_irq_params.window_param[i].update_win = false;
+
+			/* Statically skip 1 frame, because we may need to wait below things
+			 * before sending ROI to dmub:
+			 * 1. We defer the work by using system workqueue.
+			 * 2. We may need to wait for dc_lock before accessing dmub.
+			 */
+			acrtc->dm_irq_params.window_param[i].skip_frame_cnt = 1;
+			crtc_ctx->crc_info.crc[i].crc_ready = false;
+		} else {
+			struct dc_stream_state *stream_state = to_dm_crtc_state(crtc->state)->stream;
+
+			if (!dc_stream_get_crc(stream_state->ctx->dc, stream_state, i,
+						&crc_r[i], &crc_g[i], &crc_b[i]))
+				DRM_ERROR("Secure Display: fail to get crc from engine %d\n", i);
+
+			/* prepare work for psp to read ROI/CRC and send to I2C */
+			notify_ta = true;
+			/* crc ready for psp to read out */
+			crtc_ctx->crc_info.crc[i].crc_ready = true;
+		}
 	}
 
-cleanup:
 	spin_unlock_irqrestore(&drm_dev->event_lock, flags1);
+
+	if (forward_roi_change)
+		schedule_work(&crtc_ctx->forward_roi_work);
+
+	if (notify_ta)
+		schedule_work(&crtc_ctx->notify_ta_work);
+
+	spin_lock_irqsave(&crtc_ctx->crc_info.lock, flags1);
+	for (i = 0; i < MAX_CRC_WINDOW_NUM; i++) {
+		crtc_ctx->crc_info.crc[i].crc_R = crc_r[i];
+		crtc_ctx->crc_info.crc[i].crc_G = crc_g[i];
+		crtc_ctx->crc_info.crc[i].crc_B = crc_b[i];
+
+		if (!crtc_ctx->roi[i].enable) {
+			crtc_ctx->crc_info.crc[i].frame_count = 0;
+			continue;
+		}
+
+		if (!crtc_ctx->crc_info.crc[i].crc_ready)
+			all_crc_ready = false;
+
+		if (reset_crc_frame_count[i] || crtc_ctx->crc_info.crc[i].frame_count == UINT_MAX)
+			/* Reset the reference frame count after user update the ROI
+			 * or it reaches the maximum value.
+			 */
+			crtc_ctx->crc_info.crc[i].frame_count = 0;
+		else
+			crtc_ctx->crc_info.crc[i].frame_count += 1;
+	}
+	spin_unlock_irqrestore(&crtc_ctx->crc_info.lock, flags1);
+
+	if (all_crc_ready)
+		complete_all(&crtc_ctx->crc_info.completion);
 }
 
 void amdgpu_dm_crtc_secure_display_create_contexts(struct amdgpu_device *adev)
@@ -805,6 +888,7 @@ void amdgpu_dm_crtc_secure_display_create_contexts(struct amdgpu_device *adev)
 		INIT_WORK(&crtc_ctx[i].forward_roi_work, amdgpu_dm_forward_crc_window);
 		INIT_WORK(&crtc_ctx[i].notify_ta_work, amdgpu_dm_crtc_notify_ta_to_read);
 		crtc_ctx[i].crtc = &adev->mode_info.crtcs[i]->base;
+		spin_lock_init(&crtc_ctx[i].crc_info.lock);
 	}
 
 	adev->dm.secure_display_ctx.crtc_ctx = crtc_ctx;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 4ec2510bc312..0c96f2db1352 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -51,13 +51,27 @@ struct phy_id_mapping {
 	u8 rad[8];
 };
 
+struct crc_data {
+	uint32_t crc_R;
+	uint32_t crc_G;
+	uint32_t crc_B;
+	uint32_t frame_count;
+	bool crc_ready;
+};
+
+struct crc_info {
+	struct crc_data crc[MAX_CRC_WINDOW_NUM];
+	struct completion completion;
+	spinlock_t lock;
+};
+
 struct crc_window_param {
 	uint16_t x_start;
 	uint16_t y_start;
 	uint16_t x_end;
 	uint16_t y_end;
 	/* CRC window is activated or not*/
-	bool activated;
+	bool enable;
 	/* Update crc window during vertical blank or not */
 	bool update_win;
 	/* skip reading/writing for few frames */
@@ -74,13 +88,16 @@ struct secure_display_crtc_context {
 	struct drm_crtc *crtc;
 
 	/* Region of Interest (ROI) */
-	struct rect rect;
+	struct crc_window roi[MAX_CRC_WINDOW_NUM];
+
+	struct crc_info crc_info;
 };
 
 struct secure_display_context {
 
 	struct secure_display_crtc_context *crtc_ctx;
-
+    /* Whether dmub support multiple ROI setting */
+	bool support_mul_roi;
 	bool phy_mapping_updated;
 	int phy_id_mapping_cnt;
 	struct phy_id_mapping phy_id_mapping[MAX_CRTC];
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 2a3c4ac065de..cc041d2939eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3477,8 +3477,8 @@ static int crc_win_x_start_set(void *data, u64 val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	acrtc->dm_irq_params.window_param.x_start = (uint16_t) val;
-	acrtc->dm_irq_params.window_param.update_win = false;
+	acrtc->dm_irq_params.window_param[0].x_start = (uint16_t) val;
+	acrtc->dm_irq_params.window_param[0].update_win = false;
 	spin_unlock_irq(&drm_dev->event_lock);
 
 	return 0;
@@ -3494,7 +3494,7 @@ static int crc_win_x_start_get(void *data, u64 *val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	*val = acrtc->dm_irq_params.window_param.x_start;
+	*val = acrtc->dm_irq_params.window_param[0].x_start;
 	spin_unlock_irq(&drm_dev->event_lock);
 
 	return 0;
@@ -3514,8 +3514,8 @@ static int crc_win_y_start_set(void *data, u64 val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	acrtc->dm_irq_params.window_param.y_start = (uint16_t) val;
-	acrtc->dm_irq_params.window_param.update_win = false;
+	acrtc->dm_irq_params.window_param[0].y_start = (uint16_t) val;
+	acrtc->dm_irq_params.window_param[0].update_win = false;
 	spin_unlock_irq(&drm_dev->event_lock);
 
 	return 0;
@@ -3531,7 +3531,7 @@ static int crc_win_y_start_get(void *data, u64 *val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	*val = acrtc->dm_irq_params.window_param.y_start;
+	*val = acrtc->dm_irq_params.window_param[0].y_start;
 	spin_unlock_irq(&drm_dev->event_lock);
 
 	return 0;
@@ -3550,8 +3550,8 @@ static int crc_win_x_end_set(void *data, u64 val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	acrtc->dm_irq_params.window_param.x_end = (uint16_t) val;
-	acrtc->dm_irq_params.window_param.update_win = false;
+	acrtc->dm_irq_params.window_param[0].x_end = (uint16_t) val;
+	acrtc->dm_irq_params.window_param[0].update_win = false;
 	spin_unlock_irq(&drm_dev->event_lock);
 
 	return 0;
@@ -3567,7 +3567,7 @@ static int crc_win_x_end_get(void *data, u64 *val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	*val = acrtc->dm_irq_params.window_param.x_end;
+	*val = acrtc->dm_irq_params.window_param[0].x_end;
 	spin_unlock_irq(&drm_dev->event_lock);
 
 	return 0;
@@ -3586,8 +3586,8 @@ static int crc_win_y_end_set(void *data, u64 val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	acrtc->dm_irq_params.window_param.y_end = (uint16_t) val;
-	acrtc->dm_irq_params.window_param.update_win = false;
+	acrtc->dm_irq_params.window_param[0].y_end = (uint16_t) val;
+	acrtc->dm_irq_params.window_param[0].update_win = false;
 	spin_unlock_irq(&drm_dev->event_lock);
 
 	return 0;
@@ -3603,7 +3603,7 @@ static int crc_win_y_end_get(void *data, u64 *val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	*val = acrtc->dm_irq_params.window_param.y_end;
+	*val = acrtc->dm_irq_params.window_param[0].y_end;
 	spin_unlock_irq(&drm_dev->event_lock);
 
 	return 0;
@@ -3630,9 +3630,10 @@ static int crc_win_update_set(void *data, u64 val)
 
 		spin_lock_irq(&adev_to_drm(adev)->event_lock);
 
-		acrtc->dm_irq_params.window_param.activated = true;
-		acrtc->dm_irq_params.window_param.update_win = true;
-		acrtc->dm_irq_params.window_param.skip_frame_cnt = 0;
+		acrtc->dm_irq_params.window_param[0].enable = true;
+		acrtc->dm_irq_params.window_param[0].update_win = true;
+		acrtc->dm_irq_params.window_param[0].skip_frame_cnt = 0;
+		acrtc->dm_irq_params.crc_window_activated = true;
 
 		spin_unlock_irq(&adev_to_drm(adev)->event_lock);
 		mutex_unlock(&adev->dm.dc_lock);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
index 6a7ecc1e4602..6c9de834455b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
@@ -39,7 +39,9 @@ struct dm_irq_params {
 #ifdef CONFIG_DEBUG_FS
 	enum amdgpu_dm_pipe_crc_source crc_src;
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
-	struct crc_window_param window_param;
+	struct crc_window_param window_param[MAX_CRC_WINDOW_NUM];
+	/* At least one CRC window is activated or not*/
+	bool crc_window_activated;
 #endif
 #endif
 };
-- 
2.34.1

