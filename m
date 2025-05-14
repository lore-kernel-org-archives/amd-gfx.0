Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB517C3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 20:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8044B10E73A;
	Wed, 14 May 2025 20:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lOl3vN6H";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB72810E63F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 16:11:17 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-442ec3ce724so117725e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747239076; x=1747843876; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y2/V4Vh+d+a0nZcON/MiVuUcn+BjyzHoYwdbSHuLjiw=;
 b=lOl3vN6H1JCmQLfrUmDguddFHoxvKhzZAqhUto8+bnJZsHWbw9QGPECXnE9BUVQb6Q
 C6Na6LT8+fEf3yZksMe2ymZTdyWeeBx4doQFz3PNypuwhg9WmMf+sa2D1pF/kNWF5c0V
 0gI8t5EtWMBaVVd9eck/ITr8yNlGcEwZF7OJ+BcgZwNBh/hR47yXKsPvyGGJKPZytf+q
 zpi0oqH4EIsIwp2KkZG7txmHtdOQDkPrl86qKC07drRMMgCyiiWw4wR4QBGddfhd/L1d
 KO9pt3XOecxPOXlOGkualPDXEXMdXv2gXb3jYVbtq+E485RvBNjyVpUrf2wOF9hFqWMR
 r6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747239076; x=1747843876;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2/V4Vh+d+a0nZcON/MiVuUcn+BjyzHoYwdbSHuLjiw=;
 b=lgq0U5Db4Rc0aweLEPXnGimgqi/9GukLLezC44hZLqp3HKWyzJrM9E+/y/R3QKG546
 PRcyjXc2sllWjcq+g576y/QwoJh7QNh3QMpyeIXyeAW5QJBWZn7S1ZhTifFnV9mfVubG
 2Mgq+/hwJvtzkKVLl/jKejUg6laAxpIcbXMWXc1loy2IZobyd18ilGHBQIYetVKBvJqm
 kCneRQsQXcKIO/LOKsLhWKbDCr/STrdSzniK8xccQOHlykdigK2ykonSV+Me9pS0maKi
 uXQmZf9ZW7H9D7bzW6IKux5kOFcFqB4Gm4YjBR/aiXNFuf1XGGxPrrDpI9pPtUDyMb0o
 AFsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8FD+m4qmKDmBrkbXqrMBy3G5P7miistLnMqKvK1Rzgs0FZ69Dd2O4VdMGDM4PUVhcjuoRLDxW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqsGFW3RACeWHbAkiy7v0oXV49Bxgiv4duf5Qq7+rUQTWd7htO
 V0rcsL9TIb3v5GFyp0AhTxUlKyl+5ronMnsp0OhnlmBUoXfIPo14
X-Gm-Gg: ASbGnctn0efqvlJyyLMe58R7HQgtaQyCNo5dT0cUqf3AxpUPCz9HjzYocqaGdvOOYhS
 lQ+99AzlBLmLaqf2lGsAV1M1W44W5VsT+xfEFg7Y8dh1H+8O6wAiLMavChwiwPsJs8czlzVkxP3
 VLO/I5lvr6UUOievG70GCPZQxCLsgKGeq1QTCliz8rfAgnFZKYbdMsEwKKnX5MzEGAsAnLoxSKX
 fQuS7D4ENyg7gzrpvgFMRTjwfl2GJNtMEAhguoEi75vPOLfvrmfeMrB5DmpDnlf/NWMA6jSo059
 7zx7EZ+W+dRAGVfqpN4FCSV20EKxP17gX7/JpZF3C4VzckQJiR43oZq9s1mY2wc=
X-Google-Smtp-Source: AGHT+IFGHec//hF81vQxUlFa4erK/ez1voAa+p6UTDP3HcrYgaIZTtF6BiQEOAEJgs3Vbq8qTw4hYQ==
X-Received: by 2002:a05:600c:348a:b0:43c:fa0e:4713 with SMTP id
 5b1f17b1804b1-442f20bb25dmr40829335e9.2.1747239074979; 
 Wed, 14 May 2025 09:11:14 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.99.211])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f337dbb7sm35500765e9.14.2025.05.14.09.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 09:11:14 -0700 (PDT)
