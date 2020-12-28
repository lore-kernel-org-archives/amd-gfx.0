Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC834C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 07:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B72207D1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 07:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B72207D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E43A898F0;
	Mon, 28 Dec 2020 07:03:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1296898F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 07:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRwZbenxvjez84VmO9XNBPrhR+3sYojGMyZSYPT5LLJxgY3JY7+8fi0R8PGOJkO1SS6royclPq/pt90EdwfbHuVl2FhIQFhTYgElfgzNpwqSklBkGoi4DeBiWPJ3O598qU3AGcs9OwHS9gNIeM6ghJ6TVR1SLXuQQZXO0y+elRVe2mdOyffQQNFfQyBVU7sujwS3raY5jqWWX1780EImviszFaHJCr/1ivYW7vnvt8aEV3fEf2cOSjgHN6HDoXBPeyYyhDmnsQvkD62nDpnqyi7xHvcqRAOywx/bG4Sqh6cuBeZsGJ7JKenoomoeNekmgXnKk65E2zi7MKktOUfIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSuGthVw3j07R7XAxnIJM6eTX6pFmZBshnTDsLI8uS0=;
 b=R9XE4E22Cd3sFcg3M/55PZ9oPJRee5UPZfiwpBoLCIl1FJQJxbzCOLdazar6vLdUcSJM5TuXBnTJnItuX0zDFKuUkkZ6aI0jzmb8lIpgsafdX56qtVb3Fvc6zs4SQ7HNWwOyM+ml5ke1MeYr32H/Sx3CHtkQN7uKSU5FwlXXDt90JDnC9qYyqbvTB2IkhjZvYeuidVNoJwAzq25/Pw242CGcu+GoUZXciSEiBNbd8TQvuSS9qfPUCoTqWxLQFsQa76D67eBgE7xRfGDeLY8mV+nPryr6FUAmb0ZPg6WDN+xqjoPv61JVBRy0Wx41ZbydG7SIR64JiFiXho0JTHdmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSuGthVw3j07R7XAxnIJM6eTX6pFmZBshnTDsLI8uS0=;
 b=PxeCWijvDD6M+UdX+q357lwfGVYDb6W7d3UH/qYdXctn4JTd4Wa0B/j/Evduj9NIn8+KhP9p7TvpK70Q0+P4iyk5mvs6r6cmcU2lQ1/OmzgDhY81JMsc0hL1z/NaYISlRgoxEvEVRfnJYbqHBXObMx9E/C8L9m05dAYwepEgJLg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB2542.namprd12.prod.outlook.com (2603:10b6:300:e8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Mon, 28 Dec
 2020 07:03:07 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3700.031; Mon, 28 Dec
 2020 07:03:06 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: unfiy hdp function into hdp structure
Date: Mon, 28 Dec 2020 15:02:48 +0800
Message-Id: <20201228070248.2867202-2-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201228070248.2867202-1-likun.gao@amd.com>
References: <20201228070248.2867202-1-likun.gao@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:d0::11) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HKAPR04CA0001.apcprd04.prod.outlook.com (2603:1096:203:d0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.27 via Frontend Transport; Mon, 28 Dec 2020 07:03:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91487817-f5b6-4946-5d24-08d8aafea0d5
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2542DA24D839ABCAC8357DD7EFD90@MWHPR1201MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QkH2EJH2r45JOjwJzIz4UMpv0GKWvsIfq92zqJVN46RHecFaYRPYsK9mSsk4hBuS4nmytineCKzIwhl6CX2Rod2IpptMY0jk6QLN/wbQ5FFb93SJzO7wMHmZV113wVBjU1hRE2oAKZC3B2PMzcXiZfqdYU+CSTT7UQWLY9HwmuEfmPKWV0M5OEb2XO8ogUjso6ALBaOO9gpcMHloDUBsTDptO/TAqk+zoghB+Jh0zNnOplCuZp2J+7yUv+JztqeLIs0MoHX5KIRTn19qb6mct3o/uDBFtRzP+ti9RcEt8c5l2CMCW9LtOqqjOiPgXcYsKBVvXGawRLH9nxfFNUbXCcBhf3ECbTkBujC8JgtSw+LGHUwsCGjeIZtKm3p5klbhTP0gy0JeRRJ34llwSvhiyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(6666004)(5660300002)(6916009)(4326008)(186003)(54906003)(83380400001)(36756003)(2906002)(66946007)(86362001)(2616005)(52116002)(66476007)(44832011)(956004)(6486002)(7696005)(66556008)(16526019)(8676002)(478600001)(8936002)(1076003)(30864003)(26005)(316002)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n/lCAbWksLWvfjqnru4oqf5o1FAA0zETeZsaspNQUASSsi1zhBXmVfp/w63k?=
 =?us-ascii?Q?GjoJuFBBuC1GxPbQuED3V6zzS61K5wdMLGn+EkC5QbgI5kZnlz6vkL4+8LgA?=
 =?us-ascii?Q?prwfEvbdppJkz95xHvbE17pvcsRJgYP/dwU3yKpUNRHDPKGk1f2dMghgdx4f?=
 =?us-ascii?Q?P3e5fUfERnpeSMlWVkfZIz4aTpiRjOs0g5F+qPzpZTCHUqUrcm6nOTRprrqz?=
 =?us-ascii?Q?6bEaRqeIWDTEy/bxKsyCfhf9Qe0c6ZTwxk45DV/HdTx609qI1eVzOzBBcV9Q?=
 =?us-ascii?Q?rkg2acimluScQl1jPCkSLkgVarZnAuOD04l+oHvd+Tb9F50VTJLmDOqQxsgr?=
 =?us-ascii?Q?cY2EP9vf2SeDZe+Alrq2LtdBvZq2NT575WTwAlahchSAlk53h4rI99VApqSp?=
 =?us-ascii?Q?BW09qsljWprnhRi3O1xihMRyuWmBexfINi9Ip86yA/ZSjqmu2HsfIKmnlrKh?=
 =?us-ascii?Q?y9UoSvebqp2T6gJ/HRZxPrw43GH++jOQ1aSLRZVprQuz/rmpdEqoc25Dnpk9?=
 =?us-ascii?Q?nD51ktmym2ss099N5fwjJez1oybdn6tk7aD2AMaJMQXGZuHVJDnN24T+QrEm?=
 =?us-ascii?Q?RtWhdv6xR903ETEY8tyaKXsrnkRsBN+GmCYIxOCu8cz/R9NAJxPDi/30GmOP?=
 =?us-ascii?Q?frS4k+o1gWN3uBTQT2fQRycKJ0H3HUmcEFq5mrxogUT+FeoExY2Oa2Bd6NS4?=
 =?us-ascii?Q?igzmQXb88/Xxk0cwTkMZpYx/dJITHsREI18nVgUudcE5rWQg5B5PtCBBaNMn?=
 =?us-ascii?Q?fu+XBEd9KuOsMZdgdnsJYQz9dYeJn+xvr7LJjsmalYdeKGeP+OyFXMkg//vx?=
 =?us-ascii?Q?+x2Pul3e4Dl9IDzipCi6TZTYOOVqnIPVI3CcSGoJehim+Bc41MOKHrIdUxcY?=
 =?us-ascii?Q?9TUtCmNBMkSoqg147kRkie6JQhKiu3IUZxjyd5W2E7Hqb6ysK1I1A/zuMKO0?=
 =?us-ascii?Q?1cTWpWNr9Afl8cJ7ecbtGiDAixIhzCJkL6esbKPw02ZuRN7BjracGKfDvMa8?=
 =?us-ascii?Q?ec6U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 07:03:06.8648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 91487817-f5b6-4946-5d24-08d8aafea0d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeOCeYrzwHa0rD7W/GfZl6Sq3irEIhcCLKi9QpMOkfq8m6Lrr6z4OfEqRmHliObh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2542
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Separtate HDP related function into hdp structure.
Remove redundant operation related HDP.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I1549ae2a7860c3b845897e99b3c2351da277bc8c
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |   1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |   9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |   1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  14 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  21 +--
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c    | 150 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h    |  31 ++++
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c    | 212 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h    |  31 ++++
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c   |  10 --
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c   |  13 --
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c   |  10 --
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c   |  10 --
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   |  10 --
 drivers/gpu/drm/amd/amdgpu/nv.c          | 151 +---------------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |   1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |   1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c       |  71 +-------
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |   1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |   1 -
 23 files changed, 451 insertions(+), 303 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c6262689e14e..2b379fd12b44 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -71,7 +71,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
 	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o \
-	nbio_v7_2.o dimgrey_cavefish_reg_init.o
+	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v5_0.o hdp_v4_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 92e9d1f1207b..ec91f5e32b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -89,6 +89,7 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_sdma.h"
 #include "amdgpu_nbio.h"
+#include "amdgpu_hdp.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_csa.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index e62cc0e1a5ad..4ba0024aedf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -57,7 +57,6 @@ struct amdgpu_nbio_funcs {
 	u32 (*get_pcie_port_data_offset)(struct amdgpu_device *adev);
 	u32 (*get_rev_id)(struct amdgpu_device *adev);
 	void (*mc_access_enable)(struct amdgpu_device *adev, bool enable);
-	void (*hdp_flush)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 	u32 (*get_memsize)(struct amdgpu_device *adev);
 	void (*sdma_doorbell_range)(struct amdgpu_device *adev, int instance,
 			bool use_doorbell, int doorbell_index, int doorbell_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ba1086784525..10aae0abcffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -38,7 +38,6 @@
 #include "smuio/smuio_11_0_0_offset.h"
 #include "smuio/smuio_11_0_0_sh_mask.h"
 #include "navi10_enum.h"
-#include "hdp/hdp_5_0_0_offset.h"
 #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
 
 #include "soc15.h"
@@ -5691,7 +5690,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_PFP_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0);
@@ -5769,7 +5768,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CE_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CE_IC_BASE_CNTL, VMID, 0);
@@ -5846,7 +5845,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_ME_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0);
@@ -6215,7 +6214,7 @@ static int gfx_v10_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CPC_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5f4805e4d04a..a896e3d0fcf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -38,7 +38,6 @@
 #include "gc/gc_9_0_sh_mask.h"
 
 #include "vega10_enum.h"
