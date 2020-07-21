Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBA0C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28750206C1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iLuhWxZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28750206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB2F1893CB;
	Tue, 21 Jul 2020 18:21:11 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Tue, 21 Jul 2020 18:21:10 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A514893CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 18:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1595355668;
 bh=9hahJX1wBErtfPGctPMGc+TxM3hrk3yzbMmVPYxkuYU=;
 h=X-UI-Sender-Class:Reply-To:Subject:To:References:From:Date:
 In-Reply-To;
 b=iLuhWxZsj3MDx+WKsjnQxv0BsDHMTKA6do45hCHqqJhFHdVvjm8Z5ws1hgxjP9KJ5
 lsyiT8gmJokZP32Gv+na7YfgxY8vYbtGiKtb+8Jfwy5PqXRARLIXI2aMLhtG7x3mZa
 llXu1wr0iKRJmS6eZT7g0diJ+nRSKA5U0tJppesw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.5] ([178.27.135.239]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wlv-1kzeIv21f7-012KFt for
 <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 20:16:04 +0200
Subject: Re: Amdgpu kernel oops and freezing graphics
To: amd-gfx@lists.freedesktop.org
References: <44e135ed-dfb7-533f-3c55-8e852a349762@gmx.de>
 <CADnq5_PcEo7sXFpEoKLj5q4J52ehtGjMvQzUFPHLcHObR3Q94A@mail.gmail.com>
From: Harvey <harv@gmx.de>
Message-ID: <796fb0f5-d2fa-0456-5f5e-9413c9fb5a0f@gmx.de>
Date: Tue, 21 Jul 2020 20:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_PcEo7sXFpEoKLj5q4J52ehtGjMvQzUFPHLcHObR3Q94A@mail.gmail.com>
Content-Language: de-DE
X-Provags-ID: V03:K1:4CLvG+Jx8AIrRXIPyi9IuyemyV4LHT9I3tGZ5MnVGOHPO5Q5xVB
 M2M4DP/orMbgWKUv+NtzbiBEXNH3o7lRj/dn3nDH3HnKsAhS83c7oLolhryfkWxd2j21+LR
 cA4lkh8Yhm/9HVKoppvyiU0+GZrAlhkJ/MMrqHfATF1bLSJiXZd0viN8NMMB4uN2ryUxuQI
 Gx3TS5X1nKpNsup8sKEFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7zd4rQJRbpI=:iMHvEuNNHyloipvehgy9Vh
 45I+i5tSCzWs+ID64qPCgPuWQR6t/fTANrN6C+/TU4X+OazDW5zZ/cdsyTqyDI42cPX6RCBk0
 icrsLXrbw6XjI4w3TM0I1feiSJAzO1kABggkf/RmbmQ5v+2A74WAFhlDKGt0ZspDCQ2CZkvRD
 aWQ3zwspm2mzMekgLeoGD67NA2hnKU38JAdS1e2RTxe+30vphNyRoVNn4esVyAJT1RP6xaACU
 fst4WKER6k/oQDT2jLCTFtu7HyxsFUbVoiH9H36JGrbFrSSkFqebmYp/ybmTVGDvO57idPdmy
 LiUrUj15LqB30NDHuot8Ud5GhF3VsF1qcd6CHwR0MnvxbYyvBmuF/31B3TehQ36/QmRPCEhnK
 z/vFO3iBOK1yp+yVQHqu3iOsn9EJ5nLi3j/pHB6KoHadRvQFwSJRDLd1wRsLXd7tj2Fekv1OM
 15p0JdgdTGQHXYuz+pfocPFQn52RskiW/JzQnaigAPHhAHidO+5hs2murPzgAB58aT3KvFKeS
 YOmyznj+rGXdVghGB/DJdq4x6fTPr4MogiN3BtfmNY1ve6HcBT70Yct3UasvXxw1YOOr05vXV
 yaIi5VS6zyqYHLF7LrLglgxOT0wgK6aWHpwxQlvByUVvPJgCPWBz6OWdbdyaGxXhETPB8bHJr
 KuCFNjhbxEO8TrFJpBseVyD1o62F+4gKDegJmBNsxYhazFwfnhyDjAkQlVI3vN2Aq1vV3RdwZ
 wCXp+LQIBctP/ZRGrud5nBzxnIPFq+jrbJ7VmJFqYbp/xYlQyUzMeYc5fanYVEnaSD7yUEVzj
 ETQq/Zylu1jTXSU3Tbnkz8hhzvUtSoRQ+Z8b8qZfQe7IzqwOD3z6lfXaA8wlSvIZAzMVGn3Uh
 d1gx/G6l/iUe8vJWb2lalN8D8E5kD0cgmE6xIoLhLAVdtWHAWvnuTLpOJJ/xUOpHncbPfXqQe
 nuFpYIGsj/T6qVeFRMflqvoplXZCTIUYZJBsakUE1mr3C1p/dquF64l8b2JdDcS7KCK5Ex5hf
 nfdD6qbOmzPkt9+kiFyYN9bBUH2ftJ2DTWb/1rSPW2CACpdTWyO0TFBEF4uQZwQy0aVqGNCKb
 a2pKVrTRk6dgNiiTifvr0HFhHGoZ3tkY5C/lmdJtK7ojpnTHHGtvIIfqYOsSZQpPbWy36rBcX
 aY/oEmEaXBmnhC6jERY7HV8rK/TtD0/oVOAwtd0Y5o3wxJu/GvLZjFbveHaeHu9jxJh7d15Fo
 jt2rJyLYDSVWjj++O
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
Reply-To: harv@gmx.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Alex,

tnak you so much - you're my hero!

Am 21.07.20 um 18:17 schrieb Alex Deucher:
> On Mon, Jul 20, 2020 at 4:22 AM Harvey <harv@gmx.de> wrote:
>>
>> Hello,
>>
>> this is my first post to this list so please be patient with me ;)
>>
>> The facts:
>>
>> it is now one week that I own a new laptop, a MSI Bravo 17 A4DDR/MS-17FK
>> with Ryzen 7 4800U and hybrid graphics on a Radeon RX 5500M. I installed
>> my beloved Archlinux but I can't start any graphics withpout kernel oops
>> on it beside the normal console, even calling 'lspci' on the console is
>> provoking errors.
>>
>> I am using linux kernel 5.7.9 and linux-firmware 20200619.e96c121
>>
>> (FWIW: I even tried with a self-cmpiled kernel 5.8-rc5 and
>> linux-firmware directly from the git repository - no changes)
>>
>> The following is only part of the information I can provide but I didn't
>> want to make this mail bigger than it already is.
>
> Does appending amdgpu.runpm=0 on the kernel command line in grub help?

Yes it does. Woohoo! The system is not freezing anymore! Can I provide
any further information to get this sorted?

I will be happy to help investigating and testing if needed.

Greeintgs
Harvey

--
I am root. If you see me laughing, you'd better have a backup!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
