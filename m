Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6BDC4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB38C60233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB38C60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CE789DD2;
	Wed, 24 Feb 2021 22:19:35 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A0789DAB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObujRk9iNh4OUfkdXlwrl2JGNTvGEU0xQDOjoA2gW+IqaeN2OdX23x5H1DXDf+Qrw0oknZI0xnaOMEMd9ach45KJJRZLTFRKN5biNFh6I+Vdq2kOhcKcQaL/PZNcnebEhixwQlb9DvbqKoxVC/pXDe97LWdCTwxA+ifIUXqf2hUQCUR8sJXFQ8jPj9qH4rdAhpR+CD1+cuYxDoaU9ovdy+TTgy7i1zARnVCaC+tSr0C5rfg7Q5G60Guwp6Rzasr/i25J2VIoOvNsxg8olDnllJ3F0SY2twmYW3xIHYDu5IZF7k/bH4rd8BN4e/L75wCQSxjg8MHWOox1J4PV0FkRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwjI8+o4CmjaexjiR5kjQlAvxkGSL3C1IlbaLrsNguo=;
 b=jFQlBrg4ccOPyzo6JlFQUf6HisoFKY4HtP8zOzzfz95qvyBW1qKPYDamvrc0jXGFy/OhsFuTGVaNhqa/bs+hiD8GsEqmeC9vuzXdUB7QKLeUqTLWSESZd+uWNjJhasDT3/z0XN85pcG905fNmWblUfqBjcmc68AeWWczycWXh30wrOO/yoWYteCSSmgXVfk8zkdX/EaNiW6ER5S8Sql6S3YNScUM/gZ7+PWifQhE5s/WEn1XwIXLIiq8hPUMvwypUCWnKvkRUsU7I5mZRBL7+2I30B3wQTe7/s8LGoCsBcLXWqJ2hFeJdwbT/8s4WaKBIs4jQaDFqFPreHUKIUIE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwjI8+o4CmjaexjiR5kjQlAvxkGSL3C1IlbaLrsNguo=;
 b=Px5BE4gfmAZYvKSokyv8+nPr4GP5kEp39/7ARXFYT06oEI4ZowL/lzArrRghtlNhUeTjOw9dBvFqnh+1W32/x4HIHU4Xm0ehHqtNwCS0EwvA+zfVXOq15RI5mNmYmNJ8S4U6lR9YqVpPVhvN9bFOF+xbdkTat667mi+tT6WUkAg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:28 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 014/159] drm/amdgpu: add mmhub support for aldebaran (v3)
