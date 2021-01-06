Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D7EC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 03:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F98221E9
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 03:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F98221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0B96E3DA;
	Thu,  7 Jan 2021 03:06:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37836E250
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 22:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609972380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E1uCuRMPwY6rbQaS9q5J5lgxaRKnhXyzQCScUQ0wlnI=;
 b=C/27krOB6PHQ1F6ZlHdlgcWZiLR2E63K/XnqUWfgHo50ilgvzo2tmwDiCHMyEZX1sHX1Lt
 HD07a7MoheQpVyoxflnZ5Z52bubPRSYV30XfYqzz5dG6nUOQc/Dt7xCfzxakelvewRx+Ke
 jSmi5pQl/Kjnv/tUzlUW6RHmlrb9kS4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-5KqQf9eXPeCtDRi5kDwRYA-1; Wed, 06 Jan 2021 17:32:58 -0500
X-MC-Unique: 5KqQf9eXPeCtDRi5kDwRYA-1
Received: by mail-ed1-f71.google.com with SMTP id k5so2435143edk.15
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Jan 2021 14:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E1uCuRMPwY6rbQaS9q5J5lgxaRKnhXyzQCScUQ0wlnI=;
 b=mcundqYmgXr5yd0sbOWHw0E2l2ARyJqk8bXAfynDND+hRWEGdEvwXaXEWdpBaNciVl
 dBIgmI07/YDcLOYDHd4IzgA5gTIHrs2nogp/tjyno6YO+Et3Dm9qN6lzcH/VNz+jmerZ
 +qVux9eXuvx2Fz9XeH+8WPY4dPFnFGu9lWF3KoEHptdTvgguWn7M3Wiy/bZZ/OQQu6SM
 Z43lgKyAR2rDfmYP/ES+WS9q02a2pL624ngbQdRJDhbNsOpqOgPHkmnemT0q+vkfW1Fs
 +L5w+7MS3KvPYde2W2QxDMpLEMA2lI+2sPT+Q1/X4iOJi+EBDATkvgwDiDGaqicsPqcK
 u+Pw==
X-Gm-Message-State: AOAM530s3SQA/TIHVq1v7v45YeveTsZ0mXMYtksbKi8a7erWTTbr4mQS
 JToxoftG5N7Oy/zQ9lpHxJIFVsR1sFOhlfrA0QuGudEVN9CAk1SCfdLu1Fb3jbIZ1bnl6d419nv
 u2Jhe5toYDtHAVoxe3H/e0MSgEw==
X-Received: by 2002:a17:906:94cf:: with SMTP id
 d15mr4175698ejy.271.1609972376967; 
 Wed, 06 Jan 2021 14:32:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpeeYhzEzjRmUbsHQtGiTtaJvgCwRSwnjIHdFmIv23Gxw4gg79SFLt5Pe6N3jFFdyTuN0PzA==
X-Received: by 2002:a17:906:94cf:: with SMTP id
 d15mr4175680ejy.271.1609972376674; 
 Wed, 06 Jan 2021 14:32:56 -0800 (PST)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
 by smtp.gmail.com with ESMTPSA id ho12sm1768077ejc.45.2021.01.06.14.32.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jan 2021 14:32:56 -0800 (PST)
Subject: Re: radeon kernel driver not suppressing ACPI_VIDEO_NOTIFY_PROBE
 events when it should
To: Alex Deucher <alexdeucher@gmail.com>
References: <ed5b59f0-cfbf-57e8-2cdf-2d0e2c0c45bf@redhat.com>
 <CADnq5_NSBBP+c+7aGpBkUSx6h4_7zz8o-yUW3ffW0Jn2GFD1AQ@mail.gmail.com>
 <c11f3b78-a100-4657-7c07-1c3894296a5d@redhat.com>
 <CADnq5_PrbSaof8bub7t=vS_w0LxQ7RpAPDxKMci-hJvSJD=GJA@mail.gmail.com>
 <e7b9e416-634a-9dc2-8b1d-56224fead017@redhat.com>
 <CADnq5_OtViYP+6+s8kdQLhKsCwatcsnGqjXxrS5bpyKMk2a2pg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <1070409a-8d67-9d67-83fc-03365b65541b@redhat.com>
