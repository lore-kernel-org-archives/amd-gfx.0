Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D21C2BB41
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Aug 2022 08:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DAF3C7C71;
	Tue, 16 Aug 2022 08:57:12 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4B7C7FAA
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 08:57:06 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
 by mslow1.mail.gandi.net (Postfix) with ESMTP id 5F568D4CE7
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 08:49:01 +0000 (UTC)
Received: (Authenticated sender: andriy.gapon@uabsd.com)
 by mail.gandi.net (Postfix) with ESMTPSA id 22468240008
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 08:48:55 +0000 (UTC)
Message-ID: <1e0f769e-008b-09b3-efaf-4a285323dc0d@FreeBSD.org>
Date: Tue, 16 Aug 2022 11:48:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
To: amd-gfx@lists.freedesktop.org
Content-Language: en-US
From: Andriy Gapon <avg@FreeBSD.org>
Subject: Radeon HD 2600 XT, DVI outputs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


Out of necessity I had to use an ancient Radeon HD 2600 XT card.
It has two DVI outputs (and one S-video).

I noticed a curious problem, if I attach a monitor to either of the DVI 
outputs, then initially there is video output but as soon as radeonkms 
driver attaches the monitor goes blank.
But if I attach the same monitor to either of the outputs using its VGA
input and DVI->VGA converter, then the video works fine all the time.

I tested the monitor's DVI input with a different machine and there it 
works just fine (and, as I said, it also works fine before radeonkms is 
loaded).

Here is a piece of output from the driver with the direct DVI attachment:
[drm] Radeon Display Connectors
[drm] Connector 0:
[drm]   DVI-I-1
[drm]   HPD1
[drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
[drm]   Encoders:
[drm]     DFP1: INTERNAL_KLDSCP_TMDS1
[drm]     CRT2: INTERNAL_KLDSCP_DAC2
[drm] Connector 1:
[drm]   DIN-1
[drm]   Encoders:
[drm]     TV1: INTERNAL_KLDSCP_DAC2
[drm] Connector 2:
[drm]   DVI-I-2
[drm]   HPD2
[drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
[drm]   Encoders:
[drm]     CRT1: INTERNAL_KLDSCP_DAC1
[drm]     DFP2: INTERNAL_LVTM1
drmn0: [drm] Cannot find any crtc or sizes

The same scenario with additional diagnostics: 
https://people.freebsd.org/~avg/radeon-2600-dvi-dvi.txt


And here is with the DVI->VGA configuration:
[drm] Radeon Display Connectors
[drm] Connector 0:
[drm]   DVI-I-1
[drm]   HPD1
[drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
[drm]   Encoders:
[drm]     DFP1: INTERNAL_KLDSCP_TMDS1
[drm]     CRT2: INTERNAL_KLDSCP_DAC2
[drm] Connector 1:
[drm]   DIN-1
[drm]   Encoders:
[drm]     TV1: INTERNAL_KLDSCP_DAC2
[drm] Connector 2:
[drm]   DVI-I-2
[drm]   HPD2
[drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
[drm]   Encoders:
[drm]     CRT1: INTERNAL_KLDSCP_DAC1
[drm]     DFP2: INTERNAL_LVTM1
[drm] fb mappable at 0xE0243000
[drm] vram apper at 0xE0000000
[drm] size 3145728
[drm] fb depth is 24
[drm]    pitch is 4096

The same scenario with additional diagnostics: 
https://people.freebsd.org/~avg/radeon-2600-dvi-vga.txt


Not sure if this is something with the hardware...

Thanks!
-- 
Andriy Gapon


https://standforukraine.com
https://razomforukraine.org
