Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79310606A321
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=beMoKt2V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21CD10F43C;
	Tue, 27 Oct 2026 12:33:16 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC0610F319
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 09:37:48 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-4a451915d8aso2624994b6e.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 02:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793093868; cv=none;
 d=google.com; s=arc-20260327;
 b=FTFeJnWF1L7OcIboqJhNSaE3BcsZeWv5c/GqWct6fnNzWih2G/xlWTWfVElo3AkQDS
 AtUJy402OKfngEgp6CVrT1E1x5DOLJVed2uivQv/6/4k5Il/bHrW7KKhWDezS9xn8V7C
 bE4rvf8VETYAjo5UXls5Ou9uLh4Z/FJN3eIEgJvddDgfUfUzi3HSxg8SItTZ4Hg/fXbf
 GhNHRrY2Uu+WaCI59XEW9GQ/o4iWmhWr2wl/eQXKmQVtcyGV1YWYmpZWKg7RpOjP36bX
 X5SmkVqHiYMvNvQ+5mRBjI+soFFDxjECC+sqdfDv5O6ofxwpHUdqqNJ5jdS0CQqy7PIx
 oCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=osiLWILnLebB1sh7zMsQ9vtp+7CCYgXAtPwvU5+oQvA=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=c4krLAbVFA9HDBKQ0N410UmfSbt25fD7Q/vPkyCySSXyNN0aBjytRphxrnOsYpQn78
 uiMcGQ+bS8sRItWl5HMc2EpDGNjXp05erey4uItyzT6Q+YjzKJo3o1FiCNNbjV3IJOXZ
 oxU6lcFzE8ofmKF5j70xdBX4fGTY9JL58XzyVlNlVUtxpxy5bpcLhjx5+BLbOGWDC8Ti
 hCx6XntrKBxM/7+bFSWZ5eKc73oH4BZ6QAHsbHenfIjEJDmqXx42mHqfkhOjQdXTBQdF
 r3Rm3T0wFHhVHST/4C3zYta8Ix3DvPe7S03WLXLrqU3Np8vxcLDTT0Ff06uPYJXMAfq4
 zaRw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793093868; x=1793698668; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=osiLWILnLebB1sh7zMsQ9vtp+7CCYgXAtPwvU5+oQvA=;
 b=beMoKt2Vx4A+EBlcD9pxDP0WSi3jEPaa6/MN6gmTIycIavZ8cy1ZZsO+E6RJFQL0ZV
 eZlRF6+/Mhr53/C62qvqWAwpv7K43QUUMrc81Hn1typAfE1VHdDDRdEg/lcyHFS2t64x
 Xwi0R6Ieonih7O4DZRz6TFLY0RtvoeYwLJVr9iWfRhLUzRyl+SSG76O+jJ07l006i6bW
 uYss7XpnciCccQMJ6ZIc1KXFrLfS3JefgU0n9/jcCr67yFacnwhpFoAVph6zK8xYpmu1
 C9dC1pVbe2dXsUvUwQvj3j4CwGUS1WF9J0JuR8hprZtO9NHNKxNpUUxLKfTTWQ5zqCI8
 pUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793093868; x=1793698668;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=osiLWILnLebB1sh7zMsQ9vtp+7CCYgXAtPwvU5+oQvA=;
 b=hsUCkWB2yazjWg8ngopVTm/AJ/TSAUwtRKetZg8pMNNcMlH0rhnFTKecMweS1bM5gl
 TIMshoIRLXmUM9dD+MSErax1SehaWGIulTqlTdxNj5jOPEt0Y/nG9Q4iAE6OZTo8MpVa
 Fc3oKVz6AWj24qKMD6twDtS21Sl1lY5n6rxCVWjeQPLaYEbZlN4BH/IJSvCn3kZBjdrR
 g+PPyWDnmzorIsg1tNSvwVT/ppHq6/7Ez5OpgNoGcVAqaceWKhQZSV+CwalU+aek2or5
 d2qOtz5HjWOz0EJhsGiOvhHCEqNNQ6qmu22PNyAGcoaN03e/+/xiGLt5iKabFkmipjx3
 TTSA==
