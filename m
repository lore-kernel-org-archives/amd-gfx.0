Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E924FC001DC
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 11:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB5610E26C;
	Mon, 31 Jul 2023 11:58:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F269910E26C
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 11:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShgNg37sqoIrlxMdJSdc9lNKCNqQKtEox54W7kzTaJCF9tjqayHXHSk1OBkkN3n3eEDFBR/10qZ10+B91rFFLWeqm452ZmrXU5iSgqz3wdaV/T9dNgvDz/c49531hH/gqq0hdXWzUKq0dw5cs2SeY7k43aTX2IyJoDWOTjcvo8RE8BgSR3oUqEH22jrl02ShCLr0nN65NJO/6E29gA0AAiv0XCbe9r+9k551uFLUJafe41xn0FGl97Oe4NNvfq6tDBjm58yyE/BRR3TjtwwZFpEbN4iJlF49P36uFYSKBtrqhxDGe1mIVMMf41n0Y8qGyC+qaHOBL0lhMNmzYEm4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbUIFFCjeo2hs8+loIJ+iuM/l5uwUO+csovB8vWZuUE=;
 b=nIBdFn4Y9en6BAJ0jHT8HI/Bexmnivz2KtnhwTr3WNB8/N91mQ24GYQjIKQ8JLCyrkTLcb6IAhvvkC2W8KKZmSZTO4fOAut9QbRlKJaWhvXsqT7FRDC+alBuXvwU3vbsEIjaU7/hFH2pZK+QnEugIDYjxdtWUomtSz+Eg6wOIiElCPTSU2cnwOvIIPzqrWmZgg18EFuSx+cIZBuEfPNKIUHEXxOF1a+NvKNkf793c0M8oUXD/j34JBkVcuyCwP2XdnkQf6gG2uh5mYSueDYdV88fBTgiiW1fwoX37odsl8Z/loQm4rmu1sfKLnvVCbY5lQvFO3StUFjszXrAWknwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbUIFFCjeo2hs8+loIJ+iuM/l5uwUO+csovB8vWZuUE=;
 b=qb/YVTUnuhGNoy6afxCOdnOYP6Gp7F6tM2/WXKwHq6nS64X5Etjw5s2xFuwYfwso3Hd2YJljeOmYvkiqg27XvPMxn5t72saK52gwOsokdQf5hJH2MIfodoOhs4xIRbBLlGIv3TMPv/wRfbPgxf1HV6n4wwDLW4C2cOuSwDtbFhU=
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42; Mon, 31 Jul 2023 11:58:49 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::f7) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.18 via Frontend
 Transport; Mon, 31 Jul 2023 11:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 31 Jul 2023 11:58:49 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 06:58:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Prefer dev_* variant over printk in
 amdgpu_atpx_handler.c"
Date: Mon, 31 Jul 2023 17:28:28 +0530
Message-ID: <20230731115828.2850334-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DM4PR12MB5342:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b57e89-bf1a-4ec7-2e53-08db91bd807b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+DAVr3zfPnu0bzfaDZGn1a5TUPodAEXIgsszcOidGrn5nEC0u62a6Db5TakEZ5msyld7Jxd3ATiyPIuLbHMrv56T7sj//n1xUkyCMy6ERTo+d01+nR3CifMmcQEXpYI9tinqdKlSjL/iBMv6GLn98EJYQhfaZBU9DZGDPkHS4tuZ0PhWbveaTCpJS3wgY4GzVNhZ0r/EFL29d86022Nr1Gs1FTQ3Bw6P0aElLYsL/jViX7iwmb610PSIK+/cBOwmoIu4X4dFYB7b3RI7JmLoYIMOXhVonsiGkNmpATVVgofszX4UMwAmvyUCyg8bMNwk0nFctonniNwJbpQizMTCEsuzgxotviSJJrtrpm6e+Xpp/zLmPdPCSvDpdxvlF9olJTnqKF2ExgOVZzso1UJP4iOqYXYhy1lKXkERVrJAd28KmYT+uvIvPy5QymV082raCTE7I4ttZuHhXBzjPqfHXVXnE2MDyYv59Lt1eB6PbXSahW4Kfu7dnUa+KwkWpfcVknJSmeW0a7GXV7K2mBN4SWLmv9ZiTQOFyXBhGVpb9VrvGcF6L2+AQwAPoIQJu/GX1n38dkm55GIMrYxGBGeerKJzWdZUCT6z++AiJ9n9K4PUpUPx7O8MApaYzyf6CV+RuZO4n4A5k3979mFBTKeOvwvup89+cra1pPg9eSl/g4Grec9yTa0JPC0CW+p5voQl/TG/hA5U1hH7zlQFrm+8NuBsJQ5wILUNsjGzjyU2czS0EmXPLOUS1s0iBijMQ7k
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(356005)(81166007)(82740400003)(40480700001)(86362001)(36756003)(966005)(40460700003)(478600001)(6666004)(7696005)(16526019)(2616005)(336012)(186003)(1076003)(26005)(8676002)(8936002)(44832011)(5660300002)(70586007)(6636002)(4326008)(70206006)(2906002)(54906003)(110136005)(41300700001)(316002)(36860700001)(66574015)(426003)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:58:49.2053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b57e89-bf1a-4ec7-2e53-08db91bd807b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5342
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

