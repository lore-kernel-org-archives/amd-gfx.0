Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EB4CAC5B0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 10:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F7A10E6EC;
	Wed, 24 Sep 2025 10:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="noi0ONrN";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E41FE10E6EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 10:44:16 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-27a6c3f482dso24288035ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 03:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758710656; x=1759315456; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kWXmm060LCiRJOG2s/VcfeqKd3isYwEF/69EtKY/YFg=;
 b=noi0ONrN58ZkSe4jafs2LFe5pooYdM6OdOlOU/Dj2YS3h3q6OJT1os1Y4UZlfCADOf
 nLev7xmhSJBxNGgqVvEiZdHdhIhszyhSGwM3b5Uo6gX5mHxGY07nnt5wGuLedCyFJaQP
 oWXMA7QyuqnNMyRwAH22Gd99EKYBeRW5sIEIUc3vmoUmFZ/7RZrGPFJzPh8hdSEnHTJW
 68QoCQvaUIdu79JsIhnUlr4Sf3qLb2swN6g88XwRnCXy4xPlQFilhvz3VsZbYFNSv/8s
 oQfMA9qoaNBgaMNe+1WDpqynLVsn98ZMQtQgeLAaMujo1lbnFqHu4yzmnZbFXBvjdxIE
 aeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758710656; x=1759315456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kWXmm060LCiRJOG2s/VcfeqKd3isYwEF/69EtKY/YFg=;
 b=xKB7DXlHeWJ/4bCZMmE3lm2qGzvkRbOg4iLHUvw6vUvTUcdn7UtQTKbTVQKkhqyfQk
 2GkUmlUtnLdyx98aRaPwXEglWU2Gdfc2UcB1Dp4jXfPIvjr9UM/w94JPgtEIQxrNwLR1
 RTOxrnludSOdekE7EFN59yWE3SVbfbxv3QltDudcVkFTP/hbkrs5C0/tmll/UphadSny
 ZKAkYbrZiy/eKVVRu/LBSt7u9GItBfZgm7MQp5p13srF2oilP5EneeC6QfkNtZY+2qdt
 I/dOQye2zhXAyOP3GVtV7hQb/WeH6vXUM5rTgtnvU2Qu9i+bvh9OY+UVoIh20JZ0Oqn/
 EVzg==
X-Gm-Message-State: AOJu0YzvW9jFbDBtkT2C/vt91B7Rt4UwQHR0u9kntp3PozFO+9W6iiRw
 brKBu/juaQZ4JmbQNCw2RJXQU1KK7e/QDBjMWvRo/yuOzKENn2kT7Pmigif/OQ==
X-Gm-Gg: ASbGncu1OIuoAaL+xg101MEZeBFNHLEzTCq8qtVMcAX8Cjq7CB3Knuw1ykYMRgZESF/
 WuJ2ceDFzbRnIaWs3bEevxuHXUZ/KjEekeTj0GJxaXtybFCi8IflkcUAkO5Y8JBuDTBBpqSHyMy
 yUhMPKUbCY49COIB9s8Ysdk300Xm6oYrltseMR7ZN6hGh5+ferxxKIk45loj8x12sQDvWRKBbRh
 s92ONFSUckXkr3sLcm3fOqFasl7aIhPjyfyw0WsQBuZm6MT6zhwQaIvx0cKZkUTJ1UQ5cQF5LXQ
 EvdcX4jVx9JQEjAXeZ8G310WFWWgbU2L9GJhN0muCX/TDWX/Qqq1dnEhQAuU0rtRAFBl4S4qHz4
 KfixAmrrmUjRVAjCRPbj/NetwU/7lPdetTr0lcqY5KnhbH78G5sNUan2p3ri3HA+31yUr3WnChW
 VctxLjwxDrdXjBiO6IvQ4SpJFNpKwRUxf+sEKpS4WHRDaJHZpRBUCMLqF81Z91
X-Google-Smtp-Source: AGHT+IFr6oaAMwLTPNCxPk/WItikFZkJ5er/57Klp7/coISbFj0XTGzUgHjFYxa+1RbR7482vMWOwQ==
X-Received: by 2002:a17:903:1105:b0:252:1743:de67 with SMTP id
 d9443c01a7336-27cc678314fmr65074845ad.44.1758710656443; 
 Wed, 24 Sep 2025 03:44:16 -0700 (PDT)
Received: from ?IPV6:2001:4c4e:24d0:6700:5d2c:718b:790:18c4?
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698016c265sm186914275ad.49.2025.09.24.03.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 03:44:15 -0700 (PDT)
Message-ID: <b445a38f-2fb1-4f4f-b91e-925624295113@gmail.com>
Date: Wed, 24 Sep 2025 12:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Reject YUV422 encoding over DP on DCE
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 alex.hung@amd.com, harry.wentland@amd.com, siqueira@igalia.com
References: <20250919081419.9034-1-timur.kristof@gmail.com>
 <CADnq5_Pj43m4C2esgH5wVFfbq5rSehSeL-7NkdwHU0ByNSRdUg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
In-Reply-To: <CADnq5_Pj43m4C2esgH5wVFfbq5rSehSeL-7NkdwHU0ByNSRdUg@mail.gmail.com>
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



On 9/19/25 17:09, Alex Deucher wrote:
> On Fri, Sep 19, 2025 at 4:14 AM Timur Kristóf <timur.kristof@gmail.com> wrote:
>>
>> Mark YUV422 unsupported over DP on DCE to work around a
>> regression caused by the recent YUV422 fallback patch.
>>
>> See https://gitlab.freedesktop.org/drm/amd/-/issues/4585
>>
>> The recent YUV422 fallback breaks DisplayPort on DCE6-10 because
>> it can select a high refresh rate mode with YUV422 and 6 BPC,
>> which is apparently not actually supported by the HW, causing
>> it to boot to a "no signal" screen.
>>
>> Tested with a Samsung Odyssey G7 on the following GPUs:
>>
>> - Cape Verde (DCE 6): affected
>> - Tonga (DCE 10): affected
>> - Polaris (DCE 11.2): not affected
>> - Vega (DCE 12): not affected
>>
>> Polaris and Vega are not affected because the same mode
>> gets rejected by other parts of the code base, possibly the
>> bandwidth calculation which exists for DCE11+ but not older HW.
>>
>> It is not documented whether YUV422 is actually supported over DP
>> on DCE, but considering that this encoding was never used before,
>> and that YUV420 is already marked unsupported, probably not.
>>
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> 
> Fixes: db291ed1732e02 ("drm/amd/display: Add fallback path for YCBCR422")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4585
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Would be good to get feedback from the display team on what the actual
> capabilities are, but seems reasonable to me.
> 
> Alex


Please disregard this patch.

I will send a different patch which will instead reject modes that would 
require a pixel clock higher than the maximum display clock.

Thanks,
Timur
