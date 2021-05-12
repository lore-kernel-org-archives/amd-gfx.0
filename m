Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1132C4361B
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9FE61417
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9FE61417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F0E6EC66;
	Wed, 12 May 2021 17:31:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144956EC65
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYIJ8A3doJUt/SoDjdoKYe1lwxlTLCX26oCCX64WVm1U+OLVugjRNKMz3R+z2C0P8xcR/rhGKgZBdE10ZYxeDdP+9yRzYkGDAlZ4kuX1ws36n6JyBFuHGhMQMJEXiqyS/Qyv3lDTZ7BsWVSnEYwgDa9V/EeuvGzm43YbpCMpUyc+u2FFC73aKwQB20KaDUP+9M+FLbEZlyNRrk/rHyB7aHo+tX5Bq6juxFKWrhE+t+6aeUz/xLHNkVOuyA8fB4QlNz2w9/CdBDaoWQ2OBBGIOdQpR7r/2MQsYvJw9yBEnb9ZWYIQUXXzk4e/9HT38KUOIXRv0KvppAdgEbfbzCKNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buIOrphYOuXvpxF7dAmDogAbkhZadC1DcZXEOwo9HQc=;
 b=cXJ8fuMaZVlMkppi9VI2NRbjo3fiRIrFyg+N+uWpJ4fA298Q0BcTQKsVT8Pu0I/4MDfFp1ZaddKC6KSDA4mm94OYF8+chg85IQQnuPnncYub8FogncWU4PuRl4/217Vw8Y7a7X4RSYgnmDJM5y0BNYw9rYjaNNffwXbx3XBhiYF5jr8f7Ynr2UjS5vtIUXMX1r0jg7jA3+/n0wLkdjPbr0950+tCY52cgV1bpZk0zkZzrfIMSwA8N3lVRakKKql+Hfb7JprbsAgJde/5IzWzFOBWfO/Pn+dB2NeHa3uKW/ZhJb5RIhAcDp3EZvz191l6+CtDGV3ynVieS0ZOoOZVkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buIOrphYOuXvpxF7dAmDogAbkhZadC1DcZXEOwo9HQc=;
 b=bc7x16j2k1HTufUXTkW4QDlNPt/pnPtyYwpaHPODy87M/uI+RSZEv6CTrOnAu5blRb8n9BWUQoQzMO/VaRoqV07G0Mrueo+o85trp3M2yi5TIMqZ8IOATb7FMcQ8nR8u4did4NEsdyt+Z9fTTzaV/Ogxw9EN5g4nlyU+vQJT0qk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4692.namprd12.prod.outlook.com (2603:10b6:208:82::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 12 May
 2021 17:31:17 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:17 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/49] drm/amd/amdgpu: initialize IP offset for beige_goby
Date: Wed, 12 May 2021 13:30:12 -0400
Message-Id: <20210512173053.2347842-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adec3b49-df90-4944-37f3-08d9156bbf98
X-MS-TrafficTypeDiagnostic: BL0PR12MB4692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB469232B67D308B28466BADF7F7529@BL0PR12MB4692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pdQVIwUMjqgvOPKEdZlnIY/95GDcDnQh06XSNNBpovLnhSoQff15o248dBLdEpCOnKsTUKCq813X8a4WHk35p1FgSRe8krZ4ybGfpqRImgZBnUgPk8m7nUpyO2BQFsEyOc/qR1Lh9NcyaatwAKZzva67DfLuwuqy33tOLV4qSCbVU6Q3hmwUw8qkIxH3PonNwKjASj4ckfr58goQuSH1/d3IyPoz48HDJwFvkj2V3LjNw4Pugs0PS3WJI0WoN2nlRr1j9GuZd1PuAYMS/LOgjLhG6MzFY4/Hf4gFJf9e1qZt2CJiNGVdg4ftPkh2qDRLhilWroINQMpXbbTA0qSG8bo7LA/PTVf08/Br6iURRhC1+gMkMzgrwXq7TvsaMG4DKRkREsza5/xHzF+o4a8bqaZUqe3lqCutMXTh6Y/cS/C2YslOmuIPbX/2wcZ+4/Fr1RKxCpl7evYpoOJBNUnuayPh/P9AioJ17zvR9tqQoKtq/8uaR2HSJb9NpBZ3QjFU2r4mwIochXiGKFRwvR9CwnNLlRAu0kk2reLmGV5esTtBvEE3B2srlmg+MuBIhX2e3Ul295GXQ8TEzlyB69+qZtAVXVzJCLYJJmUcAx/vCj1SGLnZNPb3IqXdOfyPQcGh/g9qZ4NUv2kINWjoFYNLeF8ePMjqZsqTZmP/bO96LRhxXIVm+r7k0tyPTyLbmzM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(6666004)(4326008)(2906002)(83380400001)(8936002)(6512007)(16526019)(36756003)(478600001)(2616005)(316002)(66476007)(186003)(956004)(8676002)(54906003)(86362001)(66556008)(66946007)(30864003)(1076003)(6486002)(26005)(38350700002)(6916009)(6506007)(52116002)(38100700002)(5660300002)(69590400013)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fp1t+N2460iWpmurx9YWYmbswLzbXBX3pdrAqGjrs1xOZL8dmnmxu1BmI3Ix?=
 =?us-ascii?Q?uvWKzjRZeua17K8tv1BDGyNyOMAlt2+F8kKy6kwLyp6t9FZhwWSYzOm2YAGP?=
 =?us-ascii?Q?LFYTVTpuLfWDCQmjKkkjniRj8Nb80Fc+HFmo0gmSn8LQ+LdfpXfNa5AATRDb?=
 =?us-ascii?Q?TqNs4Vrmn4WTzQrMivVi/BVkxYNeYF3SnR0/qbmnC2qULaRzC/d3CrbBmGM4?=
 =?us-ascii?Q?+uZn+hwDli1wHTpr3su/7kHl4V8Ae2KVKm+DN+mjks0t6w9Cb0yzGW91NxgU?=
 =?us-ascii?Q?0Z19S5MKSVnKPob8JCz87Pn6w0ztBqOknKJjDn/EGQkYhvJuJJxGWAXw4/J0?=
 =?us-ascii?Q?zdBH00iFEvV1HmseyrhonROJIDhKEoKgKJXsRt4L6GiYHWJuFvRM3Q1K7IG7?=
 =?us-ascii?Q?4eK2xxH476WU+2MW6VUZldTlpwbCpnNf2kfQT68QL1Z+Sm6jP5eEhagqOiNV?=
 =?us-ascii?Q?cerlt8TyyheUPcn6gNmduameLzB+UlYSImNc1e/rxQlQaOsSvk0GjpLkEFML?=
 =?us-ascii?Q?ccYJCX4ghxDJpAGUy66veAUXEhvLquys/uHr7XRVOMBXDKV3N+3l7QEZAVAZ?=
 =?us-ascii?Q?4XsuOPPN3mZophRRBjEd2FAkWt2ZxVth4hi0epuog0HQCUU1lnYBkA1RwJb5?=
 =?us-ascii?Q?G6guc4qPBmjfhoUTjdERWHF97JLdjpsxVYokf9ISiIuYW/MZH54Q1TEtEmoY?=
 =?us-ascii?Q?Sg4XJW5oAL3eGQKL1tdbbj/R/B4kc+03DrTqdEJBkqsRA8cA/ycDvAUvXnmv?=
 =?us-ascii?Q?5dnoeJgZpuT/qRjldho9zJddwMNtzKOalpKaLp2WB7OB+bABOYdIXunWEDFw?=
 =?us-ascii?Q?Karfw+hi6Gm93QLcYIGUgH66TBLkWrWeGCeah3EdvSP8KS97M9IJT4VoAvHY?=
 =?us-ascii?Q?fRR0Vi14KEIwj1YcBsDArxsZ/v5IHwj3ZfUfbMENU4kxPNpyDZG8qoTX1ksz?=
 =?us-ascii?Q?YcbtbPy/zffYON4XEHLvNP6emN7XTLhtXpqDysdIDjrETyKuiSEFW8C0so3+?=
 =?us-ascii?Q?7NeEaSQQFYidibDxEcU8D2qs8y1nmY+wxFF2P2oVOBnuNH2p75WHIj4wf+zl?=
 =?us-ascii?Q?0lNXQFYxTDeDeRt3Q8wgw+usBntFhp78/BfHvH+LSta1CkIZ9LBfI7FaVg29?=
 =?us-ascii?Q?mVmzTrbPiXgduvxSzXH/UuO/n+NhFN8cEJ5GHSqOF3zTiJnlK4fTjlGaAlo/?=
 =?us-ascii?Q?2JG6SySSOp2MsgxXle6Lx8Cuk375WsynfynHKjCviPA6/UOlk7J2urWstvO7?=
 =?us-ascii?Q?BEUg2Qp0QNrv7d4MF+A+T2wr+6CpSw5GM5UbJnoUpd1LqknrmEnOcowarDqF?=
 =?us-ascii?Q?bqzTN19JIj7BR41RIkw+uhel?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adec3b49-df90-4944-37f3-08d9156bbf98
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:17.3427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZ0q9+27MYXbP+FleFOYSob+Yv8GQamPWkESROIC1wHVsPX7HzPLNmzhIBXfFicWoQujAToIJNItC3IAWXcatg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4692
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Add ip offset definition for beige_goby and initialize it

