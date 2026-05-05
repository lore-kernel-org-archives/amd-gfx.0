Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCF2FF8855
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 16:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C2710E03D;
	Tue,  5 May 2026 16:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=dyllankobal.com header.i=@dyllankobal.com header.b="MPLzdhHH";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC2510E03D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dyllankobal.com;
 s=protonmail2; t=1777999519; x=1778258719;
 bh=At1VEMueeNppDv1rBReMC1ElAAygysYMIIqJ2ue9MME=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=MPLzdhHHZZsMXp169Xgxf2hSCkZWDYtrlZaXezg2MkZRQVYdlISv2QSCaTBHB72EC
 FFzwfSpabObDtBq30vBcp7zbBMbe/MameSW/xrEZDfsqHttRWxfRrSUGZz2SOxgiI3
 AaXaVEM4L2mt+anxGVzY1cRl1aI58BrcVoqJBXHayczSYnxqk3W+PZFnhMCO0FP8xM
 qycoGx75J2zB9Y+RxH286xreZMNj6gJdxVFTwXI6QZbqrdNwETgR7M0fOzEQitCxxS
 c5WhUccUn3wZjMaFEGNLvHzJWiv83hnOvfTrl340RLUjZO4eqxeoOWvT6po5B4EU0m
 lxhf/+UTS/t1g==
Date: Tue, 05 May 2026 16:45:15 +0000
To: Harry Wentland <harry.wentland@amd.com>
From: Dyllan Kobal <dyllan@dyllankobal.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 15/21] drm/amd/display: Tie FRL programming together in
 HWSS
Message-ID: <zQoDVbkRUq6cOjFHY44CbOhFkxPKc3SsAlIZ32210blOHYO3EoaCw5vf6yI_3-2Ln299E0Ac78o7xSivgNoxHOE8R_mz9R5bu4a6YxbPQI8=@dyllankobal.com>
In-Reply-To: <8b617d99-7cfd-4637-997a-dd561d372730@amd.com>
References: <20260502140825.705534-1-dyllan@dyllankobal.com>
 <8b617d99-7cfd-4637-997a-dd561d372730@amd.com>
Feedback-ID: 33529580:user:proton
X-Pm-Message-ID: 5e8f12ea4bf9051fce34916d000a3e8d1a8a88ce
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

That works for me, thanks.

I=E2=80=99ve resent the commit with a new hash, https://gitlab.freedesktop.=
org/dyllan500/linux/-/commit/e1aa6f65150d606299eec5bf5a734e3b7c20c029. The =
only change is updating the author email to my work address for consistency=
 with future contributions.

Dyllan Kobal

On Tuesday, May 5th, 2026 at 11:36 AM, Harry Wentland <harry.wentland@amd.c=
om> wrote:

