Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF36C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 03:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5494A61378
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 03:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5494A61378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DABA6EB79;
	Wed, 26 May 2021 03:23:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 381216EB78
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 03:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMqFTE15OFQzeT9mBnzEkPwNt40sSzJo2tMacBL8o73U/V4WPXLlkgvfcpz4rvdwee6JNAF0kT9qGeqz+BDWdMSe2EzCA6DYNgevV+OVAXb97OKooYA733DJE5NpkaZil957KM4UeYrtMjDTQ/IVW1YJV8RWO00oR7lTEbhRA59h2roMBBXts48h2n4F3xG/R8ndTdphStk8ZL3Caf70I6GgMn3Anpzs6vAb1UYhZ4UdfmV+rQnapG29CwFJ2apiFBNY9NBWSF98om+gLvCeBRCpGUBmwlfOzGqFjfVqnswikHlBt4fCI4662S6Y87qFpdJFaCduIHbrxMI2PJE7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crSmUjWuleg1rWgAcjmMH1cNsnRuZJ4tj/ddM9RLRro=;
 b=Hs+wtyh0xkitpF4bpORDzoFQNW/g1nqg/D4I+jFQiGjPeFoZ8ci8EnE8NlKMZvs2KMmT03bmJ5bGs7+zULWGCWr0sqJEOce5dBOiiitrsXXOCofBIV9/lfMmVUuuxZ8Z7uZblMnr7ZoaicFZOZGnPuSdKPzznajS3ylombW7UrO2iGMefRUBy7DkbUbI2+5ir8CX47KuGANLH4n+m0wYsnlYuKwDI1zh7wYqkD+WQipCLmY6cd7+ANQZ5n2K91o+GUPtOiJry4YZ3X+/ho+VKJj5hjQ395mpKPcWP/2B6JbSTUZzuEhta5TOT25gIMmsPhr4pO0nCE0vOEhKN8IAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crSmUjWuleg1rWgAcjmMH1cNsnRuZJ4tj/ddM9RLRro=;
 b=Ih+9CHpG3MDRs/czvlVNsUv0ZHgemtRmFkaUSc7DeXnnvGWcpihE9dx2vd+gvrHhMg7ECwf8lfp6ue297SLKYsNJD+vlGH46EvAxrOc7EMQoK15SWjUeLpIjuL6R1kc/CwA7A5P3lnhc1y5y9mEmy0KwvBg9MAzD5m0sGCOLGAs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 03:22:54 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5%4]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 03:22:54 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/acpi: make ATPX/ATCS structures global
