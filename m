Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C5EECAAA3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6DD10E032;
	Fri, 26 Aug 2022 18:42:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159DE10E0CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVGNRVj5Y7cQPsPlAn6qJh0os4iC6BLnrSSuD5SGpY8SlswqYhkk+RZe9+rKR8WdF5ygj9C+m99YLQXek0LZaqKwFj/sTcT8PIdmXto6BfReMNtGm0p57u/nWF1pdmiGhbj8QH9g/7QiqitQEdVpudCGaA+m6NHIbJ9yDGbZqJrQEzQn06KWGutOA3fvan3zH2OKhEYCkdt6uJUueqnsYCb+0E9UEy+hivGviKraA3dnonR402zOP4EUy6UkSgoia3I4SqgT1ha22oVb0Huv5Jzp26311GVmoNIHlDQ2N0bQ3ZWhJsczBPdMT4QyLfxFeoGt19KB4JAMv9xJCv0k1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wetRXyJle1Aob/2PJFpc/xklh8syO1qr3QyHmh+q6Hs=;
 b=bJy2frew8gZtfUyQnkN5JylN192oRAufcEEm/yFKj/0wRanKp+lDpzXhb4r0Nn9GEMViD5pVOR/1g+IBxPfidezttFxJ5h9Wr7Kd9LF0Qj8CPH1LKkDE++vxj/+yxXH01B7bzJx+fm8JDEozHPv+2W4L4YTI/00r7znVr7gl42/3bXKG3FW5FxMgMIIB1MHHvClxpg7WJ3KYmTXr7LEF2Vq+sF3Z/qQSbhm+PiwAvA4Tot2ZzczxEzCrNvlM8EyEfPBDnc37hQYSuDg9I+S8pMcoF83rjSGFVLjSS0KII4mdFgounv4dbZm2R1INrpOicPwEHxKpQjFwF3TRSeVPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wetRXyJle1Aob/2PJFpc/xklh8syO1qr3QyHmh+q6Hs=;
 b=GmW3PKNI/lz7kiDtjcrqV9iE9oiM0LK1QAjRT70G7fbJ1rNAef5ZPE1slx+DieRk53G0nK+wKgiejKNdyT6RPzh0h6L6B8T/7hmHwA1uktaB6Y54PralaE+HdHli4ADHlYBiiopvwKgugXA9/NXuuc6aFu2WoToxwLwMp2PTLXM=
