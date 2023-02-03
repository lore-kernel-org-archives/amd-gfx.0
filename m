Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEA9C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 10:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A13E110E747;
	Fri,  3 Feb 2023 10:42:22 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FAA310E747
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 10:42:20 +0000 (UTC)
Received: by mail-qt1-x82b.google.com with SMTP id m12so4949433qth.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Feb 2023 02:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ju1Ff1FJyCyW5ucVJsYAbcciL3h3SMivmh4eBtH5AEo=;
 b=MEeCz03TK3R3T6DXRmywvDyEhbRrXQ1TPAm7znxpYmSEUMDzFHK4N0u8tytkesyzGr
 2mD3ZZnwj7GhqSaCbpd7/iZu3WuQmSG2pSTIKgxrbbpjl11rYmaTscF6h+aQ3w6qS2RL
 CW7eN8VvAI5RyxvhW4ZdRz85E1ZdpATcT76d2qm1iR5B6FBO2/TE5zlPTX9J3oYvjyDC
 31ncWQfNMxP+KxV7+pfwG+X+NO5B11OOJHzFT+dgDp2tzhxSc08z86h2L7bMkVVroLf6
 jXKC78sYMfuEJNmyTv0f3eIJfyiSs2jdaGTj9M2vEQICaCveYEj4+8iFroOhytLNX1Fe
 x+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ju1Ff1FJyCyW5ucVJsYAbcciL3h3SMivmh4eBtH5AEo=;
 b=PoPGzimdGeiUrGF2WvxvQqwiLSYLP1zkH3klbdAtsQF7ZJ/P36r21Eb+Lqu3qGRQ77
 XSuoZkeYrJO5xxn0HEekKd15tRWICVXZFxzXGnro3nPEz/nsyWUygYy2Yydwvy9fbWQM
 vp1a+7plq0tqzy2vRed0UyB06xSD4xlTfSSNkeaZBMMUEdmDNnnZTAbuh1Un9s6JKL1w
 lmzJVRa3y63j2QcYbpRR2/CqAC9ansYMMxNdCQUCOJLMhuHi63hjlU2N5NXxokPFDAgu
 WjRK14oHsl5thZHdk/c7sWPOhphK1ygMzNt4QWML9+3nsMWDnFo+q1W2u4ht3Em1gYhQ
 mo/w==
X-Gm-Message-State: AO0yUKWSHGstqSCKFzT/5oeU4ueo42rfecmj9A41AIDdjCEcqcSfHUXI
 9sWu+qT4q6xsCISaoxsx3punEuFBbb48fvrYsZQ=
X-Google-Smtp-Source: AK7set9/uRD1544x4foaTHK2mi2NUD58TEltq/I6SKuPVvNtcUcvscPotDa5YFhXpKX2pN3OOOLont7IgVFRqLc50LQ=
X-Received: by 2002:a05:622a:178f:b0:3b5:b318:3b7c with SMTP id
 s15-20020a05622a178f00b003b5b3183b7cmr955142qtk.310.1675420939416; Fri, 03
 Feb 2023 02:42:19 -0800 (PST)
MIME-Version: 1.0
References: <905de6ced5f1798deb21a523910a05cf9ff691bc.camel@web.de>
 <CADnq5_N97JdMT_yk-X+RgMuO_=P3FNaYFN7URvNc38icGkjxWQ@mail.gmail.com>
 <3b590ba0f11d24b8c6c39c3d38250129c1116af4.camel@web.de>
In-Reply-To: <3b590ba0f11d24b8c6c39c3d38250129c1116af4.camel@web.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 3 Feb 2023 15:42:08 +0500
Message-ID: <CABXGCsMtQEWy2KLmvJmD-irT=+=64Gp3tb-7z7AV8bGKi2XbCg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: fix memory leak in amdgpu_cs_sync_rings
To: Bert Karwatzki <spasswolf@web.de>
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
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 3, 2023 at 12:10 AM Bert Karwatzki <spasswolf@web.de> wrote:
>
> I hope I got it right this time:
> Here is the fix for
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2360
>
> From 6e064c9565ef0da890f3fcb2a4f6a8cd44a12fdb Mon Sep 17 00:00:00 2001
> From: Bert Karwatzki <spasswolf@web.de>
> Date: Thu, 2 Feb 2023 19:50:27 +0100
> Subject: [PATCH] Fix memory leak in amdgpu_cs_sync_rings.
>
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 0f4cb41078c1..08eced097bd8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1222,10 +1222,13 @@ static int amdgpu_cs_sync_rings(struct
> amdgpu_cs_parser *p)
>                  * next job actually sees the results from the
> previous one
>                  * before we start executing on the same scheduler
> ring.
>                  */
> -               if (!s_fence || s_fence->sched != sched)
> +               if (!s_fence || s_fence->sched != sched) {
> +                       dma_fence_put(fence);
>                         continue;
> +               }
>
>                 r = amdgpu_sync_fence(&p->gang_leader->explicit_sync,
> fence);
> +               dma_fence_put(fence);
>                 if (r)
>                         return r;
>         }
> --
> 2.39.1
>

As a bug reporter I can confirm this patch fixes a memory leak.
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

-- 
Best Regards,
Mike Gavrilov.
