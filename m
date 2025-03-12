Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CA4C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E2F10E79A;
	Wed, 12 Mar 2025 18:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Iicuj6uv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD8810E161
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8PqD0f0oSipoSZDfs6sSuq0b1IzJ8rUclC0lzb/0vgGwcT+4kxoHLKR43TTEuZUBHpNAP9tUn4swY0pAgdoqzVQdGq3X8HdPtm3cpThnNbFwnsvEE+jT3zOrVEhDRvlegI2NsAQGB1oZwmvYLF28JYi8iTr88Fzrjxej0o3VrXWcrAMC3q2Hf7Vm7wUUD6Lm2JBJhcSCbNUfTsRf2aTsRjuppZhKhZ6gT24nnAwpmF81Wx1NVolzzL9bLeNFHnagd8l/zduqvW4Roy6FfW44ZKPujdmupz7zHNSuUtRlX1JikftShwJ/LM78L7X69L3UaPoGtLGWqh1p3c6BFPVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9v50qX7Xds1b1mbTQng2Bnzn/DtWgowPeCKVC+UbXP0=;
 b=hUOm8byvOe2biJOlhRta+tDEUDB+ArDxfCtEkftZI9Twz3UEWtCUlpp6Vny1jcAR7HZ6dgaNDFW4kdPWqO7aT3rYyaqsj0Z9agalG0T+blhUIOw2Rpwy84Lc1MzX7oSSbrElWJ+QKhW3i9hiRORD43xHlczukMZusiWg5GA3yhrUiO/igKWVl0WqVXKk8HP1/Al6CEejMflK5Vbys/nbEMKyFdzTzgKkLrwaGwrQsKvIQi3MUYCEy/t36VkCYxj/jDNwHImAV2B6RFTGqvEyeF5GEaPrWcd7JWlgMvSQ7VkmiOPJhThfLuOA3wvxrDakXP24q4hQDsZI4Jz1BU19Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v50qX7Xds1b1mbTQng2Bnzn/DtWgowPeCKVC+UbXP0=;
 b=Iicuj6uvx6Gxa//YSdUdhaQtciMwkpmCEkNw6ttQxCphpNGoaN1wWD8sOWJJOtNVQTiWbYykokM6lqbHI3uJwV7s7VP7W687RsrFr6O36tYV/GIk7PXvBWyyrnw+1/w4/TLKMaRpSyYeRYVKCTcrlgBN+swPkEbfSTes2xYwhWM=
Received: from DS7PR03CA0215.namprd03.prod.outlook.com (2603:10b6:5:3ba::10)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 18:57:48 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::da) by DS7PR03CA0215.outlook.office365.com
 (2603:10b6:5:3ba::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Wed,
 12 Mar 2025 18:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 18:57:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 13:57:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 01/11] drm/amdgpu: add parameter to disable kernel queues
