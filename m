Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE94C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 14:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421C810E257;
	Thu, 13 Jan 2022 14:17:24 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C0D10E23F
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 14:17:23 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 t4-20020a05683022e400b00591aaf48277so6329913otc.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 06:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wI02ty8xwNwY2mvi9lBYDefjolygxEWo0SL9bRSj7WU=;
 b=iZWSqSu/jo5M5RGwfCxyO7JsTRmYLrrSDnv6E+lE3FetvLU8Ys4e4LodhLUMw1/lel
 UjYWlw/FGptGn5FLQVnza008EbHGmKculr/yuwU0hdaQ0fLEbQxO0uYk5GzeOb6xZ3Oj
 njQH21sJE1n87SinKpJ1/WrOq8qy3kTUz28doxpg/pA51GCCcLL3XeP/1QGv1yjWD85x
 TLg9IEnNQrB/B0NCuYZfyqJUxyjsL8TkwsSXlvNxvMREGi3nVJYITYfbUoatiYcwaASB
 RWY7LY4tW5zYNFujnv0nOjcungUGzSkEfOCRUD9WWp10AtlO11eugv78Qq8zLgHPQqsJ
 ntJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wI02ty8xwNwY2mvi9lBYDefjolygxEWo0SL9bRSj7WU=;
 b=NkL1MafGHN0iexKxnK2Kvi7xc2us82PAl1k6EEkga/UDdHoG7CFIekSdG5UVJM0pBP
 4rXcnItjnRxxsUF8sjfJVfQXogpqzii5RQLDMsQ6N/tF91Avi9rNz6WVIwZHV5vk84/4
 5Hi6gd2TrriTdK/+g6WTjVGAtQPfhbp3w1NuISfFrH27sJjjCOtkeoLEWLjp4cxRPss/
 RRvmYbpdJKfkwrCrKOIDhoOgmrQ7dJuu0ODZdtUaFQbAcJNqEX1PjN6NTGDoJorfm/ul
 pcWQxuit7Kjh66tQqlV17A2Q2iMXAtyH182eu1JoE+HrcrG+v6EDH/OEZC5vnxNYkUbr
 xZlQ==
X-Gm-Message-State: AOAM532sojdMDVnTuXC7Isw69zJy5+nsD2mROlblXJlz5KRjbqNIUst3
 qE5qOekbdeFsYTXWIGugLLq1PpobNS/5IstFvLXA27KE
X-Google-Smtp-Source: ABdhPJx5gVwZtefk/V7rcxIdvrxO56spuLKQmJyX8VSuHO3BCuWY0/w2ejmBA5Tc0jPcx2KKxV2I4h3nHJFE/hbaqVk=
X-Received: by 2002:a9d:6390:: with SMTP id w16mr3311514otk.200.1642083442806; 
 Thu, 13 Jan 2022 06:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20220113135457.17020-1-guchun.chen@amd.com>
In-Reply-To: <20220113135457.17020-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Jan 2022 09:17:11 -0500
Message-ID: <CADnq5_Ox2AHL3oTduu59mauQf2aW_MKLfxSfzfcW1bOwUHWWnw@mail.gmail.com>
Subject: Re: [PATCH] tests/amdgpu: Add VCN test support for Biege Goby
To: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
 Leo Liu <leo.liu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jan 13, 2022 at 8:55 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> Added Beige Goby chip id in vcn test, will open a MR to
> merge this on gitlab after review.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  tests/amdgpu/vcn_tests.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/amdgpu/vcn_tests.c b/tests/amdgpu/vcn_tests.c
> index 628b4910..15d573d3 100644
> --- a/tests/amdgpu/vcn_tests.c
> +++ b/tests/amdgpu/vcn_tests.c
> @@ -142,7 +142,8 @@ CU_BOOL suite_vcn_tests_enable(void)
>         } else if (family_id == AMDGPU_FAMILY_NV) {
>                 if (chip_id == (chip_rev + 0x28) ||
>                     chip_id == (chip_rev + 0x32) ||
> -                   chip_id == (chip_rev + 0x3c)) {
> +                   chip_id == (chip_rev + 0x3c) ||
> +                   chip_id == (chip_rev + 0x46)) {
>                         reg.data0 = 0x10;
>                         reg.data1 = 0x11;
>                         reg.cmd = 0xf;
> --
> 2.17.1
>
