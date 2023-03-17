Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819D8C6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 13:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25A610E38A;
	Fri, 17 Mar 2023 13:53:24 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 952B910E12B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 13:53:22 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id p4so4495603wre.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1679061201;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sf2EzmszfayDZXR8xQc0hu0uplDiup5f+buBzAe9IsQ=;
 b=BhD8Zibb3MqqVao3YlB9w0ZWIp0Ku5RlBhdEjDhv4ebMr1lusO0UkoW50kjoZDR8o/
 28AEWozyfXwKbTXS8srTyX1BbZXLat5FAPFhuIbGD3juHZ/UtaMhnCwYmZyhoot79NUE
 5f7FWpGEohGGpR/zNJHcWuMyzlnM5TBHipyLDSBSFXVFWoZW03p5hJO3tjwf2S4vOYbP
 tubgJEAP8qXzz/uCW5Ex5oyq+O/EJ3HpqHKpjGjQ9F5rLU+dJI7pTisYCAYI18PcCvlI
 Ehc+p5u3myyDuIgLpvoSGfZhA+rtMhPK8SGLn/xaP5r9Tdu2y08O+DRinQbC4M7Vah0B
 mHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679061201;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sf2EzmszfayDZXR8xQc0hu0uplDiup5f+buBzAe9IsQ=;
 b=ZdqrqXkvYwzxp78JPEJh61695Ru5oAr54k7OP5mCAxKWy3J0pbG8fM1LFeuDnm6efX
 oIwsDD7tHQvlvd9A7Sw0v73/YvvXnNkuvGnJ+M4AcBb6rqR4qfTr3cOUlSuQI2BsNTjI
 UcjS7dxKdTrxVVV2IAuLdNTiHLXgt3hhh0bZGa0VoKr9n0S/YTNv15y0Rzh+73+c65Pm
 VzMDkTx5ZFVjmGRxaUT3xjo6WdFNH3fLYqbwad94AOdBTWh1Hck+xlHtNBAaW9dK2UZ7
 yvc60j1JE0RKjwlddwNV4VSGBvwigLBv4tRXVIAzq75vAt6c5TNQQBPo5Q+T23QAPQhe
 jusw==
X-Gm-Message-State: AO0yUKWw3DIGnLX58naYZQ4NrGoF1O2ExTHW50kM09c4B0LjsjyW9+fX
 PZfD6VS143Fx6zNjUMX4J4sbmg==
X-Google-Smtp-Source: AK7set8AnF5b4mFovMLeTe7debqtqGofBVhwp5mmUOKxyZN1Fkv+IQwbk0me9UrzpgEpJ7M0rKVYGQ==
X-Received: by 2002:adf:dfd2:0:b0:2ce:a862:551 with SMTP id
 q18-20020adfdfd2000000b002cea8620551mr7138668wrn.58.1679061201023; 
 Fri, 17 Mar 2023 06:53:21 -0700 (PDT)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a5d58ed000000b002c5493a17efsm2043982wrd.25.2023.03.17.06.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Mar 2023 06:53:20 -0700 (PDT)
Message-ID: <5381034e-c621-628e-d1e8-ace7ed410166@froggi.es>
Date: Fri, 17 Mar 2023 13:53:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 09/17] drm/amd/display: Register Colorspace property
 for DP and HDMI
