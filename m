Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C86CDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 19:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD1210E842;
	Mon, 22 Jun 2026 19:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F9m28gWk";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3F8610E842
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 19:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3xXSCQqCZWFnVM4RVGlX5c2ahftGI7NTVUOKNG/fi+niFo5A0hDaLKAyZISGh6g083qEeRQtOe838BK+8r3KpmZDVUSJfXDjGVxu3Y13mdICCKS4PtBXNtTesKvs/pP6ohgWPnTudX1q7rTo5KuhJ+anSaPJWvhRvQV543q3rtn+jidjQMgDKouXZXyDU2YQ6nrWkEm1QJ4E4bj8ksV3jNJDDjZCOzi+R3cmWQYkJb9aDSZUGbyWFn4nEtICDLhhxP0yM1O+sfeplP5zNasM4KGdZwTIby0l2hjb+immj0atmcc1X5PgM8rKJ3F2AfTmGllz5ACy42GCbHO++cfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wLsVtwsPUDnhVJ7siJ3AF1K6/uuM0Y+Tghz6YyYAYs=;
 b=PjoWIoeDHBneI5G/Kh1JnEKgHjrJSbI/WEW/Ujw+qJF8KexxOozxc8iJ4W4SJqbO06P3zAbnOwFZfO7zr13TzJDhvre0/5JlNE5xpaaU8NN2+bcvRk8VQ21vh7cLAuUH90k6tjPJOHnXohKidbFB28tVCQvjE2QGnpA6xYGv2HPN2Y+wabtXIQGDmMmKatjm5C9Eb4GpcF9iwyJoRw+jEz8dpuzVpoEfq0LnKRX2XFqygRDP2TWpNy/JnGSxb0MOO4J23zboZNB1UKcDCtjw/Ha6d8hey26e6i59+aZgHZBg2W767iCNv/C2LeX8ZVcY5KiaAK3QcE5BNDI70ntvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wLsVtwsPUDnhVJ7siJ3AF1K6/uuM0Y+Tghz6YyYAYs=;
 b=F9m28gWkr/FEmVa7zlhVgQs3jF9MqqekLrRbqNxuaTtv0bdgERi2TCOQu+L9DorZ0SurGdLbJa8fg30dfIo9WXsBddychuLAgwPzxaDluvEAm3mIyYr+nkJdxZpNDMvYkE3pPY1h4T7q/e9JYlTln3MtEW2GWtASA8mf5maLBPY=
Received: from PH1PEPF000132F4.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::39)
 by PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 19:57:43 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF000132F4.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Mon,
 22 Jun 2026 19:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 19:57:43 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 14:57:42 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v3 1/8] drm/amdgpu: move struct amdgpu_wb and helpers into
 separate files
Date: Mon, 22 Jun 2026 15:57:22 -0400
Message-ID: <20260622195729.181216-2-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622195729.181216-1-shahyan.soltani@amd.com>
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: dabcbe62-33ba-4141-31aa-08ded0988626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: USePnAzSD+e1R+MWSi3eGpraZytx3cZaC81fVQExdKvqbSzxdgWrDZW4HSoLg5kcH7sbImiWrMtEwZtnK2d8VGSDbVwbcvDfW4GkIiWaHiB7fkzNUjA7YbjjdXwkVy0JFBhC+KPJhWxYLQCOwj+gEu3e3YyRFp4bJOfa81gbxNnzKg/jx7c0DWmBzPVdloeLlbNOw5e+Pij9f0DyT8da27mnTneLeyUhxu+kBFdNDWG1S6RARKKQCF2JNoF79hBFa8jWMDgJNSWLpH527H1nmxKS/ODQul6JV6ZsnssP0v6mzdOp3gS92cCS/tajoulADALpXgcjLGKGJ8q1K0I7T5sOSAR5X6tL5MvBFZZqYPQcGhEx6Zb5kWfbzh92O+AGIRHkn3llJABs06F0JGXzE/IIefGh2yJ5gbMbVmLNWYARLF3l6dOFcL9hRI4fuyE3I9QsNUXHwXdh1AInEQ3prAx1A8qJL2Q8V0N2Lkof99HT2VJb0CrLdVrOz0ZuVOLX+HbrpIMwg5PwIu+ObsTd5beztlBaix8YwgVjui8ocCIPVdG0UGIBnZzIfaMamMXbOvhhbDxD/dV2HKE8txXlPwbL2PD0wsyOSfrvZjQf2sA5n3/rqQ+B2lCXzAYCB4rAVj7SPONPPwc2YOx7iIsRu9BHP4XrpyMiLoe4IHr1L2FF2auVvb46BAqjkulQpRuokeXbU4ZmwF7abvsXnqiNJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w74R4NjwPap5uS3IM7f0eZncr4GlUfft+pyyNiwgdJyNlSxkuTnyBE2t6LxXcp451ibLDxbbX+NHe9PFzOplC48TUF6FfEbxWJuWlUrJhkm3eWV971+au0DiMHWMg71Dp+pAAKYftpMQoCK1OijsgvI+Fm6ThaXGzhMJq9xiI+ObK15kx0xBh5M2Yi7LucngsJjI/URd+2s2HSMOmp1J3qy7FkkbBYVc/71hB50tr7uYdm/4tB7bt/eKvT/Lr6+K95OBX4tBHYzEMatfAptc30UF9qp/WORd7zs9bI59R9MiZN+an/UNOxLG3+9FSEt/wBmyV4LIAB5H/VWPDNraMsvP/6xtGtpnR/BMlS5PViEON/d/HmgsvOAb4ifDKu0vxV0ulUAlz2itEk3XlrAiSX/d6jg1ueFuoI3hBoDXAptoQBN1MjbbbFHvlynTXenb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:57:43.6577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dabcbe62-33ba-4141-31aa-08ded0988626
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799
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

