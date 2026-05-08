Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98FFCD37AC
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 07:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13AB10E4AC;
	Mon, 11 May 2026 07:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=xry111.site header.i=@xry111.site header.b="FBlrDdW5";
	dkim-atps=neutral
Received: from xry111.site (xry111.site [89.208.246.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E1C10F3EA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 08:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
 s=default; t=1778227882;
 bh=BJNs5GPK+NnrwTQipFNZw2RWaEJGs2bI5Vw8gHPnVjM=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=FBlrDdW5a9LeiLl1abY+7fcl7o/Ki5orZN7AcnN8DHnFxOIN+RwOH+EN7E1CtSNbM
 +i1/DRcr9EY3Zkhz0g/9eGMNsRNYfkXerGo+2ngn7wkuYGeArZyzse9NWoKsNbQAjD
 +am4AW0zO8JHSvnCfP4gAzWz1bJIFQfdToDBd2LA=
Received: from [IPv6:2409:8a4c:e1f:d2d0:3663:3ffe:842d:4c31] (unknown
 [IPv6:2409:8a4c:e1f:d2d0:3663:3ffe:842d:4c31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1)
 server-digest SHA384) (Client did not present a certificate)
 (Authenticated sender: xry111@xry111.site)
 by xry111.site (Postfix) with ESMTPSA id A539865992;
 Fri,  8 May 2026 04:11:16 -0400 (EDT)
Message-ID: <df24e57df62dc4d0a9385a20f6476808b133be71.camel@xry111.site>
Subject: Re: [PATCH v2 24/30] drm/amd/display: Move FPU Guards From DML To
 DC - Part 2
From: Xi Ruoyao <xry111@xry111.site>
To: ChuanYu Tseng <ChuanYu.Tseng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung	 <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler	 <daniel.wheeler@amd.com>, Ray
 Wu <Ray.Wu@amd.com>, Ivan Lipski	 <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Rafal Ostrowski	 <rafal.ostrowski@amd.com>, Dillon
 Varone <dillon.varone@amd.com>, Mingcong Bai	 <jeffbai@aosc.io>, xinmu
 <xinmu@xinmu.moe>
Date: Fri, 08 May 2026 16:11:07 +0800
In-Reply-To: <20260326030153.406612-25-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
 <20260326030153.406612-25-ChuanYu.Tseng@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 May 2026 07:30:27 +0000
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

On Thu, 2026-03-26 at 10:57 +0800, ChuanYu Tseng wrote:

> FPU guards (DC_FP_START/DC_FP_END) are required to wrap around code that
> can manipulates floats. To do this properly, the FPU guards must be used
> in a file that is not compiled as a FPU unit. If the guards are used in
> a file that is a FPU unit, other sections in the file that aren't guarded
> may be end up being compiled to use FPU operations.

/* snip */

> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c b/drive=
rs/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c

We have:

CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o :=3D $(dml2_rcflags)

and

dml2_rcflags :=3D $(CC_FLAGS_NO_FPU)

so this file isn't compiled as a FPU unit.  Why removing the guards
here?

/* snip */

> index 408559d6fb2d..f8250c80be02 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
> @@ -6,7 +6,20 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include "dml2_internal_types.h"
> +#include "dml2_wrapper.h"
> =C2=A0#include "dml2_wrapper_fpu.h"
> +#include "dml21_wrapper.h"
> +#include "dml21_wrapper_fpu.h"
> +
> +#include "dc_fpu.h"
> +
> +struct dml2_context *dml2_allocate_memory(void)
> +{
> +	struct dml2_context *dml2;
> +
> +	DC_RUN_WITH_PREEMPTION_ENABLED(dml2 =3D vzalloc(sizeof(struct dml2_cont=
ext)));
> +	return dml2;
> +}
> =C2=A0
> =C2=A0bool dml2_validate(const struct dc *in_dc, struct dc_state *context=
, struct dml2_context *dml2,
> =C2=A0	enum dc_validate_mode validate_mode)
> @@ -23,16 +36,12 @@ bool dml2_validate(const struct dc *in_dc, struct dc_=
state *context, struct dml2
> =C2=A0		return out;
> =C2=A0	}
> =C2=A0
> -	DC_FP_START();

Notably the removal of this is causing:

[    3.943927] do_fpu invoked from kernel context![#1]:
[    3.948860] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 7.0.3-ao=
sc-main-4k #2 PREEMPT(lazy)
[    3.957938] Hardware name: Loongson Loongson-3B6000x1-7A2000x1-XB612B0_v=
1.1/XB612B0_v1.1, BIOS Loongson-FwSdk-V5.0.0431-stable202602 04/10/26 09:20=
:09
[    3.971334] Workqueue: sync_wq local_pci_probe_callback
[    3.976528] pc ffff800002becd80 ra ffff800002becd30 tp 90000001005d8000 =
sp 90000001005db5e0
[    3.984827] a0 ffff80001326ebf8 a1 0000000000000000 a2 ffff80001326ec98 =
a3 ffff80001326ec90
[    3.993124] a4 ffff80001326ec90 a5 0000000000000000 a6 0000000000000000 =
a7 0000000000000000
[    4.001422] t0 ffff800003327000 t1 ffff80001326f000 t2 0000000000000001 =
t3 0000000000000000
[    4.009720] t4 0000000000000004 t5 0000000000000100 t6 0000000000000000 =
t7 0000000000000000
[    4.018018] t8 0000000000000000 u0 ffff800002be8220 s9 90000001413e2000 =
s0 9000000160c00000
[    4.026316] s1 9000000161c80000 s2 9000000160c00000 s3 90000001223af080 =
s4 9000000161c80000
[    4.034613] s5 9000000160c00000 s6 9000000161c80000 s7 9000000161c40000 =
s8 ffff80001326a000
[    4.042912]    ra: ffff800002becd30 dml21_map_dc_state_into_dml_display_=
cfg+0x40/0x12a0 [amdgpu]
[    4.052169]   ERA: ffff800002becd80 dml21_map_dc_state_into_dml_display_=
cfg+0x90/0x12a0 [amdgpu]
[    4.061277]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
[    4.067423]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[    4.071749]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[    4.076508]  ECFG: 00071c1d (LIE=3D0,2-4,10-12 VS=3D7)
[    4.081266] ESTAT: 000f0000 [FPD] (IS=3D ECode=3D15 EsubCode=3D0)
[    4.086801]  PRID: 0014d011 (Loongson-64bit, Loongson-3B6000)
[    4.092507] Modules linked in: amdgpu(+) hid_logitech_dj i2c_algo_bit dr=
m_ttm_helper ttm drm_exec drm_suballoc_helper drm_buddy drm_panel_backlight=
_quirks gpu_sched amdxcp drm_display_helper cec hid_generic pwm_loongson la=
_ow_syscall
 ntsync i2c_dev dmi_sysfs
[    4.115253] Process kworker/0:1 (pid: 11, threadinfo=3D00000000187c43c8,=
 task=3D00000000627a7089)
[    4.123725] Stack : ffff8000135e6360 ffff8000135e66b8 0000000000000000 0=
000043800000780
[    4.131681]         ffff800003328000 9000000161c40000 9000000161c802d8 f=
fff800002c32b28
[    4.139637]         ffff8000135e63f0 0000000000000000 0000000000000000 0=
000000000000000
[    4.147592]         0000000000000000 0000000000000000 0000000000000000 9=
000000121846010
[    4.155548]         0000000000000000 9000000161c80000 9000000161c80000 0=
000000000000001
[    4.163504]         0000000000000001 90000001223af080 9000000160c00000 f=
fff80001326a000
[    4.171460]         ffff80001326a000 ffff800002bef274 9000000161c86000 0=
000000000000001
[    4.179415]         0000000000000010 0000000000000001 9000000161c80000 f=
fff800002aeb330
[    4.187371]         9000000160c00000 9000000160c00000 90000001413e2000 9=
0000001223af080
[    4.195326]         0000000000000010 0000000000000001 90000001415b0000 f=
fff800002851348
[    4.203282]         ...
[    4.205705] Call Trace:
[    4.205707] [<ffff800002becd80>] dml21_map_dc_state_into_dml_display_cfg=
+0x90/0x12a0 [amdgpu]
[    4.216978] [<ffff800002bef270>] dml21_validate+0xc0/0x160 [amdgpu]
[    4.223573] [<ffff800002aeb32c>] dcn401_validate_bandwidth+0xdc/0x290 [a=
mdgpu]
[    4.231156] [<ffff800002851344>] create_validate_stream_for_sink+0x574/0=
x5b0 [amdgpu]
[    4.239328] [<ffff800002851404>] amdgpu_dm_connector_mode_valid+0x84/0x2=
c0 [amdgpu]
[    4.247312] [<9000000006bc2db4>] drm_connector_mode_valid+0x44/0xc0
[    4.253542] [<9000000006bc2f6c>] __drm_helper_update_and_validate+0x13c/=
0x490
[    4.260632] [<9000000006bc35c8>] drm_helper_probe_single_connector_modes=
+0x308/0x6c0
[    4.268326] [<9000000006ba055c>] drm_client_modeset_probe+0x1bc/0x1a50
[    4.274811] [<9000000006bc5df8>] __drm_fb_helper_initial_config_and_unlo=
ck+0x38/0x6f0
[    4.282594] [<9000000006bccfcc>] drm_fbdev_client_hotplug+0x9c/0x120
[    4.288906] [<9000000006b9ddd0>] drm_client_register+0x60/0xb0
[    4.294702] [<9000000006bcd158>] drm_fbdev_client_setup+0xa8/0x260
[    4.300841] [<9000000006bcbed8>] drm_client_setup+0xf8/0x170
[    4.306461] [<ffff80000236a35c>] amdgpu_pci_probe+0x38c/0x8a0 [amdgpu]
[    4.313291] [<9000000006957294>] local_pci_probe+0x44/0xe0
[    4.318740] [<900000000695734c>] local_pci_probe_callback+0x1c/0x40
[    4.324965] [<9000000005a6d4f8>] process_one_work+0x1a8/0x670
[    4.330672] [<9000000005a6e42c>] worker_thread+0x1cc/0x3a0
[    4.336120] [<9000000005a787d4>] kthread+0x134/0x170
[    4.341049] [<90000000074a8314>] ret_from_kernel_thread+0x24/0x1d0
[    4.347191] [<90000000059e28c4>] ret_from_kernel_thread_asm+0xc/0x88
[    4.353504]
[    4.354975] Code: 40074580  1a00e76c  29c2207d <2bc1a078> 1400003d  2b92=
6198  038b03bd  00150369  29c30076
[    4.364664]
[    4.366156] ---[ end trace 0000000000000000 ]---

Reported-by: xinmu <xinmu@xinmu.moe>

--=20
Xi Ruoyao <xry111@xry111.site>
