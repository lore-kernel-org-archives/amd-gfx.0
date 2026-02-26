Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E39FFD8FD3
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 16:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E5010E9C1;
	Thu, 26 Feb 2026 16:47:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gkCClim/";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F39010E9C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 16:47:12 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-124a7216c9cso70644c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 08:47:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772124432; cv=none;
 d=google.com; s=arc-20240605;
 b=IY2i1i/TfYvbICwO8DLYuOLQQWCF0ykxG/DuDpI2uddJFPb73vfrzARWtEqUZg+ah4
 6voks0GBFVEwb4od+3+VDzQqdJccm6Dt6XQ80AeyC+EDHANOT3l2DBv+0ZE/ak/la86a
 MVJ1xvGWyifpevdbXOiiFexSZPDqhcQIVTH8w/zKtZ6a+8ACa49hciXGzN18/CYpywgQ
 k0rPNv0DUqiTWi1wOnkEw2OAt9b86g7ZHEvuS6RPgGkw+UfTNqE1pUSBPX6UDFe70t68
 fa8lObpJVRxtGEzXWA02DnXLbXSE/+kHmbvF3yWuZYtolpauj5ys/xV7cTABt5pN++U+
 o4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=14b7Avo43YlZe+hxgSc9nKn/f7gq8EMXA4C+O7gB90A=;
 fh=IidcqntdObpsT8v2qsPipjz8Uhxx0h3FNwm0yzxjHds=;
 b=YHWl4vhWkiTlFBTmBUR7LT/6GSBW+slHbCmRqgdNyWuLMWA+V0ba53wqApw+7RVIfc
 SBxhHPFJtMJW6FZBWxchBo+vw5Qkrl0BeI+ZVbpak2ITkNEd7Cl9phitaspp6hT23EUb
 OfCLAd9HFny+mgpUdU6tEI0n9CBgtA1E2QJPTS7XNmX0t3N1EFLzjZA1JjPI+/C35GZX
 HC4uoGWN3ZeHbeYypnZIVCFFEqQsVBibqS7kgVtQJd6FpdPgw8bmE6/lGMWs0gZTXr3Q
 mKZxfm0EIUtkY12jVsbb7qmFaqIy8OMiyFpGMVzlNgv23z8Tfis3NeWIEW1NjbQyh2Y4
 y40g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772124432; x=1772729232; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14b7Avo43YlZe+hxgSc9nKn/f7gq8EMXA4C+O7gB90A=;
 b=gkCClim/7wCUe97rcZQZutuIimQ0sX43oYAKmJShh+npmCszMMfdvD65Ph3b9NBzZg
 C+yhSz2V3qlcXCz29ZrEKUbqkzCTn/knblA+Si/ThJ5hmb8FZddT7M7UtLSINRqZ2/VG
 zQNRDlqKX6lSCzI1QSgRdJN2FDVvPW0dAwIa79HQGo+NpQSpii15oQLlb3/1FoWDUu/2
 O9KO9hCR741xB33MZ2ofL6vpaUvswI+fytnRwhxxUuanAzZQrNKxzoU5zXho1M7nouxl
 LteNQ4El53bDEZZm4JIdcBXnYT4VBLuvED0gcna1bkvpBPedCE9dNJEyL70U1qFQUS9r
 onfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772124432; x=1772729232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=14b7Avo43YlZe+hxgSc9nKn/f7gq8EMXA4C+O7gB90A=;
 b=gLIewAg+4pcKQnpeIuqJtY4HWLHlAz0mTich+ZXi1GKe9y6SE4ES+jluDVVudCSX0z
 /2jtcm5zHipkFd8UkUJz9irglp7k0Yjx5RejFRnEQnHi1k60C9Pj4xIWoQnAdSCfIAEE
 D3HS1wMS/YxRuUT2qLjgb5vqi4F/tqy6ZLGTiOX4/qPFx+U8JVavJKu8MBg6WBRG1amc
 Is6TtTgFnCJyxYeIZGDj2hX5FrXs1qWa2ntJx5BJJrODbF3SeYRb5dz1vBNLCgdK3Deq
 xEWMkppiN1H8R1Cxn5A2sMXBK3aKzgN22AsZwDp/fPVHnGJzrotbF6/XInc0MpbF7n3x
 NoVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+V6ffkMgd7kLCsVxMFsspEKbdXbE7Tohijq9y34uYpqBSU26SCOhzyXX9XQ8/CyC+qKn/D9h8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznNr6tseba/R7USumf7oOGjHi1+OyqlBykiEZNrDIztEpOl4fb
 jHp9fOO4Ic1DDKK4UssLADZmUfmAGRz12SasRTRQtYmt+PKG4BkDBhpJ4+RzJbGiR8RZReAb5i6
 AjTq50VrHsPazTOTk/6RhvjQt6avDfbs=
