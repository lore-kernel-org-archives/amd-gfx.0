Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2428AC282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A44AB10E329;
	Thu,  6 Mar 2025 18:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HTNRSLBY";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06AC210E329
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbakYTLQCK0v9hS93HnTZgi+p+qVa53eyliFsyN2szFC33fz2dI1p8aI0P9z0q+HVl3fksgTmEma+zLgf+FCYQj4qV+BqNh7hGE3BMFaCllwNuOKDAZNMUxWSRPWnj1xZX3iyumjObPFkzGDHiBoGR6FcVHogvZ/4ugHM6Y3gxPsjWc3uI5ecvW/hKemyu3jM4fldG9nSJPRJEm5vzN254X9WU8NHB7QbXgAFTrYlFKmDccDZAZ23XEMzRVYdSP0J7bgTV0PTzaTVi0S98Lh0xP6P9mO0KFrnbM+QHnfSj82o87g3FjsrJ1QD2nwi3rRQKazeaegZgVWPOFzL0uAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ka1a9wsOMH7Xf//Wdv04QPQAxao39nybQfj1OdXyNdo=;
 b=EMxx4ogfDQWwPgvbFWpVrYWY2kmGespmZsISVD5wi3CPdhAveUBNCdIK0OswQE8co+LoKxsmarPZO/Q1cpygSGhYRxnQ7Gv+2++rhH68TuUlkz+VZmL3IaGPVSRMwWRM6loJ9N0mDrIAD37gJ3mMmjOvvVuKi7kXZK68Sd0o5Gw3mupgJ3CYoO+LiORgzqCa27mI7E9OEml1AdD+8FnGU/C9ee97fsNtR01+1DUWajgeUdFGjBx/Ble/k9fStnxjVCMpS/YMBXbXk1va/xOuBBelcACuL1ICgAy+0Q29L4+QnVE2ExVr5Wdq20u/xf4Ebv7e0wAM0+KOqkO6ETHV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ka1a9wsOMH7Xf//Wdv04QPQAxao39nybQfj1OdXyNdo=;
 b=HTNRSLBYVuuhCBt5s4FLHIZSHcFd2FQ9ofMchP0vjiWZG8vMnqdch/1svpG7KyOmFGOSH2FGu+qQC/WNfkNWdKy5E0YEx2D78+MITdM0AeHgp+xVxmqwHcjfxgFbjzvbUieWyXCJtpBvknlvMK4sC1KKigFnxterpepLhw9DHmQ=
Received: from MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10) by
 BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 18:46:26 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::28) by MN2PR01CA0041.outlook.office365.com
 (2603:10b6:208:23f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 18:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:46:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:46:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 01/11] drm/amdgpu: add parameter to disable kernel queues
