Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB2606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZ/A312V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1649110E4E1;
	Tue, 17 Nov 2026 15:13:16 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 715C610E4E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 15:13:09 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-57368c586baso138149b6e.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:13:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794928388; cv=none;
 d=google.com; s=arc-20260327;
 b=ilsKrgHjcAx3C0lVGLw3KjilIgyUUE084CZDlr64XGhKFzvb7XqgBvK6uCCU5ezQXH
 l+TK5OxHZsENu0n3YY5QHuPdZ2fLBeLiNY/BWHnPBae9bJOP4yfISOdlr5ihg/ldQGlo
 61fQBzGotb0WuE2EtEnrW+tgpMyKtdI4o6E6aEGA7nhOMtjmsHIceqXx1djktOqSwzdG
 xylAs2n9HJW8+bypIs+XPWZqHIwWtkmlnJ9MDQ9q7kBBvoeSW51RZZXF6y3RXOe7/WGd
 +RawGxVkR/NG0JoCGQzXNYPX98+0101RH56Qa3j2NI5yAAGeKxzrAW7hIs3JVZVLCmM/
 Hpxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q0PVsk6AUbG8bUE6tQYJT8WrfoP9fKUG7xY6EvtD2pc=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=R6FocLSZ6IDkOI9KCUCN0LjbApLpk78Q4sn7x7iOgKNnjRI0r6g1ycgkgX77JK68jL
 ynVLyl7z38SBmJ1O/TaeeErTJZouSIuGESnzEb6SLmKAzx7YW5DHFaLQOszuD8PUgFvd
 Sge9Layi8Sl+2JuuzjjijxqJFrbpkkY9gstTxwpTSm8IH/hJK+ZZ2ojEXeSfqwDxwHQ7
 g38k41qmubTb8+UH4JLLh4nVxN8FAuGjUlwMx2PHdb+LNaDgZeNhTkz4nVbr+H2LdSL8
 uqHrSJH9V7GTs+Gylqa5GtTBYSfXYL3QBLpJhyKk6bdJ6ZB7VOBT8DDEeQpKcZbZbApe
 HH4w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794928388; x=1795533188; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q0PVsk6AUbG8bUE6tQYJT8WrfoP9fKUG7xY6EvtD2pc=;
 b=QZ/A312V0WxKNCvlb+DNsC5g6Yr4gNaCmmyECuaoujWI3P+bpECftBzREZX52Nn4ao
 kvyLlT6fSKAxAvqexHdAkmQMsyz4JKuqO/u7JG5/dqUrJyUMY5FTgyl7Gxu0dYNrFxju
 BwMW9K2ERgjCZhn/9wVfZ8p1qoWg7YScTZ/TCF1jGP2v0vhG2bw1bXZTP3yul6XO/dhz
 IuEO3T1bNcCAZC8Yjt0R/GguqGRF4AKOckikdGjjazHPLwZAwlLJH5AhQGmrdgE/wI/P
 tBGTc9sElIZB1e8lImpA+ZBui9I/YEjxVBQcGaFt7lPTf3z9yyOIeZMk8P652W8LCCtE
 aDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928388; x=1795533188;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q0PVsk6AUbG8bUE6tQYJT8WrfoP9fKUG7xY6EvtD2pc=;
 b=N+hHO6FIu6wY7/gjpenbBXHUkFpRjyBT+vaN/A0BUloD5BleZKp3ckzNurApjK3F1Z
 h8mU0bzzYmsVOWMPTMzvPCHt+fn760gMyompTM4qi2HFpAsgO38ACB0WCulnKmJfj/dp
 /wKP5N19eCjA0tI1Hv7lvEczs6m1JVZhYnEpZ73Fg81QWm29wQg4zzvc5ckhvh0sSINi
 VYZM8spMRSc+bD60lMPK5WB22KgKI0Nl+UdN9InX1/jokk6SPY8KQeO385C5AiuHlmE3
 577IsGFPbc2jAErHQVHqO0bVusKzS2im+B7v3wLtO6uBa4zEQcbmTWe7nYtgBoZB7OrN
 ahQg==
