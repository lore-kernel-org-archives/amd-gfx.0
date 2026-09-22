Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4EAC982FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 15:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E63F10ED71;
	Tue, 22 Sep 2026 15:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pJGuGHL2";
	dkim-atps=neutral
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 212D610ED71
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 15:34:16 +0000 (UTC)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2a9edfc851so100182366b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790091254; x=1790696054; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5HSSlR3RciXoHLvVrFAH7klpXQ9AOTX7doEQWX3CHaU=;
 b=pJGuGHL2FLWOON7j976JQgyhLmNZMom0cW3IB354KTu0i4imPfv7Bi47IJiMSH/sC/
 Qma/WhADDHoilrqjVPBLSUZlTz5IHve264DyC75cLJ3eeoJyv84jUwAO+ize3kLjZ15K
 EVq+ZejvUnBqStOYRJvKsgzaFGgMRozn5yOO5w8k/BKGLYRBlvbs9f8hv/qW92aW8UN1
 ZDEoWM2tMO+gQAtTFsPCNv5iEm57A0anE+NQlgwVSJ/FFGDJ9mEOu35YJTzBTGLv2IoT
 a8Yj5GGRVB/j/ZJ3j4F4E+KB6hNSd66OhbLvoVOiMgAQ+C0ZZxqdqsC2b9DB955/7bmJ
 v/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790091254; x=1790696054;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5HSSlR3RciXoHLvVrFAH7klpXQ9AOTX7doEQWX3CHaU=;
 b=BAEoN9XbYtiXOiYcHNHbP+TLSmqnMhW91uxKoVg69QV0P9JbyRE7E5tGXG5UxTkS39
 9g8dQ8Eg5IPxXmssAEuuCaVTZRjZLyOEFWgVymliL1E3yTmZZQ6K8CtZTdlzGSOIrOAO
 kTtvlhHTZql/T/eG9D/hHaw2aiKLcT32OjOKe+lk2kh2QZxT2mOzJxvDOQxVsPFXjaBs
 YDvqUFsZPmrZMXXMIO4KOb5unLJ2g5N+Hnj9McjLqJHo5xYxRPi+eilhbwkqJPO9tjSr
 RwTLELUMpeI2Xh/TVhWX2wxklBJEcNkqGzys6qjyiH06DUHcgg+jkYJD9gTg0cHIAjjM
 boDQ==
X-Gm-Message-State: AFuF++mC+1P3RIxkRuVRGZA4N9jconEe6NXRahYmerkTVwnOimk00yI6
 NRb+MJ3mbVjVuvbAGUAsg5BHh3PYe2ugljA9b+Owr7l2aTRsHGd2IrGuS5Z3tVvI
X-Gm-Gg: AYBFou2h+9tqKEvoVvzA1CwR36aNILkfqis8Ih28WHql9bsmH4tV0BLgC7wEvsmf/NH
 vgH6chqGgiHOLZmJ+JmwYBp1NIlbRroCZvsqVNJEbC4ANi8DI0PDRyRZ+/X/o9fNN1ZlMRtlfoK
 1pA4T7g+MCeAs3C6IdCZjiiJoH2kfBcLqU7h3xWQ+6tQDeE9RdGGImxrWWagSCk9aMTOP7gZ80N
 8pWAUlvos1sGQ5QPN7XIFxscF5mHCNoLaGjhMTHqPAxya0E2wgshs6Cer1awxR5pNRy1biD6WxA
 Ye7DFgsZOkiWu09v6AAUXhPVvb6rwkncsfO8nf9xTGOaI5RldwU/sIZYgYhXx7k9+O8INNf1AYz
 u7lvDbYStMCEOw2wE1fyH+I2V5Dynz0XY5bnrQRIvOjIASAXabAy8RrGMmoND1A3VF1u3+7Muib
 KZN0US9j2BzIvmXLCTdptsr2qbDhOaVQqr5A9zcs4qVSoW35oD/MGrnzUnkCKHoqkt3QqWfnG6m
 ILiFvM4imkvFwyVApHMZZU723ZfZguuSEa4XX24qN0kyj5U7vVSfKyt
X-Received: by 2002:a17:906:f597:b0:c21:8c6a:c680 with SMTP id
 a640c23a62f3a-c2a159adfdfmr1212340066b.22.1790091254429; 
 Tue, 22 Sep 2026 08:34:14 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D96A.dsl.pool.telekom.hu.
 [84.1.217.106]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a9c5b7359sm113380866b.38.2026.09.22.08.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:34:13 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, Bing.Ma@amd.com, 
 James Zhu <jamesz@amd.com>
Cc: James Zhu <James.Zhu@amd.com>, Natalie Vock <nat@pixelcluster.dev>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 01/12] drm/amdgpu: add profiler UAPI definitions
Date: Tue, 22 Sep 2026 17:34:13 +0200
Message-ID: <-2dFiumdQ7an8e02CFlfgw@gmail.com>
In-Reply-To: <3553c2d2-ca84-4333-a3cf-e3c745eaad1f@amd.com>
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <E26TqGhRRCmT_3vybr_f2w@gmail.com>
 <3553c2d2-ca84-4333-a3cf-e3c745eaad1f@amd.com>
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

On Tuesday, September 22, 2026 5:32:12=E2=80=AFPM Central European Summer T=
ime James=20
Zhu wrote:
> On 2026-09-22 11:22, Timur Krist=C3=B3f wrote:
> > On Tuesday, September 22, 2026 5:20:41=E2=80=AFPM Central European Summ=
er Time
> > James>=20
> > Zhu wrote:
> >> On 2026-09-22 11:09, Timur Krist=C3=B3f wrote:
> >>> On Monday, September 21, 2026 10:03:02=E2=80=AFPM Central European Su=
mmer Time
> >>> James>
> >>>=20
> >>> Zhu wrote:
> >>>> Add the DRM_AMDGPU_PROFILER ioctl number and its argument structures,
> >>>> the
> >>>> UAPI for GPU performance monitoring features such as SPM (Stream
> >>>> Performance Monitor).
> >>>>=20
> >>>> struct drm_amdgpu_profiler_args carries an operation selector and a
> >>>> union
> >>>> of per-operation parameters, currently AMDGPU_PROFILER_OP_GET_VER and
> >>>> AMDGPU_PROFILER_OP_SPM. The SPM operations and the layout of the
> >>>> destination buffer are described by struct drm_amdgpu_spm_args and
> >>>> struct drm_amdgpu_spm_buffer_header.
> >>>>=20
> >>>> The ioctl number and struct layout are frozen here. The implementati=
on
> >>>> lands in the rest of this series and the ioctl is not registered in
> >>>> amdgpu_ioctls_kms[] until then, so this header change alone does not
> >>>> make
> >>>> the interface reachable.
> >>>>=20
> >>>> Signed-off-by: James Zhu<James.Zhu@amd.com>
> >>>> Reviewed-by: Bing Ma<bing.ma@amd.com>
> >>>=20
> >>> Hi,
> >>>=20
> >>> Can you guys please clarify why this is necessary and what the use ca=
se
> >>> is?
> >>>=20
> >>> Are we sure we want a uAPI for this? RADV has been using SPM from
> >>> userspace
> >>> for many years now.
> >>=20
> >> [JZ] current RADV SPM is for graphic engine. These patches are for
> >> compute engine SPM.
> >>=20
> >> Thanks!
> >=20
> > Is there any reason why it can't be done in userspace for compute too?
>=20
> [JZ] for compute engine, user space is using ROCM stack , not RADV.

Is there any reason why SPM can't be handled from userspace?
(Regardless of whether that userspace is RADV or ROCm)




