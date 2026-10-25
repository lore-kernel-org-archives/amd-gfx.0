Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59307606A32A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SW8ZHw4u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7A710ECC6;
	Mon, 26 Oct 2026 08:44:01 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CDB10E15D
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 16:52:09 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-53ec9237600so1342687b6e.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 09:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792947129; cv=none;
 d=google.com; s=arc-20260327;
 b=VmNlmXFYBt80RyAuWvNGB4vpLe1DM9jNHCtP5nnMXoImdAfj3Ji8ul3+p1TvQ3Q5fF
 +Y+T99tsZJ40R36meb/6/LVM2NiV2/QMuO3pNEvSUciF5THoyNxBYC3CyUUCuS4fqQqz
 9g95Mu4ZWHzDJKVLzEfZzvO0Ps/EtES/MU4e5n9wpoFHJOU8srl96c+WrDJA47rz/2XZ
 giNqOmMU2ALtVVrKBsF3GsIVNGfOsm0In16xreQSAJx+qiL2WxzbucbJr90Nho6SiRjz
 oJViodIPZQK4/Rz3Ty8Fo6RzZ37/dJcPtq49BtmG8kFHYgbUWvbFLO9/YLvKt67vOQm4
 ylTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=SAcmB6c15V8yYqcECQsipjEXGEXN1umlUTdehS2NYLU=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=R018K+36bnIqMYp3g8IGYCPSMVRReo9LeXfQJK7lWVZn0MwIwSDsy93mhAQfEMS35I
 Wbe12svwwK1Owyl4yCFcO9zVWaQrWaNr0ViVLFCBnSaGOzQoxlnIR/SCmd0Yvi+t/kMm
 mR0qMyAKa2hT6gX1hW8DAUgu1krYEpgoWHgG5+pTNvosA+77k9KB3YiGtW34ztPG5nut
 qjvrj2fOf2c/p82oEOJq93EOu6TscVUrFaNB2kaPDClKApsJ/RjbJAs/zkRlztPeFWXO
 XWkDvOLWx2iRQWGvXTQHoHNZzV3c15IPlG+/G1d1xjOIxveKZ/D4f0ff81LlKVaD0VJz
 M5Hg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792947129; x=1793551929; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SAcmB6c15V8yYqcECQsipjEXGEXN1umlUTdehS2NYLU=;
 b=SW8ZHw4uau2LyjYBE+Hdm65PnYRei5ZhjoVs9l4w8psvE1/nTgGx+BpoZY1Gut52U9
 S28GjeTyfNW9Ch5iSv340KqpWBoIKbPjfVrETxFAmgtxLLtmoSyZ7QxCVA2Zlz0NF67S
 aVyhD2zBjSkqqu28oEbhMYdL0FWy13s4B7V/Ne3ZuaxKJa/R8o8TgJxAtfAAC/wbcV1s
 WcgrpLhOKvM5dkcHJYPxiAqx1qdTNmSHc7XF8SExkFlTvrRy20VRvoiozKr/RM0lwhXQ
 7qkVWRSf+rU98+EvHMoIMleIpI7TInai3zGT9zvIpZIXMkDiv+XUR2Qw5VcZ+UN2mFPP
 5y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792947129; x=1793551929;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SAcmB6c15V8yYqcECQsipjEXGEXN1umlUTdehS2NYLU=;
 b=sfBQFMzKnSNzcTx/hKwS4kxuAG8rbFtC2Z0hN2sCHSSv/s1fTrUW9TH+cYrUOdIajP
 PmI9MprsHyTGC2+udJuyuJEj0FAJDlz3tVjnaaKivB0FNnwBK/DfEUGHKoOdQru/Z6/t
 Qid/5BmLitVg6FtN3jrge5RRc72Dr8VyIBcjS8CnWEqiRCblQHRvX4I+EO4i+XkLVEx+
 zbVsgAx9OzCod7rBioaMhpZ7Ba6jmzXDIsnQ9wKO4Wt7pEUf8H+RoR6zDfiJCnEgL+BU
 cacQfZLllQelC1OwxNmDSQbVpugKaVWxPP7pelC6SOc2Yc0tenUA/Nwm1js3oH+DHPUu
 RgBg==
