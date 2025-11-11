Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7284CD3425
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Nov 2025 13:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E724510E5BD;
	Tue, 11 Nov 2025 13:39:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UIgXPaoo";
	dkim-atps=neutral
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com
 [209.85.166.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E2710E039
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 00:17:34 +0000 (UTC)
Received: by mail-io1-f50.google.com with SMTP id
 ca18e2360f4ac-9486696aafeso332909439f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 16:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762820253; x=1763425053; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Q8HKQ4KcnH36XoiAPXuxGl+urZnJV8rIP1Qwq36EqA=;
 b=UIgXPaoohds1MS0w1urUh+ff+XYDAaDnBgr3fNro0n26jqttbCPetvCYctcre+o5Ls
 tlB9vCc6PfpHIgH+6yIHqdTG0c+kHVLelSf0Zzlvp6kOgRMAIrK89R1N+rzYuC6kzr1V
 m9itxiWSl1c64a12Zn3FbudvGCNhX7oO2y537bGmsniow9/Wd6okUfRkmVblI6DHVsb/
 a5MMTomHh8PWKQ5XRpcgvP413ZlMDriFNOdEmkaYQHJ9twHKtehkcWrg6KdKIc4C6qa7
 Pzx8xhZJkc0iMqIZ9M2sg+AB8GNYKIUE1dSJ0PzwyaHWJA+nAMzBWU6poxJ/8uMGf5Xu
 OU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762820253; x=1763425053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Q8HKQ4KcnH36XoiAPXuxGl+urZnJV8rIP1Qwq36EqA=;
 b=thE4ESlID9TZNIyp3CdNEcoar4OCJPap+L1Aotqm8y+iEPxbRBFZLo5qIZV0Qp/y+f
 8EOBNdIJFclbAZu2CpLh+W97W90ZwoV5EWIpvtueYf20g1jqwBPxlFzWWzvNEyjaLGeK
 xsbTUq0U6W/8uYcNf9jentiXifwi5uIOQWy8oyXXNY1Cz6BnMWt+pKToadEDtGdneufj
 6VghWInyluBXVaxKeg8em7QjcnORtq21Jajw4MZZsshQTpB61rtz8N6K8w3zf0G7RPNB
 2JAMB099+zlCDxDGniGS+Zr4bZentw+sERMHy7nqqZ79fywt0Ex1AiDgvyrSARse6gMo
 P9BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzboC0Yy2hKO11FDLQKsmBjBv0yWNKSRAjTJr3b0mAvnZKwJdW9Lqskm7SB/wzYRwDTBeazAve@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw++rlZYaq1nwmUsBLKIk1L97LwNwOwl0PvqzrRuQ4cPcELWp/r
 4DonnbTEnHfxKfV8kjds3h1iYzUZog3ZXvRg+XzPTN66rPQL4yKDb/BC
X-Gm-Gg: ASbGncvbNbzoGMARS+VvnLJgC1viuloWWM06ftOhXcInyw052vYQJEoGs/Xc+UTSDdw
 Zj8xbzcC77xRP1p3kOHWnIMCCFpNTJlLeHHv2sm7Nx4rZu4LrEUiAnsistGMfwr5e6mNnmGJ/VF
 Qih9yRQJQrzPHTSYBIUwcEb0bPZNMb2LctEFKIGh2ojjgu5IItx8YdLzXw3H7VWG5rrQRcN220M
 lxHFXvqJkusVIESJetUoHjvyztppd0fZWgLjnWcs0muru5XxnN0mGqqIJ81YUcmIfC8stc8aQfa
 cCJw+fn5S70Z4MKZXhWtRUzuOz0cKfOoTURV69I7LhWnjZGvPP5qJ/1HhKx/quvddV2wHZ76Jb6
 5mqyODtC+vixVWA7XEB8RylTYcyGUjlrMEmoAvxQ1N7vULi/iiCEySTWsPK0y+kZeTI1csA8Eyg
 bVHbC4IKnv2QtZ8plK19b9/BV5noFi1qJRGOnmPU4Ii0SRyd3utgU=
X-Google-Smtp-Source: AGHT+IEAm+mJm6K/xigqu97Kf9Pb7DwxatHpmYK1k/IstJxUHVyghC6X6TBmTN8zYaB+T4/gOtOTNw==
X-Received: by 2002:a05:6602:6412:b0:948:5f42:32a1 with SMTP id
 ca18e2360f4ac-94895f8ea61mr1547811039f.5.1762820253527; 
 Mon, 10 Nov 2025 16:17:33 -0800 (PST)
Received: from [100.64.0.17] (c-68-55-107-1.hsd1.mi.comcast.net. [68.55.107.1])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b746923f26sm5588519173.38.2025.11.10.16.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 16:17:33 -0800 (PST)
Message-ID: <13627c6c-f428-4520-b0d4-32fca1e7a2a0@gmail.com>
Date: Mon, 10 Nov 2025 19:17:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: use static ids for ACP platform devs
To: Alex Deucher <alexdeucher@gmail.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, boyuan.zhang@amd.com
References: <20250325210517.2097188-1-bradynorander@gmail.com>
 <CADnq5_MNBUY=jWbnq-gZQ_4_M_sBJGAgMD0bj2cMdnkoU9G=HA@mail.gmail.com>
 <9ab05b38-6f77-4b0b-8a1b-8314e2873047@gmail.com>
 <CADnq5_No+w+tco9j35GBM3+CYBTo018eLwWec278d3VBJHPQxw@mail.gmail.com>
Content-Language: en-US
From: Brady Norander <bradynorander@gmail.com>
In-Reply-To: <CADnq5_No+w+tco9j35GBM3+CYBTo018eLwWec278d3VBJHPQxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 11 Nov 2025 13:39:06 +0000
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

On 11/10/25 14:14, Alex Deucher wrote:
> On Tue, Mar 25, 2025 at 7:11 PM Brady Norander <bradynorander@gmail.com> wrote:
>>
>> On 3/25/25 6:12 PM, Alex Deucher wrote:
>>>
>>> While you are at it, can you take a look at
>>> drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c and
>>> drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c as well?
>>>
>>> Alex
>>
>> I think it makes more sense to handle that in a separate patch as it is
>> an unrelated ip block.
> 
> Sure. Can you send a patch to fix those up as well if needed?
> 
> Alex

I don't know if that driver needs this, and I also don't have that 
hardware to test it. If that driver needs this fix, then this can be 
revisited but I don't think it should block this patch being merged now.
