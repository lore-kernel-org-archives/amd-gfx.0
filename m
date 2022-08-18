Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ECCC32772
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Aug 2022 17:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48C3710E248;
	Thu, 18 Aug 2022 17:55:07 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA84410E2E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Aug 2022 17:54:50 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 c128-20020a4a4f86000000b0044b0247f650so52054oob.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Aug 2022 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=E/rN+560dcFeJcrSrJXW0C4XHBrv2aiU2Wak6e44sig=;
 b=GZh1Q4YxMrgnLeApxAUPTk2tS/CO8ZXNXImp9GgZ6/SGU8VQUdLDGPF0OMsQzT5pV0
 KXpIEV1CuvDIvQyrjS3yQ+1UuqDp6Y1co8N2fzcaNyeWM48QA+S8qHWpt63h/kC8bqxq
 GUsLcdsX278DjLXeOLaOzD4d1LMtzPo+6ZXmogw8K9Q4u/ct5cjvWDFIawJhoYLgT/hp
 hpRDOuSOtJv03XN2Dq0N1Pc9cqZ2FMyU6nwStIN5JvBmaLktuG+aB/NOxVBG0Ha1xC6b
 9sK6kL4AUTWuZwjUjfIULWx5VDiQWILu6344VQq0wGA62l1nZ6b/XVJJtdyrSMeHzcsL
 H7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=E/rN+560dcFeJcrSrJXW0C4XHBrv2aiU2Wak6e44sig=;
 b=guaKMqt+GVKpPp1TLaCfaHCoBSOJ6duh7zKVVbc7EYg7fZNvXHUi1nghmOd6IPHIF4
 50HLkCEFljF5WyYTUjHHzlJFLVvC66e+CSQ1Lysy1MWLGiLTN9Bj9T75FV+FtsT6mtQ3
 GV+cJIxAZnE8zBYhf8EaoDcG9Ub83JRFhWO0Ppz/jQkAd3giYWFYASnNxPP8wKmj03WC
 8JZY/5p/FkHfyB+Wb4FUfBKWAjAAMnVez0C4Ws5fwKnJwrjlpcKSWZdirezAtIeblase
 seeX4pSWgP8FAMS72PYpf9E289ZCZfYrwOVV8rD4QBQ1XBpDNGc8n3BpyhHtd3YBYUN/
 TcAw==
X-Gm-Message-State: ACgBeo0ywSR0hmDckwIV3C17lH/g5wFDvVODF9KQX6R8w0VFx/Aqfu3V
 jmQF6TzMDrLg5vO4XA7QiLtPzvyix0pgtyql2Fs=
X-Google-Smtp-Source: AA6agR7VOPhHy3c6X/iXdiSbBGxIPTlotKYjit4j9wW9phnSxljLUOU6PWiOiacamYPT/taNq6cN21sh8zKSw3zQxfU=
X-Received: by 2002:a05:6820:541:b0:44a:907d:c641 with SMTP id
 n1-20020a056820054100b0044a907dc641mr1262998ooj.65.1660845289986; Thu, 18 Aug
 2022 10:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <1e0f769e-008b-09b3-efaf-4a285323dc0d@FreeBSD.org>
 <386722eb-2560-2542-92cd-4a2fc46aeacf@gmail.com>
 <eef9f672-056e-6184-7f9d-0465654c13e8@FreeBSD.org>
In-Reply-To: <eef9f672-056e-6184-7f9d-0465654c13e8@FreeBSD.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Aug 2022 13:54:38 -0400
Message-ID: <CADnq5_MvgV_guBerbJZH7o_j_y6bhASj=wQbVqSKnLVfYJEufg@mail.gmail.com>
Subject: Re: Radeon HD 2600 XT, DVI outputs
To: Andriy Gapon <avg@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 18, 2022 at 8:29 AM Andriy Gapon <avg@freebsd.org> wrote:
>
> On 2022-08-16 12:01, Christian K=C3=B6nig wrote:
> > Hi Andriy,
> >
> > well first of all can you please test that with Linux? If this works on
> > Linux then there is probably just something missing on the FreeBSD port=
.
>
> Thank you for the suggestion.  This is something that I should have
> tested from the start.  But I was overly confident that the problem
> could not be a port problem as the hardware is so ancient and the port
> exists for quite a long while and it's currently on the Linux 5.10 level.
>
> But, yes, it is a port problem after all.  I tested Debian with 5.10
> kernel and the problem does not exist there.
>
> Here are some log messages from Linux:
> [  397.379974] [drm:drm_helper_probe_single_connector_modes
> [drm_kms_helper]] [CONNECTOR:46:DVI-I-1]
> [  397.395520] [drm:radeon_atom_dac_detect [radeon]] Bios 0 scratch
> 20000 00000014
> [  397.395534] [drm:radeon_atombios_connected_scratch_regs [radeon]]
> DFP1 disconnected
> [  397.395546] [drm:radeon_atombios_connected_scratch_regs [radeon]]
> CRT2 disconnected
> [  397.395550] [drm:drm_helper_probe_single_connector_modes
> [drm_kms_helper]] [CONNECTOR:46:DVI-I-1] status updated from unknown to
> disconnected
> [  397.395553] [drm:drm_helper_probe_single_connector_modes
> [drm_kms_helper]] [CONNECTOR:46:DVI-I-1] disconnected
> [  397.395557] [drm:drm_helper_probe_single_connector_modes
> [drm_kms_helper]] [CONNECTOR:48:DIN-1]
> [  397.411838] [drm:radeon_atom_dac_detect [radeon]] Bios 0 scratch
> 20000 00000014
> [  397.411856] [drm:radeon_atombios_connected_scratch_regs [radeon]] TV1
> disconnected
> [  397.411864] [drm:drm_helper_probe_single_connector_modes
> [drm_kms_helper]] [CONNECTOR:48:DIN-1] status updated from unknown to
> disconnected
> [  397.411867] [drm:drm_helper_probe_single_connector_modes
> [drm_kms_helper]] [CONNECTOR:48:DIN-1] disconnected
> [  397.411873] [drm:drm_helper_probe_single_connector_modes
> [drm_kms_helper]] [CONNECTOR:50:DVI-I-2]
> [  397.446829] [drm:drm_add_display_info [drm]] Supported Monitor
> Refresh rate range is 0 Hz - 0 Hz
> [  397.446833] [drm:drm_add_display_info [drm]] non_desktop set to 0
> [  397.446845] [drm:radeon_atombios_connected_scratch_regs [radeon]]
> CRT1 disconnected
> [  397.446855] [drm:radeon_atombios_connected_scratch_regs [radeon]]
> DFP2 connected
>
> I guess that this tells us that the monitor (DVI-I-2 + DFP2) is detected
> using some other method, so the detection does need to invoke
> radeon_atom_dac_detect for it.
>
> I guess that radeon_dvi_detect() is what is responsible for detecting
> DVI monitor connections.  So, it looks like the difference could be in
> DDC / EDID probing.

