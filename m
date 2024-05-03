Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078ECC4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 13:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F7AF10FC3E;
	Fri,  3 May 2024 13:47:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UZffM9zA";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E49D81121C7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 13:47:53 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-613a6bb2947so4103271a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 May 2024 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714744073; x=1715348873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haza8D5RgwNX7uu902Tk/u2yczUPoRjNyG1wIs6vQSM=;
 b=UZffM9zAhnWEboMHoa4eRqFIXV6vhoqNkoTOWRCqNE03LoT5cii8eId7rdYSgSWAzW
 scy7HpIgbPQ0QF3wmuXJpV0a0Cm67tup70tizmihWQ81mLgyL4P2XKCTubEao2Fxyln1
 Sdj3ASMMRurjRH5pb8WV6mbEq9K98xlqFpzasVycQ1h8QN/2Kv9CvSqtW8ymOIQKWt1G
 hTJxG+QoU/NolScgOhaOQny9NSxv5KWOfTjn11/1Xsud5jvHsYcGORP7GOuBMLwJzYMF
 8+RihWyJ2pbFGdx40NGTrPD265XYipU9iSgOnl0rHbCl3V3P+3bZqkbXKd2RmqH6q/xE
 Njbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714744073; x=1715348873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=haza8D5RgwNX7uu902Tk/u2yczUPoRjNyG1wIs6vQSM=;
 b=Is0LNLRc/hVOFJEtza/qVGV3+WAXfLAD+w4I62ffH8yKRm7KTjrXpJMKwCgiwz6CDq
 0fCdX8c7rPeeb3FlWHUpjmjE1DSRYheViEz0tgxX/3hRtdwLkZ2Bg3bihzpcqVJBMuIm
 Z1MBPqvYh1+t78ShQ5S9cvlVa16MWRrkgO2D36yqwYfCOub+nooEvvZjrA0FI20HCcdn
 SW0fq1dnHnakAa2qrxZkK8n+2K/QErUK0xlaw6MVrsOo5YhIom2EQEsBA26+mrr1N4II
 OPQa4q8GU8K5+zEQUwm5Gu1XM7DjriCGngdrG/gko/H7tThQ0ckjkOzLDCdXqM9fw323
 hXDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg+fMFUOwYHINDTEIW5AGGPbn+F76k1jw7fA9lmclUIJHWF+VRLl79V0ALVpia35DmjFbEPdMQnDjxAk/LuWvcpsSSPvxwNRyQz2IIAA==
X-Gm-Message-State: AOJu0Yxvlh+cfdRRjosaLRguiW5NWY7KZ7YJrQQSfUGMWO9pbK3CyCAN
 yj3FzDlkHFICsVQzaquH/4eZ5bcEO7LfHIzF7pqXpG5K+h+RftXfEvI+pBEYMm/sat8FxRwKqQH
 zdIs9HXsZSPiQ8c2hZPintyjiqAfHFJdE
X-Google-Smtp-Source: AGHT+IHu4OfrbTbSr16mbMVtpHJnMBf4SG6JXb3QSEf4n/e7me4o7BZuWIktAfg4trTP+nrawPBkwxRdcAQ8JN1e41g=
X-Received: by 2002:a17:90b:1196:b0:2ae:b8df:89e7 with SMTP id
 gk22-20020a17090b119600b002aeb8df89e7mr3073836pjb.38.1714744073294; Fri, 03
 May 2024 06:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240430172748.61576-1-tursulin@igalia.com>
 <20240430172748.61576-6-tursulin@igalia.com>
 <00d43d65-333e-4b2d-861e-11d01e7931b0@gmail.com>
 <d76f9bb6-b5e1-449e-957f-e7fb965e5f9f@igalia.com>
In-Reply-To: <d76f9bb6-b5e1-449e-957f-e7fb965e5f9f@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 May 2024 09:47:41 -0400
Message-ID: <CADnq5_NqUNp=bEgnAQKA7VWa0S4eWzGenc-pC4m8any=uBPqrw@mail.gmail.com>
Subject: Re: [RFC 5/5] drm/amdgpu: Only show VRAM in fdinfo if it exists
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com
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

On Fri, May 3, 2024 at 3:50=E2=80=AFAM Tvrtko Ursulin <tvrtko.ursulin@igali=
a.com> wrote:
>
>
> On 02/05/2024 14:16, Christian K=C3=B6nig wrote:
> > Am 30.04.24 um 19:27 schrieb Tvrtko Ursulin:
> >> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>
> >> Do not emit the key-value pairs if the VRAM does not exist ie. VRAM
> >> placement is not valid and accessible.
> >
> > Yeah, that's unfortunately rather misleading.
> >
> > Even APUs have VRAM or rather stolen system memory which is managed by
> > the graphics driver.
> >
> > We only have a single compute model which really doesn't have VRAM at a=
ll.
>
> Hm what is misleading and how more precisely? :) Maybe in other words,
> if is_app_apu is not the right criteria to know when TTM_PL_VRAM is
> impossible, what is? Is the compute model you mentio the only thing
> which sets is_app_apu and uses the dummy vram manager?

Probably better to check if adev->gmc.real_vram_size is non-0.

Alex

>
> Regards,
>
> Tvrtko
>
> > Regards,
> > Christian.
> >
> >>
> >> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 29 +++++++++++++-------=
--
> >>   1 file changed, 17 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> >> index a09944104c41..603a5c010f5d 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> >> @@ -83,25 +83,30 @@ void amdgpu_show_fdinfo(struct drm_printer *p,
> >> struct drm_file *file)
> >>        */
> >>       drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
> >> -    drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
> >>       drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
> >>       drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
> >> -    drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
> >> -           stats.visible_vram/1024UL);
> >> -    drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
> >> -           stats.evicted_vram/1024UL);
> >> -    drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
> >> -           stats.evicted_visible_vram/1024UL);
> >> -    drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
> >> -           stats.requested_vram/1024UL);
> >> -    drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
> >> -           stats.requested_visible_vram/1024UL);
> >>       drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
> >>              stats.requested_gtt/1024UL);
> >> -    drm_printf(p, "drm-shared-vram:\t%llu KiB\n",
> >> stats.vram_shared/1024UL);
> >>       drm_printf(p, "drm-shared-gtt:\t%llu KiB\n",
> >> stats.gtt_shared/1024UL);
> >>       drm_printf(p, "drm-shared-cpu:\t%llu KiB\n",
> >> stats.cpu_shared/1024UL);
> >> +    if (!adev->gmc.is_app_apu) {
> >> +        drm_printf(p, "drm-memory-vram:\t%llu KiB\n",
> >> +               stats.vram/1024UL);
> >> +        drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
> >> +               stats.visible_vram/1024UL);
> >> +        drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
> >> +               stats.evicted_vram/1024UL);
> >> +        drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
> >> +               stats.evicted_visible_vram/1024UL);
> >> +        drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
> >> +               stats.requested_vram/1024UL);
> >> +        drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
> >> +               stats.requested_visible_vram/1024UL);
> >> +        drm_printf(p, "drm-shared-vram:\t%llu KiB\n",
> >> +               stats.vram_shared/1024UL);
> >> +    }
> >> +
> >>       for (hw_ip =3D 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
> >>           if (!usage[hw_ip])
> >>               continue;
> >
