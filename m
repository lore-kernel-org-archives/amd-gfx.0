Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B131C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 13:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C42604DB
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 13:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63C42604DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F23FE6E214;
	Wed, 25 Aug 2021 13:26:13 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E90FB6E214
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 13:26:12 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id y128so734160oie.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uLw2mOYDi5fteFZ762BlXIFX3M7haeIhrBQX0r+ibZ8=;
 b=fUyKsWhg6JQTK6hzqs7Nj8D1+PS8dTft2c1APgfNfPhrjLGEDPuxrWmWFPwFEp1f8I
 U5cQcCOQ5kVXZPBCpsC/qQcwLs1FaddtjuNpsbKeqf0YtOBzPwC/YuJt0UuUxxYlBWxA
 8M+xlr1I5/AaBv56EnjJeu3OAOjQDh+72OGJtkHqYcH28d1SwUGO232hmSE7CGyKNoGM
 gPj3VwpXB4fIy7EYe7gLy8dukkRk9RJHdJyPzfPIpJ5c0R3FbvP1RDuWZPVA54EiFj5P
 qGS2ZDo7/YFhVwIKjmflgk5NjXBvCtPq1CRwbYwWPBneZDpG5UY6xa9GXx8NQRSJVSTL
 xIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uLw2mOYDi5fteFZ762BlXIFX3M7haeIhrBQX0r+ibZ8=;
 b=ZYKu/wnSn4VxcNkhV8WVzv8OVrijLFCVNU54di2QYKAUnlnMu/6u/u9d0i8LlH62eC
 BgWIXGaUqQJz01V0Lwnn6n4D8edWB30TRNPC6CgC+ID7wB6r3n/4Pc4IIOAl1Xh3dyMI
 XCjjUS4Y7oiyvihhAun99relAuZHj4zgkrDknCo4h0eJFIZswsylnFogaMABKUhhFBFC
 q6zMocYjygkKRlp0KfCgl2gqrWL1Gtj5QAlTm10W1DrUgYnT0aEgu+B4P5ijGZ1NLemx
 hm3bEUsuZ81XKyXfO0xAUL46UPODR11Bt/48sc7JlrSqVQZ+2Th6do4Enqzewpt2g7Du
 PmKA==
X-Gm-Message-State: AOAM5311W/O5Hx9YAa7S+MXSy/5DRx/bMxKhIjScOxuAwRN3dN04Cd7l
 mWSNRVYFInL9vky0TxYflT/Wn+m0JnL6Hq+7rf8=
X-Google-Smtp-Source: ABdhPJzb86MC6duwb91NeSIM+SQkSXEmFuXs+s5fOoxgwdZKA1ei5UALNOkbiWrclxko8ih7CaAJigB+536GA+xSwTE=
X-Received: by 2002:a05:6808:1310:: with SMTP id
 y16mr6676891oiv.123.1629897972224; 
 Wed, 25 Aug 2021 06:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210825074424.170859-1-yifan1.zhang@amd.com>
 <408fe6fd-bf6b-0c5b-3b02-46c7b5c716e0@amd.com>
In-Reply-To: <408fe6fd-bf6b-0c5b-3b02-46c7b5c716e0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Aug 2021 09:26:01 -0400
Message-ID: <CADnq5_OFgSWuyWwYckfBuoXXxmNU-6V05bHEODqs4=NEk526vg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove preferred domain judgement in pt/pd
 creation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Yifan Zhang <yifan1.zhang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Alex Deucher <Alexander.Deucher@amd.com>
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

On Wed, Aug 25, 2021 at 4:01 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 25.08.21 um 09:44 schrieb Yifan Zhang:
> > amdgpu_bo_get_preferred_pin_domain was added to handle system memory
> > page tables. Since system memory pt/pd is disabled now, remove preferre=
d
> > domain judgement to avoid confusion.
>
> Well I would rather keep that and enable system memory page tables again.
>
> We should probably add IOMMU checks to
> amdgpu_bo_get_preferred_pin_domain() anyway. My last status is that this
> has been causing problems with DC as well.
>
> Alex, what do you think?

I think we can just enable them on dGPUs and APUs >=3D Renoir.

Alex


>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 0b893aa21ffe..764822edba18 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -926,7 +926,6 @@ static int amdgpu_vm_pt_create(struct amdgpu_device=
 *adev,
> >       bp.size =3D amdgpu_vm_bo_size(adev, level);
> >       bp.byte_align =3D AMDGPU_GPU_PAGE_SIZE;
> >       bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> > -     bp.domain =3D amdgpu_bo_get_preferred_pin_domain(adev, bp.domain)=
;
> >       bp.flags =3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> >               AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> >
>
