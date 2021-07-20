Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE12C636C8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B91B610CC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B91B610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B040E6E42D;
	Tue, 20 Jul 2021 15:44:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BAA889D4A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnTYjzAj2N5XTGxuiIu/lmkX5j788zc8Qblgg1ok+i0/zKJczGP6QqAmgrN46PM5XcO6P3HPNJTp15F8KZtDCgjIpirF5PjyHJM8yB5uv1xqle4e87SVtUeoLma0IG7VJMWrdu1xaCb4HkjGMQV3pE8wkmYK4tMVjmgQZtYuZZaJJrYID51T/8r6/pPmRZbsDSqGHY3wYcraLCHVl9yyN4xFH2qzi2KK9Eb7A4I0SzwJF/ARN/mEISyObv+DjXhMUfABiEQxozCbeCY0f7YquO/T2ocQU3L6eXfj4JSMyYFxNjOASrBd+/GSZXgl2bn5cNttj1J2dpKbZf4sAH/BiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qey0INIBzrZkM4VKKmdNhL7bnwSMg8IkUUCy6NY8dM4=;
 b=FxaiUj2brKI38CzpBGaIqqGTObRDIcGFuH+SKkKWbJEEc5kWRqSMElOSbsaJddJdbmy10ho/htTwCULLJNdLfAuoXbMKiIPjGrRHo5KLRcZ8afeMCS9ua+fLMI6JwKO5k4Sm5Vx4ndYR0nfZobK/MCKwQJSuqOvcvmQNUdZiuah1BjvlS3ddQDnvn1unM5ZoAL1do466xiSjc78sFYdvPPWDQkUttOGBEAIQ9NOV8ysPor7VvP02/ihS9ZhHl73F+UBjip1+aQRxgeuFEe3r85xWEVpu2wbm3EdMmOwYVtS3CptJaUfRld44LmO+7S18D8Y9N928S1dD1rzHre/Hmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qey0INIBzrZkM4VKKmdNhL7bnwSMg8IkUUCy6NY8dM4=;
 b=mZ+l/YoxWo0CDSin+uYI6fujy3MuSO5/90aDP22rQ4huukb0HeN/QWrKO2mq4+VMwUpmPkscpPKEWpjA3ZuO121cJvG2nYkPCj3+SBjl8CctbSqJmFR6A59VLvubic/zPupMnxm4cFLlCVRE0ITs22J6qPoviEEbUo1UhHm8yBE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:07 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:07 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/29] drm/amdgpu: dynamic initialize ip offset for
 cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:24 -0400
