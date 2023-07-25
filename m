Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3A1C001E0
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 13:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC4210E13E;
	Tue, 25 Jul 2023 13:16:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC8A10E13E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 13:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQa2iBzvHQcZNl+tkKNB5yqmhem/MrDP7BabgHjfkSMPYBNsuvwoneJOko2XF+TUxifG7/8a6jRPefBuZWXklCLnm5CQKUh2VyEsz+TDmUmqk7SACeUQiUUaomkqAwC4eXJH2h+Ae/u9jgbzvVDj8oxyqLa7cjpxoWQG82FO9hOHpsL+1xwam+Ct1unrWSVAUvV9YSrHUzr1RK6Za0wdYot7uEJfcwcECp9uizCT5oC3HWb4n+3swzdho8v339DrBy6iYosoo6aLPjZRgQmhvzXzhvbyTz0eWK0J2gXWROg7yYTDOOgbRz0RvRHxIamwnf0S+TvLU1+z+f2hRcAzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+eu4nxHusyquypiOx2Ad3sS4FYLm6JpOPDo/ArMww8=;
 b=I3zFwffbFrireS7Jema+KTejdZXJjeb8QNRzUYsdahAuFmqCJ5nKVwyy5R7j6QkvYlaDDhM6SJWMFoMISJx9hK5VSiuD3ptQZRvMquG/Nfs2Ceo7V5lDGPKiH7gaES66ABzvm3vrKLoYcVAWqdl7gEQPfkFZeEz/r6p82J+yFCTAGVvUECyYbOn8gE9D/16Sf4NHMjgknKIA4PSbDVnfO0+Dc4VqEumb96CtCjTpKEELl6d37qIj8xH6Poi3HOmLwLMEHwCuaZBMFCE0WY/FFXDwW4cJwAwt+oSazRhocL/T15IlAHf021suvdZmxrIvY1zji5QXwX2HiY0R7fZpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+eu4nxHusyquypiOx2Ad3sS4FYLm6JpOPDo/ArMww8=;
 b=LEGKfq+4hgFoGNang4AfpuBIlT3uocJiUqoWmQb10g4YVr5OtMDKksSvimzysoqM4L3ipFeMT94C4uRLeih5wL218qoH/HWFqnDmY01gNGF6NmASDsBJZpbCPwAn+c0EFrTOYAv5twNitIZ+ml/aepbjwRDSmCOW2lTtQpo35U0=
