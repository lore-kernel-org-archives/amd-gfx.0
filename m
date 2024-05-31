Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F94C27C44
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B7410EA42;
	Fri, 31 May 2024 06:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gkb8gMUc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFA4810EA42
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3dI9caIHLV1G92KUs7iamErqoFUxv6GD+RYyh9yaP+DOaTN9YsQXsGoKe7oD+IN0Kiaorx39JKhfjIxcwHjYc4oTZQFsUwlo0J982/wlzHp0ixm3hpw9hjlmySGabTT7Q+3mQvQnF85udVsiutNUL73oc7zvoKh0xAnnNjTrttOFQfa5VHWa4IwrFvbgnzUKuDqb68qCwkuR7yJVR20BgFhpstKTy8yedkqFzWELytWupisb72ALXgQ7b2sGkysFTYWubmj2FhiETqtb9WUz9LZuQzEbhyZpa0Ilo4HDjP/u7gne73baZ+qmayzXmo8SswFFuBlK//g7TUgl1hJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJDfLknjyD6SHaThwK7PmYxKscn5TLmfLqihKgYrPro=;
 b=fRlP3oE+IPDTHvmnhSCMyEghno1h/h6dZqdzWYa7rVDD8v93rKCcST0ciK2iP4kFCzozKPZP8tCmLLiS/Bj0aboPIE4AM46S2fHOgw6kXndqkG7qj8HPpXILBHeKxo/5QO6ZkV1W/9e9NYH+vcCPInCN/K8SbjemhspLM3hAqD2UnKeqbuFMXJpiTTMPj6fJvnxaCtmI/XRjNM1ulqSGAp4oScU+GTZa7+0rjEdlul6ytLVrcl27oRLhHKoB8HYIRY4LJ0l3yjy6kzbos5L2GO6oHRQzYj2mW7JQP70FoSexmaYmbrEpn8xb9R9wrnPPlHJEBHyierQEDrK9/Xog8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJDfLknjyD6SHaThwK7PmYxKscn5TLmfLqihKgYrPro=;
 b=Gkb8gMUcJAXzzT076WOWP1pbetHy0xSM2nUK1dMZkoZMiEi2dzG0DuKk96tii/AYcwRWsXgrlMoYlrsBMSQ4ebDRuHi38M7nizhiLu++MLpNEqt5k/PQ7LoWLVWumz35eK5VKwSG6VA/3Rlvsp3NYN4Al5zyv2s7OT5M5U9VACs=
Received: from BYAPR05CA0066.namprd05.prod.outlook.com (2603:10b6:a03:74::43)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 31 May
 2024 06:53:04 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::f2) by BYAPR05CA0066.outlook.office365.com
 (2603:10b6:a03:74::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.7 via Frontend
 Transport; Fri, 31 May 2024 06:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:04 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:52:59 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 01/18] drm/amdgpu: enhance amdgpu_ucode_request() function
 flexibility
