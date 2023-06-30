Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A44EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 11:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2686610E45E;
	Fri, 30 Jun 2023 11:56:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 231BA10E45C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 11:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQkToudd1bG3qxrG6Oze7LmHUTmnxP/7WCqtGrC/NnZsnPbundR/dyxiVHu0Y8kn1EtX/KVaragzrnT7gqHTZQBXrb+5BXPc+zETc1Zo2rHjuaE99XFVHpu3PLHd02GfdQ33514kASgCQDHcXS5mMbn2SQV/5GeqmgXRtGEjP1wNca1dyBJZcmp3EOYeLf1sbPUmTnEB3uH2B+I5fn2J9FW3K2NOwavHmMRvivIBR5eInERqpTqpnUnSvMEpGm0XF8/ouSg6dJ5rHKSQ9/DSGIWktC/Ypb4srHdjVdIdfLZYI3HWdtza75MOax+ps2dxVvcIak/lYlTKwdXFkL0iRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzX70Wb4zFRTASS2aeR/3WSx+y5abQed8MUpaNJ2ueg=;
 b=gYWyre+heQIXNsNxbkQ8lCplzPcwNFjjWoBLG5CytrxJcxxYdt2D5wAI/uP4zdmrRfBDHat1eMzSKOL/Bg9I+ZFV6i46sKztrxgjgnujx4yQ4aoTBOrBQZHOAUv0nCQwxu445noFA2lD0zlGHZE0dhbeBl4AY4KMIc3acGDrUuTYUclvYMzm4r0N1KlkPOKlh6tKiF9Ecm+aYiYf2BGLVORjEDxA5fX9sLT4VIBWoqzoXLsuxOiQA3tmPHJ0pBVcdbzRLPktPyKlCh5GFSeh8sNKaEeujjGVlV1vA+gGWUhhhRxkdBoZwURyZCDfrajffEylrXN3NqrEr0yaAlp+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzX70Wb4zFRTASS2aeR/3WSx+y5abQed8MUpaNJ2ueg=;
 b=10P97+uafNWBUUuw7BVvWz6lCkAyHz8dktZcYnBuVrmrUmJzM690nwtlWOEZftohMODICnIGgA8Wb11LT+KTyIZQ7BgokJNN5sFbUoZD5kDsjWMHN2zCBziGTvvhdT6mskFRvxdjFXm+Z2FDGq/Fb0xD1IP6yJANGBg3L7iFYuM=
