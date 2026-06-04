Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73A9CD6E6B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 07:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5EE211A4F4;
	Fri,  5 Jun 2026 07:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hpdpGP5p";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ABCA113F2F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 10:39:40 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-36d9794d82aso359564a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2026 03:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780569580; cv=none;
 d=google.com; s=arc-20240605;
 b=O1EBD8pM7xBXI/ybsTfcBlDEPT41Yojz2Vj1j2e5pUlTYTAKFaZd07lqQjESxCwY1z
 lwjzPg/xp1iIrfzFsX4hxX97QwICNQA/naWD9DoOR521KTgZa3TMmZU95rlFASn8HeDz
 783iHZIRTM1DpuOxU+8YIa0K1uOI1mLjmWq0RkckdM5V+Yy/Eq9Hp95jB/yodGNERmVD
 5wgGJXt6zb89rjxlmU3zaNnn+M9qz3+oLq3KiuAVSoTFp+gzK+/5wXaiMVA6FwlOy9D6
 /iQcuxGEz6kkvTFP7WHmDI2fhq0P4bTb9EB1CXvt5/1PbKODib5swvbNG59uitsRAu7g
 3jfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=DHJ8J4uiPc48jd2U1lIia7T+CC7QkgV2JPYBKgHOtEs=;
 fh=0er8lFfTQh1yBYKTd583hbehbrR5G/1hBUloTYRqB28=;
 b=ZWVmLFiZjAB4i6Vzch4ZRaanK9LVhTdOwGYIXKb5joUy6U7DwFMuX5O0Q9vpaHqN8x
 4miXkK3n+Xqydqfa3etfwFHUirw4jojrWf2zd5Mw+3dkFM8rOQnDOguBB3wDxwqbsU4G
 T49R1ry85Y647zxaZ0s/iy3mR/8LiPe/ikwILi09J7bSTjjTvBlx/zsEX12mce5ulJqZ
 P9r0p6GwhqUyHrkjHZ/LJrrF1KHWBhSAU9wBTQsGRvey+J+HnS7GlstdS6dZdZVYm81/
 tsWWjKl9WZAOCK3C9acRF8YZwrKV44iZfIMIouREWXf9w2DkgoR/Ual6MdN6Sx2mIwbL
 qOxg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780569580; x=1781174380; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DHJ8J4uiPc48jd2U1lIia7T+CC7QkgV2JPYBKgHOtEs=;
 b=hpdpGP5pVDzxH49iua17vDBDp/6yleRp590+PnFZdjs4MBXdPZ78ugMzAKjQmGqbZq
 q8mbb+98S2Yb3PFITzNJXk1QX2n9B6+Mnc2YLc+bt2/FNfSHDSCnbMUkNSAUSGtl6JBq
 KVbMjQo0FQTkizigtZufEOFOY5X4j4mA0pjqXKQY7ivr6mTHU7GXN7kHmnJmafQo1lY4
 tx7pVCeTe0WeLxT1itTNTysj9kHVh4/qrBGS/ZHTeR4WfX29TyduYK+tQZWMIHMf9Zk0
 JkXuuxQB/nlFKwn1kd0Nzjr3y5bqfxYXImSAVvsTNT5oN25vb9xi7Q8zHCUM1eKgZ+Cg
 IenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780569580; x=1781174380;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DHJ8J4uiPc48jd2U1lIia7T+CC7QkgV2JPYBKgHOtEs=;
 b=gWFT7PwiK1gHcO7t7JJReS/4GL6GBtEHypjWzQxSj5WbOE+qJqtvy4LGTFqBFn999f
 PRMlfNeehciPkOJ12Sg/4ZtGGzmCqfQndxYWCRSJ6BN1pDx8uk9knAUULJWaIkc8nKot
 mbDyMO6hab10g9ofOoqU1Ss903Tl0cg3va4YEFWVfKA7EdpoJivuHafbi4h30Uw1rwxG
 yFrKSj3AkxZLUFrsZFI+mrD0baiUfbH9ZmuYvfgGPitYsref5p4NEkRB4SkkTDfbt6l7
 FLdy7wu81YpiOiMLI0WmPFQS57PB31T+Y69NmB4q8JfzRcmMwdpvN3P/et37RC5Si18e
 6IRQ==
X-Gm-Message-State: AOJu0YzNywLIdNN/mMWbBG7/Jp7RtAsPJvRb925P3TOEJ5b0oQ4lJDLj
 iUj/CWDjt9b3SczpDtO1AHvL+GT54ca/nIl35ptaSIcmetn7bcv1wf19aiNX6C/16KQPspM2xsw
 i0ej2PwXdKXBGVA3r1VcalhHwMK2Kw+vtAWqb
X-Gm-Gg: Acq92OHhS07Q6UpSpG3saNdDlcwTeVXgdqldbxhaJgN2rfaaNfZRiuT0xf6wTylQ4hn
 S1cWR2/cuDM6Z9IKGj9Rv1kC4zf74SYPKiOni0dTd02guAPXhy9TaB+t6LVGpPvrpAzT2DLCp8x
 p6kgibi6dBPfiuZ9BRIMLzRiCkI4OckWf+etRBE6UHI+JOeizDASKokBSqIupp6Vc7Go09nauQL
 KhuiNxCAfa1ntC3XH+PSW5LUArK0X+Stwx2TFwXDfB8xZ9kp2mGO1wGND4wAw97ELW5U+41PFdj
 BIiuPgP80nOMi22wag==
X-Received: by 2002:a17:90b:2d8d:b0:36d:7d99:5316 with SMTP id
 98e67ed59e1d1-36e3228651fmr7078952a91.17.1780569579628; Thu, 04 Jun 2026
 03:39:39 -0700 (PDT)
