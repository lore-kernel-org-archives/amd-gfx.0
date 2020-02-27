Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FBFC11D3D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 20:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84F4246A0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 20:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQIoa7mS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84F4246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D6026ED39;
	Thu, 27 Feb 2020 20:49:50 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FC26ED39
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 20:49:49 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id e8so470286wrm.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 12:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jUNlC/fhhge0gplvlxSfWNj6E2D3L4vUVkDY2Ycp6cw=;
 b=PQIoa7mSWU+0fW4UZw39ynR+E0udO9Odj2IOy1DfJkFcs5qckHfKehoAHAZTMqlhXL
 tjNOSRRBJbthcFGxDQ0/jiYacXAHOotdGQz/uNx5oc0CJkkNVwuNkf2rKvEe1CjZkSxd
 bglIYaOq5oe2Tzxu+VDCGYSweNAi+Qyt4jKxwe3Mv7+XdVBdkUpb6inm0HlJS/SFufwC
 BWjLy1GMzSZeLBrMuqaGJhg9zB6WauHsHtGtxSVgo3zZ2+SUTVFqWSCv2N2Mdxg/H/kK
 CCAciXB72e5MEjL6Z//1HXr1n+ME/9dO7HrpMeDJqv+Hsk+W9SLfXLcJ2vqFu3emArTZ
 q9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jUNlC/fhhge0gplvlxSfWNj6E2D3L4vUVkDY2Ycp6cw=;
 b=tz2/xr6qc1w5EWC+QN6QbJ8ecWiULdFlbSAquWkwsN24/l2KXwsjwOsYOZf2LCwqre
 /flCSub+Z9vuiuUde4ulz9q7LFGGxTbi5KVm4RxhS1K+1k7cuVjjkDe8dV2aXPLuSnCq
 w6DyQkAYk/xbT/Dlrfwx7XL9yDIp/pGiAGNsvy4J7Pis7z3gGCFhMNlXId5yr/mJJcan
 csghexj7CGfs04mtA7oSmHEaZWoYPchAje8W1Sn2mzvV4nG4XFfAlPPtLcQJJO4x2tdo
 fZWh7P/M0YsIhw7PJpjWDNG8/2yudKI2S5+fIP9Una3hQSpGq6IhIC9lMPxokA3c2/fN
 MF7Q==
X-Gm-Message-State: APjAAAUvaVhIBT3E3pnHZhTPfRVL2UbUL2Hfc703tBHUFX2AkxWeenrc
 q3BA4pN7VaW+jTj753iLAHSL6rjCSic61deR39NpZA==
X-Google-Smtp-Source: APXvYqwU4Re/8SlzJHqqR8aZxgEn7l58+oOikUp6YeQ2x1pMwWc39eC1m++dH+oKEAKA49by7n6JvUYb7d3EANP7BQo=
X-Received: by 2002:adf:8b59:: with SMTP id v25mr702242wra.419.1582836587932; 
 Thu, 27 Feb 2020 12:49:47 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_NTd_dZAtN4yVyeM+Fp2w0Toy=tkvz00OwiYyC908W1Xg@mail.gmail.com>
 <cover.1582758921.git.mcoffin13@gmail.com>
In-Reply-To: <cover.1582758921.git.mcoffin13@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2020 15:49:36 -0500
Message-ID: <CADnq5_Mco=rKBNc9JfZZFUK22AaXMM4My7=AcxzQ1QUTseN_sw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Implement SMU message register protection
To: Matt Coffin <mcoffin13@gmail.com>
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
Cc: Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 26, 2020 at 6:16 PM Matt Coffin <mcoffin13@gmail.com> wrote:
>
> Sorry for the extra email, but the mutex_init got lost when I was rebasing. Oops.
>
> This patchset adds a message lock to lock access to the SMU message
> communication registers to prevent concurrent access.
>
> v2: Separate navi10 change out into a separate patch, and remove mutex
> definition from first patch
>
> v3: Re-add mutex_init to amdgpu_smu.c. It got lost in the rebase
>
> For Alex's concerns, I omitted one of them, though I can re-submit if
> it's still desired. since smu_send_smc_msg was previously around, and is
> used in lots of places, I left it alone rather than replace every
> occurance as it still makes sense to be able to safely send messages
> without arguments, without knowing that the default argument should be
> zero.

I've tested and applied the patches.  I'll get the team to do some
more testing across more asics as well.  Thanks!

BTW, I think you had another change to clean up some of the navi10
code, care to send that one out too?

Alex

>
> Matt Coffin (3):
>   drm/amdgpu/powerplay: Refactor SMU message handling for safety
>   drm/amdgpu/powerplay: Remove deprecated smc_read_arg
>   drm/amdgpu/smu: Add message sending lock
>
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  47 ++-----
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  30 +++--
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   4 +-
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |   5 +-
>  drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |   5 +-
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  35 ++---
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  26 ++--
>  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  11 +-
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 120 +++++++++---------
>  drivers/gpu/drm/amd/powerplay/smu_v12_0.c     |  87 +++++++------
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  69 ++++++----
>  11 files changed, 220 insertions(+), 219 deletions(-)
>
> --
> 2.25.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
