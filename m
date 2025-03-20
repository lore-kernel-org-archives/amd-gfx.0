Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EC2C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 13:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6D910E632;
	Thu, 20 Mar 2025 13:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OzzphHkx";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67EA210E3A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 13:53:52 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-301b4f97cc1so212232a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742478832; x=1743083632; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQE3ipT7omeUJ33VGgUEHj6iUHJ5s1PgeMbWUI/Htb0=;
 b=OzzphHkxIlM7rowMitVrVPhtwa6Tap6FW6UGlYs4dpl++LQX59dx5CqRLsvB1/ICDk
 QAzj2cuyhwZi4KSiLDYv9RrQJuNkG8TWApMp82oQhmAmRHkPC0sRgVF35ZT949Lo55/8
 AGlPrJne99GyPfaRTHDVhBmmyYAVJDr+7/0XQtE5zgHwk2JNN93wTjMQGM1M8mJvxoMI
 lqVCcCzpuO/UAYz87UzOyFdpJdOSE+2ej3BcEfAsIBsAliYTBCqBhB/RVzFT+YccD5gr
 VKC1lh6KE/6Z/IHAHep9ht4VE68405wzib51fg7W/lMB+ky+SNw77z1s+PIGNtEgdPm7
 Juhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742478832; x=1743083632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQE3ipT7omeUJ33VGgUEHj6iUHJ5s1PgeMbWUI/Htb0=;
 b=rE1SejobElBknbQ7blzJbzXkS2z/HX7jvy1+E/wUoGcEc8IDCxyy6/knDrSXMTnnwf
 X/JesI/S+womQuAAAwrZG5BcJfZ9dgGt16twlOpodaAAQ4rLSPCqUIGUxi5jjsjhlj3k
 N8z0f40lcn54eru8YrtP28MuiNkopuTetCnCF8Yh6TsXEvVAeo8UM7ksMF0RS1c+NwJt
 HFEtRZgsi2peIgR0S8kXbsuadP06swYT59zeGFj7X2CmdD6GZmBVIUWUJyf7Y5EaMwSB
 SIzyjdGZ7mhfCk2IdEFeKSd5a1eFIu56U7pwwxvYHaEmz5IgZr98NbEWJX4oZeYKk72+
 N75A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0SnPssjVA+oHFw/ULabYatOnspUazq/zKR3jz4n84963mW3g9BA9b6EcABNiA4jfiyl+SJOu5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZ7Wc6ECrFQ9rRsMcNcbh34Tu6C8u5NopW0WJz0p+vMPTGKMrq
 4nDn8DU61BhJV78xVkYum8XuSUfpUkGWiDIjA5nr23/i/d6zUw40DCIXk0qf8xk5Pg7qY8ZxLIZ
 zR7N8TcDBoLL2vwTmCMYU7MPQX9h+Bw==
X-Gm-Gg: ASbGnct4g+jmIoLZinhvFSy/m+XdKtQuSSSHLn1ik2JxrKdOOyPz+MdLErvhSAa5P00
 oErKvCz3XZnzCZxhOdOCzPhir60Tw83XjF2h4g5+WOLAYH+PSnZfmolGm6kkifHXwdknVYdu1Je
 6Odd5Zchl4cd3H8LA+2pNWmipjew==
X-Google-Smtp-Source: AGHT+IF2hxzEG5QIvPfOUFnCK0wgc4FO6juN4ssBkbSAuggHxcWKlLZpkRn9kz+n1HwkAWNF18vy24+YOxV4qeYrq/8=
X-Received: by 2002:a17:90b:1b44:b0:2ff:4e90:3c47 with SMTP id
 98e67ed59e1d1-301bfc7341fmr3054376a91.4.1742478831813; Thu, 20 Mar 2025
 06:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
 <d2af32a9-f7e7-4530-93b0-c5d015e41c5e@amd.com>
 <CADnq5_Mw834v4AkCFW6tSqwE-i1poAK+83GpKt_cvb8HaHDjRQ@mail.gmail.com>
 <878f6a71-204c-4f3b-becc-c8bb7ef80252@amd.com>
In-Reply-To: <878f6a71-204c-4f3b-becc-c8bb7ef80252@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Mar 2025 09:53:40 -0400
X-Gm-Features: AQ5f1JrbH_Uj15_lPm67phYYwclXwnwfzqbq4WGus7GN0TeVfztt78CLcVBmDeE
Message-ID: <CADnq5_OZy000v62NFf2vQmjSy8i9-C1Am+Oh=quqOMVdQRkyhQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu/mes: optimize compute loop handling
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 "Shaoyun.liu" <Shaoyun.liu@amd.com>
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

On Thu, Mar 20, 2025 at 9:44=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 3/20/2025 6:21 PM, Alex Deucher wrote:
> > On Thu, Mar 20, 2025 at 7:14=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com=
> wrote:
> >>
> >>
> >>
> >> On 3/20/2025 12:38 AM, Alex Deucher wrote:
> >>> Break when we get to the end of the supported pipes
> >>> rather than continuing the loop.
> >>>
> >>> Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_mes.c
> >>> index 3b83880f9e2cc..10f14bf925778 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> >>> @@ -132,7 +132,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
> >>>       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
> >>
> >> Unless I'm not seeing something, why not just keep it i <
> >> adev->gfx.mec.num_pipe_per_mec?
> >
> > AMDGPU_MES_MAX_COMPUTE_PIPES Is the size of the array and I think it
> > is aligned to the max supported by the firmware, so if we had
> > num_pipe_per_mec larger than that for some reason this would prevent
> > an overflow.
> >
>
> I think it should be kept the other way and array size should be fixed,
> otherwise it hides a real problem.

How about a dev_warn when we break out of the loop?  If we see that,
we can fix the array size or figure out why it's too large.

Alex

>
> Thanks,
> Lijo
>
> > Alex
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>>               /* use only 1st MEC pipes */
> >>>               if (i >=3D adev->gfx.mec.num_pipe_per_mec)
> >>> -                     continue;
> >>> +                     break;
> >>>               adev->mes.compute_hqd_mask[i] =3D 0xc;
> >>>       }
> >>>
> >>
>
