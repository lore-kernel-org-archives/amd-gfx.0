Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07C1C5DF89
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 12:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E9610E5ED;
	Thu, 20 Aug 2026 12:34:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mowden.top header.i=@mowden.top header.b="UsnNVgnA";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="IpIlVSDA";
	dkim-atps=neutral
X-Greylist: delayed 642 seconds by postgrey-1.36 at gabe;
 Thu, 20 Aug 2026 07:11:56 UTC
Received: from a9-44.smtp-out.amazonses.com (a9-44.smtp-out.amazonses.com
 [54.240.9.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C6010EF23;
 Thu, 20 Aug 2026 07:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
 d=mowden.top; t=1787209273;
 h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
 bh=vd4as8Qp+DFSjNv4vFzVLy9ZxxRJ7tCi7zFCHv76SYY=;
 b=UsnNVgnAkWGYkQVI1JUcif1ggqFOo0GMhcf+6/2vnAsmLILbA/E1I54onB2IUfXv
 4btZoPGL/S4YLxLMMOKsdEopHftWtzWIsyj7DQ2oAI2rwqEYuhMIf0uLS8qi2yYPJYL
 tZlvZb9QooTAI4JTt8TzCjc1Sr2X7TwonAoNUi5A=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1787209273;
 h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
 bh=vd4as8Qp+DFSjNv4vFzVLy9ZxxRJ7tCi7zFCHv76SYY=;
 b=IpIlVSDAlMJNA2YdtpAEzy3klhyhBu4vJvw1l2Tp6HDFHHWK89Wr4Va/avhM9tuD
 W/vxai3sgGcH+i4aIFL/nE95fsYSyn6TvzN/sWOGs+d4Xx7UdblAOLYTfo+abb1mS80
 iQrky2fMo40dJvS0l/ojK2w8LS/vwFuM4n4na5dc=
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260601211931.2837-2-gilles.risch@gmail.com>
References: <20260601211931.2837-2-gilles.risch@gmail.com>
From: Erik Gregg <hank@mowden.top>
To: gilles.risch@gmail.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5] drm/radeon: fix internal display on iMac11,1
 (RV770/DCE3.1)
Message-ID: <010001a01df94f48-3026542f-b8eb-4661-868e-1d35cfd0254b-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 07:01:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.CweXOU30Fo0uRv+EtGtmpsC958JZSZMuajt1v2sflD7Sxc2/xTkCtWhP0cI/cAB9q9eB91Lpt/p3wN9ykkSLI1hl3fIre1HkCSz5RpmBEncLekfR7uRL3JK08u4JIdlvXYe0BgHofoV56sytvmMvLauPmb7/x4hk1IB1Upx/VMk=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.08.20-54.240.9.44
X-Mailman-Approved-At: Thu, 20 Aug 2026 12:33:59 +0000
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

On Mon, 1 Jun 2026 23:19:32 +0200, Gilles Risch <gilles.risch@gmail.com> =
wrote:
> The Apple iMac11,1 (27-inch, Late 2009) uses a Mobility Radeon HD =
4850
> (RV770/DCE3.1) with a 2560x1440 internal panel on an internal
> DisplayPort path. Without this fix the display stays dark under KMS.
>
> This machine suffers from the same issue as iMac10,1 and iMac11,2:
> Apple routes the internal display through Link B of the DIG encoder
> instead of Link A. Add iMac11,1 to the existing DMI quirk and move
> the Apple-specific encoder assignment into its own block, independent
> of the DCE version check.
>
> Additionally, the 2560x1440 panel requires =
RADEON_PLL_USE_FRAC_FB_DIV
> and ATOM_ENCODER_CMD_DP_VIDEO_ON, limited to =
iMac11,1 via dmi_match()
> to avoid affecting other boards.
>
> Signed-off-by: Gilles Risch <gilles.risch@gmail.com>

I tested this patch on top of 7.1.7-arch1 on a Late 2009 27" iMac11,1
with the Mobility Radeon HD 4850. With nomodeset the machine boots with
a working (efifb) console. On vanilla 7.1.7 without nomodeset the panel
stays completely black (backlight off) and no radeon init is visible in
dmesg over SSH.

With the patch and without nomodeset, radeon initializes =
normally per
dmesg, but at the fbcon modeset (~4s) the panel goes blank and=
 then
shows flashing horizontal lines that start at the top and sweep down =
at
regular intervals. It never recovers. The logs below are from that case,
gathered by logging in blind on the console and running commands blind.

I tried radeon.dpm=3D0, radeon.audio=3D0, video=3DeDP-1:2560x1440@60 and
radeon.modeset=3D1, with no change.

Renderer: AMD RV770 (DRM 2.51.0 / 7.1.=
7-arch1-1-imac), Mesa 26.1.6

[    3.028962] radeon 0000:02:00.0: fence =
driver on ring 3 uses gpu addr 0x0000000020000c0c
[    3.029207] radeon =
0000:02:00.0: fence driver on ring 5 uses gpu addr 0x0000000000056230
[    3.030250] radeon 0000:02:00.0: radeon: using MSI.
[    3.030275] [drm] radeon: irq initialized.
[    3.076796] [drm] ring =
test on 0 succeeded in 1 usecs
[    3.076803] [drm] ring test on 3 =
succeeded in 2 usecs
[    3.252855] radeon 0000:02:00.0: [drm] ring test on=
 5 succeeded in 1 usecs
[    3.252861] radeon 0000:02:00.0: [drm] UVD =
initialized successfully.
[    3.253264] [drm] ib test on ring 0 succeeded =
in 0 usecs
[    3.253283] [drm] ib test on ring 3 succeeded in 0 usecs
[    3.906199] radeon 0000:02:00.0: [drm] ib test on ring 5 succeeded
[    3.906669] [drm] radeon atom DIG backlight initialized
[    3.906672] radeon 0000:02:00.0: [drm] Radeon Display Connectors
[    3.906674] radeon 0000:02:00.0: [drm] Connector 0:
[    3.906676] radeon 0000:02:00.0: [drm]   DP-1
[    3.906677] radeon =
0000:02:00.0: [drm]   HPD2
[    3.906679] radeon 0000:02:00.0: [drm]   DDC:=
 0x7e60 0x7e60 0x7e64 0x7e64 0x7e68 0x7e68 0x7e6c 0x7e6c
[    3.906682] radeon 0000:02:00.0: [drm]   Encoders:
[    3.906683] radeon 0000:02:00.0: [drm]     DFP1: INTERNAL_UNIPHY
[    3.906685] radeon 0000:02:00.0: [drm] Connector 1:
[    3.906687] radeon 0000:02:00.0: [drm]   eDP-1
[    3.906688] radeon =
0000:02:00.0: [drm]   HPD3
[    3.906689] radeon 0000:02:00.0: [drm]   DDC:=
 0x7e20 0x7e20 0x7e24 0x7e24 0x7e28 0x7e28 0x7e2c 0x7e2c
[    3.906692] radeon 0000:02:00.0: [drm]   Encoders:
[    3.906693] radeon 0000:02:00.0: [drm]     LCD1: INTERNAL_UNIPHY
[    3.906695] radeon 0000:02:00.0: [drm] Connector 2:
[    3.906697] radeon 0000:02:00.0: [drm]   VGA-1
[    3.906698] radeon =
0000:02:00.0: [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c=
 0x7e4c
[    3.906701] radeon 0000:02:00.0: [drm]   Encoders:
[    3.906702] radeon 0000:02:00.0: [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    3.915213] [drm] Initialized radeon 2.51.0 for 0000:02:00.0 on minor 0
[    3.988184] [drm] fb mappable at 0xC0347000
[    3.988187] [drm] vram =
apper at 0xC0000000
[    3.988188] [drm] size 14745600
[    3.988189] [drm] fb depth is 24
[    3.988190] [drm]    pitch is 10240
[    3.988263] fbcon: radeondrmfb (fb0) is primary device
[    4.026022] radeon 0000:02:00.0: [drm] fb0: radeondrmfb frame buffer =
device
[    5.366673] systemd[1]: Load Kernel Module drm skipped, unmet =
condition check ConditionKernelModuleLoaded=3D!drm
[    8.464118] =
snd_hda_intel 0000:02:00.1: bound 0000:02:00.0 (ops =
radeon_audio_component_bind_ops [radeon])

Happy to test further patches or=
 gather more logs.

Regards,
Erik