Date: Tue, 25 May 2021 23:22:33 -0400
Message-Id: <20210526032233.1260674-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526032233.1260674-1-alexander.deucher@amd.com>
References: <20210526032233.1260674-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:207:3c::34) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:207:3c::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 03:22:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1644fe48-b1ae-40d6-1295-08d91ff58cfa
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB404630BBF354FDCC77A09DC3F7249@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkuYBGzxr67KoPp60d29FsNkHxspN4nUe7ijl6kIGIScWzplHxl9sRjmRO8QEvCNBG9AR62jOzk8+t9oZuI1ao6f0ANV0wDNGSHG/XM8MMb7aiTEE0qZzZSej7BZISXmDrI3mF/nh+ef8Idbl52Kyb7QTs+kcq6EE43wg0aBgIN0GSuNRXakXxOgyc5tGpRjyVm6f2c8TeNRWWfjHbDth00cTVwf8qJJjIdjv/okdAm9c/UhxIDUJxnXaKxSV7XFaWRUR7fi2Qgd/jfrxyvffZIc/CuY6Vcrn6QBTKZW3rh2ELLbUlr2YVNjAB146O8K3Zg3Uruh03apjZZlzAcFZwt6l5NWWdSmqYbzzcglQGqe/wtGuWtfJiPt5SMbeh3pG/2RNIIZd7jbof4TJ+MH1LXiIQTggj/0foaG/bDA0xf7wf0v7sJC80faw5N4k4xkn6162LEd5t1lj0fGcNfdl2+vqcDxZCNM8lxHNaEGFLtYJvwqc1fcZ7fNBryY0ejGbMce76P+duFEj/oLbLtkztgqhYZVKtna71gXIlLrvj149t8tMrPKxI+vdL8/h2lngIYoKpBsBWPsJaPOhDAgC/d9kHE+oyx8t6GkSRhiM3gP4Yi1Nycuj68T+ITkSQEKmj6H8mOs7+ZvJ7SjEToLipiV0AF77suXHyygPpSiZyr4/QWKHbSkPDpBZdQ8IJlO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(16526019)(186003)(38100700002)(38350700002)(956004)(2616005)(7696005)(52116002)(26005)(6666004)(6486002)(36756003)(6916009)(86362001)(8936002)(4326008)(8676002)(2906002)(1076003)(30864003)(66556008)(66476007)(66946007)(5660300002)(83380400001)(316002)(478600001)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oeknNB4Wyga1tKpisrbCIlqVti78ob+ZoyNAK0zWBC5LJxpDBrM9l30oiuwq?=
 =?us-ascii?Q?kTXde23A4AGnvZsTU23AVwstmNB+4jXi231W76W8jfVrEA6pGQDxjULGJHe/?=
 =?us-ascii?Q?55+E09MZGdHPnOEZ7V5A5ZHWuhMrU801mCNbJnmelQJowniqbUyPCbG7j3qc?=
 =?us-ascii?Q?aoq97nApnfWtNeoXlUZFYZL+Ez7Yesx+C6+IvM9LzMXEwfGXiNWNAHLv+MgI?=
 =?us-ascii?Q?V64KLNRlaUuchcz6dCv/oP5krMFHJ8MQ2Yw/WvjGpZyu5ERYpn2lQI3x6A4I?=
 =?us-ascii?Q?4TcJGIB/MHdMEFrMp5vsHdi21wHKt+eOd46IXlRX2L91sH2e8EUpNXbi2o7T?=
 =?us-ascii?Q?uWuJa5sFIX0FqfT5FmLedvyHEUhSaXJWvhqHx/T+DVg3rrnddzQzHchtfR81?=
 =?us-ascii?Q?u4qWl6M2VxQyhkWGUHM4fbONS27GSwk2TEXvwWfnlZ7DSBqtmtWodxFWoy2w?=
 =?us-ascii?Q?A/dFUfcklca9AinkHplVoNc7OrN2ACCM3cqOyHgi+qZC4tSutFqm90BOWSYP?=
 =?us-ascii?Q?NeAQDz4al1DN27kwKnuKTac/dWGx1lBP5m+huI6Sa/0rBPQcb0H8ewppcIxR?=
 =?us-ascii?Q?0xeuYNQQW4/hYJ5xYIjwVgRL+kUZ8cdna/dA1Vcx5RinfhGRnzWWGd8Gmzao?=
 =?us-ascii?Q?cbvbBTHnGMnE/tjkLQtAl2bjbdeOe/JUVMBVzODKL9TFx3z6AvmlnPv/TKVJ?=
 =?us-ascii?Q?1C+BQYIrqzUC2+PKnihzxtk1DRYO2X0SEYwwlr131WgQ/6KHs4RTYd0Y/r+3?=
 =?us-ascii?Q?GKvn94LAH37x7tydtAfZY9w8GdsG3mYfTWooHjRHKU3m7xRQDowDpgc5Riv9?=
 =?us-ascii?Q?Jm1AVXsSAwQ3LnFOanjuDqvdx5PEZxWUoZ9x+X2rEuaOhpBnegNLQDSNr+Ov?=
 =?us-ascii?Q?qirVjNtU2sNco3QkoS+kCTYGxVqyeZqLMt/ACuTVVXQqeu3HlwMDlFpxO9hu?=
 =?us-ascii?Q?UYgbjWPi0NMIIgJqhidaKnD4qZsyVHefbwDgLggwgA0A7OIQI/dHrUKbyMm0?=
 =?us-ascii?Q?IKVPn+9wbFJB3sJfBX0PPYI+CRlpwLIa/7JfWlasWE+fZOKdRWpaaIAZ0gR1?=
 =?us-ascii?Q?SWc/P12tcikOn444kabG/B/Imb4zmNxldgxOwZzxcXwsJnCX9/ykxtxrxh5B?=
 =?us-ascii?Q?uTCjugLIOml2ZpP9TEZMpQjKp74i7KjTKX9fFWatKz5YOqNM2MBekFC5lDVE?=
 =?us-ascii?Q?sfcoGlZWalH4tB8i+K2tuhDv67YeCVCytEqRZlHdJ1gDbNOC38SZATr3AnDj?=
 =?us-ascii?Q?ooQiWVr5+fq6QDav/lzoOoJw0gjfi+EClC1zUkOvM39+qZ5/u88WpbC9PN1U?=
 =?us-ascii?Q?UwBeZr0oR2XbRyABYBpyZcG8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1644fe48-b1ae-40d6-1295-08d91ff58cfa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 03:22:54.5260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZnYrtvnvzE5sFVHD2imqarJ4oz9vgUZzUtVbLG60D1TzzT7FpGbUImA3mCKRNpgWqVeqh9pIkvGjIGWnc6R6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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

