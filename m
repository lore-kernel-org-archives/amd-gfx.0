Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C892EC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 15:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895F86023C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 15:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895F86023C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6BD06F4A1;
	Thu, 20 May 2021 15:56:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8E36F4A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 15:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNfnekEAM9QtMCBk6nNrBDQyEnlPmKDFObMJAYRliY4bBULO/ACnuKpYkcelzvN0EnTYChH8YV6ab6Q3Ol1PUIbjFWDCOt1cZeHVe6m4DPSD21206pxo7TOz3g9KLwHA0sasb8V9aeYCyzOm8jvEarVhWTFM2QY9IHIJRl7XoFM9nU9WdExxJ3AzhJmsqqqWhQ0JC0Dz8qi5QDFUiFDnSokeVp2PsFUlEiCrVqaHTY8//OVj+uv5fnnQ1F1Pz18V9jNaogKTPv4tYXgGrIr7igjEL4+O14xYz9AdPzVpZFxYsThxAoZmiWs4t3wzz6mizd/5Y1fPUHgKXgNauGWDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xm/FVIOkiGIyyfB9wEOMnfOcCcsK/5G/IpqirzLr2M=;
 b=Z1W1snK8Q61Cf3XlGeNe4qCij8f6adFc9S28n20Ows6Eu8Zr0Ud9VasHhDW8jQoAbSCc//sUFB/kdUxdr5HZ/i9v2C/p/tyGFc5UiIEwtzdtXav1EURrkhe3PC7P5fUFUWiLUOwyaP16SDK9+yCbivLeR136NghVH+HydXJQr5DVI6vi5WGr+uCe84pss4AvkI31yP+xrLwn6YhSNXhXHXnvYi/fYK2WZF/NsKf0FPDr/d+R1NhPmDJR2seSrQq36vKwZmIWyoBiw+LEZ9WOlC+EIFqx+BNTRg9kOLw+gr9r8QmMfzsHnbuSFI5mz3f/0juQacqXQQ4wdXne/VWkLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xm/FVIOkiGIyyfB9wEOMnfOcCcsK/5G/IpqirzLr2M=;
 b=L3sM7So7Q89L/5/l0Z1ENLtOMZkJj+ADsZ3mMntXy7TajLBFrixMWcUwUTVy/bntmuftL7Iw56WTZaJcytHIjeRfoHamGw5qnbC80ezDL4LTkFpPjrenRrQIdCHcSw/Vlstk+onrzjY5BN+mv2Y1rI5PWo3oRB36mKCd85euM8s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 15:56:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 15:56:30 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/acpi: unify ATCS handling (v3)