-#include "hdp/hdp_4_0_offset.h"
 
 #include "soc15_common.h"
 #include "clearstate_gfx9.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5648c48be77f..3b7c6c31fce1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -27,8 +27,6 @@
 #include "gmc_v10_0.h"
 #include "umc_v8_7.h"
 
-#include "hdp/hdp_5_0_0_offset.h"
-#include "hdp/hdp_5_0_0_sh_mask.h"
 #include "athub/athub_2_0_0_sh_mask.h"
 #include "athub/athub_2_0_0_offset.h"
 #include "dcn/dcn_2_0_0_offset.h"
@@ -312,7 +310,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	int r;
 
 	/* flush hdp cache */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	/* For SRIOV run time, driver shouldn't access the register through MMIO
 	 * Directly use kiq to do the vm invalidation instead
@@ -995,7 +993,6 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 {
 	int r;
 	bool value;
-	u32 tmp;
 
 	if (adev->gart.bo == NULL) {
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
@@ -1014,15 +1011,10 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL);
-	tmp |= HDP_MISC_CNTL__FLUSH_INVALIDATE_CACHE_MASK;
-	WREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL, tmp);
-
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL);
-	WREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL, tmp);
+	adev->hdp.funcs->init_registers(adev);
 
 	/* Flush HDP after it is initialized */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e22268f9dba7..7b1f50fa9dac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -31,8 +31,6 @@
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_gem.h"
 
