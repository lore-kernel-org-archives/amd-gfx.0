Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246F0C77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 11:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFA7F10E0D4;
	Mon, 23 Jun 2025 11:17:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YtY0QQzQ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C7C10E0D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 11:17:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVg0B8Gq10z8pF+w/yT9cR3PU6Vm995aTBW3c5ECtGjSr+QveMuAcWy3phHJ6cjktnfUu736yemnGC3X1SgNCKuyoT5cDlutzSzFOkH1UjLNU4lfBjg/ObXa/ZuaEJm0or5Uni8GJn8EpdUKoKgOB2HS9JWF/xPIlcU9i21CI+DrDIf5UcJEpikNu3TzLEf9j3oE7zLSYjA0HZr03e0rAwDh5mc2udZzjjDH7TgIqlZFAKi1EJSNmW8UercFGgt4YigJsMYuxcSifPO2u1/G2SmUotqFLKjhsHli8m8Fh3qlWhEf+3QAU8mbhxYph2CNm6gLMYaLmORU/+nlDeZvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqVeooAua2+v8k0cUcDRIqQu004YqAksa1hukGxo8mU=;
 b=OunMXylUGtjr1mSEzV/Y0IK4RpnHAYPijqLD6asrPYNIZlV36CZpxqs+BWnTaUb8grAxrCel8pEaudYNy/NDdMc3SnpXCw2T+4AnYeXulIQHRx8hcY0l8FN57mzHAqUX51Ruh7o7sGNUhUtTDOcV93937GdDeINpXYXVh/yl/Tl11/inWCG1ryCLnGuHNDDRS3Ee/G93mgTcMqVaqHAtvUQalBESp5NPdDUjpWrkZIGJqPJl2Ti0ciQ47Sea0ubPQFS0OHappwSQxwmACTwlr4EE2xbXpvdrGbCDtd5a+sN27S4U28ezdxJy7nGVAfBoye2yKzh55gJk3RvOrM2LSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqVeooAua2+v8k0cUcDRIqQu004YqAksa1hukGxo8mU=;
 b=YtY0QQzQw+PWXInieBvxHmtLk/MaWU/K4u2GyZ6qyErpMSszXQXj2Yc5D4ERlY0Mz5hNAlNpNFJtVpVGEF9YiDLI0E3rrQTfj5jgR2IvhuIXhnb5td/OF1r1uwzhJRlj4DIH0WQ92goYq5XbRtkO6vBfjwugD5qUN4nE+mzotXI=
