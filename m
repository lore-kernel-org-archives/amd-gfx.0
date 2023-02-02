Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A40DC05027
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Feb 2023 18:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C283610E15B;
	Thu,  2 Feb 2023 18:13:48 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3352810E15B
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Feb 2023 18:13:45 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id r205so2126628oib.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Feb 2023 10:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uf/2wUtRE6JXY4wvtpdfNB3DwHlvu9eeDWmxhPLSBYs=;
 b=jdMo4/I4fZz7TtckdPWxn9nfI9kN8j62s1szXQoLN937nIe0/Cj/kFBppQ9GLUY9pi
 awTQ/oilODDeZuRwXhJdQdv4SrEcSnTmSHBqIrpqO4QaZMcIMhJ/Zc2ay5KGTuZcSMv1
 PQXh01R0psnQ0CIFD3mmPX27os87B+iixdSlT4yMKL1AYIJbgOKc6vglBAnLG2JdHw0y
 zjkbQBKDPgLWQukDAykriTX0ubVA8xBKfnTqAH9Em8r7lKd7toRDuQzDpFsMXlAAbVPO
 VBuoyiWTZmM8/XwOFDIdfFXaO7jXZ/e72gNQD72Gp2tU5K/WeV+WY5F4wPBQAQXa+7Y0
 bLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uf/2wUtRE6JXY4wvtpdfNB3DwHlvu9eeDWmxhPLSBYs=;
 b=F/OADevobzG68jH20TW/OppLTXOWLxytbaJzAZnFsyAq2BWRHr5P3nkaqmqVfaX3aE
 NlcIqLxohroJZ8ysK7ZE3KsLQnunw+CJT7428z1GMJx5lqliSUqmjOPwvZfu/TY6Hqus
 Cb3j00dG/SvCQ+zXoS2XPodpAXXAnYAPrv5DmWdSt5OiXd6PI9KQrTIYtFkmod2vKFVW
 VFrbAMcXTwp+1MC67vRtrDmX3CTwlj3XSdfammhwpSK4t3/wLiJ/IPPCgOc1LnzweUJ6
 wn7/TzzF/LmQ5qV+lmCGVbW5aFxWqjyHVQ29a1y6gAFq+4VeugIgfaDyreqhUzaCrMd/
 WGBQ==
X-Gm-Message-State: AO0yUKVZqOWjOBfVGajgNFd3p4nIYmSyvmbFTpaNzNpnj2PnweVBbh44
 Q29K/EVqoyOT7kZy2b0Qt1H6lZLNZEijMWkbWYLjRrNyEpg=
X-Google-Smtp-Source: AK7set9h2A2N+a+CIyIzfSYU2ZR0eFxm7+OmNJM7ZgoO8MGA3TDi5/bbhq04yW16G6VsKQEg1cPQSWF82YzayP3dbIE=
X-Received: by 2002:aca:e1c2:0:b0:35b:d93f:cbc4 with SMTP id
 y185-20020acae1c2000000b0035bd93fcbc4mr217287oig.96.1675361624357; Thu, 02
 Feb 2023 10:13:44 -0800 (PST)
MIME-Version: 1.0
References: <905de6ced5f1798deb21a523910a05cf9ff691bc.camel@web.de>
In-Reply-To: <905de6ced5f1798deb21a523910a05cf9ff691bc.camel@web.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Feb 2023 13:13:32 -0500
Message-ID: <CADnq5_N97JdMT_yk-X+RgMuO_=P3FNaYFN7URvNc38icGkjxWQ@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 2, 2023 at 1:05 PM Bert Karwatzki <spasswolf@web.de> wrote:
>
> amdgpu_sync_get_fence deletes the returned fence from the syncobj, so
> the refcount of fence needs to lowered to avoid a memory leak:
> https://gitlab.freedesktop.org/drm/amd/-/issues/2360

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2360

Please send a proper patch using git-format-patch.  Also, please add
your Signed-off-by line.

With those fixed, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 0f4cb41078c1..08eced097bd8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1222,10 +1222,13 @@ static int amdgpu_cs_sync_rings(struct
> amdgpu_cs_parser *p)
>                  * next job actually sees the results from the previous
> one
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
>
>
> Bert Karwatzki
