Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ABCCFD65A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90CAF10E62A;
	Wed,  7 Jan 2026 15:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l9YH43Dk";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47E2210E631
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OitdpQULVPYGTak7dKkAiIODS+t81yJlD9ghL7vudEyJF75vZ7w9Wdkfi90PD5fGQRin5PwpYmQEEr0I4sXCwgr9t8mUUeGCu4FQSSS2bU76By31wKpcekeJb0i0wg6cU8Xml3JZ9Oyz5ZPItRzoPBSBptyH+QHa9bqffmMwJQtHfFuCwHOTXkhKWCCNWYMXbDLs0o14GJKLnGtJLq4kOEPgOfo4P6fZOUtYh64QBGFgPFYOL9/aPgQ1n4YA/WjR4KBzkFm0OFVZ4hBXw2mkfO0KgruoAEQc+cHAVVYC9mMtDdu1Pw213dKagb0XybK+DiKJ/qacuBw5+Om4Z8rHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awYuM9ugqDpwhQA0B3FgSfp8ug/XwzCkRFo7gqIjHZU=;
 b=CLsGmMhweBW1ojnIMF1LMqSTDTAlYyNNHyKO9HHljFbPxb5lECTsNG+2ocQjBBlyelr/pgFekw2xe3/bw1/x/uWpyXCkLe74VxDkLqgDgxNvYRadkryA4rldsmGA/tlxmRPer06559wIfT4k9M3qtTNn8dTTHtiNJSoEhnJy3sBYiCcVxUb+8F13627P9zK90c2jbQe0+wb4J7GM7uvhfzpiIt80G6sPaZvy1L1GVfs8B3ckB2wpeBVRWkGf3EQcmSYfRuDj4gpseyyOa1VxZliie1B7qtURi1OzQopAHwDuVZyppjjL4r+/voKWtCfscFWVCP+//svfFIDwc2jFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awYuM9ugqDpwhQA0B3FgSfp8ug/XwzCkRFo7gqIjHZU=;
 b=l9YH43DkOSVla+DaHNlB4W0aJh1HCNBGhPUI5KsR5334GpzhjVTje+Kp3bw38B5DvK70e23kS/XdmKN/r+lumyj+mkZ028rt5HuTmfuPofJU9gL/3WcxAMbE9aUCGIJ6z4EpFtwTAW07pW8/i3uQmsI1frEmDMqxTMvQbKeToMQ=
Received: from SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:57:54 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::5e) by SJ0PR03CA0184.outlook.office365.com
 (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 15:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:57:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:57:52 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:57:52 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 01/21] drm/amd/display: move panel replay out from edp
Date: Wed, 7 Jan 2026 10:47:53 -0500
Message-ID: <20260107155421.1999951-2-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e0ee95-5e10-4733-519e-08de4e058468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NxBCZcG8SyLky7sgc7bE+Cmp9wrKU5jhJpkSMf22W871qhMpE1npjRC7IxBw?=
 =?us-ascii?Q?qN0gPFSGS8we/L3YA81EW9oVY+20EYfpI1WFe2aEnRfedCVHUeXorJDvcrYl?=
 =?us-ascii?Q?JbJoeAAbIraSe9zjk+VhawsWlBMnELuiN82PRCDm2KISayzSO85jKPyyr3px?=
 =?us-ascii?Q?xJCnFC1d2x+XzxKWnEvOwjSWKVx4FRgDB7sTYXs+9ar2w/aaJIqRIU9B50u0?=
 =?us-ascii?Q?1qbf4grkPP93mPXr+E43hpYB2NrlxZEUUG8QtxwQ0KHSy+GRaeYkCn90gPbo?=
 =?us-ascii?Q?S3zupou09YniPU9jO/WRrS7KNWq7yxQN5v8m22Z1QTyMa6wvoK5ZGz8SuZOY?=
 =?us-ascii?Q?nNsnvaZdXDrrRrAzrRSLDlvYA9+E7rFTtvSrvix9CxeOPlUANWy2kZWPAkrU?=
 =?us-ascii?Q?VBv8pkB8CSSiAtJdSJQGVy++/aNrw7dcT35qi4qJ/VvFeu2G81zB/SxJCjEu?=
 =?us-ascii?Q?mbjVK3zrUm2nf48LhLcBJfam8gFQbxra9NYoNs8Kyk87FnUo1+5/1Jg5iB4m?=
 =?us-ascii?Q?0Blmbg6uH2gswqjCzeyv4nf0HWWuZcB47hnK5KqCqUtlqN82K8UpOL/L833z?=
 =?us-ascii?Q?1+tPa++CkGq8DAeYl83NVu01iZ8Vq1bLV1r+w6hF8w70Bl2UmOAWn8i5WUhi?=
 =?us-ascii?Q?PjnIVC5z6W45kUBYPTZqTs4sd/MP1khdCxlyOuN1yIcVpGTG/8+8N8mBECxt?=
 =?us-ascii?Q?zD5nanbMvhVdPNsZU9D05ZcV2/frx9KC/QUchL5PjqBAv8LOQI2pnNzKCDEO?=
 =?us-ascii?Q?cwsvzjdsY6vJUxgjn6Aw/hiK60i6la3EtSdazRmFIoYZJwICd43GGUaFu8/Y?=
 =?us-ascii?Q?PiRtZiXENLDrN4LxN6FGDc3xWJMeOd8AImrHLDcxeD8JJpT4qxD18i9cqhlu?=
 =?us-ascii?Q?AYymvpFP4oyZG/TaPNALlaB0ogq8wGMkqgZtRycXF3pbUs+fZ6ng9nXx83rV?=
 =?us-ascii?Q?rLRg6xyRz+S2H0p7tWy+2DkTTdaaz6CP8J+d31mSFSp/UyhUlSrA75mOxYCN?=
 =?us-ascii?Q?W5UmGSaqAXVS9INFqpNUVfWbyurxqjKmx/dYKp0RxvutmXhQcGqKxIR4assk?=
 =?us-ascii?Q?Bb1clyme8CTy5AdOmQXCGmbThJBMTVGCRKd2aDROOE/24NhuHxebzHAQwCJ9?=
 =?us-ascii?Q?nq+K1ThgAN7xDNs+0utw3PiQ8UlCklE4KbhAk8qCXNT0vGf/GyPugoaP4r5X?=
 =?us-ascii?Q?PmQcMNGt09x2HreSNQp20tHRVvunqJaY7Zs3kikWgtcDT3pKy+2UsGCX/moS?=
 =?us-ascii?Q?4ldxG0n9tO7GaT1p6OEs8Ds7FpZcrlIFXSTCXUA0WHT/aUlwZL+KsvJFjVCh?=
 =?us-ascii?Q?5o8UjEHQhPWmvAAc4WHlsZcpV5kKrmfXSuvQbs3ME0IRPplFQd8w7tsybhNR?=
 =?us-ascii?Q?13RgeUorHXyUC/pcGRKkZH6NnruzFLkaVzrC9qVBqyzz/r04yBmMbXfSUtB3?=
 =?us-ascii?Q?wEW/ZOED4qx6oymeFOjtx0fidB2wLcZdVEXCEPHN+Gw5VpMh26/FVBzAPE+6?=
 =?us-ascii?Q?AbTL+MQ9i3ZMwX8GJbYojZoyJU4AMfw5JrRPKZBlb/Hf1ZiKez7ruI7dKm8a?=
 =?us-ascii?Q?WsFDE+13T0V1qX4wJQU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:57:53.5057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e0ee95-5e10-4733-519e-08de4e058468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
