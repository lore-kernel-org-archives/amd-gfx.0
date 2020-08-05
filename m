Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF135C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 14:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A03F2332F
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 14:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VuUhO1KE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A03F2332F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09F089C84;
	Wed,  5 Aug 2020 14:41:39 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5446889C84
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596638496;
 bh=+Rdn0YU9qRdPTm46j04ZJmkm9gEgdW9O2lK6gWJLNTg=;
 h=X-UI-Sender-Class:Reply-To:Subject:To:References:From:Date:
 In-Reply-To;
 b=VuUhO1KEFyp8lAJu5wqVHucd7FeJCTSKKVQ5NRlRbz+Tehqy6mAiDECDkJfvESCzD
 lI2OttEvitvZUfZJoAeB57fOzWFTSsB/QB7LcdjA33WRAyoeegJyIDY/s1cIoOI7Xg
 CTq+RHvnCnYIvOIvsSJl2fGOY8qf1imAHDv4oxd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.3.2] ([79.157.110.246]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNY8-1kcONU1Hsm-00ZPpX for
 <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2020 16:41:36 +0200
Subject: Re: Amdgpu kernel oops and freezing graphics
To: amd-gfx@lists.freedesktop.org
References: <44e135ed-dfb7-533f-3c55-8e852a349762@gmx.de>
 <CADnq5_PcEo7sXFpEoKLj5q4J52ehtGjMvQzUFPHLcHObR3Q94A@mail.gmail.com>
 <796fb0f5-d2fa-0456-5f5e-9413c9fb5a0f@gmx.de>
 <CADnq5_MP-j6JpW+q6XV5nqwXfgFOEvgZ_GBRP3uuinSn98CRng@mail.gmail.com>
From: Harvey <harv@gmx.de>
Message-ID: <b4aa12e3-e9bc-bdb6-7583-a9bbbddf9be2@gmx.de>
Date: Wed, 5 Aug 2020 16:41:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_MP-j6JpW+q6XV5nqwXfgFOEvgZ_GBRP3uuinSn98CRng@mail.gmail.com>
Content-Language: de-DE
X-Provags-ID: V03:K1:Avb5E0u2OOm9DfeklH4n4+Eoj4y4sqHjwc+pJyuiGaUb6Z0PC26
 01RLYnTzkJ1lP9xhhL5xdgN7Jyc9uPm1HYX4nrSYJXkWCEQuvoP8GF6yFrEmA6j7UYEYm2S
 th76NzzfqfRxHjjkkg97ujxhZ8Ospjex+n9IT/G4R0bZGjOTJQClMAQYqtsu+yD4bEGa61D
 Iol3bzFJXbpTgLhXURcqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+AB+GQmZDFw=:48Ci5QQkBkSKX93zhWVIl+
 GEaDD+bVyitK7nCF8d4VyURpo1CT7NpDNuwQTA6FfqU537YFm7h1Z9ECiYU7VlUbIY7SYFS2O
 H9RpkqiUkPP6RawcU1MbLAac1AxqYg9NbyFVhaU0qjlTenwKlSqJ/lKGz37PTrMC4ykSV/rSC
 21w7pflNYEFscrXegL5QwqTWagLtOJlEP5cV1oQjyhnQ59EsKh9TCznnCBD7xVu3DcbbMzUuD
 fRHLxwmdtGNYdfw3ytjgRL+bxUgnje0Y5znm5l622bAyF4VRttF95kI5BWnJ1KjaGJclWgtnn
 4oaCUJ0E7RDGCxwnCl/ec/RzncE2JlGpVPZebizj/m0disa4mhuCiRiE7T74nd06TgBa3JhUB
 Gzb/xnAhNMqOX5nUOdxbekP88vcdIq9q2mZqq6pzwj7sGcvLzWUSxkym7g6dSfpFFtrJGPEAV
 d5EHU72F2sv35TQryPeIUpDLZGN4AAwYvFN1hVmITNqTS4L81ZhhzKvenP1uvzo+KKSDcWDgY
 J1OnVVaOnQP2oSx1ZhPm9NRClI1bX5/ryDhWK4TI6dO8R1Y8oqNibh26j3BdtVLA3HWnD5no1
 Z+c8fgAlV4RpVE+XlSMHpfONqeFLNHnv3PSgfmW/NF+zggByvHf2r0CD5GccjduFzvS8EiSO4
 N8iRU5dKOBDqFXVLx7dviQDazxWdxpNtxzPTNbMGem4AH4Oj6d9KMsq6uR7QuL7O4jRb9lRRt
 fUMgujjYVyXBWyzHIApAvbV/rg/4DujJ+NUXd+2r4m9hvPPY1oQUWi8nuTVZUMoKYgmd1xn+X
 pTfUzo3VR5vpgttDhOQEOLOMF+VoyFf7EE7ePIG+zMvlV7FCL5lYL6cg+acmkPWDwDOsdhS7f
 CY25V+0lP4Mr6KINR+O8LOwraTpDEI6suMioTmubnGcZ6/7oE1Fyh6FXwRcXJeOQukjTIusnL
 Z/caHO/fW0/FfUy8xRW/gBnGVHAV782+grX+dYLzF3YFHGeSJecec9EWLX79RYl/YPfR4qEZz
 XHnRwj9f+mMeax04XzNfzDF7zQY6+37rw32NVTCqFWOqpfs+Z4oAlLCTfdg/K/annq0qgjTlD
 pdCQHlpZ8wrMMsG/GaZ6BfLGZk9ZMEgimbzjLrXjPLpLA7fs/IKFtuapRrHLJEWmNTo5xj5yD
 duDsrLPDscFtWHRvP1HAOv1Vljt79133wCD9TRE0jMdUnrzHW1biTvXP7ekvkjNNtyCFrtXuk
 r0k+qZ1RjnAKl36FW
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

Am 04.08.20 um 22:01 schrieb Alex Deucher:
> On Tue, Jul 21, 2020 at 2:21 PM Harvey <harv@gmx.de> wrote:
>>
>> Alex,
>>
>> tnak you so much - you're my hero!
>>
>> Am 21.07.20 um 18:17 schrieb Alex Deucher:
>>> On Mon, Jul 20, 2020 at 4:22 AM Harvey <harv@gmx.de> wrote:
>>>>
>>>> Hello,
>>>>
>>>> this is my first post to this list so please be patient with me ;)
>>>>
>>>> The facts:
>>>>
>>>> it is now one week that I own a new laptop, a MSI Bravo 17 A4DDR/MS-17FK
>>>> with Ryzen 7 4800U and hybrid graphics on a Radeon RX 5500M. I installed
>>>> my beloved Archlinux but I can't start any graphics withpout kernel oops
>>>> on it beside the normal console, even calling 'lspci' on the console is
>>>> provoking errors.
>>>>
>>>> I am using linux kernel 5.7.9 and linux-firmware 20200619.e96c121
>>>>
>>>> (FWIW: I even tried with a self-cmpiled kernel 5.8-rc5 and
>>>> linux-firmware directly from the git repository - no changes)
>>>>
>>>> The following is only part of the information I can provide but I didn't
>>>> want to make this mail bigger than it already is.
>>>
>>> Does appending amdgpu.runpm=0 on the kernel command line in grub help?
>>
>> Yes it does. Woohoo! The system is not freezing anymore! Can I provide
>> any further information to get this sorted?
>>
>> I will be happy to help investigating and testing if needed.
>
> Does appending pci=noats on the kernel command line in grub also fix the issue?

No, it does not. I tested with pci=noats on kernel 5.7.11 and 5.8 and on
both the kernel oopses and freezes again. Only amdgpu.runpm=0 does the
trick.

FWIW, booting kernel 5.8 without any parameters does not work either.

Greetings
Harvey


--
I am root. If you see me laughing, you'd better have a backup!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
