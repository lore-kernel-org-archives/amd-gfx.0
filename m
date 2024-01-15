Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0FAC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 17:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7E210E33A;
	Mon, 15 Jan 2024 17:32:10 +0000 (UTC)
X-Greylist: delayed 310 seconds by postgrey-1.36 at gabe;
 Mon, 15 Jan 2024 17:32:09 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41BA410E33A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 17:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705339927; x=1705944727; i=friedrich.vock@gmx.de;
 bh=CApaeY/ARq5lIrxzK4WvX13JhLZDzCTqWIMt+au2ATg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=CF1O9taBvwAZ1W4UruQIQfhXZ4MpzUOtOuveD9xNMA5+lUvdIICLprVsvJwvW7E/
 g0Su7A2GoZzQ8OPOoOHNLDyHO5Yj6Xun2pXZhxZR548EwmEVrh9gZmhmRmQTsJn9T
 Fg5fMZLUaV5vku81AE5SpspDidXFgcvU5urRrV8dRe2V0IoUYzdPMWWXJI9Mk5cDh
 msh0Oi1HOcnQkjal0rbirAdnxcyRHlO5ooRpZIDLFcHVjKrDcfQkaGuzTay1PyHYw
 9GyNtJWam7/6jgRTEsu8EsxneLWvmnFpJwvxx4CCtC7plkYG78Hf3TpXNI5mFRxmK
 nFeMkwQx4j8xb2A1hA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.118.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf4c-1qi5Ev3KYk-00iiDU; Mon, 15
 Jan 2024 18:26:43 +0100
Message-ID: <c36400bd-b8f2-4026-b989-f4e1854b05ca@gmx.de>
Date: Mon, 15 Jan 2024 18:26:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Joshua Ashton <joshua@froggi.es>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
 <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
 <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
 <9a07c4e4-321c-4f75-aeae-81ed90038365@daenzer.net>
 <f2153219-e791-4e97-96eb-26094d7acf87@froggi.es>
 <5c99ec8c-142d-4877-9624-c8ce0373fccd@gmx.de>
 <5ff32f43-46ea-4e74-8db4-c23e0b03b429@daenzer.net>
 <8e5cd59e-075a-480e-8452-87924580122d@froggi.es>
 <1dbe811f-64a0-4ccd-88cf-3fd30f79f7bc@daenzer.net>
Content-Language: en-US
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <1dbe811f-64a0-4ccd-88cf-3fd30f79f7bc@daenzer.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tJyQQCmvEUpMZW27lm9xIsVPumzBjh8+WK84Sd4Ng74qyYNYZ7r
 uPzv4FuUog+u7R0hdFPh/e+IXFnhwt7t9AuZZ9YyLgq0cGoIyRconUijJT97aprhA3ddyHq
 plaoJ+N7xwedvFTuLhDwDnfb4e1CezRPd14arjTsGcpzewLxRnZxtFCLv5WKM7iVG2MNpPM
 sLKQEILQ/gsXR6n5DYDxg==
UI-OutboundReport: notjunk:1;M01:P0:mX4PIGmpn7s=;y4I2Z/ewtgtf42lsqbL3oGLZ0lC
 xA7Sh4KyoWvyn731KLpP0x3lB9pxJDO7vHAWw+gu5Bg+27t4CivhMnDZ4g0fFjvAxN85SnFDw
 ArNPkQJM4lwNDKi4l4Mu4XFfJmiFQTJGFV2uZGu15JJAstmswX+DGp6GY5ylfApOHiJDozWZ/
 87JKrVCBNDWFUoPLdFX4d9hjISEK8ytTqh9j6HsisnSmZcDFj67BZX8TdQdfO1f76Vu/A7gFk
 tLMu12B24KcyWDOG5013k/pcxEXfwH1WzANWFaMUGGjaQeCY0UOm7zh/XXKOu35Pm87XqGFVd
 uql4wMfITl7M41jtIQEXe02/m1ju2trIo+1/Sa3DtbGnh7AOCOjN8CMItEbLN63XePsCEsWqU
 R5D2sdjYPZoME9auOGkmfzSzq0XrFb0Z76cjoQ7vsou0aH3xGJl6nzq4xYhSbRw+FKA+Wfq7R
 zyo0LZMSkVIox+aEg0946wApE4vvbR+IHjFpffQcWY6vzZcv2HR6e35kC1vuwjkkUAgSFteIe
 jct4goWf38PIvzfcVMPm3fLcJLQ9JC4/s5HYuqse+C8Gaqgi7m142z8ql1AHbIJZuiA0lzgFJ
 K92ndXWkAqpLVeFOS+BTE54gy3WhanYaWaPOur61tiKUfQe79eMf1nKkvdXB9FReG8+VCZOvq
 Y+8imU3JSbSm7xjgePCMgyqE4uEyn9BDRx+ZVUbJbm85q9OtyufGPYDHYbTs0PVR8AtjecunS
 IgUvuXCRmV4C7fzsVRlNDP1xLkoCwlN6oO13H2Gy7o/LqyLkNUwdVwAICNU0eFuVeXykqkLYt
 sIGp/aWebDXXGlzjsI1ltCNUeHycP2lCtwM0WKOIaeC4UQbJJCZ37c7EbD199M2Sa6ul6XNpM
 r2Zr4q6G3M7E0TJTzw5LuVR3k2SaYTv5yN2JY6YiINWCjj3DCZdTpLoi86L8cn850JEisq+tV
 R0Pxumetxcq9OQ5Q5PUAcTqiF/M=
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

