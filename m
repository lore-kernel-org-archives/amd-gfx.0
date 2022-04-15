Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CE9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 16:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2679C10E222;
	Fri, 15 Apr 2022 16:00:24 +0000 (UTC)
X-Greylist: delayed 901 seconds by postgrey-1.36 at gabe;
 Fri, 15 Apr 2022 15:53:49 UTC
Received: from a3i311.smtp2go.com (a3i311.smtp2go.com [203.31.37.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A2FB10E26F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 15:53:49 +0000 (UTC)
Received: from [10.100.33.96] (helo=mail.blazebox.homeip.net)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <paulb@blazebox.homeip.net>)
 id 1nfO1x-IbZsyg-G2; Fri, 15 Apr 2022 15:38:41 +0000
Received: from blazebox.homeip.net (localhost [127.0.0.1])
 by mail.blazebox.homeip.net (Postfix) with ESMTP id 6321B64424B;
 Fri, 15 Apr 2022 11:38:40 -0400 (EDT)
X-Virus-Scanned: amavisd-new at blazebox.homeip.net
Received: from mail.blazebox.homeip.net ([127.0.0.1])
 by blazebox.homeip.net (mail.blazebox.homeip.net [127.0.0.1]) (amavisd-new,
 port 10024)
 with LMTP id MRbYDNQZYlMR; Fri, 15 Apr 2022 11:38:35 -0400 (EDT)
Received: from [IPV6:2001:470:1f07:a3a:e6aa:8e9e:c988:15a] (unknown
 [IPv6:2001:470:1f07:a3a:e6aa:8e9e:c988:15a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (Client did not present a certificate)
 by mail.blazebox.homeip.net (Postfix) with ESMTPSA id 465C264423F;
 Fri, 15 Apr 2022 11:38:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blazebox.homeip.net;
 s=mail; t=1650037115;
 bh=ibQDI/jrfd7h9yAxNYkfTQuei0FaTwwZMK4v9rQ5dMk=;
 h=Date:To:Cc:From:Subject;
 b=WxZlf4HDgVI5MwHwyI/AAua/RxX/nFZ2c0/gzeERv/GFsTaRqyA9WXXWDNnYogmgY
 sMO5kcl7nKzlz6wK+H5PZODJYaevj0wYBDWGXh+igQ8QPrWNphcWH7ACr+d4018PpK
 JR27XzJVZf87l8SG7bHyaICm+zUzqG2lu3dmmIuF9Gq5Tw1x1mHkYSRpJfAFHkH6B8
 9+KAdZpC/ohP+pLqyfxASJwO+0y/+JhFxwhLn/0HS7VfUFEXzpssgV3RcHRbx8dnYo
 aPAJITtXIXkuJ3ZBzgPDVy1M2DoXVcAWqvHpzdsF83SkbVoGax7M4hEYEG0Rkzgag1
 RIhh1FgUs83OA==
Message-ID: <5eef642a-d7d2-9f59-7f63-b6e89c52bdba@blazebox.homeip.net>
Date: Fri, 15 Apr 2022 11:38:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
From: Paul Blazejowski <paulb@blazebox.homeip.net>
Subject: Unable to boot 5.18-rc kernel on amdgpu legacy (si) hardware.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 316702m:316702a3jAEqy:316702sTI6k_UlB5
X-smtpcorp-track: 1nfO1xmPZsygG2.WJGUblSfCV9Eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1650037126; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=ibQDI/jrfd7h9yAxNYkfTQuei0FaTwwZMK4v9rQ5dMk=;
 b=RNOD+6MDxRweZaUY7o+/szK7kfqC8uWoixhopyTc6jcxOkOhvSmshlNqLAkEXqpMHrr06
 MOd3p4C7ggi8TAEfbrA68elUCCVwIY5IvFJ40eGGAIpzBkaiAVG+T8jjxPU0mL308HlZH9F
 Dikq29FcEzFLsL7og1FLZYSMxSbit7y9pi9sWiKNeA3qOXX0UTyXPT+bx1aZtPKVyeA9N4E
 S6tzHDBu3kj1HQQxTM1GQFoc/H6cTArrvwNciQ5bd5UbbR8HX54iPfNt0HbI57PcB3FYfhb
 WtpkQCryuwdMotJTuh0/yTZ/t7n4Tf6Yp4nWu0kGNNfw8R0pIi5KMlx8tg9w==
X-Mailman-Approved-At: Fri, 15 Apr 2022 16:00:22 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,

I am unable to boot 5.18-rc1(2) kernel with my rather old (si) XFX card, 
which works fine under 5.17.3 and previous kernels.

The card is identified as:

1:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] 
Cape Verde PRO [Radeon HD 7750/8740 / R7 250E]

Running on a Asus M5A99FX PRO R2.0 mainboard.

The boot process stops at "fb0: EFI VGA frame buffer device" step and 
the hdmi connected monitor just shuts off, there's not oops or any other 
debug output captured by serial console.

I was able to bisect the kernel tracing this to a bad commit:

git bisect bad 3712e7a494596b26861f4dc9b81676d1d0272eaf
# first bad commit: [3712e7a494596b26861f4dc9b81676d1d0272eaf] 
drm/amd/pm: unified lock protections in amdgpu_dpm.c

And reverting this commit on 5.18-rc2 kernel makes my system bootable again.

Please let me know if there's anything else i could provide to help fix 
this issue. I have access to serial console if needed.

Thank you.
