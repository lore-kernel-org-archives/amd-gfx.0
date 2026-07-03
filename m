Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D6EC44501
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2026 15:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC0B10E6D9;
	Sat,  4 Jul 2026 15:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="ChWOzd1I";
	dkim-atps=neutral
X-Greylist: delayed 309 seconds by postgrey-1.36 at gabe;
 Fri, 03 Jul 2026 12:49:21 UTC
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFF810E5E3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 12:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1783082959; x=1783687759; i=spasswolf@web.de;
 bh=WEtXfoqWT8u7TfvcGQ6O9maQtegVSFyhpY9XCAZTjiM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ChWOzd1IWHw1Ps1bpZxjv+iGL7xMZXROogEEtMeQ3Glft/A73t9vPD7yJGp25CvL
 Lc+BsKgVchM2/Xa1U9hQOQ9HXUnFOBadNGJqzm5VrFySjUV18KLQ2Enj9ECRCWcyW
 zP2bQCCFzQIde5I2NEVoizfcPrjNYz3axhMLEEaRy0689kahacnlJ3Mn2iBt0Tbfr
 Au4gKmizsEkdZg/wpAluftTw0+B0s2Emf4zHhN5+PGcxw8H9vigsI3OHDg6TSkqg7
 kZVnKHIvZLox3xs+HwKefZqNnO425ljC6Q7euBwiK71H53CN9ExAhWMDGbBwS3d8p
 ltwYOhjFZa9+LsVnmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3GgY-1x5NJM36Bu-00sGpr; Fri, 03
 Jul 2026 14:44:06 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-next@vger.kernel.org,
 Jesse Zhang <jesse.zhang@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: GPU reset when running the ROCm hsa runtime tests on gfx12 and
 next-20260701
Date: Fri,  3 Jul 2026 14:44:03 +0200
Message-ID: <20260703124405.56248-1-spasswolf@web.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MdgM1gHWnnqABmfITQOcZ7/JkUOH9lnunASZUuddm4UxiLJQ6oy
 r3lxtEyOzXXzrAoEKv7KZ3Gt4Sz0k+tafN/SYhRLbIQrDzLZ0SITahGhtTRAdUArcO29vWA
 wTfoz137iu40xliEzwFmjiJDBvUdDiBBlQXklfaBIRogoRYStSbJLPen6LpaGY/Z9j63AjA
 E+rzQQY6zfCj8NVD+3F2A==
UI-OutboundReport: notjunk:1;M01:P0:/EaTLjzLIsI=;hyznk6OdB2TrNwTljif11YOhFn8
 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
 phV9xg==
X-Mailman-Approved-At: Sat, 04 Jul 2026 15:40:15 +0000
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

When running the ROCm hsa selftests on debian unstable (with ROCm packages=
 from experimental)
with linux next-20260701, the GPU will reset with the following error mess=
age:

$ /usr/libexec/rocm/libhsa-runtime64-tests/run-tests

[ T2548] amdgpu 0000:03:00.0: failed to suspend gangs from MES
[ T2548] amdgpu 0000:03:00.0: MES might be in unrecoverable state, issue a=
 GPU reset
[  T360] amdgpu 0000:03:00.0: GPU reset begin!. Source:  3
[T28252] amdgpu 0000:03:00.0: Failed to evict queue 0
[T28252] amdgpu: Failed to quiesce KFD
[  T360] amdgpu 0000:03:00.0: Dumping IP State
[  T360] amdgpu 0000:03:00.0: Dumping IP State Completed
[  T360] amdgpu 0000:03:00.0: MODE1 reset
[  T360] amdgpu 0000:03:00.0: GPU mode1 reset
[  T360] amdgpu 0000:03:00.0: GPU smu mode1 reset
[  T360] amdgpu 0000:03:00.0: GPU reset succeeded, trying to resume
[drm] PCIE GART of 512M enabled (table at 0x00000083DAB00000).
[drm] AMDGPU device coredump file has been created
[drm] Check your /sys/class/drm/card0/device/devcoredump/data
[  T360] amdgpu 0000:03:00.0: VRAM is lost due to GPU reset!
[  T360] amdgpu 0000:03:00.0: PSP is resuming...
[  T360] amdgpu 0000:03:00.0: RAS: optional ras ta ucode is not available
[  T360] amdgpu 0000:03:00.0: RAP: optional rap ta ucode is not available
[  T360] amdgpu 0000:03:00.0: SECUREDISPLAY: optional securedisplay ta uco=
de is not available
[  T360] amdgpu 0000:03:00.0: SMU is resuming...
[  T360] amdgpu 0000:03:00.0: SMU is resumed successfully!
[  T360] amdgpu 0000:03:00.0: program CP_MES_CNTL : 0x4000000
[  T360] amdgpu 0000:03:00.0: program CP_MES_CNTL : 0xc000000
[drm] DMUB hardware initialized: version=3D0x00010300
[  T360] amdgpu 0000:03:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[  T360] amdgpu 0000:03:00.0: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[  T360] amdgpu 0000:03:00.0: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[  T360] amdgpu 0000:03:00.0: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[  T360] amdgpu 0000:03:00.0: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[  T360] amdgpu 0000:03:00.0: ring sdma0 uses VM inv eng 9 on hub 0
[  T360] amdgpu 0000:03:00.0: ring sdma1 uses VM inv eng 10 on hub 0
[  T360] amdgpu 0000:03:00.0: ring vcn_unified_0 uses VM inv eng 0 on hub =
8
[  T360] amdgpu 0000:03:00.0: ring jpeg_dec uses VM inv eng 1 on hub 8
[  T360] amdgpu 0000:03:00.0: GPU reset(1) succeeded!
[drm] device wedged, but no recovery needed
[ T2050] amdgpu 0000:03:00.0: VM memory stats for proc xfwm4(2105) task xf=
wm4:cs0(2050) is non-zero when fini
[ T1932] amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non=
-zero when fini
[ T2293] amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non=
-zero when fini
[ T1929] amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non=
-zero when fini
[ T1930] amdgpu 0000:03:00.0: VM memory stats for proc (0) task (0) is non=
-zero when fini
[ T2263] amdgpu 0000:03:00.0: VM memory stats for proc firefox-esr(3483) t=
ask firefox-es:cs0(2263) is non-zero when fini
[ T3590] amdgpu 0000:03:00.0: VM memory stats for proc RDD Process(4755) t=
ask firefox-es:cs0(3590) is non-zero when fini
[ T1469] amdgpu 0000:03:00.0: VM memory stats for proc Xorg(1495) task Xor=
g:cs0(1469) is non-zero when fini


