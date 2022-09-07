Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D5AC54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 17:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C1A310E7FF;
	Wed,  7 Sep 2022 17:33:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E178410E7FE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 17:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkyK8GWSAmTsatfFII+600nREX9371/T1FNS4Fmu6jFxuJlmMvlePSypequhbK49GPrZyKRsOa1MDqwmDKgL0/9wFJ+QZ+rjuicT8QmdDqxYUE/czdZs78nhEMmon+lTvOIL1SVNAoNfcAa/3wV29O+kMoiE59MPQP3ufaadiAO5xfdxc2vILfEMR1hcdsO+PSFFGyuJWilV24IIgC0Wn74nKxUn2S4pWnOPIs9iCRLgLqcGzLcNHCaEhw2unJIlwtq0cLgL69rgN44kzx5NwClgv7WXSQHQb6abbIS/sVr/Q0Pzh/FFwg0Gd16rzV/9rNPrczjGbGL84Lu/DGLPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoYwEupn7mcUSnAu8TtynKfjOZHBgn9r/E63dKmcHNA=;
 b=HmxTlwz+xezocyKyQW5dnHoQpHK5k8uE0Ldac3s9wDikYo51X42d89F/zCKzBKGUuNBirFHgoehzkGc0pcjc6UKAvVH41124kdWXpRVBr3rxU6RISygKMfPW2ldUVFXtXawNrvgd1Ds+JdJbNRTUfSn5Ilk01Dfxx/85OGefEJI+UX4Epe2xfPFgrTholMbA4Td3reWJbZh+REQ7vNuTJMezXX70YV3wOVa+84bXYVTfs3NiPuvarcjjbEaWGT1r/vm1MVo5sP3yJ0yNJfjslX0rqvXpfLQ5hsTmie4MppQxG58FPFkVFqvtMvftunDhK+8QOtYzL0gGr9gEOGWkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoYwEupn7mcUSnAu8TtynKfjOZHBgn9r/E63dKmcHNA=;
 b=ufB5S/syeQmom4xw8+CgG0dN89Nm3khp0Un2yTnBbm+uWfbTRIFCH1Ynvzb0s5mUCL6tmFB7VxXZZ5O0OoB5Kq++q+J9NmEC6udYE6AEAcXk0JyEBwGTjA9VFQCOP5ACnWxFFXf0lT2x+DqRGT2T0965Xn0XFK1gtkDYiQ0MpBg=
Received: from BN0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:408:ee::24)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 17:33:21 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::84) by BN0PR04CA0019.outlook.office365.com
 (2603:10b6:408:ee::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 17:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 17:33:20 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 12:33:19 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/27] drm/amd/display: Correct I2C register offset
Date: Wed, 7 Sep 2022 13:32:08 -0400
Message-ID: <20220907173232.11755-4-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907173232.11755-1-pavle.kotarac@amd.com>
References: <20220907173232.11755-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee7cd3c-0554-44c2-b7fd-08da90f70efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mf4RM7jNYyJ85A0C0YQNE/FG2pplkj0sRQuyYAJjqCztXqmQxMoToWPS7pTtuEI7chbi22hx6jDFa0aXvvicWln57dAJzwb2W05oQX4Nx70CuXspA7RZuzfBa6mZRC2gtn3sbGTbu/DnxhoSgyg0fM34ZfS/bJv3nbo60lo+YW8DVXkjboPaiyohXooet4kFL2WaJaQaowL3+vgPqDNgDYnlq7jmUQItGBwQIJzOX29HYQ+fA/b62VHJVyF++XIXKvAXy7AewvhltDyvXdyXmw1y0F3j/u+nMG7jG+nwdOdGYs2OcFtxSkemloE2ZRyLRXyR0Kx16OEzd3lqOsU1enkvDbj5zqfR00ZZNcqosGAS4etqWnSUY20XlxvV9/u+RG05wz59uUDJxr4nmNoA8EpnyOLu4Ctugujjq9Ci5az9XOzIToPkXqx0Q/bOqd6lDN6czkgRsA1hVNbKTa2NDAD5o8cCVzMEX/veiIKACzBXZRJqCfC1p85ijp66VNeYAbbC5cWWLCUDWJlOQ0MZyGgK0B0TweUI9Q7QGzNK75d0u5FUjL7/gU6yz2RzTqCZ1vK/HGquvk8bxb+X/jYAJ7WQWlGWK6KUTSsHz5cM0FOXB01DAim42eoZ1kEITwACtjQCACX+NS/XtR08AVH7qYUdj9jGapGaJDvnpkJOYh80AEwVtstsMx+UyYB89dADPMXOc6gB7yoSpvadGK0k+3M8Qjz+lGqOZ4k0wWeKLvRbT6A+fevvTs20Nvgfhf2BsvEJMO+sxaIxlq6q7Z1FkbSay0A9r126E0fMoEBkFE71V4N7TFMrXAfD4SXYSAvg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(46966006)(40470700004)(2906002)(356005)(47076005)(81166007)(1076003)(2616005)(36756003)(83380400001)(336012)(16526019)(186003)(70206006)(70586007)(8676002)(40480700001)(426003)(8936002)(5660300002)(44832011)(4326008)(316002)(54906003)(478600001)(82310400005)(26005)(6666004)(41300700001)(6916009)(7696005)(40460700003)(36860700001)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 17:33:20.8552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee7cd3c-0554-44c2-b7fd-08da90f70efd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Chris Park <chris.park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <chris.park@amd.com>

