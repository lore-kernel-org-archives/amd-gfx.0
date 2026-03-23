Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E7DF483E5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE1FF10E43D;
	Mon, 23 Mar 2026 19:08:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kifEgu6d";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 524C210E43D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:08:00 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-128bae6a35aso291773c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 12:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774292880; cv=none;
 d=google.com; s=arc-20240605;
 b=HlsU0muqmdfLtnon5AiJXuZAT3I5QJRSL55uatrLrFqkuYE7wbNtkUovrBa685pAz5
 uCSLxnm/7m3nempXqZVfYPbtWIPuF6IYwROhu5JwiWnmi9VbK31pGbJTqtbmh9o9drL1
 7IJkXDhNWwComq6wUfWaiI3rWj/Ur+IjKlxtOoyxG4XkoaU2veZfLG43XIKdXgeerxwj
 Q7Z0DdgJpOHUUk7+ISHbm7OF1luzozS4ycApFhDT9MJgohJBm9fLZVAnwJa8XrGPakfN
 LN310O8zytQtA1IDpRGhI811yrtXWN6OSz6Ft4cpfn9LErqNIP0gbnI9E3uFWuadT9Qt
 ITqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oeJImWPCSRYsbid3lcSOPoNjiu+PVUP21SaaND1GrKU=;
 fh=OvKzi3YaVdYQcj/ttN/1Uz8prEoy1Xr2B3QHReZfFdY=;
 b=CK5zL77QmoqeYpnF+m3KNB7qID1w8DpGkkvwBslW5KeZ0sidcbr81oV2PhYF81Y1BF
 7hKdzJNuxj/pBO9W9Mx9/avIO5prXaUDXeHeTmlwD24gRrI/8+ebcBeO7ftgy9dJ4Wu5
 tjUieYENPb2sIs+KA+7dtKZHsovIvyes/AyJD9Sy0vU/3TP0DwrAMZgkppV/ORK2Zl0R
 HoboO6EzMfmWNSIsPA1yz8/y6+RSGNVKadmTSP94frfasqqxxOJd9hOUDhMhTzb9sW3E
 WyCWcD9WZk0axLnGxb5t2PSCsYLVdE6tcOol417VXEDSrANPvnipWou5F8hgEhCJJHU9
 WewQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774292880; x=1774897680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeJImWPCSRYsbid3lcSOPoNjiu+PVUP21SaaND1GrKU=;
 b=kifEgu6dVAbbHp0NyLibdmUXCsurH9Vvi6p64uMSVTfHf78XmxHFI9cVKkj+eXlrhQ
 su6BJLcT989mZru+sUoEiLnG32VexkIBXPB0Q2BW5OAvG659UlBaBQylrfGGiHsOz+68
 I8j66MWKWSD6SMDysJByZGj0kzSFzsLLuetCVDXPzRG+NohfQc/uNgFSeFt1dBEsIp+M
 O8rR/wYACnOlTDZU4Jn8UR+/iwIeAa6zkqN82+6NiQrGQrsWklRc8YqIH+MN+Ll4SCQJ
 ywrYpzUWfjLTlfesqGVgpZ4oIaHte7bGx2Tq0nLuhspOI00mcSdhro6SafIE1MmhuhHW
 FRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774292880; x=1774897680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oeJImWPCSRYsbid3lcSOPoNjiu+PVUP21SaaND1GrKU=;
 b=iP5Gcw1qE/3cxrCoOgt82OSOazDZIIatje8phMAyxm97EKTyrscAGkKoSgFsTExbtR
 dWYsmsqMS6nQpNRM45ASQAmvwrJ2tAKQe1yAUH9aqaamdlrg4jxD5frFLqQKoKbtUc6u
 YS/4KZaLfB1tyPDabcUHGZtv5JUNCDWixCqASdWpDlq9wWDE/VKZ9eZT2zsGdeMfQkas
 Wyt+cntzbCp49yUon3FlpT5WAwSqMdYqVesC916tAubdgJlChSqjicT14goKlWPrfC3l
 l2TuOaRPRarirq38qADDmzlp2oDVSrW0GnKdBd0dXqZ+8+qTSs7fYQuWfsQNqD3hDMNK
 kC+g==
