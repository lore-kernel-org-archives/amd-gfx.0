Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFF3C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 15:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E2260EE9
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 15:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11E2260EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6952C6E516;
	Mon, 11 Oct 2021 15:02:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AEA66E507
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 15:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yby5lb1ELiHmiQf6wEMDuo3X97Xt2+nqqKPSUNvX5PkpxFD3LbFaDJUT/uxfzdQsYnlcTSr07yEbDevmRhFnVDswv756GQGZydrYClmvgzOE9VeKZ5vVBliIvtxSQwedUjVVShee+5R+meFDy7YStsRkvIJTmo6iqWEZBlh5Lx4fd9xj698SjnsCkWZNSfUXyb9dygrKV08KFF4o7q/TehJ5CgZ3aVp8IaEXWP5hvGosd2nBJ4ya9wWWGYWrd66VPbI40ht7/a3P2QxJQjFdgq0nrmKWACjkgOraBb28/J95evITqyoULvio8q4lDbY2gorwddk63zsa1a6SAwp8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHBLqtL+LSl6/G6HpYXWImj4w0RYccohr824S9JhR04=;
 b=AIaLwCJUqEuc9wYSNrF9s5/qdT2taCV3sh17gnkyvMENHVRXKnO5NKC6c5YHm7yNn+ITrJg7Zu44JNgoiNvE4kQndXl8H0nD4DPo82cqi60uppKFbo4PsRHeb4wuld4GS+CBF0vwypMm2AtwK7I5vbMcpqeVHNpMSr0VNlH+1UzPuI7XRvnQU+7IQ6h3QSUN6P7qmgYKJPzimNXn1Oj8f3wBu7VFUlWtzpSmbh5rHnwOAlv3NWhEgI5gDmH0CqXtGH7Xq+uG4O9NLipAJZdms7lzeHEBRBsT0Fyq/R6+TD988wMEpBFyoja690LPwm1YljXr3GGEW4jwvYJwi4Kp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHBLqtL+LSl6/G6HpYXWImj4w0RYccohr824S9JhR04=;
 b=i90ms6mvd7G9mt5hM4Ibg9tDQ6ybH81DwHm22p1VVn23lXqasZlB71sOvAlZP4uOj6/lHB6+KuQMsCYO4ZWPBTfewQj/4lu0Pw5qJfwudcFORnbA+S5Pi4SrHAMVVPE2kXKduubYrpEHaX/Q0KXEly0ejNyR/ibYB0QrIHLqIZk=
