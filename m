Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5C9CC6B1A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 20:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4477410E972;
	Tue, 13 Oct 2026 20:04:30 +0000 (UTC)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103EF10E972
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 20:04:24 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-15943c9be84so92402c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 13:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791921863; cv=none;
 d=google.com; s=arc-20260327;
 b=evBD2d3AUC9LYWkvyYpWQ1acSRb9bChy9aaTmfUxZwjZLCShERpknafNqLfUkIQ/nd
 2UCKWw7hflBPrItUlBPQ8VoRmICm9cKxb/YO1/YN0ypUGji4Z+P7Agk71N3Kuu77Tnmt
 6oJmBSQhApdXHZsIWT8PsuT+1iG2avBAGulMZUMVavz2AmTTu79Wgw5UK+9X3NjoqVaN
 Wyygl4eDmDISKQKdmQj03v2MLTnEOKNlEiwnDEAVjgtOI/rcjMowWwMLmrXqFSU9LatY
 YNmu22S5PGxkMOGegyoLfM9fpkXitlnzbcGu0qXXzJWpz9iQbCPBEZUIo2h3dNVaERb+
 47fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2Qq0SxZFgh94BCKvaqXPG8y49g0HBa5hpnrCqNIIN6c=;
 fh=sIfC9HZFq1ew3aE00QW1dp0FyMVRQ9ZcMGknUNSAHmA=;
 b=VGYNy/TGjJA7Gk99e5jnCGWyU7TOEYxEpjZcOai0ZLg6mLQIyR/SS8F0vXNKjyJRzv
 umL9UJy3YeMnNKnZYHJMzi5C/9UW7ZFbiPqZrMPl9zfO5gjOX4Q3uChYa0h1/VsK9NnE
 HS4a1ttoxnR/hgWI1rR+sF481mr+CN4eHIo8drYSXvUOKhp6+ieGOWaGCpUWv7xMxj7d
 CMMGgqk+rdWMrffLcR2jjULOoXszZi1pMgn4pg1glE6tVohSNWbO4U8zW8NH9/15EJsU
 Vrf4MH5Q8dLVh77K2kZLO+MSqihQS9gXHr8cxkt+2DiLc/Xn4gBOa7gvl30hPB8b848L
 g9iQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791921863; x=1792526663; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2Qq0SxZFgh94BCKvaqXPG8y49g0HBa5hpnrCqNIIN6c=;
 b=Ub1PXxSTlXoFi6HQ72IrZOY/n2aJ8olAAyxl62e7yXsi+iXRq7am22Wa5NuNMVeHrK
 1+F2EDlOMosShCKoZEIl0lg0iXpEdaqBg3r7W31oILJ4HeA3ztLbvFUoUbmqfx1fVo2I
 9kEQHq54j8YzMcBR3DRdyeHLdn1oodWY/5eXp4UD6x31apo9EOaK3yO9UBfkaOjfyw4n
 SYDRJ8qRAtAJBBLgnbG3KcXNg1Lv98mvmARIqbHOYhSa0kqg/gRn0ITRFdd7717n4LI1
 9AiHooRkGRBL5B/TNcOGcCBlcvoNiJvV00nl9rlpAk9eKlNsqZ0LfXKIczDv08neoiQy
 SlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791921863; x=1792526663;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2Qq0SxZFgh94BCKvaqXPG8y49g0HBa5hpnrCqNIIN6c=;
 b=enhRRUbtEjnSGGnjWFaXzKGfMjywfnqjsxttCGJhkFeEPEx0XczJdA8wZqp9OOkvfq
 O3QvoqIzp0WE8DfH2doAjdabawzz2nGzNmIi7D/zVvoZqAqzBQGZ/lDSLw/4WXGqbRLf
 ZPxvZN+fSj5xYLEo3e3R8iRQEmvfJMt8vH6wHkzXPw1W6eXXgZUohAi1CzcqIJWznL5G
 KNDSDmbu/0nz+IOYbdLRs0odKEkP5vzjY9VUSXj5q3yZwCvRw3CcHTCnA1WJeuqVKG2Y
 cXOJT3TsH2fY2iyCI3ZcsCDaSokwnX+GSa6oR7iy/2Y2E/isOGdNYet9AMLaJu9h1UoV
 UAJg==
X-Gm-Message-State: AFq9FYLyQdOniSaVB777FuK2VPxD9gxjxZzwvtqgSjGRySSIaX53lEw7
 587P+Jd0IdWIxzfHXdYP0HZtWAXAPLxvXL+3W1hmcAqNvevyEsXROVAMXLU2AottMSrN+z6oCVH
 2/IQzQi/saKlmUyl7nvdJaN1KeQOkWp4=
