Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367E4C4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Dec 2022 14:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D370C10E1A9;
	Sun, 18 Dec 2022 14:06:06 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B9910E1A9;
 Sun, 18 Dec 2022 14:06:01 +0000 (UTC)
Received: from [192.168.1.137] ([188.62.80.205])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202212181505568893; Sun, 18 Dec 2022 15:05:56 +0100
Message-ID: <b29ae8cf-76f3-56cd-7409-da8b153c7e23@daenzer.net>
Date: Sun, 18 Dec 2022 15:05:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To: amd-gfx@lists.freedesktop.org
References: <d09c335c-b4e8-2ad8-f135-dbac6f99f8cf@daenzer.net>
Content-Language: en-CA
Subject: Re: DRM scheduler & amdgpu splats followed by GPU hang
In-Reply-To: <d09c335c-b4e8-2ad8-f135-dbac6f99f8cf@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F21.639F1E44.000B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/17/22 13:12, Michel Dänzer wrote:
> 
> With the drm-next-2022-12-13 changes for 6.2 merged on top of a 6.1.0 kernel, I hit a GPU (Picasso APU) hang in the menu of Trackmania (free-to-play Windows game, running via Wine).

It happened again when starting Return to Monkey Island, which is Linux native and uses Vulkan. It seems to be quite easy to hit with games using Vulkan (specifically Mesa's RADV).

Curiously though, I haven't hit it with games using Vulkan on a different machine with Navi 21 dGPU.


> After rebooting, I noticed the attached splats in the journal. I can't be sure that the GPU hang was directly related to these, but it seems plausible.

Given the similar reports by Borislav Petkov and Mikhail Gavrilov, it seems likely.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

