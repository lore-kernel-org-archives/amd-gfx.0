Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDF606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pg4/eJA5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C7010F82F;
	Tue,  3 Nov 2026 20:12:21 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB4010E811
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 20:12:15 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so11226205e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 12:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793736734; x=1794341534; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rzfg/h1ayQvCfs+vJ0HflLnTVfKkUhcDdWUVOaA9XrI=;
 b=pg4/eJA5c9ft1T++QQchf9BWyAL06tkm3azU03r37Rcq47tSA4SGrIPhOspnNyLyrv
 BhRlR9O3dXg/sUAkm3kHNC/7a+HC3RlU30r64YzNiM+I5iqmabCxRp9CbIXqn8TcZF6Z
 g+/Jkq0hrgNqzsuK22a41CQjMYvypIpZIPx9hp72Lsnm8N1vmQKW53dGSvqXpBOWYil5
 5EChM4F/UGMDgEqAXTQQ65XzHufAKV8s6SplKUlBQ0GZ6DP3tWdRCm7kZomYkzOJisLD
 p7rUXOQW8qLK94P9nFGpKkbH0Ey3TJFmBa0GKMHE8vNDkhcISS9Q2pTh1oprvm/UD0AA
 o+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793736734; x=1794341534;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rzfg/h1ayQvCfs+vJ0HflLnTVfKkUhcDdWUVOaA9XrI=;
 b=0Z0ByXwZSmVbf7VhpCNGgQvV3m22FvgfSw8P4aKnw8IcXp3RPKiT1yvRvxavrkCT8W
 3gOGcOiVaOvFQjE1g7CEInBwlbvnMXxn46B9R39lGsvMzvxgytaQMLVlHJCv8QRHvVAT
 DuNAXLXZdD5BWS0RFCTjsy01nfUWIsakVumVtZIykmxLSjziwsWtLW/icIpRTF7jRuNt
 GuvhywaGu1nEw6AdQ+H2Wc4e3AARGRIckh2JjpM5Eyg3rzEgjumD4F61jOeLqBXGpxZb
 1+UUCHxHz86eUJH6UGzwEgQx268aWArEUzckYFBruMN8ctw7/yT00fcuD+189kTh70zO
 ljXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYx51V46ydY6c30aqIAsTz+3Qq5mzg3kHxmjmbT1QwYyWL3nn6gfhTyea/lPDBEmBErIecc9fH@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/u+kS7pp3WdDliOI/gXFwiqAqr/0Rz/C/BLI7XrSv5o3VV8438
 fohPgSE30Rx5i5yPZeeB+4U8ZGnPbSGV2Nckljk1YkNL16fASwHYEmZT
X-Gm-Gg: AYBFou3zFbAS3T6IJ9X2FNUzh/txirmnhYbA5tZ/ixOlny8FyWP8RtBzweDmeA/1P3T
 l+yBIQ3m40qL04wXxdUVBy9Iw/cIeAhtX+oF3Rxh7jbSwqQbR1Yr4u4U8nJcpvcXOsWvNayC+t3
 z2aiDXnd75RYe+FKB/rkwP1LuFmnDLGZsFZNvoAforGOljL9fXucVSWB5GFRhI2OzyXDsfDa8FC
 SEa+P01uAdPaiyQG3BNZiwr+GD4fsukDGtv6C4mP2AA0/ntPnGyCOuPAcDFu+DxXN9MinnkXjl2
 WPD/kCS4dur3/evRHIWZ5nHkl8tFA4XynLWJCO3crA3jAmd4ywfCIDUleslX3ll37+/1nhFQfNn
 b18rwbWXRENo/uPeQfDw4nHWLl9vA5nInPZBLDGSyZ5NT9FAbmszj88U9GscplwkKOsY8LN6vAf
 uqFsPmJxkY7VNK/RuMZvsUVF43awHrRTKlahUwzNdbJd1L0xZXRyY0GVcZyE1+TTsP1ocFYkaQY
 rX7KP/+/Rc4yhwMbtVQpUrier+QO3Ap4HLnLP6/lhP5NXgf4sqco2RGP37mjuIWG0Sn87Maff1X
 Zykq4HrCiu/fW9IohyJ23Glm7uaeoHWLNRh4eSA8Xzt6Y6pmad/pVG5ZbQY6LtdPnxosVI6HIqk
 PI74dpn2NPQ==
X-Received: by 2002:a05:600c:6285:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4ac180f07d1mr345213015e9.17.1793736733783; 
 Tue, 03 Nov 2026 12:12:13 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fcca7cf52sm309350f8f.33.2026.11.03.12.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:12:13 -0800 (PST)
