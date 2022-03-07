Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24330C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 06:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B8910E064;
	Mon,  7 Mar 2022 06:41:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0FE10E064
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 06:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWgBrqXqjWcP5I6f2P1lIY5mQgHy9Y+z+KHDZSLBYASm9cn4gqPfq2LGmTJzm50GkjNhwXKxq+y3NaEH9NJHc3vPVPj9AwEKX63dLANnGnN4sr9LfIMFi9t7Dy9UPXy4JF2XqOlCYORTb8yusqsfS8eaDNbmhfC9pHf1ri1qhtUGSOBp7Pugz9rLKjsGOie0HpPSzdbU5nsgpPPn8IcIFVkCVriUHFB9Ia7H2VGqi2LXMJzAm2J8Y5B57zfjwCsM8a9p+3gSGHTTLtpetJocETkTe15jH9IVyqld0YaQQttup5udDcRU2sIOLYc0BALVW/885e8rLLyl9mnlDE5rMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/J+/GmOvVMcSOSGSxSQvwqmhQ6wps8pIeUqtZrn6qk=;
 b=IXR0r/wrkoc+mJO9m2C3bwogkyv07xYtuE/J3j5ruNOaesSHfA757g3tp//iyIaTfoI/vbRDiXmQ4Ds5xAzUfTo76KUvoQwS5983HHevpc77Qsq2grP/svNBwEhmDksVCbJQ/APudOvO7MQwup2+ZsbuEPWQh1CnOQaqkb0PKDM/KGRD8LEPgvwdrcC7CJvoRgneciyfUp+/SVzPL2R9cGvQd1bD1EdDp1nFSlmXR0BDbzSK5BnUZTEsDRQ61NlTyUB9CqaDlV8Ht9AEdLSPhD2CgNML5Pvh5Vw4ivfvVW8MfnjQRWQgXI3khkYrMNnUhjRcCQaHBtqHwa/GCD6gaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/J+/GmOvVMcSOSGSxSQvwqmhQ6wps8pIeUqtZrn6qk=;
 b=USSYk3dwG/YJXZZbYvfwRexOJHT8hQpU7F857cRKCxJjfSLJGGOLu9lpPMymyS77S22cgh0daox/WJMcAUq5ae2Mf5k8CafirPLzZG89cWdUU0c8dVxGbWI8/pYy8UXd0i3nBU2H0lFW1YZabBVXUb5MnlBdgFopP8hXS2Weaco=
Received: from DM5PR07CA0080.namprd07.prod.outlook.com (2603:10b6:4:ad::45) by
 MWHPR1201MB0205.namprd12.prod.outlook.com (2603:10b6:301:4e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 06:41:48 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::a3) by DM5PR07CA0080.outlook.office365.com
 (2603:10b6:4:ad::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 06:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 06:41:47 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 00:41:47 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 22:41:46 -0800
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 7 Mar 2022 00:41:43 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/21] drm/amd/display: cleaning up smu_if to add future
 flexibility
Date: Tue, 8 Mar 2022 06:02:00 +0800
Message-ID: <20220307220218.445431-3-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41ab68f7-8be5-42fc-e3a4-08da00058dbc
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0205:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02055440C3E99A6535C908A8F5089@MWHPR1201MB0205.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T121oHNliEI5pCmAxREUE2U2H3aDvR2K643v/jm+ow16jnHHk30QnsphplqTbfXDKhXdJaUxm51TgM5E+pLxNTFS2Bsda8S96v8uIdTixTIsnQ6USXbMwzFDvOtImv/zK/bTYw8GWfadpCqUUEaOyV1N7RwgT8FyVHa00X4BtCWMNnnUZeoIiJhTrhrzvgqy7rp/5ncMy/2qwErPAmn/FciBiVi0ND04haPq7GqqNjKL8IyMIbLfPPrQgjZbjvf9o6sK/M5g+gL+6efEFlun7AbnPa05Xrmmcw35nQdfu/If76dDc4AfRZVsiLT1/aDIJTCS9/nfzrnK3VkcOE4CPP2pzzeqrx/doWRoqg520vBizkupiKEfKwPC/4+cxvllM0zv1WhJrHz1PmUL4Cku2TAS9YCQcTZoEZkvBknpuNlZwVvfBa/p9Mvk+NU5oSufVrnY73DO+Pv+1a8ezJiKP5kdKMXDd8BigvLjiCMrEQv/pMos7cY0a/csgaTNDVc3D6P9doOUrgc3NUY5fY1yRBHEUbhGT+0F/BRpoJYbftJ9Po6oowzyH0fke92QjRw3haH4ve+wGYtIbfekCJBSDlLq1LoB4tsycjxJ0vHPmu12qVKrLwolT44TfIDxm4pahAHYh5odBSBtqM96x3XZWMISiPwfFNW6Xz5e0BlcDXurOmAi3BWUyfFq+1NGJhB4xl/2K+stlkfWC0MCPriBIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(26005)(81166007)(5660300002)(8936002)(2616005)(47076005)(316002)(54906003)(6916009)(4326008)(8676002)(86362001)(356005)(70206006)(1076003)(70586007)(83380400001)(40460700003)(6666004)(426003)(336012)(36860700001)(7696005)(2906002)(30864003)(36756003)(82310400004)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 06:41:47.8212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ab68f7-8be5-42fc-e3a4-08da00058dbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0205
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

