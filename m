Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B891C001DC
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 12:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D440A10E277;
	Mon, 31 Jul 2023 12:18:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8957210E278
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 12:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwILayCRSIQSywZcXMD3a157FTAkmy/JLJyIEorOk6aqgeUL5Z7oEmpOAaolb/2VXAiA+fAQNc6maOFOPVRjbRGdRveKjawNOJoKdgRwy5uhzjsMekFNA13JordZqkngE6tJ1n7ojjFo78NZOHVflGaERlmCQXY7ZjQEgeVx7qLG3qh1WBU/8eu50evw4cbXL9X3sWFIrTXyPZVBWiGDyZtEROPZhETpYG3rRoVHdBYxjQK1x8kMCV+8zVuDJ0jb4giH2wyHVQ+jTPN92SR8+DYwueEglLBkRjgpYogTjVCNnTS7ZRjy/B+tL0uPWokekGX2vDnnyswkUXEvGSBIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD7Ogw2brG8etga9vTS6nohA8IVduV6PFwxrydMnTr0=;
 b=bRYYkekrESxE4jRcpNoRMNAiHrnux6G1obrB7apIOc2qqRbV5qMlEEIyBeZygOx9eBPfxMDlqs5AcsCLIsQs+CZwM1GvsxoI5lwhJaP+TB+8PCHfTOpcT+OYxSsVsu6qGsCvrjqzpWbYdCV3mu8EeG9mgphRpGkak+RBcZjyVo/aaeRvj480ENDMu8nVugQbz9B0vcfhhyWn8HCprqFJxJ69efW23VeAJXE0Ol44eTjvE3So9V22R6qhIqhurSe8y8VD51EFDhWre51ABQ3sATiw9uGeS2OZbzlrVxiqRfk8doa+A8YNYSB2esEnLw12D9FbUAG2DqZ9qZkoTN46hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD7Ogw2brG8etga9vTS6nohA8IVduV6PFwxrydMnTr0=;
 b=Ngy2yJpajtOLz/KlfWwuKfBbaRxQ0pychVXf1QWhzZ1poK6JLSung+C1JNkSEPGj+vu8gNurgGV9mYY+OzR/EtvgTxXDrpm8EbGBBU5fxO0SfYTJvRaX2ikVgh3iGCvghOhvBuXbE7DSoW6t0NawTmBaE6+hHqOTGQQeCgaYYV4=
