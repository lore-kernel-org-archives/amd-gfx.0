Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C1AC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 12:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2926010FC21;
	Tue, 23 Apr 2024 12:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Beag5LIJ";
	dkim-atps=neutral
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com
 [209.85.219.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5BDF10F6AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 12:23:18 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id
 3f1490d57ef6-de54c2a4145so892008276.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 05:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713874997; x=1714479797; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdEuS8XRlyMWs8i+nahfC/xh1vWX2u7uUNV94NmtyxI=;
 b=Beag5LIJTSmA6WUKg7LoR8J/hhNLUcpSOzopilPTTr4NRZiIwfZFoVJvsieSfIWfou
 Vjoe5EDC1HV2tH4WRhlJfTXIsh64l/fYGwXkJWXUzcyb1JxN/NPwKFAj40tSfWyOKPmM
 I1lU4eKgtfk32BkJRCsfMerlbsmqwzPnB8aqZneOAdMycq7TrDMq3/0atYvk8Dr5O/T+
 h8yA9ONVMUM0LWOcNS3jKAFnIymxHp5hDQBehgFftKBEsLGtbBYbEtUtFH0jtspmvj9g
 cH+j8nIPDx4Kac+PUWy5PvRxEk+10M5abhSVuVBfb+YUy7DIuPDfV3akUVwFYPP24fzq
 slyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713874997; x=1714479797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zdEuS8XRlyMWs8i+nahfC/xh1vWX2u7uUNV94NmtyxI=;
 b=pBhrrCdnuwDR2UQJtYW3bAWH5QT77sybmcxjKps6P1vj1zwoUGQ6Tdch+alIRYasqF
 oP9oj4PXCkJiXqJSBek9yLS3nJHNg0K4ZfEvrZSWe01k9iP4rEVNh+mTSTeFrJMaan2e
 mLaFiUjpj0MhnHxK55p3gjzdmGzesaHQgbPRn+Wd7k5lfvXMtcVCiMDmqNJFQzu5PEKw
 ivyPqOsSe9ozNDZT6Du9PAnXqhLNaFlwNyZtfr/pU+V1n+FZ/AYMFwokhyzXVET21aWD
 fsPY3M7oFfNPAajzNOpq/I78w+m+0FzZiY5oQQQcOO3toPxA61R5sEqCfYGIFQegMIbE
 pfMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFU1uD/msarUzp4RxQwa9cPmidD7r/WKTqUHW5xNqCteSfr/KkqlIRWrt+DV+N6fHSeCvkrZwnTBDvMi0rBlavHphCkT1J0sXL6Xmp4Q==
X-Gm-Message-State: AOJu0YxPyx3OL/v1vaO69QaEi9D73ZYpqP0N8SLMdpi+Q8KF4bEz2Afi
 +KuvuA2H/A50mhZsLQoeLbduyWKLz5p2qPXWadZLiZcZGkwB6ZvHFaS82gti4TrB7iG9M/HJzPo
 bcUmqYi+zZN9zI+NwLGQ/MC1LH6Ehe4XPmH9gCA==
X-Google-Smtp-Source: AGHT+IFGEmHXL5CwAkBYa70XCoYWKwe8UnjgAcbc2h7iJmpsycDinZVPrwrOVKWCKX5O935DZ/QH6hClp73iSys2pzI=
X-Received: by 2002:a25:8251:0:b0:dc7:4067:9f85 with SMTP id
 d17-20020a258251000000b00dc740679f85mr12766959ybn.58.1713874997608; Tue, 23
 Apr 2024 05:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240423040243.448091-1-vignesh.raman@collabora.com>
 <20240423040243.448091-4-vignesh.raman@collabora.com>
 <e3a0ea8f-d306-488c-a69c-aa18078e5e03@igalia.com>
In-Reply-To: <e3a0ea8f-d306-488c-a69c-aa18078e5e03@igalia.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Apr 2024 15:23:06 +0300
Message-ID: <CAA8EJppaaitcXkXSFTB4-S2CbBcrAVHouB0wWiU5Nw2FvpagqA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] drm/ci: uprev IGT and generate testlist from build
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Vignesh Raman <vignesh.raman@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 daniels@collabora.com, helen.koike@collabora.com, airlied@gmail.com, 
 daniel@ffwll.ch, robdclark@gmail.com, david.heidelberg@collabora.com, 
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 23 Apr 2024 at 13:24, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> On 4/23/24 01:02, Vignesh Raman wrote:
> > Uprev IGT to the latest version and stop vendoring the
> > testlist into the kernel. Instead, use the testlist from
> > the IGT build to ensure we do not miss renamed or newly
> > added tests.
>
> Nitpick: wouldn't it be better to (1) stop vendoring the
> testlist into the kernel in one patch and then (2) uprev
> IGT to the latest version? I feel that this patch is changing
> a lot of different stuff.

Definitely. Otherwise it's hard to understand whether a change to
fails/flakes is caused by the uprev or by the testlist change. E.g. in
several cases the list of failing subtests seems to be replaced with
the test itself.

>
> Best Regards,
> - Ma=C3=ADra
>
> >
> > Skip kms tests for panfrost driver since it is not a kms
> > driver and skip driver-specific tests. Update xfails with
> > the latest testlist.
> >
> > Increase the timoout of i915 jobs to 2h30m since some jobs
> > takes more than 2 hours to complete.
> >
> > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > ---


--=20
With best wishes
Dmitry