> Thanks for your fix, Dyllan, and for giving the series a spin.
>=20
> Would you mind if I simply picked up your patch from https://gitlab.freed=
esktop.org/dyllan500/linux/-/commit/560a1b22e4f764b8325e17f1d8f6dbbfd008e40=
9 when I merge the series?
>=20
> Harry
>=20
> On 2026-05-02 10:08, Dyllan Kobal wrote:
> > [You don't often get email from dyllan@dyllankobal.com. Learn why this =
is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Dyllan Kobal <dk@zetier.com>
> >
> > Hi Harry, Rodrigo, Jerry,
> >
> > Tested this series on Navi 22 (RX 6700 XT class, DCN 3.0.2) with a
> > Sony Bravia 8 II as the HDMI sink. Hit a NULL deref at amdgpu probe:
> >
> >   BUG: kernel NULL pointer dereference, address: 0000000000000000
> >   #PF: supervisor instruction fetch in kernel mode
> >   Oops: Oops: 0010 [#1] SMP NOPTI
> >   CPU: 14 UID: 0 PID: 568 Comm: (udev-worker) Not tainted 6.19.0+
> >   RIP: 0010:0x0
> >   Call Trace:
> >    <TASK>
> >    hdmi_frl_perform_link_training_with_fallback+0x64/0x110 [amdgpu]
> >    hdmi_frl_verify_link_cap+0x24e/0x5d0 [amdgpu]
> >    link_detect+0x4b4/0x550 [amdgpu]
> >    amdgpu_dm_initialize_drm_device+0x73f/0xb21 [amdgpu]
> >    amdgpu_dm_init.cold+0x734/0x86c [amdgpu]
> >    dm_hw_init+0x1b/0x90 [amdgpu]
> >    amdgpu_device_ip_init+0x690/0x7fe [amdgpu]
> >    amdgpu_device_init.cold+0x460/0x781 [amdgpu]
> >    amdgpu_driver_load_kms+0x19/0x80 [amdgpu]
> >    amdgpu_pci_probe+0x19b/0x550 [amdgpu]
> >
> > Cause: this patch wires .setup_hdmi_frl_link into the dcn314, dcn32,
> > dcn35, dcn351, dcn401 and dcn42 hwss tables, but not into dcn30's.
> > The dcn30 family (dcn30/302/303 =E2=80=94 Navi 21/22/23) does get FRL
> > resource creation per patches 16/17, so hdmi_frl_verify_link_cap()
> > runs on these ASICs and dispatches through the NULL
> > hwss.setup_hdmi_frl_link inside hdmi_frl_perform_link_training_with_fal=
lback().
> > amdgpu probe is fatally aborted with no display.
> >
> > Fix locally:
> >
> > --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
> > +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
> > @@ -105,6 +105,7 @@ static const struct hw_sequencer_funcs dcn30_funcs =
=3D {
> >         .enable_tmds_link_output =3D dce110_enable_tmds_link_output,
> >         .enable_dp_link_output =3D dce110_enable_dp_link_output,
> >         .disable_link_output =3D dce110_disable_link_output,
> > +       .setup_hdmi_frl_link =3D dcn30_setup_hdmi_frl_link,
> >         .set_disp_pattern_generator =3D dcn30_set_disp_pattern_generato=
r,
> >         .get_dcc_en_bits =3D dcn10_get_dcc_en_bits,
> >         .update_visual_confirm_color =3D dcn10_update_visual_confirm_co=
lor,
> >
> > With that one-line fix folded in, the Bravia comes up at 4K@120Hz
> > 10bpc RGB native FRL on cold boot. Live register state confirms the
> > HPO HDMI block is what is driving the link, not legacy TMDS:
> >
> >   - All legacy DIG[0-5] show DIG_BE_EN_CNTL.DIG_ENABLE =3D 0
> >   - All legacy SYMCLK[A-E] show CLOCK_ENABLE =3D 0
> >   - DIG0_HDMI_CONTROL.HDMI_DATA_SCRAMBLE_EN =3D 0
> >     (HDMI 2.0 TMDS scramble path is provably idle)
> >   - HPO_TOP_CLOCK_CONTROL.HPO_HDMISTREAMCLK_GATE_DIS =3D 1
> >     (HPO HDMI stream clock is forced on)
> >   - PHYASYMCLK_CLOCK_CNTL.PHYASYMCLK_FORCE_EN =3D 1,
> >     PHYASYMCLK_FORCE_SRC_SEL =3D 1 (FRL signaling source selected)
> >
> > Worth noting: the public dcn_3_0_2 ASIC register headers in tree do
> > not expose any of the HPO HDMI / HDMI_FRL_ENC / HDMI_LINK_ENC
> > register offsets =E2=80=94 they only define HPO_HDMISTREAMCLK_GATE_DIS =
as a
> > single bit field inside HPO_TOP_CLOCK_CONTROL. Despite that, the
> > silicon clearly decodes the rest of the block (the relative offsets
> > from dcn_3_1_2 evidently land at usable addresses on dcn_3_0_2).
> > This is the first time, to my knowledge, that native HDMI 2.1 FRL
> > has been demonstrated working on a Navi 22-class card on Linux.
> >
> > Happy to retest a v2 if you fold the fix in.
> >
> > Reported-by: Dyllan Kobal <dk@zetier.com>
> > Tested-by: Dyllan Kobal <dk@zetier.com>  # Navi 22 + Bravia 8 II, 4K@12=
0 10bpc RGB
> >
> > Thanks,
> > -Dyllan
> >
>=20
> 