Received: from CO2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:102:2::27)
 by DM5PR1201MB2473.namprd12.prod.outlook.com (2603:10b6:3:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 15:02:38 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::24) by CO2PR05CA0059.outlook.office365.com
 (2603:10b6:102:2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend
 Transport; Mon, 11 Oct 2021 15:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 15:02:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 10:02:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: drop navi reg init functions
Date: Mon, 11 Oct 2021 11:02:17 -0400
Message-ID: <20211011150217.165699-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211011150217.165699-1-alexander.deucher@amd.com>
References: <20211011150217.165699-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a8da5cc-2ec3-4377-25f1-08d98cc82a0e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2473:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2473267CA58A64EBDB75FAC5F7B59@DM5PR1201MB2473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ffVpWBWoK36UV5q3fb5IPylE6RCvaaVxRbMWq0AjgtOCH6PGcPn6gPG7CRgLQsloWs/XXeTHHBf1lQiW92TAMDFV9Qtp/FPqZeU8oR5cEjxmBVYb+vglkpLzqXPculs3W7oLEGYFJv1NdIlxCbzB5/u7iHsv7vE1WjjrrEzf9L3FJqGYejzviOEg69BAf//cyJSFtmTOy4mDZNYk6+IPyO8S4w6SaiBRTr628k6OqQAJXFBK3hrWUHGGFRTmqGnwkgJYJTCCWSBf27VLLMF1a8kheIeEu+dkXpYfE3OoY9EQ+9fDiMed5asZCGhpEwgUl/PhFxIqzs1MriVzXqxZz7Wm+39mxiJE7ZKMBzfxG33a3hkk8y3JT/TUq+hJx2vey5PUIf9gW+JU8pGynvQUC+wQ5XSLhjaHzJPOHNCNKiA65ocHm+xSTsQojjfCjgv/fZISNrO9Y7kz8XdXkLZQKeLGXxsAPj76ooQBA/o02FBb6I/A75kPOqfLQ2XTyGt24/xTrUijAPZzYVfjuJ/T1RRznj+Nff9iMe1c6fyUImv9afjnkETDdMpmEC6sQwnP8fdFIi0ieug7g+BWzbkxS7X+AY8YxakWG+5cKPX/qkXHgI38aMtvvQuKAkrUTdNEJL4xsZOTHKARSqAINWOCFdezpXlwVprKvOUjyCN9cnXDR6WNqqiINXAQXtAS1wfiU88AXe8BWGd0jM7b1iqI0Vz6ZaqZaweb98InH10NwU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(8936002)(36756003)(6666004)(186003)(36860700001)(26005)(16526019)(7696005)(83380400001)(86362001)(5660300002)(1076003)(8676002)(30864003)(356005)(81166007)(47076005)(6916009)(316002)(70206006)(2906002)(2616005)(82310400003)(4326008)(336012)(508600001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 15:02:37.5124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8da5cc-2ec3-4377-25f1-08d98cc82a0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2473
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

No longer used since IP enumeration is driven by the IP
discovery table now.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  6 +-
 .../gpu/drm/amd/amdgpu/beige_goby_reg_init.c  | 54 ------------------
 .../drm/amd/amdgpu/cyan_skillfish_reg_init.c  | 51 -----------------
 drivers/gpu/drm/amd/amdgpu/navi10_reg_init.c  | 55 -------------------
 drivers/gpu/drm/amd/amdgpu/navi12_reg_init.c  | 52 ------------------
 drivers/gpu/drm/amd/amdgpu/navi14_reg_init.c  | 53 ------------------
 drivers/gpu/drm/amd/amdgpu/nv.h               |  9 ---
 .../drm/amd/amdgpu/sienna_cichlid_reg_init.c  | 54 ------------------
 drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c | 50 -----------------
 .../gpu/drm/amd/amdgpu/yellow_carp_reg_init.c | 51 -----------------
 10 files changed, 2 insertions(+), 433 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/beige_goby_reg_init.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/navi10_reg_init.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/navi12_reg_init.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/navi14_reg_init.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/sienna_cichlid_reg_init.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/yellow_carp_reg_init.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 73a2151ee43f..7fedbb725e17 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -73,10 +73,8 @@ amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce
 
 amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
-	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
-	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o \
-	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o \
-	beige_goby_reg_init.o yellow_carp_reg_init.o cyan_skillfish_reg_init.o
+	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
+	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/beige_goby_reg_init.c b/drivers/gpu/drm/amd/amdgpu/beige_goby_reg_init.c
deleted file mode 100644
index 608a113ce354..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/beige_goby_reg_init.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * Copyright 2020 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#include "amdgpu.h"
-#include "nv.h"
-
-#include "soc15_common.h"
-#include "soc15_hw_ip.h"
-#include "beige_goby_ip_offset.h"
-
-int beige_goby_reg_base_init(struct amdgpu_device *adev)
-{
-	/* HW has more IP blocks,  only initialize the block needed by driver */
-	uint32_t i;
-	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
-		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
-		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
-		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
-		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
-		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
-		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
-		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(VCN0_BASE.instance[i]));
-		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
-		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DCN_BASE.instance[i]));
-		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
-		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SDMA1_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SDMA2_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SDMA3_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
-		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));
-	}
-	return 0;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c b/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
deleted file mode 100644
index 58808814d8fb..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * Copyright 2018 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#include "amdgpu.h"
-#include "nv.h"
-
-#include "soc15_common.h"
-#include "soc15_hw_ip.h"
-#include "cyan_skillfish_ip_offset.h"
-
-int cyan_skillfish_reg_base_init(struct amdgpu_device *adev)
-{
-	/* HW has more IP blocks,  only initialized the blocke needed by driver */
-	uint32_t i;
-	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
-		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
-		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
-		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
-		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
-		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
-		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
-		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(UVD0_BASE.instance[i]));
-		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
-		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DMU_BASE.instance[i]));
-		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
-		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SDMA1_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
-	}
-	return 0;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_reg_init.c b/drivers/gpu/drm/amd/amdgpu/navi10_reg_init.c
deleted file mode 100644
index 88efaecf9f70..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/navi10_reg_init.c
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * Copyright 2018 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#include "amdgpu.h"
-#include "nv.h"
-
-#include "soc15_common.h"
-#include "navi10_ip_offset.h"
-
-int navi10_reg_base_init(struct amdgpu_device *adev)
-{
-	int i;
-
-	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
-		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
-		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
-		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
-		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
-		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
-		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
-		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(VCN_BASE.instance[i]));
-		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
-		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DCN_BASE.instance[i]));
-		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
-		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SDMA1_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
-		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));
-		adev->reg_offset[CLK_HWIP][i] = (uint32_t *)(&(CLK_BASE.instance[i]));
-	}
-
-	return 0;
-}
-
-
diff --git a/drivers/gpu/drm/amd/amdgpu/navi12_reg_init.c b/drivers/gpu/drm/amd/amdgpu/navi12_reg_init.c
deleted file mode 100644
index a786d159e5e9..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/navi12_reg_init.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Copyright 2018 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#include "amdgpu.h"
-#include "nv.h"
-
-#include "soc15_common.h"
-#include "navi12_ip_offset.h"
-
-int navi12_reg_base_init(struct amdgpu_device *adev)
-{
-	/* HW has more IP blocks,  only initialized the blocks needed by driver */
-	uint32_t i;
-	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
-		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
-		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
-		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
-		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIF0_BASE.instance[i]));
-		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
-		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
-		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(UVD0_BASE.instance[i]));
-		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
-		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DMU_BASE.instance[i]));
-		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
-		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SDMA1_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
-		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));
-		adev->reg_offset[CLK_HWIP][i] = (uint32_t *)(&(CLK_BASE.instance[i]));
-	}
-	return 0;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/navi14_reg_init.c b/drivers/gpu/drm/amd/amdgpu/navi14_reg_init.c
deleted file mode 100644
index 4ea1e8fbb601..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/navi14_reg_init.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Copyright 2018 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#include "amdgpu.h"
-#include "nv.h"
-
-#include "soc15_common.h"
-#include "navi14_ip_offset.h"
-
-int navi14_reg_base_init(struct amdgpu_device *adev)
-{
-	int i;
-
-	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
-		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
-		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
-		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
-		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIF0_BASE.instance[i]));
-		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
-		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
-		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(UVD0_BASE.instance[i]));
-		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
-		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DMU_BASE.instance[i]));
-		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
-		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SDMA1_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
-		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));
-		adev->reg_offset[CLK_HWIP][i] = (uint32_t *)(&(CLK_BASE.instance[i]));
-	}
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index c6e9233afd17..83e9782aef39 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -31,14 +31,5 @@ extern const struct amdgpu_ip_block_version nv_common_ip_block;
 void nv_grbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);
 void nv_set_virt_ops(struct amdgpu_device *adev);
