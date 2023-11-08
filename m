Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A13C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 14:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7559710E76F;
	Wed,  8 Nov 2023 14:11:49 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5C8010E704
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 07:40:50 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso10964319a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Nov 2023 23:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699429249; x=1700034049; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2lkiZdWgmRWFfGNffoKo4M/Hwx+l7mjg/N7m923EUjw=;
 b=cHDM+0Q/T498NJ+G+ulVzLntqAYohfxmwc4UBesGWzsu8lIygtPGfVVMo5xse88DRw
 v2+rYBFim0XSIEnqocf0jV1siYXd2UVjeUmFDsMLoipMOaSv/TsA3gYU+ULU+n4aC4Qp
 92BfRWYwtSAzZfb1h1RWCIx9f9q+U0RURzRWwilN7B5zKbOyjCA1eyrF2UE8sLwE8Qts
 qG1o+GWDy0+x+yMUmaIjFZeo4KpECcvAHS6k8Dh+f6GzGBWCE8815YJmR89bMMiFFyOI
 AfTczj2qAizunv2pOJJNCptiW4HWvwf8XswSybedQe54aTtdvUYE2dEK6VXnUgweA+Cm
 ZypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699429249; x=1700034049;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2lkiZdWgmRWFfGNffoKo4M/Hwx+l7mjg/N7m923EUjw=;
 b=MubFekw3h+ydG1b/CADr8RTqX34mFDv1oRwtTorAO1iUNUNNlkmw098XP02J/cTUvw
 c7bbmRbkTgpcPi1j0XfLuuD9Td33V7rjcXefqNAqvvOLucp0krGpIqAr74V/76ckwnqN
 BGWihdK/7l5xrnt8UOVfcjHvQhf7IU4MmCIifrIGVXXcJ/LU06ctuZkUkkJCrLJ3xHy/
 kRfOBhNMceODzSpBWxxXjUMhZJEyMBGRWgnT31+Zi9BoZW2cPjKOKMOFKEXFF0zBPBWc
 GKciR2ea00CIL0OaBD/rsYya7z3ac+xf7Y3BbMLDrhLXZuyBA6YdDLXCgxTIbTrvok1a
 Mcpg==
X-Gm-Message-State: AOJu0YzzgxrrAnwihIBQwfwhXcYLYZX0BkSffp61smyR1m7cxX50eSLT
 5rmaef09Xo3TFTeJxIZn92I=
X-Google-Smtp-Source: AGHT+IHUI++8Ml5IvltjXJxqBZQ7Dn9AocE6M02frZ1M9yKxnxNZjupKWLMoj3/lq+XdPYRi0l/4lQ==
X-Received: by 2002:a17:906:dc92:b0:9ae:420e:739b with SMTP id
 cs18-20020a170906dc9200b009ae420e739bmr567104ejc.46.1699429248305; 
 Tue, 07 Nov 2023 23:40:48 -0800 (PST)
Received: from ?IPV6:2a01:c23:c56e:b200:75f2:d482:5d42:c8a0?
 (dynamic-2a01-0c23-c56e-b200-75f2-d482-5d42-c8a0.c23.pool.telefonica.de.
 [2a01:c23:c56e:b200:75f2:d482:5d42:c8a0])
 by smtp.googlemail.com with ESMTPSA id
 l10-20020a170906078a00b009b95787eb6dsm602950ejc.48.2023.11.07.23.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 23:40:47 -0800 (PST)
Message-ID: <9a5ba6df-5d15-4c23-98cd-686b1f62e05b@gmail.com>
Date: Wed, 8 Nov 2023 08:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: fix ASPM-related issues on a number of systems
 with NIC version from RTL8168h
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
References: <20231108033359.3948216-1-li.ma@amd.com>
 <2023110845-factual-dawn-7d68@gregkh>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <2023110845-factual-dawn-7d68@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 08 Nov 2023 14:11:48 +0000
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
Cc: yifan1.zhang@amd.com, amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 mario.limonciello@amd.com, Alexander.Deucher@amd.com,
 "David S . Miller" <davem@davemloft.net>, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 08.11.2023 08:05, Greg KH wrote:
> On Wed, Nov 08, 2023 at 11:34:00AM +0800, Li Ma wrote:
>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>
>> This effectively reverts 4b5f82f6aaef. On a number of systems ASPM L1
>> causes tx timeouts with RTL8168h, see referenced bug report.
>>
>> Fixes: 4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")
>> Cc: stable@vger.kernel.org
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217814
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> (cherry picked from commit 90ca51e8c654699b672ba61aeaa418dfb3252e5e)
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c | 4 ----
>>  1 file changed, 4 deletions(-)
> 
> Is this a proposed stable tree patch?  If so, what kernel(s) are you
> wanting it applied to?
> 
This should have been sent neither to you nor stable@vger.kernel.org.
This patch has been applied to stable already, the mail is something
AMD-internal it seems.

> thanks,
> 
> greg k-h

Heiner