Received: from DM6PR02CA0150.namprd02.prod.outlook.com (2603:10b6:5:332::17)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Mon, 23 Jun
 2025 11:17:38 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:332:cafe::f6) by DM6PR02CA0150.outlook.office365.com
 (2603:10b6:5:332::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 11:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 11:17:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Jun 2025 06:17:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Unify Device Aperture in amdgpu_info_ioctl for
 KGD/KFD
Date: Mon, 23 Jun 2025 16:47:17 +0530
Message-ID: <20250623111717.224707-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb28c6c-ed0c-4d0d-ba94-08ddb2478fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmFObzdOQnNnUWtac1ZCbXYrc2xjTWF3Q3RFcnZuUExwdmhJV2hVZ1NqdmlI?=
 =?utf-8?B?d0MyVEw1aG4yR1JJMnRkendUL3ZsSW1UTys1ODRteG9QeWlIdG9vVXVFSndB?=
 =?utf-8?B?K3lpNnA4N0VzSWQyUzU0Mm5qb0VoSm5abHZPMTVIOFdTUXNRU240L21GY2FK?=
 =?utf-8?B?UnZrRjdqTmIySTE1VmdWSUd1R2FoakwwNmFWNUo0MEU4UUFSWEdFb0h3VXoy?=
 =?utf-8?B?NjA3T2pBOXloZ1FKeWMrN01yU2hTTk13Y3FjUEQ5T0YyZFBRZy9jN3VYWUpG?=
 =?utf-8?B?b0xKeHJWRFV2M29qMTlDUldnaHVCRkpSKzhoUktqOWtHTlJycW9vL0xxV0ha?=
 =?utf-8?B?cEpJbXpJNSt6WnQ4T3B0a1VSMVZ4K0U2dkpQaWVKUGdpNk9XenlnRHdHQURP?=
 =?utf-8?B?Y1ZyQlJleXhNSlJ6VVN0b28rb21uWU1majlvY3Y5dEtWZGZuY1BiMEgvV2NE?=
 =?utf-8?B?aHVlcXdaRDJFbHc3THVLRE9MWEhDZUJPaTFQVWZuczNOQnN4RlF4bk5GZTFV?=
 =?utf-8?B?Z0Nhd29Nb1RsU2NnbjhXZEFSNnFXSjdtbm9NMkhNOFVkTTFJektvcEpVdXlX?=
 =?utf-8?B?Vm5hQ3ZhMXhKN0JpemZnUE1RRytvZC8zUk1QSEY5dHhpS0VOdHloaVRPRXRL?=
 =?utf-8?B?N2dGNWxLODRCeXZCcngzSmRnVG9UbnpYM3FJL3J4SFVack1jRW5Yem9kbFZY?=
 =?utf-8?B?VXA1cGx1RVZzZDBRUzA4Z3crOWFNb3IreDFuK01abTRFOHdDMUxid2sra2sw?=
 =?utf-8?B?T0NEZ0xrdUs1UUhka0dHbmduNWcxbE42Q0xTQkZ4NklnTG9nTlBScC9KdmFS?=
 =?utf-8?B?UzUyNlB4VTR2dnJsRUdOYTBrWVFDU2ZxVEIwREdxVEJPandmenhmVEpnRjJK?=
 =?utf-8?B?VGoxdTZTZlFlR1o1ak9RcStONXJveXkvQUsza1RoZUlwSERPWjAxUmhqdFJ6?=
 =?utf-8?B?TytrZktaeFliUXNqNEk2N0RJQjJXOWY2RjlNWXBmT2RBNjY4Slh0QVNpT0Ro?=
 =?utf-8?B?cHQwTTRzM3RvUDFjTGE0cEs3cEZRWGZaOWhsZ3RHY0FOS1pIcTd2TVREbW81?=
 =?utf-8?B?bEdJY2tETFVzS0dLNkNaU2huYVplRVlIZFprOXVyYmV0NmdSOW82MGRjenZK?=
 =?utf-8?B?QnJXQ01XaUFNWEd5MFdHUk55ZFhLZFc5cWg2b0VsMXduUnZxSWJMZ2loK09B?=
 =?utf-8?B?WGs4YzdFQ21aM0Q3VFlQaGt2U1hRTm1TRzVnS3U2b2p6akhFaCt3YzZnQXZ0?=
 =?utf-8?B?bFFTR1pNSnovc1l4eWZpdDNQc3NJWXlvVm84NWh4OFpwSWJmZTRsc2xLSzhN?=
 =?utf-8?B?ZkJubHBIUFVzenVnZVRsSGVjcVR5Y1dJbjdoejkzb3RYOFl6NTlnSEpQcDN3?=
 =?utf-8?B?QUt5c0Jhb2F1UWd0Mjk5cW93WWZSR2VacFJkV3o0R1JMK3oveGFIQmNwTWtw?=
 =?utf-8?B?Y3Y5THEwY3ZRNFNRb2wwSXBzSEVsTFQxY3V3WDducFA1MTBWRjQ5Wnh5R2Q5?=
 =?utf-8?B?ZENsOHBBYXFoVWNQcjc3eDFNdWV3MXNTVjM0SDlMdkI0NkNZSkhkYmgrenNo?=
 =?utf-8?B?TFJEL0s3UUJnODNwRityWHMwTHY5ZDRzdFR1S3RhTnJEU1dTUHBDWGRSWVNa?=
 =?utf-8?B?N29sY2E0OGp4NzlCdXZzVWtvMjZRS215U2R4ZERlWjZPcGZPNEp5WFJvV3ox?=
 =?utf-8?B?RHllQjQyS21PZ2xEQ1FFYk5MUDhjb2RSN3I3M2xYeXFqNHpJY3hPNmM2RU9T?=
 =?utf-8?B?TXRUenlzaSthVFRXTmpSblI0cEh4d3B1Y3RVUjBCcFFpSk9TbW9FdkIzYVlE?=
 =?utf-8?B?cUw2Yk9iQ1pZL0pTY3RteFZVNHdNcWtyOHRySThHcERsaElRcjlVdkVGclVU?=
 =?utf-8?B?ZE00T2REdk93YWZEejNZTWZ0bHVOVndnYlg0YlFPZXhpUHliak83eDRWVmFV?=
 =?utf-8?B?eUtwamNvVyttMklUZnRpTXE0eXBteUhVdjNrcDlURm1XSlZXcGJndDZiUnhX?=
 =?utf-8?B?dHhHalBMc29WZ3E0dFh6eHVZNXBLV1ZYNGx2YTdwN0FyYVFJMzI2Y3ZhOTB5?=
 =?utf-8?Q?Rie6O6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 11:17:37.8484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb28c6c-ed0c-4d0d-ba94-08ddb2478fab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
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

This commit refines the amdgpu_info_ioctl function to unify
the reporting of device apertures for both KGD and KFD
subsystems.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      | 23 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 29 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 29 --------------------
 include/uapi/drm/amdgpu_drm.h                |  6 ++++
 4 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d2ce7d86dbc8..6ca399a92814 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -46,6 +46,7 @@
 #include "amdgpu_reset.h"
 #include "amd_pcie.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_vm.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1011,6 +1012,28 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 		dev_info->userq_ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 
+		/* Retrieve Device Apertures */
+		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 0, 0)) {
+			dev_info->lds_base = MAKE_LDS_APP_BASE_V9();
+			dev_info->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
+
+			dev_info->lds_limit = MAKE_LDS_APP_LIMIT(dev_info->lds_base);
+			dev_info->scratch_limit = MAKE_SCRATCH_APP_LIMIT(dev_info->scratch_base);
+		} else {
+			dev_info->lds_base = MAKE_LDS_APP_BASE_VI();
+			dev_info->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
+
+			dev_info->lds_limit = MAKE_LDS_APP_LIMIT(dev_info->lds_base);
+			dev_info->scratch_limit = MAKE_SCRATCH_APP_LIMIT(dev_info->scratch_base);
+		}
+
+		dev_dbg(adev->dev, "Node ID: %u\n", adev->dev->id);
+		dev_dbg(adev->dev, "GPU ID: %u\n", dev_info->device_id);
+		dev_dbg(adev->dev, "LDS Base: %llX\n", dev_info->lds_base);
+		dev_dbg(adev->dev, "LDS Limit: %llX\n", dev_info->lds_limit);
+		dev_dbg(adev->dev, "Scratch Base: %llX\n", dev_info->scratch_base);
+		dev_dbg(adev->dev, "Scratch Limit: %llX\n", dev_info->scratch_limit);
+
 		ret = copy_to_user(out, dev_info,
 				   min((size_t)size, sizeof(*dev_info))) ? -EFAULT : 0;
 		kfree(dev_info);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f3ad687125ad..6ee09df0d345 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -184,6 +184,35 @@ struct amdgpu_bo_vm;
 #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
 #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
 
