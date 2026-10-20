Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A02606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=PiXfUFk3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0CF210EB9E;
	Tue, 20 Oct 2026 09:19:21 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB3B410E578
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 06:47:51 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j82zS5DrFzKp6s;
 Tue, 20 Oct 2026 08:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1792478868; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5cHirzWe2wfw2eW3EksY4WknOzu4j2sDM1krSqv5mqg=;
 b=PiXfUFk3CKraC0udoBD3DECyXVt1RwM9uxeSkwLI7Cdkj7B2XTIghtEcAr7xrC+4VL0o8g
 AiZtPonShANMBoW1ouyV7iU35Z0tsaQgRPrB3aeb98ROrMOI6iz7M8NXj0hdYnEWuFUpiT
 reJjHhl6dMA5O5G8SKTcrkA9E81z6LnHJ4P192wTi6zoZQc0BVe5C8t87bXGs3sS2Esd17
 kenzwGdU6r1vg8uqMsxjkcbQ50gq6zQfQQBXjPD9ZlnZWoRSGcsmuHBiZutoamQCBkpHdH
 sBnywjj7AndBbQJ4O+b760dtqBubmqaC24xbBTXG07OcEH/TR2M2MQGNTyamkA==
Message-ID: <e1202a38369202264a735836a2fd6a2de3609a13.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/amdgpu: guard VCE/UVD sched entity teardown on
 failed probe
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Olivier Kaloudoff
 <olivier.kaloudoff@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: phasta@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com
Date: Tue, 20 Oct 2026 08:47:45 +0200
In-Reply-To: <d6a743a1-7268-4167-9378-a364b6c04fbb@igalia.com>
References: <20261015193037.86472-1-olivier.kaloudoff@gmail.com>
 <d6a743a1-7268-4167-9378-a364b6c04fbb@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: ydigo8gebtkysu414sbpqbf6r6pwhmbp
X-MBO-RS-ID: 8a55f8dc748e3aef11a
X-Mailman-Approved-At: Tue, 20 Oct 2026 09:19:18 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: phasta@kernel.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-10-16 at 09:23 +0100, Tvrtko Ursulin wrote:
>=20
> On 15/10/2026 20:30, Olivier Kaloudoff wrote:
> > The hole was latent-but-safe until commit 2df5efb45425 ("drm/sched:
> > Remove redundant entity->rq initialization and checks") removed the
> > if (!entity->rq) early return that commit 1decbf6bb0b4 ("drm/sched:
> > Fix entities with 0 rqs.") had put in drm_sched_entity_flush(), on the
> > grounds that entity->rq can never be NULL. That holds only for
> > entities that completed drm_sched_entity_init() =E2=80=94 not for the
> > never-initialized entity this teardown path reaches.

[=E2=80=A6]

> > =C2=A0=20
> > -	drm_sched_entity_destroy(&adev->uvd.entity);
> > +	if (adev->uvd.entity.rq)
> > +		drm_sched_entity_destroy(&adev->uvd.entity);
> > =C2=A0=20
> > =C2=A0=C2=A0	for (j =3D 0; j < adev->uvd.num_uvd_inst; ++j) {
> > =C2=A0=C2=A0		if (adev->uvd.harvest_config & (1 << j))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vce.c
> > index 1f7a98cdc..3952af9ae 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > @@ -253,7 +253,8 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
> > =C2=A0=C2=A0	if (adev->vce.vcpu_bo =3D=3D NULL)
> > =C2=A0=C2=A0		return 0;
> > =C2=A0=20
> > -	drm_sched_entity_destroy(&adev->vce.entity);
> > +	if (adev->vce.entity.rq)
> > +		drm_sched_entity_destroy(&adev->vce.entity);
> > =C2=A0=20
> > =C2=A0=C2=A0	for (i =3D 0; i < adev->vce.num_rings; i++)
> > =C2=A0=C2=A0		amdgpu_ring_fini(&adev->vce.ring[i]);
>=20
> Dang, it looks like currently the ownership of entity initialization is=
=20
> broken between the IP agnostic phase which does the init, and per-IP=20
> phase which tears it down.
>=20
> The fix will get in the way of me re-trying to embed the run-queue into=
=20
> the scheduler but it does look correct.

Couldn't the status be tracked through the vce struct?

if (vce.entity_initialized)

Otherwise you rely on API-internals (again) which is what enabled that
bug AFAICS. If it's about amdgpu having called foo_init() or not, then
the most robust solution is to track within amdgpu "did I call that
function already?" Same applies to all constructors and destructors in
the kernel AFAIK.

>=20
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>=20
> I will see if I can re-work the init/cleanup phases so this can be=20
> removed, or if not, try to add a proper DRM scheduler API to query the=
=20
> status of an entity.

An API with which you can query whether a data object that you
allocated and that you own had the constructor run by yourself? Or am I
misunderstanding something?


P.
