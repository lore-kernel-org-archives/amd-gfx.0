Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A659EFCE57
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 02:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2176F10E1E1;
	Thu,  5 Mar 2026 02:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=deeplearntech.com header.i=@deeplearntech.com header.b="RFn+kKH0";
	dkim-atps=neutral
X-Greylist: delayed 522 seconds by postgrey-1.36 at gabe;
 Thu, 05 Mar 2026 02:19:52 UTC
Received: from zmailpro.com (zmailpro.com [174.129.240.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE8110E1E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 02:19:52 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by zmailpro.com (Postfix) with ESMTP id 7D70D8AF837;
 Wed,  4 Mar 2026 21:11:09 -0500 (EST)
Received: from zmailpro.com ([127.0.0.1])
 by localhost (zmailpro.com [127.0.0.1]) (amavis, port 10032) with ESMTP
 id P4PrmCmGE8lQ; Wed,  4 Mar 2026 21:11:08 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by zmailpro.com (Postfix) with ESMTP id 71E098AF838;
 Wed,  4 Mar 2026 21:11:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmailpro.com 71E098AF838
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeplearntech.com;
 s=E11F0DAC-414D-11E7-97F0-308B22DE3479; t=1772676668;
 bh=FUs1QTMSapz7Ac+MSggPpyALvxbJxVsmSnIkEwE4JE4=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=RFn+kKH0xkOvE3tZ3Z86hN47F7o2IJEKbEYJny/cVW9PBGGnISijOnU/OfqIxC+xA
 dcg7N7fzAYr+pKc71C5C4F7BPCSCZvqCJRyaXTeaZne43BFRSdsbHy7JcpUYltdsnb
 01rT1BQDeHwpAjJQ7omvVgnH72/XzefXZ7ylVCeR8kBCXTdZuoWNTyUC/jTeVThs6M
 N6xS3nhqmwvTc6XbS2nweUrKVtONjtLKC3Pkf2Zuh2wIIIAfuTMcf5OfeqpQ7FGwAd
 tu7jWQCnv0RQaOGdjZjhzUl1TV0nIFWJb3OpMIjgb1DCAVTS3rEqvVAUi9AomyAYuj
 Jlq66GLQGSFwQ==
X-Virus-Scanned: amavis at zmailpro.com
Received: from zmailpro.com ([127.0.0.1])
 by localhost (zmailpro.com [127.0.0.1]) (amavis, port 10026) with ESMTP
 id tnXd1SeIrrrJ; Wed,  4 Mar 2026 21:11:08 -0500 (EST)
Received: from zmailpro.com (zmailpro.com [174.129.240.60])
 by zmailpro.com (Postfix) with ESMTP id 53D208AF837;
 Wed,  4 Mar 2026 21:11:08 -0500 (EST)
Date: Wed, 4 Mar 2026 21:11:07 -0500 (EST)
From: Harris Landgarten <harrisl@deeplearntech.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
Cc: alexander deucher <alexander.deucher@amd.com>
Message-ID: <418525920.108982.1772676667882.JavaMail.zimbra@lhjonline.com>
Subject: critical bug amdgpu hard reboot after amd-smi reset --gpureset on
 Strix Point (Radeon 890M)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [174.129.240.60]
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC146
 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Index: +zSCaUzFLnTFmBDrLhiaUTpFzbaNQw==
Thread-Topic: critical bug amdgpu hard reboot after amd-smi reset --gpureset
 on Strix Point (Radeon 890M)
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

Hello,

System:

Host: beelink2

Kernel: 7.0.0-rc2-x86_64 #1 SMP PREEMPT_DYNAMIC Sun Mar 1 19:54:38 EST 2026

CPU/GPU: AMD Ryzen AI 9 HX 370 / Radeon 890M (Strix Point)

GPU PCI ID: 1002:150e

Firmware: Beelink T305 BIOS

sys-kernel/linux-firmware-20260221

dev-util/amdsmi-7.1.1

Kernel configuration: PREEMPT_DYNAMIC

Problem:

Running the following command causes the system to hard crash and immediate=
ly reboot:

amd-smi reset --gpureset
This behaves like a sudden power loss. In some cases the machine will not r=
estart cleanly until power is physically removed.

This issue has been occurring for some time on 6.18 and 6.19 kernels, but w=
ith 7.0-rc2 I was able to capture the failure sequence in the journal befor=
e the crash.

Reproduction:

Boot normally into GNOME Wayland.

Run the command as root:

amd-smi reset --gpureset
The GPU reset begins but the system crashes shortly afterward.

Journal excerpt:

Mar 01 20:04:24 beelink2 doas[7188]: harrisl ran command amd-smi reset --gp=
ureset as root from /home/harrisl
Mar 01 20:04:24 beelink2 kernel: amdgpu 0000:c5:00.0: GPU reset begin!. Sou=
rce:  5
Mar 01 20:04:24 beelink2 kernel: amdgpu 0000:c5:00.0: MODE2 reset
Mar 01 20:04:24 beelink2 kernel: amdgpu 0000:c5:00.0: GPU reset succeeded, =
trying to resume
Mar 01 20:04:24 beelink2 kernel: amdgpu 0000:c5:00.0: [drm] PCIE GART of 51=
2M enabled (table at 0x0000008000900000).
Mar 01 20:04:24 beelink2 kernel: amdgpu 0000:c5:00.0: SMU is resuming...
Mar 01 20:04:24 beelink2 kernel: amdgpu 0000:c5:00.0: SMU is resumed succes=
sfully!
Mar 01 20:04:28 beelink2 kernel: amdgpu 0000:c5:00.0: SMU: No response msg_=
reg: 31 resp_reg: 0
Mar 01 20:04:28 beelink2 kernel: in params:00000000
Mar 01 20:04:28 beelink2 kernel: amdgpu 0000:c5:00.0: Failed to power ungat=
e VPE!
Mar 01 20:04:28 beelink2 kernel: amdgpu 0000:c5:00.0: [drm] *ERROR* DPM ena=
ble vpe failed, ret =3D -62.
Mar 01 20:04:30 beelink2 kernel: amdgpu 0000:c5:00.0: failed to load ucode =
VPE(0x42)
Mar 01 20:04:30 beelink2 kernel: amdgpu 0000:c5:00.0: psp gfx command LOAD_=
IP_FW(0x6) failed and response status is (0x0)
Mar 01 20:04:30 beelink2 kernel: amdgpu 0000:c5:00.0: resume of IP block <v=
pe_v6_1> failed -22
Mar 01 20:04:30 beelink2 kernel: amdgpu 0000:c5:00.0: GPU reset end with re=
t =3D -22
Mar 01 20:04:32 beelink2 kernel: amdgpu 0000:c5:00.0: SMU: No response msg_=
reg: 31 resp_reg: 0
Mar 01 20:04:32 beelink2 kernel: in params:00000000
Mar 01 20:04:32 beelink2 kernel: amdgpu 0000:c5:00.0: Failed to power gate =
VCN instance 0!
Mar 01 20:04:32 beelink2 kernel: amdgpu 0000:c5:00.0: [drm] *ERROR* DPM dis=
able vcn failed, ret =3D -62.
Immediately after this sequence the system performs a hard reset.

Firmware files present:

=EF=BF=BC
/lib/firmware/amdgpu/vpe_6_1_0.bin
/lib/firmware/amdgpu/vpe_6_1_1.bin
/lib/firmware/amdgpu/vpe_6_1_3.bin
Questions:

Is this a known issue with amd-smi --gpureset on Strix Point / Radeon 890M?

Does the failure of the VPE resume (vpe_v6_1) during the MODE2 reset sequen=
ce indicate a firmware issue or driver bug?

If needed I can provide:

full dmesg

lspci -nnk

complete journal logs from boot to crash

kernel config

Thanks,

Harris Landgarten