Received: from CY5PR22CA0101.namprd22.prod.outlook.com (2603:10b6:930:65::15)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 31 Jul
 2023 12:18:32 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::d3) by CY5PR22CA0101.outlook.office365.com
 (2603:10b6:930:65::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 12:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 31 Jul 2023 12:18:32 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 07:18:29 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: Prefer pr_err/_info over printk in
 amdgpu_atpx_handler.c
Date: Mon, 31 Jul 2023 17:48:15 +0530
Message-ID: <20230731121815.2852832-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e68918-cf72-424e-6f82-08db91c041b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qd7UYGhfhuG0aHTlfD2Swa3eGL6qQum4rGFNCT+5yufOqKNq5fzv8jdzKBQOxFpBlrNcLz1Rn2/Df60IjcDyLRRKLmwjCcYzGdhCarBhXTx8Lqpnn7ji/TS6Iug7IypqC+jOCeOJFH4xzVckrg2SlxH4qIIHvCltTzbRirF/gi9UUpYpioBe5RBFjtYrnZlGuuFZ5fBugEigcC5hYsSX6syV+GKXjG+0pxvUe24md669cOKzMABGTGgNdOBfDiKqfyREIUo5TaVZ2/09TEGotU90SVbd5YjuYsKphESJalkopRoEdNc/9i3EZKUEgSfMf2ESszmBO9HzpTrD3UIstwT7/lwhlfl1pe5aObXB20BWzuGATkEpMUAwaWQ4dH7sXrzag1BZsMjlz6Ev3nJLu1R9Hhinykyd5OIiZ/0ZaSrswaarRxB+M7C+0Obaf+znxfXrDQL3j235UY6/Yeu0oghsViwSDdriw+vrMcnBjlY94ue/RDo4BSWx/X5OaFg8mU6HNX5zHlOFGE1HjxwWzjDEFU40FDDsa9y6gLSE0w1sNrT6ucPTSHf6FNkbGb8VhEIg5fA9vLPJ2rWMKX0GfewMsexE0u5nRZwWqgNSo5eWyxISd9gw7N3/Qq1ZVwbI2336A221llSOUlMAyi0MgGImoKew7w2Ag2z8FifxDrkmaSTmrILBHy/RNP1aCtMtGg8A4jRdAA6RrbqJS4iqJ61AhZ2z3R6NyxD5mi3X0CawX/7GblEwhEfpoFx7eWuPKsHARTtkg1KiQ5X0w7kHlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(47076005)(36860700001)(7696005)(36756003)(16526019)(40480700001)(40460700003)(2616005)(1076003)(26005)(83380400001)(186003)(336012)(426003)(66574015)(44832011)(70206006)(70586007)(81166007)(356005)(54906003)(110136005)(82740400003)(86362001)(316002)(4326008)(5660300002)(6636002)(8676002)(8936002)(41300700001)(2906002)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 12:18:32.4317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e68918-cf72-424e-6f82-08db91c041b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428
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
 Bert Karwatzki <spasswolf@web.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following style issues:

ERROR: open brace '{' following function definitions go on the next line
WARNING: printk() should include KERN_<LEVEL> facility level

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index d6d986be906a..9ba49a1b7c34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -74,24 +74,29 @@ struct atpx_mux {
 	u16 mux;
 } __packed;
 
-bool amdgpu_has_atpx(void) {
+bool amdgpu_has_atpx(void)
+{
 	return amdgpu_atpx_priv.atpx_detected;
 }
 
-bool amdgpu_has_atpx_dgpu_power_cntl(void) {
+bool amdgpu_has_atpx_dgpu_power_cntl(void)
+{
 	return amdgpu_atpx_priv.atpx.functions.power_cntl;
 }
 
-bool amdgpu_is_atpx_hybrid(void) {
+bool amdgpu_is_atpx_hybrid(void)
+{
 	return amdgpu_atpx_priv.atpx.is_hybrid;
 }
 
-bool amdgpu_atpx_dgpu_req_power_for_displays(void) {
+bool amdgpu_atpx_dgpu_req_power_for_displays(void)
+{
 	return amdgpu_atpx_priv.atpx.dgpu_req_power_for_displays;
 }
 
 #if defined(CONFIG_ACPI)
-void *amdgpu_atpx_get_dhandle(void) {
+void *amdgpu_atpx_get_dhandle(void)
+{
 	return amdgpu_atpx_priv.dhandle;
 }
 #endif
@@ -134,7 +139,7 @@ static union acpi_object *amdgpu_atpx_call(acpi_handle handle, int function,
 
 	/* Fail only if calling the method fails and ATPX is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		printk("failed to evaluate ATPX got %s\n",
+		pr_err("failed to evaluate ATPX got %s\n",
 		       acpi_format_exception(status));
 		kfree(buffer.pointer);
 		return NULL;
@@ -190,7 +195,7 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
 
 		size = *(u16 *) info->buffer.pointer;
 		if (size < 10) {
-			printk("ATPX buffer is too small: %zu\n", size);
+			pr_err("ATPX buffer is too small: %zu\n", size);
 			kfree(info);
 			return -EINVAL;
 		}
@@ -223,11 +228,11 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
 	atpx->is_hybrid = false;
 	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
 		if (amdgpu_atpx_priv.quirks & AMDGPU_PX_QUIRK_FORCE_ATPX) {
-			printk("ATPX Hybrid Graphics, forcing to ATPX\n");
+			pr_info("ATPX Hybrid Graphics, forcing to ATPX\n");
 			atpx->functions.power_cntl = true;
 			atpx->is_hybrid = false;
 		} else {
-			printk("ATPX Hybrid Graphics\n");
+			pr_info("ATPX Hybrid Graphics\n");
 			/*
 			 * Disable legacy PM methods only when pcie port PM is usable,
 			 * otherwise the device might fail to power off or power on.
@@ -269,7 +274,7 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
 
 	size = *(u16 *) info->buffer.pointer;
 	if (size < 8) {
-		printk("ATPX buffer is too small: %zu\n", size);
+		pr_err("ATPX buffer is too small: %zu\n", size);
 		err = -EINVAL;
 		goto out;
 	}
@@ -278,8 +283,8 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
 	memcpy(&output, info->buffer.pointer, size);
 
 	/* TODO: check version? */
-	printk("ATPX version %u, functions 0x%08x\n",
-	       output.version, output.function_bits);
+	pr_info("ATPX version %u, functions 0x%08x\n",
+		output.version, output.function_bits);
 
 	amdgpu_atpx_parse_functions(&atpx->functions, output.function_bits);
 
-- 
2.25.1