-#include "hdp/hdp_4_0_offset.h"
-#include "hdp/hdp_4_0_sh_mask.h"
 #include "gc/gc_9_0_sh_mask.h"
 #include "dce/dce_12_0_offset.h"
 #include "dce/dce_12_0_sh_mask.h"
@@ -1571,7 +1569,6 @@ static int gmc_v9_0_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool value;
 	int r, i;
-	u32 tmp;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v9_0_init_golden_registers(adev);
@@ -1590,24 +1587,10 @@ static int gmc_v9_0_hw_init(void *handle)
 	if (adev->mmhub.funcs->update_power_gating)
 		adev->mmhub.funcs->update_power_gating(adev, true);
 
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
-		WREG32_FIELD15(HDP, 0, HDP_MMHUB_CNTL, HDP_MMHUB_GCC, 1);
-		break;
-	default:
-		break;
-	}
-
-	WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);
-
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL);
-	WREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL, tmp);
-
-	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> 8));
-	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_start >> 40));
+	adev->hdp.funcs->init_registers(adev);
 
 	/* After HDP is initialized, flush HDP.*/
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS)
 		value = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
new file mode 100644
index 000000000000..58cf0670d8af
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -0,0 +1,150 @@
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
+#include "amdgpu_atombios.h"
+#include "hdp_v4_0.h"
+#include "amdgpu_ras.h"
+
+#include "hdp/hdp_4_0_offset.h"
+#include "hdp/hdp_4_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+#define mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL               0x00f7
+#define mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_BASE_IDX      2
+/* for Vega20 register name change */
+#define mmHDP_MEM_POWER_CTRL    0x00d4
+#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK  0x00000001L
+#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK    0x00000002L
+#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK   0x00010000L
+#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK             0x00020000L
+#define mmHDP_MEM_POWER_CTRL_BASE_IDX   0
+
+static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	uint32_t reg_addr;
+
+	if (adev->flags & AMD_IS_APU ||
+	    adev->asic_type == CHIP_VEGA20 ||
+	    adev->asic_type == CHIP_ARCTURUS)
+		reg_addr = (adev->rmmio_remap.reg_offset +
+			    KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2;
+	else
+		reg_addr = SOC15_REG_OFFSET(NBIO, 0,
+				mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL);
+
+	if (!ring || !ring->funcs->emit_wreg)
+		WREG32_NO_KIQ(reg_addr, 0);
+	else
+		amdgpu_ring_emit_wreg(ring, reg_addr, 0);
+}
+
+static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
+				    struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg)
+		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
+	else
+		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
+			HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
+}
+
+static void hdp_v4_0_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
+		return;
+	/*read back hdp ras counter to reset it to 0 */
+	RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
+}
+
+static void hdp_v4_0_update_clock_gating(struct amdgpu_device *adev,
+					 bool enable)
+{
+	uint32_t def, data;
+
+	if (adev->asic_type == CHIP_VEGA20 ||
+	    adev->asic_type == CHIP_ARCTURUS ||
+	    adev->asic_type == CHIP_RENOIR) {
+		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_CTRL));
+
+		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
+			data |= HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
+				HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
+				HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
+				HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK;
+		else
+			data &= ~(HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
+				  HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
+				  HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
+				  HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK);
+
+		if (def != data)
+			WREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_CTRL), data);
+	} else {
+		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
+
+		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
+			data |= HDP_MEM_POWER_LS__LS_ENABLE_MASK;
+		else
+			data &= ~HDP_MEM_POWER_LS__LS_ENABLE_MASK;
+
+		if (def != data)
+			WREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS), data);
+	}
+}
+
+static void hdp_v4_0_get_clockgating_state(struct amdgpu_device *adev,
+					    u32 *flags)
+{
+	int data;
+
+	/* AMD_CG_SUPPORT_HDP_LS */
+	data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
+	if (data & HDP_MEM_POWER_LS__LS_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_LS;
+}
+
+static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
+{
+	switch (adev->asic_type) {
+	case CHIP_ARCTURUS:
+		WREG32_FIELD15(HDP, 0, HDP_MMHUB_CNTL, HDP_MMHUB_GCC, 1);
+		break;
+	default:
+		break;
+	}
+
+	WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);
+
+	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> 8));
+	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_start >> 40));
+}
+
+const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
+	.flush_hdp = hdp_v4_0_flush_hdp,
+	.invalidate_hdp = hdp_v4_0_invalidate_hdp,
+	.reset_ras_error_count = hdp_v4_0_reset_ras_error_count,
+	.update_clock_gating = hdp_v4_0_update_clock_gating,
+	.get_clock_gating_state = hdp_v4_0_get_clockgating_state,
+	.init_registers = hdp_v4_0_init_registers,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
new file mode 100644
index 000000000000..d1e6399e8c46
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
@@ -0,0 +1,31 @@
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
+#ifndef __HDP_V4_0_H__
+#define __HDP_V4_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_hdp_funcs hdp_v4_0_funcs;
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
new file mode 100644
index 000000000000..7a15e669b68d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -0,0 +1,212 @@
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
+#include "amdgpu_atombios.h"
+#include "hdp_v5_0.h"
+
+#include "hdp/hdp_5_0_0_offset.h"
+#include "hdp/hdp_5_0_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg)
+		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	else
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+}
+
+static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
+				    struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
+	} else {
+		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
+					HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
+	}
+}
+
+static void hdp_v5_0_update_mem_power_gating(struct amdgpu_device *adev,
+					  bool enable)
+{
+	uint32_t hdp_clk_cntl, hdp_clk_cntl1;
+	uint32_t hdp_mem_pwr_cntl;
+
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS |
+				AMD_CG_SUPPORT_HDP_DS |
+				AMD_CG_SUPPORT_HDP_SD)))
+		return;
+
+	hdp_clk_cntl = hdp_clk_cntl1 = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
+	hdp_mem_pwr_cntl = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
+
+	/* Before doing clock/power mode switch,
+	 * forced on IPH & RC clock */
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     IPH_MEM_CLK_SOFT_OVERRIDE, 1);
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     RC_MEM_CLK_SOFT_OVERRIDE, 1);
+	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
+
+	/* HDP 5.0 doesn't support dynamic power mode switch,
+	 * disable clock and power gating before any changing */
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 IPH_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 IPH_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 IPH_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 IPH_MEM_POWER_SD_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_SD_EN, 0);
+	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+
+	/* only one clock gating mode (LS/DS/SD) can be enabled */
+	if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS) {
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 IPH_MEM_POWER_LS_EN, enable);
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 RC_MEM_POWER_LS_EN, enable);
+	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS) {
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 IPH_MEM_POWER_DS_EN, enable);
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 RC_MEM_POWER_DS_EN, enable);
+	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_SD) {
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 IPH_MEM_POWER_SD_EN, enable);
+		/* RC should not use shut down mode, fallback to ds */
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 RC_MEM_POWER_DS_EN, enable);
+	}
+
+	/* confirmed that IPH_MEM_POWER_CTRL_EN and RC_MEM_POWER_CTRL_EN have to
+	 * be set for SRAM LS/DS/SD */
+	if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_DS |
+			      AMD_CG_SUPPORT_HDP_SD)) {
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+						 IPH_MEM_POWER_CTRL_EN, 1);
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+						 RC_MEM_POWER_CTRL_EN, 1);
+	}
+
+	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+
+	/* restore IPH & RC clock override after clock/power mode changing */
+	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl1);
+}
+
+static void hdp_v5_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+						      bool enable)
+{
+	uint32_t hdp_clk_cntl;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_HDP_MGCG))
+		return;
+
+	hdp_clk_cntl = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
+
+	if (enable) {
+		hdp_clk_cntl &=
+			~(uint32_t)
+			(HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK);
+	} else {
+		hdp_clk_cntl |= HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK;
+	}
+
+	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
+}
+
+static void hdp_v5_0_update_clock_gating(struct amdgpu_device *adev,
+					      bool enable)
+{
+	hdp_v5_0_update_mem_power_gating(adev, enable);
+	hdp_v5_0_update_medium_grain_clock_gating(adev, enable);
+}
+
+static void hdp_v5_0_get_clockgating_state(struct amdgpu_device *adev,
+					    u32 *flags)
+{
+	uint32_t tmp;
+
+	/* AMD_CG_SUPPORT_HDP_MGCG */
+	tmp = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
+	if (!(tmp & (HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK)))
+		*flags |= AMD_CG_SUPPORT_HDP_MGCG;
+
+	/* AMD_CG_SUPPORT_HDP_LS/DS/SD */
+	tmp = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
+	if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_LS;
+	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_DS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_DS;
+	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_SD_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_SD;
+}
+
+static void hdp_v5_0_init_registers(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	tmp = RREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL);
+	tmp |= HDP_MISC_CNTL__FLUSH_INVALIDATE_CACHE_MASK;
+	WREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL, tmp);
+}
+
+const struct amdgpu_hdp_funcs hdp_v5_0_funcs = {
+	.flush_hdp = hdp_v5_0_flush_hdp,
+	.invalidate_hdp = hdp_v5_0_invalidate_hdp,
+	.update_clock_gating = hdp_v5_0_update_clock_gating,
+	.get_clock_gating_state = hdp_v5_0_get_clockgating_state,
+	.init_registers = hdp_v5_0_init_registers,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h
new file mode 100644
index 000000000000..2d5ec2b419f3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h
@@ -0,0 +1,31 @@
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
+#ifndef __HDP_V5_0_H__
+#define __HDP_V5_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_hdp_funcs hdp_v5_0_funcs;
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index b5c3db16c2b0..b860f1c7b5b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -80,15 +80,6 @@ static void nbio_v2_3_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);
 }
 