They are global ACPI methods, so maybe the structures
global in the driver. This simplified a number of things
in the handling of these methods.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      | 285 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 4 files changed, 136 insertions(+), 161 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8f44486dc9ad..b332dd9f63ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -268,8 +268,6 @@ struct amdgpu_job;
 struct amdgpu_irq_src;
 struct amdgpu_fpriv;
 struct amdgpu_bo_va_mapping;
-struct amdgpu_atif;
-struct amdgpu_atcs;
 struct kfd_vm_fault_info;
 struct amdgpu_hive_info;
 struct amdgpu_reset_context;
@@ -815,8 +813,6 @@ struct amdgpu_device {
 	struct notifier_block		acpi_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper     debugfs_vbios_blob;
-	struct amdgpu_atif		*atif;
-	struct amdgpu_atcs		*atcs;
 	struct mutex			srbm_mutex;
 	/* GRBM index mutex. Protects concurrent access to GRBM index */
 	struct mutex                    grbm_idx_mutex;
@@ -1351,13 +1347,14 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
 						u8 perf_req, bool advertise);
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
 
-void amdgpu_acpi_get_backlight_caps(struct amdgpu_device *adev,
-		struct amdgpu_dm_backlight_caps *caps);
+void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
 bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev);
+void amdgpu_acpi_detect(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
 static inline bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev) { return false; }
+void amdgpu_acpi_detect(void) { }
 #endif
 
 int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 2195e24acb69..0594aa0377c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -84,6 +84,11 @@ struct amdgpu_atcs {
 	struct amdgpu_atcs_functions functions;
 };
 
