Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45198FF885A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B16A910E3B2;
	Wed, 29 Apr 2026 01:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yza2npWZ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A845610E3B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWyMd5eW3KZ7NcLRyNfgJccgef7wnwzGFG5uP2PK61THsky9SjXYmOEaUFD5XumZT3fyFQvroY5e58h4qtG6Tw39S2CCrgabfhyCokFN1Ly32wE/S9RVRjwqlAWejRpvSpkT8D+nu+ojp8+aXQjd6P8rEj2J6/18skoSkhmvodk1e6sx7rIVolcD4Ej93wSKIevpGTMJakAgQC1bX5jTIsWNyGYDonaJXGvPpP/Q3WlbxTX833a1YjcsTpg61U0zQG5V/55gevye5DeMmzFJRnQIhQSmLwgy3Ouv28c58ehtOo5wZrJ2BKdrrtdK6sszlSGWZxCLNsKrfjfwAMO8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uh5/5fZtpOM3CD+ASVIVfHBlaSNSy862a3sA6mNE+Vc=;
 b=Vo72j4S65u2CN10W+aoM99gWenJcfPrLiZwm0yRA08eyC/4f0aiNs3aAImXf2yooBnj45cLdXxjMx4K8AOuoXGCIpMv3O6hIOXcGd2Q2MDlGcO10IjOXKHyZmqCHa17pSq8OE+VqnKbnCHJdlNzyESn3xUbosIiusrRzN0W/1CFtYfyBYHR9zusLTEG2/t3310Zk/eml7XpY4AJvu4LNcSa6lf2S3hsTCE4zQnLkHb1kzujMn/uIm7ARavgo4xeIL1nMtlDuoWr54Mi03CmB7b907DFGuyI5CMplmQim9vfDJS+MN6vQZ8uonpjrBjs3QpWjUZ82dsQqGDYHSV3UrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh5/5fZtpOM3CD+ASVIVfHBlaSNSy862a3sA6mNE+Vc=;
 b=yza2npWZMZ7U2KKE6LOXDtL6YiKAhpBKgbGS9u+3uIKtCDtNSUztH6LmYhG6Uh6zIxD8kJ8jN7dRUGw0DstPWoj9BW3jb6R0sFfuBO3AV9swAcNYu/5yjG0Enr2xrc4woea4EURqYt++MmxJOxhY/LLv6RZk6WvE6EIGns7v8dk=
Received: from BL1PR13CA0341.namprd13.prod.outlook.com (2603:10b6:208:2c6::16)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Wed, 29 Apr
 2026 01:53:56 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::3c) by BL1PR13CA0341.outlook.office365.com
 (2603:10b6:208:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.16 via Frontend Transport; Wed,
 29 Apr 2026 01:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:53:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:53:54 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:53:46 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 13/17] drm/amd/display: add memory bandwidth override debug
 interface
Date: Wed, 29 Apr 2026 09:19:22 +0800
Message-ID: <20260429012055.2065869-14-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 88bc78cf-60b3-424f-7958-08dea5922bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: k3jtmbCcCi85HxGUyvhzgfjTvuN/Jf3PsSa0pDyYq/PWS9T5+JeufzxcxnQtJj/j6mdOYi2RVyI/pMqtTUXdEczsXFPdKbG8d8tV6YtlY5G7jB9FnRHWF2Tc+QWe463un7jNv3t06daxYulmG0WZ/RiWIrXygo6bAQ5CcLYW+C4Ne8MbGl4pvRFRwD9Qdrzid4PF1k+7Vi0BSQ2fx0zAKN5iTWlCkb/9lBG3kr2l+uxxCIqLutoXjADKnpKorSoIkJko+wSjRGeHYee/poRU/YJhfdErujLTP0VRxLfZ+J9pUNsYekFJDxQa3BFKuM2kV4WB2MdYXePN/8zz2upFuU533mTyhiLYVfEu3yyb+Yp7krAyF/lBdIxPL4CaFpv0LhTcn0OUBCM4Pi2eCg5c5iwGCbx5Twx297I+nMLJlF24nmY6GaWtnpTOtGCYSG5Uk4l4nvsUrRnOqXs/e+s1xvkn4s4+yVw7zfoVTc1jJL1knlRsfE/xjeSF2WKm2/KvkHDa+IP2XnN9sq8FVWWFfHo+3VxgpVkQkg/3HpaEp8yiTA1xIEdnlHa4i4NzwX3u/Yws0jPZ2JMqCOiAj1sjZaGhHAl4fqr1zqIxU0g8nOWEUmSK46OVl5amP/YrhHwgR/LlQByiUWvyLG/hrQf+Ky7xTPC89qzKITqbwyDgi2pibwUUuTiPcpyhdVJ34z8keeaq0wPK+MX4NP2ervRm2Spa+dcAFgDrGUzCQM9HVrnBu0CvIDR5kDXfZNjXhjlv9k3jDeusVePTl7NUt5TTlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KBdTkEZ5Bs+k/1X1SFuh9qFj2A5599KF3pdYsWLfffmLgrmgJf95fwv9fB5fO2oocxj78JiQNR32cfve6q1yRkqnpoR/SxlnUHSXpdStmDpsmU164/9chwntsPXz0r2op/6C1NM6ybPwaT1js+uh4IiQtOJh//wSFt4BX0MIXqA/PXLvbrb/4xt8V7w/j6hoUFtw1g6Bl+p+mr550YjHVP9dOLdOQy5W7KYYcyYO3QYOMe5e2IAzzA/ShnoRAEC5bJycKzhlHsU2FLriOY3Tm7ydQritJ98BtKHgMWAKLINQYjiuLDww/acJ/I+EUdqlts1AzToJK7CUkvDDO3zBTruMd8jeVdhltvky0iOXC7izgEbErv2e+mCZ7kN+8SyENnbYKStjt8I/9YNn72Wr0zN++Sghm+L+ZBTY6jTlZtv4BG5aCBxYzUusnSe17DUr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:53:55.3991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bc78cf-60b3-424f-7958-08dea5922bf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why & How]
Add override_memory_bandwidth_request to clk_mgr_funcs and get_utm_qos_model callback
 to soc_and_ip_translator_funcs for future test use.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 13 +++++++++++++
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   | 12 ++++++++++++
 .../display/dc/inc/soc_and_ip_translator.h    | 19 ++++++++++++++++++-
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6447b85c7ce5..222053af63a0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -7625,6 +7625,17 @@ bool dc_get_qos_info(struct dc *dc, struct dc_qos_info *info)
 	return true;
 }
 
