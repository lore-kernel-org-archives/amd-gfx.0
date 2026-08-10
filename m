Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2088DC5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9828D10E33E;
	Tue, 11 Aug 2026 15:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BVXnOtWn";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010010.outbound.protection.outlook.com
 [52.101.193.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 287CD10E33E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rovk3rU7Rk8cSgj/7MyTyidwNy6cKSWSRsKIbwocJBYNYcVmtPpJfqPkszIeecE6XfqGh0NFgnsuWmHOFRtFzFPAI283Bf0N5RV7NIcJOs28FR5UhpoxxznubM19fkVZN38zOjGKukC1RzFfp/zdpnXecUIHdtjbjsu72tQ+i6xx5XYu+Qu8t1TXnoxORuYhxtaD2NBgQIitC4SUsgkURAtAgXu2vTCDngoU9ta53CE/9cTlxZ8iIPxQ8MeZK1eImiofA83blF+arBYhiBwyQ+ol5o38jXEB24ipMdySt/lUpoVLURHER2UtpjRTVH8PMUw3A5f1oVPqDV2RPiSe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1s3uE73kBqrC6RaX+NceLHSQ+uBNBmieeclehRfwGMg=;
 b=Fba7BkexR2zUI1/bbMRK0SD7L5Gru7uyHz+UaMeseLrxA7SKXnoTtvnB36CfwaV9/ePGL4n3CnYEs3RfV8G72gOe0kNL9daWIQqJ0myxuiGXkB5EaH9okGmZJS/UbV8dXus3bmHnv98nEh6vhG9gENwcPo4miZJy/MgpxXrKW8x067NDl5b05HVUGABDvd2tMgycCYEE82sc/FoIEr+YhKhaeenq1fegjbfiUXsM0Ec/n1p9fj/+t8/A6lKXBGDQ+/auy9lioKFUoNDYKg6OXJIHyfqOdQThU0MbNlshb2PMfTDEkvgLQtbRONcSc2s9/nvPve7qxHmQOOItVMzMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1s3uE73kBqrC6RaX+NceLHSQ+uBNBmieeclehRfwGMg=;
 b=BVXnOtWnCBi5a4mYFa9YcxsPslf1zgOrzOleQ9F0K7xEllWOPhGbGP0f5MGnsp/D49EIH2GUdeshrkXJ097N98pKDGKQqY8uqX+d2hIPFk1B80ozsbDEu/C2FvvmiDssdYwXx82ROuP0HY0g3L6uIRXddhrLZjlNMU5gpUlNbgk=
Received: from CH2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:59::32)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 15:48:21 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::45) by CH2PR03CA0022.outlook.office365.com
 (2603:10b6:610:59::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 15:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:48:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:48:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:48:19 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:48:05 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 01/24] drm/amd/display: Add CACP ACE curve area debugfs for
 IGT validation
Date: Tue, 11 Aug 2026 05:28:35 +0800
Message-ID: <20260810213010.1703162-2-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: f868c2ff-3009-4d1b-151a-08def7bff7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: NWJ3TtMwO9akenoS8w03o5E0h8uJrQC/M8gZtPR9MnerkGabf1Qp42B+aYmonMJQtddgnDRCxDFLMGdto5k9oSdUd/K5+nxgdR7wyei5V1tCPLclyAowjtGKU+M+VdrIv9IMkyNfEZltXCDiXVMM1K/IZ+7h1cx1adFHxaXhtNsMT4eUxYjliu21fVWZT5dURL5rbh39RrcilFiEz/9AlkR+Ysd891omM0b3pinkvEDy2MVEwwsEo42lBtaTNrUA4uV1y5R4f9Vww21lE9l4sTJUvYi2hGPa4MZ4ytdvsTcjre4uqWm7KOj3QOPrpTgTyNgbkUWFSu/i7ngSMxxlFwLbi+v6WHXKG7RwuJKELligLG+8NPa1B8ulekpUcYeeiLXmRpgmfICUcaopfDKDoLBpq2V8ogGLVGBLOcEbp5SBvZ1f2uVIgudX0p87KqQN5EOxRWqoiOZrlhIZ02InJOYEz9UtZFCR6Nu7Rc1IjSx7uXTVOBgDEgzYznMceJjdN2wVtzgHPFRgU5iSPrum6YwjyQh0sX7kwidAL0HHj1VPUUyljv85WCBtYd8jIpacFzutzNPe3Pc5NMawqJhFzJ+HbBlif08X0ZydWyvXFcYpxoi9Ut8WPQte3Nejbzc0B/mAGicHZqAH/Ih7rY6ij31ua1dml7NBUylc6x93lAsHMFKnZiieJ0m8eL224T4JWGMZuGUA/Y+bnMbSa+1K8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cAXN2bmpnxomPtFrbhdWiv4xWUI6+igA1v1JD4pu4JkcdvAGyMUKUbSPQ2ITPAyrbx75sYNbfpGvJm9qoOrsd1xzrV6SL36xuqOUMnv9enG38bl+gLquJY5a3o/w+/QdiIZrskGOcCXYIgT4YswVdMigmNkPxw3HjwOWolY7Ob786cBZRlLMB1f8hldsW+LMEI95mSMviDX4NnA8GQiSGzdLr/4wt77z6lIPp18v9fzYoAKiQ8C0TIPS/EpeU/mm3HNUlAdZOX+tqszztGU/K2r6SvpX52BMkCKm3PPv2KlT1eVD6B6MEJxy5mWjMmjxdO8LOjGMY9HaPB//LPPREza8gKb+FgogDs7gVfYfCmBjjoFnks5YE3AkLjieXA3e8TjhQxdoEiPBttjMyyBi2rxolAUSn5bfSIGPtFXZl/WSRZdpOqiiyupWJ7R+WiUt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:48:19.9413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f868c2ff-3009-4d1b-151a-08def7bff7b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
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