Move struct amdgpu_wb and helpers out of the monolithic header amdgpu.h
into its own dedicated header amdgpu_wb.h.

Move functions amdgpu_device_wb_get() and amdgpu_device_wb_free out of
amdgpu_device.c into new dedicated amdgpu_wb.c file.

Rename amdgpu_device_wb_get() and amdgpu_device_wb_free() into
amdgpu_wb_get() and amdgpu_wb_free().

Update amdgpu/Makefile to build amdgpu_wb.o.

This is part of the ongoing effort to reduce the size of amdgpu.h into
their own respective separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

---
Following v2's feedback functions amdgpu_device_wb* was renamed to amdgpu_wb*
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |  68 +------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  45 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c       |  14 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c      |  16 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  18 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c       |  71 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h       | 100 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c     |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c          |   8 +-
 33 files changed, 283 insertions(+), 224 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ba80542ead9d..10dc7cfd607e 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -71,7 +71,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
-	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
+	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
+	amdgpu_wb.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b68aea97c166..4ffcc0cc6404 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -113,6 +113,7 @@
 #include "amdgpu_reg_state.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_eviction_fence.h"
+#include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
 #include "amdgpu_sa.h"
 #if defined(CONFIG_DRM_AMD_ISP)
@@ -429,73 +430,6 @@ struct amdgpu_fpriv {
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
-/*
- * Writeback
- */
-#define AMDGPU_MAX_WB 1024	/* Reserve at most 1024 WB slots for amdgpu-owned rings. */
-
-/**
- * struct amdgpu_wb - This struct is used for small GPU memory allocation.
- *
- * This struct is used to allocate a small amount of GPU memory that can be
- * used to shadow certain states into the memory. This is especially useful for
- * providing easy CPU access to some states without requiring register access
- * (e.g., if some block is power gated, reading register may be problematic).
- *
- * Note: the term writeback was initially used because many of the amdgpu
- * components had some level of writeback memory, and this struct initially
- * described those components.
- */
-struct amdgpu_wb {
-
-	/**
-	 * @wb_obj:
-	 *
-	 * Buffer Object used for the writeback memory.
-	 */
-	struct amdgpu_bo	*wb_obj;
-
-	/**
-	 * @wb:
-	 *
-	 * Pointer to the first writeback slot. In terms of CPU address
-	 * this value can be accessed directly by using the offset as an index.
-	 * For the GPU address, it is necessary to use gpu_addr and the offset.
-	 */
-	uint32_t		*wb;
-
-	/**
-	 * @gpu_addr:
-	 *
-	 * Writeback base address in the GPU.
-	 */
-	uint64_t		gpu_addr;
-
-	/**
-	 * @num_wb:
-	 *
-	 * Number of writeback slots reserved for amdgpu.
-	 */
-	u32			num_wb;
-
-	/**
-	 * @used:
-	 *
-	 * Track the writeback slot already used.
-	 */
-	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
-
-	/**
-	 * @lock:
-	 *
-	 * Protects read and write of the used field array.
-	 */
-	spinlock_t		lock;
-};
-
-int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
-void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
-
 /*
  * Benchmarking
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5442a1fc1c37..d6931e1184d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1063,51 +1063,6 @@ static int amdgpu_device_wb_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-/**
- * amdgpu_device_wb_get - Allocate a wb entry
- *
- * @adev: amdgpu_device pointer
- * @wb: wb index
- *
- * Allocate a wb slot for use by the driver (all asics).
- * Returns 0 on success or -EINVAL on failure.
- */
-int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)
-{
-	unsigned long flags, offset;
-
-	spin_lock_irqsave(&adev->wb.lock, flags);
-	offset = find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
-	if (offset < adev->wb.num_wb) {
-		__set_bit(offset, adev->wb.used);
-		spin_unlock_irqrestore(&adev->wb.lock, flags);
-		*wb = offset << 3; /* convert to dw offset */
-		return 0;
-	} else {
-		spin_unlock_irqrestore(&adev->wb.lock, flags);
-		return -EINVAL;
-	}
-}
-
-/**
- * amdgpu_device_wb_free - Free a wb entry
- *
- * @adev: amdgpu_device pointer
- * @wb: wb index
- *
- * Free a wb slot allocated for use by the driver (all asics)
- */
-void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
-{
-	unsigned long flags;
-
-	wb >>= 3;
-	spin_lock_irqsave(&adev->wb.lock, flags);
-	if (wb < adev->wb.num_wb)
-		__clear_bit(wb, adev->wb.used);
-	spin_unlock_irqrestore(&adev->wb.lock, flags);
-}
-
 /**
  * amdgpu_device_resize_fb_bar - try to resize FB BAR
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 982b41606d48..4dffbc95c89c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1170,7 +1170,7 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
-	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
+	if (amdgpu_wb_get(adev, &reg_val_offs)) {
 		pr_err("critical bug! too many kiq readers\n");
 		goto failed_unlock;
 	}
@@ -1213,7 +1213,7 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 
 	mb();
 	value = adev->wb.wb[reg_val_offs];
-	amdgpu_device_wb_free(adev, reg_val_offs);
+	amdgpu_wb_free(adev, reg_val_offs);
 	return value;
 
 failed_undo:
@@ -1222,7 +1222,7 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_read:
 	if (reg_val_offs)
-		amdgpu_device_wb_free(adev, reg_val_offs);
+		amdgpu_wb_free(adev, reg_val_offs);
 	dev_err(adev->dev, "failed to read reg:%x\n", reg);
 	return ~0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index a6419246e9c2..c2a10b41804a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -75,13 +75,13 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 	} else {
 		unsigned wptr_offs, rptr_offs;
 
-		r = amdgpu_device_wb_get(adev, &wptr_offs);
+		r = amdgpu_wb_get(adev, &wptr_offs);
 		if (r)
 			return r;
 
-		r = amdgpu_device_wb_get(adev, &rptr_offs);
+		r = amdgpu_wb_get(adev, &rptr_offs);
 		if (r) {
-			amdgpu_device_wb_free(adev, wptr_offs);
+			amdgpu_wb_free(adev, wptr_offs);
 			return r;
 		}
 
@@ -90,8 +90,8 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 					    &ih->ring_obj, &ih->gpu_addr,
 					    (void **)&ih->ring);
 		if (r) {
-			amdgpu_device_wb_free(adev, rptr_offs);
-			amdgpu_device_wb_free(adev, wptr_offs);
+			amdgpu_wb_free(adev, rptr_offs);
+			amdgpu_wb_free(adev, wptr_offs);
 			return r;
 		}
 
@@ -131,8 +131,8 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 	} else {
 		amdgpu_bo_free_kernel(&ih->ring_obj, &ih->gpu_addr,
 				      (void **)&ih->ring);
-		amdgpu_device_wb_free(adev, (ih->wptr_addr - ih->gpu_addr) / 4);
-		amdgpu_device_wb_free(adev, (ih->rptr_addr - ih->gpu_addr) / 4);
+		amdgpu_wb_free(adev, (ih->wptr_addr - ih->gpu_addr) / 4);
+		amdgpu_wb_free(adev, (ih->rptr_addr - ih->gpu_addr) / 4);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 6c0dde3786e3..7fbb6677d5ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -183,7 +183,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 			 adev->mes.sdma_hqd_mask[0]);
 
 	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
-		r = amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs[i]);
+		r = amdgpu_wb_get(adev, &adev->mes.sch_ctx_offs[i]);
 		if (r) {
 			dev_err(adev->dev,
 				"(%d) ring trail_fence_offs wb alloc failed\n",
@@ -195,7 +195,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		adev->mes.sch_ctx_ptr[i] =
 			(uint64_t *)&adev->wb.wb[adev->mes.sch_ctx_offs[i]];
 
-		r = amdgpu_device_wb_get(adev,
+		r = amdgpu_wb_get(adev,
 				 &adev->mes.query_status_fence_offs[i]);
 		if (r) {
 			dev_err(adev->dev,
@@ -263,9 +263,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 error:
 	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
 		if (adev->mes.sch_ctx_ptr[i])
-			amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs[i]);
+			amdgpu_wb_free(adev, adev->mes.sch_ctx_offs[i]);
 		if (adev->mes.query_status_fence_ptr[i])
-			amdgpu_device_wb_free(adev,
+			amdgpu_wb_free(adev,
 				      adev->mes.query_status_fence_offs[i]);
 		if (adev->mes.hung_queue_db_array_gpu_obj[i])
 			amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj[i],
@@ -295,9 +295,9 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 					 &adev->mes.hung_queue_db_array_gpu_addr[i],
 					 &adev->mes.hung_queue_db_array_cpu_addr[i]);
 		if (adev->mes.sch_ctx_ptr[i])
-			amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs[i]);
+			amdgpu_wb_free(adev, adev->mes.sch_ctx_offs[i]);
 		if (adev->mes.query_status_fence_ptr[i])
-			amdgpu_device_wb_free(adev,
+			amdgpu_wb_free(adev,
 				      adev->mes.query_status_fence_offs[i]);
 	}
 
@@ -567,7 +567,7 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
 	uint64_t read_val_gpu_addr;
 	uint32_t *read_val_ptr;
 
-	if (amdgpu_device_wb_get(adev, &addr_offset)) {
+	if (amdgpu_wb_get(adev, &addr_offset)) {
 		dev_err(adev->dev, "critical bug! too many mes readers\n");
 		goto error;
 	}
@@ -593,7 +593,7 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
 
 error:
 	if (addr_offset)
-		amdgpu_device_wb_free(adev, addr_offset);
+		amdgpu_wb_free(adev, addr_offset);
 	return val;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 9fd41801abd2..2dec05f2f135 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -264,31 +264,31 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 			return r;
 	}
 
-	r = amdgpu_device_wb_get(adev, &ring->rptr_offs);
+	r = amdgpu_wb_get(adev, &ring->rptr_offs);
 	if (r) {
 		dev_err(adev->dev, "(%d) ring rptr_offs wb alloc failed\n", r);
 		return r;
 	}
 
-	r = amdgpu_device_wb_get(adev, &ring->wptr_offs);
+	r = amdgpu_wb_get(adev, &ring->wptr_offs);
 	if (r) {
 		dev_err(adev->dev, "(%d) ring wptr_offs wb alloc failed\n", r);
 		return r;
 	}
 
-	r = amdgpu_device_wb_get(adev, &ring->fence_offs);
+	r = amdgpu_wb_get(adev, &ring->fence_offs);
 	if (r) {
 		dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
 		return r;
 	}
 
-	r = amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
+	r = amdgpu_wb_get(adev, &ring->trail_fence_offs);
 	if (r) {
 		dev_err(adev->dev, "(%d) ring trail_fence_offs wb alloc failed\n", r);
 		return r;
 	}
 
-	r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
+	r = amdgpu_wb_get(adev, &ring->cond_exe_offs);
 	if (r) {
 		dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc failed\n", r);
 		return r;
@@ -401,11 +401,11 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 
 	ring->sched.ready = false;
 
-	amdgpu_device_wb_free(ring->adev, ring->rptr_offs);
-	amdgpu_device_wb_free(ring->adev, ring->wptr_offs);
+	amdgpu_wb_free(ring->adev, ring->rptr_offs);
+	amdgpu_wb_free(ring->adev, ring->wptr_offs);
 
-	amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
-	amdgpu_device_wb_free(ring->adev, ring->fence_offs);
+	amdgpu_wb_free(ring->adev, ring->cond_exe_offs);
+	amdgpu_wb_free(ring->adev, ring->fence_offs);
 
 	amdgpu_bo_free_kernel(&ring->ring_obj,
 			      &ring->gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index cd707d70a0bf..3985d56008cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -272,7 +272,7 @@ static int umsch_mm_init(struct amdgpu_device *adev)
 	adev->umsch_mm.engine_mask = (1 << UMSCH_SWIP_ENGINE_TYPE_VPE);
 	adev->umsch_mm.vpe_hqd_mask = 0xfe;
 
-	r = amdgpu_device_wb_get(adev, &adev->umsch_mm.wb_index);
+	r = amdgpu_wb_get(adev, &adev->umsch_mm.wb_index);
 	if (r) {
 		dev_err(adev->dev, "failed to alloc wb for umsch: %d\n", r);
 		return r;
@@ -288,7 +288,7 @@ static int umsch_mm_init(struct amdgpu_device *adev)
 				    (void **)&adev->umsch_mm.cmd_buf_ptr);
 	if (r) {
 		dev_err(adev->dev, "failed to allocate cmdbuf bo %d\n", r);
-		amdgpu_device_wb_free(adev, adev->umsch_mm.wb_index);
+		amdgpu_wb_free(adev, adev->umsch_mm.wb_index);
 		return r;
 	}
 
@@ -380,7 +380,7 @@ static int umsch_mm_sw_fini(struct amdgpu_ip_block *ip_block)
 				    &adev->umsch_mm.log_gpu_addr,
 				    (void **)&adev->umsch_mm.log_cpu_addr);
 
-	amdgpu_device_wb_free(adev, adev->umsch_mm.wb_index);
+	amdgpu_wb_free(adev, adev->umsch_mm.wb_index);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 7bf74ff93fbd..2b45010b7ebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -789,7 +789,7 @@ static int vpe_ring_test_ring(struct amdgpu_ring *ring)
 	uint64_t wb_addr;
 	int ret;
 
-	ret = amdgpu_device_wb_get(adev, &index);
+	ret = amdgpu_wb_get(adev, &index);
 	if (ret) {
 		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", ret);
 		return ret;
@@ -818,7 +818,7 @@ static int vpe_ring_test_ring(struct amdgpu_ring *ring)
 
 	ret = -ETIMEDOUT;
 out:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 
 	return ret;
 }
@@ -833,7 +833,7 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	uint64_t wb_addr;
 	int ret;
 
-	ret = amdgpu_device_wb_get(adev, &index);
+	ret = amdgpu_wb_get(adev, &index);
 	if (ret) {
 		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", ret);
 		return ret;
@@ -872,7 +872,7 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
new file mode 100644
index 000000000000..616339959813
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+#include <linux/spinlock.h>
+
+#include "amdgpu.h"
+#include "amdgpu_wb.h"
+
+/**
+ * amdgpu_wb_get - Allocate a wb entry
+ *
+ * @adev: amdgpu_device pointer
+ * @wb: wb index
+ *
+ * Allocate a wb slot for use by the driver (all asics).
+ * Returns 0 on success or -EINVAL on failure.
+ */
+int amdgpu_wb_get(struct amdgpu_device *adev, u32 *wb)
+{
+	unsigned long flags, offset;
+
+	spin_lock_irqsave(&adev->wb.lock, flags);
+	offset = find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
+	if (offset < adev->wb.num_wb) {
+		__set_bit(offset, adev->wb.used);
+		spin_unlock_irqrestore(&adev->wb.lock, flags);
+		*wb = offset << 3; /* convert to dw offset */
+		return 0;
+	} else {
+		spin_unlock_irqrestore(&adev->wb.lock, flags);
+		return -EINVAL;
+	}
+}
+
+/**
+ * amdgpu_wb_free - Free a wb entry
+ *
+ * @adev: amdgpu_device pointer
+ * @wb: wb index
+ *
+ * Free a wb slot allocated for use by the driver (all asics)
+ */
+void amdgpu_wb_free(struct amdgpu_device *adev, u32 wb)
+{
+	unsigned long flags;
+
+	wb >>= 3;
+	spin_lock_irqsave(&adev->wb.lock, flags);
+	if (wb < adev->wb.num_wb)
+		__clear_bit(wb, adev->wb.used);
+	spin_unlock_irqrestore(&adev->wb.lock, flags);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h
new file mode 100644
index 000000000000..21b82849ad07
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef __AMDGPU_WB_H__
+#define __AMDGPU_WB_H__
+
+#include <linux/types.h>
+#include <linux/spinlock_types.h>
+#include <linux/math.h>
+
+/*
+ * Writeback
+ */
+#define AMDGPU_MAX_WB 1024	/* Reserve at most 1024 WB slots for amdgpu-owned rings. */
+
+/**
+ * struct amdgpu_wb - This struct is used for small GPU memory allocation.
+ *
+ * This struct is used to allocate a small amount of GPU memory that can be
+ * used to shadow certain states into the memory. This is especially useful for
+ * providing easy CPU access to some states without requiring register access
+ * (e.g., if some block is power gated, reading register may be problematic).
+ *
+ * Note: the term writeback was initially used because many of the amdgpu
+ * components had some level of writeback memory, and this struct initially
+ * described those components.
+ */
+
+struct amdgpu_bo;
+struct amdgpu_device;
+
+struct amdgpu_wb {
+
+	/**
+	 * @wb_obj:
+	 *
+	 * Buffer Object used for the writeback memory.
+	 */
+	struct amdgpu_bo	*wb_obj;
+
+	/**
+	 * @wb:
+	 *
+	 * Pointer to the first writeback slot. In terms of CPU address
+	 * this value can be accessed directly by using the offset as an index.
+	 * For the GPU address, it is necessary to use gpu_addr and the offset.
+	 */
+	uint32_t		*wb;
+
+	/**
+	 * @gpu_addr:
+	 *
+	 * Writeback base address in the GPU.
+	 */
+	uint64_t		gpu_addr;
+
+	/**
+	 * @num_wb:
+	 *
+	 * Number of writeback slots reserved for amdgpu.
+	 */
+	u32			num_wb;
+
+	/**
+	 * @used:
+	 *
+	 * Track the writeback slot already used.
+	 */
+	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
+
+	/**
+	 * @lock:
+	 *
+	 * Protects read and write of the used field array.
+	 */
+	spinlock_t		lock;
+};
+
+int amdgpu_wb_get(struct amdgpu_device *adev, u32 *wb);
+void amdgpu_wb_free(struct amdgpu_device *adev, u32 wb);
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 120da838ac28..b703ef1fe340 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -605,7 +605,7 @@ static int cik_sdma_ring_test_ring(struct amdgpu_ring *ring)
 	u32 tmp;
 	u64 gpu_addr;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -635,7 +635,7 @@ static int cik_sdma_ring_test_ring(struct amdgpu_ring *ring)
 		r = -ETIMEDOUT;
 
 error_free_wb:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
@@ -658,7 +658,7 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 	long r;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -699,7 +699,7 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 76d4c33a6e65..98e6cee19a16 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4080,7 +4080,7 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -4121,7 +4121,7 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4315a6b6c1be..cc275d40d587 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -627,7 +627,7 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -668,7 +668,7 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f8280cc81a66..e350582fff26 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -507,7 +507,7 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -548,7 +548,7 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 30a38190f98a..f99760ac653a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -320,7 +320,7 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -361,7 +361,7 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 59728dfd8a7b..dfcc3943bf65 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -876,7 +876,7 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	uint32_t tmp;
 	long r;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -917,7 +917,7 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f836621c46eb..3da5a17af1ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1232,7 +1232,7 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	uint32_t tmp;
 	long r;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -1273,7 +1273,7 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
@@ -4267,7 +4267,7 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
-	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
+	if (amdgpu_wb_get(adev, &reg_val_offs)) {
 		pr_err("critical bug! too many kiq readers\n");
 		goto failed_unlock;
 	}
@@ -4315,7 +4315,7 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	mb();
 	value = (uint64_t)adev->wb.wb[reg_val_offs] |
 		(uint64_t)adev->wb.wb[reg_val_offs + 1 ] << 32ULL;
-	amdgpu_device_wb_free(adev, reg_val_offs);
+	amdgpu_wb_free(adev, reg_val_offs);
 	return value;
 
 failed_undo:
@@ -4324,7 +4324,7 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_read:
 	if (reg_val_offs)
-		amdgpu_device_wb_free(adev, reg_val_offs);
+		amdgpu_wb_free(adev, reg_val_offs);
 	pr_err("failed to read gpu clock\n");
 	return ~0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e50a66e9ee96..0b1ea4c643a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -459,7 +459,7 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	uint32_t tmp;
 	long r;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -500,7 +500,7 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 5ad8dd18dc67..77f159593b88 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -520,7 +520,7 @@ static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
 
 	if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
 		return 0;
-	r = amdgpu_device_wb_get(adev, &fence_offset);
+	r = amdgpu_wb_get(adev, &fence_offset);
 	if (r)
 		return r;
 
@@ -548,7 +548,7 @@ static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
 	r = -ETIMEDOUT;
 
 out:
-	amdgpu_device_wb_free(adev, fence_offset);
+	amdgpu_wb_free(adev, fence_offset);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 9e27d01cbfa3..8b87422be24e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -194,7 +194,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		timeout = 15 * 600 * 1000;
 	}
 
