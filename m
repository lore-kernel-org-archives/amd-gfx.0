Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B70ECE587
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4590310E68E;
	Mon,  9 Sep 2024 20:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1vRpj2/1";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C7D10E68E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzBCtViqSa9ECf9/qy4Q/KNPLqjWER0CF0cQggm6w9tDSwpQkKGAk3FB6m4pU+lUgIO6hxyPYpWUYlDyQLAF3pN/WBffRv12/UsXahyJhcDJhpndUKgxaTmEs2iHBE68rFlWlyri5Y17n2nY6o6vTCeCCjyJGMd+xvFxYOR3PhOtftvEfT1D1CWSef/xK92c5C/8PxrLi/CY3OeD2VoMp0s9O5af9BGlVgtKNwdgNMNXkazxvjzumokF+grw9x2d3VAc/wh+2nzoyLoXp0HsAdsH9Df+OYnbadcEoW1p3WoJX8OgxnctINKj8pn8YjlPJa9OorcDQX8oEj2q5ki9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHuL1xisvy1aDa0GtHkBZcvhQZ2wQu+qFxQmUWF4AT0=;
 b=wHdkngfhPwXhgVLIrXnwseGjZJHUyTKEg4US++VNYiY5/ucaTezmXlzAl68IukxeBbMqB1/GDCRa7iGGJLgClHl0zad4ZexxcxEZ3L70mci13NewIowZ2b/Y9h+Bd6x3UUYHSl7lo5Zlmr4S6a8lAgcZAQV02kqC6smp/egZWMmjcMNT1KIKhRNY4i5l5ooMuD8Ajk69IKQpoCDPQW493MAU6lrRHNW3GmrHstPQR7u+ZulACjcmmlZFp7aPT3uEf9BfmFxTo5gvV80b+9KSz3xA1bmRTu/JzxPGm8m4Lm6sPCHenlD1B3M5MzikCdEtNvfX/48gebok0i9wY5uxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHuL1xisvy1aDa0GtHkBZcvhQZ2wQu+qFxQmUWF4AT0=;
 b=1vRpj2/1CNYiPtNYCLob8j9g9KXm6ErSExqKNbv8Y36MGD9Dyh+xbvy2gPHFi1RJUqfZiBPCNJokGkCdY2xX2ae2WYyplCDnH22ZrkZeVnQ6I1VOrmbKVssMcNMV31tqABU8D3+c+SBKcT+qySeD/T30wlo/cmADvsjCdFLJQII=
Received: from SA0PR11CA0044.namprd11.prod.outlook.com (2603:10b6:806:d0::19)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Mon, 9 Sep
 2024 20:07:17 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::73) by SA0PR11CA0044.outlook.office365.com
 (2603:10b6:806:d0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:07:17 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:15 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH v11 15/28] drm/amdgpu: add kernel config for gfx-userqueue
