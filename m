Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29CCC5AC67
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 12:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DB7810EBCA;
	Tue, 11 Aug 2026 12:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YxhzEh3l";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAFD410EB8F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 12:26:31 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so1958176f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786451190; x=1787055990; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dcp9Xyy2hoh4eNF+HTy2sWu8AKCbGo8+F9Skb8g8ERE=;
 b=YxhzEh3lDZz9e1AZi4Vs+WNBt9SChs8zJnuVj4pFS1g+OQRwVh9EuDg1QsnN8CEqmt
 jPEgfDDSxb3LgVNboiqQ6huZEETX71l8ztip5S7WOpMRlC2epIk3hbXRo1rgFiHSqHSv
 EitbkBcf+y+R21YrrmyVT3FShnGwgrORLZ+gQlUxSHGlyPZHKhwupUIf64lAZ7JZu4qk
 z9+/fBy6VYu9NBu8KLqFJK8Yn/0QsifCgghSQ2WcLLkjBB8L7KsjiRffgekE8YRnvb/I
 roe4Ihx/ClQH7rNbFtAJAD2dAQiJNjs8X83C32kh/lHEbhMvtqbgfaUEKe7ntQnSUNIR
 VHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786451190; x=1787055990;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dcp9Xyy2hoh4eNF+HTy2sWu8AKCbGo8+F9Skb8g8ERE=;
 b=OdAj+Pch+dxa047jzUHu6RaJqy+nm+5Pd7uSUOotjpdWAiuJKt6gropRFs29hka6J5
 NssTlcASUsLwB/EYvYwfXvJao2/pN1D4MLh+TVwjTpEIlSrLdliYcb3r0jIi0kFOw1F7
 i/uUDPzMNtJndYSoj1mjcinv/RyNJB7EDVyeB3Xgm4FCHqA5l/C+Kf/BkRzwwqZoXXol
 jJEeli2aLfWcqutWsvI5lfviJG0BFvhfQJgOGmxfsY+rGTqSc6lkYDuUu+dyXWyXq+gy
 l4HZq3ipiIzAvYr/UnDSIiPSPwmvgvhgpMrP6vQaVhHbRKh8Y2alkYJ/rwVKuff0jW1A
 K0jQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKzyVFgjr1SYHhqCJqI4HdVv3H3UI5s0lew2tzeF3FaZYsO3lpE+9jx5AxyPyldYCT0txvbPkT@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3vSNRDpjwg08wwhdIqswm/OxCKGTzkbtssuVXAuw+qvKT9dgY
 2KHE2ANMMLtdCaA4k8gEXvOVMuG2UdDD6c817CzvSrRbCCP2i+eq/YlF
X-Gm-Gg: AR+sD11XhhuXHtR7eHv0duE91mfyFLwRU7v4Or5oB04NJnInkJrDkueTH5flunodHcg
 GZFVbeE5ZNLpCKLVf1QUKraMTUhSPX7KsOzl8jwUxtb23sFCmt5YJutwSKLF6to48Ybm+PekxSW
 xsDs9/WrAKBdONFz1nKlD+dkdtJce4nTCeLqJXSJarlWgRzgt/hGnVENgb4irHFvNOBrY1Khm97
 ACWfSth+AYib1p+Q3rVLObO6bY98Sp83+DJb3qCYGKo7X7k6Z+xgKj0RmMQfCgjIW6yAe9pDIZy
 vkRfdViMtLdnLoHxtRA+PEPaIcEVgOh7H8NUU0/ksp2agmmUhO7GQNkZ07nvMin1BZZaKn+vYSD
 RESrQUB0Oo259LYg8mry1G9OLjfbDuP6HdwMHiiISqsNSK8wlYlDDuIoG3k7vktEf5POaBBEWN2
 tlFAgesu4bzciOjyknIzrgz877j0QtCzW48Uz1mAmjL2UeuhOmhlpwpoFw9/Avkz6w5GW+Dkl0S
 SIM
X-Received: by 2002:a05:6000:22c9:b0:481:4810:d701 with SMTP id
 ffacd0b85a97d-4814adbb1d1mr4452767f8f.19.1786451190140; 
 Tue, 11 Aug 2026 05:26:30 -0700 (PDT)
Received: from [192.168.10.195] ([188.216.175.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a7096c5sm4247773f8f.24.2026.08.11.05.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 05:26:29 -0700 (PDT)
Message-ID: <8a0fad2d-788a-403f-a880-2f97c6708275@gmail.com>
Date: Tue, 11 Aug 2026 14:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 George Zhang <george.zhang@amd.com>
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh>
 <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
 <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com>
 <2026081151-reabsorb-calamari-7442@gregkh>
Content-Language: en-US, it-IT
From: Sergio Callegari <sergio.callegari@gmail.com>
In-Reply-To: <2026081151-reabsorb-calamari-7442@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 11 Aug 2026 12:58:16 +0000
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

On 11/08/2026 10:08, Greg KH wrote:
> We aim to be "bug compatible" with Linus's branch, otherwise the
> "pressure" to fix those bugs goes down.  But I defer to the maintainers
> of the code involved if it is being worked on, and they want it
> reverted, great, we can do that.  Otherwise we prefer to leave it as-is.

I understand. Sorry for asking about things that might be obvious to 
most people here. My expectation was that only a selected subset of the 
patches on the Linus' tree were to enter in stable, so do we really need 
to have stable "bug compatible" wrt this bug? The original behavior was 
not free of issues, but they were rather minor (a reporting issue). Now 
we have this very bad behavior where the display remains dark.

To make the matter worse, on systems that have encrypted root the screen 
remains dark also on that password prompt (observed with plymouth).

In any case, I managed testing 7.2.0RC7 and it is fine again.

Looks like the Linus' tree has more changes wrt backlight, and the 
interesting ones are probably those in the cumulative fix 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=973fd9493ec21f12e760fbbedeb7b0b2317c02f4.

Best,

Sergio