+static struct amdgpu_acpi_priv {
+	struct amdgpu_atif atif;
+	struct amdgpu_atcs atcs;
+} amdgpu_acpi_priv;
+
 /* Call the ATIF method
  */
 /**
@@ -220,62 +225,6 @@ static int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
 	return err;
 }
 
-static acpi_handle amdgpu_atif_probe_handle(acpi_handle dhandle)
-{
-	acpi_handle handle = NULL;
-	char acpi_method_name[255] = { 0 };
-	struct acpi_buffer buffer = { sizeof(acpi_method_name), acpi_method_name };
-	acpi_status status;
-
-	/* For PX/HG systems, ATIF and ATPX are in the iGPU's namespace, on dGPU only
-	 * systems, ATIF is in the dGPU's namespace.
-	 */
-	if (amdgpu_has_atpx()) {
-		status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATIF",
-					 &handle);
-		if (ACPI_SUCCESS(status))
-			goto out;
-	}
-	status = acpi_get_handle(dhandle, "ATIF", &handle);
-	if (ACPI_SUCCESS(status))
-		goto out;
-
-	DRM_DEBUG_DRIVER("No ATIF handle found\n");
-	return NULL;
-out:
-	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-	DRM_DEBUG_DRIVER("Found ATIF handle %s\n", acpi_method_name);
-	return handle;
-}
-
-static acpi_handle amdgpu_atcs_probe_handle(acpi_handle dhandle)
-{
-	acpi_handle handle = NULL;
-	char acpi_method_name[255] = { 0 };
-	struct acpi_buffer buffer = { sizeof(acpi_method_name), acpi_method_name };
-	acpi_status status;
-
-	/* For PX/HG systems, ATCS and ATPX are in the iGPU's namespace, on dGPU only
-	 * systems, ATIF is in the dGPU's namespace.
-	 */
-	if (amdgpu_has_atpx()) {
-		status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATCS",
-					 &handle);
-		if (ACPI_SUCCESS(status))
-			goto out;
-	}
-	status = acpi_get_handle(dhandle, "ATCS", &handle);
-	if (ACPI_SUCCESS(status))
-		goto out;
-
-	DRM_DEBUG_DRIVER("No ATCS handle found\n");
-	return NULL;
-out:
-	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-	DRM_DEBUG_DRIVER("Found ATCS handle %s\n", acpi_method_name);
-	return handle;
-}
-
 /**
  * amdgpu_atif_get_notification_params - determine notify configuration
  *
@@ -454,7 +403,7 @@ static int amdgpu_atif_get_sbios_requests(struct amdgpu_atif *atif,
 static int amdgpu_atif_handler(struct amdgpu_device *adev,
 			       struct acpi_bus_event *event)
 {
-	struct amdgpu_atif *atif = adev->atif;
+	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 	int count;
 
 	DRM_DEBUG_DRIVER("event, device_class = %s, type = %#x\n",
@@ -464,8 +413,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 		return NOTIFY_DONE;
 
 	/* Is this actually our event? */
