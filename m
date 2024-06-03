Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A14C25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C5610E1C8;
	Mon,  3 Jun 2024 01:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p8y5gRfT";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B1210E0D1
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngjxcRJOSyKKz+tmeaUFIfTnn3lNloxNSW05MNxYndhIOE9XQubqQ+ayJAIp+AsguCF0HKHKWJ+eFGmtyuKZ3kumFgSJ6hM0Y6VPJvHVY/DAK0fwd1SrW8gTX8lPBnzLpZ+b3qkye/+EUXGtXSjheyhrYoUtfx364qFZbT/ghD6cqh4tJOMzgFi8OFkiHpEPtu/a+B44M7JDHbFff5eix97ospRBfLU1UhfGWjj1ZQp/KdqI1IHZJFvY8m4/pm7jpSbPydQ2TmmFivZKv+DfSVdYtg/5j5TYuEw82JAmm1Q+Knr08D+m9nbPMfSGrtzkC5dTm3Rz0nmrvQF3H88Ppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJDfLknjyD6SHaThwK7PmYxKscn5TLmfLqihKgYrPro=;
 b=eSLrPbpB7Rga9fJz/hjFOlxU+rYX4dNSnpiRKe6LnNIah4hzq65SkFMGWlLVrcJ4r3zUfnlkvkf96jbEY1NRyXUWxfHNkzqPiPbnLGtm1ZXsOtVvn+7n/sFPDd+MvLEwSd8aVm7OD6Sv+LoabAQQ5at02MH0F29K0o7yG7vVayNUuUuMWJXpvA4tgMxTcFL0zrKjSCBBiX9E33dIYY930kFNf+Wm2TJGcYzN4lFQ8nBokAiuZQMNA8QvoHzIm2QIbMQzg0oHR1cBJ6eoZB1yx2hS1LbIdpBWp/k4EtH/YDRNZRQwpBckwtiVU1+3HKbAuyvdFGpsMA29b8kuwzVQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJDfLknjyD6SHaThwK7PmYxKscn5TLmfLqihKgYrPro=;
 b=p8y5gRfTILCNvK6OaoR1SB8rMXFCPAv7/VZ50pULLd35hpb1rWcTl+7ByFDZzN+Fp8a/og2CkGkCoQ8NjsvQrZRoGHUPQtmTCB/xdfAHmO0in7iVZSF74oxOSaCZW3hS/2RU9uqQxvxBK+aKSIRa6jtMWoh0/gIfMd+/obV4t9s=
Received: from BYAPR02CA0039.namprd02.prod.outlook.com (2603:10b6:a03:54::16)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 3 Jun
 2024 01:42:42 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::92) by BYAPR02CA0039.outlook.office365.com
 (2603:10b6:a03:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 01:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:42:42 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:39 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 01/18] drm/amdgpu: enhance amdgpu_ucode_request() function
 flexibility
Date: Mon, 3 Jun 2024 09:41:55 +0800
Message-ID: <20240603014212.1969546-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 05567d65-16f1-42cf-5ffd-08dc836e7593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1V2E2dmZcOPhdJSwbnlCkdOCqYIuCt1iJui+C1/vQOq3VPHfG56YPny6m8tr?=
 =?us-ascii?Q?mj4Za/f+PICfWyeumPdrYushvyojUM2OB0tdK9oj7nwqx/DdrdQmtlkfndk5?=
 =?us-ascii?Q?4eO62To60bZX8LRaSRrnP1r8YJNrrTny8njq+FEvUxKEqxLcy+U1w7UqRS6f?=
 =?us-ascii?Q?APM0rzU/hZt5w4h9Gj9TyvXUcKI5aEHsUTHzaOI+yA+jh47fM6NfTrtsN8N/?=
 =?us-ascii?Q?aNxndqP1JquaC4BRosZ43vgmn81rKplEHODMDs5zUB/xACFs/qBNOCYzhppz?=
 =?us-ascii?Q?KP7qoce00mfaNgQg05kbsGVQJx1rzIk2qF4XYWW1xjW87OB2tjRbh1mUADJe?=
 =?us-ascii?Q?1smRf8ta56hXC8X3DFsA0yjEG89p7cKj/S5j9OhyAo+oD4GAqyqeV80WtHVi?=
 =?us-ascii?Q?lHgsQmg/U5UXjZ39m+tYV1bvYERbcRz1LqHVK3RJoCBVIhHPN4RLsKtaqNo7?=
 =?us-ascii?Q?5afxvuEkschF8xF+7ebkXgbCLTgYUkRuD5eJLRY57QFJs3d6mjxKyhEGTaCk?=
 =?us-ascii?Q?ODHx0eDaqYo3hVkC6LUS2B1xdmT80PICTMUWgQpHLjWxfSgoAbY6MVtOBInU?=
 =?us-ascii?Q?QXs37fBnsHTMSF1/HBSgbhO5bW0Z7A7jV1JCCgWJra00dWcfoO22cGCgwyPo?=
 =?us-ascii?Q?2gPjHxMopmhfLZPk4sDZuLzbbCssi1mZ0qacWnIp/YoMO+9xhq53vCaGGvHz?=
 =?us-ascii?Q?jzy9BdXcBMKHsdrZiq0xjLC5lS/s79Qu1KN1Ad7WN/9l/0AOsJt8h6+tAfjR?=
 =?us-ascii?Q?VcXbFfNjHjKISp2bkCJbZ7CRZZeK4I1VaTmSfEjDpc+jgd5hu+9RwSVUJ71C?=
 =?us-ascii?Q?9gzMHA1UJHucalrzN+VmkBkMxQjZ2Js7/0M3tgncPKWk3CrOucq2RIMuID+0?=
 =?us-ascii?Q?ftmaenE5t70yti3KuhZ0oH0Q/6oMETPTXFXIKolG8ezdbIr7c5de49QYilo6?=
 =?us-ascii?Q?D1bZ3rC8onbcaC+P4UHc7W+mP714RPZw9blJnCRz/g06a0IE3JI2C4sm+ZbY?=
 =?us-ascii?Q?M9NQnByDiENeMjbjc9DHBrXksV0QZ7GUSjYvEvQ4A1ovPZv1ovMGLHOCoR2G?=
 =?us-ascii?Q?NWTM7Tp3cx0oxXgtd49hYvEPSSp5loMe2qGxuRNLfRrtXejLcijuCuG+pcLR?=
 =?us-ascii?Q?Tz1SqFjc14HpkgB3HMMVGjYfMdvCwysg00xK162iAEGHGO8NJL7z3HYmfC6b?=
 =?us-ascii?Q?aQv6fvIdG3mda4Q2WQaKvLILrMkICrBLjb0A0pW55gI2i0kVHqABwHEAL0dA?=
 =?us-ascii?Q?IOZUegJCiepoc+/HPPRXmonvCtL0areL2NeQh03U2RypcfKpZtaqZ9smvAlb?=
 =?us-ascii?Q?J1Qu1YM2uOe+gaNLk5j4wpFaaq8PRo0C9pE9hd8YokZ4GDeWcOhiiWFWTFqa?=
 =?us-ascii?Q?H/+Gfrk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:42:42.0907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05567d65-16f1-42cf-5ffd-08dc836e7593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351
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