-static void nbio_v2_3_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-}
-
 static u32 nbio_v2_3_get_memsize(struct amdgpu_device *adev)
 {
 	return RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
@@ -366,7 +357,6 @@ const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.get_pcie_data_offset = nbio_v2_3_get_pcie_data_offset,
 	.get_rev_id = nbio_v2_3_get_rev_id,
 	.mc_access_enable = nbio_v2_3_mc_access_enable,
-	.hdp_flush = nbio_v2_3_hdp_flush,
 	.get_memsize = nbio_v2_3_get_memsize,
 	.sdma_doorbell_range = nbio_v2_3_sdma_doorbell_range,
 	.vcn_doorbell_range = nbio_v2_3_vcn_doorbell_range,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index d2f1fe55d388..8427f10712ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -50,18 +50,6 @@ static void nbio_v6_1_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);
 }
 
-static void nbio_v6_1_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_SOC15_NO_KIQ(NBIO, 0,
-				    mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL,
-				    0);
-	else
-		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
-			NBIO, 0, mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL), 0);
-}
-
 static u32 nbio_v6_1_get_memsize(struct amdgpu_device *adev)
 {
 	return RREG32_SOC15(NBIO, 0, mmRCC_PF_0_0_RCC_CONFIG_MEMSIZE);
@@ -266,7 +254,6 @@ const struct amdgpu_nbio_funcs nbio_v6_1_funcs = {
 	.get_pcie_data_offset = nbio_v6_1_get_pcie_data_offset,
 	.get_rev_id = nbio_v6_1_get_rev_id,
 	.mc_access_enable = nbio_v6_1_mc_access_enable,
-	.hdp_flush = nbio_v6_1_hdp_flush,
 	.get_memsize = nbio_v6_1_get_memsize,
 	.sdma_doorbell_range = nbio_v6_1_sdma_doorbell_range,
 	.enable_doorbell_aperture = nbio_v6_1_enable_doorbell_aperture,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index ae685813c419..3c00666a13e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -60,15 +60,6 @@ static void nbio_v7_0_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);
 }
 
