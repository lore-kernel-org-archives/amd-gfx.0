Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F46C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A5D10F1E9;
	Thu, 23 Jul 2026 20:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E+Odhw3U";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879B410F1EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvsWiAiXqxNYCNg8ZEmeRl+mc5Vz+uf/ho8hc4hOPHtSUfOjK8vzERjm7I6L9NUMB8p9iPfW8RWnIeUJpvzzKjkCknzT9GxTp+XIFhyR+/K8DHTrY955aPj5I3PdHUxy+Co9CbHOQnpkzn51hYxmEWXB3qVVSHGthNE8TXY0ZVEs0ke2BllKQxvFo4LosIXDVHoPzDSK05kTq6GfPUD9NJ7M6xqC8DwnUS5ah/0ghjcvQhUGlko2nwoDwz81CAaeawyfO07R4IjyAgjjJmPqDP4O0yZToYC0tcH2scorWj5464CSOq+lfYR1z3ucBUNrlqgWmHIkrOrqgwrp0JM+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qelEqDI/YOLQZBKR2rhQq/hR9UaZkF6+KDANPO2I4o=;
 b=n237QcFotx5tGI7tk1tQI2XhiFeQauFVLL/Qo8S403eCBz+vYGZCW/jmYSru8IWmu7Q9DA+RLYvawTB5zY0rW2vXNRkWMT7H5TZ/dGJ0NqFHpIL73L9X8ww9KLPLp9glt2Sc3oduo6AGBkwGnhDh0ZnXI2h+8MnVN1A7HZJja4mYQ/qfEev5RcRbhUmvQ860zcGPOGpAL27pe/FV3Hcmsp+1IiupC1Rlxf4CWek0dgCrIylZiiNuL12KBZ2/ZYa+oZzK+HfkcKBFkXQpCzwv3t0Y6tIxtotqUr8eadhY93S8ApDF8Q6JdbAZJZnKG9IClaOo6M/e8IkJ3JZkSCJgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qelEqDI/YOLQZBKR2rhQq/hR9UaZkF6+KDANPO2I4o=;
 b=E+Odhw3U7rCX3XKpvto71nVoFyfoUuTGgzJT+Q7v477S59WbEKiCYF0LCmmiq1a+K7cAd+gUJ7iNtkwMl6JO55zfr3p+kd7mNSkfBvtnTYujCefSO01tx7z46LE8n++bC7Wn5hItiksQa/3DIk+LNSUum0vhSOfDkpo/c9xe7Rc=
Received: from BL1PR13CA0368.namprd13.prod.outlook.com (2603:10b6:208:2c0::13)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:41 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::5b) by BL1PR13CA0368.outlook.office365.com
 (2603:10b6:208:2c0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 20:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:41 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:16 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 38/49] drm/amd/display: Prune per-tile Timing from Apple
 Studio Display Primary Tile
Date: Thu, 23 Jul 2026 16:13:46 -0400
Message-ID: <20260723201908.373300-39-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 615a131d-9283-4b68-50d7-08dee8f7ba76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: yP9ZKpN2ueUqwIscbrFnEJw/35Dbr+7wfyZvc++nThk72oewymEkf++HC1HNnoo4UU9KLCN7epCoTeDCtsTDmwpiYjyNIkCDUq3DPcZ1+i9LFadAeboYOH5qpSrCJITvEtEcgUxfEqmfUNUT3lpHGCZh4fn6JgbV2ghTZoDn6tW7RqD1Hzzlk0BzSRqqN3aqDKJ7Lrd0y1INnRNVXT0i7IXgCsLMPInAfmCioViNM3DplNc6YejkxGZa3i+RyD+3RCxGzsC/MrCEjZ0UpFWxJEz+m2bYSBrBg+n6YdBmN47b9RynZLUU64FqhLHtiKeeN3HoYFSTDaxxbzVK/ynV+hVsPwEQVj0ds/tM3FzvUoniYMBORcdmhGUpa2m+0WHrr7SHC6SwN5qN7nAzQgYIaemxpAJcm/udc9PenzogVWCg2sFo27K7qraG9Kw1Mg5T4agbBgLt6ead6p44NGjCoF7nch+uA+CH/PshI2f33BIL3kSQQ09HvKPIvSDh30YugkbK5Yef74KjvO+K07FVGy/JOatxrLP5+laeoCGKV/nhBJswA0Nhd40wGFyvkOaCuWdrMQ1o59jpFk7ftXxaM2b9Pn0Us4WhrbkItTRHthvA/jq3/VCEOQOhZSTDUraOoX+NvBy6MUqFmsDm19rAXQryzsaAzVE9yLVx7qR0bMeCRhr2kqwYe4pg6ndG5fL/xI9PAxXsv/ytBi0Kjxg1Mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wVDayuGfqZLyMHBBfwWs1+0RNErDucCQZ1WSmfpVUxzfLYE0wTUD1bX3xCko/DQsndjBnqliUh0uah4/3SEvjBp1BUCT9V8pLAhQq5ICoRAINS7o6zmOT9M1OZKyMMQTlu22Mfl2UP46slD3pusbdM7f+DSVt9BQQ9zg1Nk8EvNuasuG3yk6UnQFv6LTQrvfban3AsS9nc4eHU019syh002RvmLakR673mCwUiQL1ch1gYuuEYxxTet0F/hTY5sf2Lzl9Dxpovz18AOcDohZySyWfcvNJphWPSw7IFciD2KnHJBlDd6vyyBVk2R8Fq03nlaqzw4+gj9Q6BtuQ657C+Smsl0rStbfZlPKhaRpDJWcrPzRQ4fVN3o0Hec2rkcqo+C1hjysnQvUCvfpuEvN3NXL56kT1vzTMimK7YQY1JwloyPLYxbYC0vvkmkwIBFZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:41.5624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615a131d-9283-4b68-50d7-08dee8f7ba76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
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

