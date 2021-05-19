Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFC9C43460
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677A4611C2
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677A4611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049EC6EE8E;
	Wed, 19 May 2021 20:38:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBEF6EE8E
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 20:38:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iboYOpsfYr9+9BsFKxE/CsyfH5R6Hk9Z5Pd6CfqWhU4/uhzhXpC4m8sykGOV/vzPyIr0oBMtZOBv/Jf4uLAAbh3J1j6k1n7BhPpDNcEjfTrFjQQ68L91ZRzRw/RQ025T8IAKA3hKzYmJd0F/s9+wc/VIqVsV4GTGIocWoyD4aM7u8S7NFjGaulm7I2lBShGMK264T9E+DPScA3c6UDloBcuuMeEmZokJdDt/h/9nsdXCyggVc2t4Z8kJV3972E26fPXaYwnvhXJFEZ2rWkIfq1O8Chn36JIRd+Aj1ag/G2LMpCpZEBMvJYHOt4vx+2J2c1YKNQVJIEYXWTeiQmjfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t0zzDoqQd2n4ulWvTTTC1AhvR23vjVxKxya+YR4eao=;
 b=AMcVRcy1Zc0RUJyxDWCjw6jprmZpMbijbtHLgDVObXiITmpFObHjjX6hRaOF7oVxnLDkiFYr1ICVBvuCR4GmLZ3q4TyT0IbasBPjbM850WhkAihdFPs1hoTB3Afgbujt0SXp2yiaPbMcpFLTTXfIAZxIoH86QPVSmOtbww8TYQOR3zzs+SzaWIvISfTX0/IDD5DMt1l3/zXrTVTXEE5uCKLepSTRxoIPbVpH9gsz8xL7XUhK9ZeQgkuvyg5il8jVsszoy2GjEZYJGZx7FwrhZwSvkK2oyrl4mK0s6bZ6WIrwVR4oD1LIyqoOAov0thihnQjZArNNQCjdiiJlVpfv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t0zzDoqQd2n4ulWvTTTC1AhvR23vjVxKxya+YR4eao=;
 b=RfQFh+1wfbN3N6haDzhpLnZvbsI/S8kkZfL6bva/WHjBDi/755hwbAPoMPOoC/FKIWs1UTmOB9wK/YqM6zu2cVZk/YMXFJ9DhFdTMFZ0986nkYPH5MNGOCsvSnqQb6a8MQjoQa9/hq33zpVlmgnfTNhakTeZ+qV8qWt4/CWbqF4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 20:38:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 20:38:18 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/acpi: unify ATCS handling