Received: from BN0PR08CA0020.namprd08.prod.outlook.com (2603:10b6:408:142::8)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:42:14 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::6) by BN0PR08CA0020.outlook.office365.com
 (2603:10b6:408:142::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 18:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:42:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:42:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: drop gc 11_0_0 golden settings
Date: Fri, 26 Aug 2022 14:41:56 -0400
Message-ID: <20220826184156.855072-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71feaf87-3bb3-4a2f-1219-08da8792b1d2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4462:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sQluVeC04Z+sleSMtlLRdz/vUInQnRf0OTVtPyDHifQ47aPTBUu4PMXq544/ReasMF8klf3L7DG29QE1gvmOqjcHUenOAu0df4PiVSPTSV/mTOFk7HPhEJcWxeFnZHJ9fNkc+n63wZ+wJo2yRhJ8ZLT2ug1jRlAUD1nXpoz6xXPPkF8yCnMjKnavA+WUfvX2TX2MTf7GcXowrDVTWrAXLV9qrVKO2jQEeJxG4INFHm5EQIU/gjfjQo40oCuhWpzH9SnU5/VdX/EqjwysFO5qzAa7g1D99/PTv2VYx+DYgCERa0P3cXRwt9v7Tc/2TJ1U1pWFmBMBPWBUwj++15vCqS6taXfSxUX9OsXgMF31ZCjvltVPrC0pK4HC+qSbv9LiF17nCCQB/cGejin0BWBE6V4Ffvt2epLW5Q2n4E9Z44BgQcdPFk+BrtA3DQBLdFswtLwj15UslPLrESNybEgSuYBcj9t7/4X/eAsLN7WDHT1qcLrQA5sNPPYVQ1JKbTpUZWOAUcd07U6tWQ46YPz7XsovPzBIjgRkzPHtfuF8ayGraMfC9IkI6wwMOQu0saYFNDMxoUr6A8sauqXqGgVrvmfowrxEXHKjPduwLOEcgugjBmNIj479jjisnxT1fXruuL487yymhBCj8xi2zYBbYN6KAg71oeOazBIjR3NRHsQZdKggmhXtMduhlv3ipAnLXFjJoKnqiWr66sdAmIqZnk3yfO1Cy3duLgOl4jHSxKOHpX/QfsNwW1g08ElcPtD5PzRqYgyPV/GV9lQojOuiowH0WjoVI5Qk7nvCQsP6CELMeVCa+4wos1bfGkCo4J4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(40470700004)(46966006)(36840700001)(47076005)(426003)(336012)(16526019)(7696005)(26005)(186003)(1076003)(2616005)(40480700001)(5660300002)(8936002)(86362001)(36756003)(478600001)(41300700001)(6666004)(36860700001)(83380400001)(356005)(81166007)(4326008)(8676002)(6916009)(54906003)(2906002)(82310400005)(316002)(40460700003)(82740400003)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:42:14.4030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71feaf87-3bb3-4a2f-1219-08da8792b1d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

driver doesn't need to program any gc 11_0_0 golden

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 41 --------------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f6b1bb40e503..8d985004927b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -74,21 +74,6 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_2_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_rlc.bin");
 
-static const struct soc15_reg_golden golden_settings_gc_11_0[] =
-{
-	/* Pending on emulation bring up */
-};
-
-static const struct soc15_reg_golden golden_settings_gc_11_0_0[] =
-{
-	/* Pending on emulation bring up */
-};
-
-static const struct soc15_reg_golden golden_settings_gc_rlc_spm_11_0[] =
-{
-	/* Pending on emulation bring up */
-};
-
 static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regCGTT_GS_NGG_CLK_CTRL, 0x9fff8fff, 0x00000010),
@@ -269,34 +254,10 @@ static void gfx_v11_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
 	adev->gfx.kiq.pmf = &gfx_v11_0_kiq_pm4_funcs;
 }
 
-static void gfx_v11_0_init_spm_golden_registers(struct amdgpu_device *adev)
-{
-	switch (adev->ip_versions[GC_HWIP][0]) {
-	case IP_VERSION(11, 0, 0):
-		soc15_program_register_sequence(adev,
-						golden_settings_gc_rlc_spm_11_0,
-						(const u32)ARRAY_SIZE(golden_settings_gc_rlc_spm_11_0));
-		break;
-	default:
-		break;
-	}
-}
-
 static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[GC_HWIP][0]) {
-	case IP_VERSION(11, 0, 0):
-		soc15_program_register_sequence(adev,
-						golden_settings_gc_11_0,
-						(const u32)ARRAY_SIZE(golden_settings_gc_11_0));
-		soc15_program_register_sequence(adev,
-						golden_settings_gc_11_0_0,
-						(const u32)ARRAY_SIZE(golden_settings_gc_11_0_0));
-		break;
 	case IP_VERSION(11, 0, 1):
-		soc15_program_register_sequence(adev,
-						golden_settings_gc_11_0,
-						(const u32)ARRAY_SIZE(golden_settings_gc_11_0));
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_11_0_1,
 						(const u32)ARRAY_SIZE(golden_settings_gc_11_0_1));
@@ -304,7 +265,6 @@ static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-	gfx_v11_0_init_spm_golden_registers(adev);
 }
 
 static void gfx_v11_0_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
@@ -1140,7 +1100,6 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.read_wave_sgprs = &gfx_v11_0_read_wave_sgprs,
 	.read_wave_vgprs = &gfx_v11_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
-	.init_spm_golden = &gfx_v11_0_init_spm_golden_registers,
 	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
 };
 
-- 
2.37.1

