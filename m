Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBBCC433E9
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 19:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C2723123
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 19:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C2723123
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 423BB89D8D;
	Wed,  6 Jan 2021 19:34:02 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1649789D8D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 19:34:01 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id y14so1013150oom.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Jan 2021 11:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=322V9nmZI1wLwIIV2oOW6C2k/YvaB+zTEY9xPtRMxFY=;
 b=cArMsU2FZhh22Qm61NggczaQVrQ89r3k33/evBsThPXziGPjgfknN0qUR22jxhcWOt
 CcmfSvo2tTt2T+PrEZ8tmc0jkGhxfGRVD6ePO+cO/kalJzAuTtoqpCK/FmjLJaOuzZJZ
 Joz/u6iufqrTSJbhKvxzzn1kDmxFUqdgNO/0T+cEnlmnV39EHHm3SpBbe5DfbPvZl+yp
 eMcuby2pWrOpNW7cjlqQ3IUbezR3YdqhxS3KCq3NVAhjOojsGzaTueJERPhXCv9S05HF
 TkgMl0mILO6X2nWn4E8Uu6FBECLEg5oo6vKlvwT1/eAvpKcc5O6CyRx3tLmkR+0fY2oj
 KFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=322V9nmZI1wLwIIV2oOW6C2k/YvaB+zTEY9xPtRMxFY=;
 b=St2ZXPehex2lubTxfeXwyoPohQ1GSzBCfV5HYX+5ME8kduxgumfyDSQh24GmQ8nD6s
 fr0g5rxh1QAM3ahFhASvn8RPBzovInufz0tJmuw8pphJsM2CjBP4kCQEYzX8sRfIP3UP
 xLe/wF7Kx+OCgFM2rvYtLHPRRnyoabIPEc0MoJaNJQyGkcwYNpEA+fmHI0DcftoxETQy
 23KBv37J+huukFvt5YHMXNVxz4btqqSuRZag5yOBhMwtMkp/PKEqKpRRyjQAyw1vXgjP
 yrvCypMfRMN/b/tLRjEav2IV1k98gbFFZdmVmIzXlsJpT7zZHRjA5bXd7U1/QvKpaE6Q
 BGLg==
X-Gm-Message-State: AOAM531oXOWh5iKbbbmKKTdpTj1q/KLOYT3g+VDN8AIC5xLv+rDC3Ilw
 caN4PZ9wg7E0vgp2/O3BM6GHZk6rwN+YEr9bS/4=
X-Google-Smtp-Source: ABdhPJyS35vIQpyJKOun5xrsP+5KLIqsTXp19dNPis8mvXV1c5Z1sSrPToNMQQ2a3emmdgqXWmw2Gelldo2gp/nPuB4=
X-Received: by 2002:a4a:6c45:: with SMTP id u5mr3861565oof.61.1609961640243;
 Wed, 06 Jan 2021 11:34:00 -0800 (PST)
MIME-Version: 1.0
References: <ed5b59f0-cfbf-57e8-2cdf-2d0e2c0c45bf@redhat.com>
 <CADnq5_NSBBP+c+7aGpBkUSx6h4_7zz8o-yUW3ffW0Jn2GFD1AQ@mail.gmail.com>
 <c11f3b78-a100-4657-7c07-1c3894296a5d@redhat.com>
In-Reply-To: <c11f3b78-a100-4657-7c07-1c3894296a5d@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Jan 2021 14:33:48 -0500
Message-ID: <CADnq5_PrbSaof8bub7t=vS_w0LxQ7RpAPDxKMci-hJvSJD=GJA@mail.gmail.com>
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

On Wed, Jan 6, 2021 at 1:10 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/6/21 6:07 PM, Alex Deucher wrote:
> > On Wed, Jan 6, 2021 at 11:25 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi All,
> >>
> >> I get Cc-ed on all Fedora kernel bugs and this one stood out to me:
> >>
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1911763
> >>
> >> Since I've done a lot of work on the acpi-video code I thought I should
> >> take a look. I've managed to help the user with a kernel-commandline
> >> option which stops video.ko (the acpi-video kernel module) from emitting
> >> key-press events for ACPI_VIDEO_NOTIFY_PROBE events.
> >>
> >> This is on a Dell Vostro laptop with i915/radeon hybrid gfx.
> >>
> >> I was thinking about adding a DMI quirk for this, but from the brief time
> >> that I worked on nouveau (and specifically hybrid gfx setups) I know that
> >> these events get fired on hybrid gfx setups when the discrete GPU is
> >> powered down and something happens which requires the discrete GPUs drivers
> >> attention, like an external monitor being plugged into a connector handled
> >> by the dGPU (note that is not the case here).
> >>
> >> So I took a quick look at the radeon code and the radeon_atif_handler()
> >> function from drivers/gpu/drm/radeon/radeon_acpi.c. When successful that
> >> returns NOTIFY_BAD which suppresses the key-press.
> >>
> >> But in various cases it returns NOTIFY_DONE instead which does not
> >> suppress the key-press event. So I think that the spurious key-press events
> >> which the user is seeing should be avoided by this function returning
> >> NOTIFY_BAD.
> >>
> >> Specifically I'm wondering if we should not return
> >> NOTIFY_BAD when count == 0?   I guess this can cause problems if there
> >> are multiple GPUs, but we could check if the acpi-event is for the
> >> pci-device the radeon driver is bound to. This would require changing the
> >> acpi-notify code to also pass the acpi_device pointer as part of the
> >> acpi_bus_event but that should not be a problem.
> >>
> >
> > For A+A PX/HG systems, we'd want the notifications for both the dGPU
> > and the APU since some of the events are relevant to one or the other.
> > ATIF_DGPU_DISPLAY_EVENT is only relevant to the dGPU, while
> > ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST would be possibly relevant to
> > both (if there was a mux), but mainly the APU.
> > ATIF_SYSTEM_POWER_SOURCE_CHANGE_REQUEST would be relevant to both.
> > The other events have extended bits to determine which GPU the event
> > is targeted at.
>
> Right, but AFAIK on hybrid systems there are 2 ACPI video-bus devices,
> one for each of the iGPU and dGPU which is why I suggested passing
> the video-bus acpi_device as extra data in acpi_bus_event and then
> radeon_atif_handler() could check if the acpi_device is the companion
> device of the GPU. This assumes that events for GPU# will also
> originate from (through an ACPI ASL notify call) the ACPI video-bus
> which belongs to that GPU.

That's not the case.  For PX/HG systems, ATIF is in the iGPU's
namespace, on dGPU only systems, ATIF is in the dGPU's namespace.

Alex

>
> This all assumes though that the problem is that radeon_atif_handler()
> does not return NOTIFY_BAD when the event count being 0 (in other words
> a spurious event). It is also possibly that one of the earlier checks in
> radeon_atif_handler() is failing...
>
> I guess that a first step in debugging this would be to ask the reporter
> to run a kernel with some debugging printk-s added to radeon_atif_handler(),
> to see which code-path in radeon_atif_handler we end up in
> (assuming that radeon_atif_handler() gets called at all).
>
> Any suggestions for other debugging printk-s, before I prepare a Fedora
> kernel for the reporter to test?
>
> Regards,
>
> Hans
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
