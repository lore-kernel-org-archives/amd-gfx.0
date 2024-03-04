Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE203C48BF6
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 14:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41CC01121E9;
	Mon,  4 Mar 2024 14:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="Nyz5cy7d";
	dkim-atps=neutral
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 424C01121F6
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:Reply-To:Cc:To:From:Subject:MIME-Version:Date:
 Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 In-Reply-To:References; bh=2ow5WoWCUnT2GPprP9SShU1PL2Ham9rFrhPnQ0r3S7Y=;
 t=1709561529; x=1709993529; b=Nyz5cy7d8QLbln3xoDShJhq7tONW/2usSVW5RSN7BwXFl10
 jwWupJ7ZWISmL/WeLC08Wx4sRP+Yk0tbs6mcWPuWamU7LlbN+kiYHm/QAF/ZC/smefkjqA29afwL+
 NJi7gDiqX0BDeW622rdxH0TVWBB02VryhypP8H2Po3BHHJdxOpgt6euqOfO/b0EWnfuGIiBA+un3F
 fxS8A7Pm2skQ4sZsPbr34FXYthrgM3H5zgaxLqFT6c3tGLE5kmFvIosepLgqW0ffqW0PBm7m/0i5c
 w/5LaJYb/te8ahSNAmUO3z8pjYXLm7uHgN/3sUr3Wv+dG8XsVWQT8o7GpgHMGhaA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1rh92x-0000k1-W2; Mon, 04 Mar 2024 15:12:05 +0100
Message-ID: <6e93a748-786e-4aca-9b97-65b25e664436@leemhuis.info>
Date: Mon, 4 Mar 2024 15:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7+ broke under-powering of my RX 6700XT. (Archlinux,
 mesa/amdgpu)
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Alex Deucher <alexdeucher@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Romano <romaniox@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Greg KH <gregkh@linuxfoundation.org>
References: <ae64f04d-6e94-4da4-a740-78ea94e0552c@riadoklan.sk.eu.org>
 <2024021732-framing-tactful-833d@gregkh>
 <d369b45f-e1af-4117-83a5-3e429e3bfb23@leemhuis.info>
 <CADnq5_OgPBtYpxBQ+aBmA2t7ob7EFPFWrF9OYXNgm00eEayMNA@mail.gmail.com>
 <62bf771e-640a-45ab-a2de-3df459a9ed30@leemhuis.info>
 <CADnq5_M4Zwv0_B1DoU_a8aNpyPVJj_PpjDG_oi3JkrGC5-hNgg@mail.gmail.com>
 <4bc8747a-d87f-423b-b0ce-8891e78ae094@redhat.com>
 <a6243c3b-d773-4693-88e9-033995616f12@leemhuis.info>
 <CADnq5_MHmz=HdGA22U-bk2b+4un70bmLzpbDyc3+tjzoRAnCeA@mail.gmail.com>
 <1aa3830d-ceb7-4eb1-b5bb-d6043684507f@gmail.com>
 <CADnq5_Nc+eEfXwaXfaTz75C9ww6ETVm_adCSfGsdD6OzguUQ6Q@mail.gmail.com>
 <3e077b5f-0684-4a07-9b74-ab242bb01975@gmail.com>
 <CADnq5_NszWGKVZZomTojAm_u7O-04M6x_ox4KXQC79OuGA9ARA@mail.gmail.com>
 <af6291d4-45c3-4eb6-95b8-14a5221e72a1@leemhuis.info>
 <CADnq5_Md1yQVxfxWBju7xrqZcU18KqfaJRGcE3tumCUy_3tHoA@mail.gmail.com>
 <521c02b9-d7c6-4c0f-8259-4b66cc6f9e84@leemhuis.info>
In-Reply-To: <521c02b9-d7c6-4c0f-8259-4b66cc6f9e84@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1709561529;
 8817d1c9; 
X-HE-SMSGID: 1rh92x-0000k1-W2
X-Mailman-Approved-At: Mon, 04 Mar 2024 14:16:56 +0000
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 21.02.24 16:53, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 21.02.24 16:39, Alex Deucher wrote:
>> On Wed, Feb 21, 2024 at 1:06 AM Linux regression tracking (Thorsten
>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>
>>> On 20.02.24 21:18, Alex Deucher wrote:
>>>> On Tue, Feb 20, 2024 at 2:41 PM Romano <romaniox@gmail.com> wrote:
>>>>>
>>>>> If the increased low range is allowed via boot option, like in proposed
>>>>> patch, user clearly made an intentional decision. Undefined, but won't
>>>>> fry his hardware for sure. Undefined is also overclocking in that
>>>>> matter. You can go out of range with ratio of voltage vs frequency(still
>>>>> within vendor's limits) for example and crash the system.
>>>
>>> But we have this "no regressions" rule for a reason. Adhering to it
>>> strictly would afaics be counter-productive in this situation, but give
>>> users some way to manually do what was possible before out-of-the box
>>> IMHO is the minimum we should do.
> [...]

TWIMC, I mentioned this twice in mails to Linus, he didn't get involved,
so I assume things are fine the way they are for him. And then it's of
course totally fine for me, too. :-D

Thx again for all your help and sorry for causing trouble, but in my
line of work these "might or might not be a regression from Linus
viewpoint, so let's get him involved" sometimes just happen.

Ciao, Thorsten

#regzbot resolve: apparently not a regression from Linus viewpoint