why and how:
need to hook in new smu interfaces
cleaning up code that used old variables

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 13 +---
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  |  9 ++-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h  | 67 +----------------
 .../dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h  | 74 +++++++++++++++++++
 .../display/include/grph_object_ctrl_defs.h   | 22 ------
 5 files changed, 86 insertions(+), 99 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 220682e45b8d..5ed6a93d1708 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -25,30 +25,23 @@
 
 #include "dccg.h"
 #include "clk_mgr_internal.h"
-
 #include "dcn30_clk_mgr_smu_msg.h"
 #include "dcn20/dcn20_clk_mgr.h"
 #include "dce100/dce_clk_mgr.h"
+#include "dcn30/dcn30_clk_mgr.h"
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dm_helpers.h"
-
 #include "atomfirmware.h"
-
-
 #include "sienna_cichlid_ip_offset.h"
 #include "dcn/dcn_3_0_0_offset.h"
 #include "dcn/dcn_3_0_0_sh_mask.h"
-
 #include "nbio/nbio_7_4_offset.h"
-
 #include "dpcs/dpcs_3_0_0_offset.h"
 #include "dpcs/dpcs_3_0_0_sh_mask.h"
-
 #include "mmhub/mmhub_2_0_0_offset.h"
 #include "mmhub/mmhub_2_0_0_sh_mask.h"
-/*we don't have clk folder yet*/
-#include "dcn30/dcn30_clk_mgr.h"
+#include "dcn30_smu11_driver_if.h"
 
 #undef FN
 #define FN(reg_name, field_name) \
@@ -83,7 +76,7 @@ static const struct clk_mgr_mask clk_mgr_mask = {
 
 
 /* Query SMU for all clock states for a particular clock */
-static void dcn3_init_single_clock(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, unsigned int *entry_0, unsigned int *num_levels)
+static void dcn3_init_single_clock(struct clk_mgr_internal *clk_mgr, uint32_t clk, unsigned int *entry_0, unsigned int *num_levels)
 {
 	unsigned int i;
 	char *entry_i = (char *)entry_0;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
index 8ecc708bcd9e..bfc960579760 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
@@ -29,6 +29,7 @@
 #include "clk_mgr_internal.h"
 #include "reg_helper.h"
 #include "dalsmc.h"
+#include "dcn30_smu11_driver_if.h"
 
 #define mmDAL_MSG_REG  0x1628A
 #define mmDAL_ARG_REG  0x16273
@@ -197,7 +198,7 @@ void dcn30_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr)
 }
 
 /* Returns the actual frequency that was set in MHz, 0 on failure */
-unsigned int dcn30_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, uint16_t freq_mhz)
+unsigned int dcn30_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz)
 {
 	uint32_t response = 0;
 
@@ -215,7 +216,7 @@ unsigned int dcn30_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, PP
 }
 
 /* Returns the actual frequency that was set in MHz, 0 on failure */
