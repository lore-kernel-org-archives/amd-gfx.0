Return-Path: <SRS0=8/fv=G4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF3AC43381
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB6A22240
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB6A22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F6E86E0FE;
	Mon, 25 Jan 2021 13:44:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C0B6E0FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jan 2021 13:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIieEjdKPXnzeT4WaHJbhUHHL+JrWze1uhYJPIRb5TzpCwirEAGPfPraeCVhYXlPLPI7B6sLg7YvcwTw3gEYr3uGDilgO4L+u7tQ1JVXosODk41BKSXzy8qza2wPbL/PWO+6xGh7CIeh3EGAT3+qaFJ6NJSNRiav+M/7JI9DgdtsmRhBre9gkleuk6vZgQy27rBHj+2vGslpOjYEQLDNkqwZCKiSATMVi0xIowtZtnM3x47ac97FeDAAT/mk+VouwobHsasijma879cUDqDLScALDGMTCYhir7hj8FaJQ5Ttrw0nz99oh8SEQ3wGbzTVW/UrEDyPKrVof3TT/gfOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQp7qMo3iQPQKxIF8wy3U7Y/4SJJ1eRhFUEcYT9BXus=;
 b=DFTuwG8yYk9gDYlw1j7NwEyI8olMGYRATLdzBkz1HdfwhNRICAJBep3q0XkimWg78TdnYd0h60h/aO/TSgU955RncMp4r7E17LwOKVAg+auSBJSY9aan+FTcG9lw8r++lKKGAfqFo26AZ0ZwzVW4yd913uVsjAIBEyiiGw17awHYVGDdwWVGI+LVsSAIu8QZfd444C7xIR9sit95x5yKGrGrLME3oYoBqwbOXtxSykp6J0Ui3eCOlSErEDgzLqsbnaYISHcPsZZXrrfZ4b2S7rh/xwRY19OgYH0XxjlGl5LQZoprjZeZNFpo1pdDZgVNraqNrp/j97tzSHNXfth97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQp7qMo3iQPQKxIF8wy3U7Y/4SJJ1eRhFUEcYT9BXus=;
 b=blPqUT1Huq4UYDJuaWpDON4OxjCVjAFsQOUp65lU5p6/2cWm5VF98qXQB0gZSmsNZyJcRZP4lHfqCsjjrTJm44RhdKnFVtpstZ1LMWZFILNqoCweLOgcPoiPo9IXoifFyPP3jmCPn4oPbxN+w8fvhgyXNMNl3xu0oZO4BRnc1bM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.13; Mon, 25 Jan 2021 13:44:21 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 13:44:21 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC 7/7] drm/amd/display: Drop float flages from DCN30 files
