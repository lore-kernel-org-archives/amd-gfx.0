Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BB0C4332D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74A220752
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IYaGAZSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74A220752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A8F26E97F;
	Wed, 18 Mar 2020 22:52:23 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690044.outbound.protection.outlook.com [40.107.69.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC936E97F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 22:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hes96GUzbQrdNWlojhm9eLwu7qpvMgW6Ebyy6nps6yZ4nd9tcasQiQ9ec8hlK0D4FDDpGQq9Lm2+cdr4RjtStG7tOvaz0BX/E0bUaK4tLkXwRAyHqdrDhunB/Iai/HTNffO0bN7tPTEEJ8VZW+SaEw8lnHK4BRHEholYPetjT6wzKz4ae4zoxW2nRhW90msc2CirHprE8X/tqgvKWgZu9TQ7OKn6FMCo9o/z41AXTZl6vrC6IRwgkX0XcCx0WeCdaWIT5oglw/xi/5AV3ypPd8wjEbyp1i2e3Kmv/C165o3rQbEaZaDIa7M0MyAEn9Dk0ksHSHxgDxJ455mHyzaabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EHxM3aRY8h9f/MUutORhXf1eb4vak+n0N1q7vXpxdM=;
 b=F39mqYaAXH5e5SCjOP3xkztI+Lh2UndW38zbJF8fm+gCt4diuNvMePpa5hJPGsWq1/Jzj9TG0XYPNT+ZSN9zPWQyZb7te6wOhdnDCnRLD9PJ+ccwqlhZnlz7FiX4c5CPgfeRgOgTSrPq4Tpr+8a5ZlXVJC4zqrtl01mNQdA1kN+1IxDRz0jTvFiazABKkMC6J0PdAc2h9LVJDJPVLAbbJ1su3a9ldz3O/rmdB/Y/2IJpHIWPr5t2y2lOchTHb/ZBI19/Wp+uajewJZDTa92QDx0YVakReZsr2NoMxFl4hgdsiG8x7TemnGlQPtTAN4Y9hAQjy1vcXbWmrZLSqyyknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EHxM3aRY8h9f/MUutORhXf1eb4vak+n0N1q7vXpxdM=;
 b=IYaGAZSsTMBQBaRCqEjF90j9O8rw6oNHHqJE3otU4+gGN+gfcE3f73X7h9j80OugPCxZyINHgKA00hvNJ2dCFQ+Z7glFn7MZ/ChYBisd2kzNJxA8kh2nLI9LHJ5PMwBxfOv/tZayrQjSH1h8YFc8bfEHvsFU8Bx5SKM90oCXqRo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 22:52:20 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 22:52:20 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] drm/amdgpu: create new files for arcturus ih
