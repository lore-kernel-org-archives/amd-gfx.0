Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A779AC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 16:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEA52053B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 16:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUwQlS7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEA52053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060C36E4FF;
	Thu,  4 Jun 2020 16:20:43 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58BB66E4FF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 16:20:42 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id k26so6311691wmi.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cleEe6yd+TVmdt0AUvyCB9p/COM97K5P+jt86cwkd70=;
 b=YUwQlS7R3R/hHrhxOSuG/9n+mz/FYRf/h5NSx9i6PN7Fum23wrUGdl6pJGjqKq9JgI
 E7Uw7DPivbOzlsa0ah1u9Rw0hE6I659m0yCTkh2ZA3x2MiKvqn2mpcZAmfHq+P/c2i6Q
 wLJEKfL80vogtRGnAq4lzFArcKu1sd0+yaLMUoQRZtLjN7hgiuF/dl9U7/nCtSLxfZP/
 cLlARC+OpWne/P+qZMZLILKQdXM26cHaTXgTwO7qPrR7wKfUWzaITnQ9PUczColkyBDz
 JTa/dtTKINBdDLo5wT6XqESyFhuQUHVTQ0Li+oVGwo+KrdORYwjJL/d7iYg1CwuBLD/k
 gMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cleEe6yd+TVmdt0AUvyCB9p/COM97K5P+jt86cwkd70=;
 b=c6j6X54C30fo1OjV64vwHVQBWdk/VPlCDMcIoLjdjYr9k3ey8+z7L/gnqptzajcV/Q
 ZdgXTBOb4je0uI+gDTSohiU/OQBVTvJLQ3kdNuRR8rJFUxCYxZTD738F0dGr8nLrL7xM
 7XKYZeNMK7pk4Uq0dwCcOZBaT+cnnwPPeXvsvZyxmb8Fyop6jmC8Aocu0TZPAHoUXPMs
 19lCIle98m6AHBF2QlZjVyqJ2kPNdpJpheShyZKlV0jnOV8PyyP89MR42LWYRBblPb1x
 3p0STCb32KmbNsecWRWs7yKLg9nvDrDe3Zt/yLtb1pIv130PVDud9bLFDm0V9dfH9zgx
 t59Q==
X-Gm-Message-State: AOAM530euis/h+g86ln1PxmC4jFO2K11f0inCJEizUfgtdhQAEH1RZRb
 RHhopVvrLcjPlzPk4hqXGrAcqTEmOmpJhG2ABV7WwQ==
X-Google-Smtp-Source: ABdhPJz0JkOXz+K2nfD8XDFOFZiZEgL48NyyTC0Qv1S9gNUMSy5SIkuVB1Om9kkT1H/D+IFyHZUxKmhze/fBJqzGl5Y=
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr4725338wmp.73.1591287640973; 
 Thu, 04 Jun 2020 09:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200603013137.1849404-1-alexander.deucher@amd.com>
 <s5hsgfcebe7.wl-tiwai@suse.de>
In-Reply-To: <s5hsgfcebe7.wl-tiwai@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jun 2020 12:20:29 -0400
Message-ID: <CADnq5_MKbOq5ka0x4uBC7epO7HnwXCgph2ewEYyXWumiW5YfLw@mail.gmail.com>
Subject: Re: [PATCH] sound/pci/hda: add sienna_cichlid audio asic id for
 sienna_cichlid up
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
 Hersen Wu <hersenxs.wu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 3, 2020 at 5:39 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 03 Jun 2020 03:31:37 +0200,
> Alex Deucher wrote:
> >
> > From: Hersen Wu <hersenxs.wu@amd.com>
> >
> > dp/hdmi ati hda is not shown in audio settings
> >
> > Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Applied now with a slight rearrangement with the sorted order and Cc
> to stable.
>
> But also wondering whether do we have a device with 1002:ab30?
> It's missing between this one and the next one.

Thanks!  I'll check with the audio teams, I'm not sure off hand what
DIDs will be used in upcoming parts.

Alex

>
>
> thanks,
>
> Takashi
>
> > ---
> >  sound/pci/hda/hda_intel.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 92a042e34d3e..4188bc4bd4e2 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -2643,6 +2643,9 @@ static const struct pci_device_id azx_ids[] = {
> >       { PCI_DEVICE(0x1002, 0xab38),
> >         .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
> >         AZX_DCAPS_PM_RUNTIME },
> > +     { PCI_DEVICE(0x1002, 0xab28),
> > +       .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
> > +       AZX_DCAPS_PM_RUNTIME },
> >       /* VIA VT8251/VT8237A */
> >       { PCI_DEVICE(0x1106, 0x3288), .driver_data = AZX_DRIVER_VIA },
> >       /* VIA GFX VT7122/VX900 */
> > --
> > 2.25.4
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
