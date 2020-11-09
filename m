Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC7AC55ABD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C4A2084C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PqRawu3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C4A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA062894DC;
	Mon,  9 Nov 2020 08:17:21 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700080.outbound.protection.outlook.com [40.107.70.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4083B894DC
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 08:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhjSs31a7+wxFNVx1ePjOAZMajBw/+5uXjOVWBRzUADiJYhJXEjqPWDN19PJxAnK1xZVXe//CmXmr7esD8mrDCbpu/1VEHvRmUP7TWWUmiAbBLOtTi8HDzBxQYqtF3yRTuDwi62s9Z8JTl9AVJJL+6qUw0qbK1QKFUOEvbuuHuI2tJ30RFnV1UW052rdPHnvFtmmemyCE2MsM6rLmSFktSW6OaYBYUI4RmMfqTS8oPRo8ilpTVq6X+YnCHXuuGfzv4DfZmqQTUasMAFKL+y1YsPvYejgI0AzTAyMXikDSMpBV0xIprcPpv4UIHkZEC6zjOcYfgXBd4YrcFq9IXWqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTlPAp9qYpp0e+dwUL9v43Ee7NMfylftoEgaR6adD/w=;
 b=i44jCHnN8DuIV0Pb+Jqt6T1SgzJAKlnT237My7kOwk83isVTvVTgk6aU2tTKyqKgfj2LFKe1B9lvvmgbKnzFaa86Rp5ITYLgWhMbZUUtYRF/ym3li8+WgKaaiB/Ooaz/h3yJusytayTcgpPhVI3IdD0kNR8pnvGE2nraju/aBxBXcWn47w14xUDGGJvZxtdkq3gf3VFIbRUk6FdMpxJA4Es8BAifUKybdDvuR2oK9aThA1DhDKCWzoq7sAuEYDl9Gjf9TH+DTsdxJNirWRXK9mbHWa+7bPek6qmqlZFuP8TL8HFUtRETBpQBFETm+z8kqIZKkoG2KZElZMqO7Z+H/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTlPAp9qYpp0e+dwUL9v43Ee7NMfylftoEgaR6adD/w=;
 b=PqRawu3QwTC0rs5cHPagIXyUK7/5ntVb7dIAjYlf9f33ME9sJFZOZTHlLoG9ju/s6WzZQ8RUji2KERqgWiygsqSHXQd+NS26cNHBuOw00XWMNqrUtaCvazl+ePBqapC7gDPrEFXrE6FmoZ8QmAiAIQXFtGI7dSNOxz/prr90T+g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.24; Mon, 9 Nov 2020 08:17:19 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%8]) with mapi id 15.20.3541.022; Mon, 9 Nov 2020
 08:17:19 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: implement smuio v11_0 callbacks
