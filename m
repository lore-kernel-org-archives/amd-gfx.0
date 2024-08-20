Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A910BC3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 04:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 217BD10E3B1;
	Tue, 20 Aug 2024 04:39:27 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B3F510E3B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 04:39:25 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-42819654737so39070535e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 21:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724128763; x=1724733563;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTjGr6TMsCDdXxH/Js7p8tKp5f3+qu+HUSXH6ORnMIA=;
 b=xOltv+Qu/WBo8N+wJfPB80ixJWmdIIaOFBO2Q4V7uDSnhLQ3t2tqOJ71AyR2/jfVdE
 KE+5rwdK14OfbjzSB4DxU9s5/PBRvVBhXuiBc5XTcS5IZ17T/m3FLrEuotlHZ1IDbB9Y
 CbN/O2CIGFp6iUjZLg92UDI7VQR8L1Uq4x9FMV2IL8PbP18N4Fd38rjDQz9jRaXrb/k2
 kawtr/oEZE931ZWguoPDc9kMVDJRDkdnAYCawuUER66pJevj+oRPbnQo33DRh/MiS4ca
 kLNzk2atxoVZc5qf6bMPLcO7O9mkmP40wEN0KNocPHkHbhmvRp8mmKui5hGmbTq976d3
 UHRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlz60S92JFGptf58H6FK55hOTtIBXv38uOZgEEtLcwQpnrPXl9NJVpsccdBKBleF3nHzjvOXo3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySTBPK4yxr6+lZF5vIDnUx/psaZJW62Puz3yOb8wL7/XJCRAxk
 Iu83VVnMycZAVO0oJhkJ1yAp4sV77oozBGMuHAcTwFArGnhLQb3r
X-Google-Smtp-Source: AGHT+IGw6e4J6VHUZdN+QnOwgMoLjCSSaFpBuKEyOnqRqfJO5YF6oXAjuzrWKpNMhSiH6I4QPTl/Kw==
X-Received: by 2002:adf:a45a:0:b0:371:879f:5cc0 with SMTP id
 ffacd0b85a97d-371946a4289mr7691706f8f.42.1724128763125; 
 Mon, 19 Aug 2024 21:39:23 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed648f4asm129292505e9.5.2024.08.19.21.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 21:39:21 -0700 (PDT)
Message-ID: <bf1a557a-efd5-4b83-9291-fd7e45795f40@kernel.org>
Date: Tue, 20 Aug 2024 06:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 090/263] drm/amdgpu/pm: Fix the param type of
 set_power_profile_mode
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "patches@lists.linux.dev" <patches@lists.linux.dev>,
 Sasha Levin <sashal@kernel.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240812160146.517184156@linuxfoundation.org>
 <20240812160149.990704280@linuxfoundation.org>
 <ecca67e7-4c71-4b51-a271-5066cb77a601@kernel.org>
 <0155b806-628b-4db7-ac87-7ba21013aefd@kernel.org>
 <BL1PR12MB514424F261930331FF6E58DBF78C2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <BL1PR12MB514424F261930331FF6E58DBF78C2@BL1PR12MB5144.namprd12.prod.outlook.com>
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

On 19. 08. 24, 22:12, Deucher, Alexander wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Jiri Slaby <jirislaby@kernel.org>
>> Sent: Monday, August 19, 2024 3:54 AM
>> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
>> stable@vger.kernel.org
>> Cc: patches@lists.linux.dev; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Sasha Levin <sashal@kernel.org>; Koenig,
>> Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;
>> amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 6.10 090/263] drm/amdgpu/pm: Fix the param type of
>> set_power_profile_mode
>>
>> FTR:
>> Delivery has failed to these recipients or groups:
>> Ma Jun (Jun.Ma2@amd.com)
>> The email address you entered couldn't be found
>>
>> So the author of the patch CANNOT respond. Anyone else?
> 
> This was a Coverity fix.  As to why it was pulled into stable, I think Sasha's scripts picked it up.

Sorry, but again, why do we change the kernel to _silence_ Coverity? We 
do not do this even for compilers.

I am asking, why do you call this a fix at all? What does it fixes?

And finally, Coverity has a "False positive" selection box to dismiss a 
warning for good. One needs not changing the code.

thanks,
-- 
js
suse labs

