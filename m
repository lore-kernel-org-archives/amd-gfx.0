Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C472C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 18:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C553D10EFED;
	Wed,  1 Jul 2026 18:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UYJfMwGb";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157CE10EFED
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 18:16:48 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2c996117854so3020335ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 11:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782929807; cv=none;
 d=google.com; s=arc-20260327;
 b=V9qWwWgCu48/UuFSi5viA8Xx/6wpyrn34wvlotM2iswcnF8vSfncFYo720MzILU8HD
 yEYIs5mIYT27HtIuveqcZWylvjcuQWD4PZ02EEA6H+FNt8BKKopBfvdqlk9B0xeaS3YP
 r+NCbSEGkwIXG0023eQcexxmZnDxCqxA31VuLuuM7gTEJYC50qUbm9BcA4VsRQF5meDs
 N9AMJCuUBu9JdMuyfAMohX1vi4hWIIbfOqV1LKAWuTTnkr6WblESHw70QwegDXOHfNFE
 8baK3qse+KBiPdyv9aRl25szJRQHjOHPs1OcqJPVj+tbsVHLXhBy1aY8LI/tGlr1gWGv
 q4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xAxGAcsIx40SPRaDf45jIAw93uvuTD3GOffjQyTmnq0=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=a9VtGhI240WQVS07y6Wja2pG8TfCql4u2+BhI2NCHfLdjYdNqLQ49uDmxCSLUHtks+
 0a+5kxIHKO7Kl+Iut+Si3vxNQTxctTzAdvm/zYZDrn0v09QSAjMuidWeezPSY49V6zFr
 AF+7WwXRUDVzlLjNs2fFUQXvtKnt8ZI4L0LkoU+IBX5gS8RAOLOkki/OMiWMsM8hlDTi
 8brZSI1/JEGujVuiQDkgvK6Ronc/MCq0jDa5hfANCwVdHYKyItPlF3WEHJ9kqnyIJz4x
 aDCTSb0QlggZvZiXEVY680iIOQdbEWTxiND8/YmEFB/Ecfp/IBd22Y3K6EfU8MRgfMgi
 Vccw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782929807; x=1783534607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xAxGAcsIx40SPRaDf45jIAw93uvuTD3GOffjQyTmnq0=;
 b=UYJfMwGbsF7JNGvUqMmVCUoxbf54u7Q9j9ye2nZy2m6h1vaeyl78MAA6DNLTMiYi6/
 6Fi5COi9tY+u2lsOmuhSKshJyqxmnORf4bejuEtgnZrpSKXE7oKQWsx8gcKUwkiBY6IV
 DbsXwn335reJW5siHt+2zvyMM0jrNlQ3ztPD1wbPznLOz6xSjg7QUeWZlA1xqKR5UX13
 bd99YFGCdEP4CdysGRScKDGTcOB+fIQ7gX9DO77TUrYZIn3pvo7uwtoQUx1rimAZuA5J
 jSBjMXFKmzIo2Ih05y7hmdqHxATZCCkAacVBCTwfkDQXM8R1uK+sMtxVSnwo9jeCqhUF
 98tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782929807; x=1783534607;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xAxGAcsIx40SPRaDf45jIAw93uvuTD3GOffjQyTmnq0=;
 b=ci+dtkuR9T8YvVLKEp5K+TwtUQofpTYp9K1x6/qMMFznUMbwzEzSVm+p4sN3TNe/0f
 iaHaueyqPrRZi7Eohctb7Ge9s3c1dp7O8ZLHWCmsptDW9nRpYcN44HGdoe3AMY2xX2sh
 2H5f25rF5q+trQf9ecTb8UYFShZscbYkAzKai6wrvTdDGP/i5e70+Aa4QtDIaEwcwlXJ
 hN4+Ni/+pYPuXK+c1KqurdmaP9x6RDKCbBYmzeoAOs6LljHHy0b8qLzom+eFV9bMjfVM
 Dec3X89WxcOqnYCcTNT9mp8QADCsLE7CsHZemXWj0YwCqVeqZFO8naDucL/3ojKXIJ3O
 m0CA==
X-Gm-Message-State: AOJu0YxtCsI32XF69X1bUM9x76bvUyKH4qK5lFQV4zhImkHyTcAWDv31
 WuzM8ZuozaaO04RIxXAiR6FBEGGFFy2w9Gcof6ML4tZIauh6NYA+mQcd8wd/K2bVOXAIm0CkZ4W
 j7EFdSeLCap2sgDk9FyW8Mvo4eIkPISM=
X-Gm-Gg: AfdE7ck1LFk3aASgzZZRIT7GXARZI3ur2gBioYzCpRnCk3SY9RxKS5q29O/9oQ8azXc
 Kwi/f/mb5pHVYmN/RnudQLNBcLUu0pcUV8noTAo/UWfjoDSkANbLgJlv1M7578j/rSGZlwHn0VA
 O8dfSsNaT9iK95nEX2Qm8drjBkjuIhGvrWN9nmMCrNLs2xh70WCbsg7EHFIkaXNrPoR2/KRYRlF
 oTwP4n3aB0V+/dtyqYkruROn1OSrmHRTopJpJlUwQA37Eu6vkjbiaT3DyOZY9XQs8Sn/revz++o
 G6SH7u1FzcUZM6g6KnL6vWECds/VGmiMyu9yb/P5J9O5fXq8Xh+6qjkqbCQ=
X-Received: by 2002:a17:903:2c9:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2ca7e5313c2mr19066655ad.0.1782929807460; Wed, 01 Jul 2026
 11:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260701102748.1261029-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260701102748.1261029-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jul 2026 14:16:35 -0400
X-Gm-Features: AVVi8Ce1nHMClw2feIy-Tw7XlQr_MQq1WwpwCfV6yUqo3KrApwtnlwYcEi-_afs
Message-ID: <CADnq5_MMP4PAQ1Wyfqx-yyvptADHOknL0XTuDdpvPkuigq76Ww@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: trigger GPU recovery when userq destroy fails
 to unmap a hung queue
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Wed, Jul 1, 2026 at 6:27=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> Destroying a hung user queue issues a MES REMOVE_QUEUE that times out,
> The destroy path only logged the error and freed the queue, so the
> next userq submission failed and forced a GPU reset attributed to an inno=
cent workload.
>
> Kick the userq reset work when unmap fails so the GPU is recovered at
> destroy time.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index fb7e18c841ee..aa5cc5642e87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -542,6 +542,15 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr=
, struct amdgpu_usermode_que
>         amdgpu_userq_cleanup(queue);
>         mutex_unlock(&uq_mgr->userq_mutex);
>
> +       /*
> +        * A failed unmap means MES could not remove the hung queue and i=
s now
> +        * unresponsive.  Recover the GPU here so the wedged MES does not=
 fail
> +        * the next, unrelated queue submission and trigger a reset attri=
buted
> +        * to an innocent workload.
> +        */
> +       if (r)
> +               queue_work(adev->reset_domain->wq, &uq_mgr->reset_work);
> +
>         cancel_delayed_work_sync(&queue->hang_detect_work);
>         uq_funcs->mqd_destroy(queue);
>         queue->userq_mgr =3D NULL;
> --
> 2.49.0
>
