Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980DBCCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6B410E701;
	Wed, 22 Oct 2025 07:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uaxxQ/Dl";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2246E10E6FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoQSwMJhlEMU8daDOZvNIMLpohhhJn9y8SPmw3dvKxafC4qNJs9vxDGvOMuDq/KF7nPXpaM4nAvI611E8FBZj2eC1z2/fG83jy2a1GEXW3oLYjD+BRUYPAQxnvXKcvh6TSpZ8rF4lerDHe4Sav8vVewHh2G4wH+cGzCxpK1LFJqvFGRqoq+DH31yz0H15e+7bUwYTvNLhY5Hk1xQQhn6aixzMDby5k4vKJ0GIiEeUJz+KOlPkmZz8/3P4wJwZQIlw635SLniJiVbU6JcwC3AV0nKlZMnQFpMxVFZ2YSlgNCognEPGDKpiHRTjOUfr7moHzsRAmjAAO2srruG7BbiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCbE8PmyObT8vOWBU9ApYBHSRmqAcc++CyoqwIUypxA=;
 b=rXImcv18PRyOTgVYHRElcqZUDpJ3pqkfaNdwkCtlCOzZ37USHgHDOh8hpOU0vP4GIgNlU8Bl21nCbc30Gb8C91fl4aSJ+qMW5blt7VCUHTPeX56jCFqbDwIJANw0bPNFnAOvgbWsj9JU1qySCdEEPzcY5aXctplnteaFjHL/erIvph6+2uIwVorsJJXYn8/k2yMAnA/uuRc5aaJFpE9aDEB9NhdDE6Xq19XaEFqC/eqYWTHl+98msyAykFHpqaaiIDyp1TXc/+QBJnPfWS9YPNGRf9n5CSPlz0Wwo2nKV/0bNS0CiY8P0cEObkDAq6NWJMtNg+2cRDPEO5Zx1PyARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCbE8PmyObT8vOWBU9ApYBHSRmqAcc++CyoqwIUypxA=;
 b=uaxxQ/DliswOaxO65cbg4KKaxgTB/DoyFxV1+aXQt00Dag6cLfZpM3SqBeWdMosBFlkKYxKbQC9ChHyYkAz6S3GGoSLgVFhJWsyr0FMOMgzIH71QmbLgdS/T+9OBF8mP0IscP/F6pJcwJzHOqdmiHfgkgD8wTprjjqGqxstIArk=
