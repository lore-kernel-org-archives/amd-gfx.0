Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F15C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 17:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D3710E287;
	Mon, 14 Feb 2022 17:45:41 +0000 (UTC)
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net
 [50.242.207.105])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5DEDF10E288
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 17:45:39 +0000 (UTC)
Received: from lancer.cnet.absolutedigital.net
 (lancer.cnet.absolutedigital.net [10.7.5.10])
 by luxor.inet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id 21EHjSEI018445
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
 Mon, 14 Feb 2022 12:45:28 -0500
Received: from localhost (localhost [127.0.0.1])
 by lancer.cnet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id
 21EHj8Vj011655
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Mon, 14 Feb 2022 12:45:08 -0500
Date: Mon, 14 Feb 2022 12:45:06 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Subject: Re: AMDGPU: RX 6500 XT: System reset when loading module
In-Reply-To: <b30922e2-04f5-2135-695c-2ea84d9307ac@amd.com>
Message-ID: <alpine.LNX.2.00.2202141223020.10303@lancer.cnet.absolutedigital.net>
References: <alpine.LNX.2.00.2202131848490.20545@lancer.cnet.absolutedigital.net>
 <b30922e2-04f5-2135-695c-2ea84d9307ac@amd.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="118098437-610871913-1644860708=:10303"
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

--118098437-610871913-1644860708=:10303
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Christian,

Thanks for the reply.

On Mon, 14 Feb 2022, Christian König wrote:

> well that sounds strongly like some hardware problem. What power supply do you
> have in that system?
> 

Right now, I've got it hooked up to a Corsair VX550W. It's on a test bench 
so the only things hanging off the mobo at the moment are the GPU and a 
pair of NVMe drives.

I'm also testing this system with a RTX 2060 Super and I have no problems 
with that card, even under heavy load.

> From your dmesg it looks like the kernel driver actually initializes fines. So
> my educated guess is that as soon as the desktop tries to draw we suck to much
> power and go into brown out reset.
> 

I'm not even trying for a desktop yet, it's currently booting to runlevel 3 :-)

As mentioned above, the 2060 does just fine and its power needs are 
significantly higher than that of the 6500.

It's possible that it's something with my particular motherboard. Michael 
Larabel over at Phoronix did some performance testing[1] with this same 
model card running on Ubuntu 22.04, seemingly without problem.

Do you have any suggestions for further troubleshooting?

Thanks,

-- 
Cal Peake

[1] https://www.phoronix.com/scan.php?page=article&item=radeon-rx6500xt-linux

--118098437-610871913-1644860708=:10303--