v2: squash in fixes (Alex)

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 .../gpu/drm/amd/amdgpu/beige_goby_reg_init.c  |   54 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |    3 +
 drivers/gpu/drm/amd/amdgpu/nv.h               |    1 +
 .../drm/amd/include/beige_goby_ip_offset.h    | 1274 +++++++++++++++++
 5 files changed, 1334 insertions(+), 1 deletion(-)
 create mode 100755 drivers/gpu/drm/amd/amdgpu/beige_goby_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/include/beige_goby_ip_offset.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 418e6747b3d5..580a4eb631b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -71,7 +71,8 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
 	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o \
-	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o
+	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o \
+	beige_goby_reg_init.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/beige_goby_reg_init.c b/drivers/gpu/drm/amd/amdgpu/beige_goby_reg_init.c
new file mode 100755
index 000000000000..608a113ce354
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/beige_goby_reg_init.c
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
+#include "nv.h"
+
+#include "soc15_common.h"
+#include "soc15_hw_ip.h"
+#include "beige_goby_ip_offset.h"
+
+int beige_goby_reg_base_init(struct amdgpu_device *adev)
+{
+	/* HW has more IP blocks,  only initialize the block needed by driver */
+	uint32_t i;
+	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
+		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
+		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
+		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
+		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
+		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
+		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
+		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(VCN0_BASE.instance[i]));
+		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
+		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DCN_BASE.instance[i]));
+		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
+		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SDMA1_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SDMA2_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SDMA3_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
+		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));
+	}
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2042ac4912a8..d227264a0bda 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -659,6 +659,9 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 	case CHIP_DIMGREY_CAVEFISH:
 		dimgrey_cavefish_reg_base_init(adev);
 		break;
+	case CHIP_BEIGE_GOBY:
+		beige_goby_reg_base_init(adev);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index 515d67bf249f..330438388fde 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -36,4 +36,5 @@ int navi12_reg_base_init(struct amdgpu_device *adev);
 int sienna_cichlid_reg_base_init(struct amdgpu_device *adev);
 void vangogh_reg_base_init(struct amdgpu_device *adev);
 int dimgrey_cavefish_reg_base_init(struct amdgpu_device *adev);
