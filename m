Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA45CD98C5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 05:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE7A10E1AF;
	Mon, 15 Jun 2026 05:20:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ILl3N0Zi";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013025.outbound.protection.outlook.com
 [40.93.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0176D10E1AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 05:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdLyNPidEfFXkaRrzK/KjrcoaHsGfARtr3fbsTNIOm/1qxQJ9zFRjGUJqCEFnYdxN74vHJhIErZZJr2PBllNvosIn7gLobgluy+Ie+kcV82UOWRoLJce3f68sRK2j3Xe4J+zILfI3RK2pyuPrd+B0PnWwDA14DAYYso6IMcDbJbsRvnh6V1d4f53tagO/1uBhjGj1ADBeyoWs3ORcj+AGpvaM6kEVKVXY8uzgG7pPKvJg9yzvdwCxnm0yVFYyOW7cW49vIjBggxl1BRX+BWNwTKYzvIHK5oDJrUkI/T6+68BIPX9g1nPjUcUiF77dHl2RDosP5sSG/wWDeBIMDTV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSOwftWcukAbZIF3Y6PTqLnUo2/2u0LVhlLFL9i6EnE=;
 b=Tpo5nxMsMcIb3b1gYvk6WgF8TaAt+XCzJu45rbon8DCKukJFYmEzbP19fcNk0+lVzBJ7pf2c2PXzqDhdJVb7CmOnD0EsmUIL36Yp09xm92iQ4IJ3mGLuUQEEHlVw/UM4yyr9HkTy3ghmzQ2wwfzx/CJr/0iod/ern7boZKcwYDJlrNK+8k5a+7ZOKg9+jkSgKI/u46LYisWLpPhIrfITOiTQjk6IZZ93UaxCmZ/BrC45ywbZJkGs3ZQagOS2zDxEftHQmI5RMCCLBO8ObEqo/03gI2Wj5SgluyJkWhIi9vkHPj0lCQbe3j5sSa1xs/tg2vj8F+/5BAmaaMgtD/CRYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSOwftWcukAbZIF3Y6PTqLnUo2/2u0LVhlLFL9i6EnE=;
 b=ILl3N0ZisiTkU0JU1u60/G7VmhtBKmtpJBx9i8FBpVvubkDhoO8j6cdSVKmtVUVq9eg8BaOoaDfCDm0aIQxnF/BiZ0gMNYT+MKj04VbmFcbRKBI5rM+QAASPv3TuRWKvfGh5sbDar2YSZacPFpcw/8xg+clF2FUoLPlpIzvZ6XA=
Received: from MN2PR05CA0039.namprd05.prod.outlook.com (2603:10b6:208:236::8)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 05:20:50 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::a0) by MN2PR05CA0039.outlook.office365.com
 (2603:10b6:208:236::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Mon,
 15 Jun 2026 05:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 05:20:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 00:20:47 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <candice.li@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Validate ATIF buffer length before use
Date: Mon, 15 Jun 2026 10:50:29 +0530
Message-ID: <20260615052030.42134-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d9520d-8d52-4d9d-efa0-08deca9ddced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|56012099006|3023799007|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: SnJ1n1IEeVIuVIKL9pdfSanxKdmbo+ZGMCeMaNloC5jhKVppxVmFt8OaH9vjlCwxgLJroip42zvhG2ZcKUvYuISe+E2JRVxoQIV8/zLKfuhpLhDJJlFe9rVNp11BTw53aFInyeqxwjej5EMF5HzOfLSd5/ohcjF3BQ2hKh2o/9TCHPYbYUvskPxONM1x9yFokC6an9ajPXtwRWZcPjZN6gGgETYA0jYEwz4UN71lQJkmEK/VcB/Fpgo9dBQ4k9isaOjj07tk9746uQHYep0N1Kxaj4zILUajKYJK8l9Lqce0jI54jEggA/Q9ZWoi/MtGdL80dQkV63QVgiJGE8mtjLwiBLoTB8Uc6Cd0xFmjUh/loSawhrqmqae6nJyFXjMthjzWWcQEHIIBWxBY2OPU7M0mXaO8r0rfq1pK3PSh7rsg1yocd+nL2f+lEkdaznGwiLETqa8yBGivoTTJw4k89M1HmNZmXlXJ56hOpKVbCF7g6CjieQBQizgoyUVfA7s7VACb0S6rjDlVwaCdkNd8PVtco1bhwr3q+uSzSygD0ei0Ri/OGOkdgdUlPJm7XLj1mnplKz4c1DpHMS5AV43fYJ7o6G/Q+hLprKaiew1Dn1a6FAjHdwlERbdmAd8SdBF92RcR2h6f/DVd2hnKUjwrXrSAXYKmVRx03M1vDyzW113iOckqdMZ12VTqmM07VGsrFIhYXBze01xj+yfHMd1CwWhN6JzL/hZh5bOtB7a/fdU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(56012099006)(3023799007)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vG16nFYjysg7JPILYZLlsa9grQWQTQtRDcpWbcUK2PeuNMSN2L3eSfY5wziOdHtJ0q2Y7lnLleyE0HesHZiBa7ouqvwX0zJN7Ya/DFC9PhyRC6lzC7d00kuLqRvEtunJIwAfEXvgKgc7u2MBAQGHhWvbXXfnXAZztn+yMpbMMyndjjM8ogHEwJbGY645L/gerDS07rAf1r7If+itOwda0HszFBIojrfJUSRMDUvAurzVwI5LOiHzpuXMHKMzxqjvv6A0f8FP+flkEsknzY88vKVYSBTds6vQiP3y8he63wK7TdmiEeRgUPmUg2LnkIR4H+DiZ9qbK1P7B+/tRVEeCr4dZU71h3++O7y2SJVe8wYz9Cx5loZ5ZevCp0HLW96DNsRPQvN/HOsSPHBL0+ORTdnc0Ww7QAFcWOjvx+3EuhgpY2pAGYgYWlNuGFvQ0FOd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 05:20:49.7936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d9520d-8d52-4d9d-efa0-08deca9ddced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a min_size parameter to amdgpu_atif_call() to validate that the
returned ACPI buffer is of type ACPI_TYPE_BUFFER, holds at least a u16
size field, does not claim more data than was actually returned, and
meets the minimum size required by the calling function. Each caller
passes its required minimum via sizeof() or offsetof() of the expected
output struct and drops its own size check.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Sonnet (Cursor AI)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 68 ++++++++++++------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 02d5abf9df2b..b133f50d82ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -140,13 +140,15 @@ static struct amdgpu_acpi_priv {
  * @atif: atif structure
  * @function: the ATIF function to execute
  * @params: ATIF function params
+ * @min_size: minimum size of the expected output buffer in bytes
  *
  * Executes the requested ATIF function (all asics).
  * Returns a pointer to the acpi output buffer.
  */
 static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 					   int function,
-					   struct acpi_buffer *params)
+					   struct acpi_buffer *params,
+					   size_t min_size)
 {
 	acpi_status status;
 	union acpi_object *obj;
@@ -189,6 +191,28 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 		return NULL;
 	}
 