MIME-Version: 1.0
From: Gregory Twohig <gtwohig@gmail.com>
Date: Thu, 4 Jun 2026 06:39:27 -0400
X-Gm-Features: AVHnY4JIWBtHIAmHu2r3n-W29LK30tnWV3K61ndXoM7gJVsQiLgcAzX0pxKSGB8
Message-ID: <CAPZb7wZQmhWH=SxPOYRdaqs4GbTSoU0sa8B95de4=RLeJZZ9gA@mail.gmail.com>
Subject: =?UTF-8?Q?amdgpu=2FDC=3A_DMCUB_hard_hang_when_link=2Dtraining_an_asl?=
 =?UTF-8?Q?eep_DP_sink_on_DCN3=2E1_=28Radeon_780M=29_=E2=80=94_root_cause_=2B_candida?=
 =?UTF-8?Q?te_fix?=
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, harry.wentland@amd.com
Content-Type: multipart/alternative; boundary="0000000000004aadac06536b2924"
X-Mailman-Approved-At: Fri, 05 Jun 2026 07:35:12 +0000
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

--0000000000004aadac06536b2924
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I've hit a reliably reproducible hard display hang on a Radeon 780M (RDNA3,
DCN3.1, Phoenix/Hawk Point) and tracked down what looks like the root cause=
,
with a small candidate fix below. Sending it here in case it's useful =E2=
=80=94 I'm
happy to test patches on the hardware or submit a proper Signed-off-by patc=
h
via git if you'd prefer.

=3D=3D Summary =3D=3D

Re-plugging an external DisplayPort monitor that is powered but in standby
(HPD
still asserted, but unresponsive on AUX) hard-hangs the display. The DMUB
wedges
and floods the log with "dc_dmub_srv_log_diagnostic_data: DMCUB error"
forever;
the compositor and all outputs freeze (frozen mouse) while the rest of the
system keeps running. Only a power-cycle recovers it. If the same monitor i=
s
*awake* at re-plug, link training succeeds and there is no hang =E2=80=94 s=
o the
trigger
is specifically link training against a present-but-unresponsive (AUX-dead)
sink.

=3D=3D Environment =3D=3D

- GPU: Radeon 780M, RDNA3 iGPU =E2=80=94 HawkPoint1 [1002:1900] (rev d2), D=
CN3.1
- Kernel 7.0.10; reproduces on earlier kernels too (not a recent regression=
)
- linux-firmware current; DMUB fw version=3D0x08005B00
- cmdline: amdgpu.dc=3D1 amdgpu.dpm=3D1 amdgpu.dcdebugmask=3D0x10 (PSR disa=
bled;
no effect)
- Attach: native USB-C DP-alt-mode (also reproduces via a USB4/Thunderbolt
DP tunnel)
- Monitor enters DP standby within ~5s of signal loss and does not wake
over the link

=3D=3D Steps to reproduce =3D=3D

1. External DP monitor connected and working.
2. Unplug it live (do NOT power it off). It enters standby within a few
seconds.
3. Re-plug while it is in standby.
-> HPD link training fails, the DMUB wedges, the whole display hard-hangs.
Not reproducible if the monitor is awake at step 3.

=3D=3D dmesg =3D=3D

WARNING: .../display/dc/link/protocols/link_dp_training.c:1597
at dp_perform_link_training+0x111/0x530 [amdgpu]
Workqueue: events_highpri dm_irq_work_func [amdgpu]
dp_verify_link_cap_with_retries+0x231/0x510 [amdgpu]
link_detect+0x478/0x590 [amdgpu]
handle_hpd_irq_helper+0x277/0x300 [amdgpu]
[drm] *ERROR* dpcd_set_link_settings: core_link_write_dpcd (DP_LINK_BW_SET)
failed
[drm] *ERROR* dpcd_set_link_settings: core_link_write_dpcd
(DP_LANE_COUNT_SET) failed
[drm] *ERROR* dpcd_set_link_settings: core_link_write_dpcd
(DP_DOWNSPREAD_CTRL) failed
[drm] REG_WAIT timeout 1us * 100 tries - dcn31_program_compbuf_size line:14=
1
WARNING: .../display/dc/hubbub/dcn31/dcn31_hubbub.c:151
dcn31_program_compbuf_size
[drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting
diagnostic data
(repeats ~4/s until power-off; was the literal last line logged before a
forced reboot in two captured incidents)

=3D=3D Root cause =3D=3D

On HPD, link_detect() -> dp_verify_link_cap_with_retries() repeatedly calls
dp_perform_link_training() across link settings. A standby sink still
asserts
HPD, so it is never treated as LINK_TRAINING_ABORT (unplugged) and the loop
keeps retrying into it.

Each attempt runs dp_perform_8b_10b_link_training(), which calls
dpcd_set_link_settings() to write DP_DOWNSPREAD_CTRL / DP_LANE_COUNT_SET /
DP_LINK_BW_SET. Against the standby sink every core_link_write_dpcd()
returns
!=3D DC_OK. But:

- dpcd_set_link_settings() logs each failure and continues, returning only
the
last status;
- dp_perform_8b_10b_link_training() discards that return value and proceeds
to
the clock-recovery / channel-EQ sequences, programming hardware
(dcn31_program_compbuf_size REG_WAIT timeouts) into a link the sink has
already failed to acknowledge =E2=80=94 which wedges the DMUB.

There is no DPCD sink-presence check before hardware programming.

=3D=3D Candidate fix =3D=3D

Fail link training gracefully when the sink does not ACK the basic
link-setting
AUX writes: return early from dpcd_set_link_settings() on the first failed
write,
and abort dp_perform_8b_10b_link_training() with LINK_TRAINING_ABORT before
programming hardware when those writes failed. This only affects a fully
AUX-unresponsive sink; a healthy (or marginal-but-answering) sink returns
DC_OK
and trains as before, preserving the existing retry/fallback behaviour.

(Diff below is illustrative =E2=80=94 a mail client may reflow its whitespa=
ce; I
can send
a clean git-am-able patch on request.)

--- a/.../dc/link/protocols/link_dp_training.c
+++ b/.../dc/link/protocols/link_dp_training.c
status =3D core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
&downspread.raw, sizeof(downspread));
- if (status !=3D DC_OK)
+ if (status !=3D DC_OK) {
DC_LOG_ERROR("...core_link_write_dpcd (DP_DOWNSPREAD_CTRL) failed\n", ...);
+ /* First AUX transaction of link training. If it fails the sink is
+ * unresponsive (e.g. powered but asleep); bail before issuing the
+ * remaining writes / letting the caller program hardware into a
+ * dead link (DMUB wedge on DCN3.1). */
+ return status;
+ }

