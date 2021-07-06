Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1F3C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 16:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7C961C29
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 16:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7C961C29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A5A6E520;
	Tue,  6 Jul 2021 16:32:47 +0000 (UTC)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5956E51C
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 16:29:55 +0000 (UTC)
Received: by mail-il1-x135.google.com with SMTP id g3so20094318ilq.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jul 2021 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=etYc22i2Gl0Nevaba6RCpVnI4CJLkrAbQx/tp++WzW4=;
 b=QT4qJl6Njzuv/rc+EW47j005Go9tPi24idYG9F2hf6+7AESajcYJswCFXElQ8kFMby
 3vxITIhL6oD5OvTn6ePN1zoUacBrQ5ffu1dB4JcTCI57bv9vthhfZgYhhhNqU+ePgyil
 0oVjqkgbSnNJaSikDXvfN1uGA2r2rilepOECvDPAFz+i4YUySzo8ix4MsE7aC86tV60X
 iOE8CYqdzDybuCrmVxoL7WfhOPJx1E5WRlC0HlQ7DGrGnVNsT3Zk+Wbe3rSxO2v/33RX
 olRWd/DC6AGXPPFAvSitPnP8EShIrJOMYVTSz6I/9NOxcUk33s+sqTV1aJkNsz27Dc/v
 M/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=etYc22i2Gl0Nevaba6RCpVnI4CJLkrAbQx/tp++WzW4=;
 b=aLSYKoh8ehXmf4I3amLfmq7lO+1O0M5Tm460UaRiiAvt6xkqtqF8Tv5O6mAAMrdHxU
 itsNywue1fguMfBtAj220ppV08/cyPZEW88wOEqWCGt45dAotEbMjMjTjLpgZbi/tGl2
 +yHbD5I7izTUPV0hHIBm4MdGCmtEEWMeKxQ5nNeAZq8iZ15bROrtLO8VLi3cOaScqr/A
 a+2zH6f6DOa0FAlp481lCxRq7sDkktt178bB6GVEGuD+ujC+IvygWCZzCojtmJ21ScGD
 Qi7OonBW03cbLHfuy3RybExt0rO1wqOwuexjewUdIKziGrGfTawNOtPdooPTHduvUoyj
 WjBw==
X-Gm-Message-State: AOAM533uYgsYgfxSRMcNflTnV6C0OeYxRWmI0woR4+9ylVIYLazp/NWW
 AapRAufdwTfRx9klz3DamjJflw==
X-Google-Smtp-Source: ABdhPJz6bo5skYn6n6IU9DPSu+uSaHq70zWMOCxNpyUILydINIqb1PzqfwTHtoG8Ps83diFXVzV6Rw==
X-Received: by 2002:a92:7f07:: with SMTP id a7mr14607133ild.202.1625588995298; 
 Tue, 06 Jul 2021 09:29:55 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id r16sm8512490ilj.4.2021.07.06.09.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jul 2021 09:29:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1m0nxJ-004TiJ-I6; Tue, 06 Jul 2021 13:29:53 -0300
Date: Tue, 6 Jul 2021 13:29:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <20210706162953.GQ4604@ziepe.ca>
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <CAFCwf10_rTYL2Fy6tCRVAUCf4-6_TtcWCv5gEEkGnQ0KxqMUBg@mail.gmail.com>
 <CAKMK7uEAJZUHNLreBB839BZOfnTGNU4rCx-0k55+67Nbxtdx3A@mail.gmail.com>
 <20210706142357.GN4604@ziepe.ca>
 <CAKMK7uELNzwUe+hhVWRg=Pk5Wt_vOOX922H48Kd6dTyO2PeBbg@mail.gmail.com>
 <20210706152542.GP4604@ziepe.ca>
 <CAKMK7uH7Ar6+uAOU_Sj-mf89V9WCru+66CV5bO9h-WAAv7Mgdg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uH7Ar6+uAOU_Sj-mf89V9WCru+66CV5bO9h-WAAv7Mgdg@mail.gmail.com>
X-Mailman-Approved-At: Tue, 06 Jul 2021 16:32:45 +0000
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

On Tue, Jul 06, 2021 at 05:49:01PM +0200, Daniel Vetter wrote:

> The other thing to keep in mind is that one of these drivers supports
> 25 years of product generations, and the other one doesn't. 

Sure, but that is the point, isn't it? To have an actually useful
thing you need all of this mess

> > My argument is that an in-tree open kernel driver is a big help to
> > reverse engineering an open userspace. Having the vendors
> > collaboration to build that monstrous thing can only help the end goal
> > of an end to end open stack.
> 
> Not sure where this got lost, but we're totally fine with vendors
> using the upstream driver together with their closed stack. And most
> of the drivers we do have in upstream are actually, at least in parts,
> supported by the vendor. E.g. if you'd have looked the drm/arm driver
> you picked is actually 100% written by ARM engineers. So kinda
> unfitting example.

So the argument with Habana really boils down to how much do they need
to show in the open source space to get a kernel driver? You want to
see the ISA or compiler at least?

That at least doesn't seem "extreme" to me.

> > For instance a vendor with an in-tree driver has a strong incentive to
> > sort out their FW licensing issues so it can be redistributed.
> 
> Nvidia has been claiming to try and sort out the FW problem for years.
> They even managed to release a few things, but I think the last one is
> 2-3 years late now. Partially the reason is that there don't have a
> stable api between the firmware and driver, it's all internal from the
> same source tree, and they don't really want to change that.

Right, companies have no incentive to work in a sane way if they have
their own parallel world. I think drawing them part by part into the
standard open workflows and expectations is actually helpful to
everyone.

> > > I don't think the facts on the ground support your claim here, aside
> > > from the practical problem that nvidia is unwilling to even create an
> > > open driver to begin with. So there isn't anything to merge.
> >
> > The internet tells me there is nvgpu, it doesn't seem to have helped.
> 
> Not sure which one you mean, but every once in a while they open up a
> few headers, or a few programming specs, or a small driver somewhere
> for a very specific thing, and then it dies again or gets obfuscated
> for the next platform, or just never updated. I've never seen anything
> that comes remotely to something complete, aside from tegra socs,
> which are fully supported in upstream afaik.

I understand nvgpu is the tegra driver that people actualy
use. nouveau may have good tegra support but is it used in any actual
commercial product?

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
