Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A78C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4218C20836
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKGIgn6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4218C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21186EB8B;
	Wed, 11 Dec 2019 20:20:05 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C986E6EB8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 20:20:04 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id b11so8648101wmj.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 12:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jjnhGj9D3Zt+ZSiLr+llRmVKFultni40oRhmAyNpqKw=;
 b=KKGIgn6MTG6qClWtMpbY+o9sGbQvWm5XuLErc1559i/+SgegZsg1DXJ5vOKHCtziWW
 PYLPsJmTPMhTVFx2au4e/3KCiawqv1GA6GcGthx8lZBTm335ME/TIvUyRL+FnlG9fsRS
 ALSjtZSETUNi8lFLu0Tzd9XHnuKUAe33YnTXXf3SH4iGyLKEGrySw1NKtKHwABfLTHQV
 oX6N63d/yJnmeVrGBJ9NuYYrLOhda3L4oS3NvMRHww0D+ZoHm/rx6W/pbB9Om+T1StSX
 tPdjJrPMSmrqPQQ6vldJlEm8KYX4rzfRmmg4smEEoU1CeJWZI/Nf6rRvbk0DKcqaoqN0
 fxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jjnhGj9D3Zt+ZSiLr+llRmVKFultni40oRhmAyNpqKw=;
 b=PuntkoQs490pAImbwBUzmpvzYqXCISiRyeuaCs4FVMsHgLFjAFcJonzLZbwww5CFoR
 hqhXTal5ZAmzk/zZeQVXOUwNpK5hK2ZOk/kMUOJ2UUOGWsnftLcFVkm3hLla2sD2V7Hg
 IScHfXccVA0EKotqeCVS/WXNWDCECZFDmKyu2LHPa+wecE8r9lvTuq5vVqrwojse8qXL
 vb9WB+Ar808IQlEkzjTTubwWudzjRPojGEUE4pGH4++wQmr3lfof9aFlZoCqMKyiKsyP
 3kmRGkiqFp/qBwbNoQ5NH+XYABQF/0wWAcqWZDjc4sFlM96E5Gd8ck1vOTqd8WVoc456
 qLdw==
X-Gm-Message-State: APjAAAWoPgSrFXky/8TLde9lnE0vP98OCsGG+U/YXKR0QvYPge/Ejv5f
 vEFsvEwwpwnciYui6nYT73rHPkvYPlEuACIRJTQ=
X-Google-Smtp-Source: APXvYqxbp0Kp7nOGW61DcWMkYUrl+TKPfe1y9LrJ4nRlmSrShBnv735eKIry1Ox5r2TtJNe1WiwaDfcWmAw2+6gVRj4=
X-Received: by 2002:a1c:e909:: with SMTP id q9mr1986974wmc.30.1576095603217;
 Wed, 11 Dec 2019 12:20:03 -0800 (PST)
MIME-Version: 1.0
References: <1576094829-2245-1-git-send-email-andrey.grodzovsky@amd.com>
 <1576094829-2245-2-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1576094829-2245-2-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Dec 2019 15:19:51 -0500
Message-ID: <CADnq5_OCzqh_t5YHithp2Kh0rxHsk4XxnfHm-Cm2_T7ZGSA4Ow@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm: Add Reusable task barrier.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Le.Ma" <Le.Ma@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 11, 2019 at 3:07 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> It is used to synchronize N threads at a rendevouz point before execution
> of critical code that has to be started by all the threads at approximatly
> the same time.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

You should resend to dri-devel since this task barrier is being added
to common code.

Alex

> ---
>  include/drm/task_barrier.h | 106 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 include/drm/task_barrier.h
>
> diff --git a/include/drm/task_barrier.h b/include/drm/task_barrier.h
> new file mode 100644
> index 0000000..81fb0f7
> --- /dev/null
> +++ b/include/drm/task_barrier.h
> @@ -0,0 +1,106 @@
> +/*
> + * Copyright 2019 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include <linux/semaphore.h>
> +#include <linux/atomic.h>
> +
> +/*
> + * Reusable 2 PHASE task barrier (randevouz point) implementation for N tasks.
> + * Based on the Little book of sempahores - https://greenteapress.com/wp/semaphores/
> + */
> +
> +
> +
> +#ifndef DRM_TASK_BARRIER_H_
> +#define DRM_TASK_BARRIER_H_
> +
> +/*
> + * Represents an instance of a task barrier.
> + */
> +struct task_barrier {
> +       unsigned int n;
> +       atomic_t count;
> +       struct semaphore enter_turnstile;
> +       struct semaphore exit_turnstile;
> +};
> +
> +static inline void task_barrier_signal_turnstile(struct semaphore *turnstile,
> +                                                unsigned int n)
> +{
> +       int i;
> +
> +       for (i = 0 ; i < n; i++)
> +               up(turnstile);
> +}
> +
> +static inline void task_barrier_init(struct task_barrier *tb)
> +{
> +       tb->n = 0;
> +       atomic_set(&tb->count, 0);
> +       sema_init(&tb->enter_turnstile, 0);
> +       sema_init(&tb->exit_turnstile, 0);
> +}
> +
> +static inline void task_barrier_add_task(struct task_barrier *tb)
> +{
> +       tb->n++;
> +}
> +
> +static inline void task_barrier_rem_task(struct task_barrier *tb)
> +{
> +       tb->n--;
> +}
> +
> +/*
> + * Lines up all the threads BEFORE the critical point.
> + *
> + * When all thread passed this code the entry barrier is back to locked state.
> + */
> +static inline void task_barrier_enter(struct task_barrier *tb)
> +{
> +       if (atomic_inc_return(&tb->count) == tb->n)
> +               task_barrier_signal_turnstile(&tb->enter_turnstile, tb->n);
> +
> +       down(&tb->enter_turnstile);
> +}
> +
> +/*
> + * Lines up all the threads AFTER the critical point.
> + *
> + * This function is used to avoid any one thread running ahead of the reset if
> + * the barrier is used in a loop (repeatedly) .
> + */
> +static inline void task_barrier_exit(struct task_barrier *tb)
> +{
> +       if (atomic_dec_return(&tb->count) == 0)
> +               task_barrier_signal_turnstile(&tb->exit_turnstile, tb->n);
> +
> +       down(&tb->exit_turnstile);
> +}
> +
> +static inline void task_barrier_full(struct task_barrier *tb)
> +{
> +       task_barrier_enter(tb);
> +       task_barrier_exit(tb);
> +}
> +
> +#endif
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