Received: from BN0PR04CA0187.namprd04.prod.outlook.com (2603:10b6:408:e9::12)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 11:56:44 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::87) by BN0PR04CA0187.outlook.office365.com
 (2603:10b6:408:e9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 11:56:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 11:56:43 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 06:56:41 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: Fix errors & warnings in gfx_v10_0.c
Date: Fri, 30 Jun 2023 17:26:17 +0530
Message-ID: <20230630115618.2855618-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
References: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f0b97c-625d-48c0-e033-08db796112ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+xmduFpwuL0XMe3uMqePtIhXC/LHLQiaeyOZpzXOcQ/4ED8U51I4IyG1W5LOrVSwP5XiSS0BTCktLdPUMJjfdxOX8xncG256KI2BayqA596dYlf6BUzeUHyZGfMmBoRMQsuVsx3zAwiP5fHJ7cG3MPR4Y+oe7MoWt6gT1FKGvb8/PmeUWmabTlcJDHE+9EtmMugi218bpU0Y/YYUi3cZ/k7UvqyDxSwAX/jWEFE4tQRyhhVgbAV3J3JHh0t9hk29s1lYYJyAEiXY7H8depYGze+C5AqSLSRecxBM2fh+/kiuvwJxN9kRZxYvSdH8J0tErk0gR8q9bys6veyVmN2sW/8+A0ac0LFESEPzftvwsQqaPN/WyGgMtNzHfAJv6bh5bRATH9M2be2k2lR+Ymyb+N+0tBHov5wiGmzYcIsLI4Hy9DDW8aV0tpe17YFFauKrGSeqAgr/flU7BOd706HqnxP5PjbNyPcJJpgbAlxeCCQzPpk3HJd9yODxdpYqo+AzRIKWJQ0r5vPN3gk9va0R7UeldyybmwGfAgME174VuD4pMwzelfFm5HLKMwpO3+0wns+UYzrb8PDzvp6YHs5px37FxxZ7G1FSTbgxsss/t/cd+FoSTSamJrtCyUmQlIjGyvbCVUCbxgvW3kjD3I2ZDRL2rQEfeKZ/rOr/CIQtpnW8N//qHPjR3HIyZUarWrqTv0Ug94rzEXLctX9nP3wkhopo0NwDnU9GrJzV9Kq6VGzKLmYl1glW/TIfrqdOsEskgvLDZOOhZgCq2L77YSvig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(8676002)(36860700001)(2906002)(356005)(16526019)(186003)(1076003)(36756003)(41300700001)(44832011)(30864003)(40460700003)(316002)(5660300002)(70206006)(86362001)(70586007)(4326008)(8936002)(82740400003)(6636002)(40480700001)(81166007)(66574015)(478600001)(7696005)(26005)(47076005)(6666004)(2616005)(54906003)(83380400001)(426003)(110136005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 11:56:43.9087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f0b97c-625d-48c0-e033-08db796112ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the below checkpatch errors & warnings:

ERROR: that open brace { should be on the previous line
ERROR: space prohibited before that ',' (ctx:WxV)
ERROR: space required after that ',' (ctx:WxV)
ERROR: code indent should use tabs where possible
ERROR: switch and case should be at the same indent

WARNING: please, no spaces at the start of a line
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: space prohibited before semicolon
WARNING: Block comments use a trailing */ on a separate line
WARNING: Block comments use * on subsequent lines
WARNING: braces {} are not necessary for any arm of this statement
WARNING: Missing a blank line after declarations

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 173 +++++++++++++------------
 1 file changed, 90 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 44af8022b89f..157dd33ec43a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -271,8 +271,8 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
 MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
 
-static const struct soc15_reg_golden golden_settings_gc_10_1[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
+
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CLK_CTRL, 0xcd000000, 0x0d000100),
@@ -315,13 +315,13 @@ static const struct soc15_reg_golden golden_settings_gc_10_1[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x00c00000, 0x00c00000)
 };
 
-static const struct soc15_reg_golden golden_settings_gc_10_0_nv10[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_10_0_nv10[] = {
+
 	/* Pending on emulation bring up */
 };
 
-static const struct soc15_reg_golden golden_settings_gc_rlc_spm_10_0_nv10[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_rlc_spm_10_0_nv10[] = {
+
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_GFX_INDEX, 0xe0000000, 0x0),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_GFX_INDEX, 0xffffff, 0x0),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRLC_SPM_GLB_SAMPLEDELAY_IND_ADDR, 0xFFFFFFFF, 0x28),
@@ -1376,8 +1376,8 @@ static const struct soc15_reg_golden golden_settings_gc_rlc_spm_10_0_nv10[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_GFX_INDEX, 0xFFFFFFFF, 0xe0000000)
 };
 
-static const struct soc15_reg_golden golden_settings_gc_10_1_1[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_10_1_1[] = {
+
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x003c0014),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_GS_NGG_CLK_CTRL, 0xffff8fff, 0xffff8100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_IA_CLK_CTRL, 0xffff0fff, 0xffff0100),
@@ -1418,8 +1418,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_1[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x00c00000, 0x00c00000),
 };
 
-static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_10_1_2[] = {
+
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0x003e001f, 0x003c0014),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_GS_NGG_CLK_CTRL, 0xffff8fff, 0xffff8100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_IA_CLK_CTRL, 0xffff0fff, 0xffff0100),
@@ -1464,13 +1464,13 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00c00000)
 };
 
-static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] = {
+
 	/* Pending on emulation bring up */
 };
 