[why]
The Apple Studio Display primary tile advertises both the full 5120x2880
mode and the per-tile 2560x2880 timing. With the secondary tile already
hidden from userspace, the stray 2560x2880 mode on the primary connector
can still be picked by compositors, defeating the single 5K stream goal.

[how]
Prune the per-tile timing from the primary connector during get_modes:
when the sink carries the disable_second_tile quirk and the connector is
the primary tile (tile_h_loc == 0 && tile_v_loc == 0), drop any probed
mode matching the advertised tile size (tile_h_size x tile_v_size) so
userspace only sees the full 5120x2880 mode.

Fixes: 22ea891606 ("drm/amd/display: hide Apple Studio Display secondary tile")
Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 135107c73971..a8f089d4fb72 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -2751,6 +2751,47 @@ void amdgpu_set_panel_orientation(struct drm_connector *connector)
 						       native_mode->vdisplay);
 }
 
+/*
+ * The Apple Studio Display primary tile advertises both the full 5120x2880
+ * mode and the per-tile 2560x2880 timing. As the secondary tile is hidden from
+ * userspace (see amdgpu_dm_hide_secondary_tile_from_userspace()), drop the
+ * per-tile timing from the primary connector so compositors only pick the full
+ * 5K mode.
+ */
+static void amdgpu_dm_prune_primary_tile_modes(struct drm_connector *connector)
+{
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	struct drm_display_mode *mode, *t;
+
+	if (!aconnector->dc_sink)
+		return;
+
+	if (!aconnector->dc_sink->edid_caps.panel_patch.disable_second_tile)
+		return;
+
+	if (!connector->has_tile)
+		return;
+
+	/* Only prune the per-tile timing from the primary tile. */
+	if (connector->tile_h_loc || connector->tile_v_loc)
+		return;
+
+	list_for_each_entry_safe(mode, t, &connector->probed_modes, head) {
+		if (mode->hdisplay != connector->tile_h_size ||
+		    mode->vdisplay != connector->tile_v_size)
+			continue;
+
+		drm_dbg_kms(connector->dev,
+			    "[CONNECTOR:%d:%s] pruning per-tile %dx%d timing from primary Apple Studio Display tile\n",
+			    connector->base.id, connector->name,
+			    mode->hdisplay, mode->vdisplay);
+
+		list_del(&mode->head);
+		drm_mode_destroy(connector->dev, mode);
+		aconnector->num_modes--;
+	}
+}
+
 STATIC_IFN_KUNIT void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 					      const struct drm_edid *drm_edid)
 {
@@ -2763,6 +2804,8 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *co
 		amdgpu_dm_connector->num_modes =
 				drm_edid_connector_add_modes(connector);
 
+		amdgpu_dm_prune_primary_tile_modes(connector);
+
 		/* sorting the probed modes before calling function
 		 * amdgpu_dm_get_native_mode() since EDID can have
 		 * more than one preferred mode. The modes that are
-- 
2.53.0

