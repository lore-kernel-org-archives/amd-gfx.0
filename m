Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748EFC02198
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 08:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2449B10E3A4;
	Tue, 18 Feb 2025 08:03:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OLctyaFG";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CDA10E627
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 08:03:36 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4397dff185fso19233595e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 00:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739865815; x=1740470615; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5npPDbdklZTMxIuYU+YzLoHL7NSkD8C4EhxSob5tgKo=;
 b=OLctyaFGZrvbklkwlksFd32v71FfQPWU4lgwhAYVyIckgxpz2qAT6DhUR1xI83Wb+2
 9d/dX2n1XxvlKiS1VR9THGK3WGiA4Qid4rViRHHFiG7Wg7R3pPqfW5dBsTU/RdRgCsEf
 gWFGVNH7KeUXogMgahAcUatKCbaG0BC3/86miwbySKJZEx9eINeurmrGXcIvs+sAjrfj
 MSrPIOecoRD1JL/trWOYFhLSYqNiKInYNOkY97SZJ+j/DeMTC10v+aSnkf65PjgFY9mb
 MhY7PYfdVJLMc4T5/kwLEeC/08uWKUbhKc3+gfwvqHnCYTHFgNx55f8V8ua+vwVMZ1bY
 gY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739865815; x=1740470615;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5npPDbdklZTMxIuYU+YzLoHL7NSkD8C4EhxSob5tgKo=;
 b=kXStXr2ntchN55ws1YJjIBRWHccn/AATYI8qY5us3411WoT3w0248JoaFMj+NYh0I1
 bPvp4yPIvmGPdgJT+35agJ9YMcO6Uusdm3HpWG8UK7z+9NZGgPOkxBHUcD5v/92Wf5v7
 5/Jwudg87rJWL0KO37qTKra5BRU4mwgTsK6zI4uG97XtK24gUQhACSw5kfXVGAVOnquR
 j4BrmA48A+AMbyTCD8zD7uBOGW7r0xMB2bM6wKc1qRZQcm/Er2f0ATR2olq+skIktXWr
 C+KLZVG7+Bt2tsquVkIfULG7qdyVcCpxKITdl1V1D7cQ8kN533y8HS+GmAA1KLmwywhD
 xPyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGvvZhj99ZUlG6P1Do8OcvB1i6HyokSMN7gvg+Misi5dxmXR4FoyRAGzYEV8l5Hn3GQHY54Ewo@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDr2DELDHO+zft6WbCOj46YH4R2CFZtw7zvPHuhCMG70kiQFWZ
 Mc1BT2Ych0y22i8MrUCSs8XtgM6BoXbsWEeomh6kwBdI0UAF0/fa
X-Gm-Gg: ASbGncvHSM8q74hwl3wehkAHGWOSDOmnbXAom/oua1kWZbGPjxzYv9woNsCHtC7IF5I
 rwACgBCRPTlGk7dUil0a7/y0MUqVYUBCt7uqTrawRv0+2O/kBaZ5QW3712s7GG/k62jVhQLUqsc
 pbngo8+RyXBY2k7hjhc1eeIGt+XH5WI6Jg52siKk8+j3EsjHxCEfDuLhMISI7YKG6eXsfAJGoOa
 ZRBM0qByYEkELxe0TKld2kefW+bZEzhDH1PINonQbh73vn1K+ZgypGHB7Nw4S/MUb9ugMPYLqeU
 IbTQRLw6XMYbJScRt0NzW/Usic7S6JkDkwB6FkdjN7VO
X-Google-Smtp-Source: AGHT+IFCA6Op++PqqRH2km1IikHe1NVa8hFE3PIzTLACmwC7fm363CBtKPH2JYLERCqtH+tpuTnVBg==
X-Received: by 2002:a05:600c:46d1:b0:439:6712:643d with SMTP id
 5b1f17b1804b1-4396e6a74f2mr106246975e9.9.1739865814848; 
 Tue, 18 Feb 2025 00:03:34 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25913f5asm14465027f8f.52.2025.02.18.00.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 00:03:33 -0800 (PST)
Message-ID: <97e803f4-f00e-4fb0-8ed8-714ea9960e5a@gmail.com>
Date: Tue, 18 Feb 2025 09:03:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: fix Sapphire PCI rebar quirk
To: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nirmoy Das <nirmoy.aiemd@gmail.com>
References: <20250217151053.420882-1-alexander.deucher@amd.com>
 <1654fb6c-e0e8-4dde-8554-7058cf73503d@amd.com>
 <CADnq5_NUEuMFsd__w1eGBWALxcQwtX7sa2Sn53vDjaxrqNuhPQ@mail.gmail.com>
 <CADnq5_NEhv-E9ZxHvxhBtFb_cBkPqMfu-nsQfEknO30tNBjA2Q@mail.gmail.com>
 <a2645312-0903-4fa9-9735-7f2a77986cb8@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <a2645312-0903-4fa9-9735-7f2a77986cb8@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Am 17.02.25 um 17:04 schrieb Mario Limonciello:
> On 2/17/2025 10:00, Alex Deucher wrote:
>> On Mon, Feb 17, 2025 at 10:45 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>
>>> On Mon, Feb 17, 2025 at 10:38 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>>
>>>> Am 17.02.25 um 16:10 schrieb Alex Deucher:
>>>>> There was a quirk added to add a workaround for a Sapphire
>>>>> RX 5600 XT Pulse.  However, the quirk only checks the vendor
>>>>> ids and not the subsystem ids.  The quirk really should
>>>>> have checked the subsystem vendor and device ids as now
>>>>> this quirk gets applied to all RX 5600 and it seems to
>>>>> cause problems on some Dell laptops.  Add a subsystem vendor
>>>>> id check to limit the quirk to Sapphire boards.
>>>>
>>>> That's not correct. The issue is present on all RX 5600 boards, not just the Sapphire ones.
>>>
>>> I suppose the alternative would be to disable resizing on the
>>> problematic DELL systems only.
>>
>> How about this attached patch instead?
>
> JFYI Typo in the commit message:
>
> s,casused,caused,

With that fixed feel free to add my rb. It's just that the Dell systems are unstable even without the resizing.

The resizing just makes it more likely to hit the issue because ti massively improves performance on the RX 5600 boards.

Regards,
Christian.

>
>>
>> Alex
>>
>>>
>>>>
>>>> The problems with the Dell laptops are most likely the general instability of the RX 5600 again which this quirk just make more obvious because of the performance improvement.
>>>>
>>>> Do you have a specific bug report for the Dell laptops?
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
>>>
>>> ^^^ this bug report
>>>
>>> Alex
>>>
>>>
>>>>> Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>>> Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
>>>>> ---
>>>>>   drivers/pci/pci.c | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>> index 225a6cd2e9ca3..dec917636974e 100644
>>>>> --- a/drivers/pci/pci.c
>>>>> +++ b/drivers/pci/pci.c
>>>>> @@ -3766,6 +3766,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>>>>>
>>>>>        /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
>>>>>        if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
>>>>> +         pdev->subsystem_vendor == 0x1da2 &&
>>>>
>>>>
>>>>
>>>>
>>>>>            bar == 0 && cap == 0x700)
>>>>>                return 0x3f00;
>>>>>
>>>>
>