X-Gm-Gg: AYBFou3SGDfuC5wWXO43RmsnsVbQq9HbuO6dd3JIyJhdOry1maXtKBFBO+n4JfxhLAu
 IZd+pZVVYVk1qzXcJzDi95LmXegOb+AjI4Tej6j7q/gNJSZP8CSt2Z77gonLjeciotD+aKJblzx
 iUmO9DHeQDhrRvuPp5BnWqRNx8/Gjv0DEpSIjuhwEQavcnYBOcOeg5PpLo5e5f1IW1TmwUvPB+B
 7X7IX49rlRyLJMPa4QC7EtQpcqSEYTuDOnx7F863QFJxhMf2GNTecay7HA4MX30dkFHX3h+MhFG
 wEOn2SZ68mVsopFo+hDYzs/u0KJP/YMZBQFrcMqrUHw/3fzEfw/2QnWi+TZM0wIAb7mXrNcNetc
 D9ldLpn/eNnLkCaut0ZjOpVtxoTYAw/IZ72fk7NvZIgL/0JLM+poX
X-Received: by 2002:a05:701b:21ce:b0:149:c766:2965 with SMTP id
 a92af1059eb24-17a0d84a29amr5600452c88.2.1791921862974; Tue, 13 Oct 2026
 13:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <mrib0mcd_kcuRpdKaNohPWa0K9N3YEpD8sn4QoqDDTQRBp-plJRtEBHf-d4h9Ts92_fIM_TjGanz2nG0IX48DQgIyIA11RMQZCbSGNt-Jt0=@protonmail.com>
In-Reply-To: <mrib0mcd_kcuRpdKaNohPWa0K9N3YEpD8sn4QoqDDTQRBp-plJRtEBHf-d4h9Ts92_fIM_TjGanz2nG0IX48DQgIyIA11RMQZCbSGNt-Jt0=@protonmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Oct 2026 16:04:10 -0400
X-Gm-Features: AclHuK-8Pyjdmj1s9lUVib6CwxXh9esQcPBRvDW9TWHFmKx14eO5JdMJBvTJRqk
Message-ID: <CADnq5_O83f1N7gCTV-XGf16R=gBAXtxNTr1SDvQVOUM=qd40MA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPhoenix_=2F_DCN_3=2E1=2E4=5D_Regression_in_7=2E2=3A_3840x21?=
 =?UTF-8?Q?60=4060_driven_as_RGB_594_MHz_on_an_HDMI_sink_limited_to_300_M?=
 =?UTF-8?Q?Hz_TMDS_=284=3A2=3A0=2Donly_mode=29_=E2=86=92_black_screen?=
To: Tobias Johansson <tobias.johansson.se@protonmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

Please open a ticket here:
https://gitlab.freedesktop.org/drm/amd/-/work_items
and if possible, can you bisect?

Thanks!

On Mon, Oct 12, 2026 at 3:51=E2=80=AFAM Tobias Johansson
<tobias.johansson.se@protonmail.com> wrote:
>
> Since kernel 7.2 (verified on 7.2.4 and 7.2.8, Fedora builds), the displa=
y goes black (monitor reports no signal / enters standby) as soon as the co=
mpositor sets 3840x2160@60 on the HDMI output. 7.1.8 works with the same mo=
nitor, cable, firmware and userspace.
> The monitor's EDID declares a max TMDS clock of **300 MHz**, has **no HDM=
I Forum VSDB** (no HDMI 2.0 / SCDC / scrambling), and lists 3840x2160@60 (V=
IC 97) **only in the YCbCr 4:2:0 Video Data Block**. On 7.2.8 amdgpu nevert=
heless commits that mode as **RGB 8 bpc with a 594 MHz pixel clock** =E2=80=
=94 about twice what the sink supports =E2=80=94 and reports success. The m=
ode should either be driven as YCbCr 4:2:0 (297 MHz TMDS) or rejected.
>
> The system itself keeps running normally; only the display output is lost=
. 3840x2160@30 (297 MHz, RGB) works fine on 7.2.8.
>
> ## Hardware
>
> - System: Minisforum Venus series (board F7BSC), BIOS 1.09 (2023-11-20)
> - APU: AMD Ryzen 9 7940HS w/ Radeon 780M =E2=80=94 Phoenix1 `[1002:15bf]`=
 rev c1, subsystem `1f4c:b002`
> - Display IP: DCN 3.1.4, ATOM BIOS 113-PHXGENERIC-001
> - Output: native HDMI (`HDMI-A-2`, DC signal type 4 =3D HDMI Type A), no =
adapter
> - Monitor: Samsung (EDID manufacturer `SAM`, product `0x0fee`), 4K, singl=
e display
>
> ## Software
>
> | | Good | Bad |
> |---|---|---|
> | Kernel | 7.1.8-200.fc44 (Display Core v3.2.378) | 7.2.4-200.fc44, 7.2.8=
-200.fc44 (Display Core v3.2.384) |
> | DMUB firmware | 0x08005E00 | 0x08005E00 (7.2.4) and 0x08006200 (7.2.8) =
=E2=80=94 both bad |
>
> - Distribution: Fedora 44 Workstation, GNOME / mutter 50.5 (Wayland)
> - Mesa 26.2.3, linux-firmware / amd-gpu-firmware 20260916
> - The firmware is ruled out: 7.2.4 fails with the old DMUB firmware (0x08=
005E00), and 7.1.8 works with the current linux-firmware package installed.
> - Also ruled out: `amdgpu.sg_display=3D0` makes no difference.
> - Not bisected yet. The first bad version lies somewhere between 7.1.8 an=
d 7.2.4.
>
> ## Steps to reproduce
>
> 1. Connect the Samsung monitor described above via HDMI.
> 2. Boot 7.2.x. The plymouth LUKS prompt is visible, because the initial f=
bdev mode is 3840x2160@30 at 297 MHz.
> 3. GNOME starts and applies 3840x2160@60 from `monitors.xml` =E2=86=92 th=
e screen goes black and the monitor shows no signal.
>
> Changing the GNOME configuration to 3840x2160@30 makes 7.2.8 boot to a wo=
rking desktop.
>
> ## Expected / actual
>
> - **Expected:** 3840x2160@60 is output as YCbCr 4:2:0 (297 MHz TMDS) like=
 on 7.1.8, or is pruned as unsupported.
