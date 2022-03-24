Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05E1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 19:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AAD110E1BE;
	Thu, 24 Mar 2022 19:51:22 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32CA810E1BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 19:51:21 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id q129so5996857oif.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pSDOl4RxPS3vwyxqajmQzws6vv0+qNWYgNjBfF6MJdA=;
 b=M/fjEFAgiHj+BzsOVIXD82r8Ii2g8/s3VpSIXQR4zlmIZcAD0IkMUr+xPROHHPknNI
 dr7E95zOmFbRwstcOpTFjgkUKi7TvXSb8zjVJ+87LPI+Ovj+pNG9umxoKi0JJYR+2ZqH
 H+hQe+5easlTGLQo61UyGbxLJo1g426f4C9eBnBF/zjc7LEmnQJWiRsmwlbqWfJ1s5nm
 HeZJbX3G80U0Pi76oSMosL4FkMOeEdROwBIarfq2JMlUpH2bh34vFXr8o++pDEZFMJuN
 VKSOMW8UxGtJaLGe5gHS9uH5DxaO7AHfn8cXU7Iz0m1U0GcK4jJv0up0vPsYb/HTlfRA
 lF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pSDOl4RxPS3vwyxqajmQzws6vv0+qNWYgNjBfF6MJdA=;
 b=WV2jIRsX4ztJGINeudJBovrKwGNngJixdymcvkD9DJM7oiYplj9OLRo/2MkE+yzmi5
 19/xAMv5rbFj49jLtTT/WivtJLobLPy3LG7MNaJ51N9uBX/ZBgE+eFqvoPv6hihxI0sa
 5L8SQDtBBdrsnEwLBFmSOPzt/Rhl/FGUZBeBVvrwbwRpkxS00MnNRi6LUkjFCzALDD1F
 Bcn9SLl8nSXYtSd6Q0cjEgx07R7bQNtnG9whZR7ESj/sMX6YdGcd+T1IEkmvKKyrEJke
 Iesi/aNPqDJSFpuSSNR8EXbdh6NHSJuQ8PHjnRpK4knXUs1ugcU+5OZQkZrJsgZ9BgY8
 v4Ww==
X-Gm-Message-State: AOAM5327sszUCs1iJit0G3+J1A/1CDsTULKRetZCJVdI3sI73XwcnK9L
 doGe6mcEErM2MRHfODOm4Ps1sljqJYjL/hikjhc=
X-Google-Smtp-Source: ABdhPJzOeCxYZASuuN8H5BbjKWV4ZEeFQNdF1FDoP/DFeIQU4e0iF9/sVJW6kzKUUgcBKqVhmnGeOFxdPVfTMW7C8vo=
X-Received: by 2002:a05:6808:df1:b0:2ec:b193:ad6c with SMTP id
 g49-20020a0568080df100b002ecb193ad6cmr7765124oic.200.1648151480357; Thu, 24
 Mar 2022 12:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <1648110383-3533-1-git-send-email-unSimple1993@163.com>
In-Reply-To: <1648110383-3533-1-git-send-email-unSimple1993@163.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Mar 2022 15:51:09 -0400
Message-ID: <CADnq5_PkpohP3zYxMMoS7i_nRxTZfg0d3tiwPQA2hK3RFHVjMw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdkfd: Check for potential null return of
 kmalloc_array()
To: QintaoShen <unSimple1993@163.com>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Mar 24, 2022 at 9:46 AM QintaoShen <unSimple1993@163.com> wrote:
>
> As the kmalloc_array() may return null, the 'event_waiters[i].wait' would lead to null-pointer dereference.
> Therefore, it is better to check the return value of kmalloc_array() to avoid this confusion.
>
> Signed-off-by: QintaoShen <unSimple1993@163.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index deeccce..64f4a51 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -749,6 +749,8 @@ static struct kfd_event_waiter *alloc_event_waiters(uint32_t num_events)
>         event_waiters = kmalloc_array(num_events,
>                                         sizeof(struct kfd_event_waiter),
>                                         GFP_KERNEL);
> +       if (!event_waiters)
> +               return NULL;
>
>         for (i = 0; (event_waiters) && (i < num_events) ; i++) {
>                 init_wait(&event_waiters[i].wait);
> --
> 2.7.4
>