X-Gm-Message-State: AOJu0YwxelnnGyyYuDfTag+zglBRobkOhAbGRdq7DYk5xvZzNw8CJXJM
 06mgMxMzFZFF/IqJpV4H/gkKhRjEEN0GtEwp7IkpUauF2b4mQl6M9xJ6eL+ukcv8UFGe+725CCt
 SGeYSIQQhWpDSLtQPhBaSJxCfWc+6oQw=
X-Gm-Gg: ATEYQzxMdEmPHnBJddtuiL6Qo6fI8oh2C+XeP/7LrgKmOnIB2ENI6SqBnjs/IDuGnJq
 yD+6lbNqSKXBQFlNnlXTIKhxEU82CSGv/bYC2/wYLPtL60ZxNw5zpw0Xu7squLJ/QdCXEpdqqR2
 B86Ic1GF+mMTrbuOmruao2MHdo4Y5bsplNbL/de60CF2y0HtFrjsz294m6bb6d4cjx3kjgVX3YS
 tap2rehq/Rb0r4sEOxmfD0iJuKuZRoE90s2kU66z51QmLBDfGOZGrdiw/3sYcpA0zr01UPviKVB
 KPlBUoySqF3QxFppzDTeEi7nN6R+oaqkc7s0GBZKvA38RYoURFNZ5prfY251PXvJlXwLVQ==
X-Received: by 2002:a05:7022:627:b0:128:d4d5:93b9 with SMTP id
 a92af1059eb24-12a726e1475mr3789239c88.7.1774292879605; Mon, 23 Mar 2026
 12:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
 <20260320200208.1188307-4-Amber.Lin@amd.com>
In-Reply-To: <20260320200208.1188307-4-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Mar 2026 15:07:48 -0400
X-Gm-Features: AaiRm50wWsG5fJPdg3-6YscBk-afPm5DDi63N0D15dmMxPU_9CbwqH9Amv2tAF8
Message-ID: <CADnq5_Mg3s7eO_jAzRMfeYjx=eKwWsCXHkDLfOpfMGbc5qirrg@mail.gmail.com>
Subject: Re: [PATCH 3/8] drm/amdgpu: Fixup detect and reset
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com, Jonathan Kim <jonathan.kim@amd.com>
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

On Fri, Mar 20, 2026 at 4:02=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> Identify hung queues by comparing doorbells shown in hqd_info from MES
> with doorbells stored in the driver to find matching queues.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 38 ++++++++++++++++---------
>  1 file changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index b68bf4a9cb40..bea509f6b3ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -465,23 +465,35 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct =
amdgpu_device *adev,
>
>         r =3D adev->mes.funcs->detect_and_reset_hung_queues(&adev->mes,
>                                                           &input);
> -       if (r) {
> -               dev_err(adev->dev, "failed to detect and reset\n");
> -       } else {
> -               *hung_db_num =3D 0;
> -               for (i =3D 0; i < adev->mes.hung_queue_hqd_info_offset; i=
++) {
> -                       if (db_array[i] !=3D AMDGPU_MES_INVALID_DB_OFFSET=
) {
> -                               hung_db_array[i] =3D db_array[i];
> -                               *hung_db_num +=3D 1;
> -                       }
> +
> +       if (r && detect_only) {
> +               dev_err(adev->dev, "Failed to detect hung queues\n");
> +               return r;
> +       }
> +
> +       *hung_db_num =3D 0;
> +       /* MES passes hung queues' doorbell to driver */
> +       for (i =3D 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
> +               /* Finding hung queues where db_array[i] is a valid doorb=
ell */
> +               if (db_array[i] !=3D AMDGPU_MES_INVALID_DB_OFFSET) {
> +                       hung_db_array[i] =3D db_array[i];
> +                       *hung_db_num +=3D 1;
>                 }
> +       }
>
> -               /*
> -                * TODO: return HQD info for MES scheduled user compute q=
ueue reset cases
> -                * stored in hung_db_array hqd info offset to full array =
size
> -                */
> +       if (r && !hung_db_num) {
> +               dev_err(adev->dev, "Failed to detect and reset hung queue=
s\n");
> +               return r;
>         }
>
> +       /*
> +        * TODO: return HQD info for MES scheduled user compute queue res=
et cases
> +        * stored in hung_db_array hqd info offset to full array size
> +        */
> +
> +       if (r)
> +               dev_err(adev->dev, "failed to reset\n");
> +
>         return r;
>  }
>
> --
> 2.43.0
>
