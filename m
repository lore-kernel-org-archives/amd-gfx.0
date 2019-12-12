Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E887EC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 08:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84112077B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 08:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCdLly/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84112077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893996ECAB;
	Thu, 12 Dec 2019 08:25:09 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15FC56ECAB
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 08:25:08 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id q9so1310054wmj.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 00:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=euwi9F/9uy8gSW7G3XvaafacXRnNYxLGikolRd4jKco=;
 b=TCdLly/2D6fDabl/nIvdsPtWHJH4bvo2KN6zfOeZUXLpf2/YLNT1ZdsMwBl+MzM0Hg
 92Vgc/m7q6LJBgs973uRWJAPAgLTCohHfg+gEUgJGDIIhw+Rflqukol14xjmFql7zV1C
 hq6GQRA4CzwUULpYQTaCWg4vvEWhcpI/+9dB38caXQijCyXWmgdPQxjMJkiqAhagrKbx
 rlwNj7eQOaYwnbtye3iOGURrthMCAWsSyPf5TCTNLsxkJ5vXXFszkdTnSOqlYSulmlfe
 egBmoTdQbvcozhUxp/rGFWLvvk6djs7YDzoPYEXNzFw4KzY1jVMpvvs3/sQ1IaPTkl0X
 Hc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=euwi9F/9uy8gSW7G3XvaafacXRnNYxLGikolRd4jKco=;
 b=HLrEkfj2QdHX7ruceDWfZIMVvieehLIDT32ikmLWudBeUZfu1ipe35jXt4DwrBFP3M
 GwBEbdzYZ+BLJt/EQPT8+yA45PubRc2okl6u9m5+l1J6soPh121xsloR96KrfKaghbVX
 n3272fYQoE4mH70I6sHMhs9p90X5ChENLItG0Zd5wHGYz7poE+cDnhIhjbEcCH9hCIcv
 BYqDv4/uWQV01P0vdvQKhGTaSfJUu0sS9BdVUby91e0dvZL+YxkufRGdv1f7qpQcE6T7
 Ev95MTqFf/V0rtytSRHWimE9PyHTZFje3BVMJMQap5qdroD7ZMm7eGmFuurFqDmPzcdU
 3e4w==
X-Gm-Message-State: APjAAAW69LpgIyvqhdaP5+g4mYYpjSUC6DpRH4/wlVnz7EBegnNiGBkN
 NXy5wtwPURk25trUO1BNe/o=
X-Google-Smtp-Source: APXvYqwI0nvpcAWNvQiVgo0on93zOP2MSZFReCoxnfQ17Wx9gGQcFBI9ZmYyuGlIl7DeEFDxyuZEEg==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr5073463wmi.31.1576139106580; 
 Thu, 12 Dec 2019 00:25:06 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t1sm5440973wma.43.2019.12.12.00.25.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 00:25:05 -0800 (PST)
Subject: Re: [PATCH 2/5] drm: Add Reusable task barrier.
To: Alex Deucher <alexdeucher@gmail.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
References: <1576094829-2245-1-git-send-email-andrey.grodzovsky@amd.com>
 <1576094829-2245-2-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_OCzqh_t5YHithp2Kh0rxHsk4XxnfHm-Cm2_T7ZGSA4Ow@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2b12b91a-e40f-25f4-bc7c-71566ffdabd4@gmail.com>
Date: Thu, 12 Dec 2019 09:24:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_OCzqh_t5YHithp2Kh0rxHsk4XxnfHm-Cm2_T7ZGSA4Ow@mail.gmail.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Le.Ma" <Le.Ma@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.12.19 um 21:19 schrieb Alex Deucher:
> On Wed, Dec 11, 2019 at 3:07 PM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>> It is used to synchronize N threads at a rendevouz point before execution
>> of critical code that has to be started by all the threads at approximatly
>> the same time.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> You should resend to dri-devel since this task barrier is being added
> to common code.

Additional to that this whole thing has the potential to raise lockdep 
warnings and if I'm not completely mistaken doesn't even work correctly.

See Linux kernel semaphores don't allow negative values (the count field 
in struct semaphore is unsigned).

Regards,
Christian.

>
> Alex
>
>> ---
>>   include/drm/task_barrier.h | 106 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 106 insertions(+)
>>   create mode 100644 include/drm/task_barrier.h
>>
>> diff --git a/include/drm/task_barrier.h b/include/drm/task_barrier.h
>> new file mode 100644
>> index 0000000..81fb0f7
>> --- /dev/null
>> +++ b/include/drm/task_barrier.h
>> @@ -0,0 +1,106 @@
>> +/*
>> + * Copyright 2019 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +#include <linux/semaphore.h>
>> +#include <linux/atomic.h>
>> +
>> +/*
>> + * Reusable 2 PHASE task barrier (randevouz point) implementation for N tasks.
>> + * Based on the Little book of sempahores - https://greenteapress.com/wp/semaphores/
>> + */
>> +
>> +
>> +
>> +#ifndef DRM_TASK_BARRIER_H_
>> +#define DRM_TASK_BARRIER_H_
>> +
>> +/*
>> + * Represents an instance of a task barrier.
>> + */
>> +struct task_barrier {
>> +       unsigned int n;
>> +       atomic_t count;
>> +       struct semaphore enter_turnstile;
>> +       struct semaphore exit_turnstile;
>> +};
>> +
>> +static inline void task_barrier_signal_turnstile(struct semaphore *turnstile,
>> +                                                unsigned int n)
>> +{
>> +       int i;
>> +
>> +       for (i = 0 ; i < n; i++)
>> +               up(turnstile);
>> +}
>> +
>> +static inline void task_barrier_init(struct task_barrier *tb)
>> +{
>> +       tb->n = 0;
>> +       atomic_set(&tb->count, 0);
>> +       sema_init(&tb->enter_turnstile, 0);
>> +       sema_init(&tb->exit_turnstile, 0);
>> +}
>> +
>> +static inline void task_barrier_add_task(struct task_barrier *tb)
>> +{
>> +       tb->n++;
>> +}
>> +
>> +static inline void task_barrier_rem_task(struct task_barrier *tb)
>> +{
>> +       tb->n--;
>> +}
>> +
>> +/*
>> + * Lines up all the threads BEFORE the critical point.
>> + *
>> + * When all thread passed this code the entry barrier is back to locked state.
>> + */
>> +static inline void task_barrier_enter(struct task_barrier *tb)
>> +{
>> +       if (atomic_inc_return(&tb->count) == tb->n)
>> +               task_barrier_signal_turnstile(&tb->enter_turnstile, tb->n);
>> +
>> +       down(&tb->enter_turnstile);
>> +}
>> +
>> +/*
>> + * Lines up all the threads AFTER the critical point.
>> + *
>> + * This function is used to avoid any one thread running ahead of the reset if
>> + * the barrier is used in a loop (repeatedly) .
>> + */
>> +static inline void task_barrier_exit(struct task_barrier *tb)
>> +{
>> +       if (atomic_dec_return(&tb->count) == 0)
>> +               task_barrier_signal_turnstile(&tb->exit_turnstile, tb->n);
>> +
>> +       down(&tb->exit_turnstile);
>> +}
>> +
>> +static inline void task_barrier_full(struct task_barrier *tb)
>> +{
>> +       task_barrier_enter(tb);
>> +       task_barrier_exit(tb);
>> +}
>> +
>> +#endif
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