Message-ID: <d744c7dedfc32ba6f1a66731eb9aa196f46af941.camel@gmail.com>
Subject: Re: [PATCH v3 02/15] drm/amdgpu: complete the guilty fence at the
 end of a multi ring reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Tue, 03 Nov 2026 21:12:12 +0100
In-Reply-To: <20261028085736.3808569-2-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-2-Jesse.Zhang@amd.com>
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

On Wed, 2026-10-28 at 16:56 +0800, Jesse Zhang wrote:
> amdgpu_ring_backup_unprocessed_commands() skips the backup of a ring
> and
> clears ring->guilty_fence when it sees the same guilty fence again,
> to
> avoid replay loops. That happens when the IP block soft reset follows
> a
> failed ring reset of the same job.
> amdgpu_multi_ring_reset_helper_end()
> then restored the guilty ring with ring->guilty_fence, NULL by then,
> so
> neither the guilty fence nor the rest of the ring was completed: the
> hung
> job stayed pending until it timed out again.
>=20
> Pass the guilty fence to the end helper, and use it for the guilty
> ring.
> For the other rings, and when the backup didn't drop it, nothing
> changes.
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c=C2=A0=C2=A0 |=C2=A0 3 ++-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 13 ++++++++++---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |=C2=A0 3 ++-
> =C2=A03 files changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> index d0b0d3eaffc5..2eea18965fd1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> @@ -469,7 +469,8 @@ int amdgpu_device_ip_soft_reset(struct
> amdgpu_ring *guilty_ring,
> =C2=A0
> =C2=A0	r =3D ip_block->version->funcs->soft_reset(ip_block);
> =C2=A0
> -	r =3D amdgpu_multi_ring_reset_helper_end(adev, ring_type_mask,
> guilty_ring, r);
> +	r =3D amdgpu_multi_ring_reset_helper_end(adev, ring_type_mask,
> guilty_ring,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guilty_fence, r);
> =C2=A0	amdgpu_device_unlock_reset_domain(adev->reset_domain);
> =C2=A0
> =C2=A0	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index edae764eb0c4..7f0f0ae6650a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -1038,6 +1038,7 @@ void
> amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
> =C2=A0 * @adev: amdgpu device
> =C2=A0 * @ring_type_mask: Bitmask of affected ring types
> =C2=A0 * @guilty_ring: The ring which is guilty of causing a reset, or
> NULL.
> + * @guilty_fence: The fence which didn't signal on the guilty ring.
> =C2=A0 * @ret: Return code from the reset function.
> =C2=A0 *
> =C2=A0 * After calling amdgpu_multi_ring_reset_helper_begin()
> @@ -1050,7 +1051,8 @@ void
> amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
> =C2=A0 */
> =C2=A0int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u32 ring_type_mask,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ring
> *guilty_ring, int ret)
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ring
> *guilty_ring,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_fence
> *guilty_fence, int ret)
> =C2=A0{
> =C2=A0	struct amdgpu_ring *ring;
> =C2=A0	int i, r;
> @@ -1080,8 +1082,13 @@ int amdgpu_multi_ring_reset_helper_end(struct
> amdgpu_device *adev,
> =C2=A0		if (!(BIT(ring->funcs->type) & ring_type_mask))
> =C2=A0			continue;
> =C2=A0
> -		/* Restore contents of the ring */
> -		r =3D amdgpu_ring_reset_helper_end(ring, ring-
> >guilty_fence);
> +		/*
> +		 * Restore contents of the ring. The backup of the
> guilty ring
> +		 * may have dropped its guilty fence, eg. after a
> failed ring
> +		 * reset with the same fence: still complete it.
> +		 */
> +		r =3D amdgpu_ring_reset_helper_end(ring, ring =3D=3D
> guilty_ring ?
> +						 guilty_fence :
> ring->guilty_fence);

Can you help me understand what was wrong with the line before?
I think guilty_fence =3D=3D ring->guilty_fence when ring =3D=3D guilty_ring=
 no?


> =C2=A0		if (r) {
> =C2=A0			dev_err(adev->dev,
> =C2=A0				"Failed to recover ring %s after
> soft reset\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7e6ed43771f2..349c7d503e5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -643,7 +643,8 @@ void amdgpu_multi_ring_reset_helper_begin(struct
> amdgpu_device *adev,
> =C2=A0					=C2=A0 struct amdgpu_fence
> *guilty_fence);
> =C2=A0int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u32 ring_type_mask,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ring
> *guilty_ring, int ret);
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ring
> *guilty_ring,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_fence
> *guilty_fence, int ret);
> =C2=A0bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
> =C2=A0					 u32 reset_type);
> =C2=A0#endif