Usage of container_of is wrong here.
struct acpi_device *adev = container_of(handle, struct acpi_device, handle)

This reverts commit 7b19690805bbac72c82d9b9321f8130ad7898bb3.

References: https://gitlab.freedesktop.org/drm/amd/-/issues/2744
Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 35 +++++++------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index 6f241c574665..d6d986be906a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -74,29 +74,24 @@ struct atpx_mux {
 	u16 mux;
 } __packed;
 
-bool amdgpu_has_atpx(void)
-{
+bool amdgpu_has_atpx(void) {
 	return amdgpu_atpx_priv.atpx_detected;
 }
 
-bool amdgpu_has_atpx_dgpu_power_cntl(void)
-{
+bool amdgpu_has_atpx_dgpu_power_cntl(void) {
 	return amdgpu_atpx_priv.atpx.functions.power_cntl;
 }
 
-bool amdgpu_is_atpx_hybrid(void)
-{
+bool amdgpu_is_atpx_hybrid(void) {
 	return amdgpu_atpx_priv.atpx.is_hybrid;
 }
 
-bool amdgpu_atpx_dgpu_req_power_for_displays(void)
-{
+bool amdgpu_atpx_dgpu_req_power_for_displays(void) {
 	return amdgpu_atpx_priv.atpx.dgpu_req_power_for_displays;
 }
 
 #if defined(CONFIG_ACPI)
-void *amdgpu_atpx_get_dhandle(void)
-{
+void *amdgpu_atpx_get_dhandle(void) {
 	return amdgpu_atpx_priv.dhandle;
 }
 #endif
@@ -118,8 +113,6 @@ static union acpi_object *amdgpu_atpx_call(acpi_handle handle, int function,
 	union acpi_object atpx_arg_elements[2];
 	struct acpi_object_list atpx_arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_device *adev = container_of(handle, struct acpi_device, handle);
-	struct device *dev = &adev->dev;
 
 	atpx_arg.count = 2;
 	atpx_arg.pointer = &atpx_arg_elements[0];
@@ -141,8 +134,8 @@ static union acpi_object *amdgpu_atpx_call(acpi_handle handle, int function,
 
 	/* Fail only if calling the method fails and ATPX is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		dev_err(dev, "failed to evaluate ATPX got %s\n",
-			acpi_format_exception(status));
+		printk("failed to evaluate ATPX got %s\n",
+		       acpi_format_exception(status));
 		kfree(buffer.pointer);
 		return NULL;
 	}
@@ -183,8 +176,6 @@ static void amdgpu_atpx_parse_functions(struct amdgpu_atpx_functions *f, u32 mas
 static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
 {
 	u32 valid_bits = 0;
-	struct acpi_device *adev = container_of(atpx->handle, struct acpi_device, handle);
-	struct device *dev = &adev->dev;
 
 	if (atpx->functions.px_params) {
 		union acpi_object *info;
@@ -199,7 +190,7 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
 
 		size = *(u16 *) info->buffer.pointer;
 		if (size < 10) {
-			dev_err(dev, "ATPX buffer is too small: %zu\n", size);
+			printk("ATPX buffer is too small: %zu\n", size);
 			kfree(info);
 			return -EINVAL;
 		}
@@ -232,11 +223,11 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
 	atpx->is_hybrid = false;
 	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
 		if (amdgpu_atpx_priv.quirks & AMDGPU_PX_QUIRK_FORCE_ATPX) {
-			dev_info(dev, "ATPX Hybrid Graphics, forcing to ATPX\n");
+			printk("ATPX Hybrid Graphics, forcing to ATPX\n");
 			atpx->functions.power_cntl = true;
 			atpx->is_hybrid = false;
 		} else {
-			dev_info(dev, "ATPX Hybrid Graphics\n");
+			printk("ATPX Hybrid Graphics\n");
 			/*
 			 * Disable legacy PM methods only when pcie port PM is usable,
 			 * otherwise the device might fail to power off or power on.
@@ -269,8 +260,6 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
 	struct atpx_verify_interface output;
 	size_t size;
 	int err = 0;
-	struct acpi_device *adev = container_of(atpx->handle, struct acpi_device, handle);
-	struct device *dev = &adev->dev;
 
 	info = amdgpu_atpx_call(atpx->handle, ATPX_FUNCTION_VERIFY_INTERFACE, NULL);
 	if (!info)
@@ -289,8 +278,8 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
 	memcpy(&output, info->buffer.pointer, size);
 
 	/* TODO: check version? */
-	dev_info(dev, "ATPX version %u, functions 0x%08x\n",
-		 output.version, output.function_bits);
+	printk("ATPX version %u, functions 0x%08x\n",
+	       output.version, output.function_bits);
 
 	amdgpu_atpx_parse_functions(&atpx->functions, output.function_bits);
 
-- 
2.25.1