-int navi10_reg_base_init(struct amdgpu_device *adev);
-int navi14_reg_base_init(struct amdgpu_device *adev);
-int navi12_reg_base_init(struct amdgpu_device *adev);
-int sienna_cichlid_reg_base_init(struct amdgpu_device *adev);
-void vangogh_reg_base_init(struct amdgpu_device *adev);
-int dimgrey_cavefish_reg_base_init(struct amdgpu_device *adev);
-int beige_goby_reg_base_init(struct amdgpu_device *adev);
-int yellow_carp_reg_base_init(struct amdgpu_device *adev);
-int cyan_skillfish_reg_base_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid_reg_init.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid_reg_init.c
deleted file mode 100644
index 5ee69f70c49b..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid_reg_init.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * Copyright 2019 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#include "amdgpu.h"
-#include "nv.h"
-
-#include "soc15_common.h"
-#include "soc15_hw_ip.h"
-#include "sienna_cichlid_ip_offset.h"
-
-int sienna_cichlid_reg_base_init(struct amdgpu_device *adev)
-{
-	/* HW has more IP blocks,  only initialized the blocke needed by driver */
-	uint32_t i;
-	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
-		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
-		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
-		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
-		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
-		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
-		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
-		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(VCN_BASE.instance[i]));
-		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
-		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DCN_BASE.instance[i]));
-		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
-		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SDMA1_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SDMA2_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SDMA3_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
-		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));
-	}
-	return 0;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c b/drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c
deleted file mode 100644
index d64d681a05dc..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- * Copyright 2019 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#include "amdgpu.h"
-#include "nv.h"
-
-#include "soc15_common.h"
-#include "soc15_hw_ip.h"
-#include "vangogh_ip_offset.h"
-
-void vangogh_reg_base_init(struct amdgpu_device *adev)
-{
-	/* HW has more IP blocks,  only initialized the blocke needed by driver */
-	uint32_t i;
-	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
-		adev->reg_offset[GC_HWIP][i]     = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[HDP_HWIP][i]    = (uint32_t *)(&(HDP_BASE.instance[i]));
-		adev->reg_offset[MMHUB_HWIP][i]  = (uint32_t *)(&(MMHUB_BASE.instance[i]));
-		adev->reg_offset[ATHUB_HWIP][i]  = (uint32_t *)(&(ATHUB_BASE.instance[i]));
-		adev->reg_offset[NBIO_HWIP][i]   = (uint32_t *)(&(NBIO_BASE.instance[i]));
-		adev->reg_offset[MP0_HWIP][i]    = (uint32_t *)(&(MP0_BASE.instance[i]));
-		adev->reg_offset[MP1_HWIP][i]    = (uint32_t *)(&(MP1_BASE.instance[i]));
-		adev->reg_offset[VCN_HWIP][i]    = (uint32_t *)(&(VCN_BASE.instance[i]));
-		adev->reg_offset[DF_HWIP][i]     = (uint32_t *)(&(DF_BASE.instance[i]));
-		adev->reg_offset[DCE_HWIP][i]    = (uint32_t *)(&(DCN_BASE.instance[i]));
-		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
-		adev->reg_offset[SDMA0_HWIP][i]  = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[SMUIO_HWIP][i]  = (uint32_t *)(&(SMUIO_BASE.instance[i]));
-		adev->reg_offset[THM_HWIP][i]    = (uint32_t *)(&(THM_BASE.instance[i]));
-	}
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/yellow_carp_reg_init.c b/drivers/gpu/drm/amd/amdgpu/yellow_carp_reg_init.c
deleted file mode 100644
index 3d89421275ed..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/yellow_carp_reg_init.c
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * Copyright 2019 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#include "amdgpu.h"
-#include "nv.h"
-
-#include "soc15_common.h"
-#include "soc15_hw_ip.h"
-#include "yellow_carp_offset.h"
-
-int yellow_carp_reg_base_init(struct amdgpu_device *adev)
-{
-	/* HW has more IP blocks,  only initialized the block needed by driver */
-	uint32_t i;
-	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
-		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
-		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
-		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
-		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
-		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
-		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
-		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
-		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(VCN_BASE.instance[i]));
-		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
-		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DCN_BASE.instance[i]));
-		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
-		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(SDMA0_BASE.instance[i]));
-		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
-		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));
-	}
-	return 0;
-}
-- 
2.31.1