Message-ID: <965c9753-f14b-4a87-9f6d-8798e09ad6f5@gmail.com>
Date: Wed, 14 May 2025 18:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 220110] probably thunderbolt or pci leads to pci usage
 counter underflow
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yijun Shen
 <Yijun_Shen@dell.com>, David Perry <david.perry@amd.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>, AceLan Kao <acelan.kao@canonical.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250513194506.GA1155899@bhelgaas>
 <b2f9c88d-59b5-416f-b8d5-2e0fb1fc74fd@amd.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <b2f9c88d-59b5-416f-b8d5-2e0fb1fc74fd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 May 2025 20:23:51 +0000
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


On 5/13/25 21:51, Mario Limonciello wrote:
> On 5/13/2025 2:45 PM, Bjorn Helgaas wrote:
>>  From Denis's report at https://bugzilla.kernel.org/show_bug.cgi?id=220110:
>>
>>> I am having problems with my laptop that has a thunderbolt
>>> controller to which I connected an AMD 6750XT.
>>>
>>> The topology of my system is described in this bug:
>>> https://gitlab.freedesktop.org/drm/amd/-/issues/4014 yet I don't
>>> know if this is related or not.
>>>
>>> I experienced PC attempting to enter s2idle while playing a YT
>>> video; PC has become totally unresponsive to input in any
>>> keyboard/mouse and power button after turning off screens attached
>>> to the AMD card (the built-in screen was off already).
>>>
>>>  From a look at the logs it appears one uncorrectible AER pci error
>>> triggered a pci root reset, and that comes with a bug where the
>>> usage counter assumes a wrong value; this in turn seems to cause all
>>> sorts of weird bugs.
>>>
>>> That however is my interpretation of the attached log, that might be
>>> very wrong.
>>>
>>> This is the first time I experience this bug in a year with this
>>> laptop and I don't know how easy it is to reproduce.
>>>
>>> The kernel has been compiled from sources and it has
>>>
>>>    [PATCH v2] PCI: Explicitly put devices into D0 when initializing
>>>    [PATCH v4] PCI/PM: Put devices to low power state on shutdown
>>>
>>> as I am helping testing things. I find unlikely any of those might
>>> cause these issues especially "PCI: Explicitly put devices into D0
>>> when initializing" that has been there for a few weeks now.
>>>
>>> Thanks in advice to whoever will help me.
>
> From the logs the system didn't actually enter s2idle, but because of the failure to recover after AER he lost the external GPU.
>
> I don't expect that "PCI/PM: Put devices to low power state on shutdown" has anything to do with this issue.  This should only affect system shutdown.  (Tangentially related comment; we have another version of this on the linux-pm list now that is more generic [1]).
>
> How readily can this be reproduced?  Can you try to reproduce once more?
> Can this reproduce on an unpatched kernel?
>
I have tried many different of unpatched and patched 6.14.6 for a few hours and I could not get this same bug again.

After unsuccessfully attempting to reproduce with the kernel I have been running I decided to test the newest "PM_ Use hibernate flows for system power off" patch [1].

and that patch seems to help quickly poweroff my laptop when combined with the other mentioned patch.

> To confirm if "PCI: Explicitly put devices into D0 when initializing" is the cause can you compare the PCI state of all devices from sysfs with and without the patch in place after bootup?  Basically run this in patched kernel and unpatched kernel and let's compare.
>
> $ grep -v foo /sys/bus/pci/devices/*/power_state
>
>
unpatched: https://pastebin.com/Ym31Vjh6
patched with just "PCI: Explicitly put devices into D0 when initializing": https://pastebin.com/SSSWLgcs

diff for easy view: https://www.diffchecker.com/y5GVyEG1/


two devices were D3hot and two were unknown, while now are recognized as D0.


Having those two patches together does not seem to cause any harm and I could not reproduce the issue.

I do not believe any of those patches are the cause for the particular crash I experienced, however I do believe there is something wrong going on because on power on the amdgpu on the thunderbolt card sometimes is there sometimes is not and I have to unplug and replug it for it to work.

The only patch that alleviates this particular problem is [2] "[PATCH v3] PCI: Prevent power state transition of erroneous device" but it comes with a regression where I can no longer wake up the laptop properly.

I will write this in detail as a response to that patch given that was not part of the subject here.

[2] https://lore.kernel.org/linux-pci/aCLNe2wHTiKdE5ZO@wunner.de/T/#m90fb151a4ab4af5ec8c667a27eb98bf43a9942dc

> [1] https://lore.kernel.org/linux-pm/20250512212628.2539193-1-superm1@kernel.org/T/#u
