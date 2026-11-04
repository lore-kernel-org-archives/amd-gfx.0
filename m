Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B04606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=D5hdgA6T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F51F10E23E;
	Wed,  4 Nov 2026 13:59:30 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9C410FBAD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 12:39:18 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jKQ4151DTzKpCr;
 Wed, 04 Nov 2026 13:39:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793795953; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0skui45QI7GdheV6+G3v+GkbRhbcbbkBLRGXQoWzv8=;
 b=D5hdgA6Tdg/Cl/6QgA74Y4fH/5Dt9u2ZWbHCMMbH6id4rh5AzNRAZosC2nlNbLLTZDnpJz
 DZcnTBenovMOJOSFXcA2LX5FWUPjT3CesZXhbNg1vG90KsEalysJeRD769jDPOxEBONN/q
 RKlqb5zbJ69vXBbcTfgRuzIXjWuWU96ghZFyQYy5XBA+e4WvM8rDEzO8cOPJYnRjlnAy09
 vpS96uDgsYdKDcNAYMqojUPv4IiysK211TpYzDGqUGDCaKy26KRrAHbVicAMeHuY9GReE7
 qZD3sjWNDsIi9A1uOZuYe2vksVIaFW4zL6Qb8seit8x6ntVY7H1AsGLpnga79Q==
Message-ID: <4e1ffc9f2d29bbe9482614b65dabfd96e058ecca.camel@mailbox.org>
Subject: Re: [PATCH] drm/amdgpu: Track entity initialization status in the
 driver
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>, 
 Philipp Stanner <phasta@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>
Date: Wed, 04 Nov 2026 13:39:12 +0100
In-Reply-To: <20261104121647.34640-1-tvrtko.ursulin@igalia.com>
References: <20261104121647.34640-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: bef09779efca762bace
X-MBO-RS-META: rbiq1x5kt34ep7y6ths33udicytpe1ie
X-Mailman-Approved-At: Wed, 04 Nov 2026 13:59:29 +0000
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

On Wed, 2026-11-04 at 12:16 +0000, Tvrtko Ursulin wrote:
> Instead of accessing the internals of the DRM scheduler data structures
> directly and relying on the own entity backing store to be zeroed on
> allocation, lets explicitly track whether we have called
> drm_sched_entity_init() and base on that the decision on whether or not
> to call drm_sched_entity_destroy().
>=20
> Alternative could (in theory) be to re-order the driver init/fini flows,
> but that is really complicated due inter-dependencies between different
> stages.

+1, nice.

> Apart from being conceptually cleaner this also re-allows future DRM
> scheduler work which will embed the run-queue in the scheduler.

Is that related to the spsc_queue work you're doing, or only to
Olivier's recent patches?

https://lore.kernel.org/dri-devel/20261022105454.60267-1-olivier.kaloudoff@=
gmail.com/


> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Acked-by: Philipp Stanner <phasta@kernel.org>

> ---
> Considering how many hundreds of kilobytes I have saved so far I hope I
> can get away with adding a couple of booleans. ;)

You *could* look into reordering the structs to reduce padding? IMO the
byte count is irrelevant; so just an idea.

> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 4 +++-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h | 1 +
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 4 +++-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h | 1 +
> =C2=A04 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index cd35ff7ca864..8f69aa4597e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -377,7 +377,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
> =C2=A0	void *addr =3D amdgpu_bo_kptr(adev->uvd.ib_bo);
> =C2=A0	int i, j;
> =C2=A0
> -	if (adev->uvd.entity.rq)
> +	if (adev->uvd.entity_initialized)

Just asking, what's the ordering semantics of this like in amdgpu? All
guarded by the same outer lock that serializes drm_sched_job_arm() and
drm_sched_entity_submit()?


P.
