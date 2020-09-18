Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C38C43464
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 15:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11DE23788
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 15:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpNM4SyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11DE23788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4E86ED1B;
	Fri, 18 Sep 2020 15:03:26 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C03FA6ED12;
 Fri, 18 Sep 2020 15:03:24 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id w5so5959905wrp.8;
 Fri, 18 Sep 2020 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Nv2+p022IYU52iHREG5F85mUc5+hp7EpOgNtHzw3L30=;
 b=HpNM4SyYNnFFDxmfUZqQxZGmnNPHOAGTKoesPaWKlg6usOS9n3rT0VunvGAELLhJPU
 eoY6kTqiik3JNL804xLROYbqEn3DD4qDNF7zuRG4gImPq/jw813ouo2XXHo4GiwRgIDI
 yVrx4FEvH6jIX7Fw+dVuBZrnKphFK1KS4NYW557DNVqn1QRAXxxgb1/OX3lInBsPDpw7
 4oYjyckFod3QxIbHuESNiW+82YdRRlDUcnA630XE0yHssemxxoB5lyrw8msaJh8Jzyet
 hmSATGrW74zBO7Aud7zXoRHwEV3XQCaeAwRJFnk1QSQ51vRCOJOqh1xJsSBT4F1RTcl0
 iSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nv2+p022IYU52iHREG5F85mUc5+hp7EpOgNtHzw3L30=;
 b=HT4Zx8NEPtLZarTbMKYzarot9J3DzzMDB01slTH/8zGiX3t6MJKxtPl453xGPzOozt
 sRt0wvjStRC7OeBnEvYgxglH+jlEU+j1W4euD6FA+ZWAi2NpP6YIip2ImkxRqMeNRWkf
 VILWA3uh7cVB/cZCFhyUn58YcVA2rXNAI8+6gng7+TXEU43aFFNHVxSCTrwfEK+JQ8Zu
 OxNYnWNGZq75gcb7a2HRl0HolJZ7VgvRqmNG7CJ8ndyDySTz7Z20+XLHsD8OjtnoVbAO
 MXV+opC/psoGonUhs6Ak3rRKMHEUmBfcr9HppBpfXJ5LKgLQwRBM8tICQXWDZPdmeAwr
 Ht1Q==
X-Gm-Message-State: AOAM5334WTprajqgazaH2+SaVw2o3IAsB9Q4Mrdn838kvyze05yRSLsH
 qZle8rTP5dta+/UPeFX56xdHJi4lb5J4u6WjPe7RSQlR
X-Google-Smtp-Source: ABdhPJy+bjRcE0HDVj/zeF111fV2xPIPeSGLqXnMvwDLQ6W/qIft6qMRKilkz4IoVNsjizBlSL7XlBhAWM9vuR1HLqY=
X-Received: by 2002:adf:dd82:: with SMTP id x2mr40592001wrl.419.1600441403418; 
 Fri, 18 Sep 2020 08:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200918132505.2316382-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20200918132505.2316382-1-daniel.vetter@ffwll.ch>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Sep 2020 11:03:12 -0400
Message-ID: <CADnq5_NW_k6szxmLxvf+tca4-D7oUfkLg1W-P0Q8AjVPBK_=iQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] managed drm_device, absolute final leftover bits
To: Daniel Vetter <daniel.vetter@ffwll.ch>
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
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 18, 2020 at 9:25 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> Hi all,
>
> These are the leftovers of the leftovers of my initial drmm series to
> manage drm_device.
>
> Changes:
> - bugfixed i915 selftests
> - patch from Luben to finalize the admgpu conversion
>
> Alex & i915 maintainers, pls ack for merging this all through
> drm-misc-next since otherwise the final patch (and the resulting confusion
> with outdated docs) is held up another round.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Cheers, Daniel
>
> Daniel Vetter (3):
>   drm/i915/selftest: Create mock_destroy_device
>   drm/i915/selftests: align more to real device lifetimes
>   drm/dev: Remove drm_dev_init
>
> Luben Tuikov (1):
>   drm/amdgpu: Convert to using devm_drm_dev_alloc() (v2)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 16 ++----
>  drivers/gpu/drm/drm_drv.c                     | 41 ++--------------
>  drivers/gpu/drm/drm_internal.h                |  1 +
>  drivers/gpu/drm/drm_managed.c                 | 13 -----
>  .../gpu/drm/i915/gem/selftests/huge_pages.c   |  2 +-
>  .../drm/i915/gem/selftests/i915_gem_context.c |  2 +-
>  .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |  2 +-
>  .../drm/i915/gem/selftests/i915_gem_object.c  |  2 +-
>  .../drm/i915/gem/selftests/i915_gem_phys.c    |  2 +-
>  drivers/gpu/drm/i915/gt/selftest_timeline.c   |  2 +-
>  .../gpu/drm/i915/selftests/i915_gem_evict.c   |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_request.c |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_vma.c     |  2 +-
>  .../drm/i915/selftests/intel_memory_region.c  |  2 +-
>  .../gpu/drm/i915/selftests/mock_gem_device.c  | 49 ++++++++++++-------
>  .../gpu/drm/i915/selftests/mock_gem_device.h  |  2 +
>  include/drm/drm_drv.h                         |  4 --
>  18 files changed, 51 insertions(+), 97 deletions(-)
>
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