-static void nbio_v7_0_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-}
-
 static u32 nbio_v7_0_get_memsize(struct amdgpu_device *adev)
 {
 	return RREG32_SOC15(NBIO, 0, mmRCC_CONFIG_MEMSIZE);
@@ -292,7 +283,6 @@ const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
 	.get_pcie_data_offset = nbio_v7_0_get_pcie_data_offset,
 	.get_rev_id = nbio_v7_0_get_rev_id,
 	.mc_access_enable = nbio_v7_0_mc_access_enable,
-	.hdp_flush = nbio_v7_0_hdp_flush,
 	.get_memsize = nbio_v7_0_get_memsize,
 	.sdma_doorbell_range = nbio_v7_0_sdma_doorbell_range,
 	.vcn_doorbell_range = nbio_v7_0_vcn_doorbell_range,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index aa36022670f9..598ce0e93627 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -56,15 +56,6 @@ static void nbio_v7_2_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
 }
 
-static void nbio_v7_2_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-}
-
 static u32 nbio_v7_2_get_memsize(struct amdgpu_device *adev)
 {
 	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE);
@@ -325,7 +316,6 @@ const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
 	.get_pcie_port_data_offset = nbio_v7_2_get_pcie_port_data_offset,
 	.get_rev_id = nbio_v7_2_get_rev_id,
 	.mc_access_enable = nbio_v7_2_mc_access_enable,
