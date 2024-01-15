Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273BEC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 16:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9ACE10E2FC;
	Mon, 15 Jan 2024 16:19:57 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA0E10E2FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705335579; x=1705940379; i=friedrich.vock@gmx.de;
 bh=J20WLPXZAvAnoa9IJXQEDDGftMe0YWDwgEzfQDrq1eo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=fwE7mLfeBQdkn0VHOIvbtn+hGEWkWnrB0BBD0z/+4My3+g0KvAD7tAJJ6F4easDA
 M/2MFESjFFdSQX0zlXzFi1aVQN7UGxrie6FR1XvHfyeRnudCDxQGVHbvBLS79c1lI
 A8ITsqCQDGemgr0HxfTpAZl9iIXrJotDB7915353ZvgUM8XISoz5ImAyg2TKu6s//
 pCzU3lRSyYZ6ejYsRZyPsPFE55vKUj3xp6TiKquF/YsNDu3Lle89JNl0fynfzZPnA
 D8yzF2QyIouD7SMn1NXE2aalvjaoQwNCwzITMn8VWd0ZhvKiMdLWP523RG/L07kKX
 rAJFlrpcE4oT54Y5cg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.118.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlGk-1qujhD0OkC-00dqaR; Mon, 15
 Jan 2024 17:19:39 +0100
Message-ID: <5c99ec8c-142d-4877-9624-c8ce0373fccd@gmx.de>
Date: Mon, 15 Jan 2024 17:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel@daenzer.net>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
 <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
 <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
 <9a07c4e4-321c-4f75-aeae-81ed90038365@daenzer.net>
 <f2153219-e791-4e97-96eb-26094d7acf87@froggi.es>
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <f2153219-e791-4e97-96eb-26094d7acf87@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:18wKfXbU04xivMnB7sVP5GQMRF4xVKdI8qJVuXjfB2MwsGLF6XU
 X7OTKKImPjcBB+slBaJOByEB8tw5x66D5k6k9U6HxrPSvIHP2JSo1Ynr/HujA944wx8UOVZ
 Tu2uGHUc0oTku74gICkbkpFHKg+pK7PyGoKWx3+mx6zWT1RK3Z6bfhM/Zenz+xuzVZwk9CF
 P1vbDN8QE5gWmJmRb8e9w==