Message-Id: <20210720154349.1599827-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76bfb435-763b-4251-48a3-08d94b95356f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5126895C1C7F10D63452E99CF7E29@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a45mpFTim6zRaMd1yRtoDIqEOQE+jNH0Zvf20pp9tmwn5FawUGlHFNZybSPpq4Ufd4G0YgXrKmLPPMjZ+go/a7zyYvhvIVy5vYPZ2eXHwU3dnGtttwz54INagHGCyq+X+a7mmT3emCceGjWUwIlgF9RyyTCGPfG6OQo5o3fzhDoNzMR72ayR9gQKZhIIZDai7csxDXlvSsRPN/OhOktikR8tirZ26hvglXI4HCPWrplrBXR8CsQgMz/X8+mC4ePF8Lidh7l4ds+hGABHhwyGogHkJzcDQh9ZezjSc2ZB3r9b9r4NL8dJ914jNaIRH6HGo+1UpOiLchmmMMeUxDftNM/7/sJdVCMdvn7ZQcuJK0NyF8iBxrnsI1O3frXgyIZzXjUuaaOa+JkmzCHiRnhsLx+dmuhCpUG/9qQpoduRGDj0I3yxsymgDkd/2hXZk7/5rTeCjtoC90SSD45zbc0IKZlr57OzGOGVFWNw3M4GtPefnLRwj0kU1HFIfnrJns9Vyl8zItuZiORgPesXsN9ApYQDFKTUFJwVCWI9iCla1KH3BY9NFjUSHN4v2IwHSfPYVN31ZLITrD3oa6xy9S0RD8EBN9SOCZQbXFHyKULaJdyV004ERFSQcrWOVS0LT+JVcmuRZIKticpJnAnDMCxFyNAbmcAYHb8S0jP1NiVZn2yX5TCzYVzhlfDYmo/BRtmHEjo1rtJpX01+2XwpKkEJJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(186003)(4326008)(956004)(6916009)(478600001)(36756003)(5660300002)(52116002)(7696005)(6486002)(1076003)(6666004)(2616005)(2906002)(8936002)(38350700002)(38100700002)(66946007)(316002)(66476007)(66556008)(26005)(30864003)(54906003)(83380400001)(8676002)(86362001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?khsFvTPw5dEtCynUH5PqvX+FFx0S3+V4dWaohogWqwBWPhAKv0Cylh22e2+X?=
 =?us-ascii?Q?aT/8jT/ZAePXi5ZutLyMbhTzbm/aM6eCpqIUOzjIQb4xe7FxCMgKzdZqehAS?=
 =?us-ascii?Q?C4h9LKHCLvNYJGHXSDUXE3f6D9bkT/hMtbD+CFIaBYm9wf2+M8hGDJDpcZ+O?=
 =?us-ascii?Q?8ATezDsqJr7kRxA7qYmfZ7mKzrNtfcp/nHx/0itCzjujDO/xDXrv7JhlcG4F?=
 =?us-ascii?Q?hVK/E+TOqmcp+6jR/itI921Ociz9ELhU+IpHtRmHyhk9Hiww5II+tlOI3z2N?=
 =?us-ascii?Q?m1iJBboJCHRVzuEklpx+F5JFSxedF7A06rNZ68qAbstlc3ZZrl/0GsteT97r?=
 =?us-ascii?Q?UWEOGwjEXZr6Ww2I4wIrmOOTHg6cFMBr5yK9eD5dmXCK9sl36A3dBxeADE3J?=
 =?us-ascii?Q?8lmj3QoYTr1nIaZ4+I5RO/LumfCWgCmsg+hx2H/ESv8WpclGL6x/NfgELppg?=
 =?us-ascii?Q?6cY8J/N9qO6ubUYxBFXnzy0ULsCvmHAkuTODXvieiW1Am6CkelU5EXkq6rGy?=
 =?us-ascii?Q?wFLbZe0dR0QZRY72BNx5d8tk7sgtejIXeU/w0qNk1zmLDGyfh2Y7BO3gUFrW?=
 =?us-ascii?Q?lXZc2XcqLg//KlKeFNPeNkazXGDN4tCyqVq3ilv2WphIDjt5+O67aVA/I+E9?=
 =?us-ascii?Q?TQACT1/ot2KPq3JOc5Xk2t4xOAtcWIvWesN430GZ/ZXelFNgXsB1WwLpblJz?=
 =?us-ascii?Q?w0MRMVkhvnv0peg7epWYfwt2j8xYjmcc/ZBEhiILRars85h4qFDsPMl5/DAn?=
 =?us-ascii?Q?c6tgQURchGl7h8CdaPLlyXdwRlBQXbNyTzViyQEiJMr0/m+wtkR4qpaheWLL?=
 =?us-ascii?Q?Eu217Cww3kRo+hyndaMvKMzPEqn7FnwgdCi567jDbXyGWC5thuUnVz6mNSfX?=
 =?us-ascii?Q?tnk191PQpE6UF+vWF4HXq3F5kaJng4KE8Zmpt/VXbLguNE1lwKd7OFDVk9c4?=
 =?us-ascii?Q?ZQNeeIKQU7J9L/ztZHCcxbx1U+23JdhswG/Ad27dWWXhR9bWK0ugqys+rIWk?=
 =?us-ascii?Q?2tAmq6VM2mCFqHrLYc5sUSrGhA5feYxeuB0YHBOBVKKlpi5VBVLL1OdXVLzj?=
 =?us-ascii?Q?QCvlKA2ifxujWfFRlnZbeQtlJuFipk9PqhOCSABRpn8lUEiAtwRv5TRwhT5k?=
 =?us-ascii?Q?ycCOVYHOPtSpg0znsSl2cFNZ6piqC+tE+M470zE4Nqb73cxMkZ2rRLD+q3Nw?=
 =?us-ascii?Q?wW787reBOCx2gwrl1V1Shm0NOeLIMethtXzOW8uqGv9/5vFfW3AFEfnXdmIk?=
 =?us-ascii?Q?l+31NQxHbSvuMOoRIdcw6yhprzUanib8EHhTibvGWhWSt9rRHR3FCNkQxwiX?=
 =?us-ascii?Q?4oOguAmJlaRj3Ihz+P/qdb+B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bfb435-763b-4251-48a3-08d94b95356f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:07.3021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJOLjcGDXMeVoxAnRRsWSNfOMBHkt3wWTA1dI5gOtfhdMZr2jz2aGE4J2EYQMbvUWKUEPbTevSa2BVwGeyML0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add ip offset definition for cyan_skillfish and initialize it.

v2: squash in ip_offset updates (Alex)

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 .../drm/amd/amdgpu/cyan_skillfish_reg_init.c  |  51 ++
 drivers/gpu/drm/amd/amdgpu/nv.c               |   3 +
 drivers/gpu/drm/amd/amdgpu/nv.h               |   1 +
 .../amd/include/cyan_skillfish_ip_offset.h    | 714 ++++++++++++++++++
 5 files changed, 770 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 7d292485ca7c..aa5ca7e227e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -76,7 +76,7 @@ amdgpu-y += \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
 	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o \
 	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o \
-	beige_goby_reg_init.o yellow_carp_reg_init.o
+	beige_goby_reg_init.o yellow_carp_reg_init.o cyan_skillfish_reg_init.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c b/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
new file mode 100644
index 000000000000..58808814d8fb
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
@@ -0,0 +1,51 @@
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
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
+#include "cyan_skillfish_ip_offset.h"
+
+int cyan_skillfish_reg_base_init(struct amdgpu_device *adev)
+{
+	/* HW has more IP blocks,  only initialized the blocke needed by driver */
+	uint32_t i;
+	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
+		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
+		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
+		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
+		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
+		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
+		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
+		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(UVD0_BASE.instance[i]));
+		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
+		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DMU_BASE.instance[i]));
+		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
+		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SDMA1_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
+	}
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 94a2c0742ee5..76692106a144 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -817,6 +817,9 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 	case CHIP_YELLOW_CARP:
 		yellow_carp_reg_base_init(adev);
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		cyan_skillfish_reg_base_init(adev);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index eb9aff1e7253..1f40ba3b0460 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -38,5 +38,6 @@ void vangogh_reg_base_init(struct amdgpu_device *adev);
 int dimgrey_cavefish_reg_base_init(struct amdgpu_device *adev);
 int beige_goby_reg_base_init(struct amdgpu_device *adev);
 int yellow_carp_reg_base_init(struct amdgpu_device *adev);
