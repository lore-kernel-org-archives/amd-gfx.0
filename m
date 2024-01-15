Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE93C3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 17:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311FD10E35A;
	Mon, 15 Jan 2024 17:54:45 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C5B10E35A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 17:54:43 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202401151854395046; Mon, 15 Jan 2024 18:54:39 +0100
Message-ID: <7194a09a-afe8-4eae-8288-c72e2ac7d0a6@daenzer.net>
Date: Mon, 15 Jan 2024 18:54:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: de-CH-frami, en-CA
To: Friedrich Vock <friedrich.vock@gmx.de>, Joshua Ashton <joshua@froggi.es>, 
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
 <c36400bd-b8f2-4026-b989-f4e1854b05ca@gmx.de>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Autocrypt: addr=michel@daenzer.net; keydata=
 xsDiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPM0jTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD7CXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkLOwE0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpcJGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAnjICalDn2zB1
 fXqoOkGsTwElvKa5AJ9FhyKJpysFRcejfdZwrwl9xb4oOg==
In-Reply-To: <c36400bd-b8f2-4026-b989-f4e1854b05ca@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F22.65A57160.0046,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2024-01-15 18:26, Friedrich Vock wrote:
> On 15.01.24 18:09, Michel Dänzer wrote:
>> On 2024-01-15 17:46, Joshua Ashton wrote:
>>> On 1/15/24 16:34, Michel Dänzer wrote:
>>>> On 2024-01-15 17:19, Friedrich Vock wrote:
>>>>> On 15.01.24 16:43, Joshua Ashton wrote:
>>>>>> On 1/15/24 15:25, Michel Dänzer wrote:
>>>>>>> On 2024-01-15 14:17, Christian König wrote:
>>>>>>>> Am 15.01.24 um 12:37 schrieb Joshua Ashton:
>>>>>>>>> On 1/15/24 09:40, Christian König wrote:
>>>>>>>>>> Am 13.01.24 um 15:02 schrieb Joshua Ashton:
>>>>>>>>>>
>>>>>>>>>>> Without this feedback, the application may keep pushing through
>>>>>>>>>>> the soft
>>>>>>>>>>> recoveries, continually hanging the system with jobs that timeout.
>>>>>>>>>> Well, that is intentional behavior. Marek is voting for making
>>>>>>>>>> soft recovered errors fatal as well while Michel is voting for
>>>>>>>>>> better ignoring them.
>>>>>>>>>>
>>>>>>>>>> I'm not really sure what to do. If you guys think that soft
>>>>>>>>>> recovered hangs should be fatal as well then we can certainly do
>>>>>>>>>> this.
>>>>>>> A possible compromise might be making soft resets fatal if they
>>>>>>> happen repeatedly (within a certain period of time?).
>>>>>> No, no and no. Aside from introducing issues by side effects not
>>>>>> surfacing and all of the stuff I mentioned about descriptor buffers,
>>>>>> bda, draw indirect and stuff just resulting in more faults and hangs...
>>>>>>
>>>>>> You are proposing we throw out every promise we made to an application
>>>>>> on the API contract level because it "might work". That's just wrong!
>>>>>>
>>>>>> Let me put this in explicit terms: What you are proposing is in direct
>>>>>> violation of the GL and Vulkan specification.
>>>>>>
>>>>>> You can't just chose to break these contracts because you think it
>>>>>> 'might' be a better user experience.
>>>>> Is the original issue that motivated soft resets to be non-fatal even an
>>>>> issue anymore?
>>>>>
>>>>> If I read that old thread correctly, the rationale for that was that
>>>>> assigning guilt to a context was more broken than not doing it, because
>>>>> the compositor/Xwayland process would also crash despite being unrelated
>>>>> to the hang.
>>>>> With Joshua's Mesa fixes, this is not the case anymore, so I don't think
>>>>> keeping soft resets non-fatal provides any benefit to the user experience.
>>>>> The potential detriments to user experience have been outlined multiple
>>>>> times in this thread already.
>>>>>
>>>>> (I suppose if the compositor itself faults it might still bring down a
>>>>> session, but I've literally never seen that, and it's not like a
>>>>> compositor triggering segfaults on CPU stays alive either.)
>>>> That's indeed what happened for me, multiple times. And each time the session continued running fine for days after the soft reset.
>>>>
>>>> But apparently my experience isn't valid somehow, and I should have been forced to log in again to please the GL gods...
>>>>
>>>>
>>>> Conversely, I can't remember hitting a case where an app kept running into soft resets. It's almost as if different people may have different experiences! ;)
>>> Your anecdote of whatever application coincidentally managing to soldier through being hung is really not relevant.
>> But yours is, got it.
> The fundamental problem here is that not telling applications that
> something went wrong when you just canceled their work midway is an
> out-of-spec hack.
> When there is a report of real-world apps breaking because of that hack,
> reports of different apps working (even if it's convenient that they
> work) doesn't justify keeping the broken code.

If the breaking apps hit multiple soft resets in a row, I've laid out a pragmatic solution which covers both cases.


> If mutter needs to be robust against faults it caused itself, it should be robust
> against GPU resets.

It's unlikely that the hangs I've seen were caused by mutter itself, more likely Mesa or amdgpu.

Anyway, this will happen at some point, the reality is it hasn't yet though.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

