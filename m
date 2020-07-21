Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56722C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2640420720
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="34Vs/kmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2640420720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D40486E423;
	Tue, 21 Jul 2020 16:01:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 550D96E423
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 16:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTSjtpIcxZmn9aiJ3GSzATRzG4/KySQjJNjDf7fZpJTWBvOflPmLFutDSGxzUKNjCpo9DEosXwCjec4EngCaND92z+qFnCzI2YvBlWymtWaH3Spx0cYDQubjMIYaik2hk9TE4EXRvW/DHd9RHgJg2cwjjp1n9wwPdFld0u0Bg+sGUlA/YGdhQtQA3Qq58s1Ti7fKP9OQPmGcFMPF32txMqQ1VU45xT6x/CSRs6WEtkDXSZbMmYejqCHKO2vNHzVycS0cH8dPo14mc7GOUkL94EsbvPnIbrPqgH7ZH8EB8Pzj/Zst20eZDstWvAv7uJ7l7CxCBbOMH4L33mSPv8j+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SdHhRf/FVdws5mqyRiwNvFb1Zaw5Cb+f8iVQpk+Mos=;
 b=m6iHXJ54xIFl8KC9/TP0vF7MN7vP1JNxCqrkUPKfdPIXaTv3qfbwOaVIntP0xU4h4WKdqvyJfAE17ys6qkFrDu80xzTDGNvD7b+eKOdMmw8TZemP/YXeDAIOaU1JNmH4ljhhn1S/xL1jPv7BGURAe51RfPYC2MJjsaDZNNsUvs6o9q/BG00ltmaW6OS7OCIi2CdjHAJ8sQpoGGK3rr/XK7f9KqJvWqefaDo1eDcayvfjy3qtxJleMc3R9/4xu9UceI8fi45i5TczyCCJHJawuUhFJWJgUu+PQKXF20gD9BAWxmgDZPGgiYGesAPmm6cUamxNNzYdvlL2PYTyYjZhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SdHhRf/FVdws5mqyRiwNvFb1Zaw5Cb+f8iVQpk+Mos=;
 b=34Vs/kmQ1ctswIHzOcqegRCLui6FKr4NdHokG+w013ra0eizR66Ebt4JDz5s+giqPfqdvqhPd3UbSLEV3kzmh/CMVLlKD5CPbIY9U5myYoybsFRut+QgZBVflnQ41yGIuEzFfCwQrIa3qCKLjWwKizowCLo0x1+WcdhKxZrRlYA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2837.namprd12.prod.outlook.com (2603:10b6:a03:68::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 16:01:14 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::7d42:c932:e35f:71b1]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::7d42:c932:e35f:71b1%7]) with mapi id 15.20.3216.020; Tue, 21 Jul 2020
 16:01:14 +0000
