Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274D5C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F197061A36
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F197061A36
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DB16ED1E;
	Wed,  2 Jun 2021 16:49:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31FF86ED1A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8Mbj05mAE0ifdiRAIou4zj0t5kBNIWHDUdXESxDvIpdKpm+Z5nqLA96X2gyOeL7cxxGhjYEN9SYES9WBaL1wudbaotYLJYv2GQuXJPkNq2tRARY8wX8en8aPRpMeueLSoCrLaV/iAalOOzkDVvo06VQpv8keFHwy/0FF+IAWXAqvV57mZmLetVWE1VsCDaFe4vHSq46n9J7nUBhGndyrsOEX5FyaHQnU6jr088M3bQ+OU7FvSX3gYwHkBagvy6P+VguSWAMYM3y6RxvrAvEbd88lK4dCR/LA1hYgk51ng6GaQ6Nn4NKYIjRvlr1JKzSGjB02vbFMfEC3U+hYDMvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOBeqeo61dddlrQ2Z5tfBlk3cLL8IHn6ZAJrRnwBjL8=;
 b=CpLGAQPkHN3xVszzdq9Cx4izlE6h5CqW51OhMf7Gof6vPMv3QAzi/RVFjAZQuYaxNhfDVT3NEtcm3EQZMD/6NJp1r+48QZZ1efvgBdBSyrZDDBe2Q/azfIifhuadUDBKP6wk1hlSBLRrWvq5rZwkHsJKwrG0vNjPzE8qkaNQhux6mXYCCr8AUByzNOSLJ+VsaamtjGJZAIL+179z3NYfPG1tiNfh79ujlIWY3iLDSjMzOM5cwlLSmMOm/xMto67n7mbvCE4J9PTaTbhrHO39cEk/RQzf0rgG8UxXUWL0lgBYmpUygGFX0OYlvcpUKda09+j03pSa5EbzcO/aPODRqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOBeqeo61dddlrQ2Z5tfBlk3cLL8IHn6ZAJrRnwBjL8=;
 b=wA7Bn60T0Tt45U2lwAA8Ugio194sTBC4jKDmOt1JlsDsq1HisL17SYhXWcyr6ZcdX6fZuTdYmTlmcbS67FXxEFQ/1L6wdUQTR9ldvM32WiFdTPfZrHErbs1hcy78o0Xo7Kvni7wc6ERKxvQz/uZgho6YjXyWSY4ISsEuhjujlXw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:32 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/89] drm/amdgpu: add yellow_carp_reg_base_init function for
 yellow carp (v2)