-	ret = amdgpu_device_wb_get(adev, &status_offset);
+	ret = amdgpu_wb_get(adev, &status_offset);
 	if (ret)
 		return ret;
 
@@ -266,7 +266,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		goto error_wb_free;
 	}
 
-	amdgpu_device_wb_free(adev, status_offset);
+	amdgpu_wb_free(adev, status_offset);
 	return 0;
 
 error_undo:
@@ -277,7 +277,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	spin_unlock_irqrestore(&mes->ring_lock[0], flags);
 
 error_wb_free:
-	amdgpu_device_wb_free(adev, status_offset);
+	amdgpu_wb_free(adev, status_offset);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index d80a983b1b6c..05633b98f4e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -175,7 +175,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		timeout = 15 * 600 * 1000;
 	}
 
-	ret = amdgpu_device_wb_get(adev, &status_offset);
+	ret = amdgpu_wb_get(adev, &status_offset);
 	if (ret)
 		return ret;
 
@@ -253,7 +253,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		goto error_wb_free;
 	}
 
-	amdgpu_device_wb_free(adev, status_offset);
+	amdgpu_wb_free(adev, status_offset);
 	return 0;
 
 error_undo:
@@ -264,7 +264,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	spin_unlock_irqrestore(ring_lock, flags);
 
 error_wb_free:
