Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C13E74ADB
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B0F10EB65;
	Tue,  3 Dec 2024 21:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gZYkOiAw";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D462A10EB63
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv8q1WO0qi0XVa4rMRz8v6hug79w4/7ffu/l4CmiXAbHDqv2Z48CTEOGIC2crgb1GfNK/M0aagv4YLb1KIYxaipwXcSz5Ic7mMubxgUMa9oE5FzDHHNLCCDhPtgQZjj7SPukliuMoyoLGJgf+MfFtUr9Z9ZCRQTWHuGZHrrPGSXBvV5oZIlIesX/xEqp+P4yMFMBaY1dkMtKv4zUWTF1lbDhacIv9II1YcNCYzge8EMqE+2QXcaHz47hQMRbaPZQVAc5U03BTPiPLDNWwGqLjrQVD9F2milOieCqYjlDjvxFO3jfcaPMeDMlZsU8cnCIxKOOxlS2VQv/G2DgzG/k5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xKhUAKINLM5n7Hi2ArewiFmfQQY4+27hy8kXidaUQs=;
 b=G7noslsPgcY59v85HhSPQPZs5RwSVxMmXj/epmj/5Lle8DDq2vMOJq2PJf6/dXhJlXWFtBCDQCxFeY1i3pPH2car0InLx48smhXRlg/Hzhwfq9jlw26INQnzY7D4S1iOPVVGS2gemENyW5WfAfS6so2lCGQoxl5f9UvYPNl2gDRDVOEbRcnVGDacDIofOE1jgyKDBUl4f2PzbX+xzyoh1ZbR+Rz02gTwtNY/9R4Xntji/+MNzVnXIDT0cIWXlZorwwTIDEDi0OfNox9VeIMm1UPLNDsKpmImBmdAy+XI5XkOtcvbLKg89lbNqzA39XCWfBOyE0o9wx9Lp32TXcm6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xKhUAKINLM5n7Hi2ArewiFmfQQY4+27hy8kXidaUQs=;
 b=gZYkOiAwL/kIow+4XZVLSaIu7jxZGnT1TqLvgbC7u/Zq0KQjDpR53896NdBysC2L3ssgP8plvtEsHvGJ4BKYYghckfmHjuLdGP/C/3aKkjIq54G7miBnzUg8sQh5I4A7G9w6MYq++Bx5YIW+Qi7DE7V3Sz2lliVYiCHtlsajCzM=
