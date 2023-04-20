Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01638C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29BBC10ED48;
	Thu, 20 Apr 2023 23:50:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622EB10ED44
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe/t9gcxuE+XKgHYsjH2zOu0JkLqKnedwHV6dH/NsxkKhX/cvHDH8k6R71G918Dc6zkH6OIdTRx5W6i2Sm+uqYvxo5ZSGPnbwmonWZvUAFgjez3Aydp9GAnYXoqOK/5Rj7Q9pn0J6aTWpSv6QXiGLReBR5VIDvEYzfRW5/UuEA2zie4FQuX6gfT38Y0Ssv/JI3zzep/mUA4MBATkfecSsuLBixGE5Oq5GHbF1l1bM6mCP1S3nTvp6giI1kHf/9fnV0N65tCOgVDYZBUapGe9sCGIOfwi3xXPFTCksNcJSfu4mF0ZUywf7hpkL54F+LBKqPcaW7FLrDxD51S/lg0/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoX18zDt77IvraDftm4Lor5QM14Tp0x5VqWE+GVC8Gw=;
 b=TJ0pAMhxnj7s8cTdUR4m8wmTdxMsFtYI+xCnmT9sKE4AU7qYuLRkXKZ7Us3YbjeYtqW61QkSnNFZ+IHvisq2dQJMAmMOXGhOuB33YSoQip7eHp7bSBZccbN/UhikqjcWyHMvrxMF5JOEIyczFybLlMt6W5uCRlMqVvj0VToUPOK+8Fcw8z/BtHGLYtUk0Cpi5fVh4ULt/KEcXwgGBghOqcNm1pS88ifZmtq7j/fYZdnAf4GPAXE4habVzJi+j39Qpl3T7t7F5wd1rB7x2Wm/nyXhJFd7MAjXIuF7SkD7i7RTWz1+08wJ4CbRef7Y9wS4tuIqPBfjUsjVXEvWNgXktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoX18zDt77IvraDftm4Lor5QM14Tp0x5VqWE+GVC8Gw=;
 b=fHRbK3YPsx2I5xRBM6NOVdw+/39+jSUMosdQG+sIunr+wqfxgJlx6PfgeLDmE5uMpHnrcKCIIx8STkv+mV9k74sQO8wqOpUZ7m22xG4SjJvdMOh0TpZd5Z3qMpIl7oEyOc3IVgb4yFtFcFFdqC3kaiJ8WQ1QAm2LgdoJJobOFh4=
Received: from DM6PR08CA0017.namprd08.prod.outlook.com (2603:10b6:5:80::30) by
 DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Thu, 20 Apr 2023 23:50:11 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::15) by DM6PR08CA0017.outlook.office365.com
 (2603:10b6:5:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 23:50:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:08 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/21] drm/amd/display: Convert Delaying Aux-I Disable To
 Monitor Patch
Date: Thu, 20 Apr 2023 17:49:32 -0600
Message-ID: <20230420234951.1772270-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 28138853-c19b-490b-697d-08db41f9fa96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTRVozVVEJxDVaRkB2Re9HKrjedU/UbistaYUI5Spvta2tmv1rZVZ83lh2Lsw0RiZGQtMBY56am4VB25zZlUaZKkYWMY/qmQB6hYUoD9p9v8M6gIiqMH3tTW1V45r2Ek+Urt1P/twz1FA36Ls3i6izFyhIZ2wmZrJYqrPqI+mwUBCje06qx1CCMqnQAz0+ZRgokPLdq0Dq8uCPAVFR3l1cbhgouPe7fGkRou1glXlqw0aHwABifUG25PdbemNFKNG/UOnTd2mzSxZEoKp7aA8NEK27qroJfEaD1EffMdhEoo9kodyCkmiqPj3g++tBE4TECKmjSNOMoW/c7Xitp/4sAxUbQpzQUGYcRWbsSE6yJK6dXMoNxj2XWPp/dJ5UqlpLqoqvlr5f6gsGWM8a3lzA4HAgU+o4aCKdDzDTwEyudndCu9unm71I8UpmNmWaKgJ6hBfovuRzRii/v+Llb/FKYY47vkWEKF5glu+Ikw+RbBygTn5wyXCmQgNGNauzn+vng93Nf90krqryZ6ULJv3SgflrMcT3LTrZOgnfejk9XzXelbn1NnkP6WFUykqA4Spj5R5G63yugU7+wdjYObBtIFhPfPFGphpb2D2vwNHZ8Qg4SGsTXtzLJq+9/iTh9nB475xt3C+x8d//1SGbDK47HU5ce8T6hp6T0uefV4SnL7YpkoIw8c3Ehph4IjxX3MfVJfecT7bysKsNI5DFNj37kVYmB3x6oEZHN+fFIIevw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(36756003)(4326008)(316002)(6916009)(70206006)(70586007)(54906003)(478600001)(6666004)(40480700001)(82310400005)(8936002)(8676002)(5660300002)(41300700001)(2906002)(82740400003)(86362001)(81166007)(2616005)(47076005)(426003)(336012)(26005)(16526019)(40460700003)(1076003)(36860700001)(83380400001)(356005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:10.9099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28138853-c19b-490b-697d-08db41f9fa96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
32ms delay was added to resolve issue with a specific sink, however this same
delay also introduces erroneous link training failures with certain sink
devices.

