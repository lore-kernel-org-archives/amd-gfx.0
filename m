Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7E9EE645B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 13:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D1610E629;
	Fri, 15 Sep 2023 13:02:49 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582A010E628
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 13:02:47 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3ab3aceaf2aso1255276b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694782966; x=1695387766; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBlJzM+ZVT8PGXVfKFRkRw23ip2p91qdcWNX8VQx0Ws=;
 b=mzb7/wdnp3CfCxK/b2aclyRYXMJgpv+0gfymOPaZENYN6z/RamvxCR+cWtj2p8lHAV
 O/Ed93DWip+bM33QNMrgsb9goKMVBdzKdeslsFt5+LLLnQaVo0t6idaCGmjThoJg3Yvm
 FEu3GVB5t+9KL4vam1IbJWQZLXQ8gAShen/fPq5bvPevhzQkoNn53fhQgPwcTwLTRotS
 LjY4ySbJjja1i+EXFn2zHO8wE92EINgM+H+8ekA5IkTmqDAWVF5y6R7VLXREzVlcSbMn
 +yX1fMy2kmUcf7sw7+LmW2FVWR5eZCv3tmvSJ7sJnswPOputRm+9VAoklQYeviIRT5lT
 XNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694782966; x=1695387766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBlJzM+ZVT8PGXVfKFRkRw23ip2p91qdcWNX8VQx0Ws=;
 b=jM0m7tqqefJPOwCm0BgSELIzxDr7wYufkao5O133hWaW21/TiFhPLFsYQCPiZ75xqn
 e66ZB+YryjYZTpuKzd9dwefKqZmrjN7Spfr9QJjbca1sl4alBcNZXg3LZWg1byC13loS
 FKnYsY2A2FtnblwkvGxg5qEsbQWCxmDcWYUi03DCn9NPb9/jOuUP3SzWcD2+Ubfqf1II
 5V7Wy64eJkCwHPZ8LqL4BRgmdRL/LNNATFR0L9C0DbGmOCG9XNVWwTu4SPk+d6ZCtUan
 cN9q6d3ilYXoyevq6wv5MoocxTYWALDjkZ6uSOVnu+CgT4zKFWPgL62lwHFOcBO0t3wk
 6nfw==
X-Gm-Message-State: AOJu0Yzok+IITtIpt9fhFlwWDCaJO2wNa9S17DGpsdn1YxTDi3khVFFz
 Xea7VKXZM17uuxc9IJ2Iwkt0CjotoSYBtP2WtfE=
X-Google-Smtp-Source: AGHT+IGHtY9K2IT/k/AivAaAutQs7kZcZvG5UJR+j4HGT+eYCtuwHH2XmiG6e/I4luOZFT/oVyrjSu4z/yoQdcHuZwc=
X-Received: by 2002:a05:6871:70c:b0:1b0:17f2:6518 with SMTP id
 f12-20020a056871070c00b001b017f26518mr1684369oap.42.1694782966346; Fri, 15
 Sep 2023 06:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230914182200.679059-1-alexander.deucher@amd.com>
 <20230914182200.679059-4-alexander.deucher@amd.com>
 <CADnq5_OucfrjjRtTsV=yiaCcYJT8oADr5xdQLUsrBhfNs_npDw@mail.gmail.com>
 <9aac2aa5-448d-1abd-6c70-6ec7840e4b12@gmail.com>
In-Reply-To: <9aac2aa5-448d-1abd-6c70-6ec7840e4b12@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Sep 2023 09:02:35 -0400
Message-ID: <CADnq5_N3BFNUvja7Bmfa8kMV8zQ7j1J=SVp038HfOcGywkOd7g@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu/gmc11: disable AGP on GC 11.5
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 15, 2023 at 2:13=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 14.09.23 um 20:49 schrieb Alex Deucher:
> > On Thu, Sep 14, 2023 at 2:31=E2=80=AFPM Alex Deucher <alexander.deucher=
@amd.com> wrote:
> >> AGP aperture is deprecated and no longer functional.
> >>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v11_0.c
> >> index 6947b598e9b2..7ee91b66f761 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >> @@ -745,6 +745,9 @@ static int gmc_v11_0_mc_init(struct amdgpu_device =
*adev)
> >>                  adev->gmc.gart_placement =3D AMDGPU_GART_PLACEMENT_LO=
W;
> >>          else
> >>                  adev->gmc.gart_placement =3D AMDGPU_GART_PLACEMENT_HI=
GH;
> >> +       /* AGP aperture is removed on GC11.5 */
> >> +       if (amdgpu_ip_version(adev, GC_HWIP, -2) >=3D IP_VERSION(11, 5=
, 0))
> > Not sure what happened here.  I've replaced the -2 with 0 locally.
>
> I also don't see patch #1 in the series.
>

https://patchwork.freedesktop.org/patch/557552/?series=3D123727&rev=3D1

> Patch #3 shouldn't be necessary, if the AGP aperture isn't wanted the
> code should just not call amdgpu_gmc_agp_location().

Yeah, I could go that way too if you prefer.  Same difference at the
end of the day.

Alex

>
> Christian.
>
> >
> > Alex
> >
> >> +               adev->gmc.no_agp =3D true;
> >>
> >>          gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
> >>
> >> --
> >> 2.41.0
> >>
>