-unsigned int dcn30_smu_set_hard_max_by_freq(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, uint16_t freq_mhz)
+unsigned int dcn30_smu_set_hard_max_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz)
 {
 	uint32_t response = 0;
 
@@ -246,7 +247,7 @@ unsigned int dcn30_smu_set_hard_max_by_freq(struct clk_mgr_internal *clk_mgr, PP
  *
  * Returns 0 on failure
  */
-unsigned int dcn30_smu_get_dpm_freq_by_index(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, uint8_t dpm_level)
+unsigned int dcn30_smu_get_dpm_freq_by_index(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint8_t dpm_level)
 {
 	uint32_t response = 0;
 
@@ -264,7 +265,7 @@ unsigned int dcn30_smu_get_dpm_freq_by_index(struct clk_mgr_internal *clk_mgr, P
 }
 
 /* Returns the max DPM frequency in DC mode in MHz, 0 on failure */
-unsigned int dcn30_smu_get_dc_mode_max_dpm_freq(struct clk_mgr_internal *clk_mgr, PPCLK_e clk)
+unsigned int dcn30_smu_get_dc_mode_max_dpm_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk)
 {
 	uint32_t response = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h
index dd2640a3ce5d..ca9f5296be94 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h
@@ -28,65 +28,6 @@
 
 #include "core_types.h"
 
-#define SMU11_DRIVER_IF_VERSION 0x1F
-
-typedef enum {
-	PPCLK_GFXCLK = 0,
-	PPCLK_SOCCLK,
-	PPCLK_UCLK,
-	PPCLK_FCLK,
-	PPCLK_DCLK_0,
-	PPCLK_VCLK_0,
-	PPCLK_DCLK_1,
-	PPCLK_VCLK_1,
-	PPCLK_DCEFCLK,
-	PPCLK_DISPCLK,
-	PPCLK_PIXCLK,
-	PPCLK_PHYCLK,
-	PPCLK_DTBCLK,
-	PPCLK_COUNT,
-} PPCLK_e;
-
-typedef struct {
-	uint16_t MinClock; // This is either DCEFCLK or SOCCLK (in MHz)
-	uint16_t MaxClock; // This is either DCEFCLK or SOCCLK (in MHz)
-	uint16_t MinUclk;
-	uint16_t MaxUclk;
-
-	uint8_t  WmSetting;
-	uint8_t  Flags;
-	uint8_t  Padding[2];
-
-} WatermarkRowGeneric_t;
-
-#define NUM_WM_RANGES 4
-
-typedef enum {
-	WM_SOCCLK = 0,
-	WM_DCEFCLK,
-	WM_COUNT,
-} WM_CLOCK_e;
-
-typedef enum {
-	WATERMARKS_CLOCK_RANGE = 0,
-	WATERMARKS_DUMMY_PSTATE,
-	WATERMARKS_MALL,
-	WATERMARKS_COUNT,
-} WATERMARKS_FLAGS_e;
-
-typedef struct {
-	// Watermarks
-	WatermarkRowGeneric_t WatermarkRow[WM_COUNT][NUM_WM_RANGES];
-} Watermarks_t;
-
-typedef struct {
-	Watermarks_t Watermarks;
-
-	uint32_t     MmHubPadding[8]; // SMU internal use
-} WatermarksExternal_t;
-
-#define TABLE_WATERMARKS 1
-
 struct clk_mgr_internal;
 
 bool         dcn30_smu_test_message(struct clk_mgr_internal *clk_mgr, uint32_t input);
@@ -97,10 +38,10 @@ void         dcn30_smu_set_dram_addr_high(struct clk_mgr_internal *clk_mgr, uint
 void         dcn30_smu_set_dram_addr_low(struct clk_mgr_internal *clk_mgr, uint32_t addr_low);
 void         dcn30_smu_transfer_wm_table_smu_2_dram(struct clk_mgr_internal *clk_mgr);
 void         dcn30_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
-unsigned int dcn30_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, uint16_t freq_mhz);
-unsigned int dcn30_smu_set_hard_max_by_freq(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, uint16_t freq_mhz);
-unsigned int dcn30_smu_get_dpm_freq_by_index(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, uint8_t dpm_level);
-unsigned int dcn30_smu_get_dc_mode_max_dpm_freq(struct clk_mgr_internal *clk_mgr, PPCLK_e clk);
+unsigned int dcn30_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz);
+unsigned int dcn30_smu_set_hard_max_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz);
+unsigned int dcn30_smu_get_dpm_freq_by_index(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint8_t dpm_level);
+unsigned int dcn30_smu_get_dc_mode_max_dpm_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk);
 void         dcn30_smu_set_min_deep_sleep_dcef_clk(struct clk_mgr_internal *clk_mgr, uint32_t freq_mhz);
 void         dcn30_smu_set_num_of_displays(struct clk_mgr_internal *clk_mgr, uint32_t num_displays);
 void         dcn30_smu_set_display_refresh_from_mall(struct clk_mgr_internal *clk_mgr, bool enable, uint8_t cache_timer_delay, uint8_t cache_timer_scale);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
