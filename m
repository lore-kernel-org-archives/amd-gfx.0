Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046D4C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 17:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A366C61C56
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 17:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A366C61C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D6176E54C;
	Tue,  6 Jul 2021 17:30:35 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565B56E54C
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 17:28:30 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id h18so10144046qve.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jul 2021 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=px11FX2o2NfOVHHhqnYnIhPQRFcjzs1+EmS0dsyOJPw=;
 b=NF9XyW3fJY3iSvOKRIQQV+C9O8LDLzSL5nLvOmxEd2aIXF2R2INnN2ppJQUbhi6DTV
 bkLZ9RPPT44Eqt9TFVlwTbLNxtdPmHz8R3OsArM3R4sQi8ODLHQSjGR3OgBwMKyXtHNF
 K9ejcbRJRLCLTPyFEbwQzuBzfEgTPnMj6hMROdxPpkzmYY6xp0eWqzR8mSjb/sLAqfbB
 lSEkuCODAJl2x64EYiUVYfnC8YDK58ifVoE9B2fQ6/omp+mfhARrfLpa+fypn8XD9z9S
 kyOUZYLc41KEvRUUGGnMouFoGD5+qIuQ+IqsTll4iXp+lukaxhYtEoRakxbU44SzNWt/
 gwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=px11FX2o2NfOVHHhqnYnIhPQRFcjzs1+EmS0dsyOJPw=;
 b=QbR/i8EbR/ynrOS/LDZKFOd7dsKTpRaFqVJt1ExclKlS5yIkbtfLLftkdaHZ8IDq4T
 HkwaMsKN+lIOAsWgPXioBkERtTbtJpmNYPD+rhH0QecdbO36+7hbsDEWOvxXwBEIyMl0
 Aw1pTSwg/NWWpatfgzSHxe7EE+lskJKEGaUsZsUJwMbma1KGmuSkH0zn1KxOJ9bC8XI4
 /I0kElad/hnQU+7RSXHIN+d5YZiIJDWkxZsIFSyvqxqRfF9Z+HOzNAryw0raxrEc7jMN
 +G1migUhhCJvK7SYQ2TcS3R8b8xfMVJavDwMfuwqS82u64S6AfBK+Xoh2W3ySLfH6Hyl
 F5Jg==
X-Gm-Message-State: AOAM531oFpGAJ4D2YvId8RS0e9z2LYQ8tPSkq66/1un6riMurmRyZB4b
 SE4TfKN4zMzwxGXgCHH2l1oMng==
X-Google-Smtp-Source: ABdhPJy+jZYEROJ3qIspffgyVpxmDj4ZiVgCcQDd9MnAGWHJKAq+GyoBJWW0gIXqY5aoWofm1iZXqA==
X-Received: by 2002:a0c:eb8f:: with SMTP id x15mr19333838qvo.42.1625592509542; 
 Tue, 06 Jul 2021 10:28:29 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id g13sm5694745qtx.96.2021.07.06.10.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jul 2021 10:28:29 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1m0os0-004V5Z-2n; Tue, 06 Jul 2021 14:28:28 -0300
Date: Tue, 6 Jul 2021 14:28:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <20210706172828.GR4604@ziepe.ca>
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <CAFCwf10_rTYL2Fy6tCRVAUCf4-6_TtcWCv5gEEkGnQ0KxqMUBg@mail.gmail.com>
 <CAKMK7uEAJZUHNLreBB839BZOfnTGNU4rCx-0k55+67Nbxtdx3A@mail.gmail.com>
 <20210706142357.GN4604@ziepe.ca>
 <CAKMK7uELNzwUe+hhVWRg=Pk5Wt_vOOX922H48Kd6dTyO2PeBbg@mail.gmail.com>
 <20210706152542.GP4604@ziepe.ca>
 <CAKMK7uH7Ar6+uAOU_Sj-mf89V9WCru+66CV5bO9h-WAAv7Mgdg@mail.gmail.com>
 <CAKMK7uGvO0h7iZ3vKGe8GouESkr79y1gP1JXbfV82sRiaT-d1A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uGvO0h7iZ3vKGe8GouESkr79y1gP1JXbfV82sRiaT-d1A@mail.gmail.com>
X-Mailman-Approved-At: Tue, 06 Jul 2021 17:30:33 +0000
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>, Gal Pressman <galpress@amazon.com>,
 sleybo@amazon.com, linux-rdma <linux-rdma@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oded Gabbay <ogabbay@kernel.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Christoph Hellwig <hch@lst.de>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 06, 2021 at 06:07:17PM +0200, Daniel Vetter wrote:

> Also on your claim that drivers/gpu is a non-upstream disaster: I've
> also learned that that for drivers/rdma there's the upstream driver,
> and then there's the out-of-tree hackjob the vendor actually
> supports.

In the enterprise world everyone has their out of tree backport
drivers. It varies on the vendor how much deviation there is from the
upstream driver and what commercial support relationship the vendor
has with the enterprise distros.

> So seems to be about the same level of screwed up, if you ask the
> vendor they tell you the upstream driver isn't a thing they care about
> and it's just done for a bit of goodwill. 

Sounds like you should get a new RDMA supplier :)

To be fair Intel is getting better, they got their new RDMA HW support
merged into v5.14 after about 2 years in the out of tree world. Though
it is still incomplete compared to their out of tree driver, the gap
is much smaller now.

> amounts of volume, then suddenly it's an option ... Minus the fw issue
> for nvidia, upstream does support all the gpus you can buy right now
> and that can run on linux with some vendor driver (aka excluding apple
> M1 and ofc upcoming products from most vendors).

I would look at how many actual commercial systems are running the
upstream/inbox stack. I personally know of quite a few sites with big
HPC RDMA deployments running pure inbox kernels, no add on kernel
modules, with full commercial support.

If you can say that kind of arrangment is also common place in the GPU
world then I will happily be wrong.

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