+#define MAKE_GPUVM_APP_BASE_VI(gpu_num) \
+	(((uint64_t)(gpu_num) << 61) + 0x1000000000000L)
+
+#define MAKE_GPUVM_APP_LIMIT(base, size) \
+	(((uint64_t)(base) & 0xFFFFFF0000000000UL) + (size) - 1)
+
+#define MAKE_SCRATCH_APP_BASE_VI() \
+	(((uint64_t)(0x1UL) << 61) + 0x100000000L)
+
+#define MAKE_SCRATCH_APP_LIMIT(base) \
+	(((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
+
+#define MAKE_LDS_APP_BASE_VI() \
+	(((uint64_t)(0x1UL) << 61) + 0x0)
+#define MAKE_LDS_APP_LIMIT(base) \
+	(((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
+
+/* On GFXv9 the LDS and scratch apertures are programmed independently
+ * using the high 16 bits of the 64-bit virtual address. They must be
+ * in the hole, which will be the case as long as the high 16 bits are
+ * not 0.
+ *
+ * The aperture sizes are still 4GB implicitly.
+ *
+ * A GPUVM aperture is not applicable on GFXv9.
+ */
+#define MAKE_LDS_APP_BASE_V9() ((uint64_t)(0x1UL) << 48)
+#define MAKE_SCRATCH_APP_BASE_V9() ((uint64_t)(0x2UL) << 48)
+
 /* VMPT level enumerate, and the hiberachy is:
  * PDB2->PDB1->PDB0->PTB
  */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index dbcb60eb54b2..fdcbb400f618 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -277,35 +277,6 @@
  * for FLAT_* / S_LOAD operations.
  */
 
-#define MAKE_GPUVM_APP_BASE_VI(gpu_num) \
-	(((uint64_t)(gpu_num) << 61) + 0x1000000000000L)
-
-#define MAKE_GPUVM_APP_LIMIT(base, size) \
-	(((uint64_t)(base) & 0xFFFFFF0000000000UL) + (size) - 1)
-
-#define MAKE_SCRATCH_APP_BASE_VI() \
-	(((uint64_t)(0x1UL) << 61) + 0x100000000L)
-
-#define MAKE_SCRATCH_APP_LIMIT(base) \
-	(((uint64_t)base & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
-
-#define MAKE_LDS_APP_BASE_VI() \
-	(((uint64_t)(0x1UL) << 61) + 0x0)
-#define MAKE_LDS_APP_LIMIT(base) \
-	(((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
-
-/* On GFXv9 the LDS and scratch apertures are programmed independently
- * using the high 16 bits of the 64-bit virtual address. They must be
- * in the hole, which will be the case as long as the high 16 bits are
- * not 0.
- *
- * The aperture sizes are still 4GB implicitly.
- *
- * A GPUVM aperture is not applicable on GFXv9.
- */
-#define MAKE_LDS_APP_BASE_V9() ((uint64_t)(0x1UL) << 48)
-#define MAKE_SCRATCH_APP_BASE_V9() ((uint64_t)(0x2UL) << 48)
-
 /* User mode manages most of the SVM aperture address space. The low
  * 16MB are reserved for kernel use (CWSR trap handler and kernel IB
  * for now).
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 45c4fa13499c..a52683ae7115 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1477,6 +1477,12 @@ struct drm_amdgpu_info_device {
 	/* Userq IP mask (1 << AMDGPU_HW_IP_*) */
 	__u32 userq_ip_mask;
 	__u32 pad;
+
+	/* Additional fields for memory aperture information */
+	__u64 lds_base;          /* LDS base */
+	__u64 lds_limit;         /* LDS limit */
+	__u64 scratch_base;      /* Scratch base */
+	__u64 scratch_limit;     /* Scratch limit */
 };
 
 struct drm_amdgpu_info_hw_ip {
-- 
2.34.1