+unsigned int dc_override_memory_bandwidth_request(
+		struct dc *dc,
+		unsigned int bw_mbps)
+{
+	if (!dc->clk_mgr || !dc->clk_mgr->funcs)
+		return 0;
+
+	return dc->clk_mgr->funcs->override_memory_bandwidth_request(
+			dc->clk_mgr, bw_mbps * 1000) / 1000;
+}
+
 enum update_v3_flow {
 	UPDATE_V3_FLOW_INVALID,
 	UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 67d64a1cdb4a..2bb11296ee6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -3383,4 +3383,17 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
  */
 bool dc_get_qos_info(struct dc *dc, struct dc_qos_info *info);
 
+/**
+ * dc_override_memory_bandwidth_request - Override the DCN nominal memory
+ *     bandwidth request sent to PMFW, independent of the current display mode.
+ *     For debug use only.
+ * @dc: DC instance
+ * @bw_mbps: requested bandwidth in MB/s; 0 clears the override
+ *
+ * Return: capped bandwidth value actually applied (MB/s)
+ */
+unsigned int dc_override_memory_bandwidth_request(
+		struct dc *dc,
+		unsigned int bw_mbps);
+
 #endif /* DC_INTERFACE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 21224fd6b36d..eab25efea76b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -362,6 +362,18 @@ struct clk_mgr_funcs {
 	uint32_t (*set_smartmux_switch)(struct clk_mgr *clk_mgr, uint32_t pins_to_set);
 
 	unsigned int (*get_max_clock_khz)(struct clk_mgr *clk_mgr_base, enum clk_type clk_type);
+	/**
+	 * override_memory_bandwidth_request - Override the DCN nominal memory
+	 *     bandwidth request sent to PMFW, independent of the current display
+	 *     mode. For debug use only.
+	 * @clk_mgr: clock manager instance
+	 * @bw_kbps: requested bandwidth in kbps; 0 clears the override
+	 *
+	 * Return: capped bandwidth value actually applied (kbps)
+	 */
+	unsigned int (*override_memory_bandwidth_request)(
+			struct clk_mgr *clk_mgr,
+			unsigned int bw_kbps);
 };
 
 struct clk_mgr {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h b/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
index 23daf98b8aa8..6a97a3e28bd2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
@@ -8,9 +8,26 @@
 #include "dc.h"
 #include "dml_top_soc_parameter_types.h"
 
+/* Forward declarations — callers that dereference these structs must include
+ * the full UTM model headers themselves. */
+struct utm_qos_model;
+struct utm_qos_model_dchub_v2;
+
 struct soc_and_ip_translator_funcs {
-	void (*get_soc_bb)(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config);
+	void (*get_soc_bb)(
+			struct dml2_soc_bb *soc_bb,
+			const struct dc *dc,
+			const struct dml2_configuration_options *config);
 	void (*get_ip_caps)(struct dml2_ip_capabilities *dml_ip_caps);
+	/**
+	 * get_utm_qos_model - Return the static UTM QoS model for this DCN
+	 *     generation. Caller provides storage for @qos_model and @dchub.
+	 * @qos_model: output — populated with SoC bounding box and SOP table
+	 * @dchub: output — populated with DCHUB client extension data
+	 */
+	void (*get_utm_qos_model)(
+			struct utm_qos_model *qos_model,
+			struct utm_qos_model_dchub_v2 *dchub);
 };
 
 struct soc_and_ip_translator {
-- 
2.43.0

