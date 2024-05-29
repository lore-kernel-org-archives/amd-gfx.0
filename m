Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FACBC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 15:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F85510E15C;
	Wed, 29 May 2024 15:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iq2a7W7S";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9271210E15C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 15:19:25 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4202c1d19d5so19350255e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716995964; x=1717600764; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xc27XGK8QAAFDFHs5M2vJqmodHKvjvZyhmMjUqqGbKA=;
 b=iq2a7W7SMrsg9VgEGghNoNgN5B+UzduwJieqeB+H9FGdeH3HwJw/Km9HuMVflGoX1z
 WLnpvzi3tzYs4nau3f2qZ5Z81s5s/StztVUEqYw42lkDYS94Dp3xZWF8PoajuDwT7Gts
 NU3ZTU504dlEeqaVYw82VlPLPQlUv0Vcjuu2LnC5FPUSwC37MiA31YNGZSRIA9L+lfug
 EPlzD6TKszFZhlcNaGgNXbA/1c9bVw9Vzu6Ja2KwjUSQJjdtVSSSjLesMpweeYBoFrGi
 /1ZwEDAE7ZRrdtbOsSvL/RYI7mOK6yHvuHmDlV8rud/wVIrUHUATpR/n7fKDA8H6kIXq
 l8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716995964; x=1717600764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xc27XGK8QAAFDFHs5M2vJqmodHKvjvZyhmMjUqqGbKA=;
 b=Dz7vDlMH+6fah514+lw+TXdK6E5Qd6HZH4zra4R8tIMN2qrM/n5GVa11VyCnC0fMII
 KObuTij1Ik5vcm2hhnXlUaSX2kraJjNM+B4QOFxkBuNSKLRFG2aN2oXZwwDNp9iL7uhy
 ltblIwi7F0BxSVHNqQ2hhZo81lj1WIstfQArmBQJNwxxI44+J3+vzHwZ16rGBNQmkkvw
 4G1HtPQ12m0JRa5dAtna3WmKz+FygeOFxrdwG3AM2wdAhcNnvPDnTYPDW7zLPqbhmcBH
 GGOhoiMR3JA30wIIPxr1/9UMmlna0oYdBFcjLokfXzVYqS4DAZsxDWa3eP65EpJmguf5
 CWKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcMdncxMlH7e2Q6hnhS4neTxcBCoxQ2ryxpMsbcrX6xiCvcZWstqR4OMkZuM17YFlEkQvwybSxwX0vi237+2wIW+lXN0ltCUJwskqx6Q==
X-Gm-Message-State: AOJu0YyHzmiO6h8VvvBM3CA/+oX95RH9v8yDQBEDSWL1lYR7K+avBedG
 ntQE1BlJcgu7XGL6/UeCA/mCyeiJyoI5nk/MxgGi1V4rmpcrsVUM
X-Google-Smtp-Source: AGHT+IEvSJJpwIcF81Xq+sBm/ZmHNdw3S6eBffkqR4xZ2vCNHlY2Qfy1TGq9yfgEEPoZz01oQAUSNQ==
X-Received: by 2002:a05:600c:1c03:b0:41f:e3b0:83ee with SMTP id
 5b1f17b1804b1-421089b1b29mr127205045e9.3.1716995963615; 
 Wed, 29 May 2024 08:19:23 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fb9042sm217253395e9.39.2024.05.29.08.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 08:19:23 -0700 (PDT)
Message-ID: <ab92ab3e-b96b-480e-8089-b3949f453bd3@gmail.com>
Date: Wed, 29 May 2024 17:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-4-Yunxiang.Li@amd.com>
 <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
 <SA1PR12MB8599F850C7BD44B5F66D80E8EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <a1e40066-f980-4490-a0b9-d8f3be34ad8f@amd.com>
 <SA1PR12MB85996538350B30F80330C0EAEDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b646408e-9b50-4e2a-b2b1-ab1ff9f4b366@amd.com>
 <SA1PR12MB859960F8F2B9B22E726EF6D2EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b35b5556-9919-4806-bea7-f7ed94844a04@amd.com>
 <SA1PR12MB8599AB4284E5B4415D92FF14EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <SA1PR12MB8599AB4284E5B4415D92FF14EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.05.24 um 16:48 schrieb Li, Yunxiang (Teddy):
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> Yeah, I know. That's one of the reason I've pointed out on the patch adding
>> that that this behavior is actually completely broken.
>>
>> If you run into issues with the MES because of this then please suggest a
>> revert of that patch.
> I think it just need to be improved to allow this force-signal behavior. The current behavior is slow/inconvenient, but the old behavior is wrong. Since MES will continue process submissions even when one submission failed. So with just one fence location there's no way to tell if a command failed or not.

No the MES behavior is broken. When a submission failed it should stop 
processing or signal that the operation didn't completed through some 
other mechanism.

Just not writing the fence and continuing results in tons of problems, 
from the TLB fence all the way to the ring buffer and reset handling.

This is a hard requirement and really can't be changed.

Regards,
Christian.
