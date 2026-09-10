Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F5DC79FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 14:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DFDE10F492;
	Thu, 10 Sep 2026 14:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="tFzJW1cc";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA3D10F492
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 14:44:41 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so12291106a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1789051480; x=1789656280; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+Sggb/yob4z5ntQx2PQmAeF0TT1qAbm9yFCDAVBjjQE=;
 b=tFzJW1ccVvK0+CoxUU8zHNJoz0JihSPVIAUNhauo3YgyBSJClJOFproOjFUtNhyKhQ
 fC1sHp8+sT0w1whhKIRKh0+tjs7risHqWDoMzSQ0CMZ1dvCQ8MPgJAMlBoNdrJ0XSvP5
 R/eHeR8NN3yV37pCui76pm3+bw6mLJKiARq3rJy2HzqRbeZLlT/oPo+m+PS53vqw7RyI
 Ch+zI9OBrsEZAzi76PEZwDmMwfOKw3nWOpodcRJoxJK5ka4PYJJJmhqG0MGbP+mp42ma
 kKp84ukRhDIuQgCIk6EGnK3FAtxwdmvOR4YGFBM/07ZH+Tg1cvhj9GYSare49oiYUkox
 RZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789051480; x=1789656280;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+Sggb/yob4z5ntQx2PQmAeF0TT1qAbm9yFCDAVBjjQE=;
 b=H4ZBTHNKgQtXIG9sIkfKE5HGaUIhQlm23DxGBCn/Z0To0TlvdAu9qXErBkQ+GpAhjE
 CYBQRRSOxU29/qdrx8Rpa1Zgbi7AkFhP27GejRqBp1ik8GtLwM7AoCmLDDvDAud625n/
 Y4Gt7Euj8ls/qwCD9WmAomQRCh4uvU7MU7YGIunX0hYk1e6cQ8JLky5f2QFf8cRqQ49i
 DbiNg5Z1pYI60jwpn4uzc/gpbj+aIotAm1U5QqnOZAdmPEKZ+kU5i4cbQcy1tunCEgzq
 lQQUIVl4AvzS6MFMaJf14mLyiYT8Sv0PeAl1cR756nZUTg62pXao14BBucGi/eovF6bM
 RI+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlwbN3m8VpwClcUK6mlHXyzE3qVxHCFDf9YMkJdNLVdSp1cEIvurvbT40bzi5yjp0+IaWNWSOp@lists.freedesktop.org
X-Gm-Message-State: AFuF++ljBIAC+Jg1IJXsavv6RiX0nS0ZbUzvbk5zG9ia/ZTag22uCdix
 b56ZQlFlgS2GSGBYJtDNE45/VaT91Or2zxZU/iTRcDZZ7xoguxjNXDXF/pcgwRON3g4=
X-Gm-Gg: AYBFou0/KwOA/QHh6zkb6dcNKGImZVMtNy65zKdpihj1DVDula7JTjnMyk1TrKstfv8
 bG/CcpzC9PhuceBRFwySI6b6SeTo556yO988y6cU2u/mNF5jNuyuI2WHM8Aar17MMDhwgWZ7E4H
 pfDme75jttvsvZNHdnZnH+F9ZqQOubQXLIeW0ko1Ys0nTuNwINF5KqCtlHKioBTtRDA1BbdTqRm
 a9jqmHoLGstRuQHp4vTtsdnAcIWZSEdbNzmDV9++1Ag/7YXkYNvw/uQA3o5ZNlsNsyBl0DseKax
 b3zc0t6HcH8vUtSHofvSYWEmhoeHFzvG/vjtMjqbZwnBAsOw9nH0CZ1cwTWX+sC2CcS0aTn7ARA
 yiVL/nODPq3wIIPUBvQzA38ugpegdRzM2daG3AkFPoSoguyf9xsWMMyyS+h3zfEd30d2kMTqesW
 WCRleTgrXHSmU0o658HvbpsmFRzPBZXfv7MezrpSLMII46FWz5+IVXfSZQo519ybhq3Vh8Ms00C
 WCx1hFhmHKTg8AwsLH2cXP6XQ==
X-Received: by 2002:a05:6402:1ecd:b0:6a9:9522:f893 with SMTP id
 4fb4d7f45d1cf-6a99522fac4mr4301917a12.35.1789051479997; 
 Thu, 10 Sep 2026 07:44:39 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a7e6bf5072sm8218572a12.28.2026.09.10.07.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 07:44:39 -0700 (PDT)
Message-ID: <02748b13-a1d9-4323-903e-21d0d6922ad4@ursulin.net>
Date: Thu, 10 Sep 2026 15:44:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] drm/amdgpu/sdma: Refactor SDMA v4.0 functions to be
 per instance
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <nat@pixelcluster.dev>,
 Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260907203316.159103-1-timur.kristof@gmail.com>
 <20260907203316.159103-11-timur.kristof@gmail.com>
 <8c9a61ed-5c68-4391-8736-251ac9deef9b@ursulin.net>
 <hzs0nGCHSt6jpoHrzEB04w@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <hzs0nGCHSt6jpoHrzEB04w@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 08/09/2026 09:14, Timur Kristóf wrote:
> On 2026. szeptember 8., kedd 9:41:48 közép-európai nyári idő Tvrtko Ursulin
> wrote:
>> On 07/09/2026 21:33, Timur Kristóf wrote:
>>> This prepares the code for implementing recovery for SDMA 4.0.
>>>
>>> Reorganize the SDMA 4.0 code so that the functions that are
>>> responsible for managing the SDMA engines take an instance ID
>>> as an argument.
>>>
>>> This makes it possible to manage the SDMA instances
>>> independently of each other, which will enable us to
>>> also use these functions to implement resetting and
>>> recovering them independently.
>>
>> Radom patch to drop a comment on the whole series. It looks clean and
>> reasonable to me. Once the pre-requisite series is reviewed I can do a
>> more detail pass and slap an r-b to it.
> 
> Thanks! If we agree this is the right approach, I would like to do the same
> refactor for all the newer SDMA blocks as well for the sake of consistency.
> 
> This refactor is necessary because I want to reuse the same functions for
> implementing per-instance SDMA soft reset (as opposed to duplicating a lot of
> code which seems to me to be more error-prone).
> 
>> One discussion point could be is do we maybe want the prototype for all
>> to be "struct amdgpu_sdma_instance *" instead of "struct amdgpu_device,
>> const u32 instance_id"?
> 
> I don't want to complicate this with the amdgpu_sdma_instance struct, because
> these functions only need the instance ID, and only for the purpose of knowing
> the register offset.

Fine by me to keep the signatures as you have them.

Regards,

Tvrtko


>> Could I also interest you in a related cleanup:
>>
>> https://lore.kernel.org/amd-gfx/20260622143649.54632-1-tvrtko.ursulin@igalia
>> .com/#t
>>
>> ?
> 
> I've taken a quick look, I'd suggest a different approach to it.
> I will reply on your commits.
> 
> Thanks & best regards,
> Timur
> 
> 

