Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47EBC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF2A60233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF2A60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2421089C7F;
	Wed, 24 Feb 2021 22:19:29 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F2B89C7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajmzf9GbnA9OiEqgcz02qZW9L0qsc6y686enpAjQ2fpgMvPpYsNoZgCs5Cxf6YoYAus7jtfyQRLpHa6fxILTPEn+zBKTnATs4ibwae+blH3bcpKpWod2WBAgfqUDO3On52pO5T/zV7pgz9oIE5bI6Q+hI4cVxZin0ro3Wm8ydIyPaHT/q+0kVdShYwI3hyPXHXm1gJY7AZA7Q80L8j8Th7+K+XRYrxViOyt/c4bXjQUaQFSYMmOuKnLvI28jdCfWLe6f505yJRgtkftpZ771IpmFASMRA1VAUHLzGg9DUsWZHgojCHyplKFhryf7I7+AlfXl71hQchFNyBuMob+B0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX3DvyanNgPKHgemxlmir8deubavmiinug1fkzVCHig=;
 b=kIG4B95gvrcF0KGO1A51cAWSXAugoVl2wSEpqBUkr9uL/vfor4g/j/RVoM5MCjBC2Koqy3+hQZuBFgcdqvjog9PM472RH8qBLEAWNXpZykQTSx0Wkka02VWy+236reenMLUJdIMrrlkRB/Der9g3HptEIpm6mz5qypblzW62YifCGH+jZ2EhC0Sn3o3+hhgk7Qp/JaxyUmMSfm/u9cAisnhZHRViilWALY6VHZPciB+XjX1DFMD4UgyNHOsz/92iXwq8xV3stUV8i3MBl1wJV2oFeLz4XULy97vmfmiCO1wzM0ens29M0v2x0Ad2FNw4CxSHJxi8qMFXx5HnDKh8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX3DvyanNgPKHgemxlmir8deubavmiinug1fkzVCHig=;
 b=5iXntrXpB1BWGaGYp0kiXtm0PSGZ/YrHqQwC7ECUeWUCO8LcAut6SwHrGext+DzMGnWrQoSY7GfvbYp3TXlJGmogkb6ax84ISI1pr6w5q2BuBx3F+qR0NE853+aAqThxs+TCKsKXr7hnbYJnjbZJRm2bAJT/1HLkp3su7OZCQQU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:26 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:25 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 011/159] drm/amdgpu: add register base init for aldebaran (v2)
Date: Wed, 24 Feb 2021 17:16:31 -0500
Message-Id: <20210224221859.3068810-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5604772-26ce-48bc-925c-08d8d9123ea2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175F09DB6712DB14BD4B429F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFqm9/6UjIMcG4x7ITgBZi1XVHkQDCWN5CzJm2I34U4DbFkiG/mtMRYGyyVRP1EYNEueMTxTxYqyFE4L4ASCg1ZHL0FJeso7ZxCspPM5hsYT1/kmy2Z9iIs0Rq5YnfllZdxQVrFZWGzt9K2Y+JzEWRNy5c9v+dhr5lZEYzB28ANBmxam2XwWClBOIKd/VYn6/U20sEBdOoyd9hjH6oGn8tSjjSyAaYNBLFbbG18owGlGiD81vKPkjT6LXR/ryperBF13JdbLV3B7LeIcGNrzNbzKTWChV+WZn2UzJNlTlSfaefsNBe1n32P2B7adzmy0g3KmC84SLDgSQBL8pNVSTFxq9LBu/oR5Shvmn4mX9y6TeBSnzz4Al5KKdURa6rhZm+/2arvvVUvaEcy6PLBqQOtvp2BbRWtMLTZmGaZenkU7vB8e1H60SXbyNhR7BQ6vVmPmriuOkixNdXvXYvgNA4Mh1br5EiNtB4UgF1Dkfjv7lXBAEF7jEByrJdVisHJwAuF6KqLbw/CP7D/4PB/fVep++BBPtQoKiJIxhPQQ25fGMZIeELe6IbCETjqgy+w4kmpHi2hY1o0ynOIKGc17SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?517vI4jPoGQDEGTJDqiPSpyIBpy7Lm2GteYbVKtKOaMz7icTuSarcLUBBVWN?=
 =?us-ascii?Q?Ki3gAQpDhIef2VSL7qfVgzzPGNQoBSZo3jywi5R8z1vJZdJrhrYMdT17HdWk?=
 =?us-ascii?Q?8o8+eQBEmKhBlGSVtQivGwRF7TSrXNJbvEqfLi5LL1FZepolgUebDCUmfHi5?=
 =?us-ascii?Q?1o2RjV0PdtBPoJLAcKLiG5eFmOzok99zePZypxwdkgLdf8yF1UaY/f9u8x/J?=
 =?us-ascii?Q?5CLBNy4exVAqKktZ6Muo/XZj/IbY30uXNgGs4VVp0v93E0SFO9cSKkAtn7x3?=
 =?us-ascii?Q?Iwxf57v+hx7w9AWzLCv1ksq9kGG3UFEX2rKjF5+mSx6d/KI1aQD8jFHyK4V0?=
 =?us-ascii?Q?acLMFsLNG4yVrv10jaq98s9nAlX+KUs3XP2EIXWEaOaRbeP1tnEj7fxxB/gq?=
 =?us-ascii?Q?QnxWXx6IU3G4tXs6BBO8xWIUZ+lYeEcjc2jKwkaNx8JtGW+n1Xe4cf1I1jxs?=
 =?us-ascii?Q?HpGgatFIywZefP5Ap2CuDb9z2bRaPPH9e7v44KmoOXWW8fvUBMpV6KGVbIWo?=
 =?us-ascii?Q?H8fX+V8At7RpvLcg9fHYAguw56IZXLHcl4TcbP5sb/JsHBYD5Me6Xbl91zsq?=
 =?us-ascii?Q?CJog1K2qZFmLPG0t5LRH834EiBTDOu+gwEunM37MiHwsYRYEU4wjrUUg69xg?=
 =?us-ascii?Q?tRv1cYTd2QTeXGM7pvlVC29NxVb1q177dbW+jufhAR5YMTW4udXTbQGhNPEw?=
 =?us-ascii?Q?y/bBuggi2NZDL/4RkNhu5e4qVOilHdlV0SGajOmH+r93mj70NhH+3OeoGUP3?=
 =?us-ascii?Q?kEJTnGxH/DRt8VT2BKRwXqNuKrjlLiFOglzcjnxx8xMCttiVk/kREuZPqylP?=
 =?us-ascii?Q?MxBmdZVd24Q7JWc9k6p07xjZaofXxkyc5w40CwhFRGvg2CrCsgX8g2gbvmEi?=
 =?us-ascii?Q?iZXxLIw9Un4H+S1S1C/rNGsX84NG1MaOINEkcHj8/p7UDX8JTMk2xSSxR7jZ?=
 =?us-ascii?Q?P2aw1k8qYpFcTqRKHP6etS791uCCZ06TWoXc8Mk/oto1JVfUVpXvbpgL7vxs?=
 =?us-ascii?Q?ofqyfebAKJEpW6zxNMdxMPiz3z5J4xVPRsEp/VrX7/H97VPYPMa4auDuadmf?=
 =?us-ascii?Q?zmS98RLcwa2UktTh0fU0cQ3EbajBxtRaHXn4IvBn4VqYck/6DmCsw6um+w+j?=
 =?us-ascii?Q?mWATsG9DdgbrqtAFQ4BiiyJjTtmzw7P7gzJqMI4JYfH6F60p1ayv5v/aV2yX?=
 =?us-ascii?Q?1iZd7J2kovWnP/B2BErSQpEU92F+ar/whlitdDAf90exZiP7DoFmEfFr87JD?=
 =?us-ascii?Q?09+k1JGO1Pcvr6kcYSpWCK36OR8lsXvdL2Beowm2misTwf7MpPYju/wCmaAm?=
 =?us-ascii?Q?ENBnF5AwH28qFM9TaP6gG2+k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5604772-26ce-48bc-925c-08d8d9123ea2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:25.8655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LwTm4KM/NwCLV2SFktSNaM0lX06WA9nnj7EvEwkUodyt/F6mfQRCCOvibmfaxArMEo+L4+zGIMLiMIZcjKmvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Evan Quan <evan.quan@amd.com>, Le Ma <le.ma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

