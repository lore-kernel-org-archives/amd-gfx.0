Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F49606A321
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xzvsi7K+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 021AA10E6FE;
	Tue, 10 Nov 2026 21:50:03 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C835810E05C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 21:49:56 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-36dc4797082so360692eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 13:49:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794347396; cv=none;
 d=google.com; s=arc-20260327;
 b=K4pTheO45DDl2MutgVVP9GAHtd897zISGandTOFj7HMPcmalvc7FZfaUgNtXgcYv1q
 s9Gz4es2Fyj98Ihvhsds282dFuPsXkjvY4NTPk9X/RiGZGtosyZDwy4whKkGGnqEFoxd
 Hjyam5LJz/q2VZmF/eIumslevFkV/dEIEdQBh+siM5PURQI3uFgpJtW10+jjrlbxEPGv
 pelYrQNk4tlCVpvn4fr1X9KSpLcFHQAnw4gcekmBImGHS0P0dH4BGxtsjWCe1N3N08um
 U6BvDMSR+5h383HB/9/bReikBJ6Kwica5NbjQN8irMQRdvmfGyMQ6hK2ZJeuPWc6fHpt
 2RRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lc2d75OL7aQ19NWtHaPUWdOA/U+qQ69pXWLu70/x14s=;
 fh=qK+nNbj0Ey8qSYlvw8IbQeA1M2v165RL7AMhI+hODkc=;
 b=X1qo0NbCvpWUiaURDsYtQ7hTJfIOjvmf3Hh3bHy68H1Ab49OsaAAMZOVhFevhf/vK4
 +nhiGOoL2LUP1dVRcmYAZQ6GrdsyTxZ0BY+8ljW6Gg07Vgb60iBX8+1EWIsl+mspGr9n
 +6BfirZI6+qxH+bkqhMApK6HTYN5sV/nt/ZJA5+HHZxCmjDATojIZxkSe8OaanyERflk
 fkXS4RyolBCaCDxtEkJzjateEMF9GIZUA8kQL9ttC/G9wyvS4echPeePgquQyfEKQYHp
 2pfLtKo1N+fqnklJs3x7bc7usCoaZVpRGCZVG3bRZ0WqDESFL6Pa6Sa5ZfKZj8dalkGD
 BiWA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794347396; x=1794952196; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lc2d75OL7aQ19NWtHaPUWdOA/U+qQ69pXWLu70/x14s=;
 b=xzvsi7K+Rxx1yTTQAbCLSkkRBIbkgyRzJKujahpc8PaT8Vapym4zYDm2BV0aDxxS4M
 49qkWCzWsbZewo7sMhrgMxkKnQWVDw2ywGBxR4M0dd50s1R7jMIfGhIfvphoqOS4M+U1
 WfYV6XduF+G73yuQABpAQDEOcquhiS41Xs1EnIDlclpacuLgolCPJvTmjxuJmJg0Zo9U
 Uw4Aso70xfOM6JVBzdY7lJhgTPcITIaRIt0TLqsHUV7eKTZT1NpzYeiudt1HNEZRuz5h
 PHUMj/U+3rIFgaEm5wRoCpZTHhdBP7oAA14+784ddpmjYg1W//NZo+19xhbfSVj8ceGr
 1BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794347396; x=1794952196;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lc2d75OL7aQ19NWtHaPUWdOA/U+qQ69pXWLu70/x14s=;
 b=XrgIKut47xZ+TYJ/xno7+2C8BiUdqFH6NtixJI98DbDp+dZ1xgoejWhT56kHKzveNW
 wFw8UhbGGo3cL4yNPgkev54AobzlDKstSfhb6J4TH+/QNtJ02P2YLzbOgMa0uSRDpQ0E
 UxhUL6Ztx9Mo3avo3JsuRF16Q243MsRdM5EOioJ7dwj5GqzfCa9QuvyYapXJs3D+L9uE
 uSc8LWJrvHjNDII7KEFL7AwdBvOAH/Tmd7c0h9RuQ4fABbsT7OHvOivxoeZ5DBZ7QsKC
 cnKTd+UHpNAIgZTOBAvZVtfHvqYna/IbZXY7qgHlMFhhQhNvGz21IpTRRDWKQKb7qrmd
 ybdw==