Received: from DM5PR08CA0060.namprd08.prod.outlook.com (2603:10b6:4:60::49) by
 CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:34:58 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::1e) by DM5PR08CA0060.outlook.office365.com
 (2603:10b6:4:60::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:34:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:34:57 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:34:57 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:34:54 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Cruise Hung <cruise.hung@amd.com>
Subject: [PATCH 13/20] drm/amd/display: Add dc interface to log pre os
 firmware information
Date: Wed, 22 Oct 2025 15:30:25 +0800
Message-ID: <20251022073332.666119-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f5aafd-e3ec-4a58-ef29-08de113d80bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Ysx6aVTq772y03zCORbYY5rjAnicf21L1Ial/yin1qMAq0sRGv+5PaczkkV?=
 =?us-ascii?Q?s0qYo54Tn+fWyNd5ei8Z4Ip7y3pabZeEWpegcdW/CMwihA4pfqZksosrQOcQ?=
 =?us-ascii?Q?LbUdcMz+fMlH+MmuMugDOysEXcuZTlZUrTbbtDDuzrifqLCh2GMHI2sOi754?=
 =?us-ascii?Q?0d/0MiFcI9Gh/MG6qG+FbBwExvga7NUfEj4C4aiu8Qp3/rPpX38yQcgI+0+Z?=
 =?us-ascii?Q?PuiGF8ieTxPjRx7Mk3rAM/rt95K6ZwWk0yKRe7Ff7JG7z8OnMD6uYhWcvrec?=
 =?us-ascii?Q?vf41lwQO2IZeKevwkt1DLoIqGASGI2/UQDDjBTp/zFqcU2rX9J5/R65oucvB?=
 =?us-ascii?Q?ElQlOyFl0AeOtbwlECaGtfkvUOSpK3dE3KQdS5OD/27PEa39hgaiOEHC0xPr?=
 =?us-ascii?Q?jQOJZ9poZHQ8/iDrJMsfLNrAbgikHLrwUCiwgc2CRoqE1Gxm/s+wHLsomEnL?=
 =?us-ascii?Q?ga1eFDAb/74h5tPwIxuxQhgKjZNQcsNaXRFpuOF2RMwlr7BqjfOsei/ZjqBY?=
 =?us-ascii?Q?m2Ik23qt9G8T5QjH7ZQ3ZsiHEmeDENbAR9wK+/GcvWgRrAc+StnS/VgnnEj6?=
 =?us-ascii?Q?EnL/0wNV282Lwec07UDrdij3AWbBrqDRloQ1p4vVH3XYRpXpRRUCvR2KIpmL?=
 =?us-ascii?Q?AUvQu5/ckrmovUl2Gk0MH77T5/+YlWpP/Kx+0UR3XVF7NiYAOJHGPtfv55Hi?=
 =?us-ascii?Q?gBhItZR5VVThmZDaKxoclFcc65BulBN9hRUKYj0gKBto7qFCHo5NFAMkABgS?=
 =?us-ascii?Q?oOF3vA4MF/UQJtsAO0qt5giqx72d47hfBT6UZo/eE6XtDXzp42jOI+DmWEh3?=
 =?us-ascii?Q?AEVjYLlBmGIFqg5rfujocJOeu0H4MKLxtztxilEwm3vT8F+l27saLc//foU8?=
 =?us-ascii?Q?K5kkyVoTjpe2HzVEIBQ2cZtdkgZX6OiyEdJwNXRpXhvAGuawqnZJ4o/PNEn5?=
 =?us-ascii?Q?X2MnnfCnfnwX61nQ0BhrG6LYyDwVFBZOS7L47o7Fa8lkn/hGdUGyiCEu91O6?=
 =?us-ascii?Q?6xmD4SU255mujuRhai3DYB/X/E/8i76lDpyQQVg71lRLRW0V4wuRIS4vtXgV?=
 =?us-ascii?Q?/9ixShvQ2TclR00oQozi3uNx4AvbjwExL2UEWm+TsGBmjqFtk+mzSlRFoF37?=
 =?us-ascii?Q?RCquYs5sWuevcGYm8+f8QfcMjAjII2CLA3qA6g/JPIxrCMd0Kon/Hs9ADxgA?=
 =?us-ascii?Q?8BHpZgkVGDqXuBWdnYCrh1gM3ewZDlB4oPkQUlSZXlJovg+jwOBUBwZhcLOR?=
 =?us-ascii?Q?4wSMRir5R1ba8xDdyCpjV7iFGbS29wmDjpGu5uKziQVVgMxeRdWTV8saMS1h?=
 =?us-ascii?Q?0AHYwi4XaDbptAlz8HxpXcdgh/JInLJm5qRkTbOudkPNQm3OxBoMm9xWr9Q8?=
 =?us-ascii?Q?PmeOeKhUULxYinOrZmTtr/8j0LDXBit1B+7gXxWnhXyNf51Yb92EB7mU4oVk?=
 =?us-ascii?Q?XOCkz+BeVHsh/O4qCRCJbVWt8KhR9/exauNk7dl2LDZ+qwZ+PPDSBHaPJ7dH?=
 =?us-ascii?Q?cwJN76qRt+n9OwiszfztJuFfKfwpJvcUV+vd8658f80ai3YOCEAuCTAxugP4?=
 =?us-ascii?Q?oLr9l+gb3NasdMm2irMztmD3tE1P2gpku9PLcug0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:34:58.3123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f5aafd-e3ec-4a58-ef29-08de113d80bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Pre os firmware information is useful to debug pre os to post os fw
transition issues.

[How]
Add dc interface dc_log_preos_dmcub_info() to log pre os firmware
information.

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 21 ++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  7 ++++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 25 ++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 39 +++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h |  2 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  9 +++++
 8 files changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2eb02345dadd..6ef9dd9ab7a3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6401,3 +6401,8 @@ void dc_get_underflow_debug_data_for_otg(struct dc *dc, int primary_otg_inst,
 	if (dc->hwss.get_underflow_debug_data)
 		dc->hwss.get_underflow_debug_data(dc, tg, out_data);
 }
+
+void dc_log_preos_dmcub_info(const struct dc *dc)
+{
+	dc_dmub_srv_log_preos_dmcub_info(dc->ctx->dmub_srv);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b80bcbf7ae13..82ce1fbec7d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2727,6 +2727,8 @@ unsigned int dc_get_det_buffer_size_from_state(const struct dc_state *context);
 
 bool dc_get_host_router_index(const struct dc_link *link, unsigned int *host_router_index);
 
+void dc_log_preos_dmcub_info(const struct dc *dc);
+
 /* DSC Interfaces */
 #include "dc_dsc.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 4b20c01bf646..fffbf1983143 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -2344,3 +2344,24 @@ void dc_dmub_srv_release_hw(const struct dc *dc)
 
 	dm_execute_dmub_cmd(dc->ctx, &cmd,  DM_DMUB_WAIT_TYPE_WAIT);
 }
+
+void dc_dmub_srv_log_preos_dmcub_info(struct dc_dmub_srv *dc_dmub_srv)
+{
+	struct dmub_srv *dmub;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return;
+
+	dmub = dc_dmub_srv->dmub;
+
+	if (dmub_srv_get_preos_info(dmub)) {
+		DC_LOG_DEBUG("%s: PreOS DMCUB Info", __func__);
+		DC_LOG_DEBUG("fw_version				: 0x%08x", dmub->preos_info.fw_version);
+		DC_LOG_DEBUG("boot_options				: 0x%08x", dmub->preos_info.boot_options);
+		DC_LOG_DEBUG("boot_status				: 0x%08x", dmub->preos_info.boot_status);
+		DC_LOG_DEBUG("trace_buffer_phy_addr		: 0x%016llx", dmub->preos_info.trace_buffer_phy_addr);
+		DC_LOG_DEBUG("trace_buffer_size_bytes	: 0x%08x", dmub->preos_info.trace_buffer_size);
+		DC_LOG_DEBUG("fb_base					: 0x%016llx", dmub->preos_info.fb_base);
+		DC_LOG_DEBUG("fb_offset					: 0x%016llx", dmub->preos_info.fb_offset);
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 9bb00d48fd5e..72e0a41f39f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -367,4 +367,11 @@ bool dc_dmub_srv_is_cursor_offload_enabled(const struct dc *dc);
  * @dc - pointer to DC object
  */
 void dc_dmub_srv_release_hw(const struct dc *dc);
+
+/**
+ * dc_dmub_srv_log_preos_dmcub_info() - Logs preos dmcub fw info.
+ *
+ * @dc - pointer to DC object
+ */
+void dc_dmub_srv_log_preos_dmcub_info(struct dc_dmub_srv *dc_dmub_srv);
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index f25c2fc2f98f..9d0168986fe7 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -363,6 +363,19 @@ struct dmub_diagnostic_data {
 	uint8_t is_pwait : 1;
 };
 
+/**
+ * struct dmub_preos_info - preos fw info before loading post os fw.
+ */
+struct dmub_preos_info {
+	uint64_t fb_base;
+	uint64_t fb_offset;
+	uint64_t trace_buffer_phy_addr;
+	uint32_t trace_buffer_size;
+	uint32_t fw_version;
+	uint32_t boot_status;
+	uint32_t boot_options;
+};
+
 struct dmub_srv_inbox {
 	/* generic status */
 	uint64_t num_submitted;
@@ -488,6 +501,7 @@ struct dmub_srv_hw_funcs {
 	uint32_t (*get_current_time)(struct dmub_srv *dmub);
 
 	void (*get_diagnostic_data)(struct dmub_srv *dmub);
+	bool (*get_preos_fw_info)(struct dmub_srv *dmub);
 
 	bool (*should_detect)(struct dmub_srv *dmub);
 	void (*init_reg_offsets)(struct dmub_srv *dmub, struct dc_context *ctx);
@@ -588,6 +602,7 @@ struct dmub_srv {
 	enum dmub_srv_power_state_type power_state;
 	struct dmub_diagnostic_data debug;
 	struct dmub_fb lsdma_rb_fb;
+	struct dmub_preos_info preos_info;
 };
 
 /**
@@ -1073,4 +1088,14 @@ enum dmub_status dmub_srv_wait_for_inbox_free(struct dmub_srv *dmub,
  */
 enum dmub_status dmub_srv_update_inbox_status(struct dmub_srv *dmub);
 
+/**
+ * dmub_srv_get_preos_info() - retrieves preos fw info
+ * @dmub: the dmub service
+ *
+ * Return:
+ *   true - preos fw info retrieved successfully
+ *   false - preos fw info not retrieved successfully
+ */
+bool dmub_srv_get_preos_info(struct dmub_srv *dmub);
+
 #endif /* _DMUB_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index b40482dbd6ad..e13557ed97be 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -521,6 +521,45 @@ void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub)
 
 	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
+
+bool dmub_dcn35_get_preos_fw_info(struct dmub_srv *dmub)
+{
+	uint64_t region3_cw5_offset;
+	uint32_t top_addr, top_addr_enable, offset_low;
+	uint32_t offset_high, base_addr, fw_version;
+	bool is_vbios_fw = false;
+
+	memset(&dmub->preos_info, 0, sizeof(dmub->preos_info));
+
+	fw_version = REG_READ(DMCUB_SCRATCH1);
+	is_vbios_fw = ((fw_version >> 6) & 0x01) ? true : false;
+	if (!is_vbios_fw)
+		return false;
+
+	dmub->preos_info.boot_status = REG_READ(DMCUB_SCRATCH0);
+	dmub->preos_info.fw_version = REG_READ(DMCUB_SCRATCH1);
+	dmub->preos_info.boot_options = REG_READ(DMCUB_SCRATCH14);
+	REG_GET(DMCUB_REGION3_CW5_TOP_ADDRESS,
+		DMCUB_REGION3_CW5_ENABLE, &top_addr_enable);
+	if (top_addr_enable) {
+		dmub_dcn35_get_fb_base_offset(dmub,
+			&dmub->preos_info.fb_base, &dmub->preos_info.fb_offset);
+		offset_low = REG_READ(DMCUB_REGION3_CW5_OFFSET);
+		offset_high = REG_READ(DMCUB_REGION3_CW5_OFFSET_HIGH);
+		region3_cw5_offset = ((uint64_t)offset_high << 32) | offset_low;
+		dmub->preos_info.trace_buffer_phy_addr = region3_cw5_offset
+			- dmub->preos_info.fb_base + dmub->preos_info.fb_offset;
+
+		REG_GET(DMCUB_REGION3_CW5_TOP_ADDRESS,
+			DMCUB_REGION3_CW5_TOP_ADDRESS, &top_addr);
+		base_addr = REG_READ(DMCUB_REGION3_CW5_BASE_ADDRESS) & 0x1FFFFFFF;
+		dmub->preos_info.trace_buffer_size =
+			(top_addr > base_addr) ? (top_addr - base_addr + 1) : 0;
+	}
+
+	return true;
+}
+
 void dmub_dcn35_configure_dmub_in_system_memory(struct dmub_srv *dmub)
 {
 	/* DMCUB_REGION3_TMR_AXI_SPACE values:
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
index 39fcb7275da5..92e6695a2c9b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
@@ -285,4 +285,6 @@ bool dmub_dcn35_is_hw_powered_up(struct dmub_srv *dmub);
 
 void dmub_srv_dcn35_regs_init(struct dmub_srv *dmub, struct dc_context *ctx);
 
+bool dmub_dcn35_get_preos_fw_info(struct dmub_srv *dmub);
+
 #endif /* _DMUB_DCN35_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 0244c9b44ecc..a657efda89ce 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -359,6 +359,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 
 			funcs->get_current_time = dmub_dcn35_get_current_time;
 			funcs->get_diagnostic_data = dmub_dcn35_get_diagnostic_data;
+			funcs->get_preos_fw_info = dmub_dcn35_get_preos_fw_info;
 
 			funcs->init_reg_offsets = dmub_srv_dcn35_regs_init;
 			if (asic == DMUB_ASIC_DCN351)
@@ -1372,3 +1373,11 @@ enum dmub_status dmub_srv_update_inbox_status(struct dmub_srv *dmub)
 
 	return DMUB_STATUS_OK;
 }
+
+bool dmub_srv_get_preos_info(struct dmub_srv *dmub)
+{
+	if (!dmub || !dmub->hw_funcs.get_preos_fw_info)
+		return false;
+
+	return dmub->hw_funcs.get_preos_fw_info(dmub);
+}
-- 
2.43.0