X-Gm-Message-State: AFq9FYLpwSDDsOfFBHxgBLn2We3uJzIEPWt3ntiSJUItOD1VB0+41BTx
 r6csBCP4A8/4j7N2O4ZEtirbhUlzi2hQz+iFJKIo5lQlMyfg09ltXGlpS92+Y4AjAIVkL0AwqrQ
 p46/XXjcgjRuXl4Z9CcJH/E0BE0Xd32z5PTVIcz4=
X-Gm-Gg: AYBFou2HjlSXOjisIoudAkxD/7OGIrE+sxaA4vukl4cN+XTZiNjbNrXHICooQR5yeKI
 aZOxqIpuyVTsAoSHz1IyhvhnYdtl0wu/jdjWb1g4jXW1D9lA2I/Z7y/2Vu8rsr6sZB3151Nn1B8
 DVZ1T9no0XZnD0BkoO9InxiUuniRQ3DN3eZ97F6GpWWfjE48kazZ61yqlis5dh3LLTei0IiG4IA
 Kk11bsPUK60Dm2oLWkfgZkOb6dleMwdIz/qfBvV2GxK6Vf3pnyqEQ6zAblGgQd6TPal/VfV+M2Y
 8Oem/qPlvm0rfDKM5LRcPo7IEjpz/hXpixu3/pVqjS+LUc8Yt23hEQgFUVZC55beUKpJgyBUui/
 Z2/FJwgesikhkwmhlgK5iVlAPhmira9+Ho2kLDGjg5aOe1zNIZxpDpZ2Q1sCxHx+TVGMjWNcBtR
 Hecg9r8E5dgrsZANUfra/7JaUdbeJACYjD+TYbCbWZOCkBzSJvv2Sx/m0m6+f/AyCVORZcze/NV
 X97E8/G241bENsbpz2a78GygG6g6SwxkA==
X-Received: by 2002:a05:6808:2205:b0:4d6:92d4:c806 with SMTP id
 5614622812f47-55c00401fbcmr6027311b6e.62.1793093867593; Tue, 27 Oct 2026
 02:37:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dennis Hilk <hilk.dennis@gmail.com>
Date: Tue, 27 Oct 2026 10:37:36 +0100
X-Gm-Features: AclHuK_CvwQ0pk9PTK_nV1CaPsDtV0rAtjrgDOFDpetKbwLFNzUQonOgaSGP1tw
Message-ID: <CAEF-o0sboapPN8iQ7Rj9s3CN30Zm+_-KZzX1yc7756t9z5n9DQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_AMDGPU_RX_9060_XT_=E2=80=94_New_findings=3A_=2D500_MHz_clo?=
 =?UTF-8?Q?ck_offset_and_successful_retests?=
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000006e681065ecf3348"
X-Mailman-Approved-At: Tue, 27 Oct 2026 12:33:15 +0000
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

--00000000000006e681065ecf3348
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello AMDGPU developers,

I would like to share a significant update to my original report from
October 25 concerning GPU device-loss failures on my PowerColor Radeon RX
9060 XT (Navi44 / GFX1200).

On October 27, I performed a controlled GPU clock-offset experiment that
produced some very interesting results.

*1. Previous Blackbox findings*

My persistent logger captured three PCI bus-loss incidents, including the
two Arma 3 failures reported previously and a separate Qwen3-TTS / ROCm
failure on October 26.

The last readable GPU clock values before those failures were:

   -

   October 24: 3,472 MHz =E2=80=94 135 W
   -

   October 24: 3,445 MHz =E2=80=94 148 W
   -

   October 26: 3,474 MHz =E2=80=94 124 W

All three showed 100% GPU utilization in their final valid samples.

I also found previous high-frequency intervals without failures, so I am *n=
ot
claiming that 3,400 MHz represents a deterministic crash threshold*.

*2. New experiment: AMDGPU OverDrive*

