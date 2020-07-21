Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628EDC433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 15:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3944A20702
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 15:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G+E/0Mck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3944A20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEED96E5A0;
	Tue, 21 Jul 2020 15:38:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD0B6E5A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 15:38:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+QGZstYzDMjWwi0Ai3YGGVivqJZLi5CDTomgOoCR378Go2Ru4QdeUuO0X2A3ICy+mXylJgZxA8DkuRShmolcsA6xT9wSylCRVkyJmuwYfNwX2a0aiR+eUPluZI1VsQKXNXakpz9QFM3WFOVaMi2nFBnEa5k2PbC/MJW4WcBSHRKFA8nSeaZ5vNBoGVtNPHhyh0awKnuvAoAj4k77pSN68JSejGQAMKeHze79UdCpRbWOyKAN5pBcDTij36DGPOn+76ytkH7L7d1ObkEZ7939XD7uYYPZ3FmwfU10F5hB9+ii14JF1MlJ1IVdltAedxWXOSa6NmtcJqHEs4YkPfbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgIupF6cOyqoBhBz8ZZulU7p9oS+lYbU93O6dKWvHrw=;
 b=OaRqNeQMcmRbI61mRm64y24e1VwX7sfMzDQgMTtpp8agpdpL5CfhlRV/o/gMfgrXSPogYfkadXSRdWoErFK3qJbf6OM+yY+8PIaxOSSL3DvOFhHR6rTWTL6KVTd3O9OoPskuIsXbFNBY5GXcFTU3UgkIfchiQtT6ZcO29SpeVaG2GCs2x9dd8p9gX7J6PomF2U1HWWiuEAbUtKyRLo0f2wT4x/kBUq3kGTP0ScCO88nBYjCk9XQ14DCTI8jJkt9UKnIm64pkwl9ekhfeWkrgiOyD/PmoBKHZ23aiWlAJZBI0xbGF+zgv2KXP1GuRIfKWGGDG2euiTEJGlcM1hN1s8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgIupF6cOyqoBhBz8ZZulU7p9oS+lYbU93O6dKWvHrw=;
 b=G+E/0MckvGOcbVULyvjFFFZE0iNtSR0e9uDz8rjMIp+fcgQe80LwN2wdHYlBTvlUq5wIDlvClsnDWQfkIaVsRD2n4n73/7BheJY2YyS0KbIgdYiPomtcfiu298lTAZcNPNmT85L0muH7F+jlNt0QSpRmuvkvyor+Xc59wgxmDco=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 15:38:11 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::99a9:a1a9:8427:d7b5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::99a9:a1a9:8427:d7b5%7]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 15:38:11 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Explicitly set stack size to 4
Date: Tue, 21 Jul 2020 11:38:01 -0400
Message-Id: <20200721153801.11699-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 15:38:10 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1af221b8-0201-48f8-56c7-08d82d8c130c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44034CBD385706C79BB41CE385780@DM6PR12MB4403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YO1Vzv2c1pMo+VVydgBzC2LJunAw12rg67boiVqQnLNzCaaageAzOjSYdCACxbXbSSIjUp1LzhUSU6DTsGdlx3QMpDco7AvqAOu+TIl63ilvPxqK9l4GsGHJgmbjozKh2bzu6qINOb8BDOPjDazjZ3GNv7EEpHOJHd5GD9qtqNfGYZlOCJkk8x55VlHGP3hmJAxSfp9wdQtsE1RpJV1vFdoywCPIZievjLH3rVFhrqfcwDqXfLsT3MhHsUy4LbNlk+zL1VyH+WqWrdMMVE44MGjoCcJwot9drPSBhP8NYg5Sc2i/ymY1iBBqKZrOVdWOt6Rsn++KE0wQi21OvLZTZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(44832011)(956004)(1076003)(6666004)(478600001)(2616005)(66476007)(66946007)(66556008)(5660300002)(186003)(36756003)(26005)(83380400001)(16526019)(86362001)(8676002)(6486002)(8936002)(52116002)(7696005)(316002)(2906002)(4326008)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kkwlUgkAOwHuZj47hfYfGCpKl8Wg/DUodZlN1Sm01mepnoN3zITrKhXoCALXcZaV1Zh4E2cbL0vbCk/yPFnCBzkJQVdCIBLI/OIuEAQ0jIpKk4kRrV/Dpupj9rBmKuYEoOWMCVh+gnNuhn9IZ2zK0DCFmiqreSDk/lp1sj3+DWGs4vN+pUzkD2++ZFTH4TWmrj7NB8tgL1lfz5cz5jAsaZ3YFglMNrOjz+GzZdGjbUbEy+Z9oi74wIthaFJwxoUihEK5qPQJWr3U6hqZwDfcKnkdZhasHdIW/c/3GNLOMjoZJQ03GXbDTnLYm75qShqjklkY/QjCWyL2HNFvRWHP1kauFaqw0sBCQ3vPmC49oRn64Wj8I2CFmjZeEDaBbOuDw1BY13XDAdIBza2BdzK31k80+jCHHY1JvMZ88unKeGhcVX/kRbLrdI+2udPzsVK8/5C3l9hv7QWJx+9ZkEce5Mk+ZJ1nqVyx9Ax+r7UWbzVrXYoKa3QcX+CEyIRAmOwH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af221b8-0201-48f8-56c7-08d82d8c130c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 15:38:11.2601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oSsL0ki+Y8t4qa/404JLh3CCqCuqmwIigCHsGvRIV8b9xE3W8YgsEqdJbTYj3wgZN283yBk599nPlt2YjRyVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In certain kernels using GCC 8.2, we get compilation errors saying:
-mpreferred-stack-boundary=3 is not between 4 and 12
Explicitly set -mpreferred-stack-boundary=4 in the Display Makefiles,
even when SSE2 is enabled

