Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CD6CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 17:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D28A510E77E;
	Wed, 24 Sep 2025 17:13:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ma+s/IQZ";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6652C10E77E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 17:13:13 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-77f605f22easo64799b3a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758733993; x=1759338793; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ViC9tw0tv1yp8xCIYJ+A9v3YVoKMtKQ5O477dSh2cuk=;
 b=Ma+s/IQZcJ+KLmHco1Dn4EQIWmMLKiENTru46mSdyK0s2ogq/0MF3VB981QrlQR4o3
 6qCeraDYiDLUYC2kkPvDQ1SYRTelB8mmcm9qUmd7+o5oejF92wMa3/0kJ0xB7j9wvb8j
 onpuU9CYmXUyTQwqOKMBsiSb1BYveEuXc8jO+/OSM1cqQSWMd2j1IrnEky8XaQXxVt/+
 Too7l8buB2M13ZLeTELsUilv18W8Qlap/0nt3KEC/WU1zWpaXLdup2DLMuz6lTLtD14J
 Wp+xMYwNl+pe0QlbB/exOKIrfuUXaRw2bgGft6/3yRAdiYJKzgBQ80w04hSjWPbX5Yxq
 +jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758733993; x=1759338793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ViC9tw0tv1yp8xCIYJ+A9v3YVoKMtKQ5O477dSh2cuk=;
 b=WV0r14IdJIRo5uEP3/lCXUGfoGwrHxv8VsHuiCKwpiKa939LrBhkP1U86AjBsDB1Rb
 hdOpL50dJ/RZzahF/2Ssxh9h1orqvjhbOPKKx8BHucA30RtEDkv3ZH4ydrPsMDkPUleY
 KoMJUK7YeRFQOx7ptIfupkFmfXxc4jkCMkACeUoL12ZFwo2qnYiFdm9wXs6Q+w/GVaWw
 Swn6qUNwZJmrgZh6UKs+mc62i8h8MLEKM1ClvCmnHmRq2lmste6uB0NW7SNKNaWV3+W9
 l81DLmy4h/gVoO2RZPgbwM+i1KlbGz0DiAcoVcEJbgfRxQE0Ai3n5t8RJSKrETAeLi6S
 EIHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXJPC5QZHVXXUs2fF5Io8glqB4x4lBmBr3OPjyQyD8//RiR/vrP8RZeeAnT6tqoBl8pYIHh+ry@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwF0+ttybHzuNfoxvTewoyC22pee3KpRdLyTUyfMXQxr1ho2VrI
 guN/17U9Tf85OUvQ00El8mySms8ADkepvUUZgrJn+PgupRaQ82HXwsHw
X-Gm-Gg: ASbGncsOvevBu8H0DDsk0jZdsFPx9EKtse20yiQhufaoafn5IPOxyzk2Mc5PWJ/yaju
 vp98n8De5akuK3uW7NYkqRQCwI5J82BWFNUDoiamO4h0S9i1eej+gej1KQ2LhtZ0kuNqt3Fp78W
 jGgZ1yR0lVgpOUQhfqhGWo5UMFfJznXqoASfFWvsn++PZrAmff8zsKBBqt8pSB7N+TIP6hHng2V
 xVnd7waHTvDpxltkXV7u5IR4defgLI5LxVANFVlorj+FdwnY4DpNAHigpxuraHhjjCNaTAIB485
 RpIhjtkuWKcS2vEWNs7bwU0x1wJADdYj3eu/Z1ZocRHnutpHQEqOWOWpsQzwuLtSzJPJuheEivd
 GxMRbt6XsnWrp5cTlHS6dCKGW2KxRSAG0Zz7jrnnSiCQSOK8z3pm6nERLCpgGshyotg53NyD0W/
 pAEOQK0+2ljhWFIt3+xRDllR/Z4JGdBCacJUmFMY1kCKcqLQZJRM7FHXLf7ZvVTipgHB3ox8A=
X-Google-Smtp-Source: AGHT+IFL16CxT92EcPiTaY1BDq6W1nWyLF/EtNklu1fI3Pn+iBe/yDAePA996fFT5LVPQ+mttIkF7w==
X-Received: by 2002:a05:6a20:4315:b0:2e2:3e68:6e36 with SMTP id
 adf61e73a8af0-2e7d2e45e6dmr364288637.49.1758733992759; 
 Wed, 24 Sep 2025 10:13:12 -0700 (PDT)
Received: from ?IPV6:2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8?
 (20014C4E24D06700C9F588200B1ECEA8.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b551705bd02sm15076832a12.41.2025.09.24.10.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 10:13:12 -0700 (PDT)
Message-ID: <29cbab3f-083a-41a8-81a1-b0234f36152f@gmail.com>
Date: Wed, 24 Sep 2025 19:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Adjustments to common mode behavior
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
In-Reply-To: <20250924161624.1975819-1-mario.limonciello@amd.com>
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



On 9/24/25 18:16, Mario Limonciello wrote:
> As part of enablement for SI and CIK in DC Timur pointed out some
> differences in behavior for common mode handling for DC vs non DC
> code paths. This series lines up the behavior between the two
> implementations.
> 
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>

Thank you Mario, this series makes good sense to me.
My only worry is this: is it possible that removing the common modes 
from connectors like DP, HDMI, etc. will regress somebody's setup?

Two possible cases come to mind:
1. When we are unable to read the EDID for some reason
2. When the EDID is buggy and/or doesn't contain any modes
Are these issues real or am I overthinking it?

Thanks & best regards,
Timur