> - **Actual:** the mode is validated and committed as RGB 8 bpc at 594 MHz=
 on a sink whose EDID declares a max TMDS clock of 300 MHz =E2=86=92 no pic=
ture.
>
> ## Analysis (drm.debug=3D0x06 on 7.2.8)
>
> EDID parsing =E2=80=94 note the max TMDS clock:
>
> ```
> [drm:drm_parse_cea_ext] [CONNECTOR:402:HDMI-A-2] HDMI: DVI dual 0, max TM=
DS clock 300000 kHz
> [drm:dm_helpers_parse_edid_caps [amdgpu]] dm_helpers_parse_edid_caps: HDM=
I_FRL [HDMI-A-2] max_frl_rate 0
> ```
>
> Mode validation. Higher bpc values are pruned, but 8 bpc RGB at 594 MHz p=
asses, although it exceeds 300 MHz:
>
> ```
> [drm:create_validate_stream_for_sink [amdgpu]] Pruned mode 3840 x 2160 (c=
lk 594000) RGB 10-bpc -- Encoder validation failure
> [drm:create_validate_stream_for_sink [amdgpu]] Trying with 8 bpc
> ```
>
> Commit when the compositor starts (screen goes black right after this):
>
> ```
> [   41.109637] [drm:dc_stream_log [amdgpu]] core_stream ...: src: 0, 0, 3=
840, 2160; dst: 0, 0, 3840, 2160, colorSpace:1
> [   41.110034] [drm:dc_stream_log [amdgpu]]         pix_clk_khz: 594000, =
h_total: 4400, v_total: 2250, pixel_encoding:RGB, color_depth:8-bpc
> [   41.110513] [drm:dc_stream_log [amdgpu]]         signal: 4 dispname: S=
AMSUNG manufacturer_id: 0x2d4c product_id: 0xfee
> [   41.201208] [drm:dc_commit_state_no_check [amdgpu]] {3840x2160, 4400x2=
250@594000Khz}
> [   41.202066] [drm:dc_commit_streams [amdgpu]] dc_commit_streams Finishe=
d.
> ```
>
> For comparison, the early-boot fbdev mode, which displays correctly:
>
> ```
> [    4.946654] [drm:dc_stream_log [amdgpu]]         pix_clk_khz: 297000, =
h_total: 4400, v_total: 2250, pixel_encoding:RGB, color_depth:8-bpc
> ```
>
> No errors, warnings, GPU hangs or resets are logged in the failing case. =
The only other display-related message (`REG_WAIT timeout ... optc314_disab=
le_crtc line:146`) also appears on 7.1.8 and is unrelated.
>
> ### EDID (CTA-861 extension, decoded)
>
> - Video Data Block VICs: 95 (2160p30), 16, 31, 4, 19, 5, 20, 32, 33, 34, =
93, 94, 98, 100, 7, 22, 3, 18. VIC 97 (2160p60) is not listed here.
> - HDMI 1.4 VSDB (OUI 00-0C-03): max TMDS clock 300 MHz.
> - **No** HDMI Forum VSDB (OUI C4-5D-D8), so no SCDC and no scrambling.
> - YCbCr 4:2:0 Video Data Block: VICs 96, 97, 101, 102, which are 4:2:0-on=
ly.
>
> Raw EDID (256 bytes) is attached as `edid-samsung-hdmi.bin`.
>
> On 7.1.8 the same 3840x2160@60 mode works on this monitor. That is consis=
tent with it being output as YCbCr 4:2:0 at 297 MHz, which is the only way =
the sink can accept it, but I have not yet captured a drm.debug log on 7.1.=
8 to confirm the encoding there. I can provide one, and I can test patches =
or bisect if needed.
>
> ## Attachments
>
> - `dmesg-7.2.8-drm.debug-0x06-black-screen.txt`: failing boot, 4K@60 requ=
ested by GNOME
> - `dmesg-7.2.8-drm.debug-0x06-4k30-working.txt`: same kernel with GNOME s=
et to 4K@30, working
> - `dmesg-7.1.8-working.txt`: last good kernel, no drm.debug
> - `edid-samsung-hdmi.bin`: raw EDID of the monitor
>
> MAC addresses in the logs have been replaced with `xx:xx:xx:xx:xx:xx`.
