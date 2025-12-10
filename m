Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869D9D3B995
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 02:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3DF810E5FC;
	Wed, 10 Dec 2025 02:02:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=lhjonline.com header.i=@lhjonline.com header.b="TXxr+qKl";
	dkim-atps=neutral
X-Greylist: delayed 361 seconds by postgrey-1.36 at gabe;
 Wed, 10 Dec 2025 02:02:39 UTC
Received: from zmailpro.com (zmailpro.com [174.129.240.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F69910E5FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 02:02:39 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by zmailpro.com (Postfix) with ESMTP id D819689E321
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 20:56:37 -0500 (EST)
Received: from zmailpro.com ([127.0.0.1])
 by localhost (zmailpro.com [127.0.0.1]) (amavis, port 10032) with ESMTP
 id yEZoyOhg_Ydz for <amd-gfx@lists.freedesktop.org>;
 Tue,  9 Dec 2025 20:56:36 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by zmailpro.com (Postfix) with ESMTP id A9AD189E341
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 20:56:36 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmailpro.com A9AD189E341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lhjonline.com;
 s=22187CEA-9A4A-11E6-98C3-D49722DE3479; t=1765331796;
 bh=5nv43zdoGxwMNPoqG6Busm13oZu3lyu4cByjaTf9gx8=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=TXxr+qKl/QJJd/L0GfRzAHMti/bZzBN1gTLQ2dfKagQba26hj7/UFp4hg0GbIVa7A
 MPR4EejWpZiEn9uFZXJSHzv7D+kP7e91wwqDvp893cgKgRMOBhMNXTKalJecfHbiMj
 paOlb2ix4T3YYItyMbACNjLFPMdS0LGBoW2hG8VVGObeN923dOGQuKGnq1Wq3zBu6H
 d4y9ks86G+nd2XA30pWrr2lnsmmrGhNhf1Mphv1a7G0+qmSAt7sOQ/i5/3TUZIiMzD
 pG+p72d0D9dp0oUmy2SwTBc/VLVqSVjRXBl3j8Ryrwc9lEz5ska2BhihLDqzIruLss
 2J00+j3sY1MfA==
X-Virus-Scanned: amavis at zmailpro.com
Received: from zmailpro.com ([127.0.0.1])
 by localhost (zmailpro.com [127.0.0.1]) (amavis, port 10026) with ESMTP
 id e6ygw5cLSoNL for <amd-gfx@lists.freedesktop.org>;
 Tue,  9 Dec 2025 20:56:36 -0500 (EST)
Received: from zmailpro.com (zmailpro.com [174.129.240.60])
 by zmailpro.com (Postfix) with ESMTP id 8670B89E31B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 20:56:36 -0500 (EST)
Date: Tue, 9 Dec 2025 20:56:35 -0500 (EST)
From: Harris Landgarten <harrisl@lhjonline.com>
To: amd-gfx@lists.freedesktop.org
Message-ID: <1810124938.51173.1765331795979.JavaMail.zimbra@lhjonline.com>
Subject: =?utf-8?Q?Subject:_gfx1150_/_Radeon_890M_=E2=80=93_MES_s?=
 =?utf-8?Q?cheduler_wedge_under_sustained_compute_?=
 =?utf-8?Q?(Ring_13_stalls,_GPU_unrecoverable;_res?=
 =?utf-8?Q?et_triggers_power-off)_on_kernel-6.18.0?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [174.129.240.60]
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC144
 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Index: SKMl78hy58OFLA/DdFr9xVtEC4vWDw==
Thread-Topic: Subject: gfx1150 / Radeon 890M =?utf-8?B?4oCTIE1FUw==?=
 scheduler wedge under sustained compute (Ring 13 stalls, GPU unrecoverable;
 reset triggers power-off) on kernel-6.18.0
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

Hello AMD GPU team,

I am reporting a reproducible issue on Strix Point (gfx1150, Radeon 890M)
where the MES scheduler (Ring 13) wedges under sustained compute load.
Once this occurs, the GPU becomes unrecoverable from userspace, and the
system becomes unable to shut down cleanly. This happens reliably during
extended machine-learning training workloads.

Hardware / software environment:
--------------------------------
=E2=80=A2 GPU: Strix [Radeon 880M / 890M], PCI ID 1002:150e =20
=E2=80=A2 CPU: AMD Ryzen AI 9 HX 370 =20
=E2=80=A2 OS: Gentoo Linux (fully updated) =20
=E2=80=A2 Kernel: 6.18.0-gentoo-x86_64 =20
=E2=80=A2 linux-firmware version: linux-firmware-20251125_p20251203 =20
=E2=80=A2 GPU IFWI: 113-STRIXEMU-001, version 00107777 =20

Important notes about firmware authenticity:
--------------------------------------------
=E2=80=A2 The GPU firmware in the linux-firmware package is **unmodified AM=
D-
  provided firmware**. =20
=E2=80=A2 Gentoo does *not* patch amdgpu firmware=E2=80=94if it loaded succ=
essfully, it is
  the exact AMD-signed blob. =20
=E2=80=A2 All GPU firmware components load with valid signatures. =20
=E2=80=A2 There is a separate Gentoo CPU =E2=80=9Camd-ucode=E2=80=9D signat=
ure warning, but that is
  unrelated; GPU firmware loads cleanly. =20
=E2=80=A2 I am therefore already running the *exact* firmware AMD intends f=
or
  gfx1150. If a recent microcode or kernel fix was supposed to address
  MES issues, this confirms the problem persists.

Description of the failure:
---------------------------
After many hours of sustained GPU compute (deep-learning training),
The driver begins logging Ring 13 / MES errors. Once the first real-time
Scheduler message failure appears, the GPU quickly becomes unresponsive:

=E2=80=A2 amdgpu stops accepting messages =20
=E2=80=A2 Ring 13 reports "MES buffer full" and/or stops progressing =20
=E2=80=A2 display session dies and triggers emergency logout =20
=E2=80=A2 attempting to restart GDM usually causes an immediate reboot =20
=E2=80=A2 The system cannot complete a clean shutdown once MES is wedged =
=20

Critically, `amd-smi reset --gpureset -g 0` *almost* works=E2=80=94it reset=
s GFX
momentarily, GNOME becomes responsive for ~30 seconds, but the GPU then
forces a power-off shortly afterward. This suggests the MES block remains
in a corrupted state and cannot be reinitialized safely.

This behavior is consistent and fully reproducible under heavy compute.

`amd-smi` diagnostic data:
--------------------------
The following `amd-smi` outputs were captured **while training was running*=
*
(i.e., during a real workload, not idle). These represent true runtime
conditions rather than idle reporting.

Examples:

`amd-smi static -g all`:
  =E2=80=A2 correctly reports gfx1150, 16 CUs, 4096 MB VRAM, clocks, caches=
, etc.
  =E2=80=A2 IFWI package 113-STRIXEMU-001 v00107777 is present
  =E2=80=A2 firmware components (CP_PFP, CP_ME, MEC1, RLC, SDMA, VCN, ASD, =
PM)
    all load with valid versions

`amd-smi metric -g all`:
  =E2=80=A2 reports training-phase VRAM usage (approx. 2.4 GB of 4 GB)
  =E2=80=A2 temperatures are normal
  =E2=80=A2 most advanced metrics for this iGPU are "N/A"
  =E2=80=A2 system fully responsive before the wedge

`amd-smi list -g all`:
  =E2=80=A2 GPU 0 at BDF 0000:c5:00.0 with UUID 00ff150e-0000-1000-8000-000=
000000000

Impact:
-------
Once Ring 13 wedges, the GPU cannot:
=E2=80=A2 process new compute work =20
=E2=80=A2 process display work reliably =20
=E2=80=A2 accept amdgpu reset =20
=E2=80=A2 shut the system down cleanly =20

This appears to be a MES firmware or driver scheduling issue specific to
gfx1150 under long-duration compute loads.

What I can provide:
-------------------
=E2=80=A2 Full logs including `dmesg`, journal slices, and fence dump snaps=
hots =20
=E2=80=A2 Exact reproduction steps (training runs 10=E2=80=9320 hours, alwa=
ys reproduces) =20
=E2=80=A2 Willingness to test:
    =E2=80=93 patched kernels
    =E2=80=93 updated MES firmware
    =E2=80=93 new linux-firmware bundles
    =E2=80=93 debug patches or instrumentation =20
=E2=80=A2 Any additional diagnostic commands you require =20

Please let me know what additional information would be most useful.

Thank you for your time, and I=E2=80=99m happy to assist further with debug=
ging
gfx1150 stability under sustained compute load.

https://bugs.gentoo.org/967078 references this issue with attachments

Harris Landgarten
516 643-1286