X-Gm-Message-State: AFq9FYL07B7zAULdx3jVwN8MHSlk8/Foz1h2x414/lrWFrWl++2g7U/h
 TzvOs/YSyG6tbFf/2OJknbGk2KumXbCW7w+d41DJURYhAWr8lUWvvj4MN4VKC9yFjIacEHpzc6/
 w2PHJlSz1yWLrsKvuBA023iJkCeF5mS6taI1B9oM=
X-Gm-Gg: AYBFou2ygQxXrc+gSVNUdwAkmQ9jR2BrsRZyXsgcfWa6kP25yIF/B7byl1l8kwl1WqU
 P7y8zZxMXPpuOYDXLH5Eu/68BtSr9VwHGIWZD70d6+LEFAPCFltyepLU4WuFQCexCwnKvA7dcUy
 8n1kN1loPEKkr5Fvw4lJY+f5K59gKOyFoqtRpoujVhRKtpcS4Q2ITkBfuQg7ZOYUgbfrpkeuRwS
 ZZbzB9nfQu0Eq/Pd6Xs4tbHq1XbFaWPsdo07NHqL7OQ3sR92xjnCgodU37pJlVMtuev+LQNVnNz
 sPoBeAn5wsy877eoWa5wXaGu+K+s+7lm15/xdo6orl5CxI18Or+JLgeAqyvJXGl3KUdJHaJJRRD
 y1FNJRSY7mlWp1Z7KLfJjlQa0GqJtTyVlx6/ybxJjat4uh+eQUNAtdpNoL2RBGcWokxSf9MGyRx
 PP3ZPKOAtzR3JKbDbIRb9OTD78qR1BRXFxQac/qQSz7mEwP3xzBxTgqEgGGWVljsnNUS5VGy05J
 ixtJuOEYiBUpA==
X-Received: by 2002:a05:6808:1506:b0:4f1:6c9c:78d3 with SMTP id
 5614622812f47-55c0025c6a1mr2617645b6e.26.1792947128523; Sun, 25 Oct 2026
 09:52:08 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dennis Hilk <hilk.dennis@gmail.com>
Date: Sun, 25 Oct 2026 17:51:55 +0100
X-Gm-Features: AclHuK_tBy_gYo1JRGucb04RxNwsan1BPYsXf_fwz7AEa7PYivcCDbZINc0egp8
Message-ID: <CAEF-o0uY8t8SmwSQXT9R7GrTNDmkP2r1N-HwCc1UzVT30V5nSQ@mail.gmail.com>
Subject: [amdgpu][Navi44] RX 9060 XT: PCI device loss in Arma 3 precedes ring
 recovery (Linux 7.2.11)
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000b261b2065ead0844"
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:43:34 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000b261b2065ead0844
Content-Type: text/plain; charset="UTF-8"

Hello AMDGPU developers,

I am investigating reproducible GPU device-loss failures on an AMD Radeon
RX 9060 XT 16 GiB (Navi44 / GFX1200) under Linux. I captured two Arma 3
failures on 24 October 2026 with a persistent, independent kernel/telemetry
logger. I would appreciate guidance on which additional existing data would
be most useful, and whether this signature matches a known kernel/firmware
issue.

System:
- AMD Ryzen 7 5800X3D; Gigabyte B550 VISION D (BIOS F18d)
- AMD Radeon RX 9060 XT 16 GiB, PCI BDF 0000:55:00.0; GPU audio at
0000:55:00.1
- Arch Linux; kernel 7.2.11-arch1-1; Mesa/RADV 26.2.5
- Proton 11.0-2e; Xorg/dwm
- Arma 3 using DXVK