DVI-I connectors support both analog and digital encoders so the
driver has to determine which type of monitor is connected so that it
can enable the right encoder.  If an EDID is available, we can check
the digital bit to determine which encoder should be used.  If there
is no EDID, it gets more complicated.  At that point we have to try
and determine what type based on the hotplug detect pin or load
detection on the DAC.

Alex

>
>
> > Am 16.08.22 um 10:48 schrieb Andriy Gapon:
> >>
> >> Out of necessity I had to use an ancient Radeon HD 2600 XT card.
> >> It has two DVI outputs (and one S-video).
> >>
> >> I noticed a curious problem, if I attach a monitor to either of the
> >> DVI outputs, then initially there is video output but as soon as
> >> radeonkms driver attaches the monitor goes blank.
> >> But if I attach the same monitor to either of the outputs using its VG=
A
> >> input and DVI->VGA converter, then the video works fine all the time.
> >>
> >> I tested the monitor's DVI input with a different machine and there it
> >> works just fine (and, as I said, it also works fine before radeonkms
> >> is loaded).
> >>
> >> Here is a piece of output from the driver with the direct DVI attachme=
nt:
> >> [drm] Radeon Display Connectors
> >> [drm] Connector 0:
> >> [drm]   DVI-I-1
> >> [drm]   HPD1
> >> [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
> >> [drm]   Encoders:
> >> [drm]     DFP1: INTERNAL_KLDSCP_TMDS1
> >> [drm]     CRT2: INTERNAL_KLDSCP_DAC2
> >> [drm] Connector 1:
> >> [drm]   DIN-1
> >> [drm]   Encoders:
> >> [drm]     TV1: INTERNAL_KLDSCP_DAC2
> >> [drm] Connector 2:
> >> [drm]   DVI-I-2
> >> [drm]   HPD2
> >> [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
> >> [drm]   Encoders:
> >> [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> >> [drm]     DFP2: INTERNAL_LVTM1
> >> drmn0: [drm] Cannot find any crtc or sizes
> >>
> >> The same scenario with additional diagnostics:
> >> https://people.freebsd.org/~avg/radeon-2600-dvi-dvi.txt
> >>
> >>
> >> And here is with the DVI->VGA configuration:
> >> [drm] Radeon Display Connectors
> >> [drm] Connector 0:
> >> [drm]   DVI-I-1
> >> [drm]   HPD1
> >> [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
> >> [drm]   Encoders:
> >> [drm]     DFP1: INTERNAL_KLDSCP_TMDS1
> >> [drm]     CRT2: INTERNAL_KLDSCP_DAC2
> >> [drm] Connector 1:
> >> [drm]   DIN-1
> >> [drm]   Encoders:
> >> [drm]     TV1: INTERNAL_KLDSCP_DAC2
> >> [drm] Connector 2:
> >> [drm]   DVI-I-2
> >> [drm]   HPD2
> >> [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
> >> [drm]   Encoders:
> >> [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> >> [drm]     DFP2: INTERNAL_LVTM1
> >> [drm] fb mappable at 0xE0243000
> >> [drm] vram apper at 0xE0000000
> >> [drm] size 3145728
> >> [drm] fb depth is 24
> >> [drm]    pitch is 4096
> >>
> >> The same scenario with additional diagnostics:
> >> https://people.freebsd.org/~avg/radeon-2600-dvi-vga.txt
> >>
> >>
> >> Not sure if this is something with the hardware...
> >>
> >> Thanks!
> >
>
>
> --
> Andriy Gapon
>
>
> https://standforukraine.com
> https://razomforukraine.org