-	amdgpu_device_wb_free(adev, status_offset);
+	amdgpu_wb_free(adev, status_offset);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 8007a6e69305..e95b8bcaf00a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -178,7 +178,7 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		timeout = 15 * 600 * 1000;
 	}
 
-	ret = amdgpu_device_wb_get(adev, &status_offset);
+	ret = amdgpu_wb_get(adev, &status_offset);
 	if (ret)
 		return ret;
 
@@ -253,7 +253,7 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		goto error_wb_free;
 	}
 
-	amdgpu_device_wb_free(adev, status_offset);
+	amdgpu_wb_free(adev, status_offset);
 	return 0;
 
 error_undo:
@@ -264,7 +264,7 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	spin_unlock_irqrestore(ring_lock, flags);
 
 error_wb_free:
-	amdgpu_device_wb_free(adev, status_offset);
+	amdgpu_wb_free(adev, status_offset);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 93ec52c1f367..397b08c7173a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -536,7 +536,7 @@ static int sdma_v2_4_ring_test_ring(struct amdgpu_ring *ring)
 	u32 tmp;
 	u64 gpu_addr;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -567,7 +567,7 @@ static int sdma_v2_4_ring_test_ring(struct amdgpu_ring *ring)
 		r = -ETIMEDOUT;
 
 error_free_wb:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
