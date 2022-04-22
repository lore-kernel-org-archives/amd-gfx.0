Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F5BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA1810E4BB;
	Fri, 22 Apr 2022 16:46:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A5C10E4AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gudsWSou5FLZr3gfMkQSKtm9Z1QQlxzPG4i7SCALopxyYOrfMn5A1a1/niNGyYjWeoA/R42meOmuljZsKV1cRmXGkmtTCK1pDiTs+bRWbTPbXu2I5Ko2jfqG6F76yD7rF2kNgP+d3WzC59ZMZ5RCfUBjq/+0FB4XWWC6qsSpYNarBmZnV6ZrnHKE0pVuA/Z0oYpzf5jHUvksjGTZwJH9nS4aVmuA0w1SPOf5+hG9iRK/kI3pMn1T49wgJUV1HDOzpPaac3otknHeEuEWPe2B+PbKsdq5xPGxCZOlWAbPM2Xq8iGIY9MiQRwHYiF98yhSewWZBV9XdwsU5CagNlbKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvGcclRst8Yv+y8vDSzUQB2Y1vDEKvLgG8ilHBj9X/Y=;
 b=LIw2G8Gl/d4pduSYZHGR83gv7T4WaQFg+KsRA+o3o324uZ5YVsJMHs4ZkF4mVt1GBfjlObV2ENnAOW1iA85dZ5NSoik5Tl4oYmKQK7meXyIyQ5Tt/z9OUin1SrT/AJ8OfcFHC+Mp4CovJzYdzIkIgXhawvSmg261QSpH8D1eKT8zEt98/AsymCn/bgnD6Y7W8FDeqcRq/VYhh8QKoAgXDC1TjH5oF0A0Wy/s43Y8TmJ7Q9tLnURMuHvv3w2rHBZoHUUQZ/7U8d6igk50xpBMz9cUEccbGNJeup2fo949gfmaVMFVQpyc4lklCuRI3cE97qbvDnx1U+Fbk2KmdPLVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvGcclRst8Yv+y8vDSzUQB2Y1vDEKvLgG8ilHBj9X/Y=;
 b=KJtAEPDVhjt1cJAlXFdHAIFxZSERrt7gwvs7okgboO9JA2DzgvAmwvIFiovyPcudLPsNfM+TvJgTvnuKY7i1Viu5FKG+V7hA/GfrlUCEiFFz8Zkxp3o2dhq19Oes3xyPvNncsR5IWP7O5e+eYFsOskwmlPWRfMl5/tnKqoj7/cI=
Received: from MW4PR04CA0218.namprd04.prod.outlook.com (2603:10b6:303:87::13)
 by BN6PR12MB1297.namprd12.prod.outlook.com (2603:10b6:404:14::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 16:46:55 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::dd) by MW4PR04CA0218.outlook.office365.com
 (2603:10b6:303:87::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 16:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:46:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:46:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:46:50 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:46:46 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/13] drm/amd/display: Don't pass HostVM by default on DCN3.1
