Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FF1C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 12:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3CC810E28A;
	Thu, 20 Mar 2025 12:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k//5s0ve";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB5110E217
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 12:51:12 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2ff5f2c5924so157376a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742475072; x=1743079872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0Bh62dxU7gw1JWPZR5KYG5OhW7gfVorTdyQOCFJ6J8=;
 b=k//5s0veq59pantfYF/FMnxN2T1EkFmGosJR846o5BgqZw8WJ2TGmJ/eF6i78E8EgW
 +QO7xCFUCyrGTuSzwsyBgKVW/mbZD+2NKu+1P06LlbTsElf9eoMlbsNol++eus04AvnO
 1iS/swueu28vA4mSLuVXnFR4R7FANkRHg5LEGjAgnthjh3kiVz5b1DEhr4C40OKGLAUg
 qjdZhFi+faV2aQ5E4LsWCMu1kblJPvE6qH4iFG+lpMufYzNUioK8oGVN/Y4YllQnWN/i
 m2kgQNV/Kt6oT0y84b5e+CzmLvqozo4vOvtB040exaE/Xni33dCVFcgGZ/TcN4MIyE68
 Np3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742475072; x=1743079872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G0Bh62dxU7gw1JWPZR5KYG5OhW7gfVorTdyQOCFJ6J8=;
 b=B680SbII0t+oY1gbsu4VW6RyVbzFRVmrxMk8e4ycyQ8/PoIf0kiluc4839fZVDzCRS
 gUomw0IDle8CoIP53ArvTPlnMOz7bFJYc35BXppOW4b9dnO6DGaLJU9OJEEYxyF/ctcB
 SDJ4FMDPHydYb3UZDxTZ81u2EJ4up+jlGwkjlhfl8l+GQ4iiLcjc/b2NyxjG4OTtL5zA
 SUuu0Bqyf43hWdZsCuOx3OtEGxR/Ojv2EWJvDDGPsrYiOs4CsW1VY7y5rDbPip4ia4YH
 JupG8WUBkyrGcZZ/JcsEApy78NNzoHkhYVf0zEBKFKPZk2Bcf+YVxcclou5BoY0bKZ7F
 uxYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjairG0MxexTRED0lBI6GaXZTDNnxYzvKjitQ5LDtFsQanfrBA5ZH7Rm0kiCLfDDStknDygKeV@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7tr3bwdheKG7HchrtrHcgcHTtAfJJc4sNg9KHhBjtOH2xLdb6
 zK33yzbshnu6kg7B1xA8erSQem9Y8EYwbyZLeSkaOrRfpgClxLzKKamv8B1ZGKL42f9icU/NGAO
 PjDNjfw3spSzlqEd76L7gXpXMzCw=
X-Gm-Gg: ASbGncsPlvWDDhjsWCvz0aBqagUwJxwMKN1BHKK/jeC9Izv4kKibHntqN+aYhaUXXzb
 yipLIBhXbTxTs/9iL4IPHU9eVP9cUXTECGyaPRMgPFHsx5kpBxoyBmCc6/PdteDGX3/oImuZCCr
 OQJQkQT5d3HcX7hdst00LtKAGi5Q==
X-Google-Smtp-Source: AGHT+IEtLc7IcNr9MP5X9+LmeGvKX6X6DxlwY0pABkYZws3BbVdKCYz3OKmvf+tX6YfLhSfY44RigGKYTJEKF2/9g8k=
X-Received: by 2002:a17:90b:3841:b0:2fe:8fa0:e7a1 with SMTP id
 98e67ed59e1d1-301bfbd3372mr3458105a91.2.1742475071969; Thu, 20 Mar 2025
 05:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
 <d2af32a9-f7e7-4530-93b0-c5d015e41c5e@amd.com>
In-Reply-To: <d2af32a9-f7e7-4530-93b0-c5d015e41c5e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Mar 2025 08:51:00 -0400
X-Gm-Features: AQ5f1JoDHAwVCTcsNtp8mJZlSvx33DCSWmZxp1Or12JH23ARhP88F0Ps8iQVab4
Message-ID: <CADnq5_Mw834v4AkCFW6tSqwE-i1poAK+83GpKt_cvb8HaHDjRQ@mail.gmail.com>
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

On Thu, Mar 20, 2025 at 7:14=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 3/20/2025 12:38 AM, Alex Deucher wrote:
> > Break when we get to the end of the supported pipes
> > rather than continuing the loop.
> >
> > Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_mes.c
> > index 3b83880f9e2cc..10f14bf925778 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -132,7 +132,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
> >       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
>
> Unless I'm not seeing something, why not just keep it i <
> adev->gfx.mec.num_pipe_per_mec?

AMDGPU_MES_MAX_COMPUTE_PIPES Is the size of the array and I think it
is aligned to the max supported by the firmware, so if we had
num_pipe_per_mec larger than that for some reason this would prevent
an overflow.

Alex

>
> Thanks,
> Lijo
>
> >               /* use only 1st MEC pipes */
> >               if (i >=3D adev->gfx.mec.num_pipe_per_mec)
> > -                     continue;
> > +                     break;
> >               adev->mes.compute_hqd_mask[i] =3D 0xc;
> >       }
> >
>
