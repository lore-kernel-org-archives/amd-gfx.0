Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968E0C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 20:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD3323124
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 20:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD3323124
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835656E22C;
	Wed,  6 Jan 2021 20:21:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E468989E0D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 20:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609963468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qbuFD+jGV8JQ4V48J65Bx5rpJ+K0A7ULPMzMICJo3II=;
 b=ShYi84jWfRjFuFhv87XvCbqGYDree8pwOnPn5ndD350bnRBMJngtjr/D4ZoxpbCcK7EEzm
 NHUrz64pp6BwM48wGbx4T/oHCYJBxGSeuM5lpz0pRRVCUQVXmSOruXv5GdHZQqMz0G/WV3
 79SfKrpz6anB5r0FY7OmQt+QwiZ3mlo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-eAbGYqRzO7GZEyVhJJ9hLQ-1; Wed, 06 Jan 2021 15:04:27 -0500
X-MC-Unique: eAbGYqRzO7GZEyVhJJ9hLQ-1
Received: by mail-ej1-f72.google.com with SMTP id h4so1732845eja.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Jan 2021 12:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qbuFD+jGV8JQ4V48J65Bx5rpJ+K0A7ULPMzMICJo3II=;
 b=lgyu7a1DXntxrK/WGj2J6vUat4MSTD9Ffz16Mj9NoQtoWmObV3tutYhJWpynNCX2fm
 3lzf7MYpg/t9XYyMqYWdwl0JW9+xZ7dY7zzee2zUtsaiSsGyja6Fcnx84KsfCTOWXk37
 FpWXT20A+WqNuqcsy/qMZK83ltCNvwF0LSlS61kNcsU5mHbOLfrDZpLx8CeM47E041FM
 hO/CIVBG2x0o4s/ibaLumxvXVRW+xr//Xp1nmkqLjwq7xv8iprD3Sp+9iW2o22Fnx4i6
 500lUqT3f13FD4MJ1lJJTDJKODIZtBYQw9FtK4TWJhHCIILejIq+3Jngspxqp5gYfa1C
 ahMw==
X-Gm-Message-State: AOAM530nvw3JKTVzrgToivF1XGWHI19gSOv9aEekM/ci6BPXFgRc+5yI
 9YWKAaVaBK877IIrOqiWDlNUEfVR2R6JXR95YohBr+F6tSvFLs/TCxAipSZPFzD6BdeM/TXc65J
 5NbUj3j/PJqJNBaNm1ODCgMkfaw==
X-Received: by 2002:a05:6402:1ad1:: with SMTP id
 ba17mr4952085edb.51.1609963465138; 
 Wed, 06 Jan 2021 12:04:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzquvdws0SdVZ0SXFaw9vhgr9sso/Ca3l1rwnxGCMe47PhiT0KKBpcas9UCUkjUB9UXM2p0fg==
X-Received: by 2002:a05:6402:1ad1:: with SMTP id
 ba17mr4952073edb.51.1609963464954; 
 Wed, 06 Jan 2021 12:04:24 -0800 (PST)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
 by smtp.gmail.com with ESMTPSA id k3sm1850383eds.87.2021.01.06.12.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jan 2021 12:04:24 -0800 (PST)
Subject: Re: radeon kernel driver not suppressing ACPI_VIDEO_NOTIFY_PROBE
 events when it should
To: Alex Deucher <alexdeucher@gmail.com>
References: <ed5b59f0-cfbf-57e8-2cdf-2d0e2c0c45bf@redhat.com>
 <CADnq5_NSBBP+c+7aGpBkUSx6h4_7zz8o-yUW3ffW0Jn2GFD1AQ@mail.gmail.com>
 <c11f3b78-a100-4657-7c07-1c3894296a5d@redhat.com>
 <CADnq5_PrbSaof8bub7t=vS_w0LxQ7RpAPDxKMci-hJvSJD=GJA@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <e7b9e416-634a-9dc2-8b1d-56224fead017@redhat.com>
