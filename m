Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D3FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Mar 2022 13:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBD710E1F0;
	Wed, 30 Mar 2022 13:58:06 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABA310E1F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Mar 2022 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KI3h6W+pOEwwApRyiycZlOjDzQv6Mf2lAJP4LJqXUgo=; b=KK7crrj/Rqs+k9RYlriZYTbZ2o
 Gs+qeD8uMRpQfSCxhhWCSb9x+PQH1Y3fxMEkHHYaWDrZqT9sMUx8XlAEtlAvZzN72/sNAEU/lFMW5
 0tpfOzzysI17FxyXfmxDKW05z10+2o7Qun/rkP2EvVEGDCdTukaYLOj3lJp1w4wjzAf26im4W77Y7
 Ui/xZxsS8oe7olGwFhfWQ+SjYojx6rdeSZXFa5yNVaWtxKgYxVhjd5zceW3GaHNLT75/d+6UYtDmi
 7FZ1DdWeDSntnxkq1NX7XU+DAjRcFtpA0GxEUL0z0/ZXDeHtU/5s2nKE1PFvSU2EOE6hJNq/CzRUC
 XPx+drAQ==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1nZYph-0002AB-WB; Wed, 30 Mar 2022 15:57:58 +0200
Date: Wed, 30 Mar 2022 12:57:37 -0100
From: Melissa Wen <mwen@igalia.com>
To: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix by adding FPU protection for
 dcn30_internal_validate_bw
Message-ID: <20220330135737.iuoo7qnjbhthjs45@mail.igalia.com>
References: <20220329082957.1662655-1-chandan.vurdigerenataraj@amd.com>
 <c8c00a40-5f1f-d861-adde-3dc246cd2338@molgen.mpg.de>
 <MW4PR12MB5668E0D09D8A0B1D9B7E6EC2961F9@MW4PR12MB5668.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3kbb4uu6alzir3nw"
