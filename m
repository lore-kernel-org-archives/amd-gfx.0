Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A466AC10DC3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 13:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3144F10E42F;
	Mon, 11 Dec 2023 13:57:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D33810E0BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 11:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702295121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLZ4KUgEvLDnwKAg4roHGuAnVoOR9CuyCDnJ+KhaDh4=;
 b=KY/vTYWdQbR9yndTl3iWurH15cK4vGBVQTs/ym4dUU205nVPwvDYCyt7LgiMXWgU3PWnqv
 TMPH+0R6c0dBWMgor3ducvltwZdKDJ9D8iULdEMFDiSMjQ7+InSJHIcgEJG3GM5hM/2YQW
 X++9kQr+8twmXjoCPZ8GPNqHIUaG5Iw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-853ss4eKNo-Ap9W6997FMA-1; Mon, 11 Dec 2023 06:45:20 -0500
X-MC-Unique: 853ss4eKNo-Ap9W6997FMA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-54c504e5fd0so2714763a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 03:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702295119; x=1702899919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gLZ4KUgEvLDnwKAg4roHGuAnVoOR9CuyCDnJ+KhaDh4=;
 b=dR6js1OvYsmCFXbG0FYEO/xk1ZH+eFUxfAJOMnjW5Drv61dPu19nS/FftDbGwHXdhd
 I1TVxDgsbHFDwMlUUQKNJr8YogauT3zfU6Mz7qgcyAfK/gBet0abAn6kw/yoZOxT46jd
 8MoPefxMwL5xFFBGqyINlyeOKPz739ldYGgdfDVzn/XVZaL7Fc9Wc9JNeNe8jLSl6WBN
 NYpegzvwpEhuVqTuAGL50e4Auj4Un4lO8G/QdzUFfT+FlFgzJ6I7+aciDrSVYJubPymu
 K167FRzkGmxQXlHna381R2X8Pwx/ZiUoh7j2Ne2OtutwQx7bZ+1G9XCTWteB9yDgoINM
 ShYw==
X-Gm-Message-State: AOJu0Yz9eF9lt/Q9lVR2IiN24f5PGt0gCMaVh/c6F8NMTvUpRTg9L9/z
 EdTtx46cKvLhOR7+zysghXS8YDTvDAttieSwqI11GfTWQeyeTNx0JUlvlAReAMVvWFW/3C8MfcG
 7xtbcJam7QIk3Wp7+5S4NKm4QjA==
X-Received: by 2002:a50:9e6b:0:b0:54b:1ca8:851e with SMTP id
 z98-20020a509e6b000000b0054b1ca8851emr2745808ede.2.1702295119014; 
 Mon, 11 Dec 2023 03:45:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOml1mAb2dOWnv2X7f45Je/I6NHQxu5c6wiCmMQ960C9uZmb7dhmZ+BKjrrHrKBB/58iMdXA==
X-Received: by 2002:a50:9e6b:0:b0:54b:1ca8:851e with SMTP id
 z98-20020a509e6b000000b0054b1ca8851emr2745797ede.2.1702295118690; 
 Mon, 11 Dec 2023 03:45:18 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 28-20020a508e5c000000b0054b686e5b3bsm3675915edx.68.2023.12.11.03.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 03:45:17 -0800 (PST)
Message-ID: <56f065d0-4cb5-43bb-b8d1-0ed275c54044@redhat.com>
Date: Mon, 11 Dec 2023 12:45:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and wifi
 / amdgpu due for the v6.8 merge window
To: Johannes Berg <johannes@sipsolutions.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
 <5e14be1fc61d9d7027cd50f4148eea52e40fb9d3.camel@sipsolutions.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <5e14be1fc61d9d7027cd50f4148eea52e40fb9d3.camel@sipsolutions.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 11 Dec 2023 13:57:12 +0000
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
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Johannes,

On 12/11/23 12:41, Johannes Berg wrote:
> Hi,
> 
>> Here is a pull-request for the platform-drivers-x86 parts of:
>>
>> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.Ma2@amd.com/
>>
>> From my pov the pdx86 bits are ready and the platform-drivers-x86-amd-wbrf-v6.8-1 tag can be merged by you to merge the wifi-subsys resp. the amdgpu driver changes on top.
>>
>> This only adds kernel internal API, so if in the future the API needs work that can be done.
> 
> I've been fine with the wifi bits since around v3 of the patchset ;-)
> 
> So the idea is that I'll pull this into wireless-next and then apply the
> two wireless patches on top, right?

Right.

> AFAICT, since the other patches don't depend on wireless for
> compilation, this is the only thing I need to do, i.e. no need to have
> another separate branch to send it further on, right?

Right / correct.

Regards,

Hans




