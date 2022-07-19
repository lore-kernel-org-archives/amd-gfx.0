Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA52C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 12:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBAA14A8B8;
	Tue, 19 Jul 2022 12:55:22 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 526B314AB80
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 09:14:02 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 cb12-20020a056830618c00b00616b871cef3so11231383otb.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 02:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=USiHEWO3jenD+4D67wgYkGKlAcIRmi0lfoN5PdFyKzQ=;
 b=dFYdzZzeGTwRc0FPEgBG5fRwMWNVjXZzxLxwtIHOW4IyAUtC1iJhL8ze0h/ntk8Iq4
 lKlrAFaVxT4/pV4802tsmPOfXqrd/5krNwAeme2Ty0hfRzSXMQ2O+C/Kf1izAeM/mOcz
 8LysLHAdaCtPPppxeQNBi2EL1ZGV/VNGij1I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=USiHEWO3jenD+4D67wgYkGKlAcIRmi0lfoN5PdFyKzQ=;
 b=ilcJum859ZfC4IfyU7mUsl+fY2uuf2gsIImcHZhptWUtHsDHwHIrgjyKGFltUJh74X
 gBoVldZzxMyCPVYcKulq1m6o/ruLMaHBYebbQx1ZkkJLnPHxHg5IfUPTK/e2V4vghGdz
 wPN/5VJ/bjLV0+nvzx6lapVawhjNiaW03Lm2vXuTIDzjaLHQbDpUtWuxOhPhgLKr/SCb
 S7mdY5htm2i63jV1EuNdxSbesXh0w7CsDbyxI/fBeUgxLeXPeG3Lhlgd0ZHofU0qXcjf
 xJScqdzRT25wQC3qnNlu7jCvidpQ+iYrhDn2k85MMwCDBnH8TA4JdxY/SjR8pb7PoCSU
 DDvw==
X-Gm-Message-State: AJIora8rMuCIlZlEbKE1inOSREZlO2NbQ2GQhYHMXtmZL5pBnyjq8W7x
 OiRdigPyOO6zihMXCrvKTR2/5A7dIV3VqA==
X-Google-Smtp-Source: AGRyM1uxjDDKD7depwDMkvm3u3Nj9KawuQvgq4t9MjGtFbow9kilwBRicETN6MudKhoiD6QTqvAARQ==
X-Received: by 2002:a9d:6484:0:b0:60b:eb0b:4054 with SMTP id
 g4-20020a9d6484000000b0060beb0b4054mr13159322otl.159.1658222041172; 
 Tue, 19 Jul 2022 02:14:01 -0700 (PDT)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com.
 [209.85.161.53]) by smtp.gmail.com with ESMTPSA id
 t26-20020a4ac89a000000b004358b15cfe8sm3577767ooq.13.2022.07.19.02.14.00
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Jul 2022 02:14:01 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id
 n16-20020a4a9550000000b0043568f1343bso2778272ooi.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 02:14:00 -0700 (PDT)
X-Received: by 2002:a81:6ccd:0:b0:31d:c77:73e5 with SMTP id
 h196-20020a816ccd000000b0031d0c7773e5mr33706265ywc.314.1658222030025; Tue, 19
 Jul 2022 02:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220715005244.42198-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220715005244.42198-1-dmitry.osipenko@collabora.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 19 Jul 2022 18:13:39 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C0dx5X=VEqXDyj22fbxs1jhOQLLid3vSNfAc9vataPhg@mail.gmail.com>
Message-ID: <CAAFQd5C0dx5X=VEqXDyj22fbxs1jhOQLLid3vSNfAc9vataPhg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Move all drivers to a common dma-buf locking
 convention
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 19 Jul 2022 12:55:20 +0000
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
Cc: David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Thierry Reding <thierry.reding@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-rdma@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Daniel Stone <daniel@fooishbar.org>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 spice-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Chia-I Wu <olvaffe@gmail.com>, linux-media@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, amd-gfx@lists.freedesktop.org,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 15, 2022 at 9:53 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hello,
>
> This series moves all drivers to a dynamic dma-buf locking specification.
> From now on all dma-buf importers are made responsible for holding
> dma-buf's reservation lock around all operations performed over dma-bufs.
> This common locking convention allows us to utilize reservation lock more
> broadly around kernel without fearing of potential dead locks.
>
> This patchset passes all i915 selftests. It was also tested using VirtIO,
> Panfrost, Lima and Tegra drivers. I tested cases of display+GPU,
> display+V4L and GPU+V4L dma-buf sharing, which covers majority of kernel
> drivers since rest of the drivers share same or similar code paths.
>
> This is a continuation of [1] where Christian K=C3=B6nig asked to factor =
out
> the dma-buf locking changes into separate series.
>
> [1] https://lore.kernel.org/dri-devel/20220526235040.678984-1-dmitry.osip=
enko@collabora.com/
>
> Dmitry Osipenko (6):
>   dma-buf: Add _unlocked postfix to function names
>   drm/gem: Take reservation lock for vmap/vunmap operations
>   dma-buf: Move all dma-bufs to dynamic locking specification
>   dma-buf: Acquire wait-wound context on attachment
>   media: videobuf2: Stop using internal dma-buf lock
>   dma-buf: Remove internal lock
>
>  drivers/dma-buf/dma-buf.c                     | 198 +++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   4 +-
>  drivers/gpu/drm/armada/armada_gem.c           |  14 +-
>  drivers/gpu/drm/drm_client.c                  |   4 +-
>  drivers/gpu/drm/drm_gem.c                     |  28 +++
>  drivers/gpu/drm/drm_gem_cma_helper.c          |   6 +-
>  drivers/gpu/drm/drm_gem_framebuffer_helper.c  |   6 +-
>  drivers/gpu/drm/drm_gem_shmem_helper.c        |   6 +-
>  drivers/gpu/drm/drm_prime.c                   |  12 +-
>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c   |   6 +-
>  drivers/gpu/drm/exynos/exynos_drm_gem.c       |   2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c    |  20 +-
>  .../gpu/drm/i915/gem/i915_gem_execbuffer.c    |   2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_object.h    |   6 +-
>  .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |  20 +-
>  drivers/gpu/drm/i915/i915_gem_evict.c         |   2 +-
>  drivers/gpu/drm/i915/i915_gem_ww.c            |  26 ++-
>  drivers/gpu/drm/i915/i915_gem_ww.h            |  15 +-
>  drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c     |   8 +-
>  drivers/gpu/drm/qxl/qxl_object.c              |  17 +-
>  drivers/gpu/drm/qxl/qxl_prime.c               |   4 +-
>  drivers/gpu/drm/tegra/gem.c                   |  27 +--
>  drivers/infiniband/core/umem_dmabuf.c         |  11 +-
>  .../common/videobuf2/videobuf2-dma-contig.c   |  26 +--
>  .../media/common/videobuf2/videobuf2-dma-sg.c |  23 +-
>  .../common/videobuf2/videobuf2-vmalloc.c      |  17 +-

For the videobuf2 changes:

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