--- a/.../dc/link/protocols/link_dp_training_8b_10b.c
+++ b/.../dc/link/protocols/link_dp_training_8b_10b.c
/* 1. set link rate, lane count and spread. */
if (lt_settings->lttpr_early_tps2)
set_link_settings_and_perform_early_tps2_retimer_pre_lt_sequence(...);
- else
- dpcd_set_link_settings(link, lt_settings);
+ else if (dpcd_set_link_settings(link, lt_settings) !=3D DC_OK)
+ /* Sink did not ACK the basic link-setting AUX writes (powered but
+ * asleep, still asserting HPD). Abort before programming the training
+ * sequence; on DCN3.1 proceeding wedges the DMUB and hard-hangs the
+ * display. */
+ return LINK_TRAINING_ABORT;

=3D=3D Open question =3D=3D

On DCN3.1 AUX is DMUB-mediated. Is the wedge caused by the hardware
programming
into the dead link (what this patch prevents) or by the failed AUX-over-DMU=
B
transactions themselves? The trace suggests the former =E2=80=94 the AUX wr=
ites
return
failure cleanly and the wedge correlates with the subsequent
dcn31_program_compbuf_size programming.

I can build/test on the affected hardware and collect DMUB diagnostics
before/after. Thanks for taking a look.

Greg

--0000000000004aadac06536b2924
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helve=
tica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:=
normal;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial;display:inline;float:none">Hi,</span><br style=3D=
"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;word-spacing:0px;white-space:normal;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial"><br =
style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-si=
ze:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0=
px;text-transform:none;word-spacing:0px;white-space:normal;background-color=
:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initi=
al"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-ser=
if;font-size:small;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial;display:inline;float:none">I&#39;ve hit a reliably reproducibl=
e hard display hang on a Radeon 780M (RDNA3,</span><br style=3D"color:rgb(3=
4,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial"><span style=3D"c=
olor:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;f=
ont-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fon=
t-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,2=
55,255);text-decoration-style:initial;text-decoration-color:initial;display=
:inline;float:none">DCN3.1, Phoenix/Hawk Point) and tracked down what looks=
 like the root cause,</span><br style=3D"color:rgb(34,34,34);font-family:Ar=
ial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;whi=
te-space:normal;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font=
-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-v=
ariant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;word-spaci=
ng:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration=
-style:initial;text-decoration-color:initial;display:inline;float:none">wit=
h a small candidate fix below. Sending it here in case it&#39;s useful =E2=
=80=94 I&#39;m</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Hel=
vetica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:=
normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-spac=
e:normal;background-color:rgb(255,255,255);text-decoration-style:initial;te=
xt-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-family=
:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;=
white-space:normal;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial;display:inline;float:none">happy to t=
est patches on the hardware or submit a proper Signed-off-by patch</span><b=
r style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-=
size:small;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;word-spacing:0px;white-space:normal;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-s=
erif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-v=
ariant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;back=
ground-color:rgb(255,255,255);text-decoration-style:initial;text-decoration=
-color:initial;display:inline;float:none">via git if you&#39;d prefer.</spa=
n><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;f=
ont-size:small;font-style:normal;font-variant-ligatures:normal;font-variant=
-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-in=
dent:0px;text-transform:none;word-spacing:0px;white-space:normal;background=
-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color=
:initial"><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans=
-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helv=
etica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space=
:normal;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial;display:inline;float:none">=3D=3D Summary =3D=3D=
</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial"><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica=
,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:norm=
al;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial=
,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligatu=
res:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-=
space:normal;background-color:rgb(255,255,255);text-decoration-style:initia=
l;text-decoration-color:initial;display:inline;float:none">Re-plugging an e=
xternal DisplayPort monitor that is powered but in standby (HPD</span><br s=
tyle=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-siz=
e:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:n=
ormal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;word-spacing:0px;white-space:normal;background-color:=
rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initia=
l"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-seri=
f;font-size:small;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial;display:inline;float:none">still asserted, but unresponsive on =
AUX) hard-hangs the display. The DMUB wedges</span><br style=3D"color:rgb(3=
4,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial"><span style=3D"c=
olor:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;f=
ont-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fon=
t-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,2=
55,255);text-decoration-style:initial;text-decoration-color:initial;display=
:inline;float:none">and floods the log with &quot;dc_dmub_srv_log_diagnosti=
c_</span><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,san=
s-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;fon=
t-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:star=
t;text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;b=
ackground-color:rgb(255,255,255);text-decoration-style:initial;text-decorat=
ion-color:initial;display:inline;float:none">data: DMCUB error&quot; foreve=
r;</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-=
serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;bac=
kground-color:rgb(255,255,255);text-decoration-style:initial;text-decoratio=
n-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helve=
tica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:=
normal;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial;display:inline;float:none">the compositor and all=
 outputs freeze (frozen mouse) while the rest of the</span><br style=3D"col=
or:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial"><span st=
yle=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;word-spacing:0px;white-space:normal;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
;display:inline;float:none">system keeps running. Only a power-cycle recove=
rs it. If the same monitor is</span><br style=3D"color:rgb(34,34,34);font-f=
amily:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing=
:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,=
34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:norma=
l;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wo=
rd-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-de=
coration-style:initial;text-decoration-color:initial;display:inline;float:n=
one">*awake* at re-plug, link training succeeds and there is no hang =E2=80=
=94 so the trigger</span><br style=3D"color:rgb(34,34,34);font-family:Arial=
,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligatu=
res:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-=
space:normal;background-color:rgb(255,255,255);text-decoration-style:initia=
l;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-fa=
mily:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:=
0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial;display:inline;float:none">is spe=
cifically link training against a present-but-unresponsive (AUX-dead)</span=
><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;fo=
nt-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;word-spacing:0px;white-space:normal;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,san=
s-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;fon=
t-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:star=
t;text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;b=
ackground-color:rgb(255,255,255);text-decoration-style:initial;text-decorat=
ion-color:initial;display:inline;float:none">sink.</span><br style=3D"color=
:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-=
style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-we=
ight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transf=
orm:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,2=
55);text-decoration-style:initial;text-decoration-color:initial"><br style=
=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;word-spacing:0px;white-space:normal;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial"><=
span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;fo=
nt-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;word-spacing:0px;white-space:normal;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;display:inline;float:none">=3D=3D Environment =3D=3D</span><br styl=
e=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;word-spacing:0px;white-space:normal;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial">=
<br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;fon=
t-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;word-spacing:0px;white-space:normal;background-c=
olor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:i=
nitial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans=
-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial;display:inline;float:none">- GPU: Radeon 780M, RDNA3 iGPU =
=E2=80=94 HawkPoint1 [1002:1900] (rev d2), DCN3.1</span><br style=3D"color:=
rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial"><span style=
=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;word-spacing:0px;white-space:normal;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial;di=
splay:inline;float:none">- Kernel 7.0.10; reproduces on earlier kernels too=
 (not a recent regression)</span><br style=3D"color:rgb(34,34,34);font-fami=
ly:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-varian=
t-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:=
normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0p=
x;white-space:normal;background-color:rgb(255,255,255);text-decoration-styl=
e:initial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34)=
;font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-=
spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial;display:inline;float:none=
">- linux-firmware current; DMUB fw version=3D0x08005B00</span><br style=3D=
"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;word-spacing:0px;white-space:normal;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial"><spa=
n style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-=
size:small;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;word-spacing:0px;white-space:normal;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial;display:inline;float:none">- cmdline: amdgpu.dc=3D1 amdgpu.dpm=3D1 amd=
gpu.dcdebugmask=3D0x10 (PSR disabled; no effect)</span><br style=3D"color:r=
gb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-st=
yle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weig=
ht:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfor=
m:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255=
);text-decoration-style:initial;text-decoration-color:initial"><span style=
=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;word-spacing:0px;white-space:normal;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial;di=
splay:inline;float:none">- Attach: native USB-C DP-alt-mode (also reproduce=
s via a USB4/Thunderbolt DP tunnel)</span><br style=3D"color:rgb(34,34,34);=
font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-s=
pacing:0px;white-space:normal;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial"><span style=3D"color:rgb(=
34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial;display:inline;f=
loat:none">- Monitor enters DP standby within ~5s of signal loss and does n=
ot wake over the link</span><br style=3D"color:rgb(34,34,34);font-family:Ar=
ial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;whi=
te-space:normal;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial"><br style=3D"color:rgb(34,34,34);font-f=
amily:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing=
:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,=
34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:norma=
l;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wo=
rd-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-de=
coration-style:initial;text-decoration-color:initial;display:inline;float:n=
one">=3D=3D Steps to reproduce =3D=3D</span><br style=3D"color:rgb(34,34,34=
);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;=
font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lett=
er-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word=
-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-deco=
ration-style:initial;text-decoration-color:initial"><br style=3D"color:rgb(=
34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial"><span style=3D"=
color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial;displa=
y:inline;float:none">1. External DP monitor connected and working.</span><b=
r style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-=
size:small;font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;word-spacing:0px;white-space:normal;background-col=
or:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:ini=
tial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-s=
erif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-v=
ariant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;back=
ground-color:rgb(255,255,255);text-decoration-style:initial;text-decoration=
-color:initial;display:inline;float:none">2. Unplug it live (do NOT power i=
t off). It enters standby within a few seconds.</span><br style=3D"color:rg=
b(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-sty=
le:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weigh=
t:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform=
:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255)=
;text-decoration-style:initial;text-decoration-color:initial"><span style=
=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;word-spacing:0px;white-space:normal;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial;di=
splay:inline;float:none">3. Re-plug while it is in standby.</span><br style=
=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;word-spacing:0px;white-space:normal;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial"><=
span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;fo=
nt-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;word-spacing:0px;white-space:normal;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;display:inline;float:none">-&gt; HPD link training fails, the DMUB =
wedges, the whole display hard-hangs.</span><br style=3D"color:rgb(34,34,34=
);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;=
font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lett=
er-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word=
-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-deco=
ration-style:initial;text-decoration-color:initial"><span style=3D"color:rg=
b(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-sty=
le:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weigh=
t:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform=
:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255)=
;text-decoration-style:initial;text-decoration-color:initial;display:inline=
;float:none">Not reproducible if the monitor is awake at step 3.</span><br =
style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-si=
ze:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0=
px;text-transform:none;word-spacing:0px;white-space:normal;background-color=
:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initi=
al"><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif=
;font-size:small;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;word-spacing:0px;white-space:norma=
l;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial;display:inline;float:none">=3D=3D dmesg =3D=3D</span><=
br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font=
-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-ca=
ps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;word-spacing:0px;white-space:normal;background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial"><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helveti=
ca,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norm=
al;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-alig=
n:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:no=
rmal;background-color:rgb(255,255,255);text-decoration-style:initial;text-d=
ecoration-color:initial;display:inline;float:none">WARNING: .../display/dc/=
link/protocols/</span><span style=3D"color:rgb(34,34,34);font-family:Arial,=
Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligatur=
es:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-s=
pace:normal;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial;display:inline;float:none">link_dp_training.=
c:1597</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,H=
elvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-sp=
ace:normal;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial;display:inline;float:none">at dp_perform_link=
_training+</span><span style=3D"color:rgb(34,34,34);font-family:Arial,Helve=
tica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:=
normal;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial;display:inline;float:none">0x111/0x530 [amdgpu]</=
span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-seri=
f;font-size:small;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica=
,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:norm=
al;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial;display:inline;float:none">Workqueue: events_highpri =
dm_irq_work_func [amdgpu]</span><br style=3D"color:rgb(34,34,34);font-famil=
y:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px=
;white-space:normal;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);=
font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-s=
pacing:0px;white-space:normal;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial;display:inline;float:none"=
>dp_verify_link_cap_with_</span><span style=3D"color:rgb(34,34,34);font-fam=
ily:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0=
px;white-space:normal;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial;display:inline;float:none">retries=
+0x231/0x510 [amdgpu]</span><br style=3D"color:rgb(34,34,34);font-family:Ar=
ial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;whi=
te-space:normal;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font=
-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-v=
ariant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;word-spaci=
ng:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration=
-style:initial;text-decoration-color:initial;display:inline;float:none">lin=
k_detect+0x478/0x590 [amdgpu]</span><br style=3D"color:rgb(34,34,34);font-f=
amily:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing=
:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,=
34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:norma=
l;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wo=
rd-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-de=
coration-style:initial;text-decoration-color:initial;display:inline;float:n=
one">handle_hpd_irq_helper+0x277/</span><span style=3D"color:rgb(34,34,34);=
font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-s=
pacing:0px;white-space:normal;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial;display:inline;float:none"=
>0x300 [amdgpu]</span><br style=3D"color:rgb(34,34,34);font-family:Arial,He=
lvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-spa=
ce:normal;background-color:rgb(255,255,255);text-decoration-style:initial;t=
ext-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-famil=
y:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px=
;white-space:normal;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial;display:inline;float:none">[drm] *ER=
ROR* dpcd_set_link_settings: core_link_write_dpcd (DP_LINK_BW_SET) failed</=
span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-seri=
f;font-size:small;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica=
,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:norm=
al;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial;display:inline;float:none">[drm] *ERROR* dpcd_set_lin=
k_settings: core_link_write_dpcd (DP_LANE_COUNT_SET) failed</span><br style=
=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;word-spacing:0px;white-space:normal;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial"><=
span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;fo=
nt-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;word-spacing:0px;white-space:normal;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;display:inline;float:none">[drm] *ERROR* dpcd_set_link_settings: co=
re_link_write_dpcd (DP_DOWNSPREAD_CTRL) failed</span><br style=3D"color:rgb=
(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-styl=
e:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight=
:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial"><span style=3D=
"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;word-spacing:0px;white-space:normal;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial;displ=
ay:inline;float:none">[drm] REG_WAIT timeout 1us * 100 tries - dcn31_progra=
m_compbuf_size line:141</span><br style=3D"color:rgb(34,34,34);font-family:=
Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:normal;background-color:rgb(255,255,255);text-decoration-style:i=
nitial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);fo=
nt-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;word-spa=
cing:0px;white-space:normal;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial;display:inline;float:none">W=
ARNING: .../display/dc/hubbub/dcn31/</span><span style=3D"color:rgb(34,34,3=
4);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal=
;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wor=
d-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-dec=
oration-style:initial;text-decoration-color:initial;display:inline;float:no=
ne">dcn31_hubbub.c:151 dcn31_program_compbuf_size</span><br style=3D"color:=
rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial"><span style=
=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;word-spacing:0px;white-space:normal;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial;di=
splay:inline;float:none">[drm] *ERROR* dc_dmub_srv_log_diagnostic_</span><s=
pan style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;fon=
t-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;word-spacing:0px;white-space:normal;background-c=
olor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:i=
nitial;display:inline;float:none">data: DMCUB error - collecting diagnostic=
 data</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sa=
