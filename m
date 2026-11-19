Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD05606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XUFnTPG3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B7C112160;
	Thu, 19 Nov 2026 11:33:31 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63609112160
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 11:33:25 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso21335185e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 03:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795088004; x=1795692804; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hU9Jd9hbKmGBVrdrlMRlMKHrjrdfdDpcWmEkUC6JJTA=;
 b=XUFnTPG3kZgjxgMOva/dmqjsUEgFEOubhmj4r65js9cKsPcUOqU2iK0iW/MiSXiKRg
 SRJRsIahZTt7pzlzmX003JA5HR8jz8aNHZIUSLA35tSKzxxXhxA8ZQl3R3FoHTKqiqD+
 s3GE5rAOy1RVCYHWLZq0p86uTlyOqeydkoI2NtW6G/iuXmiE7xq/LMeqE+qmVK+BVP7X
 BtpAWrrckpWxp2qMnhSLXFVkpw+wDu+xxB4yMfp6IeTwSRMEx2FB4QAL5549nxRkXmXS
 1ex3srK08SciPOgx0OgCXOn4hVZOF6mHfMR0ifwqFUIxWxohnaZNTKtXa+oh9gwo5kNW
 uXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088004; x=1795692804;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hU9Jd9hbKmGBVrdrlMRlMKHrjrdfdDpcWmEkUC6JJTA=;
 b=RGMIvDTq6eU7uNx1sEFWS8Sds7Cp/GqYij4QkdSsPEMgW/8mysO96uwS2bzo4BBPNQ
 tC/rYyI7PwfnR2eqSeYojAGwAROQyRYEJJ4CaiwPTSgfBG5VgY2Pk5Rp0Gf9TlLelrR4
 dMKQJiZsbM8AKQDSongr8eugUUhawnKoGNjCR/bx1NijcYulA0bDHHMCN1GTICNmRFjR
 O1fNvH38TcJyEZzU1zS41PCsGD72d51IUu6yAEuoAZiiZvu9gi62qqtXxeyTfzs16Qt2
 M08zHvaLlbPPEqxC5y4YqlXc7Wyv98c64jMo6nmwuhjLslZ7xOMqGLkYKCDKOG/gchUk
 BD1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGH9JhWMIfJ72Ks2gX28M2HeUalUH4JeMmwbEWg2F2Pr/gPuPfCJb8e62MClL+LKGL5TMP3pS/s@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Elpgi0TjyPwGVY8HuDZnobHf23egJXhqDwBdCy8GjIeeFu0jI
 vAxeuZFst9GV7YDe6iO/pKsOAQ6zqHYric9GmNDFGCD+XyJ3jBjsMB21
X-Gm-Gg: AYBFou2CL7ajNEFOidTK54YO8usthcnat+7ian5hGfziulzsZairjnxvSO5eewLPhJ/
 Ua5pLRFsjXWt/CCFmS+2IpMWDEPjZPPSWo5Fmx1BUejXsRTupX3vDUBsgYVh6B868i8RWTa87BX
 qmaZ9XwdNngpRGX3b7dn1iha7bKbk3LjBe6CvpJvIn/8gU07kGb9tu8JyoL1dfE4rGmZ2pupBZI
 obaUzXDZxzCY4XjNnJF8fchQ2rPRKX5ZKrboVM2Y2muAi+PnS5kRbRP6l9GyU1uejWSqrJL9g+E
 qTwnl9yvxjXNy9Hc2MyQOLchD+8ztTG4KhwY8vaXfzI4WyXtj/FifnwTAkCEhedSmJb4iQZTS+N
 Z0916WanMzwuvJfzOy77stEsZfm9J9bxIvajvL8rAU4q3txYc6Qt5+PH52KVK4vZRrr/uyp3nGs
 sC23ImNSbESu2i7vSw9ZjjyeA3CaHja4fQaTCVP6tpxo/a5vsGyUO6koUA6uSXTrdDm8FzmWwq4
 sAzFnIUC0wR/eNntNcKEPnQQ1w47Jgiz8mKDYSbG2VqHYd1QNeBB6AAa151MG5oq01Q+XgWjtW1
 BYXOBZbXVT+4cGrwhsc33tBcZ+qvRGvybblO2ONQaxxH0thZZlNSNQVAHCNay8LL9QaKHMBJbsP
 MSaEe
X-Received: by 2002:a05:600d:41c9:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4bb7da12715mr103605685e9.5.1795088003408; 
 Thu, 19 Nov 2026 03:33:23 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c23bsm8748100f8f.12.2026.11.19.03.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:33:22 -0800 (PST)
Message-ID: <eeef593a3c6c546dd634277c20a361b6155e482e.camel@gmail.com>
Subject: Re: [PATCH v4 01/13] drm/amdgpu: pass the device to the multi ring
 reset helpers
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Thu, 19 Nov 2026 12:33:21 +0100
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
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

