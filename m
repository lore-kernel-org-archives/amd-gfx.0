Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202F6C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 08:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584FF10E700;
	Wed, 30 Apr 2025 08:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rod6agkU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357DF10E700
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 08:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPKEV7+NmoqCNqq8gdTOxbLbKjHl6DVAoRshNgY96EksEUM+HxwFRu0vAfb/ASmSq2uE9ru428nqwII56UcDsXiBhidMT9UJ7jaG29rbwXlWfKWC0fe8SWFVx3NGlVf62knPq7l3Hfw1CMTOSfKJTTDlcgdkMCspGVS+mBdT897vbrZFdgCXZxeqGt0AqmltsSgBWHyqU/Tlf+jSKQU0y+MbCX4z09/g0gveB2PIhz8rQN4SZSwFGh8juium/KHe1IRW8MxMDhXGb/KX5a9Ww+eNgdpjFAzrFlxbkzVpv6m+flyu1ww7Z4YnWXjhx2cBw9MAHSZkBCiDqfS0fQDZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJiSyPkLc/qHj3U30jGMB8YyQMwnYbxj0ATSDCAlgQg=;
 b=ZxGrLcGnukCypdYxW9VbySSyRlN9MelhadPybvzDlOEkQw3vZA70zIrXZBCSywG7yL2S6vuRBia4/ATfmKWTxwDT+vdDhrdyta6jUDrmHzkGfVWX5usNaUF2c/FK1fQ85DLE7VWtOlf7uMiCft7RQq8eJYxlxv57BkA0my4qZkkq7ea0HumWb4fx++FK3yY0T45qU4YnWPWuGyIQ33TjbuOPi0Fc/oB+UTc6pfgDKNzDdiH9ItFZD/iynT2BBlAsAicvQPq4X4QqFES3hdrrh7kkz2XGLdxdKErXu94CCINe1x8AccjwISNcJ/CxbmEPiMdBaZ3d3WxpSB8Mx+BG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJiSyPkLc/qHj3U30jGMB8YyQMwnYbxj0ATSDCAlgQg=;
 b=rod6agkUrGT7DGtFbgSOrSb57k3h7lSDsNvKrtrKd2fGtSi3FUMdCSP52HkT4ncuMVvU6VKVxZ8G/uHHI0Chd6hx1HfKyutul6lJzfVmg7YxY/wkiAOYiso/OOCJeRK1D29zqJ/Bqx3D2JBSTiL4ox0FJhSyvYhdC8kkkbKdA0U=
