Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63683C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 16:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DE86198D
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 16:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DE86198D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC51F6E4A7;
	Mon, 28 Jun 2021 16:29:35 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 668576E0A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 16:29:34 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 a5-20020a05683012c5b029046700014863so2566955otq.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OUJwoGvfmw1MtZC6FNnt+5peBTs2ophLxdA21WiuRQ0=;
 b=UAUDLpWd3lHqBuGE6nREq2uWfDxRbI6WlAB3ZCgZLA9hfgHfdhSlVm6iDrUN4oHSdg
 oHKO8Y3n4SmFutS5dUoPnsq0wEV1B8EkZufZp2SMAGU0JYn6KZm2TEJrFr5Ot4Nvapsv
 +FQp9nLVfNNySY+dKgv2sNjvmTO3w8nvRvUD7qw/tsdWnsHx5n+JGUjx8K20ifQMZjlw
 dSZTf7o4cN8YJ+NnXK11IXiJWgVp02psXno85kJZRttYVtbG3l2p1TemD9mVucEZiOvg
 yu2+SiWDFc/u3aP9DsA9HPsGTYzc2qxWoXLT0z+cN8AsINf/VzWyUZsmi+i0MWcjw1p+
 kLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OUJwoGvfmw1MtZC6FNnt+5peBTs2ophLxdA21WiuRQ0=;
 b=FsMwKL0dn2UgqIpYX3841kLtH+pNjyX+5K+J5E5TyJU3NzWJuGetUJFtIMfjz44Tzf
 6/eQ7SMB+l3tvqapuzUXs+m0PpSGxjQqgw7NtaWD5DJCRn/4V0LvrAiw66wS1vMDapF6
 fZqJsplRkC3yBsNUoBhy9wOn9dFPh97q2eoqUIMnB+x1L0w6KYnx2os9ChhjfP75tniq
 yUITVsW5nRpfvzjnl03ZrI3TET3JWqNdZzVz6KXzfqug96WZNVk1b+8n7JR4iT4un388
 /B4zIhU8CQN1i8TOrVEun6Vn/gJATPHs2MpH9ZIFWM/XO7QvqTH29cIxoqxcLf9sXVyK
 yctg==
X-Gm-Message-State: AOAM530tz6A7hqf0GAGGOyp3qE+tyvXkgTlceroZ839dmy/2JRyCgHHH
 lyPZVYZHAKVXPocde2U7WX64pGZV8/ySlgSe6GA=
X-Google-Smtp-Source: ABdhPJzFt/amRDdFlZFxC5euttiXP0p2sjPkFIXhvK5uXW02ElLpyEgxPvAzY3xvx5SYT4coeFfkbFEa+vGEIwuE8iQ=
X-Received: by 2002:a05:6830:1e64:: with SMTP id
 m4mr354098otr.23.1624897773724; 
 Mon, 28 Jun 2021 09:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210628025449.3404-1-aaron.liu@amd.com>
In-Reply-To: <20210628025449.3404-1-aaron.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jun 2021 12:29:22 -0400
Message-ID: <CADnq5_NE6nSpfdVRkEbwceU4rr8HFitsxBKDT1ebtY+oNFK0ig@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable sdma0 tmz for Raven/Renoir(V2)
To: Aaron Liu <aaron.liu@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <luben.tuikov@amd.com>, Huang Rui <Ray.Huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jun 27, 2021 at 10:55 PM Aaron Liu <aaron.liu@amd.com> wrote:
>
> Without driver loaded, SDMA0_UTCL1_PAGE.TMZ_ENABLE is set to 1
> by default for all asic. On Raven/Renoir, the sdma goldsetting
> changes SDMA0_UTCL1_PAGE.TMZ_ENABLE to 0.
> This patch restores SDMA0_UTCL1_PAGE.TMZ_ENABLE to 1.
>
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index ae5464e2535a..f6881d99609b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -144,7 +144,7 @@ static const struct soc15_reg_golden golden_settings_sdma_4_1[] = {
>         SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>         SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_IB_CNTL, 0x800f0111, 0x00000100),
>         SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
> -       SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
> +       SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003e0),
>         SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000)
>  };
>
> @@ -288,7 +288,7 @@ static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
>         SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_POWER_CNTL, 0x003fff07, 0x40000051),
>         SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
>         SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
> -       SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
> +       SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003e0),
>         SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x03fbe1fe)
>  };
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