-static const struct soc15_reg_golden golden_settings_gc_rlc_spm_10_1_nv14[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_rlc_spm_10_1_nv14[] = {
+
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_GFX_INDEX, 0xE0000000L, 0x0),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_GFX_INDEX, 0xffffff, 0x0),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRLC_SPM_GLB_SAMPLEDELAY_IND_ADDR, 0xFFFFFFFF, 0x28),
@@ -2093,13 +2093,13 @@ static const struct soc15_reg_golden golden_settings_gc_rlc_spm_10_1_nv14[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_GFX_INDEX, 0xFFFFFFFF, 0xe0000000)
 };
 
-static const struct soc15_reg_golden golden_settings_gc_10_1_2_nv12[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_10_1_2_nv12[] = {
+
 	/* Pending on emulation bring up */
 };
 
-static const struct soc15_reg_golden golden_settings_gc_rlc_spm_10_1_2_nv12[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_rlc_spm_10_1_2_nv12[] = {
+
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_GFX_INDEX, 0xe0000000L, 0x0),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_GFX_INDEX, 0xffffff, 0x0),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRLC_SPM_GLB_SAMPLEDELAY_IND_ADDR, 0xFFFFFFFF, 0x28),
@@ -3154,8 +3154,8 @@ static const struct soc15_reg_golden golden_settings_gc_rlc_spm_10_1_2_nv12[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_GFX_INDEX, 0xFFFFFFFF, 0xe0000000)
 };
 
-static const struct soc15_reg_golden golden_settings_gc_10_3[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_10_3[] = {
+
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0x78000000, 0x78000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_PS_CLK_CTRL, 0xff7f0fff, 0x78000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0xff7f0fff, 0x30000100),
@@ -3164,7 +3164,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0 ,mmGCEA_SDP_TAG_RESERVE0, 0xffffffff, 0x10100100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCEA_SDP_TAG_RESERVE0, 0xffffffff, 0x10100100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCEA_SDP_TAG_RESERVE1, 0xffffffff, 0x17000088),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCUTCL2_CGTT_CLK_CTRL_Sienna_Cichlid, 0xff000000, 0xff008080),
@@ -3201,13 +3201,13 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a00000)
 };
 
-static const struct soc15_reg_golden golden_settings_gc_10_3_sienna_cichlid[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_10_3_sienna_cichlid[] = {
+
 	/* Pending on emulation bring up */
 };
 
-static const struct soc15_reg_golden golden_settings_gc_10_3_2[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_10_3_2[] = {
+
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0xff7f0fff, 0x78000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_PS_CLK_CTRL, 0xff7f0fff, 0x78000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0xff7f0fff, 0x30000100),
@@ -3254,8 +3254,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020),
 };
 
-static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] = {
+
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0xff7f0fff, 0x30000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL, 0xff7f0fff, 0x7e000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCH_PIPE_STEER, 0x000000ff, 0x000000e4),
@@ -3285,8 +3285,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020),
 };
 
-static const struct soc15_reg_golden golden_settings_gc_10_3_3[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_10_3_3[] = {
+
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0xff7f0fff, 0x78000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCH_PIPE_STEER, 0x000000ff, 0x000000e4),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c200),
@@ -3309,8 +3309,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00100000)
 };
 
-static const struct soc15_reg_golden golden_settings_gc_10_3_4[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_10_3_4[] = {
+
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0x78000000, 0x78000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0x30000000, 0x30000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL, 0x7e000000, 0x7e000100),
@@ -3380,7 +3380,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_5[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER7_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX,0xfff7ffff, 0x01030000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a00000)
 };
 
@@ -3421,8 +3421,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_0_cyan_skillfish[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x00800000, 0x00800000)
 };
 
-static const struct soc15_reg_golden golden_settings_gc_10_3_6[] =
-{
+static const struct soc15_reg_golden golden_settings_gc_10_3_6[] = {
+
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0xff7f0fff, 0x78000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCH_PIPE_STEER, 0x000000ff, 0x00000044),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c200),
@@ -3714,8 +3714,8 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(10, 3, 4):
 		soc15_program_register_sequence(adev,
-                                                golden_settings_gc_10_3_4,
-                                                (const u32)ARRAY_SIZE(golden_settings_gc_10_3_4));
+						golden_settings_gc_10_3_4,
+						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_4));
 		break;
 	case IP_VERSION(10, 3, 5):
 		soc15_program_register_sequence(adev,
@@ -3782,7 +3782,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t scratch = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0);
 	uint32_t tmp = 0;