[HOW]
Only apply the 32ms delay for offending devices instead of globally.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h             |  1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h       |  1 +
 .../link_dp_training_fixed_vs_pe_retimer.c      | 17 +++++++++++------
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b45974a2dec3..97747f5fde56 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -855,7 +855,6 @@ struct dc_debug_options {
 	bool force_usr_allow;
 	/* uses value at boot and disables switch */
 	bool disable_dtb_ref_clk_switch;
-	uint32_t fixed_vs_aux_delay_config_wa;
 	bool extended_blank_optimization;
 	union aux_wake_wa_options aux_wake_wa;
 	uint32_t mst_start_top_delay;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 34c848311455..150c19286d67 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -196,6 +196,7 @@ struct dc_panel_patch {
 	unsigned int disable_fams;
 	unsigned int skip_avmute;
 	unsigned int mst_start_top_delay;
+	unsigned int delay_disable_aux_intercept_ms;
 };
 
 struct dc_edid_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index 5731c4b61f9f..fb6c938c6dab 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -233,7 +233,8 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 	const uint8_t vendor_lttpr_write_data_intercept_en[4] = {0x1, 0x55, 0x63, 0x0};
 	const uint8_t vendor_lttpr_write_data_intercept_dis[4] = {0x1, 0x55, 0x63, 0x68};
-	uint32_t pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa;
+	uint32_t pre_disable_intercept_delay_ms =
+			link->local_sink->edid_caps.panel_patch.delay_disable_aux_intercept_ms;
 	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
 	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
 	uint32_t vendor_lttpr_write_address = 0xF004F;
@@ -259,7 +260,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 
 		/* Certain display and cable configuration require extra delay */
 		if (offset > 2)
-			pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa * 2;
+			pre_disable_intercept_delay_ms = pre_disable_intercept_delay_ms * 2;
 	}
 
 	/* Vendor specific: Reset lane settings */
@@ -380,7 +381,8 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 						0);
 				/* Vendor specific: Disable intercept */
 				for (i = 0; i < max_vendor_dpcd_retries; i++) {
-					msleep(pre_disable_intercept_delay_ms);
+					if (pre_disable_intercept_delay_ms != 0)
+						msleep(pre_disable_intercept_delay_ms);
 					dpcd_status = core_link_write_dpcd(
 							link,
 							vendor_lttpr_write_address,
@@ -591,9 +593,11 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	const uint8_t vendor_lttpr_write_data_adicora_eq1[4] = {0x1, 0x55, 0x63, 0x2E};
 	const uint8_t vendor_lttpr_write_data_adicora_eq2[4] = {0x1, 0x55, 0x63, 0x01};
 	const uint8_t vendor_lttpr_write_data_adicora_eq3[4] = {0x1, 0x55, 0x63, 0x68};
-	uint32_t pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa;
 	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
 	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
+	uint32_t pre_disable_intercept_delay_ms =
+			link->local_sink->edid_caps.panel_patch.delay_disable_aux_intercept_ms;
+
 
 	uint32_t vendor_lttpr_write_address = 0xF004F;
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
@@ -618,7 +622,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 
 		/* Certain display and cable configuration require extra delay */
 		if (offset > 2)
-			pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa * 2;
+			pre_disable_intercept_delay_ms = pre_disable_intercept_delay_ms * 2;
 	}
 
 	/* Vendor specific: Reset lane settings */
@@ -739,7 +743,8 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 						0);
 				/* Vendor specific: Disable intercept */
 				for (i = 0; i < max_vendor_dpcd_retries; i++) {
-					msleep(pre_disable_intercept_delay_ms);
+					if (pre_disable_intercept_delay_ms != 0)
+						msleep(pre_disable_intercept_delay_ms);
 					dpcd_status = core_link_write_dpcd(
 							link,
 							vendor_lttpr_write_address,
-- 
2.39.2

