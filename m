Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC7AC2BB3F
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Nov 2023 16:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C423E10E231;
	Sat, 18 Nov 2023 16:13:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419B710E231
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Nov 2023 16:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWN1k3EEN890ctcKua7kWMD6YoPNU0lGJYsTx/8DIlrYCZo9nehpTd9sclzgdSLcXWPvySn1ALJfzjJGBcqicQUpSiTH1sX5xW9OruIg3rqVWsXehd8lWFH71TGw13GfrA1+ieL05tCYDYotvUSHv4fLDAglI0HCsc90h9D1Fnpc8G5+7FxkDSj9L3PDYydpejBnACPMO8RRglEfHGgfRFoujnxdguxCrwlnJYN4n0Bl8d7Ni5p7SciIHKCOaws2xSSVJPHud3p4OQtdeIJTU/uGCgdmT6q3jQ1frGwgiJq6fqqYaN5I0pBJk0ywYevw2Rz1WKEnQ8zCT2eFFxdWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJwfpteK0xHCTlmiq/U7rnyOgpjhTOWHSB6Wnn7vrr0=;
 b=FJQF1dBCueuVh2DrSy7AgE+QZWtG3GpOWD1JiB0REwCFkGnEX2RGb3Odypo/J5YN68EnqF4vqdy6rr2a5lwFLaw+iJIdLNqiaV0GKP+JX3BXLIpUmZZ+hlLzwUKbgYjhRhbVktEyXMgklDjpp/A7UKrd1zQPo6sVEGVi7RhgTx5NR8hDbrISQbpkAphcsG+qZfgdxYxB5xF73B1kqZCuHP3Q3u+QBcHqFZghdjoTnuZlDRsxPyY0Jd8hZaIv8kBcKtcDCzcoh8wF9MjCbKIm6VMUD3HrqTMOcgDu9c8J+Mlth8FNAEfmgG2XyzkabnT5Ytrwjvo6sAuFI0QBdQtFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJwfpteK0xHCTlmiq/U7rnyOgpjhTOWHSB6Wnn7vrr0=;
 b=sKMcdVMNf2oxh1nWbDopGAP9ckGClSsT+KeBelW7so632lJCQ68MblvLp4zeZvAYZiFVMiUI6d/JsyA8xt1LOy4xUl3ZNujHkE2H5HqqHUcNwy5BQxhPXg43zumO1oYxSS4nhBhL3oMNZRq4cKOtfYItApvpsXdiIh7fOGVpi+4=
