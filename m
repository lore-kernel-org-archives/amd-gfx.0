Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6000C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 10:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56DCE6ECD2;
	Fri, 26 Nov 2021 10:37:43 +0000 (UTC)
X-Greylist: delayed 1643 seconds by postgrey-1.36 at gabe;
 Thu, 25 Nov 2021 11:37:19 UTC
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B886EB11
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 11:37:19 +0000 (UTC)
Received: from [77.23.61.74] (helo=[192.168.66.200]); authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1mqCdV-0000FU-KZ; Thu, 25 Nov 2021 12:09:53 +0100
Message-ID: <7e1fd10f-ecd7-a4b7-bd46-327970baeb66@leemhuis.info>
Date: Thu, 25 Nov 2021 12:09:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-BS
To: Mark Boddington <lkml@badpenguin.co.uk>, amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
References: <99797fb7-76eb-9d86-ad2f-591243eca404@badpenguin.co.uk>
From: Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: kernel 5.15.x: AMD RX 6700 XT - Fails to resume after screen blank
In-Reply-To: <99797fb7-76eb-9d86-ad2f-591243eca404@badpenguin.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1637840239;6ff5baab;
X-HE-SMSGID: 1mqCdV-0000FU-KZ
X-Mailman-Approved-At: Fri, 26 Nov 2021 10:37:43 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, regressions@lists.linux.dev
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, this is your Linux kernel regression tracker speaking.

On 24.11.21 20:14, Mark Boddington wrote:
> Hi all,
> 
> TL;DR - git bisection points to
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.15.4&id=61d861cf478576d85d6032f864360a34b26084b1
> as causing an issue when changing power state after idle.

Thx for the more detailed report and the bisection.

TWIMC: To be sure this issue doesn't fall through the cracks unnoticed,
I'm adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced 61d861cf478576d85d6032f864360a34b26084b1
#regzbot title drm/amd: AMD RX 6700 XT - Fails to resume after screen blank
#regzbot ignore-activity

Also CCing the developer and everything in the signed-off-by chain of
the culprit.

Ciao, Thorsten

> Since 5.15.0 I have had intermittent issues with my GPU failing to
> resume after entering power saving. I have errors like these:
> 
> Nov 18 09:52:19 katana kernel: [ 4921.669813] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:21 katana kernel: [ 4923.667803] snd_hda_intel
> 0000:0d:00.1: refused to change power state from D0 to D3hot
> Nov 18 09:52:26 katana kernel: [ 4928.622234] amdgpu 0000:0d:00.0:
> amdgpu: Failed to export SMU metrics table!
> Nov 18 09:52:31 katana kernel: [ 4933.371814] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:31 katana kernel: [ 4933.650854] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:32 katana kernel: [ 4933.921708] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:32 katana kernel: [ 4933.940249] amdgpu 0000:0d:00.0:
> amdgpu: SMU: I'm not done with your previous command!
> Nov 18 09:52:32 katana kernel: [ 4933.940254] amdgpu 0000:0d:00.0:
> amdgpu: Failed to export SMU metrics table!
> Nov 18 09:52:32 katana kernel: [ 4934.192236] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:32 katana kernel: [ 4934.463213] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:33 katana kernel: [ 4934.736895] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:33 katana kernel: [ 4935.007928] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:33 katana kernel: [ 4935.279063] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:33 katana kernel: [ 4935.550243] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:34 katana kernel: [ 4935.824034] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:34 katana kernel: [ 4936.095158] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:34 katana kernel: [ 4936.366210] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:34 katana kernel: [ 4936.629193] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:35 katana kernel: [ 4936.886333] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:35 katana kernel: [ 4937.140815] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:35 katana kernel: [ 4937.395341] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:35 katana kernel: [ 4937.649885] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:36 katana kernel: [ 4937.906944] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> Nov 18 09:52:36 katana kernel: [ 4938.162866] [drm:dc_dmub_srv_wait_idle
> [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> 
> this eventually leads to processes crashing, and the system locking up
> during shutdown.
> 
> A git bisection has isolated the following patch as the cause.
> 
> commit 8f0284f190e6a0aa09015090568c03f18288231a (refs/bisect/bad)
> Merge: 5bea1c8ce673 61d861cf4785
> Author: Dave Airlie <airlied@redhat.com>
> Date:   Mon Aug 30 09:06:01 2021 +1000
> 
>     Merge tag 'amd-drm-next-5.15-2021-08-27' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-next
> 
>     amd-drm-next-5.15-2021-08-27:
> 
>     amdgpu:
>     - PLL fix for SI
>     - Misc code cleanups
>     - RAS fixes
>     - PSP cleanups
>     - Polaris UVD/VCE suspend fixes
>     - aldebaran fixes
>     - DCN3.x mclk fixes
> 
>     amdkfd:
>     - CWSR fixes for arcturus and aldebaran
>     - SVM fixes
> 
>     Signed-off-by: Dave Airlie <airlied@redhat.com>
>     From: Alex Deucher <alexander.deucher@amd.com>
>     Link:
> https://patchwork.freedesktop.org/patch/msgid/20210827192336.4649-1-alexander.deucher@amd.com
> 
> 
> commit 61d861cf478576d85d6032f864360a34b26084b1 (HEAD)
> Author: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Date:   Wed May 13 11:58:50 2020 -0400
> 
>     drm/amd/display: Move AllowDRAMSelfRefreshOrDRAMClockChangeInVblank
> to bounding box
> 
>     [Why]
>     This is a global parameter, not a per pipe parameter and it's useful
>     for experimenting with the prefetch schedule to be adjustable from
>     the SOC bb.
> 
>     [How]
>     Add a parameter to the SOC bb, default is the existing policy for
>     all DCN. Fill it in when filling SOC bb parameters.
> 
>     Revert the policy to use MinDCFClk at the same time since that's not
>     going to give us P-State in most cases on the spreadsheet.
> 
>     Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1403
>     Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>     Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>     Tested-by: Daniel Wheeler <Daniel.Wheeler@amd.com>
>     Acked-by: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> I have been running 5.15.4 with 61d861cf478576d85d6032f864360a34b26084b1
> backed out for a few hours with multiple periods of power saving, and so
> far so good.
> 
> Cheers,
> 
> Mark

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply. That's in everyone's interest, as
what I wrote above might be misleading to everyone reading this; any
suggestion I gave they thus might sent someone reading this down the
wrong rabbit hole, which none of us wants.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.

P.P.S.: If you want to know more about regzbot, check out its
web-interface, the getting start guide, and/or the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for the reporter: when reporting a regression it's in your interest
to tell #regzbot about it in the report, as that will ensure the
regression gets on the radar of regzbot and the regression tracker.
That's in your interest, as they will make sure the report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot, just
fix the issue as you normally would. Just remember to include a 'Link:'
tag to the report in the commit message, as explained in
Documentation/process/submitting-patches.rst
That aspect was recently was made more explicit in commit 1f57bd42b77c:
https://git.kernel.org/linus/1f57bd42b77c

