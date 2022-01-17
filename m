Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9825C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 05:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4A610E575;
	Mon, 17 Jan 2022 05:15:59 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF66010E575
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 05:15:58 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id h23so9853506pgk.11
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Jan 2022 21:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=MQeBrGkGEPprlAGgzRHSnT1m1Ox7Vg6LsQGd/Iu7NGs=;
 b=zv1yBiIyK4mMISwhtI4Pbr+dw8RVonPbi+fUCF0Xpuvz6C5K5mWFWEFBGDxt0XxQ/W
 cJXmztz1z9qEGFd5duOYIkhhcKAwVgigWrJah0RZJTHFkgg2KXkAPb2nblOOySKzR6zo
 xF9yuG9KfYQfL0YSLww/NV3NB2EME+iINMugre+MRNmHKB/gT1cEGFDwRS+FC2z481qJ
 b0dEd5MkZkDLA887VF8x3QW7/w/+iJeVmnjSSOxk6zNyoUaH1arGie2EaDF32cE3koBT
 FATnZjisTmkrXzQF0HwxO3ga5/2uWvDKoBGXsBPb8FJfxxVcFgHd1EYoeDJqWFciEHCZ
 dsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=MQeBrGkGEPprlAGgzRHSnT1m1Ox7Vg6LsQGd/Iu7NGs=;
 b=mZhqYtaBdBqZNaHY9Eohi9uJy24is8hF94s6+9BYglp6ccia+X3m+goEgv96//U95a
 mT6rp9PyA2t9G7/P/QbC/L9x+LA06CpW/5OUqrRNgTkz62NWsqEc/FhPDFqIU1BiRz3Y
 keAHjMERfmMHqVpj15delhdsTY55RGuPfqOJvoqdwISVkHDfyFD3xTjtmHvl0mAEjU0N
 DrHfg7E9ePFUJJ8ACJ6FCDIAfBCK10/QC2NaFl2njZyLU0/0N3E/1bj4vQYhy7/xdbzX
 L6XEnGJBlJ9F+FXQvycgyYSM03sANcmoIeR7TePoDh0+Fc3ZL75hm9QaDe/R3EpyEp+f
 +8Aw==
X-Gm-Message-State: AOAM5323ljvddH+7xs6L+595Ni1cgb8oPQsy/6nOcUEz1PurGBd98H1l
 Z99jWK8JlVWbWtw8GR01BaDZdg==
X-Google-Smtp-Source: ABdhPJyd50JZ5TcZwpKKG06f3DkcKlsUMm/JuuJ/PhWjAmM8kxYt86DgraRr8zaKIruizzcn/MgB3g==
X-Received: by 2002:a05:6a00:2182:b0:4a7:ec46:29da with SMTP id
 h2-20020a056a00218200b004a7ec4629damr19626922pfi.68.1642396558414; 
 Sun, 16 Jan 2022 21:15:58 -0800 (PST)
Received: from [10.16.129.73] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id p18sm12346694pfq.174.2022.01.16.21.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jan 2022 21:15:57 -0800 (PST)
Message-ID: <0cf405a1-0d2d-ed5e-abdf-be645e7a9209@igel.co.jp>
Date: Mon, 17 Jan 2022 14:15:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH v3 2/3] drm: add support modifiers for drivers whose
 planes only support linear layout
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220114101753.24996-1-etom@igel.co.jp>
 <20220114101753.24996-3-etom@igel.co.jp>
 <YeGFugZvwbF7l2I/@smile.fi.intel.com>
From: Esaki Tomohito <etom@igel.co.jp>
In-Reply-To: <YeGFugZvwbF7l2I/@smile.fi.intel.com>
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

Thank you for your reviews.

On 2022/01/14 23:16, Andy Shevchenko wrote:
> On Fri, Jan 14, 2022 at 07:17:52PM +0900, Tomohito Esaki wrote:
>> The LINEAR modifier is advertised as default if a driver doesn't specify
>> modifiers.
> 
> ...
> 
>> +	const uint64_t default_modifiers[] = {
>> +		DRM_FORMAT_MOD_LINEAR,
>> +		DRM_FORMAT_MOD_INVALID
> 
> + Comma?

There is no mention in the coding style about adding/removing a comma to 
the last element of an array. Is there a policy in drm driver?

I think the advantage of adding a comma to the last element of an array 
is that diff is only one line when an element is added to the end.
However since INVALID is always the last element in the modifiers array, 
I think it can be either in this case.
If there is a policy, I will match it.

Thanks,
Tomohito Esaki