+int cyan_skillfish_reg_base_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h b/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h
new file mode 100644
index 000000000000..9cb5f3631c60
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/cyan_skillfish_ip_offset.h
@@ -0,0 +1,714 @@
+/*
+ * Copyright (C) 2018  Advanced Micro Devices, Inc.
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
+#ifndef _cyan_skillfish_ip_offset_HEADER
+#define _cyan_skillfish_ip_offset_HEADER
+
+#define MAX_INSTANCE                                       6
+#define MAX_SEGMENT                                        5
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
+static const struct IP_BASE ATHUB_BASE            ={ { { { 0x00000C00, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE CLK_BASE            ={ { { { 0x00016C00, 0, 0, 0, 0 } },
+                                        { { 0x00016E00, 0, 0, 0, 0 } },
+                                        { { 0x00017000, 0, 0, 0, 0 } },
+                                        { { 0x00017200, 0, 0, 0, 0 } },
+                                        { { 0x00017E00, 0, 0, 0, 0 } },
+                                        { { 0x0001B000, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DF_BASE            ={ { { { 0x00007000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DMU_BASE            ={ { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE FUSE_BASE            ={ { { { 0x00017400, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE GC_BASE            ={ { { { 0x00001260, 0x0000A000, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE HDP_BASE            ={ { { { 0x00000F20, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MMHUB_BASE            ={ { { { 0x0001A000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MP0_BASE            ={ { { { 0x00016000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MP1_BASE            ={ { { { 0x00016000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE NBIO_BASE            ={ { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE OSSSYS_BASE            ={ { { { 0x000010A0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SMUIO_BASE            ={ { { { 0x00016800, 0x00016A00, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE THM_BASE            ={ { { { 0x00016600, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE UMC0_BASE            ={ { { { 0x00014000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE UVD0_BASE            ={ { { { 0x00007800, 0x00007E00, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } },
+					{ { 0, 0, 0, 0, 0 } } } };
+
+
+#define ATHUB_BASE__INST0_SEG0                     0x00000C00
+#define ATHUB_BASE__INST0_SEG1                     0
+#define ATHUB_BASE__INST0_SEG2                     0
+#define ATHUB_BASE__INST0_SEG3                     0
+#define ATHUB_BASE__INST0_SEG4                     0
+
+#define ATHUB_BASE__INST1_SEG0                     0
+#define ATHUB_BASE__INST1_SEG1                     0
+#define ATHUB_BASE__INST1_SEG2                     0
+#define ATHUB_BASE__INST1_SEG3                     0
+#define ATHUB_BASE__INST1_SEG4                     0
+
+#define ATHUB_BASE__INST2_SEG0                     0
+#define ATHUB_BASE__INST2_SEG1                     0
+#define ATHUB_BASE__INST2_SEG2                     0
+#define ATHUB_BASE__INST2_SEG3                     0
+#define ATHUB_BASE__INST2_SEG4                     0
+
+#define ATHUB_BASE__INST3_SEG0                     0
+#define ATHUB_BASE__INST3_SEG1                     0
+#define ATHUB_BASE__INST3_SEG2                     0
+#define ATHUB_BASE__INST3_SEG3                     0
+#define ATHUB_BASE__INST3_SEG4                     0
+
+#define ATHUB_BASE__INST4_SEG0                     0
+#define ATHUB_BASE__INST4_SEG1                     0
+#define ATHUB_BASE__INST4_SEG2                     0
+#define ATHUB_BASE__INST4_SEG3                     0
+#define ATHUB_BASE__INST4_SEG4                     0
+
+#define ATHUB_BASE__INST5_SEG0                     0
+#define ATHUB_BASE__INST5_SEG1                     0
+#define ATHUB_BASE__INST5_SEG2                     0
+#define ATHUB_BASE__INST5_SEG3                     0
+#define ATHUB_BASE__INST5_SEG4                     0
+
+#define CLK_BASE__INST0_SEG0                       0x00016C00
+#define CLK_BASE__INST0_SEG1                       0
+#define CLK_BASE__INST0_SEG2                       0
+#define CLK_BASE__INST0_SEG3                       0
+#define CLK_BASE__INST0_SEG4                       0
+
+#define CLK_BASE__INST1_SEG0                       0x00016E00
+#define CLK_BASE__INST1_SEG1                       0
+#define CLK_BASE__INST1_SEG2                       0
+#define CLK_BASE__INST1_SEG3                       0
+#define CLK_BASE__INST1_SEG4                       0
+
+#define CLK_BASE__INST2_SEG0                       0x00017000
+#define CLK_BASE__INST2_SEG1                       0
+#define CLK_BASE__INST2_SEG2                       0
+#define CLK_BASE__INST2_SEG3                       0
+#define CLK_BASE__INST2_SEG4                       0
+
+#define CLK_BASE__INST3_SEG0                       0x00017200
+#define CLK_BASE__INST3_SEG1                       0
+#define CLK_BASE__INST3_SEG2                       0
+#define CLK_BASE__INST3_SEG3                       0
+#define CLK_BASE__INST3_SEG4                       0
+
+#define CLK_BASE__INST4_SEG0                       0x00017E00
+#define CLK_BASE__INST4_SEG1                       0
+#define CLK_BASE__INST4_SEG2                       0
+#define CLK_BASE__INST4_SEG3                       0
+#define CLK_BASE__INST4_SEG4                       0
+
+#define CLK_BASE__INST5_SEG0                       0x0001B000
+#define CLK_BASE__INST5_SEG1                       0
+#define CLK_BASE__INST5_SEG2                       0
+#define CLK_BASE__INST5_SEG3                       0
+#define CLK_BASE__INST5_SEG4                       0
+
+#define DF_BASE__INST0_SEG0                        0x00007000
+#define DF_BASE__INST0_SEG1                        0
+#define DF_BASE__INST0_SEG2                        0
+#define DF_BASE__INST0_SEG3                        0
+#define DF_BASE__INST0_SEG4                        0
+
+#define DF_BASE__INST1_SEG0                        0
+#define DF_BASE__INST1_SEG1                        0
+#define DF_BASE__INST1_SEG2                        0
+#define DF_BASE__INST1_SEG3                        0
+#define DF_BASE__INST1_SEG4                        0
+
+#define DF_BASE__INST2_SEG0                        0
+#define DF_BASE__INST2_SEG1                        0
+#define DF_BASE__INST2_SEG2                        0
+#define DF_BASE__INST2_SEG3                        0
+#define DF_BASE__INST2_SEG4                        0
+
+#define DF_BASE__INST3_SEG0                        0
+#define DF_BASE__INST3_SEG1                        0
+#define DF_BASE__INST3_SEG2                        0
+#define DF_BASE__INST3_SEG3                        0
+#define DF_BASE__INST3_SEG4                        0
+
+#define DF_BASE__INST4_SEG0                        0
+#define DF_BASE__INST4_SEG1                        0
+#define DF_BASE__INST4_SEG2                        0
+#define DF_BASE__INST4_SEG3                        0
+#define DF_BASE__INST4_SEG4                        0
+
+#define DF_BASE__INST5_SEG0                        0
+#define DF_BASE__INST5_SEG1                        0
+#define DF_BASE__INST5_SEG2                        0
+#define DF_BASE__INST5_SEG3                        0
+#define DF_BASE__INST5_SEG4                        0
+
+#define DMU_BASE__INST0_SEG0                       0x00000012
+#define DMU_BASE__INST0_SEG1                       0x000000C0
+#define DMU_BASE__INST0_SEG2                       0x000034C0
+#define DMU_BASE__INST0_SEG3                       0x00009000
+#define DMU_BASE__INST0_SEG4                       0
+
+#define DMU_BASE__INST1_SEG0                       0
+#define DMU_BASE__INST1_SEG1                       0
+#define DMU_BASE__INST1_SEG2                       0
+#define DMU_BASE__INST1_SEG3                       0
+#define DMU_BASE__INST1_SEG4                       0
+
+#define DMU_BASE__INST2_SEG0                       0
+#define DMU_BASE__INST2_SEG1                       0
+#define DMU_BASE__INST2_SEG2                       0
+#define DMU_BASE__INST2_SEG3                       0
+#define DMU_BASE__INST2_SEG4                       0
+
+#define DMU_BASE__INST3_SEG0                       0
+#define DMU_BASE__INST3_SEG1                       0
+#define DMU_BASE__INST3_SEG2                       0
+#define DMU_BASE__INST3_SEG3                       0
+#define DMU_BASE__INST3_SEG4                       0
+
+#define DMU_BASE__INST4_SEG0                       0
+#define DMU_BASE__INST4_SEG1                       0
+#define DMU_BASE__INST4_SEG2                       0
+#define DMU_BASE__INST4_SEG3                       0
+#define DMU_BASE__INST4_SEG4                       0
+
+#define DMU_BASE__INST5_SEG0                       0
+#define DMU_BASE__INST5_SEG1                       0
+#define DMU_BASE__INST5_SEG2                       0
+#define DMU_BASE__INST5_SEG3                       0
+#define DMU_BASE__INST5_SEG4                       0
+
+#define FUSE_BASE__INST0_SEG0                      0x00017400
+#define FUSE_BASE__INST0_SEG1                      0
+#define FUSE_BASE__INST0_SEG2                      0
+#define FUSE_BASE__INST0_SEG3                      0
+#define FUSE_BASE__INST0_SEG4                      0
+
+#define FUSE_BASE__INST1_SEG0                      0
+#define FUSE_BASE__INST1_SEG1                      0
+#define FUSE_BASE__INST1_SEG2                      0
+#define FUSE_BASE__INST1_SEG3                      0
+#define FUSE_BASE__INST1_SEG4                      0
+
+#define FUSE_BASE__INST2_SEG0                      0
+#define FUSE_BASE__INST2_SEG1                      0
+#define FUSE_BASE__INST2_SEG2                      0
+#define FUSE_BASE__INST2_SEG3                      0
+#define FUSE_BASE__INST2_SEG4                      0
+
+#define FUSE_BASE__INST3_SEG0                      0
+#define FUSE_BASE__INST3_SEG1                      0
+#define FUSE_BASE__INST3_SEG2                      0
+#define FUSE_BASE__INST3_SEG3                      0
+#define FUSE_BASE__INST3_SEG4                      0
+
+#define FUSE_BASE__INST4_SEG0                      0
+#define FUSE_BASE__INST4_SEG1                      0
+#define FUSE_BASE__INST4_SEG2                      0
+#define FUSE_BASE__INST4_SEG3                      0
+#define FUSE_BASE__INST4_SEG4                      0
+
+#define FUSE_BASE__INST5_SEG0                      0
+#define FUSE_BASE__INST5_SEG1                      0
+#define FUSE_BASE__INST5_SEG2                      0
+#define FUSE_BASE__INST5_SEG3                      0
+#define FUSE_BASE__INST5_SEG4                      0
+
+#define GC_BASE__INST0_SEG0                        0x00001260
+#define GC_BASE__INST0_SEG1                        0x0000A000
+#define GC_BASE__INST0_SEG2                        0
+#define GC_BASE__INST0_SEG3                        0
+#define GC_BASE__INST0_SEG4                        0
+
+#define GC_BASE__INST1_SEG0                        0
+#define GC_BASE__INST1_SEG1                        0
+#define GC_BASE__INST1_SEG2                        0
+#define GC_BASE__INST1_SEG3                        0
+#define GC_BASE__INST1_SEG4                        0
+
+#define GC_BASE__INST2_SEG0                        0
+#define GC_BASE__INST2_SEG1                        0
+#define GC_BASE__INST2_SEG2                        0
+#define GC_BASE__INST2_SEG3                        0
+#define GC_BASE__INST2_SEG4                        0
+
+#define GC_BASE__INST3_SEG0                        0
+#define GC_BASE__INST3_SEG1                        0
+#define GC_BASE__INST3_SEG2                        0
+#define GC_BASE__INST3_SEG3                        0
+#define GC_BASE__INST3_SEG4                        0
+
+#define GC_BASE__INST4_SEG0                        0
+#define GC_BASE__INST4_SEG1                        0
+#define GC_BASE__INST4_SEG2                        0
+#define GC_BASE__INST4_SEG3                        0
+#define GC_BASE__INST4_SEG4                        0
+
+#define GC_BASE__INST5_SEG0                        0
+#define GC_BASE__INST5_SEG1                        0
+#define GC_BASE__INST5_SEG2                        0
+#define GC_BASE__INST5_SEG3                        0
+#define GC_BASE__INST5_SEG4                        0
+
+#define HDP_BASE__INST0_SEG0                       0x00000F20
+#define HDP_BASE__INST0_SEG1                       0
+#define HDP_BASE__INST0_SEG2                       0
+#define HDP_BASE__INST0_SEG3                       0
+#define HDP_BASE__INST0_SEG4                       0
+
+#define HDP_BASE__INST1_SEG0                       0
+#define HDP_BASE__INST1_SEG1                       0
+#define HDP_BASE__INST1_SEG2                       0
+#define HDP_BASE__INST1_SEG3                       0
+#define HDP_BASE__INST1_SEG4                       0
+
+#define HDP_BASE__INST2_SEG0                       0
+#define HDP_BASE__INST2_SEG1                       0
+#define HDP_BASE__INST2_SEG2                       0
+#define HDP_BASE__INST2_SEG3                       0
+#define HDP_BASE__INST2_SEG4                       0
+
+#define HDP_BASE__INST3_SEG0                       0
+#define HDP_BASE__INST3_SEG1                       0
+#define HDP_BASE__INST3_SEG2                       0
+#define HDP_BASE__INST3_SEG3                       0
+#define HDP_BASE__INST3_SEG4                       0
+
+#define HDP_BASE__INST4_SEG0                       0
+#define HDP_BASE__INST4_SEG1                       0
+#define HDP_BASE__INST4_SEG2                       0
+#define HDP_BASE__INST4_SEG3                       0
+#define HDP_BASE__INST4_SEG4                       0
+
+#define HDP_BASE__INST5_SEG0                       0
+#define HDP_BASE__INST5_SEG1                       0
+#define HDP_BASE__INST5_SEG2                       0
+#define HDP_BASE__INST5_SEG3                       0
+#define HDP_BASE__INST5_SEG4                       0
+
+#define MMHUB_BASE__INST0_SEG0                     0x0001A000
+#define MMHUB_BASE__INST0_SEG1                     0
+#define MMHUB_BASE__INST0_SEG2                     0
+#define MMHUB_BASE__INST0_SEG3                     0
+#define MMHUB_BASE__INST0_SEG4                     0
+
+#define MMHUB_BASE__INST1_SEG0                     0
+#define MMHUB_BASE__INST1_SEG1                     0
+#define MMHUB_BASE__INST1_SEG2                     0
+#define MMHUB_BASE__INST1_SEG3                     0
+#define MMHUB_BASE__INST1_SEG4                     0
+
+#define MMHUB_BASE__INST2_SEG0                     0
+#define MMHUB_BASE__INST2_SEG1                     0
+#define MMHUB_BASE__INST2_SEG2                     0
+#define MMHUB_BASE__INST2_SEG3                     0
+#define MMHUB_BASE__INST2_SEG4                     0
+
+#define MMHUB_BASE__INST3_SEG0                     0
+#define MMHUB_BASE__INST3_SEG1                     0
+#define MMHUB_BASE__INST3_SEG2                     0
+#define MMHUB_BASE__INST3_SEG3                     0
+#define MMHUB_BASE__INST3_SEG4                     0
+
+#define MMHUB_BASE__INST4_SEG0                     0
+#define MMHUB_BASE__INST4_SEG1                     0
+#define MMHUB_BASE__INST4_SEG2                     0
+#define MMHUB_BASE__INST4_SEG3                     0
+#define MMHUB_BASE__INST4_SEG4                     0
+
+#define MMHUB_BASE__INST5_SEG0                     0
+#define MMHUB_BASE__INST5_SEG1                     0
+#define MMHUB_BASE__INST5_SEG2                     0
+#define MMHUB_BASE__INST5_SEG3                     0
+#define MMHUB_BASE__INST5_SEG4                     0
+
+#define MP0_BASE__INST0_SEG0                       0x00016000
+#define MP0_BASE__INST0_SEG1                       0
+#define MP0_BASE__INST0_SEG2                       0
+#define MP0_BASE__INST0_SEG3                       0
+#define MP0_BASE__INST0_SEG4                       0
+
+#define MP0_BASE__INST1_SEG0                       0
+#define MP0_BASE__INST1_SEG1                       0
+#define MP0_BASE__INST1_SEG2                       0
+#define MP0_BASE__INST1_SEG3                       0
+#define MP0_BASE__INST1_SEG4                       0
+
+#define MP0_BASE__INST2_SEG0                       0
+#define MP0_BASE__INST2_SEG1                       0
+#define MP0_BASE__INST2_SEG2                       0
+#define MP0_BASE__INST2_SEG3                       0
+#define MP0_BASE__INST2_SEG4                       0
+
+#define MP0_BASE__INST3_SEG0                       0
+#define MP0_BASE__INST3_SEG1                       0
+#define MP0_BASE__INST3_SEG2                       0
+#define MP0_BASE__INST3_SEG3                       0
+#define MP0_BASE__INST3_SEG4                       0
+
+#define MP0_BASE__INST4_SEG0                       0
+#define MP0_BASE__INST4_SEG1                       0
+#define MP0_BASE__INST4_SEG2                       0
+#define MP0_BASE__INST4_SEG3                       0
+#define MP0_BASE__INST4_SEG4                       0
+
+#define MP0_BASE__INST5_SEG0                       0
+#define MP0_BASE__INST5_SEG1                       0
+#define MP0_BASE__INST5_SEG2                       0
+#define MP0_BASE__INST5_SEG3                       0
+#define MP0_BASE__INST5_SEG4                       0
+
+#define MP1_BASE__INST0_SEG0                       0x00016000
+#define MP1_BASE__INST0_SEG1                       0
+#define MP1_BASE__INST0_SEG2                       0
+#define MP1_BASE__INST0_SEG3                       0
+#define MP1_BASE__INST0_SEG4                       0
+
+#define MP1_BASE__INST1_SEG0                       0
+#define MP1_BASE__INST1_SEG1                       0
+#define MP1_BASE__INST1_SEG2                       0
+#define MP1_BASE__INST1_SEG3                       0
+#define MP1_BASE__INST1_SEG4                       0
+
+#define MP1_BASE__INST2_SEG0                       0
+#define MP1_BASE__INST2_SEG1                       0
+#define MP1_BASE__INST2_SEG2                       0
+#define MP1_BASE__INST2_SEG3                       0
+#define MP1_BASE__INST2_SEG4                       0
+
+#define MP1_BASE__INST3_SEG0                       0
+#define MP1_BASE__INST3_SEG1                       0
+#define MP1_BASE__INST3_SEG2                       0
+#define MP1_BASE__INST3_SEG3                       0
+#define MP1_BASE__INST3_SEG4                       0
+
+#define MP1_BASE__INST4_SEG0                       0
+#define MP1_BASE__INST4_SEG1                       0
+#define MP1_BASE__INST4_SEG2                       0
+#define MP1_BASE__INST4_SEG3                       0
+#define MP1_BASE__INST4_SEG4                       0
+
+#define MP1_BASE__INST5_SEG0                       0
+#define MP1_BASE__INST5_SEG1                       0
+#define MP1_BASE__INST5_SEG2                       0
+#define MP1_BASE__INST5_SEG3                       0
+#define MP1_BASE__INST5_SEG4                       0
+
+#define NBIO_BASE__INST0_SEG0                     0x00000000
+#define NBIO_BASE__INST0_SEG1                     0x00000014
+#define NBIO_BASE__INST0_SEG2                     0x00000D20
+#define NBIO_BASE__INST0_SEG3                     0x00010400
+#define NBIO_BASE__INST0_SEG4                     0
+
+#define NBIO_BASE__INST1_SEG0                     0
+#define NBIO_BASE__INST1_SEG1                     0
+#define NBIO_BASE__INST1_SEG2                     0
+#define NBIO_BASE__INST1_SEG3                     0
+#define NBIO_BASE__INST1_SEG4                     0
+
+#define NBIO_BASE__INST2_SEG0                     0
+#define NBIO_BASE__INST2_SEG1                     0
+#define NBIO_BASE__INST2_SEG2                     0
+#define NBIO_BASE__INST2_SEG3                     0
+#define NBIO_BASE__INST2_SEG4                     0
+
+#define NBIO_BASE__INST3_SEG0                     0
+#define NBIO_BASE__INST3_SEG1                     0
+#define NBIO_BASE__INST3_SEG2                     0
+#define NBIO_BASE__INST3_SEG3                     0
+#define NBIO_BASE__INST3_SEG4                     0
+
+#define NBIO_BASE__INST4_SEG0                     0
+#define NBIO_BASE__INST4_SEG1                     0
+#define NBIO_BASE__INST4_SEG2                     0
+#define NBIO_BASE__INST4_SEG3                     0
+#define NBIO_BASE__INST4_SEG4                     0
+
+#define NBIO_BASE__INST5_SEG0                     0
+#define NBIO_BASE__INST5_SEG1                     0
+#define NBIO_BASE__INST5_SEG2                     0
+#define NBIO_BASE__INST5_SEG3                     0
+#define NBIO_BASE__INST5_SEG4                     0
+
+#define OSSSYS_BASE__INST0_SEG0                    0x000010A0
+#define OSSSYS_BASE__INST0_SEG1                    0
+#define OSSSYS_BASE__INST0_SEG2                    0
+#define OSSSYS_BASE__INST0_SEG3                    0
+#define OSSSYS_BASE__INST0_SEG4                    0
+
+#define OSSSYS_BASE__INST1_SEG0                    0
+#define OSSSYS_BASE__INST1_SEG1                    0
+#define OSSSYS_BASE__INST1_SEG2                    0
+#define OSSSYS_BASE__INST1_SEG3                    0
+#define OSSSYS_BASE__INST1_SEG4                    0
+
+#define OSSSYS_BASE__INST2_SEG0                    0
+#define OSSSYS_BASE__INST2_SEG1                    0
+#define OSSSYS_BASE__INST2_SEG2                    0
+#define OSSSYS_BASE__INST2_SEG3                    0
+#define OSSSYS_BASE__INST2_SEG4                    0
+
+#define OSSSYS_BASE__INST3_SEG0                    0
+#define OSSSYS_BASE__INST3_SEG1                    0
+#define OSSSYS_BASE__INST3_SEG2                    0
+#define OSSSYS_BASE__INST3_SEG3                    0
+#define OSSSYS_BASE__INST3_SEG4                    0
+
+#define OSSSYS_BASE__INST4_SEG0                    0
+#define OSSSYS_BASE__INST4_SEG1                    0
+#define OSSSYS_BASE__INST4_SEG2                    0
+#define OSSSYS_BASE__INST4_SEG3                    0
+#define OSSSYS_BASE__INST4_SEG4                    0
+
+#define OSSSYS_BASE__INST5_SEG0                    0
+#define OSSSYS_BASE__INST5_SEG1                    0
+#define OSSSYS_BASE__INST5_SEG2                    0
+#define OSSSYS_BASE__INST5_SEG3                    0
+#define OSSSYS_BASE__INST5_SEG4                    0
+
+#define SMUIO_BASE__INST0_SEG0                     0x00016800
+#define SMUIO_BASE__INST0_SEG1                     0x00016A00
+#define SMUIO_BASE__INST0_SEG2                     0
+#define SMUIO_BASE__INST0_SEG3                     0
+#define SMUIO_BASE__INST0_SEG4                     0
+
+#define SMUIO_BASE__INST1_SEG0                     0
+#define SMUIO_BASE__INST1_SEG1                     0
+#define SMUIO_BASE__INST1_SEG2                     0
+#define SMUIO_BASE__INST1_SEG3                     0
+#define SMUIO_BASE__INST1_SEG4                     0
+
+#define SMUIO_BASE__INST2_SEG0                     0
+#define SMUIO_BASE__INST2_SEG1                     0
+#define SMUIO_BASE__INST2_SEG2                     0
+#define SMUIO_BASE__INST2_SEG3                     0
+#define SMUIO_BASE__INST2_SEG4                     0
+
+#define SMUIO_BASE__INST3_SEG0                     0
+#define SMUIO_BASE__INST3_SEG1                     0
+#define SMUIO_BASE__INST3_SEG2                     0
+#define SMUIO_BASE__INST3_SEG3                     0
+#define SMUIO_BASE__INST3_SEG4                     0
+
+#define SMUIO_BASE__INST4_SEG0                     0
+#define SMUIO_BASE__INST4_SEG1                     0
+#define SMUIO_BASE__INST4_SEG2                     0
+#define SMUIO_BASE__INST4_SEG3                     0
+#define SMUIO_BASE__INST4_SEG4                     0
+
+#define SMUIO_BASE__INST5_SEG0                     0
+#define SMUIO_BASE__INST5_SEG1                     0
+#define SMUIO_BASE__INST5_SEG2                     0
+#define SMUIO_BASE__INST5_SEG3                     0
+#define SMUIO_BASE__INST5_SEG4                     0
+
+#define THM_BASE__INST0_SEG0                       0x00016600
+#define THM_BASE__INST0_SEG1                       0
+#define THM_BASE__INST0_SEG2                       0
+#define THM_BASE__INST0_SEG3                       0
+#define THM_BASE__INST0_SEG4                       0
+
+#define THM_BASE__INST1_SEG0                       0
+#define THM_BASE__INST1_SEG1                       0
+#define THM_BASE__INST1_SEG2                       0
+#define THM_BASE__INST1_SEG3                       0
+#define THM_BASE__INST1_SEG4                       0
+
+#define THM_BASE__INST2_SEG0                       0
+#define THM_BASE__INST2_SEG1                       0
+#define THM_BASE__INST2_SEG2                       0
+#define THM_BASE__INST2_SEG3                       0
+#define THM_BASE__INST2_SEG4                       0
+
+#define THM_BASE__INST3_SEG0                       0
+#define THM_BASE__INST3_SEG1                       0
+#define THM_BASE__INST3_SEG2                       0
+#define THM_BASE__INST3_SEG3                       0
+#define THM_BASE__INST3_SEG4                       0
+
+#define THM_BASE__INST4_SEG0                       0
+#define THM_BASE__INST4_SEG1                       0
+#define THM_BASE__INST4_SEG2                       0
+#define THM_BASE__INST4_SEG3                       0
+#define THM_BASE__INST4_SEG4                       0
+
+#define THM_BASE__INST5_SEG0                       0
+#define THM_BASE__INST5_SEG1                       0
+#define THM_BASE__INST5_SEG2                       0
+#define THM_BASE__INST5_SEG3                       0
+#define THM_BASE__INST5_SEG4                       0
+
+#define UMC0_BASE__INST0_SEG0                      0x00014000
+#define UMC0_BASE__INST0_SEG1                      0
+#define UMC0_BASE__INST0_SEG2                      0
+#define UMC0_BASE__INST0_SEG3                      0
+#define UMC0_BASE__INST0_SEG4                      0
+
+#define UMC0_BASE__INST1_SEG0                      0
+#define UMC0_BASE__INST1_SEG1                      0
+#define UMC0_BASE__INST1_SEG2                      0
+#define UMC0_BASE__INST1_SEG3                      0
+#define UMC0_BASE__INST1_SEG4                      0
+
+#define UMC0_BASE__INST2_SEG0                      0
+#define UMC0_BASE__INST2_SEG1                      0
+#define UMC0_BASE__INST2_SEG2                      0
+#define UMC0_BASE__INST2_SEG3                      0
+#define UMC0_BASE__INST2_SEG4                      0
+
+#define UMC0_BASE__INST3_SEG0                      0
+#define UMC0_BASE__INST3_SEG1                      0
+#define UMC0_BASE__INST3_SEG2                      0
+#define UMC0_BASE__INST3_SEG3                      0
+#define UMC0_BASE__INST3_SEG4                      0
+
+#define UMC0_BASE__INST4_SEG0                      0
+#define UMC0_BASE__INST4_SEG1                      0
+#define UMC0_BASE__INST4_SEG2                      0
+#define UMC0_BASE__INST4_SEG3                      0
+#define UMC0_BASE__INST4_SEG4                      0
+
+#define UMC0_BASE__INST5_SEG0                      0
+#define UMC0_BASE__INST5_SEG1                      0
+#define UMC0_BASE__INST5_SEG2                      0
+#define UMC0_BASE__INST5_SEG3                      0
+#define UMC0_BASE__INST5_SEG4                      0
+
+#define UVD0_BASE__INST0_SEG0                      0x00007800
+#define UVD0_BASE__INST0_SEG1                      0x00007E00
+#define UVD0_BASE__INST0_SEG2                      0
+#define UVD0_BASE__INST0_SEG3                      0
+#define UVD0_BASE__INST0_SEG4                      0
+
+#define UVD0_BASE__INST1_SEG0                      0
+#define UVD0_BASE__INST1_SEG1                      0
+#define UVD0_BASE__INST1_SEG2                      0
+#define UVD0_BASE__INST1_SEG3                      0
+#define UVD0_BASE__INST1_SEG4                      0
+
+#define UVD0_BASE__INST2_SEG0                      0
+#define UVD0_BASE__INST2_SEG1                      0
+#define UVD0_BASE__INST2_SEG2                      0
+#define UVD0_BASE__INST2_SEG3                      0
+#define UVD0_BASE__INST2_SEG4                      0
+
+#define UVD0_BASE__INST3_SEG0                      0
+#define UVD0_BASE__INST3_SEG1                      0
+#define UVD0_BASE__INST3_SEG2                      0
+#define UVD0_BASE__INST3_SEG3                      0
+#define UVD0_BASE__INST3_SEG4                      0
+
+#define UVD0_BASE__INST4_SEG0                      0
+#define UVD0_BASE__INST4_SEG1                      0
+#define UVD0_BASE__INST4_SEG2                      0
+#define UVD0_BASE__INST4_SEG3                      0
+#define UVD0_BASE__INST4_SEG4                      0
+
+#define UVD0_BASE__INST5_SEG0                      0
+#define UVD0_BASE__INST5_SEG1                      0
+#define UVD0_BASE__INST5_SEG2                      0
+#define UVD0_BASE__INST5_SEG3                      0
+#define UVD0_BASE__INST5_SEG4                      0
+
+#endif
+
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
