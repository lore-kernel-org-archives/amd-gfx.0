Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44540C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 22:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD8E10E393;
	Wed, 23 Feb 2022 22:59:15 +0000 (UTC)
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net
 [50.242.207.105])
 by gabe.freedesktop.org (Postfix) with ESMTP id 70E7210E393
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 22:59:14 +0000 (UTC)
Received: from lancer.cnet.absolutedigital.net
 (lancer.cnet.absolutedigital.net [10.7.5.10])
 by luxor.inet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id 21NMwvAp003449
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
 Wed, 23 Feb 2022 17:58:57 -0500
Received: from localhost (localhost [127.0.0.1])
 by lancer.cnet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id
 21NMx9MG008938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Wed, 23 Feb 2022 17:59:09 -0500
Date: Wed, 23 Feb 2022 17:59:09 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Subject: Re: AMDGPU: RX 6500 XT: System reset when loading module
In-Reply-To: <809355d6-ef2a-ca90-5a9a-813beb8ff6d1@amd.com>
Message-ID: <alpine.LNX.2.00.2202181444250.8791@lancer.cnet.absolutedigital.net>
References: <alpine.LNX.2.00.2202131848490.20545@lancer.cnet.absolutedigital.net>
 <b30922e2-04f5-2135-695c-2ea84d9307ac@amd.com>
 <alpine.LNX.2.00.2202141223020.10303@lancer.cnet.absolutedigital.net>
 <de9952a6-cba1-4927-f8e0-fcd7f115267e@amd.com>
 <alpine.LNX.2.00.2202171254420.21576@lancer.cnet.absolutedigital.net>
 <809355d6-ef2a-ca90-5a9a-813beb8ff6d1@amd.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="118098437-563937920-1645213522=:8791"
Content-ID: <alpine.LNX.2.00.2202231649110.5028@lancer.cnet.absolutedigital.net>
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

--118098437-563937920-1645213522=:8791
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.2.00.2202231649111.5028@lancer.cnet.absolutedigital.net>

On Fri, 18 Feb 2022, Christian König wrote:

> That's a really strong evidence that you have a hardware problem here.
> 
> BTW: Where do you got that hardware from? Is it used or a new one? Was it
> maybe used for mining?
> 

Nah, this was a brand new card I bought on launch day from a reputable 
brick-and-mortar.

Since I was getting to the end of my 30-day return window, I decided to 
just take the card back and exchange it for an RX 560 -- the only other 
card comparable in price that was also in stock (thanks miners/scalpers!).

When I got that card home and tried it out, it had the same problem. From 
there, I decided to take a break and try a different approach. First thing 
I wanted to try was stepping through the different BIOS revisions 
available for my motherboard to see if that made any difference.

That's when I saw ASRock had a beta for the next BIOS release available 
for testing. Flashed it, configured the BIOS to my liking, and incredibly, 
no resets or crashes.

I've been under the weather for several days so I'm just now getting back 
to testing things again, but so far, everything seems to be good.

I do wish I could have gotten to this point a little sooner. Exchanging my 
overpriced brand new GPU for an overpriced 5 year old GPU is a little 
stomach turning :-/

-- 
Cal Peake
--118098437-563937920-1645213522=:8791--
