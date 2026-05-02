Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE943CD343C
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 12:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B22410E6A6;
	Mon,  4 May 2026 12:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=dyllankobal.com header.i=@dyllankobal.com header.b="uAOQG8hA";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D3910E269
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2026 14:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dyllankobal.com;
 s=protonmail2; t=1777730917; x=1777990117;
 bh=YazXJnLTAIYakDPX+ixQ+9woMpswAij5bhueE+qQUQ8=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=uAOQG8hAj0FQjOkYhP+UkwYxz/+n0+uTtdQbzFn9AEKycmR2LMPApFaJCd2Ffvjja
 kBdA9SAs0sCsK+8hdh9TxGqfExvWb7oANfPZbyhCkUuEF64yz7u/qtOLMnyE9qvQgh
 bJknQIUE5Uxlt+jodH2bLv7BIFo8yO3Wv4RiNXTRd0SIgeQzKnWtGWB5RWAjKJTvOd
 IRBIY9ynAI0oBTQmsH7JTglR4wiKWPOKAfvsTGBH9qXvCUZP/PJI4ROmvWNHu1Fafg
 N0alsPq3NoaVJqVA6UIs+/zCxvmCBbr3cRgLEP0yHY74qB3wrNML18ti+sV/aN87jq
 LwEOuWrUGatKg==
Date: Sat, 02 May 2026 14:08:31 +0000
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>
From: Dyllan Kobal <dyllan@dyllankobal.com>
Subject: Re: [PATCH 15/21] drm/amd/display: Tie FRL programming together in
 HWSS
Message-ID: <20260502140825.705534-1-dyllan@dyllankobal.com>
Feedback-ID: 33529580:user:proton
X-Pm-Message-ID: 251e24dab77d27eb816dae6c09af1a167ad513a1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 04 May 2026 12:42:21 +0000
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

From: Dyllan Kobal <dk@zetier.com>

Hi Harry, Rodrigo, Jerry,

Tested this series on Navi 22 (RX 6700 XT class, DCN 3.0.2) with a
Sony Bravia 8 II as the HDMI sink. Hit a NULL deref at amdgpu probe:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor instruction fetch in kernel mode
  Oops: Oops: 0010 [#1] SMP NOPTI
  CPU: 14 UID: 0 PID: 568 Comm: (udev-worker) Not tainted 6.19.0+
  RIP: 0010:0x0
  Call Trace:
   <TASK>
   hdmi_frl_perform_link_training_with_fallback+0x64/0x110 [amdgpu]
   hdmi_frl_verify_link_cap+0x24e/0x5d0 [amdgpu]
   link_detect+0x4b4/0x550 [amdgpu]
   amdgpu_dm_initialize_drm_device+0x73f/0xb21 [amdgpu]
   amdgpu_dm_init.cold+0x734/0x86c [amdgpu]
   dm_hw_init+0x1b/0x90 [amdgpu]
   amdgpu_device_ip_init+0x690/0x7fe [amdgpu]
   amdgpu_device_init.cold+0x460/0x781 [amdgpu]
   amdgpu_driver_load_kms+0x19/0x80 [amdgpu]
   amdgpu_pci_probe+0x19b/0x550 [amdgpu]

Cause: this patch wires .setup_hdmi_frl_link into the dcn314, dcn32,
dcn35, dcn351, dcn401 and dcn42 hwss tables, but not into dcn30's.
The dcn30 family (dcn30/302/303 =E2=80=94 Navi 21/22/23) does get FRL
resource creation per patches 16/17, so hdmi_frl_verify_link_cap()
runs on these ASICs and dispatches through the NULL
hwss.setup_hdmi_frl_link inside hdmi_frl_perform_link_training_with_fallbac=
k().
amdgpu probe is fatally aborted with no display.

Fix locally:

--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -105,6 +105,7 @@ static const struct hw_sequencer_funcs dcn30_funcs =3D =
{
        .enable_tmds_link_output =3D dce110_enable_tmds_link_output,
        .enable_dp_link_output =3D dce110_enable_dp_link_output,
        .disable_link_output =3D dce110_disable_link_output,
+       .setup_hdmi_frl_link =3D dcn30_setup_hdmi_frl_link,
        .set_disp_pattern_generator =3D dcn30_set_disp_pattern_generator,
        .get_dcc_en_bits =3D dcn10_get_dcc_en_bits,
        .update_visual_confirm_color =3D dcn10_update_visual_confirm_color,

With that one-line fix folded in, the Bravia comes up at 4K@120Hz
10bpc RGB native FRL on cold boot. Live register state confirms the
HPO HDMI block is what is driving the link, not legacy TMDS:

  - All legacy DIG[0-5] show DIG_BE_EN_CNTL.DIG_ENABLE =3D 0
  - All legacy SYMCLK[A-E] show CLOCK_ENABLE =3D 0
  - DIG0_HDMI_CONTROL.HDMI_DATA_SCRAMBLE_EN =3D 0
    (HDMI 2.0 TMDS scramble path is provably idle)
  - HPO_TOP_CLOCK_CONTROL.HPO_HDMISTREAMCLK_GATE_DIS =3D 1
    (HPO HDMI stream clock is forced on)
  - PHYASYMCLK_CLOCK_CNTL.PHYASYMCLK_FORCE_EN =3D 1,
    PHYASYMCLK_FORCE_SRC_SEL =3D 1 (FRL signaling source selected)

Worth noting: the public dcn_3_0_2 ASIC register headers in tree do
not expose any of the HPO HDMI / HDMI_FRL_ENC / HDMI_LINK_ENC
register offsets =E2=80=94 they only define HPO_HDMISTREAMCLK_GATE_DIS as a
single bit field inside HPO_TOP_CLOCK_CONTROL. Despite that, the
silicon clearly decodes the rest of the block (the relative offsets
from dcn_3_1_2 evidently land at usable addresses on dcn_3_0_2).
This is the first time, to my knowledge, that native HDMI 2.1 FRL
has been demonstrated working on a Navi 22-class card on Linux.

Happy to retest a v2 if you fold the fix in.

Reported-by: Dyllan Kobal <dk@zetier.com>
Tested-by: Dyllan Kobal <dk@zetier.com>  # Navi 22 + Bravia 8 II, 4K@120 10=
bpc RGB

Thanks,
-Dyllan