On 15.01.24 18:09, Michel D=C3=A4nzer wrote:
> On 2024-01-15 17:46, Joshua Ashton wrote:
>> On 1/15/24 16:34, Michel D=C3=A4nzer wrote:
>>> On 2024-01-15 17:19, Friedrich Vock wrote:
>>>> On 15.01.24 16:43, Joshua Ashton wrote:
>>>>> On 1/15/24 15:25, Michel D=C3=A4nzer wrote:
>>>>>> On 2024-01-15 14:17, Christian K=C3=B6nig wrote:
>>>>>>> Am 15.01.24 um 12:37 schrieb Joshua Ashton:
>>>>>>>> On 1/15/24 09:40, Christian K=C3=B6nig wrote:
>>>>>>>>> Am 13.01.24 um 15:02 schrieb Joshua Ashton:
>>>>>>>>>
>>>>>>>>>> Without this feedback, the application may keep pushing through
>>>>>>>>>> the soft
>>>>>>>>>> recoveries, continually hanging the system with jobs that timeo=
ut.
>>>>>>>>> Well, that is intentional behavior. Marek is voting for making
>>>>>>>>> soft recovered errors fatal as well while Michel is voting for
>>>>>>>>> better ignoring them.
>>>>>>>>>
>>>>>>>>> I'm not really sure what to do. If you guys think that soft
>>>>>>>>> recovered hangs should be fatal as well then we can certainly do
>>>>>>>>> this.
>>>>>> A possible compromise might be making soft resets fatal if they
>>>>>> happen repeatedly (within a certain period of time?).
>>>>> No, no and no. Aside from introducing issues by side effects not
>>>>> surfacing and all of the stuff I mentioned about descriptor buffers,
>>>>> bda, draw indirect and stuff just resulting in more faults and hangs=
...
>>>>>
>>>>> You are proposing we throw out every promise we made to an applicati=
on
>>>>> on the API contract level because it "might work". That's just wrong=
!
>>>>>
>>>>> Let me put this in explicit terms: What you are proposing is in dire=
ct
>>>>> violation of the GL and Vulkan specification.
>>>>>
>>>>> You can't just chose to break these contracts because you think it
>>>>> 'might' be a better user experience.
>>>> Is the original issue that motivated soft resets to be non-fatal even=
 an
>>>> issue anymore?
>>>>
>>>> If I read that old thread correctly, the rationale for that was that
>>>> assigning guilt to a context was more broken than not doing it, becau=
se
>>>> the compositor/Xwayland process would also crash despite being unrela=
ted
>>>> to the hang.
>>>> With Joshua's Mesa fixes, this is not the case anymore, so I don't th=
ink
>>>> keeping soft resets non-fatal provides any benefit to the user experi=
ence.
>>>> The potential detriments to user experience have been outlined multip=
le
>>>> times in this thread already.
>>>>
>>>> (I suppose if the compositor itself faults it might still bring down =
a
>>>> session, but I've literally never seen that, and it's not like a
>>>> compositor triggering segfaults on CPU stays alive either.)
>>> That's indeed what happened for me, multiple times. And each time the =
session continued running fine for days after the soft reset.
>>>
>>> But apparently my experience isn't valid somehow, and I should have be=
en forced to log in again to please the GL gods...
>>>
>>>
>>> Conversely, I can't remember hitting a case where an app kept running =
into soft resets. It's almost as if different people may have different ex=
periences! ;)
>> Your anecdote of whatever application coincidentally managing to soldie=
r through being hung is really not relevant.
> But yours is, got it.
The fundamental problem here is that not telling applications that
something went wrong when you just canceled their work midway is an
out-of-spec hack.
When there is a report of real-world apps breaking because of that hack,
reports of different apps working (even if it's convenient that they
work) doesn't justify keeping the broken code.

I don't think it makes sense to argue against fixing broken code just
because it doesn't affect all apps (and is convenient for some of them).

This isn't anything personal. I don't think your experience is invalid
(I think I just misunderstood the original thread. Sorry if I came
across as condescending!), all I'm arguing is that this should be fixed
somewhere else than the kernel, because what the kernel does right now
makes it impossible to implement modern APIs fully correctly. If mutter
needs to be robust against faults it caused itself, it should be robust
against GPU resets.

>
>
>> It looks like Mutter already has some handling for GL robustness anyway=
...
> That's just for suspend/resume with the nvidia driver. It can't recover =
from GPU hangs yet.
>
>
