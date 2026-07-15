Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC52C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 10:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6974710E011;
	Wed, 15 Jul 2026 10:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r44ySvD3";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0612A10E011
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 10:45:46 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so6243655e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 03:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784112344; x=1784717144; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n4ckrSv62jixhloIeP/xzg75q2MAF+cTs9DrqBPsmKQ=;
 b=r44ySvD3N+HSwASGR5mVRpnqUnA5mkW04RbonIu5VR/lcSdBQKkU5lExFMhSfa0yhw
 r0Ea1mxA3POiC7PIRLT6bXCnPY2mPvN7RKsiSHL8QBwfhQ6eiUTEyjokDrd3Y5X4ub23
 b4gCHI9WN7kO9CB8oW3lttdoIAJ+r7SI3YYhSkXN1XKc7qiqS4uRODGy+qCiQL+cfhaN
 BfarbZu38JX73h7IzgqllDtT4zUc+wHC0N4aPrTShPt5Y9I70kYwlP1wAx4DKGvoyNDH
 LHwxP6tTzKt2h/w9cpPvAngKzFp5J5lke/7ZJml8mYYbdaLJsk24Jn/rjDU3iaBGqHHk
 hFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784112344; x=1784717144;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n4ckrSv62jixhloIeP/xzg75q2MAF+cTs9DrqBPsmKQ=;
 b=HonQ29p46MD6xTqQZ70h3Z26/i8lFKOxjzhlkzgkzpsGQ6C8VqTLVLWy1UlwVoNDYB
 EZanBqH8mAnBloIOPl7MoUHN05V9jFpdY9KQBGqi7b+xjcy+3lzbOcvjOwak4yYe84Aj
 Xyw5Tf2Jj9AJ4aK5YE5Vz2dLskQ+fhCZDMNL3mtDCt9GYQbHxSPvoRAc8SCnqmdZ0f/Z
 lPSdADEqy7f8LvwgqNBeh3B7qoYeI0q8Gw1RQ/m6N6XLUAqr3nP0VgIG9/UNEtY+cDyU
 O6m41pudofakcgTClLRYSX/CCgQnmr6ZcJ3bh29JnP+FBhBYoolj/m6aS6oYpog5XH8A
 jBJQ==
X-Gm-Message-State: AOJu0YydDc2FJqGNqR3ExkRx1GBzvMg/z+PGVWEhn+8nikvgBLrkwjQu
 xmpGJka4ZxbwrGLa0bnmh6kqRbuMPfHdgvroFtkCjWmmcoWBjcpXWZE3TTh9bg==
X-Gm-Gg: AfdE7ck+/mmt6650k+omZtAOQw+MDbPc6+x2LZ7fX80bKXZQFK/pnOIrxY9sus05QN7
 1Ec0C485Pw6csoXXQWqh6jo9wS5lADNxeHgE+j765Bi4FD5TxdCEQr4D9IPtOhU4xr9p5Ecg2EP
 8/qLeqEFaylqUPlti1e8IBWGifb5mxzSWl5XjPwm1IrlKxtU+CV62A3Ce5nK0Q4GRPeA3GscNkM
 8k3yMYvPg2eQgXKg5s9yJW+9655u8G1j0aE1BbyM+HvKC6VZ57nyM8w8bBjTGULYS3wvCz3rj3a
 uXU2rYeJwrMHWZBuaJqJoschlZOV5BP/ltENeTup3ygtF90Asq/2ArOwGywPPMiJigoMdePiJLc
 Rzy2krG+1x8TUmavcRLTeAp2e1MLMVjrz2Wd/hlzMftz65jERN6sQ5SfD3JkxSfaoaDdKILJ93U
 X0VIHLDpmIB+7fISWwpSYCQ0jqPKvmo6eDdsimuk8aFsH0JKtJaYvHGLiAxdDdwZgfUeCRI9QPR
 /8E2/tmyPVDFubwEHE=
X-Received: by 2002:a05:600c:1d0a:b0:493:c991:8e56 with SMTP id
 5b1f17b1804b1-493f887bc07mr173459555e9.4.1784112344219; 
 Wed, 15 Jul 2026 03:45:44 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950871e830sm145205475e9.2.2026.07.15.03.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:45:43 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 7/9] drm/amdgpu/gfx7: Use COND_EXEC
Date: Wed, 15 Jul 2026 12:45:42 +0200
Message-ID: <2299222.Hq7AAxBmiT@timur-max>
In-Reply-To: <2a8374ee-bd72-4306-9524-a8cb3cc0d5f8@ursulin.net>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-8-timur.kristof@gmail.com>
 <2a8374ee-bd72-4306-9524-a8cb3cc0d5f8@ursulin.net>
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

