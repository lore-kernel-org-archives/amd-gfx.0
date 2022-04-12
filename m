Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9014EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 06:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35E810FBB3;
	Tue, 12 Apr 2022 06:13:27 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5414310F125
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 06:13:26 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef95.dynamic.kabel-deutschland.de
 [95.90.239.149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 16C1661EA1929;
 Tue, 12 Apr 2022 08:13:24 +0200 (CEST)
Message-ID: <fae30821-f0b8-440a-a0d1-4c2a7d37ec07@molgen.mpg.de>
Date: Tue, 12 Apr 2022 08:13:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Vega 56 failing to process EDID from VR Headset
Content-Language: en-US
To: James Dutton <james.dutton@gmail.com>
References: <CAAMvbhF-mcZd+mfSUVpYShvKmFiQ6pb+j2eosBr-kvsxE+202g@mail.gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAAMvbhF-mcZd+mfSUVpYShvKmFiQ6pb+j2eosBr-kvsxE+202g@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear James,


Am 11.04.22 um 23:39 schrieb James Dutton:

> I have an Oculus Rift S, that I am trying to get working in Linux.

Please always mention the Linux kernel version.

> I have an AMD Vega 56  graphics card.
> 
> The VR headset plugs into a display port of the Vega56.
> The amdgpu driver sees the connection, and tries to process it.
> The problem is it cannot process the EDID, so fails to recognise the
> VR headset, and the VR headset does not work as a result.
> Please find the EDID below.
> I am guessing that the following is causing the problem:
> Established Timings I & II: none
> Standard Timings: none
> Forcing the driver to understand the Detailed mode, to which it is failing.
> If it helps, when attached to windows 10, it uses 1440x2560, portrait mode.
> Some dmesg lines that may be useful:
> // We should pick 1440x2560 as Windows picks that, but for some reason
> is rejects it with error 10.
> [10402.650734] [drm:create_validate_stream_for_sink [amdgpu]] Mode
> 1440x2560 (clk 571570) failed DC validation with error 10 (No DP link
> bandwidth)
> [10402.650991] [drm:update_stream_scaling_settings [amdgpu]]
> Destination Rectangle x:0  y:0  width:1440  height:2560
> [10402.651225] [drm:create_validate_stream_for_sink [amdgpu]] Mode
> 1440x2560 (clk 571570) failed DC validation with error 10 (No DP link
> bandwidth)

(Please use an email program, which does not wrap lines after 72 
characters.)

> Can anyone help give me with some pointers as to how to get the amdgpu
> driver to accept this EDID?

So, did you do any changes to Linux? Why do you think the EDID is at fault?

[…]

I suggest to analyze, why `No DP link bandwidth` is logged. The macro is 
`DC_NO_DP_LINK_BANDWIDTH`, and you should first check why 
`dp_validate_mode_timing()` in 
`drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c` returns false.


Kind regards,

Paul


PS: Using the issue tracker [1] might make it easier to keep track of 
this problem, and also to attach all the necessary information.


[1]: https://gitlab.freedesktop.org/drm/amd/-/issues/
