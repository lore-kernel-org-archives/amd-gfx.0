Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17784CD8CAC
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 19:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB2310F958;
	Mon,  8 Jun 2026 19:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fZKr7VOW";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013015.outbound.protection.outlook.com
 [40.93.196.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9414E10F958
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 19:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrfdMHT3JsE1O3tEPMyEH17JzweQGhPoN3HQCJNOKkZWauSLiAjQD5mDGfZBBAdJCg49/Vg3r4sbj0ujxZrg7ryLOgp9USN5B5sth2JuQ/T9YE5JM/QmIoZcHhGPfn+8y14e7PlMe5IoES5hdZuSGq8B+oWY8zDOYl+vLdw9EXhixxwFqkO3W2WYcZwmcRDaG3ivBdsC2Lf159JGNYHU82R06LiW+CXyM0HFr8pWgr+LCi+vjhBmS67lvvnTR/1EKKqsFi7uaeY8r8AlwdhRPn+g0F6gIApPhdm05Q2LxUQKanAFSRQ9NpH7MOka1fl2+UE6uZ0rzTU2qXiKaJMIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKmXANEEDTjvJeaFPRLu0pma/JIqXq+6ZhlAJszBATY=;
 b=ZXT/bHJmkTmRp57eS9uLbT2ff/cjwr5GzyOO1dSpTG17bBQsubufD5/bvIX7k3neyjli2Z8ou+vjlU2+Mi27Gh7qFKkgCePTdRTdfZzJd7SVMgm6rgG0v2HFxkAEOEOWAJmA1BT3RpgyaDBg0yazVTnj/JM4wba6Dk5L535P0z1JJ/UubiWHtmhwV9zZAWk1V74Q1JXw5+ipCpBchj8V5XA3AdaHwT3ZhYd2prWu9SNTxcm6acxn7k6QaX4AqaeMxBLdk5LriE9trWjtbEVPP07eAvUTrWIWig0SNsNoBMTNzT4XUAsZgWae8X8jIfX/F5MZWsTa9EE1alT9zDpjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKmXANEEDTjvJeaFPRLu0pma/JIqXq+6ZhlAJszBATY=;
 b=fZKr7VOWqKqBMAJo+//RwD9lExoDohBNUZ3pnVYT0zuIHh9HoGe4t5Ci0W1xi9Z20ImhihcX90amESW2XvMN7nNoTtw1zXhtkeKLJd6OKGuOJcuhSH3R6IAUgUKjwRcvWu1vg0QKrNZ7+hWAaNR9HZO1ruYRTi1ADoGg3rrjvec=
Received: from CY5PR22CA0078.namprd22.prod.outlook.com (2603:10b6:930:80::25)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 19:48:12 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:80:cafe::6f) by CY5PR22CA0078.outlook.office365.com
 (2603:10b6:930:80::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 19:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 19:48:12 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 14:48:04 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH v2 11/11] drm/amdgpu: include amdgpu_video_codecs.h only where
 needed
Date: Mon, 8 Jun 2026 15:47:41 -0400
Message-ID: <20260608194741.1590055-12-shahyan.soltani@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: de70ae40-84cf-4f5f-fc04-08dec596dfb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SHimUZRt7pCHCHmk1LRrPQ243zkgwtXLQiWIlRBBDqpo5Wlb8uO+jRkvEYmyHZFgviahy5vRJG9CI2kOfrKA5x141EdgDsTsmD0rVCM89whF9BMVnPtHOvOXrBVaNCNMxMfQ+OfBn0EpRzU3/R7g77gNWap8yT1cbgMRqzL2zTN3cdaS5XANJ+h1FXgc7tjxa1NQCqrDdIQ5ZopT1IbTYISCnyAWTjJZo2CVn9+5Dov8aTm0Z8gVV3tPSkJcrJPazbGZiGZ8JmWrvN5JkyR8cTSMrzeEGh3ingqIvop8s0QfNFTUm1em7POUdbzAUR/3/6UsbOYItIEkUFtN3OR7UuegC1SdhVIlKAm5/dDL4HR3lPqZigCyF6MiKHxwDNx8/8qQXRze0QBrFph9eCsEqJLiyfZjwIzCSQkBEgSSjY/2i+EwwB4BYkf6bRJZab1r6I6YSxJGU3ZpHuvclj/fKp/08dt0dUL68WZn5kP4uT2kGghyKa/Wjq5Lgu3ju7o7LkWpvHO71OvgaWqTI+PcA1nwrZdTFhXvC/SqADm66WKnBwiMHEwG5s9sfHtFdLI1u5taU0zkrMvUciZPRU1gnapcMXdc0J5nPPHTrYmwHSnn17VitdyCThIkc8FrfPeQeMX2E9yXtjIFEoCAa6HtPGkGIjHla/LOM5x7MNJwlPSUMOxKJH8zS9nRWgLRvuWtFFA48rZ0lqrGpFeqXCP/0F2CicTGrAZwbLI7Qeqv22U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EyP8X39Z56LKFexbO2Q32GX+w0bf+gFBbRm0q6OdvU2rBcSNrEtvDJH5Frs3yvXw4sEA+bcG9rW0SFh9qRiv4FZcf0OTiuy7FwZZFVc1fZfUjCFqz8rOc5utu3kuYsvhf6JRDuTT7iYylbkDsz+T+f6A/IWUYcN7g5YEPG3vg0v9OxzkJa5D2Ldv6FH77/T7k0Q0EFMd7EcKJI6ahRhteqHSn2kCd8Yz4z4Pqp5R9hzBIlS6JotJPsr3ukhrvvtlDPX82Ex31qIckTsxJeUzmmx4zeFvG42JjcwiDjWl/HCYY7TSpmcdBNfnPYmE/8YT2zK61roKSW8AgfP77JWb+lVcmklvnQs3hGL9JJM/s2S+sqGRQBo97dZmNGdNm1bf4R70KLcqSt/E5P7KrPSbpz4qL0jf7ZBo68PQ+0tVyoeTD2hGtDPjeUB8ojN6+CRV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:48:12.1392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de70ae40-84cf-4f5f-fc04-08dec596dfb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961
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
index a733ebb61300..fc1775ffa956 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -116,7 +116,6 @@
 #include "amdgpu_ip.h"
 #include "amdgpu_acpi.h"
 #include "amdgpu_mqd.h"
-#include "amdgpu_video_codecs.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
@@ -329,6 +328,7 @@ struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
 struct amdgpu_uid;
 struct amdgpu_init_level;
+struct amdgpu_video_codecs;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 24526e92f9b8..23b3034753d2 100644
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
index f8e58d12e39a..749de39e8e3c 100644
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
index 29954c7d61b0..72d03a15d68b 100644
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
index 72edf5326b05..09bf861d2d17 100644
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
index c26cb3e8bff6..e003fdfaeceb 100644
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
index 49b9d81cf8ca..3dbd684b8007 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -78,6 +78,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_init_level.h"
+#include "amdgpu_video_codecs.h"
 #include <uapi/linux/kfd_ioctl.h>
 
 #define mmMP0_MISC_CGTT_CTRL0                                                                   0x01b9
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 93c002e511c7..20dd530be3ba 100644
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
index 265db9331d0b..0f470aafcafd 100644
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
index 5f05c8e68297..db26ee4854ed 100644
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
index a256320b92f3..9c2c313ebc6b 100644
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

