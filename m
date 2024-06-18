Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321A6C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 15:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B9A310E6EA;
	Tue, 18 Jun 2024 15:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wjsmt9t7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D189A10E6ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 15:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJ1LLfWh19ckJOTeL14DWkUEenU0U7toO+7fJ2itOe3fCIT+AdiMTQH2LgEJij9TSWewnWhX8tBYjIYDmP/4vvz4RiVbiGeoVL+uuQIZCOPmoEEz1lxXLtLZVkIKIBiTmB3lpSvy82EUpF/c6HL70zE5aF7Y9DWEnD+0oblxiq5RNgL53KVzrUmsCNBk91dhSXW2ea1o/9CU7OJAbmcIqohlcmF+tgPmEqWXrl/ONhvWbA1FC/aHg30U517W0804KejQq1n/CX9FQ+vWY+so8iTMtrr94VfHbDUKHr2whfHbazl1/jPtKjjF3v4hQnKu/MzWgFqSGwhs3Pm9D7JUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MF0XdaE1bYlgr7Yl+IdRd6HCKkOVxNTMlH5wlH7XG18=;
 b=TzJsCFLJT9HdEQoCbZYtQIW8ZLueqjrLC0b7ugBqVZuLwdp/tyajWh4eofJSIAeIik6jh4PPU7f7qKChWuYs1nowEq3QiSPOFx1LqdqdRsCgLWdlLUr2DVMvgZpQycaiiPtkbXIb7+JoHmkdoZ8pekBvsVf3UPyQGALy1iHZ0ESg5TRrrx70kHavLt1c0Gmxs5xsBzz0z1vdzRXFHa8Ur9DaZFxRRn3pJrCjzw9/TLAPjPNdZ+PaNwPBEtCxEsdyCIo6t0+n7Qf/GJnuKnuEcZhrihQZcYai+skxjW32UU8weoRVCNHqFfbDLEr8JxCvPuDNGE0hm2HgNW+Uzfwedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MF0XdaE1bYlgr7Yl+IdRd6HCKkOVxNTMlH5wlH7XG18=;
 b=wjsmt9t7K2B9bfWN8XGKuJLwM2wv10+oYU0c8HAxs22Xw8oz0VF+X0oq3Ol4bH/7GZEdgOBKX8NakYm/tV69P5I7e+IhfgIy9mogJYAZ014SlodG8Qjn0bfgnOPEAQbHEftOqMHbmgtUGI1K/GWbkf9WzJ13NaH58mlg18UiMbA=