Date: Wed,  2 Jun 2021 12:47:44 -0400
Message-Id: <20210602164908.2848791-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67d03968-2e3e-4edb-210a-08d925e664b8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40633417B421542854C96D20F73D9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEZJ3QscUDfFZds1O+5kOBB4nZ9SUduE5v+DpDvEArLHWTNOlI/VtOawsaWXo5hY079qtAU5EnqPJnAUjxH8AObbNenFu020M0huR/orKd0fkVrvRMkbf9JsVsxdae7mykwjcKAivDu+8NoOizx6KMmSaRomfHugsm+Rc29t0Sr4B+x+bukrS8XV6zTPzrl7ALOms0he9FwZe7P1ZPesYgGe779htdySPgOrGBa8wUmup0BQHc+EBsx5PvzFy3bDkiiQn0W/BQEcAzI023wNO79MiH2LRbRbBk0apNdbrCqFC3vyZu1JtEQuYdHe98Gwj2pJijT51tXy14AjKG6lVqu6X1UtJe4QRTYdQbO18NXut7F7JTBkihhP17e2pzzHcR5bbu8xJdA/8jShkvSBfLoMWrZS1SWxsgCiEupYhrmQVIW2ZNXg/AkPfMBiqkKFu+zRGRkoctgB5HAnWriqpn46KaViYtbPE7dqk/5ei4eZQaAZ4tOTqJ6RdERKxK0Fj1eIT9CMjh2W1SAxoGJ1xJRrKiBRyAPClaLXbfXzD5EZCwr5uJ/dmwboXvNw+MRcmFXCfSjuFfbrqqHrXKGZdazPtxanQjBQw21gUFb3t6s4aYs7Fk4+s6rAWJUKnxlBES3U1GzGvfyuc58LUYYaa9Z5yucwSsgV1/6yCv64g7yg/btr71t8Ylrku9e1QEZe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(54906003)(16526019)(186003)(316002)(4326008)(52116002)(38350700002)(66476007)(86362001)(478600001)(38100700002)(2616005)(956004)(36756003)(6506007)(6916009)(2906002)(8936002)(6486002)(6512007)(1076003)(66556008)(6666004)(5660300002)(8676002)(30864003)(83380400001)(66946007)(26005)(69590400013)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oh5cmuZ0A1tiZtVip76DioMPq+kBTO/ultSZpN6LoX8udNHB1MWkva9e/jQS?=
 =?us-ascii?Q?t0lkftnP9vkAewJKFmibCCi39Uyc2g0Z5qKDBm9NBS7DZd8BV8psl9rZAShp?=
 =?us-ascii?Q?XtvlOQa/xXIX25Ew4vgYJDSXCxm/8oin69kI4Whdc9JIJODf1olu8Rln4JWn?=
 =?us-ascii?Q?4fdOL0l6AvxgYFMPs9Yq2gW96eEAfNgQKsvJZx9wuxR2gJyBh/BoJRBr7SFw?=
 =?us-ascii?Q?mP+XMLIzxEKT/BF8qvJQakRVm9B1oD1mRZsLuGP/U/5S6R5tJao5uUy7/jDT?=
 =?us-ascii?Q?sXS3jIdxzP9dQtUrSxjcCkSazRJ6p64iIOr+radWRVK3kCeTY8Y4DZaKlfJ8?=
 =?us-ascii?Q?hG9+96Mw6gqV8BAGFcCp1pjy8MVe4wqNHzRwX/sZlMvN821DYkInLCdo8h6m?=
 =?us-ascii?Q?TjbiS17/VW2X23+CNK+xnfJ4BjDZd21ndHG5CDWvujuEIzwWGSE5oXpLKprV?=
 =?us-ascii?Q?MUfHH4+QM5kXWG003SfT+CrYhHIshbjp5cGBTaQ9v8OO0diYCMD5A+Uk3FYg?=
 =?us-ascii?Q?7DvNHtSVE/oRj0UK9CJSGKInoGO2Vz8VGw4uHB1wYNDQvfav2svcgTBa8dso?=
 =?us-ascii?Q?pXUmxGawteyO0jx30vZuV2JizYlIIlNwSoEJxZNFYztUAL9OWJ5nXRQFMa+S?=
 =?us-ascii?Q?OBFaXQCoI9VoZo78+v/zKq/AKq8PQ7eiJLx524A2w4bRpvyJAz5sHfIN/zdL?=
 =?us-ascii?Q?Hzii7DcnWjo7YzOAWyWd7JAPO+MBtIgs42eyDSsuOgBRGM3Jw48u/SGO+Wdt?=
 =?us-ascii?Q?UYe5uMrHn7z7POwkk0zQKhxuhc0rmYid7+RPMbS+V56MlOv6I5d9IrU0Tywy?=
 =?us-ascii?Q?rk1cnxiKnFxKxzkIi3PHv+AU1IJQXussaZ0NoxmjPhspN5ilZPpoj7Kf2Xoz?=
 =?us-ascii?Q?RJ28ec6s41gAY95xQs2QLyvpJ4va3H091W6hRZTwmlTdN8zK0BZ1yF1meRst?=
 =?us-ascii?Q?/is7V0KiHaC7ZC6VtszfCPKOywpYnI/pDdAAsx2uYcJocloAKGIY4oxgP1L6?=
 =?us-ascii?Q?Wp0E4frfaZu5/waf1Zsd8VGVZbVdegcrJTAsEWiBi4FQsYgE/QRqbZXvL6vc?=
 =?us-ascii?Q?LzN0C5tGir/EGvYblpIkkvtyGspwwidTJ/9++9HLR6U3k+NbqEf6ua0FqEnj?=
 =?us-ascii?Q?jf5SpT0SHorxs9kgN7pGel93U2rwWuRJBQg++LnIETyEKaCnusVOBD+3y6uC?=
 =?us-ascii?Q?JgDqpnG5399+ZvYpbzNV/kpb+FvB+qgMX0KKs7qkL7cOY4Q9dU1YKsYA2gkc?=
 =?us-ascii?Q?ioPjVCReg2rOmHtRIf7WjhQCloKSDw9FkeZaomNY9AH18cNXACMz5DhnQsJs?=
 =?us-ascii?Q?xZ/5lQRRcHesNwleF3O0rYJB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d03968-2e3e-4edb-210a-08d925e664b8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:31.4708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87ahtGMmOAGDx387H1D6zvK6AUOGzULgzhInqYE3i4CBM9vxEE1s8wQstVSv5Pf1x6f8HCg6TfhEjSjCY74vBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds yellow_carp_reg_base_init function to init the register