-	.hdp_flush = nbio_v7_2_hdp_flush,
 	.get_memsize = nbio_v7_2_get_memsize,
 	.sdma_doorbell_range = nbio_v7_2_sdma_doorbell_range,
 	.vcn_doorbell_range = nbio_v7_2_vcn_doorbell_range,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index eadc9526d33f..4bc1d1434065 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -82,15 +82,6 @@ static void nbio_v7_4_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);
 }
 
-static void nbio_v7_4_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-}
-
 static u32 nbio_v7_4_get_memsize(struct amdgpu_device *adev)
 {
 	return RREG32_SOC15(NBIO, 0, mmRCC_CONFIG_MEMSIZE);
@@ -541,7 +532,6 @@ const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
 	.get_pcie_data_offset = nbio_v7_4_get_pcie_data_offset,
 	.get_rev_id = nbio_v7_4_get_rev_id,
 	.mc_access_enable = nbio_v7_4_mc_access_enable,
-	.hdp_flush = nbio_v7_4_hdp_flush,
 	.get_memsize = nbio_v7_4_get_memsize,
 	.sdma_doorbell_range = nbio_v7_4_sdma_doorbell_range,
 	.vcn_doorbell_range = nbio_v7_4_vcn_doorbell_range,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 6bee3677394a..a7f7f960af46 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -38,8 +38,6 @@
 
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
-#include "hdp/hdp_5_0_0_offset.h"
-#include "hdp/hdp_5_0_0_sh_mask.h"
 #include "smuio/smuio_11_0_0_offset.h"
 #include "mp/mp_11_0_offset.h"
 
@@ -50,6 +48,7 @@
 #include "mmhub_v2_0.h"
 #include "nbio_v2_3.h"
 #include "nbio_v7_2.h"
+#include "hdp_v5_0.h"
 #include "nv.h"
 #include "navi10_ih.h"
 #include "gfx_v10_0.h"
@@ -514,6 +513,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v2_3_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
 	}
+	adev->hdp.funcs = &hdp_v5_0_funcs;
 
 	if (adev->asic_type == CHIP_SIENNA_CICHLID)
 		adev->gmc.xgmi.supported = true;
@@ -671,18 +671,13 @@ static uint32_t nv_get_rev_id(struct amdgpu_device *adev)
 
 static void nv_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 {
-	adev->nbio.funcs->hdp_flush(adev, ring);
+	adev->hdp.funcs->flush_hdp(adev, ring);
 }
 
 static void nv_invalidate_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
-	} else {
-		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
-					HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
-	}
+	adev->hdp.funcs->invalidate_hdp(adev, ring);
 }
 
 static bool nv_need_full_reset(struct amdgpu_device *adev)
@@ -1080,120 +1075,6 @@ static int nv_common_soft_reset(void *handle)
 	return 0;
 }
 