ns-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;fo=
nt-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;=
background-color:rgb(255,255,255);text-decoration-style:initial;text-decora=
tion-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,He=
lvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-spa=
ce:normal;background-color:rgb(255,255,255);text-decoration-style:initial;t=
ext-decoration-color:initial;display:inline;float:none">(repeats ~4/s until=
 power-off; was the literal last line logged before a</span><br style=3D"co=
lor:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial"><span s=
tyle=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-siz=
e:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:n=
ormal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;word-spacing:0px;white-space:normal;background-color:=
rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initia=
l;display:inline;float:none">forced reboot in two captured incidents)</span=
><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;fo=
nt-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;word-spacing:0px;white-space:normal;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial"><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-=
serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;bac=
kground-color:rgb(255,255,255);text-decoration-style:initial;text-decoratio=
n-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helve=
tica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:=
normal;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial;display:inline;float:none">=3D=3D Root cause =3D=
=3D</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans=
-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial"><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvet=
ica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:n=
ormal;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Ar=
ial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;whi=
te-space:normal;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial;display:inline;float:none">On HPD, link_=
detect() -&gt; dp_verify_link_cap_with_</span><span style=3D"color:rgb(34,3=
4,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:nor=
mal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial;display:inline;float=
:none">retries() repeatedly calls</span><br style=3D"color:rgb(34,34,34);fo=
nt-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;word-spa=
cing:0px;white-space:normal;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial"><span style=3D"color:rgb(34=
,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial;display:inline;flo=
at:none">dp_perform_link_training() across link settings. A standby sink st=
ill asserts</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvet=
ica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:n=
ormal;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Ar=
ial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;whi=
te-space:normal;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial;display:inline;float:none">HPD, so it is=
 never treated as LINK_TRAINING_ABORT (unplugged) and the loop</span><br st=
yle=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;word-spacing:0px;white-space:normal;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif=
;font-size:small;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial;display:inline;float:none">keeps retrying into it.</span><br sty=
le=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:=
small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;word-spacing:0px;white-space:normal;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial"=
><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;fo=
nt-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;word-spacing:0px;white-space:normal;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,san=
s-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;fon=
t-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:star=
t;text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;b=
ackground-color:rgb(255,255,255);text-decoration-style:initial;text-decorat=
ion-color:initial;display:inline;float:none">Each attempt runs dp_perform_8=
b_10b_link_</span><span style=3D"color:rgb(34,34,34);font-family:Arial,Helv=
etica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space=
:normal;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial;display:inline;float:none">training(), which cal=
ls</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-=
serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;bac=
kground-color:rgb(255,255,255);text-decoration-style:initial;text-decoratio=
n-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helve=
tica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:=
normal;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial;display:inline;float:none">dpcd_set_link_settings=
() to write DP_DOWNSPREAD_CTRL / DP_LANE_COUNT_SET /</span><br style=3D"col=
or:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial"><span st=
yle=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;word-spacing:0px;white-space:normal;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
;display:inline;float:none">DP_LINK_BW_SET. Against the standby sink every =
core_link_write_dpcd() returns</span><br style=3D"color:rgb(34,34,34);font-=
family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;word-spacin=
g:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial"><span style=3D"color:rgb(34,34=
,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
ord-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial;display:inline;float:=
none">!=3D DC_OK. But:</span><br style=3D"color:rgb(34,34,34);font-family:A=
rial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;wh=
ite-space:normal;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial"><br style=3D"color:rgb(34,34,34);font-=
family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;word-spacin=
g:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial"><span style=3D"color:rgb(34,34=
,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
ord-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial;display:inline;float:=
none">- dpcd_set_link_settings() logs each failure and continues, returning=
 only the</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetic=
a,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:norma=
l;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align=
:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:nor=
mal;background-color:rgb(255,255,255);text-decoration-style:initial;text-de=
coration-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Aria=
l,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white=
-space:normal;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial;display:inline;float:none">last status;</s=
pan><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif=
;font-size:small;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;word-spacing:0px;white-space:norma=
l;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial;display:inline;float:none">- dp_perform_8b_10b_link_</=
span><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial;display:inline;float:none">training() discards that return va=
lue and proceeds to</span><br style=3D"color:rgb(34,34,34);font-family:Aria=
l,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white=
-space:normal;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-f=
amily:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing=
:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial;display:inline;float:none">the c=
lock-recovery / channel-EQ sequences, programming hardware</span><br style=
=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;word-spacing:0px;white-space:normal;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial"><=
span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;fo=
nt-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;word-spacing:0px;white-space:normal;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;display:inline;float:none">(dcn31_program_compbuf_size REG_WAIT tim=
eouts) into a link the sink has</span><br style=3D"color:rgb(34,34,34);font=
-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-v=
ariant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;word-spaci=
ng:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration=
-style:initial;text-decoration-color:initial"><span style=3D"color:rgb(34,3=
4,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:nor=
mal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial;display:inline;float=
:none">already failed to acknowledge =E2=80=94 which wedges the DMUB.</span=
><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;fo=
nt-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;word-spacing:0px;white-space:normal;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial"><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-=
serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;bac=
kground-color:rgb(255,255,255);text-decoration-style:initial;text-decoratio=
n-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helve=
tica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:=
normal;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial;display:inline;float:none">There is no DPCD sink-=
presence check before hardware programming.</span><br style=3D"color:rgb(34=
,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial"><br style=3D"colo=
r:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial"><span sty=
le=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:=
small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;word-spacing:0px;white-space:normal;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial;=
display:inline;float:none">=3D=3D Candidate fix =3D=3D</span><br style=3D"c=
olor:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;f=
ont-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fon=
t-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,2=
55,255);text-decoration-style:initial;text-decoration-color:initial"><br st=
yle=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size=
:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;word-spacing:0px;white-space:normal;background-color:r=
gb(255,255,255);text-decoration-style:initial;text-decoration-color:initial=
"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif=
;font-size:small;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial;display:inline;float:none">Fail link training gracefully when th=
e sink does not ACK the basic link-setting</span><br style=3D"color:rgb(34,=
34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:no=
rmal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400=
;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none=
;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial"><span style=3D"col=
or:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial;display:i=
nline;float:none">AUX writes: return early from dpcd_set_link_settings() on=
 the first failed write,</span><br style=3D"color:rgb(34,34,34);font-family=
:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;=
white-space:normal;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);f=
ont-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-sp=
acing:0px;white-space:normal;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial;display:inline;float:none">=
and abort dp_perform_8b_10b_link_</span><span style=3D"color:rgb(34,34,34);=
font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-s=
pacing:0px;white-space:normal;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial;display:inline;float:none"=
>training() with LINK_TRAINING_ABORT before</span><br style=3D"color:rgb(34=
,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial"><span style=3D"co=
lor:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial;display:=
inline;float:none">programming hardware when those writes failed. This only=
 affects a fully</span><br style=3D"color:rgb(34,34,34);font-family:Arial,H=
elvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-sp=
ace:normal;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-fami=
ly:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-varian=
t-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:=
normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0p=
x;white-space:normal;background-color:rgb(255,255,255);text-decoration-styl=
e:initial;text-decoration-color:initial;display:inline;float:none">AUX-unre=
sponsive sink; a healthy (or marginal-but-answering) sink returns DC_OK</sp=
an><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;word-spacing:0px;white-space:normal;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial;display:inline;float:none">and trains as before, preser=
ving the existing retry/fallback behaviour.</span><br style=3D"color:rgb(34=
,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial"><br style=3D"colo=
r:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial"><span sty=
le=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:=
small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;word-spacing:0px;white-space:normal;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial;=
display:inline;float:none">(Diff below is illustrative =E2=80=94 a mail cli=
ent may reflow its whitespace; I can send</span><br style=3D"color:rgb(34,3=
4,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:nor=
mal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial"><span style=3D"colo=
r:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial;display:in=
line;float:none">a clean git-am-able patch on request.)</span><br style=3D"=
color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial"><br s=
tyle=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-siz=
e:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:n=
ormal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;word-spacing:0px;white-space:normal;background-color:=
rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initia=
l"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-seri=
f;font-size:small;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial;display:inline;float:none">--- a/.../dc/link/protocols/link_</s=
pan><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-ser=
if;font-size:small;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial;display:inline;float:none">dp_training.c</span><br style=3D"co=
lor:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial"><span s=
tyle=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-siz=
e:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:n=
ormal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;word-spacing:0px;white-space:normal;background-color:=
rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initia=
l;display:inline;float:none">+++ b/.../dc/link/protocols/link_</span><span =
style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-si=
ze:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0=
px;text-transform:none;word-spacing:0px;white-space:normal;background-color=
:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initi=
al;display:inline;float:none">dp_training.c</span><br style=3D"color:rgb(34=
,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial"><span style=3D"co=
lor:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial;display:=
inline;float:none">status =3D core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL=
,</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-s=
erif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-v=
ariant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;back=
ground-color:rgb(255,255,255);text-decoration-style:initial;text-decoration=
-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvet=
ica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:n=
ormal;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial;display:inline;float:none">&amp;downspread.raw, si=
zeof(downspread));</span><br style=3D"color:rgb(34,34,34);font-family:Arial=
,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligatu=
res:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-=
space:normal;background-color:rgb(255,255,255);text-decoration-style:initia=
l;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-fa=
mily:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:=
0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial;display:inline;float:none">- if (=
status !=3D DC_OK)</span><br style=3D"color:rgb(34,34,34);font-family:Arial=
,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligatu=
res:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-=
space:normal;background-color:rgb(255,255,255);text-decoration-style:initia=
l;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-fa=
mily:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:=
0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial;display:inline;float:none">+ if (=
status !=3D DC_OK) {</span><br style=3D"color:rgb(34,34,34);font-family:Ari=
al,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-liga=
tures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal=
;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;whit=
e-space:normal;background-color:rgb(255,255,255);text-decoration-style:init=
ial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-=
family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;word-spacin=
g:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial;display:inline;float:none">DC_L=
OG_ERROR(&quot;...core_link_</span><span style=3D"color:rgb(34,34,34);font-=
family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;word-spacin=
g:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial;display:inline;float:none">writ=
e_dpcd (DP_DOWNSPREAD_CTRL) failed\n&quot;, ...);</span><br style=3D"color:=
rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial"><span style=
=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;word-spacing:0px;white-space:normal;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial;di=
splay:inline;float:none">+ /* First AUX transaction of link training. If it=
 fails the sink is</span><br style=3D"color:rgb(34,34,34);font-family:Arial=
,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligatu=
res:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-=
space:normal;background-color:rgb(255,255,255);text-decoration-style:initia=
l;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-fa=
mily:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:=
0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial;display:inline;float:none">+ * un=
responsive (e.g. powered but asleep); bail before issuing the</span><br sty=
le=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:=
small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;word-spacing:0px;white-space:normal;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial"=
><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;=
font-size:small;font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;word-spacing:0px;white-space:normal;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial;display:inline;float:none">+ * remaining writes / letting the cal=
ler program hardware into a</span><br style=3D"color:rgb(34,34,34);font-fam=
ily:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0=
px;white-space:normal;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34=
);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;=
font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lett=
er-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word=
-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-deco=
ration-style:initial;text-decoration-color:initial;display:inline;float:non=
e">+ * dead link (DMUB wedge on DCN3.1). */</span><br style=3D"color:rgb(34=
,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial"><span style=3D"co=
lor:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial;display:=
inline;float:none">+ return status;</span><br style=3D"color:rgb(34,34,34);=
font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-s=
pacing:0px;white-space:normal;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial"><span style=3D"color:rgb(=
34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial;display:inline;f=
loat:none">+ }</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Hel=
vetica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:=
normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-spac=
e:normal;background-color:rgb(255,255,255);text-decoration-style:initial;te=
xt-decoration-color:initial"><br style=3D"color:rgb(34,34,34);font-family:A=
rial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;wh=
ite-space:normal;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);fon=
t-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-=
variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;word-spac=
ing:0px;white-space:normal;background-color:rgb(255,255,255);text-decoratio=
n-style:initial;text-decoration-color:initial;display:inline;float:none">--=
- a/.../dc/link/protocols/link_</span><span style=3D"color:rgb(34,34,34);fo=
nt-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;word-spa=
cing:0px;white-space:normal;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial;display:inline;float:none">d=
p_training_8b_10b.c</span><br style=3D"color:rgb(34,34,34);font-family:Aria=
l,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white=
-space:normal;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-f=
amily:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing=
:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial;display:inline;float:none">+++ b=
/.../dc/link/protocols/link_</span><span style=3D"color:rgb(34,34,34);font-=
family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;word-spacin=
g:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial;display:inline;float:none">dp_t=
raining_8b_10b.c</span><br style=3D"color:rgb(34,34,34);font-family:Arial,H=
elvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-sp=
ace:normal;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-fami=
ly:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-varian=
t-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:=
normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0p=
x;white-space:normal;background-color:rgb(255,255,255);text-decoration-styl=
e:initial;text-decoration-color:initial;display:inline;float:none">/* 1. se=
t link rate, lane count and spread. */</span><br style=3D"color:rgb(34,34,3=
4);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal=
;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wor=
d-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-dec=
oration-style:initial;text-decoration-color:initial"><span style=3D"color:r=
gb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-st=
yle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weig=
ht:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfor=
m:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255=
);text-decoration-style:initial;text-decoration-color:initial;display:inlin=
e;float:none">if (lt_settings-&gt;lttpr_early_</span><span style=3D"color:r=
gb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-st=
yle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weig=
ht:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfor=
m:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255=
);text-decoration-style:initial;text-decoration-color:initial;display:inlin=
e;float:none">tps2)</span><br style=3D"color:rgb(34,34,34);font-family:Aria=
l,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;white=
-space:normal;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-f=
amily:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-var=
iant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spaci=
ng:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing=
:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial;display:inline;float:none">set_l=
ink_settings_and_perform_</span><span style=3D"color:rgb(34,34,34);font-fam=
ily:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0=
px;white-space:normal;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial;display:inline;float:none">early_t=
ps2_retimer_pre_lt_</span><span style=3D"color:rgb(34,34,34);font-family:Ar=
ial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;whi=
te-space:normal;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial;display:inline;float:none">sequence(...)=
;</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-s=
erif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-v=
ariant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;back=
ground-color:rgb(255,255,255);text-decoration-style:initial;text-decoration=
-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvet=
ica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:n=
ormal;background-color:rgb(255,255,255);text-decoration-style:initial;text-=
decoration-color:initial;display:inline;float:none">- else</span><br style=
=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;word-spacing:0px;white-space:normal;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial"><=
span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;fo=
nt-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;word-spacing:0px;white-space:normal;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;display:inline;float:none">- dpcd_set_link_settings(link, lt_settin=
gs);</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,san=
s-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;fon=
t-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:star=
t;text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;b=
ackground-color:rgb(255,255,255);text-decoration-style:initial;text-decorat=
ion-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Hel=
vetica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:=
normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;word-spacing:0px;white-spac=
e:normal;background-color:rgb(255,255,255);text-decoration-style:initial;te=
xt-decoration-color:initial;display:inline;float:none">+ else if (dpcd_set_=
link_settings(link, lt_settings) !=3D DC_OK)</span><br style=3D"color:rgb(3=
4,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial"><span style=3D"c=
olor:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;f=
ont-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fon=
t-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,2=
55,255);text-decoration-style:initial;text-decoration-color:initial;display=
:inline;float:none">+ /* Sink did not ACK the basic link-setting AUX writes=
 (powered but</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helv=
etica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space=
:normal;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-family:=
Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;w=
hite-space:normal;background-color:rgb(255,255,255);text-decoration-style:i=
nitial;text-decoration-color:initial;display:inline;float:none">+ * asleep,=
 still asserting HPD). Abort before programming the training</span><br styl=
