Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEDEC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6997A611AE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6997A611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9AE86EE91;
	Wed, 19 May 2021 20:42:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A80E6EE91
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 20:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2OvI3jTOL3raTnzNkfLxT5FckGaPJm42++fNDnD12Q8oykTYLoxfzmoEJhtEJoqTUMmrrSbOHyCijKf8dHo+hwvk72MrvDuKfbAvRr29TGlKLMmZmQWXxkIeJUCOaE7KaGxEWK9AEZ7xffS9Kc9tZyMmvS9u1jfK4Q8ySVkmC5yIV8GJMzx+978a0TIJDHI2Pc2XZfFWx6TMM5TA8tHmrZlBvlehZchLsVkS20jQFSKm5x0E5nemZQe0aeo1Adc8EUItw+b3Tgmu2d/yMgen/MgdMJGxTsXHwcaZvrdLVqMJp/c+qpHdjel6Fg8BD4b07R75nbOfgONmT0maNnj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgHZQQsXF4QoslgqlPm8n/5Py8N3nG4RgY1jHSsIDG0=;
 b=QvSmub7sjwMJiUwfiBrBwdNt/LI/jGZjPU1YgbNZI09pgfOzMnvk9pTqUeP2tsPAkN1SyK05u042kU1FWUbXflxYLdihUKnzeW3m/X8zEWUgk+4KhpJdXCUCa+A5JKiHZZ79ks1lG71l4YKv1hWue8jvf5j2GA6BHZ1Uka6jEFTn9QW1IFv0H6U83uBHILYKlxFz6ZJP0zASxbTg3jiXRLpAUoqqOSQmycB0FIGwN05rRZBnSkCxAj99Nm/Qo5JCMUJ/dRS9RHu2OTL2LUFTxHl8/f+SDVyYYGkwtx1gtbM1v2vfWEykpcRJMYAnhzFu7EnIRGqt5DZHSYUjm/4YIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgHZQQsXF4QoslgqlPm8n/5Py8N3nG4RgY1jHSsIDG0=;
 b=2FYOFN1YrUzQ27xUtHKlOJ20kMBCxK3wWGO3mzBcMpptvaE2vfb40KKVP/DSXvyIP3yN70n3JVki+7t7Crk6VE4aGZUpAXjbkmPJftFy9B9jwyJin1SzNxC+poG1YrJ1O1kzx1abuwcNvwmQAhizc1E4W/nCfYmO7pT2y7xlXjI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 20:42:05 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 20:42:05 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/acpi: unify ATCS handling (v2)
