Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D3BCA5FE5
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C01F010F9F0;
	Fri,  2 Oct 2026 19:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MMJQoVba";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010070.outbound.protection.outlook.com
 [40.93.198.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E73A910F9D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LV84ELfi6rnNp8oNS3/dbDfR6ME1TA0KssXPNOxjEDo66+Dp87D3LZ8q3fQ20erTrUvseZIjHSmM+LpNVnJl9jhZFl+vpNlKofFieQzWNMP7Z0oLUs9DyK9j3Aziz/JL/b90SwunoL2MEiH1FXodwxWKYtY1cFtEVLiSyplL5X0LFHcuBfwSZAUJhovS7YP8KncP0XZA4S+wS0empiTY38SHRCij5uq3f0km61S+gRMG8SwDW4R9w+0g4PLOll0OZfq60lEMRlKDsduxs/OLeglFB7qvt/aAk3TIk6MFvGzJNEiECM928IRziybrRm3kGllcQxVRFz+6JROGXnhLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClhGb9vflDCiGXa4EzkvfDVup1KPiBK4GQ+q72gacJg=;
 b=CEht2xqZE6O2CRiE0enCllKSVH+ukRMsMNK1RJfnRaaGNs69Z54bBp3kVFs2I0UFYD4+0Fyhwh/v+AlF5SI/Wj4ugAsvGB3hk5Gq1hX6wPC8qBttljdW4Bh9gHcjtVwQX0x/U0JXg2nRYE3qpIFOR/LWFfqP+hy3pqtBeef8H8lfsr+m/Rb4e2f1E9wp62hIv46SyqyvzhVFcksbeapt3MdwRXFrEL1KP9t24ee2xjriQZBMOsfUBhCt7XJjJYK0BRPTEDE8gxyD5syVTdNYFAigEYn4crlMO+sRlU/HJUM5J7bfWoeqBTXd4WAm5tb+MFMzopFmW2PB5a6R+xE80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClhGb9vflDCiGXa4EzkvfDVup1KPiBK4GQ+q72gacJg=;
 b=MMJQoVba/iKXkmYTJ1U5grb0ty88RIDpV5weiAKTtbZB19kYeI4g+H3/ooYXpMLAAqUm6M3BmIY1YaZqkmWc3yM7FfWgGsRrBV7VXwGhbnQ+Gi2Dt1YkjIGUosFgeFvwwkOx/LGVZuROEKnyYLQoGb2Srk1hZLy3/ePB3Gfjm4U=
Received: from CH0PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:33::15)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Fri, 2 Oct
 2026 19:33:24 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::93) by CH0PR08CA0010.outlook.office365.com
 (2603:10b6:610:33::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:33:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:23 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:23 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Dillon Varone
 <Dillon.Varone@amd.com>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 14/17] drm/amd/display: Add dcn42b project id