Two independently captured configurations:
A) DXVK descriptor-buffer path enabled.
   First 'device lost from bus' indication: 2026-10-24 17:17:56.404353 CEST
   First logged graphics ring reset attempt: 17:17:57.430485 CEST
   GPU recovery result: 'GPU Recovery Failed: -19'
   Last valid Blackbox power telemetry before loss: 135 W.

B) DXVK legacy binding path (dxvk.enableDescriptorBuffer = False, effective
in the application).
   GPU audio function 0000:55:00.1 failed a D3hot-to-D0 transition at
17:34:59.321751 CEST.
   First 'device lost from bus' indication: 17:34:59.469720 CEST
   First logged graphics ring reset attempt: 17:35:00.733750 CEST
   Last valid Blackbox power telemetry before loss: 148 W.

In both captures the device became inaccessible *before the first logged
ring reset attempt*. Subsequent SMU metric reads and other device queries
failed. The cached power cap remained readable at 175 W even after live
metrics stopped responding; it is not evidence that firmware was still
answering.

I cannot determine from the logs whether the original trigger was a
GPU/firmware hang, PCIe/platform problem, internal power-state transition,
or an electrical fault. The audio transition failure is an observed
symptom, not an identified root cause. I do not claim the reset attempt
caused the earlier bus loss.

As a control, eight GravityMark 1.89 benchmark runs across seven Vulkan,
OpenGL, RT, compute, and Proton paths ended normally on the same Linux
system. Driver-reported power telemetry reached 242 W during native Vulkan
RT and 224 W during Proton D3D11 with a displayed cap of 175 W; these
readings are NOT independent electrical power measurements, and did not
coincide with a GPU loss. A simple observed-wattage threshold therefore
does not explain both Arma failures.

My technical investigation (DE/EN):
https://www.dennishilk.com/blog/rx-9060-xt-linux-crashes/

I have preserved both original Arma Blackbox sessions (kernel logs,
~1-second telemetry and boot snapshots), corresponding Proton logs, and
hashes. I can provide redacted excerpts or full archives as preferred. No
new intentionally crashing reproduction is planned merely to collect
duplicate logs.

Could you advise:
1. Whether the PCI-config-space failure before recovery resembles an
existing Navi44 / GFX12 issue.
2. Which specific pre-failure logs, firmware identities, PCIe/AER or
runtime-PM evidence would best distinguish the hypotheses.
3. Whether you would prefer a drm/amd GitLab report linked from this thread.

Thank you for taking a look.

Best regards,
Dennis Hilk

--000000000000b261b2065ead0844
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div id=3D"gmail-:6b" class=3D"gmail-Am gmail-aiL gmail-Al=
 editable gmail-LW-avf gmail-tS-tW gmail-tS-tY" aria-label=3D"Inhalt der Na=
chricht" role=3D"textbox" aria-multiline=3D"true" tabindex=3D"1" style=3D"d=
irection:ltr;min-height:416px" aria-controls=3D":8u" aria-expanded=3D"false=
">Hello AMDGPU developers,<br><br>I am investigating reproducible GPU devic=
e-loss failures on an AMD Radeon RX 9060 XT 16 GiB (Navi44 / GFX1200) under=
 Linux. I captured two Arma 3 failures on 24 October 2026 with a persistent=
, independent kernel/telemetry logger. I would appreciate guidance on which=
 additional existing data would be most useful, and whether this signature =