-	if (!atif ||
-	    !atif->notification_cfg.enabled ||
+	if (!atif->notification_cfg.enabled ||
 	    event->type != atif->notification_cfg.command_code) {
 		/* These events will generate keypresses otherwise */
 		if (event->type == ACPI_VIDEO_NOTIFY_PROBE)
@@ -642,10 +590,8 @@ static int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
  */
 bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev)
 {
-	struct amdgpu_atcs *atcs = adev->atcs;
+	struct amdgpu_atcs *atcs = &amdgpu_acpi_priv.atcs;
 
-	if (!atcs)
-		return false;
 	if (atcs->functions.pcie_perf_req && atcs->functions.pcie_dev_rdy)
 		return true;
 
@@ -664,10 +610,8 @@ bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *ade
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)
 {
 	union acpi_object *info;
-	struct amdgpu_atcs *atcs = adev->atcs;
+	struct amdgpu_atcs *atcs = &amdgpu_acpi_priv.atcs;
 
-	if (!atcs)
-		return -EINVAL;
 	if (!atcs->functions.pcie_dev_rdy)
 		return -EINVAL;
 
@@ -695,16 +639,13 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
 					 u8 perf_req, bool advertise)
 {
 	union acpi_object *info;
-	struct amdgpu_atcs *atcs = adev->atcs;
+	struct amdgpu_atcs *atcs = &amdgpu_acpi_priv.atcs;
 	struct atcs_pref_req_input atcs_input;
 	struct atcs_pref_req_output atcs_output;
 	struct acpi_buffer params;
 	size_t size;
 	u32 retry = 3;
 
-	if (!atcs)
-		return -EINVAL;
-
 	if (amdgpu_acpi_pcie_notify_device_ready(adev))
 		return -EINVAL;
 
@@ -801,37 +742,7 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
  */
 int amdgpu_acpi_init(struct amdgpu_device *adev)
 {
-	acpi_handle handle, atif_handle, atcs_handle;
-	struct amdgpu_atif *atif;
-	struct amdgpu_atcs *atcs;
-	int ret = 0;
-
-	/* Get the device handle */
-	handle = ACPI_HANDLE(&adev->pdev->dev);
-
-	if (!adev->bios || !handle)
-		return ret;
-
-	/* Probe for ATIF, and initialize it if found */
-	atif_handle = amdgpu_atif_probe_handle(handle);
-	if (!atif_handle)
-		goto atcs;
-
-	atif = kzalloc(sizeof(*atif), GFP_KERNEL);
-	if (!atif) {
-		DRM_WARN("Not enough memory to initialize ATIF\n");
-		goto atcs;
-	}
-	atif->handle = atif_handle;
-
-	/* Call the ATIF method */
-	ret = amdgpu_atif_verify_interface(atif);
-	if (ret) {
-		DRM_DEBUG_DRIVER("Call to ATIF verify_interface failed: %d\n", ret);
-		kfree(atif);
-		goto atcs;
-	}
-	adev->atif = atif;
+	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
 	if (atif->notifications.brightness_change) {
@@ -861,6 +772,126 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 		}
 	}
 #endif
+	adev->acpi_nb.notifier_call = amdgpu_acpi_event;
+	register_acpi_notifier(&adev->acpi_nb);
+
+	return 0;
+}
+
+void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)
+{
+	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
+
+	caps->caps_valid = atif->backlight_caps.caps_valid;
+	caps->min_input_signal = atif->backlight_caps.min_input_signal;
+	caps->max_input_signal = atif->backlight_caps.max_input_signal;
+}
+
+/**
+ * amdgpu_acpi_fini - tear down driver acpi support
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Unregisters with the acpi notifier chain (all asics).
+ */
+void amdgpu_acpi_fini(struct amdgpu_device *adev)
+{
+	unregister_acpi_notifier(&adev->acpi_nb);
+}
+
+/**
+ * amdgpu_atif_pci_probe_handle - look up the ATIF handle
+ *
+ * @pdev: pci device
+ *
+ * Look up the ATIF handles (all asics).
+ * Returns true if the handle is found, false if not.
+ */
+static bool amdgpu_atif_pci_probe_handle(struct pci_dev *pdev)
+{
+	char acpi_method_name[255] = { 0 };
+	struct acpi_buffer buffer = {sizeof(acpi_method_name), acpi_method_name};
+	acpi_handle dhandle, atif_handle;
+	acpi_status status;
+	int ret;
+
+	dhandle = ACPI_HANDLE(&pdev->dev);
+	if (!dhandle)
+		return false;
+
+	status = acpi_get_handle(dhandle, "ATIF", &atif_handle);
+	if (ACPI_FAILURE(status)) {
+		return false;
+	}
+	amdgpu_acpi_priv.atif.handle = atif_handle;
+	acpi_get_name(amdgpu_acpi_priv.atif.handle, ACPI_FULL_PATHNAME, &buffer);
+	DRM_DEBUG_DRIVER("Found ATIF handle %s\n", acpi_method_name);
+	ret = amdgpu_atif_verify_interface(&amdgpu_acpi_priv.atif);
+	if (ret)
+		return false;
+	return true;
+}
+
+/**
+ * amdgpu_atcs_pci_probe_handle - look up the ATCS handle
+ *
+ * @pdev: pci device
+ *
+ * Look up the ATCS handles (all asics).
+ * Returns true if the handle is found, false if not.
+ */
+static bool amdgpu_atcs_pci_probe_handle(struct pci_dev *pdev)
+{
+	char acpi_method_name[255] = { 0 };
+	struct acpi_buffer buffer = { sizeof(acpi_method_name), acpi_method_name };
+	acpi_handle dhandle, atcs_handle;
+	acpi_status status;
+	int ret;
+
+	dhandle = ACPI_HANDLE(&pdev->dev);
+	if (!dhandle)
+		return false;
+
+	status = acpi_get_handle(dhandle, "ATCS", &atcs_handle);
+	if (ACPI_FAILURE(status)) {
+		return false;
+	}
+	amdgpu_acpi_priv.atcs.handle = atcs_handle;
+	acpi_get_name(amdgpu_acpi_priv.atcs.handle, ACPI_FULL_PATHNAME, &buffer);
+	DRM_DEBUG_DRIVER("Found ATCS handle %s\n", acpi_method_name);
+	ret = amdgpu_atcs_verify_interface(&amdgpu_acpi_priv.atcs);
+	if (ret)
+		return false;
+	return true;
+}
+
+/*
+ * amdgpu_acpi_detect - detect ACPI ATIF/ATCS methods
+ *
+ * Check if we have the ATIF/ATCS methods and populate
+ * the structures in the driver.
+ */
+void amdgpu_acpi_detect(void)
+{
+	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
+	bool has_atif = false;
+	bool has_atcs = false;
+	struct pci_dev *pdev = NULL;
+	int ret;
+
+	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
+		if (!has_atif)
+			has_atif = amdgpu_atif_pci_probe_handle(pdev);
+		if (!has_atcs)
+			has_atcs = amdgpu_atcs_pci_probe_handle(pdev);
+	}
+
+	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
+		if (!has_atif)
+			has_atif = amdgpu_atif_pci_probe_handle(pdev);
+		if (!has_atcs)
+			has_atcs = amdgpu_atcs_pci_probe_handle(pdev);
+	}
 
 	if (atif->functions.sbios_requests && !atif->functions.system_params) {
 		/* XXX check this workraround, if sbios request function is
@@ -890,60 +921,6 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	} else {
 		atif->backlight_caps.caps_valid = false;
 	}
-
-atcs:
-	/* Probe for ATCS, and initialize it if found */
-	atcs_handle = amdgpu_atcs_probe_handle(handle);
-	if (!atcs_handle)
-		goto out;
-
-	atcs = kzalloc(sizeof(*atcs), GFP_KERNEL);
-	if (!atcs) {
-		DRM_WARN("Not enough memory to initialize ATCS\n");
-		goto out;
-	}
-	atcs->handle = atcs_handle;
-
-	/* Call the ATCS method */
-	ret = amdgpu_atcs_verify_interface(atcs);
-	if (ret) {
-		DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
-		kfree(atcs);
-		goto out;
-	}
-	adev->atcs = atcs;
-
-out:
-	adev->acpi_nb.notifier_call = amdgpu_acpi_event;
-	register_acpi_notifier(&adev->acpi_nb);
-
-	return ret;
-}
-
-void amdgpu_acpi_get_backlight_caps(struct amdgpu_device *adev,
-		struct amdgpu_dm_backlight_caps *caps)
-{
-	if (!adev->atif) {
-		caps->caps_valid = false;
-		return;
-	}
-	caps->caps_valid = adev->atif->backlight_caps.caps_valid;
-	caps->min_input_signal = adev->atif->backlight_caps.min_input_signal;
-	caps->max_input_signal = adev->atif->backlight_caps.max_input_signal;
-}
-
-/**
- * amdgpu_acpi_fini - tear down driver acpi support
- *
- * @adev: amdgpu_device pointer
- *
- * Unregisters with the acpi notifier chain (all asics).
- */
-void amdgpu_acpi_fini(struct amdgpu_device *adev)
-{
-	unregister_acpi_notifier(&adev->acpi_nb);
-	kfree(adev->atif);
-	kfree(adev->atcs);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 877469d288f8..cce7e8e31883 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1801,6 +1801,7 @@ static int __init amdgpu_init(void)
 
 	DRM_INFO("amdgpu kernel modesetting enabled.\n");
 	amdgpu_register_atpx_handler();
+	amdgpu_acpi_detect();
 
 	/* Ignore KFD init failures. Normal when CONFIG_HSA_AMD is not set. */
 	amdgpu_amdkfd_init();
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e9b72e601cee..07f522af62f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3415,7 +3415,7 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
 	if (dm->backlight_caps.caps_valid)
 		return;
 
-	amdgpu_acpi_get_backlight_caps(dm->adev, &caps);
+	amdgpu_acpi_get_backlight_caps(&caps);
 	if (caps.caps_valid) {
 		dm->backlight_caps.caps_valid = true;
 		if (caps.aux_support)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