Content-Language: en-US
To: Pekka Paalanen <ppaalanen@gmail.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20230307151107.49649-10-harry.wentland@amd.com>
 <CA+hFU4yiniJdxWOxDKnD7bTGw3QA8uSLyG5sbeiQ5oWqitTZcQ@mail.gmail.com>
 <ZBLmYzVcnBgU6uo5@intel.com> <20230316120701.523bcb37@eldfell>
 <ZBLz17f8YFmNEJlY@intel.com> <20230316133449.26b62760@eldfell>
 <ZBMNEdYWsyfVq46p@intel.com>
 <CA+hFU4zWvm3-SSjtF17zjRnshEDw27gkQDLGZRk2AbnWN8+1Vg@mail.gmail.com>
 <ZBOf0m6W3ZWPy7nc@intel.com> <20230317105335.45d6a629@eldfell>
 <ZBRiIG+TEft19Kum@intel.com> <20230317153553.5b8eb460@eldfell>
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <20230317153553.5b8eb460@eldfell>
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
Cc: Sebastian Wick <sebastian.wick@redhat.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/17/23 13:35, Pekka Paalanen wrote:
> On Fri, 17 Mar 2023 14:50:40 +0200
> Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> 
>> On Fri, Mar 17, 2023 at 10:53:35AM +0200, Pekka Paalanen wrote:
>>> On Fri, 17 Mar 2023 01:01:38 +0200
>>> Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
>>>    
>>>> On Thu, Mar 16, 2023 at 10:13:54PM +0100, Sebastian Wick wrote:
>>>>> On Thu, Mar 16, 2023 at 1:35 PM Ville Syrjälä
>>>>> <ville.syrjala@linux.intel.com> wrote:
>>>>>>
>>>>>> On Thu, Mar 16, 2023 at 01:34:49PM +0200, Pekka Paalanen wrote:
>>>>>>> On Thu, 16 Mar 2023 12:47:51 +0200
>>>>>>> Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
>>>>>>>     
>>>>>>>> On Thu, Mar 16, 2023 at 12:07:01PM +0200, Pekka Paalanen wrote:
>>>>>>>>> On Thu, 16 Mar 2023 11:50:27 +0200
>>>>>>>>> Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
>>>>>>>>>     
>>>>>>>>>> On Thu, Mar 16, 2023 at 01:37:24AM +0100, Sebastian Wick wrote:
>>>>>>>>>>> On Tue, Mar 7, 2023 at 4:12 PM Harry Wentland <harry.wentland@amd.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> We want compositors to be able to set the output
>>>>>>>>>>>> colorspace on DP and HDMI outputs, based on the
>>>>>>>>>>>> caps reported from the receiver via EDID.
>>>>>>>>>>>
>>>>>>>>>>> About that... The documentation says that user space has to check the
>>>>>>>>>>> EDID for what the sink actually supports. So whatever is in
>>>>>>>>>>> supported_colorspaces is just what the driver/hardware is able to set
>>>>>>>>>>> but doesn't actually indicate that the sink supports it.
>>>>>>>>>>>
>>>>>>>>>>> So the only way to enable bt2020 is by checking if the sink supports
>>>>>>>>>>> both RGB and YUV variants because both could be used by the driver.
>>>>>>>>>>> Not great at all. Something to remember for the new property.
>>>>>>>>>>
>>>>>>>>>> Hmm. I wonder if that's even legal... Looks like maybe it
>>>>>>>>>> is since I can't immediately spot anything in CTA-861 to
>>>>>>>>>> forbid it :/
>>>>>>>>>
>>>>>>>>> Wouldn't the driver do the same EDID check before choosing whether it
>>>>>>>>> uses RGB or YCbCr signalling?
>>>>>>>>
>>>>>>>> I suppose it could. The modeset would then fail, which is perhaps
>>>>>>>
>>>>>>> Could? What are they missing?
>>>>>>
>>>>>> The fact that the new property that also affects the rgb->ycbcr matrix
>>>>>> doesn't even exist?
>>>>>
>>>>> I think the question was about the current Colorspace property.
>>>
>>> Yes.
>>>
>>> We need to be able to set ColourPrimaries infoframe field for the sink.
>>> Only userspace knows what ColourPrimaries it uses, and the driver has
>>> no need to care at all, other than tell the sink what we have.
>>>
>>> When a driver chooses to use YCbCr, it needs to use the
>>> MatrixCoefficients the sink expects.
>>>
>>> If we send the infoframe to the sink telling the signal uses BT.2020
>>> ColourPrimaries, does that same bit pattern also tell the sink we are
>>> using the BT.2020 NCL MatrixCoefficients if the driver chooses YCbCr?
>>>
>>> Do drivers actually use BT.2020 NCL MatrixCoefficients in that case?
>>
>> No. I think I've repeated this same line a thousand times already:
>> The current colorspace property *only* affects the infoframe/msa/sdp,
>> nothing else.

