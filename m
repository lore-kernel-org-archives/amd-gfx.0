Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E94BC369B9
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C1B10E7B9;
	Tue, 15 Apr 2025 14:59:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nWgtgqqF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1239C10E7B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxKRhMP1e0whOrFnYQJlgJpHTE9FVcSFtp9uDrUDnXsgZgfIdcIiO4xFAjhQl5z2sNcD42dLRWGc0GrnN9rC9e/FJbodmj+f7X08E1lpqT6uTajM/d/RpUJf19lXR0eJBan5X9ct4KuF1K4096P8Yx7omdwm3E8ZPqOzFCofuMsjgFCSklM0hTZKgGcb6PdckI5rdg66Hu/4480KOFB0mvfJjEkg560kqI067JUhp0DsHyuINinF8ignBAa5fr5GB0oCF03KuP8fToDFjjH+GMUUz3KaaddUE0KtiY3c7fQZhm5BwJv58TmCpHZStU4xymAzonwhrXbL6VTjSnU6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSCsO9k/SnezNPCX3aDdyt477yOrtay/Gg97uKUrpDY=;
 b=YKW5OFayzy2c+qkTQeZOhDWpWsBC4GE+EtE6GVvsaR5d91GuTW/UtlJPBJ6ys38bUDFtNhgy+XSkZw/PZTMlX8rdbEBzboFu2Z6wRE4scnlURJSL978e9bg2zn2OR0sB6rLPDwSBxjrC2g1h+sVEX7Rjd4fMwoXO/yDwqWlaa+iHYHi6sG54I5G/TqfQ6oCIpZpCQrFT8A2/IXZrDEsX9A8iSsYEGgNzZoQC9QTLh0/gpbCiqr1BmJp/7w5NtmHbTbjl1hSi42NW7eKqELCvxowPKOQWvAps0oy1EwWjggeECPheuH8YhIz5dwIgG6ZztWeULhPCrkfpLQPwMXpGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSCsO9k/SnezNPCX3aDdyt477yOrtay/Gg97uKUrpDY=;
 b=nWgtgqqFa9lzl48lWRCz7OAFG5xxkVKpNqtYuIztGw0jeFNDjEtL4EffuNxdtX4MyuR9aD37TcPCaP70d5hd5XMzhPjWMKHovmvGQkYrTkDR2mUiNYmgjKLifFgWFwK8RcExK9kuJnEGLpnaS2OB3jTotF56/XxnR4qmGUXxs6M=