X-Gm-Message-State: APuU4Z+CFJvASEClXHj2aEzCQy6JpampDfirGINAACllesnpVChuFdV1
 YOAj3SV5lgzjImVXLr1X+TlY1ymSy/0jFKKdjFII5PwuI5FeH2doz2UmPjiFZgYu0ZSeiov8YDe
 kPfmn2n5WgaScfMUYx4wfH5NrU9Px9yQ=
X-Gm-Gg: AYBFou2OcPr+Ef6WWm5O4r20roKGUPJkoOcGFCAirOANubpT4iz0hFCiCF8vVf1rGhk
 7OKg0BZ7+cknGK9LyfpXGnT767y6x5Eqb7pnG7+VZjUaa31MNaMDXzN0VAmXa6KDzQtu7F1yCD0
 huxq1ymfYEoZuoB5WwfoXMKFYg6/uFF5OMIgcc3Lg3lx83EaA8JFy/wGONcWjqqXCGMK0xZXz43
 x5yuCCDVFVqxpRYZhu4YuJIT7wlc21cMVG+EnG8FhKhlreRNOML8iS9SwyTL1GNAiUg53S49ATU
 1PEABoOYOEwBO5K985OndMmF9Va3K0gpb3QKRo7bNyxdLHEItu2bsTKOQwGIETQLlpbkmlsaYbc
 KOb8MX3UWzJk1b7ykAbO+Sl20h6AhA2668afmGLJxsu2yOomNbKPz4aR5x7ywW7PRMOwh63sEQV
 7xAvupRjgBpnTEYotK0W0ALgJZJG1mJOjLJHBVUx9+8zb6ju56R2nk79HxG+o=
X-Received: by 2002:a05:6808:1927:b0:549:e9e3:9460 with SMTP id
 5614622812f47-56e5cff3837mr21218379b6e.0.1794928388526; Tue, 17 Nov 2026
 07:13:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106224350.3568574-1-alexander.deucher@amd.com>
In-Reply-To: <20261106224350.3568574-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 10:12:56 -0500
X-Gm-Features: AclHuK_481XYs9y5QMe37PMbTi4fpmiDFrttFqiS4ZdxswYWvot_83Mp530rX2w
Message-ID: <CADnq5_PDKMWyNy1261_aZW1y0efsjv67NKJA1Bj4jFBmheyFwA@mail.gmail.com>
Subject: Re: [PATCH 0/4] GMC 13.x Support
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Fri, Nov 6, 2026 at 5:51=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> This patch set add support the GMC (Graphics Memory Controller) v13.x.
> This enables support for GPUVM and memory controller setup on chips
> with GMC v13.  The first patch adds a large new register header which
> was too large for the list so it was omitted.
>
> Hawking Zhang (4):
>   drm/amdgpu: Add gc v13_0_1 ip headers v6
>   drm/amdgpu: Add gfxhub v13_0 support
>   drm/amdgpu: Add gmc v13_0 support
>   drm/amdgpu/discovery: Add gmc v13_0 ip block

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
>  drivers/gpu/drm/amd/amdgpu/Makefile           |     3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     4 +
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v13_0.c     |   529 +
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v13_0.h     |    29 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v13_0.c        |   999 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v13_0.h        |    30 +
>  .../include/asic_reg/gc/gc_13_0_1_offset.h    | 16009 +++++
>  .../include/asic_reg/gc/gc_13_0_1_sh_mask.h   | 54975 ++++++++++++++++
>  8 files changed, 72577 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v13_0.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v13_0.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v13_0.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v13_0.h
>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_13_0_1_off=
set.h
>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_13_0_1_sh_=
mask.h
>
> --
> 2.56.0
>
