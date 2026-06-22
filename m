Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B109CDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 19:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C027810E858;
	Mon, 22 Jun 2026 19:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3lGJvXeL";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4E8610E854
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 19:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1WdAfxc7QEDB1mMKZ8UApdR9F4DC1O+VaXJ0OGqCYgSCsc++im7rySnYmrRJA5ly3DlFwgX8EimdbvYptwCiLXNwOgMFkn8DsAgdOXKpd54WTI2F0MItSUevkJqxpb8H3aJfh4tf4tLEIkorowlaRUTsmrOsd65/z9G0pniEIRy2ezeutwPOVZ+3MnRHcNLQ2D20E7KfYKvWWBL6zThRNRJCvH5hrO9UzJXKP5vazBlxtR69nOB9OEoAWKh/XJgQQSAIjxL2V4wvTLPKMsOPTtNZzB3cdjt5B2jA62CYQ7Tzp41EMENF7NGxj2wCPzhTtMUVOVYVUmuuC67cuS9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfJ3k1LvA8V4mh3iZT6rJkWDiuWwVHdirZZF6cBTO+w=;
 b=CJYKXHrBH3SFmit5w8Ccv0vgzapOZfweHNIBlIl8+CoNlezUgHH3HtLo63PllI3OFL2ffwFBmfwzWPwYTlgJhUCu5KxRwBCIBzR5nLyVtUcUtuk3Da31HnccucZKTJjrWjzAWBynleaZieJiPABjF7cFrRD4TzQUenB5PUgvROOtl1UjYe87E2ouVlcUtd+uV5snBaHYn1uauZJedLmEFRQQlCaAHqrYZiNlBkqtrNEAaL9AYzxw+iaSSGp2hcG8a4GgjenchFT0SpPyji+7jAosSBVVlpAm2R5yPgKKHUti2uqclIxZP6s0YWXKBrNCtPQNjvoo5IVlRHA+dFah4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfJ3k1LvA8V4mh3iZT6rJkWDiuWwVHdirZZF6cBTO+w=;
 b=3lGJvXeLhp6nrL4WUhauQjEVHCVlmJe0OSVAKa2KwCr4LSg2vnHHdBOXKdtFE9sQEryuPO+TeGiuK/PAGT9dX1u60qJ+FGn4vfmT69wB0iln7mVmjJgXoixKVmXanllZPKpvvBouvmskZBfxDmkCV/LNhyTTe50jMiQTKxviptc=
Received: from PH1PEPF000132FC.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2d)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 19:57:53 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF000132FC.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Mon,
 22 Jun 2026 19:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 19:57:52 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 14:57:44 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v3 8/8] drm/amdgpu: include amdgpu_video_codecs.h only where
 needed
Date: Mon, 22 Jun 2026 15:57:29 -0400
Message-ID: <20260622195729.181216-9-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622195729.181216-1-shahyan.soltani@amd.com>
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c37646-7d10-47ae-4a08-08ded0988bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: quWPVBbGNqOXc2g/P0o1Om5mKITgkouef33u8QUwMOnB2fwCjYhvM0pVenEfoiIbVxh4dCugpuo9aymKYhJP3+yeISXySXdtftdQCtGxciRz/Tu7vurkcbIGiuUFhmdKqMpr3wjwrGfHsGtc5Bfs5QdYxf3wbqPCUXMAgEAIFl08ZB59BDvCWKXWE/hi6y+O2tI/m8fJAHYhKlRCcjDGIopxA7KDhMrcELS7kQ47sdBoPjRKJZC1RJ8m+c0nSXN4m4t3IUPTpdlhhKfwAFskjAChlh3hgVAL9ZfCvJoE/V1uwMFnf1Hk4oxtR6vUbFKUXfCacqF8TaQ8MBqPuYPDz/ld7So1NBE/I//hnY7PdNGJTHfP5iPZg6aWCyLEZtSyFqkXoRF2hFf674dXkbBKFQepJjKdOGHvkMff1t8WY0OYGtMUHAG+i+Es69BkOmkNnjWVE5UKlOL1UngasoAr9ZdnPWAIPFoH+AuWEQ3OmZl1yfhWI6gs0c+pqsLIsbCBLTJdse1X9HmMFvqqqAzloS4xZsGzhjY9DdMDervjQhAay3lLzk+47kPblElyhdZfkJWdplVzgwrpIBTAVA+khzd4rxSZUdrQHTRHM+S/XYeZsTp32uRK55fJijdptK9UDrPSbW6LYZt2Mg/gntA9M1M14I/Ixgw0GF246U3QuyOUIHrZlIy9ClQVaNYl4BmYOAxtzLrzeIrg/AdnL92wtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y1TjNyZwx2koOMYfkztRpTVOLhybKB1I2xPLLa0ATbalITyeYfbe73PKMF/CBtWghq39BBxuz8QIuU5bHDeCxr9RdSJxLcRSnvb+LI/xuYyQGPo1QvWbXv7pOSYeZwL8bGJ/FmwA+guSyP5MrbHLsBTE5PIfrpjKJHzw5YL6jH+zp/m40BnfBBzeU6mGu1vYpHXJaqW+oPXJ1fo6bIhrroDbbNtf13UogmzSpkcTh2BKnSnn+tiK+za0X4b1KaPTIgJLHktYiq+eY99cM7sQmdGkV+JA0GD1bWp37LQvDpTOL8BxBi2mfFXGkTISWOKb5AWEpMAH/DQirXCCvL/d6/pRtzV0gdEZ2PDy7UzjXk1nk0WoL40CZy2IacNmjdWeJZ7TO5CzkWQyHNocsUD41XUIx//j1S9mX908AK+1/GtlYsvMq1u/i/x2TnhCW5Xv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:57:52.9245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c37646-7d10-47ae-4a08-08ded0988bac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509
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
index 358508120dfd..7e06caeeaa48 100644
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
@@ -328,6 +327,7 @@ struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
 struct amdgpu_uid;
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