+	if (obj->buffer.length < sizeof(u16)) {
+		DRM_DEBUG_DRIVER("ATIF buffer too small to hold size field: %u\n",
+				 obj->buffer.length);
+		kfree(obj);
+		return NULL;
+	}
+
+	if (obj->buffer.length < *(u16 *)obj->buffer.pointer) {
+		DRM_DEBUG_DRIVER("ATIF buffer length mismatch: reported %u, actual %u\n",
+				 *(u16 *)obj->buffer.pointer,
+				 obj->buffer.length);
+		kfree(obj);
+		return NULL;
+	}
+
+	if (*(u16 *)obj->buffer.pointer < min_size) {
+		DRM_DEBUG_DRIVER("ATIF buffer too small: expected %zu, got %u\n",
+				 min_size, *(u16 *)obj->buffer.pointer);
+		kfree(obj);
+		return NULL;
+	}
+
 	return obj;
 }
 
@@ -251,19 +275,14 @@ int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
 	size_t size;
 	int err = 0;
 
-	info = amdgpu_atif_call(atif, ATIF_FUNCTION_VERIFY_INTERFACE, NULL);
+	info = amdgpu_atif_call(atif, ATIF_FUNCTION_VERIFY_INTERFACE, NULL,
+				sizeof(output));
 	if (!info)
 		return -EIO;
 
 	memset(&output, 0, sizeof(output));
 
