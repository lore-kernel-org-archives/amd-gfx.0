Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756B0CDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 17:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1137210F002;
	Wed, 24 Jun 2026 17:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0QmVL1nH";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1191110F002
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 17:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgwcpJxSgMrmEHBrtMGinwQCKz4Xged3cM95MvpwjXhpHVMMc0E2aA0xZyNGoURdRG3LUple+7e10qIoPh8im1L1d5Ev+T1+k9SmyNp1AQMS6oUHb/7LxHJX28ivf0DK4y7X1JWT0F/y9kdQWXJvizJ4+5K8BnNK2GmEbfveCXm+uomjmYppAN6h75SGMfp2LClJmRuVU3T3KkOzRmS8cq75+JK069/yhoembNstf9YDVzg1IyRtnDqY/HhUhQWPdoV6cGLGP4dY1n6Un3GDbGgQF+/+H9rkf8bl1Yw/pguH8jEgqT9ZhLOy8Wl6efZ4rzLYtUbxlZ7x0blP1i/FhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEqXvWy9UucbmCaahO9dZehn7jsjUdedLZ6XYVs2fsY=;
 b=S/5CqOKCxYMwS4TcjVZGXbcvKKCa23v4fSN26qSk/Wt9EOnuXFk/JDFbPajTl5uc1mRn3B6+M89hAvUUcZg9dnN/oELTZlCiTTq1BwA5jS23wnl/vzA0WJpDVSDltBN3yD791sv6moqUMkfus/P6CXEUXMQA03F07T/KEvA/IzjvtQ9p5yLlrr71BE072oc2MG+ESrETu3PDFr9sX5Dxf6Yhl3BWBX5O/bSkw29PDk54J72Xd593Iw82Jb5fraTryBd+RQ3phR6xygNklj07t/s7SnX4uAuHhtI81cKA1y/H8A6gFuCYl4EbwtJRaP2U3lvVZH+a5F+GGjIBGb8qvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEqXvWy9UucbmCaahO9dZehn7jsjUdedLZ6XYVs2fsY=;
 b=0QmVL1nHkULAvE+8g6zRE/lJyDqgTKzh/8R2f0O1SSoIPwxNCrS6/nQbfbiilVPKHMZhzsd4mzfMuZ61cu3sQT+PNmMyBcjl80e9RT2dYvm3ZD8EagfPPBIlOxA1uupGo7YchLFYKWfXBJGoFwq9Cui3zkIqwPm1tHKWLc4aTBs=
Received: from BN9PR03CA0168.namprd03.prod.outlook.com (2603:10b6:408:f4::23)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 17:56:11 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::1d) by BN9PR03CA0168.outlook.office365.com
 (2603:10b6:408:f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Wed,
 24 Jun 2026 17:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 17:56:11 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 12:56:05 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v4 6/6] drm/amdgpu: include amdgpu_video_codecs.h only where
 needed
Date: Wed, 24 Jun 2026 13:55:07 -0400
Message-ID: <20260624175554.489406-7-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624175554.489406-1-shahyan.soltani@amd.com>
References: <20260624175554.489406-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: eef4cb8d-9dcf-47a4-d526-08ded219e05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EBO6JOjdu0j7r9Zb6xPv5e+WYXosa/PKZoKtkTYqWDgXNX0s2jnnYuOCUESS6NpCKuyvw/Tl6sTNL6dZkjf/wsogEG0Xph0dcQ8OJkGamFutMAL6t5R3XCLyS4RM1Zg5gybnvtu62tgEDrvy44pAO6vL4YOdagZ8kdfwRqKMTVHrhUejyhARNXA0jIz9iwJN4FJTasUo0+TI+ovvBdT4oZ5cUsiULu8sF6xUhS7d4dKh+8DTbCiFrdcEQuC4oUQjEhdQ/PpeCyRuU4tutNZwQgia4m39QjgQPYNMzTx0Tduuyt2pQLAnKg9XTilRFBdqynxvyaoWEE5oKCkTNAH6WJH++YZdeW6tU2lP7257PL1xjko5UKhJBUkzI4k+LZncW/t7WB3yE8d3NmT5SdK5Qa2/pxJGRlNXwmswlV+R9aKqyClKWEO/lpbjC/wYPoZIGKTfb4zcjfj4FPnwyp/jxvht3WN4boeADsyF0AaWpBM4eDR1Hvvk00iWr+GK1eaRFm0ubN2CJ8uCVvwnL2llAcF5NKFyxKD+e+ksTeQVWjkhCvNoVetKuUuhe6cAvDcS9BkdbrsEl2aJ4WG986qb2ubQAsNvY0RuKS4E0iD7bWWPgTujonPdc9kV8+q1ZFuX1mBiegxL4ZLKjpJZJtsLK/Wga+dqTHeLotZ16En9ARtqWqDm6dihq7AmiDDleWj2HGojKiwZrY9FwqG8KDcYQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZFwrBpY3tZavgNgn/KdfaAqEbGG8ifqSwoY0f/JnpbseRph7b8Nt+Wo12ME6BeJEWdPhDXu6xeE52xxyzIenZjMCCt8UGvYosR2160LgST3gj0PEnYXxa+3EPXgZoJb18Krf54uf6pF4OPfwKKquPkMS+F8J6LLxsSaYiDEsHEL9fBu6lMoKCbrNrIutU+J/vcMF5zWwaENY/SA9UDQ2dtSrwyaaeXoxlWlHcEMLn1MG3u+2Mffm2ly9qYO/zLDKsvUgZ0LI+JSxDrxft+IJqbNti7o7OY8RcgVvyL2OW5SIQkpRMEv6qzrea8fReIt54Lg+2lUyJVHS9gtXqmAv7J6DK1J78F2TTJJGGzJ7wUYu8O1WeHsoAO8/Y5O7ESn7uRDDp+43q4lKOqT49nyqLhX4N/MKswozKQbaTkmSmbJXFA83AvcrVpbgUduP9Uzi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 17:56:11.2887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef4cb8d-9dcf-47a4-d526-08ded219e05b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142
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

