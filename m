Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA02E74901
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 18:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0714B10E0C1;
	Mon,  2 Oct 2023 18:11:45 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277C110E17A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 18:08:20 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-57bce354d94so11695eaf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Oct 2023 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696270099; x=1696874899;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=muC7B8fW75NQ6UziQ28q/q7hcKRLv9QhdzwxKJUqnpg=;
 b=ZA5a1OBbtjccI+GX59yq3A+k8oeAWE5sqRzPtN6rs+jO0AAqCZ2VuMtywMVMdpZlaN
 X5p+oHaP9V0ogxR3qqmlN8EXnr0ewQRWnG2fklIl5TIlXJ816USIJRUUVTeTFUcDnA6L
 qj0OBtdSfQiHtelekMbSJgN5EwPBK1HaGLYt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696270099; x=1696874899;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=muC7B8fW75NQ6UziQ28q/q7hcKRLv9QhdzwxKJUqnpg=;
 b=HN74++FeZXrPJmI8ykTo5LN0apSvjTzi6c2iZ2E/5uXfegvOYvEVqkgw+fIOEYYa5t
 +gpCfr4FpLNqubCU3WBD6FVGlerGB10PaULn6EE3CxoRo9OtLmaX+PvxGVJIJ1ULhxJj
 VqXbDKHNTL/dYXbbOLT2k5J2YOBq1/FR6vB2aiHbjzQD51xDY6lDKKfUgiCpcgCrYOH/
 PXb7AtAoXGG5MXwcrbGq5yyl83ivkTcSeYqtarXj1cYyZ0+r9acrzbE2XSV62DDmJ5/m
 Dq2HVbSpPSOX/PIqRh2ac1vlJ8E/q2KCzyG8jc/pEn61nFwZ9UC1szEsr6KG0Z6CP0Lg
 jccw==
X-Gm-Message-State: AOJu0YwuOb9J3lqQjWJ4eCzUx+gax/y1OrqS1sTyupq2stVPkteLA+z5
 1/xC3erKqAjfoc+b8SK5btKDag==
X-Google-Smtp-Source: AGHT+IFxp3WuQLBF6a4Zx6RmI26vX0risXfepC82ZiUfTaJR3IBCtfYoiOluvuBsDmgpQQL/ViltxA==
X-Received: by 2002:a05:6358:728:b0:14c:e2d3:fb2d with SMTP id
 e40-20020a056358072800b0014ce2d3fb2dmr9868464rwj.5.1696270098901; 
 Mon, 02 Oct 2023 11:08:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 it21-20020a056a00459500b0069319bfed42sm5485937pfb.79.2023.10.02.11.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 11:08:18 -0700 (PDT)
Date: Mon, 2 Oct 2023 11:08:16 -0700
From: Kees Cook <keescook@chromium.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
Message-ID: <202310021107.9BB46FB8E@keescook>
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
 <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
 <202310020952.E7DE0948C0@keescook>
 <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
X-Mailman-Approved-At: Mon, 02 Oct 2023 18:11:42 +0000
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
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>, Emma Anholt <emma@anholt.net>,
 Tom Rix <trix@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, Prike Liang <Prike.Liang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Karol Herbst <kherbst@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 amd-gfx@lists.freedesktop.org, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-hardening@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Kevin Wang <kevin1.wang@amd.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Evan Quan <evan.quan@amd.com>, Sean Paul <sean@poorly.run>,
 Yifan Zhang <yifan1.zhang@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 Le Ma <le.ma@amd.com>, freedreno@lists.freedesktop.org,
 Bjorn Andersson <andersson@kernel.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Melissa Wen <mwen@igalia.com>,
 Zack Rusin <zackr@vmware.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexdeucher@gmail.com>, Nirmoy Das <nirmoy.das@intel.com>,
 Lang Yu <Lang.Yu@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 John Harrison <john.c.harrison@intel.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 02, 2023 at 08:01:57PM +0200, Christian König wrote:
> Am 02.10.23 um 18:53 schrieb Kees Cook:
> > On Mon, Oct 02, 2023 at 11:06:19AM -0400, Alex Deucher wrote:
> > > On Mon, Oct 2, 2023 at 5:20 AM Christian König
> > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > > > Am 29.09.23 um 21:33 schrieb Kees Cook:
> > > > > On Fri, 22 Sep 2023 10:32:05 -0700, Kees Cook wrote:
> > > > > > This is a batch of patches touching drm for preparing for the coming
> > > > > > implementation by GCC and Clang of the __counted_by attribute. Flexible
> > > > > > array members annotated with __counted_by can have their accesses
> > > > > > bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS (for array
> > > > > > indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions).
> > > > > > 
> > > > > > As found with Coccinelle[1], add __counted_by to structs that would
> > > > > > benefit from the annotation.
> > > > > > 
> > > > > > [...]
> > > > > Since this got Acks, I figure I should carry it in my tree. Let me know
> > > > > if this should go via drm instead.
> > > > > 
> > > > > Applied to for-next/hardening, thanks!
> > > > > 
> > > > > [1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table with __counted_by
> > > > >         https://git.kernel.org/kees/c/a6046ac659d6
> > > > STOP! In a follow up discussion Alex and I figured out that this won't work.
> > I'm so confused; from the discussion I saw that Alex said both instances
> > were false positives?
> > 
> > > > The value in the structure is byte swapped based on some firmware
> > > > endianness which not necessary matches the CPU endianness.
> > > SMU10 is APU only so the endianess of the SMU firmware and the CPU
> > > will always match.
> > Which I think is what is being said here?
> > 
> > > > Please revert that one from going upstream if it's already on it's way.
> > > > 
> > > > And because of those reasons I strongly think that patches like this
> > > > should go through the DRM tree :)
> > Sure, that's fine -- please let me know. It was others Acked/etc. Who
> > should carry these patches?
> 
> Probably best if the relevant maintainer pick them up individually.
> 
> Some of those structures are filled in by firmware/hardware and only the
> maintainers can judge if that value actually matches what the compiler
> needs.
> 
> We have cases where individual bits are used as flags or when the size is
> byte swapped etc...
> 
> Even Alex and I didn't immediately say how and where that field is actually
> used and had to dig that up. That's where the confusion came from.

Okay, I've dropped them all from my tree. Several had Acks/Reviews, so
hopefully those can get picked up for the DRM tree?

Thanks!

-Kees

-- 
Kees Cook
