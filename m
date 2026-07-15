Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9ADC4450E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C7110F0B4;
	Wed, 15 Jul 2026 13:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X1f2+c/m";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5F110F0B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JA2I/asJkvSXw7LJO9/AxdGonzmtH56KIZBzAp9l4wEbCX2pQHbeBNE7J00V/xuyV5QDExWzTQ3EQjYxVmjMOeik2wwwy7r+ufHpUI3lnkaV0G7D+q1jJJNdSZkhxpHqGqgCyatHqKfbI9BpzCYRxzoyWs//OMbDYeviJ44qWo/hD074oqvC/IRqn9mFBuzUaGRq+7EFkcBBF2C5JgdCyGa4BRuspF8imEi1HBvdCwkwoPl2Ge7qykB/BPoeljNEcrD6fwKIxA53IeZVNxxAqnFvMIBqn+P1z+AEmyZ5MAcDo6GjMaCkvwFyF2qBVAT+0To7Fni40oT0iNnKbNTveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNBILjyHJP14CSgq5SqZGG2Fvn1mcMHi4Ee9QTt49ts=;
 b=q5MTx7RPe+qn+mLRW+ZKScvWs3XxNiiFqMwFOwXbME3p7/d0Gc4sIO9us9msHpyiBE++QMwbWdRBYiM7O9gtoAbAamXL0itzMqOmXu0CUSDT3MjWsulgfAz/81gFsecuq+3hGCFM98nTAVM36gzU2tUvyND4XW1qTP4Z8azIZxvUolB5OeIqjyZuPd4t8LhVMqHxCwF8cJlzo+xcVHvJFapeXvv/j5mpKFe0LdABn1TFu0mQyiPcku22dyUX+kRoNe0hRnmK1IcoOJgs5/ytDg2WM2kzfCTp8voZ4zFgIpyl2rfkPY6EbHEyckMVetKiny/obxzQ7xwCsWgNgHd7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNBILjyHJP14CSgq5SqZGG2Fvn1mcMHi4Ee9QTt49ts=;
 b=X1f2+c/mTuIBdop1hCQ9HQ5SXp4ojlizRTGG5Ouf7XtECcRQUCzOWqgvTBp65lsAwsivI+jn7OfW7+9jTkAzcT9v0PuFnKoBACoxgrSLnK9puF0pULFqAqyziiYNq7rRVqq6aZyZGVHe1ZX98lCGVZu7ci3JiS1K/7XelMfgruk=
Received: from SJ0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:33b::17)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 13:49:10 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::1b) by SJ0PR05CA0012.outlook.office365.com
 (2603:10b6:a03:33b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 13:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:49:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:56 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:53 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 64/70] drm/amd/display: hide Apple Studio Display secondary
 tile
Date: Wed, 15 Jul 2026 21:38:14 +0800
Message-ID: <20260715134432.1975118-65-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: d50820fe-42f2-4d70-f7b9-08dee277d8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8H4sdrO+b8OiYBBhZx6ZA2T7shPUqZCHBqDj2JDhc6iu00B8UL+q3KSbW/3XZ7QoNpOoqvYfR22fj/48YvxBO4uGG+g9eAN44VemlIw0/3gqJ6gUUUS/oFE2mdSUgvQmiJMvbepvV7rH4rRymPfhIeIF8x/3z+lQvMd/3rbvuSuCvyQJGnMbv5SiGqq2lEH5hrXEFnUoINrlnMYON6tn0FjsKieZlJ8nNa0b9X3iFJDygLVPO8A+F55OwtuqKKHYvh1MTxAlU3UJOFF/tqdNC9JP+CA0xEjxJqrF8cQ4TKrBWC+sdFf8XbzR3Yz0c+iMBcOAsxU40gDG9xTY/aGP2tdoNCmDq3cDoSV8QXDNADAZ4OjnCoLZH2b/oHqCS5XVIlS00cqvaKAcNjgHyZw+cokC0bO8AbRXhFAkSv6rmSz1e6jYaURHnn7Fa/CPD6xQA7mB9ZEtMEIu8fEC/VKgP7b9Xpcgm/mo6AgqgCqX+iviMPfZUzQ/q58sP3K59b0R6oA7Wyq8mSeew6hxbgbgRwZJZI0VPqlm9CaGA/zFMaGYtj13dSSfboScJajIRStduKu2+tQnIQhIhP2G5VyOVaEnFJxTK9AWiVZupkQ8YUG1lDGAgcMHIPkOlg1Q+aypxlTenTolu1W6RO63SrU3gVS7VmRpXPUeLESjlfumWegJfgAcWhjWLzVAEzVR9sTrf92LGXPUQ41PE50RjE+Uhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uOBgaRizBBy9wfUicPTPLdAXMSbz81VrrM09MUqvRLnGX9sQccOSeM9do5AIVRC0ZM8sI10zld6kqpsjnR/z4LFq53tWsGd0ZNb6wVPY1EF/eqfL5DSj50d8eFnMQnOUQ8MyjnFCzRKxbNKsLckV4WKF+ZTy68RjrV/GMSQnR+62YnZPpM4N7P+Yd2TUEQsoH+ZYlt4ITpaVMmCSviwBpd7uQqec6VmuJVwvqTy6JKmG1lf+yrU/O3q2kGeAHA22lH5P+1/VGwHtvff3apaWkYkJodmqvsO9GfEfx6jhYUIhPML7MvxQtoA9kw0iFBM6zbv9Z4Gfb9ISUId0ki3aRKzYugWEq++TwOtNFrm8QtQ+TTVvQMmjBum+qfeWwXrBGO5LiX41JrI4oOScctMEW0Fq1rItKuTQQxGAZaK0RZFnQn1tqLVyE52NtWeq63gN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:49:09.8002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d50820fe-42f2-4d70-f7b9-08dee277d8c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
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

