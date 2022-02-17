Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8788EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 18:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED50F10E2F1;
	Thu, 17 Feb 2022 18:11:26 +0000 (UTC)
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net
 [50.242.207.105])
 by gabe.freedesktop.org (Postfix) with ESMTP id A85DF10E2F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 18:11:24 +0000 (UTC)
Received: from lancer.cnet.absolutedigital.net
 (lancer.cnet.absolutedigital.net [10.7.5.10])
 by luxor.inet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id 21HIBB6m023774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
 Thu, 17 Feb 2022 13:11:11 -0500
Received: from localhost (localhost [127.0.0.1])
 by lancer.cnet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id
 21HIAppH022234
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Thu, 17 Feb 2022 13:10:51 -0500
Date: Thu, 17 Feb 2022 13:10:51 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Subject: Re: AMDGPU: RX 6500 XT: System reset when loading module
In-Reply-To: <de9952a6-cba1-4927-f8e0-fcd7f115267e@amd.com>
Message-ID: <alpine.LNX.2.00.2202171254420.21576@lancer.cnet.absolutedigital.net>
References: <alpine.LNX.2.00.2202131848490.20545@lancer.cnet.absolutedigital.net>
 <b30922e2-04f5-2135-695c-2ea84d9307ac@amd.com>
 <alpine.LNX.2.00.2202141223020.10303@lancer.cnet.absolutedigital.net>
 <de9952a6-cba1-4927-f8e0-fcd7f115267e@amd.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="118098437-1486817-1645121451=:21576"
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--118098437-1486817-1645121451=:21576
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 17 Feb 2022, Christian König wrote:

> Ok, at least it doesn't sounds like it is the power supply.

I was able to procure an 800W PSU just to give it a try, and at first it 
seemed to make a difference. The drivers would fully load, but after a 
short amount of time things would become unstable and the system would 
crash or reset. Very bizarre...

> Unfortunately not of hand. You could try to play around with the power flags,
> but from your description it sounds like you already did that.
> 
> Only other option I see is to try a different motherboard and/or Windows with
> that hardware. If that also doesn't work there must be some hardware fault on
> the RX6500.

That was my thinking too. I got the idea to try Windows after I did the 
PSU swap and, like Linux, it was okay at first, but then started crashing 
and resetting. Either the card is defective or it really doesn't like my 
motherboard.

Thanks very much for your help!

-- 
Cal Peake

--118098437-1486817-1645121451=:21576--
