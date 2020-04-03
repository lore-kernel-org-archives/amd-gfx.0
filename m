Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB3DC2BA15
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 08:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DB12073B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 08:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gB0RAbdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DB12073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801D46E250;
	Fri,  3 Apr 2020 08:32:25 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F2F46E217
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 08:32:24 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id z7so6232599wmk.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2020 01:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=At8sSIc806Hse8GwwvxColRQIHchAyJQdaYFJ9Ur+6A=;
 b=gB0RAbdpuPmhDh8TNpLk/DY70NyY7rBNfqJZShUBaqz7mMfB0camm2aSyG8gakGNCk
 0FIHODl/UHaEoGbKjuAlJLB4Lu5/L8027QrXq70uSjBNI7QhJ439R24vEFGjk74QfKpT
 MmPwBk+uxaO/lmEJLi7PHzQ/x5UYrhv9yk5G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=At8sSIc806Hse8GwwvxColRQIHchAyJQdaYFJ9Ur+6A=;
 b=k723kB4NOZdhmRVF/RA7uZRZ7rwMle7/J0Ys3k9r/rf+pWEndqKR9a6YWDCOSJYLTK
 RIWknfW3Zavny4SZKIGiLoZxbToaiS9kK1mvpMef5FQudo1C5Qm6VyGKdyL3dM52G9WC
 /yx9dSKm/FHQa1B8s/fVBMe5bIXqco7/DvvfCSXY5o+WFYjvR+YGvsRKcWpbPZcf7ur4
 4NpuTVebM7hrlqXGnOfSFnZCy+W3yrTZmU4sZMNgVAXCH4F2b9zq4JavuW0c1zAEtpQz
 ZvjFgkmsXAIggc7yb2GGLBbBm+sT0cikytsUi0QZMfVHtsFx1TPfoQMdDcbTwFL20hks
 YQxw==
X-Gm-Message-State: AGi0PuaW39ATAey4IoipyTrT3lF+ufZZE2bQ6u2x8TAk3v4uODBRFTbG
 bU+Y8s8eQ8EPdlyKY3FQ7DZKZg==
X-Google-Smtp-Source: APiQypJHhwc18QFjz5o3a4OCVO6AhuKda1bPEwknUbs5tQxFuNFNLx4wX+t1pkklF2EaDAoWLRuXIw==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr7922848wma.83.1585902742891;
 Fri, 03 Apr 2020 01:32:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id f141sm10774114wmf.3.2020.04.03.01.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 01:32:22 -0700 (PDT)
Date: Fri, 3 Apr 2020 10:32:20 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Subject: Re: [PATCH 1/6] dma-buf: add peer2peer flag
Message-ID: <20200403083220.GT2363188@phenom.ffwll.local>
References: <20200330135536.2997-1-christian.koenig@amd.com>
 <20200401113446.GR2363188@phenom.ffwll.local>
 <14063C7AD467DE4B82DEDB5C278E8663FFFC63C1@fmsmsx107.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E8663FFFC63C1@fmsmsx107.amr.corp.intel.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
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
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 01, 2020 at 04:04:14PM +0000, Ruhl, Michael J wrote:
> >-----Original Message-----
> >From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
> >Daniel Vetter
> >Sent: Wednesday, April 1, 2020 7:35 AM
> >To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
> >Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org
> >Subject: Re: [PATCH 1/6] dma-buf: add peer2peer flag
> >
> >On Mon, Mar 30, 2020 at 03:55:31PM +0200, Christian K=F6nig wrote:
> >> Add a peer2peer flag noting that the importer can deal with device
> >> resources which are not backed by pages.
> >>
> >> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> >> ---
> >>  drivers/dma-buf/dma-buf.c |  2 ++
> >>  include/linux/dma-buf.h   | 10 ++++++++++
> >>  2 files changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> >> index ccc9eda1bc28..570c923023e6 100644
> >> --- a/drivers/dma-buf/dma-buf.c
> >> +++ b/drivers/dma-buf/dma-buf.c
> >> @@ -690,6 +690,8 @@ dma_buf_dynamic_attach(struct dma_buf *dmabuf,
> >struct device *dev,
> >>
> >>  	attach->dev =3D dev;
> >>  	attach->dmabuf =3D dmabuf;
> >> +	if (importer_ops)
> >> +		attach->peer2peer =3D importer_ops->allow_peer2peer;
> >
> >So an idea that crossed my mind to validate this, since we need quite so=
me
> >bad amounts of bad luck if someone accidentally introduces and access to
> >struct_page in sg lists in some slowpath.
> >
> >On map_sg, if ->peer2peer is set, we could mangle the struct_page
> >pointers, e.g. swap high bits for low bits (so that NULL stays NULL). On
> >unmap_sg we obviously need to undo that, in case the exporter needs those
> >pointers for its own book-keeping for some reason. I was also pondering
> >just setting them all to NULL, but that might break some exporters. With
> >the pointer mangling trick (especially if we flip high for low bits on 64
> >where this should result in invalid addresses in almost all cases) we
> >should be able to catch buggy p2p importers quite quickly.
> =

> The scatter list usage of the struct page pointer has other information i=
n the
> lower bits for keeping track of linking and other stuff.  Swizzling the p=
age
> pointers will probably make the scatter list unusable.

We'd need to swizzle only the pointers that are actual struct page
pointers. Plus keep the low bits as-is, and maybe only flip the top-most
60 bits or so. Doesn't break the idea fundamentally I think.
-Daniel

> =

> Mike
> =

> >Thoughts? Maybe add as a follow-up patch for testing?
> >-Daniel
> >>  	attach->importer_ops =3D importer_ops;
> >>  	attach->importer_priv =3D importer_priv;
> >>
> >> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> >> index 1ade486fc2bb..82e0a4a64601 100644
> >> --- a/include/linux/dma-buf.h
> >> +++ b/include/linux/dma-buf.h
> >> @@ -334,6 +334,14 @@ struct dma_buf {
> >>   * Attachment operations implemented by the importer.
> >>   */
> >>  struct dma_buf_attach_ops {
> >> +	/**
> >> +	 * @allow_peer2peer:
> >> +	 *
> >> +	 * If this is set to true the importer must be able to handle peer
> >> +	 * resources without struct pages.
> >> +	 */
> >> +	bool allow_peer2peer;
> >> +
> >>  	/**
> >>  	 * @move_notify
> >>  	 *
> >> @@ -362,6 +370,7 @@ struct dma_buf_attach_ops {
> >>   * @node: list of dma_buf_attachment, protected by dma_resv lock of t=
he
> >dmabuf.
> >>   * @sgt: cached mapping.
> >>   * @dir: direction of cached mapping.
> >> + * @peer2peer: true if the importer can handle peer resources without
> >pages.
> >>   * @priv: exporter specific attachment data.
> >>   * @importer_ops: importer operations for this attachment, if provided
> >>   * dma_buf_map/unmap_attachment() must be called with the dma_resv
> >lock held.
> >> @@ -382,6 +391,7 @@ struct dma_buf_attachment {
> >>  	struct list_head node;
> >>  	struct sg_table *sgt;
> >>  	enum dma_data_direction dir;
> >> +	bool peer2peer;
> >>  	const struct dma_buf_attach_ops *importer_ops;
> >>  	void *importer_priv;
> >>  	void *priv;
> >> --
> >> 2.17.1
> >>
> >
> >--
> >Daniel Vetter
> >Software Engineer, Intel Corporation
> >http://blog.ffwll.ch
> >_______________________________________________
> >dri-devel mailing list
> >dri-devel@lists.freedesktop.org
> >https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
