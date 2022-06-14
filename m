Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3DFC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 13:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 941FE112252;
	Tue, 14 Jun 2022 13:43:26 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC9A112252
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 13:43:25 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id v143so11594857oie.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+xkCkGEnOyi9zHIB58yS9ZPcJP6TE904Hlihi3sFeN0=;
 b=KhaMD9+BjrKkXp0c0yyFnedqVJf8dkpNOHuasIjMMcRaKzNpF1VNCq1NKP6en8lnEd
 +MDf22IZTxwgrZlN3Fd/BlwvrqgSQeaoSovwYfBqLVgpMQk7XdsO49WSFCaEfpp78ZFU
 TFrw0gIup4j1yuhc5iTQlc6ynZmUmHGae4YPG2iTa1KoxrY1IGXq2qGhVlceDfCj9OK6
 p7EL5rossE1vaNPkJxtHNCKLbUxRzQj/DUgSuozQXtzKlwcZMuZYJgNen48CkBbHXmH4
 V+GB76GoEovs3yYk5UgrOOyRs1gInF+neCHuhiiFaYH4rMUl77YPPchSub6wEZI+MZH/
 E6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+xkCkGEnOyi9zHIB58yS9ZPcJP6TE904Hlihi3sFeN0=;
 b=DToE94waigf0ekmfcABa82WxwhoOkTK/yFRsrLT9oR/QQbEywq0n51nsomLP2oQ6kG
 Rbk8rEEgIw+ceiCCC+nmgtxmSKMP5JYCBKnc2srh9g63nTqiV81PEbcF3GY2Vq4TDt29
 8XulghnLVLNG4U1HWLlauSog5t4k6ihCWuvjDNFWXU5tsOkqcjwDpUm/8wLJPG+DjP13
 JUUDdO4OtU/kYOTTlx8oJ1Fu9jxu2rfjPxF4bLoU5X2u9kM7w54heI8g+69SUaOAAVUg
 A6tUuEZJrD7OwATcY2/MwFRzqgx600riKfPlwvAP21QN8DBMvyFbTQkOEtvKsQRoVch5
 ydAA==
X-Gm-Message-State: AOAM531p/6UBabk+k/zEyHGsoX2EtQtdoidstN3Edh/o8vF5vC6HAOq4
 IniCwggdPGHsWA8Lel/yCTrUe0kb1fHD6l5ISJpAQFWd
X-Google-Smtp-Source: ABdhPJywFUE/hNthOcQ3dHe9FGMP8IiWCyqDFMxcXKC+K8Xb9H8WFFNttxjcXP6pkPhhNGXoLd0eih70SiFXbBdD87o=
X-Received: by 2002:a54:4f01:0:b0:32e:726c:bced with SMTP id
 e1-20020a544f01000000b0032e726cbcedmr2208652oiy.253.1655214204979; Tue, 14
 Jun 2022 06:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220520150912.762831-1-alexander.deucher@amd.com>
 <CADnq5_OZ5e1hfA_6O1q=evs0RbVsH1xf8xybcarTMztZhdvEsg@mail.gmail.com>
 <f27f1a49-7ecd-ef6c-7886-eed078c4e752@amd.com>
In-Reply-To: <f27f1a49-7ecd-ef6c-7886-eed078c4e752@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jun 2022 09:43:14 -0400
Message-ID: <CADnq5_NkvUwT7-ohb7ZBq-ErptkAokUPnWcvnT7+gxKt77LmqA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size (v3)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I don't see how this is worse than the current behavior.  We have some
bug reports where we have games that use a lot of memory and with the
lower limit the system ends up dying due to swapping and the behavior
is actually better with the patch.

Alex

On Thu, Jun 2, 2022 at 2:03 PM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> I totally agree on the reasoning, but I have the strong feeling that
> this will blow up in our face once more.
>
> I've tried to raise this limit twice already and had to revert it both
> times. And the reasons why I had to revert it haven't changed since them.
>
> Christian.
>
> Am 02.06.22 um 18:40 schrieb Alex Deucher:
> > @Christian Koenig
> > Any objections to this?  I realize that fixing the OOM killer is
> > ultimately the right approach, but I don't really see how this makes
> > things worse.  The current scheme is biased towards dGPUs as they have
> > lots of on board memory so on dGPUs we can end up setting gtt size to
> > 3/4 of system memory already in a lot of cases since there is often as
> > much vram as system memory.  Due to the limits in ttm, we can't use
> > more than half at the moment anway, so this shouldn't make things
> > worse on dGPUs and would help a lot of APUs.  Once could make the
> > argument that with more vram there is less need for gtt so less chance
> > for OOM, but I think it is more of a scale issue.  E.g., on dGPUs
> > you'll generally be running higher resolutions and texture quality,
> > etc. so the overall memory footprint is just scaled up.
> >
> > Alex
> >
> > On Fri, May 20, 2022 at 11:09 AM Alex Deucher <alexander.deucher@amd.co=
m> wrote:
> >> Certain GL unit tests for large textures can cause problems
> >> with the OOM killer since there is no way to link this memory
> >> to a process.  This was originally mitigated (but not necessarily
> >> eliminated) by limiting the GTT size.  The problem is this limit
> >> is often too low for many modern games so just make the limit 1/2
> >> of system memory. The OOM accounting needs to be addressed, but
> >> we shouldn't prevent common 3D applications from being usable
> >> just to potentially mitigate that corner case.
> >>
> >> Set default GTT size to max(3G, 1/2 of system ram) by default.
> >>
> >> v2: drop previous logic and default to 3/4 of ram
> >> v3: default to half of ram to align with ttm
> >>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++------
> >>   1 file changed, 14 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c
> >> index d2b5cccb45c3..7195ed77c85a 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> @@ -1798,18 +1798,26 @@ int amdgpu_ttm_init(struct amdgpu_device *adev=
)
> >>          DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
> >>                   (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)=
));
> >>
> >> -       /* Compute GTT size, either bsaed on 3/4th the size of RAM siz=
e
> >> +       /* Compute GTT size, either bsaed on 1/2 the size of RAM size
> >>           * or whatever the user passed on module init */
> >>          if (amdgpu_gtt_size =3D=3D -1) {
> >>                  struct sysinfo si;
> >>
> >>                  si_meminfo(&si);
> >> -               gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20=
),
> >> -                              adev->gmc.mc_vram_size),
> >> -                              ((uint64_t)si.totalram * si.mem_unit * =
3/4));
> >> -       }
> >> -       else
> >> +               /* Certain GL unit tests for large textures can cause =
problems
> >> +                * with the OOM killer since there is no way to link t=
his memory
> >> +                * to a process.  This was originally mitigated (but n=
ot necessarily
> >> +                * eliminated) by limiting the GTT size.  The problem =
is this limit
> >> +                * is often too low for many modern games so just make=
 the limit 1/2
> >> +                * of system memory which aligns with TTM. The OOM acc=
ounting needs
> >> +                * to be addressed, but we shouldn't prevent common 3D=
 applications
> >> +                * from being usable just to potentially mitigate that=
 corner case.
> >> +                */
> >> +               gtt_size =3D max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> >> +                              (u64)si.totalram * si.mem_unit / 2);
> >> +       } else {
> >>                  gtt_size =3D (uint64_t)amdgpu_gtt_size << 20;
> >> +       }
> >>
> >>          /* Initialize GTT memory pool */
> >>          r =3D amdgpu_gtt_mgr_init(adev, gtt_size);
> >> --
> >> 2.35.3
> >>
>