Panel Replay is not an eDP-specific function.

[HOW]
Create new Panel Replay source files and move the Panel Replay
functions from the eDP files to the new files. Additionally, create
a new link_service construct function to assign the related
function pointers.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |   2 +-
 .../drm/amd/display/dc/core/dc_link_exports.c |   9 +-
 .../gpu/drm/amd/display/dc/inc/link_service.h |  10 +-
 drivers/gpu/drm/amd/display/dc/link/Makefile  |   2 +-
 .../drm/amd/display/dc/link/link_factory.c    |  18 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |   1 +
 .../dc/link/protocols/link_dp_panel_replay.c  | 308 ++++++++++++++++++
 .../dc/link/protocols/link_dp_panel_replay.h  |  38 +++
 .../link/protocols/link_edp_panel_control.c   | 271 +--------------
 .../link/protocols/link_edp_panel_control.h   |   8 +-
 10 files changed, 373 insertions(+), 294 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index da94e3544b65..fb619a3336b7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -161,7 +161,7 @@ bool amdgpu_dm_replay_enable(struct dc_stream_state *stream, bool wait)
 	link = stream->link;
 
 	if (link) {
-		link->dc->link_srv->edp_setup_replay(link, stream);
+		link->dc->link_srv->dp_setup_replay(link, stream);
 		link->dc->link_srv->edp_set_coasting_vtotal(link, stream->timing.v_total, 0);
 		DRM_DEBUG_DRIVER("Enabling replay...\n");
 		link->dc->link_srv->edp_set_replay_allow_active(link, &replay_active, wait, false, NULL);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index a8d7228907c2..7bb4504889be 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -493,24 +493,24 @@ bool dc_link_get_replay_state(const struct dc_link *link, uint64_t *state)
 
 bool dc_link_set_pr_enable(struct dc_link *link, bool enable)
 {
-	return link->dc->link_srv->edp_pr_enable(link, enable);
+	return link->dc->link_srv->dp_pr_enable(link, enable);
 }
 
 bool dc_link_update_pr_state(struct dc_link *link,
 		struct dmub_cmd_pr_update_state_data *update_state_data)
 {
-	return link->dc->link_srv->edp_pr_update_state(link, update_state_data);
+	return link->dc->link_srv->dp_pr_update_state(link, update_state_data);
 }
 
 bool dc_link_set_pr_general_cmd(struct dc_link *link,
 		struct dmub_cmd_pr_general_cmd_data *general_cmd_data)
 {
-	return link->dc->link_srv->edp_pr_set_general_cmd(link, general_cmd_data);
+	return link->dc->link_srv->dp_pr_set_general_cmd(link, general_cmd_data);
 }
 
 bool dc_link_get_pr_state(const struct dc_link *link, uint64_t *state)
 {
-	return link->dc->link_srv->edp_pr_get_state(link, state);
+	return link->dc->link_srv->dp_pr_get_state(link, state);
 }
 
 bool dc_link_wait_for_t12(struct dc_link *link)
@@ -549,4 +549,3 @@ void dc_link_get_alpm_support(struct dc_link *link,
 {
 	link->dc->link_srv->edp_get_alpm_support(link, auxless_support, auxwake_support);
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index 4b092a9ee4c6..5885b4abdf38 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -283,7 +283,7 @@ struct link_service {
 	bool (*edp_set_replay_allow_active)(struct dc_link *dc_link,
 			const bool *enable, bool wait, bool force_static,
 			const unsigned int *power_opts);
-	bool (*edp_setup_replay)(struct dc_link *link,
+	bool (*dp_setup_replay)(struct dc_link *link,
 			const struct dc_stream_state *stream);
 	bool (*edp_send_replay_cmd)(struct dc_link *link,
 			enum replay_FW_Message_type msg,
@@ -304,10 +304,10 @@ struct link_service {
 	bool (*edp_receiver_ready_T9)(struct dc_link *link);
 	bool (*edp_receiver_ready_T7)(struct dc_link *link);
 	bool (*edp_power_alpm_dpcd_enable)(struct dc_link *link, bool enable);
-	bool (*edp_pr_enable)(struct dc_link *link, bool enable);
-	bool (*edp_pr_update_state)(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data);
-	bool (*edp_pr_set_general_cmd)(struct dc_link *link, struct dmub_cmd_pr_general_cmd_data *general_cmd_data);
-	bool (*edp_pr_get_state)(const struct dc_link *link, uint64_t *state);
+	bool (*dp_pr_enable)(struct dc_link *link, bool enable);
+	bool (*dp_pr_update_state)(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data);
+	bool (*dp_pr_set_general_cmd)(struct dc_link *link, struct dmub_cmd_pr_general_cmd_data *general_cmd_data);
+	bool (*dp_pr_get_state)(const struct dc_link *link, uint64_t *state);
 	void (*edp_set_panel_power)(struct dc_link *link, bool powerOn);
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
index 84c7af5fa589..84dace27daf7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -56,7 +56,7 @@ LINK_PROTOCOLS = link_hpd.o link_ddc.o link_dpcd.o link_dp_dpia.o \
 link_dp_training.o link_dp_training_8b_10b.o link_dp_training_128b_132b.o \
 link_dp_training_dpia.o link_dp_training_auxless.o \
 link_dp_training_fixed_vs_pe_retimer.o link_dp_phy.o link_dp_capability.o \
-link_edp_panel_control.o link_dp_irq_handler.o link_dp_dpia_bw.o
+link_edp_panel_control.o link_dp_panel_replay.o link_dp_irq_handler.o link_dp_dpia_bw.o
 
 AMD_DAL_LINK_PROTOCOLS = $(addprefix $(AMDDALPATH)/dc/link/protocols/, \
 $(LINK_PROTOCOLS))
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 923517715651..e185f2caad0c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -41,6 +41,7 @@
 #include "protocols/link_dp_phy.h"
 #include "protocols/link_dp_training.h"
 #include "protocols/link_edp_panel_control.h"
+#include "protocols/link_dp_panel_replay.h"
 #include "protocols/link_hpd.h"
 #include "gpio_service_interface.h"
 #include "atomfirmware.h"
@@ -214,7 +215,6 @@ static void construct_link_service_edp_panel_control(struct link_service *link_s
 
 	link_srv->edp_get_replay_state = edp_get_replay_state;
 	link_srv->edp_set_replay_allow_active = edp_set_replay_allow_active;
-	link_srv->edp_setup_replay = edp_setup_replay;
 	link_srv->edp_send_replay_cmd = edp_send_replay_cmd;
 	link_srv->edp_set_coasting_vtotal = edp_set_coasting_vtotal;
 	link_srv->edp_replay_residency = edp_replay_residency;
@@ -228,13 +228,20 @@ static void construct_link_service_edp_panel_control(struct link_service *link_s
 	link_srv->edp_receiver_ready_T9 = edp_receiver_ready_T9;
 	link_srv->edp_receiver_ready_T7 = edp_receiver_ready_T7;
 	link_srv->edp_power_alpm_dpcd_enable = edp_power_alpm_dpcd_enable;
-	link_srv->edp_pr_enable = edp_pr_enable;
-	link_srv->edp_pr_update_state = edp_pr_update_state;
-	link_srv->edp_pr_set_general_cmd = edp_pr_set_general_cmd;
-	link_srv->edp_pr_get_state = edp_pr_get_state;
 	link_srv->edp_set_panel_power = edp_set_panel_power;
 }
 
+/* link dp panel replay implements DP panel replay functionality.
+ */
+static void construct_link_service_dp_panel_replay(struct link_service *link_srv)
+{
+	link_srv->dp_setup_replay = dp_setup_replay;
+	link_srv->dp_pr_enable = dp_pr_enable;
+	link_srv->dp_pr_update_state = dp_pr_update_state;
+	link_srv->dp_pr_set_general_cmd = dp_pr_set_general_cmd;
+	link_srv->dp_pr_get_state = dp_pr_get_state;
+}
+
 /* link dp cts implements dp compliance test automation protocols and manual
  * testing interfaces for debugging and certification purpose.
  */
@@ -287,6 +294,7 @@ static void construct_link_service(struct link_service *link_srv)
 	construct_link_service_dp_phy_or_dpia(link_srv);
 	construct_link_service_dp_irq_handler(link_srv);
 	construct_link_service_edp_panel_control(link_srv);
+	construct_link_service_dp_panel_replay(link_srv);
 	construct_link_service_dp_cts(link_srv);
 	construct_link_service_dp_trace(link_srv);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 4b01ab0a5a7f..47abd3ec69b3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -38,6 +38,7 @@
 #include "link/link_dpms.h"
 #include "dm_helpers.h"
 #include "link_dp_dpia_bw.h"
+#include "link_dp_panel_replay.h"
 
 #define DC_LOGGER \
 	link->ctx->logger
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
new file mode 100644
index 000000000000..3168c42d662c
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -0,0 +1,308 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "link_dp_panel_replay.h"
+#include "link_edp_panel_control.h"
+#include "link_dpcd.h"
+#include "dm_helpers.h"
+#include "dc/dc_dmub_srv.h"
+#include "dce/dmub_replay.h"
+
+#define DC_LOGGER \
+	link->ctx->logger
+
+#define DP_SINK_PR_ENABLE_AND_CONFIGURATION		0x37B
+
+static bool dp_setup_panel_replay(struct dc_link *link, const struct dc_stream_state *stream)
+{
+	/* To-do: Setup Replay */
+	struct dc *dc;
+	struct dmub_replay *replay;
+	int i;
+	unsigned int panel_inst;
+	struct replay_context replay_context = { 0 };
+	unsigned int lineTimeInNs = 0;
+
+	union panel_replay_enable_and_configuration_1 pr_config_1 = { 0 };
+	union panel_replay_enable_and_configuration_2 pr_config_2 = { 0 };
+
+	union dpcd_alpm_configuration alpm_config;
+
+	replay_context.controllerId = CONTROLLER_ID_UNDEFINED;
+
+	if (!link)
+		return false;
+
+	//Clear Panel Replay enable & config
+	dm_helpers_dp_write_dpcd(link->ctx, link,
+		DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_1,
+		(uint8_t *)&(pr_config_1.raw), sizeof(uint8_t));
+
+	dm_helpers_dp_write_dpcd(link->ctx, link,
+		DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_2,
+		(uint8_t *)&(pr_config_2.raw), sizeof(uint8_t));
+
+	if (!(link->replay_settings.config.replay_supported))
+		return false;
+
+	dc = link->ctx->dc;
+
+	//not sure should keep or not
+	replay = dc->res_pool->replay;
+
+	if (!replay)
+		return false;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	replay_context.aux_inst = link->ddc->ddc_pin->hw_info.ddc_channel;
+	replay_context.digbe_inst = link->link_enc->transmitter;
+	replay_context.digfe_inst = link->link_enc->preferred_engine;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (dc->current_state->res_ctx.pipe_ctx[i].stream
+				== stream) {
+			/* dmcu -1 for all controller id values,
+			 * therefore +1 here
+			 */
+			replay_context.controllerId =
+				dc->current_state->res_ctx.pipe_ctx[i].stream_res.tg->inst + 1;
+			break;
+		}
+	}
+
+	lineTimeInNs =
+		((stream->timing.h_total * 1000000) /
+			(stream->timing.pix_clk_100hz / 10)) + 1;
+
+	replay_context.line_time_in_ns = lineTimeInNs;
+
+	link->replay_settings.replay_feature_enabled = dp_pr_copy_settings(link, &replay_context);
+
+	if (link->replay_settings.replay_feature_enabled) {
+		pr_config_1.bits.PANEL_REPLAY_ENABLE = 1;
+		pr_config_1.bits.PANEL_REPLAY_CRC_ENABLE = 1;
+		pr_config_1.bits.IRQ_HPD_ASSDP_MISSING = 1;
+		pr_config_1.bits.IRQ_HPD_VSCSDP_UNCORRECTABLE_ERROR = 1;
+		pr_config_1.bits.IRQ_HPD_RFB_ERROR = 1;
+		pr_config_1.bits.IRQ_HPD_ACTIVE_FRAME_CRC_ERROR = 1;
+		pr_config_1.bits.PANEL_REPLAY_SELECTIVE_UPDATE_ENABLE = 1;
+		pr_config_1.bits.PANEL_REPLAY_EARLY_TRANSPORT_ENABLE = 1;
+
+		pr_config_2.bits.SINK_REFRESH_RATE_UNLOCK_GRANTED = 0;
+		pr_config_2.bits.SU_Y_GRANULARITY_EXT_VALUE_ENABLED = 0;
+		pr_config_2.bits.SU_REGION_SCAN_LINE_CAPTURE_INDICATION = 0;
+
+		dm_helpers_dp_write_dpcd(link->ctx, link,
+			DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_1,
+			(uint8_t *)&(pr_config_1.raw), sizeof(uint8_t));
+
+		dm_helpers_dp_write_dpcd(link->ctx, link,
+			DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_2,
+			(uint8_t *)&(pr_config_2.raw), sizeof(uint8_t));
+
+		//ALPM Setup
+		memset(&alpm_config, 0, sizeof(alpm_config));
+		alpm_config.bits.ENABLE = link->replay_settings.config.alpm_mode != DC_ALPM_UNSUPPORTED ? 1 : 0;
+
+		if (link->replay_settings.config.alpm_mode == DC_ALPM_AUXLESS) {
+			alpm_config.bits.ALPM_MODE_SEL = 1;
+			alpm_config.bits.ACDS_PERIOD_DURATION = 1;
+		}
+
+		dm_helpers_dp_write_dpcd(
+			link->ctx,
+			link,
+			DP_RECEIVER_ALPM_CONFIG,
+			&alpm_config.raw,
+			sizeof(alpm_config.raw));
+	}
+
+	return true;
+}
+
+bool dp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream)
+{
+	if (!link)
+		return false;
+	if (link->replay_settings.config.replay_version == DC_VESA_PANEL_REPLAY)
+		return dp_setup_panel_replay(link, stream);
+	else if (link->replay_settings.config.replay_version == DC_FREESYNC_REPLAY)
+		return edp_setup_freesync_replay(link, stream);
+	else
+		return false;
+}
+
+bool dp_pr_enable(struct dc_link *link, bool enable)
+{
+	struct dc *dc = link->ctx->dc;
+	unsigned int panel_inst = 0;
+	union dmub_rb_cmd cmd;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	if (link->replay_settings.replay_allow_active != enable) {
+		//for sending PR enable commands to DMUB
+		memset(&cmd, 0, sizeof(cmd));
+
+		cmd.pr_enable.header.type = DMUB_CMD__PR;
+		cmd.pr_enable.header.sub_type = DMUB_CMD__PR_ENABLE;
+		cmd.pr_enable.header.payload_bytes = sizeof(struct dmub_cmd_pr_enable_data);
+		cmd.pr_enable.data.panel_inst = panel_inst;
+		cmd.pr_enable.data.enable = enable ? 1 : 0;
+
+		dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+		link->replay_settings.replay_allow_active = enable;
+	}
+	return true;
+}
+
+bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_context)
+{
+	struct dc *dc = link->ctx->dc;
+	unsigned int panel_inst = 0;
+	union dmub_rb_cmd cmd;
+	struct pipe_ctx *pipe_ctx = NULL;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	for (unsigned int i = 0; i < MAX_PIPES; i++) {
+		if (dc->current_state->res_ctx.pipe_ctx[i].stream &&
+			dc->current_state->res_ctx.pipe_ctx[i].stream->link &&
+			dc->current_state->res_ctx.pipe_ctx[i].stream->link == link &&
+			dc->current_state->res_ctx.pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
+			pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+			//TODO: refactor for multi edp support
+			break;
+		}
+	}
+
+	if (!pipe_ctx)
+		return false;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.pr_copy_settings.header.type = DMUB_CMD__PR;
+	cmd.pr_copy_settings.header.sub_type = DMUB_CMD__PR_COPY_SETTINGS;
+	cmd.pr_copy_settings.header.payload_bytes = sizeof(struct dmub_cmd_pr_copy_settings_data);
+	cmd.pr_copy_settings.data.panel_inst = panel_inst;
+	// HW inst
+	cmd.pr_copy_settings.data.aux_inst = replay_context->aux_inst;
+	cmd.pr_copy_settings.data.digbe_inst = replay_context->digbe_inst;
+	cmd.pr_copy_settings.data.digfe_inst = replay_context->digfe_inst;
+	if (pipe_ctx->plane_res.dpp)
+		cmd.pr_copy_settings.data.dpp_inst = pipe_ctx->plane_res.dpp->inst;
+	else
+		cmd.pr_copy_settings.data.dpp_inst = 0;
+	if (pipe_ctx->stream_res.tg)
+		cmd.pr_copy_settings.data.otg_inst = pipe_ctx->stream_res.tg->inst;
+	else
+		cmd.pr_copy_settings.data.otg_inst = 0;
+
+	cmd.pr_copy_settings.data.dpphy_inst = link->link_enc->transmitter;
+
+	cmd.pr_copy_settings.data.line_time_in_ns = replay_context->line_time_in_ns;
+	cmd.pr_copy_settings.data.flags.bitfields.fec_enable_status = (link->fec_state == dc_link_fec_enabled);
+	cmd.pr_copy_settings.data.flags.bitfields.dsc_enable_status = (pipe_ctx->stream->timing.flags.DSC == 1);
+	cmd.pr_copy_settings.data.debug.u32All = link->replay_settings.config.debug_flags;
+
+	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	return true;
+}
+
+bool dp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data)
+{
+	struct dc *dc = link->ctx->dc;
+	unsigned int panel_inst = 0;
+	union dmub_rb_cmd cmd;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.pr_update_state.header.type = DMUB_CMD__PR;
+	cmd.pr_update_state.header.sub_type = DMUB_CMD__PR_UPDATE_STATE;
+	cmd.pr_update_state.header.payload_bytes = sizeof(struct dmub_cmd_pr_update_state_data);
+	cmd.pr_update_state.data.panel_inst = panel_inst;
+
+	memcpy(&cmd.pr_update_state.data, update_state_data, sizeof(struct dmub_cmd_pr_update_state_data));
+
+	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	return true;
+}
+
+bool dp_pr_set_general_cmd(struct dc_link *link, struct dmub_cmd_pr_general_cmd_data *general_cmd_data)
+{
+	struct dc *dc = link->ctx->dc;
+	unsigned int panel_inst = 0;
+	union dmub_rb_cmd cmd;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.pr_general_cmd.header.type = DMUB_CMD__PR;
+	cmd.pr_general_cmd.header.sub_type = DMUB_CMD__PR_GENERAL_CMD;
+	cmd.pr_general_cmd.header.payload_bytes = sizeof(struct dmub_cmd_pr_general_cmd_data);
+	cmd.pr_general_cmd.data.panel_inst = panel_inst;
+
+	memcpy(&cmd.pr_general_cmd.data, general_cmd_data, sizeof(struct dmub_cmd_pr_general_cmd_data));
+
+	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	return true;
+}
+
+bool dp_pr_get_state(const struct dc_link *link, uint64_t *state)
+{
+	const struct dc *dc = link->ctx->dc;
+	unsigned int panel_inst = 0;
+	uint32_t retry_count = 0;
+	uint32_t replay_state = 0;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	do {
+		// Send gpint command and wait for ack
+		if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__GET_REPLAY_STATE, panel_inst,
+					       &replay_state, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
+			// Return invalid state when GPINT times out
+			replay_state = PR_STATE_INVALID;
+		}
+		/* Copy 32-bit result into 64-bit output */
+		*state = replay_state;
+	} while (++retry_count <= 1000 && *state == PR_STATE_INVALID);
+
+	// Assert if max retry hit
+	if (retry_count >= 1000 && *state == PR_STATE_INVALID) {
+		ASSERT(0);
+		/* To-do: Add retry fail log */
+	}
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.h
new file mode 100644
index 000000000000..b936092edb85
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#ifndef __DC_LINK_DP_PANEL_REPLAY_H__
+#define __DC_LINK_DP_PANEL_REPLAY_H__
+
+#include "link_service.h"
+
+bool dp_setup_replay(struct dc_link *link,
+		const struct dc_stream_state *stream);
+bool dp_pr_enable(struct dc_link *link, bool enable);
+bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_context);
+bool dp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data);
+bool dp_pr_set_general_cmd(struct dc_link *link, struct dmub_cmd_pr_general_cmd_data *general_cmd_data);
+bool dp_pr_get_state(const struct dc_link *link, uint64_t *state);
+
+#endif /* __DC_LINK_DP_PANEL_REPLAY_H__ */
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index d6e91da72ef8..ab047ff556a1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1003,116 +1003,8 @@ bool edp_get_replay_state(const struct dc_link *link, uint64_t *state)
 	return true;
 }
 
-static bool edp_setup_panel_replay(struct dc_link *link, const struct dc_stream_state *stream)
-{
-	/* To-do: Setup Replay */
-	struct dc *dc;
-	struct dmub_replay *replay;
-	int i;
-	unsigned int panel_inst;
-	struct replay_context replay_context = { 0 };
-	unsigned int lineTimeInNs = 0;
-
-	union panel_replay_enable_and_configuration_1 pr_config_1 = { 0 };
-	union panel_replay_enable_and_configuration_2 pr_config_2 = { 0 };
-
-	union dpcd_alpm_configuration alpm_config;
 
-	replay_context.controllerId = CONTROLLER_ID_UNDEFINED;
-
-	if (!link)
-		return false;
-
-	//Clear Panel Replay enable & config
-	dm_helpers_dp_write_dpcd(link->ctx, link,
-		DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_1,
-		(uint8_t *)&(pr_config_1.raw), sizeof(uint8_t));
-
-	dm_helpers_dp_write_dpcd(link->ctx, link,
-		DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_2,
-		(uint8_t *)&(pr_config_2.raw), sizeof(uint8_t));
-
-	if (!(link->replay_settings.config.replay_supported))
-		return false;
-
-	dc = link->ctx->dc;
-
-	//not sure should keep or not
-	replay = dc->res_pool->replay;
-
-	if (!replay)
-		return false;
-
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
-		return false;
-
-	replay_context.aux_inst = link->ddc->ddc_pin->hw_info.ddc_channel;
-	replay_context.digbe_inst = link->link_enc->transmitter;
-	replay_context.digfe_inst = link->link_enc->preferred_engine;
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		if (dc->current_state->res_ctx.pipe_ctx[i].stream
-				== stream) {
-			/* dmcu -1 for all controller id values,
-			 * therefore +1 here
-			 */
-			replay_context.controllerId =
-				dc->current_state->res_ctx.pipe_ctx[i].stream_res.tg->inst + 1;
-			break;
-		}
-	}
-
-	lineTimeInNs =
-		((stream->timing.h_total * 1000000) /
-			(stream->timing.pix_clk_100hz / 10)) + 1;
-
-	replay_context.line_time_in_ns = lineTimeInNs;
-
-	link->replay_settings.replay_feature_enabled = edp_pr_copy_settings(link, &replay_context);
-
-	if (link->replay_settings.replay_feature_enabled) {
-		pr_config_1.bits.PANEL_REPLAY_ENABLE = 1;
-		pr_config_1.bits.PANEL_REPLAY_CRC_ENABLE = 1;
-		pr_config_1.bits.IRQ_HPD_ASSDP_MISSING = 1;
-		pr_config_1.bits.IRQ_HPD_VSCSDP_UNCORRECTABLE_ERROR = 1;
-		pr_config_1.bits.IRQ_HPD_RFB_ERROR = 1;
-		pr_config_1.bits.IRQ_HPD_ACTIVE_FRAME_CRC_ERROR = 1;
-		pr_config_1.bits.PANEL_REPLAY_SELECTIVE_UPDATE_ENABLE = 1;
-		pr_config_1.bits.PANEL_REPLAY_EARLY_TRANSPORT_ENABLE = 1;
-
-		pr_config_2.bits.SINK_REFRESH_RATE_UNLOCK_GRANTED = 0;
-		pr_config_2.bits.SU_Y_GRANULARITY_EXT_VALUE_ENABLED = 0;
-		pr_config_2.bits.SU_REGION_SCAN_LINE_CAPTURE_INDICATION = 0;
-
-		dm_helpers_dp_write_dpcd(link->ctx, link,
-			DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_1,
-			(uint8_t *)&(pr_config_1.raw), sizeof(uint8_t));
-
-		dm_helpers_dp_write_dpcd(link->ctx, link,
-			DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_2,
-			(uint8_t *)&(pr_config_2.raw), sizeof(uint8_t));
-
-		//ALPM Setup
-		memset(&alpm_config, 0, sizeof(alpm_config));
-		alpm_config.bits.ENABLE = link->replay_settings.config.alpm_mode != DC_ALPM_UNSUPPORTED ? 1 : 0;
-
-		if (link->replay_settings.config.alpm_mode == DC_ALPM_AUXLESS) {
-			alpm_config.bits.ALPM_MODE_SEL = 1;
-			alpm_config.bits.ACDS_PERIOD_DURATION = 1;
-		}
-
-		dm_helpers_dp_write_dpcd(
-			link->ctx,
-			link,
-			DP_RECEIVER_ALPM_CONFIG,
-			&alpm_config.raw,
-			sizeof(alpm_config.raw));
-	}
-
-	return true;
-}
-
-static bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_state *stream)
+bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_state *stream)
 {
 	/* To-do: Setup Replay */
 	struct dc *dc;
@@ -1208,17 +1100,6 @@ static bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stre
 	return true;
 }
 
-bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream)
-{
-	if (!link)
-		return false;
-	if (link->replay_settings.config.replay_version == DC_VESA_PANEL_REPLAY)
-		return edp_setup_panel_replay(link, stream);
-	else if (link->replay_settings.config.replay_version == DC_FREESYNC_REPLAY)
-		return edp_setup_freesync_replay(link, stream);
-	else
-		return false;
-}
 
 /*
  * This is general Interface for Replay to set an 32 bit variable to dmub
@@ -1323,156 +1204,6 @@ bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
 	return true;
 }
 
-bool edp_pr_enable(struct dc_link *link, bool enable)
-{
-	struct dc  *dc = link->ctx->dc;
-	unsigned int panel_inst = 0;
-	union dmub_rb_cmd cmd;
-
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
-		return false;
-
-	if (link->replay_settings.replay_allow_active != enable) {
-		//for sending PR enable commands to DMUB
-		memset(&cmd, 0, sizeof(cmd));
-
-		cmd.pr_enable.header.type = DMUB_CMD__PR;
-		cmd.pr_enable.header.sub_type = DMUB_CMD__PR_ENABLE;
-		cmd.pr_enable.header.payload_bytes = sizeof(struct dmub_cmd_pr_enable_data);
-		cmd.pr_enable.data.panel_inst = panel_inst;
-		cmd.pr_enable.data.enable = enable ? 1 : 0;
-
-		dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
-
-		link->replay_settings.replay_allow_active = enable;
-	}
-	return true;
-}
-
-bool edp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_context)
-{
-	struct dc  *dc = link->ctx->dc;
-	unsigned int panel_inst = 0;
-	union dmub_rb_cmd cmd;
-	struct pipe_ctx *pipe_ctx = NULL;
-
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
-		return false;
-
-	for (unsigned int i = 0; i < MAX_PIPES; i++) {
-		if (dc->current_state->res_ctx.pipe_ctx[i].stream &&
-			dc->current_state->res_ctx.pipe_ctx[i].stream->link &&
-			dc->current_state->res_ctx.pipe_ctx[i].stream->link == link &&
-			dc->current_state->res_ctx.pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
-			pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
-			//TODO: refactor for multi edp support
-			break;
-		}
-	}
-
-	if (!pipe_ctx)
-		return false;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.pr_copy_settings.header.type = DMUB_CMD__PR;
-	cmd.pr_copy_settings.header.sub_type = DMUB_CMD__PR_COPY_SETTINGS;
-	cmd.pr_copy_settings.header.payload_bytes = sizeof(struct dmub_cmd_pr_copy_settings_data);
-	cmd.pr_copy_settings.data.panel_inst = panel_inst;
-	// HW inst
-	cmd.pr_copy_settings.data.aux_inst = replay_context->aux_inst;
-	cmd.pr_copy_settings.data.digbe_inst = replay_context->digbe_inst;
-	cmd.pr_copy_settings.data.digfe_inst = replay_context->digfe_inst;
-	if (pipe_ctx->plane_res.dpp)
-		cmd.pr_copy_settings.data.dpp_inst = pipe_ctx->plane_res.dpp->inst;
-	else
-		cmd.pr_copy_settings.data.dpp_inst = 0;
-	if (pipe_ctx->stream_res.tg)
-		cmd.pr_copy_settings.data.otg_inst = pipe_ctx->stream_res.tg->inst;
-	else
-		cmd.pr_copy_settings.data.otg_inst = 0;
-
-	cmd.pr_copy_settings.data.dpphy_inst = link->link_enc->transmitter;
-
-	cmd.pr_copy_settings.data.line_time_in_ns = replay_context->line_time_in_ns;
-	cmd.pr_copy_settings.data.flags.bitfields.fec_enable_status = (link->fec_state == dc_link_fec_enabled);
-	cmd.pr_copy_settings.data.flags.bitfields.dsc_enable_status = (pipe_ctx->stream->timing.flags.DSC == 1);
-	cmd.pr_copy_settings.data.debug.u32All = link->replay_settings.config.debug_flags;
-
-	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
-	return true;
-}
-
-bool edp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data)
-{
-	struct dc  *dc = link->ctx->dc;
-	unsigned int panel_inst = 0;
-	union dmub_rb_cmd cmd;
-
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
-		return false;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.pr_update_state.header.type = DMUB_CMD__PR;
-	cmd.pr_update_state.header.sub_type = DMUB_CMD__PR_UPDATE_STATE;
-	cmd.pr_update_state.header.payload_bytes = sizeof(struct dmub_cmd_pr_update_state_data);
-	cmd.pr_update_state.data.panel_inst = panel_inst;
-
-	memcpy(&cmd.pr_update_state.data, update_state_data, sizeof(struct dmub_cmd_pr_update_state_data));
-
-	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
-	return true;
-}
-
-bool edp_pr_set_general_cmd(struct dc_link *link, struct dmub_cmd_pr_general_cmd_data *general_cmd_data)
-{
-	struct dc  *dc = link->ctx->dc;
-	unsigned int panel_inst = 0;
-	union dmub_rb_cmd cmd;
-
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
-		return false;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.pr_general_cmd.header.type = DMUB_CMD__PR;
-	cmd.pr_general_cmd.header.sub_type = DMUB_CMD__PR_GENERAL_CMD;
-	cmd.pr_general_cmd.header.payload_bytes = sizeof(struct dmub_cmd_pr_general_cmd_data);
-	cmd.pr_general_cmd.data.panel_inst = panel_inst;
-
-	memcpy(&cmd.pr_general_cmd.data, general_cmd_data, sizeof(struct dmub_cmd_pr_general_cmd_data));
-
-	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
-	return true;
-}
-
-bool edp_pr_get_state(const struct dc_link *link, uint64_t *state)
-{
-	const struct dc  *dc = link->ctx->dc;
-	unsigned int panel_inst = 0;
-	uint32_t retry_count = 0;
-	uint32_t replay_state = 0;
-
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
-		return false;
-
-	do {
-		// Send gpint command and wait for ack
-		if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__GET_REPLAY_STATE, panel_inst,
-					       &replay_state, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
-			// Return invalid state when GPINT times out
-			replay_state = PR_STATE_INVALID;
-		}
-		/* Copy 32-bit result into 64-bit output */
-		*state = replay_state;
-	} while (++retry_count <= 1000 && *state == PR_STATE_INVALID);
-
-	// Assert if max retry hit
-	if (retry_count >= 1000 && *state == PR_STATE_INVALID) {
-		ASSERT(0);
-		/* To-do: Add retry fail log */
-	}
-
-	return true;
-}
 
 static struct abm *get_abm_from_stream_res(const struct dc_link *link)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index fd63b5d0f948..8780bbc4e8c5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -54,8 +54,6 @@ bool edp_set_sink_vtotal_in_psr_active(const struct dc_link *link,
 void edp_get_psr_residency(const struct dc_link *link, uint32_t *residency, enum psr_residency_mode mode);
 bool edp_set_replay_allow_active(struct dc_link *dc_link, const bool *enable,
 	bool wait, bool force_static, const unsigned int *power_opts);
-bool edp_setup_replay(struct dc_link *link,
-		const struct dc_stream_state *stream);
 bool edp_send_replay_cmd(struct dc_link *link,
 			enum replay_FW_Message_type msg,
 			union dmub_replay_cmd_set *cmd_data);
@@ -75,11 +73,7 @@ void edp_add_delay_for_T9(struct dc_link *link);
 bool edp_receiver_ready_T9(struct dc_link *link);
 bool edp_receiver_ready_T7(struct dc_link *link);
 bool edp_power_alpm_dpcd_enable(struct dc_link *link, bool enable);
-bool edp_pr_enable(struct dc_link *link, bool enable);
-bool edp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_context);
-bool edp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data);
-bool edp_pr_set_general_cmd(struct dc_link *link, struct dmub_cmd_pr_general_cmd_data *general_cmd_data);
-bool edp_pr_get_state(const struct dc_link *link, uint64_t *state);
+bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_state *stream);
 void edp_set_panel_power(struct dc_link *link, bool powerOn);
 void edp_set_panel_assr(struct dc_link *link, struct pipe_ctx *pipe_ctx,
 		enum dp_panel_mode *panel_mode, bool enable);
-- 
2.52.0

