Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8BDCFD31F
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 08:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA1E10E1E3;
	Mon, 24 Nov 2025 08:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=oscada.org header.i=@oscada.org header.b="Z8DXgY5l";
	dkim-atps=neutral
Received: from oscada.org (oscada.org [46.98.2.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC3A10E08F
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Nov 2025 12:41:21 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by oscada.org (Postfix) with ESMTP id 94CAC43E4;
 Sat, 22 Nov 2025 14:41:19 +0200 (EET)
Received: from oscada.org ([127.0.0.1])
 by localhost (mail.oscada [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id XoHk8AD43HPN; Sat, 22 Nov 2025 14:41:19 +0200 (EET)
Received: from [192.168.1.3] (oscada [192.168.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by oscada.org (Postfix) with ESMTPSA id E6E6243D2;
 Sat, 22 Nov 2025 14:41:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oscada.org;
 s=default; t=1763815278;
 bh=aWzghXdFPl3oX98otVra04CJWe9J76hOd9rOfo189fg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Z8DXgY5lglUXB2klWaR66SoBeBJ/MbkWehEpaqCa0WOeQEHu01hOx853UKlJ/fUqY
 Fc6+yxJEdOUH0hVM+ymORPXLLn4FdcybcpK0CwLiFo54iqw1emSo0mOV0OzaWONGdb
 cu0+1P8Jwf2iRukb8c8kSh1Cy0KECp/LQ+zyZUxhVjSe/o+KuqSXPyCgv9qvitMxnI
 5TVbExolAw6x91XwgFTz3EtEI81wXwAXQJ4bsg/StWZ5gi3TPd2RGMX0m+ggqAnUfa
 xLutCkQwaWTCuf7+QbzcEVsUXjluqN6x5tdcjsgOld03+ULew4hR2J84RG7fyc212D
 V9YVE8JNNs+cg==
Content-Type: multipart/mixed; boundary="------------pJ8MuIKKndLm04hoTwrEqxOs"
Message-ID: <1981f7cd-50f4-4ed2-bfa9-7b4b64493be0@oscada.org>
Date: Sat, 22 Nov 2025 14:41:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 1118349@bugs.debian.org
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <epyf7tdz3azb3fflb6rwuhax7mpccmqlsmzqqe2pcm7mxrdur4@zpx2uo5pvoqs>
 <BL1PR12MB51448357F3CCE2B2F9D346ADF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <f689f22a-f53a-435a-b79c-d79b4cfd810c@oscada.org>
 <2qxsyt34y4gmwuxwyvs7qh6ekypair6mt3h7n5txdhletjnpsc@vygqxoo7oacn>
Content-Language: en-US
From: Roman Savochenko <roman@oscada.org>
Organization: OpenSCADA Team
In-Reply-To: <2qxsyt34y4gmwuxwyvs7qh6ekypair6mt3h7n5txdhletjnpsc@vygqxoo7oacn>
X-Mailman-Approved-At: Mon, 24 Nov 2025 08:12:45 +0000
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
--------------pJ8MuIKKndLm04hoTwrEqxOs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

12.11.25 13:14, Uwe Kleine-König:
>> Now just I set "radeon.dpm=1", I got immediately restart with disabling USB,
>> so I have needed to restart for successful download with "radeon.dpm=0".
> Can you try a different monitor?

The problem is reproducible on any monitor and video-output due to I 
tried the same through VGA and TV through HDMI.

--------------pJ8MuIKKndLm04hoTwrEqxOs
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

--------------pJ8MuIKKndLm04hoTwrEqxOs--