@@ -590,7 +590,7 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 	long r;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -635,7 +635,7 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index e77261a64cf8..8a8353c3a7c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -810,7 +810,7 @@ static int sdma_v3_0_ring_test_ring(struct amdgpu_ring *ring)
 	u32 tmp;
 	u64 gpu_addr;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -841,7 +841,7 @@ static int sdma_v3_0_ring_test_ring(struct amdgpu_ring *ring)
 		r = -ETIMEDOUT;
 
 error_free_wb:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
@@ -864,7 +864,7 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 	long r;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -908,7 +908,7 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index cb64d17000df..20c8ebf0e159 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1468,7 +1468,7 @@ static int sdma_v4_0_ring_test_ring(struct amdgpu_ring *ring)
 	u32 tmp;
 	u64 gpu_addr;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -1499,7 +1499,7 @@ static int sdma_v4_0_ring_test_ring(struct amdgpu_ring *ring)
 		r = -ETIMEDOUT;
 
 error_free_wb:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
@@ -1522,7 +1522,7 @@ static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u32 tmp = 0;
 	u64 gpu_addr;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -1567,7 +1567,7 @@ static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 777a70852883..34e762eaffb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1064,7 +1064,7 @@ static int sdma_v4_4_2_ring_test_ring(struct amdgpu_ring *ring)
 	u32 tmp;
 	u64 gpu_addr;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -1095,7 +1095,7 @@ static int sdma_v4_4_2_ring_test_ring(struct amdgpu_ring *ring)
 		r = -ETIMEDOUT;
 
 error_free_wb:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
