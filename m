Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2A2D2FEF5
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 22:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E43410E5D1;
	Tue, 27 Jan 2026 22:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VBS857KQ";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D524010E5D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 22:55:21 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-124a55b7bfbso18773c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 14:55:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769554521; cv=none;
 d=google.com; s=arc-20240605;
 b=Y8Khju5/BSMvPLDaH0zgEXT0uDmpuVCsg2CK8GcnMtdywh8FzZfzFmnXgnc6It+Pqs
 r6JW0LRwOMQhNBNEr4mvCYzC95DMoSoyIoh8FiS9Hf/CqSKgYBKRF1mJFDQmHy+RSQvx
 luBWJoZtLDaFae989QYVeGzU4s+Kkukaqm4B+SjDRip6EHhLjSnneRPhwC10+fITP6iW
 qIe/cqs42gsZoAuFlLpjSEdn8+RMp9x//Sgm3MLdONUxaK0S4yi8N5j1PX2/ehP8QNgb
 5l/VluwYZGx43Lq0IbBWAgnSUngFNjKM4b8NcwDzj4PR/fJSm/JUrLyZHk5EHBdv+Gez
 y85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/VvX2MAN6SuZMPA6a97goqJuC4zc+gOJNWDk55dUus0=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=DeVewvFBbYQuL4XU2OrdyDhUX42uxtPPq49JEJB5m8hYHXQO3T5gfI2BjDaGNQjDSc
 ZQyPivuIAu3WzXgwaV+cAJnU+IT48MMdwFYrNR03uHTx/OcJugweAJTolHnZio4ZCbek
 GnflkQLRMgEfE+y452ts0Py2U6Dg7AADCMvuoCjRQnIPnYN7uhHiiIcM2X6V5jk+1nR8
 WRa9p8iah/mdshWyySV9J+FjYMOGEDPTaAYQmJ1JORA6ev3mhfohzKBNyHyyUCNH7VUi
 HgkeLNCu2ATz5Vgcd04/4YnX4pP5zLU+vkeEGJS7LsJWFHzAsvu8LgqAQJwEV5TsSNT8
 JzuA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769554521; x=1770159321; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VvX2MAN6SuZMPA6a97goqJuC4zc+gOJNWDk55dUus0=;
 b=VBS857KQkWvFdv9DTP/LneNGHlOrNVuoqhHoCmzt7hMkzxnYkM5om0h0AsKgpTZtXU
 XxdglJj4zt6tM447Ut3N4UlgbokR8bS4IqEEmnEZ3ZpgR5mz/Oc8ktWdosNja4OJs6NM
 57OAUxSbPqyj2XmSulsyG8R3IbDJrHwDMcgxn7LDLN8Jj8/Z+tfzcApwctp9xheRaslP
 NtYrs/99RPVaYsC6Jr3zqY/531YaE9KOXzQqKtVDgNq2K0ycEzzjXsrcvHT/41GDjuCS
 9e4Wol+fIZLb97GIpBczzPXyKFZidOC1vFRWlerVTmG8OK10pFPATHU/LjNQcyslPki8
 QZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769554521; x=1770159321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/VvX2MAN6SuZMPA6a97goqJuC4zc+gOJNWDk55dUus0=;
 b=spFU5SM4KbmTr/hdyrzbjPGShtcXpD32QF4tevyogRR0mCZmmtCGsBRYtye6WzzBsM
 COYZGsPksUQ4VyIDtJ7pKIXIPDQnv/r2edm8psMjkMTwdJRGbPfr/tkM+3L1WA9V/KJl
 rbPY5lQHMcGcIdz56dAcx4+LzQxbM1O7mfexRkyg6qPUFCW304PF/AYUpT89U3DXihjK
 lE9YhKm+n16CdOjj8sBu4KX8FQSJaIrsl09UNZ7F6VHKXT9Rb3Kg/1icFQeftNy4AJfe
 wG6wf2o3ohiaB/pYQjXcaLogOE1HnbmYIT0yMXMh0ud0J9l1KlZpzr07H24Yk+Cyuyrk
 5tLA==
X-Gm-Message-State: AOJu0Yx9lCp/PcW6ZqBI/PFssfX9IjN7zIEUaJdIJbJPzHPAdDKD/zt9
 LHzrwXkinSpldoHYm6iph9EBRTGAfw/n+8qwMvLV6nRSEP1ri2aISnlBE1vHjdiep1QsMLi06DR
 GlukuHMEC6lc9y+/Ve+K5f5R95twGb2K5gw==
X-Gm-Gg: AZuq6aLUyZeOQPNfXUCh6lVq00pia8PmgQD0+tJmBqcGWS/USCkdud+mBsOe9EyZ5gs
 59UHaV2OrZCxtMo991Dj7krsO57MJtSqIL0HwSXPWdwY2SyzqPNatyrldpyME7vkdNIkexSUoVi
 Lw2Rebx94BvAcDrJcTH+Lmh/ZGYaRnBXJy0vwA05Sb5YezyedaWme94xgLrzsch/X4iprCG2fih
 xAJ1geZMkecZicc+sKDLc9f28oSw/+I9UmgjVSuCzcPHnngPSt/DHH3VNWSa7eQaBFTCUuH
X-Received: by 2002:a05:7023:b85:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-124a99cf629mr122250c88.3.1769554520923; Tue, 27 Jan 2026
 14:55:20 -0800 (PST)
MIME-Version: 1.0
References: <20260123191500.18619-1-alexander.deucher@amd.com>
In-Reply-To: <20260123191500.18619-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Jan 2026 17:55:09 -0500
X-Gm-Features: AZwV_QilkdAci-sX1kWe8OBWV6xErqknarGgb66-w4JpIqHB_4HvC1rsv9TjVhE
Message-ID: <CADnq5_ODe5fCk3BKZdU6z7=VsUCk2aOMh79myfqE3X-VDE97tQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/soc21: fix xclk for APUs
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

On Fri, Jan 23, 2026 at 2:22=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> The reference clock is supposed to be 100Mhz, but it
> appears to actually be slightly lower (99.81Mhz).
>
> Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/14451
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amd=
gpu/soc21.c
> index 2da733b45c21a..d9cc649d81ad4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -256,7 +256,13 @@ static u32 soc21_get_config_memsize(struct amdgpu_de=
vice *adev)
>
>  static u32 soc21_get_xclk(struct amdgpu_device *adev)
>  {
> -       return adev->clock.spll.reference_freq;
> +       u32 reference_clock =3D adev->clock.spll.reference_freq;
> +
> +       /* reference clock is actually 99.81 Mhz rather than 100 Mhz */
> +       if ((adev->flags & AMD_IS_APU) && reference_clock =3D=3D 10000)
> +               return 9981;
> +
> +       return reference_clock;
>  }
>
>
> --
> 2.52.0
>