I created a separate systemd-boot UKI with:

amdgpu.ppfeaturemask=3D0xfff7ffff

The original mask was 0xfff7bfff.

I then applied and committed:

OD_SCLK_OFFSET: -500Mhz

Other settings remained unchanged:

   -

   Voltage offset: 0 mV
   -

   Memory clock configuration: unchanged
   -

   Reported power limit: 175 W
   -

   GPU performance policy: auto

This is a negative clock offset, not an enforced 3,000 MHz frequency cap.

*3. Results with the -500 MHz offset*
Workload Maximum recorded GPU clock Result
GravityMark 1.89 Vulkan 2,993 MHz Completed, 167 seconds
GravityMark Vulkan RT 2,989 MHz Completed, 167 seconds
Qwen3-TTS / ROCm, three-voice generation 2,998 MHz All three voices
successfully generated
Arma 3 campaign 2,994 MHz Approximately 15 minutes without a hardlock

No samples at or above 3,000 MHz appeared in these analyzed workload
windows.

The Qwen3-TTS test is particularly interesting because the same longer
three-voice job had previously caused a complete GPU bus loss.

*4. Previously problematic games now working*

Arma 3 had previously caused system hardlocks shortly after entering the
menu or immediately when starting the campaign.

With the -500 MHz offset, I completed approximately 15 minutes of campaign
gameplay without a hardlock and without additional Steam launch parameters.

I also tested S.T.A.L.K.E.R. 2, which had previously hardlocked directly
after shader compilation when launched without workarounds.

With the clock offset applied, I could play for approximately 15 minutes on
Ultra settings, including two deaths and subsequent reloads.

The Steam launch-options field was completely empty. In particular, I did
not disable VK_EXT_descriptor_buffer.

I have not yet independently analyzed the S.T.A.L.K.E.R. 2 telemetry window=
.

*5. Interpretation and next steps*

This is the strongest stability improvement I have observed so far on this
machine.

However, I do not consider the underlying cause established. Possible
GPU/SMU stability, firmware, driver, PCIe, and electrical issues remain
open. Reducing the GPU clock might simply be masking a deeper problem.

I plan to perform longer, precisely timed tests with several games that
previously produced hardlocks, while keeping the Blackbox logger active.

I would particularly appreciate your thoughts on whether this sensitivity
to a negative GFX clock offset suggests any specific SMU,
clock/voltage-management, GPU hardware, or driver diagnostics worth
investigating.

The full measurements, reproduction procedure, and separate UKI/OverDrive
configuration are documented here:

https://www.dennishilk.com/blog/rx-9060-xt-linux-crashes/#blackbox-20261027

All original failure logs, telemetry files, coredumps, and system snapshots
remain available.

Thank you again for your time and for your work on the Linux AMDGPU driver.

Best regards,
Dennis Hilk

--00000000000006e681065ecf3348
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hello AMDGPU developers,</p><p>I would like to share a =
significant update to my original report from October 25 concerning GPU dev=
ice-loss failures on my PowerColor Radeon RX 9060 XT (Navi44 / GFX1200).</p=
><p>On October 27, I performed a controlled GPU clock-offset experiment tha=
t produced some very interesting results.</p><p><strong>1. Previous Blackbo=
x findings</strong></p><p>My persistent logger captured three PCI bus-loss =
incidents, including the two Arma 3 failures reported previously and a sepa=
rate Qwen3-TTS / ROCm failure on October 26.</p><p>The last readable GPU cl=
ock values before those failures were:</p><ul><li><p>October 24: 3,472 MHz =
=E2=80=94 135 W</p></li><li><p>October 24: 3,445 MHz =E2=80=94 148 W</p></l=
i><li><p>October 26: 3,474 MHz =E2=80=94 124 W</p></li></ul><p>All three sh=
owed 100% GPU utilization in their final valid samples.</p><p>I also found =
previous high-frequency intervals without failures, so I am <strong>not cla=
iming that 3,400 MHz represents a deterministic crash threshold</strong>.</=
p><p><strong>2. New experiment: AMDGPU OverDrive</strong></p><p>I created a=
 separate systemd-boot UKI with:</p><p><code>amdgpu.ppfeaturemask=3D0xfff7f=
