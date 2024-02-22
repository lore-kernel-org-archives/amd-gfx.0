Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FD4C48BEB
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 00:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E23910E834;
	Thu, 22 Feb 2024 00:21:23 +0000 (UTC)
X-Greylist: delayed 385 seconds by postgrey-1.36 at gabe;
 Thu, 22 Feb 2024 00:21:21 UTC
Received: from mail.mhcomputing.net (master.mhcomputing.net [74.208.228.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A08C510E834
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 00:21:21 +0000 (UTC)
Received: by mail.mhcomputing.net (Postfix, from userid 1000)
 id E34A3E5; Wed, 21 Feb 2024 16:14:55 -0800 (PST)
Date: Wed, 21 Feb 2024 16:14:55 -0800
From: Matthew Hall <mhall@mhcomputing.net>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: AMDGPU crash - request for assistance triaging / reporting
Message-ID: <20240222001455.GA14576@mhcomputing.net>
References: <20230721034359.GA1133@mhcomputing.net>
 <BL1PR12MB514416A3C79BA1E6F43FEF83F73FA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230721180131.GA10297@mhcomputing.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721180131.GA10297@mhcomputing.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Hi All,

Even using the older stock Ubuntu kernel, I am still seeing this GPU crash killing my user sessions, even without intense 3-D activity.

It happens with X.org or Wayland, older kernel 6.5.0, and all recent latest non-snapshot releases from kernel.org as well.

The more Wayland, and the newer the kernel, the worse the frequency.

On the old stuff, frequency seems to be once every 2-3 weeks, on the new stuff, daily to a couple times daily.

Linux mhall-xps-01 6.5.0-14-generic #14-Ubuntu SMP PREEMPT_DYNAMIC Tue Nov 14 14:59:49 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux

Is there any way I can get some help to debug or fix this? It is happening to multiple similar Lenovo model users for multiple months now.

https://gitlab.freedesktop.org/drm/amd/-/issues/2718

Regards,
Matthew.

--

2024-02-21T15:36:53.785101-08:00 mhall-xps-01 kernel: [2880378.141686] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0 timeout, signaled seq=1350708, emitted seq=1350710
2024-02-21T15:36:53.785121-08:00 mhall-xps-01 kernel: [2880378.142104] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process  pid 0 thread  pid 0
2024-02-21T15:36:53.785124-08:00 mhall-xps-01 kernel: [2880378.142485] amdgpu 0000:67:00.0: amdgpu: GPU reset begin!
2024-02-21T15:36:54.605112-08:00 mhall-xps-01 kernel: [2880378.965256] amdgpu 0000:67:00.0: amdgpu: MODE2 reset
2024-02-21T15:36:54.617089-08:00 mhall-xps-01 kernel: [2880378.973994] amdgpu 0000:67:00.0: amdgpu: GPU reset succeeded, trying to resume
2024-02-21T15:36:54.617097-08:00 mhall-xps-01 kernel: [2880378.974380] [drm] PCIE GART of 1024M enabled (table at 0x000000F41FC00000).
2024-02-21T15:36:54.617099-08:00 mhall-xps-01 kernel: [2880378.974465] [drm] VRAM is lost due to GPU reset!
2024-02-21T15:36:54.617100-08:00 mhall-xps-01 kernel: [2880378.974467] [drm] PSP is resuming...
2024-02-21T15:36:54.637111-08:00 mhall-xps-01 kernel: [2880378.996584] [drm] reserve 0xa00000 from 0xf41e000000 for PSP TMR
2024-02-21T15:36:54.961131-08:00 mhall-xps-01 kernel: [2880379.321327] amdgpu 0000:67:00.0: amdgpu: RAS: optional ras ta ucode is not available
2024-02-21T15:36:54.973091-08:00 mhall-xps-01 kernel: [2880379.333287] amdgpu 0000:67:00.0: amdgpu: RAP: optional rap ta ucode is not available
2024-02-21T15:36:54.973099-08:00 mhall-xps-01 kernel: [2880379.333292] amdgpu 0000:67:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
2024-02-21T15:36:54.973101-08:00 mhall-xps-01 kernel: [2880379.333300] amdgpu 0000:67:00.0: amdgpu: SMU is resuming...
2024-02-21T15:36:54.977097-08:00 mhall-xps-01 kernel: [2880379.334001] amdgpu 0000:67:00.0: amdgpu: SMU is resumed successfully!
2024-02-21T15:36:54.977105-08:00 mhall-xps-01 kernel: [2880379.335963] [drm] DMUB hardware initialized: version=0x0400003F
2024-02-21T15:36:55.981082-08:00 mhall-xps-01 kernel: [2880380.339381] [drm] kiq ring mec 2 pipe 1 q 0
2024-02-21T15:36:55.985137-08:00 mhall-xps-01 kernel: [2880380.344491] [drm] VCN decode and encode initialized successfully(under DPG Mode).
2024-02-21T15:36:55.985148-08:00 mhall-xps-01 kernel: [2880380.345269] [drm] JPEG decode initialized successfully.
2024-02-21T15:36:55.985149-08:00 mhall-xps-01 kernel: [2880380.345274] amdgpu 0000:67:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-02-21T15:36:55.985150-08:00 mhall-xps-01 kernel: [2880380.345278] amdgpu 0000:67:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-02-21T15:36:55.985151-08:00 mhall-xps-01 kernel: [2880380.345279] amdgpu 0000:67:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-02-21T15:36:55.985152-08:00 mhall-xps-01 kernel: [2880380.345281] amdgpu 0000:67:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
2024-02-21T15:36:55.985152-08:00 mhall-xps-01 kernel: [2880380.345283] amdgpu 0000:67:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
2024-02-21T15:36:55.985153-08:00 mhall-xps-01 kernel: [2880380.345284] amdgpu 0000:67:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
2024-02-21T15:36:55.985153-08:00 mhall-xps-01 kernel: [2880380.345286] amdgpu 0000:67:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
2024-02-21T15:36:55.985154-08:00 mhall-xps-01 kernel: [2880380.345288] amdgpu 0000:67:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
2024-02-21T15:36:55.985154-08:00 mhall-xps-01 kernel: [2880380.345289] amdgpu 0000:67:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
2024-02-21T15:36:55.985155-08:00 mhall-xps-01 kernel: [2880380.345291] amdgpu 0000:67:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 11 on hub 0
2024-02-21T15:36:55.985156-08:00 mhall-xps-01 kernel: [2880380.345293] amdgpu 0000:67:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-02-21T15:36:55.985168-08:00 mhall-xps-01 kernel: [2880380.345295] amdgpu 0000:67:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on hub 8
2024-02-21T15:36:55.985168-08:00 mhall-xps-01 kernel: [2880380.345296] amdgpu 0000:67:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 on hub 8
2024-02-21T15:36:55.985169-08:00 mhall-xps-01 kernel: [2880380.345298] amdgpu 0000:67:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 on hub 8
2024-02-21T15:36:55.985169-08:00 mhall-xps-01 kernel: [2880380.345299] amdgpu 0000:67:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on hub 8
2024-02-21T15:36:55.991915-08:00 mhall-xps-01 kernel: [2880380.352137] amdgpu 0000:67:00.0: amdgpu: recover vram bo from shadow start
2024-02-21T15:36:55.991926-08:00 mhall-xps-01 kernel: [2880380.352143] amdgpu 0000:67:00.0: amdgpu: recover vram bo from shadow done
2024-02-21T15:36:55.991928-08:00 mhall-xps-01 kernel: [2880380.352174] amdgpu 0000:67:00.0: amdgpu: GPU reset(1) succeeded!
2024-02-21T15:36:55.991929-08:00 mhall-xps-01 kernel: [2880380.352193] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991930-08:00 mhall-xps-01 kernel: [2880380.352203] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991932-08:00 mhall-xps-01 kernel: [2880380.352210] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991933-08:00 mhall-xps-01 kernel: [2880380.352221] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991935-08:00 mhall-xps-01 kernel: [2880380.352227] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991936-08:00 mhall-xps-01 kernel: [2880380.352235] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991937-08:00 mhall-xps-01 kernel: [2880380.352258] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991939-08:00 mhall-xps-01 kernel: [2880380.352262] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991940-08:00 mhall-xps-01 kernel: [2880380.352284] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991941-08:00 mhall-xps-01 kernel: [2880380.352299] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991942-08:00 mhall-xps-01 kernel: [2880380.352312] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991943-08:00 mhall-xps-01 kernel: [2880380.352325] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991944-08:00 mhall-xps-01 kernel: [2880380.352339] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991945-08:00 mhall-xps-01 kernel: [2880380.352358] [drm] Skip scheduling IBs!
2024-02-21T15:36:55.991947-08:00 mhall-xps-01 kernel: [2880380.352366] [drm] Skip scheduling IBs!
2024-02-21T15:36:56.989097-08:00 mhall-xps-01 kernel: [2880381.345919] [drm] PCIE GART of 512M enabled (table at 0x00000080FEB00000).
2024-02-21T15:36:56.989113-08:00 mhall-xps-01 kernel: [2880381.345949] [drm] PSP is resuming...
2024-02-21T15:36:57.065064-08:00 mhall-xps-01 kernel: [2880381.421985] [drm] reserve 0xa00000 from 0x80fd000000 for PSP TMR
2024-02-21T15:36:57.161054-08:00 mhall-xps-01 kernel: [2880381.521330] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available
2024-02-21T15:36:57.177051-08:00 mhall-xps-01 kernel: [2880381.536487] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
2024-02-21T15:36:57.177055-08:00 mhall-xps-01 kernel: [2880381.536493] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
2024-02-21T15:36:57.177056-08:00 mhall-xps-01 kernel: [2880381.536498] amdgpu 0000:03:00.0: amdgpu: smu driver if version = 0x0000000d, smu fw if version = 0x0000000f, smu fw program = 0, version = 0x00492000 (73.32.0)
2024-02-21T15:36:57.177057-08:00 mhall-xps-01 kernel: [2880381.536504] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
2024-02-21T15:36:57.217055-08:00 mhall-xps-01 kernel: [2880381.575099] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
2024-02-21T15:36:57.217063-08:00 mhall-xps-01 kernel: [2880381.576452] [drm] DMUB hardware initialized: version=0x02020017
2024-02-21T15:36:57.221054-08:00 mhall-xps-01 kernel: [2880381.579774] [drm] kiq ring mec 2 pipe 1 q 0
2024-02-21T15:36:57.225060-08:00 mhall-xps-01 kernel: [2880381.583037] [drm] VCN decode and encode initialized successfully(under DPG Mode).
2024-02-21T15:36:57.225062-08:00 mhall-xps-01 kernel: [2880381.583055] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-02-21T15:36:57.225063-08:00 mhall-xps-01 kernel: [2880381.583057] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-02-21T15:36:57.225063-08:00 mhall-xps-01 kernel: [2880381.583059] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-02-21T15:36:57.225064-08:00 mhall-xps-01 kernel: [2880381.583060] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
2024-02-21T15:36:57.225065-08:00 mhall-xps-01 kernel: [2880381.583061] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
2024-02-21T15:36:57.225066-08:00 mhall-xps-01 kernel: [2880381.583063] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
2024-02-21T15:36:57.225066-08:00 mhall-xps-01 kernel: [2880381.583064] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
2024-02-21T15:36:57.225067-08:00 mhall-xps-01 kernel: [2880381.583066] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
2024-02-21T15:36:57.225067-08:00 mhall-xps-01 kernel: [2880381.583067] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
2024-02-21T15:36:57.225068-08:00 mhall-xps-01 kernel: [2880381.583069] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 11 on hub 0
2024-02-21T15:36:57.225068-08:00 mhall-xps-01 kernel: [2880381.583070] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-02-21T15:36:57.225069-08:00 mhall-xps-01 kernel: [2880381.583071] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on hub 8
2024-02-21T15:36:57.237126-08:00 mhall-xps-01 kernel: [2880381.595618] [drm] Skip scheduling IBs!
2024-02-21T15:36:57.237133-08:00 mhall-xps-01 kernel: [2880381.595637] [drm] Skip scheduling IBs!
2024-02-21T15:36:57.237134-08:00 mhall-xps-01 kernel: [2880381.595648] [drm] Skip scheduling IBs!
... SNIPPED ...
2024-02-21T15:36:57.621302-08:00 mhall-xps-01 kernel: [2880381.979192] [drm] Skip scheduling IBs!
2024-02-21T15:36:57.621303-08:00 mhall-xps-01 kernel: [2880381.979199] [drm] Skip scheduling IBs!
2024-02-21T15:36:57.621303-08:00 mhall-xps-01 kernel: [2880381.979205] [drm] Skip scheduling IBs!
2024-02-21T15:36:57.665432-08:00 mhall-xps-01 kernel: [2880382.021491] workqueue: delayed_fput hogged CPU for >10000us 16 times, consider switching to WQ_UNBOUND
2024-02-21T15:37:23.225433-08:00 mhall-xps-01 kernel: [2880397.341439] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
2024-02-21T15:37:33.465409-08:00 mhall-xps-01 kernel: [2880407.580685] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
2024-02-21T15:37:43.705091-08:00 mhall-xps-01 kernel: [2880417.820114] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
2024-02-21T15:37:53.945389-08:00 mhall-xps-01 kernel: [2880428.059779] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
2024-02-21T15:38:04.185799-08:00 mhall-xps-01 kernel: [2880438.299089] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
2024-02-21T15:38:14.425239-08:00 mhall-xps-01 kernel: [2880448.538928] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
2024-02-21T15:38:24.665410-08:00 mhall-xps-01 kernel: [2880458.778463] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
2024-02-21T15:38:34.905460-08:00 mhall-xps-01 kernel: [2880469.017993] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
2024-02-21T15:38:45.145251-08:00 mhall-xps-01 kernel: [2880479.257543] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
2024-02-21T15:38:55.385743-08:00 mhall-xps-01 kernel: [2880489.496921] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
2024-02-21T15:39:05.625422-08:00 mhall-xps-01 kernel: [2880499.736383] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
2024-02-21T15:39:15.865455-08:00 mhall-xps-01 kernel: [2880509.976241] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
2024-02-21T15:39:26.105410-08:00 mhall-xps-01 kernel: [2880520.215766] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
2024-02-21T15:39:36.345444-08:00 mhall-xps-01 kernel: [2880530.455123] [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* wait_for_completion_timeout timeout!