-	unsigned i;
+	unsigned int i;
 	int r;
 
 	WREG32(scratch, 0xCAFEDEAD);
@@ -3820,7 +3820,7 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_ib ib;
 	struct dma_fence *f = NULL;
-	unsigned index;
+	unsigned int index;
 	uint64_t gpu_addr;
 	volatile uint32_t *cpu_ptr;
 	long r;
@@ -3951,7 +3951,7 @@ static bool gfx_v10_0_navi10_gfxoff_should_enable(struct amdgpu_device *adev)
 		break;
 	}
 
-	return ret ;
+	return ret;
 }
 
 static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
@@ -4159,14 +4159,14 @@ static void gfx_v10_0_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 	reg_access_ctrl->grbm_cntl = SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL);
 	reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX);
 	switch (adev->ip_versions[GC_HWIP][0]) {
-		case IP_VERSION(10, 3, 0):
-			reg_access_ctrl->spare_int =
-				SOC15_REG_OFFSET(GC, 0, mmRLC_SPARE_INT_0_Sienna_Cichlid);
-			break;
-		default:
-			reg_access_ctrl->spare_int =
-				SOC15_REG_OFFSET(GC, 0, mmRLC_SPARE_INT);
-			break;
+	case IP_VERSION(10, 3, 0):
+		reg_access_ctrl->spare_int =
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPARE_INT_0_Sienna_Cichlid);
+		break;
+	default:
+		reg_access_ctrl->spare_int =
+			SOC15_REG_OFFSET(GC, 0, mmRLC_SPARE_INT);
+		break;
 	}
 	adev->gfx.rlc.rlcg_reg_access_supported = true;
 }
@@ -4213,7 +4213,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *adev)
 	int r;
 	u32 *hpd;
 	const __le32 *fw_data = NULL;
-	unsigned fw_size;
+	unsigned int fw_size;
 	u32 *fw = NULL;
 	size_t mec_hpd_size;
 
@@ -4295,7 +4295,8 @@ static void gfx_v10_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id
 {
 	/* in gfx10 the SIMD_ID is specified as part of the INSTANCE
 	 * field when performing a select_se_sh so it should be
-	 * zero here */
+	 * zero here
+	 */
 	WARN_ON(simd != 0);
 
 	/* type 2 wave data */
@@ -4474,7 +4475,7 @@ static int gfx_v10_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 				       int mec, int pipe, int queue)
 {
-	unsigned irq_type;
+	unsigned int irq_type;
 	struct amdgpu_ring *ring;
 	unsigned int hw_prio;
 
@@ -4795,7 +4796,8 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
 	uint32_t pa_sc_tile_steering_override;
 
 	/* for ASICs that integrates GFX v10.3
-	 * pa_sc_tile_steering_override should be set to 0 */
+	 * pa_sc_tile_steering_override should be set to 0
+	 */
 	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 0))
 		return 0;
 
@@ -4872,7 +4874,8 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	mutex_unlock(&adev->srbm_mutex);
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
-	   access. These should be enabled by FW for target VMIDs. */
+	 * access. These should be enabled by FW for target VMIDs.
+	 */
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
@@ -5109,7 +5112,8 @@ static void gfx_v10_0_rlc_smu_handshake_cntl(struct amdgpu_device *adev,
 static void gfx_v10_0_rlc_start(struct amdgpu_device *adev)
 {
 	/* TODO: enable rlc & smu handshake until smu
-	 * and gfxoff feature works as expected */
+	 * and gfxoff feature works as expected
+	 */
 	if (!(amdgpu_pp_feature_mask & PP_GFXOFF_MASK))
 		gfx_v10_0_rlc_smu_handshake_cntl(adev, false);
 
@@ -5132,7 +5136,7 @@ static int gfx_v10_0_rlc_load_microcode(struct amdgpu_device *adev)
 {
 	const struct rlc_firmware_header_v2_0 *hdr;
 	const __le32 *fw_data;
-	unsigned i, fw_size;
+	unsigned int i, fw_size;
 
 	if (!adev->gfx.rlc_fw)
 		return -EINVAL;
@@ -5674,11 +5678,10 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
 	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);
 
-	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 2)) {
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 2))
 		WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