Date: Wed, 6 Jan 2021 21:04:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_PrbSaof8bub7t=vS_w0LxQ7RpAPDxKMci-hJvSJD=GJA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Approved-At: Wed, 06 Jan 2021 20:21:52 +0000
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

On 1/6/21 8:33 PM, Alex Deucher wrote:
> On Wed, Jan 6, 2021 at 1:10 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 1/6/21 6:07 PM, Alex Deucher wrote:
>>> On Wed, Jan 6, 2021 at 11:25 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> I get Cc-ed on all Fedora kernel bugs and this one stood out to me:
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1911763
>>>>
>>>> Since I've done a lot of work on the acpi-video code I thought I should
>>>> take a look. I've managed to help the user with a kernel-commandline
>>>> option which stops video.ko (the acpi-video kernel module) from emitting
>>>> key-press events for ACPI_VIDEO_NOTIFY_PROBE events.
>>>>
>>>> This is on a Dell Vostro laptop with i915/radeon hybrid gfx.
>>>>
>>>> I was thinking about adding a DMI quirk for this, but from the brief time
>>>> that I worked on nouveau (and specifically hybrid gfx setups) I know that
>>>> these events get fired on hybrid gfx setups when the discrete GPU is
>>>> powered down and something happens which requires the discrete GPUs drivers
>>>> attention, like an external monitor being plugged into a connector handled
>>>> by the dGPU (note that is not the case here).
>>>>
>>>> So I took a quick look at the radeon code and the radeon_atif_handler()
>>>> function from drivers/gpu/drm/radeon/radeon_acpi.c. When successful that
>>>> returns NOTIFY_BAD which suppresses the key-press.
>>>>
>>>> But in various cases it returns NOTIFY_DONE instead which does not
>>>> suppress the key-press event. So I think that the spurious key-press events
>>>> which the user is seeing should be avoided by this function returning
>>>> NOTIFY_BAD.
>>>>
>>>> Specifically I'm wondering if we should not return
>>>> NOTIFY_BAD when count == 0?   I guess this can cause problems if there
>>>> are multiple GPUs, but we could check if the acpi-event is for the
>>>> pci-device the radeon driver is bound to. This would require changing the
>>>> acpi-notify code to also pass the acpi_device pointer as part of the
>>>> acpi_bus_event but that should not be a problem.
>>>>
>>>
>>> For A+A PX/HG systems, we'd want the notifications for both the dGPU
>>> and the APU since some of the events are relevant to one or the other.
>>> ATIF_DGPU_DISPLAY_EVENT is only relevant to the dGPU, while
>>> ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST would be possibly relevant to
>>> both (if there was a mux), but mainly the APU.
>>> ATIF_SYSTEM_POWER_SOURCE_CHANGE_REQUEST would be relevant to both.
>>> The other events have extended bits to determine which GPU the event
>>> is targeted at.
>>
>> Right, but AFAIK on hybrid systems there are 2 ACPI video-bus devices,
>> one for each of the iGPU and dGPU which is why I suggested passing
>> the video-bus acpi_device as extra data in acpi_bus_event and then
>> radeon_atif_handler() could check if the acpi_device is the companion
>> device of the GPU. This assumes that events for GPU# will also
>> originate from (through an ACPI ASL notify call) the ACPI video-bus
>> which belongs to that GPU.
> 
> That's not the case.  For PX/HG systems, ATIF is in the iGPU's
> namespace, on dGPU only systems, ATIF is in the dGPU's namespace.

That assumes and AMD iGPU + AMD dGPU I believe ?  The system on
which the spurious ACPI_VIDEO_NOTIFY_PROBE events lead to spurious
KEY_SWITCHVIDEOMODE key-presses being reported uses an Intel iGPU
with an AMD dGPU. I don't have any hybrid gfx systems available for
testing atm, but I believe that in this case there will be 2 ACPI
video-busses, one for each GPU.

Note I'm not saying that that means that checking the originating
ACPI device is the companion of the GPUs PCI-device is the solution
here. But so far all I've heard from you is that that is not the
solution, without you offering any alternative ideas / possible
solutions to try for filtering out these spurious key-presses.

Regards,

Hans

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
