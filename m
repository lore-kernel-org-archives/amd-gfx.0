Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB75C11F69
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 12:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA4762300
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 12:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA4762300
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1F189DF7;
	Tue,  6 Jul 2021 12:23:48 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED0CA89DAB
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 12:23:46 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id n9so8512767wrs.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jul 2021 05:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=uNyqHLQRNkYk8ghNPCyy058MytEY7ye/Hosx5rgh6L0=;
 b=I861MRXnVEJLWhlPliO+jitKdknn/PB69GvRAM/Y4b8ranu/45I6eMeXTNi9dKuJ0j
 WYk89i6CPtBnGLN6nluhfnivHJjMYYzeqUVC8YHPJKGLDAkmLUXMmITr5S5TPlVgR6z+
 pWlut4ORszisRKb8vPQRzvBskW4VntzJL5DP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=uNyqHLQRNkYk8ghNPCyy058MytEY7ye/Hosx5rgh6L0=;
 b=ZhF0uCvIoVUu0Zqd2QGWMihrgwNpioeID9GHvj5MglkwUkgZhWo0W7xCKTQUbZX6GD
 eFIG6PcZGAGi7jSzTuQK5nkaa0jtBfDVD6BeI2gg/9NvbJjAgxoZOKNqvtCSRRviud+u
 +EWaglHJhNZ+DUBAzKCQCqVJaa1UDZPfygy0k2MC9DI5f7ZyUZqCFX+87GxxY0g8R8ox
 7mPUPo7Hl3oSt67mrsZAQXY7CIo0ixgwTjTYcFXYLolu1Bj+Vut8yRmqVxDv44Uy6iP9
 X+q4bTf1xQ87uGnhGKaAlRwPHrG083qN8tFH4oAZWi36QZDLoFK+eDpefNhwCNVs9TSI
 O98w==
X-Gm-Message-State: AOAM5333seR+itgx2ENW2OeclB6pjkwH12ewSs41Ds0px/lL0inOku61
 p72kFMe1aB9P1Y6RuC2i6dP91Q==
X-Google-Smtp-Source: ABdhPJxolizhwmybAQ3VsffOuvUoyS5FTxRrVw3O2VuBLsJFS1lJdSAYSr7mbyMR8j36zn3HCunCMA==
X-Received: by 2002:adf:a41e:: with SMTP id d30mr3249053wra.10.1625574225475; 
 Tue, 06 Jul 2021 05:23:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id 31sm18348673wrs.79.2021.07.06.05.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jul 2021 05:23:44 -0700 (PDT)
Date: Tue, 6 Jul 2021 14:23:42 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [Linaro-mm-sig] [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <YORLTmyoXDtoM9Ta@phenom.ffwll.local>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
 Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, sumit.semwal@linaro.org,
 christian.koenig@amd.com, galpress@amazon.com, sleybo@amazon.com,
 dri-devel@lists.freedesktop.org, jgg@ziepe.ca,
 linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
 dledford@redhat.com, airlied@gmail.com, alexander.deucher@amd.com,
 leonro@nvidia.com, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <20210706122110.GA18273@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210706122110.GA18273@lst.de>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
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
Cc: sleybo@amazon.com, linux-rdma@vger.kernel.org, gregkh@linuxfoundation.org,
 Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, galpress@amazon.com,
 linaro-mm-sig@lists.linaro.org, jgg@ziepe.ca, dledford@redhat.com,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, airlied@gmail.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, leonro@nvidia.com,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 06, 2021 at 02:21:10PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 06, 2021 at 10:40:37AM +0200, Daniel Vetter wrote:
> > > Greg, I hope this will be good enough for you to merge this code.
> > 
> > So we're officially going to use dri-devel for technical details review
> > and then Greg for merging so we don't have to deal with other merge
> > criteria dri-devel folks have?
> > 
> > I don't expect anything less by now, but it does make the original claim
> > that drivers/misc will not step all over accelerators folks a complete
> > farce under the totally-not-a-gpu banner.
> > 
> > This essentially means that for any other accelerator stack that doesn't
> > fit the dri-devel merge criteria, even if it's acting like a gpu and uses
> > other gpu driver stuff, you can just send it to Greg and it's good to go.
> > 
> > There's quite a lot of these floating around actually (and many do have
> > semi-open runtimes, like habanalabs have now too, just not open enough to
> > be actually useful). It's going to be absolutely lovely having to explain
> > to these companies in background chats why habanalabs gets away with their
> > stack and they don't.
> 
> FYI, I fully agree with Daniel here.  Habanlabs needs to open up their
> runtime if they want to push any additional feature in the kernel.
> The current situation is not sustainable.

Before anyone replies: The runtime is open, the compiler is still closed.
This has become the new default for accel driver submissions, I think
mostly because all the interesting bits for non-3d accelerators are in the
accel ISA, and no longer in the runtime. So vendors are fairly happy to
throw in the runtime as a freebie.

It's still incomplete, and it's still useless if you want to actually hack
on the driver stack.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