Subject: Re: [PATCH] drm/amd/display: Explicitly set stack size to 4
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200721153801.11699-1-kent.russell@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <e874aba0-5719-8687-e425-c8d18be41d61@amd.com>
Date: Tue, 21 Jul 2020 12:01:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200721153801.11699-1-kent.russell@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::28) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0089.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 16:01:13 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab56fddc-921a-4d9f-eb6b-08d82d8f4afe
X-MS-TrafficTypeDiagnostic: BYAPR12MB2837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB28372C74CE1AE6BE52967D1FEC780@BYAPR12MB2837.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUltrbInX+0uWywNoXpd4ToWBst52Tk3yXIO6fQzv9oQOQX7zxgE+twxQ2eSwCL/TAvmYi3EioqPo/gN4tmdX5dtusdiB/aBfw9MuO6G6Ll+CXjWneo0rEBiRTqm5T7F9Vmdeeziq9wawOpCLeT9l4VyhVDzZ5yaYQZUeeoFCujWMAMjh5ojPOovDH08kYVBhHpXbD5CZkAEvRZkMaOqOC4JY9JW29Ck4vEid+oEBSQZW9j1cj9YgZhL1zWFjb1F0KpOThLBCpd+1Uco3bqXw7oP9gqp86hBoGTiwCM3TB9aTrwAE/0MxqVaty/JSTv02/X7C1Z8h4si3PWja6rvhpoRwVv8ES4XB2fN2uimR2zuH2ov+jTImlRbf1nqaD24
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(83380400001)(478600001)(956004)(2616005)(66556008)(66476007)(6486002)(31696002)(66946007)(26005)(6666004)(16526019)(86362001)(8676002)(8936002)(2906002)(316002)(16576012)(53546011)(186003)(31686004)(52116002)(5660300002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: isA94ydVwg2oHPbBbXb6qUnuAMsW50jARgOLURkJEHsQU8xsywt4KFI0gIE6xATXB5ZcOgsA0Iya/1tnXVr/dfCzoZkPYHaa9efIqFl6k4MUGMSpo6J/ze0Dgq8/gvUtT1hiTyswam7XLXas34itplO2lsONr+8IrdCv8iVW1eTy3xaSEiYL9f62zc8jpkmM/TA5yup6zZz7J3LhA81u7eqYKLgkNDW/+Sl3Ogo01ZHnO51owPfwFjehIy8lp8ZAMR6ff9+hqGzkj/mwfpUSJwtjAq8D29RYWns04xAbVhCNXWMHqYzGjDBf9L9dZxdWPokHRuyxftZ9TY89R00rXmAMe6XL7+dcjtNlciyL8q43IbCT/3h2puJ57HvaUadRTqfdYBkrQVM7osiRjr0lVDY4R0VcIJAR+yCt2r1gjHFULwT6G08HI4c/ei8+xxoZPIERtYft0GZn35zpn+4dvC7ktXz+XU1+KO10Bx+w1g8BuIq/ZlVDcbdI7mZDmi/1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab56fddc-921a-4d9f-eb6b-08d82d8f4afe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 16:01:13.8596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViFoxzDCDGpazED3J0TlZro3PNvjGRG1oX2CphnXN8A/nRp4QU6FjXdCeII6BAy7bREhJuXcxLE8PtbIydZFkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2837
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-07-21 11:38 a.m., Kent Russell wrote:
> In certain kernels using GCC 8.2, we get compilation errors saying:
> -mpreferred-stack-boundary=3 is not between 4 and 12
> Explicitly set -mpreferred-stack-boundary=4 in the Display Makefiles,
> even when SSE2 is enabled
> 
> Change-Id: Ic7c4637e2e521af2d0444d3b5886f710131c80ca
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Seems reasonable to me. I'd imagine we want this anyway since SIMD 
generally wants to be 16-byte aligned anyway and this code has FP in it.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/calcs/Makefile | 8 ++++----
>   drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 8 ++++----
>   drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 8 ++++----
>   drivers/gpu/drm/amd/display/dc/dcn30/Makefile | 8 ++++----
>   drivers/gpu/drm/amd/display/dc/dml/Makefile   | 9 +++++----
>   drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 8 ++++----
>   6 files changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> index 4674aca8f206..5c519cec9039 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> @@ -26,7 +26,9 @@
>   #
>   
>   ifdef CONFIG_X86
> -calcs_ccflags := -mhard-float -msse
> +# Certain kernels don't compile with -mpreferred-stack-boundary=3, so explicitly set it
> +# to 4, even if we enable SSE2
> +calcs_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
>   endif
>   
>   ifdef CONFIG_PPC64
> @@ -40,12 +42,10 @@ endif
>   endif
>   
>   ifdef CONFIG_X86
> -ifdef IS_OLD_GCC
> +ifndef IS_OLD_GCC
>   # Stack alignment mismatch, proceed with caution.
>   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
>   # (8B stack alignment).
> -calcs_ccflags += -mpreferred-stack-boundary=4
> -else
>   calcs_ccflags += -msse2
>   endif
>   endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> index 5fcaf78334ff..78d3e0563a4c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> @@ -10,7 +10,9 @@ DCN20 = dcn20_resource.o dcn20_init.o dcn20_hwseq.o dcn20_dpp.o dcn20_dpp_cm.o d
>   DCN20 += dcn20_dsc.o
>   
>   ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -msse
> +# Certain kernels don't compile with -mpreferred-stack-boundary=3, so explicitly set it
> +# to 4, even if we enable SSE2
> +CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
>   endif
>   
>   ifdef CONFIG_PPC64
> @@ -24,12 +26,10 @@ endif
>   endif
>   
>   ifdef CONFIG_X86
> -ifdef IS_OLD_GCC
> +ifndef IS_OLD_GCC
>   # Stack alignment mismatch, proceed with caution.
>   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
>   # (8B stack alignment).
> -CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o += -mpreferred-stack-boundary=4
> -else
>   CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o += -msse2
>   endif
>   endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> index 07684d3e375a..6183e8f141bb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> @@ -6,7 +6,9 @@ DCN21 = dcn21_init.o dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o \
>   	 dcn21_hwseq.o dcn21_link_encoder.o
>   
>   ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse
> +# Certain kernels don't compile with -mpreferred-stack-boundary=3, so explicitly set it
> +# to 4, even if we enable SSE2
> +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
>   endif
>   
>   ifdef CONFIG_PPC64
> @@ -20,12 +22,10 @@ endif
>   endif
>   
>   ifdef CONFIG_X86
> -ifdef IS_OLD_GCC
> +ifndef IS_OLD_GCC
>   # Stack alignment mismatch, proceed with caution.
>   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
>   # (8B stack alignment).
> -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -mpreferred-stack-boundary=4
> -else
>   CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -msse2
>   endif
>   endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> index 025637a83c3b..0d803486e051 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> @@ -33,19 +33,19 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
>   
>   CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse -mpreferred-stack-boundary=4
>   
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
> +# Certain kernels don't compile with -mpreferred-stack-boundary=3, so explicitly set it
> +# to 4, even if we enable SSE2
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
>   ifdef CONFIG_CC_IS_GCC
>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>   IS_OLD_GCC = 1
>   endif
>   endif
>   
> -ifdef IS_OLD_GCC
> +ifndef IS_OLD_GCC
>   # Stack alignment mismatch, proceed with caution.
>   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
>   # (8B stack alignment).
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mpreferred-stack-boundary=4
> -else
>   CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -msse2
>   endif
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 417331438c30..fc5e304c4dac 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -25,8 +25,11 @@
>   # It provides the general basic services required by other DAL
>   # subcomponents.
>   
> +
>   ifdef CONFIG_X86
> -dml_ccflags := -mhard-float -msse
> +# Certain kernels don't compile with -mpreferred-stack-boundary=3, so explicitly set it
> +# to 4, even if we enable SSE2
> +dml_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
>   endif
>   
>   ifdef CONFIG_PPC64
> @@ -40,12 +43,10 @@ endif
>   endif
>   
>   ifdef CONFIG_X86
> -ifdef IS_OLD_GCC
> +ifndef IS_OLD_GCC
>   # Stack alignment mismatch, proceed with caution.
>   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
>   # (8B stack alignment).
> -dml_ccflags += -mpreferred-stack-boundary=4
> -else
>   dml_ccflags += -msse2
>   endif
>   endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> index ea29cf95d470..98695c66eaf1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> @@ -3,7 +3,9 @@
>   # Makefile for the 'dsc' sub-component of DAL.
>   
>   ifdef CONFIG_X86
> -dsc_ccflags := -mhard-float -msse
> +# Certain kernels don't compile with -mpreferred-stack-boundary=3, so explicitly set it
> +# to 4, even if we enable SSE2
> +dsc_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
>   endif
>   
>   ifdef CONFIG_PPC64
> @@ -17,12 +19,10 @@ endif
>   endif
>   
>   ifdef CONFIG_X86
> -ifdef IS_OLD_GCC
> +ifndef IS_OLD_GCC
>   # Stack alignment mismatch, proceed with caution.
>   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
>   # (8B stack alignment).
> -dsc_ccflags += -mpreferred-stack-boundary=4
> -else
>   dsc_ccflags += -msse2
>   endif
>   endif
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
