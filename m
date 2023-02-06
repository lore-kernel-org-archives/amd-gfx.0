Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16274C05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 15:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C9E10E3FE;
	Mon,  6 Feb 2023 15:39:44 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48B410E3FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 15:39:41 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4P9Vn60f2Sz9sZR;
 Mon,  6 Feb 2023 16:39:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1675697978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hY0JELLUsH4//WyYx1ylwhuc0BL4EFjdELuUbEY4rPA=;
 b=rb1q+4Z5EBNxWStlxpancErdl14iZgn7Lzre9a7Dny1g/E8Y21vKTztXDl0n1eT0c1TBKv
 83qmzbq/+4UCRIyE2uFyJ3A6YijYwj4mUh4YljqYKiMAU0MAfN1iMZZIPVpTvdALeJznF9
 p9T1KYJV/aBxGDUsR05bt1VgzWYVANQ3b4JYz6xBoKIUiL63t7/3L0nP6v2kjExDV9pMz1
 mmJTnnffgkmnGl0GuLtuXwBUD2aOBbr8LgDqX27A34P1IPFKlGt7t9TwYEWMwpcLu1/xxe
 xxGmTI1wH/u0VNUj432qks/aoLwZDnOGC57VdtBXWyCzXgn9eCSCqMgm5exUaw==
Message-ID: <1de90d3d-e1de-1540-6e28-1caa245bc474@mailbox.org>
Date: Mon, 6 Feb 2023 16:39:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/8] AMDGPU usermode queues
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230203215409.2021-1-shashank.sharma@amd.com>
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20230203215409.2021-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c8330b2ea7cc28204b3
X-MBO-RS-META: 3zn1ja9wgmoqb63pwbatbxqkej81q5nn
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
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2/3/23 22:54, Shashank Sharma wrote:
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
>   - A queue object to hold the workload packets.
>   - A read pointer object.
>   - A write pointer object.
>   - A doorbell page.
> - Kernel picks any 32-bit offset in the doorbell page for this queue.
> - The application uses the usermode_queue_create IOCTL introduced in
>   this patch, by passing the the GPU addresses of these objects (read
>   ptr, write ptr, queue base address and doorbell address)
> - The kernel creates the queue and maps it in the HW.
> - The application can start submitting the data in the queue as soon as
>   the kernel IOCTL returns.
> - Once the data is filled in the queue, the app must write the number of
>   dwords in the doorbell offset, and the GPU will start fetching the data.
> 
> libDRM changes for this series and a sample DRM test program can be found
> in the MESA merge request here:
> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287

I hope everyone's clear these libdrm_amdgpu changes won't be sufficient uAPI validation to allow the kernel bits to be merged upstream.

This will require an implementation in the Mesa radeonsi / RADV driver, ideally with working implicit synchronization for BOs shared via dma-buf.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