Date: Wed, 18 Mar 2020 17:51:12 -0500
Message-Id: <20200318225118.10756-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318225118.10756-1-alex.sierra@amd.com>
References: <20200318225118.10756-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN4PR0501CA0076.namprd05.prod.outlook.com
 (2603:10b6:803:22::14) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0501CA0076.namprd05.prod.outlook.com (2603:10b6:803:22::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.11 via Frontend
 Transport; Wed, 18 Mar 2020 22:52:19 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3413f199-e0bc-40e3-cf67-08d7cb8f03ca
X-MS-TrafficTypeDiagnostic: SA0PR12MB4415:|SA0PR12MB4415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB441541945F1CC04C4A73E555FDF70@SA0PR12MB4415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(66476007)(66556008)(6486002)(81166006)(8676002)(44832011)(316002)(81156014)(956004)(2616005)(16526019)(26005)(186003)(8936002)(52116002)(86362001)(7696005)(66946007)(30864003)(478600001)(2906002)(6916009)(1076003)(4326008)(6666004)(36756003)(5660300002)(21314003)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4415;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+DL55FlIqOwnnVP6n29Mh7NJ4HlgDwu8hMWaUDtUtqifXVTRYu5yNBxENRgHkgmOu7cTD4LkhYNPPy/3LJD6bx9i7H6xl4gbzNDJxxw/B6cdsMlZM26WNArb91QjCJZXdKhCn4rtiqFJr6OdynNeNI4l561hU7AyAkSb7vPEwAIN9AK3kWohACHr3mMntY0+S51QOp6jwifq1QNryD7Wyl38kFehMPQkNcWLpIIvL/Bu7rfIwxrgachQ3ilbGEIMYVV8SZ0uYBawAAxs50UsSQAoxRnPm45K2I/WLXxJw0meTVHfpv7LVPXeX0EAgvoHKxt6esOUdpLHAe3+oHFgqAHkcKnBh0esFs9T+hp/36E2sxvwFCAbLwQ19FU+IlihcJD8oPygfONsB0rcECBvCnRpTfCy2JsyXm6cbs+rfZ2ghOcShTeeHbTT42gIWF6HtgAFr9+6yOOPBvRYHMoov3NW1Fs4BRYDDgQe/IViJ/rLhufZ+XTsulrQfGTsqHRBXesCj1YipLaPTVPNK4YUA==
X-MS-Exchange-AntiSpam-MessageData: fj+bMEkMknvczmBGGgdUWwOYmLEhFNZxYEQbE3+KE6JArnMSzR5vcOQRA/CO7PhONEqOp5c1bxcYThUdzhshWUwu1smxKmkEmUNhxHXx3q4XI8HgOjpj6ifSoMDyaYfhjXYKmvt/IgNsQBt96NXb4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3413f199-e0bc-40e3-cf67-08d7cb8f03ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 22:52:20.5338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcl2U1iQpke3nt09ZNLQdE7Xyv42M3QxHLhpyraTrIIc7v8oXpwWXTZ81BrrjgITjjmfkyk++heWG5XlX9D9bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Arcturus uses osssys v4.2. This shares the same register map as
osssys v5.0.

[How]
Copy vega10_ih into new arcturus_ih source and header files.
Replace osssys include file with v5.0.0 on arcturus_ih.c source.

Change-Id: I5215f32f477adb6a30acef6e8add9f8e5bb041ef
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/arcturus_ih.c | 766 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/arcturus_ih.h |  30 +
 2 files changed, 796 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/arcturus_ih.h

diff --git a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
new file mode 100644
index 000000000000..21bb5be40921
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
@@ -0,0 +1,766 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+ *
+ */
+
+#include <linux/pci.h>
+
+#include "amdgpu.h"
+#include "amdgpu_ih.h"
+#include "soc15.h"
+
+#include "oss/osssys_5_0_0_offset.h"
+#include "oss/osssys_5_0_0_sh_mask.h"
+
+#include "soc15_common.h"
+#include "arcturus_ih.h"
+
+#define MAX_REARM_RETRY 10
+
+static void vega10_ih_set_interrupt_funcs(struct amdgpu_device *adev);
+
+/**
+ * vega10_ih_enable_interrupts - Enable the interrupt ring buffer
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Enable the interrupt ring buffer (VEGA10).
+ */
+static void vega10_ih_enable_interrupts(struct amdgpu_device *adev)
+{
+	u32 ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
+
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1);
+	if (amdgpu_sriov_vf(adev)) {
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return;
+		}
+	} else {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
+	}
+	adev->irq.ih.enabled = true;
+
+	if (adev->irq.ih1.ring_size) {
+		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
+					   RB_ENABLE, 1);
+		if (amdgpu_sriov_vf(adev)) {
+			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
+						ih_rb_cntl)) {
+				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
+				return;
+			}
+		} else {
+			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+		}
+		adev->irq.ih1.enabled = true;
+	}
+
+	if (adev->irq.ih2.ring_size) {
+		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
+					   RB_ENABLE, 1);
+		if (amdgpu_sriov_vf(adev)) {
+			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
+						ih_rb_cntl)) {
+				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
+				return;
+			}
+		} else {
+			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+		}
+		adev->irq.ih2.enabled = true;
+	}
+}
+
+/**
+ * vega10_ih_disable_interrupts - Disable the interrupt ring buffer
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Disable the interrupt ring buffer (VEGA10).
+ */
+static void vega10_ih_disable_interrupts(struct amdgpu_device *adev)
+{
+	u32 ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
+
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 0);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 0);
+	if (amdgpu_sriov_vf(adev)) {
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return;
+		}
+	} else {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
+	}
+
+	/* set rptr, wptr to 0 */
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR, 0);
+	adev->irq.ih.enabled = false;
+	adev->irq.ih.rptr = 0;
+
+	if (adev->irq.ih1.ring_size) {
+		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
+					   RB_ENABLE, 0);
+		if (amdgpu_sriov_vf(adev)) {
+			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
+						ih_rb_cntl)) {
+				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
+				return;
+			}
+		} else {
+			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+		}
+		/* set rptr, wptr to 0 */
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);
+		adev->irq.ih1.enabled = false;
+		adev->irq.ih1.rptr = 0;
+	}
+
+	if (adev->irq.ih2.ring_size) {
+		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
+					   RB_ENABLE, 0);
+		if (amdgpu_sriov_vf(adev)) {
+			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
+						ih_rb_cntl)) {
+				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
+				return;
+			}
+		} else {
+			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+		}
+
+		/* set rptr, wptr to 0 */
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);
+		adev->irq.ih2.enabled = false;
+		adev->irq.ih2.rptr = 0;
+	}
+}
+
+static uint32_t vega10_ih_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t ih_rb_cntl)
+{
+	int rb_bufsz = order_base_2(ih->ring_size / 4);
+
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+				   MC_SPACE, ih->use_bus_addr ? 1 : 4);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+				   WPTR_OVERFLOW_CLEAR, 1);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+				   WPTR_OVERFLOW_ENABLE, 1);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_SIZE, rb_bufsz);
+	/* Ring Buffer write pointer writeback. If enabled, IH_RB_WPTR register
+	 * value is written to memory
+	 */
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+				   WPTR_WRITEBACK_ENABLE, 1);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, MC_SNOOP, 1);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, MC_RO, 0);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, MC_VMID, 0);
+
+	return ih_rb_cntl;
+}
+
+static uint32_t vega10_ih_doorbell_rptr(struct amdgpu_ih_ring *ih)
+{
+	u32 ih_doorbell_rtpr = 0;
+
+	if (ih->use_doorbell) {
+		ih_doorbell_rtpr = REG_SET_FIELD(ih_doorbell_rtpr,
+						 IH_DOORBELL_RPTR, OFFSET,
+						 ih->doorbell_index);
+		ih_doorbell_rtpr = REG_SET_FIELD(ih_doorbell_rtpr,
+						 IH_DOORBELL_RPTR,
+						 ENABLE, 1);
+	} else {
+		ih_doorbell_rtpr = REG_SET_FIELD(ih_doorbell_rtpr,
+						 IH_DOORBELL_RPTR,
+						 ENABLE, 0);
+	}
+	return ih_doorbell_rtpr;
+}
+
+/**
+ * vega10_ih_irq_init - init and enable the interrupt ring
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Allocate a ring buffer for the interrupt controller,
+ * enable the RLC, disable interrupts, enable the IH
+ * ring buffer and enable it (VI).
+ * Called at device load and reume.
+ * Returns 0 for success, errors for failure.
+ */
+static int vega10_ih_irq_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ih_ring *ih;
+	u32 ih_rb_cntl, ih_chicken;
+	int ret = 0;
+	u32 tmp;
+
+	/* disable irqs */
+	vega10_ih_disable_interrupts(adev);
+
+	adev->nbio.funcs->ih_control(adev);
+
+	ih = &adev->irq.ih;
+	/* Ring Buffer base. [39:8] of 40-bit address of the beginning of the ring buffer*/
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE, ih->gpu_addr >> 8);
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI, (ih->gpu_addr >> 40) & 0xff);
+
+	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
+	ih_rb_cntl = vega10_ih_rb_cntl(ih, ih_rb_cntl);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
+				   !!adev->irq.msi_enabled);
+	if (amdgpu_sriov_vf(adev)) {
+		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
+			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
+	}
+
+	if ((adev->asic_type == CHIP_ARCTURUS &&
+	     adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) ||
+	    adev->asic_type == CHIP_RENOIR) {
+		ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
+		if (adev->irq.ih.use_bus_addr) {
+			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
+						   MC_SPACE_GPA_ENABLE, 1);
+		} else {
+			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
+						   MC_SPACE_FBPA_ENABLE, 1);
+		}
+		WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken);
+	}
+
+	/* set the writeback address whether it's enabled or not */
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_LO,
+		     lower_32_bits(ih->wptr_addr));
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_HI,
+		     upper_32_bits(ih->wptr_addr) & 0xFFFF);
+
+	/* set rptr, wptr to 0 */
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR, 0);
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
+
+	WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR,
+		     vega10_ih_doorbell_rptr(ih));
+
+	ih = &adev->irq.ih1;
+	if (ih->ring_size) {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_RING1, ih->gpu_addr >> 8);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI_RING1,
+			     (ih->gpu_addr >> 40) & 0xff);
+
+		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+		ih_rb_cntl = vega10_ih_rb_cntl(ih, ih_rb_cntl);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+					   WPTR_OVERFLOW_ENABLE, 0);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+					   RB_FULL_DRAIN_ENABLE, 1);
+		if (amdgpu_sriov_vf(adev)) {
+			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
+						ih_rb_cntl)) {
+				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
+				return -ETIMEDOUT;
+			}
+		} else {
+			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+		}
+
+		/* set rptr, wptr to 0 */
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
+
+		WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR_RING1,
+			     vega10_ih_doorbell_rptr(ih));
+	}
+
+	ih = &adev->irq.ih2;
+	if (ih->ring_size) {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_RING2, ih->gpu_addr >> 8);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI_RING2,
+			     (ih->gpu_addr >> 40) & 0xff);
+
+		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
+		ih_rb_cntl = vega10_ih_rb_cntl(ih, ih_rb_cntl);
+
+		if (amdgpu_sriov_vf(adev)) {
+			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
+						ih_rb_cntl)) {
+				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
+				return -ETIMEDOUT;
+			}
+		} else {
+			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+		}
+
+		/* set rptr, wptr to 0 */
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
+
+		WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR_RING2,
+			     vega10_ih_doorbell_rptr(ih));
+	}
+
+	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL);
+	tmp = REG_SET_FIELD(tmp, IH_STORM_CLIENT_LIST_CNTL,
+			    CLIENT18_IS_STORM_CLIENT, 1);
+	WREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL, tmp);
+
+	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL);
+	tmp = REG_SET_FIELD(tmp, IH_INT_FLOOD_CNTL, FLOOD_CNTL_ENABLE, 1);
+	WREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL, tmp);
+
+	pci_set_master(adev->pdev);
+
+	/* enable interrupts */
+	vega10_ih_enable_interrupts(adev);
+
+	return ret;
+}
+
+/**
+ * vega10_ih_irq_disable - disable interrupts
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Disable interrupts on the hw (VEGA10).
+ */
+static void vega10_ih_irq_disable(struct amdgpu_device *adev)
+{
+	vega10_ih_disable_interrupts(adev);
+
+	/* Wait and acknowledge irq */
+	mdelay(1);
+}
+
+/**
+ * vega10_ih_get_wptr - get the IH ring buffer wptr
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Get the IH ring buffer wptr from either the register
+ * or the writeback memory buffer (VEGA10).  Also check for
+ * ring buffer overflow and deal with it.
+ * Returns the value of the wptr.
+ */
+static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
+			      struct amdgpu_ih_ring *ih)
+{
+	u32 wptr, reg, tmp;
+
+	wptr = le32_to_cpu(*ih->wptr_cpu);
+
+	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+		goto out;
+
+	/* Double check that the overflow wasn't already cleared. */
+
+	if (ih == &adev->irq.ih)
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR);
+	else if (ih == &adev->irq.ih1)
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING1);
+	else if (ih == &adev->irq.ih2)
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING2);
+	else
+		BUG();
+
+	wptr = RREG32_NO_KIQ(reg);
+	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+		goto out;
+
+	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+
+	/* When a ring buffer overflow happen start parsing interrupt
+	 * from the last not overwritten vector (wptr + 32). Hopefully
+	 * this should allow us to catchup.
+	 */
+	tmp = (wptr + 32) & ih->ptr_mask;
+	dev_warn(adev->dev, "IH ring buffer overflow "
+		 "(0x%08X, 0x%08X, 0x%08X)\n",
+		 wptr, ih->rptr, tmp);
+	ih->rptr = tmp;
+
+	if (ih == &adev->irq.ih)
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL);
+	else if (ih == &adev->irq.ih1)
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+	else if (ih == &adev->irq.ih2)
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING2);
+	else
+		BUG();
+
+	tmp = RREG32_NO_KIQ(reg);
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
+	WREG32_NO_KIQ(reg, tmp);
+
+out:
+	return (wptr & ih->ptr_mask);
+}
+
+/**
+ * vega10_ih_decode_iv - decode an interrupt vector
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Decodes the interrupt vector at the current rptr
+ * position and also advance the position.
+ */
+static void vega10_ih_decode_iv(struct amdgpu_device *adev,
+				struct amdgpu_ih_ring *ih,
+				struct amdgpu_iv_entry *entry)
+{
+	/* wptr/rptr are in bytes! */
+	u32 ring_index = ih->rptr >> 2;
+	uint32_t dw[8];
+
+	dw[0] = le32_to_cpu(ih->ring[ring_index + 0]);
+	dw[1] = le32_to_cpu(ih->ring[ring_index + 1]);
+	dw[2] = le32_to_cpu(ih->ring[ring_index + 2]);
+	dw[3] = le32_to_cpu(ih->ring[ring_index + 3]);
+	dw[4] = le32_to_cpu(ih->ring[ring_index + 4]);
+	dw[5] = le32_to_cpu(ih->ring[ring_index + 5]);
+	dw[6] = le32_to_cpu(ih->ring[ring_index + 6]);
+	dw[7] = le32_to_cpu(ih->ring[ring_index + 7]);
+
+	entry->client_id = dw[0] & 0xff;
+	entry->src_id = (dw[0] >> 8) & 0xff;
+	entry->ring_id = (dw[0] >> 16) & 0xff;
+	entry->vmid = (dw[0] >> 24) & 0xf;
+	entry->vmid_src = (dw[0] >> 31);
+	entry->timestamp = dw[1] | ((u64)(dw[2] & 0xffff) << 32);
+	entry->timestamp_src = dw[2] >> 31;
+	entry->pasid = dw[3] & 0xffff;
+	entry->pasid_src = dw[3] >> 31;
+	entry->src_data[0] = dw[4];
+	entry->src_data[1] = dw[5];
+	entry->src_data[2] = dw[6];
+	entry->src_data[3] = dw[7];
+
+	/* wptr/rptr are in bytes! */
+	ih->rptr += 32;
+}
+
+/**
+ * vega10_ih_irq_rearm - rearm IRQ if lost
+ *
+ * @adev: amdgpu_device pointer
+ *
+ */
+static void vega10_ih_irq_rearm(struct amdgpu_device *adev,
+			       struct amdgpu_ih_ring *ih)
+{
+	uint32_t reg_rptr = 0;
+	uint32_t v = 0;
+	uint32_t i = 0;
+
+	if (ih == &adev->irq.ih)
+		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR);
+	else if (ih == &adev->irq.ih1)
+		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING1);
+	else if (ih == &adev->irq.ih2)
+		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING2);
+	else
+		return;
+
+	/* Rearm IRQ / re-wwrite doorbell if doorbell write is lost */
+	for (i = 0; i < MAX_REARM_RETRY; i++) {
+		v = RREG32_NO_KIQ(reg_rptr);
+		if ((v < ih->ring_size) && (v != ih->rptr))
+			WDOORBELL32(ih->doorbell_index, ih->rptr);
+		else
+			break;
+	}
+}
+
+/**
+ * vega10_ih_set_rptr - set the IH ring buffer rptr
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set the IH ring buffer rptr.
+ */
+static void vega10_ih_set_rptr(struct amdgpu_device *adev,
+			       struct amdgpu_ih_ring *ih)
+{
+	if (ih->use_doorbell) {
+		/* XXX check if swapping is necessary on BE */
+		*ih->rptr_cpu = ih->rptr;
+		WDOORBELL32(ih->doorbell_index, ih->rptr);
+
+		if (amdgpu_sriov_vf(adev))
+			vega10_ih_irq_rearm(adev, ih);
+	} else if (ih == &adev->irq.ih) {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih->rptr);
+	} else if (ih == &adev->irq.ih1) {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, ih->rptr);
+	} else if (ih == &adev->irq.ih2) {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, ih->rptr);
+	}
+}
+
+/**
+ * vega10_ih_self_irq - dispatch work for ring 1 and 2
+ *
+ * @adev: amdgpu_device pointer
+ * @source: irq source
+ * @entry: IV with WPTR update
+ *
+ * Update the WPTR from the IV and schedule work to handle the entries.
+ */
+static int vega10_ih_self_irq(struct amdgpu_device *adev,
+			      struct amdgpu_irq_src *source,
+			      struct amdgpu_iv_entry *entry)
+{
+	uint32_t wptr = cpu_to_le32(entry->src_data[0]);
+
+	switch (entry->ring_id) {
+	case 1:
+		*adev->irq.ih1.wptr_cpu = wptr;
+		schedule_work(&adev->irq.ih1_work);
+		break;
+	case 2:
+		*adev->irq.ih2.wptr_cpu = wptr;
+		schedule_work(&adev->irq.ih2_work);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs vega10_ih_self_irq_funcs = {
+	.process = vega10_ih_self_irq,
+};
+
+static void vega10_ih_set_self_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->irq.self_irq.num_types = 0;
+	adev->irq.self_irq.funcs = &vega10_ih_self_irq_funcs;
+}
+
+static int vega10_ih_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	vega10_ih_set_interrupt_funcs(adev);
+	vega10_ih_set_self_irq_funcs(adev);
+	return 0;
+}
+
+static int vega10_ih_sw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_IH, 0,
+			      &adev->irq.self_irq);
+	if (r)
+		return r;
+
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, true);
+	if (r)
+		return r;
+
+	adev->irq.ih.use_doorbell = true;
+	adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
+
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
+	if (r)
+		return r;
+
+	adev->irq.ih1.use_doorbell = true;
+	adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
+
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
+	if (r)
+		return r;
+
+	adev->irq.ih2.use_doorbell = true;
+	adev->irq.ih2.doorbell_index = (adev->doorbell_index.ih + 2) << 1;
+
+	r = amdgpu_irq_init(adev);
+
+	return r;
+}
+
+static int vega10_ih_sw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	amdgpu_irq_fini(adev);
+	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
+	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
+	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
+
+	return 0;
+}
+
+static int vega10_ih_hw_init(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	r = vega10_ih_irq_init(adev);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static int vega10_ih_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	vega10_ih_irq_disable(adev);
+
+	return 0;
+}
+
+static int vega10_ih_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return vega10_ih_hw_fini(adev);
+}
+
+static int vega10_ih_resume(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return vega10_ih_hw_init(adev);
+}
+
+static bool vega10_ih_is_idle(void *handle)
+{
+	/* todo */
+	return true;
+}
+
+static int vega10_ih_wait_for_idle(void *handle)
+{
+	/* todo */
+	return -ETIMEDOUT;
+}
+
+static int vega10_ih_soft_reset(void *handle)
+{
+	/* todo */
+
+	return 0;
+}
+
+static void vega10_ih_update_clockgating_state(struct amdgpu_device *adev,
+					       bool enable)
+{
+	uint32_t data, def, field_val;
+
+	if (adev->cg_flags & AMD_CG_SUPPORT_IH_CG) {
+		def = data = RREG32_SOC15(OSSSYS, 0, mmIH_CLK_CTRL);
+		field_val = enable ? 0 : 1;
+		/**
+		 * Vega10 does not have IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE
+		 * and IH_BUFFER_MEM_CLK_SOFT_OVERRIDE field.
+		 */
+		if (adev->asic_type > CHIP_VEGA10) {
+			data = REG_SET_FIELD(data, IH_CLK_CTRL,
+				     IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE, field_val);
+			data = REG_SET_FIELD(data, IH_CLK_CTRL,
+				     IH_BUFFER_MEM_CLK_SOFT_OVERRIDE, field_val);
+		}
+
+		data = REG_SET_FIELD(data, IH_CLK_CTRL,
+				     DBUS_MUX_CLK_SOFT_OVERRIDE, field_val);
+		data = REG_SET_FIELD(data, IH_CLK_CTRL,
+				     OSSSYS_SHARE_CLK_SOFT_OVERRIDE, field_val);
+		data = REG_SET_FIELD(data, IH_CLK_CTRL,
+				     LIMIT_SMN_CLK_SOFT_OVERRIDE, field_val);
+		data = REG_SET_FIELD(data, IH_CLK_CTRL,
+				     DYN_CLK_SOFT_OVERRIDE, field_val);
+		data = REG_SET_FIELD(data, IH_CLK_CTRL,
+				     REG_CLK_SOFT_OVERRIDE, field_val);
+		if (def != data)
+			WREG32_SOC15(OSSSYS, 0, mmIH_CLK_CTRL, data);
+	}
+}
+
+static int vega10_ih_set_clockgating_state(void *handle,
+					  enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	vega10_ih_update_clockgating_state(adev,
+				state == AMD_CG_STATE_GATE);
+	return 0;
+
+}
+
+static int vega10_ih_set_powergating_state(void *handle,
+					  enum amd_powergating_state state)
+{
+	return 0;
+}
+
+const struct amd_ip_funcs vega10_ih_ip_funcs = {
+	.name = "vega10_ih",
+	.early_init = vega10_ih_early_init,
+	.late_init = NULL,
+	.sw_init = vega10_ih_sw_init,
+	.sw_fini = vega10_ih_sw_fini,
+	.hw_init = vega10_ih_hw_init,
+	.hw_fini = vega10_ih_hw_fini,
+	.suspend = vega10_ih_suspend,
+	.resume = vega10_ih_resume,
+	.is_idle = vega10_ih_is_idle,
+	.wait_for_idle = vega10_ih_wait_for_idle,
+	.soft_reset = vega10_ih_soft_reset,
+	.set_clockgating_state = vega10_ih_set_clockgating_state,
+	.set_powergating_state = vega10_ih_set_powergating_state,
+};
+
+static const struct amdgpu_ih_funcs vega10_ih_funcs = {
+	.get_wptr = vega10_ih_get_wptr,
+	.decode_iv = vega10_ih_decode_iv,
+	.set_rptr = vega10_ih_set_rptr
+};
+
+static void vega10_ih_set_interrupt_funcs(struct amdgpu_device *adev)
+{
+	adev->irq.ih_funcs = &vega10_ih_funcs;
+}
+
+const struct amdgpu_ip_block_version vega10_ih_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_IH,
+	.major = 4,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &vega10_ih_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.h b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.h
new file mode 100644
index 000000000000..54daf8cf6ff3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+ *
+ */
+
+#ifndef __VEGA10_IH_H__
+#define __VEGA10_IH_H__
+
+extern const struct amd_ip_funcs vega10_ih_ip_funcs;
+extern const struct amdgpu_ip_block_version vega10_ih_ip_block;
+
+#endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
