Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D570CC4741F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D672084C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sWNWDHAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D672084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CCD4894D7;
	Mon,  9 Nov 2020 08:17:20 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700080.outbound.protection.outlook.com [40.107.70.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 184FC894D7
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 08:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAmI6mWD6SEd6miJ4nCIzb1WGdLJR2YUPQvt3KYnTSdWh/FiXKmN3ZfQEXtuGrOEBBpId+2Tp2/vd+aLsIMrh9rb90q0FsiY5O3vccyBKzY1WbyRWdlsihOY0fWRGfut+kJZCokcOQaNhBxFnyiIKQtuLbqZF+J3+gPeIzL1fmvh+pOZPJxBa//ey+maIaK9ziq78POks7zQdJr6yk+hGiFdFIgefhOu5qLmni3zY5FS3NLeIPIWDFwlhM67EoAfY1d8eXwZkiUB1+EQmj/bt42eyI9N+pvrDKyrNCf1eEVqgXWAi4r4Iv+7mu6RPKEwIdJGcbR+Ynx3kzMz2lao5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+mamEw1DzoBIpW99xpjJ+o+spyCe71DO9LmBHIH/mk=;
 b=XUrBu72nIxUUg0b84uER6H6t3HmmpE6s88Mq9sz3eRLbCzBf6NnN4WgvgxeiMuOi+ZT7epXMoaoXy4BdTCAf/IcrmaakF5inf4em3nGOgmeLx7da6i/7v1v2EE2eiq1jo7/JGfcCsq5FxdQSrrTuOeoCMWdUPLCiXDvDgqZzPIQsp4Ga8/cCGy98CKQ0orKbqDaC5q+Nd45K48RkTnCAVo3+K563GI/TQ1E3few1SrhdZ8PV+sPRLaEUBpnl5aksT1tnLMmNZtAw+T8hr8PoR7eXe4al7v8PvKh5hFQD3SsOa05qoEJhUgFTlM9gysgAzT8+p9l3VVicapGiDiIlaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+mamEw1DzoBIpW99xpjJ+o+spyCe71DO9LmBHIH/mk=;
 b=sWNWDHAQPIpjZsFWbQkT3um+yB44YHP5RhUnGI7J5Yu/VU9124yIm9OpXAAhc9qpp9Kd5kPtERFQI29hrcg0iRu/bF7u9tJnnqmA9mVU2BrlljYc2C5FhiNxDaDkTAOwfz6nNkrBTbh783x4AOwFy0h2WyQqTfkL9A54mIqchg0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.24; Mon, 9 Nov 2020 08:17:16 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%8]) with mapi id 15.20.3541.022; Mon, 9 Nov 2020
 08:17:16 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: implement smuio v9_0 callbacks