e=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;word-spacing:0px;white-space:normal;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial">=
<span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;f=
ont-size:small;font-style:normal;font-variant-ligatures:normal;font-variant=
-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-in=
dent:0px;text-transform:none;word-spacing:0px;white-space:normal;background=
-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color=
:initial;display:inline;float:none">+ * sequence; on DCN3.1 proceeding wedg=
es the DMUB and hard-hangs the</span><br style=3D"color:rgb(34,34,34);font-=
family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;word-spacin=
g:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial"><span style=3D"color:rgb(34,34=
,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
ord-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial;display:inline;float:=
none">+ * display. */</span><br style=3D"color:rgb(34,34,34);font-family:Ar=
ial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-lig=
atures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;whi=
te-space:normal;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font=
-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-v=
ariant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;word-spaci=
ng:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration=
-style:initial;text-decoration-color:initial;display:inline;float:none">+ r=
eturn LINK_TRAINING_ABORT;</span><br style=3D"color:rgb(34,34,34);font-fami=
ly:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-varian=
t-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:=
normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0p=
x;white-space:normal;background-color:rgb(255,255,255);text-decoration-styl=
e:initial;text-decoration-color:initial"><br style=3D"color:rgb(34,34,34);f=
ont-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-sp=
acing:0px;white-space:normal;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial"><span style=3D"color:rgb(3=
4,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial;display:inline;fl=
oat:none">=3D=3D Open question =3D=3D</span><br style=3D"color:rgb(34,34,34=
);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;=
font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lett=
er-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word=
-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-deco=
ration-style:initial;text-decoration-color:initial"><br style=3D"color:rgb(=
34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial"><span style=3D"=
color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial;displa=
y:inline;float:none">On DCN3.1 AUX is DMUB-mediated. Is the wedge caused by=
 the hardware programming</span><br style=3D"color:rgb(34,34,34);font-famil=
y:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px=
;white-space:normal;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);=
font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-s=
pacing:0px;white-space:normal;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial;display:inline;float:none"=
>into the dead link (what this patch prevents) or by the failed AUX-over-DM=
UB</span><br style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-=
serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;bac=
kground-color:rgb(255,255,255);text-decoration-style:initial;text-decoratio=
n-color:initial"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helve=
tica,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;word-spacing:0px;white-space:=
normal;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial;display:inline;float:none">transactions themselve=
s? The trace suggests the former =E2=80=94 the AUX writes return</span><br =
style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-si=
ze:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0=
px;text-transform:none;word-spacing:0px;white-space:normal;background-color=
:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initi=
al"><span style=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-ser=
if;font-size:small;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;word-spacing:0px;white-space:normal;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial;display:inline;float:none">failure cleanly and the wedge corre=
lates with the subsequent</span><br style=3D"color:rgb(34,34,34);font-famil=
y:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px=
;white-space:normal;background-color:rgb(255,255,255);text-decoration-style=
:initial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);=
font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-s=
pacing:0px;white-space:normal;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial;display:inline;float:none"=
>dcn31_program_compbuf_size programming.</span><br style=3D"color:rgb(34,34=
,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:norm=
al;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
ord-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-d=
ecoration-style:initial;text-decoration-color:initial"><br style=3D"color:r=
gb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-st=
yle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weig=
ht:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfor=
m:none;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255=
);text-decoration-style:initial;text-decoration-color:initial"><span style=
=3D"color:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;word-spacing:0px;white-space:normal;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial;di=
splay:inline;float:none">I can build/test on the affected hardware and coll=
ect DMUB diagnostics</span><br style=3D"color:rgb(34,34,34);font-family:Ari=
al,Helvetica,sans-serif;font-size:small;font-style:normal;font-variant-liga=
tures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal=
;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;whit=
e-space:normal;background-color:rgb(255,255,255);text-decoration-style:init=
ial;text-decoration-color:initial"><span style=3D"color:rgb(34,34,34);font-=
family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;font-va=
riant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;word-spacin=
g:0px;white-space:normal;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial;display:inline;float:none">befo=
re/after. Thanks for taking a look.</span><br style=3D"color:rgb(34,34,34);=
font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:normal;fo=
nt-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-s=
pacing:0px;white-space:normal;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial"><br style=3D"color:rgb(34=
,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial"><span style=3D"co=
lor:rgb(34,34,34);font-family:Arial,Helvetica,sans-serif;font-size:small;fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;word-spacing:0px;white-space:normal;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial;display:=
inline;float:none">Greg</span><br></div>

--0000000000004aadac06536b2924--