Date: Mon,  9 Nov 2020 16:16:50 +0800
Message-Id: <20201109081652.1964-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109081652.1964-1-Hawking.Zhang@amd.com>
References: <20201109081652.1964-1-Hawking.Zhang@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:202:16::13) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (58.247.170.242) by
 HK2PR02CA0129.apcprd02.prod.outlook.com (2603:1096:202:16::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 08:17:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62bafe63-8c50-4e03-927f-08d88487e053
X-MS-TrafficTypeDiagnostic: DM6PR12MB3274:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3274EB42BC304DFE27954547FCEA0@DM6PR12MB3274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55+nI4jhjK4EEAITUHjKsev9Z01tslJ3DhCs0A05tfXZUJRsHeU8fg6i/iXKv9Du71jScY6cXFnbmKTLJrZS+bg2ths2AF1v1lQljUDSB/OMY8C5JgNIWsOKwxv8qI0lweqQ8P86CRQKoQyRfQkOkhgYpYQVjghI5HrdHcp26NXDmbK5xgp13l0w/NS0g8cISS9z+CCnEhpzS+MgbHQVl1Ni4KZF2JhXjS1tDTArrj6lEG9gOG5JfkEZ1MFDXYrumMDCGURrh5a+RQOHEA+bj0H4uIvHFfKIM5KLcD13VcW0lG8WjvNnzGpfwfVrFGRg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(66476007)(66556008)(316002)(66946007)(6916009)(5660300002)(8676002)(8936002)(4326008)(1076003)(26005)(2906002)(86362001)(83380400001)(6486002)(2616005)(478600001)(956004)(186003)(16526019)(52116002)(6666004)(36756003)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zP9JDjY6/ibrYYYGAfXqDPVe3aGDsvYx+gQc/yiy0iyomROdReT9hnJYQQYxNNDSEzA4IzHNJq1iIWTmRURmYmJGFWQzVJtEfpD5Y27pybeMxoGRFU/tE8q9PWhOZGP9LLNAuNmxIsjppyZLLL4kDALc18VRCFC5NEFQEM91XpUVQClODCcpCAiN1H2eIHntBGayXvvKpWXQN4kH52au5eVzdhph/HaQN8DZzvaTydz7JkNcKQW66u1CI7yKPHR1IiwXcoB2gHEjRentuYQyxEVmvsMgYSfXx9kV800bm/JSqyTISdn0WbVgEF6EDz9M+gJre5STKpE9w2Fg7RvDZ53ZylKwmbHyfsb7JVHscz+bvAMmSJgZoKaS9QP9IfeQN8IAfO6lIHRXHx8BF91wRgU+BvpB5n7Btc/rhS6WmLFyknjTVAo0zxVBtZ7GfYOhvtsOT6mSuHE/CcY57l9n2o/uGAAvJa1kmbgkpEKGHkTY4RpBZP1OCtaDRWyVVk/QSF+iqhr8wLmTs1LH1pZO3TO5dmHJUhInfnpgXkQjg8DpF3Xf8zneiik8GD9Q2qd1flXH+z30NQsrxdUBfoollAzxYKry7ecwJh8fTCIBwGeuHeXakSmoAyNRyxzH6lJAyfoEybIyd0byvqSbikLGOQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bafe63-8c50-4e03-927f-08d88487e053
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 08:17:19.3672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSHF2QLjOU2EemfORXuz6Py6J0YCV4fvYRQKwO622OcL7vwyXHnsACxoym38oRRhVsalDFq03Aj360PzOubaQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Vega20/Arcturus will use smuio v11_0 callbacks

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |  3 +-
 drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c | 77 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/smuio_v11_0.h | 30 +++++++++++++
 3 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v11_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 2d60a5b8..6bf6cfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -169,7 +169,8 @@ amdgpu-y += \
 
 # add SMUIO block
 amdgpu-y += \
-	smuio_v9_0.o
+	smuio_v9_0.o \
+	smuio_v11_0.o
 
 # add amdkfd interfaces
 amdgpu-y += amdgpu_amdkfd.o
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
new file mode 100644
index 0000000..137b410
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
@@ -0,0 +1,77 @@
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
+#include "amdgpu.h"
+#include "smuio_v11_0.h"
+#include "smuio/smuio_11_0_0_offset.h"
+#include "smuio/smuio_11_0_0_sh_mask.h"
+
+static u32 smuio_v11_0_get_rom_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, mmROM_INDEX);
+}
+
+static u32 smuio_v11_0_get_rom_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA);
+}
+
+void smuio_v11_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
+{
+	u32 def, data;
+
+	/* enable/disable ROM CG is not supported on APU */
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	def = data = RREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0);
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_ROM_MGCG))
+		data &= ~(CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK |
+			CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE1_MASK);
+	else
+		data |= CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK |
+			CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE1_MASK;
+
+	if (def != data)
+		WREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0, data);
+}
+
+void smuio_v11_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+{
+	u32 data;
+
+	/* CGTT_ROM_CLK_CTRL0 is not available for APU */
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	data = RREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0);
+	if (!(data & CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK))
+		*flags |= AMD_CG_SUPPORT_ROM_MGCG;
+}
+
+const struct amdgpu_smuio_funcs smuio_v11_0_funcs = {
+	.get_rom_index_offset = smuio_v11_0_get_rom_index_offset,
+	.get_rom_data_offset = smuio_v11_0_get_rom_data_offset,
+	.update_rom_clock_gating = smuio_v11_0_update_rom_clock_gating,
+	.get_clock_gating_state = smuio_v11_0_get_clock_gating_state,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.h b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.h
new file mode 100644
index 0000000..43c4262
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.h
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
+#ifndef __SMUIO_V11_0_H__
+#define __SMUIO_V11_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_smuio_funcs smuio_v11_0_funcs;
+
+#endif /* __SMUIO_V11_0_H__ */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