@@ -1118,7 +1118,7 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u32 tmp = 0;
 	u64 gpu_addr;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -1163,7 +1163,7 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index fa02907217e0..3847dc08334a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1019,7 +1019,7 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 
 	tmp = 0xCAFEDEAD;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
 		return r;
@@ -1031,7 +1031,7 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 20);
 	if (r) {
 		drm_err(adev_to_drm(adev), "dma failed to lock ring %d (%d).\n", ring->idx, r);
-		amdgpu_device_wb_free(adev, index);
+		amdgpu_wb_free(adev, index);
 		return r;
 	}
 
@@ -1056,7 +1056,7 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 	if (i >= adev->usec_timeout)
 		r = -ETIMEDOUT;
 
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 
 	return r;
 }
@@ -1083,7 +1083,7 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	tmp = 0xCAFEDEAD;
 	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r) {
 		dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
 		return r;
@@ -1135,7 +1135,7 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index f6ecbc524c9b..bb2189cc882e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -919,7 +919,7 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 
 	tmp = 0xCAFEDEAD;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
 		return r;
@@ -931,7 +931,7 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 20);
 	if (r) {
 		drm_err(adev_to_drm(adev), "dma failed to lock ring %d (%d).\n", ring->idx, r);
-		amdgpu_device_wb_free(adev, index);
+		amdgpu_wb_free(adev, index);
 		return r;
 	}
 
