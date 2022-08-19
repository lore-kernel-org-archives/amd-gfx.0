Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54232C32771
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Aug 2022 10:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA3E710E871;
	Fri, 19 Aug 2022 10:56:55 +0000 (UTC)
X-Greylist: delayed 81402 seconds by postgrey-1.36 at gabe;
 Fri, 19 Aug 2022 10:56:50 UTC
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C878610E871
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Aug 2022 10:56:50 +0000 (UTC)
Received: (Authenticated sender: andriy.gapon@uabsd.com)
 by mail.gandi.net (Postfix) with ESMTPSA id 1A802C0008;
 Fri, 19 Aug 2022 10:56:47 +0000 (UTC)
Message-ID: <9d899d87-ad7c-e240-2701-8a8a8aa6a3cc@FreeBSD.org>
Date: Fri, 19 Aug 2022 13:56:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: Radeon HD 2600 XT, DVI outputs
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <1e0f769e-008b-09b3-efaf-4a285323dc0d@FreeBSD.org>
 <386722eb-2560-2542-92cd-4a2fc46aeacf@gmail.com>
 <eef9f672-056e-6184-7f9d-0465654c13e8@FreeBSD.org>
 <CADnq5_MvgV_guBerbJZH7o_j_y6bhASj=wQbVqSKnLVfYJEufg@mail.gmail.com>
From: Andriy Gapon <avg@FreeBSD.org>
In-Reply-To: <CADnq5_MvgV_guBerbJZH7o_j_y6bhASj=wQbVqSKnLVfYJEufg@mail.gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-08-18 20:54, Alex Deucher wrote:
> On Thu, Aug 18, 2022 at 8:29 AM Andriy Gapon <avg@freebsd.org> wrote:
>>
>> On 2022-08-16 12:01, Christian König wrote:
>>> Hi Andriy,
>>>
>>> well first of all can you please test that with Linux? If this works on
>>> Linux then there is probably just something missing on the FreeBSD port.
>>
>> Thank you for the suggestion.  This is something that I should have
>> tested from the start.  But I was overly confident that the problem
>> could not be a port problem as the hardware is so ancient and the port
>> exists for quite a long while and it's currently on the Linux 5.10 level.
>>
>> But, yes, it is a port problem after all.  I tested Debian with 5.10
>> kernel and the problem does not exist there.
>>
>> Here are some log messages from Linux:
>> [  397.379974] [drm:drm_helper_probe_single_connector_modes
>> [drm_kms_helper]] [CONNECTOR:46:DVI-I-1]
>> [  397.395520] [drm:radeon_atom_dac_detect [radeon]] Bios 0 scratch
>> 20000 00000014
>> [  397.395534] [drm:radeon_atombios_connected_scratch_regs [radeon]]
>> DFP1 disconnected
>> [  397.395546] [drm:radeon_atombios_connected_scratch_regs [radeon]]
>> CRT2 disconnected
>> [  397.395550] [drm:drm_helper_probe_single_connector_modes
>> [drm_kms_helper]] [CONNECTOR:46:DVI-I-1] status updated from unknown to
>> disconnected
>> [  397.395553] [drm:drm_helper_probe_single_connector_modes
>> [drm_kms_helper]] [CONNECTOR:46:DVI-I-1] disconnected
>> [  397.395557] [drm:drm_helper_probe_single_connector_modes
>> [drm_kms_helper]] [CONNECTOR:48:DIN-1]
>> [  397.411838] [drm:radeon_atom_dac_detect [radeon]] Bios 0 scratch
>> 20000 00000014
>> [  397.411856] [drm:radeon_atombios_connected_scratch_regs [radeon]] TV1
>> disconnected
>> [  397.411864] [drm:drm_helper_probe_single_connector_modes
>> [drm_kms_helper]] [CONNECTOR:48:DIN-1] status updated from unknown to
>> disconnected
>> [  397.411867] [drm:drm_helper_probe_single_connector_modes
>> [drm_kms_helper]] [CONNECTOR:48:DIN-1] disconnected
>> [  397.411873] [drm:drm_helper_probe_single_connector_modes
>> [drm_kms_helper]] [CONNECTOR:50:DVI-I-2]
>> [  397.446829] [drm:drm_add_display_info [drm]] Supported Monitor
>> Refresh rate range is 0 Hz - 0 Hz
>> [  397.446833] [drm:drm_add_display_info [drm]] non_desktop set to 0
>> [  397.446845] [drm:radeon_atombios_connected_scratch_regs [radeon]]
>> CRT1 disconnected
>> [  397.446855] [drm:radeon_atombios_connected_scratch_regs [radeon]]
>> DFP2 connected
>>
>> I guess that this tells us that the monitor (DVI-I-2 + DFP2) is detected
>> using some other method, so the detection does need to invoke
>> radeon_atom_dac_detect for it.
>>
>> I guess that radeon_dvi_detect() is what is responsible for detecting
>> DVI monitor connections.  So, it looks like the difference could be in
>> DDC / EDID probing.
> 
> DVI-I connectors support both analog and digital encoders so the
> driver has to determine which type of monitor is connected so that it
> can enable the right encoder.  If an EDID is available, we can check
> the digital bit to determine which encoder should be used.  If there
> is no EDID, it gets more complicated.  At that point we have to try
> and determine what type based on the hotplug detect pin or load
> detection on the DAC.

Thank you very much for all the help.
The problem turned out to be in FreeBSD support for bit-banging I2C.
Hardware I2C found on newer cards was not affected, so the problem went 
under the radar.

-- 
Andriy Gapon


https://standforukraine.com
https://razomforukraine.org
