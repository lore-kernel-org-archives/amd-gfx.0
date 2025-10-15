Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B2ECCD193
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 12:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135BA10E797;
	Wed, 15 Oct 2025 12:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.b="FjT2tTY1";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA3F10E79D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 12:04:06 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-88e22898072so97485885a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 05:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1760529845; x=1761134645;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X3tSr4HAvbS0zz40z1XcCEFjgrGlF3qXMnfs2AVWb3Y=;
 b=FjT2tTY1likXYrsS9/NRmwLnHrYQxO4FXckVp1djxQM8DEeFO+p0ZgzkvtWcGpjU8E
 qbM63jgDQwYSTSh39qNkJeFJ+1NHOdZ8BgcDNdbhxvt0B8mu+Zd1ePHMVMeAcWblFjn6
 Hw9WlC1dcs5sOl2tI5FnGf7vUEluIYA0Pf3A+WWH+LAthphRswfYMdw2dC1vTFvIr6GE
 ZwFzCohv4BZ+xGkBrb11EhvmV8isnfyYcvimkrjcdELhca1H4XEuNnqlo9ocadv6rqC+
 ojbY7UVCMAz191V6sbILbYwEJtnLEB3ICgnssKtZ/erpMIV8UQtXxrjxOoZTygBL+3TJ
 jWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760529845; x=1761134645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X3tSr4HAvbS0zz40z1XcCEFjgrGlF3qXMnfs2AVWb3Y=;
 b=QPSUIy/axBepaET4cfAj0az3qpXRVRIC5ZdUnSKwOTi7Z2yZGmDpcl9BeTTbJ8V/A6
 KtwnfzbK+LeS4uw8QrieaKPAEIs3N+mp3cMDVPMNJgh9/mj2qBPqc+bdpTnJVxLwFe4o
 3QafN3qFWJEjOD4beGvCKWURMD9fd5QpEmraWKRLiu56NK5nVp0gCenEtVd4pgMBXRh0
 LDlKMWMyXdTwCKkAy879q6/ouhizfa67LZG3MYSBZropzjynXUJm+p6VASITW+sfKZnz
 1WopMlpKPW5b+bJK5IDuw9rt6FKumRBxpjk/65FhrON0mGD6RBzFWwK/dkrA29vaK6eG
 K97w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcExacn9taxjFk3CJmD5LyJm8AFcrxAhgByCNI4ybyPeUmv++8Q+fig23LGfqG6R083a7W6t93@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQ364ycLeXawGHD8GiOHu7AtOdGwbmR72lBj8qaUtFAo6xWzaf
 Rmk+PSgUA7kSligZR3uoCP1w7gWZfGnjLyb8dCbd0OfoAb1HIhEBI+j2nA7Y4zNR921kbWDM7RN
 AZCNUjB8J2BFGEyQfVM0ClmpAG5EV8zLxFKe0yXpgOg==
X-Gm-Gg: ASbGncvvDkvSXQUBlQ/xeJxfjc8f6cnBnAkQtGI7tXt9TITPtPOhxaSSoPl0/YtbMw/
 Z7M06AmNScMBkirMzlhwxMTpfSNnOfl5awLhInctQJhUufT0zuJNxf1GFTo8KJs/gw+o53L31jW
 7eCwzzNbj03HqsBmHyARl0+QfJLYC7asMkvYSCSfbK7BG2718V+CuNdQJRNjTshugabt90svkuG
 6T6/X1d1WaYMhjE2y9Ntzr67Hr3zAvZig==
X-Google-Smtp-Source: AGHT+IHqCTndsaW9mNNOpEoxqpK+g671TVftkJwHJncfJRnISWrovh6jkW0GrLsJk4LzlYEdY/SfnIetRnQxqll+9N8=
X-Received: by 2002:a05:620a:d89:b0:859:7e5d:efb0 with SMTP id
 af79cd13be357-883521dbdb5mr3978297485a.43.1760529845105; Wed, 15 Oct 2025
 05:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250718105407.32878-1-vignesh.raman@collabora.com>
In-Reply-To: <20250718105407.32878-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 15 Oct 2025 13:03:53 +0100
X-Gm-Features: AS18NWCXawAF8rrUemNB4cY6pOyINS36FA1C_QZssu58BBI9i4GnKsHpaQ9lquo
Message-ID: <CAPj87rMRKdm4BvfD8gMmSF3jjeMK4nurzTKPOFY15V0tBr4pyw@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] drm/ci: add new jobs, uprev IGT and mesa
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
 robdclark@gmail.com, guilherme.gallo@collabora.com, 
 sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
 lumag@kernel.org, linux-mediatek@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi VIgnesh,

On Fri, 18 Jul 2025 at 11:54, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> This series introduces new jobs to drm-ci for testing the following
> devices:
> - rk3588-rock-5b
> - mt8192-asurada-spherion-r0
>
> Other updates include:
> - Uprev IGT and updating test expectations accordingly.
> - Adapting to recent changes in Mesa CI, such as:
>    - LAVA overlay-based firmware handling
>    - Container/job rule separation
>    - Removal of the python-artifacts job
>    - Use of the Alpine container for LAVA jobs
>    - Various other CI improvements
> - Disabling bare-metal jobs for apq8016 and apq8096, as these devices
>   are being migrated to LAVA.
> - Updating the runner tag for i915: cml (switching from hatch to puff)
>   to improve device availability.
> - Adjusting parallelism in jobs (sm8350-hdk, amly) to better utilize
>   test resources.

Series is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
