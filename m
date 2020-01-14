Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C18C33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF8C24658
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRhZJbO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF8C24658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9F86E438;
	Tue, 14 Jan 2020 17:39:27 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54A16E438
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 17:39:25 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a5so14844741wmb.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 09:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bv0KVrOAlAqefoO1PWOexO7NiqkRml+lZ1bSZfhIiM0=;
 b=sRhZJbO5OE8STxNKt8WuOJ2VicLSkC+kP8k35R+fOjUzY8y4DSQv604oeCgNAV6VKK
 w3uNLpjaDy4Vi2HhkTvRHYN/g7DQxGmLDECcHLt+RfdbGq0SUkXgHPocZHXBhWkPgWXP
 aefr1CCuX4IxMF48EEm+UnZdOC4wpwPt0YhAc0VtgpfDkRfHr9mLIe4e5Zp6EjzT+d8v
 ybKheYPpfyPHeDMcCWI+ox9MTOAiW0ntCNfM5t2T3xOzU/IDBqacd+Kj566P3DSnHYL8
 8W3dtmZ6d3Ldy0GZd13do8CLoMLZ421I0Ymrtq5PCy+0xCk//baiamXjm0Tup7WnA7ZN
 5cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bv0KVrOAlAqefoO1PWOexO7NiqkRml+lZ1bSZfhIiM0=;
 b=Lz63XME1wytZt/PaHV7mZ0PatEtqatH67edK9KBee+kHhuR4hazXP+VZBr1Svmbryh
 jh5OCOiit5nYilMvywNHVV2ZbKG1U6bEoevXzqR2b/b7/BuJz7eP+fJNve7vNCMIHx57
 +htB59KFnxTrO9XtdYMOkm9IODQj4yEaj8YXKCS115srKXG6hABQStla7qENxFtlW/L6
 THa6rbVjBBp4+Gl4h7is2P88sPrwKuqXGJLlQXN6ZacawP38EfE19is5eTMuwz6AAUCG
 d8+7S8ps+shmO9/6EnrG01s2u3TBG0H9OfDO16DJOEYJSYr5DXmedqlzk8XjEzHaQ6Ys
 ALmg==
X-Gm-Message-State: APjAAAXHJ5/3eWjKQkjKqC8Zx+4moiZjqRTbSVG8KuQzXNXWX1MHLFQe
 xE0Bz0BUpzLY1p75/OEhbyIQT+EscNiHq2B/MOw=
X-Google-Smtp-Source: APXvYqz371URssC9uNm0Rrdt9QxXlmFetqgy/dumVZeOqZ33yDHp1iAEVnTH12gaIrjm5pM5ITzNVCqfSPGt5W0h4UI=
X-Received: by 2002:a1c:f210:: with SMTP id s16mr27747275wmc.57.1579023564300; 
 Tue, 14 Jan 2020 09:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20200114112841.17148-1-tianci.yin@amd.com>
 <20200114112841.17148-2-tianci.yin@amd.com>
In-Reply-To: <20200114112841.17148-2-tianci.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jan 2020 12:39:12 -0500
Message-ID: <CADnq5_PcAGeuzi1wAJvfd_sju3RwmsmQbyg6KMzfijm97QdGeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx10: update gfx golden settings for
 navi14
To: Tianci Yin <tianci.yin@amd.com>
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 14, 2020 at 6:42 AM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> remove registers: mmSPI_CONFIG_CNTL
> add registers: mmSPI_CONFIG_CNTL_1
>
> Change-Id: I0bbaeca184e7dc85463d6c5740151d6ba1b08c06
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 4f6ffaf3f9be..3c9082b1eea9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -169,7 +169,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_1[] =
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0x00000800, 0x00000820),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL, 0x001f0000, 0x00070105),
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1, 0x001f0000, 0x00070105),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xffffffff),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000133, 0x00000130),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