-	} else {
+	else
 		WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
-	}
 
 	if (adev->job_hang && !enable)
 		return 0;
@@ -5700,7 +5703,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 	int r;
 	const struct gfx_firmware_header_v1_0 *pfp_hdr;
 	const __le32 *fw_data;
-	unsigned i, fw_size;
+	unsigned int i, fw_size;
 	uint32_t tmp;
 	uint32_t usec_timeout = 50000;  /* wait for 50ms */
 
@@ -5778,7 +5781,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_device *adev)
 	int r;
 	const struct gfx_firmware_header_v1_0 *ce_hdr;
 	const __le32 *fw_data;
-	unsigned i, fw_size;
+	unsigned int i, fw_size;
 	uint32_t tmp;
 	uint32_t usec_timeout = 50000;  /* wait for 50ms */
 
@@ -5855,7 +5858,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 	int r;
 	const struct gfx_firmware_header_v1_0 *me_hdr;
 	const __le32 *fw_data;
-	unsigned i, fw_size;
+	unsigned int i, fw_size;
 	uint32_t tmp;
 	uint32_t usec_timeout = 50000;  /* wait for 50ms */
 
@@ -6243,7 +6246,7 @@ static int gfx_v10_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 {
 	const struct gfx_firmware_header_v1_0 *mec_hdr;
 	const __le32 *fw_data;
-	unsigned i;
+	unsigned int i;
 	u32 tmp;
 	u32 usec_timeout = 50000; /* Wait for 50 ms */
 
@@ -6923,7 +6926,8 @@ static bool gfx_v10_0_check_grbm_cam_remapping(struct amdgpu_device *adev)
 	uint32_t data, pattern = 0xDEADBEEF;
 
 	/* check if mmVGT_ESGS_RING_SIZE_UMD
-	 * has been remapped to mmVGT_ESGS_RING_SIZE */
+	 * has been remapped to mmVGT_ESGS_RING_SIZE
+	 */
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(10, 3, 0):
 	case IP_VERSION(10, 3, 2):
@@ -6934,7 +6938,7 @@ static bool gfx_v10_0_check_grbm_cam_remapping(struct amdgpu_device *adev)
 		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, pattern);
 
 		if (RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid) == pattern) {
-			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD , data);
+			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, data);
 			return true;
 		} else {
 			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid, data);
@@ -6970,7 +6974,8 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 		return;
 
 	/* initialize cam_index to 0
-	 * index will auto-inc after each data writting */
+	 * index will auto-inc after each data writting
+	 */
 	WREG32_SOC15(GC, 0, mmGRBM_CAM_INDEX, 0);
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
@@ -7100,6 +7105,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 static void gfx_v10_0_disable_gpa_mode(struct amdgpu_device *adev)
 {
 	uint32_t data;
+
 	data = RREG32_SOC15(GC, 0, mmCPC_PSP_DEBUG);
 	data |= CPC_PSP_DEBUG__GPA_OVERRIDE_MASK;
 	WREG32_SOC15(GC, 0, mmCPC_PSP_DEBUG, data);
@@ -7216,7 +7222,7 @@ static bool gfx_v10_0_is_idle(void *handle)
 
 static int gfx_v10_0_wait_for_idle(void *handle)
 {
-	unsigned i;
+	unsigned int i;
 	u32 tmp;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -7471,7 +7477,7 @@ static bool gfx_v10_0_is_rlc_enabled(struct amdgpu_device *adev)
 static void gfx_v10_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t data;
-	unsigned i;
+	unsigned int i;
 
 	data = RLC_SAFE_MODE__CMD_MASK;
 	data |= (1 << RLC_SAFE_MODE__MESSAGE__SHIFT);
@@ -7900,7 +7906,7 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned int vmid)
 {
 	u32 reg, data;
 
@@ -8297,7 +8303,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 				       struct amdgpu_ib *ib,
 				       uint32_t flags)
 {
-	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
+	unsigned int vmid = AMDGPU_JOB_GET_VMID(job);
 	u32 header, control = 0;
 
 	if (ib->flags & AMDGPU_IB_FLAG_CE)
@@ -8338,7 +8344,7 @@ static void gfx_v10_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 					   struct amdgpu_ib *ib,
 					   uint32_t flags)
 {
-	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
+	unsigned int vmid = AMDGPU_JOB_GET_VMID(job);
 	u32 control = INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 24);
 
 	if (ring->is_mes_queue)
@@ -8373,7 +8379,7 @@ static void gfx_v10_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 }
 
 static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