Date: Thu, 20 May 2021 11:56:13 -0400
Message-Id: <20210520155614.309986-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [204.111.139.213]
X-ClientProxiedBy: BL1PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::6) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (204.111.139.213) by
 BL1PR13CA0061.namprd13.prod.outlook.com (2603:10b6:208:2b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.12 via Frontend Transport; Thu, 20 May 2021 15:56:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36e3d76e-cacb-47e7-1df0-08d91ba7d50d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4488533F7F3B728984CB12BBF72A9@MN2PR12MB4488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:43;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1o+y9NtWxhYKdTj3DH1IIw+5XeMqbTRP7Igape1QLfMEXMIgjgFlDB4JRXQBRa7BPkEyWkR2KtUynn/tKiM7gx3drEirSYCZTWaJUExYuYAN+CWCHjE6SAM7HdIsazGAuoJBQbYZxsuQYRKOk2tOJGkFTOia3i3AAGAxLLSqzwNZEfgtGmsV9n+N/aAHE30lsXocBCro3KguTNdXSEh+LjvogqcuvF9dEWcqLwifTPtmEgNsVueVqO93U30CdT5XR4m3dbUl29lcNfPcFVFtxtGqpDCmUWiUG8hHE6fkqBDzwEHR9Yj/RS1YKTao6JKetDwsN47cxDOnAsOuruA/Urx5XHIbvFJxJhKWO5wTcGW5kc72LfnsD8OzcDmbylzt6+NlQrLaLkYurAHKwU6ttBRPHBtZM8pj/3BdIff5e8VJOF5ckK06slPWrQ43tTa4FWZqgAgpGHgMTccGskDu2lA+ahZJ2jIefdGoP4Juo/oeytAPieYDos5Hy3NnCirHncwimkuwMwHx2hRK0Sw2+qcpWXC3omoEc/UFGNKRXf+XIDWvyMfhEF94pXx3vSigqyHtf06ytcDdv8nrZvzScGEB6euDKjuYSZcAac1Qjp+VuVjwITM88SEHjshacYUJvO9CzjyYQdRiuu1foQH8Uy+ppEPa21/KR2i4fITD1xYiUUO8FAO+4FMhUXixZsu2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(83380400001)(6666004)(6916009)(66946007)(66476007)(66556008)(2906002)(6486002)(86362001)(186003)(8676002)(1076003)(52116002)(38350700002)(38100700002)(478600001)(5660300002)(8936002)(4326008)(26005)(956004)(36756003)(316002)(2616005)(6506007)(16526019)(6512007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Hz+uEetqeB3zQ7elcMqwVDtlxHXqPFyeDs/aobl7ts5if2Of9B2/54ZnUJMf?=
 =?us-ascii?Q?2SvdPdxbnB/C1g5aJbZ201OikNdRODHLhb/Q3qrT6W3tjvB/hp2ulqJ1yGzP?=
 =?us-ascii?Q?ZQv/6DXQhQlWTGvkudmxtZN8OfG3ospshcUfId5eA/Oc27iL98J1gb8uMtTB?=
 =?us-ascii?Q?idBgS1j+hVAPkNbx2TTYIz9Z9JfaHHsO3NPt16lh5Rslkwi0cYRwOpCG9nLY?=
 =?us-ascii?Q?P1gU5pSa0mxOZRzI8RAN3LDPKXmtUVjwKNE+mGeoJWOsmEZk1zd9hgcwVYMW?=
 =?us-ascii?Q?S3kPNVkNJslDdDkHq1LlUovoglVWCTzdBvxRHdHIsPAjvk6rK2kzVZyZggD7?=
 =?us-ascii?Q?M8a7nfZbITEoj/HYhjDd1E/eWvwK66b/MP2NMOy1xLE69C2XBEfFhkUHefIL?=
 =?us-ascii?Q?woNtGnR6M0+CWD4F7vLXZnnlVqbHpbx8APa2tUphcxsMTO77BRpTIj3ojvbz?=
 =?us-ascii?Q?kvn7frQpqHtByK8Ytij0vh/C6Yvt7M5Dsqhis/w22WyGg/v+GQhlAixvG76W?=
 =?us-ascii?Q?u8X6FKNe/Brx9Z5lEFywE4jxlnRB175uJEP5DfmBRe2KwOuA6ExOuo8dk5Qg?=
 =?us-ascii?Q?Bt4aIndS3W/WDxYCBey6Vvc+jbDdyStJjMAeXN+Uke4CsWe6uJwxvpOj5Twu?=
 =?us-ascii?Q?Wk/4qxzoL8aeXamRPTRZFR82EyIoP9dnLFJwrWPTl21p4SYZy/nJ4vBpcMTe?=
 =?us-ascii?Q?hPJzksJBNnqFhspgxbuwqNBTXEbWYkBfNHLLiw6w5W+9DkTh56ggMgH/hTFw?=
 =?us-ascii?Q?4+L6ie/GDIfhW7LaYLy4A4ejQyVdGGFTa8T6G1ZjBhwq7z0mG8aJ4pd6S2mO?=
 =?us-ascii?Q?YnDf3yeIeQ2KqyhZ1mNPs2extaXhavrc5wn1jfvNjl+IolPsz90YefzIi+B0?=
 =?us-ascii?Q?PWqNBYAFngmr94eiDKHleM4dT+f/6jnk8qeH+NUuAQYV0ffGXHozsturkErL?=
 =?us-ascii?Q?ex97QkNcvE2j9G9lL3p/6N6VhV77XdyvwASjP3zx14ooA2/1OmReHErlYWGl?=
 =?us-ascii?Q?faUgLRr51Zh+tJsH+NR+s/KUl/kvl0hZWSlgciy74Ut1tFbEfMwpC84AL6R0?=
 =?us-ascii?Q?czo3tomhIT/dOfqoT+ho+xjqgwLPH/Obbn6EF1qrU56xfkNRLyembg8ibuhV?=
 =?us-ascii?Q?ATDNdjggay7FLB1aOxJuiiKnamBMXgrNc0fF98nRc9eGXJM52VMpJvEKpLeS?=
 =?us-ascii?Q?7S4k2bDw8wwn1d28Kf4M/wFUmPfIgTUPd2uOTyL0c+cTAD+MOspRx4qkGJlv?=
 =?us-ascii?Q?uZXt942/UN6RMib+UuTGgGhaKBpWWr8kxSZ/LRLwcQrnYCQjZfFjTfmJKKXJ?=
 =?us-ascii?Q?zj1MLfPHBoGJFkt0Jw2A+Ovf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e3d76e-cacb-47e7-1df0-08d91ba7d50d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 15:56:29.9671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNA+HSW+qeLcjaqiucHkI7r+DOglhA84/jE51deSn+b9y3Ix9sFDRiN3Y4knaFtIZ/a4nNanymYBua/BijE+bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Treat it like ATIF and check both the dGPU and APU for
the method.  This is required because ATCS may be hung
off of the APU in ACPI on A+A systems.

v2: add back accidently removed ACPI handle check.
v3: Fix incorrect atif check (Colin)
    Fix uninitialized variable (Colin)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  17 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 128 ++++++++++++++++-------
 2 files changed, 93 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b6435479cac8..ece1aee5a667 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -268,6 +268,7 @@ struct amdgpu_irq_src;
 struct amdgpu_fpriv;
 struct amdgpu_bo_va_mapping;
 struct amdgpu_atif;
+struct amdgpu_atcs;
 struct kfd_vm_fault_info;
 struct amdgpu_hive_info;
 struct amdgpu_reset_context;
@@ -681,20 +682,6 @@ struct amdgpu_vram_scratch {
 	u64				gpu_addr;
 };
 
-/*
- * ACPI
- */
-struct amdgpu_atcs_functions {
-	bool get_ext_state;
-	bool pcie_perf_req;
-	bool pcie_dev_rdy;
-	bool pcie_bus_width;
-};
-
-struct amdgpu_atcs {
-	struct amdgpu_atcs_functions functions;
-};
-
 /*
  * CGS
  */
@@ -825,7 +812,7 @@ struct amdgpu_device {
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper     debugfs_vbios_blob;
 	struct amdgpu_atif		*atif;
-	struct amdgpu_atcs		atcs;
+	struct amdgpu_atcs		*atcs;
 	struct mutex			srbm_mutex;
 	/* GRBM index mutex. Protects concurrent access to GRBM index */
 	struct mutex                    grbm_idx_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 6cf6231057fc..29708b5685ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -72,12 +72,25 @@ struct amdgpu_atif {
 	struct amdgpu_dm_backlight_caps backlight_caps;
 };
 
+struct amdgpu_atcs_functions {
+	bool get_ext_state;
+	bool pcie_perf_req;
+	bool pcie_dev_rdy;
+	bool pcie_bus_width;
+};
+
+struct amdgpu_atcs {
+	acpi_handle handle;
+
+	struct amdgpu_atcs_functions functions;
+};
+
 /* Call the ATIF method
  */
 /**
  * amdgpu_atif_call - call an ATIF method
  *
- * @atif: acpi handle
+ * @atif: atif structure
  * @function: the ATIF function to execute
  * @params: ATIF function params
  *
@@ -237,6 +250,35 @@ static acpi_handle amdgpu_atif_probe_handle(acpi_handle dhandle)
 	return handle;
 }
 
+static acpi_handle amdgpu_atcs_probe_handle(acpi_handle dhandle)
+{
+	acpi_handle handle = NULL;
+	char acpi_method_name[255] = { 0 };
+	struct acpi_buffer buffer = { sizeof(acpi_method_name), acpi_method_name };
+	acpi_status status;
+
+	/* For PX/HG systems, ATCS and ATPX are in the iGPU's namespace, on dGPU only
+	 * systems, ATIF is in the dGPU's namespace.
+	 */
+	status = acpi_get_handle(dhandle, "ATCS", &handle);
+	if (ACPI_SUCCESS(status))
+		goto out;
+
+	if (amdgpu_has_atpx()) {
+		status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATCS",
+					 &handle);
+		if (ACPI_SUCCESS(status))
+			goto out;
+	}
+
+	DRM_DEBUG_DRIVER("No ATCS handle found\n");
+	return NULL;
+out:
+	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+	DRM_DEBUG_DRIVER("Found ATCS handle %s\n", acpi_method_name);
+	return handle;
+}
+
 /**
  * amdgpu_atif_get_notification_params - determine notify configuration
  *
@@ -486,14 +528,15 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 /**
  * amdgpu_atcs_call - call an ATCS method
  *
- * @handle: acpi handle
+ * @atcs: atcs structure
  * @function: the ATCS function to execute
  * @params: ATCS function params
  *
  * Executes the requested ATCS function (all asics).
  * Returns a pointer to the acpi output buffer.
  */
-static union acpi_object *amdgpu_atcs_call(acpi_handle handle, int function,
+static union acpi_object *amdgpu_atcs_call(struct amdgpu_atcs *atcs,
+					   int function,
 					   struct acpi_buffer *params)
 {
 	acpi_status status;
@@ -517,7 +560,7 @@ static union acpi_object *amdgpu_atcs_call(acpi_handle handle, int function,
 		atcs_arg_elements[1].integer.value = 0;
 	}
 
-	status = acpi_evaluate_object(handle, "ATCS", &atcs_arg, &buffer);
+	status = acpi_evaluate_object(atcs->handle, "ATCS", &atcs_arg, &buffer);
 
 	/* Fail only if calling the method fails and ATIF is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
@@ -551,7 +594,6 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
 /**
  * amdgpu_atcs_verify_interface - verify ATCS
  *
- * @handle: acpi handle
  * @atcs: amdgpu atcs struct
  *
  * Execute the ATCS_FUNCTION_VERIFY_INTERFACE ATCS function
@@ -559,15 +601,14 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
  * (all asics).
  * returns 0 on success, error on failure.
  */
-static int amdgpu_atcs_verify_interface(acpi_handle handle,
-					struct amdgpu_atcs *atcs)
+static int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
 {
 	union acpi_object *info;
 	struct atcs_verify_interface output;
 	size_t size;
 	int err = 0;
 
-	info = amdgpu_atcs_call(handle, ATCS_FUNCTION_VERIFY_INTERFACE, NULL);
+	info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_VERIFY_INTERFACE, NULL);
 	if (!info)
 		return -EIO;
 
@@ -604,8 +645,10 @@ static int amdgpu_atcs_verify_interface(acpi_handle handle,
  */
 bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev)
 {
-	struct amdgpu_atcs *atcs = &adev->atcs;
+	struct amdgpu_atcs *atcs = adev->atcs;
 
+	if (!atcs)
+		return false;
 	if (atcs->functions.pcie_perf_req && atcs->functions.pcie_dev_rdy)
 		return true;
 
@@ -623,19 +666,15 @@ bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *ade
  */
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)
 {
-	acpi_handle handle;
 	union acpi_object *info;
-	struct amdgpu_atcs *atcs = &adev->atcs;
+	struct amdgpu_atcs *atcs = adev->atcs;
 
-	/* Get the device handle */
-	handle = ACPI_HANDLE(&adev->pdev->dev);
-	if (!handle)
+	if (!atcs)
 		return -EINVAL;
-
 	if (!atcs->functions.pcie_dev_rdy)
 		return -EINVAL;
 
-	info = amdgpu_atcs_call(handle, ATCS_FUNCTION_PCIE_DEVICE_READY_NOTIFICATION, NULL);
+	info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_PCIE_DEVICE_READY_NOTIFICATION, NULL);
 	if (!info)
 		return -EIO;
 
@@ -658,21 +697,18 @@ int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)
 int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
 					 u8 perf_req, bool advertise)
 {
-	acpi_handle handle;
 	union acpi_object *info;
-	struct amdgpu_atcs *atcs = &adev->atcs;
+	struct amdgpu_atcs *atcs = adev->atcs;
 	struct atcs_pref_req_input atcs_input;
 	struct atcs_pref_req_output atcs_output;
 	struct acpi_buffer params;
 	size_t size;
 	u32 retry = 3;
 
-	if (amdgpu_acpi_pcie_notify_device_ready(adev))
+	if (!atcs)
 		return -EINVAL;
 
-	/* Get the device handle */
-	handle = ACPI_HANDLE(&adev->pdev->dev);
-	if (!handle)
+	if (amdgpu_acpi_pcie_notify_device_ready(adev))
 		return -EINVAL;
 
 	if (!atcs->functions.pcie_perf_req)
@@ -692,7 +728,7 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
 	params.pointer = &atcs_input;
 
 	while (retry--) {
-		info = amdgpu_atcs_call(handle, ATCS_FUNCTION_PCIE_PERFORMANCE_REQUEST, &params);
+		info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_PCIE_PERFORMANCE_REQUEST, &params);
 		if (!info)
 			return -EIO;
 
@@ -768,32 +804,26 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
  */
 int amdgpu_acpi_init(struct amdgpu_device *adev)
 {
-	acpi_handle handle, atif_handle;
+	acpi_handle handle, atif_handle, atcs_handle;
 	struct amdgpu_atif *atif;
-	struct amdgpu_atcs *atcs = &adev->atcs;
-	int ret;
+	struct amdgpu_atcs *atcs;
+	int ret = 0;
 
 	/* Get the device handle */
 	handle = ACPI_HANDLE(&adev->pdev->dev);
 
 	if (!adev->bios || !handle)
-		return 0;
-
-	/* Call the ATCS method */
-	ret = amdgpu_atcs_verify_interface(handle, atcs);
-	if (ret) {
-		DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
-	}
+		return ret;
 
 	/* Probe for ATIF, and initialize it if found */
 	atif_handle = amdgpu_atif_probe_handle(handle);
 	if (!atif_handle)
-		goto out;
+		goto atcs;
 
 	atif = kzalloc(sizeof(*atif), GFP_KERNEL);
 	if (!atif) {
 		DRM_WARN("Not enough memory to initialize ATIF\n");
-		goto out;
+		goto atcs;
 	}
 	atif->handle = atif_handle;
 
@@ -802,7 +832,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	if (ret) {
 		DRM_DEBUG_DRIVER("Call to ATIF verify_interface failed: %d\n", ret);
 		kfree(atif);
-		goto out;
+		goto atcs;
 	}
 	adev->atif = atif;
 
@@ -811,7 +841,8 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 		if (amdgpu_device_has_dc_support(adev)) {
 #if defined(CONFIG_DRM_AMD_DC)
 			struct amdgpu_display_manager *dm = &adev->dm;
-			atif->bd = dm->backlight_dev;
+			if (dm->backlight_dev)
+				atif->bd = dm->backlight_dev;
 #endif
 		} else {
 			struct drm_encoder *tmp;
@@ -863,6 +894,28 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 		atif->backlight_caps.caps_valid = false;
 	}
 
+atcs:
+	/* Probe for ATCS, and initialize it if found */
+	atcs_handle = amdgpu_atcs_probe_handle(handle);
+	if (!atcs_handle)
+		goto out;
+
+	atcs = kzalloc(sizeof(*atcs), GFP_KERNEL);
+	if (!atcs) {
+		DRM_WARN("Not enough memory to initialize ATCS\n");
+		goto out;
+	}
+	atcs->handle = atcs_handle;
+
+	/* Call the ATCS method */
+	ret = amdgpu_atcs_verify_interface(atcs);
+	if (ret) {
+		DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
+		kfree(atcs);
+		goto out;
+	}
+	adev->atcs = atcs;
+
 out:
 	adev->acpi_nb.notifier_call = amdgpu_acpi_event;
 	register_acpi_notifier(&adev->acpi_nb);
@@ -893,6 +946,7 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
 {
 	unregister_acpi_notifier(&adev->acpi_nb);
 	kfree(adev->atif);
+	kfree(adev->atcs);
 }
 
 /**
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