Date: Mon, 25 Jan 2021 08:43:13 -0500
Message-Id: <20210125134313.305184-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125134313.305184-1-Rodrigo.Siqueira@amd.com>
References: <20210125134313.305184-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:7f86:f3af:1efb:628a]
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:7f86:f3af:1efb:628a)
 by YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Mon, 25 Jan 2021 13:44:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: badc74c7-aca6-46d1-cc3a-08d8c137518c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB434057B188A01E95C156B1D398BD9@DM6PR12MB4340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfNfaInxNO5meC31bwLoX7W7RteN+OHFgXXYKgp1IScVZVpUk6Jcc61adHhJSR1sCo/U3S+LizhR7DyblInF7fJM8//MTILujfSAGQL401I+B45aaIMLQEz5yZZ+tXOkRYnofiQBuZrrxAIse0jyd5XV8wdHW85A+MVg+JJgDaHOqMwN7MjAn6UvEhMNIlxAEp+hqli8X8s+a1uknpLFKTGKq7j+jzQV58W3m4U02BmMjte+Uwl34H8pevoXB2umGD35WFcH5KER68iqeFUXE8Q7oEvkJ9AQQvXzlBNkUPvAyqVqm1V7NhZ8wKSTU4hRtSZUkV7keayYIrZmPCyDsyHmoRZOSCKD3D0OWQFLPaIZDallCAUsUTL4Y/ujHlARaVQQEJ6d4XzLqQv2CZ0yoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(52116002)(54906003)(6512007)(16526019)(6506007)(5660300002)(4326008)(8936002)(316002)(83380400001)(186003)(2906002)(66556008)(66946007)(66476007)(478600001)(6486002)(86362001)(2616005)(8676002)(6666004)(6916009)(1076003)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?48GYE4VqovPWUdRfIXbWV94S8uqab/a1UKGoAXuabgHN+DITOD8hyAglOs28?=
 =?us-ascii?Q?Rv8uHmcfcjzD0z7A2+FQwIgFTJBwCw+0ylVUAU3vpJKaiaecskz2gV1h9cfd?=
 =?us-ascii?Q?1TUqQNillxtK9EvY38/ChLHrwKR9fhaLeSeRX6ZJAEXR/V1+eAnAsasymhIV?=
 =?us-ascii?Q?SEG1gDI0O2hAPr+UOsgR7K7cIeVkV2TFqSVlr1l4jGv6ChcAuD9ILuFsetjm?=
 =?us-ascii?Q?SlQeSIXaq9enwJ5fTYxQkC02uFwMHabB379Vjhr8fhWtRQXLwAFeoJkZTPs6?=
 =?us-ascii?Q?CUqcYSgNwwozfthuVn3LeDBeA96ZdmgKd1o6758DtiOrR//cCnQi3ypEQLVN?=
 =?us-ascii?Q?huRYHn6giysb3UNAbR8gmN6OIzBH9WKS7Wmbk01YPnAYGZ0fWvc7otXddcAi?=
 =?us-ascii?Q?F/1ygrY24iFq9KCcb7VL7uQ/gHEeVs7w8On08NGsxL/8yqHU0t/+howFZhNo?=
 =?us-ascii?Q?YH9/zmjrnf2EgjIbP0HRMuwd/TffNDOj3ms6F7TedN/9n0mN8SCdUeexHd+j?=
 =?us-ascii?Q?C65rLK6gfboa7ne27+u9e6xz0+STsDcnfw0Mhdwg8mPl8effou+loI6PxGOM?=
 =?us-ascii?Q?8ZuabTl24KsV28nM7tNw2z9LJJ/rBYXuXJVEXFNZ1YgzkS19QQOmW2D7LLvg?=
 =?us-ascii?Q?w8JGuFLKJRJwSmVt8gmmXKea6sK5iijKEvM8T6HqhxQm+Gz9vEvcU3M2DzNY?=
 =?us-ascii?Q?ZMnfKYTmVlJTWZjiCtbp+99z8KrBODtqSGOeyS+hEZr0C8Yvm7Pq3Umi80BH?=
 =?us-ascii?Q?K3KM0uxIP/JG6n09ppqHHPFqlTwyB/gk/yBzX9thXtPQJFx0koNDzDrXjbZ5?=
 =?us-ascii?Q?4dK4vohnz4kzBiy+a0BsISxO8xWkYXj1iV1a9jgW1k0kn94RjyBdHeDV3i6L?=
 =?us-ascii?Q?lWWrsadfK2DksGjDSpP5J7o1hWlzkbVIX9UWfBTrGq6jJEubMgrN3eu/FaUs?=
 =?us-ascii?Q?TqosBm/hEFD4/V9VZNW7j9ccqSMHi/o13SObJiFgGQ5m6OgK9z45CAm5j82q?=
 =?us-ascii?Q?Jj8UqDyfBfWfLVxV3xXO3M1U/wOzbRGxmTXKLqCnTbLlnimQKrslmXv5Wrxp?=
 =?us-ascii?Q?+AgR2WquOs3SOsB081lgKUDdtEhL0mkYiSmGzkRr3EtYscVd54cZO0EM5G85?=
 =?us-ascii?Q?Jd4t8Xk5eOSz+sK0iKzutzMlifWFovBIww=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: badc74c7-aca6-46d1-cc3a-08d8c137518c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 13:44:20.9678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJZVzruJm80ihMbYx7aECm55CbRLuWu+AFS/8FqYWnJykJmUhVRCKXz6yx3Sy/iUCuQ7nedkJK/ZIomGB39D7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

All functions that require FPU access associated with DCN30 were moved
to the specific file inside the FPU directory. For this reason, we don't
need to use the `-mhard-float -msse` flags for any DCN30 file directly,
which means that we can safely drop those flags from the Makefile and
any other unrelated FPU code.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile | 30 -------------------
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  3 --
 .../gpu/drm/amd/display/dc/dcn302/Makefile    | 25 ----------------
 3 files changed, 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index c20331eb62e0..b7c2ae9ddfda 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -30,36 +30,6 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
 	dcn30_dpp_cm.o dcn30_dwb_cm.o dcn30_cm_common.o dcn30_mmhubbub.o \
 	dcn30_dio_link_encoder.o dcn30_resource.o
 
-
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -maltivec
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mpreferred-stack-boundary=4
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -msse2
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -msse2
-endif
-endif
-
 AMD_DAL_DCN30 = $(addprefix $(AMDDALPATH)/dc/dcn30/,$(DCN30))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN30)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index cd2598bd193f..d00f98174f21 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1403,9 +1403,6 @@ bool dcn30_release_post_bldn_3dlut(
 	return ret;
 }
 
-#define fixed16_to_double(x) (((double) x) / ((double) (1 << 16)))
-#define fixed16_to_double_to_cpu(x) fixed16_to_double(le32_to_cpu(x))
-
 static bool dcn30_split_stream_for_mpc_or_odm(
 		const struct dc *dc,
 		struct resource_context *res_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
index 8d4924b7dc22..3ea9bff27912 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
@@ -12,31 +12,6 @@
 
 DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
 
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -msse2
-endif
-endif
-
 AMD_DAL_DCN3_02 = $(addprefix $(AMDDALPATH)/dc/dcn302/,$(DCN3_02))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN3_02)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
