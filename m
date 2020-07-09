Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97729C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 12:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F43C2074B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 12:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="PoAXES+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F43C2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 154506E077;
	Thu,  9 Jul 2020 12:11:25 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB43D6E0B8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 12:11:24 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id f18so1544296wml.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 05:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=76Pr5Imry6Y6+NQUV46pzWGDfBUpjBEUH8MLbXYDtq8=;
 b=PoAXES+V23Wh8eM1RMa1gjv7mPdB9CHvXYOhFE06xOw/lMwbG/HZ53PABoY8YaxIgs
 /ROsDCtb7CcSWl99Acc2lIZyw7vhas2ZIGL3Ki1AJDgM2rGMRUCDI/AexHfuV+OrjnL9
 topSv19nW8QIm2JsuBwLzSSpnHvj8hrxQXpLFQxSMcLqXF+fDV3ORupMLNE5TMh+r0OA
 Trg8XRN/fVokthVccXXppm7BJJEK3Jz9QMSYfIc/fW3D04yKmMZTU52iAFdp/4EmW3zi
 HGAW53jITOccHxT8InC62n+akeJnp3riy7+EacBJAzuqWSCYVf+xDufoR7bXUJg6y/oD
 z3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=76Pr5Imry6Y6+NQUV46pzWGDfBUpjBEUH8MLbXYDtq8=;
 b=gH2RFLTxABgiIi7X/E4oF7/+NuM5m7eDPSHPeovqoVj5B+4gBJGXyjMUusxt5vUxDi
 t9djsOTMOGaPB+xdTwSPuWWmhl2uL5AviMF51s128sIC4bEqQHEPCoKlbeeK+vf0rg5J
 uKE2I+VgmtGlisq4z6TgoU/doSNoBiRc+aoEjb6GRYuLgRqYnyHbQb1KymMAHeoCWCMu
 xkkujTUXXI0AFW7ktVa5h7aFy5+kyW1SqBtEdeh1rCH64+K5cyHKOiuN3xzFxAObaQHM
 m9KnQOXq+hw2yYIaxG5PSJQkvynCYvaRKdkxDqSdjlrUyl9z72kfrwf9zEjzIfiskeUM
 s4Pw==
X-Gm-Message-State: AOAM533IxraoFjsQwGSHrh9haoOZUpHNS+0WPJJhwSQLdfXbS6z0zmkY
 OcKUHfXJU0dtbgO/USiZLhyuZP5w035x4GygM3OtsA==
X-Google-Smtp-Source: ABdhPJxv2bOOBtwBiOGYgL5OIERVoKiGIkkOEtt5HovOBMNjbTSQatsMIYv39pPFy2HfkEl1IbeCaLvATVq/PpV25+k=
X-Received: by 2002:a1c:bdc3:: with SMTP id n186mr13815672wmf.84.1594296683336; 
 Thu, 09 Jul 2020 05:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <CAPj87rO4mm-+sQbP07cgM8-=b6Q8Jbh5G0FsV8rwYx2hnEzPkA@mail.gmail.com>
 <20200709080458.GO3278063@phenom.ffwll.local>
In-Reply-To: <20200709080458.GO3278063@phenom.ffwll.local>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 9 Jul 2020 13:11:12 +0100
Message-ID: <CAPj87rPtD04099=sBzL2jKN6NNFNnM-hH3qfOLL10nPoF==VbA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 03/25] dma-buf.rst: Document why idenfinite
 fences are a bad idea
To: Daniel Vetter <daniel@ffwll.ch>
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-rdma <linux-rdma@vger.kernel.org>,
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 9 Jul 2020 at 09:05, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Jul 09, 2020 at 08:36:43AM +0100, Daniel Stone wrote:
> > On Tue, 7 Jul 2020 at 21:13, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > > Comes up every few years, gets somewhat tedious to discuss, let's
> > > write this down once and for all.
> >
> > Thanks for writing this up! I wonder if any of the notes from my reply
> > to the previous-version thread would be helpful to more explicitly
> > encode the carrot of dma-fence's positive guarantees, rather than just
> > the stick of 'don't do this'. ;) Either way, this is:
>
> I think the carrot should go into the intro section for dma-fence, this
> section here is very much just the "don't do this" part. The previous
> patches have an attempt at encoding this a bit, maybe see whether there's
> a place for your reply (or parts of it) to fit?

Sounds good to me.

> > Acked-by: Daniel Stone <daniels@collabora.com>
> >
> > > What I'm not sure about is whether the text should be more explicit in
> > > flat out mandating the amdkfd eviction fences for long running compute
> > > workloads or workloads where userspace fencing is allowed.
> >
> > ... or whether we just say that you can never use dma-fence in
> > conjunction with userptr.
>
> Uh userptr is entirely different thing. That one is ok. It's userpsace
> fences or gpu futexes or future fences or whatever we want to call them.
> Or is there some other confusion here?.

I mean generating a dma_fence from a batch which will try to page in
userptr. Given that userptr could be backed by absolutely anything at
all, it doesn't seem smart to allow fences to rely on a pointer to an
mmap'ed NFS file. So it seems like batches should be mutually
exclusive between arbitrary SVM userptr and generating a dma-fence?

Speaking of entirely different things ... the virtio-gpu bit really
doesn't belong in this patch.

Cheers,
Daniel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