-static void nv_update_hdp_mem_power_gating(struct amdgpu_device *adev,
-					   bool enable)
-{
-	uint32_t hdp_clk_cntl, hdp_clk_cntl1;
-	uint32_t hdp_mem_pwr_cntl;
-
-	if (!(adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS |
-				AMD_CG_SUPPORT_HDP_DS |
-				AMD_CG_SUPPORT_HDP_SD)))
-		return;
-
-	hdp_clk_cntl = hdp_clk_cntl1 = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
-	hdp_mem_pwr_cntl = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
-
-	/* Before doing clock/power mode switch,
-	 * forced on IPH & RC clock */
-	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
-				     IPH_MEM_CLK_SOFT_OVERRIDE, 1);
-	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
-				     RC_MEM_CLK_SOFT_OVERRIDE, 1);
-	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
-
-	/* HDP 5.0 doesn't support dynamic power mode switch,
-	 * disable clock and power gating before any changing */
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_CTRL_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_LS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_DS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_SD_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_CTRL_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_LS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_DS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_SD_EN, 0);
-	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
-
-	/* only one clock gating mode (LS/DS/SD) can be enabled */
-	if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_LS_EN, enable);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_LS_EN, enable);
-	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_DS_EN, enable);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_DS_EN, enable);
-	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_SD) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_SD_EN, enable);
-		/* RC should not use shut down mode, fallback to ds */
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_DS_EN, enable);
-	}
-
-	/* confirmed that IPH_MEM_POWER_CTRL_EN and RC_MEM_POWER_CTRL_EN have to
-	 * be set for SRAM LS/DS/SD */
-	if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_DS |
-							AMD_CG_SUPPORT_HDP_SD)) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-						IPH_MEM_POWER_CTRL_EN, 1);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-						RC_MEM_POWER_CTRL_EN, 1);
-	}
-
-	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
-
-	/* restore IPH & RC clock override after clock/power mode changing */
-	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl1);
-}
-
-static void nv_update_hdp_clock_gating(struct amdgpu_device *adev,
-				       bool enable)
-{
-	uint32_t hdp_clk_cntl;
-
-	if (!(adev->cg_flags & AMD_CG_SUPPORT_HDP_MGCG))
-		return;
-
-	hdp_clk_cntl = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
-
-	if (enable) {
-		hdp_clk_cntl &=
-			~(uint32_t)
-			  (HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK);
-	} else {
-		hdp_clk_cntl |= HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK;
-	}
-
-	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
-}
-
 static int nv_common_set_clockgating_state(void *handle,
 					   enum amd_clockgating_state state)
 {
@@ -1213,9 +1094,7 @@ static int nv_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		nv_update_hdp_mem_power_gating(adev,
-				   state == AMD_CG_STATE_GATE);
-		nv_update_hdp_clock_gating(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
 	default:
@@ -1234,31 +1113,13 @@ static int nv_common_set_powergating_state(void *handle,
 static void nv_common_get_clockgating_state(void *handle, u32 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	uint32_t tmp;
 
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
 	adev->nbio.funcs->get_clockgating_state(adev, flags);
 
-	/* AMD_CG_SUPPORT_HDP_MGCG */
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
-	if (!(tmp & (HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK)))
-		*flags |= AMD_CG_SUPPORT_HDP_MGCG;
-
-	/* AMD_CG_SUPPORT_HDP_LS/DS/SD */
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
-	if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_LS;
-	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_DS_EN_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_DS;
-	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_SD_EN_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_SD;
+	adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
 	return;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index a738a7d7e383..c325d6f53a71 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -690,7 +690,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 		}
 
 		memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 		vfree(buf);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index ce56e93c6886..c8c22c1d1e65 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -46,7 +46,6 @@
 #include "sdma6/sdma6_4_2_2_sh_mask.h"
 #include "sdma7/sdma7_4_2_2_offset.h"
 #include "sdma7/sdma7_4_2_2_sh_mask.h"
-#include "hdp/hdp_4_0_offset.h"
 #include "sdma0/sdma0_4_1_default.h"
 
 #include "soc15_common.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index b208b81005bb..d345e324837d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -32,7 +32,6 @@
 
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
-#include "hdp/hdp_5_0_0_offset.h"
 #include "ivsrcid/sdma0/irqsrcs_sdma0_5_0.h"
 #include "ivsrcid/sdma1/irqsrcs_sdma1_5_0.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 0d3def7269bb..24480896547d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -40,8 +40,6 @@
 #include "gc/gc_9_0_sh_mask.h"
 #include "sdma0/sdma0_4_0_offset.h"
 #include "sdma1/sdma1_4_0_offset.h"
-#include "hdp/hdp_4_0_offset.h"
-#include "hdp/hdp_4_0_sh_mask.h"
 #include "nbio/nbio_7_0_default.h"
 #include "nbio/nbio_7_0_offset.h"
 #include "nbio/nbio_7_0_sh_mask.h"
@@ -59,6 +57,7 @@
 #include "nbio_v6_1.h"
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
+#include "hdp_v4_0.h"
 #include "vega10_ih.h"
 #include "vega20_ih.h"
 #include "navi10_ih.h"
@@ -84,14 +83,6 @@
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL                                                             0x01ba
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL_BASE_IDX                                                    0
 
-/* for Vega20 register name change */
-#define mmHDP_MEM_POWER_CTRL	0x00d4
-#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK	0x00000001L
-#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK	0x00000002L
-#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK	0x00010000L
-#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK		0x00020000L
-#define mmHDP_MEM_POWER_CTRL_BASE_IDX	0
-
 /*
  * Indirect registers accessor
  */
@@ -700,6 +691,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v6_1_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v6_1_hdp_flush_reg;
 	}
+	adev->hdp.funcs = &hdp_v4_0_funcs;
 
 	if (adev->asic_type == CHIP_VEGA20 || adev->asic_type == CHIP_ARCTURUS)
 		adev->df.funcs = &df_v3_6_funcs;
@@ -837,17 +829,13 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 
 static void soc15_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 {
-	adev->nbio.funcs->hdp_flush(adev, ring);
+	adev->hdp.funcs->flush_hdp(adev, ring);
 }
 
 static void soc15_invalidate_hdp(struct amdgpu_device *adev,
 				 struct amdgpu_ring *ring)
 {
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
-	else
-		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
-			HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
+	adev->hdp.funcs->invalidate_hdp(adev, ring);
 }
 
 static bool soc15_need_full_reset(struct amdgpu_device *adev)
@@ -858,10 +846,7 @@ static bool soc15_need_full_reset(struct amdgpu_device *adev)
 
 static void vega20_reset_hdp_ras_error_count(struct amdgpu_device *adev)
 {
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
-		return;
-	/*read back hdp ras counter to reset it to 0 */
-	RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
+	adev->hdp.funcs->reset_ras_error_count(adev);
 }
 
 static void soc15_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
@@ -1422,41 +1407,6 @@ static int soc15_common_soft_reset(void *handle)
 	return 0;
 }
 
-static void soc15_update_hdp_light_sleep(struct amdgpu_device *adev, bool enable)
-{
-	uint32_t def, data;
-
-	if (adev->asic_type == CHIP_VEGA20 ||
-		adev->asic_type == CHIP_ARCTURUS ||
-		adev->asic_type == CHIP_RENOIR) {
-		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_CTRL));
-
-		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
-			data |= HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
-				HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
-				HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
-				HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK;
-		else
-			data &= ~(HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
-				HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
-				HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
-				HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK);
-
-		if (def != data)
-			WREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_CTRL), data);
-	} else {
-		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
-
-		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
-			data |= HDP_MEM_POWER_LS__LS_ENABLE_MASK;
-		else
-			data &= ~HDP_MEM_POWER_LS__LS_ENABLE_MASK;
-
-		if (def != data)
-			WREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS), data);
-	}
-}
-
 static void soc15_update_drm_clock_gating(struct amdgpu_device *adev, bool enable)
 {
 	uint32_t def, data;
@@ -1517,7 +1467,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		soc15_update_hdp_light_sleep(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
@@ -1534,7 +1484,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		soc15_update_hdp_light_sleep(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
@@ -1542,7 +1492,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		break;
 	case CHIP_ARCTURUS:
-		soc15_update_hdp_light_sleep(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
 	default:
@@ -1561,10 +1511,7 @@ static void soc15_common_get_clockgating_state(void *handle, u32 *flags)
 
 	adev->nbio.funcs->get_clockgating_state(adev, flags);
 
-	/* AMD_CG_SUPPORT_HDP_LS */
-	data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
-	if (data & HDP_MEM_POWER_LS__LS_ENABLE_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_LS;
+	adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
 	/* AMD_CG_SUPPORT_DRM_MGCG */
 	data = RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_CTRL0));
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 312ecf6d24a0..7cd67cb2ac5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -36,7 +36,6 @@
 #include "vce/vce_4_0_default.h"
 #include "vce/vce_4_0_sh_mask.h"
 #include "nbif/nbif_6_1_offset.h"
-#include "hdp/hdp_4_0_offset.h"
 #include "mmhub/mmhub_1_0_offset.h"
 #include "mmhub/mmhub_1_0_sh_mask.h"
 #include "ivsrcid/uvd/irqsrcs_uvd_7_0.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index c734e31a9e65..6117931fa8d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -32,7 +32,6 @@
 
 #include "vcn/vcn_1_0_offset.h"
 #include "vcn/vcn_1_0_sh_mask.h"
-#include "hdp/hdp_4_0_offset.h"
 #include "mmhub/mmhub_9_1_offset.h"
 #include "mmhub/mmhub_9_1_sh_mask.h"
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