Date: Wed, 19 May 2021 16:41:41 -0400
Message-Id: <20210519204141.2737262-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:208:257::23) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0048.namprd13.prod.outlook.com (2603:10b6:208:257::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend
 Transport; Wed, 19 May 2021 20:42:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c6ea2c3-7b11-43ce-fedf-08d91b069046
X-MS-TrafficTypeDiagnostic: MN2PR12MB4471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4471C4F8AB1FEEC5B2979437F72B9@MN2PR12MB4471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:43;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3aDopGLlvBixkCTWcA8tKxg7evv/32YqglA+wSSBdlrd/iSM6eBI19p0fo6FYssdtz5E6jDGhb68Rxdx0EFpIipDzULfcz1CxRpi5YhIVkvByuUf4q4UzdKpDWPWi8XmMCftBPzKnKtMGl6+DoyVNiPvarn/S2tnmgKhb9dBhwr9M9Fobg2s1juoDc07AIaxhP1D3N6f48cVvKNqu3DvZsCYBo5ViZ5pmK3Fz0T4J1rX8K2igd2p39ekGkIfr9TguPTWjEFPlPq48rDNYWdS/quNC8dEVDe7QqMJgvS+uaXPE3rr5Zk4cYcANpC8Re/Mh8uO0Brv0lULr+1HDtLmf9dzR8Go3JUNXLnjQPvMbMGvrHW219avHpUEJn+zZ0n2zLJlHKJbL6iZL3T2pdxm4+rwzoszM+/kS+owXdnXSYJl6tHi47RX/ESHfmDhpg+LQzD24bHqSc+Y90Pljw/hyykOrVd/QcBrliht/kNKXmCXQA329WqAhBA9GHd7qD1sdPwO/M4gcCacsbsCPpBJWbE/h9OHIfRKm9BIjzfG4KTckZLsR6x9pqnP6wJHHlPnze6a7Gy5T95rAsuGlDmv6aJl9Wrpt08QmE02CgrfDo1m57TDrCIgvRBqRzuOqzQu3+mgYUBQaXmNsPntshg2Lt6yMo7e8npO11DiFnoWKnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(36756003)(6486002)(316002)(478600001)(83380400001)(86362001)(52116002)(7696005)(8936002)(8676002)(26005)(16526019)(6666004)(1076003)(186003)(5660300002)(6916009)(956004)(2616005)(66556008)(66476007)(4326008)(2906002)(38100700002)(38350700002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UenmkaqFYY/jLqPaSYGu+iWuUHg3lVebb5zMMpVjTFU3XPTTZr3I4S/pEUic?=
 =?us-ascii?Q?sNveEm2OPUdtHij2DIRd42PxixYztDZL9+LhT+dkwASCNY+Wr3nUXA+dnRSV?=
 =?us-ascii?Q?kP3gzkSjCbMuxrSq/vupwEEIn9cmY8s7tRX9bKeoNtxrawIvro2w1Gww8N1u?=
 =?us-ascii?Q?7YuFP4kT+D2jdwjz19af+xRuWI5jeL4qdDNOURec1clmDn6z3/HjmOl8VmEQ?=
 =?us-ascii?Q?kMRz7eKV1uS/HNsNPHeiNQjheU3eVNw2IOeceBkmZ2NW5asN9RYcxObapJjA?=
 =?us-ascii?Q?qyZeViXkmMVEgy+BbMqvzw3BBlHzh6FwXL/cxi7X8ybCYsStpy3jQLyqe7eB?=
 =?us-ascii?Q?irwPoYTss4DLmgcGlThmWdnK9LQcVam1MA/5P1g125rcobK99vN72oOE4NJC?=
 =?us-ascii?Q?6NTRNNd69GVSBwTkOo66ul0rZIM6jIWuY2cHH9lwjzW4mdtAwyBq0Rek5hBs?=
 =?us-ascii?Q?trsqfBmqYXDOnSKNcb99BMh2WuFTpGEEbQ8FOst6v5slzKEcSr/dKI//+f88?=
 =?us-ascii?Q?CGl4nGbG3k8yI8T8N4nvuGdW8jEADkzWnD9MZvRB0n7A7yM/1BUyHobjhmrG?=
 =?us-ascii?Q?1SxhDl7aQHfKyoYzUxVZOhps8yOGw0yryM2FByTY31TMcGJpDcsKlyduELUy?=
 =?us-ascii?Q?h46p6PmuQxfUunIxtKBmhqVQp+aRy3qX19fc07BGPoAIAPfAvaaJvM7q2QJb?=
 =?us-ascii?Q?UncuC/wEHHwdP9OUBtobnwaUlV4DWzcVRL44Ix/tTLK8ZjZxLmQid5QKYIhn?=
 =?us-ascii?Q?vPEL7rT8QXF31ydDjpA05hh67uqUHZF96kbQxgngwiSF2x1UN4LXU4vD/wGO?=
 =?us-ascii?Q?LUELzYs0OV38zOMLJNq5rR524CuzqS1nJw3KH94I4e1c14neFsmKuVng4bt8?=
 =?us-ascii?Q?D+LmzIj43p3UJWdJ8Z3KBlHq8V9qQBth6DhbG/A9N3WTs4oyxP9s6SiArq/W?=
 =?us-ascii?Q?BjKWBLPSKBE4xtYFAb4IWe/O6+NvxC5SczEpqHMriq/6pL1hi46/+YkuEnas?=
 =?us-ascii?Q?fn/032Zm1KGi35hBwNY3lKGqwv7r+Fypc5UQ3MulzQdH/4PeynN1OtTOpqwf?=
 =?us-ascii?Q?QC/YV8O+I52zfRjYkxF9J7vL9Vg8i2cR14PB+a1SrcIxKhysB1VNalAZMA+t?=
 =?us-ascii?Q?oC11B4VMQJspnzRlCWlvf4w9yZFuOIokq6bdF65wCh09ohoXxu9Lz8UsK+SJ?=
 =?us-ascii?Q?2N09OSIT274Gh1FMlRuEXl394COVjMnnoxSjoeX4u3ywB3Rukq6boI59aKwU?=
 =?us-ascii?Q?IyyXWohrMtV64hcIxl3hIg0Fx0pL6O9CdgeiT4PuUwrI1HS5xnHMgKZJuT3L?=
 =?us-ascii?Q?m+VBmA1DE4ICueaK464X5a7n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6ea2c3-7b11-43ce-fedf-08d91b069046
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 20:42:05.8192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5x13fiFfj0Fqg6xJqhS9MeSJ+oEYeV0DkD94QdvoYK8A9LG7KoyV+nI26xCP/y71WDzlDhDbVN0UkQWonO/GmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  17 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 124 ++++++++++++++++-------
 2 files changed, 91 insertions(+), 50 deletions(-)

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
index bf2939b6eb43..93f5207104ec 100644
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
 
@@ -767,9 +803,9 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
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
@@ -778,21 +814,15 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	if (!adev->bios || !handle)
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