Change-Id: Ic7c4637e2e521af2d0444d3b5886f710131c80ca
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 8 ++++----
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 8 ++++----
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 8 ++++----
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile | 8 ++++----
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 9 +++++----
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 8 ++++----
 6 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index 4674aca8f206..5c519cec9039 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -26,7 +26,9 @@
 #
 
 ifdef CONFIG_X86
-calcs_ccflags := -mhard-float -msse
+# Certain kernels don't compile with -mpreferred-stack-boundary=3, so explicitly set it
+# to 4, even if we enable SSE2
+calcs_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
 endif
 
 ifdef CONFIG_PPC64
@@ -40,12 +42,10 @@ endif
 endif
 
 ifdef CONFIG_X86
-ifdef IS_OLD_GCC
+ifndef IS_OLD_GCC
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
-calcs_ccflags += -mpreferred-stack-boundary=4
-else
 calcs_ccflags += -msse2
 endif
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 5fcaf78334ff..78d3e0563a4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -10,7 +10,9 @@ DCN20 = dcn20_resource.o dcn20_init.o dcn20_hwseq.o dcn20_dpp.o dcn20_dpp_cm.o d
 DCN20 += dcn20_dsc.o
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -msse
+# Certain kernels don't compile with -mpreferred-stack-boundary=3, so explicitly set it
+# to 4, even if we enable SSE2
+CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
 endif
 
 ifdef CONFIG_PPC64
@@ -24,12 +26,10 @@ endif
 endif
 
 ifdef CONFIG_X86
-ifdef IS_OLD_GCC
+ifndef IS_OLD_GCC
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o += -mpreferred-stack-boundary=4
-else
 CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o += -msse2
 endif
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index 07684d3e375a..6183e8f141bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -6,7 +6,9 @@ DCN21 = dcn21_init.o dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o \
 	 dcn21_hwseq.o dcn21_link_encoder.o
 
 ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse
+# Certain kernels don't compile with -mpreferred-stack-boundary=3, so explicitly set it
+# to 4, even if we enable SSE2
+CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
 endif
 
 ifdef CONFIG_PPC64
@@ -20,12 +22,10 @@ endif
 endif
 
 ifdef CONFIG_X86
-ifdef IS_OLD_GCC
+ifndef IS_OLD_GCC
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -mpreferred-stack-boundary=4
-else
 CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -msse2
 endif
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index 025637a83c3b..0d803486e051 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -33,19 +33,19 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
 
 CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse -mpreferred-stack-boundary=4
 
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
+# Certain kernels don't compile with -mpreferred-stack-boundary=3, so explicitly set it
+# to 4, even if we enable SSE2
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
 ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
 endif
 
-ifdef IS_OLD_GCC
+ifndef IS_OLD_GCC
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mpreferred-stack-boundary=4
-else
 CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -msse2
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 417331438c30..fc5e304c4dac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -25,8 +25,11 @@
 # It provides the general basic services required by other DAL
 # subcomponents.
 
+
 ifdef CONFIG_X86
-dml_ccflags := -mhard-float -msse
+# Certain kernels don't compile with -mpreferred-stack-boundary=3, so explicitly set it
+# to 4, even if we enable SSE2
+dml_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
 endif
 
 ifdef CONFIG_PPC64
@@ -40,12 +43,10 @@ endif
 endif
 
 ifdef CONFIG_X86
-ifdef IS_OLD_GCC
+ifndef IS_OLD_GCC
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
-dml_ccflags += -mpreferred-stack-boundary=4
-else
 dml_ccflags += -msse2
 endif
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index ea29cf95d470..98695c66eaf1 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -3,7 +3,9 @@
 # Makefile for the 'dsc' sub-component of DAL.
 
 ifdef CONFIG_X86
-dsc_ccflags := -mhard-float -msse
+# Certain kernels don't compile with -mpreferred-stack-boundary=3, so explicitly set it
+# to 4, even if we enable SSE2
+dsc_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
 endif
 
 ifdef CONFIG_PPC64
@@ -17,12 +19,10 @@ endif
 endif
 
 ifdef CONFIG_X86
-ifdef IS_OLD_GCC
+ifndef IS_OLD_GCC
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
-dsc_ccflags += -mpreferred-stack-boundary=4
-else
 dsc_ccflags += -msse2
 endif
 endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