Date: Fri, 31 May 2024 14:52:32 +0800
Message-ID: <20240531065249.1746350-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 7540a4bf-6290-4a06-7618-08dc813e5214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4078MxtvtnWVB+ARC31m2A/qnbaomt9J7JTKE5DyiyS47zyn3YA20kY24f91?=
 =?us-ascii?Q?sGlEPKh9M9UGQrjOUwnVbp0kcDtTtifc0JEQOyd/EPRNYrlsHcAB7V1xBFJk?=
 =?us-ascii?Q?Ut7NljFlQeAX0DkStaOj0OprEJO4tc9lM+myA9UDFc1f1jXI61CI2o1r0AHo?=
 =?us-ascii?Q?YYOEEX6DMnfLMH+C48pt0BMncMLOTklX/svBLk4DDTA84vRmUyxRTy3Q9EZ4?=
 =?us-ascii?Q?u1lDwf1pDRCYDd8vfWdB353IY5C08aPGlAoIAbD5vHsqoIByXFBhLJDGbP9K?=
 =?us-ascii?Q?bx++ClMi6evjI/M390fN5y8w7arkf9K00MqpYGwb3mAK7bQZWeN+bT0kw1k3?=
 =?us-ascii?Q?pjyhLQIxH/Gmiu3lhqF+BwgvZ2/gfhaNbbF+TM3RIkgv2pL3JZM9BgTDEM9B?=
 =?us-ascii?Q?D6uzZl/KIxNy3j6BSW9gYTAPueXzOx0z2t+5/HZHeCKKSntmOmoj3Qm/Zmue?=
 =?us-ascii?Q?wBBvviRcCv3rvgp43KhSS92Re+qsBRskBwmpUdDxw23u4BdoCOzF8Nn08zyl?=
 =?us-ascii?Q?SJacU3z5oUwd/xEw0+87h00EhDz1+R2Yqidv+qAnZ+yHtPQVjWQZGUn6S9XO?=
 =?us-ascii?Q?Qw/XAw3j4pL6e0/XxxPrbs24Ot+a46xz5YOGEyjqHEH5Ag5JOgixU6Vvg7q7?=
 =?us-ascii?Q?2MdXy6VVBBhLxcxYeOKkPXdgWo3bWV1IBw7y8IGgxuHhc7yj17+stI9ibFYR?=
 =?us-ascii?Q?pncTShc8VuILzBrTrcjG7ftc0kedcNF5PJxt2EXLlP35tIDHeVen5j9XyCTs?=
 =?us-ascii?Q?BN+DkTk1V7mGeK7ze9tgxKzGVtpKsqjPVA8vylvNfJFNcQ3Z0wBYEsEgD9eY?=
 =?us-ascii?Q?dELNwTgsr5qeCbq4UWcnn8vZNdRzzGGXY0RgCzc9igVyAuUPchf86BN1pdpA?=
 =?us-ascii?Q?58zqViKs4/k6lQtDquwEO5X3c3TaonCdL0Zhv5M4Iy8vwvPJKwQOltmfNDIS?=
 =?us-ascii?Q?VKJ5I7wJjuFzzhIEJ/0k4HB/q3x6YYOT1ydl+foQ5mI6XUfnZvQgh3E++XB1?=
 =?us-ascii?Q?0HcU5lqaI1DMYW7Z+kReMAerRBw+oPEsNflBSozcrAAAiqzmFIqyyEdwpH0e?=
 =?us-ascii?Q?B5sp85uAqkh8HL4W3Ah8KANQTRjtwJuGhk8Nsa4C6qZ+CJdvBH8kNWKjj3h3?=
 =?us-ascii?Q?usm7uYUtqmuNTDJlpJpGueNFDUwG+kUjQVpz2FgDI2qeu7K9ZA/1vqxnbRPS?=
 =?us-ascii?Q?0ivWEaiCmAPvcGwcsHgerEumjDgM3dj6tjM0ki6TRNZ/PszR0rgEjKPyAlO/?=
 =?us-ascii?Q?InhJNl8t1XZ/qs8H4YK5qqYADRBhrdgjPgh1/Jus/rUwkdRbJSm3/1NI1QuI?=
 =?us-ascii?Q?xFnJ9Eb/0LzVtYXDg9hgLKtrktn6iCSZDOqopUwfouxc2Nw7kauTzqqkWyF/?=
 =?us-ascii?Q?APtCQqk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:04.3389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7540a4bf-6290-4a06-7618-08dc813e5214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
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

Adding formatting string feature to improve function flexibility.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 30 +++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  3 ++-
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index a9de78bb96e2..a452d9b6afdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -28,6 +28,8 @@
 #include "amdgpu.h"
 #include "amdgpu_ucode.h"
 
+#define AMDGPU_MAX_FW_NAME_LEN		(128)
+
 static void amdgpu_ucode_print_common_hdr(const struct common_firmware_header *hdr)
 {
 	DRM_DEBUG("size_bytes: %u\n", le32_to_cpu(hdr->size_bytes));
@@ -1432,28 +1434,40 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
  *
  * @adev: amdgpu device
  * @fw: pointer to load firmware to
- * @fw_name: firmware to load
+ * @fmt: firmware name format string
+ * @...: variable arguments
  *
  * This is a helper that will use request_firmware and amdgpu_ucode_validate
  * to load and run basic validation on firmware. If the load fails, remap
  * the error code to -ENODEV, so that early_init functions will fail to load.
  */
 int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
-			 const char *fw_name)
+			 const char *fmt, ...)
 {
-	int err = request_firmware(fw, fw_name, adev->dev);
+	char fname[AMDGPU_MAX_FW_NAME_LEN];
+	va_list ap;
+	int r;
+
+	va_start(ap, fmt);
+	r = vsnprintf(fname, sizeof(fname), fmt, ap);
+	va_end(ap);
+	if (r == sizeof(fname)) {
+		dev_warn(adev->dev, "amdgpu firmware name buffer overflow\n");
+		return -EOVERFLOW;
+	}
 
-	if (err)
+	r = request_firmware(fw, fname, adev->dev);
+	if (r)
 		return -ENODEV;
 
-	err = amdgpu_ucode_validate(*fw);
-	if (err) {
-		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name);
+	r = amdgpu_ucode_validate(*fw);
+	if (r) {
+		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fname);
 		release_firmware(*fw);
 		*fw = NULL;
 	}
 
-	return err;
+	return r;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index db745ab7b0c8..5bc37acd3981 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -594,8 +594,9 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr);
+__printf(3, 4)
 int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
-			 const char *fw_name);
+			 const char *fmt, ...);
 void amdgpu_ucode_release(const struct firmware **fw);
 bool amdgpu_ucode_hdr_version(union amdgpu_firmware_header *hdr,
 				uint16_t hdr_major, uint16_t hdr_minor);
-- 
2.34.1