No, sorry, this is completely nonsensical.

Even with the current Colorspace property that we want to deprecate, 
drivers doing an implicit conversion from RGB -> to YCC should respect 
the colorspace property to pick the right matrix coefficients here.

Doing so simply introduces a useless mismatch that is unavoidable from 
userspace and makes absolutely no sense.

Arguing about this is kind of completely useless anyway... as we are 
deprecating this property... Let's pleeeease let it die.

I am not sure why these patches were re-submitted with my RB again after 
we had the discussion previously about making a new one that's actually 
going to get tested and have userspace consumers.

(FTR, I guess Gamescope *is* a userspace consumer for this broken 
property right now, but I am completely happy for AMDGPU upstream to 
never support this and to just move onto the new property and leave this 
one behind).

> 
> That's the problem. I don't know what that means.
> 
> Does it mean that the sink expects BT.2020 NCL MatrixCoefficients to
> have been used?

Yes.

> 
> And the driver will never use BT.2020 NCL MatrixCoefficients in any
> circumstances?

That is what Ville is describing and what I disagree with, yes.

But whether or not Ville or I agree on that is kind of irrelevant as we 
are going to deprecate the property... right... right?

> 
> See the conflict? The sink will be decoding the signal incorrectly,
> because we are encoding it with the wrong MatrixCoefficients if the
> driver happens to silently choose YCbCr and userspace wants to send
> BT2020 ColourPrimaries indicated in the infoframe.

Yeah.

- Joshie 🐸✨

> 
>>
>>>
>>> If they don't, then YCbCr BT.2020 has never worked, which is another
>>> nail in the coffin for "Colorspace" property.
>>
>> That is the same nail we've been talking about all along I thought.
>>
>>> But it still means that
>>> RGB BT.2020 may have worked correctly, and then drivers would regress
>>> if they started picking YCbCr for any reason where they previously used
>>> RGB.
>>
>> The policy has been to use RGB if at all possible. Only falling back
>> to YCbCr 4:2:0 if absolutely necessary (eg. EDID says 4:2:0 must
>> be used, or there's not enough bandwidth for 4:4:4, etc.). If the
>> behaviour suddenly changes then it probably means the driver was
>> doing something illegal before by using RGB 4:4:4.
> 
> Ok.
> 
>>>>>>>
>>>>>>> I mean, drivers are already automatically choosing between RGB and YCbCr
>>>>>>> signalling based on e.g. available bandwidth. Surely they already will
>>>>>>> not attempt to send a signal format to a monitor that does not say it
>>>>>>> supports that?
>>>>>
>>>>> That's exactly what they do. The drivers don't check the EDID for the
>>>>> colorimetry the sink supports and the responsibility is punted off to
>>>>> user space.
>>>
>>> I suspect there are two different things:
>>>
>>> - which of RGB, YCbCr 4:4:4, YCbCr 4:2:0 can the sink take
>>> - the supported MatrixCoefficients for each of the YCbCr
>>>
>>> Surely drivers are already checking the former point?
>>
>> Yes.
>>
>>>
>>> I'm not surprised if they are not checking the latter point, but they
>>> do need to, because it is the driver making the choice between RGB and
>>> some YCbCr.
>>
>> This point has been irrelevant since we always select BT.709
>> and there is no optional feature bit in EDID to check for that.
>> Presumaly it is mandatory for sinks to support both BT.601 and
>> BT.709 whenever they support YCbCr in general.
> 
> Ok, so BT.601 and BT.709 MatrixCoefficients are cool. How do you tell
> the sink which one you used, btw?
> 
> What about BT.2020 MatrixCoefficients?
> 
> 
> Thanks,
> pq
