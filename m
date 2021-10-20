Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B20C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 17:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67DE06138B
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 17:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67DE06138B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFF06E321;
	Wed, 20 Oct 2021 17:25:41 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E21589DDF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 17:12:46 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id 75so23119748pga.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 10:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yh4VNQVbmqEE1XoY0HfdKCiOCUMZEFg9p2e4mySh1ho=;
 b=gXp+nm6KP18UxdU9Hk3ApH1mhWLfoJo59VGT/uI2ErBwWWyik4nmEDpSY+ZrwJRKsD
 1m2G6rHPn7W/JZ+E3tckd4iJSTd6DrCA1haY52Re29y61eWHiifpVeHfZXxxVG0OyAIG
 SNKtPfTbbylxqWGsIA6ibBarKTRo4H14iXLyBREaAXG+H2DN8uhwtgKoCeWK8woL61v/
 h3zf1b5/RLytsJ/EioaqOo91sbl+0/PnLuBJrtfYdYpnEHnps1RtQHpp6zHlZvn6BAf5
 ILV5/M+yMBS3ApNMZ1KgMy5ldAYTELk9W2MzVGpH+zHnvMYELSkCHHRjl7R71WGss/j1
 /9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yh4VNQVbmqEE1XoY0HfdKCiOCUMZEFg9p2e4mySh1ho=;
 b=mfH241IIBT18SHGyU7gPaz+CKOFSo5Mmx8El/+OXgs6AlIGc829hJBrv3g8+ERrx0O
 fe2rKvnshDIDPKzgWM8eMc3uzqSgpGdHsA/yvMtmb6TYqJWaY+mGRrFO9G46FWPc/s8y
 d4WCnzgVdi8DG/aGB4PzEdAq1N9sY1uk3u0UQvtCgNtRPUXnBWnV34ihhfxnc63Qlxy+
 hIedeDaZLjRvLrbv+cd1f3qJErZOGKwlYqx8uLVt/bzrvaPa2xFb00q9AQ52pdnRsc/F
 3x6uCVGXbC9Nkpor6whIFYrkVt7J+68Ltn5PcBDvZDAzBhoOUfc6kyP+2RmYoNK2PcNb
 BhAQ==
X-Gm-Message-State: AOAM533jyB2EanCtbzMXNxU42G/ZspRcC12UA7/pMOrKBFulm8TgY3MW
 Mt3K2nkMBvb7iAEi1E5RqCajggl+C3FI8aKnprYzVQ==
X-Google-Smtp-Source: ABdhPJwX0GE82e3GMz46Z+6E2d1Wq5pKde1k4jJ2mpNNK8H935nRo76Hn1Yb+qZii2GkvCfouy2IWMMOT+HKVGAV2+o=
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr388190pge.5.1634749965551;
 Wed, 20 Oct 2021 10:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <YWh6PL7nvh4DqXCI@casper.infradead.org>
 <CAPcyv4hBdSwdtG6Hnx9mDsRXiPMyhNH=4hDuv8JZ+U+Jj4RUWg@mail.gmail.com>
 <20211014230606.GZ2744544@nvidia.com>
 <CAPcyv4hC4qxbO46hp=XBpDaVbeh=qdY6TgvacXRprQ55Qwe-Dg@mail.gmail.com>
 <20211016154450.GJ2744544@nvidia.com>
 <CAPcyv4j0kHREAOG6_07E2foz6e4FP8D72mZXH6ivsiUBu_8c6g@mail.gmail.com>
 <20211018182559.GC3686969@ziepe.ca>
 <CAPcyv4jvZjeMcKLVuOEQ_gXRd87i3NUX5D=MmsJ++rWafnK-NQ@mail.gmail.com>
 <20211018230614.GF3686969@ziepe.ca>
 <499043a0-b3d8-7a42-4aee-84b81f5b633f@oracle.com>
 <20211019160136.GH3686969@ziepe.ca>
 <CAPcyv4gmvxi5tpT+xgxPLMPGZiLqKsft_5PzpMQZ-aCvwpbCvw@mail.gmail.com>
 <a82a1307-938b-eaf1-cf3d-b9dc76215636@oracle.com>
In-Reply-To: <a82a1307-938b-eaf1-cf3d-b9dc76215636@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 20 Oct 2021 10:12:35 -0700
Message-ID: <CAPcyv4g7+FTNi-vFvx_3qzrosTSET6nPc=ozdxs=p1dm0hBJtg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm: remove extra ZONE_DEVICE struct page refcount
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Matthew Wilcox <willy@infradead.org>,
 Alex Sierra <alex.sierra@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, 
 Linux MM <linux-mm@kvack.org>, Ralph Campbell <rcampbell@nvidia.com>, 
 linux-ext4 <linux-ext4@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@lst.de>, 
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
 Alistair Popple <apopple@nvidia.com>, Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Linux NVDIMM <nvdimm@lists.linux.dev>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 20 Oct 2021 17:25:40 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 20, 2021 at 10:09 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 10/19/21 20:21, Dan Williams wrote:
> > On Tue, Oct 19, 2021 at 9:02 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>
> >> On Tue, Oct 19, 2021 at 04:13:34PM +0100, Joao Martins wrote:
> >>> On 10/19/21 00:06, Jason Gunthorpe wrote:
> >>>> On Mon, Oct 18, 2021 at 12:37:30PM -0700, Dan Williams wrote:
> >>>>
> >>>>>> device-dax uses PUD, along with TTM, they are the only places. I'm not
> >>>>>> sure TTM is a real place though.
> >>>>>
> >>>>> I was setting device-dax aside because it can use Joao's changes to
> >>>>> get compound-page support.
> >>>>
> >>>> Ideally, but that ideas in that patch series have been floating around
> >>>> for a long time now..
> >>>>
> >>> The current status of the series misses a Rb on patches 6,7,10,12-14.
> >>> Well, patch 8 too should now drop its tag, considering the latest
> >>> discussion.
> >>>
> >>> If it helps moving things forward I could split my series further into:
> >>>
> >>> 1) the compound page introduction (patches 1-7) of my aforementioned series
> >>> 2) vmemmap deduplication for memory gains (patches 9-14)
> >>> 3) gup improvements (patch 8 and gup-slow improvements)
> >>
> >> I would split it, yes..
> >>
> >> I think we can see a general consensus that making compound_head/etc
> >> work consistently with how THP uses it will provide value and
> >> opportunity for optimization going forward.
> >>
>
> I'll go do that. Meanwhile, I'll wait a couple days for Dan to review the
> dax subsystem patches (6 & 7), or otherwise send them over.
>
> >>> Whats the benefit between preventing longterm at start
> >>> versus only after mounting the filesystem? Or is the intended future purpose
> >>> to pass more context into an holder potential future callback e.g. nack longterm
> >>> pins on a page basis?
> >>
> >> I understood Dan's remark that the device-dax path allows
> >> FOLL_LONGTERM and the FSDAX path does not ?
> >>
> >> Which, IIRC, today is signaled basd on vma properties and in all cases
> >> fast-gup is denied.
> >
> > Yeah, I forgot that 7af75561e171 eliminated any possibility of
> > longterm-gup-fast for device-dax, let's not disturb that status quo.
> >
> I am slightly confused by this comment -- the status quo is what we are
> questioning here -- And we talked about changing that in the past too
> (thread below), that longterm-gup-fast was an oversight that that commit
> was only applicable to fsdax. [Maybe this is just my english confusion]

No, you have it correct. However that "regression" has gone unnoticed,
so unless there is data showing that gup-fast on device-dax is
critical for longterm page pinning workflows I'm ok for longterm to
continue to trigger gup-slow.
