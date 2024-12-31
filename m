Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE8BE77194
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Dec 2024 10:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D7310E641;
	Tue, 31 Dec 2024 10:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=slash.cl header.i=@slash.cl header.b="IQt/fWKq";
	dkim-atps=neutral
X-Greylist: delayed 344 seconds by postgrey-1.36 at gabe;
 Tue, 31 Dec 2024 05:53:55 UTC
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70BDD10E17A
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Dec 2024 05:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=slash.cl;
 s=protonmail; t=1735624087; x=1735883287;
 bh=WrI1gq56mtL3OM8vk1b2QKbwqTggWjJB+35usOKT7bk=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=IQt/fWKqkefKnCdqxlZTQXldsTvgve9Nwgq5pFXJJQAePhAkc3GsC3RXyl6Ua00Ai
 kDI4tNy0FX5x7G7mcxI6xkrCjtwmD4UFSQm6yAu46rW1cwPre+Aa2h0tLS/PTfR/Oq
 aetv74+v/n0nZo+Y6OWwpblv3A9aKiDmyn4YDA2dF7BZ7OY+A7q30VQj0BEB/CVjzd
 OWwuwx1qSs/T8Jbba6JuMXC3EiWlX5qBkwDKqMejg3olFpYS0bGhEMp8dD20eiua1P
 kGiLukc5xAPdp4pubgx4Za1wDFVrJNwa8CIX6xgjJP+kXlf+NlDXyySwGttgjtz1w3
 5hMupAA77jbjA==
Date: Tue, 31 Dec 2024 05:48:01 +0000
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: WalterCool <waltercool@slash.cl>
Subject: Question regarding to ROCM and removable GPUs
Message-ID: <f8WL4KnjmYpr0FjFp-smhNOpcL_mlmVBPMx_587jjWuesiuvxRZP6xI_PjoKJ79MD--cDlL8geLycJij-kopopaIdar5P197eDSdToi_vZc=@slash.cl>
Feedback-ID: 8489026:user:proton
X-Pm-Message-ID: acad6aad0af0fa941316c02e3495808afe1e93e9
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 31 Dec 2024 10:35:23 +0000
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

Hi everyone,

I have a Framework 16 laptop with dGPU extension, as you may know, that mea=
ns it uses Radeon 780M iGPU and Radeon RX 7700S dGPU.

Something I noticed, after I virtually remove RX 7700S for VM applications =
(vfio-pci), it breaks the entire ROCM feature... making ROCM apps to not de=
tect anything, not even iGPU. Re-attaching 7700S doesn't resolve the proble=
m.

> $ rocminfo=20
> ROCk module is loaded
> Unable to open /dev/kfd read-write: Invalid argument
> waltercool is member of render group

When using LMStudio for example, by default both ROCM and OpenCL backends w=
ork fine, if I remove my GPU (and later re-attach to host), only OpenCL wil=
l work.

Applications like ollama or ComfyUI will fail after dGPU is detached, using=
 "amdgpu_gpu_recover" does not resolve the issue.

Any ideas how to recover KFD/ROCM functionality after I detach my GPU?

Q: How do you detach your GPU?
A: /sys/bus/pci/devices/${GPU_VIDEO/GPU_AUDIO}/driver/unbind or /sys/module=
/amdgpu/drivers/pci\:amdgpu/unbind

Q: How do you reattach your GPU?
A: Remove device (/sys/bus/pci/devices/${GPU_VIDEO/GPU_AUDIO}/remove), then=
 PCI rescan.

Kind regards.

--
WalterCool

Sent with Proton Mail secure email.
