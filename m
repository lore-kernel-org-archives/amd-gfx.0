Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC814C44507
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 02:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D547C10E27A;
	Thu, 16 Jul 2026 02:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="C5luYaQI";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CB410E27E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 02:09:00 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-6680ae2031fso2297029d50.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 19:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784167739; cv=none;
 d=google.com; s=arc-20260327;
 b=elS/nbZyI8x6k8zd9pYLZwOdsAfStrUbuqFztxjOirm9fquXWg352ZEvKY/vYUuh1h
 fUh0CbDaxrU5HxCMrZn+YmQjDNI7d8HfWySwujVKeRw2JMsGQhs0HOwN3r7EiT7xQzoB
 C1gDxek3iJcZqLBXf2XpihAo1zvmzIxPbg8BsrKEwAZB1RHYTw6Ts+6kc7Q9C7Sv7vgQ
 DPFyWbkiaEfMuVyRgRt4W2roWvBOxEtFMIvgEEfWxauGTOAbyM8KFArJvhEXAl5zrRbB
 zBCD5KQu11vq6kySpnstY1BhZE3WrVIvqiM0swwu6hfkr5D1I2a+pZRU/SpbhUXGXgq4
 0WdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tII59+nJn0Y7yFeQ2yo7nNurb6NAgKIZTZuMeMT6aYU=;
 fh=gZ5JeMlQUrQSZLQrA1rObwbpy6SAQ5wGd79qHYgyo94=;
 b=R7R3lVMPC8bfGTI7n1nZnmxyRULNRXPR3gfRez8yyLf4Gzj6dbK/ed3/nitKJCfTDk
 FTxLsYj7Wmy2KTrIrbirswrBbnVSVYQK84UKyCS62N7QV1pEKMZ3x0aq23fQ0h07o1SZ
 imUALxdAVBPOUdpFXazxgV4YB5u5eqgTU3WpSc3QWl4uItdv8j+uGqiMzIaXrwxYdY7O
 wP2wdl2wz/uT0z2zr760zgO8SGwelggmWWm+++lo0viiqvvBlk3xoT+Exu0bHE3et6hP
 UxcwNR+QR4bVGKU9ywxdN0+TgR/ecMzQyw7J7/ib1tWVfPNWg6Gn98oql/1QpLTm2iT+
 qFUA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784167739; x=1784772539;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tII59+nJn0Y7yFeQ2yo7nNurb6NAgKIZTZuMeMT6aYU=;
 b=C5luYaQI3Py/qg1086ez3H7xctygQUadKJw5drsRb6MLsLn5BFy7geell/Snp3xJFa
 liDXUPnX28dEnF9f6DOReKL0LmIQXwOer9GEclVxqBBQ9X1fHIkIQb3acXf7H4O75AgU
 ijra68S/E6IbyszvR2GCtwRDSZminTNayXMSr6O5kpl4B/T+pk/XJ/fnMu48sXdVhgp2
 h52FOsKu/8z2kkZSdBKm09L3aO6zMFjigYIxpIKZ1J193mn2IvFPxvaEF/O+fVG89HKr
 TRiT2tEwwzlb5YanHWTcXuN0aY4IR7jTCcrWJ7Sy73oJCbiFyDsRj5ABgBlbagyso3p9
 +u9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784167739; x=1784772539;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tII59+nJn0Y7yFeQ2yo7nNurb6NAgKIZTZuMeMT6aYU=;
 b=tQm7tOT9OcqBVSJZEfiYAHFyLZDA5TX3FU/xjyg7RNEiGme1q4dnpAXitCG+McVPGA
 YlLfjryXtkSfWuwZo+ah6bvvFXcwpFNB7RbfslSTXpiHsr/6zJVRtPHgqBozYgF8SsU5
 t+YHcEpyGO+QmzLgQ0Zfv7v0i0sAtyXx0c25vQfAlQKqr6M4w7IN6Wx8skIkncaqRTSX
 4rf7NzeSA0Bhhp381DhFr33WDn1KtKa4RipuzJtqAtnLMKPYiZumIcb6xbJGRBgbWVft
 DvT8alWELb5RQOz3bUW48I6PlpKlSSsOM3QoKdQbzwOkXmXVSt7XqN5kaYrGuphO6Hrd
 CTXw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rou33R75+5vVXkvZAPIh558m8W7uf/NVF62ZSymx4rUD80u4psb1Mhn4+BGgcO73HKe+zhY70EX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwL6vrTwb/k77DHV/CianBMRyHGWWcj4yMNTcm5dj0GS/sLAANk
 ZloGs5VoYUxKX6XiZWdAzeg50KswLQUnJb2qocJt+SUGENCkLmJ3X5sjCAYQsbCYoSljsLG6c8Q
 uUXYNUrCQIfctUxSUB+Iu4gM7w+i0DuQtLF257q0rvQ==
