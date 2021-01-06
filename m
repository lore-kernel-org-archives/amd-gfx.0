Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50563C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 20:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B7D2311B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 20:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B7D2311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D736E22C;
	Wed,  6 Jan 2021 20:39:10 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D926E22C
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 20:39:08 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id x13so4242923oto.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Jan 2021 12:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zyU8xwXxYGFclUV005V5y9E3OIbRVmsMwT5nCHOZ5MM=;
 b=D4vqJizGRjxd/ksmIumfcRcFWnQO88J+SRXOkB4YogwNNNnU8sqXiiG6hemj1Ii7OI
 77u5yglPuwtolm2qseE/GagC9ECv2xXGbZUIp1oiUxGyBkcGn1v72QREkd+pp+MpAVYg
 /lkZ4yJgDorrr2jBeurL9sFcddswpCcjFo0MqQx3o37kzxuVbTwhEfTaJToVHVIPKaiE
 JAKUrm4A3tOazINzivkF1+tJfswybRkFCKrmY4DT0TI/MHhyQk9Wlk5YA/wAxbzsd8UJ
 ALs859TMsVWeQXdWDobo4IIfOtbrVRh869nlBPDK4rXU4LdnLuoZwte/bLggqhZSyrE9
 Z78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zyU8xwXxYGFclUV005V5y9E3OIbRVmsMwT5nCHOZ5MM=;
 b=CjH/V0iH/giUBBOQzf1Dng4BsrfOd/kOct27v7/OFnYgTHE90Z8QHpUfkkVt7KoOiI
 tk8AMhChJo4q5V2IhsSEV7fvHbPvnHf3Vz2uRiSDN4nnWLgdGdm1J729kZ9Y3P8LYZV2
 +28TdatRYJywqrEOgFaEcDFsPo5ALG9sFXjo9VZyJ8BcziumZKtbhguYU8qf/ZsprDn+
 JNnInzFZvE2dGcy5ylWFT2O/xMawHIJ1SHkfn+uYQbK46dNP01z4s1P2ereh6z+16qlC
 RB4+E+OuEtUwL1+mQ31JypJCfWnVLfUPXzLGBxckZqYDQ+kC/7Bdua0zr1KyhYi5PIZl
 vrJw==
X-Gm-Message-State: AOAM5326o7Byc3qNHZb8A6cy91NqONpVq3lNl2DKEHJxfgLpXPQOFez/
 Nvi6GosZEmIdGB0cfgtS0EUipNv6Iod7s7vhsRPOlR0L
X-Google-Smtp-Source: ABdhPJwGfIxBv0BWu0aNDJP2c8ojDJIXQGPptPK8BCPsbvFc/0I4sXs3Zv2666hcjiWdpdFHx6bUc1XfcA1RM72Z/CA=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr4688662ote.132.1609965548229; 
 Wed, 06 Jan 2021 12:39:08 -0800 (PST)
MIME-Version: 1.0
References: <ed5b59f0-cfbf-57e8-2cdf-2d0e2c0c45bf@redhat.com>
 <CADnq5_NSBBP+c+7aGpBkUSx6h4_7zz8o-yUW3ffW0Jn2GFD1AQ@mail.gmail.com>
 <c11f3b78-a100-4657-7c07-1c3894296a5d@redhat.com>
 <CADnq5_PrbSaof8bub7t=vS_w0LxQ7RpAPDxKMci-hJvSJD=GJA@mail.gmail.com>
 <e7b9e416-634a-9dc2-8b1d-56224fead017@redhat.com>
In-Reply-To: <e7b9e416-634a-9dc2-8b1d-56224fead017@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Jan 2021 15:38:57 -0500
Message-ID: <CADnq5_OtViYP+6+s8kdQLhKsCwatcsnGqjXxrS5bpyKMk2a2pg@mail.gmail.com>
Subject: Re: radeon kernel driver not suppressing ACPI_VIDEO_NOTIFY_PROBE
 events when it should