As this does not occur on v7.2-rc1 I bisected the issue and found
commit f94bbd648bb4 ("drm/amdgpu: use a single entry point for mes compute=
 reset")
as responsible.
Unfortunately the does not revert cleanly in linux-next-20260701, so I had=
 to revert these
commits to fix the issue in next-20260701:

b789664e3e30 ("drm/amdkfd: Clean up suspend_all and resume_all mes")
a665d09b10af ("drm/amdkfd: Pass known bad queue info to reset")
a4e4d945cba8 ("drm/amdgpu/gfx: defer per-queue helper_end until after MES =
resume")
f401a2633e02 ("drm/amdgpu: Remove faulty queue before resume")
f94bbd648bb4 ("drm/amdgpu: use a single entry point for mes compute reset"=
)

GPU used:
03:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AM=
D/ATI] Navi 44 [Radeon RX 9060 XT] [1002:7590] (rev c0)
CPU used:
model name	: AMD Ryzen 9 9950X 16-Core Processor

Installed ROCm packages (from debian experimental)

bert@homer:~$ dpkg -l | grep 7.2.4
ii  hip-utils                                                        7.2.4=
-1~exp1                             amd64        utilities for HIP languag=
e development
ii  hipcc                                                            7.2.4=
+dfsg-1~exp1                        amd64        C++ Runtime API and Kerne=
l Language for AMD and NVIDIA GPUs
ii  libamd-comgr-dev                                                 7.2.4=
+dfsg-1~exp1                        amd64        ROCm code object manager =
- development package
ii  libamd-comgr3:amd64                                              7.2.4=
+dfsg-1~exp1                        amd64        ROCm code object manager
ii  libamdhip64-7:amd64                                              7.2.4=
-1~exp1                             amd64        HIP runtime for AMD GPUs =
- library
ii  libamdhip64-dev                                                  7.2.4=
-1~exp1                             amd64        HIP runtime for AMD GPUs =
- headers
ii  libhiprtc-builtins7:amd64                                        7.2.4=
-1~exp1                             amd64        HIP runtime compilation l=
ibrary - builtins
ii  libhiprtc7:amd64                                                 7.2.4=
-1~exp1                             amd64        HIP runtime compilation l=
ibrary
ii  libhsa-runtime-dev:amd64                                         7.2.4=
+dfsg-1~exp1                        amd64        HSA Runtime API and runti=
me for ROCm - development files
ii  libhsa-runtime64-1:amd64                                         7.2.4=
+dfsg-1~exp1                        amd64        HSA Runtime API and runti=
me for ROCm
ii  libhsa-runtime64-tests                                           7.2.4=
+dfsg-1~exp1                        amd64        HSA Runtime test suites f=
or ROCm
ii  librocblas-dev                                                   7.2.4=
-1~exp1                             amd64        ROCm library for basic li=
near algebra - headers
ii  librocblas-doc                                                   7.2.4=
-1~exp1                             all          ROCm library for basic li=
near algebra - documentation
ii  librocblas5                                                      7.2.4=
-1~exp1                             amd64        ROCm library for basic li=
near algebra - library
ii  librocblas5-bench                                                7.2.4=
-1~exp1                             amd64        ROCm library for basic li=
near algebra - benchmarks
ii  librocblas5-tests                                                7.2.4=
-1~exp1                             amd64        ROCm library for basic li=
near algebra - tests
ii  librocblas5-tests-data                                           7.2.4=
-1~exp1                             all          ROCm library for basic li=
near algebra - test data
ii  librocm-core-dev                                                 7.2.4=
-1~exp1                             amd64        provides methods to get i=
nformation about installed ROCm - headers
ii  librocm-core1                                                    7.2.4=
-1~exp1                             amd64        provides methods to get i=
nformation about installed ROCm
ii  librocm-smi64-7                                                  7.2.4=
-1~exp1                             amd64        ROCm System Management In=
terface (ROCm SMI) library
ii  librocsolver-dev                                                 7.2.4=
-1~exp1                             amd64        ROCm library for numerica=
l linear algebra - headers
ii  librocsolver0                                                    7.2.4=
-1~exp1                             amd64        ROCm library for numerica=
l linear algebra - library
ii  librocsolver0-tests                                              7.2.4=
-1~exp1                             amd64        ROCm library for numerica=
l linear algebra - tests
ii  libroctx64-4                                                     7.2.4=
-1~exp1                             amd64        ROCm library for profiler=
 annotations - library
ii  rocm-device-libs-22                                              7.2.4=
+dfsg-1~exp1                        amd64        AMD specific device-side =
language runtime libraries
ii  rocm-opencl-icd:amd64                                            7.2.4=
-1~exp1                             amd64        AMD ROCm implementation o=
f the OpenCL API - ICD runtime
ii  rocminfo                                                         7.2.4=
-1~exp1                             amd64        ROCm Application for Repo=
rting System Info


Bert Karwatzki
   =20
