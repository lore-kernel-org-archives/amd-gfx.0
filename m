Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE2CCD8CA4
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 19:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418E010F956;
	Mon,  8 Jun 2026 19:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LnHQfdCV";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D9F010F957
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 19:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWYarIKhzVN/iItLVCsN9wQn65OJzRQGtvkafsMVQtKQrtQVoiy5fh56Vo/703IzIzteroP7BbVglRi69spv6Wu/B2szI4mimKIIjsg+Acwu3YQ7K0DKs3kH1rAegBqFqITYMRI2rqqXz+ix8V3LrNpj/Ozcvk/i/QgRl4Q93kKfxLbf6pv2qEuvSYq38Rpu3G9QNjUn0l5pdKcn0tIna9g3N7eFPD4RnVyNjYwheA+3pRh7DqH+v2XWLirAot3/M8Ys6XcIwUy3itWY5HCfZr416Knrb03/s1BK5yC6E3/2PLUmYMjKQxjGC75is9yyNRtap2vEvemKbnmWoxF5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNSYLOgp/3aOW5moflSUIyNS79s/FHWxvhq9XyyZf4M=;
 b=KIYMHsB/TUrkquhnWf5dHf0ZdZBQtACqOLOMvX8+jzPnucQ8l0jr9GtdMQ3mxdivlgeswh7TmPn4LMnT6OZBBvQzIqSllet5NCq+BHptnYu1SGdc7ZhNUFpGodu5UgxPX0nO1F5TOkAw3Z079rclkTPAnfwpMq92vWj8UuB30Tj2g9MiZZEGsS43GrM/m3uWxtbfM4uigmu2kKQMHSJzfD6d03vLTUyveaWNKBxZ9sYAEQWGbaDfjEO/ShtuqDOM26YBByR8R9TT3UARppNH+RMZyUQXnsadqUsNcgCjp+nVccm+mYw14Oo87st+7heijtu7lrTr+Hp8/2jEbraIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNSYLOgp/3aOW5moflSUIyNS79s/FHWxvhq9XyyZf4M=;
 b=LnHQfdCVtHv9eqBkot2a4DiMMHswQspr7uyGX4mWGKjVAZYfdmnUuNrNBYCDhgPbCo/mE2y1u82I4IQ2HB6RwN1VwUy2zwSBEJie2iNGM04yNjAWHrrBzu7+ZzwAS6/sAd/TdrlMGb5hkE9kF6bM3bqNoW8itIiCTXHtdR4teZg=
Received: from CY5PR22CA0061.namprd22.prod.outlook.com (2603:10b6:930:80::6)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 19:48:11 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:80:cafe::35) by CY5PR22CA0061.outlook.office365.com
 (2603:10b6:930:80::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 19:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 19:48:11 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 14:48:04 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH v2 10/11] drm/amdgpu: include amdgpu_init_level.h only where
 needed
Date: Mon, 8 Jun 2026 15:47:40 -0400
Message-ID: <20260608194741.1590055-11-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608194741.1590055-1-shahyan.soltani@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8b8e98-9e38-4b4b-314a-08dec596df3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Q85O5r9ykNx6Uxv58JRS1aQFJKiwvgw2WuUDNPxVx9pXVdA35rBCj7R14dr4S5ZlHMD9LeM3OFP/Ts3G2ZP1MWIL5vQDs25PyEYGDRiRDtFZ0+dMwMXNsjVwD92kUKHDSbqyPOAjvMo1l4Z+M4Oa8ntbncWAkjnFM+P+oAH01CxlbuOeL9ZlvHrB6WQsQ8OXmQl4QO9Qk/1klStBHFAKcKbVI5fHPA6M23n0C98Z1Q/PJMz+gAHpVeWe1BD2W/FGP473I4oofF9tPeiUkCs7K65EGtlY/dCK3OEsafsAvkcn3H+IgAAsXPMKAxEnobvREF/JdmR47PKR5Wh8fgKrFdeS3EBkBzTVbg0rrkX316TXkPv9lPSvlygInx/favwrsCX7CUZjUqQV2wlJzPxfaraW/mzI18Tiq1AUKALvF20wIBOJmWSqlogeidsQpLSHJysQIjKzlCcTR42HJ743dKtXWpAYuLm0NUQGzdo2akb4idPLNYx6+TK3ylntg+DklB2CEQFeWHLFm0TG1yDleDH2gw7svjxRIrj5Ag6ABc2fC+IqNW0CsV0cJuBkAgQ5dKrhGJhE8V/vFKQ+BaiB18jTWK+5AL6GQ6oN3JoMA2O50+0tkuLMxu+6OKxF/Jjz2tsqGBuGh/YHUskHMhTyDc3r9qj6WOTL7/MoXKTnemU0QKv9aXHDVeUpEw1IhupqdPRrmcINhFZ+BMSeR5qyE1rXuh348zF+AwVanHLh/74=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V+AKx9SO1g5gF4oFqmDeF+LTdNQiH90YGyygoA/aaGlTZe2wi8cTiZJnCzk1ocC25LXAJgSfHvtSOxwJ6mug6ikePZ6H3bBPPaSpzAiRFmH+FWos24zX0DL6mb9SdXKOK8xejjsW65MzsIBFkqQGciPApX4cxttt57VAMFolwX4aTwh5MjFNMrEug1Mgnsefnq9tCNaJCVy2qAFXeE3hH0YB66qZMXkZKZ8TY9S3Uln+VhTfGyTDGPQHJI2Fe4Gm9flG4bCQ8C1W32vN43fk44yOzZrirZCsXXM4UGjQTd2wZgJAD6aQps+TW9yGg5c9t7j3nGFJ1U/iTjf+6EsqeCEEuvOYvmDUfQxZd23vWX2LcLaUVTPToG1jE0cQ75HAwI8u0FDnhzUu+x7fRA+4a51aRufybvMBKMjEiEHdZvzvUyk9oQcqX7D2ZvAQkcWr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:48:11.3409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8b8e98-9e38-4b4b-314a-08dec596df3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136
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

