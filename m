Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D169EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 19:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 684E710E8FE;
	Fri, 25 Feb 2022 19:30:51 +0000 (UTC)
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net
 [50.242.207.105])
 by gabe.freedesktop.org (Postfix) with ESMTP id D2C3A10E8FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 19:30:49 +0000 (UTC)
Received: from lancer.cnet.absolutedigital.net
 (lancer.cnet.absolutedigital.net [10.7.5.10])
 by luxor.inet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id 21PJUY4k016034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
 Fri, 25 Feb 2022 14:30:35 -0500
Received: from localhost (localhost [127.0.0.1])
 by lancer.cnet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id
 21PJTlam015844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Fri, 25 Feb 2022 14:29:47 -0500
Date: Fri, 25 Feb 2022 14:29:47 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: AMDGPU: RX 6500 XT: System reset when loading module
In-Reply-To: <CADnq5_Nx9Oski_2A-99QvqFJiUG36=+bfx_0F-eUK0gD56Vqjg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.2202251421580.14365@lancer.cnet.absolutedigital.net>
References: <alpine.LNX.2.00.2202131848490.20545@lancer.cnet.absolutedigital.net>
 <b30922e2-04f5-2135-695c-2ea84d9307ac@amd.com>
 <alpine.LNX.2.00.2202141223020.10303@lancer.cnet.absolutedigital.net>
 <de9952a6-cba1-4927-f8e0-fcd7f115267e@amd.com>
 <alpine.LNX.2.00.2202171254420.21576@lancer.cnet.absolutedigital.net>
 <809355d6-ef2a-ca90-5a9a-813beb8ff6d1@amd.com>
 <alpine.LNX.2.00.2202181444250.8791@lancer.cnet.absolutedigital.net>
 <8cd9b639-be48-5b2f-bc3d-d6bd49be1830@amd.com>
 <alpine.LNX.2.00.2202241728250.23253@lancer.cnet.absolutedigital.net>
 <CADnq5_Nx9Oski_2A-99QvqFJiUG36=+bfx_0F-eUK0gD56Vqjg@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Cc: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 25 Feb 2022, Alex Deucher wrote:

Hi Alex,

> Does setting amdgpu.aspm=0 help?
> 

No, I remember trying it with the 6500XT and I just tried it now with the 
RX560. No help on either.

-- 
Cal Peake

