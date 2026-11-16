Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED6606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBVRQy25
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A647310F3E4;
	Mon, 16 Nov 2026 19:33:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D175C10F3E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:33:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E4E7760A06;
 Mon, 16 Nov 2026 19:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A0B1F000C9;
 Mon, 16 Nov 2026 19:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794857628;
 bh=B47qn/3br8M7mfEgtoTBLHRG7b0kymSYm0bLYB3EPNM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=aBVRQy25IQh7J3GstSl6lPKLAroLKvyPRMjRA3cohGtsGQq2psoXHuZW1iHJXWrIn
 i3dF4S41Ee2YGUosR8BsNZ992o25wq5J91hDJ3I0zu2KrtZep2upgd2N8OJvzoJUtx
 QRAeAnfh/40X5Kmgkm7y9XgtMEhZbVeEqPVdzbL/t6UhacAgNPMPhZROKnG7w4FLlr
 KDvvE2TfHa2KQEXAvQ6u1eyB7/fjQGY8++PLfWfIqKhnpTlGnWuJ8CuU+Xo6abRVHF
 mNFEE61wHX8WmNu3lPdrRg03Sr5V2BYjljdJ+Yg0U1RhW8uiOAR6eKaW8Zu47Hz2JS
 AdjM2foCJA7sg==
Message-ID: <sashiko-outbox-217573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: Disable XNACK retry on GFX12.1
To: "Kent Russell" <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261116191141.145348-1-kent.russell@amd.com>
References: <20261116191141.145348-1-kent.russell@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:33:48 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amdkfd: unreachable duplicate GFX12.1 check in
  kfd_ioctl_set_xnack_mode()
--

commit 34665c5afc18630d5c2e3d3dd0b64b6b650cafc2
Author: Kent Russell <kent.russell@amd.com>

drm/amdgpu: Disable XNACK retry on GFX12.1

This commit disables XNACK retry on GFX12.1 in both amdgpu and amdkfd by
forcing noretry=3D1, setting RETRY_DISABLE in SH_MEM_CONFIG, and rejecting
XNACK mode enablement for GFX12.1 devices.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 5a7f4f0cd0ce7..0728271f8c087 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1766,6 +1766,8 @@ static int kfd_ioctl_set_xnack_mode(struct file *fi=
lep,
> =20
>  	mutex_lock(&p->mutex);
>  	if (args->xnack_enabled >=3D 0) {
> +		int i;
> +
>  		if (!list_empty(&p->pqm.queues)) {
>  			pr_debug("Process has user queues running\n");
>  			r =3D -EBUSY;
> @@ -1780,6 +1782,16 @@ static int kfd_ioctl_set_xnack_mode(struct file *f=
ilep,
>  			goto out_unlock;
>  		}
> =20
> +		/* XNACK cannot be enabled for gfx12.1 */
> +		for (i =3D 0; i < p->n_pdds; i++) {
> +			struct kfd_node *dev =3D p->pdds[i]->dev;
> +
> +			if (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(12, 1, 0)) {
> +				r =3D -EPERM;
> +				goto out_unlock;
> +			}
> +		}

[Severity: Low]
Is this loop in kfd_ioctl_set_xnack_mode() reachable?

Immediately above it, enabling XNACK checks kfd_process_xnack_mode(p,
true), which already iterates over p->pdds[] and returns false when
KFD_GC_VERSION(dev) =3D=3D IP_VERSION(12, 1, 0) (or dev->kfd->noretry is se=
t):

drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:kfd_ioctl_set_xnack_mode() {
	...
		if (p->xnack_enabled =3D=3D args->xnack_enabled)
			goto out_unlock;

		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
			r =3D -EPERM;
			goto out_unlock;
		}
	...
}

When args->xnack_enabled is 0, p->xnack_enabled is already initialized to
false on GFX12.1, so the p->xnack_enabled =3D=3D args->xnack_enabled check
exits early (and if p->xnack_enabled were ever true, this unguarded loop
would reject disabling XNACK with -EPERM).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116191141.1453=
48-1-kent.russell@amd.com?part=3D1