Date: Thu, 6 Mar 2025 13:46:01 -0500
Message-ID: <20250306184612.8910-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306184612.8910-1-alexander.deucher@amd.com>
References: <20250306184612.8910-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 05548fdf-cd10-4d57-60fd-08dd5cdf333d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GNGTmmyt6ENk0etngLFp0JIfXKGIV0pYnXTVX7TDY//EapbzdOMm8Ej2QxkQ?=
 =?us-ascii?Q?DN6GY9/+BnB88GQ3TYYAtUff5RSl/SEsKd+OCYsmS4/UogJmHdUGqIEWw90n?=
 =?us-ascii?Q?hhwE/sHLtDAFgmNcIX+6sK0j8pOpUJ+o8awzY/XuRBA98dP/uh6ZmURbwJEL?=
 =?us-ascii?Q?ZE3embCRpdDVLey4noosVQt7ow5E1fGiI1LKcH+3T9NGG+A206UGk48Xjstz?=
 =?us-ascii?Q?un+HViPNeoBSYKOSSBgsk6yRhu0wWc81KX5wKUhDl5MQ4RjTopRh5L14pN2S?=
 =?us-ascii?Q?lKx8CEGMTUUO1k6slP8uLm17IpuNo1PsjnyWj8ys8ntJSi8rFlddvNovNNOQ?=
 =?us-ascii?Q?6ew7bWsuQbVDgV2tTNBmHySVsKfFa4j7SlgPaRG4pVboAtIMLgCCcCEpE5IT?=
 =?us-ascii?Q?pF5Sy+rLctXiuPPDdLj9CnQ+wRBNObF97+oEVv6836VmCmTPzmvm7o8xYniP?=
 =?us-ascii?Q?/i4OecZRWKiXpq319CYmy92A4zeA6/j8Wdtol6ibuMwgk05BzjHn7IQpphM+?=
 =?us-ascii?Q?qBAjIRnjCYaV7+xA3R32+Cjdl15O4VBDVERwYwDDYmvTWNUtw7fAq0fXVTol?=
 =?us-ascii?Q?ajzTsa1mQmEFFRUxc3QFKf90rDGnO2GzOXbB/Cjbrw9UQGObyxsjI8z6dzaR?=
 =?us-ascii?Q?ucwNe1pT1N1bCrR5rat8Pfyxai/jR+mOkymwaPsQDuWOfYUG3lJ/6KZmGbck?=
 =?us-ascii?Q?7pPpVAuedtPOezMDVJw80fx+KX02dRjmQqwSogQFFqohTFLlNfzoWSsW88h0?=
 =?us-ascii?Q?8imApncDYDSLa46YzaQE2YyRedoH6yXSKJaSnS1VlE+kD2/fmvI2zDQTsaJZ?=
 =?us-ascii?Q?GtQbwfG3fddCIqnpQagwmsnvnYdq5oH6eJHCgrMcLTwOc/0whV3Ptsq4/NGM?=
 =?us-ascii?Q?2OLK/N5uLeR57Ns+1RcJbzbo3zozeQfcKQdH9mtVHBMZVXJlSYWlOwUvHdFh?=
 =?us-ascii?Q?7oIrCJRFEXc4i/9SoLEDLebgQIxbzutiCmqJ2asF0WY2+stzqslIl7F6yEWj?=
 =?us-ascii?Q?qgzYePYt+qoghEFJ8K2ug+c0UCzVqKrR2rrj6aiFSzbTA4rooyfi0GknfNYp?=
 =?us-ascii?Q?j4cFMo05x9xjJdkm9xZYD20OYPTpoKK37pibOptmjt7y3wkWVbUrODi8mi55?=
 =?us-ascii?Q?ZQH09BGz6mUHtTOJTMgSKyGKtG3RcOrBWHI3Vj98yufkbnaUHOEMO9hXKB9x?=
 =?us-ascii?Q?F/pGyZxmQPhuJu1qWxf1ZG0dRc1ETUM2uGceCRKdsY7hZG0dw9g3hhFqZcxz?=
 =?us-ascii?Q?UpJU1YiwhmX8i+b4+Zfwj0+lb/EFR/izqt1GgG3aqrOo/e/+gadsBtxLv//j?=
 =?us-ascii?Q?rv+lreqdxCT2qjVaPjMGgXmRAQdsMudKg1cp8VqohnqTkdicbk7Sx8/+BrqJ?=
 =?us-ascii?Q?wxwNH8oggxP9i+UDthgdFA6lQlsyazTj4WOWbZAeYBdjyjbWpUeA4SQfxLmm?=
 =?us-ascii?Q?MQY1rkJa3IwmMjjqKG2cHnQVJfX4vXnYhEhgu3sLCqRN0ujK9gKNnUs8bAhW?=
 =?us-ascii?Q?eqWTmVKp55D1go0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:46:26.3132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05548fdf-cd10-4d57-60fd-08dd5cdf333d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922
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
index b161daa900198..42a7619592ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -237,6 +237,7 @@ int amdgpu_agp = -1; /* auto */
 int amdgpu_wbrf = -1;
 int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
+int amdgpu_disable_kq = -1;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1083,6 +1084,14 @@ MODULE_PARM_DESC(wbrf,
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