Received: from BY5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:1d0::16)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 30 Apr
 2025 08:26:05 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::6) by BY5PR04CA0006.outlook.office365.com
 (2603:10b6:a03:1d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 30 Apr 2025 08:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 08:26:04 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 03:26:02 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: add get_retire_flip_bits for UMC
Date: Wed, 30 Apr 2025 16:25:46 +0800
Message-ID: <20250430082550.60109-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430082550.60109-1-tao.zhou1@amd.com>
References: <20250430082550.60109-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 06280498-7963-40b3-2432-08dd87c0a5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9D41UmDJsgsw9ahi5ZpuInp02stxZORSreOArRycgGe/EjZ/3jGP7stURhef?=
 =?us-ascii?Q?n+mAOquqIrKfE0+DwosXITSJj4IdS6KuI3FZwK2JDd34L+YGmHhb9MqXWe/h?=
 =?us-ascii?Q?p9RTGDaJ0f0raknvMSlR5yPEyFfnPGIHei35+ilRO8saoEy3bPgHr+XdcmPJ?=
 =?us-ascii?Q?qVbbRH4W0dMMMRRqNKVEHAAF+LdXwW3IBSdVIbrSUn3RAgzsAQAmNoQyL/F9?=
 =?us-ascii?Q?T/cRNwXmt2B7ebktdQ0w9Z2sDN4AnVfi4fsFLOqDaBchFLR/JuBrpGRb2ES+?=
 =?us-ascii?Q?s3QCOUe7vjw3PNj/i4wtYrBKcQnMa/pcvalgdSGDZhsRR7/cFh5uJSu2qv5M?=
 =?us-ascii?Q?zgvl4r5c9URAXeDwK4916PrBdjAF8/6u5suaLGIAS9jPAGAvDhAQjbTKG0VE?=
 =?us-ascii?Q?PL44fivel4zSon85mANXe6Hr+CTIdFdv8YNQwEUGYkMgujW5b2V3580gP2Z6?=
 =?us-ascii?Q?tuxaTY5xm5hbqHyX1l3/CY60wa47c025kqa9P5LnRPsmVpI0fTvQbshNcEGD?=
 =?us-ascii?Q?4TDZMqbsOGhdNnXan8cXn9HMUh6E8piYtAR2XXZoFqp0ZWlbGmMy42zcJhZ7?=
 =?us-ascii?Q?Gc/VYpYUVJaMw83uDaxAsoh9Ps0f+imwrtzukp2+G4Iz24eKtTwLyzDIufLU?=
 =?us-ascii?Q?j6xzNQ39kjR9s9Y2btbuzZSiblcREWgU0C4/BrVTdZfuJKU3rfAK8ycqokv8?=
 =?us-ascii?Q?OCTjnIkuWW2DpR0dZXNjnrvn4oavDQ/gq2h/JJYuwbjibS+5CnWrDgLlW9tY?=
 =?us-ascii?Q?uVIlySPKRACaKAx7dmbXbPDB5l2nw0z2W8WadIjRSxZuTYwKPMmeS+CdtD8g?=
 =?us-ascii?Q?rN7fRGjg8aSGgGHMe7kmk263+sm03VxlSWUh3ZxfZQPf1rKB9r3kmthVkpfz?=
 =?us-ascii?Q?lCowIcQI+23t8Xp29vzD6j3bacoUpbJ0ZXaCLWpLrUSybL5EL1lpr8k+wpMs?=
 =?us-ascii?Q?kFdterD4BFJXV46MA27TP25GbdXvjyk0baW+QKHp6E8WUolYnzXfTMsc0V61?=
 =?us-ascii?Q?+xkbiv2ApX6tkcOiM1asfjP2Nbdk1lbrTSIIHOja2C8V6cA89pblgcb77PRs?=
 =?us-ascii?Q?Oj0Om/+9k5ZGJ6j5Kx40PS2LsyNtm1VFBng9ICj/yT3KT7hbu95aJ2Apfg7j?=
 =?us-ascii?Q?gI9d1D6Ywlu4BhR7xzbRhSPPawhm4BljIujM1pMOXmOA/GoPJJxDaL0yD1vS?=
 =?us-ascii?Q?2F5220qIHC3bLcnmSgrlAwH6fCqOkJvKayUWzml8QQdHhhqnsBrLwIdy7OpT?=
 =?us-ascii?Q?3qOGYVV1lvxj0tQAsSEvTpSOWpcws6ikTQZprEOZ0oNuU1VHFXxmGlu7h2sY?=
 =?us-ascii?Q?yY4AO33znFSIWhp3A0+aN/QVerssCXCQkd9uP88L9ntsxTTjkkBlDcxiWq7E?=
 =?us-ascii?Q?LC/qex6JBNCohbs4aoRUbA/a23aV0DPkx7U19U+6URd68Y1Gcoev7Ud7lJiV?=
 =?us-ascii?Q?WWpdfAxYbTI83goIsrMBeAKuhd5xPxD3J1Bdp9i+MJVhi2m3ml7v/TKuO6c5?=
 =?us-ascii?Q?WNS+oAAMXBwnD6tN22WAK2ZfoFkJKHwROA0T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:26:04.2623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06280498-7963-40b3-2432-08dd87c0a5e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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

Add the general interface to get flip bits for RAS bad page retirement.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 32a8cd64d29a..a5a853894ab0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3474,6 +3474,10 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 	if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr)
 		control->ras_num_pa_recs = control->ras_num_recs;
 
+	if (adev->umc.ras &&
+	    adev->umc.ras->get_retire_flip_bits)
+		adev->umc.ras->get_retire_flip_bits(adev);
+
 	if (control->ras_num_recs) {
 		ret = amdgpu_ras_load_bad_pages(adev);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 857693bcd8d4..78a8b8654573 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -78,6 +78,18 @@
 #define UMC_NPS_SHIFT 40
 #define UMC_NPS_MASK 0xffULL
 
+/* three column bits and one row bit in MCA address flip
+ * in bad page retirement
+ */
+#define RETIRE_FLIP_BITS_NUM 4
+
+struct amdgpu_umc_flip_bits {
+	uint32_t flip_bits_in_pa[RETIRE_FLIP_BITS_NUM];
+	uint32_t flip_row_bit;
+	uint32_t r13_in_pa;
+	uint32_t bit_num;
+};
+
 typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst,
 			uint32_t umc_inst, uint32_t ch_inst, void *data);
 
@@ -100,6 +112,7 @@ struct amdgpu_umc_ras {
 			bool dump_addr);
 	uint32_t (*get_die_id_from_pa)(struct amdgpu_device *adev,
 			uint64_t mca_addr, uint64_t retired_page);
+	void (*get_retire_flip_bits)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_umc_funcs {
@@ -130,6 +143,8 @@ struct amdgpu_umc {
 
 	/* active mask for umc node instance */
 	unsigned long active_mask;
+
+	struct amdgpu_umc_flip_bits flip_bits;
 };
 
 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);
-- 
2.34.1

