Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5B0C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 17:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70CE22EBD
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 17:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70CE22EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E117C89C52;
	Wed,  6 Jan 2021 17:07:37 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13D889C52
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 17:07:36 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id j20so3614962otq.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Jan 2021 09:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sDoltfIOxtlIx0Ni88ZJjl0kKguMKHLFWh5+N1yKsWM=;
 b=ODl7Wzypz9CAfKEDCXEnn5c2ayStsQcg8ba9muW0HNJ0I5/r18Hpp8Wl+IXTe35BqN
 JluRNK5EM0WCkean6Iu+8Y79D6n4pMymTKxHtphFLHtfaKwyFJ6Zfuqepx+kqZGyz24q
 7eoTUAL4XLa4e2zpQo6MdxpJ11gr0VulwYjtqm0cWCrppuzrs/EfwCcDYpNk4+iDawZ4
 0yYv8gslV5YQ4qZRUukbFKJNWb8+813wXw+xYVA86BQAUdvgplNIufbRuu8SGZrizY7t
 4aDZX9fsLJxQYSJ6mC17AzKaSTXx0FwJgR9uSypgUDpFw1YHCCku+aNYgZ2y3KpfzWyx
 gKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sDoltfIOxtlIx0Ni88ZJjl0kKguMKHLFWh5+N1yKsWM=;
 b=L7Yu6ugJaxq8h6Bep7/UkbqucHLa5W0FqQgna2P26Y7Ch6da9CRRGRtIQpA+1bgNZ9
 3pl7axAjfDHeZK4luGU8Rb5iFVGAJCku3YxPjQ/TG5C1Rf3rFpraYcCQr+CXtr1p6wA6
 XPyms1wrJZT6uQxsVsMevVCn4mwhm0vGHe7Bp47+jyu0h3/CVIRebBeTBcKk+9wtKA3p
 DQ9evHV0ouoKxgJTvoCHrnet4iMSLC8kqGJzmboD360UqORdmL35Uhq2ORWLOc0xta4k
 UFSZ8hDUIxaOnvbmogvrvEjrsp8ib3S29VwtPCfwXEz9f1qnGWtrL0oW3oMxXwyTKtOG
 HC8Q==
X-Gm-Message-State: AOAM530iDIAjQOlKSNBZI+T+RjBhZqEisSo1xG/wqEAX4RTJXcGfUjq8
 NOJAm6wkQTzFWwlRNqfYbwtHW66JDkPM/9uG8V4=
X-Google-Smtp-Source: ABdhPJzIBbVfMMyE9fVtCxoqjYaAvI+vpd3ZSBOv3MBSxKuwOCdoa14a6SNwDRYYjxNg3/92tPPTZfPOKgx688ZrhRE=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr3838806otl.311.1609952856137; 
 Wed, 06 Jan 2021 09:07:36 -0800 (PST)
MIME-Version: 1.0
References: <ed5b59f0-cfbf-57e8-2cdf-2d0e2c0c45bf@redhat.com>
In-Reply-To: <ed5b59f0-cfbf-57e8-2cdf-2d0e2c0c45bf@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Jan 2021 12:07:25 -0500
Message-ID: <CADnq5_NSBBP+c+7aGpBkUSx6h4_7zz8o-yUW3ffW0Jn2GFD1AQ@mail.gmail.com>
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

On Wed, Jan 6, 2021 at 11:25 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> I get Cc-ed on all Fedora kernel bugs and this one stood out to me:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1911763
>
> Since I've done a lot of work on the acpi-video code I thought I should
> take a look. I've managed to help the user with a kernel-commandline
> option which stops video.ko (the acpi-video kernel module) from emitting
> key-press events for ACPI_VIDEO_NOTIFY_PROBE events.
>
> This is on a Dell Vostro laptop with i915/radeon hybrid gfx.
>
> I was thinking about adding a DMI quirk for this, but from the brief time
> that I worked on nouveau (and specifically hybrid gfx setups) I know that
> these events get fired on hybrid gfx setups when the discrete GPU is
> powered down and something happens which requires the discrete GPUs drivers
> attention, like an external monitor being plugged into a connector handled
> by the dGPU (note that is not the case here).
>
> So I took a quick look at the radeon code and the radeon_atif_handler()
> function from drivers/gpu/drm/radeon/radeon_acpi.c. When successful that
> returns NOTIFY_BAD which suppresses the key-press.
>
> But in various cases it returns NOTIFY_DONE instead which does not
> suppress the key-press event. So I think that the spurious key-press events
> which the user is seeing should be avoided by this function returning
> NOTIFY_BAD.
>
> Specifically I'm wondering if we should not return
> NOTIFY_BAD when count == 0?   I guess this can cause problems if there
> are multiple GPUs, but we could check if the acpi-event is for the
> pci-device the radeon driver is bound to. This would require changing the
> acpi-notify code to also pass the acpi_device pointer as part of the
> acpi_bus_event but that should not be a problem.
>

For A+A PX/HG systems, we'd want the notifications for both the dGPU
and the APU since some of the events are relevant to one or the other.
ATIF_DGPU_DISPLAY_EVENT is only relevant to the dGPU, while
ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST would be possibly relevant to
both (if there was a mux), but mainly the APU.
ATIF_SYSTEM_POWER_SOURCE_CHANGE_REQUEST would be relevant to both.
The other events have extended bits to determine which GPU the event
is targeted at.

Alex


> Anyways I'm hoping you all have some ideas. If necessary I can build
> a Fedora test-kernel with some patches for the reporter to test.
>
> Regards,
>
> Hans
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
