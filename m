Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78076C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 15:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2356D23131
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 15:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2356D23131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894B76E2D1;
	Tue, 12 Jan 2021 15:03:53 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8088D6E2D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 15:03:52 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id x5so2178709otp.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 07:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mkhl+VfNjs6HNl4wutbq9XSPu6PuR5coxiekuLwc0+I=;
 b=CaVy6HZ3pYY85t8D7tJjVfBJUBDcWsGh09KsSFJbLMbOXfr+Kjlmx2JmpohJcVOMcA
 SfE4SVJov0s9w/S183jQddbFQEHrYwFXFv40ZQSKvzyv+3NXY/cLLJDLo9LX1buPMVZA
 3ja4UczUQpch4tvGlOvqY9fNxTLUNyKmKyWiDVsrU1vA2ap7EODEHYVUaaROxbbmtrF3
 2MqbLw2HATKgaeLoyOPtPM+yzOVLpby0djzJpGvnzhgHOkyCw0FjlgdM/C7VUYEG5nu6
 PuV/V484hmUPsuJBBlX7evpT7CmIoj2YxjFq1rarSTrAtwxOqgiMIPvhiVwf44HORjAj
 5RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mkhl+VfNjs6HNl4wutbq9XSPu6PuR5coxiekuLwc0+I=;
 b=Q51vnI7sixZLP7Fucm+pXCS1WOVD5rey+qEceci04KrmlqFUQdmXQEZ1mNPc36CbDR
 j+YNF07Wd8OpLCBKQU4ha27LHRwlTC9hL3T2iXzA3u6E24C0QC9N4k/IESvu4AjuDh0s
 OZpE/+ZR+o6kZeZUmkGbPkk151vawHjaDtTfZEqjyEHIz7S5WZSrv/m9TzoXm1Z3YkhS
 R1azUCkjCJ/FOMWFpxzo7gFLTdX1OL/osLF5aIiM87ZlinbnA4EjUsX+TG57edL8cTgL
 Y5L+pym43PJczIdZ8xjBssIT1PUECqdTztH6Wh82dP+sgcET4NgrkPVOWwsV/2goVSWQ
 QCag==
X-Gm-Message-State: AOAM530WyPaXEW572TmhyFyd1P5obz60QmtMPYXmy3vBzQaP2RoLU9QM
 wRCuvbXorRlr+S0AqEuDM+UwammdrIN49s2/DzA=
X-Google-Smtp-Source: ABdhPJzMm6xvVyR8GOH+2DHzaSdtq/2Gm2WJEvFL7lcaBdTsy6Iev7ecO3nc5HYycrYb3Sqnd8W8VQMn3hBZ9VNwy/c=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr3169216ote.132.1610463831842; 
 Tue, 12 Jan 2021 07:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20210105175245.963451-1-alexander.deucher@amd.com>
 <s5him82qjxz.wl-tiwai@suse.de>
In-Reply-To: <s5him82qjxz.wl-tiwai@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Jan 2021 10:03:41 -0500
Message-ID: <CADnq5_PYxjGazN-4ULer5CC_fD_DEQbPHepkdbATjZaq0MimzQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/hdmi - enable runtime pm for CI AMD display
 audio
To: Takashi Iwai <tiwai@suse.de>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, alsa-devel@alsa-project.org,
 Evan Quan <evan.quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 12, 2021 at 10:00 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 05 Jan 2021 18:52:45 +0100,
> Alex Deucher wrote:
> >
> > We are able to power down the GPU and audio via the GPU driver
> > so flag these asics as supporting runtime pm.
> >
> > Reviewed-by: Evan Quan <evan.quan@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> I wanted to apply this one now, but noticed that the author address
> (gmail) is different from your S-o-b address (amd.com).
> Alex, is this intentional and keep it, or should I correct the author
> address?

The s-o-b address is the correct one.  Thanks!

Alex

>
>
> thanks,
>
> Takashi
>
> > ---
> >  sound/pci/hda/hda_intel.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index d539f52009a1..2ea46b5a9a23 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -2597,7 +2597,8 @@ static const struct pci_device_id azx_ids[] = {
> >         .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_AMD_SB },
> >       /* ATI HDMI */
> >       { PCI_DEVICE(0x1002, 0x0002),
> > -       .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
> > +       .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
> > +       AZX_DCAPS_PM_RUNTIME },
> >       { PCI_DEVICE(0x1002, 0x1308),
> >         .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
> >       { PCI_DEVICE(0x1002, 0x157a),
> > @@ -2659,9 +2660,11 @@ static const struct pci_device_id azx_ids[] = {
> >       { PCI_DEVICE(0x1002, 0xaab0),
> >         .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
> >       { PCI_DEVICE(0x1002, 0xaac0),
> > -       .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
> > +       .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
> > +       AZX_DCAPS_PM_RUNTIME },
> >       { PCI_DEVICE(0x1002, 0xaac8),
> > -       .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
> > +       .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
> > +       AZX_DCAPS_PM_RUNTIME },
> >       { PCI_DEVICE(0x1002, 0xaad8),
> >         .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
> >         AZX_DCAPS_PM_RUNTIME },
> > --
> > 2.29.2
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