Received: from MW4PR03CA0360.namprd03.prod.outlook.com (2603:10b6:303:dc::35)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 13:16:08 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::8b) by MW4PR03CA0360.outlook.office365.com
 (2603:10b6:303:dc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 13:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 13:16:07 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 08:16:03 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Prefer dev_* variant over printk in
 amdgpu_atpx_handler.c
Date: Tue, 25 Jul 2023 18:45:39 +0530
Message-ID: <20230725131539.2308926-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: e88179ea-6dec-4435-643f-08db8d114e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crT81SBiQiXXwWDTN5BwLTBuUGWyzpinkDhiqbeGjxDEn0aJrIQqleCSbLiV8wJo+TCk5RqF4bIYwjfIJeEoHwpqETG+b/LriOvbSIAwqurCeGmVZnpxcZBbd5osTPb1HK8PxhenzbwstFk8uqaO9qBgiSeV7b5lrnGmxBKrvGB5DWl5nx9jtV0gA2vCwQ8RAFxtmFrM93ssxjK2DEoFje/wOlSloMRIvcB1FdL5rRC6p3wYu8FQeYsIMcjChj6rnl55UVlpGdsAU/YpZd//v8/7SO1YoKN8uSJABNgBxXrsn/r/wOG/OS6kZbkzFpDmX7JWAje9gRcy34GU6QczQMZy/EdWoeFz0z07sr4vpip9do24Hvsjr7ygIusWi6T4Xs6hJdC3QTg+YZ7dZQUIgOMw+L74PGoh36PjyZLWgwl0JIUPoqLVGiONmr4Ltd1akbAHwg1W1mDL2rUKH/WvBtuydjW1O4Q3QDmGytyPs8jUgdPzmC310hmEjWhBbHovT1z0yTUSqGRrJMExzuqsIwsqLN8eJ5fEz3j2wQttsgEIKGcab/cZ/vE+xxSp+CxBBdyDRFAM57bkOBapXL0Qz7GXXXOfXfxZ1lEPQxyuRYezfMdE9+QomwU4XszmCQpy/d0Yiu0U8iVXyBkstp6r3qQuCkaSfte0BvUlK2Jacx3ewj936S90jVAQlGuDdAA5fie1F+0/yC3GFSAY9v/3z6cax1RQsSWNnhD2S996L9fGPwRNi4YregpgmkMcJm9WakhCMr1DgoHUkuIRNEePow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(7696005)(54906003)(110136005)(6666004)(478600001)(16526019)(336012)(2616005)(186003)(1076003)(26005)(44832011)(2906002)(41300700001)(6636002)(5660300002)(8936002)(70206006)(8676002)(4326008)(316002)(81166007)(70586007)(82740400003)(356005)(40460700003)(86362001)(47076005)(83380400001)(426003)(36860700001)(66574015)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 13:16:07.1418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e88179ea-6dec-4435-643f-08db8d114e72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
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

Changed from printk to dev_* variants so that
we get better debug info when there are multiple GPUs
in the system.

Fixes other style issue:

ERROR: open brace '{' following function definitions go on the next line
WARNING: printk() should include KERN_<LEVEL> facility level

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 35 ++++++++++++-------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index d6d986be906a..4eddca672f3e 100644
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
@@ -113,6 +118,8 @@ static union acpi_object *amdgpu_atpx_call(acpi_handle handle, int function,
 	union acpi_object atpx_arg_elements[2];
 	struct acpi_object_list atpx_arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev = container_of(handle, struct acpi_device, handle);
+	struct device *dev = &adev->dev;
 
 	atpx_arg.count = 2;
 	atpx_arg.pointer = &atpx_arg_elements[0];
@@ -134,8 +141,8 @@ static union acpi_object *amdgpu_atpx_call(acpi_handle handle, int function,
 
 	/* Fail only if calling the method fails and ATPX is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		printk("failed to evaluate ATPX got %s\n",
-		       acpi_format_exception(status));
+		dev_err(dev, "failed to evaluate ATPX got %s\n",
+			acpi_format_exception(status));
 		kfree(buffer.pointer);
 		return NULL;
 	}
@@ -176,6 +183,8 @@ static void amdgpu_atpx_parse_functions(struct amdgpu_atpx_functions *f, u32 mas
 static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
 {
 	u32 valid_bits = 0;
+	struct acpi_device *adev = container_of(atpx->handle, struct acpi_device, handle);
+	struct device *dev = &adev->dev;
 
 	if (atpx->functions.px_params) {
 		union acpi_object *info;
@@ -190,7 +199,7 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
 
 		size = *(u16 *) info->buffer.pointer;
 		if (size < 10) {
-			printk("ATPX buffer is too small: %zu\n", size);
+			dev_err(dev, "ATPX buffer is too small: %zu\n", size);
 			kfree(info);
 			return -EINVAL;
 		}
@@ -223,11 +232,11 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
 	atpx->is_hybrid = false;
 	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
 		if (amdgpu_atpx_priv.quirks & AMDGPU_PX_QUIRK_FORCE_ATPX) {
-			printk("ATPX Hybrid Graphics, forcing to ATPX\n");
+			dev_info(dev, "ATPX Hybrid Graphics, forcing to ATPX\n");
 			atpx->functions.power_cntl = true;
 			atpx->is_hybrid = false;
 		} else {
-			printk("ATPX Hybrid Graphics\n");
+			dev_info(dev, "ATPX Hybrid Graphics\n");
 			/*
 			 * Disable legacy PM methods only when pcie port PM is usable,
 			 * otherwise the device might fail to power off or power on.
@@ -260,6 +269,8 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
 	struct atpx_verify_interface output;
 	size_t size;
 	int err = 0;
+	struct acpi_device *adev = container_of(atpx->handle, struct acpi_device, handle);
+	struct device *dev = &adev->dev;
 
 	info = amdgpu_atpx_call(atpx->handle, ATPX_FUNCTION_VERIFY_INTERFACE, NULL);
 	if (!info)
@@ -278,8 +289,8 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
 	memcpy(&output, info->buffer.pointer, size);
 
 	/* TODO: check version? */
-	printk("ATPX version %u, functions 0x%08x\n",
-	       output.version, output.function_bits);
+	dev_info(dev, "ATPX version %u, functions 0x%08x\n",
+		 output.version, output.function_bits);
 
 	amdgpu_atpx_parse_functions(&atpx->functions, output.function_bits);
 
-- 
2.25.1

