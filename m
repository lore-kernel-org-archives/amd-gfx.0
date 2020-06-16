Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81902C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 15:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA37208B3
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 15:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cDN3DzBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA37208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EBB26E8EB;
	Tue, 16 Jun 2020 15:24:46 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95BBA89930
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 14:53:14 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id p15so9598162qvr.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=H9Q21GJcnralnv81ky+DYZCuyhzGkXe+xlvLrhcRUVI=;
 b=cDN3DzBNq5d3CrdALYsiOTFh73YRcI8lQ7uTSznJPv8dAJPnHjJPQR57lcTVwcL/Fu
 tV3NTbV5GNoBVgT5Y9FK7M+PwBjksAzlKvZZnxf+Qkd/PqTbrIdNSIbQI4xY6GgG5IkN
 2i29pdJFycDxjY2QVTv0QiEB95VIbTnGIGt0UTkJ1Csd3R+WgZXFN5sle6nrM8u0InPD
 03ylAeGN5+aJZmvaChOTyf6V/AGcN+wyw9nUErW3py9ORSzNIR2Kd+m+VbjIZ7U5Y8CF
 +bk0T6Aw1wPbeMExKzclzBgPz36VephSSjSjX1HFVeLmX9lSoGuhN4yVL+U6sHPpHMa8
 lzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H9Q21GJcnralnv81ky+DYZCuyhzGkXe+xlvLrhcRUVI=;
 b=ryXR5z5gNxZBFWmfJCE0gvli0/PZgaEVAPEx5qeA70ESKVPeRJ8LMaFV5RnEvgTArg
 SeVGUfiNAdW6iBJnzVGfX0TMPCLHz3JZPyMNn1PfUTpvEb8yUEU9yXfQcMX+B9GVzLpU
 xNH0QANtaLA2K3rsDLYO5MevQy+zfTS4eDrLLYeCtKkbcizVkS9tagB3OkYls7y4O8bj
 Y1Fux0i+FZhrLrP2OwdPkX5plOGmKAtjEQmxpdLVj5l6mTWNJJ+hlTsuqc5Ozvg1dqKd
 Qxqi7oOtaFJ3XeR6tYSwY/rvVFNl6r1+0mJyL8Fs6mco0HHtyqKo4eu4oJbKrkRcbxUL
 adLQ==
X-Gm-Message-State: AOAM53221tBTZuMo3TLbgnhsKDMRoQINeswmPM8joywt9YvMazlo5h69
 J291+Y/ceLibmtKjo9wTtTsWng==
X-Google-Smtp-Source: ABdhPJzP5DGSQb5Sh+luEoCiwZvsmX+7FP3MYwRCXpBsltvvGKDh3l1qc0mmf+FYXhbSQFkMBoXxZQ==
X-Received: by 2002:a0c:e9cd:: with SMTP id q13mr2731630qvo.23.1592319193724; 
 Tue, 16 Jun 2020 07:53:13 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id g9sm14433034qtq.66.2020.06.16.07.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 07:53:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93) (envelope-from <jgg@ziepe.ca>)
 id 1jlCxc-0096j7-MB; Tue, 16 Jun 2020 11:53:12 -0300
Date: Tue, 16 Jun 2020 11:53:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= <thomas_os@shipmail.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 linux-rdma@vger.kernel.org,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org,
 Thomas Hellstrom <thomas.hellstrom@intel.com>,
 Daniel Vetter <daniel.vetter@intel.com>, linux-media@vger.kernel.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
Message-ID: <20200616145312.GC6578@ziepe.ca>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local>
 <20200611141515.GW6578@ziepe.ca>
 <20200616120719.GL20149@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200616120719.GL20149@phenom.ffwll.local>
X-Mailman-Approved-At: Tue, 16 Jun 2020 15:24:44 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 16, 2020 at 02:07:19PM +0200, Daniel Vetter wrote:
> > > I've pinged a bunch of armsoc gpu driver people and ask them how much this
> > > hurts, so that we have a clear answer. On x86 I don't think we have much
> > > of a choice on this, with userptr in amd and i915 and hmm work in nouveau
> > > (but nouveau I think doesn't use dma_fence in there). 
> > 
> > Right, nor will RDMA ODP. 
> 
> Hm, what's the context here? I thought RDMA side you really don't want
> dma_fence in mmu_notifiers, so not clear to me what you're agreeing on
> here.

rdma does not use dma_fence at all, and though it is hard to tell, I
didn't notice a dma_fence in the nouveau invalidation call path.

At the very least I think there should be some big warning that
dma_fence in notifiers should be avoided.

Ie it is strange that the new totally-not-a-gpu drivers use dma_fence,
they surely don't have the same constraints as the existing GPU world,
and it would be annoying to see dma_fence notifiers spring up in them

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
