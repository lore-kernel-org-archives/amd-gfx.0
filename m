Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE5C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 19:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C376206D5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 19:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw7ae4K+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C376206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A82A6E99A;
	Mon,  8 Jun 2020 19:46:42 +0000 (UTC)
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13FC89DB7;
 Mon,  8 Jun 2020 19:39:01 +0000 (UTC)
Received: by mail-lj1-x242.google.com with SMTP id 9so12376555ljv.5;
 Mon, 08 Jun 2020 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TVOtxpmeYOWD7rcQA6p6PVJsdwW/9XtVAfJ00067Jwk=;
 b=Uw7ae4K+D9tmeKHdEU38WOe4FsdhXp1ZnKr7YKUGixiQ9oWe2zUkZdxYWRFL5TGsGn
 +V9y94pvG0g5IXdQ2s4+PKu/NvK9GfJ5zCE2bQeGG95W+5y0fJ2+gTsk4k83rf03ItCJ
 kLC6qXpWbigmmVckNhVl6m270lucklRJQLrGoqZmdnWFsJKpGVxCkW4TqmwNSvOiG1BH
 d7soMSphupowplBAdx0AqVYwm0rmW0kE6W5xrmEBYPj5QQ0rsZtXxPEdj4xYSsQtECzW
 Nrs4lqroRuljEnV+wdWyUPdWz7xp5vspC1+LTQ3C15/rCfKQ54OQWj3k6b8s7vujTbBm
 A2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TVOtxpmeYOWD7rcQA6p6PVJsdwW/9XtVAfJ00067Jwk=;
 b=aocZlLd7JIFUqc9CQ/JYS9ysr/yWA6oVbxTquwZf7pe1sMuRj41tZRBPd9v00ojMW1
 KZyve7PI4ifEjb7MUqpgfN8hySjKiRvKBz+e/oNVIZWeOBYnOniIfomocMVxY9HyH+fG
 i9CsrfN0scgq7zTjdU/7QjVJcqq/EvK7iJy6DvZnq2dyirj7EZs/xTC0Jwi7C+pwIrBm
 Nuwo9AGUgqVMEd6QjA8e2v8yj9T8h4+oeuNODbC05DKlU4LzZN+fceMwON78N9qp+0P2
 ApdZzxmMghh8pcAmnK9FIflRE8VuesDaLEhuXDN85acscG7iQ2unfunqCc0WpUGsjOk4
 ImLA==
X-Gm-Message-State: AOAM531jwh0xZeTDhfQ/Pa1dFX4iVzQj8ME1Yw3gPsd3VvB8DMaGtebP
 vXxQz+k/LW8IbzGkA07RE6n9onIwCFR97WZql4c=
X-Google-Smtp-Source: ABdhPJzj7F/aaSi7HE9SPJMq1V4yr6hfoXBgPhFqPh91CbbkatR/Ryqmnw/QWzidGESYaRxTEW2Cmw1bqOyx6OoorZ0=
X-Received: by 2002:a2e:9147:: with SMTP id q7mr12642562ljg.430.1591645140048; 
 Mon, 08 Jun 2020 12:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <1590526802-3008-1-git-send-email-jrdr.linux@gmail.com>
 <69a033cf-63b2-7da6-6a5e-a5bbc94b8afb@nvidia.com>
 <20200527084852.GN206103@phenom.ffwll.local>
 <20200527085117.GO206103@phenom.ffwll.local>
 <aaf62285-981e-3753-5501-07bbba98fc36@nvidia.com>
 <CAFqt6zZVAQ3LKwud85LgHe9300xVjyGYXjvdWKTdezZA1uRewg@mail.gmail.com>
 <011353ca-39d5-a41d-477a-f67a47ebb47b@nvidia.com>
In-Reply-To: <011353ca-39d5-a41d-477a-f67a47ebb47b@nvidia.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Tue, 9 Jun 2020 01:08:48 +0530
Message-ID: <CAFqt6zZPh6RazWcwmfz1oXMbHaxMOtQtVU=Cgs79M9JG+PDrSg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Convert get_user_pages() --> pin_user_pages()
To: John Hubbard <jhubbard@nvidia.com>
X-Mailman-Approved-At: Mon, 08 Jun 2020 19:46:40 +0000
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
Cc: "Zhou, David\(ChunMing\)" <David1.Zhou@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx@lists.freedesktop.org, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 29, 2020 at 12:58 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-05-28 23:49, Souptick Joarder wrote:
> ...
> >> This is what case 3 was *intended* to cover, but it looks like case 3 needs to
> >> be written a little better. I'll attempt that, and Cc you on the actual patch
> >> to -mm. (I think we also need a case 5 for an unrelated scenario, too, so
> >> it's time.)
> >
> > There were no *case 5* in the other patch posted in -mm. Do we need to add it ?
> >
>
> Working on figuring that out [1], but it's not directly relevant to this thread.
> Maybe I shouldn't have brought it up here. :)
>
>
> [1] https://lore.kernel.org/r/20200529070343.GL14550@quack2.suse.cz
>
> thanks,
> John Hubbard
> NVIDIA
>
>
>

As this conversion is not relevant ( mentioned above), I have dropped
this patch.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
