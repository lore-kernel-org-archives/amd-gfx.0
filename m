Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467D5C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96621112417;
	Fri, 26 Apr 2024 13:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VziXEqmP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB64112415
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gw4V8N82GyJmA0BVtNH8OpCOMDbz9tAj4KlCuNHZBBxOS74/tmvxbfVSYSpd+S7SA2lcn+J3Um2vk1PSMDEukhB3mxBiaaXS1Mqlyxjx++GxSymeo67WROyma0Zxqi1nY+5D5cFJEYHCbeKhbt8PNNEDluGbI8rx2V9GzxQfwJegnrx8+0la4yj/fUvUE8GZhy82aKJfgqR0U3yqPk+ffapyoEsAHOgnxiKJaMwgbJbXDw1dbbkmDgzmrvvtgbXgu0q3CfI1octK16MICMB+U32sjlRUfITn4NpUlgdMkk3BfEoliYZ+IOwJXqKhbyAr2zwHCyGk78nVvk1mMVQFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsIlFpAzs5VerXMG6eOCUdoLmKm42CrouONzECAH/4M=;
 b=cchlq+kViwbWA/e6Jp3TXXt3pPkDg5+21GmNY0BPj3/ZDLrAbdOFdxHdidkowOEG34jsxTd5GG/FIZ9oP1f/g3uqUXprPdk/JfKrPCwI+irPnlkj9+hSXA1XFDZRKFAcb6tr4Rct3lUVGeV8mZO7L+64rwNA2wDt0NrGknQy1rDlwQbu84E9YeUNVULPRfZSJWthuYO/pvOuPaJaIPlsn4JWQ9HmpkGxgxgnvA/5AK0cvhauZ+Jyire5qAtupktHqJETsoN5tMnP4DhnsMJWwTbNCkK1ZYvk70OTIMSsFRb/JFCWzoZEj7FjjjTnJlQN12WYOaRFe2u0PGNaCkThjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsIlFpAzs5VerXMG6eOCUdoLmKm42CrouONzECAH/4M=;
 b=VziXEqmPIlQ5L7z8szfZQVxD5L3qcN8kBezqVR5+iThFgBD6ILxQvyRAIbzfOSAcZPoj05SaM0pC7ZNFTgF67WAa5sV72+mRvWiDP8mOHaS2PBoH3wbL5Who28EX/1ZuyHCdbkGmvMbUi0uyJUmc7ZbwIXbxpUyeFsgpM8FmLGY=
Received: from CH5PR02CA0021.namprd02.prod.outlook.com (2603:10b6:610:1ed::26)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 13:48:59 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::ec) by CH5PR02CA0021.outlook.office365.com
 (2603:10b6:610:1ed::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:59 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:57 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v9 14/14] drm/amdgpu: add kernel config for gfx-userqueue