Date: Fri, 2 Oct 2026 15:32:37 -0400
Message-ID: <20261002193240.3441018-15-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ebb510c-f1b1-4c9c-76fe-08df20bc065b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: mqSbogyHUAT6acqQRONRerBy3QzFmbxEOAt1NNU2RGSt5mkwAadp860gD53vuZ18lkeZl4qtLcldlMsr+nyFlrmWbhnY3wlprf74tm9vDlOxH3pijoq/JfXw9W2ye3eRY7JppmAX+MBUqgmKtanZLDBt3jtPD5wM46US+GREZOBm5L4JPCxCEu2+3nza67eWYXaIekVlnBw+9lM3VMP8sAtGn5sPxBqGQolAIOsTUkJgPgmhHM9JD+xoSnAnvurOMFp0WTFeplfV7dEZCpOyOHCjWtQaTe3VA65zs0Fro7M7Evb3CWN/xbJ7ci0BnXuO2koZBVVEp3wvvhReC4NcXIjc6r700d9G4Kibqb9l412PsSCit1kPFOoi4nHJGp8xuL1QC3EuBTgQFziFT/4ps51gGVyF6zmosNXqE5w9ezU2C4wmb8H/dp0rbKX7zRx8kDtPBtT3+XrafDtyCvRwYXuzWZwe5iyLnjnlTNOIFuyhvU8XNyj28wZyCTM0QACfEaNcfaqVyNsDNiifaDGrZPX91OyRGqfo2qLZc5vKwLj3bQKpVHPTt4PbJLtqkpVXVDR1UdusgrEdUWwePaXiXVhR1e7s4K2S213E+nA+vmbf9zspEAinLqRqcY9uyJ2lZumPHoCO1QN/J/eUGts65csmBiOBN7sSMgFUF2JkyaQWIaen3MEDon1qhjTzWNujDKdG9PT6mqrb77LzF18iHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cl1D+SroAwY5Y+leEesdnToM8Zfj2Dh/Eo4ilDGEvilc4NzxR1Vq/LkQ3oBexmfHKNpmdiLXWJGhOCcd8HI4YhkbcbO7SiMyKrQm3yVsSzocHSEEunvhnonwew0tPQNYwKdJf/JvUSdYAXBixesozaqIATbsb15ZDXVHIxX8DncCooQQ3mKNbIV4uBAtGJcy2u+WxoYB1uTmW7Rmm8ip9DLlwsgOyK4Iq+H9axRaaxCSCfHT1/23XECqy721mt3w/suGie3VjlBVEvrsXPqpc53HixGWv18+ZJh7QPNBlWCBEfBlAXcBEShfJBlxhwbiA8fkqyd9Y9oKmOzlhGyFN9oEcNsJhE7296RwWQp3KhAZ+h8MOSd1Qn5HSCz+g9ybw5voZFVRvtIiTinxFE1oXHHpfXQTGaTzTVBRpCGzpnaewheqXL5craJ94129c1FK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:24.2222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebb510c-f1b1-4c9c-76fe-08df20bc065b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Add project ID to distinguish dcn42b from dcn42.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h  | 1 +
 .../amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_factory.c  | 1 +
 .../display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c    | 1 +
 .../display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c    | 1 +
 .../amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c  | 1 +
 .../amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c  | 1 +
 .../display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c   | 1 +
 .../dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c   | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index 5a8550f592ca..75a24a85775e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -20,6 +20,7 @@ enum dml2_project_id {
 	dml2_project_dcn4x_stage2,
 	dml2_project_dcn4x_stage2_auto_drr_svp,
 	dml2_project_dcn42,
+	dml2_project_dcn42b,
 	dml2_project_dcn4x_utm,
 	dml2_project_dcn5x,
 	dml2_project_dcn5x_utm,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_factory.c
index 92cdc11c1892..ddf4f55cc261 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_factory.c
@@ -16,6 +16,7 @@ bool dml2_cga_create(enum dml2_project_id project_id, struct dml2_clock_granular
 	switch (project_id) {
 	case dml2_project_dcn4x_stage1:
 	case dml2_project_dcn42:
+	case dml2_project_dcn42b:
 	case dml2_project_dcn4x_stage2:
 	case dml2_project_dcn4x_stage2_auto_drr_svp:
 	case dml2_project_dcn4x_utm:
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
index 0800c667f204..320f60cfa165 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
@@ -35,6 +35,7 @@ bool dml2_core_create(enum dml2_project_id project_id, struct dml2_core_instance
 		result = true;
 		break;
 	case dml2_project_dcn42:
+	case dml2_project_dcn42b:
 		out->initialize = &core_dcn42_initialize;
 		out->mode_support = &core_dcn4_mode_support;
 		out->mode_programming = &core_dcn4_mode_programming;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
index 528ebadb87e1..ec09c69482ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
@@ -45,6 +45,7 @@ bool dml2_dpmm_create(enum dml2_project_id project_id, struct dml2_dpmm_instance
 		result = true;
 		break;
 	case dml2_project_dcn42:
+	case dml2_project_dcn42b:
 		out->map_mode_to_soc_dpm = &dpmm_dcn4_map_mode_to_soc_dpm;
 		out->map_watermarks = &dpmm_dcn42_map_watermarks;
 		result = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
index a1d63148b6e5..0105fb890792 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
@@ -33,6 +33,7 @@ bool dml2_mcg_create(enum dml2_project_id project_id, struct dml2_mcg_instance *
 		result = true;
 		break;
 	case dml2_project_dcn42:
+	case dml2_project_dcn42b:
 		out->build_min_clock_table = &mcg_dcn42_build_min_clock_table;
 		result = true;
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
index 44438792931c..997a2be30ef9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
@@ -63,6 +63,7 @@ bool dml2_pmo_create(enum dml2_project_id project_id, struct dml2_pmo_instance *
 		result = true;
 		break;
 	case dml2_project_dcn42:
+	case dml2_project_dcn42b:
 		out->initialize = pmo_dcn42_initialize;
 
 		out->init_for_vmin = pmo_dcn4_fams2_init_for_vmin;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c
index aaca0a450f0e..95558710a834 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c
@@ -19,6 +19,7 @@ bool dml2_initialize_instance(struct dml2_initialize_instance_in_out *in_out)
 	case dml2_project_dcn4x_stage2:
 	case dml2_project_dcn4x_stage2_auto_drr_svp:
 	case dml2_project_dcn42:
+	case dml2_project_dcn42b:
 		return dml2_top_soc15_initialize_instance(in_out);
 	case dml2_project_dcn5x_utm:
 	case dml2_project_dcn6x_soc_var_a:
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c
index 2faf28f753fe..68a6b1a4f2a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c
@@ -20,6 +20,7 @@ bool dml2_utm_soc_bb_create(enum dml2_project_id project_id, struct dml2_utm_soc
 	case dml2_project_dcn5x:
 	case dml2_project_dcn4x_stage1:
 	case dml2_project_dcn42:
+	case dml2_project_dcn42b:
 	case dml2_project_dcn4x_stage2:
 	case dml2_project_dcn4x_stage2_auto_drr_svp:
 	case dml2_project_invalid:
-- 
2.34.1