Remove #include "amdgpu_init_level.h" from amdgpu.h and add forward declaration
of struct amdgpu_init_level.

Add #include "amdgpu_init_level.h" into files aldebaran.c, amdgpu_device.c,
amdgpu_gmc.c, amdgpu_reset.c, gmc_v9_0.c, sienna_cichlid.c, smu_v13_0_10.c,
soc15.c, amdgpu_pm.c, and smu_v11_0.c.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c         | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h            | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c          | 1 +
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/soc15.c             | 1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c             | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 +
 11 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index a7bc65099755..197876021b73 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -30,6 +30,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_init_level.h"
 
 static bool aldebaran_is_mode2_default(struct amdgpu_reset_control *reset_ctl)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 06e61d66dcf3..a733ebb61300 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -116,7 +116,6 @@
 #include "amdgpu_ip.h"
 #include "amdgpu_acpi.h"
 #include "amdgpu_mqd.h"
-#include "amdgpu_init_level.h"
 #include "amdgpu_video_codecs.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
@@ -329,6 +328,7 @@ struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
 struct amdgpu_uid;
+struct amdgpu_init_level;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 20b67897d7ff..e7e60dba1e4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -79,6 +79,7 @@
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
 #include "amdgpu_uid.h"
+#include "amdgpu_init_level.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 13bec8461cde..e55fa66f7daa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -35,6 +35,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_atomfirmware.h"
+#include "amdgpu_init_level.h"
 
 #include <drm/drm_drv.h>
 #include <drm/ttm/ttm_tt.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index da77e0ef129b..78121e698151 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -25,6 +25,7 @@
 #include "aldebaran.h"
 #include "sienna_cichlid.h"
 #include "smu_v13_0_10.h"
+#include "amdgpu_init_level.h"
 
 static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ced0f3941863..8b0aaa912a8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -64,6 +64,7 @@
 
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_init_level.h"
 
 /* add these here since we already include dce12 headers and these are for DCN */
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                                                          0x055d
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 2594467bdd87..940092d8bd1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -30,6 +30,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_init_level.h"
 
 static bool sienna_cichlid_is_mode2_default(struct amdgpu_reset_control *reset_ctl)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index 70569ea906bc..93bc343fdfeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -28,6 +28,7 @@
 #include "amdgpu_ring.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_psp.h"
+#include "amdgpu_init_level.h"
 
 static bool smu_v13_0_10_is_mode2_default(struct amdgpu_reset_control *reset_ctl)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 87b398dd0769..49b9d81cf8ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -77,6 +77,7 @@
 #include "mxgpu_ai.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_init_level.h"
 #include <uapi/linux/kfd_ioctl.h>
 
 #define mmMP0_MISC_CGTT_CTRL0                                                                   0x01b9
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 0c58d23013f4..2b138c85cf60 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -27,6 +27,7 @@
 #include "amdgpu_drv.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_dpm.h"
+#include "amdgpu_init_level.h"
 #include "atom.h"
 #include <linux/pci.h>
 #include <linux/hwmon.h>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 98e7109bbc95..0ca961177c7c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -37,6 +37,7 @@
 #include "soc15_common.h"
 #include "atom.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_init_level.h"
 #include "smu_cmn.h"
 
 #include "asic_reg/thm/thm_11_0_2_offset.h"
-- 
2.54.0