X-Forwarded-Encrypted: i=1;
 AL+hErG9r8QQwBpma/6Sft258gxUDpFX+r2ZLuUO41Rb7BYIV08WjGNGS67rBapvpup/Z0ahjO/WU1KU@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8B1OKkNip+Yw2KGp96c/fO7sO9CsY21N/GJzeNFvYnHoFz3y+6
 /fghz0aRbov6a3B4SgOBzOBOpt1NbdoCJp1RUTpY693SvprxrPhNBP+hM5Ufrrdbod7gpHuQnH3
 HqYfIfKj+shXmTpIeC7CWM7jHCG8TyBI=
X-Gm-Gg: AYBFou3hlyt0GiHX1qFlK8RzmBj9vnrFTF2c37znW8RJIVBKbKqLuBSiUh/FTdN6l+O
 bZWHWoroQDtx9tThFuDISfdF1OdY98H7Qfd4Q7hd5AdaMhO7V2lce0mjzKQ7BpFdse5dwDBu/mZ
 UlQzQSp5pq3ehm3yZABnEdmKz8pvJQdxg55+wfEf9xYJl0CrurWdhG0Obxa3FVujknvqWyyFIXZ
 sGceXyRzA1nP9TXpVK1zFK5Nyil+sTK1nQ2L5UHHt41Ey5v5h1ibgai/5zv/VYC8z2djhOiEOkQ
 XHrPbg8r6ncic/kb0/FHjFi0kZL9/u8/76Gw6F3qlBHSW/czLgGS6ezVPVMtBuoCu6GKKNDuRRX
 aXghuIt7j9judzDOHtMWoOs2L8N95Mx4smUnTkR109uVmVdHYw4HVAT4qTE3hjZomhoQV1eyNHp
 HLU4Zsz6qiB+yhZ7AXoqVSlmSQ0e2GtuOHF+oqN8ZBft7vY5Q76qKiX9sqJP4=
X-Received: by 2002:a05:693c:41cb:20b0:36e:66d8:1424 with SMTP id
 5a478bee46e88-37680a60bbdmr1218085eec.0.1794347395773; Tue, 10 Nov 2026
 13:49:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110120326.538252-1-tzimmermann@suse.de>
In-Reply-To: <20261110120326.538252-1-tzimmermann@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2026 16:49:43 -0500
X-Gm-Features: AclHuK_r02Bf4QXu75VAdsauSxMk2WkxkkNGMymOSn-A5ONgkHUPX0j_0Ud49DY
Message-ID: <CADnq5_NCF2J0Dzea5swubs+eEKBLq+8ontc5n=kihYZVA3A1aw@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/amdgpu,radeon: Inline drm_crtc_init()
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 7:11=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> The helper drm_crtc_init() sets up a CRTC with a primary plane for
> non-atomic mode setting. Only drivers for some AMD hardware still
> use it.
>
> Inline drm_crtc_init() into amdgpu and radeon and remove it from
> DRM. All new code implements atomic mode setting, which does not
> use drm_crtc_init().
>

I'd like to drop all of the old amdgpu non-DC code since DC is now the
default, and we have an LTS kernel now.  I'm planning to send these
out in the near future:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/remove-non-dc-display?=
ref_type=3Dheads
So that just leaves radeon.

Alex

> DRM support for kernel panic is only implemented in amdgpu. Take
> the panic helpers from drm_crtc_init() in amdgpu, but clean it up
> in radeon.
>
> With this series in place, DRM's helpers for drawing panic screens
> can be further integrated with other drawing helpers, as outlined
> in [1].
>
> Tested on radeon with a Radeon HD 6570.
>
> [1] https://lore.kernel.org/dri-devel/20261019154612.777074-1-tzimmermann=
@suse.de/
>
> Thomas Zimmermann (5):
>   drm/amdgpu: dce_v6_0: Inline drm_crtc_init()
>   drm/amdgpu: dce_v8_0: Inline drm_crtc_init()
>   drm/amdgpu: dce_v10_0: Inline drm_crtc_init()
>   drm/radeon: Inline drm_crtc_init()
>   drm: Remove drm_crtc_init()
>
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c  | 44 ++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c   | 44 ++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c   | 44 ++++++++++++++-
>  drivers/gpu/drm/drm_crtc.c              | 26 +++------
>  drivers/gpu/drm/drm_modeset_helper.c    | 74 -------------------------
>  drivers/gpu/drm/radeon/radeon_display.c | 47 +++++++++++++---
>  include/drm/drm_modeset_helper.h        |  3 -
>  include/drm/drm_plane.h                 |  5 --
>  8 files changed, 170 insertions(+), 117 deletions(-)
>
> --
> 2.56.0
>
