Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5DAC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 18:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B6E110E057;
	Mon, 15 Jan 2024 18:04:35 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39AC610E057
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 18:04:34 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e7e2e04f0so7353535e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705341872; x=1705946672; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6C+JvXqWZ89XNdJd8IKYHLqPZOLLSRzJnvVUy+3MnVU=;
 b=nM14u3gvLN2KZG40UUXtRWAwmG0kfT1gS17Jw0I095uMTSv1tJ5fpa0Ye3bcnSbWfa
 tmCcdy5qPlJOdwzC5AWXVr+LR47QqrQoKIUELXT9q1w7GNwkl494eih3yai/ZcdErkgK
 5hlen2Jc4kdqsxE4rqnLA6meAE3G0oN3U/ygvoWgTeXdriBkxzxzjZ35NUkFkLrcwURC
 bg5cHYK5aPBOYzlfWaGjThv3egO3iyplY9JZCNrefayQ0hLv2rJoM1JOe+Q2bsI3wzB8
 wu0aEh/LMNBvRNvDYgsCOCmERc6SWbebM2RuksJVgKcrX6Thy6AcTzi0zKeSbFYHIXcv
 xhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705341872; x=1705946672;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6C+JvXqWZ89XNdJd8IKYHLqPZOLLSRzJnvVUy+3MnVU=;
 b=UjdivXvHCnlDRIFWngUgzXf3j6vcmCH/lzEK8rEoznOZ89a8HjocOFQ0aREirTV2Cp
 +QjDleh7FLNGowKPWBTtnaNpcN7zyqsILhmv3iNckbxjlYVBMo23gTMmzLfqb0rsTVF2
 Q9m4VlR/oijrVxKRCsCw8HL4ztKXzv1X7sgX0BL8Am6/O2QDJNTz0042Tmzqy/Oftigw
 eIYIfg0VPmehNYj/fKyY2lJXc2HwQp2q5HkhgkW7rNjoFA302HAZRg9gYHQq7Xj0YYaO
 Db4hH/ngRzvz3buLOxrebx1UZqBMNWWgZJ1dso2C/z1jIqCqVQT4u+yLHRB/5gqbRPcq
 6iFA==
X-Gm-Message-State: AOJu0YwBCIY5YJXRqs8jnxnYfM0tJNJhRFzQn5JWQ8/yKeu8t7lOiVhY
 yRrVrqhcF6bsDjNu9abXGx/hr/+o6RFN9Q==
X-Google-Smtp-Source: AGHT+IGNGkC/A7c6UaunhocdWL11IfBJDYXcDkCvUUXx+gktMxYjyF71uLsndlKOeRzpk3wUkkSV9g==
X-Received: by 2002:a05:600c:b47:b0:40e:706a:5228 with SMTP id
 k7-20020a05600c0b4700b0040e706a5228mr1497268wmr.62.1705341872559; 
 Mon, 15 Jan 2024 10:04:32 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 v23-20020a5d5917000000b00337876596d1sm12415845wrd.111.2024.01.15.10.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 10:04:32 -0800 (PST)
Message-ID: <ee2f3480-7f9b-4ba3-be7c-ae57130f3997@froggi.es>
Date: Mon, 15 Jan 2024 18:04:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Friedrich Vock <friedrich.vock@gmx.de>,
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
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <1dbe811f-64a0-4ccd-88cf-3fd30f79f7bc@daenzer.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 1/15/24 17:09, Michel Dänzer wrote:
> On 2024-01-15 17:46, Joshua Ashton wrote:
>> On 1/15/24 16:34, Michel Dänzer wrote:
>>> On 2024-01-15 17:19, Friedrich Vock wrote:
>>>> On 15.01.24 16:43, Joshua Ashton wrote:
>>>>> On 1/15/24 15:25, Michel Dänzer wrote:
>>>>>> On 2024-01-15 14:17, Christian König wrote:
>>>>>>> Am 15.01.24 um 12:37 schrieb Joshua Ashton:
>>>>>>>> On 1/15/24 09:40, Christian König wrote:
>>>>>>>>> Am 13.01.24 um 15:02 schrieb Joshua Ashton:
>>>>>>>>>
>>>>>>>>>> Without this feedback, the application may keep pushing through
>>>>>>>>>> the soft
>>>>>>>>>> recoveries, continually hanging the system with jobs that timeout.
>>>>>>>>>
>>>>>>>>> Well, that is intentional behavior. Marek is voting for making
>>>>>>>>> soft recovered errors fatal as well while Michel is voting for
>>>>>>>>> better ignoring them.
>>>>>>>>>
>>>>>>>>> I'm not really sure what to do. If you guys think that soft
>>>>>>>>> recovered hangs should be fatal as well then we can certainly do
>>>>>>>>> this.
>>>>>>
>>>>>> A possible compromise might be making soft resets fatal if they
>>>>>> happen repeatedly (within a certain period of time?).
>>>>>
>>>>> No, no and no. Aside from introducing issues by side effects not
>>>>> surfacing and all of the stuff I mentioned about descriptor buffers,
>>>>> bda, draw indirect and stuff just resulting in more faults and hangs...
>>>>>
>>>>> You are proposing we throw out every promise we made to an application
>>>>> on the API contract level because it "might work". That's just wrong!
>>>>>
>>>>> Let me put this in explicit terms: What you are proposing is in direct
>>>>> violation of the GL and Vulkan specification.
>>>>>
>>>>> You can't just chose to break these contracts because you think it
>>>>> 'might' be a better user experience.
>>>>
>>>> Is the original issue that motivated soft resets to be non-fatal even an
>>>> issue anymore?
>>>>
>>>> If I read that old thread correctly, the rationale for that was that
>>>> assigning guilt to a context was more broken than not doing it, because
>>>> the compositor/Xwayland process would also crash despite being unrelated
>>>> to the hang.
>>>> With Joshua's Mesa fixes, this is not the case anymore, so I don't think
>>>> keeping soft resets non-fatal provides any benefit to the user experience.
>>>> The potential detriments to user experience have been outlined multiple
>>>> times in this thread already.
>>>>
>>>> (I suppose if the compositor itself faults it might still bring down a
>>>> session, but I've literally never seen that, and it's not like a
>>>> compositor triggering segfaults on CPU stays alive either.)
>>>
>>> That's indeed what happened for me, multiple times. And each time the session continued running fine for days after the soft reset.
>>>
>>> But apparently my experience isn't valid somehow, and I should have been forced to log in again to please the GL gods...
>>>
>>>
>>> Conversely, I can't remember hitting a case where an app kept running into soft resets. It's almost as if different people may have different experiences! ;)
>>
>> Your anecdote of whatever application coincidentally managing to soldier through being hung is really not relevant.
> 
> But yours is, got it.

Yes, as what I am stating is backed by the specification for the APIs we 
are using.
You previously said things are not black and white, but it very 
explicitly is -- we have specifications for a reason!

Your app just-so happening to survive a command buffer being ignored is 
not a useful or valid addition to this discussion at all.

- Joshie 🐸✨

> 
> 
>> It looks like Mutter already has some handling for GL robustness anyway...
> 
> That's just for suspend/resume with the nvidia driver. It can't recover from GPU hangs yet.
> 
> 