Received: from BN9PR03CA0348.namprd03.prod.outlook.com (2603:10b6:408:f6::23)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 21:41:41 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::26) by BN9PR03CA0348.outlook.office365.com
 (2603:10b6:408:f6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 21:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:40 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:34 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, HaoPing Liu <haoping.liu@amd.com>
Subject: [PATCH 06/19] drm/amd/display: Adjust secure_display_context data
 structure
Date: Tue, 3 Dec 2024 16:39:44 -0500
Message-ID: <20241203214120.1161810-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: 6833317a-328c-4bd2-811c-08dd13e34617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bpkT5Stu2+a+XACoIslkT234dC9yIcCN6aWYFR5v1qKUAbyE+tJ2NJtYIxhL?=
 =?us-ascii?Q?yO0G1gFzZZanUJPtJA/TrBv1GoSxbQI8SOatFFgnhyX9fL9Z+FaPb58LIR/J?=
 =?us-ascii?Q?eEIRHRYpXX35awjdy2QXWvxliEX5v0q1D+AYDMLU2y7rvEBP6zY6K9soTsx/?=
 =?us-ascii?Q?pBYJcF+oPhUrzLmpIL5beDeDrEVCkVCt1yqH3ROkaaOFG4nO07GwIfWSTfQo?=
 =?us-ascii?Q?Ng0jZLQY4wxcsYZeK6i0+A8EIxZIguwab1mB1OX3Jearu4PBuEVQJ3shkyqR?=
 =?us-ascii?Q?AuhiJWfXy0hXAj4QCR60wR6QDRZyxJef/7o6aC3dqTp7y6JZ3Zsgy72Fiouo?=
 =?us-ascii?Q?CA+d8qSKuYAUP1eZcFLrA2UFf1DdMmtdIMNaePOAXKJhFwRhElIHzUvtsb34?=
 =?us-ascii?Q?J42h+KBwPt357t8kEGA8qASdWKGQUghxx1StJbN/J8+7CHtNlzag+DCg6z/3?=
 =?us-ascii?Q?Xs2975rXC2LXdYMLPixrtjN7/w/vk1hIU3DItZLhnhrO52RwU5Gb+CmExgHf?=
 =?us-ascii?Q?pXjFOu8VUAA+oUqjV2trXbiQiHjRsgKKnhwM8aIRv0Netp7v473E/nay+NT1?=
 =?us-ascii?Q?BiWJn5RkZSYHS08/riu67AVvv51Zs4nZ8YKfV5sL13/3JubMC6KZs+mFmqXZ?=
 =?us-ascii?Q?NxXbl2T+F0xCdQ4ikfgvSmZaZurnSpToqMJtQzia9PNQdVWZB1Zsrko5B89/?=
 =?us-ascii?Q?NCJgkb/EJJe1UNF0/zZCGNJXjnLOZ8kJtEM9JxMYgqOZii+prL66/ngFmy16?=
 =?us-ascii?Q?0Q+q7G07ZiRdmHGQt7xYMkIFNMZ3QaI1IDcOJglGFou0WybWhK5z7PJTDX3D?=
 =?us-ascii?Q?Nwa7h9kDMw5HtttYhJPkoq8BWOiKqao0hNpYumdQHHB48esvZCXIRK744R6m?=
 =?us-ascii?Q?Gp4dui/0rptE7Run3jEz3cBqzYkO+s+IVIh+dWuMlx6cqhWPJ084H5XaA1Zs?=
 =?us-ascii?Q?LZFxONDbWgZ7c1M/qu3+dHdTuMbBoKLtCbZ1IvFwhKxX1Sq5BAzQsaGEUvUC?=
 =?us-ascii?Q?u3jR9nMwvHsRGTVfD9h0SrLiBCfq0jpkwTTnuA11UVhmJXZvCPZj2ojlt/ll?=
 =?us-ascii?Q?gR96YZxKGKlHb6xiv17QApsAKdaB+klIaAo5rxP7GfcjVj54tWW5ykdUt7VK?=
 =?us-ascii?Q?XRo1trMXyhhbbhDSxXIWJcjVFx1FjYGbnEUYffNMkevRmXDbNHFTZarnssMG?=
 =?us-ascii?Q?K0B7KFniH5EFIGEaZYFsrtNnHDNlceyePtxl2ufqWy6EyxJO51lUqsVTbta8?=
 =?us-ascii?Q?i8XJh6wYINKhVfCNHo8i4NtE0hVgOzoRN5+JXvjOMUbRrT4p0jewMx03K4u5?=
 =?us-ascii?Q?BJUVM+zpasfEwIVew0qOmhRQx/UuHQsGMjfjyJMLTBpRDitUkg6k5cxkW3YZ?=
 =?us-ascii?Q?CL+cKci5HAgaeY7N63oT2t38FQocbE1wWHZI75PJQ6C5UP4olkpVujnmrHR8?=
 =?us-ascii?Q?USiOUOV5Xy5kJN9+0KvKyWkBgnMmXiAI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:41.0302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6833317a-328c-4bd2-811c-08dd13e34617
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698
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

[Why]
Variables relates to secure display are spreading out within struct
amdgpu_display_manager.

[How]
Encapsulate relevant variables into struct secure_display_context and
adjust relevant affected codes.

Reviewed-by: HaoPing Liu <haoping.liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  16 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 109 +++++++++---------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |  16 ++-
 4 files changed, 81 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 85f21db6ef24..f5aff4dfbe6f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2152,8 +2152,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	}
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-	adev->dm.secure_display_ctxs = amdgpu_dm_crtc_secure_display_create_contexts(adev);
-	if (!adev->dm.secure_display_ctxs)
+	amdgpu_dm_crtc_secure_display_create_contexts(adev);
+	if (!adev->dm.secure_display_ctx.crtc_ctx)
 		DRM_ERROR("amdgpu: failed to initialize secure display contexts.\n");
 #endif
 
