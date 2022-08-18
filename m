Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E566AC00140
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Aug 2022 12:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E97D2250;
	Thu, 18 Aug 2022 12:29:51 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE135113B2D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Aug 2022 12:29:28 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
 by mslow1.mail.gandi.net (Postfix) with ESMTP id 332B3D1878
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Aug 2022 12:20:09 +0000 (UTC)
Received: (Authenticated sender: andriy.gapon@uabsd.com)
 by mail.gandi.net (Postfix) with ESMTPSA id 1C2EE60005;
 Thu, 18 Aug 2022 12:20:01 +0000 (UTC)
Message-ID: <eef9f672-056e-6184-7f9d-0465654c13e8@FreeBSD.org>
Date: Thu, 18 Aug 2022 15:20:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: Radeon HD 2600 XT, DVI outputs
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <1e0f769e-008b-09b3-efaf-4a285323dc0d@FreeBSD.org>
 <386722eb-2560-2542-92cd-4a2fc46aeacf@gmail.com>
From: Andriy Gapon <avg@FreeBSD.org>
In-Reply-To: <386722eb-2560-2542-92cd-4a2fc46aeacf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2022-08-16 12:01, Christian König wrote:
> Hi Andriy,
> 
> well first of all can you please test that with Linux? If this works on 
> Linux then there is probably just something missing on the FreeBSD port.

Thank you for the suggestion.  This is something that I should have 
tested from the start.  But I was overly confident that the problem 
could not be a port problem as the hardware is so ancient and the port 
exists for quite a long while and it's currently on the Linux 5.10 level.

But, yes, it is a port problem after all.  I tested Debian with 5.10 
kernel and the problem does not exist there.

Here are some log messages from Linux:
[  397.379974] [drm:drm_helper_probe_single_connector_modes 
[drm_kms_helper]] [CONNECTOR:46:DVI-I-1]
[  397.395520] [drm:radeon_atom_dac_detect [radeon]] Bios 0 scratch 
20000 00000014
[  397.395534] [drm:radeon_atombios_connected_scratch_regs [radeon]] 
DFP1 disconnected
[  397.395546] [drm:radeon_atombios_connected_scratch_regs [radeon]] 
CRT2 disconnected
[  397.395550] [drm:drm_helper_probe_single_connector_modes 
[drm_kms_helper]] [CONNECTOR:46:DVI-I-1] status updated from unknown to 
disconnected
[  397.395553] [drm:drm_helper_probe_single_connector_modes 
[drm_kms_helper]] [CONNECTOR:46:DVI-I-1] disconnected
[  397.395557] [drm:drm_helper_probe_single_connector_modes 
[drm_kms_helper]] [CONNECTOR:48:DIN-1]
[  397.411838] [drm:radeon_atom_dac_detect [radeon]] Bios 0 scratch 
20000 00000014
[  397.411856] [drm:radeon_atombios_connected_scratch_regs [radeon]] TV1 
disconnected
[  397.411864] [drm:drm_helper_probe_single_connector_modes 
[drm_kms_helper]] [CONNECTOR:48:DIN-1] status updated from unknown to 
disconnected
[  397.411867] [drm:drm_helper_probe_single_connector_modes 
[drm_kms_helper]] [CONNECTOR:48:DIN-1] disconnected
[  397.411873] [drm:drm_helper_probe_single_connector_modes 
[drm_kms_helper]] [CONNECTOR:50:DVI-I-2]
[  397.446829] [drm:drm_add_display_info [drm]] Supported Monitor 
Refresh rate range is 0 Hz - 0 Hz
[  397.446833] [drm:drm_add_display_info [drm]] non_desktop set to 0
[  397.446845] [drm:radeon_atombios_connected_scratch_regs [radeon]] 
CRT1 disconnected
[  397.446855] [drm:radeon_atombios_connected_scratch_regs [radeon]] 
DFP2 connected

I guess that this tells us that the monitor (DVI-I-2 + DFP2) is detected 
using some other method, so the detection does need to invoke 
radeon_atom_dac_detect for it.

I guess that radeon_dvi_detect() is what is responsible for detecting 
DVI monitor connections.  So, it looks like the difference could be in 
DDC / EDID probing.


> Am 16.08.22 um 10:48 schrieb Andriy Gapon:
>>
>> Out of necessity I had to use an ancient Radeon HD 2600 XT card.
>> It has two DVI outputs (and one S-video).
>>
>> I noticed a curious problem, if I attach a monitor to either of the 
>> DVI outputs, then initially there is video output but as soon as 
>> radeonkms driver attaches the monitor goes blank.
>> But if I attach the same monitor to either of the outputs using its VGA
>> input and DVI->VGA converter, then the video works fine all the time.
>>
>> I tested the monitor's DVI input with a different machine and there it 
>> works just fine (and, as I said, it also works fine before radeonkms 
>> is loaded).
>>
>> Here is a piece of output from the driver with the direct DVI attachment:
>> [drm] Radeon Display Connectors
>> [drm] Connector 0:
>> [drm]   DVI-I-1
>> [drm]   HPD1
>> [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
>> [drm]   Encoders:
>> [drm]     DFP1: INTERNAL_KLDSCP_TMDS1
>> [drm]     CRT2: INTERNAL_KLDSCP_DAC2
>> [drm] Connector 1:
>> [drm]   DIN-1
>> [drm]   Encoders:
>> [drm]     TV1: INTERNAL_KLDSCP_DAC2
>> [drm] Connector 2:
>> [drm]   DVI-I-2
>> [drm]   HPD2
>> [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
>> [drm]   Encoders:
>> [drm]     CRT1: INTERNAL_KLDSCP_DAC1
>> [drm]     DFP2: INTERNAL_LVTM1
>> drmn0: [drm] Cannot find any crtc or sizes
>>
>> The same scenario with additional diagnostics: 
>> https://people.freebsd.org/~avg/radeon-2600-dvi-dvi.txt
>>
>>
>> And here is with the DVI->VGA configuration:
>> [drm] Radeon Display Connectors
>> [drm] Connector 0:
>> [drm]   DVI-I-1
>> [drm]   HPD1
>> [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
>> [drm]   Encoders:
>> [drm]     DFP1: INTERNAL_KLDSCP_TMDS1
>> [drm]     CRT2: INTERNAL_KLDSCP_DAC2
>> [drm] Connector 1:
>> [drm]   DIN-1
>> [drm]   Encoders:
>> [drm]     TV1: INTERNAL_KLDSCP_DAC2
>> [drm] Connector 2:
>> [drm]   DVI-I-2
>> [drm]   HPD2
>> [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
>> [drm]   Encoders:
>> [drm]     CRT1: INTERNAL_KLDSCP_DAC1
>> [drm]     DFP2: INTERNAL_LVTM1
>> [drm] fb mappable at 0xE0243000
>> [drm] vram apper at 0xE0000000
>> [drm] size 3145728
>> [drm] fb depth is 24
>> [drm]    pitch is 4096
>>
>> The same scenario with additional diagnostics: 
>> https://people.freebsd.org/~avg/radeon-2600-dvi-vga.txt
>>
>>
>> Not sure if this is something with the hardware...
>>
>> Thanks!
> 


-- 
Andriy Gapon


https://standforukraine.com
https://razomforukraine.org