[Why]
I2C register name starts with 1, unlike other
registers that start with 0.  This creates
a problem with the new register macro
refactoring when I2C HW objects are created
in an array.

[How]
Correct I2C register offset by making a new
macro to account for array offset.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c   |  9 ++++++++-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h   | 17 +++++++++--------
 .../drm/amd/display/dc/dcn321/dcn321_resource.c |  9 ++++++++-
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index ef0a6d468a10..5a21cf041732 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -152,6 +152,13 @@ enum dcn32_clk_src_array_id {
 	REG_STRUCT[id].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
 
+#define SR_ARR_I2C(reg_name, id) \
+	REG_STRUCT[id-1].reg_name = BASE(reg##reg_name##_BASE_IDX) + reg##reg_name
+
+#define SRI_ARR_I2C(reg_name, block, id)\
+	REG_STRUCT[id-1].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
+
 #define SRI_ARR_ALPHABET(reg_name, block, index, id)\
 	REG_STRUCT[index].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
@@ -792,7 +799,7 @@ static struct dce_aux *dcn32_aux_engine_create(
 #define i2c_inst_regs_init(id)\
 	I2C_HW_ENGINE_COMMON_REG_LIST_DCN30_RI(id)
 
-static struct dce_i2c_registers i2c_hw_regs[6];
+static struct dce_i2c_registers i2c_hw_regs[5];
 
 static const struct dce_i2c_shift i2c_shifts = {
 		I2C_COMMON_MASK_SH_LIST_DCN30(__SHIFT)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 60d8fad16eee..dbcdf8607ee9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -1175,18 +1175,19 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
 
 #define I2C_HW_ENGINE_COMMON_REG_LIST_RI(id)                                   \
   ( \
-  SRI_ARR(SETUP, DC_I2C_DDC, id), SRI_ARR(SPEED, DC_I2C_DDC, id),              \
-      SRI_ARR(HW_STATUS, DC_I2C_DDC, id), SR_ARR(DC_I2C_ARBITRATION, id),      \
-      SR_ARR(DC_I2C_CONTROL, id), SR_ARR(DC_I2C_SW_STATUS, id),                \
-      SR_ARR(DC_I2C_TRANSACTION0, id), SR_ARR(DC_I2C_TRANSACTION1, id),        \
-      SR_ARR(DC_I2C_TRANSACTION2, id), SR_ARR(DC_I2C_TRANSACTION3, id),        \
-      SR_ARR(DC_I2C_DATA, id), SR_ARR(MICROSECOND_TIME_BASE_DIV, id)           \
+      SRI_ARR_I2C(SETUP, DC_I2C_DDC, id), SRI_ARR_I2C(SPEED, DC_I2C_DDC, id),  \
+      SRI_ARR_I2C(HW_STATUS, DC_I2C_DDC, id),                                  \
+      SR_ARR_I2C(DC_I2C_ARBITRATION, id),                                      \
+      SR_ARR_I2C(DC_I2C_CONTROL, id), SR_ARR_I2C(DC_I2C_SW_STATUS, id),        \
+      SR_ARR_I2C(DC_I2C_TRANSACTION0, id), SR_ARR_I2C(DC_I2C_TRANSACTION1, id),\
+      SR_ARR_I2C(DC_I2C_TRANSACTION2, id), SR_ARR_I2C(DC_I2C_TRANSACTION3, id),\
+      SR_ARR_I2C(DC_I2C_DATA, id), SR_ARR_I2C(MICROSECOND_TIME_BASE_DIV, id)          \
   )
 
 #define I2C_HW_ENGINE_COMMON_REG_LIST_DCN30_RI(id)                             \
   ( \
-  I2C_HW_ENGINE_COMMON_REG_LIST_RI(id), SR_ARR(DIO_MEM_PWR_CTRL, id),          \
-      SR_ARR(DIO_MEM_PWR_STATUS, id)                                           \
+      I2C_HW_ENGINE_COMMON_REG_LIST_RI(id), SR_ARR_I2C(DIO_MEM_PWR_CTRL, id),  \
+      SR_ARR_I2C(DIO_MEM_PWR_STATUS, id)                                           \
   )
 
 #endif /* _DCN32_RESOURCE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index a93dc00ebfb5..8a89c28add0d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -159,6 +159,13 @@ enum dcn321_clk_src_array_id {
 	REG_STRUCT[id].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
 
+#define SR_ARR_I2C(reg_name, id) \
+	REG_STRUCT[id-1].reg_name = BASE(reg##reg_name##_BASE_IDX) + reg##reg_name
+
+#define SRI_ARR_I2C(reg_name, block, id)\
+	REG_STRUCT[id-1].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+		reg ## block ## id ## _ ## reg_name
+
 #define SRI_ARR_ALPHABET(reg_name, block, index, id)\
 	REG_STRUCT[index].reg_name = BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		reg ## block ## id ## _ ## reg_name
@@ -796,7 +803,7 @@ static struct dce_aux *dcn321_aux_engine_create(
 #define i2c_inst_regs_init(id)\
 	I2C_HW_ENGINE_COMMON_REG_LIST_DCN30_RI(id)
 
-static struct dce_i2c_registers i2c_hw_regs[6];
+static struct dce_i2c_registers i2c_hw_regs[5];
 
 static const struct dce_i2c_shift i2c_shifts = {
 		I2C_COMMON_MASK_SH_LIST_DCN30(__SHIFT)
-- 
2.34.1

