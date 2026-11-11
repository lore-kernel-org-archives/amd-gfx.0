Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA3606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kScMbi53
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB9C10EA6E;
	Wed, 11 Nov 2026 15:28:53 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2668710EA6E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 15:28:48 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso22806515e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 07:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794410926; x=1795015726; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gnShjvLSHigduqVJbs94Q1k4xsDyyKOG4o4oWqTJUig=;
 b=kScMbi53MdqtwJanBq7IQG7Rd8L/Gb++xivFfTzSWNIYFqGtfIcQ3wb/Sj3SnCbERk
 Zn54DBz9IEebCxtwy3ZZx3R6ZAD9uddBhZtvQnA3AE81RCsEu09sH1bKvl2SiH38Qo8E
 ZKvi9cRyh3BTdbqU8tztSyAQAKpkbZDboOncB8eHKSaVnra4YO66Ouk3bYhoWfO8y++J
 ZMsL3WEa/RbgdCQkvz50wP4kcl0cqGdMdCrnF9Gz9MYlzASus3UfUQWB2lgGbHEvlWBr
 z4FdlSiQjkZorHAJWypMAKXhS28afeuu3EC9LDIEAo+ZBstloYQqCg/hKdgFl8qghYVw
 gOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794410926; x=1795015726;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gnShjvLSHigduqVJbs94Q1k4xsDyyKOG4o4oWqTJUig=;
 b=yO1MY+T4xSSMeBP5ozObfr5Li71+b/97CU4RmgYapiEUplDMSVa/eNzCO7RFypxt/C
 HgaftPx192ia0IpoELXuQtamy6WGWt3fILNf+gke1FihJV8bGjunZ8HGSmZkcXMfxwgu
 AHa0b3uDQqYUDdpj6gwBl05ESWl0uWaPJUAHcy2DffEgtuKzJ/1X5m+Q8MHKTPfTU+Vk
 iumOjLSxMwbtQ2k6F7NWT/Gmey+FmP4/ki1tsB4Mkl2TRXQLbuU7Egih9al9vEdf32YK
 5Ne/hczCilrXaQNYIFOZU55r2ocCrBoHfi4W5uA6oLSPhNjKkj55UWNPuvvC7y1erE12
 0Ftg==
X-Forwarded-Encrypted: i=1;
 AL+hErEcrQ+qCX4/DHsfBCJT0cHmCkVZpH/TW1jxFQ2FBLIxMlpfOISxDK76jidrco+YBIE9govzZJd9@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8tomqXyAjwG9ERDmUWuQN1J6zsVgZzFuN7JqvsYU0j2S7VCf93
 +C8FIbMPkOAjt22UiZ1KyBEGs86A5v+m6FsyQ7JfjPpQLb1a6ts+bDiC
X-Gm-Gg: AYBFou2cU3mUz1oWxpkHETdFQ0ffaaHWY4o9Ml9yuWHiMnWcG//WbcrQkMNd/jr9jWr
 krcSqI+DBNag6XSiJNY4uQq6jsG6id0e3I0ggik6+kITfvXYhsSR4adzvueAXQjIg3ULlO+a1xu
 8KSKaz4DukNaoZYRu0OZ0eE3BRRVJbFNlM6gU+iG9/Y8XVL8CCbtORanm/uTn+lPVJhVBhvKjNV
 41EZYVsXbdjNbqym04zMSk9qCBir9rT4EjFenwLFisIQN5pF/T341PMvAPBE5vbDh0r8tUFKREt
 6pNvLznGDl0rxxglbNmaut7AAdxujP2bUBxZ6WP+FBHzk6d8p8GoO2WINFbhMGntcgJ1y8D6H7N
 uC8TPEJRgskEpIwHF1aqJv2xIuGCgsx9AVRI9WXO7k+eStiHX57kQJqOoZz8zcYNmxHDgUvbtUM
 8FWH4QHAuZMU2pVx7KaubsBfjEWCQQ+zSPVVK+qnR/zI0/miah/JFq+iK5Nz65A10V77j2ZVSZy
 /9LbW+PuQT9ZcjweL6IUm7EjvWbhO4vkJFdV3B0xyUvwdTN4LH4xx1GZLdvJePOB25Fk49eLNl4
 GvzuwCuFpZ21I1eWZT4OTNm50IBdMgZ7v7I9xKOky8Tua6fNPLuGx7Vh/2IZIf+c+nyzDE+3PIn
 YOmd4vSpz
X-Received: by 2002:a05:600c:310e:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4ba09383147mr47120505e9.16.1794410926410; 
 Wed, 11 Nov 2026 07:28:46 -0800 (PST)
Received: from [192.168.1.92] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0951bf2asm46760965e9.4.2026.11.11.07.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 07:28:45 -0800 (PST)
Message-ID: <9ab5834bfb5e55a10f11566dcd269cf451328db4.camel@gmail.com>
Subject: Re: [PATCH v4 01/13] drm/amdgpu: pass the device to the multi ring
 reset helpers
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"	
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Mario
 Sopena-Novales <Mario.Novales@amd.com>, "Rastogi, Manu"
 <Manu.Rastogi@amd.com>, "Zhu, Jiongyu (Joey)"	 <Jiongyu.Zhu@amd.com>
Date: Wed, 11 Nov 2026 16:28:44 +0100
In-Reply-To: <DM4PR12MB5152D1EC2A42EFEA5D53D0A6E3722@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <DM4PR12MB5152D1EC2A42EFEA5D53D0A6E3722@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-10 at 02:06 +0000, Zhang, Jesse(Jie) wrote:
> AMD General
>=20
> Ping on the series

Hi Jesse,

