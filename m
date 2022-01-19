Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F504C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 02:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F7C10E564;
	Wed, 19 Jan 2022 02:35:33 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC69610E581
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 02:35:32 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id t18so769699plg.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 18:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ghW/ul0d9NEyJ9r42fCrbuuKSEOCoJslPqejWSnYe4E=;
 b=uPqM8B/AGjP0zEx3Jb1zSG/XQs3hDbbgpen5gl3SMQdeuniUTowERurn5OXzTAdvtd
 fRR1eFmNfr/L328KILrOZGgiISXNDYf/CYtmObLx+YvxxNpnFvTtDTBtXm1zKxDTtTFn
 FmCtJUT5ufM73Pc8tn8pVy7/45/n6mPTHu06ivs5vZrR2Uan/i/bNM/XUw+UZymsYMi0
 kM+j5EyyQSO60NNsEg3qFLDqjZ4HHBYI7h07UqdQkJFoi/GsAK3ypsziUF4WOQY2b9t1
 dVl3eg/PpJwmFGNOSlQkbTd10Kq3T5nfbK7BqVAsWZRV2w8nva5jJysJuEabEcuXp5WG
 UPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ghW/ul0d9NEyJ9r42fCrbuuKSEOCoJslPqejWSnYe4E=;
 b=gwr9BpZNWYhSTNMOaJGkzZk6j5PP/GTMao3fDjmA5ckV1E/pKvD0mMtAZMaK9pD8+b
 R6dp8K1r4QgCv6htAcDpmN0OMhb/Tzs/blHTJIcWbyqA2Fz3rtLaeWXXDPOKvoiS4WfC
 9GP6KtaGHUcjLyGs7UZFmRYHr4LzRp4rKisBjKbxvs9RGFBC3nfeHUf4Yyf1Ymea9S38
 eEiq0XOAiiNBTDkUZl8qTzX1rM2X5BDNV/Sl4qzAPRzs7gK+luXhh8wX2uNWSfnTLqfa
 zWHhaPHdbBB9xoFNHx26fKcAIFeZs+Y4xPBU72/Tu8Ty9+lH7VVnT7ANTyo5CbIleEc7
 Dqig==
X-Gm-Message-State: AOAM532DG+yulw2ep3w62DdXQOYTtcxp3KqPl82QG9TLFhO3HsiC9I+g
 rV8e2akRd7a67nS7iURMbJujlg==
X-Google-Smtp-Source: ABdhPJxN1s1eA9Hs8mRFndnBGoYKps6ZgVn3wyGBiRkZe12FBr3GwhWrZf3/6Z6/SAg6dI6p5UlLsA==
X-Received: by 2002:a17:902:cece:b0:14a:73bb:e75 with SMTP id
 d14-20020a170902cece00b0014a73bb0e75mr30647215plg.115.1642559732396; 
 Tue, 18 Jan 2022 18:35:32 -0800 (PST)
Received: from [10.16.129.73] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id d11sm18974996pfu.211.2022.01.18.18.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jan 2022 18:35:31 -0800 (PST)
Message-ID: <94bddda6-9823-6479-bc1d-cbb8c1079877@igel.co.jp>
Date: Wed, 19 Jan 2022 11:35:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v3 2/3] drm: add support modifiers for drivers whose
 planes only support linear layout
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220114101753.24996-1-etom@igel.co.jp>
 <20220114101753.24996-3-etom@igel.co.jp>
 <YeGFugZvwbF7l2I/@smile.fi.intel.com>
 <0cf405a1-0d2d-ed5e-abdf-be645e7a9209@igel.co.jp>
 <YeaOHqfTcf+evbVC@smile.fi.intel.com>
From: Esaki Tomohito <etom@igel.co.jp>
In-Reply-To: <YeaOHqfTcf+evbVC@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <mdaenzer@redhat.com>,
 Daniel Stone <daniel@fooishbar.org>, Lee Jones <lee.jones@linaro.org>,
 Rob Clark <robdclark@chromium.org>, Takanari Hayama <taki@igel.co.jp>,
 amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
 Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Abhinav Kumar <abhinavk@codeaurora.org>,
 Alex Deucher <alexander.deucher@amd.com>, Sean Paul <seanpaul@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Evan Quan <evan.quan@amd.com>, Mark Yacoub <markyacoub@chromium.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Simon Ser <contact@emersion.fr>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Damian Hobson-Garcia <dhobsong@igel.co.jp>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022/01/18 18:53, Andy Shevchenko wrote:
> On Mon, Jan 17, 2022 at 02:15:48PM +0900, Esaki Tomohito wrote:
>> On 2022/01/14 23:16, Andy Shevchenko wrote:
>>> On Fri, Jan 14, 2022 at 07:17:52PM +0900, Tomohito Esaki wrote:
>>>> The LINEAR modifier is advertised as default if a driver doesn't specify
>>>> modifiers.
>>>
>>> ...
>>>
>>>> +	const uint64_t default_modifiers[] = {
>>>> +		DRM_FORMAT_MOD_LINEAR,
>>>> +		DRM_FORMAT_MOD_INVALID
>>>
>>> + Comma?
>>
>> There is no mention in the coding style about adding/removing a comma to the
>> last element of an array. Is there a policy in drm driver?
>>
>> I think the advantage of adding a comma to the last element of an array is
>> that diff is only one line when an element is added to the end.
>> However since INVALID is always the last element in the modifiers array, I
>> think it can be either in this case.
>> If there is a policy, I will match it.
> 
> Indeed, but there is a common sense. The idea behind (multi-line) definitions
> that when next time somebody will add an element in the array, there are will
> be:
> 
> a) no additional churn (like in case of this patch, if the item will be added
>     at the bottom;
> 
> b) an element that may not be added behind the terminator, which will look
>     weird.
> 
> That said, the question is if the element is terminator one or not, if not,
> comma is better than no comma and vise versa.
> 

Ah I see. In this case, DRM_FORMAT_MOD_INVALID is terminator, so it
should not have a comma.

Thanks
Tomohito Esaki
