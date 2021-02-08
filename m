Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28942C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 10:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2A064E3F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 10:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2A064E3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C750F89B8F;
	Mon,  8 Feb 2021 10:11:52 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 119EA89A61
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Feb 2021 10:11:51 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id r21so122386wrr.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Feb 2021 02:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=A9XtSLIM2qv0sdY1ObMG2vMTkKJWol/5PG6aDpPhXD4=;
 b=INmD6dcGbZ3z/gl1OgxIq8nZ1OH72SM7E7COM02HdS8iRCWaKI4u5pz5bbgPvuOLYI
 EQHpZPc7cwbYXKGw3FNdMYPGzgutx57I34+VZsCsKY+zzdlpGGkltf+AUbXVe3+eXiFN
 kVHYrXS4LJ+PWT8Kju8Bd0xFaHQQtQRfNSHJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=A9XtSLIM2qv0sdY1ObMG2vMTkKJWol/5PG6aDpPhXD4=;
 b=Q5BQz4mgxZ08TSJxKPaGzOnixjlI8BjqP/ZCHOy2Rhk25Xhdg5QhTwLpVjNHIkiws6
 cXxnBIABTxmSq7tu4ivDy0DHaze8Z8LoaTENAhaKoaXx1lbVvO3BANTr3000Hm23p/BZ
 /ffJ/m/RdgmW3hPvzmg5rdtDxcU2AgQ9a0GVcZoq/heF/XUNsyv0kW1+3VZnm8NOyFwJ
 m61w9U71eqPIeczcTU8Ov93klJCiTGVX3nD655NvZNLxQvIE6GI83SJ/SXDdF/d2fZ57
 WQiO21NP2jr3Q0w9U4Auu/HSHJOon8GUIF3glsEV2fHuLbCEAlySCPvZcvLpr3AkPvD7
 0Mxw==
X-Gm-Message-State: AOAM533wEIXXOE7DZvTdpiwHXPr6JnLBFJHEILDWsOTlLHNP2+8ZXuAz
 ikdS55VjzAkVpMvsiuUvmd9sBg==
X-Google-Smtp-Source: ABdhPJwpoXiL5iPrWdqPT5nvGT/fokDLtEGUgv+KNgfoacJfkNn6uYFTmRNvugwwKLDurxJLonFbzQ==
X-Received: by 2002:a5d:4391:: with SMTP id i17mr19078709wrq.57.1612779109793; 
 Mon, 08 Feb 2021 02:11:49 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id i7sm28902816wru.49.2021.02.08.02.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 02:11:49 -0800 (PST)
Date: Mon, 8 Feb 2021 11:11:47 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: christian.koenig@amd.com
Subject: Re: [PATCH v4 11/14] drm/amdgpu: Guard against write accesses after
 device removal
Message-ID: <YCEOY5wFmpGRl7jJ@phenom.ffwll.local>
References: <07dceec0-0be9-1531-0357-353f04d1cb2b@amd.com>
 <69f036e2-f102-8233-37f6-5254a484bf97@amd.com>
 <0b502043-5a66-dcd5-53f9-5c190f22dc46@gmail.com>
 <78e4705d-c55f-6c68-d0f9-b1939b636121@amd.com>
 <CAKMK7uEm=N4kQYyzMt=nUefu2BdyKNcWikFiSJih7CthJMd2Aw@mail.gmail.com>
 <8fbeee95-b365-7f68-1e0b-1d42eb0dea70@amd.com>
 <CAKMK7uEJDfPsbnkVfunjVe2iNbpVBWY2_XHai4JntcxWkuVc3A@mail.gmail.com>
 <fcb2cf17-d011-55c6-1545-9fa190e358c3@gmail.com>
 <YCEJBfA6ce4dD3JT@phenom.ffwll.local>
 <6c639669-b78d-b6a3-71b9-d546ca34121b@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6c639669-b78d-b6a3-71b9-d546ca34121b@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: Rob Herring <robh@kernel.org>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>, "Anholt, Eric" <eric@anholt.net>,
 Pekka Paalanen <ppaalanen@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <Alexander.Deucher@amd.com>,
 Qiang Yu <yuq825@gmail.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 08, 2021 at 11:03:15AM +0100, Christian K=F6nig wrote:
> Am 08.02.21 um 10:48 schrieb Daniel Vetter:
> > On Mon, Feb 08, 2021 at 10:37:19AM +0100, Christian K=F6nig wrote:
> > > Am 07.02.21 um 22:50 schrieb Daniel Vetter:
> > > > [SNIP]
> > > > > Clarification - as far as I know there are no page fault handlers=
 for kernel
> > > > > mappings. And we are talking about kernel mappings here, right ? =
 If there were
> > > > > I could solve all those issues the same as I do for user mappings=
, by
> > > > > invalidating all existing mappings in the kernel (both kmaps and =
ioreamps)and
> > > > > insert dummy zero or ~0 filled page instead.
> > > > > Also, I assume forcefully remapping the IO BAR to ~0 filled page =
would involve
> > > > > ioremap API and it's not something that I think can be easily don=
e according to
> > > > > am answer i got to a related topic a few weeks ago
> > > > > https://www.spinics.net/lists/linux-pci/msg103396.html (that was =
the only reply
> > > > > i got)
> > > > mmiotrace can, but only for debug, and only on x86 platforms:
> > > > =

> > > > https://www.kernel.org/doc/html/latest/trace/mmiotrace.html
> > > > =

> > > > Should be feasible (but maybe not worth the effort) to extend this =
to
> > > > support fake unplug.
> > > Mhm, interesting idea you guys brought up here.
> > > =

> > > We don't need a page fault for this to work, all we need to do is to =
insert
> > > dummy PTEs into the kernels page table at the place where previously =
the
> > > MMIO mapping has been.
> > Simply pte trick isn't enough, because we need:
> > - drop all writes silently
> > - all reads return 0xff
> > =

> > ptes can't do that themselves, we minimally need write protection and t=
hen
> > silently proceed on each write fault without restarting the instruction.
> > Better would be to only catch reads, but x86 doesn't do write-only pte
> > permissions afaik.
> =

> You are not thinking far enough :)
> =

> The dummy PTE is point to a dummy MMIO page which is just never used.
> =

> That hast the exact same properties than our removed MMIO space just does=
n't
> goes bananas when a new device is MMIO mapped into that and our driver st=
ill
> tries to write there.

Hm, but where do we get such a "guaranteed never used" mmio page from?

It's a nifty idea indeed otherwise ...
-Daniel

> =

> Regards,
> Christian.
> =

> =

> > =

> > > > > > But ugh ...
> > > > > > =

> > > > > > Otoh validating an entire driver like amdgpu without such a tri=
ck
> > > > > > against 0xff reads is practically impossible. So maybe you need=
 to add
> > > > > > this as one of the tasks here?
> > > > > Or I could just for validation purposes return ~0 from all reg re=
ads in the code
> > > > > and ignore writes if drm_dev_unplugged, this could already easily=
 validate a big
> > > > > portion of the code flow under such scenario.
> > > > Hm yeah if your really wrap them all, that should work too. Since
> > > > iommappings have __iomem pointer type, as long as amdgpu is sparse
> > > > warning free, should be doable to guarantee this.
> > > Problem is that ~0 is not always a valid register value.
> > > =

> > > You would need to audit every register read that it doesn't use the r=
eturned
> > > value blindly as index or similar. That is quite a bit of work.
> > Yeah that's the entire crux here :-/
> > -Daniel
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