fff</code></p><p>The original mask was <code>0xfff7bfff</code>.</p><p>I the=
n applied and committed:</p><p><code>OD_SCLK_OFFSET: -500Mhz</code></p><p>O=
ther settings remained unchanged:</p><ul><li><p>Voltage offset: 0 mV</p></l=
i><li><p>Memory clock configuration: unchanged</p></li><li><p>Reported powe=
r limit: 175 W</p></li><li><p>GPU performance policy: auto</p></li></ul><p>=
This is a negative clock offset, not an enforced 3,000 MHz frequency cap.</=
p><p><strong>3. Results with the -500 MHz offset</strong></p><table><tbody>=
<tr><th>Workload</th><th>Maximum recorded GPU clock</th><th>Result</th></tr=
><tr><td>GravityMark 1.89 Vulkan</td><td>2,993 MHz</td><td>Completed, 167 s=
econds</td></tr><tr><td>GravityMark Vulkan RT</td><td>2,989 MHz</td><td>Com=
pleted, 167 seconds</td></tr><tr><td>Qwen3-TTS / ROCm, three-voice generati=
on</td><td>2,998 MHz</td><td>All three voices successfully generated</td></=
tr><tr><td>Arma 3 campaign</td><td>2,994 MHz</td><td>Approximately 15 minut=
es without a hardlock</td></tr></tbody></table><p>No samples at or above 3,=
000 MHz appeared in these analyzed workload windows.</p><p>The Qwen3-TTS te=
st is particularly interesting because the same longer three-voice job had =
previously caused a complete GPU bus loss.</p><p><strong>4. Previously prob=
lematic games now working</strong></p><p>Arma 3 had previously caused syste=
m hardlocks shortly after entering the menu or immediately when starting th=
e campaign.</p><p>With the -500 MHz offset, I completed approximately 15 mi=
nutes of campaign gameplay without a hardlock and without additional Steam =
launch parameters.</p><p>I also tested S.T.A.L.K.E.R. 2, which had previous=
ly hardlocked directly after shader compilation when launched without worka=
rounds.</p><p>With the clock offset applied, I could play for approximately=
 15 minutes on Ultra settings, including two deaths and subsequent reloads.=
</p><p>The Steam launch-options field was completely empty. In particular, =
I did not disable <code>VK_EXT_descriptor_buffer</code>.</p><p>I have not y=
et independently analyzed the S.T.A.L.K.E.R. 2 telemetry window.</p><p><str=
ong>5. Interpretation and next steps</strong></p><p>This is the strongest s=
tability improvement I have observed so far on this machine.</p><p>However,=
 I do not consider the underlying cause established. Possible GPU/SMU stabi=
lity, firmware, driver, PCIe, and electrical issues remain open. Reducing t=
he GPU clock might simply be masking a deeper problem.</p><p>I plan to perf=
orm longer, precisely timed tests with several games that previously produc=
ed hardlocks, while keeping the Blackbox logger active.</p><p>I would parti=
cularly appreciate your thoughts on whether this sensitivity to a negative =
GFX clock offset suggests any specific SMU, clock/voltage-management, GPU h=
ardware, or driver diagnostics worth investigating.</p><p>The full measurem=
ents, reproduction procedure, and separate UKI/OverDrive configuration are =
documented here:</p><p><a href=3D"https://www.dennishilk.com/blog/rx-9060-x=
t-linux-crashes/#blackbox-20261027">https://www.dennishilk.com/blog/rx-9060=
-xt-linux-crashes/#blackbox-20261027</a></p><p>All original failure logs, t=
elemetry files, coredumps, and system snapshots remain available.</p><p>Tha=
nk you again for your time and for your work on the Linux AMDGPU driver.</p=
><p>Best regards,<br>Dennis Hilk</p></div>

--00000000000006e681065ecf3348--