Remove #include "amdgpu_video_codecs.h" from amdgpu.h and add forward declaration
of struct amdgpu_video_codecs.

Add #include "amdgpu_video_codecs.h" into files amdgpu_kms.c, amdgpu_virt.c,
cik.c, nv.c, si.c, soc15.c, soc21.c, soc24.c, soc_v1_0.c, and vi.c.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
 drivers/gpu/drm/amd/amdgpu/cik.c         | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c          | 1 +
 drivers/gpu/drm/amd/amdgpu/si.c          | 1 +
 drivers/gpu/drm/amd/amdgpu/soc15.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/soc24.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/vi.c          | 1 +
 11 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 020b79c9ca78..9ffaaad93ea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -117,7 +117,6 @@
 #include "amdgpu_mes.h"
 #include "amdgpu_sa.h"
 #include "amdgpu_acpi.h"
-#include "amdgpu_video_codecs.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
@@ -328,6 +327,7 @@ struct amdgpu_hive_info;
 struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
+struct amdgpu_video_codecs;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cacdc99b3ad6..6b4de2a6c629 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -46,6 +46,7 @@
 #include "amdgpu_reset.h"
 #include "amd_pcie.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_video_codecs.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 7b0d42510161..c792e3088b76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -34,6 +34,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_dpm.h"
+#include "amdgpu_video_codecs.h"
 #include "vi.h"
 #include "soc15.h"
 #include "nv.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 77e120a72815..e037c08c8547 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -36,6 +36,7 @@
 #include "cikd.h"
 #include "atom.h"
 #include "amd_pcie.h"
+#include "amdgpu_video_codecs.h"
 
 #include "cik.h"
 #include "gmc_v7_0.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 77557ee3ca16..96faaf8c5737 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -36,6 +36,7 @@
 #include "amdgpu_psp.h"
 #include "atom.h"
 #include "amd_pcie.h"
+#include "amdgpu_video_codecs.h"
 
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index b104469c38ec..6e455ad66d62 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -35,6 +35,7 @@
 #include "amdgpu_vce.h"
 #include "atom.h"
 #include "amd_pcie.h"
+#include "amdgpu_video_codecs.h"
 
 #include "si_dpm.h"
 #include "sid.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index ed3fd58b78d0..3d4573d93742 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -77,6 +77,7 @@
 #include "mxgpu_ai.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_video_codecs.h"
 #include <uapi/linux/kfd_ioctl.h>
 
 #define mmMP0_MISC_CGTT_CTRL0                                                                   0x01b9
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 223702e5c220..685258b29fe9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -33,6 +33,7 @@
 #include "amdgpu_ucode.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_smu.h"
+#include "amdgpu_video_codecs.h"
 #include "atom.h"
 #include "amd_pcie.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index e5e3a460e486..9a658e4837f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -34,6 +34,7 @@
 #include "amdgpu_smu.h"
 #include "atom.h"
 #include "amd_pcie.h"
+#include "amdgpu_video_codecs.h"
 
 #include "gc/gc_12_0_0_offset.h"
 #include "gc/gc_12_0_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index a9039fb1a77b..43e92e2a85e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -29,6 +29,7 @@
 #include "gfxhub_v12_1.h"
 #include "sdma_v7_1.h"
 #include "gfx_v12_1.h"
+#include "amdgpu_video_codecs.h"
 
 #include "gc/gc_12_1_0_offset.h"
 #include "gc/gc_12_1_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 5715b6b596af..514715793f78 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -34,6 +34,7 @@
 #include "amdgpu_ucode.h"
 #include "atom.h"
 #include "amd_pcie.h"
+#include "amdgpu_video_codecs.h"
 
 #include "gmc/gmc_8_1_d.h"
 #include "gmc/gmc_8_1_sh_mask.h"
-- 
2.54.0