Received: from MW4PR04CA0066.namprd04.prod.outlook.com (2603:10b6:303:6b::11)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 16:13:39 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::3) by MW4PR04CA0066.outlook.office365.com
 (2603:10b6:303:6b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25 via Frontend
 Transport; Sat, 18 Nov 2023 16:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Sat, 18 Nov 2023 16:13:38 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 18 Nov
 2023 10:13:37 -0600
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Force order between a read and write to the same
 address
Date: Sat, 18 Nov 2023 10:13:21 -0600
Message-ID: <20231118161321.18632-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5a3e46-8304-4a3a-2815-08dbe85152e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pd/pp5qMRnRRUc3fdjfJIgH++gqwvdCSFB48Six773r2XelidPgJjnHMQccnVvaFiqCTj5HE7bMhZBWZGnG6eQZQMb6zRtNwhEhUE0kODVUUy41SGkLclqsOVGaFKf7V66SqRzodd6MXlvNTWV30OREzN8xKdBZVLCk5aMcI9PgBC4AF4Z1SLg9lPF+sycZT+kCXtkQVcJy1NBYFygje/6fUnz/Qj6q5m+UOpRgyqeqcEkdveSqD+M25nqMKRmUa7fiKLtaFeJei1Im+rhjYTE2Y3DSLdL9y4bfiV54nwCBZA+oTwCTLJeTefAtF5fbkwOzXO8CWOi1yIIQrAuNNUH+1qCqeJ50JPnrBiwbgh9YxHCs1OCEB85sZRDeUu7k4Z7ZwiCKQ8Lpg/Cy510kIe7jJjAHEq828MzMhEsmcZJMux4qA4jN7DEEsToPi1GeIo/VOBi0KPUqRg5JuHqXEpK5l7xBOEFkt5Im1qwppRSwBLLun3f6c5b5HC7I3FrL/bTb+ORlJp5gS/+bDDOn3j9DMlKFA0OaABcfvH3v94M5yyZYT9ml4gbC6tCvXvQ9fSCdgFzeWelDVdPe6dOAZ00alchRGSghYsbdYsD6uMW57k3LaDYRbo4f2deNurOFx1aJvoNOmErl21vPmzcMas6r2fzp9xkRZc1lNJMoPldmZy3iJzAMPgI185tcy7u5RZKFlHCiT5BLmFdSURwI6Xq7YUvc6kjHF+UHRGhveVoUDOtmzpHbojryAlJXskp90HoboF6JbyErGeVE7msiKqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(426003)(336012)(70206006)(70586007)(316002)(6916009)(54906003)(26005)(16526019)(40460700003)(36756003)(8936002)(4326008)(8676002)(41300700001)(356005)(81166007)(82740400003)(36860700001)(47076005)(44832011)(86362001)(2906002)(5660300002)(83380400001)(7696005)(40480700001)(478600001)(1076003)(2616005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 16:13:38.2108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5a3e46-8304-4a3a-2815-08dbe85152e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735
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
Cc: Alex Sierra <alex.sierra@amd.com>, Felix.Kuehling@amd.com,
 joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Setting register to force ordering to prevent read/write or write/read
hazards for un-cached modes.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 22 +++++++++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  8 +++++++
 .../include/asic_reg/gc/gc_11_0_0_offset.h    |  2 ++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 68747a52e5c2..592ac993f013 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3193,7 +3193,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0x00010000, 0x00010020),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a00000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a00000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_10_3_sienna_cichlid[] = {
@@ -3245,6 +3246,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_2[] = {
 
 	/* This is not in GDB yet. Don't remove it. It fixes a GPU hang on Navy Flounder. */
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] = {
@@ -3275,6 +3277,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] = {
 
 	/* This is not in GDB yet. Don't remove it. It fixes a GPU hang on VanGogh. */
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_10_3_3[] = {
@@ -3297,7 +3300,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_3[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x00000820),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00100000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00100000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_10_3_4[] = {
@@ -3336,7 +3340,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_4[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0x00010000, 0x00010020),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0x01030000, 0x01030000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x03a00000, 0x00a00000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_10_3_5[] = {
@@ -3371,7 +3376,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_5[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a00000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a00000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_10_0_cyan_skillfish[] = {
@@ -3408,7 +3414,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_0_cyan_skillfish[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000100, 0x00000130),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0x00030008, 0x01030000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x00800000, 0x00800000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x00800000, 0x00800000),
 };
 
 static const struct soc15_reg_golden golden_settings_gc_10_3_6[] = {
@@ -3433,7 +3439,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_6[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQG_CONFIG, 0x000017ff, 0x00001000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0xffffff7f, 0x00010020),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00100000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00100000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_10_3_7[] = {
@@ -3458,7 +3465,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_7[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQG_CONFIG, 0x000017ff, 0x00001000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0xffffff7f, 0x00010020),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00100000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00100000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
 };
 
 #define DEFAULT_SH_MEM_CONFIG \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fd22943685f7..84decd069875 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -89,6 +89,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_rlc.bin");
 
+static const struct soc15_reg_golden golden_settings_gc_11_0[] = {
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000, 0x20000000)
+};
+
 static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regCGTT_GS_NGG_CLK_CTRL, 0x9fff8fff, 0x00000010),
@@ -303,6 +307,10 @@ static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
 	default:
 		break;
 	}
+	soc15_program_register_sequence(adev,
+					golden_settings_gc_11_0,
+					(const u32)ARRAY_SIZE(golden_settings_gc_11_0));
+
 }
 
 static void gfx_v11_0_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
index c92c4b83253f..4bff1ef8a9a6 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
@@ -6369,6 +6369,8 @@
 #define regTCP_INVALIDATE_BASE_IDX                                                                      1
 #define regTCP_STATUS                                                                                   0x19a1
 #define regTCP_STATUS_BASE_IDX                                                                          1
+#define regTCP_CNTL                                                                                     0x19a2
+#define regTCP_CNTL_BASE_IDX                                                                            1
 #define regTCP_CNTL2                                                                                    0x19a3
 #define regTCP_CNTL2_BASE_IDX                                                                           1
 #define regTCP_DEBUG_INDEX                                                                              0x19a5
-- 
2.32.0