matches a known kernel/firmware issue.<br><br>System:<br>- AMD Ryzen 7 5800=
X3D; Gigabyte B550 VISION D (BIOS F18d)<br>- AMD Radeon RX 9060 XT 16 GiB, =
PCI BDF 0000:55:00.0; GPU audio at 0000:55:00.1<br>- Arch Linux; kernel 7.2=
.11-arch1-1; Mesa/RADV 26.2.5<br>- Proton 11.0-2e; Xorg/dwm<br>- Arma 3 usi=
ng DXVK<br><br>Two independently captured configurations:<br>A) DXVK descri=
ptor-buffer path enabled.<br>=C2=A0 =C2=A0First &#39;device lost from bus&#=
39; indication: 2026-10-24 17:17:56.404353 CEST<br>=C2=A0 =C2=A0First logge=
d graphics ring reset attempt: 17:17:57.430485 CEST<br>=C2=A0 =C2=A0GPU rec=
overy result: &#39;GPU Recovery Failed: -19&#39;<br>=C2=A0 =C2=A0Last valid=
 Blackbox power telemetry before loss: 135 W.<br><br>B) DXVK legacy binding=
 path (dxvk.enableDescriptorBuffer =3D False, effective in the application)=
.<br>=C2=A0 =C2=A0GPU audio function 0000:55:00.1 failed a D3hot-to-D0 tran=
sition at 17:34:59.321751 CEST.<br>=C2=A0 =C2=A0First &#39;device lost from=
 bus&#39; indication: 17:34:59.469720 CEST<br>=C2=A0 =C2=A0First logged gra=
phics ring reset attempt: 17:35:00.733750 CEST<br>=C2=A0 =C2=A0Last valid B=
lackbox power telemetry before loss: 148 W.<br><br>In both captures the dev=
ice became inaccessible *before the first logged ring reset attempt*. Subse=
quent SMU metric reads and other device queries failed. The cached power ca=
p remained readable at 175 W even after live metrics stopped responding; it=
 is not evidence that firmware was still answering.<br><br>I cannot determi=
ne from the logs whether the original trigger was a GPU/firmware hang, PCIe=
/platform problem, internal power-state transition, or an electrical fault.=
 The audio transition failure is an observed symptom, not an identified roo=
t cause. I do not claim the reset attempt caused the earlier bus loss.<br><=
br>As a control, eight GravityMark 1.89 benchmark runs across seven Vulkan,=
 OpenGL, RT, compute, and Proton paths ended normally on the same Linux sys=
tem. Driver-reported power telemetry reached 242 W during native Vulkan RT =
and 224 W during Proton D3D11 with a displayed cap of 175 W; these readings=
 are NOT independent electrical power measurements, and did not coincide wi=
th a GPU loss. A simple observed-wattage threshold therefore does not expla=
in both Arma failures.<br><br>My technical investigation (DE/EN):<br><a hre=
f=3D"https://www.dennishilk.com/blog/rx-9060-xt-linux-crashes/">https://www=
.dennishilk.com/blog/rx-9060-xt-linux-crashes/</a><br><br>I have preserved =
both original Arma Blackbox sessions (kernel logs, ~1-second telemetry and =
boot snapshots), corresponding Proton logs, and hashes. I can provide redac=
ted excerpts or full archives as preferred. No new intentionally crashing r=
eproduction is planned merely to collect duplicate logs.<br><br>Could you a=
dvise:<br>1. Whether the PCI-config-space failure before recovery resembles=
 an existing Navi44 / GFX12 issue.<br>2. Which specific pre-failure logs, f=
irmware identities, PCIe/AER or runtime-PM evidence would best distinguish =
the hypotheses.<br>3. Whether you would prefer a drm/amd GitLab report link=
ed from this thread.<br><br>Thank you for taking a look.<br><br>Best regard=
s,<br>Dennis Hilk</div><div id=3D"gmail-:6b" class=3D"gmail-Am gmail-aiL gm=
ail-Al editable gmail-LW-avf gmail-tS-tW gmail-tS-tY" aria-label=3D"Inhalt =
der Nachricht" role=3D"textbox" aria-multiline=3D"true" tabindex=3D"1" styl=
e=3D"min-height:416px" aria-controls=3D":8u" aria-expanded=3D"false"><br></=
div></div>

--000000000000b261b2065ead0844--