Date: Wed, 24 Feb 2021 17:16:34 -0500
Message-Id: <20210224221859.3068810-7-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de5f535c-848f-4cc8-f39d-08d8d9123ffc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB417565AE218C2AF76AB679F9F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vs45p22gdOBy9kKW9XoX2TcbHdo53UZm8KAINfk3vtONcbwcbaAi4eRtK/+A6oiA0pDpCEH+K8gEE3ASif4+7HRcb4yz4iI+NUaKYXXPalIuHSlCyDI2Usbr0aDyQ8RAFOJFvpdBRDqOr9kU2p67uuTVhrpCSzCweVYWjjBt2GHR+x8Cv5cj3Dr1RKdB4ExQxRfdwPbFst44X6vWl8QnOAuCIIHHNvXQrz4Vg8KCb57/UCV8WVRcZleZlWFT8YJStKRCbpo6Piz7VqnFbml4BK1U7jp+fu401VQzd4Awcf17nJMONfL8JuClmFT3ke+Ezr33R2v+t/XaAsSX71EYSMi0W2Bg74rRiX9F33msEC90IocMPdCugnlmaSC0CE3BlHpSKz+3+xUlqbbCR31GMD0YHK5yLAE+Rl2kwv7Vap+gnpY6lll8sDr+dEMHbf5lTnhx4c0d8mrlyQakB0RvDWL0xsqK68Jcitqj+jkMr6cdBBLrmZfv1+13wX7vcJ3LJMTgXqzHPhjiKrEXC+TwrwqL26dvt8Ubgv/Mfw7B5wkrfpLTUJPr6pMyq4HH8c1pcHI1K2JvjbecnjbemMDrhbk9tIH+iwVIQS9+8X7yHS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002)(30864003)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cchBG8hUUJbySSV15d9hcnuCLcAzmDTw0rFFcBHczCU30QSLR3lK/aKgD5Lg?=
 =?us-ascii?Q?vROrFFWtDt1QL4RJr4JJ4aXivMal48yLbHQy6UefOvgxDc7n8M18mersMVb5?=
 =?us-ascii?Q?GKF0tezCuHXrkqXt2zODrTzESlcWcqeYJb3C9CAC5eWKr8YXkx05Yhapd5WQ?=
 =?us-ascii?Q?6MBfASQN3R7tX4QF3mu2lfSTp/ZZAol85ZMjHmwDZuzjgsULduddAefATFpV?=
 =?us-ascii?Q?hn4TiBnyn/EwnntE8rkYwIXXrqBS28u62mRo+/UtgIJWOrKRgGya0Q5JqKOr?=
 =?us-ascii?Q?g0dfAIc/cezRb202wT1V6e5KmVwgqwD5v5dApoYqXZ5uTosD4l1Oj6BsW/JG?=
 =?us-ascii?Q?lqQTCa3MuwmSX4Pt99OhRUfE1jdTq2+d4bHej+Bk+M0KMyh7O7tvrnnMDWc1?=
 =?us-ascii?Q?emjlSNXdoIq4aaI2Gbb0QqzXlAnrzqWI3Pa7yTNag3mFbB58YFYPoZNdybMl?=
 =?us-ascii?Q?mrDDSPmsKKBNjEObpMA9LyUTqWsYbV3XHct9rx08rxbHoAeboLrOoyZxHpYQ?=
 =?us-ascii?Q?y+aOUHLphfXc8heKI7/0JstCeHQAqXgNExGAOeJBa6vEnmAafZKx9MJU8OoP?=
 =?us-ascii?Q?ZpUBSCPDOF8MrCsDy2Rh7wAg/tBbJtUYGOq5YBb0RlMC38hsunQep6JRjWoj?=
 =?us-ascii?Q?/85GSasSXqJAxFqCX6T4BP3PwsaRqop545FZahndDUiZeCBj1Kv70y+fk/Jo?=
 =?us-ascii?Q?0uA03MD8WqkMDC5UUuASmx3EhrwtDuaKll8E00zx2qiEZ9slyJrjmfcsOoij?=
 =?us-ascii?Q?WYIvwbEFqRhYQW1XdRI0JQA6dyTUNj1Z5/NXttocaAXLZbRy3dZUdCIhjXfD?=
 =?us-ascii?Q?fa6jw65XXqHr7cEN1GXGIRz6ALZD2wvwjseWQFCtWMeiROejfAZ4vpNY7Uus?=
 =?us-ascii?Q?2jJ3ay7mGcP+6nfaYtEpjI1YXXK4SKf/f8TBUxtYJ4ZV5skaE815Txkk8He7?=
 =?us-ascii?Q?LdE/RPqo3PBj22mxq1nSlEUmN/X5vfdFCmD2ZSyy/ed8A7CyCfdYTPcyFtN3?=
 =?us-ascii?Q?cNGDGYUkAuOa4dH6IU9i9kkRBZvGw1ipVY3GyCFI5GxkHKQi2mX+/4RxJ5Fj?=
 =?us-ascii?Q?1iRmCjxUEXM7OFlcAcC7wKQ3ztVovU2iQi4XVc9R2OfL9fS2Pc6STqfKb0Ka?=
 =?us-ascii?Q?VaN55GHFxot7O5DfeFPTn9ElZCKeSRtJ3dwgSRMh+NH5e+jnDbVGMdpWIS6G?=
 =?us-ascii?Q?24R851U+53OR3fA0Nb+JcHBo+646ig+yg9hskdDK39jofs7UFaWCjhedgQOX?=
 =?us-ascii?Q?+u8EMw2pCjOGvMAROKCmbVXxRXUW7k6Yw0UdcQkGmwfJAjC3EcagzpbMvBnv?=
 =?us-ascii?Q?eAvD4aeuVUSK5q5DOJjVOauj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5f535c-848f-4cc8-f39d-08d8d9123ffc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:28.2112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMm/Oqf0N5cLzSvOfXdw0LIBviJvb2J4V6ojClt8TqmiPcZEHB6jDvKn0ILox0ZrfwjZBSaz1riP3AtpoAWySg==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

