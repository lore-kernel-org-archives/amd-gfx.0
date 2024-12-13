Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA68E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 08:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5104010E695;
	Fri, 13 Dec 2024 08:24:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lzXjkT0s";
	dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 904B710E314
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 04:07:15 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-215770613dbso9220925ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 20:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734062835; x=1734667635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=kiHYNsetQzoVeIG7Or2ocnrsNfqUINILWof+n9mH9SM=;
 b=lzXjkT0s3IFlqNFFUSY4BqEpkudORYf+2QnXl0vr6zHXK2HeWKvr+nOtULAVLEGwiY
 RwCVjndQaAuRtSMDyK/LQ+dcnvxlory3pA5m4KoSPHNf8TvkoKOpq9hUsmV0ayRG60N4
 D6CRhqaBYto8mhPfE56vIUKD6MWn28xqOp9AOyW/TXtplTLyMZf+/fmA+0g64abix8cB
 8Nw/uvWjLyr/sdcOh+fD3rgcvBxy/0cVdNCq+WFgEzHh4jZy6kJQGwJShuL9wl1uJl8D
 qzUBPsQXAJ+v+WoZfBoEKqFXLBlRnXLPnLOuy3+cJHMtRsh61mmH7SBFGwPomxPIJDhL
 DzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734062835; x=1734667635;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kiHYNsetQzoVeIG7Or2ocnrsNfqUINILWof+n9mH9SM=;
 b=twNvjpwuzDPhRNaXt8i+dbDD6f1jXAILjuhiAmShOnOcHgWN+fHkXRJseooWpj3Y9k
 hmuIeqHe7vFzuUWFSwvKWj84hWpZCUNXvu1WAVVnVbQifjoWdHrv5brZVnEBTopfLmH1
 HnkexbpIcUSGBshvjQaWiLmUfFnwOgqPJyDMt7y0EXcH8ZFBL9t95Fq4jogq9wDLQ0KP
 Z7BK0KINxEz7LtBUB4GH+FGYV03K/XztgMmeBSSERU1sTyeL8qeg/Y2CENdJStc8Qjyh
 ZLF5J9Qe2Myo9PKVlQQKVvmmyWzrUfJ/hUNC1eUSwAfM3e78c8SA4JcgRWOA213vAMR8
 gxqA==
X-Gm-Message-State: AOJu0Yxesu2F1xm+oBRPs6pa7PXvbZrNJUFdNFS9mpQsUW6TToT6sUMA
 U091hEstsgqpUeOWrn81lpl6P8iUcxekj/HXsEQkmlBj3+C2uazu
X-Gm-Gg: ASbGncskJ8D9WTAr96b+aJ82EvMUR4FNYQB+EqwNuMETkIL8BeJfkovPR5OAzuK7LGp
 CMhJ5ieiIC0vp1LNlfD5lUdHoxMmXwFN37sDaVaI7Y3Xtm8+LWHWTMpuQRo4tlJIHjoIsZAaNAs
 NZ4b0bvt+VAC3MPRfNoVBUSI5O9mqe/2U7KN4hhCPDea4niJMKSbf1x/WK5aQGtrLJV39f77pge
 a6vZ0V4zY08sOHTW770E8txOv/6UVtLPj3GD+FUY/LQwq710fXTA8snqZ90o8tGyT5BTANs4c8G
 aAsgJkqWQaIdB5O3nM6W4uOEydiGfg==
X-Google-Smtp-Source: AGHT+IExCfjT8JybNTAmJaeIbvRXBMXdNyhxwqffT8vtHGpK6k/rJii9U+TDz20PKdKtYMs0cMCHIw==
X-Received: by 2002:a17:902:ecd2:b0:216:6fbc:3904 with SMTP id
 d9443c01a7336-218929a17demr17433205ad.13.1734062834996; 
 Thu, 12 Dec 2024 20:07:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f63772sm127993325ad.281.2024.12.12.20.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 20:07:14 -0800 (PST)
Message-ID: <6f8621fd-b73a-4edf-b596-8b1da3df11ea@roeck-us.net>
Date: Thu, 12 Dec 2024 20:07:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/34] drm/amd/display: Add debug prints for IPS testing
To: "Hung, Alex" <Alex.Hung@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "hersenxs.wu@amd.com" <hersenxs.wu@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "Ma, Duncan" <Duncan.Ma@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
 <20240228183940.1883742-11-alex.hung@amd.com>
 <abe64cad-4ac4-4372-9d46-5e77618b3836@roeck-us.net>
 <DM4PR12MB8476E86FE65DEE9CA8DC7895F73E2@DM4PR12MB8476.namprd12.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <DM4PR12MB8476E86FE65DEE9CA8DC7895F73E2@DM4PR12MB8476.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Dec 2024 08:24:48 +0000
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

On 12/11/24 08:18, Hung, Alex wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> 
> Hi Guenter,
> 
> Thanks for the updates.
> 
> This may be a real issue. Please file a bug at https://gitlab.freedesktop.org/drm/amd/-/issues <https://gitlab.freedesktop.org/drm/amd/-/issues> and share your setup. This helps us investigate further.
> 

Opened https://gitlab.freedesktop.org/drm/amd/-/issues/3824. My apologies if it doesn't meet
reporting requirements.

Guenter