@@ -956,7 +956,7 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 	if (i >= adev->usec_timeout)
 		r = -ETIMEDOUT;
 
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 
 	return r;
 }
@@ -983,7 +983,7 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	tmp = 0xCAFEDEAD;
 	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r) {
 		dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
 		return r;
@@ -1034,7 +1034,7 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index c208c584f912..9776b2582ab5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -910,7 +910,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 
 	tmp = 0xCAFEDEAD;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
 		return r;
@@ -922,7 +922,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
 		drm_err(adev_to_drm(adev), "dma failed to lock ring %d (%d).\n", ring->idx, r);
-		amdgpu_device_wb_free(adev, index);
+		amdgpu_wb_free(adev, index);
 		return r;
 	}
 
@@ -947,7 +947,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 	if (i >= adev->usec_timeout)
 		r = -ETIMEDOUT;
 
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 
 	return r;
 }
@@ -974,7 +974,7 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	tmp = 0xCAFEDEAD;
 	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r) {
 		dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
 		return r;
@@ -1025,7 +1025,7 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 9f232805cd76..cd9ff90626d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -925,7 +925,7 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 
 	tmp = 0xCAFEDEAD;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
 		return r;
@@ -937,7 +937,7 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
 		drm_err(adev_to_drm(adev), "dma failed to lock ring %d (%d).\n", ring->idx, r);
-		amdgpu_device_wb_free(adev, index);
+		amdgpu_wb_free(adev, index);
 		return r;
 	}
 