Date: Sat, 23 Apr 2022 00:44:51 +0800
Message-ID: <20220422164457.1755751-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d16cee25-4618-4649-f915-08da247fb508
X-MS-TrafficTypeDiagnostic: BN6PR12MB1297:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB129728CF45453CFF91ADA452E6F79@BN6PR12MB1297.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRqleFPxJ3YoQQ18Rzr0+41rnKQzzcufwNsiLl17Ll+Z26Dgi42Iy+1PGW6i6KeYEPQo7D8frU3gcCansST0XCrBxjrXq5TekJEqyn3AAFzIDLRzecAYo68hzOctJIr4M7+2C4JD+ZWe9BCN95MZSnyO7jBRzyiolMxbC2FICnncYtEqEor7tfGfXuV+r+x7K8F+goU0vi3Z0TpApC/NPRpFw4e4zi4QHbUnK/ZyNSHYv2C7ptqQO1waPw/Ccd3miJfcaEMQ4Mi9io6YABlNd37SjuHIg0mWFsI1eYKt12ltIaQo/gbntqYlDpYXrVlDiimot/FbWyaFvf5GsJBb9rTxbWqLI+6qwHaEtVcVilbleJ5eEwPZlNqckpiB2ImfLUarAChdGObG6zre82W++MpCv5xlwpcN0/gs3Cli4bLpcHFXhaZK/ZZ4cFcxFc/NLOFBBs3SZlYhLqqPCEBjjhXRvG379GTlDYl7QWFKrmMzgAmd3OiUk1/BQld3GUNZ1LZv4uJXTyUg5OAj31BB7DLwPHiSFm0jxLrgind0vNHrRB62Ka/43t+NWheYV1K2x2UMW9fP5u+6/cQbru1U1sPr2HVZax7m4qN+DEJ6kOhql709ZgFRGZaHQzZramGqGgUgQ2k//fHKzJkrBWFQ2M0yBXeiMYLbcYsM6tblJNK1W+4TAut6ORmfx4Jf5OaysyxaY/WKNFGAy4LZyMh8Hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(5660300002)(54906003)(82310400005)(6916009)(7696005)(1076003)(81166007)(26005)(356005)(47076005)(6666004)(426003)(336012)(2616005)(186003)(2906002)(36756003)(316002)(86362001)(508600001)(8676002)(70206006)(70586007)(40460700003)(4326008)(8936002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:46:54.1182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d16cee25-4618-4649-f915-08da247fb508
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1297
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Roll back previous change to stop passing this value by default, instead
add a debug flag to override to previous behaviour (or force HostVM calcs)

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                   | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5c85e52e5406..78b9df776503 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -359,6 +359,12 @@ enum dc_psr_power_opts {
 	psr_power_opt_ds_disable_allow = 0x100,
 };
 
+enum dml_hostvm_override_opts {
+	DML_HOSTVM_NO_OVERRIDE = 0x0,
+	DML_HOSTVM_OVERRIDE_FALSE = 0x1,
+	DML_HOSTVM_OVERRIDE_TRUE = 0x2,
+};
+
 enum dcc_option {
 	DCC_ENABLE = 0,
 	DCC_DISABLE = 1,
@@ -733,6 +739,7 @@ struct dc_debug_options {
 	bool extended_blank_optimization;
 	union aux_wake_wa_options aux_wake_wa;
 	uint8_t psr_power_use_phy_fsm;
+	enum dml_hostvm_override_opts dml_hostvm_override;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 5b3f0c2dfb55..d3edc9d11d88 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -890,6 +890,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_sw_cntl_psr = true,
 	.apply_vendor_specific_lttpr_wa = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
+	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
@@ -1666,7 +1667,6 @@ int dcn31_populate_dml_pipes_from_context(
 		 * intermittently experienced depending on peak b/w requirements.
 		 */
 		pipes[pipe_cnt].pipe.src.immediate_flip = true;
-
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
 		pipes[pipe_cnt].pipe.src.gpuvm = true;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
@@ -1675,6 +1675,13 @@ int dcn31_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].pipe.src.dcc_rate = 3;
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
 
+		if (dc->debug.dml_hostvm_override == DML_HOSTVM_NO_OVERRIDE)
+			pipes[pipe_cnt].pipe.src.hostvm = dc->res_pool->hubbub->riommu_active;
+		else if (dc->debug.dml_hostvm_override == DML_HOSTVM_OVERRIDE_FALSE)
+			pipes[pipe_cnt].pipe.src.hostvm = false;
+		else if (dc->debug.dml_hostvm_override == DML_HOSTVM_OVERRIDE_TRUE)
+			pipes[pipe_cnt].pipe.src.hostvm = true;
+
 		if (pipes[pipe_cnt].dout.dsc_enable) {
 			switch (timing->display_color_depth) {
 			case COLOR_DEPTH_888:
-- 
2.25.1

