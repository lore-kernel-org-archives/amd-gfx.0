Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593D3606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UmBXaSbH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86A810E297;
	Mon, 23 Nov 2026 03:12:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930E610E297
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 03:12:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B7E443C7F;
 Mon, 23 Nov 2026 03:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192A71F000C0;
 Mon, 23 Nov 2026 03:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795403566;
 bh=76R/0K0OzIIh9kWFKRpwe+6jtOI6azBBd4LU+qPg+sg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=UmBXaSbHgTx89U4i2NkxjDSHeEvR+v+JsQkInwyrcWZOY9K1MFas5432HdEztrTCg
 bWpiScQP9E4+UAMEERc7Onn1uYg1nOxtr27UYI1ih6J2xv7YEiMR/XFkwFaxJ34qpH
 IEHdzbC8CzegtyNCRhi71IBq/7tf+DAi+lbuADWE2zj1ZkNo0b7DfbSYFwXk/KF7y4
 tDdFink84h0vrX+IY6hM747oKddbV9dpA4U/P2LK4QV/Idd3i95pQAsqOR6Deyj6uE
 RnfBCE4WC2v1M07oAuw21WcfxeSgE/paOYocsfv79f5toC/JegQ2MZEr8gLzsAP6YM
 eMlT5XIV33Sow==
Message-ID: <sashiko-outbox-228583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] drm/amdkfd: don't flush the TLB of a device the
 process has no VM on
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261123024737.1475714-1-Jesse.Zhang@amd.com>
References: <20261123024737.1475714-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 03:12:45 +0000
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
- [Low] drm/amdkfd: commit message cites missing patch and omits Fixes
  trailer
--

commit 49a7c752d976cee4f89634bba3990ab398ece2e3
Author: Jesse Zhang <Jesse.Zhang@amd.com>

> drm/amdkfd: don't flush the TLB of a device the process has no VM on
>
> A process has a PDD for every device, also the ones it never acquired a
> VM on, and pdd->drm_priv of those is NULL. kfd_flush_tlb() dereferences
> it unconditionally, which is how suspend_queues() oopsed before the
> previous patch.
>
> Return early from kfd_flush_tlb() when there is no VM to flush, so no
> caller can oops on such a PDD.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

[Severity: Low]
There is no preceding patch in the tree modifying suspend_queues(), which
still calls kfd_flush_tlb(pdd) on PDDs without a VM when total_suspended >
0.  Because this commit directly fixes that NULL pointer dereference,
should the reference to a previous patch be updated and a Fixes tag added?

  Fixes: f5c4f88e0f9c ("drm/amdkfd: Add TLB flush after MES queue eviction/=
suspension")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123024737.1475=
714-1-Jesse.Zhang@amd.com?part=3D1
