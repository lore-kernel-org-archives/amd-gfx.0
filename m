Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886C4CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 16:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B3A10EF68;
	Wed, 13 May 2026 16:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ro3JzfSL";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD24010EF68
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 16:43:21 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so64323895e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 09:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778690600; x=1779295400; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5la2me0h5HNWHM/ie9O+hBvrxyhEC/ghA9fan1RCI8o=;
 b=Ro3JzfSLJonhTEeCcun7J4lysQYMlFNPOtgFnPwzH4p8Q0Q/IRuID7USLBjLI0BB7X
 0li997O7k/dQgGjF0IWAOKqdWqoeQ3azrtFAjQjCG8LbswywxARGx0xoJtDr7xpJCA8l
 YGd96Jz1EMznAQOYNU4SoF0Sm5B5VBetnZM2Jmz08gXVaqfxxyy7xw9py79VsbBvZOPF
 3NJIMJavjLOL7lWsKlbmtrgxrq+97s7NPP5VPsmPjsQORBCPB3YM0H4UcCG45itWtiiU
 mI2UajtBlltAVYSCajF+LvKs8os3QZXBqfjWmI1gfs2rAf/tw1SrjrJNjiH69cg1EthL
 QgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778690600; x=1779295400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5la2me0h5HNWHM/ie9O+hBvrxyhEC/ghA9fan1RCI8o=;
 b=S8l4xBfiOy57wgd4XJgdGMV6dFWnqGasWwJLXy3Sy3mJQAD7lMDT4ob1GNrPQ0MV0g
 snpAfKuEVCHHSLX/N0W1Ag3MwVf/EAfVnNSM6ZOrfdol4hj0Zkbk0xDE3/JAfFHDZide
 vguuJzFd8WqDgiq7WPNxgEIxdCjS2D909628p2Sd66R1euh5amkvIaeFMgEKsi8QLTvT
 XJYxaSNJVYl1W7m4U2MZuoe36Bw0ZkZZU5enEFpX3oSjzaLFg+Hstg4IN1/xljpjNuXY
 cSXtvty49+TQmiTWuCag9Kn08PK/d322AY6YisBeXO3KobrearcxCWgIQ7AbUL8A9ZFq
 7eLQ==
X-Gm-Message-State: AOJu0Ywi1DScO+tYVRV5UN3u5r1GNaQXSwC/TZeXjbgJELv33o0RwGnT
 X2Mkic249Ifk093EPDjyZZ5P1kaU4Jad0aqAuernKWm4/PnKCaRJCzOW
X-Gm-Gg: Acq92OE8xyVmwhjecqwGoRsu9vnBVLJNEN0YuCuVjf0/0Q8LqsRXjXi8rqUpGk/xm/w
 4chPSj/JetHNkVr2yXWMWIZZWaubybYGWlHXF9O8y7QqJm8GrhlhpNG1MfYv8MQ7NoN6x4lDjmL
 YLJtXs14PpphHPzybNatTQktMpNNW7F5j1iKLSsmTTIZwkNJYRRHfBOtAniqabpIr77wMKSANLn
 xEmimTK5GO5Ni9g5jzcuCrtOW6ExKSvR1WdG82jYYk/uLd1Kchz0mnthftBxggmGIUXVtNz5p3I
 jGmXwltqst3ogwRvvL8TFdo1lcyiaNq9WOvqS8dJI5atsJypRWFFMF8+cy2uDuq/YN/fFMB/tkA
 84+dcDO2MoFaDW7EU7BN6GEIhVqIFibXAejChyIbOb19m2JOy/bf32alEqP0C/LAvj3DhcEssvm
 8B+Bz/Z8Vx4kcWMPF0797JTvEASq542TCisTkvj3zNMm4Iyid+pnqB/xmMta5NlGX9GqxFPg==
X-Received: by 2002:a05:600c:4fcb:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-48fc9a0ebc2mr63437255e9.8.1778690600220; 
 Wed, 13 May 2026 09:43:20 -0700 (PDT)
Received: from timur-hyperion.localnet (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64d9f63sm2147855e9.12.2026.05.13.09.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:43:19 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Amir Shetaia <amir.shetaia@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 0/6] drm/amdgpu: Improve retry fault handling
Date: Wed, 13 May 2026 18:43:18 +0200
Message-ID: <2795714.vuYhMxLoTh@timur-hyperion>
In-Reply-To: <CADnq5_Ot+iPKNtxTvA7rWvdsDie3vdrHN8ftwM84FY-+p3A_0g@mail.gmail.com>
References: <20260513163043.8725-1-timur.kristof@gmail.com>
 <CADnq5_Ot+iPKNtxTvA7rWvdsDie3vdrHN8ftwM84FY-+p3A_0g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Wednesday, May 13, 2026 6:36:02=E2=80=AFPM Central European Summer Time =
Alex=20
Deucher wrote:
> + Amir
>=20
> Amir may have some insights on navi4x as he was looking at this recently.
>=20
> Alex

Hi Alex, Amir,

I think we are very close to enabling retry faults by default on Navi 3.
I'd be happy to receive feedback on the above series.

With regards to Navi 4:

I also attempted to get it working on Navi 48, and I managed to get retry=20
faults enabled, but it seems that amdgpu_vm_handle_fault() can't actually=20
resolve the page fault on Navi 48. It just keeps retrying until it times ou=
t.=20
Christian suggested this may be due to an invalid page being stuck in the=20
cache. I tried adding a TLB flush but unfortunately that just made it worse=
 (it=20
hangs irrecoverably).

Any insight is appreciated!

Thanks & best regards,
Timur

>=20
> On Wed, May 13, 2026 at 12:30=E2=80=AFPM Timur Krist=C3=B3f <timur.kristo=
f@gmail.com>=20
wrote:
> > Fix some issues regarding retry fault handling,
> > such as enabling the retry fault interrupt (necessary
> > for retry faults to work) and such.
> >=20
> > Improve retry faults on Navi 3 dGPUs by enabling
> > the filter CAM, which can filter the repeated page
> > fault interrupts that happen when retry faults are
> > enabled, making the handling more efficient.
> >=20
> > With this series, the kernel is able to mitigate
> > most page faults on Navi 3 without causing a hang
> > and without a need to reset the GPU, when the
> > amdgpu.noretry=3D0 module parameter is set.
> >=20
> > Timur Krist=C3=B3f (6):
> >   drm/amdgpu: Use gmc->noretry instead of amdgpu_noretry directly
> >   drm/amdgpu/gfxhub: Enable retry fault interrupts when needed
> >   drm/amdgpu/gfxhub: Program CRASH_ON_*_FAULT bits to 0 as needed
> >   drm/amdgpu/gmc: Don't compare page fault timestamps with other
> >  =20
> >     interrupts
> >  =20
> >   drm/amdgpu/ih: Add retry_cam_ack IH function pointer
> >   drm/amdgpu: Enable retry CAM on Navi 3 dGPUs
> > =20
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  7 +++++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h      |  1 +
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 17 ++++++++++-------
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 17 ++++++++++-------
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 19 +++++++++++--------
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 15 +++++++++------
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 15 +++++++++------
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 15 +++++++++------
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 15 +++++++++------
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 17 ++++++++++-------
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 17 ++++++++++-------
> >  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  5 ++++-
> >  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c        | 18 +++++++++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c        |  6 ++++++
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c     |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c   |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c   |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c     |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c   |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c   |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/vega20_ih.c      |  8 +++++++-
> >  22 files changed, 134 insertions(+), 71 deletions(-)
> >=20
> > --
> > 2.54.0




