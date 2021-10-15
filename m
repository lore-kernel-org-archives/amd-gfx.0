Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33D8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D6D60C4A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76D6D60C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0296EDE7;
	Fri, 15 Oct 2021 18:44:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D956EDE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axo5PZd+cHWrgS1tSIhGZLCKZNzt2oXSI5rQPHnCuDFB5POR1OPxyOe3JhTeWWs5G62ZLYNEwRY1YHfa4StRQ+UcAsvyi2okA1PDVPNJ5+zGxGJfR9QrUrtUt8AjjQ9YnaSoVqTlzS8570Incc8qWUhf0rl37kGMjca+5NYO6Hkq0Fu99v4Wxy7oT/idNZgMgdeZIuLxS+HQLV+rL7n1EKs3ZRGqOYOPifkHQUcrw2atQPC75Y+zbSpbv+JjyG2A3mgKNO0Vp/A+EhaMJ8G5cw5DZYzg/B7FlA5kkkERmfnSmF6xVUBRe0LCAOMEST/79VwJsJOrSMpvaXqAwx2xAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHATS7Y/epsO7N9BnNa6A2K8mo1nr4hBUaWfSJ/EeR0=;
 b=YjeGfDU8zWpFB264pPnLOkHXu1J9HVreEcheyCZzovI5qyx9V1CcUIQLdA8t6Ni5oFbdTR3LJ35SItOkHX4CPBO6Er/A1HtbuZ5E9XiAxUDbUUPZScP+X6A0uBDcxHHcrHFwz7Goet81nzP4yKCrdIhaFRrrK3y4iqwuYpkrvMVF42FP00WskIz4H+Gvsj1Mc32kB5Ls9Vhvvzda3esSUzqzWaSwjQitsPGDEg7mbEoz+FAxXa/UK5kIC8PmcFxiriLPtB5SGiRdF4d490+FYytafiTzE37R8NCfbjon+FwowRNf+j9hL+D6iwFHPKoXshFLSswzq4wjNyU8JnO8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHATS7Y/epsO7N9BnNa6A2K8mo1nr4hBUaWfSJ/EeR0=;
 b=I1P1OOoDa/WRrlpBffWlbfjBGzlqJRfGEz/Lxy8CdSp/JHHVk8UffIUrL1mIC9psXqp9QsUv7Wrtt+8lHbbao912OnyWoA6BvEMI9dNczXV9Im+UpmOMg8DZFNGQVYATw5aDk3Nu6kIMPrWstunv4dK1AT3GIEMI0UkaK3Geqhg=