Content-Disposition: inline
In-Reply-To: <MW4PR12MB5668E0D09D8A0B1D9B7E6EC2961F9@MW4PR12MB5668.namprd12.prod.outlook.com>
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--3kbb4uu6alzir3nw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/30, VURDIGERENATARAJ, CHANDAN wrote:
> Hi Paul,
>=20
> >Am 29.03.22 um 10:29 schrieb CHANDAN VURDIGERE NATARAJ:
> >
> >Is it common to spell your name all uppercase? If not, please use Chanda=
n nVurdigere Nataraj.
> >
> >> [WHY]
> >
> >The [] already emphasize the word, so Why could be used.
> >
> >> Below general protection fault observed when WebGL Aquarium is run for=
=20
> >> longer duration. If drm debug logs are enabled and set to 0x1f then=20
> >> the
> >
> >In what browser and what version?
> The issue was observed on ChromiumOS and Chromium Browser version 100.0.4=
877.0
> >
> >> issue is observed within 10 minutes of run.
> >
> >Where you able to reproduce it without drm debug logs?
> Yes. It took 34 hours to reproduce without drm debug logs. Using drm debu=
g logs was a faster way to reproduce the issue.
> >
> >> [  100.717056] general protection fault, probably for non-canonical ad=
dress 0x2d33302d32323032: 0000 [#1] PREEMPT SMP NOPTI
> >> [  100.727921] CPU: 3 PID: 1906 Comm: DrmThread Tainted: G        W   =
      5.15.30 #12 d726c6a2d6ebe5cf9223931cbca6892f916fe18b
> >> [  100.754419] RIP: 0010:CalculateSwathWidth+0x1f7/0x44f
> >> [  100.767109] Code: 00 00 00 f2 42 0f 11 04 f0 48 8b 85 88 00 00 00=
=20
> >> f2 42 0f 10 04 f0 48 8b 85 98 00 00 00 f2 42 0f 11 04 f0 48 8b 45 10=
=20
> >> 0f 57 c0 <f3> 42 0f 2a 04 b0 0f 57 c9 f3 43 0f 2a 0c b4 e8 8c e2 f3 ff=
=20
> >> 48 8b [  100.781269] RSP: 0018:ffffa9230079eeb0 EFLAGS: 00010246 [ =20
> >> 100.812528] RAX: 2d33302d32323032 RBX: 0000000000000500 RCX:=20
> >> 0000000000000000 [  100.819656] RDX: 0000000000000001 RSI:=20
> >> ffff99deb712c49c RDI: 0000000000000000 [  100.826781] RBP:=20
> >> ffffa9230079ef50 R08: ffff99deb712460c R09: ffff99deb712462c [ =20
> >> 100.833907] R10: ffff99deb7124940 R11: ffff99deb7124d70 R12:=20
> >> ffff99deb712ae44 [  100.841033] R13: 0000000000000001 R14:=20
> >> 0000000000000000 R15: ffffa9230079f0a0 [  100.848159] FS:  00007af1212=
12640(0000) GS:ffff99deba780000(0000) knlGS:0000000000000000 [  100.856240]=
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [  100.861980] CR2: 0000=
209000fe1000 CR3: >000000011b18c000 CR4: 0000000000350ee0 [  100.869106] Ca=
ll Trace:
> >> [  100.871555]  <TASK>
> >> [  100.873655]  ? asm_sysvec_reschedule_ipi+0x12/0x20
> >> [  100.878449]  CalculateSwathAndDETConfiguration+0x1a3/0x6dd
> >> [  100.883937] =20
> >> dml31_ModeSupportAndSystemConfigurationFull+0x2ce4/0x76da
> >> [  100.890467]  ? kallsyms_lookup_buildid+0xc8/0x163
> >> [  100.895173]  ? kallsyms_lookup_buildid+0xc8/0x163
> >> [  100.899874]  ? __sprint_symbol+0x80/0x135 [  100.903883]  ?=20
> >> dm_update_plane_state+0x3f9/0x4d2 [  100.908500]  ?=20
> >> symbol_string+0xb7/0xde [  100.912250]  ? number+0x145/0x29b [ =20
> >> 100.915566]  ? vsnprintf+0x341/0x5ff [  100.919141]  ?=20
> >> desc_read_finalized_seq+0x39/0x87 [  100.923755]  ?=20
> >> update_load_avg+0x1b9/0x607 [  100.927849]  ?=20
> >> compute_mst_dsc_configs_for_state+0x7d/0xd5b
> >> [  100.933416]  ? fetch_pipe_params+0xa4d/0xd0c [  100.937686]  ?=20
> >> dc_fpu_end+0x3d/0xa8 [  100.941175]  dml_get_voltage_level+0x16b/0x180=
=20
> >> [  100.945619]  dcn30_internal_validate_bw+0x10e/0x89b
> >> [  100.950495]  ? dcn31_validate_bandwidth+0x68/0x1fc
> >> [  100.955285]  ? resource_build_scaling_params+0x98b/0xb8c
> >> [  100.960595]  ? dcn31_validate_bandwidth+0x68/0x1fc
> >> [  100.965384]  dcn31_validate_bandwidth+0x9a/0x1fc
> >> [  100.970001]  dc_validate_global_state+0x238/0x295
> >> [  100.974703]  amdgpu_dm_atomic_check+0x9c1/0xbce
> >> [  100.979235]  ? _printk+0x59/0x73
> >> [  100.982467]  drm_atomic_check_only+0x403/0x78b [  100.986912] =20
> >> drm_mode_atomic_ioctl+0x49b/0x546 [  100.991358]  ?=20
> >> drm_ioctl+0x1c1/0x3b3 [  100.994936]  ?=20
> >> drm_atomic_set_property+0x92a/0x92a
> >> [  100.999725]  drm_ioctl_kernel+0xdc/0x149 [  101.003648] =20
> >> drm_ioctl+0x27f/0x3b3 [  101.007051]  ?=20
> >> drm_atomic_set_property+0x92a/0x92a
> >> [  101.011842]  amdgpu_drm_ioctl+0x49/0x7d [  101.015679] =20
> >> __se_sys_ioctl+0x7c/0xb8 [  101.015685]  do_syscall_64+0x5f/0xb8 [ =20
> >> 101.015690]  ? __irq_exit_rcu+0x34/0x96
> >>=20
> >> [HOW]
> >> It calles populate_dml_pipes which uses doubles to initialize.
> >
> >calls
> >
> >Excuse my ignorance. So using doubles causes a context switch?
> If we don=E2=80=99t add FPU protection then context switch can happen. DC=
_FP_START would in-turn call preempt_disable.
>=20
> >> Adding FPU protection avoids context switch and probable loss of vba=
=20
> >> context as there is potential contention while drm debug logs are enab=
led.
> >>=20
> >> Signed-off-by: CHANDAN VURDIGERE NATARAJ=20
> >> <chandan.vurdigerenataraj@amd.com>
> >>=20
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c=20
> >> b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> >> index 826970f2bd0a..f27262417abe 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> >> @@ -1750,7 +1750,9 @@ bool dcn31_validate_bandwidth(struct dc *dc,
> >>  =20
> >>   	BW_VAL_TRACE_COUNT();
> >>  =20
> >> +	DC_FP_START();
> >>   	out =3D dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt,=
=20
> >> &vlevel, fast_validate);
> >> +	DC_FP_END();
> >>  =20
> >>   	// Disable fast_validate to set min dcfclk in alculate_wm_and_dlg
> >>   	if (pipe_cnt =3D=3D 0)
Acked-by: Melissa Wen <mwen@igalia.com>

In fact, I revisited the code and realized the FPU protection is
missing for two other dcn30 functions called by dcn31:
- dcn30_populate_dml_writeback_from_context()
- dcn30_set_mcif_arb_params()

I'll send a patch addressing this shortly.

CC'ing: Siqueira

Best regards,

Melissa
> >
> >
> >Kind regards,
> >
> >Paul

--3kbb4uu6alzir3nw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmJEYcwACgkQwqF3j0dL
ehzF8Q/+JKyPOam1bFQ2z89ZRkuExbcaryIzqs3FtmRMiil1a+U90ukdjVyAki4k
KXVEfD1BYepq/b3TwRHbRcKV/peXDmqcPRccFHYl+EBWrTuHkSP87B5/08GAoEMC
6phWZUL3OIylPxHKy0dbrOhjjr0BAVz3tA0v7n2NKuroR3mTrk33m0yJDSH41E4K
2CwHfrmiOb5tEH5fXBqs38j5a1cGRCPjndeZgGgMcMvS9B++myYXx/5vTkB46n1a
rU4+UWm33O2KfIlJfpQEqn+wd9sY50ON2eLAH6lvu5yLR7Glc6wL93/Vi3Uy52ns
cHciJab9XuK3mFhCdTFppZ8ESzH9+AtJm8dtJyMdhYexBDeCtQGZYywHKkv/umWn
QCFs1Sf1y5QL4IsN4ZiVvKqwhPDMotj+4CHXE0YLqk/ulcHiUPTrB4zVKIX/4ESP
DyRPYt0V8GbZWXd6wuazHdY+sZO7l+TyHQzas8JL5pF7xWHENpL/0ag3gEot6i1W
hBwthrBjOsd4oY+O8N8mNSmcArotqEjatKrsC39xaWJLBtTq8ywoiOyW/73oo1vw
nsrssebLz0z4nuGYmfA2y2dhb8GeAi4exhpcR4i7DEslcMHJVavFsq2EI0lb1/3p
uFLOv1G3UmgSBdrkO9EZq9BjS4JnVEw0kkirSt/B6qS4Nv1hrkE=
=88so
-----END PGP SIGNATURE-----

--3kbb4uu6alzir3nw--