Date: Wed, 6 Jan 2021 23:32:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_OtViYP+6+s8kdQLhKsCwatcsnGqjXxrS5bpyKMk2a2pg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Approved-At: Thu, 07 Jan 2021 03:06:28 +0000
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
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <mdaenzer@redhat.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 1/6/21 9:38 PM, Alex Deucher wrote:
> On Wed, Jan 6, 2021 at 3:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 1/6/21 8:33 PM, Alex Deucher wrote:
>>> On Wed, Jan 6, 2021 at 1:10 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 1/6/21 6:07 PM, Alex Deucher wrote:
>>>>> On Wed, Jan 6, 2021 at 11:25 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>
>>>>>> Hi All,
>>>>>>
>>>>>> I get Cc-ed on all Fedora kernel bugs and this one stood out to me:
>>>>>>
>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1911763
>>>>>>
>>>>>> Since I've done a lot of work on the acpi-video code I thought I should
>>>>>> take a look. I've managed to help the user with a kernel-commandline
>>>>>> option which stops video.ko (the acpi-video kernel module) from emitting
>>>>>> key-press events for ACPI_VIDEO_NOTIFY_PROBE events.
>>>>>>
>>>>>> This is on a Dell Vostro laptop with i915/radeon hybrid gfx.
>>>>>>
>>>>>> I was thinking about adding a DMI quirk for this, but from the brief time
>>>>>> that I worked on nouveau (and specifically hybrid gfx setups) I know that
>>>>>> these events get fired on hybrid gfx setups when the discrete GPU is
>>>>>> powered down and something happens which requires the discrete GPUs drivers
>>>>>> attention, like an external monitor being plugged into a connector handled
>>>>>> by the dGPU (note that is not the case here).
>>>>>>
>>>>>> So I took a quick look at the radeon code and the radeon_atif_handler()
>>>>>> function from drivers/gpu/drm/radeon/radeon_acpi.c. When successful that
>>>>>> returns NOTIFY_BAD which suppresses the key-press.
>>>>>>
>>>>>> But in various cases it returns NOTIFY_DONE instead which does not
>>>>>> suppress the key-press event. So I think that the spurious key-press events
>>>>>> which the user is seeing should be avoided by this function returning
>>>>>> NOTIFY_BAD.
>>>>>>
>>>>>> Specifically I'm wondering if we should not return
>>>>>> NOTIFY_BAD when count == 0?   I guess this can cause problems if there
>>>>>> are multiple GPUs, but we could check if the acpi-event is for the
>>>>>> pci-device the radeon driver is bound to. This would require changing the
>>>>>> acpi-notify code to also pass the acpi_device pointer as part of the
>>>>>> acpi_bus_event but that should not be a problem.
>>>>>>
>>>>>
>>>>> For A+A PX/HG systems, we'd want the notifications for both the dGPU
>>>>> and the APU since some of the events are relevant to one or the other.
>>>>> ATIF_DGPU_DISPLAY_EVENT is only relevant to the dGPU, while
>>>>> ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST would be possibly relevant to
>>>>> both (if there was a mux), but mainly the APU.
>>>>> ATIF_SYSTEM_POWER_SOURCE_CHANGE_REQUEST would be relevant to both.
>>>>> The other events have extended bits to determine which GPU the event
>>>>> is targeted at.
>>>>
>>>> Right, but AFAIK on hybrid systems there are 2 ACPI video-bus devices,
>>>> one for each of the iGPU and dGPU which is why I suggested passing
>>>> the video-bus acpi_device as extra data in acpi_bus_event and then
>>>> radeon_atif_handler() could check if the acpi_device is the companion
>>>> device of the GPU. This assumes that events for GPU# will also
>>>> originate from (through an ACPI ASL notify call) the ACPI video-bus
>>>> which belongs to that GPU.
>>>
>>> That's not the case.  For PX/HG systems, ATIF is in the iGPU's
>>> namespace, on dGPU only systems, ATIF is in the dGPU's namespace.
>>
>> That assumes and AMD iGPU + AMD dGPU I believe ?  The system on
>> which the spurious ACPI_VIDEO_NOTIFY_PROBE events lead to spurious
>> KEY_SWITCHVIDEOMODE key-presses being reported uses an Intel iGPU
>> with an AMD dGPU. I don't have any hybrid gfx systems available for
>> testing atm, but I believe that in this case there will be 2 ACPI
>> video-busses, one for each GPU.
> 
> I think the ATIF method will be on the iGPU regardless of whether it's
> intel or AMD.

Ok.

>> Note I'm not saying that that means that checking the originating
>> ACPI device is the companion of the GPUs PCI-device is the solution
>> here. But so far all I've heard from you is that that is not the
>> solution, without you offering any alternative ideas / possible
>> solutions to try for filtering out these spurious key-presses.
> 
> Sorry, I'm not really an ACPI expert.  I think returning NOTIFY_BAD is
> fine for this specific case, but I don't know if it will break other
> platforms.

Yes, I'm worried too that it might break other platforms, so that
option is of the table then.

> That said, I don't recall seeing any other similar bugs,
> so maybe this is something specific to this particular laptop.

Ok, the acpi_video.c code already has the option to suppress
key-press reporting based on either a cmdline option, or
a DMI quirk and the reporter of the issue has already confirmed that
the kernel cmdline option works around this. So I will submit a patch
for acpi_video.c to add a DMI quirk for this then. This seems more
of a workaround then a real solution, but it looks like this is
the best which we can do atm.

Regards,

Hans

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