From: Jerry Zuo <jerry.zuo@amd.com>

The Apple Studio Display exposes a 2x1 tiled panel over two SST DP
links. The primary tile advertises the full 5120x2880 mode (with DSC on
the bandwidth-sufficient link) while the secondary carries a per-tile
2560x2880 timing on a link without sufficient bandwidth. Report the
non-primary tile connector as disconnected during detect so compositors
only see the primary DP link and configure a single 5K mode instead of
driving both tiled streams independently.

Drive the behaviour from an EDID quirk: add a disable_second_tile panel
patch that apply_edid_quirks() sets for the affected Apple Studio
Display panel IDs (0xAE3A, 0xAE42, 0xAE46), and have detect() hide the
secondary tile when the sink carries that quirk.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 36 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 11 ++++++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 3 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index da6ec75bb0f9..c30e341c0f37 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1605,6 +1605,39 @@ amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_poll);
 
+/*
+ * Apple Studio Display exposes two SST DP links for a 2x1 tiled panel.
+ * The primary tile advertises the full 5120x2880 mode (with DSC on the
+ * bandwidth-sufficient link) while the secondary carries a per-tile
+ * 2560x2880 timing on a insufficient bandwidth link. Hide the secondary
+ * connector from userspace so compositors configure a single 5K stream
+ * on the primary link only.
+ */
+static bool amdgpu_dm_hide_secondary_tile_from_userspace(struct drm_connector *connector)
+{
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+	if (!aconnector->dc_sink)
+		return false;
+
+	if (!aconnector->dc_sink->edid_caps.panel_patch.disable_second_tile)
+		return false;
+
+	drm_edid_connector_update(connector, aconnector->drm_edid);
+
+	if (!connector->has_tile)
+		return false;
+
+	if (!connector->tile_h_loc && !connector->tile_v_loc)
+		return false;
+
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] hiding secondary Apple Studio Display tile from userspace\n",
+		    connector->base.id, connector->name);
+
+	return true;
+}
+
 /**
  * amdgpu_dm_connector_detect() - Detect whether a DRM connector is connected to a display
  *
@@ -1648,6 +1681,9 @@ amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 		(!aconnector->dc_sink || aconnector->dc_sink->edid_caps.analog))
 		return amdgpu_dm_connector_poll(aconnector, force);
 
+	if (amdgpu_dm_hide_secondary_tile_from_userspace(connector))
+		return connector_status_disconnected;
+
 	return (aconnector->dc_sink ? connector_status_connected :
 			connector_status_disconnected);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c172bb76bcda..42f5673acb4d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -136,6 +136,17 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 		drm_dbg_driver(dev, "Skip PHY SSC reduction on panel id %X\n", panel_id);
 		link->wa_flags.skip_phy_ssc_reduction = true;
 		break;
+	/*
+	 * Workaround for Apple Studio Display which exposes a 2x1 tiled panel
+	 * over two SST DP links. Hide the secondary tile from userspace so
+	 * compositors drive a single 5K stream on the primary link only.
+	 */
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE3A):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE42):
+	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE46):
+		drm_dbg_driver(dev, "Hiding secondary tile on panel id %X\n", panel_id);
+		edid_caps->panel_patch.disable_second_tile = true;
+		break;
 	default:
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index fccf9cb359f0..3edeb94fba23 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -188,6 +188,7 @@ struct dc_panel_patch {
 	unsigned int skip_audio_sab_check;
 	unsigned int mst_start_top_delay;
 	unsigned int remove_sink_ext_caps;
+	bool disable_second_tile;
 	unsigned int disable_colorimetry;
 	uint8_t blankstream_before_otg_off;
 	bool oled_optimize_display_on;
-- 
2.43.0

