Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D30F606A32A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLuPCKpJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85DC210F099;
	Thu, 19 Nov 2026 18:56:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4225310F099
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 18:55:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE35A4097E;
 Thu, 19 Nov 2026 18:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A80C1F000C4;
 Thu, 19 Nov 2026 18:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795114556;
 bh=AQRml/v99oURKVvNDarSYYsWlPpE9KAR4h36n1WPl60=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=gLuPCKpJPWWv9TyT/G9tJDShhgI0qCv5TiqqE9rV54M425kDRQ1rH84R81t1JyTur
 L2rJWiReNq7oRNXBeyUSLxqj2SrXT1J1uLyla92gAGI2E9BrAtCpvWArpR+LD44LK7
 QBbdAM6jUuEwOG+8jZ8RSQ1doFOPaywCxTpebTPmfDEYPl582yjYcHMT2KGRSoCndl
 SU/qtxn3N6I1HDBPz+zHiTbEVrrQM9WY4XikLlM/5HOd7dqOCkDySaw4XYHhfDrJIv
 gbs83ZvuXd/N1N7fNEIjn5Jm9G6KfXMmBjI6OCsA0sD2680Gph5ii6bMjse0jAIpVp
 ucz3oA1bIyFGQ==
Message-ID: <sashiko-outbox-223809@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/amdgpu: clear root PT after setting vm->is_npa =
 true
To: "Shahyan Soltani" <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261119184620.1090706-1-shahyan.soltani@amd.com>
References: <20261119184620.1090706-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:55:56 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amdgpu: missing Fixes trailer on amdgpu_vm_make_npa() bug
  fix
--

commit 40ad838159433460dcfd2d24788c88778750f58b
Author: Shahyan Soltani <shahyan.soltani@amd.com>

> drm/amdgpu: clear root PT after setting vm->is_npa =3D true
>
> Previously, the root PT was never cleared after setting vm->is_npa =3D
> true within amdgpu_vm_make_npa(). This resulted in the flag
> adev->gmc.no_retry_flags to never be applied for the NPA VMs.
>
> Call amdgpu_vm_pt_clear() after vm->is_npa =3D true is set and the bo has
> been pinned/validated. This allows the root PT of the NPA VM to be
> cleared with the correct value.
>
> If the pinning or reservation of the bo failed, the vm->is_npa flag will
> no longer remain as true. This is to avoid conditionals outside of
> amdgpu_vm_make_npa() that depend on the vm->is_npa flag to determine if
> the VM is a correctly initialized NPA VM.
>
> Warn if the VM already has mappings, since clearing the root PT will
> break existing mappings.
>
> Remove the redundant second setting of vm->is_npa =3D true.
>
> v2:
> - Add the WARN_ON sanity check regarding an empty VM (Felix)
> - Change the return handling to only set vm->is_npa =3D true upon a
>   successful pin (Felix)
> - Add the heavy weight TLB flush after the root PT clear (Philip)
>
> v3:
> - Remove TLB flush (Felix)
> - Move WARN_ON sanity check to start to return early (Christian)
> - Reserve fence slots for amdgpu_vm_pt_clear() and amdgpu_bo_pin()
>   by replacing amdgpu_bo_reserve with amdgpu_vm_lock_pd()
>   (Christian)
> - Use goto error handling rather than calling return when applicable
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

[Severity: Low]
This fixes a bug in amdgpu_vm_make_npa() where the root page directory
was not cleared after setting vm->is_npa =3D true and vm->is_npa was set
before reserving and pinning vm->root.bo.  Should this include:

  Fixes: e05a54573df7 ("drm/amdgpu: Pin page tables in NPA VMs")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119184620.1090=
706-1-shahyan.soltani@amd.com?part=3D1