X-Gm-Gg: ATEYQzyJvoG8S/ILVs1YXtzOsJaVNPY1gYP1I9b6Z9EOXEwDtlrz13MbEPDZ4yWOW/h
 hdQ9l2iNCS2k/GYQiKAsPZTFBqGR3WSIjeHfcMJ1mBscTlkKpOXY7FjhdDVLGjhFQLEEM13s1Oq
 iL4LdFknhnnEDTDAkU9Am8uYasISyTnTOVAcSa7Twfbpsg8N7OrPF/MtJhauaqQGZdbMDyDH/Lw
 OrmPdHnHn/cC4ceq13fKXSIKq/qDLJ5FvS6dAKKAnnQDsCCFvhXfvC+juH3aSin7Wv3Ml3DVyJS
 TM4tfA6HvNQvSw9rtER/QTPXgYpoORsWdSA+gekfveCd38K0OOuuDe/tV0QyF7aEZ6bAsQ==
X-Received: by 2002:a05:7022:521:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-1276ad1a953mr3945750c88.6.1772124431737; Thu, 26 Feb 2026
 08:47:11 -0800 (PST)
MIME-Version: 1.0
References: <20260225174702.it.918-kees@kernel.org>
In-Reply-To: <20260225174702.it.918-kees@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Feb 2026 11:46:58 -0500
X-Gm-Features: AaiRm51xyAWxRasXbIsk-hsIItXJk-3QDBUo6dz1ndGIfSkhqxcHNt_CuM4bM8E
Message-ID: <CADnq5_MWNLM+KUb09LgPUq6QsY68paojSAWXEZ3n+YLHq0ULxA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/ras: Fix type size of remainder argument
To: Kees Cook <kees@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 YiPeng Chai <YiPeng.Chai@amd.com>, 
 Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
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

Alex

On Wed, Feb 25, 2026 at 1:04=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Forcing an int to be dereferenced at uint64_t for div64_u64_rem() runs
> the risk of endian confusion and stack overflowing writes. Seen while
> preparing to enable -Warray-bounds globally:
>
> In file included from ../arch/x86/include/asm/processor.h:35,
>                  from ../include/linux/sched.h:13,
>                  from ../include/linux/ratelimit.h:6,
>                  from ../include/linux/dev_printk.h:16,
>                  from ../drivers/gpu/drm/amd/amdgpu/../ras/ras_mgr/ras_sy=
s.h:29,
>                  from ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras.h:=
27,
>                  from ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_co=
re.c:24:
> In function 'div64_u64_rem',
>     inlined from 'ras_core_convert_timestamp_to_time' at ../drivers/gpu/d=
rm/amd/amdgpu/../ras/rascore/ras_core.c:72:9:
> ../include/linux/math64.h:56:20: error: array subscript 'u64 {aka long lo=
ng unsigned int}[0]' is partly outside array bounds of 'int[1]' [-Werror=3D=
array-bounds=3D]
>    56 |         *remainder =3D dividend % divisor;
>       |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c: In function 'ras=
_core_convert_timestamp_to_time':
> ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c:70:19: note: obje=
ct 'remaining_seconds' of size 4
>    70 |         int days, remaining_seconds;
>       |                   ^~~~~~~~~~~~~~~~~
>
> Use a 64-bit type for the remainder calculation, but leave
> remaining_seconds as 32-bit to avoid 64-bit division later. The value of
> remainder will always be less than seconds_per_day, so there's no
> truncation risk.
>
> Fixes: ace232eff50e ("drm/amdgpu: Add ras module files into amdgpu")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v2: use temp u64 to avoid 64-bit division later
>  v1: https://lore.kernel.org/lkml/20260225024716.work.043-kees@kernel.org=
/
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: YiPeng Chai <YiPeng.Chai@amd.com>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: <amd-gfx@lists.freedesktop.org>
> Cc: <dri-devel@lists.freedesktop.org>
> ---
>  drivers/gpu/drm/amd/ras/rascore/ras_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm=
/amd/ras/rascore/ras_core.c
> index 01122b55c98a..02bbee64a5bd 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -62,14 +62,16 @@ int ras_core_convert_timestamp_to_time(struct ras_cor=
e_context *ras_core,
>                         uint64_t timestamp, struct ras_time *tm)
>  {
>         int days_in_month[] =3D {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, =
30, 31};
> -       uint64_t month =3D 0, day =3D 0, hour =3D 0, minute =3D 0, second=
 =3D 0;
> +       uint64_t month =3D 0, day =3D 0, hour =3D 0, minute =3D 0, second=
 =3D 0, remainder;
>         uint32_t year =3D 0;
>         int seconds_per_day =3D 24 * 60 * 60;
>         int seconds_per_hour =3D 60 * 60;
>         int seconds_per_minute =3D 60;
>         int days, remaining_seconds;
>
> -       days =3D div64_u64_rem(timestamp, seconds_per_day, (uint64_t *)&r=
emaining_seconds);
> +       days =3D div64_u64_rem(timestamp, seconds_per_day, &remainder);
> +       /* remainder will always be less than seconds_per_day. */
> +       remaining_seconds =3D remainder;
>
>         /* utc_timestamp follows the Unix epoch */
>         year =3D 1970;
> --
> 2.34.1
>
