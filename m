Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7781C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 07:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDDB20771
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 07:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZqLlsVf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDDB20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 792FA6E96B;
	Tue, 23 Jun 2020 07:49:19 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB036E935
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 00:05:27 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id u17so14168373qtq.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 17:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ZARmJJ7xCkdZZ2t8wNh4/tQvVIlLfUoBxGbPVnLj1no=;
 b=ZqLlsVf823WvkS6Pxei8NiC2W2IIsAJoQA2urO7e9M3j3n78WU8zuiQnBC/Hh13LQ7
 W82cIEkI8yK1kig27JBpN1A+kBTvdyfep2zqFSsRZ3bneYMoHddrECdeOHAhBx3jAggE
 8oQvGlZO4VuJSft8Izl2Bf/u/NJdZDmJmyKoVRcHZq2TKwggLrrOlhDeM/ysxoX7/Me3
 dqRCX3t0aoqiPb12yGgusjNMnEL8ewMvbu4zIi2lDYR1tedgzPmqU85hNdNt9mW7kpmp
 xuKIYdmxHb1ZwHUACc5P3GQ4w7GIm5gpp47skdgCpNYwfEX9eupQQgKd/elWzUh05kv2
 mhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZARmJJ7xCkdZZ2t8wNh4/tQvVIlLfUoBxGbPVnLj1no=;
 b=N79MoMk4cF5Bxpon03IXUQZ5OlWQ66yjtRDxfY1RICXJloR7B1BYmGNXY+GUmFQ99S
 rOUMk22oUa25oh/SLZJQcpDvpJZO9TCrYOKrATGqD+/z2crt1YQOa+NDmxqcKInKqca3
 w0RfAFiZhxw3szhnlfNyx8JE50ozRtj4j8yrmHjarqbqA+Te1E4whZ7wFK/lwoY/11Fm
 gAHZMGFg9NOdqdtz0JeZitoI7QH64jSmCsA96AuMHWQYa+yDN+ogvDgC291b5WSzWViG
 +SrKzx7CC4D7BAN7lPHyf3CF+Y+N6ggkp2Zu8oFmIkg4oQzyMV3so94WWOC6QZtpTJ3n
 Z1mg==
X-Gm-Message-State: AOAM532zwuolZtbEoo6Dn9yYUznYpgV+8YoZM8pVrLjrumiJsJiE+pdf
 SO/h9XQxUnu7uJmEoxiuN1f0VQ==
X-Google-Smtp-Source: ABdhPJybLGEC9Vkbo3afR1e0rkiE4Uqi81y09rG7Z316acKAzGcUboScxSHByPFqPGL4yR3GT9b3Ew==
X-Received: by 2002:ac8:279a:: with SMTP id w26mr18731669qtw.309.1592870726664; 
 Mon, 22 Jun 2020 17:05:26 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id n143sm1204192qkn.94.2020.06.22.17.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 17:05:26 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93) (envelope-from <jgg@ziepe.ca>)
 id 1jnWRJ-00CHPu-Cd; Mon, 22 Jun 2020 21:05:25 -0300
Date: Mon, 22 Jun 2020 21:05:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
Message-ID: <20200623000525.GX6578@ziepe.ca>
References: <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca>
 <20200619180935.GA10009@redhat.com>
 <20200619181849.GR6578@ziepe.ca>
 <20200619201011.GB13117@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200619201011.GB13117@redhat.com>
X-Mailman-Approved-At: Tue, 23 Jun 2020 07:49:16 +0000
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 19, 2020 at 04:10:11PM -0400, Jerome Glisse wrote:
 
> Maybe we can audit how user ptr buffer are use today and see if
> we can define a usage pattern that would allow to cut corner in
> kernel. For instance we could use mmu notifier just to block CPU
> pte update while we do GUP and thus never wait on dma fence.

The DMA fence is the main problem, if you can think of a way to avoid
it then it would be great!
 
> Then GPU driver just keep the GUP pin around until they are done
> with the page. They can also use the mmu notifier to keep a flag
> so that the driver know if it needs to redo a GUP ie:
> 
> The notifier path:
>    GPU_mmu_notifier_start_callback(range)
>         gpu_lock_cpu_pagetable(range)
>         for_each_bo_in(bo, range) {
>             bo->need_gup = true;
>         }
>         gpu_unlock_cpu_pagetable(range)

So some kind of invalidation tracking? But this doesn't solve COW and
Fork problem?

> > It is kind of unrelated to HMM, it just shouldn't be using mmu
> > notifiers to replace page pinning..
> 
> Well my POV is that if you abide by rules HMM defined then you do
> not need to pin pages. The rule is asynchronous device page table
> update.

I think one of the hmm rules is to not block notifiers for a long
time, which these scheme seem to violate already.

Pinning for a long time is less bad than blocing notifiers for a long
time, IMHO

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