@@ -2197,15 +2197,15 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 	amdgpu_dm_destroy_drm_device(&adev->dm);
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-	if (adev->dm.secure_display_ctxs) {
+	if (adev->dm.secure_display_ctx.crtc_ctx) {
 		for (i = 0; i < adev->mode_info.num_crtc; i++) {
-			if (adev->dm.secure_display_ctxs[i].crtc) {
-				flush_work(&adev->dm.secure_display_ctxs[i].notify_ta_work);
-				flush_work(&adev->dm.secure_display_ctxs[i].forward_roi_work);
+			if (adev->dm.secure_display_ctx.crtc_ctx[i].crtc) {
+				flush_work(&adev->dm.secure_display_ctx.crtc_ctx[i].notify_ta_work);
+				flush_work(&adev->dm.secure_display_ctx.crtc_ctx[i].forward_roi_work);
 			}
 		}
-		kfree(adev->dm.secure_display_ctxs);
-		adev->dm.secure_display_ctxs = NULL;
+		kfree(adev->dm.secure_display_ctx.crtc_ctx);
+		adev->dm.secure_display_ctx.crtc_ctx = NULL;
 	}
 #endif
 	if (adev->dm.hdcp_workqueue) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index cbd7a1cb34af..e46e1365fe91 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -541,16 +541,12 @@ struct amdgpu_display_manager {
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	/**
-	 * @secure_display_ctxs:
+	 * @secure_display_ctx:
 	 *
-	 * Store the ROI information and the work_struct to command dmub and psp for
-	 * all crtcs.
+	 * Store secure display relevant info. e.g. the ROI information
+	 * , the work_struct to command dmub, etc.
 	 */
-	struct secure_display_context *secure_display_ctxs;
-
-	bool secure_display_phy_mapping_updated;
-	int phy_id_mapping_cnt;
-	struct phy_id_mapping phy_id_mapping[AMDGPU_DM_MAX_CRTC];
+	struct secure_display_context secure_display_ctx;
 #endif
 	/**
 	 * @hpd_rx_offload_wq:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 066054caa4c7..309c7999faa6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -93,7 +93,7 @@ static void update_phy_id_mapping(struct amdgpu_device *adev)
 	struct drm_connector_list_iter iter;
 	uint8_t idx = 0, idx_2 = 0, connector_cnt = 0;
 
-	dm->secure_display_phy_mapping_updated = false;
+	dm->secure_display_ctx.phy_mapping_updated = false;
 
 	mutex_lock(&ddev->mode_config.mutex);
 	drm_connector_list_iter_begin(ddev, &iter);
@@ -194,27 +194,27 @@ static void update_phy_id_mapping(struct amdgpu_device *adev)
 		}
 	}
 
-	/* Complete sorting. Assign relavant result to dm->phy_id_mapping[]*/
-	memset(dm->phy_id_mapping, 0, sizeof(dm->phy_id_mapping));
+	/* Complete sorting. Assign relavant result to dm->secure_display_ctx.phy_id_mapping[]*/
+	memset(dm->secure_display_ctx.phy_id_mapping, 0, sizeof(dm->secure_display_ctx.phy_id_mapping));
 	for (idx = 0; idx < connector_cnt; idx++) {
 		aconnector = sort_connector[idx];
 
-		dm->phy_id_mapping[idx].assigned = true;
-		dm->phy_id_mapping[idx].is_mst = false;
-		dm->phy_id_mapping[idx].enc_hw_inst = aconnector->dc_link->link_enc_hw_inst;
+		dm->secure_display_ctx.phy_id_mapping[idx].assigned = true;
+		dm->secure_display_ctx.phy_id_mapping[idx].is_mst = false;
+		dm->secure_display_ctx.phy_id_mapping[idx].enc_hw_inst = aconnector->dc_link->link_enc_hw_inst;
 
 		if (sort_connector[idx]->mst_root) {
-			dm->phy_id_mapping[idx].is_mst = true;
-			dm->phy_id_mapping[idx].lct = aconnector->mst_output_port->parent->lct;
-			dm->phy_id_mapping[idx].port_num = aconnector->mst_output_port->port_num;
-			memcpy(dm->phy_id_mapping[idx].rad, aconnector->mst_output_port->parent->rad,
-				sizeof(aconnector->mst_output_port->parent->rad));
+			dm->secure_display_ctx.phy_id_mapping[idx].is_mst = true;
+			dm->secure_display_ctx.phy_id_mapping[idx].lct = aconnector->mst_output_port->parent->lct;
+			dm->secure_display_ctx.phy_id_mapping[idx].port_num = aconnector->mst_output_port->port_num;
+			memcpy(dm->secure_display_ctx.phy_id_mapping[idx].rad,
+				aconnector->mst_output_port->parent->rad, sizeof(aconnector->mst_output_port->parent->rad));
 		}
 	}
 	mutex_unlock(&ddev->mode_config.mutex);
 
-	dm->phy_id_mapping_cnt = connector_cnt;
-	dm->secure_display_phy_mapping_updated = true;
+	dm->secure_display_ctx.phy_id_mapping_cnt = connector_cnt;
+	dm->secure_display_ctx.phy_mapping_updated = true;
 }
 
 static bool get_phy_id(struct amdgpu_display_manager *dm,
@@ -227,19 +227,20 @@ static bool get_phy_id(struct amdgpu_display_manager *dm,
 	 * Assume secure display start after all connectors are probed. The connection
 	 * config is static as well
 	 */
-	if (!dm->secure_display_phy_mapping_updated) {
+	if (!dm->secure_display_ctx.phy_mapping_updated) {
 		DRM_WARN("%s Should update the phy id table before get it's value", __func__);
 		return false;
 	}
 
-	for (idx = 0; idx < dm->phy_id_mapping_cnt; idx++) {
-		if (!dm->phy_id_mapping[idx].assigned) {
+	for (idx = 0; idx < dm->secure_display_ctx.phy_id_mapping_cnt; idx++) {
+		if (!dm->secure_display_ctx.phy_id_mapping[idx].assigned) {
 			DRM_ERROR("phy_id_mapping[%d] should be assigned", idx);
 			return false;
 		}
 
-		if (aconnector->dc_link->link_enc_hw_inst == dm->phy_id_mapping[idx].enc_hw_inst) {
-			if (!dm->phy_id_mapping[idx].is_mst) {
+		if (aconnector->dc_link->link_enc_hw_inst ==
+				dm->secure_display_ctx.phy_id_mapping[idx].enc_hw_inst) {
+			if (!dm->secure_display_ctx.phy_id_mapping[idx].is_mst) {
 				found = true;
 				goto out;
 			} else {
@@ -254,8 +255,8 @@ static bool get_phy_id(struct amdgpu_display_manager *dm,
 					DRM_WARN("%s pass in a stale mst connector", __func__);
 				}
 
-				if (aconnector->mst_output_port->parent->lct == dm->phy_id_mapping[idx].lct &&
-					aconnector->mst_output_port->port_num == dm->phy_id_mapping[idx].port_num) {
+				if (aconnector->mst_output_port->parent->lct == dm->secure_display_ctx.phy_id_mapping[idx].lct &&
+					aconnector->mst_output_port->port_num == dm->secure_display_ctx.phy_id_mapping[idx].port_num) {
 					if (aconnector->mst_output_port->parent->lct == 1) {
 						found = true;
 						goto out;
@@ -264,7 +265,7 @@ static bool get_phy_id(struct amdgpu_display_manager *dm,
 						for (idx_2 = 0; idx_2 < aconnector->mst_output_port->parent->lct - 1; idx_2++) {
 							int shift = (idx_2 % 2) ? 0 : 4;
 							int port_num = (aconnector->mst_output_port->parent->rad[idx_2 / 2] >> shift) & 0xf;
-							int port_num2 = (dm->phy_id_mapping[idx].rad[idx_2 / 2] >> shift) & 0xf;
+							int port_num2 = (dm->secure_display_ctx.phy_id_mapping[idx].rad[idx_2 / 2] >> shift) & 0xf;
 
 							if (port_num != port_num2)
 								break;
@@ -318,8 +319,8 @@ static void amdgpu_dm_set_crc_window_default(struct drm_crtc *crtc, struct dc_st
 	/* Disable secure_display if it was enabled */
 	if (was_activated) {
 		/* stop ROI update on this crtc */
-		flush_work(&dm->secure_display_ctxs[crtc->index].notify_ta_work);
-		flush_work(&dm->secure_display_ctxs[crtc->index].forward_roi_work);
+		flush_work(&dm->secure_display_ctx.crtc_ctx[crtc->index].notify_ta_work);
+		flush_work(&dm->secure_display_ctx.crtc_ctx[crtc->index].forward_roi_work);
 
 		aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
 
@@ -332,7 +333,7 @@ static void amdgpu_dm_set_crc_window_default(struct drm_crtc *crtc, struct dc_st
 
 static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 {
-	struct secure_display_context *secure_display_ctx;
+	struct secure_display_crtc_context *crtc_ctx;
 	struct psp_context *psp;
 	struct ta_securedisplay_cmd *securedisplay_cmd;
 	struct drm_crtc *crtc;
@@ -342,8 +343,8 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 	struct amdgpu_display_manager *dm;
 	int ret;
 
-	secure_display_ctx = container_of(work, struct secure_display_context, notify_ta_work);
-	crtc = secure_display_ctx->crtc;
+	crtc_ctx = container_of(work, struct secure_display_crtc_context, notify_ta_work);
+	crtc = crtc_ctx->crtc;
 
 	if (!crtc)
 		return;
@@ -393,15 +394,15 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 static void
 amdgpu_dm_forward_crc_window(struct work_struct *work)
 {
-	struct secure_display_context *secure_display_ctx;
+	struct secure_display_crtc_context *crtc_ctx;
 	struct amdgpu_display_manager *dm;
 	struct drm_crtc *crtc;
 	struct dc_stream_state *stream;
 	struct amdgpu_dm_connector *aconnector;
 	uint8_t phy_id;
 
-	secure_display_ctx = container_of(work, struct secure_display_context, forward_roi_work);
-	crtc = secure_display_ctx->crtc;
+	crtc_ctx = container_of(work, struct secure_display_crtc_context, forward_roi_work);
+	crtc = crtc_ctx->crtc;
 
 	if (!crtc)
 		return;
@@ -422,7 +423,7 @@ amdgpu_dm_forward_crc_window(struct work_struct *work)
 	mutex_unlock(&crtc->dev->mode_config.mutex);
 
 	mutex_lock(&dm->dc_lock);
-	dc_stream_forward_crc_window(stream, &secure_display_ctx->rect,
+	dc_stream_forward_crc_window(stream, &crtc_ctx->rect,
 		phy_id, false);
 	mutex_unlock(&dm->dc_lock);
 }
@@ -656,7 +657,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	/* Initialize phy id mapping table for secure display*/
-	if (!dm->secure_display_phy_mapping_updated)
+	if (!dm->secure_display_ctx.phy_mapping_updated)
 		update_phy_id_mapping(adev);
 #endif
 
@@ -730,7 +731,7 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 	enum amdgpu_dm_pipe_crc_source cur_crc_src;
 	struct amdgpu_crtc *acrtc = NULL;
 	struct amdgpu_device *adev = NULL;
-	struct secure_display_context *secure_display_ctx = NULL;
+	struct secure_display_crtc_context *crtc_ctx = NULL;
 	unsigned long flags1;
 
 	if (crtc == NULL)
@@ -756,23 +757,23 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 		goto cleanup;
 	}
 
-	secure_display_ctx = &adev->dm.secure_display_ctxs[acrtc->crtc_id];
-	if (WARN_ON(secure_display_ctx->crtc != crtc)) {
-		/* We have set the crtc when creating secure_display_context,
+	crtc_ctx = &adev->dm.secure_display_ctx.crtc_ctx[acrtc->crtc_id];
+	if (WARN_ON(crtc_ctx->crtc != crtc)) {
+		/* We have set the crtc when creating secure_display_crtc_context,
 		 * don't expect it to be changed here.
 		 */
-		secure_display_ctx->crtc = crtc;
+		crtc_ctx->crtc = crtc;
 	}
 
 	if (acrtc->dm_irq_params.window_param.update_win) {
 		/* prepare work for dmub to update ROI */
-		secure_display_ctx->rect.x = acrtc->dm_irq_params.window_param.x_start;
-		secure_display_ctx->rect.y = acrtc->dm_irq_params.window_param.y_start;
-		secure_display_ctx->rect.width = acrtc->dm_irq_params.window_param.x_end -
+		crtc_ctx->rect.x = acrtc->dm_irq_params.window_param.x_start;
+		crtc_ctx->rect.y = acrtc->dm_irq_params.window_param.y_start;
+		crtc_ctx->rect.width = acrtc->dm_irq_params.window_param.x_end -
 								acrtc->dm_irq_params.window_param.x_start;
-		secure_display_ctx->rect.height = acrtc->dm_irq_params.window_param.y_end -
+		crtc_ctx->rect.height = acrtc->dm_irq_params.window_param.y_end -
 								acrtc->dm_irq_params.window_param.y_start;
-		schedule_work(&secure_display_ctx->forward_roi_work);
+		schedule_work(&crtc_ctx->forward_roi_work);
 
 		acrtc->dm_irq_params.window_param.update_win = false;
 
@@ -785,32 +786,34 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 
 	} else {
 		/* prepare work for psp to read ROI/CRC and send to I2C */
-		schedule_work(&secure_display_ctx->notify_ta_work);
+		schedule_work(&crtc_ctx->notify_ta_work);
 	}
 
 cleanup:
 	spin_unlock_irqrestore(&drm_dev->event_lock, flags1);
 }
 
-struct secure_display_context *
-amdgpu_dm_crtc_secure_display_create_contexts(struct amdgpu_device *adev)
+void amdgpu_dm_crtc_secure_display_create_contexts(struct amdgpu_device *adev)
 {
-	struct secure_display_context *secure_display_ctxs = NULL;
+	struct secure_display_crtc_context *crtc_ctx = NULL;
 	int i;
 
-	secure_display_ctxs = kcalloc(adev->mode_info.num_crtc,
-				      sizeof(struct secure_display_context),
+	crtc_ctx = kcalloc(adev->mode_info.num_crtc,
+				      sizeof(struct secure_display_crtc_context),
 				      GFP_KERNEL);
 
-	if (!secure_display_ctxs)
-		return NULL;
+	if (!crtc_ctx) {
+		adev->dm.secure_display_ctx.crtc_ctx = NULL;
+		return;
+	}
 
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		INIT_WORK(&secure_display_ctxs[i].forward_roi_work, amdgpu_dm_forward_crc_window);
-		INIT_WORK(&secure_display_ctxs[i].notify_ta_work, amdgpu_dm_crtc_notify_ta_to_read);
-		secure_display_ctxs[i].crtc = &adev->mode_info.crtcs[i]->base;
+		INIT_WORK(&crtc_ctx[i].forward_roi_work, amdgpu_dm_forward_crc_window);
+		INIT_WORK(&crtc_ctx[i].notify_ta_work, amdgpu_dm_crtc_notify_ta_to_read);
+		crtc_ctx[i].crtc = &adev->mode_info.crtcs[i]->base;
 	}
 
-	return secure_display_ctxs;
+	adev->dm.secure_display_ctx.crtc_ctx = crtc_ctx;
+	return;
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 82afb551632b..4ec2510bc312 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -40,6 +40,8 @@ enum amdgpu_dm_pipe_crc_source {
 };
 
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
+#define MAX_CRTC 6
+
 struct phy_id_mapping {
 	bool assigned;
 	bool is_mst;
@@ -62,7 +64,7 @@ struct crc_window_param {
 	int skip_frame_cnt;
 };
 
-struct secure_display_context {
+struct secure_display_crtc_context {
 	/* work to notify PSP TA*/
 	struct work_struct notify_ta_work;
 
@@ -74,6 +76,15 @@ struct secure_display_context {
 	/* Region of Interest (ROI) */
 	struct rect rect;
 };
+
+struct secure_display_context {
+
+	struct secure_display_crtc_context *crtc_ctx;
+
+	bool phy_mapping_updated;
+	int phy_id_mapping_cnt;
+	struct phy_id_mapping phy_id_mapping[MAX_CRTC];
+};
 #endif
 
 static inline bool amdgpu_dm_is_valid_crc_source(enum amdgpu_dm_pipe_crc_source source)
@@ -104,8 +115,7 @@ void amdgpu_dm_crtc_handle_crc_irq(struct drm_crtc *crtc);
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 bool amdgpu_dm_crc_window_is_activated(struct drm_crtc *crtc);
 void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc);
-struct secure_display_context *amdgpu_dm_crtc_secure_display_create_contexts(
-						struct amdgpu_device *adev);
+void amdgpu_dm_crtc_secure_display_create_contexts(struct amdgpu_device *adev);
 #else
 #define amdgpu_dm_crc_window_is_activated(x)
 #define amdgpu_dm_crtc_handle_crc_window_irq(x)
-- 
2.47.1