To: Hans de Goede <hdegoede@redhat.com>
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
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 6, 2021 at 3:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/6/21 8:33 PM, Alex Deucher wrote:
> > On Wed, Jan 6, 2021 at 1:10 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 1/6/21 6:07 PM, Alex Deucher wrote:
> >>> On Wed, Jan 6, 2021 at 11:25 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>
> >>>> Hi All,
> >>>>
> >>>> I get Cc-ed on all Fedora kernel bugs and this one stood out to me:
> >>>>
> >>>> https://bugzilla.redhat.com/show_bug.cgi?id=1911763
> >>>>
> >>>> Since I've done a lot of work on the acpi-video code I thought I should
> >>>> take a look. I've managed to help the user with a kernel-commandline
> >>>> option which stops video.ko (the acpi-video kernel module) from emitting
> >>>> key-press events for ACPI_VIDEO_NOTIFY_PROBE events.
> >>>>
> >>>> This is on a Dell Vostro laptop with i915/radeon hybrid gfx.
> >>>>
> >>>> I was thinking about adding a DMI quirk for this, but from the brief time
> >>>> that I worked on nouveau (and specifically hybrid gfx setups) I know that
> >>>> these events get fired on hybrid gfx setups when the discrete GPU is
> >>>> powered down and something happens which requires the discrete GPUs drivers
> >>>> attention, like an external monitor being plugged into a connector handled
> >>>> by the dGPU (note that is not the case here).
> >>>>
> >>>> So I took a quick look at the radeon code and the radeon_atif_handler()
> >>>> function from drivers/gpu/drm/radeon/radeon_acpi.c. When successful that
> >>>> returns NOTIFY_BAD which suppresses the key-press.
> >>>>
> >>>> But in various cases it returns NOTIFY_DONE instead which does not
> >>>> suppress the key-press event. So I think that the spurious key-press events
> >>>> which the user is seeing should be avoided by this function returning
> >>>> NOTIFY_BAD.
> >>>>
> >>>> Specifically I'm wondering if we should not return
> >>>> NOTIFY_BAD when count == 0?   I guess this can cause problems if there
> >>>> are multiple GPUs, but we could check if the acpi-event is for the
> >>>> pci-device the radeon driver is bound to. This would require changing the
> >>>> acpi-notify code to also pass the acpi_device pointer as part of the
> >>>> acpi_bus_event but that should not be a problem.
> >>>>
> >>>
> >>> For A+A PX/HG systems, we'd want the notifications for both the dGPU
> >>> and the APU since some of the events are relevant to one or the other.
> >>> ATIF_DGPU_DISPLAY_EVENT is only relevant to the dGPU, while
> >>> ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST would be possibly relevant to
> >>> both (if there was a mux), but mainly the APU.
> >>> ATIF_SYSTEM_POWER_SOURCE_CHANGE_REQUEST would be relevant to both.
> >>> The other events have extended bits to determine which GPU the event
> >>> is targeted at.
> >>
> >> Right, but AFAIK on hybrid systems there are 2 ACPI video-bus devices,
> >> one for each of the iGPU and dGPU which is why I suggested passing
> >> the video-bus acpi_device as extra data in acpi_bus_event and then
> >> radeon_atif_handler() could check if the acpi_device is the companion
> >> device of the GPU. This assumes that events for GPU# will also
> >> originate from (through an ACPI ASL notify call) the ACPI video-bus
> >> which belongs to that GPU.
> >
> > That's not the case.  For PX/HG systems, ATIF is in the iGPU's
> > namespace, on dGPU only systems, ATIF is in the dGPU's namespace.
>
> That assumes and AMD iGPU + AMD dGPU I believe ?  The system on
> which the spurious ACPI_VIDEO_NOTIFY_PROBE events lead to spurious
> KEY_SWITCHVIDEOMODE key-presses being reported uses an Intel iGPU
> with an AMD dGPU. I don't have any hybrid gfx systems available for
> testing atm, but I believe that in this case there will be 2 ACPI
> video-busses, one for each GPU.

I think the ATIF method will be on the iGPU regardless of whether it's
intel or AMD.

>
> Note I'm not saying that that means that checking the originating
> ACPI device is the companion of the GPUs PCI-device is the solution
> here. But so far all I've heard from you is that that is not the
> solution, without you offering any alternative ideas / possible
> solutions to try for filtering out these spurious key-presses.

Sorry, I'm not really an ACPI expert.  I think returning NOTIFY_BAD is
fine for this specific case, but I don't know if it will break other
platforms.  That said, I don't recall seeing any other similar bugs,
so maybe this is something specific to this particular laptop.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