-				     u64 seq, unsigned flags)
+				     u64 seq, unsigned int flags)
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
@@ -8429,7 +8435,7 @@ static void gfx_v10_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 }
 
 static void gfx_v10_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
-					 unsigned vmid, uint64_t pd_addr)
+					 unsigned int vmid, uint64_t pd_addr)
 {
 	if (ring->is_mes_queue)
 		gfx_v10_0_ring_invalidate_tlbs(ring, 0, 0, false, 0);
@@ -8511,9 +8517,9 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, 0);
 }
 
-static unsigned gfx_v10_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring)
+static unsigned int gfx_v10_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring)
 {
-	unsigned ret;
+	unsigned int ret;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
 	amdgpu_ring_write(ring, lower_32_bits(ring->cond_exe_gpu_addr));
@@ -8525,9 +8531,10 @@ static unsigned gfx_v10_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring)
 	return ret;
 }
 
-static void gfx_v10_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigned offset)
+static void gfx_v10_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigned int offset)
 {
-	unsigned cur;
+	unsigned int cur;
+
 	BUG_ON(offset > ring->buf_mask);
 	BUG_ON(ring->ring[offset] != 0x55aa55aa);
 
@@ -8750,7 +8757,7 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 }
 
 static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned vmid)
+					 unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t value = 0;
@@ -8859,7 +8866,7 @@ static void gfx_v10_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev
 
 static int gfx_v10_0_set_eop_interrupt_state(struct amdgpu_device *adev,
 					    struct amdgpu_irq_src *src,
-					    unsigned type,
+					    unsigned int type,
 					    enum amdgpu_interrupt_state state)
 {
 	switch (type) {
@@ -8956,7 +8963,7 @@ static int gfx_v10_0_eop_irq(struct amdgpu_device *adev,
 
 static int gfx_v10_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
-					      unsigned type,
+					      unsigned int type,
 					      enum amdgpu_interrupt_state state)
 {
 	switch (state) {
@@ -8975,7 +8982,7 @@ static int gfx_v10_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 
 static int gfx_v10_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 					       struct amdgpu_irq_src *source,
-					       unsigned type,
+					       unsigned int type,
 					       enum amdgpu_interrupt_state state)
 {
 	switch (state) {
@@ -9342,7 +9349,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 
 static void gfx_v10_0_set_gds_init(struct amdgpu_device *adev)
 {
-	unsigned total_cu = adev->gfx.config.max_cu_per_sh *
+	unsigned int total_cu = adev->gfx.config.max_cu_per_sh *
 			    adev->gfx.config.max_sh_per_se *
 			    adev->gfx.config.max_shader_engines;
 
@@ -9423,7 +9430,7 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 {
 	int i, j, k, counter, active_cu_number = 0;
 	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0;
-	unsigned disable_masks[4 * 2];
+	unsigned int disable_masks[4 * 2];
 
 	if (!adev || !cu_info)
 		return -EINVAL;
@@ -9540,8 +9547,8 @@ static void gfx_v10_3_set_power_brake_sequence(struct amdgpu_device *adev)
 		     (0x1 << DIDT_SQ_THROTTLE_CTRL__PWRBRK_STALL_EN__SHIFT));
 }
 
-const struct amdgpu_ip_block_version gfx_v10_0_ip_block =
-{
+const struct amdgpu_ip_block_version gfx_v10_0_ip_block = {
+
 	.type = AMD_IP_BLOCK_TYPE_GFX,
 	.major = 10,
 	.minor = 0,
-- 
2.25.1