base for yellow carp.

v2: squash in updates (Alex)

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |    2 +-
 drivers/gpu/drm/amd/amdgpu/nv.h               |    2 +
 .../gpu/drm/amd/amdgpu/yellow_carp_reg_init.c |   51 +
 .../gpu/drm/amd/include/yellow_carp_offset.h  | 1366 +++++++++++++++++
 4 files changed, 1420 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/yellow_carp_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/include/yellow_carp_offset.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 6cf0fe871d6c..c56320e78c0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -75,7 +75,7 @@ amdgpu-y += \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
 	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o \
 	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o \
-	beige_goby_reg_init.o
+	beige_goby_reg_init.o yellow_carp_reg_init.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index 330438388fde..eb9aff1e7253 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -37,4 +37,6 @@ int sienna_cichlid_reg_base_init(struct amdgpu_device *adev);
 void vangogh_reg_base_init(struct amdgpu_device *adev);
 int dimgrey_cavefish_reg_base_init(struct amdgpu_device *adev);
 int beige_goby_reg_base_init(struct amdgpu_device *adev);
+int yellow_carp_reg_base_init(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/yellow_carp_reg_init.c b/drivers/gpu/drm/amd/amdgpu/yellow_carp_reg_init.c
new file mode 100644
index 000000000000..3d89421275ed
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/yellow_carp_reg_init.c
@@ -0,0 +1,51 @@
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
+#include "nv.h"
+
+#include "soc15_common.h"
+#include "soc15_hw_ip.h"
+#include "yellow_carp_offset.h"
+
+int yellow_carp_reg_base_init(struct amdgpu_device *adev)
+{
+	/* HW has more IP blocks,  only initialized the block needed by driver */
+	uint32_t i;
+	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
+		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
+		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
+		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
+		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
+		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
+		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
+		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(VCN_BASE.instance[i]));
+		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
+		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DCN_BASE.instance[i]));
+		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
+		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(SDMA0_BASE.instance[i]));
+		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
+		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));
+	}
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/include/yellow_carp_offset.h b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
new file mode 100644
index 000000000000..76b9eb3f441d
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
@@ -0,0 +1,1366 @@
+#ifndef YELLOW_CARP_OFFSET_H
+#define YELLOW_CARP_OFFSET_H
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
+static const struct IP_BASE ACP_BASE = { { { { 0x02403800, 0x00480000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE ATHUB_BASE = { { { { 0x00000C00, 0x00013300, 0x02408C00, 0, 0, 0 } },
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
+                                        { { 0x0001B400, 0x0242E000, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DBGU_IO_BASE = { { { { 0x000001E0, 0x00000260, 0x00000280, 0x0240B400, 0x02413C00, 0x02416000 } },
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
+static const struct IP_BASE DF_BASE = { { { { 0x00007000, 0x0240B800, 0x02447800, 0x00C00000, 0x03640000, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE FCH_BASE = { { { { 0x0240C000, 0x00B40000, 0x11000000, 0, 0, 0 } },
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
+static const struct IP_BASE GC_BASE = { { { { 0x00001260, 0x0000A000, 0x02402C00, 0, 0, 0 } },
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
+static const struct IP_BASE IOHC0_BASE = { { { { 0x00010000, 0x02406000, 0x04EC0000, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MMHUB_BASE = { { { { 0x00013200, 0x0001A000, 0x02408800, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MP0_BASE = { { { { 0x00016000, 0x0243FC00, 0x00DC0000, 0x00E00000, 0x00E40000, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MP1_BASE = { { { { 0x00016000, 0x0243FC00, 0x00DC0000, 0x00E00000, 0x00E40000, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MP2_BASE = { { { { 0x00016000, 0x0243FC00, 0x00DC0000, 0x00E00000, 0x00E40000, 0 } },
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
+static const struct IP_BASE PCIE_BASE = { { { { 0x02411800, 0x04440000, 0, 0, 0, 0 } },
+                                        { { 0x02411C00, 0x04480000, 0, 0, 0, 0 } },
+                                        { { 0x02412000, 0x044C0000, 0, 0, 0, 0 } },
+                                        { { 0x02412400, 0x04500000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SDMA0_BASE = { { { { 0x00001260, 0x0000A000, 0x02402C00, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SMUIO_BASE = { { { { 0x00016800, 0x00016A00, 0x02401000, 0x00440000, 0, 0 } },
+                                        { { 0x0001BC00, 0x0242D400, 0, 0, 0, 0 } },
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
+static const struct IP_BASE UMC_BASE = { { { { 0x00014000, 0x00054000, 0x02425800, 0x02425C00, 0, 0 } },
+                                        { { 0x00094000, 0x000D4000, 0x02426000, 0x02426400, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE VCN_BASE = { { { { 0x00007800, 0x00007E00, 0x02403000, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+
+
+#define ACP_BASE__INST0_SEG0                       0x02403800
+#define ACP_BASE__INST0_SEG1                       0x00480000
+#define ACP_BASE__INST0_SEG2                       0
+#define ACP_BASE__INST0_SEG3                       0
+#define ACP_BASE__INST0_SEG4                       0
+#define ACP_BASE__INST0_SEG5                       0
+
+#define ACP_BASE__INST1_SEG0                       0
+#define ACP_BASE__INST1_SEG1                       0
+#define ACP_BASE__INST1_SEG2                       0
+#define ACP_BASE__INST1_SEG3                       0
+#define ACP_BASE__INST1_SEG4                       0
+#define ACP_BASE__INST1_SEG5                       0
+
+#define ACP_BASE__INST2_SEG0                       0
+#define ACP_BASE__INST2_SEG1                       0
+#define ACP_BASE__INST2_SEG2                       0
+#define ACP_BASE__INST2_SEG3                       0
+#define ACP_BASE__INST2_SEG4                       0
+#define ACP_BASE__INST2_SEG5                       0
+
+#define ACP_BASE__INST3_SEG0                       0
+#define ACP_BASE__INST3_SEG1                       0
+#define ACP_BASE__INST3_SEG2                       0
+#define ACP_BASE__INST3_SEG3                       0
+#define ACP_BASE__INST3_SEG4                       0
+#define ACP_BASE__INST3_SEG5                       0
+
+#define ACP_BASE__INST4_SEG0                       0
+#define ACP_BASE__INST4_SEG1                       0
+#define ACP_BASE__INST4_SEG2                       0
+#define ACP_BASE__INST4_SEG3                       0
+#define ACP_BASE__INST4_SEG4                       0
+#define ACP_BASE__INST4_SEG5                       0
+
+#define ACP_BASE__INST5_SEG0                       0
+#define ACP_BASE__INST5_SEG1                       0
+#define ACP_BASE__INST5_SEG2                       0
+#define ACP_BASE__INST5_SEG3                       0
+#define ACP_BASE__INST5_SEG4                       0
+#define ACP_BASE__INST5_SEG5                       0
+
+#define ACP_BASE__INST6_SEG0                       0
+#define ACP_BASE__INST6_SEG1                       0
+#define ACP_BASE__INST6_SEG2                       0
+#define ACP_BASE__INST6_SEG3                       0
+#define ACP_BASE__INST6_SEG4                       0
+#define ACP_BASE__INST6_SEG5                       0
+
+#define ATHUB_BASE__INST0_SEG0                     0x00000C00
+#define ATHUB_BASE__INST0_SEG1                     0x00013300
+#define ATHUB_BASE__INST0_SEG2                     0x02408C00
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
+#define CLK_BASE__INST6_SEG0                       0x0001B400
+#define CLK_BASE__INST6_SEG1                       0x0242E000
+#define CLK_BASE__INST6_SEG2                       0
+#define CLK_BASE__INST6_SEG3                       0
+#define CLK_BASE__INST6_SEG4                       0
+#define CLK_BASE__INST6_SEG5                       0
+
+#define DBGU_IO_BASE__INST0_SEG0                   0x000001E0
+#define DBGU_IO_BASE__INST0_SEG1                   0x00000260
+#define DBGU_IO_BASE__INST0_SEG2                   0x00000280
+#define DBGU_IO_BASE__INST0_SEG3                   0x0240B400
+#define DBGU_IO_BASE__INST0_SEG4                   0x02413C00
+#define DBGU_IO_BASE__INST0_SEG5                   0x02416000
+
+#define DBGU_IO_BASE__INST1_SEG0                   0
+#define DBGU_IO_BASE__INST1_SEG1                   0
+#define DBGU_IO_BASE__INST1_SEG2                   0
+#define DBGU_IO_BASE__INST1_SEG3                   0
+#define DBGU_IO_BASE__INST1_SEG4                   0
+#define DBGU_IO_BASE__INST1_SEG5                   0
+
+#define DBGU_IO_BASE__INST2_SEG0                   0
+#define DBGU_IO_BASE__INST2_SEG1                   0
+#define DBGU_IO_BASE__INST2_SEG2                   0
+#define DBGU_IO_BASE__INST2_SEG3                   0
+#define DBGU_IO_BASE__INST2_SEG4                   0
+#define DBGU_IO_BASE__INST2_SEG5                   0
+
+#define DBGU_IO_BASE__INST3_SEG0                   0
+#define DBGU_IO_BASE__INST3_SEG1                   0
+#define DBGU_IO_BASE__INST3_SEG2                   0
+#define DBGU_IO_BASE__INST3_SEG3                   0
+#define DBGU_IO_BASE__INST3_SEG4                   0
+#define DBGU_IO_BASE__INST3_SEG5                   0
+
+#define DBGU_IO_BASE__INST4_SEG0                   0
+#define DBGU_IO_BASE__INST4_SEG1                   0
+#define DBGU_IO_BASE__INST4_SEG2                   0
+#define DBGU_IO_BASE__INST4_SEG3                   0
+#define DBGU_IO_BASE__INST4_SEG4                   0
+#define DBGU_IO_BASE__INST4_SEG5                   0
+
+#define DBGU_IO_BASE__INST5_SEG0                   0
+#define DBGU_IO_BASE__INST5_SEG1                   0
+#define DBGU_IO_BASE__INST5_SEG2                   0
+#define DBGU_IO_BASE__INST5_SEG3                   0
+#define DBGU_IO_BASE__INST5_SEG4                   0
+#define DBGU_IO_BASE__INST5_SEG5                   0
+
+#define DBGU_IO_BASE__INST6_SEG0                   0
+#define DBGU_IO_BASE__INST6_SEG1                   0
+#define DBGU_IO_BASE__INST6_SEG2                   0
+#define DBGU_IO_BASE__INST6_SEG3                   0
+#define DBGU_IO_BASE__INST6_SEG4                   0
+#define DBGU_IO_BASE__INST6_SEG5                   0
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
+#define DF_BASE__INST0_SEG0                        0x00007000
+#define DF_BASE__INST0_SEG1                        0x0240B800
+#define DF_BASE__INST0_SEG2                        0x02447800
+#define DF_BASE__INST0_SEG3                        0x00C00000
+#define DF_BASE__INST0_SEG4                        0x03640000
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
+#define FCH_BASE__INST0_SEG0                       0x0240C000
+#define FCH_BASE__INST0_SEG1                       0x00B40000
+#define FCH_BASE__INST0_SEG2                       0x11000000
+#define FCH_BASE__INST0_SEG3                       0
+#define FCH_BASE__INST0_SEG4                       0
+#define FCH_BASE__INST0_SEG5                       0
+
+#define FCH_BASE__INST1_SEG0                       0
+#define FCH_BASE__INST1_SEG1                       0
+#define FCH_BASE__INST1_SEG2                       0
+#define FCH_BASE__INST1_SEG3                       0
+#define FCH_BASE__INST1_SEG4                       0
+#define FCH_BASE__INST1_SEG5                       0
+
+#define FCH_BASE__INST2_SEG0                       0
+#define FCH_BASE__INST2_SEG1                       0
+#define FCH_BASE__INST2_SEG2                       0
+#define FCH_BASE__INST2_SEG3                       0
+#define FCH_BASE__INST2_SEG4                       0
+#define FCH_BASE__INST2_SEG5                       0
+
+#define FCH_BASE__INST3_SEG0                       0
+#define FCH_BASE__INST3_SEG1                       0
+#define FCH_BASE__INST3_SEG2                       0
+#define FCH_BASE__INST3_SEG3                       0
+#define FCH_BASE__INST3_SEG4                       0
+#define FCH_BASE__INST3_SEG5                       0
+
+#define FCH_BASE__INST4_SEG0                       0
+#define FCH_BASE__INST4_SEG1                       0
+#define FCH_BASE__INST4_SEG2                       0
+#define FCH_BASE__INST4_SEG3                       0
+#define FCH_BASE__INST4_SEG4                       0
+#define FCH_BASE__INST4_SEG5                       0
+
+#define FCH_BASE__INST5_SEG0                       0
+#define FCH_BASE__INST5_SEG1                       0
+#define FCH_BASE__INST5_SEG2                       0
+#define FCH_BASE__INST5_SEG3                       0
+#define FCH_BASE__INST5_SEG4                       0
+#define FCH_BASE__INST5_SEG5                       0
+
+#define FCH_BASE__INST6_SEG0                       0
+#define FCH_BASE__INST6_SEG1                       0
+#define FCH_BASE__INST6_SEG2                       0
+#define FCH_BASE__INST6_SEG3                       0
+#define FCH_BASE__INST6_SEG4                       0
+#define FCH_BASE__INST6_SEG5                       0
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
+#define GC_BASE__INST0_SEG2                        0x02402C00
+#define GC_BASE__INST0_SEG3                        0
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
+#define IOHC0_BASE__INST0_SEG0                     0x00010000
+#define IOHC0_BASE__INST0_SEG1                     0x02406000
+#define IOHC0_BASE__INST0_SEG2                     0x04EC0000
+#define IOHC0_BASE__INST0_SEG3                     0
+#define IOHC0_BASE__INST0_SEG4                     0
+#define IOHC0_BASE__INST0_SEG5                     0
+
+#define IOHC0_BASE__INST1_SEG0                     0
+#define IOHC0_BASE__INST1_SEG1                     0
+#define IOHC0_BASE__INST1_SEG2                     0
+#define IOHC0_BASE__INST1_SEG3                     0
+#define IOHC0_BASE__INST1_SEG4                     0
+#define IOHC0_BASE__INST1_SEG5                     0
+
+#define IOHC0_BASE__INST2_SEG0                     0
+#define IOHC0_BASE__INST2_SEG1                     0
+#define IOHC0_BASE__INST2_SEG2                     0
+#define IOHC0_BASE__INST2_SEG3                     0
+#define IOHC0_BASE__INST2_SEG4                     0
+#define IOHC0_BASE__INST2_SEG5                     0
+
+#define IOHC0_BASE__INST3_SEG0                     0
+#define IOHC0_BASE__INST3_SEG1                     0
+#define IOHC0_BASE__INST3_SEG2                     0
+#define IOHC0_BASE__INST3_SEG3                     0
+#define IOHC0_BASE__INST3_SEG4                     0
+#define IOHC0_BASE__INST3_SEG5                     0
+
+#define IOHC0_BASE__INST4_SEG0                     0
+#define IOHC0_BASE__INST4_SEG1                     0
+#define IOHC0_BASE__INST4_SEG2                     0
+#define IOHC0_BASE__INST4_SEG3                     0
+#define IOHC0_BASE__INST4_SEG4                     0
+#define IOHC0_BASE__INST4_SEG5                     0
+
+#define IOHC0_BASE__INST5_SEG0                     0
+#define IOHC0_BASE__INST5_SEG1                     0
+#define IOHC0_BASE__INST5_SEG2                     0
+#define IOHC0_BASE__INST5_SEG3                     0
+#define IOHC0_BASE__INST5_SEG4                     0
+#define IOHC0_BASE__INST5_SEG5                     0
+
+#define IOHC0_BASE__INST6_SEG0                     0
+#define IOHC0_BASE__INST6_SEG1                     0
+#define IOHC0_BASE__INST6_SEG2                     0
+#define IOHC0_BASE__INST6_SEG3                     0
+#define IOHC0_BASE__INST6_SEG4                     0
+#define IOHC0_BASE__INST6_SEG5                     0
+
+#define MMHUB_BASE__INST0_SEG0                     0x00013200
+#define MMHUB_BASE__INST0_SEG1                     0x0001A000
+#define MMHUB_BASE__INST0_SEG2                     0x02408800
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
+#define MP0_BASE__INST0_SEG1                       0x0243FC00
+#define MP0_BASE__INST0_SEG2                       0x00DC0000
+#define MP0_BASE__INST0_SEG3                       0x00E00000
+#define MP0_BASE__INST0_SEG4                       0x00E40000
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
+#define MP1_BASE__INST0_SEG1                       0x0243FC00
+#define MP1_BASE__INST0_SEG2                       0x00DC0000
+#define MP1_BASE__INST0_SEG3                       0x00E00000
+#define MP1_BASE__INST0_SEG4                       0x00E40000
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
+#define MP2_BASE__INST0_SEG0                       0x00016000
+#define MP2_BASE__INST0_SEG1                       0x0243FC00
+#define MP2_BASE__INST0_SEG2                       0x00DC0000
+#define MP2_BASE__INST0_SEG3                       0x00E00000
+#define MP2_BASE__INST0_SEG4                       0x00E40000
+#define MP2_BASE__INST0_SEG5                       0
+
+#define MP2_BASE__INST1_SEG0                       0
+#define MP2_BASE__INST1_SEG1                       0
+#define MP2_BASE__INST1_SEG2                       0
+#define MP2_BASE__INST1_SEG3                       0
+#define MP2_BASE__INST1_SEG4                       0
+#define MP2_BASE__INST1_SEG5                       0
+
+#define MP2_BASE__INST2_SEG0                       0
+#define MP2_BASE__INST2_SEG1                       0
+#define MP2_BASE__INST2_SEG2                       0
+#define MP2_BASE__INST2_SEG3                       0
+#define MP2_BASE__INST2_SEG4                       0
+#define MP2_BASE__INST2_SEG5                       0
+
+#define MP2_BASE__INST3_SEG0                       0
+#define MP2_BASE__INST3_SEG1                       0
+#define MP2_BASE__INST3_SEG2                       0
+#define MP2_BASE__INST3_SEG3                       0
+#define MP2_BASE__INST3_SEG4                       0
+#define MP2_BASE__INST3_SEG5                       0
+
+#define MP2_BASE__INST4_SEG0                       0
+#define MP2_BASE__INST4_SEG1                       0
+#define MP2_BASE__INST4_SEG2                       0
+#define MP2_BASE__INST4_SEG3                       0
+#define MP2_BASE__INST4_SEG4                       0
+#define MP2_BASE__INST4_SEG5                       0
+
+#define MP2_BASE__INST5_SEG0                       0
+#define MP2_BASE__INST5_SEG1                       0
+#define MP2_BASE__INST5_SEG2                       0
+#define MP2_BASE__INST5_SEG3                       0
+#define MP2_BASE__INST5_SEG4                       0
+#define MP2_BASE__INST5_SEG5                       0
+
+#define MP2_BASE__INST6_SEG0                       0
+#define MP2_BASE__INST6_SEG1                       0
+#define MP2_BASE__INST6_SEG2                       0
+#define MP2_BASE__INST6_SEG3                       0
+#define MP2_BASE__INST6_SEG4                       0
+#define MP2_BASE__INST6_SEG5                       0
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
+#define PCIE_BASE__INST0_SEG0                      0x02411800
+#define PCIE_BASE__INST0_SEG1                      0x04440000
+#define PCIE_BASE__INST0_SEG2                      0
+#define PCIE_BASE__INST0_SEG3                      0
+#define PCIE_BASE__INST0_SEG4                      0
+#define PCIE_BASE__INST0_SEG5                      0
+
+#define PCIE_BASE__INST1_SEG0                      0x02411C00
+#define PCIE_BASE__INST1_SEG1                      0x04480000
+#define PCIE_BASE__INST1_SEG2                      0
+#define PCIE_BASE__INST1_SEG3                      0
+#define PCIE_BASE__INST1_SEG4                      0
+#define PCIE_BASE__INST1_SEG5                      0
+
+#define PCIE_BASE__INST2_SEG0                      0x02412000
+#define PCIE_BASE__INST2_SEG1                      0x044C0000
+#define PCIE_BASE__INST2_SEG2                      0
+#define PCIE_BASE__INST2_SEG3                      0
+#define PCIE_BASE__INST2_SEG4                      0
+#define PCIE_BASE__INST2_SEG5                      0
+
+#define PCIE_BASE__INST3_SEG0                      0x02412400
+#define PCIE_BASE__INST3_SEG1                      0x04500000
+#define PCIE_BASE__INST3_SEG2                      0
+#define PCIE_BASE__INST3_SEG3                      0
+#define PCIE_BASE__INST3_SEG4                      0
+#define PCIE_BASE__INST3_SEG5                      0
+
+#define PCIE_BASE__INST4_SEG0                      0
+#define PCIE_BASE__INST4_SEG1                      0
+#define PCIE_BASE__INST4_SEG2                      0
+#define PCIE_BASE__INST4_SEG3                      0
+#define PCIE_BASE__INST4_SEG4                      0
+#define PCIE_BASE__INST4_SEG5                      0
+
+#define PCIE_BASE__INST5_SEG0                      0
+#define PCIE_BASE__INST5_SEG1                      0
+#define PCIE_BASE__INST5_SEG2                      0
+#define PCIE_BASE__INST5_SEG3                      0
+#define PCIE_BASE__INST5_SEG4                      0
+#define PCIE_BASE__INST5_SEG5                      0
+
+#define PCIE_BASE__INST6_SEG0                      0
+#define PCIE_BASE__INST6_SEG1                      0
+#define PCIE_BASE__INST6_SEG2                      0
+#define PCIE_BASE__INST6_SEG3                      0
+#define PCIE_BASE__INST6_SEG4                      0
+#define PCIE_BASE__INST6_SEG5                      0
+
+#define SDMA0_BASE__INST0_SEG0                     0x00001260
+#define SDMA0_BASE__INST0_SEG1                     0x0000A000
+#define SDMA0_BASE__INST0_SEG2                     0x02402C00
+#define SDMA0_BASE__INST0_SEG3                     0
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
+#define SMUIO_BASE__INST0_SEG2                     0x02401000
+#define SMUIO_BASE__INST0_SEG3                     0x00440000
+#define SMUIO_BASE__INST0_SEG4                     0
+#define SMUIO_BASE__INST0_SEG5                     0
+
+#define SMUIO_BASE__INST1_SEG0                     0x0001BC00
+#define SMUIO_BASE__INST1_SEG1                     0x0242D400
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
+#define UMC_BASE__INST0_SEG1                       0x00054000
+#define UMC_BASE__INST0_SEG2                       0x02425800
+#define UMC_BASE__INST0_SEG3                       0x02425C00
+#define UMC_BASE__INST0_SEG4                       0
+#define UMC_BASE__INST0_SEG5                       0
+
+#define UMC_BASE__INST1_SEG0                       0x00094000
+#define UMC_BASE__INST1_SEG1                       0x000D4000
+#define UMC_BASE__INST1_SEG2                       0x02426000
+#define UMC_BASE__INST1_SEG3                       0x02426400
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
+#define VCN_BASE__INST0_SEG0                       0x00007800
+#define VCN_BASE__INST0_SEG1                       0x00007E00
+#define VCN_BASE__INST0_SEG2                       0x02403000
+#define VCN_BASE__INST0_SEG3                       0
+#define VCN_BASE__INST0_SEG4                       0
+#define VCN_BASE__INST0_SEG5                       0
+
+#define VCN_BASE__INST1_SEG0                       0
+#define VCN_BASE__INST1_SEG1                       0
+#define VCN_BASE__INST1_SEG2                       0
+#define VCN_BASE__INST1_SEG3                       0
+#define VCN_BASE__INST1_SEG4                       0
+#define VCN_BASE__INST1_SEG5                       0
+
+#define VCN_BASE__INST2_SEG0                       0
+#define VCN_BASE__INST2_SEG1                       0
+#define VCN_BASE__INST2_SEG2                       0
+#define VCN_BASE__INST2_SEG3                       0
+#define VCN_BASE__INST2_SEG4                       0
+#define VCN_BASE__INST2_SEG5                       0
+
+#define VCN_BASE__INST3_SEG0                       0
+#define VCN_BASE__INST3_SEG1                       0
+#define VCN_BASE__INST3_SEG2                       0
+#define VCN_BASE__INST3_SEG3                       0
+#define VCN_BASE__INST3_SEG4                       0
+#define VCN_BASE__INST3_SEG5                       0
+
+#define VCN_BASE__INST4_SEG0                       0
+#define VCN_BASE__INST4_SEG1                       0
+#define VCN_BASE__INST4_SEG2                       0
+#define VCN_BASE__INST4_SEG3                       0
+#define VCN_BASE__INST4_SEG4                       0
+#define VCN_BASE__INST4_SEG5                       0
+
+#define VCN_BASE__INST5_SEG0                       0
+#define VCN_BASE__INST5_SEG1                       0
+#define VCN_BASE__INST5_SEG2                       0
+#define VCN_BASE__INST5_SEG3                       0
+#define VCN_BASE__INST5_SEG4                       0
+#define VCN_BASE__INST5_SEG5                       0
+
+#define VCN_BASE__INST6_SEG0                       0
+#define VCN_BASE__INST6_SEG1                       0
+#define VCN_BASE__INST6_SEG2                       0
+#define VCN_BASE__INST6_SEG3                       0
+#define VCN_BASE__INST6_SEG4                       0
+#define VCN_BASE__INST6_SEG5                       0
+
+#endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
