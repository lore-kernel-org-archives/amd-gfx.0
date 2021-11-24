Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8048C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 19:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9C86E1E8;
	Wed, 24 Nov 2021 19:50:42 +0000 (UTC)
X-Greylist: delayed 993 seconds by postgrey-1.36 at gabe;
 Wed, 24 Nov 2021 19:31:27 UTC
Received: from queue02a.mail.zen.net.uk (queue02a.mail.zen.net.uk
 [212.23.3.234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B256E108
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 19:31:27 +0000 (UTC)
Received: from [212.23.1.20] (helo=smarthost01a.ixn.mail.zen.net.uk)
 by queue02a.mail.zen.net.uk with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.90_1)
 (envelope-from <lkml@badpenguin.co.uk>)
 id 1mpxjJ-0003rc-BM; Wed, 24 Nov 2021 19:14:53 +0000
Received: from [217.155.148.18] (helo=swift)
 by smarthost01a.ixn.mail.zen.net.uk with esmtp (Exim 4.90_1)
 (envelope-from <lkml@badpenguin.co.uk>)
 id 1mpxjA-0001nz-KT; Wed, 24 Nov 2021 19:14:44 +0000
Received: from localhost (localhost [127.0.0.1])
 by swift (Postfix) with ESMTP id 5921C2CABAF;
 Wed, 24 Nov 2021 19:14:44 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at badpenguin.co.uk
Received: from swift ([127.0.0.1])
 by localhost (swift.badpenguin.co.uk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1t1_JkQkkFO8; Wed, 24 Nov 2021 19:14:41 +0000 (GMT)
Received: from [192.168.42.11] (katana [192.168.42.11])
 by swift (Postfix) with ESMTPS id E90072CAB9E;
 Wed, 24 Nov 2021 19:14:41 +0000 (GMT)
From: Mark Boddington <lkml@badpenguin.co.uk>
Subject: kernel 5.15.x: AMD RX 6700 XT - Fails to resume after screen blank
To: amd-gfx@lists.freedesktop.org
Message-ID: <99797fb7-76eb-9d86-ad2f-591243eca404@badpenguin.co.uk>
Date: Wed, 24 Nov 2021 19:14:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-smarthost01a-IP: [217.155.148.18]
Feedback-ID: 217.155.148.18
X-Mailman-Approved-At: Wed, 24 Nov 2021 19:50:40 +0000
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
Cc: regressions@lists.linux.dev
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,

TL;DR - git bisection points to 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.15.4&id=61d861cf478576d85d6032f864360a34b26084b1 
as causing an issue when changing power state after idle.

Since 5.15.0 I have had intermittent issues with my GPU failing to 
resume after entering power saving. I have errors like these:

Nov 18 09:52:19 katana kernel: [ 4921.669813] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:21 katana kernel: [ 4923.667803] snd_hda_intel 
0000:0d:00.1: refused to change power state from D0 to D3hot
Nov 18 09:52:26 katana kernel: [ 4928.622234] amdgpu 0000:0d:00.0: 
amdgpu: Failed to export SMU metrics table!
Nov 18 09:52:31 katana kernel: [ 4933.371814] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:31 katana kernel: [ 4933.650854] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:32 katana kernel: [ 4933.921708] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:32 katana kernel: [ 4933.940249] amdgpu 0000:0d:00.0: 
amdgpu: SMU: I'm not done with your previous command!
Nov 18 09:52:32 katana kernel: [ 4933.940254] amdgpu 0000:0d:00.0: 
amdgpu: Failed to export SMU metrics table!
Nov 18 09:52:32 katana kernel: [ 4934.192236] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:32 katana kernel: [ 4934.463213] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:33 katana kernel: [ 4934.736895] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:33 katana kernel: [ 4935.007928] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:33 katana kernel: [ 4935.279063] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:33 katana kernel: [ 4935.550243] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:34 katana kernel: [ 4935.824034] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:34 katana kernel: [ 4936.095158] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:34 katana kernel: [ 4936.366210] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:34 katana kernel: [ 4936.629193] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:35 katana kernel: [ 4936.886333] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:35 katana kernel: [ 4937.140815] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:35 katana kernel: [ 4937.395341] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:35 katana kernel: [ 4937.649885] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:36 katana kernel: [ 4937.906944] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
Nov 18 09:52:36 katana kernel: [ 4938.162866] [drm:dc_dmub_srv_wait_idle 
[amdgpu]] *ERROR* Error waiting for DMUB idle: status=3

this eventually leads to processes crashing, and the system locking up 
during shutdown.

A git bisection has isolated the following patch as the cause.

commit 8f0284f190e6a0aa09015090568c03f18288231a (refs/bisect/bad)
Merge: 5bea1c8ce673 61d861cf4785
Author: Dave Airlie <airlied@redhat.com>
Date:   Mon Aug 30 09:06:01 2021 +1000

     Merge tag 'amd-drm-next-5.15-2021-08-27' of 
https://gitlab.freedesktop.org/agd5f/linux into drm-next

     amd-drm-next-5.15-2021-08-27:

     amdgpu:
     - PLL fix for SI
     - Misc code cleanups
     - RAS fixes
     - PSP cleanups
     - Polaris UVD/VCE suspend fixes
     - aldebaran fixes
     - DCN3.x mclk fixes

     amdkfd:
     - CWSR fixes for arcturus and aldebaran
     - SVM fixes

     Signed-off-by: Dave Airlie <airlied@redhat.com>
     From: Alex Deucher <alexander.deucher@amd.com>
     Link: 
https://patchwork.freedesktop.org/patch/msgid/20210827192336.4649-1-alexander.deucher@amd.com

commit 61d861cf478576d85d6032f864360a34b26084b1 (HEAD)
Author: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Date:   Wed May 13 11:58:50 2020 -0400

     drm/amd/display: Move AllowDRAMSelfRefreshOrDRAMClockChangeInVblank 
to bounding box

     [Why]
     This is a global parameter, not a per pipe parameter and it's useful
     for experimenting with the prefetch schedule to be adjustable from
     the SOC bb.

     [How]
     Add a parameter to the SOC bb, default is the existing policy for
     all DCN. Fill it in when filling SOC bb parameters.

     Revert the policy to use MinDCFClk at the same time since that's not
     going to give us P-State in most cases on the spreadsheet.

     Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1403
     Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
     Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
     Tested-by: Daniel Wheeler <Daniel.Wheeler@amd.com>
     Acked-by: Alex Deucher <alexander.deucher@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I have been running 5.15.4 with 61d861cf478576d85d6032f864360a34b26084b1 
backed out for a few hours with multiple periods of power saving, and so 
far so good.

Cheers,

Mark