X-Gm-Gg: AfdE7cmUsg11uxw6+i8yzinHWClM42iTLB8Ed+8dx0WDQRDdAsiKmFMHd5d/TNeIswn
 EWir5TG9Xp5SSwfWGoJxvsWP+Xus+yiqgL+B3FdQmxbwyZm2K6L4qrZEo7bqqYVOytTIpJEN0OW
 aWdTjvlbz7ptqepI8Vh0Dfesy3/Su2yoz7LjCymtGwJC8uIrK+//ybikPJta7/Afk2r4xnBjsaA
 YdbR9bzi73gn/EElpd0nMU9Sz+O2LHQ3xw5V8uJjrBl3svEp/oEQ5/4KAvjevRmcfk0sL3/6AVq
 IchQ++TtgtJJMuuAnJM81B/GAfnibshOnYlCOE0=
X-Received: by 2002:a05:690e:1507:b0:664:e3ed:52c3 with SMTP id
 956f58d0204a3-667d7ccc0c9mr12122195d50.73.1784167739455; Wed, 15 Jul 2026
 19:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260714-radeon_32bit_fix-v1-1-42a99945f6e0@oss.tenstorrent.com>
 <11218edd-ae58-4966-8172-27b2435eaa1f@amd.com>
In-Reply-To: <11218edd-ae58-4966-8172-27b2435eaa1f@amd.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 15 Jul 2026 21:08:48 -0500
X-Gm-Features: AUfX_mysHJnJfe86rmMYRqwDkQW-fetcdx0Rb9SLA2is7B-buYGz3xeLKn1HoLU
Message-ID: <CAEev2e_gnmhYw_mV8zt2AnkY6Hj_F165veoAPaXhA_ej-5RUUg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: allocate dummy_page without DMA32 on fail
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi Christian,

On Wed, Jul 15, 2026 at 4:15=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 7/14/26 18:03, Anirudh Srinivasan wrote:
> > radeon fails to probe on platforms that have all their memory above the
> > 32-bit range with an -ENOMEM because dummy_page_init calls
> > alloc_page(GFP_DMA32), which would fail.
>
> Unfortunately I clearly have to reject this.
>
> The DMA32 allocation is mandatory for radeon to work correctly on some pl=
atforms.
>
> > Allow this driver to work on such platforms by falling back to
> > ZONE_NORMAL regions. dma_map_page called subsequently would catch any
> > issues with the device being unable to DMA into the mapped page.
>
> No, it doesn't.
>
> It's just your special case that dma_map_page() is able to use some IOMMU=
 to remap the page below 32bits so that the driver can access it.
>
> The problem is that we have quite a bunch of cases where this doesn't wor=
k correctly and eventually result in all kinds of trouble, including random=
 memory corruptions.
>
> In those cases it's better to not load the driver at all than to later de=
al with corrupted data.

So this platform has an IOMMU, but it isn't enabled in the upstream
kernel at the moment. I am able to boot up to framebuffer console. Is
there anything that isn't expected to work in this setup? Is there
some test I can run to verify this?

I should look into whether the IOMMU on this cihp can be enabled and
then try this out too.

>
> What could be possible is to add a special quirk for your platform to not=
 allocate the dummy page as DMA32 in the first place.

So some kind of a whitelisted set of PCIE vendor/ID combos (with
working IOMMUS?) where we fallback to non DMA32 ranges?

Regards
Anirudh Srinivasan
