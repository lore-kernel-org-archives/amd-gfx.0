Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A976FC00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E3BB93AB;
	Fri,  5 Aug 2022 18:00:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8341B8B6E9
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GApW+ff67EHez5MyH9cpsiEi2Y7RdhXnk7fYAo77KYaKk91OpVfPGRs1ktF/qXum7eNwMBAw/LLxifC0EnqByqRtFaYg3XiXk36bkhEuKfDF0ii+Lx1MDHcqZofUoyY94pUoHY+SPuUdVK8ElsG0c/T+XGEPZM5t2NQuFNfjlcN4H9p07e6ttLa28EXEUEOa/QByz3R2js4ijg3UYhqhT1aKieFQl82YCBV6eIjWpJpIRa13tvXjl+gcaCrR30SW4rA6t41wNfPlT5PKejsuZO3e+frzCEt2d82pEqVOLgpGm2tJkTlibz02TliyZU1E4u306io2BQFr6YdcfWl55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McQLi8pgzfBOOBXXCSCRz7njgK4zyJ26hf4brGuTXyQ=;
 b=ldr5VuMDV5pH13hQk+O24zP9lql6ikroRKBExhaNraxcu9dG4+bgjpEv6QnAzk+NOFHBlrjnExz0piNrxftsBHVkurrPfqw6j3e0OJ5egwyNdngnWCbAoluYKkB/xnkf9wi47s0UBuTJhkzP0cOadSddLz2gbPOrZvwAwt9CSlq4/vmfw2XaIrzaWoFv95UBl/TeETbgLnrZ5sVgMGzsSsZzRlte6ht+Sq/OoPj3VunuK8ipOSlq6FRQwiYunxJ1sbyZ/yK/9RcYxKcydTQfY9VTNyByux9M4+WCioBssaOERWEPw+XCmdZLWHaRJzJsNQypHP5JocadDhk3TLFElg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McQLi8pgzfBOOBXXCSCRz7njgK4zyJ26hf4brGuTXyQ=;
 b=2Cmd0aEOIwLJhJrl0E/mB4zH4DIF6OhMlyrES12crfhaFXQNp5eaeUYwlJ9boz5/IhhJ0fv7BsKNPh6i7tu1iULx+5UFcuYWmEzg7e+xB76SdqQOxd+VXM7bns0lvvBaFQS4zphPLSQeIj41KpCa+UDffIZigPEh26MgQ+LK3eA=
Received: from BN0PR04CA0147.namprd04.prod.outlook.com (2603:10b6:408:ed::32)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 5 Aug
 2022 18:00:40 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::be) by BN0PR04CA0147.outlook.office365.com
 (2603:10b6:408:ed::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Fri, 5 Aug 2022 18:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:00:40 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:00:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 11:00:37 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:00:32 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/32] drm/amd/display: Document some of the DML structs
