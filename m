Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85518C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 18:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F3610E3CB;
	Thu, 30 Mar 2023 18:24:00 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E0D910E3CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 18:23:58 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-17683b570b8so20644478fac.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680200637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZZsLdHbwftk4nXhT4cyv/PZMfhLFGXGFRP3AZuWzrQ=;
 b=OcfQjYvIdaO7LOmGKyhLnJlmsXtF8qs0ncrjaHOxmr26uFxmKvjVhzwDlbZPGz66mb
 5kCCDfarF4Vj28tz/G5Ev60fxrrHHlMg+2sfnBp14sxOEORC442pgiFmq43TZcr9RUoR
 42QyHnYhqKEtwcW/4ONfyHWSSSeXDl5iIa5LfiF3K/cxusR5QpFeKRAISpy3BCwAbLk/
 bbJRinQh5dl6yQ3j4RUXLgyT5Rsl1U1ERQ3WyKp5Aqu/vHhQJFcx1GHgn8f1xiywEHa0
 ta5Oj3YNszLeIOGcUbNDcIq8WRqS+jr/ql7Qd6bIa4U2ORcA5ysy6HlHexr84yU/a9am
 Fs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680200637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZZsLdHbwftk4nXhT4cyv/PZMfhLFGXGFRP3AZuWzrQ=;
 b=RJKJ648OLYz8+cp7zp/xxT4b49nUciOzhGE8BncmZzyQ40QQM9RLb/FdAJtjcpAiJP
 XbCXos28w3PYsSG7uIMYTLe0JeFm12mMpi0kAevq2gnXPCAYq7jPxxhEDqjr2/3gkZxU
 lPJ7E5dHtNqFqKWCFwaanqwK4tk1WzAhG7KNjAxtVFJhqoinQVUK/ORbiwRSHarnAqfV
 kOqLN9kc2lbNdSxLlO5OMOeG0M6HWg40mulYqUchRtwh2YhD9wP1rdmJ02qfFxa1PZWv
 Dh8Ekz17ITwrGZRv9Ta8f/KiQx9BC535unR2hjhFpQpsiUwp5tPRAuFYolIPnDcEJHUr
 4buQ==
X-Gm-Message-State: AO0yUKV7Iiqqz+dRBJj3qYpJNSxhNwa+XO6aNcMz/pZ+BN7X3Rx8ztrv
 Ldg+bJk6/Mh05Is337yb34VToFQA10I4SlA5kQl0vwgn
X-Google-Smtp-Source: AKy350YvWOjM4s9CfN0juHiWNNb0WY3kkZE664HLdGB66v15pi4SO/+qax5oSOjM3GI3QMo2Rgtw0NVR+iuKyLlideE=
X-Received: by 2002:a05:6870:1114:b0:177:9150:e7ba with SMTP id
 20-20020a056870111400b001779150e7bamr8105940oaf.3.1680200636605; Thu, 30 Mar
 2023 11:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230330144045.466110-1-gpiccoli@igalia.com>
In-Reply-To: <20230330144045.466110-1-gpiccoli@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 14:23:45 -0400
Message-ID: <CADnq5_PxtSF=dYjRV=7Bc0XpNbakquD=KOgrbaocLR61SHqbJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix incorrect comment about Vangogh power cap
 support
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
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
Cc: Xinhui.Pan@amd.com, Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org, kernel@gpiccoli.net,
 Melissa Wen <mwen@igalia.com>, kernel-dev@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 rodrigo.barbieri@canonical.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Thu, Mar 30, 2023 at 11:32=E2=80=AFAM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> The comment mentions that power1 cap attributes are not supported on
> Vangogh, but the opposite is indeed valid: for APUs, only Vangogh is
> supported. While at it, also fixed the Renoir comment below (thanks
> Melissa for noticing that!).
>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>
>
> Hi folks, this is a very trivial one, just to fix the comments - since I =
needed
> to re-read the code/comments to figure out, I'm trying to improve it here=
 to
> avoid others to get confused as well heh
>
> Lemme know in case I made some mistake (even after re-re-reading the code=
).
> Cheers,
>
>
> Guilherme
>
>
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index d75a67cfe523..6460906c354c 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3351,7 +3351,7 @@ static umode_t hwmon_attributes_visible(struct kobj=
ect *kobj,
>               attr =3D=3D &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /*=
 can't manage state */
>                 effective_mode &=3D ~S_IWUSR;
>
> -       /* not implemented yet for GC 10.3.1 APUs */
> +       /* In the case of APUs, this is only implemented on Vangogh */
>         if (((adev->family =3D=3D AMDGPU_FAMILY_SI) ||
>              ((adev->flags & AMD_IS_APU) && (gc_ver !=3D IP_VERSION(10, 3=
, 1)))) &&
>             (attr =3D=3D &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
> @@ -3360,7 +3360,7 @@ static umode_t hwmon_attributes_visible(struct kobj=
ect *kobj,
>              attr =3D=3D &sensor_dev_attr_power1_cap_default.dev_attr.att=
r))
>                 return 0;
>
> -       /* not implemented yet for APUs having <=3D GC 9.3.0 */
> +       /* not implemented yet for APUs having < GC 9.3.0 (Renoir) */
>         if (((adev->family =3D=3D AMDGPU_FAMILY_SI) ||
>              ((adev->flags & AMD_IS_APU) && (gc_ver < IP_VERSION(9, 3, 0)=
))) &&
>             (attr =3D=3D &sensor_dev_attr_power1_average.dev_attr.attr))
> --
> 2.40.0
>
