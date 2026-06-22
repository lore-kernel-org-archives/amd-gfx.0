Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5931ECD98F2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 19:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E702210E84E;
	Mon, 22 Jun 2026 19:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vt1EaWw1";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D645310E84E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 19:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h98iOmvGZVdkbdObZtGzYEHn4Xe6rAxFDjt1NkbvWiZBHdT6KPDZlCKgm1BbrnBCK8QDBKuwTNWzKiSINvz1urpCBcHXGZNBYaoCPzGC64hpgfGdDxRw4h/z9lCGRIk0aWyBXnoW3sHiLEuQwwmrP2q4bclevKGC+ZcFC1Kjgt961fRONjNaqIfi1PbUhcOPb51LcJge4oLsEwa3Egblf2F2RZ0gDmJbldF72uXtBu/Ii+gIP8hkU6g1X+D7H30J0F7acuBg8fi1VTWvqXdfhO5TDGMRLVo4R68FqSV9HMJWyuXlqYv0BpXIpyT/TcFgWOr94apiKqopgNq+C2Kfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+oq5MJ4+A/A45DScxHmJJpnPDsl49Ap1boqlNTEXcI=;
 b=U5VGqzMyw4a5vEGgjY1YaHLOh447tSe4LsedIqvv1ZZLRYGUqI+4HrPIQ1sVVIamWoKDLMoDroEO6XGbJFTUCngWH7ygWJjlmexQX9wS8p3yEeZYDi9TSd9TeMZ2IaKL08iLaxpypvh6SJQA7u/nefFUdAyJIu8fqhiYTzIiek96Vga7PYtGkwQ69HnF0bmh2TQyTtxvsr2of4M8GpZeSIi6K0RigLceUfcsDLwDMsM1eMB0syzK/A3fKN6aIooXlhLTyePXMRqQEgMj+y+vRtS1LEcBWQMPAOmpEy74GDwlsMrf8FOjDQ9JeKePMcOAZxNkJKuEKy3v7vq38QQeJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+oq5MJ4+A/A45DScxHmJJpnPDsl49Ap1boqlNTEXcI=;
 b=vt1EaWw1yMqLdkr5OTp+qTPqzQKRT/UFcv8BLC5udgH+3UgE01Mx4YfYEhE53n5Uc6ABWRE/xgU4Es+AFgeuPd8S0y37CE6MdGMMqz/FdOjODXrY5OfVx+U7ldh+HoZSdlyUyaXCJJ5dmEwdjL1OaCBntIQU/BvagzlOuPo3RRc=
Received: from PH1PEPF000132F2.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::35)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 19:57:52 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF000132F2.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Mon,
 22 Jun 2026 19:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 19:57:48 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 14:57:44 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v3 7/8] drm/amdgpu: include amdgpu_uid.h only where needed