UI-OutboundReport: notjunk:1;M01:P0:RVwcQOux6/U=;wcACLRq9+rEUhelrvrxslRxKSRu
 PYFPupYx/w5iihtEhy45HnBJ5xK0FtKF4FF4jBw2flho9GUCtd8miN2c8+nsuCFVJKOV4Qm37
 Ar8dsaXHq1QSaUhQI6TLHeLZCKXzdIJHL7pRC+L6/gZKbBw2xaQipQ2U+YWJaagKrJjvqlwkH
 3zIIhzbIGoD8uvDwXn3Dl02A0Y5WtMr4tTbgilvAkNOKy8qDt35Qpbw4TFmew9zobWIlLrJFl
 lR7fZuEGwDfXhMcEOquRxSjobDRn3hXbNtsE73fIJo1tSHYG6La/NVISR2841rUuoYMVMDRtv
 REn44yr9txvDgIfRNKsJi+7nz4MQmMFKOHCjSDbEy6l2dv252VnJ5i7Sn8hQ6dk1Ouf0J+M4C
 tAI8lL5btMsYxheswMgLWlfaobYdTXoEqRMq048eQosllgfuo5MdMv4bIrBfFO+CdjVUD4NxF
 927WT/0FfZUP9Uyxt6TTRA7CJIjsDWADkDMoQgk69kMjT6cFXNe9S8Q5edVRzA9moZ5CrzpHR
 OqnV3eptAL5eAhzdJgBJuwwc1QTVoV8r9qheCz7oyq/1ZbSQLJFdnrnU/0qecRNXmlm9Bh3jc
 CZXW9bUBFPgJEb0tqKxb0VPhLei3NDYGDH4HufdvX7mfzgl5h6SV9tYXAwnjNgvZpEl7eXPW2
 yj+zoOU9AH5JGoP/SSVlmWFt6SgtrbEIPh4D0PajH/1nPh8PKdlse894wD5e6M752CCCZj9wV
 aOyYrvsto0MhMWZvtd9e7F5M4KOwHEZkjtddXaLxV9lx0JIcR7tZ3PP9XkmfemEt0ZlqQ3zpJ
 x/kLw8VTZtGim+AM8IKCwvkjvJVnITyl+veeLOVuUGKjPz20jbKRULbiH0ZwQ2tBtM7XPpXhC
 1Jy39RoHFAvFTxWeOJ2Ie+jZDmdYEWauaEj6l0b1eRVnyDC8VLIeI8e5Ci7hNQpUgek25DViQ
 FjjWJs9XjJIZupKoron+qUBhlGE=
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
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 15.01.24 16:43, Joshua Ashton wrote:
>
>
> On 1/15/24 15:25, Michel D=C3=A4nzer wrote:
>> On 2024-01-15 14:17, Christian K=C3=B6nig wrote:
>>> Am 15.01.24 um 12:37 schrieb Joshua Ashton:
>>>> On 1/15/24 09:40, Christian K=C3=B6nig wrote:
>>>>> Am 13.01.24 um 15:02 schrieb Joshua Ashton:
>>>>>
>>>>>> Without this feedback, the application may keep pushing through
>>>>>> the soft
>>>>>> recoveries, continually hanging the system with jobs that timeout.
>>>>>
>>>>> Well, that is intentional behavior. Marek is voting for making
>>>>> soft recovered errors fatal as well while Michel is voting for
>>>>> better ignoring them.
>>>>>
>>>>> I'm not really sure what to do. If you guys think that soft
>>>>> recovered hangs should be fatal as well then we can certainly do
>>>>> this.
>>
>> A possible compromise might be making soft resets fatal if they
>> happen repeatedly (within a certain period of time?).
>>
>
> No, no and no. Aside from introducing issues by side effects not
> surfacing and all of the stuff I mentioned about descriptor buffers,
> bda, draw indirect and stuff just resulting in more faults and hangs...
>
> You are proposing we throw out every promise we made to an application
> on the API contract level because it "might work". That's just wrong!
>
> Let me put this in explicit terms: What you are proposing is in direct
> violation of the GL and Vulkan specification.
>
> You can't just chose to break these contracts because you think it
> 'might' be a better user experience.

Is the original issue that motivated soft resets to be non-fatal even an
issue anymore?

If I read that old thread correctly, the rationale for that was that
assigning guilt to a context was more broken than not doing it, because
the compositor/Xwayland process would also crash despite being unrelated
to the hang.
With Joshua's Mesa fixes, this is not the case anymore, so I don't think
keeping soft resets non-fatal provides any benefit to the user experience.
The potential detriments to user experience have been outlined multiple
times in this thread already.

(I suppose if the compositor itself faults it might still bring down a
session, but I've literally never seen that, and it's not like a
compositor triggering segfaults on CPU stays alive either.)

>
>>
>>>> They have to be!
>>>>
>>>> As Marek and I have pointed out, applications that hang or fault
>>>> will just hang or fault again, especially when they use things like
>>>> draw indirect, buffer device address, descriptor buffers, etc.
>>>
>>> Ok, well then I now have two people (Marek and you) saying that soft
>>> recovery should be fatal while Michel is saying that soft recovery
>>> being non fatal improves stability for him :)
>>
>> That's not quite what I wrote before.
>>
>> I pointed out that my GNOME session has survived a soft reset without
>> issues[0] on multiple occasions, whereas Marek's proposal at the time
>> would have kicked me back to the login screen every time. > 0 vs
>> effectively 0 chance of survival.
>
> The correct thing for GNOME/Mutter to do is to simply re-create it's
> context, reimport it's DMABUFs, etc.
>
> The fact that it survives and keeps soldiering on with whatever side
> effects missed is purely coincidental and not valid API usage.
>
> If you want such behaviour for hangs for Mutter, you should propose a
> GL/VK extension for it, but I really doubt that will get anywhere.
>
> - Joshie =F0=9F=90=B8=E2=9C=A8
>
>>
>> [0] Except for Firefox unnecessarily falling back to software
>> rendering, which is a side note, not the main point.
>>
>>
>
