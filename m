Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9ED4C282D2
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 13:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CDBB10E40F;
	Mon,  3 Mar 2025 13:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3dwC99gy";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6EEC10E40F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 13:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3eozcu8bdsjNK78Y/G/3sDIaSBoyZkvIna85CqaiILnqDazUoXboeiS/eAsY40+TTBwVq7OuiXrIpVVhKjy7QX2b13bz8BzMB95fhDHjmdopJCxUKHHA2+3J21dUqqGzWv3BNmB/oisesTqrHmgUtHs+zKtx4lnfwPN+jiF/k9NA+oBfHuPFv+O+V5hFUhgmm0M7QTlb0GaaXAuvGj++4md1P9YuLidtHIwzU8JbJmDUHyj4nrTWTeK7HafV3VuzebFcKlFeTA0ZWi0MN7TAFvdoWF04q6hvBh3CSTmTJCD5bEDvxLw/HdgBgQfHuprlqEkN3336/6fDQILKUGW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r/hHOd0Glr2mUYGhRi5WvD4Wcm/ZPH7skBZrsH2FTE=;
 b=TSiPjFG6pFz+n+JT2fCLo8rLH6zE++Pngw+6yV4GmqR8r4xKwE3LTzkaU61bddhd9+Cs7PFcLdUvr11rdsaV0IzsOSovTIwytF+hUuymj/HF/q20BQYHd6NPU0R5t6yuDt0E1IThmGIHNNfZ13gn+yCQYh7LPc4Fd5D3Ha2A9fFcEPzAMizeUJ45Xi8+YXlI6wk+ThVig9SlWyjFTDBNkY/aTNWn3PNmvpZVvv9BceaD8usl+9EeISJ3lO9WVkMC6mPBwcUWgLKl/q+juFWndKzJNgM3KkK9nTd533R9GAOtQ4bnlVRY6EdUIU7/ZnGA07UEZ6bZO215xa7bqmDiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r/hHOd0Glr2mUYGhRi5WvD4Wcm/ZPH7skBZrsH2FTE=;
 b=3dwC99gyBRUEtoUEEX2npF6p1xctTkWBFDvNfQxSgCQvrC3So/o17NKhEPvRTgoxy6YYBM5/0If/qWaRZ7kzyMNlFGTkFlkMIdZ/0hDOzDFM/e6RInXaqLZxu7HK/FCiK6LyN8BiLpekk82r6phWmCseMD7D7Gg15Dcqsoe5gb8=
Received: from MN2PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:160::29)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 13:50:59 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:160:cafe::bc) by MN2PR13CA0016.outlook.office365.com
 (2603:10b6:208:160::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.14 via Frontend Transport; Mon,
 3 Mar 2025 13:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.4 via Frontend Transport; Mon, 3 Mar 2025 13:50:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 07:50:57 -0600
Received: from aaurabin-cachy.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 3 Mar 2025 07:50:57 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <alex.hung@amd.com>,
 <aurabindo.pillai@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Add a temp w/a for a panel
Date: Mon, 3 Mar 2025 08:50:50 -0500
Message-ID: <20250303135051.1177406-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b26899-f977-4f78-c2b5-08dd5a5a6d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ovLWSf96ZBXDxECPctTTlokPZmh44jzesnzu5T5Poe25NzLNszxiYEKRTR2d?=
 =?us-ascii?Q?f04oqzjQW8I0Q0zsMaXKzHA9K98iWW6yVH5O+uvT0BbHeugyqH0w0vVuARGw?=
 =?us-ascii?Q?dwy3lfwXcFdG1Su8nsSYRpoyWTkY1OPQF7jGz33W9AYZ50o0GrNUD1IRUtpo?=
 =?us-ascii?Q?M8yLqeI1AUR/572SOkjp9YJhY98ekzxZ2MtAkkXZyT3gTKk58zsLeov1vQxO?=
 =?us-ascii?Q?wW4QT/5lEitgjU5vZ9b3h/w90mNWEpFKAgRC/c2UK+5YwhhkRmF26iooSA/J?=
 =?us-ascii?Q?VhB6Hco0iwV+dsJHIhP/McKAWvppNwcXLez914Ik0061gnzfOLeGEAtRDnar?=
 =?us-ascii?Q?GtS5ENN9meijfoT9gRQ9VqghWehp9Bif3RLAFizQN666KSSEG8qLT+xxo+5T?=
 =?us-ascii?Q?PtC6AGOtL2IgUOgqKdmwdSkpx6KTVkzvcNjxHl+VcQw/BzQNABQIx1OWoPlk?=
 =?us-ascii?Q?4Qo1tRf4mPsglCjKvDGF4cr66B4OP9yrUF4njU9JsePgKsTc9fBtSFYaYa9N?=
 =?us-ascii?Q?I/W8CI8XPpRZmEbY/7+FlnwRywarpJvIEWNf+eI5p8jjtUgw0TXNPZsS8vgl?=
 =?us-ascii?Q?N2qoi+2I7az7bwDbjeA9ofBIJHv7JvRWj33k5Ol2CnmPs6TIJbWIRmNgCbWg?=
 =?us-ascii?Q?G+WIU6+LRtgWXul9I8ydcbOfK1PzWnALfHetwQ+/+M7xLwSNoBMZEyAq9GwJ?=
 =?us-ascii?Q?PqEhLUBCvqwxrEISlbc3ycoPPM65gUsE06/D+dpiSby4gptNBc45JVTutxLp?=
 =?us-ascii?Q?5rdhsB3Yp6kiTuz2JEpIeFyAmpWVxDNGQYvYZFjbHGG+FuaU9JLU0x15l37I?=
 =?us-ascii?Q?5Djogv8474BxXlfwsaX/Adxdt8soJLOSwWn1TFzJNdDOD1MUqKZZAIoE3/Yf?=
 =?us-ascii?Q?M0FsYtsmVdBCUjZ+Hr/G1dHZjC9bigvfuqKFRCM8L4Al/USmDZA6mphEvaYU?=
 =?us-ascii?Q?dfUTgcRSwPM9xNbHHh6RCIWJAg/F/cW6l32LpGhIzatuhrDxMKrytYZmGALe?=
 =?us-ascii?Q?pjDR4qD6OAcykZCSpywtZBmp+VPMI8aUVJW7CDV6wrVODpN2AtU+FzzABTnX?=
 =?us-ascii?Q?IvuTcJjDNqtBQn07r2D/7S4TrXA1OimHAGU2JsOShM190JAgYewNer4BG/P3?=
 =?us-ascii?Q?+/RwUZmi1xghRZnfYHIR5F+b6NZbuH+nUYzFxiKzTl+sM/xP9Pk7AYl6iZUA?=
 =?us-ascii?Q?9caxG4oQJ3TeBYuUxIWFKTeHgUwSTgyj4+rGg3HkLIzImGJYM9aPcZZ5sAsn?=
 =?us-ascii?Q?DOvdjcx9RkgNFRqhuZBZd3NIZLCFoC7xrB3xg6KJKxHsvNSVkMM1zMNYHkaS?=
 =?us-ascii?Q?3kn6w5j7UHtAo0vPzLUVmxi6MyLHqI5ojLoWnnWegwIzL3A81+Rnnr5CQC4j?=
 =?us-ascii?Q?9OTkpqmNYtfILaW0htj2yOuXvhuihtFOyvw2M854tSxJGp4RL6RcjaDvIlOS?=
 =?us-ascii?Q?lZ33klEPPZQfD/oH5o3wnNgZxHJEIpn0kvVdDzNQHOsARmBzmVmKUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:50:58.3324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b26899-f977-4f78-c2b5-08dd5a5a6d4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
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

Implement w/a for a panel which requires 10s delay after link detect.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 10 ++++++--
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 73c95c3c39f9..3a2843e3367e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3327,6 +3327,21 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	}
 }
 
