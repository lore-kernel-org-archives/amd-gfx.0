Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FA2C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 13:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A382311A456;
	Thu, 25 Apr 2024 13:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jXVlRSYE";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 433A111A456
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 13:14:17 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-6ecf05fd12fso897322b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714050856; x=1714655656; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/04NPuWph/f1HHWfFX3p4sMMZaHwUX78EXYyCvVwOg=;
 b=jXVlRSYEPn8gy3fLmCgNjvfWR/w85E8lycev+KPBigyozcokf/VBkVKsVZu7/HPFF7
 LvR9+QV/uUPk8FfHA6qFUxGkn7CpATcJeZ7GTgEU+CJi5Lsy+fR3vDZY1us8SoYzcHWh
 iJUXZiyeh3BWaONSNGA8m0k3uEAcd1jGvD0Z6P/YilqCbeW2lo0hJMUr5Y2KoiqUoQM4
 /OdHxmKuSm/jiVdpUfLMp1DTFGRaUufKTCJNY36rtfP0IOyBoostlTNqZAGUOJCRqIii
 G+b6KfSCCcDp8fCw7LnjK+SVeYzQdE/bjsaCkeQTyViCMFm5FSE5toAuV0NPzlnHGSvF
 l/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714050856; x=1714655656;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/04NPuWph/f1HHWfFX3p4sMMZaHwUX78EXYyCvVwOg=;
 b=R+oAVAqMpYl5/qJ88+e+hre5XcDcPUgGrzSLJbzwyFDgYxfewm+StMmIwSM+j4ayH8
 feYDO3s1MtueLYfA6Vmiomk2/5PEeagYVLW692RDXdZHb8RcaARpJFgoP5F2DiAtwPAo
 TmZWlyJbHWWuNMumbZJ94O0NO3aySLwchoTZrJakhnCWkjQdLGj0SMNgAXUV9WD3YRWd
 ZR4y0KSICLc9bw/kO8WBCa9HsHYywVcQXTrKVwHkITwLjkflXP+Dj2dd8sFGi5fFyNcM
 /zB8aLlPtUqQiED3x0mEtO9qplzOy3edjzvIxejVauS06pgKEZZA9mS3GgQLIYxBUC2h
 9ccQ==
X-Gm-Message-State: AOJu0YzUp5EO3ma+kvRBPQxtY42ZLafSBqgHJetSagQ0I8iJd8sc2Ysk
 s9pnAPs3/gdTW0VAFIbI9XXGQKZg7Ti/RC92H0sySnLTJGuqcM3COuP7xPkoaDdqibJ96DwD3lt
 zF0gWxXrPJ4J7NrotMYqbs+K1G6RIug==
X-Google-Smtp-Source: AGHT+IHOxtlpio+iaVAkLFbJLlpIR/y8XsImP6MADnnKXNUjizIepD0Y5uU7UzxCXGwCwrtRomSuXqF3ZwCQwNMVRQc=
X-Received: by 2002:a17:90b:1a85:b0:2af:76fa:fb3e with SMTP id
 ng5-20020a17090b1a8500b002af76fafb3emr4053609pjb.45.1714050856526; Thu, 25
 Apr 2024 06:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240425100027.637016-1-Jun.Ma2@amd.com>
 <20240425100027.637016-2-Jun.Ma2@amd.com>
In-Reply-To: <20240425100027.637016-2-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Apr 2024 09:14:05 -0400
Message-ID: <CADnq5_ObVpXHZDixBZfVo_ByM6fjmsJAQxz6fL_X5VZPFnGeiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Fix uninitialized variable warning in
 amdgpu_afmt_acr
To: Ma Jun <Jun.Ma2@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 Alexander.Deucher@amd.com
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

On Thu, Apr 25, 2024 at 6:07=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Assign value to clock to fix the warning below:
> "Using uninitialized value res. Field res.clock is uninitialized"
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_afmt.c
> index a4d65973bf7c..80771b1480ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
> @@ -100,6 +100,7 @@ struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock=
)
>         amdgpu_afmt_calc_cts(clock, &res.cts_32khz, &res.n_32khz, 32000);
>         amdgpu_afmt_calc_cts(clock, &res.cts_44_1khz, &res.n_44_1khz, 441=
00);
>         amdgpu_afmt_calc_cts(clock, &res.cts_48khz, &res.n_48khz, 48000);
> +       res.clock =3D clock;
>
>         return res;
>  }
> --
> 2.34.1
>
