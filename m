Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BE0C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 17:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3DEB10ED56;
	Mon, 20 Jun 2022 17:50:52 +0000 (UTC)
Received: from er-systems.de (er-systems.de [148.251.68.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE24510E032
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 14:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by er-systems.de (Postfix) with ESMTP id 88BC5D60070;
 Mon, 20 Jun 2022 16:31:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by er-systems.de (Postfix) with ESMTPS id 62462D6006D;
 Mon, 20 Jun 2022 16:31:26 +0200 (CEST)
Date: Mon, 20 Jun 2022 16:31:26 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Subject: Re: Performance drop using deinterlace_vaapi on 5.19-rcX
In-Reply-To: <6cd161d2-5caa-65c8-6b86-5992cc15d1af@amd.com>
Message-ID: <957926e6-2462-4c42-b57f-9cfbd9fe7024@lio96.de>
References: <0249066a-2e95-c21d-d16a-fba08c633c0b@lio96.de>
 <f1a52ddc-5aad-cc76-282e-93206ae43477@amd.com>
 <70395b22-1857-2a25-1472-17ce3df22607@lio96.de>
 <6cd161d2-5caa-65c8-6b86-5992cc15d1af@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-74181308-1760291136-1655735486=:7141"
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV
 0.103.6/26578/Mon Jun 20 10:06:11 2022 signatures .
X-Mailman-Approved-At: Mon, 20 Jun 2022 17:50:48 +0000
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---74181308-1760291136-1655735486=:7141
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 20 Jun 2022, Christian König wrote:

> Am 20.06.22 um 13:40 schrieb Thomas Voegtle:
>>  On Mon, 20 Jun 2022, Christian König wrote:
>>
>>>  Hi Thomas,
>>>
>>>  [moving vger to bcc]
>>>
>>>  mhm, sounds like something isn't running in parallel any more.
>>>
>>>  We usually don't test the multimedia engines for this but we do test
>>>  gfx+compute, so I'm really wondering what goes wrong here.
>>>
>>>  Could you run some tests for me? Additional to that I'm going to raise
>>>  that issue with our multimedia guys later today.
>>
>>  Yes, I can run some tests for you. Which tests?
>
> Try this as root:
>
> echo 1 > /sys/kernel/debug/tracing/events/dma_fence/dma_fence_init/enable
> echo 1 > /sys/kernel/debug/tracing/events/dma_fence/dma_fence_signaled/enable
> cat /sys/kernel/debug/tracing/trace_pipe > trace.log
>
> Then start the encoding in another shell, after it completed cancel the cat 
> with cntr+c and save the log file.
>
> Do this one with the old kernel and once with the new one.


    https://32h.de/tv/5.18.0-i5-trace.log.bz2
    https://32h.de/tv/5.19.0-rc3-i5-trace.log.bz2


I hope I have done this correctly.
All necessary tracing things switched on?

I want to add that this is a headless machine. No monitor connected.


---74181308-1760291136-1655735486=:7141--

