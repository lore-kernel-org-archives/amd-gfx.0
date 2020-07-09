Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A3EC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 08:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFE22070E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 08:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QyjKYLKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFE22070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0D66EA02;
	Thu,  9 Jul 2020 08:05:04 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C106E9FA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 08:05:02 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z15so1305380wrl.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 01:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AanOntssHVq3a/hYYgiJ/Jv7xDYr/XO47TZ8dJKYOfg=;
 b=QyjKYLKao++0SSyM8aZCwczNT2pFyNkKc2p4ZpEv62WkcG5eiz8JDGaPiwT0/ggzaJ
 IR6p/K6ncIihYsmMMWOKwTm0qCVQDwj5lpl4+j+HohoTFt1N0thAtJPAhqzP1GKvD0DT
 mDeEZ/WxXGFFx6EGFzPhTWq2CTko4+6fvnpQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AanOntssHVq3a/hYYgiJ/Jv7xDYr/XO47TZ8dJKYOfg=;
 b=njeWF3m/J6bfmWE9xFP+LLKEj1SCE4g7Rv3CmdcsAXT/QOqEqmEzN0+IdlDmgXRi9M
 9ya4q/gnpG0tSLLbc97HvW7iL7YQKMUYvuvQqYHLVdTbCdXz7fpAhJ0oqktx62FnawsW
 vFDT/TdaaprqRKwrZr7csudczHR7/YTORCzbl+BsGnIrdJWdtO4/FyluwhPVWC1nvpAf
 vWxFfViEYfIHfaUESP1hluEQrGVu7oAEVhMFAG/rL3A+UPtotbeNWySZAZIIWhJvvdPj
 7qr1hu0oYeUIHHrdqW84fxgTzafMhGNsMdSOZtIuc2GW7txHNiDOrzM7pRcfFt/bgjuv
 DUaQ==
X-Gm-Message-State: AOAM532vP6TyTigT5y050iM2Z6BMuwV8A9BeHLQp2b/D9ijqPch3klzT
 tE5V+8tmZ9T34/BAldD37RAxpQ==
X-Google-Smtp-Source: ABdhPJxO7RoS+ijbjhDgz9IHsX93bEVBPBQ5YAnvnMKF0T6MTWfNzI57IiCMoHlxMz1reth22NnRpA==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr61603577wrt.108.1594281901314; 
 Thu, 09 Jul 2020 01:05:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id v12sm4179709wrt.31.2020.07.09.01.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 01:05:00 -0700 (PDT)
Date: Thu, 9 Jul 2020 10:04:58 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Daniel Stone <daniel@fooishbar.org>
Subject: Re: [Intel-gfx] [PATCH 03/25] dma-buf.rst: Document why idenfinite
 fences are a bad idea
Message-ID: <20200709080458.GO3278063@phenom.ffwll.local>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <CAPj87rO4mm-+sQbP07cgM8-=b6Q8Jbh5G0FsV8rwYx2hnEzPkA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPj87rO4mm-+sQbP07cgM8-=b6Q8Jbh5G0FsV8rwYx2hnEzPkA@mail.gmail.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, linux-rdma@vger.kernel.org,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Steve Pronovost <spronovo@microsoft.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Jesse Natalie <jenatali@microsoft.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 09, 2020 at 08:36:43AM +0100, Daniel Stone wrote:
> Hi,
> 
> On Tue, 7 Jul 2020 at 21:13, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > Comes up every few years, gets somewhat tedious to discuss, let's
> > write this down once and for all.
> 
> Thanks for writing this up! I wonder if any of the notes from my reply
> to the previous-version thread would be helpful to more explicitly
> encode the carrot of dma-fence's positive guarantees, rather than just
> the stick of 'don't do this'. ;) Either way, this is:

I think the carrot should go into the intro section for dma-fence, this
section here is very much just the "don't do this" part. The previous
patches have an attempt at encoding this a bit, maybe see whether there's
a place for your reply (or parts of it) to fit?

> Acked-by: Daniel Stone <daniels@collabora.com>
> 
> > What I'm not sure about is whether the text should be more explicit in
> > flat out mandating the amdkfd eviction fences for long running compute
> > workloads or workloads where userspace fencing is allowed.
> 
> ... or whether we just say that you can never use dma-fence in
> conjunction with userptr.

Uh userptr is entirely different thing. That one is ok. It's userpsace
fences or gpu futexes or future fences or whatever we want to call them.
Or is there some other confusion here?.
-Daniel


> 
> Cheers,
> Daniel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
