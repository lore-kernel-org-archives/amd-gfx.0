Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FF4606A330
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VDlylGF0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A109B10E6A7;
	Thu, 12 Nov 2026 22:25:35 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CDA0112334
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 22:25:30 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-6dc6099b5f1so29816eaf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 14:25:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794522329; cv=none;
 d=google.com; s=arc-20260327;
 b=oQNlQMZaigZlDAuViQJOQKs13kEyh6TurZjKfR7c1jrjS9asVUrT56+SSLAJhOwGlm
 9DVlwezNhxWW3ZPGBwURDYJjYOoUDnACyFxHxG3XHOEC3z1g9wjSzApDVP7IEYTrJnXU
 fypckdy9rVjPiL2UlTf6+LQ5Acbxj8C58qcSg2RkzlM2h9mEHoAtrPGqM7EWUcJIBqET
 Cb6jtGD76kjaj/lEVoR0jmHfQhmuXsSvpElXU41O41gTf31ZHV+cy3X+1qnBVYGsxYVq
 4pTzrMb5JkGbUzThR1fiQ0gP9Xa8CHTkROcLCsWgn2z5DPOJvcOofy8UUrgcFB8TJEYS
 AiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7MKTVXjppM6Sj39d72sw6FHgn0wjt/0qge0qOjFaJdY=;
 fh=CBx/t1HZI3mVenaNHmzLyuUtDGXZCj/phlCfKtEmyqY=;
 b=efDLKhJjdUc4jRwM2UF5ZCdtdCjN/kuWCmfnaqDRh7cXfWhx/4w4h/jmgudxGyMszf
 dxE0B7YApmqkPuAsmWyFg9bRrNPYiIo2eqrJTAinhnn3AfceFwBrJhSYsHWSkLAwZuOm
 Z8M8fv/ufQ6yCvq6MewTrBG3bEQcUEKsCYzUBpoGhrIXSYMyEt1A1NBh5mx9LmKuduEk
 /WU+S2zbzgym7LHDZ9zd6+3o6uSQSj1SnojB/6uX8OZseIw2zSNyMVCoJtLqZGXstyCh
 4XpwAUAkM1mmQzA+mCDgOGGcLMfO8hRP2JoS5bvmjQrunESbNrO5XytUvdUq/ON55HHd
 p2VQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794522329; x=1795127129; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7MKTVXjppM6Sj39d72sw6FHgn0wjt/0qge0qOjFaJdY=;
 b=VDlylGF0t4AKPWWtFJih+ABv4J68nAGaSEEp+l2+whjIS5HDQ7DEyFDd0xbQyYIoUX
 2BoC6OFCfxU3Q5wFa2RjZzKjzvDeJ2EilWxXpPwNlxnfWDxV8yEgkhhlxXeicWEiQ6xl
 Up1itUKsUWUA8Gd5EOq+IsTOztLh9DpJq9oxlVHNJ0mrRb6qB/5y9FPnQIyoz7CM53jr
 SnTcD370NTPgzVFqzxZ1gfEWP80liJHHNA5YZqT1paW8sGuKjPhA6et78uHMfbUrwI6q
 x1ICXmBSvzZ3ggEbNlGczd98RYGXy5EuVvaerf8yFBRfqPi/48b851DQ4lW3QYEV4CM9
 W5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794522329; x=1795127129;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7MKTVXjppM6Sj39d72sw6FHgn0wjt/0qge0qOjFaJdY=;
 b=dW7KmCE1T0zhic4LHc26zEvnjeH0xVv9WoTepSEqTpt7rk3LED62wegVPhStGf4l1L
 e2UBWxSvF0rAJIExxXzDdYBfie76YnJBh5BiDjuChA2/tDauNdXkilBLkagm64vIOSF5
 SNNT5YuSPrk4KkWdw8TkbRY0iQ0MA8oYqFzfrkXXUvKbjznIkjUjhKRnrxNBfprkxpef
 BlsYtPQAaicaiZs7UQPyDOrxu+Qet+m1f95/gLZHGQxZEYQtLboFAEL3qxQU+lo88Dvm
 AgAMCpsrb6Jkn1otvhFMBRwB8kSL53wi6ZMfYqdqYxiv6RLdHjL5AoegeKgGuu4GTqNn
 Zfcg==