Date: Mon, 22 Jun 2026 15:57:28 -0400
Message-ID: <20260622195729.181216-8-shahyan.soltani@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 8956bb74-d037-4451-6789-08ded0988949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GNkVMZEX/i+MyiHC3Kn65LC1UGWDxVnu82QuCZL6L1VP+uSDkm/VVCDJ459vx+ry03lqaZ8SvuYqnNNCzx+yY8Yt96fy1fvRYgpLgxIE6auAvGs9TNgeYHjtb3VElr/xSOds8hpt8CwuT9MsXWcQsgDy2ahh+GxtOM8N8Xch2Lk6CP45oXhnFOkcnAUPCirDhbqzDRqpdhiucLZF2+qZ5PQsvVuTknWUrh/2kgRqxpB2US9gIbT7+vkJ9a/EEiZLl8x82FKuHlW5O2VSmgbDU2NW88Nc14c6BN5pXlMYa8xpGM+KT5/+zVWqcgwW9obRGNmid24GDuBRWtB3LwdJdPRARCo0x/hEux98GB/6Lwr2S6Re0zaMeh6N8FhyZE/n/Yi7FR/4GyX9bBt141NE0vZecD7VMwemrfwOry0d48JQgh11c59H2wdnK5A9+XZhMatCUQ/f7uDVZbRzJS4Tn59LuOwkd7bmlLxqgJOTUL1qG9MJMK7Fjjb5qCk6MZmsqG/SHtPfdz8yNNZUqtjyj7uu6dlvZB16N8qagUNZqwTIr7NdC8wputZ+yv9FPI8rPS4FZXWu7Rya0dRyXospyNTg+d42ee5i811wqnIULGAfoBNjKt877f3uPD02RZqegyiIdDa93zYJJws2qNnVdQtXFt7DtZ7bInGt2cjqqIF0NXW25Y0Emg46qaQGpp0/dG7c9Bxp5K2uP2XnUtkUrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uD8ChxZlA8eOe9JJRjDEWI0D4p7MZhq6+j5D4RCnImFFlcQnFXwvWAy24oZ3ONF0iTeceZOqzuH1KrAGcQC+g3+EvkOL5henGYD3+TBfE9P5+y55DvNFfDx1/tx/Emcn5EkdhKCOTN+EG8IhUL8MHuVCPqr7G74c8xItfBR988IwCNeMkmfajfLs38bVrEUoI8Zi1/Uhgo+3MqHXWsuuLsxuZwd2baqmubb88CyiwxTkUucC4dNu/Erw5ZKVp9foxDn4n0FDuQJPiPuFu+bR/yYtgmfDM6wV5lP4/kjztQLONIYDz5ce9DcWeT+Yz6T7DyufitroRNBCjrSLYnSRcE2u3Vn1pUeqNbikuCUZX/V1Qavo0hdGrDQZueJKfLxCIUkhWPxO0QEfFySDyPb+hBucnvnX0hJ4AYqaYFcvT+0b+itbny6gMFLbpc+V9717
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:57:48.9194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8956bb74-d037-4451-6789-08ded0988949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657
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

Remove #include "amdgpu_uid.h" from amdgpu.h and add a foward declaration
of struct amdgpu_uid.

Add #include "amdgpu_uid.h" into files amdgpu_device.c, amdgpu_xcp.c,
smu_v13_0_12_ppt.c, smu_v13_0_6_ppt.c, and smu_v15_0_8_ppt.c.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>

---
This patch and patch 2 can be dropped if moving amdgpu_uid out of 
amdgpu.h is not desirable.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c            | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c               | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 1 +
 6 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fff532bdc6ac..358508120dfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -117,7 +117,6 @@
 #include "amdgpu_mes.h"
 #include "amdgpu_sa.h"
 #include "amdgpu_acpi.h"
-#include "amdgpu_uid.h"
 #include "amdgpu_video_codecs.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
@@ -328,6 +327,7 @@ struct amdgpu_hive_info;
 struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
+struct amdgpu_uid;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8d55658ecb31..f6905f9da587 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -78,6 +78,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_uid.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 88e6eab91bc6..0f2e4d2995b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -23,6 +23,7 @@
 #include "amdgpu.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_drv.h"
+#include "amdgpu_uid.h"
 
 #include <drm/drm_drv.h>
 #include "../amdxcp/amdgpu_xcp_drv.h"
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 12b57a0f4fc4..f61bdc2aed5e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -35,6 +35,7 @@
 #include <linux/pci.h>
 #include "smu_cmn.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_uid.h"
 
 #undef MP1_Public
 #undef smnMP1_FIRMWARE_FLAGS
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ce520f43ab94..799ef8dbe66c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -50,6 +50,7 @@
 #include "mp/mp_13_0_6_offset.h"
 #include "mp/mp_13_0_6_sh_mask.h"
 #include "umc_v12_0.h"
+#include "amdgpu_uid.h"
 
 #undef MP1_Public
 #undef smnMP1_FIRMWARE_FLAGS
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 2105a1d7bb34..c241fe5f2e09 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -36,6 +36,7 @@
 #include "mp/mp_15_0_8_sh_mask.h"
 #include "smu_v15_0.h"
 #include "amdgpu_fru_eeprom.h"
+#include "amdgpu_uid.h"
 
 #undef MP1_Public
 
-- 
2.54.0