I apologize for the late reply. I'm reviewing the new version too, just
need some time to finish my review.

Best regards,
Timur

>=20
> > -----Original Message-----
> > From: Jesse Zhang <Jesse.Zhang@amd.com>
> > Sent: Thursday, November 5, 2026 11:06 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > Christian
> > <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;
> > timur.kristof@gmail.com; Mario Sopena-Novales
> > <Mario.Novales@amd.com>; Rastogi, Manu <Manu.Rastogi@amd.com>;
> > Zhu, Jiongyu (Joey) <Jiongyu.Zhu@amd.com>; Zhang, Jesse(Jie)
> > <Jesse.Zhang@amd.com>
> > Subject: [PATCH v4 01/13] drm/amdgpu: pass the device to the multi
> > ring
> > reset helpers
> >=20
> > amdgpu_multi_ring_reset_helper_begin() and _end() take the device
> > from the
> > guilty ring. A reset triggered by a hung user queue has no guilty
> > kernel ring, so
> > pass the device explicitly and allow a NULL guilty ring.
> >=20
> > No functional change.
> >=20
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c=C2=A0=C2=A0 |=C2=A0 4 ++--
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 14 ++++++++------
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |=C2=A0 6 ++++--
> > =C2=A03 files changed, 14 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> > index 734f2a0bc79a..d0b0d3eaffc5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> > @@ -465,11 +465,11 @@ int amdgpu_device_ip_soft_reset(struct
> > amdgpu_ring *guilty_ring,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring_type_mask =3D amdgpu_ring_mask_from=
_ip(ip_type);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_device_lock_reset_domain(adev->re=
set_domain);
> > -=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_multi_ring_reset_helper_begin(ring_typ=
e_mask,
> > guilty_ring,
> > guilty_fence);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_multi_ring_reset_helper_begin(adev, ri=
ng_type_mask,
> > +guilty_ring, guilty_fence);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D ip_block->version->funcs->soft_res=
et(ip_block);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 r =3D amdgpu_multi_ring_reset_helper_end(ring=
_type_mask,
> > guilty_ring, r);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 r =3D amdgpu_multi_ring_reset_helper_end(adev=
, ring_type_mask,
> > +guilty_ring, r);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_device_unlock_reset_domain(adev->=
reset_domain);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > index 7b67e8cecca2..edae764eb0c4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -919,8 +919,9 @@ int amdgpu_ring_reset_helper_end(struct
> > amdgpu_ring *ring,
> > =C2=A0/**
> > =C2=A0 * amdgpu_multi_ring_reset_helper_begin() - Prepare multiple ring=
s
> > for a
> > reset.
> > =C2=A0 *
> > + * @adev: amdgpu device
> > =C2=A0 * @ring_type_mask: Bitmask of affected ring types
> > - * @guilty_ring: The ring which is guilty of causing a reset.
> > + * @guilty_ring: The ring which is guilty of causing a reset, or
> > NULL.
> > =C2=A0 * @guilty_fence: The fence which didn't signal on the guilty
> > ring.
> > =C2=A0 *
> > =C2=A0 * Useful when performing a GPU reset method that affects @@ -
> > 938,11
> > +939,11 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring
> > *ring,
> > =C2=A0 * After the reset is complete, the caller should then call
> > =C2=A0 * amdgpu_multi_ring_reset_helper_end() to restore the rings.
> > =C2=A0 */
> > -void amdgpu_multi_ring_reset_helper_begin(const u32
> > ring_type_mask,
> > +void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device
> > *adev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 const u32 ring_type_mask,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct amdgpu_ring
> > *guilty_ring,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct amdgpu_fence
> > *guilty_fence)
> > {
> > -=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_device *adev =3D guilty_ring->a=
dev;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_fence *ring_guilty_fence;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ring *ring;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool rings_busy;
> > @@ -1034,8 +1035,9 @@ void
> > amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
> > =C2=A0/**
> > =C2=A0 * amdgpu_multi_ring_reset_helper_end() - Prepare multiple rings
> > for a reset.
> > =C2=A0 *
> > + * @adev: amdgpu device
> > =C2=A0 * @ring_type_mask: Bitmask of affected ring types
> > - * @guilty_ring: The ring which is guilty of causing a reset.
> > + * @guilty_ring: The ring which is guilty of causing a reset, or
> > NULL.
> > =C2=A0 * @ret: Return code from the reset function.
> > =C2=A0 *
> > =C2=A0 * After calling amdgpu_multi_ring_reset_helper_begin()
> > @@ -1046,10 +1048,10 @@ void
> > amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
> > =C2=A0 * be called to restore preemption state, but it won't attempt to
> > =C2=A0 * fully restore the ring contents.
> > =C2=A0 */
> > -int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
> > +int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u3=
2 ring_type_mask,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct amdgpu_ring
> > *guilty_ring, int ret)=C2=A0 {
> > -=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_device *adev =3D guilty_ring->a=
dev;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ring *ring;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, r;
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index b2040f80b7f2..7e6ed43771f2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -637,10 +637,12 @@ void amdgpu_ring_reset_helper_begin(struct
> > amdgpu_ring *ring,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_fence
> > *guilty_fence);=C2=A0 int
> > amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_fence *guilty_fence);
> > -void
> > amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
> > +void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device
> > *adev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 const u32 ring_type_mask,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct amdgpu_ring
> > *guilty_ring,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct amdgpu_fence
> > *guilty_fence);
> > -int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
> > +int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u3=
2 ring_type_mask,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct amdgpu_ring
> > *guilty_ring, int ret);
> > bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 u32 reset_type);
> > --
> > 2.50.1
