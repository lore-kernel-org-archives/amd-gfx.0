Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47777C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 11:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D5010E385;
	Tue,  9 May 2023 11:06:10 +0000 (UTC)
X-Greylist: delayed 382 seconds by postgrey-1.36 at gabe;
 Tue, 09 May 2023 11:06:07 UTC
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D88C710E385
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 11:06:07 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202305091259413226; Tue, 09 May 2023 12:59:41 +0200
Message-ID: <9deeb132-a317-7419-e9da-cbc0a379c0eb@daenzer.net>
Date: Tue, 9 May 2023 12:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-CA
To: Qingqing Zhuo <Qingqing.Zhuo@amd.com>, amd-gfx@lists.freedesktop.org,
 Wesley Chalmers <Wesley.Chalmers@amd.com>
References: <20230414155330.5215-11-Qingqing.Zhuo@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
In-Reply-To: <20230414155330.5215-11-Qingqing.Zhuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1F.645A279D.002E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 4/14/23 17:52, Qingqing Zhuo wrote:
> From: Wesley Chalmers <Wesley.Chalmers@amd.com>
> 
> [WHY]
> Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as a
> pipe commit can cause underflow.
> 
> [HOW]
> Move DMUB p-state delegate into optimze_bandwidth; enabling FAMS sets
> optimized_required.
> 
> This change expects that Freesync requests are blocked when
> optimized_required is true.
> 
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
I bisected a regression to this change, see below for the symptoms. Reverting this patch (and the following patch "drm/amd/display: Block optimize on consecutive FAMS enables", which depends on it) on top of the DRM changes merged for 6.4-rc1 avoids the regression.

Maybe "Freesync requests are blocked when optimized_required is true" isn't ensured as needed?


The symptoms are that the monitor (Samsung Odyssey Neo G9, 5120x1440@240/VRR, connected to Navi 21 via DisplayPort) blanks and the GPU hangs while starting the Steam game Assetto Corsa Competizione (via Proton 7.0).

Example dmesg excerpt:

 amdgpu 0000:0c:00.0: [drm] *ERROR* [CRTC:82:crtc-0] flip_done timed out
 NMI watchdog: Watchdog detected hard LOCKUP on cpu 6
 [...]
 RIP: 0010:amdgpu_device_rreg.part.0+0x2f/0xf0 [amdgpu]
 Code: 41 54 44 8d 24 b5 00 00 00 00 55 89 f5 53 48 89 fb 4c 3b a7 60 0b 00 00 73 6a 83 e2 02 74 29 4c 03 a3 68 0b 00 00 45 8b 24 24 <48> 8b 43 08 0f b7 70 3e 66 90 44 89 e0 5b 5d 41 5c 31 d2 31 c9 31
 RSP: 0000:ffffb39a119dfb88 EFLAGS: 00000086
 RAX: ffffffffc0eb96a0 RBX: ffff9e7963dc0000 RCX: 0000000000007fff
 RDX: 0000000000000000 RSI: 0000000000004ff6 RDI: ffff9e7963dc0000
 RBP: 0000000000004ff6 R08: ffffb39a119dfc40 R09: 0000000000000010
 R10: ffffb39a119dfc40 R11: ffffb39a119dfc44 R12: 00000000000e05ae
 R13: 0000000000000000 R14: ffff9e7963dc0010 R15: 0000000000000000
 FS:  000000001012f6c0(0000) GS:ffff9e805eb80000(0000) knlGS:000000007fd40000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00000000461ca000 CR3: 00000002a8a20000 CR4: 0000000000350ee0
 Call Trace:
  <TASK>
  dm_read_reg_func+0x37/0xc0 [amdgpu]
  generic_reg_get2+0x22/0x60 [amdgpu]
  optc1_get_crtc_scanoutpos+0x6a/0xc0 [amdgpu]
  dc_stream_get_scanoutpos+0x74/0x90 [amdgpu]
  dm_crtc_get_scanoutpos+0x82/0xf0 [amdgpu]
  amdgpu_display_get_crtc_scanoutpos+0x91/0x190 [amdgpu]
  ? dm_read_reg_func+0x37/0xc0 [amdgpu]
  amdgpu_get_vblank_counter_kms+0xb4/0x1a0 [amdgpu]
  dm_pflip_high_irq+0x213/0x2f0 [amdgpu]
  amdgpu_dm_irq_handler+0x8a/0x200 [amdgpu]
  amdgpu_irq_dispatch+0xd4/0x220 [amdgpu]
  amdgpu_ih_process+0x7f/0x110 [amdgpu]
  amdgpu_irq_handler+0x1f/0x70 [amdgpu]
  __handle_irq_event_percpu+0x46/0x1b0
  handle_irq_event+0x34/0x80
  handle_edge_irq+0x9f/0x240
  __common_interrupt+0x66/0x110
  common_interrupt+0x5c/0xd0
  asm_common_interrupt+0x22/0x40


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

