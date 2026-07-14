Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43481C44508
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 15:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A5210E074;
	Tue, 14 Jul 2026 15:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DTU2s2Df";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E0C910E074
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 15:39:45 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-475881b9a4bso1001626f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784043584; x=1784648384; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hU1HHqXSZbkcEDf0w+wJjDB22ACaAi2S3LpJwzADS9w=;
 b=DTU2s2DfSTGrEcm/E4J3rZ5bY/yXw4mll04Izp/y/aA/TIy/oL09BG0MGHerM1T1We
 5XAV6oYxIaCZxkpxBSwB6Hvl7pJ8vEbc5xc4w0V5rflWelMhbWUGbiPU+nr2vNR5rd1p
 z81l2WmqiB5k6co2kZjCuRq/XQRq91lKo/bJlmu+DXwpzwQe0BrUiKbXomVyK7lKK03p
 0mHDnOaUyvISsRRf9qAO65Y/s44HerEPf2KDLunx41koOHAVuLYjb4p2O4sAwwR0twFA
 nOKpBJEFc4J0QDzjmD1QnrPTv4LJ+xo0DnDC9Sj1DiHIA5kuCcBWOg+jnYuVB/pm53Sy
 hIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784043584; x=1784648384;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hU1HHqXSZbkcEDf0w+wJjDB22ACaAi2S3LpJwzADS9w=;
 b=PucISXY1eiKk2CBgHB/TvoOWLRnyFaDrbGOwIdYosIqP9quWGxFkcG9clteDVXnk+N
 ejBIG5AXTd9FaXIj/Alu7nQMB6+Pwp5A4iahagNo3ZvgXnw1B2Fr9GBu3ghBbGcn9yRD
 8Qj2bKW6QiwNX7XRMeIHfSVctOA6HgtnZkBHEnacWt8neuKNzrXSB4mCp09sn7ML64tV
 uFak0nz1wcJzzGYgjOTaWQ6vOniP6wlcbPJ9WYt4qlTSCDnb8kUC5oi96ALeUHqhAVCp
 iDK09RZ6jQ/RDV9Gc4au5jbDG7rLCt2GQGMik0Dqb21eZ5SiY/fQM6v9P70kP/z2NCH9
 9RZA==
X-Gm-Message-State: AOJu0Yw2Zu45ZGbsq700wrl8eSFuM6dBXi32TU2Np2Bdtu4xpT788ATP
 Zb9H+fscmspQezZ0jOcBMLsHuM0tPnimwHPgJ+QSTbsf+WDsvItBGUVq
X-Gm-Gg: AfdE7cl9dpSxaz+F+F6CzmiG5iQ0iyu5OX6nEsIyf3GXmjkS83LchMXYqvTiydQmFWH
 9rb09HG/4caqQ98vO1Qm598E1PtbfAnfW9dm8taBq5oa9/j4CDGRLicGcDDdYrCFN/w66LwzvJJ
 ewQRYCZQsSs1bX2qBwjm2Ap9X8rXPPz+nqjT8RjHmoMJqag0ptE0veEiGXyOHoiK/mg2/mt+uAR
 SGhStVmggRIl9LJ7c9NW0YCZuY8i5AWwfLHP3NHE33wnE4eQRJm7IP3/I4j+GSBDu57ja/kNVHC
 Km9KQiqx6qHsUudKO+8GYRBuGd28dpMzRIZYQjTwDqdao+msu804Fnybb3I7c9nKWx1Pk4iH82R
 a8C7AlhMPThuvENUCKvMlcyLoO5SjjoYlikmInV7MqAlNtF0aD6H6DUNhZ8DKxG8T6+JDwpwF99
 /mGyv8a0SrxJ68rs/SKkUSdCegPh53lUH4f26xgAnk2BEyiXlgtfBD2qVPReSMpw==
X-Received: by 2002:a05:6000:2285:b0:473:6e8d:7f3 with SMTP id
 ffacd0b85a97d-47f2dcd1a25mr16400840f8f.1.1784043583494; 
 Tue, 14 Jul 2026 08:39:43 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1BC569.dsl.pool.telekom.hu.
 [94.27.197.105]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c1f84sm9330314f8f.29.2026.07.14.08.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 08:39:43 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Subject: Re: [PATCH 1/9] drm/amdgpu/gfx7: Make amdgpu_gfx_mqd_sw_init() usable
 on GFX7
Date: Tue, 14 Jul 2026 17:39:41 +0200
Message-ID: <OYDF_volTbuQ8b1_pht54A@gmail.com>
In-Reply-To: <061761c8-cdd1-47d2-abcb-718711c49cef@ursulin.net>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <CADnq5_MWaSxpnMBRYsk-vqhKPvZB_ohq4yCZsu_iYMG+M2dmiA@mail.gmail.com>
 <061761c8-cdd1-47d2-abcb-718711c49cef@ursulin.net>
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

On Tuesday, July 14, 2026 5:19:57=E2=80=AFPM Central European Summer Time T=
vrtko=20
Ursulin wrote:
> On 14/07/2026 16:05, Alex Deucher wrote:
> > On Tue, Jul 14, 2026 at 10:59=E2=80=AFAM Tvrtko Ursulin <tursulin@ursul=
in.net>=20
wrote:
> >> On 13/07/2026 13:58, Timur Krist=C3=B3f wrote:
> >>> We don't use KIQ on GFX7 but otherwise MQD works the
> >>> same way as GFX8 and newer.
> >>>=20
> >>> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>> ---
> >>>=20
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c index
> >>> 96c9d4f00b27..0f142c156afa 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >>> @@ -420,7 +420,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device
> >>> *adev,
> >>>=20
> >>>    #endif
> >>>   =20
> >>>        /* create MQD for KIQ */
> >>>=20
> >>> -     if (!adev->enable_mes_kiq && !ring->mqd_obj) {
> >>> +     if (adev->asic_type >=3D CHIP_TOPAZ && !adev->enable_mes_kiq &&
> >>> !ring->mqd_obj) {>>=20
> >> CHIP_TOPAZ is gfx7? Hm if it is then the branch would already run ther=
e.
> >> So the change is limiting the branch to a subset of platforms, while t=
he
> >> patch title made me think it is enabling something on gfx7. Perhaps
> >> somehow indirectly or what am I not understanding?
> >=20
> > TOPAZ is gfx8.

We currently don't use KIQ on GFX7 so the patch changes the code to allocat=
e=20
the BO only on GFX8 and newer. Topaz is the first GFX8 chip in the enum, so=
=20
that's why the code checks >=3D TOPAZ here.

> Ah now I get it, thank you! Could maybe adev->gfx[0].kiq.something or be
> used to make it a bit self-documenting?

Technically, GFX7 supports the KIQ, amdgpu just doesn't use it. So, I fear=
=20
that adding a field would mislead the reader into thinking that the HW supp=
ort=20
is missing when it really is just the kernel doesn't use it.

How would you feel about just updating the comment above the changed line?
Maybe like this?

/* create MQD for KIQ - only on GFX8+ GPUs where we use the KIQ */

I think that would make it self-explanatory.

>=20
> >>>                /* originaly the KIQ MQD is put in GTT domain, but for
> >>>                SRIOV VRAM domain is a must>>>               =20
> >>>                 * otherwise hypervisor trigger SAVE_VF fail after dri=
ver
> >>>                 unloaded which mean MQD * deallocated and gart_unbind,
> >>>                 to strict diverage we decide to use VRAM domain for




