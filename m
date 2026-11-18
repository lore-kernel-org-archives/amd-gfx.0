Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9BC606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVjjCj2/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4796D10E684;
	Wed, 18 Nov 2026 07:28:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C14A10E6F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 07:28:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D825C43950;
 Wed, 18 Nov 2026 07:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928B11F000C4;
 Wed, 18 Nov 2026 07:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794986927;
 bh=WgTJ5exg7QDD8NJPlPSl+/Y4CWL5mwsDMQDuyW3/GkM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=fVjjCj2/Tv1adOFrRVrCNy6n8EJEAj7kMt/WAPGnfzsf2AEDLkt2OB01Ss1HFDtFS
 W0ts53u+KRhXwZMImj4hd6Aqpd7vWHL5doFU6XOHsjV7RLXTD/oXQFwZBbFN//Ctyf
 /19O9LFn9ZvHtm4VxRpVEnn/I5O//xTz9+yHMEmw0hbDsxgKH/DFImBYBCBUfjfU4H
 ckCK4b3gNmNYRWDYnDyB5tT36/OEh/qsHoNtbrQ1Zt1Y2XKon4TLy/2wbBWK1DwdpL
 FLokb4lWskjsgkeqnbv03QQUIkFJBbauyYKcZ8qFInJq0xeJHSIklX6B/nr96g0kJC
 EqpP01b5w+vdA==
Message-ID: <sashiko-outbox-220306@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/pm: Fix SMU v15.0.8 energy accumulator
To: "Lijo Lazar" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261118071927.2149652-1-lijo.lazar@amd.com>
References: <20261118071927.2149652-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 07:28:47 +0000
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
- [Low] drm/amd/pm: unresolvable SHA d1168b8cfbe6 in Fixes trailer
--

commit 7bfc1b1729a32aa01f3585d9c539d253e7c105fe
Author: Lijo Lazar <lijo.lazar@amd.com>

> drm/amd/pm: Fix SMU v15.0.8 energy accumulator
>
> The energy accumulator is a raw counter in 2^-16 units, not a Q10
> fixed-point value. Report the counter as is.
>
> Fixes: d1168b8cfbe6 ("drm/amd/pm: Fix metrics formatting in SMUv15.0.8")
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

[Severity: Low]
Commit d1168b8cfbe6 in the Fixes: tag does not exist in the repository.
Should this reference b7d7649f7d99 ("drm/amd/pm: Fix metrics formatting in
SMUv15.0.8") instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118071927.2149=
652-1-lijo.lazar@amd.com?part=3D1
