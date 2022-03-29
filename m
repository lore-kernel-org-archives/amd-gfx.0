Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87358C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 16:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0A210F161;
	Tue, 29 Mar 2022 16:46:40 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D15210F160
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 16:46:39 +0000 (UTC)
Received: from [192.168.0.4] (ip5f5aef5a.dynamic.kabel-deutschland.de
 [95.90.239.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1589761E64846;
 Tue, 29 Mar 2022 18:46:37 +0200 (CEST)
Message-ID: <c8c00a40-5f1f-d861-adde-3dc246cd2338@molgen.mpg.de>
Date: Tue, 29 Mar 2022 18:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amd/display: Fix by adding FPU protection for
 dcn30_internal_validate_bw
Content-Language: en-US
To: CHANDAN VURDIGERE NATARAJ <chandan.vurdigerenataraj@amd.com>
References: <20220329082957.1662655-1-chandan.vurdigerenataraj@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220329082957.1662655-1-chandan.vurdigerenataraj@amd.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Chandan,


Am 29.03.22 um 10:29 schrieb CHANDAN VURDIGERE NATARAJ:

Is it common to spell your name all uppercase? If not, please use 
Chandan nVurdigere Nataraj.

> [WHY]

The [] already emphasize the word, so Why could be used.

> Below general protection fault observed when WebGL Aquarium is run for
> longer duration. If drm debug logs are enabled and set to 0x1f then the

In what browser and what version?

> issue is observed within 10 minutes of run.

Where you able to reproduce it without drm debug logs?

> [  100.717056] general protection fault, probably for non-canonical address 0x2d33302d32323032: 0000 [#1] PREEMPT SMP NOPTI
> [  100.727921] CPU: 3 PID: 1906 Comm: DrmThread Tainted: G        W         5.15.30 #12 d726c6a2d6ebe5cf9223931cbca6892f916fe18b
> [  100.754419] RIP: 0010:CalculateSwathWidth+0x1f7/0x44f
> [  100.767109] Code: 00 00 00 f2 42 0f 11 04 f0 48 8b 85 88 00 00 00 f2 42 0f 10 04 f0 48 8b 85 98 00 00 00 f2 42 0f 11 04 f0 48 8b 45 10 0f 57 c0 <f3> 42 0f 2a 04 b0 0f 57 c9 f3 43 0f 2a 0c b4 e8 8c e2 f3 ff 48 8b
> [  100.781269] RSP: 0018:ffffa9230079eeb0 EFLAGS: 00010246
> [  100.812528] RAX: 2d33302d32323032 RBX: 0000000000000500 RCX: 0000000000000000
> [  100.819656] RDX: 0000000000000001 RSI: ffff99deb712c49c RDI: 0000000000000000
> [  100.826781] RBP: ffffa9230079ef50 R08: ffff99deb712460c R09: ffff99deb712462c
> [  100.833907] R10: ffff99deb7124940 R11: ffff99deb7124d70 R12: ffff99deb712ae44
> [  100.841033] R13: 0000000000000001 R14: 0000000000000000 R15: ffffa9230079f0a0
> [  100.848159] FS:  00007af121212640(0000) GS:ffff99deba780000(0000) knlGS:0000000000000000
> [  100.856240] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  100.861980] CR2: 0000209000fe1000 CR3: 000000011b18c000 CR4: 0000000000350ee0
> [  100.869106] Call Trace:
> [  100.871555]  <TASK>
> [  100.873655]  ? asm_sysvec_reschedule_ipi+0x12/0x20
> [  100.878449]  CalculateSwathAndDETConfiguration+0x1a3/0x6dd
> [  100.883937]  dml31_ModeSupportAndSystemConfigurationFull+0x2ce4/0x76da
> [  100.890467]  ? kallsyms_lookup_buildid+0xc8/0x163
> [  100.895173]  ? kallsyms_lookup_buildid+0xc8/0x163
> [  100.899874]  ? __sprint_symbol+0x80/0x135
> [  100.903883]  ? dm_update_plane_state+0x3f9/0x4d2
> [  100.908500]  ? symbol_string+0xb7/0xde
> [  100.912250]  ? number+0x145/0x29b
> [  100.915566]  ? vsnprintf+0x341/0x5ff
> [  100.919141]  ? desc_read_finalized_seq+0x39/0x87
> [  100.923755]  ? update_load_avg+0x1b9/0x607
> [  100.927849]  ? compute_mst_dsc_configs_for_state+0x7d/0xd5b
> [  100.933416]  ? fetch_pipe_params+0xa4d/0xd0c
> [  100.937686]  ? dc_fpu_end+0x3d/0xa8
> [  100.941175]  dml_get_voltage_level+0x16b/0x180
> [  100.945619]  dcn30_internal_validate_bw+0x10e/0x89b
> [  100.950495]  ? dcn31_validate_bandwidth+0x68/0x1fc
> [  100.955285]  ? resource_build_scaling_params+0x98b/0xb8c
> [  100.960595]  ? dcn31_validate_bandwidth+0x68/0x1fc
> [  100.965384]  dcn31_validate_bandwidth+0x9a/0x1fc
> [  100.970001]  dc_validate_global_state+0x238/0x295
> [  100.974703]  amdgpu_dm_atomic_check+0x9c1/0xbce
> [  100.979235]  ? _printk+0x59/0x73
> [  100.982467]  drm_atomic_check_only+0x403/0x78b
> [  100.986912]  drm_mode_atomic_ioctl+0x49b/0x546
> [  100.991358]  ? drm_ioctl+0x1c1/0x3b3
> [  100.994936]  ? drm_atomic_set_property+0x92a/0x92a
> [  100.999725]  drm_ioctl_kernel+0xdc/0x149
> [  101.003648]  drm_ioctl+0x27f/0x3b3
> [  101.007051]  ? drm_atomic_set_property+0x92a/0x92a
> [  101.011842]  amdgpu_drm_ioctl+0x49/0x7d
> [  101.015679]  __se_sys_ioctl+0x7c/0xb8
> [  101.015685]  do_syscall_64+0x5f/0xb8
> [  101.015690]  ? __irq_exit_rcu+0x34/0x96
> 
> [HOW]
> It calles populate_dml_pipes which uses doubles to initialize.

calls

Excuse my ignorance. So using doubles causes a context switch?

> Adding FPU protection avoids context switch and probable loss of vba context
> as there is potential contention while drm debug logs are enabled.
> 
> Signed-off-by: CHANDAN VURDIGERE NATARAJ <chandan.vurdigerenataraj@amd.com>
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index 826970f2bd0a..f27262417abe 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -1750,7 +1750,9 @@ bool dcn31_validate_bandwidth(struct dc *dc,
>   
>   	BW_VAL_TRACE_COUNT();
>   
> +	DC_FP_START();
>   	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
> +	DC_FP_END();
>   
>   	// Disable fast_validate to set min dcfclk in alculate_wm_and_dlg
>   	if (pipe_cnt == 0)


Kind regards,

Paul
