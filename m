Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B06EC3F2D5
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 08:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4869F246B4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 08:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lzjmjr/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4869F246B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A29E56E10D;
	Mon,  2 Mar 2020 08:19:30 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0921A6E3CB;
 Sat, 29 Feb 2020 21:47:28 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id t11so1327579wrw.5;
 Sat, 29 Feb 2020 13:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:in-reply-to:references:mime-version
 :date:user-agent:content-transfer-encoding;
 bh=rkmZ41WofvOt7iBnDSrFuO4lCYptyXZTqHdtoi4NzVI=;
 b=Lzjmjr/w/IDaGSRs7fbaPIORvdWvOuJaQKwcKMWXRp0nkOB23C5ppzYKwNVoAzhm41
 UDjcG3hDUTpVu69Rd0tPWxWTfAbvlZWlLoKT50WqUNZE4J5Kq5X9120MB5Q+UotZX1By
 MvcSgYYTC+kk1BNl3EANmSfLuG2vdCJnJMtvZq8JEL8Zuh+LIiVQK1MPwBCbhiZfNFnv
 g9GZ1YOpzAgHgHG08V8MTgkhTdY2Vd6uZAsrxOdh2Du9DW/NK9RKLP0IoXw4OHOm1sbj
 xV7NYIMSO3rk6yJ/K9ysqMFiuKQnAfdXv++1ndgJZrZaq3odzbiuny/PNXtZpHc4t5cy
 pXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
 :references:mime-version:date:user-agent:content-transfer-encoding;
 bh=rkmZ41WofvOt7iBnDSrFuO4lCYptyXZTqHdtoi4NzVI=;
 b=BtmWESN64z0ojghLLT9GGcJ4mrlydaUGfS7D29YOy88zchfsj/g0NPJbWzy/RMClpR
 AchR51oGmXw1Oa+TYFbwSuAnLvGKRUviiXDI4NKpZsMmIJS3Yf+GgTQvC3Vtxt1koaO/
 6CU50y7LQ/VrYIXPN96Erm42WehiG/rRAGB84TdIZlNw3sC37BLWPcis8wdyU5faiq/q
 b5KVSnD8WxiPY1dJZZYSLp7bLJUmCuSWtJoTiGt4OBt+rAm/4uNsS3GiXqbfLoSUMu1m
 /kBuSqpayxHrX0+XmRSMwesrYzsJYevL+cpkU1ps4Wr+Y0XtXaJ9HyWZGwPeA1I2KYZ6
 Opmg==
X-Gm-Message-State: APjAAAVijISG9/8HwVktar7tr2RIy55EprFQRLqH4Y5TVqMvYXEHw0CO
 JJ1MLkRO+ND1K7Xfg1AXwQ0=
X-Google-Smtp-Source: APXvYqxTD5vxcKtb2KO8ce0FLVISwnH+nPCwfeS94f2zOppIqjX8biSY0BJu4K7XVsmXfCC8ZhpC/w==
X-Received: by 2002:a5d:4289:: with SMTP id k9mr12552398wrq.280.1583012846581; 
 Sat, 29 Feb 2020 13:47:26 -0800 (PST)
Received: from Timur-XPS ([2a02:ab88:3846:1b00:9eb6:d0ff:fe89:c25f])
 by smtp.gmail.com with ESMTPSA id r19sm2844926wmh.26.2020.02.29.13.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Feb 2020 13:47:25 -0800 (PST)
Message-ID: <d9dca12759fd6a549dc4cd71b5f210a4dced01cd.camel@gmail.com>
Subject: Re: [Mesa-dev] [Intel-gfx] gitlab.fd.o financial situation and
 impact on services
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>, Discussion of the development
 of and with GStreamer <gstreamer-devel@lists.freedesktop.org>, Daniel Stone
 <daniel@fooishbar.org>, Erik Faye-Lund <erik.faye-lund@collabora.com>
In-Reply-To: <d0ef47e45c83b342494e6781b808b4831a008836.camel@ndufresne.ca>
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
 <ece8ebe3-40ec-2457-02da-4fef19cbe8f6@intel.com>
 <6d2ec570f957b4504fb70e0b1f0632712a99dc0c.camel@collabora.com>
 <CAPj87rO7BuKQj2Kei3T7RdkFq5=TiuShBvtrPU2sn0iqMfXSTg@mail.gmail.com>
 <59f4ea1f13a9a9d37f7801b93061b4ae7dd595e2.camel@gmail.com>
 <d0ef47e45c83b342494e6781b808b4831a008836.camel@ndufresne.ca>
MIME-Version: 1.0
Date: Sat, 29 Feb 2020 21:28:33 +0100
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
X-Mailman-Approved-At: Mon, 02 Mar 2020 08:19:29 +0000
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, 2020-02-29 at 14:46 -0500, Nicolas Dufresne wrote:
> > 
> > 1. I think we should completely disable running the CI on MRs which
> > are
> > marked WIP. Speaking from personal experience, I usually make a lot
> > of
> > changes to my MRs before they are merged, so it is a waste of CI
> > resources.
> 
> In the mean time, you can help by taking the habit to use:
> 
>   git push -o ci.skip

Thanks for the advice, I wasn't aware such an option exists. Does this
also work on the mesa gitlab or is this a GStreamer only thing?

How hard would it be to make this the default?

> That's a much more difficult goal then it looks like. Let each
> projects
> manage their CI graph and content, as each case is unique. Running
> more
> tests, or building more code isn't the main issue as the CPU time is
> mostly sponsored. The data transfers between the cloud of gitlab and
> the runners (which are external), along to sending OS image to Lava
> labs is what is likely the most expensive.
> 
> As it was already mention in the thread, what we are missing now, and
> being worked on, is per group/project statistics that give us the
> hotspot so we can better target the optimization work.

Yes, would be nice to know what the hotspot is, indeed.

As far as I understand, the problem is not CI itself, but the bandwidth
needed by the build artifacts, right? Would it be possible to not host
the build artifacts on the gitlab, but rather only the place where the
build actually happened? Or at least, only transfer the build artifacts
on-demand?

I'm not exactly familiar with how the system works, so sorry if this is
a silly question.

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
