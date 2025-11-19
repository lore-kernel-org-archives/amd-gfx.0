Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C066CF885A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 13:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F27E10E749;
	Thu, 20 Nov 2025 13:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=oscada.org header.i=@oscada.org header.b="jxb+LehE";
	dkim-atps=neutral
Received: from oscada.org (oscada.org [46.98.2.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DEB10E265
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 19:35:25 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by oscada.org (Postfix) with ESMTP id EC85F43D4;
 Wed, 19 Nov 2025 21:35:23 +0200 (EET)
Received: from oscada.org ([127.0.0.1])
 by localhost (mail.oscada [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id xHYD-vd3NTbI; Wed, 19 Nov 2025 21:35:23 +0200 (EET)
Received: from [192.168.1.2] (oscada [192.168.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by oscada.org (Postfix) with ESMTPSA id 4555943D2;
 Wed, 19 Nov 2025 21:35:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oscada.org;
 s=default; t=1763580923;
 bh=2jypUAfXIAajU/PjtIm5BKW8fwY0BGa08xe7pmyCzJk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jxb+LehEX/AUbDyfj6VRXGPbeNtUhYpJLMkZtU+5Yx7AOdXjLd9Kwrnf29L7NYj25
 hCAVm8qhaL8hYIZT8hIJ2xkID0/X7X3X/LQM0gY9KV1fEf+mF63DsulSFlbRBoX6cX
 wTuiUZQiZORrHjBlmcU9eyvNXC8+p3Am7BNIuRjhuHbo70yVKKBWT3M84JWDQaU/Gq
 R8YG6rIdYZRltSN19Snldwf3AS7el0Gs6T4MG6YNs4VJ3hXQ5G+K7yRKRPOnVpGSYK
 vVe2Oz5ZgtNg1HfOjQPG0T6xkojZ4NGWhoxfAuNq8zfvtTWR0OlwMvmmWMu4OoFybI
 tYWDcxWklb0Ig==
Content-Type: multipart/mixed; boundary="------------tF6iNQmg80RU4DWGstx88TNx"
Message-ID: <9e663ca2-8de2-49da-8616-805318b5fe8c@oscada.org>
Date: Wed, 19 Nov 2025 21:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 1118349@bugs.debian.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <epyf7tdz3azb3fflb6rwuhax7mpccmqlsmzqqe2pcm7mxrdur4@zpx2uo5pvoqs>
 <BL1PR12MB51448357F3CCE2B2F9D346ADF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <f689f22a-f53a-435a-b79c-d79b4cfd810c@oscada.org>
 <2qxsyt34y4gmwuxwyvs7qh6ekypair6mt3h7n5txdhletjnpsc@vygqxoo7oacn>
 <e0d85321-733d-4b89-ba5f-5efd5f1b18ac@oscada.org>
 <931c33cf-26cd-4d23-827d-8c61f9028ca9@amd.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <389a9e45-0f92-4810-a8ed-91640750d973@oscada.org>
 <jkkqfvey7b6evfq6ojj7nldwka6a2s5y32ehybyoi47nfn25ck@hqh7d2zrvlr3>
Content-Language: en-US
From: Roman Savochenko <roman@oscada.org>
Organization: OpenSCADA Team
In-Reply-To: <jkkqfvey7b6evfq6ojj7nldwka6a2s5y32ehybyoi47nfn25ck@hqh7d2zrvlr3>
X-Mailman-Approved-At: Thu, 20 Nov 2025 13:53:05 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------tF6iNQmg80RU4DWGstx88TNx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

19.11.25 19:05, Uwe Kleine-König:
> In that case the interesting interval is 5.10 .. 6.1. If you could
> pinpoint the oldest kernel image package that shows the symptoms that
> would be great.

The oldest Linux kernel 6 is only one on the actual Debian 12 
installation on this PC:

roman@home:~$ cat /proc/version
Linux version 6.1.0-33-amd64 (debian-kernel@lists.debian.org) (gcc-12 
(Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP 
PREEMPT_DYNAMIC Debian 6.1.133-1 (2025-04-10)

And the problem is actual here since I have loaded from the kernel only 
with "radeon.dpm=0":

roman@home:~$ cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-6.1.0-33-amd64 
root=UUID=dd0275fe-934a-4742-8f89-0bc5c0357dad ro radeon.dpm=0 quiet splash

Regards, Roman

--------------tF6iNQmg80RU4DWGstx88TNx
Content-Type: text/vcard; charset=UTF-8; name="roman.vcf"
Content-Disposition: attachment; filename="roman.vcf"
Content-Transfer-Encoding: base64

QkVHSU46VkNBUkQNClZFUlNJT046NC4wDQpFTUFJTDtQUkVGPTE6cm9tYW5Ab3NjYWRhLm9y
Zw0KRk46Um9tYW4gU2F2b2NoZW5rbw0KT1JHOk9wZW5TQ0FEQSBUZWFtOw0KVElUTEU6T3Bl
blNDQURBIGF1dGhvciBhbmQgbWFpbiBkZXZlbG9wZXINCk46U2F2b2NoZW5rbztSb21hbjs7
Ow0KQURSOjs7O0thbWphbnNrZTtTaWNoZXNsYXZza2E7NTE5Mzk7VWtyYWluZQ0KVEVMO1ZB
TFVFPVRFWFQ6KzM4MDY3OTg1OTgxNQ0KVVJMO1RZUEU9d29yaztWQUxVRT1VUkw6aHR0cDov
L29zY2FkYS5vcmcNClVJRDpiYzkyY2E2My03NWNhLTQ5OGItODAxYy01NGJlMmIzNDMyOGUN
CkVORDpWQ0FSRA0K

--------------tF6iNQmg80RU4DWGstx88TNx--