Date: Wed, 19 May 2021 16:37:46 -0400
Message-Id: <20210519203747.2736827-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: MN2PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:208:23d::34) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR06CA0029.namprd06.prod.outlook.com (2603:10b6:208:23d::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend
 Transport; Wed, 19 May 2021 20:38:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc940df1-318a-41be-a5e1-08d91b0608a4
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB486557EEF6802F8D3A9A355FF72B9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:43;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sgYDCwMVtrSFXYvoAP0gSG2FoCS+5L7dVkydUb3rg3zi/03C37BuyjnLLPW6wMP0YnLEt79kYErZ0Nh6sPCQksVYGfjg6+N65n/CUlTY4wod3X4dc+WVaQ5irJgemVsRY1Xp3eI9BB6VnnhWOxKTyK68ClA9UTL5MhfZMJzIB7yH5Qt520/wlSd/QrHaFQHY/kogGFCh9ZaVtZn7Vr54JP1m75XqFyZzfuLstvLkc1qdWx6YcG7fFTjOpJJS4QoS3OjRynoLpNQ809KFQGX+/fB7pJaAuq4fD0MUea6uZPzyxnRqZ1bfdp5JHBNsNBTMMdc7VeudfFD55TVxOBkU+wi+p16dCryF0tgeGzsqjhhopDsQx2JzejiqlyqNKxCnGu33KYkEaQ/9HftSulZ+OX0yF2fYbrE8eZa4S/wqoTfN3FwKhYtmN6x2GYv1D/NTTzphALKWI0yxL/tuh4UneisDpFjVbGOa0Vgo2PPCRwSXpiruv0MOMSL+nNBXAQG58oIbQo+QNQdyz1BtIPbwKlORVdFMYg1cspoMNzgoF3FuculgGbAouxeTs5sUYAGvVKiXfFl3fNc27wITo1DyI96GNaWumie4/2AwGL6GAH44hfsd88kWOH2onlHYaZ0dhZxz7BKeJHhiJ8H5gXhvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(26005)(6486002)(7696005)(66946007)(6666004)(38100700002)(4326008)(956004)(1076003)(186003)(38350700002)(8676002)(6916009)(2906002)(83380400001)(5660300002)(66556008)(316002)(8936002)(86362001)(2616005)(478600001)(66476007)(52116002)(36756003)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?T4wY1hVSk6A8eyWDixwmgrvUPMSMPBjyBZScPjQuHSff+p98kdMkUN3SLamS?=
 =?us-ascii?Q?+LowMRDR+itlL6t1A2fJ9Xcts9MBaDKzSJSJI5CnB7Xxr9tp1ZYeOQ+i9NUc?=
 =?us-ascii?Q?UBiips/899sVD73B8VamsRvWbRhaT14SE+1JMj4oJBFMjYg6MoCZ/7JkyKxL?=
 =?us-ascii?Q?CytaU4dlr63GIKEAo6WwYTCZ+Jb7H7SO8+ZCrAhBL+JfkRstc1LuTYrR+iVP?=
 =?us-ascii?Q?0uXC/ZzEM+W+x83TWIy81gCm8XFllQ6GIBwtC3pLrJ01EllaSE7LldSojYEO?=
 =?us-ascii?Q?G63MdvlquSpO7reQZ0BqceWH7G69wdh6DRekvO7fKIads54C6w2qpQChE9Z4?=
 =?us-ascii?Q?yx9nzWs3SkK42+HbtBrPSGi1493ybbdqQAQiDRILQDYCGiybYa46NvMm2Xyr?=
 =?us-ascii?Q?PZ5h2tEsJr8VGXMcJyRXVHw/VQUZZoluAQcJtwwHxURO6VNSjdl46UAUEX0E?=
 =?us-ascii?Q?3wB9J0Y4vGTgp2sCIMVUsz2q2ORN8oyTvs/lznk3p31s9O2k62vcBexsiH4g?=
 =?us-ascii?Q?uh/+TOCkwWFAY+iZtD5hKnAbIyI4MTJTfrSIsEvgyFou8iaztm/aXkCoA9QM?=
 =?us-ascii?Q?y+9h1y094jjOpsp8af7oLplUzr9JuWDVDLu6em+hnW+OPX4rQvHViTIXEBv9?=
 =?us-ascii?Q?wCQRG+3RVLDhnM6wH+z5Ia8dLsCr6vG2xDC+HwOGSJIjjbiHvi6C0gz0hXxr?=
 =?us-ascii?Q?FcogfQTaCw+xSK1PnG2wsAYacyDZff4bUjkvQu1tIeaYmWHUJGSpVDf2MHo3?=
 =?us-ascii?Q?FFHTa7lku5BkDuDhbF8ihQvw58qsmU9e8zkJEuleNkdrAVvIcbsdX/XrE8Pl?=
 =?us-ascii?Q?5bn/FCdR1gkWFYBCorIO4VCaWGyLZVb7aY9IbaJkNWWsd5mK90a7psEwm96A?=
 =?us-ascii?Q?/LH/WN5KF0tmWyXPMeF/H+CBhrUP4Ba3gtiatAjM9csj1bF1OcPkGX+HxVpG?=
 =?us-ascii?Q?S0/hsDu3B0qpWBdY5bVhR1JNCkRBKLGQRUhjxPFLXs5cgeyt0JyxpK9hjBMm?=
 =?us-ascii?Q?TYdOh5mCCg9X42isYhoGFH4TIWI5yggmUdaI4L79D1zMwS7v4WWY5pqY8ItK?=
 =?us-ascii?Q?OM4DQgSbtquw3JJSWNE5yz4d0V9u0Hio8a0i50n8FeiQv1GVkaKiKNQXMTbG?=
 =?us-ascii?Q?LaScA7zJtIi4lOvAC1Wq+KTBQBFoWoVos/1ZM37RGsLiU7g6Vp0fBYQexmag?=
 =?us-ascii?Q?T0mzDL598ZrogCRpavmNr7FrSgGW/9CLnwlCAL33vkwLV56bamFXY2OplSzN?=
 =?us-ascii?Q?+C1AUJO6gnwojOh8m9kVnv5qRezgSYBKXFisvJMz7gtiJFDzbH0RUT9djbXc?=
 =?us-ascii?Q?jvfQxf3dXie2uUFbap0eObTc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc940df1-318a-41be-a5e1-08d91b0608a4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 20:38:18.1175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lm5KsepS3JZOzp36vtaUgakl6SCyIKz+Q4g23Sxkvvf+IzIT87gmKb4ZCdrL8sRWFr1VQbXP8mnscICXXvGh5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  17 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 126 ++++++++++++++++-------
 2 files changed, 92 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3147c1c935c8..b92eb068be12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -269,6 +269,7 @@ struct amdgpu_irq_src;
 struct amdgpu_fpriv;
 struct amdgpu_bo_va_mapping;
 struct amdgpu_atif;
+struct amdgpu_atcs;
 struct kfd_vm_fault_info;
 struct amdgpu_hive_info;
 struct amdgpu_reset_context;
@@ -685,20 +686,6 @@ struct amdgpu_vram_scratch {
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
@@ -829,7 +816,7 @@ struct amdgpu_device {
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper     debugfs_vbios_blob;
 	struct amdgpu_atif		*atif;
-	struct amdgpu_atcs		atcs;
+	struct amdgpu_atcs		*atcs;
 	struct mutex			srbm_mutex;
 	/* GRBM index mutex. Protects concurrent access to GRBM index */
 	struct mutex                    grbm_idx_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index bf2939b6eb43..cc8bf2ac77d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -71,12 +71,25 @@ struct amdgpu_atif {
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
@@ -236,6 +249,35 @@ static acpi_handle amdgpu_atif_probe_handle(acpi_handle dhandle)
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
@@ -485,14 +527,15 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
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
@@ -516,7 +559,7 @@ static union acpi_object *amdgpu_atcs_call(acpi_handle handle, int function,
 		atcs_arg_elements[1].integer.value = 0;
 	}
 
-	status = acpi_evaluate_object(handle, "ATCS", &atcs_arg, &buffer);
+	status = acpi_evaluate_object(atcs->handle, "ATCS", &atcs_arg, &buffer);
 
 	/* Fail only if calling the method fails and ATIF is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
@@ -550,7 +593,6 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
 /**
  * amdgpu_atcs_verify_interface - verify ATCS
  *
- * @handle: acpi handle
  * @atcs: amdgpu atcs struct
  *
  * Execute the ATCS_FUNCTION_VERIFY_INTERFACE ATCS function
@@ -558,15 +600,14 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
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
 
@@ -603,8 +644,10 @@ static int amdgpu_atcs_verify_interface(acpi_handle handle,
  */
 bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev)
 {
-	struct amdgpu_atcs *atcs = &adev->atcs;
+	struct amdgpu_atcs *atcs = adev->atcs;
 
+	if (!atcs)
+		return false;
 	if (atcs->functions.pcie_perf_req && atcs->functions.pcie_dev_rdy)
 		return true;
 
@@ -622,19 +665,15 @@ bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *ade
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
 
@@ -657,21 +696,18 @@ int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)
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
@@ -691,7 +727,7 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
 	params.pointer = &atcs_input;
 
 	while (retry--) {
-		info = amdgpu_atcs_call(handle, ATCS_FUNCTION_PCIE_PERFORMANCE_REQUEST, &params);
+		info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_PCIE_PERFORMANCE_REQUEST, &params);
 		if (!info)
 			return -EIO;
 
@@ -767,32 +803,26 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
  */
 int amdgpu_acpi_init(struct amdgpu_device *adev)
 {
-	acpi_handle handle, atif_handle;
+	acpi_handle handle, atif_handle, atcs_handle;
 	struct amdgpu_atif *atif;
-	struct amdgpu_atcs *atcs = &adev->atcs;
+	struct amdgpu_atcs *atcs;
 	int ret;
 
 	/* Get the device handle */
 	handle = ACPI_HANDLE(&adev->pdev->dev);
 
-	if (!adev->bios || !handle)
+	if (!adev->bios)
 		return 0;
 
-	/* Call the ATCS method */
-	ret = amdgpu_atcs_verify_interface(handle, atcs);
-	if (ret) {
-		DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
-	}
-
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
 
@@ -801,7 +831,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	if (ret) {
 		DRM_DEBUG_DRIVER("Call to ATIF verify_interface failed: %d\n", ret);
 		kfree(atif);
-		goto out;
+		goto atcs;
 	}
 	adev->atif = atif;
 
@@ -810,7 +840,8 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 		if (amdgpu_device_has_dc_support(adev)) {
 #if defined(CONFIG_DRM_AMD_DC)
 			struct amdgpu_display_manager *dm = &adev->dm;
-			atif->bd = dm->backlight_dev;
+			if (dm->backlight_dev)
+				atif->bd = dm->backlight_dev;
 #endif
 		} else {
 			struct drm_encoder *tmp;
@@ -862,6 +893,28 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 		atif->backlight_caps.caps_valid = false;
 	}
 
+atcs:
+	/* Probe for ATCS, and initialize it if found */
+	atcs_handle = amdgpu_atcs_probe_handle(handle);
+	if (!atcs_handle)
+		goto out;
+
+	atcs = kzalloc(sizeof(*atcs), GFP_KERNEL);
+	if (!atif) {
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
@@ -892,6 +945,7 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
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
