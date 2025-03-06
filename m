Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552B1C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 14:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB6B010E9C7;
	Thu,  6 Mar 2025 14:44:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OiaoVEhW";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA0E510E9C7
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 14:43:59 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2ff66327419so184154a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Mar 2025 06:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741272239; x=1741877039; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOuXqHLwhoywZeeVkpq77OS6iNRsJcoQHW5JDpHphP4=;
 b=OiaoVEhWI/+VaHSgD4XhdVWzrWn3/Q6fiq95w+NuXiYO4tYABj15M3KwWsPeCybqah
 SA7vh+DjkReakfxCTfZszd57HKz5cMjghTEONQ2rfZvqr2BAkIindxr6HFtGcBaSDuAa
 qOhFa6t5eH417Y1vB1kWj49Zu3+pt6Mw1PkUyjWs4c2+ZYxjNAPI/PDXgIFz2bGw8AtA
 YDKUJUAquKd3YV8rpb0l+yuEZXCuCCt50beeW+tEEgAPKaCEo8v9AtkGMVc/qYeUiuuP
 QX4Ma+7FEBM4JhDAuEmGKfEIb2OxeQVUdk8WOJ3lA0mZMLrZLZHTMh7JRt+PNyRZVRrQ
 AZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741272239; x=1741877039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oOuXqHLwhoywZeeVkpq77OS6iNRsJcoQHW5JDpHphP4=;
 b=mfFQGfKVAHeOuQyg9o+2JbpcbFyrP6OUF7bYbv67MeBKGBu+hN0Qdv+0qxbp2KQmgB
 R5wyKs9Uw4l7/asdZFmFGD/EZ9/4Ns7OBq3MYfq/5ATboLa97C1gaEGonaMPpeYHYswj
 neREsmYE74DQHl12CgZZWB8tN51mUTplYG6tK61ZFqnGtpyxk+zZQNj3yuCiaVFaBqlp
 i49nSukJoLYv+9r0GK7aqunqoCyxAw7xgliGpRzmsWLbaMA4Z4pK7r/Cs13aIuhqnShB
 w/0q+1bzVrjv8A0kfIcJ8EAXbm5x0OS+/xU6rcJ2M2x8CTZSRHrmWvdK23WYYlwHSsce
 a0VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpYQ9LoA1hiYQEsamNcWsz4m0eXgnUfs+gVGzF92T6o96QYGH4DkXKSMD+cKxTQgrA+3hYDTUS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLbNqzbFThHu+fMmTa7/5JFuZB7VVUuAILINMVHNJI9FjCZr8Q
 KQt7cupBar+xmD1H54LhlmniEsww1UEXuBlW7bBOqBoEIzmv6ivxo1wM96CwDh67GOFh3MQvzQ2
 WRe5QqLPM8KC0P+2HXmMx0sGUHR8=
X-Gm-Gg: ASbGncuK3tqIpA4DqkRyL5S4a5X8fz10PIj9D/ew6uUPo4zGGbrZ+vaYD3zsRvWicoL
 VEstgxKaOPZ60GqI9J15VLkJ5H26BG67d8EqWsijsZHqbelmJ87PVSuTxnV3x885svlmkLinl5I
 3QPyk0DUsXm1zNemR9NqW8nFje0Q==
X-Google-Smtp-Source: AGHT+IFIMuqvtdQeTvKmw8diwqa5n4LJl9yYalj1aquXZaD0QcmpHfmxn43WeV147qVRmmThhKGTyHR49xtqlcPEJkw=
X-Received: by 2002:a17:90b:1e03:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-2ff497711c1mr4724924a91.2.1741272239200; Thu, 06 Mar 2025
 06:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20250306103603.23350-1-aliaksei.urbanski@gmail.com>
In-Reply-To: <20250306103603.23350-1-aliaksei.urbanski@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Mar 2025 09:43:47 -0500
X-Gm-Features: AQ5f1JoJiql6AXqg8vp_CW1j7N3EvB_WcR1RWX0ZljQ1MNDzXH3Rf9oQxe6OSHc
Message-ID: <CADnq5_PaxnYBeTVaidOVJzqnj_HfQH-xwYwUmf3BVeZOaQeT6g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix missing .is_two_pixels_per_container
To: Aliaksei Urbanski <aliaksei.urbanski@gmail.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Rosen Penev <rosenp@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Thu, Mar 6, 2025 at 9:13=E2=80=AFAM Aliaksei Urbanski
<aliaksei.urbanski@gmail.com> wrote:
>
> Starting from 6.11, AMDGPU driver, while being loaded with amdgpu.dc=3D1,
> due to lack of .is_two_pixels_per_container function in dce60_tg_funcs,
> causes a NULL pointer dereference on PCs with old GPUs, such as R9 280X.
>
> So this fix adds missing .is_two_pixels_per_container to dce60_tg_funcs.
>
> Reported-by: Rosen Penev <rosenp@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3942
> Fixes: e6a901a00822 ("drm/amd/display: use even ODM slice width for two p=
ixels per container")
> Cc: <stable@vger.kernel.org> # 6.11+
> Signed-off-by: Aliaksei Urbanski <aliaksei.urbanski@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.=
c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
> index e5fb0e8333..e691a1cf33 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
> @@ -239,6 +239,7 @@ static const struct timing_generator_funcs dce60_tg_f=
uncs =3D {
>                                 dce60_timing_generator_enable_advanced_re=
quest,
>                 .configure_crc =3D dce60_configure_crc,
>                 .get_crc =3D dce110_get_crc,
> +               .is_two_pixels_per_container =3D dce110_is_two_pixels_per=
_container,
>  };
>
>  void dce60_timing_generator_construct(
> --
> 2.48.1
>
