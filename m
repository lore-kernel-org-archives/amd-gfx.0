Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06F7C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 21:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 706ED10E311;
	Thu, 25 Jul 2024 21:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O1yipHev";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7EEF10E311
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 21:41:14 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2cb64529a36so252593a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721943674; x=1722548474; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gyg5+sSAwTVVYZKpRyStVR6rlyD7mkf6vJfBogvLiSc=;
 b=O1yipHev8yOwM7rgjPn1Hie1kh3azV2V3FexL9bMwWoyfaqGHqPqOIb1jx0HG0B510
 XV6X8cqVseyRD2t0VIGQIqxzcu5gpmwGPAi4/UPgFEc4+RAyieNnfbY4TtdBePM13nAS
 DGe0caf/uNLhDA15zmwIB5vgh0R7pydeJWnkKHa7zhHhWB3HqNnd5uxjkg9wlMSPHCwN
 zAabHggGLts5DgLYkNLy3ICI/y4/xSF8cb0/ZATc+efYMmamV7ofgGjZgCZK+4fmQFfe
 Q8Yb7+EYYeWFwUlq7zZVEtvwEwQ1yGycN2LTPJoxph14TdefNJROOKMMCkbxoPFR+bSD
 VUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721943674; x=1722548474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gyg5+sSAwTVVYZKpRyStVR6rlyD7mkf6vJfBogvLiSc=;
 b=OhsQFDOpeHb0SfnErh1LPQnk2jC211fTBKeswhnNf07sWC62z9yQFPEmeNzqT2MsLh
 6Qa8J+2pkLGta9q9MQFG+b/mSf1DTy6sjSjwi3c7FcNMHHXoT97Bahxzp7QYlyXwG1y7
 Fm4zJ8yFHTEfDu0b2OqEdsqC0f6KIyDyT0Li5Iq/ALBVJj8HGn+1iWYglq2bX9T00Nrd
 I8oL2Mafd2uA84EzSaicxzX9gY6QP6Qm0xETtGYqQzoNWH5t1uUAQG9uDgRsOdXUSQsu
 KuOsTaV4zORve20DVrUI0cDNTgaONgOBUsZZ4jGp7Jp1ayFCAqO5fT6rA44yUWbBln7Q
 zGPw==
X-Gm-Message-State: AOJu0YxbdCUOBCPGr2zn9VjxEDuEgnAyQCDIh+j8amQcNHhxzCY0Bmzo
 Ep4loogX7zGz/kOj/fGTsYsD0S0/CwaULvj3OJ0XB5uZvDezcKR0uof5To+tQ5OKEm6JYBR+Nnp
 8cuH8zwvc4vlF1KQ2c6aNM669rcY=
X-Google-Smtp-Source: AGHT+IEJsXpREVxQ8y+e2JVo/7qugR8fyLsMvkbVnZBUboWK9TUMRBKJ0ET2QZihiFycCCu8p53bThjYZEik47fbYw4=
X-Received: by 2002:a17:90a:c907:b0:2c9:8020:1b51 with SMTP id
 98e67ed59e1d1-2cf237864bcmr4917481a91.3.1721943674230; Thu, 25 Jul 2024
 14:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240502202216.3385044-1-alexander.deucher@amd.com>
In-Reply-To: <20240502202216.3385044-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jul 2024 17:41:02 -0400
Message-ID: <CADnq5_NsEWDX2T05PvaQHccLE8S8zUWYEeCmVn=4wEm+p1DdHw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: update documentation on memory clock
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

On Thu, May 2, 2024 at 5:07=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Update documentation for RDNA3 dGPUs.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index ec9058c80647a..9ad114e695e5d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -610,12 +610,18 @@ static ssize_t amdgpu_set_pp_table(struct device *d=
ev,
>   *
>   * Clock conversion (Mhz):
>   *
> + * Pre-RDNA3 GPUs:
> + *
>   * HBM: effective_memory_clock =3D memory_controller_clock * 1
>   *
>   * G5: effective_memory_clock =3D memory_controller_clock * 1
>   *
>   * G6: effective_memory_clock =3D memory_controller_clock * 2
>   *
> + * RDNA3 GPUs:
> + *
> + * G6: effective_memory_clock =3D memory_controller_clock * 1
> + *
>   * DRAM data rate (MT/s):
>   *
>   * HBM: effective_memory_clock * 2 =3D data_rate
> --
> 2.44.0
>
