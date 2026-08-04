Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3C5C5518F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 14:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9BB10EA7E;
	Tue,  4 Aug 2026 14:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LX0zsTy0";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C07AB10EA7E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 14:11:19 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c9b3f380006so561767a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2026 07:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785852679; cv=none;
 d=google.com; s=arc-20260327;
 b=YlTcCO/a3aNuQKxW3l4q+WUQhXUcQjpXQK8W8X67WMDrIwu+VMFEpvzy9M7wvuePNc
 YpPwuFoI4UKVgYCF6JDJ7YOnN7KOWRzRuAjUpwJsXuuvlnilNjjxzS4v/3Fim37hd2M/
 cNxtmxvbpx4rQZaTOFMv7Vqd8ckSVCV9lxntmNNQL8RWqmBAWNsHj8H5h1HyVgORs26V
 KU/0Oo9913HdRvrgaxQgHIjrtccZpZ45Gpft8BWORJuoMq+KkhtmpvV7+7HjeKvEOTqz
 n13BQ9gkbI4XOSkTWJU1VFXIXkRr04AIyU3+VNndOOUz2tvIeHux6X8uxxeT/IUvWYgv
 HLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9573ZgFGpxY/w9OExlW8vi5rfmnaJLIY8zIRbwzaQoo=;
 fh=a1F/lY0pz1+bbO1QiJVWcdmrA51AZqlW4BvrL/Orn9w=;
 b=IGFKvcPDMYgzcNr3AcZBhRPEGEOCOlK72vL26cwVtXmbqXzkdOK2o+0rKEIrE+mlWn
 na1zW9osGxyg1Jd2aDE+iMOjBNavNl8QiziGYISwEzKyK2KABjATaxx78SVy0lJB6fKP
 x5rTw5x0hLEkCyqdtTMxuNeWdqZjzIHlAzd3RbwkCdrRGQ9zyBg5QdKIN3D5wrvfutmj
 Sl3B/uAENUXr9b+lC4oyyB36H3EqhqtMgCFaoiFDf1xJtFAZP0aXAaOFmZbcMYN0d+fK
 zqSeRhYLKfmCX/dV0UkadnR81yZGkT0MG6v8zlgLCq+zdu/QMm0JUfWkEe0xSv4Y0a5X
 i5Zg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785852679; x=1786457479; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9573ZgFGpxY/w9OExlW8vi5rfmnaJLIY8zIRbwzaQoo=;
 b=LX0zsTy0WI4mYRF4gxgrnyrEZ6ApYoWcFe973Y2isOFL/ovxJ40sQilJ9RzMMzcSMD
 F45EY72jfceR6fE6eSlZTyu9pWYUxymp0KTTgupVnUO6IicwVNXpwg9NuIxwvg3ab+8o
 QfIOdbd8En9yd5KDOu4dU9xqHhU30rDbrDHdkQzSwynweuUV81e3uJC3kuJeaMeiUM3c
 9CSBjO5hp+0SWnBzDvsuLupRxZdWk6XRQoDad954LuIgn8nd8VolJRxlkiTEssuDN9nv
 h1db+12D1vTfV6BN8MUppeT9qpMs2eXA9Q2wcmtzG76EfgI675hGU1nc4w5cFIGLfAAN
 s4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785852679; x=1786457479;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9573ZgFGpxY/w9OExlW8vi5rfmnaJLIY8zIRbwzaQoo=;
 b=fzw50S+5/LjgJpLOrwrYGU14MtMtlnwLWs/BBYnSaU04hM7wU7MWLLVFy9XokfBPgZ
 rLW3mDvF0RfDEwmvT40J3VR5IfhXJEi172WF1y0M+0zwe6EH5nb/kh74eKf5lJgWFiqy
 JEdnHZORdxQr2/2PGKKsrM6yFxlN+Xzi6AQeknVxQHy3dVc8/hHMbre9rzsY+UlvJBtz
 Eq8CRVxw5QWVEB72x1O6AmPEk7ruwiaZIU7d6yjI9IZk3llJee6ovrAlzRJ/fZI9+XcV
 MjTOmDOqBsQNbvSJozI0nG9awr4RmI4eXTatp8mq61p76moXKGoW0PBdTQDDtQYSNqGu
 KN4A==
X-Gm-Message-State: AOJu0YxhCuy5UFsp13u1vcWZ/8sjiTjrXm4J7S2ZAmxJO8/BmW/S4tyN
 vVQJPZ0GnDfimmTPlqMONpfRlVXXgV+iQgPOAEI0ljnE00T5ZT5eqlR7hYyL03Nl//jeiHQMArs
 8KyWRgrovgjvLY0mRazLEsCfqMMMe5IClHg==
