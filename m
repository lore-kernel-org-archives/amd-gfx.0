Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774E5C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 13:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1132710E1CA;
	Fri, 10 Jul 2026 13:11:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V6xwd5eu";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D1710E1CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 13:11:48 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cac39b729dso1864965ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783689108; cv=none;
 d=google.com; s=arc-20260327;
 b=QWA6wgfIgL6VfBkCo/dpQxANe/TRjsaC6xh8fCI1VJKXYXvGDNuj5I7sGmR6EVfjYd
 RNQVd63D6IwoP0P0O1yPETxg5/y8bF1z6nFdhKfN5ISUv5msKbefUT+SsQyrYYBt4J5N
 trpnodSq13CReAly3E46lntlk4F0aqaTCPH4ZHl2PL1RVlQCKcxRuVTox3tpAcbeA6ms
 g11aJ/+kDxfnqvK2kKkR1FljGt+g+iLQG4xvBzmnW0uG/LGkzTWPrK0SaCRg1Lp9HJ2M
 jObemcUMPUi+sb+4gRx6qLwtjhzdL1dI0eteTU+dZpDMwJd1EPLgJwCfC/P5npSAfvQj
 eOcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Sift9wSoOoEUQv9EUfa/hyijGQOVq6okw+WyJTpjnXw=;
 fh=X5Kw/mzK1Y2XLOpmcyD2UWHIr4BTF+ZIOvJZy8cWd20=;
 b=Zc7M8acjWwqONq6cFEf8ioTjboZDDydSjJmEOSqbD1wxQ1Tc09k1LWEfpmU0DRyXv+
 w28C0S4Tnf4zUFj5hEe9Y6C9ULMmBVJPQZf/epzEbzvHvrl9mjFNaIr0CZVaW4nJK+3i
 V5bt8ccVm3ZqouYUTpBP8NkSFnyvU00M/VCNX8Dlham71j8MNch1jIIed6miDLIBA6by
 Io1nNuZ9eXslwjd8wE+6RWqiQaMN8iv/Xcuk5U4TZoBtsQEtRbNDhsDpVsbHMk7fEn8W
 Y2iIwcmoFJMfRVodtFj0PPuP1aI5fr8Qw0U+nJQRkCwzO4kYyClP7MKeYvNMxfwlQ1Pq
 VXAg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783689108; x=1784293908; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sift9wSoOoEUQv9EUfa/hyijGQOVq6okw+WyJTpjnXw=;
 b=V6xwd5euZf6GwfGFTBY3pwrkgnyqQJEst4fOHokPlpcdPbj40O/B3YzGUvsoZaVKas
 WYvFbl/MJo6vgN9SCe4TMkQh+1v3INReVHs5r7SBmV6l+01b3ZsBp4VHxVVuMayDzwnN
 wdIuaJpW2pGGdAuKqE7SNonabkkKdLmiL40dWA0578ZG+Goj77tet4trq99Pzglu6GvT
 GoQZIBmETR0FteKr+2wjWYImjGpfeU1VMcI8UdFugdvh18nngp2LErVVDHRvJhJAm/Fr
 NhG3Hw7iDN+BrHVz9eOs4MdpHOHq1mGxNenMQIdicqLNzlWsLnSwev7F/eiNBMJIw5C3
 kOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783689108; x=1784293908;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sift9wSoOoEUQv9EUfa/hyijGQOVq6okw+WyJTpjnXw=;
 b=F1IlQ6aJRkuj43+TsrNjHPXUr4/IsBpGDvurRUMXrNXmcy5jR3Hrl7O3iGMQYraYqd
 SRiAR3XqdUkQitZK0YDFZX6TMIcaul5HQcE4uQIHVpjS3AxXI8Fsf6Cs7bT4XGC/Ctae
 KRW5Irevp5Yr6Hh33tSmzZvWRQu8O9RaUrRz1FP/vUhHku6frMlZGs9I90AiWLF4Akhv
 p52NcDStibJx1f9kBnbzKnK+ACEouyMxCVNG+b/I5zA3syBjJHXiZhhhPoy4Duv0Nowq
 /fAFeveMtaCxgZi5NEVHOsCF9GoFcgLO0XsU9SdkEiWHOFtCo9s8PRxZaeH9wzMeXbCj
 WOEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpJtShbi+5vfnKx6ivPHyzu7ZKtxR+vF6x6gRwgWmOOZzhfSMXMntlPSDbs+OJIPg7527raMwX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFzrwgItuMs/1wy0Do1LvtcX0aXfQPT+75aQ/6QCQvdcglN7kr
 fKi1e7+gZ5wVdeV7BY3HtOfnQrE21OLqSIfzEtT1tzPK+pAE4gC+aeenx5qOU5TVxLdtMPiIMJo
 m6AQswsuGDTfLlYoZUeSBplKMFTHelX4=