Date: Mon,  9 Nov 2020 16:16:49 +0800
Message-Id: <20201109081652.1964-2-Hawking.Zhang@amd.com>
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
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 08:17:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8eaf755b-5d70-457e-cd04-08d88487de9e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3274:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB327474E529C89B9BF0B6B170FCEA0@DM6PR12MB3274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFLTaZ0gvqsTMvnkqcKcAlT4nE4kEYjloSoStG7ntDLPelbf4QDe34CNsupjndph9TqZhXwm937Ul9RrG4oOCQWUwoia+qYcD3Bj/5Rp5GNyYB5b0rCdR9aClWiWrV5BdzX7XlwTtAoFMSs7gR7I2a2J5X271a0TOFoPsyCmJBNsrlF19oPlS8l+ANtelS8hZDP5B5bLuNcA/8vwiWF7GKXdJTkZGhyD07OBJ22Rps79EMp4y/sA9ctfVm4SPueuAdUPdwDxO4ikMK+9Q3VpIpB1nWii6FfipYjJZ40Tc5oYwUf2C1gL1rzSKgsW32wt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(66476007)(66556008)(316002)(66946007)(6916009)(5660300002)(8676002)(8936002)(4326008)(1076003)(26005)(2906002)(86362001)(83380400001)(6486002)(2616005)(478600001)(956004)(186003)(16526019)(52116002)(6666004)(36756003)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: g40GF24QlGxeCUTVzr6J+DxJ0E6csqZoIFiKkVr85fex9gc5BWjKTHxr8ATsozcjY3ATj6d106Ggygd01iPiRv0e2flHwQxhKu98MijQD7X6o1vVCOizAIl9d9LyCgzNDyWjE5tWgd5cjuu77OYYSD1dXbrWY5+oPw7nlYh0503qqjJmWW7d6i77wYG6ao+f0rV6VoD3tzhDbeROPCbBzDfneTUvpUrzkeAl1+5V580BPNteBXpBOApOZ+MlYX5ipXSF+Ew3R0ZiAB/WfzcuNVfKQw7zcbf5FgIPQ7E4mF+E7iH6ui5sXYzlKqJuQrHIBlUokgujyL6UyB87MLnSGS7C3FJYJEesCFe2Yaqwm9VnYtjDUWkwRdRpaFnVFhu22/6ygIc3wT5kbKHpplW7aSlN/OcatDqBl4KVOS28k2ZT/VpN9kTyYAFLaMEB0XlC1v2YiPEhYT362g0OxHYXwXfTJ8MGgv799yorJwOgCyRkBtBwVaPFm+lVkxDtHc0McP/DGDLn26o7nvVPnWJMWSg8bCc3Xd7pUouXmaHbCGqgFgvllpS5jJkkPgUdRNxFy8QBxLJuDxziBAA1CKcfCE1ME998lMQvbywZ39h4HGGbAgIedyciNp1cT/o5s5gIDaAKT7VyypjShiIpP8FigA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eaf755b-5d70-457e-cd04-08d88487de9e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 08:17:16.4938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JhE3A28cqebbeV8UY/qLMjCXgSwiN7aLzCQePYO8+3apVUetGKJo+0UcEo1of8lzolKVODyszLt2hBjfvAAXw==
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

Vega10/12 will use smuio v9_0 callbacks

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |  4 ++
 drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c | 77 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/smuio_v9_0.h | 30 +++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v9_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 6fde9a9..2d60a5b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -167,6 +167,10 @@ amdgpu-y += \
 	athub_v2_0.o \
 	athub_v2_1.o
 
+# add SMUIO block
+amdgpu-y += \
+	smuio_v9_0.o
+
 # add amdkfd interfaces
 amdgpu-y += amdgpu_amdkfd.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
new file mode 100644
index 0000000..c9c3e30
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
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
+#include "smuio_v9_0.h"
+#include "smuio/smuio_9_0_offset.h"
+#include "smuio/smuio_9_0_sh_mask.h"
+
+static u32 smuio_v9_0_get_rom_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, mmROM_INDEX);
+}
+
+static u32 smuio_v9_0_get_rom_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA);
+}
+
+void smuio_v9_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
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
+void smuio_v9_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+{
+	u32 data;
+
+	/* CGTT_ROM_CLK_CTRL0 is not availabe for APUs */
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	data = RREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0);
+	if (!(data & CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK))
+		*flags |= AMD_CG_SUPPORT_ROM_MGCG;
+}
+
+const struct amdgpu_smuio_funcs smuio_v9_0_funcs = {
+	.get_rom_index_offset = smuio_v9_0_get_rom_index_offset,
+	.get_rom_data_offset = smuio_v9_0_get_rom_data_offset,
+	.update_rom_clock_gating = smuio_v9_0_update_rom_clock_gating,
+	.get_clock_gating_state = smuio_v9_0_get_clock_gating_state,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.h b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.h
new file mode 100644
index 0000000..fc265ce
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.h
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
+#ifndef __SMUIO_V9_0_H__
+#define __SMUIO_V9_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_smuio_funcs smuio_v9_0_funcs;
+
+#endif /* __SMUIO_V9_0_H__ */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