X-Forwarded-Encrypted: i=1;
 AL+hErEGMxxYJasPWojRm3OYdyl/NkhzFvetnpuGqGkP1bmUYmaNKa/oIRTAkZlxMGZqhpeEwaAfLGf9@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/zhRRHDN+9WG6VE9CDQXHsk79XLxAwi5npTdrP7cNzLUFVSTo1
 H9HHN/J57wcH9Z2zmtuTVwTzjCZfPeWMk1r3mPLb/zY0KMD78p3UO7jT+icTgccfls/6j2r3/8I
 sGZznEHchHbuQx+FpTOmki7M47IpNM+Y=
X-Gm-Gg: AYBFou2d8oeW94l2Vs4otOx3XHyGPRprqABqph18BdCsq6DL8ujhQ1WMxgvWvbEmKRK
 LhDLKUrMuJlrJE2vpZKNeatNGzfYj8ilx+6tBMAF5RJUNjDCbapYBfSCG6fhjNEalyrt+97Qvny
 6TFc3k5OXaaBb/Cyu0Th3JqNLnidb+SXpRo45oeHhVtmXQqDBsA4k5d66hGxBXSW2ww9ngFIYcs
 zKJvlLee+dLN8hsbHmlqIIO4mswgM8Psr1v5t77SigcSZucMpms2xkBJy1ewDP9EpH3XNkAkNew
 MsEjTW0u9wultljFAwg1Lru0KA3Gte6moEy1IYP9Chv3B5daeFRXPl+rJMQig+PXg/bBO/E8ZWW
 7/+GEew+/Ph0kL909glmi+D3A2bKWwwzuduHsOSGDKFmBo5kAHcQ54YP420MIL5/+AbJYlGz34C
 MXddl5kotRgkNP+xUUydTSN5kK87FDQFNtd1BskS6NUOQdCcuAOsL82vTgyQ==
X-Received: by 2002:a05:6808:1927:b0:549:e9e3:9460 with SMTP id
 5614622812f47-56e5cff3837mr1010087b6e.0.1794522328745; Thu, 12 Nov 2026
 14:25:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1794469153.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1794469153.git.u.kleine-koenig@baylibre.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Nov 2026 17:25:17 -0500
X-Gm-Features: AclHuK89_7-xJ0fNP96-d-HS0yUpV4nDEkjT1yR4ni6ZgFZbGukqx6Zkpd666p4
Message-ID: <CADnq5_NFNbQF4F---Y8f-K4ZGb8q6=CdDtM0K5BL_nhsNbd47w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/radeon: Cleanups around <drm/drm_pciids.h>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 3:06=E2=80=AFAM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> patches 1 and 2 were already sent before
> (https://lore.kernel.org/3205129f75aba48bd1ad8fc810cf6a18e718206d.1777545=
446.git.u.kleine-koenig@baylibre.com
> and
> https://lore.kernel.org/20260430102958.136859-2-u.kleine-koenig@baylibre.=
com
> respectively). Alex asked to resend as they fell through the cracks. My
> motivation here is to have the pci_device_id items defined using named
> initializers to be able to modify struct pci_device_id. See
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre=
.com/
> for the general idea.
>
> Note that patch 3 depends on patches 1 and 2, so if amdgpu and radeon go
> in via different trees or branches, patch 3 has to wait.

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
And applied.

Thanks!

>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (3):
>   drm/amdgpu: Drop unused include of <drm/drm_pciids.h>
>   drm/radeon: Consistently define pci_device_ids using named
>     initializers
>   drm/radeon: Fold <drm/drm_pciids.h> into its only consumer
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 -
>  drivers/gpu/drm/radeon/radeon_drv.c     | 702 +++++++++++++++++++++++-
>  include/drm/drm_pciids.h                | 702 ------------------------
>  3 files changed, 700 insertions(+), 705 deletions(-)
>  delete mode 100644 include/drm/drm_pciids.h
>
>
> base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
> --
> 2.56.0.rc1
>