On 2026. j=C3=BAlius 15., szerda 11:38:40 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> On 13/07/2026 13:58, Timur Krist=C3=B3f wrote:
> > COND_EXEC tells the CP to discard the dwords following it
> > when its condition is zero (false).
> >=20
> > This is useful for GPU recovery because it can help reduce
> > collateral damage during GFX IP block soft reset, meaning
> > that it reduces the likelyhood that we fail some jobs which
> > are not guilty of the hang as the IP block soft reset
> > mechanism clears the condition before doing the reset.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c index 915612628f9a..6d52b8710437
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > @@ -3162,6 +3162,22 @@ static void gfx_v7_0_ring_emit_vm_flush(struct
> > amdgpu_ring *ring,>=20
> >   	}
> >  =20
> >   }
> >=20
> > +static unsigned int gfx_v7_0_ring_emit_init_cond_exec(struct amdgpu_ri=
ng
> > *ring, +						     =20
uint64_t gpu_addr)
> > +{
> > +	unsigned int ret;
> > +
> > +	/* Discard following DWs after this packet when gpu_addr=3D=3D0 */
> > +	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
> > +	amdgpu_ring_write(ring, lower_32_bits(gpu_addr));
> > +	amdgpu_ring_write(ring, upper_32_bits(gpu_addr));
> > +	amdgpu_ring_write(ring, 0);
> > +	ret =3D ring->wptr & ring->buf_mask;
> > +	/* patch dummy value later */
> > +	amdgpu_ring_write(ring, 0);
> > +	return ret;
> > +}
> > +
> >=20
> >   static void gfx_v7_0_ring_emit_wreg(struct amdgpu_ring *ring,
> >  =20
> >   				    uint32_t reg, uint32_t val)
> >  =20
> >   {
> >=20
> > @@ -4943,6 +4959,8 @@ static const struct amdgpu_ring_funcs
> > gfx_v7_0_ring_funcs_gfx =3D {>=20
> >   	.get_wptr =3D gfx_v7_0_ring_get_wptr_gfx,
> >   	.set_wptr =3D gfx_v7_0_ring_set_wptr_gfx,
> >   	.emit_frame_size =3D
> >=20
> > +		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from=20
amdgpu_ib_schedule) */
> > +		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from=20
amdgpu_vm_flush) */
>=20
> gfx8 version /appears/ to make an effort to keep the additions here
> sorted in the emission order. I think at least.

As far as I see it was already not in emission order here.

> Not sure how much value
> it adds since the whole emit_frame_size mechanism is "fragilotedious".
>=20
> :) Another task for a rainy day - we see if it can be replaced with
>=20
> something more manageable.

If you have ideas how to clean it up, I'd be happy to hear it.

> Anyway, digressions aside:
>=20
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>=20
> Regards,
>=20
> Tvrtko
>=20
> >   		20 + /* gfx_v7_0_ring_emit_gds_switch */
> >   		7 + /* gfx_v7_0_ring_emit_hdp_flush */
> >   		5 + /* hdp invalidate */
> >=20
> > @@ -4965,6 +4983,7 @@ static const struct amdgpu_ring_funcs
> > gfx_v7_0_ring_funcs_gfx =3D {>=20
> >   	.pad_ib =3D amdgpu_ring_generic_pad_ib,
> >   	.emit_switch_buffer =3D gfx_v7_0_ring_emit_sb,
> >   	.emit_cntxcntl =3D gfx_v7_ring_emit_cntxcntl,
> >=20
> > +	.init_cond_exec =3D gfx_v7_0_ring_emit_init_cond_exec,
> >=20
> >   	.emit_wreg =3D gfx_v7_0_ring_emit_wreg,
> >   	.soft_recovery =3D gfx_v7_0_ring_soft_recovery,
> >   	.emit_mem_sync =3D gfx_v7_0_emit_mem_sync,
> >=20
> > @@ -4979,6 +4998,8 @@ static const struct amdgpu_ring_funcs
> > gfx_v7_0_ring_funcs_compute =3D {>=20
> >   	.get_wptr =3D gfx_v7_0_ring_get_wptr_compute,
> >   	.set_wptr =3D gfx_v7_0_ring_set_wptr_compute,
> >   	.emit_frame_size =3D
> >=20
> > +		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from=20
amdgpu_ib_schedule) */
> > +		5 + /* gfx_v7_0_ring_emit_init_cond_exec (from=20
amdgpu_vm_flush) */
> >=20
> >   		20 + /* gfx_v7_0_ring_emit_gds_switch */
> >   		7 + /* gfx_v7_0_ring_emit_hdp_flush */
> >   		5 + /* hdp invalidate */
> >=20
> > @@ -4997,6 +5018,7 @@ static const struct amdgpu_ring_funcs
> > gfx_v7_0_ring_funcs_compute =3D {>=20
> >   	.test_ib =3D gfx_v7_0_ring_test_ib,
> >   	.insert_nop =3D amdgpu_ring_insert_nop,
> >   	.pad_ib =3D amdgpu_ring_generic_pad_ib,
> >=20
> > +	.init_cond_exec =3D gfx_v7_0_ring_emit_init_cond_exec,
> >=20
> >   	.emit_wreg =3D gfx_v7_0_ring_emit_wreg,
> >   	.soft_recovery =3D gfx_v7_0_ring_soft_recovery,
> >   	.emit_mem_sync =3D gfx_v7_0_emit_mem_sync_compute,




