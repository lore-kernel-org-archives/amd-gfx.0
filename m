Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFEAC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 14:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6777488FD4;
	Mon, 28 Mar 2022 14:19:28 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E828488FD4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 14:19:26 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id r8so15731640oib.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vNZUWqY43Gn4W2OKnC2HgnRd3nSjOoGrjselKkRTokY=;
 b=C+KFQUFnF9tZbtwjrVBX+5EfJXhFSN3WQ/nECiVc4E5bVaYjrg/NjKPHBx2XgjYTD8
 T3tNobdvOUP8Ra2IF+E50gPzQTADyk4Bh/tNH9CPiY3txhMsiJ2NtCixDEas3YuWljL8
 SDyfrLl2f7vaAGMwKg6RZNTc08j75vu2ZkJw8Wzbfu33QwRFJcObV/Xt/Nc+SPnTyNIh
 Ol7gpF8uSYk3MwUNqgLUPbIclp2p5V5/ChLTIrPwzJZNiIRBHwiT69gfEjOk9YKJc3Vo
 hQabLl6/UvNuHXy4gSGkraNScTUbjqanUcVgaMU3E8XfloKYBqHk1aFgjSVULNneC0JW
 59wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vNZUWqY43Gn4W2OKnC2HgnRd3nSjOoGrjselKkRTokY=;
 b=cFYroWh58sWKcM7fdXyWgr/CUVQ8JQGyislHu+WrycX/1+RRFKSWWu1fex6NQcKEWi
 v81lMcI66rk7g7H4d8A9xaCoQRsQiECeKN4KibUXSocalr0+ykYrsNEhg7qgVOf/0E/B
 kHUrScLCS939EvdzWSM7kBiAg/I1mnjHu5IEexIiEOal69VbOWbK8lmqTD1Ja4Do2vOg
 RRbLzio5H1MhMucGz8YCksvbteu3SsahnzPXANfB/1IKJIRU0Eytan1DutD19HnkLEfb
 2Zsbd6wk0G6OHZUYG3UlZTXktDJS2C7mnSoNfOMipMZn9NjAnBdjF8rV3+9nABnUxSAV
 730A==
X-Gm-Message-State: AOAM53287raUkvVMe7l7Tl9ehw/gycwSNbSMBUDlOCl2RHVjGCsVwL5W
 xoYrlxF6Lmr9DAxfBkaE3XR3rAEZRBAL48TDAws=
X-Google-Smtp-Source: ABdhPJyy8j3Ryy4zPV0l73e8W0RSsdyM7tteRPyE3+jJM/OVf6trItlkZFDm9ERbNcWz8mJmbBTopYJxnt2/1GGAEjw=
X-Received: by 2002:a05:6808:df1:b0:2ec:b193:ad6c with SMTP id
 g49-20020a0568080df100b002ecb193ad6cmr15841023oic.200.1648477166304; Mon, 28
 Mar 2022 07:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220328141230.46059-1-christian.koenig@amd.com>
In-Reply-To: <20220328141230.46059-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Mar 2022 10:19:15 -0400
Message-ID: <CADnq5_OdW6GHVAYnng0vzrfxDneV69h_=k=_2iWyxu2vZMu1uA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix incorrect size printing in error msg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 28, 2022 at 10:12 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> That are bytes not pages.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index ea0cde4904f0..f4a148917520 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -472,7 +472,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_dev=
ice *adev,
>
>  fail:
>         DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
> -                 man->size << PAGE_SHIFT);
> +                 man->size);
>         return false;
>  }
>
> --
> 2.25.1
>