new file mode 100644
index 000000000000..8ea8ee57b39f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
@@ -0,0 +1,74 @@
+// This is a stripped-down version of the smu11_driver_if.h file for the relevant DAL interfaces.
+
+#define SMU11_DRIVER_IF_VERSION 0x40
+
+//Only Clks that have DPM descriptors are listed here
+typedef enum {
+	PPCLK_GFXCLK = 0,
+	PPCLK_SOCCLK,
+	PPCLK_UCLK,
+	PPCLK_FCLK,
+	PPCLK_DCLK_0,
+	PPCLK_VCLK_0,
+	PPCLK_DCLK_1,
+	PPCLK_VCLK_1,
+	PPCLK_DCEFCLK,
+	PPCLK_DISPCLK,
+	PPCLK_PIXCLK,
+	PPCLK_PHYCLK,
+	PPCLK_DTBCLK,
+	PPCLK_COUNT,
+} PPCLK_e;
+
+typedef struct {
+	uint16_t MinClock; // This is either DCEFCLK or SOCCLK (in MHz)
+	uint16_t MaxClock; // This is either DCEFCLK or SOCCLK (in MHz)
+	uint16_t MinUclk;
+	uint16_t MaxUclk;
+
+	uint8_t  WmSetting;
+	uint8_t  Flags;
+	uint8_t  Padding[2];
+
+} WatermarkRowGeneric_t;
+
+#define NUM_WM_RANGES 4
+
+typedef enum {
+	WM_SOCCLK = 0,
+	WM_DCEFCLK,
+	WM_COUNT,
+} WM_CLOCK_e;
+
+typedef enum {
+	WATERMARKS_CLOCK_RANGE = 0,
+	WATERMARKS_DUMMY_PSTATE,
+	WATERMARKS_MALL,
+	WATERMARKS_COUNT,
+} WATERMARKS_FLAGS_e;
+
+typedef struct {
+	// Watermarks
+	WatermarkRowGeneric_t WatermarkRow[WM_COUNT][NUM_WM_RANGES];
+} Watermarks_t;
+
+typedef struct {
+	Watermarks_t Watermarks;
+
+	uint32_t     MmHubPadding[8]; // SMU internal use
+} WatermarksExternal_t;
+
+// Table types
+#define TABLE_PPTABLE                 0
+#define TABLE_WATERMARKS              1
+#define TABLE_AVFS_PSM_DEBUG          2
+#define TABLE_AVFS_FUSE_OVERRIDE      3
+#define TABLE_PMSTATUSLOG             4
+#define TABLE_SMU_METRICS             5
+#define TABLE_DRIVER_SMU_CONFIG       6
+#define TABLE_ACTIVITY_MONITOR_COEFF  7
+#define TABLE_OVERDRIVE               8
+#define TABLE_I2C_COMMANDS            9
+#define TABLE_PACE                   10
+#define TABLE_ECCINFO                11
+#define TABLE_COUNT                  12
diff --git a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
index dd974c428d23..bc96d0211360 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
@@ -419,28 +419,6 @@ struct integrated_info {
 	struct edp_info edp2_info;
 };
 
-/**
-* Power source ids.
-*/
-enum power_source {
-	POWER_SOURCE_AC = 0,
-	POWER_SOURCE_DC,
-	POWER_SOURCE_LIMITED_POWER,
-	POWER_SOURCE_LIMITED_POWER_2,
-	POWER_SOURCE_MAX
-};
-
-struct bios_event_info {
-	uint32_t thermal_state;
-	uint32_t backlight_level;
-	enum power_source powerSource;
-	bool has_thermal_state_changed;
-	bool has_power_source_changed;
-	bool has_forced_mode_changed;
-	bool forced_mode;
-	bool backlight_changed;
-};
-
 /*
  * DFS-bypass flag
  */
-- 
2.25.1

