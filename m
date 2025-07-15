Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7D9C83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 13:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C0D10E5C7;
	Tue, 15 Jul 2025 13:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RX9gXMh5";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B6510E5C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 13:26:39 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2369dd5839dso8998145ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752585999; x=1753190799; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOkJU66VdpEErh2dlxHaQJ8MzXFCzT3pZGEwTPpEruc=;
 b=RX9gXMh5bteZyFybEPGEtlVsv5t/APWxC0G8BsERBGBa+zeD5VtfX9gKfA4OGY+5B+
 tBn939+sI5CWlNvCck2oPnJty3R+mg/vRqycooVnuPOc87m7A5DTS/iyOjAvaAxTy7Oy
 fbxswTiEtTEbVVPb6g5HkVstu+LEnq96zFDOSjDPxabJUPfuEsnbDMee200f2spaSiqN
 G+YuJVsez1sc2sEKONLyXDu9R4q+fG9z5JGpilfOGgPq7ui48FAjboJI88SYUqIP7gL7
 cCK8qb8e0BqytjX7k/K+bSVI7NHsA73jETHoFjroFgOLjNZCBcVhlM4nT0PZbrknyEXL
 izfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752585999; x=1753190799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eOkJU66VdpEErh2dlxHaQJ8MzXFCzT3pZGEwTPpEruc=;
 b=P9vSL6MQV5NNT+ilCIPmaIuZREpxI7KSrOaHtW+zdspyWOjRANzgGYhAWinljd+Idv
 vLlHakhhSv4ZxDIm3naNUNvDVGzIXkH1ob750y4ZXibcGuaAigkjRs5Rfq9dgwwJJazA
 NaCuL1VExiG7yfN2RxxDrLE3+wthZ4Np0LYAMTMr7MNZWOego43cEHlmcKIm+ZR658nL
 cjPRDA4XDhc2DkvDLq52yAkknmi0U/BTtIZLtb+V9JE5dM6d1HuvQcHu7DxxiJNX0oTT
 uABbZO8rA1TyFkoUAFTpCXPn92KfbtnNTZL1IK3ENs0HqIV/bN2TAdhxZ6ZWxBj5zhjr
 WYLA==
X-Gm-Message-State: AOJu0YzOi8YHSkjqV/tmIqm8zb5gh2SyiC8QGi1cazG0CWxqchN+CTIU
 GAd7VoPPWaExbpay6vIDDvhDFre5TWVIrnLtbnuRtcojSH14ILEbogA8E8dVNzpjb2+iryju1FK
 QkdXhw+4xnqf3Pk89obesVoQPDT34QVA=
X-Gm-Gg: ASbGncsn08z3OXgJ3+1wXnn7+OkURv6Fmol88lKE9bbyBC8thYlfWnP8+0u8ZEnmwpO
 7Lx7WfLbpE+MvGiI1x+LIQWfdDXuZrlHs7dUDzgBzDqKjXSMYaNm5coMToMc12RUzSwniKeNOkz
 wxPJ8GMPlvCNhkW/Rgrc0szwGxJZS+dO1zw/pRjJO2edG3zccVtcz98i5s5biuIxsJuEdvXhz9m
 l2oJtVL
X-Google-Smtp-Source: AGHT+IHtd4X6z2WYd//pkBTBYyQVDdxlMvigsvqs/BIa7M7E6cq1BpofBL1dWpKqzhvdOjDXP50Tys+OUkyZlZricP8=
X-Received: by 2002:a17:902:c40d:b0:235:239d:2e3d with SMTP id
 d9443c01a7336-23e1e9bd2f3mr10265675ad.9.1752585998603; Tue, 15 Jul 2025
 06:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250711213720.48928-1-coelacanth_dream@protonmail.com>
In-Reply-To: <20250711213720.48928-1-coelacanth_dream@protonmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Jul 2025 09:26:26 -0400
X-Gm-Features: Ac12FXxCC16GRez7SYLt7mSd9Ytm5U2B7Zs-vFLwVvAVj_WDsLWiPHP3yAShjm4
Message-ID: <CADnq5_MOAqK9mvBbJfQ=HRofYXisiggnGDdQpcN-8GeGPQ+ZpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix null pointer access
To: Umio Yasuno <coelacanth_dream@protonmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Evan Quan <evan.quan@amd.com>, Ma Jun <Jun.Ma2@amd.com>
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

On Sat, Jul 12, 2025 at 10:13=E2=80=AFAM Umio Yasuno
<coelacanth_dream@protonmail.com> wrote:
>
> Writing a string without delimiters (' ', '\n', '\0') to the under
> gpu_od/fan_ctrl sysfs or pp_power_profile_mode for the CUSTOM profile
> will result in a null pointer dereference.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4401

Please add your signed-off-by.  With that, the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index edd9895b4..39ee81085 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1398,6 +1398,8 @@ static ssize_t amdgpu_set_pp_power_profile_mode(str=
uct device *dev,
>                         if (ret)
>                                 return -EINVAL;
>                         parameter_size++;
> +                       if (!tmp_str)
> +                               break;
>                         while (isspace(*tmp_str))
>                                 tmp_str++;
>                 }
> @@ -3645,6 +3647,9 @@ static int parse_input_od_command_lines(const char =
*buf,
>                         return -EINVAL;
>                 parameter_size++;
>
> +               if (!tmp_str)
> +                       break;
> +
>                 while (isspace(*tmp_str))
>                         tmp_str++;
>         }
> --
> 2.47.2
>
>