From: Chenyu Chen <chen-yu.chen@amd.com>

[Why]
IGT test cases for CACP need a way to validate that the ACE
(Adaptive Contrast Enhancement) curve responds to the CACP
aggression level. No interface exists to read the resulting
curve back from firmware for automated validation.

[How]
Add a read-only "cacp_ace_curve_area" debugfs node on eDP
connectors that support CACP. It issues a
DMUB_CMD__CACP_GET_ACE_CURVE_AREA command and reports the area
under the ACE PWL curve returned by firmware, which is directly
comparable across CACP levels, so IGT tests can query it per panel.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index c4b2fc690fd7..1a574f508b8d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3677,6 +3677,72 @@ DEFINE_DEBUGFS_ATTRIBUTE(ips_residency_cntl_fops, ips_residency_cntl_get,
 
 DEFINE_SHOW_ATTRIBUTE(current_backlight);
 DEFINE_SHOW_ATTRIBUTE(target_backlight);
+
+/*
+ * CACP ACE curve area. Read only.
+ * Returns the area under the ACE PWL curve computed by DMUB firmware on
+ * eDP panels that support CACP. The value is in DMU-internal units (PWL
+ * area); it is only meaningful for relative comparison between CACP
+ * levels on the same panel. Level 0 returns the linear baseline (largest).
+ *
+ * Example usage: cat /sys/kernel/debug/dri/0/eDP-1/cacp_ace_curve_area
+ */
+static int cacp_ace_curve_area_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(m->private);
+	struct dc_link *link = aconnector->dc_link;
+	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
+	struct dc *dc;
+	union dmub_rb_cmd cmd;
+	unsigned int panel_inst = 0;
+	bool reallow_idle = false;
+	int ret = 0;
+
+	if (!link || link->type == dc_connection_none)
+		return -ENODEV;
+
+	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
+		return -ENODEV;
+
+	if (!link->panel_config.cacp.cacp_supported)
+		return -EOPNOTSUPP;
+
+	dc = link->ctx->dc;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return -EINVAL;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cacp_get_ace_curve_area.header.type = DMUB_CMD__CACP;
+	cmd.cacp_get_ace_curve_area.header.sub_type = DMUB_CMD__CACP_GET_ACE_CURVE_AREA;
+	cmd.cacp_get_ace_curve_area.header.payload_bytes =
+		sizeof(cmd.cacp_get_ace_curve_area) -
+		sizeof(cmd.cacp_get_ace_curve_area.header);
+	cmd.cacp_get_ace_curve_area.data.in.panel_inst = panel_inst;
+
+	mutex_lock(&adev->dm.dc_lock);
+
+	if (dc->idle_optimizations_allowed) {
+		dc_allow_idle_optimizations(dc, false);
+		reallow_idle = true;
+	}
+
+	if (!dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd,
+					  DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY) ||
+	    cmd.cacp_get_ace_curve_area.header.ret_status)
+		ret = -EIO;
+	else
+		seq_printf(m, "%u\n", cmd.cacp_get_ace_curve_area.data.out.area);
+
+	if (reallow_idle)
+		dc_allow_idle_optimizations(dc, true);
+
+	mutex_unlock(&adev->dm.dc_lock);
+
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(cacp_ace_curve_area);
+
 DEFINE_SHOW_ATTRIBUTE(ips_status);
 DEFINE_SHOW_ATTRIBUTE(ips_residency);
 
@@ -3877,6 +3943,8 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 					&disallow_edp_enter_psr_fops);
 		debugfs_create_file("disallow_edp_enter_replay", 0644, dir, connector,
 					&disallow_edp_enter_replay_fops);
+		debugfs_create_file("cacp_ace_curve_area", 0444, dir, connector,
+				    &cacp_ace_curve_area_fops);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(connector_debugfs_entries); i++) {
-- 
2.43.0