-	size = *(u16 *) info->buffer.pointer;
-	if (size < 12) {
-		DRM_INFO("ATIF buffer is too small: %zu\n", size);
-		err = -EINVAL;
-		goto out;
-	}
-	size = min(sizeof(output), size);
+	size = min(sizeof(output), (size_t)*(u16 *)info->buffer.pointer);
 
 	memcpy(&output, info->buffer.pointer, size);
 
@@ -273,7 +292,6 @@ int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
 	amdgpu_atif_parse_notification(&atif->notifications, output.notification_mask);
 	amdgpu_atif_parse_functions(&atif->functions, output.function_bits);
 
-out:
 	kfree(info);
 	return err;
 }
@@ -299,20 +317,14 @@ int amdgpu_atif_get_notification_params(struct amdgpu_atif *atif)
 	int err = 0;
 
 	info = amdgpu_atif_call(atif, ATIF_FUNCTION_GET_SYSTEM_PARAMETERS,
-				NULL);
+				NULL, offsetof(struct atif_system_params, command_code));
 	if (!info) {
 		err = -EIO;
 		goto out;
 	}
 
-	size = *(u16 *) info->buffer.pointer;
-	if (size < 10) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	memset(&params, 0, sizeof(params));
-	size = min(sizeof(params), size);
+	size = min(sizeof(params), (size_t)*(u16 *)info->buffer.pointer);
 	memcpy(&params, info->buffer.pointer, size);
 
 	DRM_DEBUG_DRIVER("SYSTEM_PARAMS: mask = %#x, flags = %#x\n",
@@ -376,20 +388,14 @@ int amdgpu_atif_query_backlight_caps(struct amdgpu_atif *atif)
 
 	info = amdgpu_atif_call(atif,
 		ATIF_FUNCTION_QUERY_BRIGHTNESS_TRANSFER_CHARACTERISTICS,
-		&params);
+		&params, offsetof(struct atif_qbtc_output, data_points));
 	if (!info) {
 		err = -EIO;
 		goto out;
 	}
 
-	size = *(u16 *) info->buffer.pointer;
-	if (size < 10) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	memset(&characteristics, 0, sizeof(characteristics));
-	size = min(sizeof(characteristics), size);
+	size = min(sizeof(characteristics), (size_t)*(u16 *)info->buffer.pointer);
 	memcpy(&characteristics, info->buffer.pointer, size);
 
 	atif->backlight_caps.caps_valid = true;
@@ -427,24 +433,18 @@ static int amdgpu_atif_get_sbios_requests(struct amdgpu_atif *atif,
 	int count = 0;
 
 	info = amdgpu_atif_call(atif, ATIF_FUNCTION_GET_SYSTEM_BIOS_REQUESTS,
-				NULL);
+				NULL, sizeof(*req));
 	if (!info)
 		return -EIO;
 
-	size = *(u16 *)info->buffer.pointer;
-	if (size < 0xd) {
-		count = -EINVAL;
-		goto out;
-	}
 	memset(req, 0, sizeof(*req));
 
-	size = min(sizeof(*req), size);
+	size = min(sizeof(*req), (size_t)*(u16 *)info->buffer.pointer);
 	memcpy(req, info->buffer.pointer, size);
 	DRM_DEBUG_DRIVER("SBIOS pending requests: %#x\n", req->pending);
 
 	count = hweight32(req->pending);
 
-out:
 	kfree(info);
 	return count;
 }
-- 
2.49.0