+static void apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev, struct dc_sink *sink) {
+	struct dc_panel_patch *ppatch = NULL;
+
+	if (!sink)
+		return;
+
+	ppatch = &sink->edid_caps.panel_patch;
+	if (ppatch->wait_after_dpcd_poweroff_ms) {
+		msleep(ppatch->wait_after_dpcd_poweroff_ms);
+		drm_dbg_driver(adev_to_drm(adev), "%s: adding a %ds delay as w/a for panel\n",
+				__func__,
+				ppatch->wait_after_dpcd_poweroff_ms / 1000);
+	}
+}
+
 static int dm_resume(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -3448,6 +3463,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	/* Do detection*/
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+		bool ret;
 
 		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 			continue;
@@ -3473,7 +3489,11 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		} else {
 			guard(mutex)(&dm->dc_lock);
 			dc_exit_ips_for_hw_access(dm->dc);
-			dc_link_detect(aconnector->dc_link, DETECT_REASON_RESUMEFROMS3S4);
+			ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_RESUMEFROMS3S4);
+			if (ret) {
+				/* w/a delay for certain panels */
+				apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
+			}
 		}
 
 		if (aconnector->fake_enable && aconnector->dc_link->local_sink)
@@ -3834,6 +3854,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 			ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
 		}
 		if (ret) {
+			/* w/a delay for certain panels */
+			apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
 			amdgpu_dm_update_connector_after_detect(aconnector);
 
 			drm_modeset_lock_all(dev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index fbd80d8545a8..253aac93e3d8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -55,11 +55,16 @@ static u32 edid_extract_panel_id(struct edid *edid)
 	       (u32)EDID_PRODUCT_ID(edid);
 }
 
-static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
+static void apply_edid_quirks(struct drm_device *dev, struct edid *edid, struct dc_edid_caps *edid_caps)
 {
 	uint32_t panel_id = edid_extract_panel_id(edid);
 
 	switch (panel_id) {
+	/* Workaround for monitors that need a delay after detecting the link */
+	case drm_edid_encode_panel_id('G', 'B', 'T', 0x3215):
+		drm_dbg_driver(dev, "Add 10s delay for link detection for panel id %X\n", panel_id);
+		edid_caps->panel_patch.wait_after_dpcd_poweroff_ms = 10000;
+		break;
 	/* Workaround for some monitors which does not work well with FAMS */
 	case drm_edid_encode_panel_id('S', 'A', 'M', 0x0E5E):
 	case drm_edid_encode_panel_id('S', 'A', 'M', 0x7053):
@@ -101,6 +106,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
 	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
 	struct edid *edid_buf = edid ? (struct edid *) edid->raw_edid : NULL;
 	struct cea_sad *sads;
 	int sad_count = -1;
@@ -130,7 +136,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
-	apply_edid_quirks(edid_buf, edid_caps);
+	apply_edid_quirks(dev, edid_buf, edid_caps);
 
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
 	if (sad_count <= 0)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index e60898c2df01..acd3b373a18e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -181,6 +181,7 @@ struct dc_panel_patch {
 	uint8_t blankstream_before_otg_off;
 	bool oled_optimize_display_on;
 	unsigned int force_mst_blocked_discovery;
+	unsigned int wait_after_dpcd_poweroff_ms;
 };
 
 struct dc_edid_caps {
-- 
2.48.1