On Thu, 2026-11-05 at 11:05 +0800, Jesse Zhang wrote:
> amdgpu_multi_ring_reset_helper_begin() and _end() take the device
> from
> the guilty ring. A reset triggered by a hung user queue has no guilty
> kernel ring, so pass the device explicitly and allow a NULL guilty
> ring.
>=20
> No functional change.
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 14 ++++++++------
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |=C2=A0 6 ++++--
> =C2=A03 files changed, 14 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> index 734f2a0bc79a..d0b0d3eaffc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> @@ -465,11 +465,11 @@ int amdgpu_device_ip_soft_reset(struct
> amdgpu_ring *guilty_ring,
> =C2=A0	ring_type_mask =3D amdgpu_ring_mask_from_ip(ip_type);
> =C2=A0
> =C2=A0	amdgpu_device_lock_reset_domain(adev->reset_domain);
> -	amdgpu_multi_ring_reset_helper_begin(ring_type_mask,
> guilty_ring, guilty_fence);
> +	amdgpu_multi_ring_reset_helper_begin(adev, ring_type_mask,
> guilty_ring, guilty_fence);
> =C2=A0
> =C2=A0	r =3D ip_block->version->funcs->soft_reset(ip_block);
> =C2=A0
> -	r =3D amdgpu_multi_ring_reset_helper_end(ring_type_mask,
> guilty_ring, r);
> +	r =3D amdgpu_multi_ring_reset_helper_end(adev, ring_type_mask,
> guilty_ring, r);
> =C2=A0	amdgpu_device_unlock_reset_domain(adev->reset_domain);
> =C2=A0
> =C2=A0	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 7b67e8cecca2..edae764eb0c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -919,8 +919,9 @@ int amdgpu_ring_reset_helper_end(struct
> amdgpu_ring *ring,
> =C2=A0/**
> =C2=A0 * amdgpu_multi_ring_reset_helper_begin() - Prepare multiple rings
> for a reset.
> =C2=A0 *
> + * @adev: amdgpu device
> =C2=A0 * @ring_type_mask: Bitmask of affected ring types
> - * @guilty_ring: The ring which is guilty of causing a reset.
> + * @guilty_ring: The ring which is guilty of causing a reset, or
> NULL.
> =C2=A0 * @guilty_fence: The fence which didn't signal on the guilty ring.
> =C2=A0 *
> =C2=A0 * Useful when performing a GPU reset method that affects
> @@ -938,11 +939,11 @@ int amdgpu_ring_reset_helper_end(struct
> amdgpu_ring *ring,
> =C2=A0 * After the reset is complete, the caller should then call
> =C2=A0 * amdgpu_multi_ring_reset_helper_end() to restore the rings.
> =C2=A0 */
> -void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
> +void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device
> *adev,
> +					=C2=A0 const u32 ring_type_mask,
> =C2=A0					=C2=A0 struct amdgpu_ring
> *guilty_ring,
> =C2=A0					=C2=A0 struct amdgpu_fence
> *guilty_fence)
> =C2=A0{
> -	struct amdgpu_device *adev =3D guilty_ring->adev;
> =C2=A0	struct amdgpu_fence *ring_guilty_fence;
> =C2=A0	struct amdgpu_ring *ring;
> =C2=A0	bool rings_busy;
> @@ -1034,8 +1035,9 @@ void amdgpu_multi_ring_reset_helper_begin(const
> u32 ring_type_mask,
> =C2=A0/**
> =C2=A0 * amdgpu_multi_ring_reset_helper_end() - Prepare multiple rings fo=
r
> a reset.
> =C2=A0 *
> + * @adev: amdgpu device
> =C2=A0 * @ring_type_mask: Bitmask of affected ring types
> - * @guilty_ring: The ring which is guilty of causing a reset.
> + * @guilty_ring: The ring which is guilty of causing a reset, or
> NULL.
> =C2=A0 * @ret: Return code from the reset function.
> =C2=A0 *
> =C2=A0 * After calling amdgpu_multi_ring_reset_helper_begin()
> @@ -1046,10 +1048,10 @@ void
> amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
> =C2=A0 * be called to restore preemption state, but it won't attempt to
> =C2=A0 * fully restore the ring contents.
> =C2=A0 */
> -int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
> +int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u32 ring_type_mask,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ring
> *guilty_ring, int ret)
> =C2=A0{
> -	struct amdgpu_device *adev =3D guilty_ring->adev;
> =C2=A0	struct amdgpu_ring *ring;
> =C2=A0	int i, r;
> =C2=A0
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b2040f80b7f2..7e6ed43771f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -637,10 +637,12 @@ void amdgpu_ring_reset_helper_begin(struct
> amdgpu_ring *ring,
> =C2=A0				=C2=A0=C2=A0=C2=A0 struct amdgpu_fence
> *guilty_fence);
> =C2=A0int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> =C2=A0				 struct amdgpu_fence *guilty_fence);
> -void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
> +void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device
> *adev,
> +					=C2=A0 const u32 ring_type_mask,
> =C2=A0					=C2=A0 struct amdgpu_ring
> *guilty_ring,
> =C2=A0					=C2=A0 struct amdgpu_fence
> *guilty_fence);
> -int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
> +int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u32 ring_type_mask,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ring
> *guilty_ring, int ret);
> =C2=A0bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
> =C2=A0					 u32 reset_type);