Date: Wed, 12 Mar 2025 14:57:21 -0400
Message-ID: <20250312185731.211350-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312185731.211350-1-alexander.deucher@amd.com>
References: <20250312185731.211350-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: c49f4036-3f85-47bd-68d2-08dd6197c80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zhlK7YuFIZUOJ4AQOUGt/pxK2sJFHujtS3ikpP2I4QW6YjdRQ0cGF1zUhZES?=
 =?us-ascii?Q?0sP4hh3jGi4Tyk62tFOfl3UAPTMpuwbVHI4bFzNoc7CYQ5Ks/06dWJRB+SZh?=
 =?us-ascii?Q?1WJ//vyULSLaHhuzmkPdJzLin5kWJMzcVeWl1vIEBa3EufQRcEjNY3J5vuOX?=
 =?us-ascii?Q?g3KU3K1q4z+NmL2hsHRLCpwMVQIKIkLdr2rX0Gt6n5kcAFZyi1MpmjfG4JuL?=
 =?us-ascii?Q?/+ZUs5HaiXV/TNhdtH3ggqkHroPL3G0kNqjHNkUYxtZfissqeea1ieeEUonJ?=
 =?us-ascii?Q?yXmn7X5xgB2+jwFiajQ/vMV7KaVSdY3lwwJm4Lek/QZiBj6TA+RGx6zkvdNF?=
 =?us-ascii?Q?mp+AYLga4ALV4HO7mLOXGUCMtdw13YwnliGN37l9Rn/zUKqcwjYxaU97+gE4?=
 =?us-ascii?Q?cCjJwkbbA2sYjGvlrSdGGJnKuY7qarGMqT8aiYNavTphNWn+qQMbngu9YyIE?=
 =?us-ascii?Q?VHFM/cTrVtHGxtXdd6LEPsmcL+xf7EVzba3H5NUiop+MHEwE2mI7YtGvaA1D?=
 =?us-ascii?Q?yBbnHn6ULbMbvL6zZ4MsdjTnn/tIODchVD6J9O0Z0AoNbq3KIou17/YKtaVy?=
 =?us-ascii?Q?SrueUap+YhH/NIa8xiiV32lFJYhjv4LY/+uyjo2H70LkQO1RAtfSpYibj94s?=
 =?us-ascii?Q?l7fa+GAgRmEE2vP7JVeQRmTwpY7ClNtaIUyTQW9mpuv6AOB6GBinxPxCmsHY?=
 =?us-ascii?Q?zXvg/J144sjhXZRKHiJ9KvM63jE/erRe2XNUL8lxD+JVZQ1t5rPSePMwax3e?=
 =?us-ascii?Q?BVB+Z+T8uC7ycZLb7zdGZ1Ha6MJU71kmE+kqEWyzGFcC09c4KXkOW3B/4+8e?=
 =?us-ascii?Q?7/ioi3v4Hboxpb990QmRlZ/7/c5OOqaOANjsNVkEMe3V/fe1JBZwzkg6ub5U?=
 =?us-ascii?Q?hlSaMzNcaL+dcviUGyd6b6LM9TQqsHQTpW4+YSRWbN8tnXfJb4LG0ljamhSZ?=
 =?us-ascii?Q?A5cQ6vX/cuTeVglKthkZny5/Lbh2qBpVYVxdSsbOH/90x2+Ydmhx9OIlcukN?=
 =?us-ascii?Q?ZChXaCtXBejvAGD5JRfRrA5Dg+r7CPLCtwQB5g4ac6wNSJOucBUkC1pKwxdW?=
 =?us-ascii?Q?Jy35pU/p7VMqmh1D6zvDVEQtMsNr16oPQyKL+FN5U8EKw6vSTglkreDGrkm7?=
 =?us-ascii?Q?gul/omLDOFJhHjF+T95+h5KHFGe2q6sdS5TmZLv5HgXwNYpKTRFjousjsx8w?=
 =?us-ascii?Q?v7TFo97RTSeywlKLN/5CANzlL1UoGpqzipU9fZJt/e/35EVYtba/L/S3SxPz?=
 =?us-ascii?Q?mtK4B3JNuSVuAPtiBO1SxSsbVAN4UN1AO5u05lRG2RNHudoMegG5YW2GbGZQ?=
 =?us-ascii?Q?TH4gf6j1DdAOLS/VLdm0QVXzbugVex8lzOXrHERn+eVAVZOCm/1GnraB7uRI?=
 =?us-ascii?Q?rs8xIZ2IHL4h6MmTpKGduAGT7mNdHYJNPMwZbE7UykzWqRy9m6fwSjCmnPzT?=
 =?us-ascii?Q?lZwkxODhSAbIFcHQb4iBpEEPz2b58heQfE4PCnpBJHufnpLTazJZeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:57:48.0106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c49f4036-3f85-47bd-68d2-08dd6197c80f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
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

On chips that support user queues, setting this option
will disable kernel queues to be used to validate
user queues without kernel queues.

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 87062c1adcdf7..45437a8f29d3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -270,6 +270,7 @@ extern int amdgpu_user_partt_mode;
 extern int amdgpu_agp;
 
 extern int amdgpu_wbrf;
+extern int amdgpu_disable_kq;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ba8111169fa99..f50a25fb60376 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -238,6 +238,7 @@ int amdgpu_agp = -1; /* auto */
 int amdgpu_wbrf = -1;
 int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
+int amdgpu_disable_kq = -1;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1084,6 +1085,14 @@ MODULE_PARM_DESC(wbrf,
 	"Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
 module_param_named(wbrf, amdgpu_wbrf, int, 0444);
 
+/**
+ * DOC: disable_kq (int)
+ * Disable kernel queues on systems that support user queues.
+ * (0 = kernel queues enabled, 1 = kernel queues disabled, -1 = auto (default setting))
+ */
+MODULE_PARM_DESC(disable_kq, "Disable kernel queues (-1 = auto (default), 0 = enable KQ, 1 = disable KQ)");
+module_param_named(disable_kq, amdgpu_disable_kq, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
-- 
2.48.1

