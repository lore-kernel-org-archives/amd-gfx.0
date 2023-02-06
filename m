Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D79C636CC
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 00:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EB5C10E0CA;
	Mon,  6 Feb 2023 00:52:42 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F8A710E0CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 00:52:40 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id mc11so29899818ejb.10
 for <amd-gfx@lists.freedesktop.org>; Sun, 05 Feb 2023 16:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nEh25UqBzxlaKGe/hhdqXbA4ekp5/vn/kyTtqBtN2Cc=;
 b=kGQFi1eyA4oBbmU6KWU/Hj9DN4F/iaxb6a+ldUUAq0oFwJQGOeOQsZ5NFH42lN/2j0
 mmj7AGCSkBC0a9ge2buIwVVw2QkPSAJSKMf9/zHWTrVVN2U8QxzlqkIFF6zLkPv928KH
 luTQJ7gGlQdNzS+mpupFmR8j69qP1OFkSjzwRfaCzYcmPO4r15jVXO4Jd+DC22t1aboY
 vYz9N/Kheuvi6qpTijsfEj4Nv1GY3DOfLd5CrqEovqhp+blsmP/Q0ztM5T8geGTZfoHm
 FcJpvsVacxdicKjE6LM/uMp+C2vKV7I1HLNbKYY+7GN11KMQY8TtpbopZvgZYTqsad7F
 5wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nEh25UqBzxlaKGe/hhdqXbA4ekp5/vn/kyTtqBtN2Cc=;
 b=REYbfzU1erveXVZoYQTWQ5KotAxjJEelVHlJEH/zu+6n1/Q14KDy7Nou3wYa/Rvk5D
 3sgHSnUPch65T5p+J1xpMQIJS4Vk6e8DN81cyXQGT63BD+L3vdnsOkBWgQBgdAO9zr9N
 nC0lhPAIKdWqesSFAiax7IOfRaN5drjfTjRz82zom1I87LyLpwFdjplJcM58fUBGcZwT
 jufisKiMHu2ZW9cXCZCO74GXMFgCM980J2RLh7mSuO58US9WhtgTdm2BiNBFMBUsFU9m
 BrInAR837Y2zlXtSdFajzh9QfGb/Z/2Qm06GdSzTjG9k5s1GH7hYz0KTXaRDhYMbeqol
 fwjQ==
X-Gm-Message-State: AO0yUKXP6HAOCfgJnZiZd/E/sgoeJufwgV178aP9GBIiSuWx8QmRTUn9
 E3A1JJQPCZbvQ8RDimbXkegmwOVG7HBDsdh9k1cf488bsRU=
X-Google-Smtp-Source: AK7set9Wn8XwdcZU6Eejdr/1mQ6PYS1R/9hhy49cagL3B29XtE7Oth2FkCrjRWo+/aUiyxxHRewWvo0apGa6w/5HVIU=
X-Received: by 2002:a17:907:2c4f:b0:8a5:8539:aaac with SMTP id
 hf15-20020a1709072c4f00b008a58539aaacmr114996ejc.304.1675644758919; Sun, 05
 Feb 2023 16:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20230203215409.2021-1-shashank.sharma@amd.com>
In-Reply-To: <20230203215409.2021-1-shashank.sharma@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 6 Feb 2023 10:52:26 +1000
Message-ID: <CAPM=9tzTKj3M_tKiwvSyN+jKsYFbE2yRvjgMkZGmGdUWabnwiA@mail.gmail.com>
Subject: Re: [PATCH 0/8] AMDGPU usermode queues
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, 4 Feb 2023 at 07:54, Shashank Sharma <shashank.sharma@amd.com> wrote:
>
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch series introduces AMDGPU usermode graphics queues.
> User queues is a method of GPU workload submission into the graphics
> hardware without any interaction with kernel/DRM schedulers. In this
> method, a userspace graphics application can create its own workqueue
> and submit it directly in the GPU HW.
>
> The general idea of how this is supposed to work:
> - The application creates the following GPU objetcs:
>   - A queue object to hold the workload packets.
>   - A read pointer object.
>   - A write pointer object.
>   - A doorbell page.
> - Kernel picks any 32-bit offset in the doorbell page for this queue.
> - The application uses the usermode_queue_create IOCTL introduced in
>   this patch, by passing the the GPU addresses of these objects (read
>   ptr, write ptr, queue base address and doorbell address)
> - The kernel creates the queue and maps it in the HW.
> - The application can start submitting the data in the queue as soon as
>   the kernel IOCTL returns.
> - Once the data is filled in the queue, the app must write the number of
>   dwords in the doorbell offset, and the GPU will start fetching the data.

So I just have one question about forward progress here, let's call it
the 51% of VRAM problem.

You have two apps they both have working sets that allocate > 51% of VRAM.

Application (a) has the VRAM and mapping for the user queues and is
submitting work
Application (b) wants to submit work, it has no queue mapping as it
was previously evicted, does (b) have to call an ioctl to get it's
mapping back?
When (b) calls the ioctl (a) loses it mapping. Control returns to (b),
but before it submits any work on the ring mapping it has, (a) gets
control and notices it has no queues, so calls the ioctl, and (b)
loses it mapping, and around and around they go never making forward
progress.

What's the exit strategy for something like that, fall back to kernel
submit so you can get a memory objects validated and submit some work?

Dave.