Received: from DM6PR02CA0107.namprd02.prod.outlook.com (2603:10b6:5:1f4::48)
 by CH2PR12MB4954.namprd12.prod.outlook.com (2603:10b6:610:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 18:44:12 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::8f) by DM6PR02CA0107.outlook.office365.com
 (2603:10b6:5:1f4::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:12 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:08 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jake Wang <haonan.wang2@amd.com>, Aric Cyr
 <Aric.Cyr@amd.com>
Subject: [PATCH 21/27] drm/amd/display: Disable hdmistream and hdmichar clocks
Date: Fri, 15 Oct 2021 14:43:26 -0400
Message-ID: <20211015184332.221091-22-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5c1cf08-5631-4322-d4c5-08d9900bc7d9
X-MS-TrafficTypeDiagnostic: CH2PR12MB4954:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4954E44DD61944F706D2126CF5B99@CH2PR12MB4954.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZHV0bAWpWvlsWJj9ItGUCoZJ4207S2TcZqWzdP2Eo2xWrErapSCLXgOKsdZHvuBl9QRAdozM8GUqUEzrJrZTNOeXBjnG21VOnDhbkeq1KMltluKiV3YSaftp+pDTEIkUVYSFxe6DVzYLKDxMUBAa83Pem+vxQZPRJ24PpczFPFsepeR2KK9PuZrX5fc3GBth+9oyEVyOavJF71P5JK6hf3kHM1ItVJ90fBHVNB8SHbL/Bdoti/qnOi4CCcW3BUfXPulqWNYfhhwdkKiRcXXEcC3EuTaZ2/7dSHoos6XGz9y7jnn8oaQTwQErfqY8VzjFHMXD+U+n5yyiWmGPfYBvX+89cQcAc7DrNrWi1wYAj1JODIy++TMmpEZxQPd/rGAnJ2swqRfsK0iwrXdYMXe599K6WFNrcuM09p2jyQPbcibYYM+oFpcl4Kn/pqFX4E5OtlzahBJpI5oYP2mRxFR21+Ab2OB6Elu1ohgJ24FlCLkadd+gCqqdY4h6NqOXZnO7L2cpNtMFqER8ea7RypoZo+sXF0vPJR9TTw+m7tT1GBJxlzQUWzmXsfrqR2i8b4/IvxZqmarwVI+c8txIB4ENUoEVrRuTUBp5mcKEmNA/7Y8aB0ZsJBtKv5aGlFBXy/j2IoxPVw7uqJ5EOU2/Gd3mOCLYv/sq7x9HnFdJh67+diJdG8CJ1ndvxWwdlcZ1rbqRXTUavyHs725k5pOWEXlqfAFOfffS43JtOXcURvZTdc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(2906002)(81166007)(8936002)(426003)(1076003)(5660300002)(8676002)(36756003)(36860700001)(26005)(336012)(186003)(16526019)(47076005)(70206006)(508600001)(70586007)(4326008)(44832011)(54906003)(6666004)(356005)(2616005)(316002)(6916009)(83380400001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:12.0799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c1cf08-5631-4322-d4c5-08d9900bc7d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4954
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

From: Jake Wang <haonan.wang2@amd.com>

[Why & How]
Disable hdmistream and hdmichar root clocks when not being used.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Jake Wang <haonan.wang2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h        | 9 +++++++--
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h        | 9 +++++----
 .../gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_offset.h  | 2 ++
 .../gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h | 8 ++++++++
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index 4098669a0c1f..f98aba308028 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -186,8 +186,11 @@
 	type SYMCLK32_ROOT_LE0_GATE_DISABLE;\
 	type SYMCLK32_ROOT_LE1_GATE_DISABLE;\
 	type DPSTREAMCLK_ROOT_GATE_DISABLE;\
-	type DPSTREAMCLK_GATE_DISABLE;
-
+	type DPSTREAMCLK_GATE_DISABLE;\
+	type HDMISTREAMCLK0_DTO_PHASE;\
+	type HDMISTREAMCLK0_DTO_MODULO;\
+	type HDMICHARCLK0_GATE_DISABLE;\
+	type HDMICHARCLK0_ROOT_GATE_DISABLE;
 
 
 struct dccg_shift {
@@ -231,6 +234,8 @@ struct dccg_registers {
 	uint32_t DPSTREAMCLK_ROOT_GATE_DISABLE;
 	uint32_t DPSTREAMCLK_GATE_DISABLE;
 	uint32_t DCCG_GATE_DISABLE_CNTL3;
+	uint32_t HDMISTREAMCLK0_DTO_PARAM;
+	uint32_t DCCG_GATE_DISABLE_CNTL4;
 
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
index 602bf461298b..a013a32bbaf7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -66,7 +66,8 @@
 	SR(DSCCLK1_DTO_PARAM),\
 	SR(DSCCLK2_DTO_PARAM),\
 	SR(DSCCLK_DTO_CTRL),\
-	SR(DCCG_GATE_DISABLE_CNTL3)
+	SR(DCCG_GATE_DISABLE_CNTL3),\
+	SR(HDMISTREAMCLK0_DTO_PARAM)
 
 
 #define DCCG_MASK_SH_LIST_DCN31(mask_sh) \
@@ -141,9 +142,9 @@
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE2_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE3_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE0_GATE_DISABLE, mask_sh),\
-	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE1_GATE_DISABLE, mask_sh)
-
-
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE1_GATE_DISABLE, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK0_DTO_PARAM, HDMISTREAMCLK0_DTO_PHASE, mask_sh),\
+	DCCG_SF(HDMISTREAMCLK0_DTO_PARAM, HDMISTREAMCLK0_DTO_MODULO, mask_sh)
 
 
 struct dccg *dccg31_create(
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_offset.h
index 312c50ea30f3..f268d33c4744 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_offset.h
@@ -436,6 +436,8 @@
 #define regPHYESYMCLK_CLOCK_CNTL_BASE_IDX                                                               2
 #define regDCCG_GATE_DISABLE_CNTL3                                                                      0x005a
 #define regDCCG_GATE_DISABLE_CNTL3_BASE_IDX                                                             2
+#define regHDMISTREAMCLK0_DTO_PARAM                                                                     0x005b
+#define regHDMISTREAMCLK0_DTO_PARAM_BASE_IDX                                                            2
 #define regDCCG_AUDIO_DTBCLK_DTO_PHASE                                                                  0x0061
 #define regDCCG_AUDIO_DTBCLK_DTO_PHASE_BASE_IDX                                                         2
 #define regDCCG_AUDIO_DTBCLK_DTO_MODULO                                                                 0x0062
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
index a9d553ef26c0..1f21f313bd1d 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
@@ -1438,6 +1438,14 @@
 #define DCCG_GATE_DISABLE_CNTL3__SYMCLK32_LE0_GATE_DISABLE_MASK                                               0x00200000L
 #define DCCG_GATE_DISABLE_CNTL3__SYMCLK32_ROOT_LE1_GATE_DISABLE_MASK                                          0x00400000L
 #define DCCG_GATE_DISABLE_CNTL3__SYMCLK32_LE1_GATE_DISABLE_MASK                                               0x00800000L
+//HDMISTREAMCLK0_DTO_PARAM
+#define HDMISTREAMCLK0_DTO_PARAM__HDMISTREAMCLK0_DTO_PHASE__SHIFT                                             0x0
+#define HDMISTREAMCLK0_DTO_PARAM__HDMISTREAMCLK0_DTO_MODULO__SHIFT                                            0x8
+#define HDMISTREAMCLK0_DTO_PARAM__HDMISTREAMCLK0_DTO_EN__SHIFT                                                0x10
+#define HDMISTREAMCLK0_DTO_PARAM__HDMISTREAMCLK0_DTO_PHASE_MASK                                               0x000000FFL
+#define HDMISTREAMCLK0_DTO_PARAM__HDMISTREAMCLK0_DTO_MODULO_MASK                                              0x0000FF00L
+#define HDMISTREAMCLK0_DTO_PARAM__HDMISTREAMCLK0_DTO_EN_MASK                                                  0x00010000L
+
 //DCCG_AUDIO_DTBCLK_DTO_PHASE
 #define DCCG_AUDIO_DTBCLK_DTO_PHASE__DCCG_AUDIO_DTBCLK_DTO_PHASE__SHIFT                                       0x0
 #define DCCG_AUDIO_DTBCLK_DTO_PHASE__DCCG_AUDIO_DTBCLK_DTO_PHASE_MASK                                         0xFFFFFFFFL
-- 
2.25.1