v1: dupilcate mmhub_v1_7.c from mmhub_v1_0.c because
mmhub register address for aldebaran is different
from existing asics (Le)
v2: switch to latest mmhub_v9_4_2 register headers (Hawking)
v3: squash in init VM_L2_CNTL3 default value for mmhub v1_7

Signed-off-by: Le Ma <le.ma@amd.com>
Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 598 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h |  42 ++
 3 files changed, 642 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 906bf2eaa158..95afdbda0b44 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -83,7 +83,8 @@ amdgpu-y += \
 	gmc_v7_0.o \
 	gmc_v8_0.o \
 	gfxhub_v1_0.o mmhub_v1_0.o gmc_v9_0.o gfxhub_v1_1.o mmhub_v9_4.o \
-	gfxhub_v2_0.o mmhub_v2_0.o gmc_v10_0.o gfxhub_v2_1.o mmhub_v2_3.o
+	gfxhub_v2_0.o mmhub_v2_0.o gmc_v10_0.o gfxhub_v2_1.o mmhub_v2_3.o \
+	mmhub_v1_7.o
 
 # add UMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
new file mode 100644
index 000000000000..fd9aebb0ca2d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -0,0 +1,598 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
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
+#include "amdgpu_ras.h"
+#include "mmhub_v1_7.h"
+
+#include "mmhub/mmhub_1_7_offset.h"
+#include "mmhub/mmhub_1_7_sh_mask.h"
+#include "vega10_enum.h"
+
+#include "soc15_common.h"
+
+#define EA_EDC_CNT_MASK 0x3
+#define EA_EDC_CNT_SHIFT 0x2
+
+#define regVM_L2_CNTL3_DEFAULT	0x80100007
+#define regVM_L2_CNTL4_DEFAULT	0x000000c1
+
+u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
+{
+	u64 base = RREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE);
+	u64 top = RREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP);
+
+	base &= MC_VM_FB_LOCATION_BASE__FB_BASE_MASK;
+	base <<= 24;
+
+	top &= MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;
+	top <<= 24;
+
+	adev->gmc.fb_start = base;
+	adev->gmc.fb_end = top;
+
+	return base;
+}
+
+void mmhub_v1_7_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
+				uint64_t page_table_base)
+{
+	/* two registers distance between regVM_CONTEXT0_* to regVM_CONTEXT1_* */
+	int offset = regVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32
+			- regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+
+	WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+			offset * vmid, lower_32_bits(page_table_base));
+
+	WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+			offset * vmid, upper_32_bits(page_table_base));
+}
+
+static void mmhub_v1_7_init_gart_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+
+	mmhub_v1_7_setup_vm_pt_regs(adev, 0, pt_base);
+
+	WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+		     (u32)(adev->gmc.gart_start >> 12));
+	WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+		     (u32)(adev->gmc.gart_start >> 44));
+
+	WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+		     (u32)(adev->gmc.gart_end >> 12));
+	WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+		     (u32)(adev->gmc.gart_end >> 44));
+}
+
+static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t value;
+	uint32_t tmp;
+
+	/* Program the AGP BAR */
+	WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BASE, 0);
+	WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
+	/* Program the system aperture low logical page number. */
+	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
+
+	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	/* Set default page address. */
+	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
+		adev->vm_manager.vram_base_offset;
+	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+		     (u32)(value >> 12));
+	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+		     (u32)(value >> 44));
+
+	/* Program "protection fault". */
+	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+		     (u32)(adev->dummy_page_addr >> 12));
+	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+		     (u32)((u64)adev->dummy_page_addr >> 44));
+
+	tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
+			    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+}
+
+static void mmhub_v1_7_init_tlb_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	/* Setup TLB control */
+	tmp = RREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL);
+
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 1);
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, SYSTEM_ACCESS_MODE, 3);
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+			    MTYPE, MTYPE_UC);/* XXX for emulation. */
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
+
+	WREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
+}
+
+static void mmhub_v1_7_init_cache_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	/* Setup L2 cache */
+	tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_CNTL);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 1);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_FRAGMENT_PROCESSING, 1);
+	/* XXX for emulation, Refer to closed source code.*/
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, L2_PDE0_CACHE_TAG_GENERATION_MODE,
+			    0);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, PDE_FAULT_CLASSIFICATION, 0);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, CONTEXT1_IDENTITY_ACCESS_MODE, 1);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, IDENTITY_MODE_FRAGMENT_SIZE, 0);
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL, tmp);
+
+	tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_CNTL2);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_ALL_L1_TLBS, 1);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL2, tmp);
+
+	tmp = regVM_L2_CNTL3_DEFAULT;
+	if (adev->gmc.translate_further) {
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 12);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
+				    L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
+	} else {
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
+				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
+	}
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL3, tmp);
+
+	tmp = regVM_L2_CNTL4_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL4, tmp);
+}
+
+static void mmhub_v1_7_enable_system_domain(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	tmp = RREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_CNTL);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH, 0);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL,
+			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
+	WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_CNTL, tmp);
+}
+
+static void mmhub_v1_7_disable_identity_aperture(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
+		     0XFFFFFFFF);
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
+		     0x0000000F);
+
+	WREG32_SOC15(MMHUB, 0,
+		     regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32, 0);
+	WREG32_SOC15(MMHUB, 0,
+		     regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32, 0);
+
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32,
+		     0);
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32,
+		     0);
+}
+
+static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
+{
+	unsigned num_level, block_size;
+	uint32_t tmp;
+	int i;
+
+	num_level = adev->vm_manager.num_level;
+	block_size = adev->vm_manager.block_size;
+	if (adev->gmc.translate_further)
+		num_level -= 1;
+	else
+		block_size -= 9;
+
+	for (i = 0; i <= 14; i++) {
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
+				    num_level);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT,
+				    1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    PAGE_TABLE_BLOCK_SIZE,
+				    block_size);
+		/* Send no-retry XNACK on fault to suppress VM fault storm. */
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
+				    !amdgpu_noretry);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i, tmp);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32, i*2, 0);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32, i*2, 0);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32, i*2,
+			lower_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32, i*2,
+			upper_32_bits(adev->vm_manager.max_pfn - 1));
+	}
+}
+
+static void mmhub_v1_7_program_invalidation(struct amdgpu_device *adev)
+{
+	unsigned i;
+
+	for (i = 0; i < 18; ++i) {
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+				    2 * i, 0xffffffff);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+				    2 * i, 0x1f);
+	}
+}
+
+void mmhub_v1_7_update_power_gating(struct amdgpu_device *adev,
+				bool enable)
+{
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	if (enable && adev->pg_flags & AMD_PG_SUPPORT_MMHUB) {
+		if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->set_powergating_by_smu)
+			amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GMC, true);
+
+	}
+}
+
+int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev)) {
+		/*
+		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
+		 * VF copy registers so vbios post doesn't program them, for
+		 * SRIOV driver need to program them
+		 */
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE,
+			     adev->gmc.vram_start >> 24);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP,
+			     adev->gmc.vram_end >> 24);
+	}
+
+	/* GART Enable. */
+	mmhub_v1_7_init_gart_aperture_regs(adev);
+	mmhub_v1_7_init_system_aperture_regs(adev);
+	mmhub_v1_7_init_tlb_regs(adev);
+	mmhub_v1_7_init_cache_regs(adev);
+
+	mmhub_v1_7_enable_system_domain(adev);
+	mmhub_v1_7_disable_identity_aperture(adev);
+	mmhub_v1_7_setup_vmid_config(adev);
+	mmhub_v1_7_program_invalidation(adev);
+
+	return 0;
+}
+
+void mmhub_v1_7_gart_disable(struct amdgpu_device *adev)
+{
+	u32 tmp;
+	u32 i;
+
+	/* Disable all tables */
+	for (i = 0; i < 16; i++)
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_CNTL, i, 0);
+
+	/* Setup TLB control */
+	tmp = RREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL);
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
+	tmp = REG_SET_FIELD(tmp,
+				MC_VM_MX_L1_TLB_CNTL,
+				ENABLE_ADVANCED_DRIVER_MODEL,
+				0);
+	WREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
+
+	if (!amdgpu_sriov_vf(adev)) {
+		/* Setup L2 cache */
+		tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_CNTL);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
+		WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL, tmp);
+		WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL3, 0);
+	}
+}
+
+/**
+ * mmhub_v1_7_set_fault_enable_default - update GART/VM fault handling
+ *
+ * @adev: amdgpu_device pointer
+ * @value: true redirects VM faults to the default page
+ */
+void mmhub_v1_7_set_fault_enable_default(struct amdgpu_device *adev, bool value)
+{
+	u32 tmp;
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			PDE1_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			PDE2_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp,
+			VM_L2_PROTECTION_FAULT_CNTL,
+			TRANSLATE_FURTHER_PROTECTION_FAULT_ENABLE_DEFAULT,
+			value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			NACK_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			VALID_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			READ_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	if (!value) {
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				CRASH_ON_NO_RETRY_FAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				CRASH_ON_RETRY_FAULT, 1);
+    }
+
+	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL, tmp);
+}
+
+void mmhub_v1_7_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+
+	hub->ctx0_ptb_addr_lo32 =
+		SOC15_REG_OFFSET(MMHUB, 0,
+				 regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
+	hub->ctx0_ptb_addr_hi32 =
+		SOC15_REG_OFFSET(MMHUB, 0,
+				 regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
+	hub->vm_inv_eng0_req =
+		SOC15_REG_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_REQ);
+	hub->vm_inv_eng0_ack =
+		SOC15_REG_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_ACK);
+	hub->vm_context0_cntl =
+		SOC15_REG_OFFSET(MMHUB, 0, regVM_CONTEXT0_CNTL);
+	hub->vm_l2_pro_fault_status =
+		SOC15_REG_OFFSET(MMHUB, 0, regVM_L2_PROTECTION_FAULT_STATUS);
+	hub->vm_l2_pro_fault_cntl =
+		SOC15_REG_OFFSET(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL);
+
+}
+
+static void mmhub_v1_7_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+							bool enable)
+{
+	uint32_t def, data, def1, data1, def2 = 0, data2 = 0;
+
+	def  = data  = RREG32_SOC15(MMHUB, 0, regATC_L2_MISC_CG);
+
+	def1 = data1 = RREG32_SOC15(MMHUB, 0, regDAGB0_CNTL_MISC2);
+	def2 = data2 = RREG32_SOC15(MMHUB, 0, regDAGB1_CNTL_MISC2);
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG)) {
+		data |= ATC_L2_MISC_CG__ENABLE_MASK;
+
+		data1 &= ~(DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
+		           DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
+		           DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
+		           DAGB0_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
+		           DAGB0_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
+		           DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
+
+		data2 &= ~(DAGB1_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
+		           DAGB1_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
+		           DAGB1_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
+		           DAGB1_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
+		           DAGB1_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
+		           DAGB1_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
+	} else {
+		data &= ~ATC_L2_MISC_CG__ENABLE_MASK;
+
+		data1 |= (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
+			  DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
+			  DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
+			  DAGB0_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
+			  DAGB0_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
+			  DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
+
+		data2 |= (DAGB1_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
+		          DAGB1_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
+		          DAGB1_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
+		          DAGB1_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
+		          DAGB1_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
+		          DAGB1_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
+	}
+
+	if (def != data)
+		WREG32_SOC15(MMHUB, 0, regATC_L2_MISC_CG, data);
+
+	if (def1 != data1)
+		WREG32_SOC15(MMHUB, 0, regDAGB0_CNTL_MISC2, data1);
+
+	if (def2 != data2)
+		WREG32_SOC15(MMHUB, 0, regDAGB1_CNTL_MISC2, data2);
+}
+
+static void mmhub_v1_7_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+						       bool enable)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(MMHUB, 0, regATC_L2_MISC_CG);
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS))
+		data |= ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
+	else
+		data &= ~ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(MMHUB, 0, regATC_L2_MISC_CG, data);
+}
+
+int mmhub_v1_7_set_clockgating(struct amdgpu_device *adev,
+			       enum amd_clockgating_state state)
+{
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	switch (adev->asic_type) {
+	case CHIP_ALDEBARAN:
+		mmhub_v1_7_update_medium_grain_clock_gating(adev,
+				state == AMD_CG_STATE_GATE ? true : false);
+		mmhub_v1_7_update_medium_grain_light_sleep(adev,
+				state == AMD_CG_STATE_GATE ? true : false);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+void mmhub_v1_7_get_clockgating(struct amdgpu_device *adev, u32 *flags)
+{
+	int data, data1;
+
+	if (amdgpu_sriov_vf(adev))
+		*flags = 0;
+
+	data = RREG32_SOC15(MMHUB, 0, regATC_L2_MISC_CG);
+
+	data1 = RREG32_SOC15(MMHUB, 0, regDAGB0_CNTL_MISC2);
+
+	/* AMD_CG_SUPPORT_MC_MGCG */
+	if ((data & ATC_L2_MISC_CG__ENABLE_MASK) &&
+	    !(data1 & (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
+		       DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
+		       DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
+		       DAGB0_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
+		       DAGB0_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
+		       DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK)))
+		*flags |= AMD_CG_SUPPORT_MC_MGCG;
+
+	/* AMD_CG_SUPPORT_MC_LS */
+	if (data & ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_MC_LS;
+}
+
+static void mmhub_v1_7_query_ras_error_count(struct amdgpu_device *adev,
+					   void *ras_error_status)
+{
+	int i;
+	uint32_t ea0_edc_cnt, ea0_edc_cnt2;
+	uint32_t ea1_edc_cnt, ea1_edc_cnt2;
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+
+	/* EDC CNT will be cleared automatically after read */
+	ea0_edc_cnt = RREG32_SOC15(MMHUB, 0, regMMEA0_EDC_CNT);
+	ea0_edc_cnt2 = RREG32_SOC15(MMHUB, 0, regMMEA0_EDC_CNT2);
+	ea1_edc_cnt = RREG32_SOC15(MMHUB, 0, regMMEA1_EDC_CNT);
+	ea1_edc_cnt2 = RREG32_SOC15(MMHUB, 0, regMMEA1_EDC_CNT2);
+
+	/* error count of each error type is recorded by 2 bits,
+	 * ce and ue count in EDC_CNT
+	 */
+	for (i = 0; i < 5; i++) {
+		err_data->ce_count += (ea0_edc_cnt & EA_EDC_CNT_MASK);
+		err_data->ce_count += (ea1_edc_cnt & EA_EDC_CNT_MASK);
+		ea0_edc_cnt >>= EA_EDC_CNT_SHIFT;
+		ea1_edc_cnt >>= EA_EDC_CNT_SHIFT;
+		err_data->ue_count += (ea0_edc_cnt & EA_EDC_CNT_MASK);
+		err_data->ue_count += (ea1_edc_cnt & EA_EDC_CNT_MASK);
+		ea0_edc_cnt >>= EA_EDC_CNT_SHIFT;
+		ea1_edc_cnt >>= EA_EDC_CNT_SHIFT;
+	}
+	/* successive ue count in EDC_CNT */
+	for (i = 0; i < 5; i++) {
+		err_data->ue_count += (ea0_edc_cnt & EA_EDC_CNT_MASK);
+		err_data->ue_count += (ea1_edc_cnt & EA_EDC_CNT_MASK);
+		ea0_edc_cnt >>= EA_EDC_CNT_SHIFT;
+		ea1_edc_cnt >>= EA_EDC_CNT_SHIFT;
+	}
+
+	/* ce and ue count in EDC_CNT2 */
+	for (i = 0; i < 3; i++) {
+		err_data->ce_count += (ea0_edc_cnt2 & EA_EDC_CNT_MASK);
+		err_data->ce_count += (ea1_edc_cnt2 & EA_EDC_CNT_MASK);
+		ea0_edc_cnt2 >>= EA_EDC_CNT_SHIFT;
+		ea1_edc_cnt2 >>= EA_EDC_CNT_SHIFT;
+		err_data->ue_count += (ea0_edc_cnt2 & EA_EDC_CNT_MASK);
+		err_data->ue_count += (ea1_edc_cnt2 & EA_EDC_CNT_MASK);
+		ea0_edc_cnt2 >>= EA_EDC_CNT_SHIFT;
+		ea1_edc_cnt2 >>= EA_EDC_CNT_SHIFT;
+	}
+	/* successive ue count in EDC_CNT2 */
+	for (i = 0; i < 6; i++) {
+		err_data->ue_count += (ea0_edc_cnt2 & EA_EDC_CNT_MASK);
+		err_data->ue_count += (ea1_edc_cnt2 & EA_EDC_CNT_MASK);
+		ea0_edc_cnt2 >>= EA_EDC_CNT_SHIFT;
+		ea1_edc_cnt2 >>= EA_EDC_CNT_SHIFT;
+	}
+}
+
+const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs = {
+	.ras_late_init = amdgpu_mmhub_ras_late_init,
+	.query_ras_error_count = mmhub_v1_7_query_ras_error_count,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
new file mode 100644
index 000000000000..dc2bb6cfbe73
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
@@ -0,0 +1,42 @@
+/*
+ * Copyright 2016 Advanced Micro Devices, Inc.
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
+#ifndef __MMHUB_V1_7_H__
+#define __MMHUB_V1_7_H__
+
+extern const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs;
+
+u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev);
+int mmhub_v1_7_gart_enable(struct amdgpu_device *adev);
+void mmhub_v1_7_gart_disable(struct amdgpu_device *adev);
+void mmhub_v1_7_set_fault_enable_default(struct amdgpu_device *adev,
+					 bool value);
+void mmhub_v1_7_init(struct amdgpu_device *adev);
+int mmhub_v1_7_set_clockgating(struct amdgpu_device *adev,
+			       enum amd_clockgating_state state);
+void mmhub_v1_7_get_clockgating(struct amdgpu_device *adev, u32 *flags);
+void mmhub_v1_7_update_power_gating(struct amdgpu_device *adev,
+                                bool enable);
+void mmhub_v1_7_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
+				uint64_t page_table_base);
+
+#endif
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