@@ -962,7 +962,7 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 	if (i >= adev->usec_timeout)
 		r = -ETIMEDOUT;
 
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 
 	return r;
 }
@@ -989,7 +989,7 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	tmp = 0xCAFEDEAD;
 	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r) {
 		dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
 		return r;
@@ -1040,7 +1040,7 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 14186e0ddb2c..b881f77602d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -915,7 +915,7 @@ static int sdma_v7_1_ring_test_ring(struct amdgpu_ring *ring)
 
 	tmp = 0xCAFEDEAD;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
 		return r;
@@ -927,7 +927,7 @@ static int sdma_v7_1_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
 		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
-		amdgpu_device_wb_free(adev, index);
+		amdgpu_wb_free(adev, index);
 		return r;
 	}
 
@@ -952,7 +952,7 @@ static int sdma_v7_1_ring_test_ring(struct amdgpu_ring *ring)
 	if (i >= adev->usec_timeout)
 		r = -ETIMEDOUT;
 
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 
 	return r;
 }
@@ -979,7 +979,7 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	tmp = 0xCAFEDEAD;
 	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r) {
 		dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
 		return r;
@@ -1030,7 +1030,7 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 549708075eb4..47f1d325bd1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -213,7 +213,7 @@ static int si_dma_ring_test_ring(struct amdgpu_ring *ring)
 	u32 tmp;
 	u64 gpu_addr;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -242,7 +242,7 @@ static int si_dma_ring_test_ring(struct amdgpu_ring *ring)
 		r = -ETIMEDOUT;
 
 error_free_wb:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
@@ -265,7 +265,7 @@ static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 	long r;
 
-	r = amdgpu_device_wb_get(adev, &index);
+	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
 
@@ -304,7 +304,7 @@ static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	amdgpu_wb_free(adev, index);
 	return r;
 }
 
-- 
2.54.0