Received: from SN6PR01CA0020.prod.exchangelabs.com (2603:10b6:805:b6::33) by
 DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.34; Tue, 15 Apr 2025 14:59:33 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::42) by SN6PR01CA0020.outlook.office365.com
 (2603:10b6:805:b6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.31 via Frontend Transport; Tue,
 15 Apr 2025 14:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:33 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:31 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Chris Park
 <chris.park@amd.com>, Joshua Aberback <joshua.aberback@amd.com>
Subject: [PATCH 02/22] drm/amd/display: Implement HDMI Read Request
Date: Tue, 15 Apr 2025 10:58:48 -0400
Message-ID: <20250415145908.3790253-3-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d42905-ec83-428a-b02e-08dd7c2e21d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MAYnTbXj2LTmPzCXTbmcFonLMArvPc8g0XT+MbkQ5njcJIeCQn5K60UNTkHV?=
 =?us-ascii?Q?QcrUX7zyEWSycD+g8wJPGlCY7pRCs5+iE09s75f3UORcQ4de+TZZ9WOKNVL8?=
 =?us-ascii?Q?1CCODGeOAEJwe/qB09Nlmvqo/mc2ongpplFwLISNhkUzOI4NVA7D+lOpG+pU?=
 =?us-ascii?Q?N6l7t5wtGW8Bh1IqBiuUKGuW6+qdyxhBzSPyqhkrKcOFSMD2RdfuU7noo8G4?=
 =?us-ascii?Q?DQccZPmurQzqo9gFBh0eT48AJ1fVWPaiHHF/RQp0QCGiP38QWK9qoIcHoNnE?=
 =?us-ascii?Q?c1f4hOPlqayVZ30ktzsZEh/XiWaQVltYVHGVqWQweObvVHcFM3TjZ9/gW4UP?=
 =?us-ascii?Q?iIWjDAL0m7uj2YujHLjOnf21NbAwLdNsOGfg5g4g9KwNdY/0sTWKFU8VU6Ha?=
 =?us-ascii?Q?pzKaoXg3Kkmf8ad0y7G537zFoBxyvjpztnJe8Rf/0J6X1GN1f2ZRIA3B4O4n?=
 =?us-ascii?Q?Llccx9LRHeA6ly+oc79p36/mDjkiuw6Zrq8T/Syc125jSi5Ux92J5YQ3bjbA?=
 =?us-ascii?Q?Q8H5VZwKXiUywbtymSFNTaTST+CU9+mm4GbiPozVZ/Nx8JmmC6zWbPLJeb0R?=
 =?us-ascii?Q?vWBoKKMGrXi1Srj1D8Bk+yXgBV1tJDj84w7nKr9SlObrz6yJPGDQvyKs+kIA?=
 =?us-ascii?Q?0RzkqAO7pPPugTVqWEb8fM7ZHwV91OHBYO7fM180Jk9phX7eVVXl/cvJWYhT?=
 =?us-ascii?Q?TczkwJvvjAc8K0eCyc6F2H79mbITq07s597CLZuqfd0B/ZlnMvmu4zGMdf7d?=
 =?us-ascii?Q?RglyOYYtbzCpq4G+sU0GjPHFRBpzbY0J9QBP3LWblHwkswdVYd/F7cyM93tj?=
 =?us-ascii?Q?mycGZGN64tmPHXhirLgZUwlPK4Nn9bvN6e5EqVRm5eDGZ+VfjpRn0942Xzvt?=
 =?us-ascii?Q?yX3TCJ9btxsXJjneG7vBMlL+QFHmP7+euGmUUOEmT3iJ9vMrzh6/EUYNNGtU?=
 =?us-ascii?Q?WwugRf1H0lVo+CG9B+PG8tazDsplarz5Yg5qqcrzA24V6CZpnSw7+AL6bHCw?=
 =?us-ascii?Q?8o1H05dVYAyNc3Re9/qo1xVk4L5fzHGlKYp/g485jSHKSEDbMJ1EKkLQ+RRc?=
 =?us-ascii?Q?76mqXTJCJjPVDutyb4ln6kZPDFaWuNDTvl8ELP7SPjIKflQ/uBXIHsZ1qVAP?=
 =?us-ascii?Q?eFGtuF7jxPnOcNSPVPnOXysCAJGMEcHceznX/9zJdmhEvxjPN8JUd6mq7+mR?=
 =?us-ascii?Q?GsFoS1R5NQL9u3g7xeft9LKxMnRwnnVScovnhy2imKhBnrxFbVhF9oUxqUiE?=
 =?us-ascii?Q?DBRLPaTJWyqzPZLZ8enL2FDjqvR1gUtOmDX+CtaaOehBv4rIZ9nZqmc11M6s?=
 =?us-ascii?Q?zCUgFFNZgmhvJS6cThyYS2X/OI51+212+whpyqTFTltzJuL5BuG8T2+kh8PU?=
 =?us-ascii?Q?pJ/fzmy2BDLcokHhtXAvpRB+EzkbYcd/Qh7uNEb37XB0M1CHMQNqOYQqwqKk?=
 =?us-ascii?Q?eJW4qanY7wDdUeS4h/1vl775ABtsYPkydQRYU6EskLWncO66BC5v43enS8Mz?=
 =?us-ascii?Q?YKC1qgsulwob3xHq8zTXWsjPnS83q2E/pd4D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:33.2842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d42905-ec83-428a-b02e-08dd7c2e21d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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

From: Chris Park <chris.park@amd.com>

[Why]
Read Request provides alterative method to polling to
the HDMI sinks that support it.

[How]
Implement Read Request where interrupt can be generated
by the sink.

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                |  1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |  1 +
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/irq_types.h         |  7 +++++++
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |  4 ++++
 .../amd/display/include/gpio_service_interface.h   |  3 +++
 6 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7624b909497e..04b1c7b331a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1436,6 +1436,7 @@ struct dc_scratch_space {
 	enum signal_type connector_signal;
 	enum dc_irq_source irq_source_hpd;
 	enum dc_irq_source irq_source_hpd_rx;/* aka DP Short Pulse  */
+	enum dc_irq_source irq_source_read_request;/* Read Request */
 
 	bool is_hpd_filter_disabled;
 	bool dp_ss_off;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 9bfa9ac1b05f..ab1adc836018 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -210,6 +210,7 @@ struct dc_edid_caps {
 
 	bool edid_hdmi;
 	bool hdr_supported;
+	bool rr_capable;
 
 	struct dc_panel_patch panel_patch;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index b099989d9364..942d9f0b6df2 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -411,6 +411,20 @@ enum dc_irq_source dal_irq_get_rx_source(
 	}
 }
 
+enum dc_irq_source dal_irq_get_read_request(
+	const struct gpio *irq)
+{
+	enum gpio_id id = dal_gpio_get_id(irq);
+
+	switch (id) {
+	case GPIO_ID_HPD:
+		return (enum dc_irq_source)(DC_IRQ_SOURCE_DCI2C_RR_DDC1 +
+			dal_gpio_get_enum(irq));
+	default:
+		return DC_IRQ_SOURCE_INVALID;
+	}
+}
+
 enum gpio_result dal_irq_setup_hpd_filter(
 	struct gpio *irq,
 	struct gpio_hpd_config *config)
diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index eadab0a2afeb..a2f7b933bebf 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -168,6 +168,13 @@ enum dc_irq_source {
 	DC_IRQ_SOURCE_DC5_VLINE2,
 	DC_IRQ_SOURCE_DC6_VLINE2,
 
+	DC_IRQ_SOURCE_DCI2C_RR_DDC1,
+	DC_IRQ_SOURCE_DCI2C_RR_DDC2,
+	DC_IRQ_SOURCE_DCI2C_RR_DDC3,
+	DC_IRQ_SOURCE_DCI2C_RR_DDC4,
+	DC_IRQ_SOURCE_DCI2C_RR_DDC5,
+	DC_IRQ_SOURCE_DCI2C_RR_DDC6,
+
 	DAL_IRQ_SOURCES_NUMBER
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 70f54bdbbc64..0125f2cfc114 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -464,6 +464,7 @@ static bool construct_phy(struct dc_link *link,
 
 	link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 	link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
+	link->irq_source_read_request = DC_IRQ_SOURCE_INVALID;
 	link->link_status.dpcd_caps = &link->dpcd_caps;
 
 	link->dc = init_params->dc;
@@ -514,6 +515,9 @@ static bool construct_phy(struct dc_link *link,
 	case CONNECTOR_ID_HDMI_TYPE_A:
 		link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
 
+		if (link->hpd_gpio)
+			link->irq_source_read_request =
+					dal_irq_get_read_request(link->hpd_gpio);
 		break;
 	case CONNECTOR_ID_SINGLE_LINK_DVID:
 	case CONNECTOR_ID_SINGLE_LINK_DVII:
diff --git a/drivers/gpu/drm/amd/display/include/gpio_service_interface.h b/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
index 7e3240e73c1f..63813009a3a6 100644
--- a/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
+++ b/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
@@ -86,6 +86,9 @@ enum dc_irq_source dal_irq_get_source(
 enum dc_irq_source dal_irq_get_rx_source(
 	const struct gpio *irq);
 
+enum dc_irq_source dal_irq_get_read_request(
+	const struct gpio *irq);
+
 enum gpio_result dal_irq_setup_hpd_filter(
 	struct gpio *irq,
 	struct gpio_hpd_config *config);
-- 
2.34.1

