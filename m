Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED06C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 23:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E1310E930;
	Thu, 24 Feb 2022 23:12:51 +0000 (UTC)
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net
 [50.242.207.105])
 by gabe.freedesktop.org (Postfix) with ESMTP id CF3B710E930
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 23:12:49 +0000 (UTC)
Received: from lancer.cnet.absolutedigital.net
 (lancer.cnet.absolutedigital.net [10.7.5.10])
 by luxor.inet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id 21ONCXf0005177
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
 Thu, 24 Feb 2022 18:12:34 -0500
Received: from localhost (localhost [127.0.0.1])
 by lancer.cnet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id
 21ONBngf024090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Thu, 24 Feb 2022 18:11:49 -0500
Date: Thu, 24 Feb 2022 18:11:49 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Subject: Re: AMDGPU: RX 6500 XT: System reset when loading module
In-Reply-To: <8cd9b639-be48-5b2f-bc3d-d6bd49be1830@amd.com>
Message-ID: <alpine.LNX.2.00.2202241728250.23253@lancer.cnet.absolutedigital.net>
References: <alpine.LNX.2.00.2202131848490.20545@lancer.cnet.absolutedigital.net>
 <b30922e2-04f5-2135-695c-2ea84d9307ac@amd.com>
 <alpine.LNX.2.00.2202141223020.10303@lancer.cnet.absolutedigital.net>
 <de9952a6-cba1-4927-f8e0-fcd7f115267e@amd.com>
 <alpine.LNX.2.00.2202171254420.21576@lancer.cnet.absolutedigital.net>
 <809355d6-ef2a-ca90-5a9a-813beb8ff6d1@amd.com>
 <alpine.LNX.2.00.2202181444250.8791@lancer.cnet.absolutedigital.net>
 <8cd9b639-be48-5b2f-bc3d-d6bd49be1830@amd.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="118098437-1169863731-1645744309=:23253"
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

--118098437-1169863731-1645744309=:23253
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 24 Feb 2022, Christian König wrote:

> Interesting to know that it turned out to be the motherboard, going to keep
> that in mind if somebody else is having similar problems.

Looks like I might have spoke too soon, getting random resets again. I 
have no idea why my nvidia card runs perfectly fine, but two completely 
different AMD GPUs both have the same problem, or why that problem comes 
and goes at random.

I'm gonna have to do a deeper dive into this until I figure it out (or 
until Intel drops their dGPUs and I can get a modern, OSS-friendly GPU 
that's stable on my system lol).

I'll let you know if I come up with anything more definitive, Christian.

Thanks!

-- 
Cal Peake

P.S. To your earlier point about capacitors: Between the mobo and the GPU, 
the only electrolytic caps are for the audio hardware. Everything else is 
solid polymer, so I'm thinking that that's probably not the culprit :-)
--118098437-1169863731-1645744309=:23253--
