Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC04D111A8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 08:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE8B10E2E9;
	Mon,  1 Dec 2025 08:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KGBmiUQ7";
	dkim-atps=neutral
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com
 [209.85.166.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F6E410E173
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Nov 2025 13:48:10 +0000 (UTC)
Received: by mail-io1-f50.google.com with SMTP id
 ca18e2360f4ac-949325df6c8so183343839f.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Nov 2025 05:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764510489; x=1765115289; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eiQ3eFN12BMemKB9ngyDX/zYtCqwPFyCoway1CJnXQo=;
 b=KGBmiUQ7RThdWebxJtTti8LVZ6Xqg8KnV16X4ZVtql68qgwo/hAutGnOr9p433uaiV
 +v5Gn3cyR0Fp8t9Ro0YYKtETOI35pGj1nV16q0wnm/ICLNlve3qfqjIE4M9xCd6QJCCf
 IJ2eSBa5udTE/ymEhEuHtBdCvHRr6lWXeOe19HXRfRQ3O7dowtdkAplyUJqD1w2ep/pd
 4MHCGFONpDgWBKkhHk0wRkRLx6/MsKoH0l4Un27BZGYkr5aeWPA+YY8uvquFWQhkshkL
 lHDS1KgF/f0jdgczcTvxgY3jV86Sz98z0O4ZQ1IdW2aV9LQG5rINPk4EUi7a6f3EK8FH
 OEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764510489; x=1765115289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eiQ3eFN12BMemKB9ngyDX/zYtCqwPFyCoway1CJnXQo=;
 b=qB5eF1dYjxNW5hhTJ8zfQXBFotHllEyLE3HubMsGaHYUS+1ovlmYEBT/9y68K0Im7L
 LiQdYG2az6mKEIPfkcLBVwc5hHR4Sil/2YjcyyjtulvHjToL/BmR6HkjPY4rAqNRTomx
 m+H+SucSpz7+xsVUuHawr6p0507MnSiuPREa1JFDX+iszE5rrtnTNxIviz5UwMKA2VUx
 G1e1G6GcrZust97fz1TP6pUMNUo8n5OwZ9HQbHE5laI67bpT4DKGbtr4z7KkLDWl3B7q
 LQqhtW+EHfIaDLBL+uI1u5SUjfJ+M0FV0jkOZBvkzMRQnU3JX0tqmaVGiUMuPJqGjNG2
 tC5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz8CZOr5ULIx7s8uzjf8ldV+HTzkDfBocPR3kvWrZNtUsAvIa+brp17r1JxjPlPwq0ycsmb94v@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxp9Uf4PUE+Ug9z53a61jUhSt7IwebcatGGMIC5YVKTECXkV7TS
 1fbYw68Gr6zMlxSH19uu11ZFvSM30IrgWy+sU5tydnmDwLvtQ6XCEsPH
X-Gm-Gg: ASbGncvpN6t/6qJESXDbnLaP8/hrRIyQP0e5XJd+AY6jO8HO/iFSYJ2dHE8GiREpTnv
 KFvxJNdL2s7+DX517kcYIiimNyHncxU5tylGslr24I8PcY0Ab67eqK9prh2bzHELmtDtaKiuldE
 J5KZ/vRZzk6o8RFbb7uuwDH2IQy3vOUTJvYCPi+GUurv4E7c2WokwXL5PHk0axkA8YDKUsKjN9l
 ClwTAphNVnfJdGrwetKxsB/hS8Bn213rmIQsqT1rj4aJYxduHcx4I0Zu+hy1TjfS6CHHAKYdXgj
 3G9hIFPdUqeHdKQp7ZZ2I/gj9Mzl4KL6pPdoIh4eg4HJbJa3Toq2tQzc2TStrL3D2+xoTs7CsTg
 EptAM6Mhe8R+tPjIff/7TwT+dgwr8j6ejm3yN8AfI4ZyrO1Kzr5ft6PXCaq1ix94lMXvBN89jzi
 iOxt3pZH/wTjbQxrK2Kiroxmkd
X-Google-Smtp-Source: AGHT+IHoHXUfTkF+vaS1pnIVRKSps09fJdophVLtTYQOKUkmnHvUYngKhUIxBBlieYeLEpnP+wV2vA==
X-Received: by 2002:a05:6638:8805:b0:5b7:c969:85f3 with SMTP id
 8926c6da1cb9f-5b967a01c06mr35061717173.4.1764510489137; 
 Sun, 30 Nov 2025 05:48:09 -0800 (PST)
Received: from ?IPV6:2601:40a:8000:28d9::dbf? ([2601:40a:8000:28d9::dbf])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b9bc767d6fsm4592649173.34.2025.11.30.05.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Nov 2025 05:48:08 -0800 (PST)
Message-ID: <7462992a-fdc1-44ff-9604-ca5a9feaef07@gmail.com>
Date: Sun, 30 Nov 2025 08:48:07 -0500
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
X-Mailman-Approved-At: Mon, 01 Dec 2025 08:20:38 +0000
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

Sorry to nag again, but can we look into getting this patch merged? The 
ASoC patch has already been merged and it would be nice to have audio 
working on this platform.