v1: add aldebaran_reg_base_init function to initialize
register base for aldebaran (Le)
v2: update VCN HWIP and initialize base offset (James)

Signed-off-by: Le Ma <le.ma@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
 .../gpu/drm/amd/amdgpu/aldebaran_reg_init.c   | 54 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  3 ++
 drivers/gpu/drm/amd/amdgpu/soc15.h            |  1 +
 4 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/aldebaran_reg_init.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 13ebb1f71e49..906bf2eaa158 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -71,7 +71,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
 	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o \
-	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o hdp_v5_0.o
+	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aldebaran_reg_init.c
new file mode 100644
index 000000000000..28e6c9ab8767
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran_reg_init.c
@@ -0,0 +1,54 @@
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
+#include "soc15.h"
+
+#include "soc15_common.h"
+#include "aldebaran_ip_offset.h"
+
+int aldebaran_reg_base_init(struct amdgpu_device *adev)
+{
+	/* HW has more IP blocks,  only initialized the block needed by our driver  */
+	uint32_t i;
+	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
+		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
+		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
+		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
+		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
+		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
+		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
+		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
+		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
+		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(SDMA0_BASE.instance[i]));
+		adev->reg_offset[SDMA1_HWIP][i] = (uint32_t *)(&(SDMA1_BASE.instance[i]));
+		adev->reg_offset[SDMA2_HWIP][i] = (uint32_t *)(&(SDMA2_BASE.instance[i]));
+		adev->reg_offset[SDMA3_HWIP][i] = (uint32_t *)(&(SDMA3_BASE.instance[i]));
+		adev->reg_offset[SDMA4_HWIP][i] = (uint32_t *)(&(SDMA4_BASE.instance[i]));
+		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
+		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));
+		adev->reg_offset[UMC_HWIP][i] = (uint32_t *)(&(UMC_BASE.instance[i]));
+		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(VCN_BASE.instance[i]));
+	}
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 1221aa6b40a9..fc1eef339d2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -661,6 +661,9 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
 	case CHIP_ARCTURUS:
 		arct_reg_base_init(adev);
 		break;
+	case CHIP_ALDEBARAN:
+		aldebaran_reg_base_init(adev);
+		break;
 	default:
 		DRM_ERROR("Unsupported asic type: %d!\n", adev->asic_type);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index 8f38f047265b..0e37f4ce8364 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -100,6 +100,7 @@ void soc15_program_register_sequence(struct amdgpu_device *adev,
 int vega10_reg_base_init(struct amdgpu_device *adev);
 int vega20_reg_base_init(struct amdgpu_device *adev);
 int arct_reg_base_init(struct amdgpu_device *adev);
+int aldebaran_reg_base_init(struct amdgpu_device *adev);
 
 void vega10_doorbell_index_init(struct amdgpu_device *adev);
 void vega20_doorbell_index_init(struct amdgpu_device *adev);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