Date: Mon, 9 Sep 2024 22:06:06 +0200
Message-ID: <20240909200614.481-16-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 7faee884-3114-48cf-5d86-08dcd10b0141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0hvdm1mQlpFSDlYL3p1MzFPL2JJNnJhY01LK0FCTDNtWDhTZFp2aWc5NDVN?=
 =?utf-8?B?TEtJYWQvaGZScC80SWpBQ1RDYUg3WnlWVHJCMUx0UlIxZGNmb0pleGV1YXU2?=
 =?utf-8?B?RDJhV2hyZEJtSUdVdlRHYXdnTGFPaWw3RXdCeG1uUGp5MmFDQjFzeGRoNEo5?=
 =?utf-8?B?NmdFUXMzdWZ5VEZTblAxeE8rQWxPRis4RGhsVUhKb2tkaExtN0dTdjlpSGc1?=
 =?utf-8?B?bnFzS2tNSXFsWlpGbkx3eXFjcXpkbGhMYXRuRmxnZ0VXMTZxSnpYd2Y1RnVO?=
 =?utf-8?B?K3RDTHJNbmxUZXRSclpvSW5XN0N4VTBvS2dUVWtNb20vQXJxZ2hCY2F2Z3oy?=
 =?utf-8?B?Vjhnc29QMWxpd3IyRENsbGluWlVBWFVCV0MzeEpJSkwrbFZwaHMvQk5abDEz?=
 =?utf-8?B?ZFR1eGZzblJ6WDZPNmZhZmRBNmUwTmFWVkxsWndOeTlOUVAxc2FidFZ1aXhr?=
 =?utf-8?B?R2xVRUFXbk9wUHdQeUtJbHc0YUJkaWZCSVlucEZ3RDdXSzJsbFVUNlBZQTdB?=
 =?utf-8?B?Y0I2L3hiTVBqQXI4WThVU3RIT0NyVnBaeEdZekJUK3Axek5Eakl1U0xYR1R5?=
 =?utf-8?B?ZSsrZGtBeGdoN3FqR1YwRFBOdnV6NVo0VmhJK3JUTk9CZkpvL3pOWFlSNjMx?=
 =?utf-8?B?QWV6WFhxdlFXL1RZTnJ5ck1TNkJ4QkhXalFqUER2K1dvcXBwOEJ0cnl1bUsx?=
 =?utf-8?B?b2I2TU1QNHBtNXF2S24veGpWRW5TeElWdEx3Wko1a2Vidy82OUVrZ09GcGNL?=
 =?utf-8?B?TkxidktRUi9FRlRHNldEUXNxWFVsdWNYOGErRW1md2lQZEtOSFBVRzErVDly?=
 =?utf-8?B?RG55Q1JCRCtOWHJpK1FQOHJ4MUVTZjNXSU5lQzJHazNHamQxSWVoWFBtVmow?=
 =?utf-8?B?cm1TTmNveGVuaWY0c0Z1ZUFwSUxGSm5pSXY0Y0xiWlNvWlFIUWpXazRjTk1u?=
 =?utf-8?B?TVlpYUdvZm5XVzQ1T1YzbVRtdHR5bVNMRWpLWit5WmpKekM3ZWxaQjJwYjJG?=
 =?utf-8?B?M2tueEtkTXY0TncxN0tPMEhtSzBGdmpCQTZsMHdRb3BiREhWbm0zQWtBU1Rs?=
 =?utf-8?B?WllrRzV5NDdoVk1Jb2Q2TWdyYms1V3BoaFNKRmh1NGVNQ0dYaytWaGJLNXJL?=
 =?utf-8?B?dTd4cWVUZFVUUkc2c2tmSHhqWTc3d04weDhVaTFJZ0o1akJDNTVEdjM0eXFk?=
 =?utf-8?B?eHNkNXRmNFdNY3BZV1lYY0YrZW9RUitlMUMxSWdZNTZWWmNoOFNJNDlJVFhj?=
 =?utf-8?B?Q2NhOC8vaXZwNWhGUW45VU1Ya1p1aHFjejF4NXdjRlM1dlczYnhTaytlS1NS?=
 =?utf-8?B?cCtuL1NNQU9jNjlqckFoeUpGRzN0RUtpNWszK0gvbDFjOHNmRVY1T2FBMHZu?=
 =?utf-8?B?WDRZWGpQZVZEUE5oQnBFVFZlaW9lVEZtS0o0V3ZRRW9sSUQ2VFNQdVQxRE5h?=
 =?utf-8?B?dE5ZSStwcWJQZE5vVUVQcWZueWw2cXhjRitBOWhUdVV3V0QzUVFvME82V2FU?=
 =?utf-8?B?b056enhBdCs1S0dBcENJRlpiMnZJSUV3ZytkTGE4MkFxcE1mc2NPdGpLVVM2?=
 =?utf-8?B?SEk2dmFpY3lhOHU2cmlub3g0QjZIM2VndDJnOTh5RkZNTmhRS2h6U2JUTTBM?=
 =?utf-8?B?YUd6UllXY3N6RmFiamtjRnh6OTVEWWhreUhNb3VZRVIvajJHK3IzOUI3TGNz?=
 =?utf-8?B?RGV3OXZjdFdYRHQ0QnN2TXVTaVF4Y3p1MTcrQ1dKNzBYeFB1ZFJCMldYRENu?=
 =?utf-8?B?TDdaTUxCOFFmcnAxQUw4OENWd05jVEgzZ1FuYVBJNzFzQ0dhQlBrNWQ0UTNY?=
 =?utf-8?B?ZGltQ1BjT0h1ekVGeDZmek9aNmxBKzlLSlYvZE1KNHB0ck1UZWZwSlhoYm1v?=
 =?utf-8?B?b0VVbFJRaWtQRnJ5MUI4K2duSmM3QjFpTlI5UUNMeDNOZVZaU0RzbjlTMGs3?=
 =?utf-8?Q?fjtPGNWEOamH2yeMzjsRz+NykUI0Wqlh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:17.4736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7faee884-3114-48cf-5d86-08dcd10b0141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177
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

This patch:
- adds a kernel config option "CONFIG_DRM_AMD_USERQ_GFX"
- moves the usequeue initialization code for all IPs under
  this flag

so that the userqueue works only when the config is enabled.

V9:  Introduce this patch
V10: Call it CONFIG_DRM_AMDGPU_NAVI3X_USERQ instead of
     CONFIG_DRM_AMDGPU_USERQ_GFX (Christian)
V11: Add GFX in the config help description message.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Change-Id: I509a1fc9eb9ae1adddd1e042ae4456737333a606
---
 drivers/gpu/drm/amd/amdgpu/Kconfig     | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/Makefile    | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 0051fb1b437f..b7f41177b3b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -92,6 +92,14 @@ config DRM_AMDGPU_WERROR
 	  Add -Werror to the build flags for amdgpu.ko.
 	  Only enable this if you are warning code for amdgpu.ko.
 
+config DRM_AMDGPU_NAVI3X_USERQ
+	bool "Enable Navi 3x gfx usermode queues"
+	depends on DRM_AMDGPU
+	default n
+	help
+	  Choose this option to enable GFX usermode queue support for GFX/SDMA/Compute
+          workload submission. This feature is supported on Navi 3X only.
+
 source "drivers/gpu/drm/amd/acp/Kconfig"
 source "drivers/gpu/drm/amd/display/Kconfig"
 source "drivers/gpu/drm/amd/amdkfd/Kconfig"
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index d9bf70251eba..beb8442b4e3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -174,7 +174,9 @@ amdgpu-y += \
 	amdgpu_mes.o \
 	mes_v11_0.o \
 	mes_v12_0.o \
-	mes_v11_0_userqueue.o
+
+# add GFX userqueue support
+amdgpu-$(CONFIG_DRM_AMDGPU_NAVI3X_USERQ) += mes_v11_0_userqueue.o
 
 # add UVD block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 82a8df56240e..f3d034f2d4fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1553,8 +1553,10 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
 		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
+#endif
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
@@ -1567,8 +1569,10 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+#ifdef CONFIG_DRM_AMD_USERQ_GFX
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
 		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
+#endif
 		break;
 	default:
 		adev->gfx.me.num_me = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 62f6f015c685..bb11917ad855 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1341,7 +1341,10 @@ static int sdma_v6_0_sw_init(void *handle)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
+#endif
+
 	return r;
 }
 
-- 
2.45.1