+int beige_goby_reg_base_init(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/include/beige_goby_ip_offset.h b/drivers/gpu/drm/amd/include/beige_goby_ip_offset.h
new file mode 100644
index 000000000000..26044cb285d2
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/beige_goby_ip_offset.h
@@ -0,0 +1,1274 @@
+/*
+ * Copyright (C) 2020  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _beige_goby_ip_offset_HEADER
+#define _beige_goby_ip_offset_HEADER
+
+
+#define MAX_INSTANCE                                        7
+#define MAX_SEGMENT                                         6
+
+
+struct IP_BASE_INSTANCE
+{
+    unsigned int segment[MAX_SEGMENT];
+};
+
+struct IP_BASE
+{
+    struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
+};
+
+
+static const struct IP_BASE ATHUB_BASE = { { { { 0x00000C00, 0x02408C00, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0, 0 } },
+                                        { { 0x00016E00, 0x02401C00, 0, 0, 0, 0 } },
+                                        { { 0x00017000, 0x02402000, 0, 0, 0, 0 } },
+                                        { { 0x00017200, 0x02402400, 0, 0, 0, 0 } },
+                                        { { 0x0001B000, 0x0242D800, 0, 0, 0, 0 } },
+                                        { { 0x0001B200, 0x0242DC00, 0, 0, 0, 0 } },
+                                        { { 0x00017E00, 0x0240BC00, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DBGU_IO0_BASE = { { { { 0x000001E0, 0x0240B400, 0, 0, 0, 0 } },
+                                        { { 0x00000260, 0x02413C00, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DF_BASE = { { { { 0x00007000, 0x0240B800, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DIO_BASE = { { { { 0x02404000, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DPCS_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE FUSE_BASE = { { { { 0x00017400, 0x02401400, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE GC_BASE = { { { { 0x00001260, 0x0000A000, 0x0001C000, 0x02402C00, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE HDA_BASE = { { { { 0x004C0000, 0x02404800, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE HDP_BASE = { { { { 0x00000F20, 0x0240A400, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MMHUB_BASE = { { { { 0x0001A000, 0x02408800, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MP0_BASE = { { { { 0x00016000, 0x00DC0000, 0x00E00000, 0x00E40000, 0x0243FC00, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MP1_BASE = { { { { 0x00016000, 0x00DC0000, 0x00E00000, 0x00E40000, 0x0243FC00, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE OSSSYS_BASE = { { { { 0x000010A0, 0x0240A000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE PCIE0_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SDMA0_BASE = { { { { 0x00001260, 0x0000A000, 0x0001C000, 0x02402C00, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SMUIO_BASE = { { { { 0x00016800, 0x00016A00, 0x00440000, 0x02401000, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE THM_BASE = { { { { 0x00016600, 0x02400C00, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE UMC_BASE = { { { { 0x00014000, 0x02425800, 0, 0, 0, 0 } },
+                                        { { 0x00054000, 0x02425C00, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE VCN0_BASE = { { { { 0x00007800, 0x00007E00, 0x02403000, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+
+
+#define ATHUB_BASE__INST0_SEG0                     0x00000C00
+#define ATHUB_BASE__INST0_SEG1                     0x02408C00
+#define ATHUB_BASE__INST0_SEG2                     0
+#define ATHUB_BASE__INST0_SEG3                     0
+#define ATHUB_BASE__INST0_SEG4                     0
+#define ATHUB_BASE__INST0_SEG5                     0
+
+#define ATHUB_BASE__INST1_SEG0                     0
+#define ATHUB_BASE__INST1_SEG1                     0
+#define ATHUB_BASE__INST1_SEG2                     0
+#define ATHUB_BASE__INST1_SEG3                     0
+#define ATHUB_BASE__INST1_SEG4                     0
+#define ATHUB_BASE__INST1_SEG5                     0
+
+#define ATHUB_BASE__INST2_SEG0                     0
+#define ATHUB_BASE__INST2_SEG1                     0
+#define ATHUB_BASE__INST2_SEG2                     0
+#define ATHUB_BASE__INST2_SEG3                     0
+#define ATHUB_BASE__INST2_SEG4                     0
+#define ATHUB_BASE__INST2_SEG5                     0
+
+#define ATHUB_BASE__INST3_SEG0                     0
+#define ATHUB_BASE__INST3_SEG1                     0
+#define ATHUB_BASE__INST3_SEG2                     0
+#define ATHUB_BASE__INST3_SEG3                     0
+#define ATHUB_BASE__INST3_SEG4                     0
+#define ATHUB_BASE__INST3_SEG5                     0
+
+#define ATHUB_BASE__INST4_SEG0                     0
+#define ATHUB_BASE__INST4_SEG1                     0
+#define ATHUB_BASE__INST4_SEG2                     0
+#define ATHUB_BASE__INST4_SEG3                     0
+#define ATHUB_BASE__INST4_SEG4                     0
+#define ATHUB_BASE__INST4_SEG5                     0
+
+#define ATHUB_BASE__INST5_SEG0                     0
+#define ATHUB_BASE__INST5_SEG1                     0
+#define ATHUB_BASE__INST5_SEG2                     0
+#define ATHUB_BASE__INST5_SEG3                     0
+#define ATHUB_BASE__INST5_SEG4                     0
+#define ATHUB_BASE__INST5_SEG5                     0
+
+#define ATHUB_BASE__INST6_SEG0                     0
+#define ATHUB_BASE__INST6_SEG1                     0
+#define ATHUB_BASE__INST6_SEG2                     0
+#define ATHUB_BASE__INST6_SEG3                     0
+#define ATHUB_BASE__INST6_SEG4                     0
+#define ATHUB_BASE__INST6_SEG5                     0
+
+#define CLK_BASE__INST0_SEG0                       0x00016C00
+#define CLK_BASE__INST0_SEG1                       0x02401800
+#define CLK_BASE__INST0_SEG2                       0
+#define CLK_BASE__INST0_SEG3                       0
+#define CLK_BASE__INST0_SEG4                       0
+#define CLK_BASE__INST0_SEG5                       0
+
+#define CLK_BASE__INST1_SEG0                       0x00016E00
+#define CLK_BASE__INST1_SEG1                       0x02401C00
+#define CLK_BASE__INST1_SEG2                       0
+#define CLK_BASE__INST1_SEG3                       0
+#define CLK_BASE__INST1_SEG4                       0
+#define CLK_BASE__INST1_SEG5                       0
+
+#define CLK_BASE__INST2_SEG0                       0x00017000
+#define CLK_BASE__INST2_SEG1                       0x02402000
+#define CLK_BASE__INST2_SEG2                       0
+#define CLK_BASE__INST2_SEG3                       0
+#define CLK_BASE__INST2_SEG4                       0
+#define CLK_BASE__INST2_SEG5                       0
+
+#define CLK_BASE__INST3_SEG0                       0x00017200
+#define CLK_BASE__INST3_SEG1                       0x02402400
+#define CLK_BASE__INST3_SEG2                       0
+#define CLK_BASE__INST3_SEG3                       0
+#define CLK_BASE__INST3_SEG4                       0
+#define CLK_BASE__INST3_SEG5                       0
+
+#define CLK_BASE__INST4_SEG0                       0x0001B000
+#define CLK_BASE__INST4_SEG1                       0x0242D800
+#define CLK_BASE__INST4_SEG2                       0
+#define CLK_BASE__INST4_SEG3                       0
+#define CLK_BASE__INST4_SEG4                       0
+#define CLK_BASE__INST4_SEG5                       0
+
+#define CLK_BASE__INST5_SEG0                       0x0001B200
+#define CLK_BASE__INST5_SEG1                       0x0242DC00
+#define CLK_BASE__INST5_SEG2                       0
+#define CLK_BASE__INST5_SEG3                       0
+#define CLK_BASE__INST5_SEG4                       0
+#define CLK_BASE__INST5_SEG5                       0
+
+#define CLK_BASE__INST6_SEG0                       0x00017E00
+#define CLK_BASE__INST6_SEG1                       0x0240BC00
+#define CLK_BASE__INST6_SEG2                       0
+#define CLK_BASE__INST6_SEG3                       0
+#define CLK_BASE__INST6_SEG4                       0
+#define CLK_BASE__INST6_SEG5                       0
+
+#define DBGU_IO0_BASE__INST0_SEG0                  0x000001E0
+#define DBGU_IO0_BASE__INST0_SEG1                  0x0240B400
+#define DBGU_IO0_BASE__INST0_SEG2                  0
+#define DBGU_IO0_BASE__INST0_SEG3                  0
+#define DBGU_IO0_BASE__INST0_SEG4                  0
+#define DBGU_IO0_BASE__INST0_SEG5                  0
+
+#define DBGU_IO0_BASE__INST1_SEG0                  0x00000260
+#define DBGU_IO0_BASE__INST1_SEG1                  0x02413C00
+#define DBGU_IO0_BASE__INST1_SEG2                  0
+#define DBGU_IO0_BASE__INST1_SEG3                  0
+#define DBGU_IO0_BASE__INST1_SEG4                  0
+#define DBGU_IO0_BASE__INST1_SEG5                  0
+
+#define DBGU_IO0_BASE__INST2_SEG0                  0
+#define DBGU_IO0_BASE__INST2_SEG1                  0
+#define DBGU_IO0_BASE__INST2_SEG2                  0
+#define DBGU_IO0_BASE__INST2_SEG3                  0
+#define DBGU_IO0_BASE__INST2_SEG4                  0
+#define DBGU_IO0_BASE__INST2_SEG5                  0
+
+#define DBGU_IO0_BASE__INST3_SEG0                  0
+#define DBGU_IO0_BASE__INST3_SEG1                  0
+#define DBGU_IO0_BASE__INST3_SEG2                  0
+#define DBGU_IO0_BASE__INST3_SEG3                  0
+#define DBGU_IO0_BASE__INST3_SEG4                  0
+#define DBGU_IO0_BASE__INST3_SEG5                  0
+
+#define DBGU_IO0_BASE__INST4_SEG0                  0
+#define DBGU_IO0_BASE__INST4_SEG1                  0
+#define DBGU_IO0_BASE__INST4_SEG2                  0
+#define DBGU_IO0_BASE__INST4_SEG3                  0
+#define DBGU_IO0_BASE__INST4_SEG4                  0
+#define DBGU_IO0_BASE__INST4_SEG5                  0
+
+#define DBGU_IO0_BASE__INST5_SEG0                  0
+#define DBGU_IO0_BASE__INST5_SEG1                  0
+#define DBGU_IO0_BASE__INST5_SEG2                  0
+#define DBGU_IO0_BASE__INST5_SEG3                  0
+#define DBGU_IO0_BASE__INST5_SEG4                  0
+#define DBGU_IO0_BASE__INST5_SEG5                  0
+
+#define DBGU_IO0_BASE__INST6_SEG0                  0
+#define DBGU_IO0_BASE__INST6_SEG1                  0
+#define DBGU_IO0_BASE__INST6_SEG2                  0
+#define DBGU_IO0_BASE__INST6_SEG3                  0
+#define DBGU_IO0_BASE__INST6_SEG4                  0
+#define DBGU_IO0_BASE__INST6_SEG5                  0
+
+#define DF_BASE__INST0_SEG0                        0x00007000
+#define DF_BASE__INST0_SEG1                        0x0240B800
+#define DF_BASE__INST0_SEG2                        0
+#define DF_BASE__INST0_SEG3                        0
+#define DF_BASE__INST0_SEG4                        0
+#define DF_BASE__INST0_SEG5                        0
+
+#define DF_BASE__INST1_SEG0                        0
+#define DF_BASE__INST1_SEG1                        0
+#define DF_BASE__INST1_SEG2                        0
+#define DF_BASE__INST1_SEG3                        0
+#define DF_BASE__INST1_SEG4                        0
+#define DF_BASE__INST1_SEG5                        0
+
+#define DF_BASE__INST2_SEG0                        0
+#define DF_BASE__INST2_SEG1                        0
+#define DF_BASE__INST2_SEG2                        0
+#define DF_BASE__INST2_SEG3                        0
+#define DF_BASE__INST2_SEG4                        0
+#define DF_BASE__INST2_SEG5                        0
+
+#define DF_BASE__INST3_SEG0                        0
+#define DF_BASE__INST3_SEG1                        0
+#define DF_BASE__INST3_SEG2                        0
+#define DF_BASE__INST3_SEG3                        0
+#define DF_BASE__INST3_SEG4                        0
+#define DF_BASE__INST3_SEG5                        0
+
+#define DF_BASE__INST4_SEG0                        0
+#define DF_BASE__INST4_SEG1                        0
+#define DF_BASE__INST4_SEG2                        0
+#define DF_BASE__INST4_SEG3                        0
+#define DF_BASE__INST4_SEG4                        0
+#define DF_BASE__INST4_SEG5                        0
+
+#define DF_BASE__INST5_SEG0                        0
+#define DF_BASE__INST5_SEG1                        0
+#define DF_BASE__INST5_SEG2                        0
+#define DF_BASE__INST5_SEG3                        0
+#define DF_BASE__INST5_SEG4                        0
+#define DF_BASE__INST5_SEG5                        0
+
+#define DF_BASE__INST6_SEG0                        0
+#define DF_BASE__INST6_SEG1                        0
+#define DF_BASE__INST6_SEG2                        0
+#define DF_BASE__INST6_SEG3                        0
+#define DF_BASE__INST6_SEG4                        0
+#define DF_BASE__INST6_SEG5                        0
+
+#define DIO_BASE__INST0_SEG0                       0x02404000
+#define DIO_BASE__INST0_SEG1                       0
+#define DIO_BASE__INST0_SEG2                       0
+#define DIO_BASE__INST0_SEG3                       0
+#define DIO_BASE__INST0_SEG4                       0
+#define DIO_BASE__INST0_SEG5                       0
+
+#define DIO_BASE__INST1_SEG0                       0
+#define DIO_BASE__INST1_SEG1                       0
+#define DIO_BASE__INST1_SEG2                       0
+#define DIO_BASE__INST1_SEG3                       0
+#define DIO_BASE__INST1_SEG4                       0
+#define DIO_BASE__INST1_SEG5                       0
+
+#define DIO_BASE__INST2_SEG0                       0
+#define DIO_BASE__INST2_SEG1                       0
+#define DIO_BASE__INST2_SEG2                       0
+#define DIO_BASE__INST2_SEG3                       0
+#define DIO_BASE__INST2_SEG4                       0
+#define DIO_BASE__INST2_SEG5                       0
+
+#define DIO_BASE__INST3_SEG0                       0
+#define DIO_BASE__INST3_SEG1                       0
+#define DIO_BASE__INST3_SEG2                       0
+#define DIO_BASE__INST3_SEG3                       0
+#define DIO_BASE__INST3_SEG4                       0
+#define DIO_BASE__INST3_SEG5                       0
+
+#define DIO_BASE__INST4_SEG0                       0
+#define DIO_BASE__INST4_SEG1                       0
+#define DIO_BASE__INST4_SEG2                       0
+#define DIO_BASE__INST4_SEG3                       0
+#define DIO_BASE__INST4_SEG4                       0
+#define DIO_BASE__INST4_SEG5                       0
+
+#define DIO_BASE__INST5_SEG0                       0
+#define DIO_BASE__INST5_SEG1                       0
+#define DIO_BASE__INST5_SEG2                       0
+#define DIO_BASE__INST5_SEG3                       0
+#define DIO_BASE__INST5_SEG4                       0
+#define DIO_BASE__INST5_SEG5                       0
+
+#define DIO_BASE__INST6_SEG0                       0
+#define DIO_BASE__INST6_SEG1                       0
+#define DIO_BASE__INST6_SEG2                       0
+#define DIO_BASE__INST6_SEG3                       0
+#define DIO_BASE__INST6_SEG4                       0
+#define DIO_BASE__INST6_SEG5                       0
+
+#define DCN_BASE__INST0_SEG0                       0x00000012
+#define DCN_BASE__INST0_SEG1                       0x000000C0
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+#define DCN_BASE__INST0_SEG3                       0x00009000
+#define DCN_BASE__INST0_SEG4                       0x02403C00
+#define DCN_BASE__INST0_SEG5                       0
+
+#define DCN_BASE__INST1_SEG0                       0
+#define DCN_BASE__INST1_SEG1                       0
+#define DCN_BASE__INST1_SEG2                       0
+#define DCN_BASE__INST1_SEG3                       0
+#define DCN_BASE__INST1_SEG4                       0
+#define DCN_BASE__INST1_SEG5                       0
+
+#define DCN_BASE__INST2_SEG0                       0
+#define DCN_BASE__INST2_SEG1                       0
+#define DCN_BASE__INST2_SEG2                       0
+#define DCN_BASE__INST2_SEG3                       0
+#define DCN_BASE__INST2_SEG4                       0
+#define DCN_BASE__INST2_SEG5                       0
+
+#define DCN_BASE__INST3_SEG0                       0
+#define DCN_BASE__INST3_SEG1                       0
+#define DCN_BASE__INST3_SEG2                       0
+#define DCN_BASE__INST3_SEG3                       0
+#define DCN_BASE__INST3_SEG4                       0
+#define DCN_BASE__INST3_SEG5                       0
+
+#define DCN_BASE__INST4_SEG0                       0
+#define DCN_BASE__INST4_SEG1                       0
+#define DCN_BASE__INST4_SEG2                       0
+#define DCN_BASE__INST4_SEG3                       0
+#define DCN_BASE__INST4_SEG4                       0
+#define DCN_BASE__INST4_SEG5                       0
+
+#define DCN_BASE__INST5_SEG0                       0
+#define DCN_BASE__INST5_SEG1                       0
+#define DCN_BASE__INST5_SEG2                       0
+#define DCN_BASE__INST5_SEG3                       0
+#define DCN_BASE__INST5_SEG4                       0
+#define DCN_BASE__INST5_SEG5                       0
+
+#define DCN_BASE__INST6_SEG0                       0
+#define DCN_BASE__INST6_SEG1                       0
+#define DCN_BASE__INST6_SEG2                       0
+#define DCN_BASE__INST6_SEG3                       0
+#define DCN_BASE__INST6_SEG4                       0
+#define DCN_BASE__INST6_SEG5                       0
+
+#define DPCS_BASE__INST0_SEG0                      0x00000012
+#define DPCS_BASE__INST0_SEG1                      0x000000C0
+#define DPCS_BASE__INST0_SEG2                      0x000034C0
+#define DPCS_BASE__INST0_SEG3                      0x00009000
+#define DPCS_BASE__INST0_SEG4                      0x02403C00
+#define DPCS_BASE__INST0_SEG5                      0
+
+#define DPCS_BASE__INST1_SEG0                      0
+#define DPCS_BASE__INST1_SEG1                      0
+#define DPCS_BASE__INST1_SEG2                      0
+#define DPCS_BASE__INST1_SEG3                      0
+#define DPCS_BASE__INST1_SEG4                      0
+#define DPCS_BASE__INST1_SEG5                      0
+
+#define DPCS_BASE__INST2_SEG0                      0
+#define DPCS_BASE__INST2_SEG1                      0
+#define DPCS_BASE__INST2_SEG2                      0
+#define DPCS_BASE__INST2_SEG3                      0
+#define DPCS_BASE__INST2_SEG4                      0
+#define DPCS_BASE__INST2_SEG5                      0
+
+#define DPCS_BASE__INST3_SEG0                      0
+#define DPCS_BASE__INST3_SEG1                      0
+#define DPCS_BASE__INST3_SEG2                      0
+#define DPCS_BASE__INST3_SEG3                      0
+#define DPCS_BASE__INST3_SEG4                      0
+#define DPCS_BASE__INST3_SEG5                      0
+
+#define DPCS_BASE__INST4_SEG0                      0
+#define DPCS_BASE__INST4_SEG1                      0
+#define DPCS_BASE__INST4_SEG2                      0
+#define DPCS_BASE__INST4_SEG3                      0
+#define DPCS_BASE__INST4_SEG4                      0
+#define DPCS_BASE__INST4_SEG5                      0
+
+#define DPCS_BASE__INST5_SEG0                      0
+#define DPCS_BASE__INST5_SEG1                      0
+#define DPCS_BASE__INST5_SEG2                      0
+#define DPCS_BASE__INST5_SEG3                      0
+#define DPCS_BASE__INST5_SEG4                      0
+#define DPCS_BASE__INST5_SEG5                      0
+
+#define DPCS_BASE__INST6_SEG0                      0
+#define DPCS_BASE__INST6_SEG1                      0
+#define DPCS_BASE__INST6_SEG2                      0
+#define DPCS_BASE__INST6_SEG3                      0
+#define DPCS_BASE__INST6_SEG4                      0
+#define DPCS_BASE__INST6_SEG5                      0
+
+#define FUSE_BASE__INST0_SEG0                      0x00017400
+#define FUSE_BASE__INST0_SEG1                      0x02401400
+#define FUSE_BASE__INST0_SEG2                      0
+#define FUSE_BASE__INST0_SEG3                      0
+#define FUSE_BASE__INST0_SEG4                      0
+#define FUSE_BASE__INST0_SEG5                      0
+
+#define FUSE_BASE__INST1_SEG0                      0
+#define FUSE_BASE__INST1_SEG1                      0
+#define FUSE_BASE__INST1_SEG2                      0
+#define FUSE_BASE__INST1_SEG3                      0
+#define FUSE_BASE__INST1_SEG4                      0
+#define FUSE_BASE__INST1_SEG5                      0
+
+#define FUSE_BASE__INST2_SEG0                      0
+#define FUSE_BASE__INST2_SEG1                      0
+#define FUSE_BASE__INST2_SEG2                      0
+#define FUSE_BASE__INST2_SEG3                      0
+#define FUSE_BASE__INST2_SEG4                      0
+#define FUSE_BASE__INST2_SEG5                      0
+
+#define FUSE_BASE__INST3_SEG0                      0
+#define FUSE_BASE__INST3_SEG1                      0
+#define FUSE_BASE__INST3_SEG2                      0
+#define FUSE_BASE__INST3_SEG3                      0
+#define FUSE_BASE__INST3_SEG4                      0
+#define FUSE_BASE__INST3_SEG5                      0
+
+#define FUSE_BASE__INST4_SEG0                      0
+#define FUSE_BASE__INST4_SEG1                      0
+#define FUSE_BASE__INST4_SEG2                      0
+#define FUSE_BASE__INST4_SEG3                      0
+#define FUSE_BASE__INST4_SEG4                      0
+#define FUSE_BASE__INST4_SEG5                      0
+
+#define FUSE_BASE__INST5_SEG0                      0
+#define FUSE_BASE__INST5_SEG1                      0
+#define FUSE_BASE__INST5_SEG2                      0
+#define FUSE_BASE__INST5_SEG3                      0
+#define FUSE_BASE__INST5_SEG4                      0
+#define FUSE_BASE__INST5_SEG5                      0
+
+#define FUSE_BASE__INST6_SEG0                      0
+#define FUSE_BASE__INST6_SEG1                      0
+#define FUSE_BASE__INST6_SEG2                      0
+#define FUSE_BASE__INST6_SEG3                      0
+#define FUSE_BASE__INST6_SEG4                      0
+#define FUSE_BASE__INST6_SEG5                      0
+
+#define GC_BASE__INST0_SEG0                        0x00001260
+#define GC_BASE__INST0_SEG1                        0x0000A000
+#define GC_BASE__INST0_SEG2                        0x0001C000
+#define GC_BASE__INST0_SEG3                        0x02402C00
+#define GC_BASE__INST0_SEG4                        0
+#define GC_BASE__INST0_SEG5                        0
+
+#define GC_BASE__INST1_SEG0                        0
+#define GC_BASE__INST1_SEG1                        0
+#define GC_BASE__INST1_SEG2                        0
+#define GC_BASE__INST1_SEG3                        0
+#define GC_BASE__INST1_SEG4                        0
+#define GC_BASE__INST1_SEG5                        0
+
+#define GC_BASE__INST2_SEG0                        0
+#define GC_BASE__INST2_SEG1                        0
+#define GC_BASE__INST2_SEG2                        0
+#define GC_BASE__INST2_SEG3                        0
+#define GC_BASE__INST2_SEG4                        0
+#define GC_BASE__INST2_SEG5                        0
+
+#define GC_BASE__INST3_SEG0                        0
+#define GC_BASE__INST3_SEG1                        0
+#define GC_BASE__INST3_SEG2                        0
+#define GC_BASE__INST3_SEG3                        0
+#define GC_BASE__INST3_SEG4                        0
+#define GC_BASE__INST3_SEG5                        0
+
+#define GC_BASE__INST4_SEG0                        0
+#define GC_BASE__INST4_SEG1                        0
+#define GC_BASE__INST4_SEG2                        0
+#define GC_BASE__INST4_SEG3                        0
+#define GC_BASE__INST4_SEG4                        0
+#define GC_BASE__INST4_SEG5                        0
+
+#define GC_BASE__INST5_SEG0                        0
+#define GC_BASE__INST5_SEG1                        0
+#define GC_BASE__INST5_SEG2                        0
+#define GC_BASE__INST5_SEG3                        0
+#define GC_BASE__INST5_SEG4                        0
+#define GC_BASE__INST5_SEG5                        0
+
+#define GC_BASE__INST6_SEG0                        0
+#define GC_BASE__INST6_SEG1                        0
+#define GC_BASE__INST6_SEG2                        0
+#define GC_BASE__INST6_SEG3                        0
+#define GC_BASE__INST6_SEG4                        0
+#define GC_BASE__INST6_SEG5                        0
+
+#define HDA_BASE__INST0_SEG0                       0x004C0000
+#define HDA_BASE__INST0_SEG1                       0x02404800
+#define HDA_BASE__INST0_SEG2                       0
+#define HDA_BASE__INST0_SEG3                       0
+#define HDA_BASE__INST0_SEG4                       0
+#define HDA_BASE__INST0_SEG5                       0
+
+#define HDA_BASE__INST1_SEG0                       0
+#define HDA_BASE__INST1_SEG1                       0
+#define HDA_BASE__INST1_SEG2                       0
+#define HDA_BASE__INST1_SEG3                       0
+#define HDA_BASE__INST1_SEG4                       0
+#define HDA_BASE__INST1_SEG5                       0
+
+#define HDA_BASE__INST2_SEG0                       0
+#define HDA_BASE__INST2_SEG1                       0
+#define HDA_BASE__INST2_SEG2                       0
+#define HDA_BASE__INST2_SEG3                       0
+#define HDA_BASE__INST2_SEG4                       0
+#define HDA_BASE__INST2_SEG5                       0
+
+#define HDA_BASE__INST3_SEG0                       0
+#define HDA_BASE__INST3_SEG1                       0
+#define HDA_BASE__INST3_SEG2                       0
+#define HDA_BASE__INST3_SEG3                       0
+#define HDA_BASE__INST3_SEG4                       0
+#define HDA_BASE__INST3_SEG5                       0
+
+#define HDA_BASE__INST4_SEG0                       0
+#define HDA_BASE__INST4_SEG1                       0
+#define HDA_BASE__INST4_SEG2                       0
+#define HDA_BASE__INST4_SEG3                       0
+#define HDA_BASE__INST4_SEG4                       0
+#define HDA_BASE__INST4_SEG5                       0
+
+#define HDA_BASE__INST5_SEG0                       0
+#define HDA_BASE__INST5_SEG1                       0
+#define HDA_BASE__INST5_SEG2                       0
+#define HDA_BASE__INST5_SEG3                       0
+#define HDA_BASE__INST5_SEG4                       0
+#define HDA_BASE__INST5_SEG5                       0
+
+#define HDA_BASE__INST6_SEG0                       0
+#define HDA_BASE__INST6_SEG1                       0
+#define HDA_BASE__INST6_SEG2                       0
+#define HDA_BASE__INST6_SEG3                       0
+#define HDA_BASE__INST6_SEG4                       0
+#define HDA_BASE__INST6_SEG5                       0
+
+#define HDP_BASE__INST0_SEG0                       0x00000F20
+#define HDP_BASE__INST0_SEG1                       0x0240A400
+#define HDP_BASE__INST0_SEG2                       0
+#define HDP_BASE__INST0_SEG3                       0
+#define HDP_BASE__INST0_SEG4                       0
+#define HDP_BASE__INST0_SEG5                       0
+
+#define HDP_BASE__INST1_SEG0                       0
+#define HDP_BASE__INST1_SEG1                       0
+#define HDP_BASE__INST1_SEG2                       0
+#define HDP_BASE__INST1_SEG3                       0
+#define HDP_BASE__INST1_SEG4                       0
+#define HDP_BASE__INST1_SEG5                       0
+
+#define HDP_BASE__INST2_SEG0                       0
+#define HDP_BASE__INST2_SEG1                       0
+#define HDP_BASE__INST2_SEG2                       0
+#define HDP_BASE__INST2_SEG3                       0
+#define HDP_BASE__INST2_SEG4                       0
+#define HDP_BASE__INST2_SEG5                       0
+
+#define HDP_BASE__INST3_SEG0                       0
+#define HDP_BASE__INST3_SEG1                       0
+#define HDP_BASE__INST3_SEG2                       0
+#define HDP_BASE__INST3_SEG3                       0
+#define HDP_BASE__INST3_SEG4                       0
+#define HDP_BASE__INST3_SEG5                       0
+
+#define HDP_BASE__INST4_SEG0                       0
+#define HDP_BASE__INST4_SEG1                       0
+#define HDP_BASE__INST4_SEG2                       0
+#define HDP_BASE__INST4_SEG3                       0
+#define HDP_BASE__INST4_SEG4                       0
+#define HDP_BASE__INST4_SEG5                       0
+
+#define HDP_BASE__INST5_SEG0                       0
+#define HDP_BASE__INST5_SEG1                       0
+#define HDP_BASE__INST5_SEG2                       0
+#define HDP_BASE__INST5_SEG3                       0
+#define HDP_BASE__INST5_SEG4                       0
+#define HDP_BASE__INST5_SEG5                       0
+
+#define HDP_BASE__INST6_SEG0                       0
+#define HDP_BASE__INST6_SEG1                       0
+#define HDP_BASE__INST6_SEG2                       0
+#define HDP_BASE__INST6_SEG3                       0
+#define HDP_BASE__INST6_SEG4                       0
+#define HDP_BASE__INST6_SEG5                       0
+
+#define MMHUB_BASE__INST0_SEG0                     0x0001A000
+#define MMHUB_BASE__INST0_SEG1                     0x02408800
+#define MMHUB_BASE__INST0_SEG2                     0
+#define MMHUB_BASE__INST0_SEG3                     0
+#define MMHUB_BASE__INST0_SEG4                     0
+#define MMHUB_BASE__INST0_SEG5                     0
+
+#define MMHUB_BASE__INST1_SEG0                     0
+#define MMHUB_BASE__INST1_SEG1                     0
+#define MMHUB_BASE__INST1_SEG2                     0
+#define MMHUB_BASE__INST1_SEG3                     0
+#define MMHUB_BASE__INST1_SEG4                     0
+#define MMHUB_BASE__INST1_SEG5                     0
+
+#define MMHUB_BASE__INST2_SEG0                     0
+#define MMHUB_BASE__INST2_SEG1                     0
+#define MMHUB_BASE__INST2_SEG2                     0
+#define MMHUB_BASE__INST2_SEG3                     0
+#define MMHUB_BASE__INST2_SEG4                     0
+#define MMHUB_BASE__INST2_SEG5                     0
+
+#define MMHUB_BASE__INST3_SEG0                     0
+#define MMHUB_BASE__INST3_SEG1                     0
+#define MMHUB_BASE__INST3_SEG2                     0
+#define MMHUB_BASE__INST3_SEG3                     0
+#define MMHUB_BASE__INST3_SEG4                     0
+#define MMHUB_BASE__INST3_SEG5                     0
+
+#define MMHUB_BASE__INST4_SEG0                     0
+#define MMHUB_BASE__INST4_SEG1                     0
+#define MMHUB_BASE__INST4_SEG2                     0
+#define MMHUB_BASE__INST4_SEG3                     0
+#define MMHUB_BASE__INST4_SEG4                     0
+#define MMHUB_BASE__INST4_SEG5                     0
+
+#define MMHUB_BASE__INST5_SEG0                     0
+#define MMHUB_BASE__INST5_SEG1                     0
+#define MMHUB_BASE__INST5_SEG2                     0
+#define MMHUB_BASE__INST5_SEG3                     0
+#define MMHUB_BASE__INST5_SEG4                     0
+#define MMHUB_BASE__INST5_SEG5                     0
+
+#define MMHUB_BASE__INST6_SEG0                     0
+#define MMHUB_BASE__INST6_SEG1                     0
+#define MMHUB_BASE__INST6_SEG2                     0
+#define MMHUB_BASE__INST6_SEG3                     0
+#define MMHUB_BASE__INST6_SEG4                     0
+#define MMHUB_BASE__INST6_SEG5                     0
+
+#define MP0_BASE__INST0_SEG0                       0x00016000
+#define MP0_BASE__INST0_SEG1                       0x00DC0000
+#define MP0_BASE__INST0_SEG2                       0x00E00000
+#define MP0_BASE__INST0_SEG3                       0x00E40000
+#define MP0_BASE__INST0_SEG4                       0x0243FC00
+#define MP0_BASE__INST0_SEG5                       0
+
+#define MP0_BASE__INST1_SEG0                       0
+#define MP0_BASE__INST1_SEG1                       0
+#define MP0_BASE__INST1_SEG2                       0
+#define MP0_BASE__INST1_SEG3                       0
+#define MP0_BASE__INST1_SEG4                       0
+#define MP0_BASE__INST1_SEG5                       0
+
+#define MP0_BASE__INST2_SEG0                       0
+#define MP0_BASE__INST2_SEG1                       0
+#define MP0_BASE__INST2_SEG2                       0
+#define MP0_BASE__INST2_SEG3                       0
+#define MP0_BASE__INST2_SEG4                       0
+#define MP0_BASE__INST2_SEG5                       0
+
+#define MP0_BASE__INST3_SEG0                       0
+#define MP0_BASE__INST3_SEG1                       0
+#define MP0_BASE__INST3_SEG2                       0
+#define MP0_BASE__INST3_SEG3                       0
+#define MP0_BASE__INST3_SEG4                       0
+#define MP0_BASE__INST3_SEG5                       0
+
+#define MP0_BASE__INST4_SEG0                       0
+#define MP0_BASE__INST4_SEG1                       0
+#define MP0_BASE__INST4_SEG2                       0
+#define MP0_BASE__INST4_SEG3                       0
+#define MP0_BASE__INST4_SEG4                       0
+#define MP0_BASE__INST4_SEG5                       0
+
+#define MP0_BASE__INST5_SEG0                       0
+#define MP0_BASE__INST5_SEG1                       0
+#define MP0_BASE__INST5_SEG2                       0
+#define MP0_BASE__INST5_SEG3                       0
+#define MP0_BASE__INST5_SEG4                       0
+#define MP0_BASE__INST5_SEG5                       0
+
+#define MP0_BASE__INST6_SEG0                       0
+#define MP0_BASE__INST6_SEG1                       0
+#define MP0_BASE__INST6_SEG2                       0
+#define MP0_BASE__INST6_SEG3                       0
+#define MP0_BASE__INST6_SEG4                       0
+#define MP0_BASE__INST6_SEG5                       0
+
+#define MP1_BASE__INST0_SEG0                       0x00016000
+#define MP1_BASE__INST0_SEG1                       0x00DC0000
+#define MP1_BASE__INST0_SEG2                       0x00E00000
+#define MP1_BASE__INST0_SEG3                       0x00E40000
+#define MP1_BASE__INST0_SEG4                       0x0243FC00
+#define MP1_BASE__INST0_SEG5                       0
+
+#define MP1_BASE__INST1_SEG0                       0
+#define MP1_BASE__INST1_SEG1                       0
+#define MP1_BASE__INST1_SEG2                       0
+#define MP1_BASE__INST1_SEG3                       0
+#define MP1_BASE__INST1_SEG4                       0
+#define MP1_BASE__INST1_SEG5                       0
+
+#define MP1_BASE__INST2_SEG0                       0
+#define MP1_BASE__INST2_SEG1                       0
+#define MP1_BASE__INST2_SEG2                       0
+#define MP1_BASE__INST2_SEG3                       0
+#define MP1_BASE__INST2_SEG4                       0
+#define MP1_BASE__INST2_SEG5                       0
+
+#define MP1_BASE__INST3_SEG0                       0
+#define MP1_BASE__INST3_SEG1                       0
+#define MP1_BASE__INST3_SEG2                       0
+#define MP1_BASE__INST3_SEG3                       0
+#define MP1_BASE__INST3_SEG4                       0
+#define MP1_BASE__INST3_SEG5                       0
+
+#define MP1_BASE__INST4_SEG0                       0
+#define MP1_BASE__INST4_SEG1                       0
+#define MP1_BASE__INST4_SEG2                       0
+#define MP1_BASE__INST4_SEG3                       0
+#define MP1_BASE__INST4_SEG4                       0
+#define MP1_BASE__INST4_SEG5                       0
+
+#define MP1_BASE__INST5_SEG0                       0
+#define MP1_BASE__INST5_SEG1                       0
+#define MP1_BASE__INST5_SEG2                       0
+#define MP1_BASE__INST5_SEG3                       0
+#define MP1_BASE__INST5_SEG4                       0
+#define MP1_BASE__INST5_SEG5                       0
+
+#define MP1_BASE__INST6_SEG0                       0
+#define MP1_BASE__INST6_SEG1                       0
+#define MP1_BASE__INST6_SEG2                       0
+#define MP1_BASE__INST6_SEG3                       0
+#define MP1_BASE__INST6_SEG4                       0
+#define MP1_BASE__INST6_SEG5                       0
+
+#define NBIO_BASE__INST0_SEG0                      0x00000000
+#define NBIO_BASE__INST0_SEG1                      0x00000014
+#define NBIO_BASE__INST0_SEG2                      0x00000D20
+#define NBIO_BASE__INST0_SEG3                      0x00010400
+#define NBIO_BASE__INST0_SEG4                      0x0241B000
+#define NBIO_BASE__INST0_SEG5                      0x04040000
+
+#define NBIO_BASE__INST1_SEG0                      0
+#define NBIO_BASE__INST1_SEG1                      0
+#define NBIO_BASE__INST1_SEG2                      0
+#define NBIO_BASE__INST1_SEG3                      0
+#define NBIO_BASE__INST1_SEG4                      0
+#define NBIO_BASE__INST1_SEG5                      0
+
+#define NBIO_BASE__INST2_SEG0                      0
+#define NBIO_BASE__INST2_SEG1                      0
+#define NBIO_BASE__INST2_SEG2                      0
+#define NBIO_BASE__INST2_SEG3                      0
+#define NBIO_BASE__INST2_SEG4                      0
+#define NBIO_BASE__INST2_SEG5                      0
+
+#define NBIO_BASE__INST3_SEG0                      0
+#define NBIO_BASE__INST3_SEG1                      0
+#define NBIO_BASE__INST3_SEG2                      0
+#define NBIO_BASE__INST3_SEG3                      0
+#define NBIO_BASE__INST3_SEG4                      0
+#define NBIO_BASE__INST3_SEG5                      0
+
+#define NBIO_BASE__INST4_SEG0                      0
+#define NBIO_BASE__INST4_SEG1                      0
+#define NBIO_BASE__INST4_SEG2                      0
+#define NBIO_BASE__INST4_SEG3                      0
+#define NBIO_BASE__INST4_SEG4                      0
+#define NBIO_BASE__INST4_SEG5                      0
+
+#define NBIO_BASE__INST5_SEG0                      0
+#define NBIO_BASE__INST5_SEG1                      0
+#define NBIO_BASE__INST5_SEG2                      0
+#define NBIO_BASE__INST5_SEG3                      0
+#define NBIO_BASE__INST5_SEG4                      0
+#define NBIO_BASE__INST5_SEG5                      0
+
+#define NBIO_BASE__INST6_SEG0                      0
+#define NBIO_BASE__INST6_SEG1                      0
+#define NBIO_BASE__INST6_SEG2                      0
+#define NBIO_BASE__INST6_SEG3                      0
+#define NBIO_BASE__INST6_SEG4                      0
+#define NBIO_BASE__INST6_SEG5                      0
+
+#define OSSSYS_BASE__INST0_SEG0                    0x000010A0
+#define OSSSYS_BASE__INST0_SEG1                    0x0240A000
+#define OSSSYS_BASE__INST0_SEG2                    0
+#define OSSSYS_BASE__INST0_SEG3                    0
+#define OSSSYS_BASE__INST0_SEG4                    0
+#define OSSSYS_BASE__INST0_SEG5                    0
+
+#define OSSSYS_BASE__INST1_SEG0                    0
+#define OSSSYS_BASE__INST1_SEG1                    0
+#define OSSSYS_BASE__INST1_SEG2                    0
+#define OSSSYS_BASE__INST1_SEG3                    0
+#define OSSSYS_BASE__INST1_SEG4                    0
+#define OSSSYS_BASE__INST1_SEG5                    0
+
+#define OSSSYS_BASE__INST2_SEG0                    0
+#define OSSSYS_BASE__INST2_SEG1                    0
+#define OSSSYS_BASE__INST2_SEG2                    0
+#define OSSSYS_BASE__INST2_SEG3                    0
+#define OSSSYS_BASE__INST2_SEG4                    0
+#define OSSSYS_BASE__INST2_SEG5                    0
+
+#define OSSSYS_BASE__INST3_SEG0                    0
+#define OSSSYS_BASE__INST3_SEG1                    0
+#define OSSSYS_BASE__INST3_SEG2                    0
+#define OSSSYS_BASE__INST3_SEG3                    0
+#define OSSSYS_BASE__INST3_SEG4                    0
+#define OSSSYS_BASE__INST3_SEG5                    0
+
+#define OSSSYS_BASE__INST4_SEG0                    0
+#define OSSSYS_BASE__INST4_SEG1                    0
+#define OSSSYS_BASE__INST4_SEG2                    0
+#define OSSSYS_BASE__INST4_SEG3                    0
+#define OSSSYS_BASE__INST4_SEG4                    0
+#define OSSSYS_BASE__INST4_SEG5                    0
+
+#define OSSSYS_BASE__INST5_SEG0                    0
+#define OSSSYS_BASE__INST5_SEG1                    0
+#define OSSSYS_BASE__INST5_SEG2                    0
+#define OSSSYS_BASE__INST5_SEG3                    0
+#define OSSSYS_BASE__INST5_SEG4                    0
+#define OSSSYS_BASE__INST5_SEG5                    0
+
+#define OSSSYS_BASE__INST6_SEG0                    0
+#define OSSSYS_BASE__INST6_SEG1                    0
+#define OSSSYS_BASE__INST6_SEG2                    0
+#define OSSSYS_BASE__INST6_SEG3                    0
+#define OSSSYS_BASE__INST6_SEG4                    0
+#define OSSSYS_BASE__INST6_SEG5                    0
+
+#define PCIE0_BASE__INST0_SEG0                     0x00000000
+#define PCIE0_BASE__INST0_SEG1                     0x00000014
+#define PCIE0_BASE__INST0_SEG2                     0x00000D20
+#define PCIE0_BASE__INST0_SEG3                     0x00010400
+#define PCIE0_BASE__INST0_SEG4                     0x0241B000
+#define PCIE0_BASE__INST0_SEG5                     0x04040000
+
+#define PCIE0_BASE__INST1_SEG0                     0
+#define PCIE0_BASE__INST1_SEG1                     0
+#define PCIE0_BASE__INST1_SEG2                     0
+#define PCIE0_BASE__INST1_SEG3                     0
+#define PCIE0_BASE__INST1_SEG4                     0
+#define PCIE0_BASE__INST1_SEG5                     0
+
+#define PCIE0_BASE__INST2_SEG0                     0
+#define PCIE0_BASE__INST2_SEG1                     0
+#define PCIE0_BASE__INST2_SEG2                     0
+#define PCIE0_BASE__INST2_SEG3                     0
+#define PCIE0_BASE__INST2_SEG4                     0
+#define PCIE0_BASE__INST2_SEG5                     0
+
+#define PCIE0_BASE__INST3_SEG0                     0
+#define PCIE0_BASE__INST3_SEG1                     0
+#define PCIE0_BASE__INST3_SEG2                     0
+#define PCIE0_BASE__INST3_SEG3                     0
+#define PCIE0_BASE__INST3_SEG4                     0
+#define PCIE0_BASE__INST3_SEG5                     0
+
+#define PCIE0_BASE__INST4_SEG0                     0
+#define PCIE0_BASE__INST4_SEG1                     0
+#define PCIE0_BASE__INST4_SEG2                     0
+#define PCIE0_BASE__INST4_SEG3                     0
+#define PCIE0_BASE__INST4_SEG4                     0
+#define PCIE0_BASE__INST4_SEG5                     0
+
+#define PCIE0_BASE__INST5_SEG0                     0
+#define PCIE0_BASE__INST5_SEG1                     0
+#define PCIE0_BASE__INST5_SEG2                     0
+#define PCIE0_BASE__INST5_SEG3                     0
+#define PCIE0_BASE__INST5_SEG4                     0
+#define PCIE0_BASE__INST5_SEG5                     0
+
+#define PCIE0_BASE__INST6_SEG0                     0
+#define PCIE0_BASE__INST6_SEG1                     0
+#define PCIE0_BASE__INST6_SEG2                     0
+#define PCIE0_BASE__INST6_SEG3                     0
+#define PCIE0_BASE__INST6_SEG4                     0
+#define PCIE0_BASE__INST6_SEG5                     0
+
+#define SDMA0_BASE__INST0_SEG0                     0x00001260
+#define SDMA0_BASE__INST0_SEG1                     0x0000A000
+#define SDMA0_BASE__INST0_SEG2                     0x0001C000
+#define SDMA0_BASE__INST0_SEG3                     0x02402C00
+#define SDMA0_BASE__INST0_SEG4                     0
+#define SDMA0_BASE__INST0_SEG5                     0
+
+#define SDMA0_BASE__INST1_SEG0                     0
+#define SDMA0_BASE__INST1_SEG1                     0
+#define SDMA0_BASE__INST1_SEG2                     0
+#define SDMA0_BASE__INST1_SEG3                     0
+#define SDMA0_BASE__INST1_SEG4                     0
+#define SDMA0_BASE__INST1_SEG5                     0
+
+#define SDMA0_BASE__INST2_SEG0                     0
+#define SDMA0_BASE__INST2_SEG1                     0
+#define SDMA0_BASE__INST2_SEG2                     0
+#define SDMA0_BASE__INST2_SEG3                     0
+#define SDMA0_BASE__INST2_SEG4                     0
+#define SDMA0_BASE__INST2_SEG5                     0
+
+#define SDMA0_BASE__INST3_SEG0                     0
+#define SDMA0_BASE__INST3_SEG1                     0
+#define SDMA0_BASE__INST3_SEG2                     0
+#define SDMA0_BASE__INST3_SEG3                     0
+#define SDMA0_BASE__INST3_SEG4                     0
+#define SDMA0_BASE__INST3_SEG5                     0
+
+#define SDMA0_BASE__INST4_SEG0                     0
+#define SDMA0_BASE__INST4_SEG1                     0
+#define SDMA0_BASE__INST4_SEG2                     0
+#define SDMA0_BASE__INST4_SEG3                     0
+#define SDMA0_BASE__INST4_SEG4                     0
+#define SDMA0_BASE__INST4_SEG5                     0
+
+#define SDMA0_BASE__INST5_SEG0                     0
+#define SDMA0_BASE__INST5_SEG1                     0
+#define SDMA0_BASE__INST5_SEG2                     0
+#define SDMA0_BASE__INST5_SEG3                     0
+#define SDMA0_BASE__INST5_SEG4                     0
+#define SDMA0_BASE__INST5_SEG5                     0
+
+#define SDMA0_BASE__INST6_SEG0                     0
+#define SDMA0_BASE__INST6_SEG1                     0
+#define SDMA0_BASE__INST6_SEG2                     0
+#define SDMA0_BASE__INST6_SEG3                     0
+#define SDMA0_BASE__INST6_SEG4                     0
+#define SDMA0_BASE__INST6_SEG5                     0
+
+#define SMUIO_BASE__INST0_SEG0                     0x00016800
+#define SMUIO_BASE__INST0_SEG1                     0x00016A00
+#define SMUIO_BASE__INST0_SEG2                     0x00440000
+#define SMUIO_BASE__INST0_SEG3                     0x02401000
+#define SMUIO_BASE__INST0_SEG4                     0
+#define SMUIO_BASE__INST0_SEG5                     0
+
+#define SMUIO_BASE__INST1_SEG0                     0
+#define SMUIO_BASE__INST1_SEG1                     0
+#define SMUIO_BASE__INST1_SEG2                     0
+#define SMUIO_BASE__INST1_SEG3                     0
+#define SMUIO_BASE__INST1_SEG4                     0
+#define SMUIO_BASE__INST1_SEG5                     0
+
+#define SMUIO_BASE__INST2_SEG0                     0
+#define SMUIO_BASE__INST2_SEG1                     0
+#define SMUIO_BASE__INST2_SEG2                     0
+#define SMUIO_BASE__INST2_SEG3                     0
+#define SMUIO_BASE__INST2_SEG4                     0
+#define SMUIO_BASE__INST2_SEG5                     0
+
+#define SMUIO_BASE__INST3_SEG0                     0
+#define SMUIO_BASE__INST3_SEG1                     0
+#define SMUIO_BASE__INST3_SEG2                     0
+#define SMUIO_BASE__INST3_SEG3                     0
+#define SMUIO_BASE__INST3_SEG4                     0
+#define SMUIO_BASE__INST3_SEG5                     0
+
+#define SMUIO_BASE__INST4_SEG0                     0
+#define SMUIO_BASE__INST4_SEG1                     0
+#define SMUIO_BASE__INST4_SEG2                     0
+#define SMUIO_BASE__INST4_SEG3                     0
+#define SMUIO_BASE__INST4_SEG4                     0
+#define SMUIO_BASE__INST4_SEG5                     0
+
+#define SMUIO_BASE__INST5_SEG0                     0
+#define SMUIO_BASE__INST5_SEG1                     0
+#define SMUIO_BASE__INST5_SEG2                     0
+#define SMUIO_BASE__INST5_SEG3                     0
+#define SMUIO_BASE__INST5_SEG4                     0
+#define SMUIO_BASE__INST5_SEG5                     0
+
+#define SMUIO_BASE__INST6_SEG0                     0
+#define SMUIO_BASE__INST6_SEG1                     0
+#define SMUIO_BASE__INST6_SEG2                     0
+#define SMUIO_BASE__INST6_SEG3                     0
+#define SMUIO_BASE__INST6_SEG4                     0
+#define SMUIO_BASE__INST6_SEG5                     0
+
+#define THM_BASE__INST0_SEG0                       0x00016600
+#define THM_BASE__INST0_SEG1                       0x02400C00
+#define THM_BASE__INST0_SEG2                       0
+#define THM_BASE__INST0_SEG3                       0
+#define THM_BASE__INST0_SEG4                       0
+#define THM_BASE__INST0_SEG5                       0
+
+#define THM_BASE__INST1_SEG0                       0
+#define THM_BASE__INST1_SEG1                       0
+#define THM_BASE__INST1_SEG2                       0
+#define THM_BASE__INST1_SEG3                       0
+#define THM_BASE__INST1_SEG4                       0
+#define THM_BASE__INST1_SEG5                       0
+
+#define THM_BASE__INST2_SEG0                       0
+#define THM_BASE__INST2_SEG1                       0
+#define THM_BASE__INST2_SEG2                       0
+#define THM_BASE__INST2_SEG3                       0
+#define THM_BASE__INST2_SEG4                       0
+#define THM_BASE__INST2_SEG5                       0
+
+#define THM_BASE__INST3_SEG0                       0
+#define THM_BASE__INST3_SEG1                       0
+#define THM_BASE__INST3_SEG2                       0
+#define THM_BASE__INST3_SEG3                       0
+#define THM_BASE__INST3_SEG4                       0
+#define THM_BASE__INST3_SEG5                       0
+
+#define THM_BASE__INST4_SEG0                       0
+#define THM_BASE__INST4_SEG1                       0
+#define THM_BASE__INST4_SEG2                       0
+#define THM_BASE__INST4_SEG3                       0
+#define THM_BASE__INST4_SEG4                       0
+#define THM_BASE__INST4_SEG5                       0
+
+#define THM_BASE__INST5_SEG0                       0
+#define THM_BASE__INST5_SEG1                       0
+#define THM_BASE__INST5_SEG2                       0
+#define THM_BASE__INST5_SEG3                       0
+#define THM_BASE__INST5_SEG4                       0
+#define THM_BASE__INST5_SEG5                       0
+
+#define THM_BASE__INST6_SEG0                       0
+#define THM_BASE__INST6_SEG1                       0
+#define THM_BASE__INST6_SEG2                       0
+#define THM_BASE__INST6_SEG3                       0
+#define THM_BASE__INST6_SEG4                       0
+#define THM_BASE__INST6_SEG5                       0
+
+#define UMC_BASE__INST0_SEG0                       0x00014000
+#define UMC_BASE__INST0_SEG1                       0x02425800
+#define UMC_BASE__INST0_SEG2                       0
+#define UMC_BASE__INST0_SEG3                       0
+#define UMC_BASE__INST0_SEG4                       0
+#define UMC_BASE__INST0_SEG5                       0
+
+#define UMC_BASE__INST1_SEG0                       0x00054000
+#define UMC_BASE__INST1_SEG1                       0x02425C00
+#define UMC_BASE__INST1_SEG2                       0
+#define UMC_BASE__INST1_SEG3                       0
+#define UMC_BASE__INST1_SEG4                       0
+#define UMC_BASE__INST1_SEG5                       0
+
+#define UMC_BASE__INST2_SEG0                       0
+#define UMC_BASE__INST2_SEG1                       0
+#define UMC_BASE__INST2_SEG2                       0
+#define UMC_BASE__INST2_SEG3                       0
+#define UMC_BASE__INST2_SEG4                       0
+#define UMC_BASE__INST2_SEG5                       0
+
+#define UMC_BASE__INST3_SEG0                       0
+#define UMC_BASE__INST3_SEG1                       0
+#define UMC_BASE__INST3_SEG2                       0
+#define UMC_BASE__INST3_SEG3                       0
+#define UMC_BASE__INST3_SEG4                       0
+#define UMC_BASE__INST3_SEG5                       0
+
+#define UMC_BASE__INST4_SEG0                       0
+#define UMC_BASE__INST4_SEG1                       0
+#define UMC_BASE__INST4_SEG2                       0
+#define UMC_BASE__INST4_SEG3                       0
+#define UMC_BASE__INST4_SEG4                       0
+#define UMC_BASE__INST4_SEG5                       0
+
+#define UMC_BASE__INST5_SEG0                       0
+#define UMC_BASE__INST5_SEG1                       0
+#define UMC_BASE__INST5_SEG2                       0
+#define UMC_BASE__INST5_SEG3                       0
+#define UMC_BASE__INST5_SEG4                       0
+#define UMC_BASE__INST5_SEG5                       0
+
+#define UMC_BASE__INST6_SEG0                       0
+#define UMC_BASE__INST6_SEG1                       0
+#define UMC_BASE__INST6_SEG2                       0
+#define UMC_BASE__INST6_SEG3                       0
+#define UMC_BASE__INST6_SEG4                       0
+#define UMC_BASE__INST6_SEG5                       0
+
+#define VCN0_BASE__INST0_SEG0                      0x00007800
+#define VCN0_BASE__INST0_SEG1                      0x00007E00
+#define VCN0_BASE__INST0_SEG2                      0x02403000
+#define VCN0_BASE__INST0_SEG3                      0
+#define VCN0_BASE__INST0_SEG4                      0
+#define VCN0_BASE__INST0_SEG5                      0
+
+#define VCN0_BASE__INST1_SEG0                      0
+#define VCN0_BASE__INST1_SEG1                      0
+#define VCN0_BASE__INST1_SEG2                      0
+#define VCN0_BASE__INST1_SEG3                      0
+#define VCN0_BASE__INST1_SEG4                      0
+#define VCN0_BASE__INST1_SEG5                      0
+
+#define VCN0_BASE__INST2_SEG0                      0
+#define VCN0_BASE__INST2_SEG1                      0
+#define VCN0_BASE__INST2_SEG2                      0
+#define VCN0_BASE__INST2_SEG3                      0
+#define VCN0_BASE__INST2_SEG4                      0
+#define VCN0_BASE__INST2_SEG5                      0
+
+#define VCN0_BASE__INST3_SEG0                      0
+#define VCN0_BASE__INST3_SEG1                      0
+#define VCN0_BASE__INST3_SEG2                      0
+#define VCN0_BASE__INST3_SEG3                      0
+#define VCN0_BASE__INST3_SEG4                      0
+#define VCN0_BASE__INST3_SEG5                      0
+
+#define VCN0_BASE__INST4_SEG0                      0
+#define VCN0_BASE__INST4_SEG1                      0
+#define VCN0_BASE__INST4_SEG2                      0
+#define VCN0_BASE__INST4_SEG3                      0
+#define VCN0_BASE__INST4_SEG4                      0
+#define VCN0_BASE__INST4_SEG5                      0
+
+#define VCN0_BASE__INST5_SEG0                      0
+#define VCN0_BASE__INST5_SEG1                      0
+#define VCN0_BASE__INST5_SEG2                      0
+#define VCN0_BASE__INST5_SEG3                      0
+#define VCN0_BASE__INST5_SEG4                      0
+#define VCN0_BASE__INST5_SEG5                      0
+
+#define VCN0_BASE__INST6_SEG0                      0
+#define VCN0_BASE__INST6_SEG1                      0
+#define VCN0_BASE__INST6_SEG2                      0
+#define VCN0_BASE__INST6_SEG3                      0
+#define VCN0_BASE__INST6_SEG4                      0
+#define VCN0_BASE__INST6_SEG5                      0
+
+#endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