X-Gm-Gg: AfdE7cmwSLJBtvrOwz2b5+P4MD86FdwfYCvM35rqnBS+5HHvAzio2bmYP+VGRWWXCBO
 1esxp96J78oa1eEkFDh0gsNrxVLoNSAbwHJabgJYo8QfFHdd+cSXLmNXU6txZZVkYBGS5pZqwL0
 rmMd0cdHvK9x7lp9wGQf+Nca9whP4SeFUCZFcFR0BtzA6Si6cUOprad2AEd/zSTGGd6Q7m/N8QT
 qTfnGIf4y/dtFFm89hH59Q0Sh2pTnhOZ1lfptmhFckzBmnBu2zhd+mB0gyJcPdeFKp3BCIjO76a
 VAyzWoJG7RxniB5KvQ2y/mTOoO1QwvNjwTxY+Lb4iwcoEwiuxSQfzvaOcZV5dp2ZsWQLUQ==
X-Received: by 2002:a17:903:8cd:b0:2cc:e3b6:f305 with SMTP id
 d9443c01a7336-2ccea3f7733mr91203895ad.4.1783689108095; Fri, 10 Jul 2026
 06:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260710091617.156343-1-lingshan.zhu@amd.com>
In-Reply-To: <20260710091617.156343-1-lingshan.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jul 2026 09:11:34 -0400
X-Gm-Features: AVVi8Cf2n09ahYASodunHnlDEDlRxikGwU4yjPRbGosy22F1_AiB3vRcyqxwC8o
Message-ID: <CADnq5_N5PR9CcJWD703jf0DapxGnDneAFyX5V0iNgR+27qWAUQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix bo->pin leaking in
 amdgpu_bo_create_reserved
To: Zhu Lingshan <lingshan.zhu@amd.com>
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, 
 amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com
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

On Fri, Jul 10, 2026 at 5:54=E2=80=AFAM Zhu Lingshan <lingshan.zhu@amd.com>=
 wrote:
>
> amdgpu_bo_create_reserved() only allocates a new BO when
> *bo_ptr (struct amdgpu_bo **bo_ptr as input parameter) is
> NULL, it simply skips creation when *bo_ptr is non-NULL.
> But it unconditionally reserves, pins, gart allocates
> and maps the BO afterwards.
>
> When the same non-NULL BO pointer is passed in again,
> for example firmware buffers that live in adev and are
> re-loaded on every resume / cp_resume / start
> under AMDGPU_FW_LOAD_DIRECT, amdgpu_bo_pin() just increases
> pin_count unconditionally, however the matching teardown only unpins
> once, so pin_count never drops to zero, so TTM is not able
> to move, swap or evict a BO, causing BO leaks.
>
> This commit fixes this issue by only pinning the bo
> once at creation, and repeated calls no longer
> take additional pin references.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 4dd7c712b8c3..7ac3b8fd963a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -276,10 +276,12 @@ int amdgpu_bo_create_reserved(struct amdgpu_device =
*adev,
>                 goto error_free;
>         }
>
> -       r =3D amdgpu_bo_pin(*bo_ptr, domain);
> -       if (r) {
> -               dev_err(adev->dev, "(%d) kernel bo pin failed\n", r);
> -               goto error_unreserve;
> +       if (free) {
> +               r =3D amdgpu_bo_pin(*bo_ptr, domain);
> +               if (r) {
> +                       dev_err(adev->dev, "(%d) kernel bo pin failed\n",=
 r);
> +                       goto error_unreserve;
> +               }
>         }
>
>         r =3D amdgpu_ttm_alloc_gart(&(*bo_ptr)->tbo);
> @@ -302,7 +304,8 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *a=
dev,
>         return 0;
>
>  error_unpin:
> -       amdgpu_bo_unpin(*bo_ptr);
> +       if (free)
> +               amdgpu_bo_unpin(*bo_ptr);
>  error_unreserve:
>         amdgpu_bo_unreserve(*bo_ptr);
>
> --
> 2.55.0
>