X-Gm-Gg: AR+sD10Zzw/P+Sr7XHq7NpINtNL13D/00Wsu/Y1KbDF8Q1ev2poIj2OgyCA5QQzmdQo
 2N9kixDUd9Km2TmJTXiXJyjEAEcU4FxXKLJSbwZmRiHeBJkw81rOInEVnNBuE0DQNaNNzDioxhC
 +eAhRxRgzqA3t85Co0rywoeLZ8YusDRmrHXqiv5qJh0ke8+iD9Rmjkkm8F27+MG02dHFR+DDFRq
 9B0DFJOueHFCZLqB2WDHme/43pKSayCOoyczAJVqYLw9sRG7b5XYzRv140uryjUIVs8TkQfA4Vu
 5zdVU4hbB/1+Lqdx1UhmrGmNn6OG2y7mE6YDndkNV6trAhCpgAAOY1fcnHSacjcM0+4sF4DLV8h
 sJLu0/IJuNOjbQIpqP5gE5q2t+z93FK85
X-Received: by 2002:a17:90b:562e:b0:36d:b30b:14ed with SMTP id
 98e67ed59e1d1-38fbc4ad251mr18806626a91.2.1785852679171; Tue, 04 Aug 2026
 07:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHSgyMMBq9zbcAgiFz75vM0_oJRi+YkKap2W9=L_Na6Yu39zNA@mail.gmail.com>
In-Reply-To: <CAHSgyMMBq9zbcAgiFz75vM0_oJRi+YkKap2W9=L_Na6Yu39zNA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2026 10:11:07 -0400
X-Gm-Features: AUfX_my77WErq2CEtzVCswTDK17LmNihNDiXts5eRxNYQvYIzGM55C749ViZ8BU
Message-ID: <CADnq5_OL6_WQYmNev241VA1HMgSgyG6BynbZM_AtXUSDOyGiTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Disable DP audio spread spectrum for Cyan
 Skillfish
To: Travis B <tbangs89@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, 
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>, harry.wentland@amd.com,
 "sunpeng.li@amd.com" <sunpeng.li@amd.com>
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

On Tue, Aug 4, 2026 at 3:28=E2=80=AFAM Travis B <tbangs89@gmail.com> wrote:
>
> From: Travis K. Bangs <tbangs89@gmail.com>
>
> The VBIOS for Cyan Skillfish devices (DCN201) indicates there is
> DisplayPort ref clock spread spectrum downspread, so the audio clock
> is corrected for it.
>
> However, the clock source in this hardware does not seem to actually be
> running with a clock downspread, so DisplayPort audio desyncs with video
> after several minutes.
>
> Ignore dprefclk SS downspread on CYAN_SKILLFISH2 asic.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5429
> Signed-off-by: Travis K. Bangs <tbangs89@gmail.com>

Applied.  Thanks!

Alex

>
> ---
> Submitting this patch as requested by Alex Deucher.
>
> The system with this problem is the ASRock BC-250, which to my knowledge
> is the only GPU which uses DCN 201, so this should not affect anything
> else. I have tested this patch on my system.
>
> Some relevant register reads:
> dprefclk is set based on the value of register CLK4_CLK2_CURRENT_CNT
> which reads as 6000.
>
> Without this patch DCCG_AUDIO_DTO1_MODULE gets set to 598874.
> With this patch DCCG_AUDIO_DTO1_MODULE gets set to 600000 and audio
> stays in sync.
>
> I am in contact with about a dozen other BC-250 users who have also used
> this patch and reported that it solved their desync.
>
> There might be a deeper underlying bug here but I think it takes AMD
> insider knowledge to fully understand what is happening. I am glad to
> provide further info or do further testing if needed.
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1820547b1dde..941c1a312824 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2189,6 +2189,11 @@ static int amdgpu_dm_init(struct amdgpu_device *ad=
ev)
>          init_data.flags.unify_link_enc_assignment =3D true;
>          init_data.flags.usb4_bw_alloc_support =3D true;
>      }
> +
> +    /* DCN201 audio desyncs using DP SS */
> +    if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
> +        init_data.flags.ignore_dpref_ss =3D true;
> +
>      retrieve_dmi_info(&adev->dm);
>      if (adev->dm.edp0_on_dp1_quirk)
>          init_data.flags.support_edp0_on_dp1 =3D true;