Received: from SJ0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:a03:39f::17)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 15:30:48 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::1c) by SJ0PR03CA0222.outlook.office365.com
 (2603:10b6:a03:39f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 15:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 15:30:47 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 10:30:45 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: add AMDGPU_INFO_GB_ADDR_CONFIG query
Date: Tue, 18 Jun 2024 17:23:25 +0200
Message-ID: <20240618153003.146168-5-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f02b8a-2465-417e-5a44-08dc8faba060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|82310400023|1800799021|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l6O8/WGENr8Cv7yHZhH14zocTypB3qPmDFfbu+fF/t51unfDr1+/TjpsFsVA?=
 =?us-ascii?Q?kTNGNVZq1AjeGxY5XeYDBHzkd1L+zILAFU1WaZ5KGZ/zewPOVrisVTwRZp4L?=
 =?us-ascii?Q?gnFJ21LVk3p1+QghxD2GEC6mCfBHJJop2t0ZLpci1kXRz6vLUOD5sS8cnNnp?=
 =?us-ascii?Q?KZMN2qAVhKhNbaCZSVaiRL4TNs5tPEUGsPUNHGVxDXtZeBPk+xX8laEji3Te?=
 =?us-ascii?Q?a1zoZm5AhbbnStGdi7E9mc2T72R2PE8gdTqlTKVDZ4GZMqtzVBQ35/JZnBo9?=
 =?us-ascii?Q?CYtrmUAN0bGT4I/GBzDFGcHgWc2BMUkpPyShx0eC7fxjBVXE0gQAJExDCTOX?=
 =?us-ascii?Q?pvN3jWblAzyqog9Fx3I80+fiROnCbeSm9Ok9XOwCMu2SCwjH+VLVuU1p8DDU?=
 =?us-ascii?Q?NWObuL9HE1jDXlHClFevoPGq+bkrOOeNRk62cM1CeKPO1jZD+/tAv8DLzFgD?=
 =?us-ascii?Q?o44cyBF8M7Ut+GKhI+Hp/iP/GJd53fQHjRuFi+O/ItWxd4g7QQShNIc7Dy2/?=
 =?us-ascii?Q?vQdq0ilUfwY8qYfo/WZ8i27tyq0seGCDhNWv0AF/ToEsSGx3Wxsp+NKUY1gC?=
 =?us-ascii?Q?wisE+X06BpdqOfK8HUckebWjJbeP9RzyVEY1apdjnbd+5gTkd6dwccad26MM?=
 =?us-ascii?Q?AbrpDBW+TCTeOKL5NW3pIriIAi4j1uFLGakjuz7i7o0F7KVw+4bDg1G3obj1?=
 =?us-ascii?Q?9fZ+S8fZf1CqjDsruETEk+H1/jaCknP8RuLayqOQ/lLPAB7FE2aYzsIaH8O9?=
 =?us-ascii?Q?b56T9izyac2y4Xm1zh2eJZRp28miqjTKijvNFmVZ7pNVb7M5NQQQ1dPwkfG5?=
 =?us-ascii?Q?4AgV0o4VnYNR4WbXbXUUi+rwrWbuBIf4hm/U9yYL1yDdpHLF0KPiJQeg3TzU?=
 =?us-ascii?Q?e++SpheuQBOZ0nfnDqhQUZq9sJ9/t+eMFGXwwIjNpq6CMPlx8LUrDjakC+Qi?=
 =?us-ascii?Q?PPIo5ULJlJXr3srBxvSiBgZEW+TDrSUr/Ey1DGnyMka1Zaz6Ighga010hLki?=
 =?us-ascii?Q?bJtwpewypSlIoxnZbQLZ9JjL2KwqdNa/COjy60E3O9P6nEmkWNVfsPYNcjN+?=
 =?us-ascii?Q?XqowauocSi7ZkFravzVG7GRKQ7VDX2oHm9krbzjCITuvpJQS+4qj5/UlYRvP?=
 =?us-ascii?Q?KoabbLYh1A3n/Y0hVO5xvX0sg3zl+rmFPtr2lwS1/yPSuQqtOarb59R2UAYq?=
 =?us-ascii?Q?bbW5yVrrJICEO1zG2TBTebFPb0G6vMk2IdZCmPQ7ydEqJEJ2ndCZ0l0iIGdq?=
 =?us-ascii?Q?sQ0OpGyuaIM2BLIuKD8tcsshnpFh/3lQsuQ9hXMKFX7y4SEqBS/q3hFpKX4H?=
 =?us-ascii?Q?MrgjPiy+O1Fq+XIWK0Ut9Wq15xfvEj1EiB7ZFCEuUhUZsUv5g19lhuw/ged9?=
 =?us-ascii?Q?RjU0WOs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(82310400023)(1800799021)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:30:47.1054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f02b8a-2465-417e-5a44-08dc8faba060
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141
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

libdrm_amdgpu uses AMDGPU_INFO_READ_MMR_REG to fill the dev->info.gb_addr_cfg
value.
Since this value is already known by the kernel, this commit implements a new
query to return it.

The libdrm MR to use this query is:
   https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/368

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
 include/uapi/drm/amdgpu_drm.h           | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f51f121d804e..403add7f05af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -117,9 +117,10 @@
  * - 3.56.0 - Update IB start address and size alignment for decode and encode
  * - 3.57.0 - Compute tunneling on GFX10+
  * - 3.58.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AMDGPU_IDS_FLAGS_MODE_PT
+ * - 3.59.0 - Add AMDGPU_INFO_GB_ADDR_CONFIG support
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	58
+#define KMS_DRIVER_MINOR	59
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b32ff6e1baaf..dbb05d51682b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1256,6 +1256,10 @@ static int amdgpu_info(struct drm_device *dev, void *data, struct drm_file *filp
 		return copy_to_user(out, &gpuvm_fault,
 				    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
 	}
+	case AMDGPU_INFO_GB_ADDR_CONFIG: {
+		ui32 = adev->gfx.config.gb_addr_config;
+		return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
@@ -1310,6 +1314,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	case AMDGPU_INFO_VIDEO_CAPS:
 	case AMDGPU_INFO_MAX_IBS:
 	case AMDGPU_INFO_GPUVM_FAULT:
+	case AMDGPU_INFO_GB_ADDR_CONFIG:
 		need_runtime_pm = false;
 		break;
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 3e488b0119eb..680492cd73d8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -933,6 +933,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_MAX_IBS			0x22
 /* query last page fault info */
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
+/* Query GB_ADDR_CONFIG */
+#define AMDGPU_INFO_GB_ADDR_CONFIG		0x24
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
-- 
2.40.1