Date: Sat, 6 Aug 2022 01:58:14 +0800
Message-ID: <20220805175826.2992171-21-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed98178e-2fca-4322-2618-08da770c685e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iojsaDEBJW3/hcTU/qBMQfhn2mv9BNnYZ9XwZP6Lk5LYGS8msjzxBdy6Gy0cZN2pELevLp2qXa09IsATIGxYukAUihUca6P7SisVH/TeFXdWST153V10MrDNB3qEpJ3jhlJSPLqTqlRN05j9+PFE1ZqzobxjzFWO9gI7B+6wdARC1OyemQsSgMA0IsIxckhm7ltBPiRoQP78fYFjybqeSN900/qIRu7RYgCZX0xeoHBS9N1w0ovWztpI5XyU5o/CcS1757Ahqp56l4Yuz1RV21+jRDLs45OVGdCaUJGffOyDgyC6F2h0zfIgaXBdQJyhqad7synygX+34bq0Gy4i5vrf++vCYRHH9HlbXVgr+DEuWQRZ1yVVm5fFs+7RSRLenE0qDCPcZdoxOaYM2yfsI0we5Mmub9A8xONFnWUukZC03iLU9xmpuMwKFMLR1RFaQ8lewXA7O4Ir7uROXFCYqK9IE3gEsl1dEK+/WTIdNL1PBQm4DleZN0a9H4h8gYyF3I8ddig6Ih+8YS4vcwWkvdv9i6OhqkV7yUvTwD7pZR0SaPKl2xVCgJ2mEZvSZv/AOtH3QtzqIemgMSZW0hoQ8j8B4ihMPAESxj57MdeKLJdhA9XPvaLCQdwRBVHHihOq+AHKvdEmDFUiZyWdfkZgLlf+T6n0H9PeO0b0SPZXAbYZa/sWaQVlX67aIUq4YJ8zkSo3m/R4rqZ/42zb7ljM9X+sgwIHpzGA41k5ETKYXTDto4vL3cS48JVtsmCBqIQiZYmAiOyngQCCpRYY/I4z2Fyuj4W1aUoLm0BKivntXZM7pIG41DGvWJuMbhe3wQ262F4TNfW0rIo75PTU/aIvwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966006)(36840700001)(40470700004)(26005)(36756003)(356005)(186003)(54906003)(1076003)(6916009)(40480700001)(82740400003)(4326008)(8676002)(82310400005)(81166007)(7696005)(86362001)(8936002)(6666004)(2616005)(70206006)(83380400001)(70586007)(2906002)(41300700001)(47076005)(426003)(40460700003)(478600001)(5660300002)(336012)(36860700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:00:40.0035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed98178e-2fca-4322-2618-08da770c685e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dml/display_mode_structs.h | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index e8b094006d95..8538588e7754 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -26,6 +26,16 @@
 #include "dc_features.h"
 #include "display_mode_enums.h"
 
+/**
+ * DOC: overview
+ *
+ * Most of the DML code is automatically generated and tested via hardware
+ * description language. Usually, we use the reference _vcs_dpi in the code
+ * where VCS means "Verilog Compiled Simulator" and DPI stands for "Direct
+ * Programmer Interface". In other words, those structs can be used to
+ * interface with Verilog with other languages such as C.
+ */
+
 #ifndef __DISPLAY_MODE_STRUCTS_H__
 #define __DISPLAY_MODE_STRUCTS_H__
 
@@ -159,6 +169,14 @@ struct _vcs_dpi_voltage_scaling_st {
 	double dtbclk_mhz;
 };
 
+/**
+ * _vcs_dpi_soc_bounding_box_st: SOC definitions
+ *
+ * This struct maintains the SOC Bounding Box information for the ASIC; it
+ * defines things such as clock, voltage, performance, etc. Usually, we load
+ * these values from VBIOS; if something goes wrong, we use some hard-coded
+ * values, which will enable the ASIC to light up with limitations.
+ */
 struct _vcs_dpi_soc_bounding_box_st {
 	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
 	/*
@@ -166,6 +184,11 @@ struct _vcs_dpi_soc_bounding_box_st {
 	 * clock table. Do not use outside of *update_bw_boudning_box functions.
 	 */
 	struct _vcs_dpi_voltage_scaling_st _clock_tmp[DC__VOLTAGE_STATES];
+
+	/**
+	 * @num_states: It represents the total of Display Power Management
+	 * (DPM) supported by the specific ASIC.
+	 */
 	unsigned int num_states;
 	double sr_exit_time_us;
 	double sr_enter_plus_exit_time_us;
@@ -231,6 +254,14 @@ struct _vcs_dpi_soc_bounding_box_st {
 	enum self_refresh_affinity allow_dram_self_refresh_or_dram_clock_change_in_vblank;
 };
 
+/**
+ * @_vcs_dpi_ip_params_st: IP configuraion for DCN blocks
+ *
+ * In this struct you can find the DCN configuration associated to the specific
+ * ASIC. For example, here we can save how many DPPs the ASIC is using and it
+ * is available.
+ *
+ */
 struct _vcs_dpi_ip_params_st {
 	bool use_min_dcfclk;
 	bool clamp_min_dcfclk;
@@ -283,6 +314,9 @@ struct _vcs_dpi_ip_params_st {
 	unsigned int writeback_line_buffer_chroma_buffer_size;
 
 	unsigned int max_page_table_levels;
+	/**
+	 * @max_num_dpp: Maximum number of DPP supported in the target ASIC.
+	 */
 	unsigned int max_num_dpp;
 	unsigned int max_num_otg;
 	unsigned int cursor_chunk_size;
-- 
2.25.1