Date: Fri, 26 Apr 2024 15:48:10 +0200
Message-ID: <20240426134810.1250-15-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a226fd-e2bc-408e-33c8-08dc65f7a011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7mYIJILR9SKJuLSCZba0uVxKT/g/4Olp6DDOQ07phPN+MOEgqLDlXAz8E7hS?=
 =?us-ascii?Q?XYloMnmcZOxRnLwK06Gvi78gExhg+XUazobXSfXnE5pVeL4KP2woDCqKSPBl?=
 =?us-ascii?Q?Eitp+Hk76VBuEeQ9YZXf3jMup6m3K2Ie4N7wPZc3mCcbTR9VP5YWOZkZgd+l?=
 =?us-ascii?Q?GLjBiGAhhJvFyIZRsEdLcO6PCqY1hmwi4rmdsA2dooKv7hb9adP4W9av/n8P?=
 =?us-ascii?Q?X56op+vfxgfIGSDkVwE7OLbpuoZRifsBvyrLEapQVIAfk8+sp1Bfa3cCcpFZ?=
 =?us-ascii?Q?ToiImI2VcvLo1QfIf+UHEVSpGp6SqH36Ox/G5fyvIt3pSjKye0YLvdbVMDez?=
 =?us-ascii?Q?TCiNefGIuZSDTGAID6vsOPPW2gufTKan7CCoRzoFVxIQ4dL95UzRZhdlbXXe?=
 =?us-ascii?Q?/ZfeMjkf3J8nmgGtUMx3YWxUuK7293lMwlUwa7xYRBXlYKkPJIOEh1h2j5OY?=
 =?us-ascii?Q?VnEpSeez3+Jzii+5LEcKZIv53hD9oJ/wpo/IwiBh0SCfQedAfSQUNsX+jrOk?=
 =?us-ascii?Q?vhI8nX1CvTuS7BZhBWhLfIR7B/BHXgk7orxj+7TsKaT4v2R1w1ipg5nHNLQD?=
 =?us-ascii?Q?5dY/FnMkinCHIGL/kuNsBeoVqDnqYKGgSeXheAmESPDtrFq5+i4tTk5BQhVk?=
 =?us-ascii?Q?jv2S/7JSNeT6Nt78hKw2BssbUAUYzSb9nbdLdKrG2KIxuYilk4mABYi72l8d?=
 =?us-ascii?Q?s+gMO2ok2vSV9uUAvOn1GPEdlzSJvBmTZwtszwFzx4Rj9sn0yFm8jhQSnkfA?=
 =?us-ascii?Q?EBEcSOxk9X5iM4BvLNB0XZUuh3djq5QeKJ0ZSK0kifFLnKGlPsG0MuVUljdI?=
 =?us-ascii?Q?BYyd7B6E2QeIElhFXiBfZn3SOacoWGhGLoXjd7mrsWVX/xx1G20suZaItfdY?=
 =?us-ascii?Q?vLnWGZRe1D7s4TpeMw+bbHFfu9RHXkxA5tW80bWwK4NnUKHqJIHhpLZQzjcn?=
 =?us-ascii?Q?BNaK8UDAjgKKzeLpnZKNKj6Si6M0hgjb8b/QckpVdCg3KuToy/MhBLG+OqdQ?=
 =?us-ascii?Q?7/V0L6txyEwVILNruR9vdmfreMSXa6qsHbZEpsUJCtZrcOfm+VQ6XlT/FyPy?=
 =?us-ascii?Q?kUE68P+X1co34oezn/cj192rANRMTlQZEGpR3MYDop/0knezzLQerADxJTLx?=
 =?us-ascii?Q?6ijmG2llBR8zxsAUnQhsTtIDpKP8Aym7WjvqQ/KzlqIia80CQ82/WGc1D/rv?=
 =?us-ascii?Q?vg5gwabiokEGNIjTVpF+SiDW0ffWfTofkK3Shq+cw5X3ZbIaflK1cIcXXi8g?=
 =?us-ascii?Q?A7/u5mhTPUTGrrpeJGiI1qrnLwxknjNgGXPc9k05EVXnYg18r6dOC/g96bGj?=
 =?us-ascii?Q?mdOUfqY7Bm/Xlq3VxcwpXeAQMqhceKAFVhmET375eWYoVvpabHnJFrm3bdPU?=
 =?us-ascii?Q?TFzAQ2Oda9zJX0fjlRoaPDQg1d7d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:59.5483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a226fd-e2bc-408e-33c8-08dc65f7a011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig     | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/Makefile    | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 22d88f8ef527..bba963527d22 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -80,6 +80,14 @@ config DRM_AMDGPU_WERROR
 	  Add -Werror to the build flags for amdgpu.ko.
 	  Only enable this if you are warning code for amdgpu.ko.
 
+config DRM_AMDGPU_USERQ_GFX
+	bool "Enable Navi 3x gfx usermode queues"
+	depends on DRM_AMDGPU
+	default n
+	help
+	  Choose this option to enable usermode queue support for GFX
+          workload submission. This feature is supported on Navi 3X only.
+
 source "drivers/gpu/drm/amd/acp/Kconfig"
 source "drivers/gpu/drm/amd/display/Kconfig"
 source "drivers/gpu/drm/amd/amdkfd/Kconfig"
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index a640bfa468ad..0b17fc1740a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -184,8 +184,12 @@ amdgpu-y += \
 amdgpu-y += \
 	amdgpu_mes.o \
 	mes_v10_1.o \
-	mes_v11_0.o \
-	mes_v11_0_userqueue.o
+	mes_v11_0.o
+
+# add GFX userqueue support
+ifneq ($(CONFIG_DRM_AMD_USERQ_GFX),)
+amdgpu-y += mes_v11_0_userqueue.o
+endif
 
 # add UVD block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 27b86f7fe949..8591aed9f9ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1349,8 +1349,10 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+#ifdef CONFIG_DRM_AMD_USERQ_GFX
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
 		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
+#endif
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
@@ -1362,8 +1364,10 @@ static int gfx_v11_0_sw_init(void *handle)
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
index 90354a70c807..084059c95db6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1267,7 +1267,10 @@ static int sdma_v6_0_sw_init(void *handle)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_DRM_AMD_USERQ_GFX
 	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
+#endif
+
 	return r;
 }
 
-- 
2.43.2

