Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9578FF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 16:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48BD110EBDB;
	Tue, 28 Apr 2026 16:53:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=xwax.org header.i=@xwax.org header.b="clXwujdL";
	dkim-atps=neutral
Received: from disco.pogo.org.uk (disco.pogo.org.uk [93.93.128.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A1D10EBDB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xwax.org;
 s=swing; h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:
 Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description; bh=pkC0TMhSk8sVwi6d06/aJ6hWhX0USnbqNfZ0R99DDAI=; b=clXwu
 jdLyHFdjvnOK8oMmnB72XcX6Yg5KIMjKTQX80ixUYWKKiAvKqAndERF6MAJn0/lAL0smAyu+ekoyq
 RWZKrwDuUoHCn85wfKZ7KgKrrJtsKmcH55dbxy+icchiQCziby3CtehIDm5pUPm5dMcMPFp3A39ez
 obkATJWFNBMk=;
Received: from cpc93786-hari17-2-0-cust786.20-2.cable.virginm.net
 ([82.36.99.19] helo=tamla)
 by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.2 (FreeBSD)) (envelope-from <mark@xwax.org>)
 id 1wHlgu-000000001cB-0Le5; Tue, 28 Apr 2026 17:53:44 +0100
Received: from localhost (tamla.pogo.org.uk [local])
 by tamla.pogo.org.uk (OpenSMTPD) with ESMTPA id e1092892;
 Tue, 28 Apr 2026 17:53:42 +0100 (BST)
Date: Tue, 28 Apr 2026 17:53:42 +0100 (BST)
From: Mark Hills <mark@xwax.org>
To: Alex Deucher <alexdeucher@gmail.com>
cc: amd-gfx@lists.freedesktop.org
Subject: Re: Radeon Pro WX7100 regression since v6.19, no display
In-Reply-To: <CADnq5_Px_vh0OLLjT9vohcp07yK9m_5NNLPvHz=KMfo564gJTQ@mail.gmail.com>
Message-ID: <b9eae938-a558-8614-7fea-aa25cceea3f1@xwax.org>
References: <832b0927-fff2-90b3-538c-8e1890f3f42c@xwax.org>
 <CADnq5_Px_vh0OLLjT9vohcp07yK9m_5NNLPvHz=KMfo564gJTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=0894690600177739522214211
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0894690600177739522214211
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 Apr 2026, Alex Deucher wrote:

> On Tue, Apr 28, 2026 at 7:44=E2=80=AFAM Mark Hills <mark@xwax.org> wrote:
> >
> > The last kernel I have been able to use is v6.19.3, because shortly aft=
er
> > I lose functionality of my Radeon Pro WX7100.
> >
> > Normally around the point udevd is run, I see a switch from "BIOS"-styl=
e
> > console to some kind of framebuffer one, followed by launching Xorg.
> >
> > With later kernels, around the time of udevd the displays (LG DualUp,
> > DisplayPort) freeze and swich to "no signal". The host is alive to SSH.
[...]
> Looks like you built your kernel without CONFIG_DRM_AMD_DC=3Dy.  That is
> necessary for the display hardware support to be built into your
> kernel.  7.0.x dropped support for the old legacy display support
> since it's deprecated for years and has much less functionality
> compared to DC.

Thanks, guess I'm behind the times by assuming a GPU implies there=20
is some display hardware :-)

More seriously, I carried the .config forward and so probably carried=20
these defaults. I note that /dev/fb0 was a red-herring as this was never=20
present. FWIW it was pre 7.0 that it stopped working.

But yes, that fixed the problem. Thank you.

The new dmesg is below for reference. I note that there is no longer any=20
conector information, but I expect this is intended.

--=20
Mark


$ dmesg | cut -c 16-1000 | grep -E '(amdgpu|drm|fb|fbcon)'
Command line: root=3D/dev/sda2 fbcon=3Drotate_all:1 BOOT_IMAGE=3Dvmlinuz=20
Kernel command line: root=3D/dev/sda2 fbcon=3Drotate_all:1 BOOT_IMAGE=3Dvml=
inuz=20
Unknown kernel command line parameters "fbcon=3Drotate_all:1", will be pass=
ed to user space.
pci 0000:00:1c.4:   bridge window [mem 0xefb00000-0xefbfffff]
pci 0000:0b:00.0: BAR 0 [mem 0xefb00000-0xefb03fff 64bit]
pci 0000:00:1c.4:   bridge window [mem 0xefb00000-0xefbfffff]
pci_bus 0000:0b: resource 1 [mem 0xefb00000-0xefbfffff]
    fbcon=3Drotate_all:1
ACPI: bus type drm_connector registered
amdgpu 0000:01:00.0: initializing kernel modesetting (POLARIS10 0x1002:0x67=
C4 0x1002:0x0B0D 0x00).
amdgpu 0000:01:00.0: register mmio base: 0xEFE00000
amdgpu 0000:01:00.0: register mmio size: 262144
amdgpu 0000:01:00.0: detected ip block number 0 <common_v1_0_0> (vi_common)
amdgpu 0000:01:00.0: detected ip block number 1 <gmc_v8_1_0> (gmc_v8_0)
amdgpu 0000:01:00.0: detected ip block number 2 <ih_v3_0_0> (tonga_ih)
amdgpu 0000:01:00.0: detected ip block number 3 <gfx_v8_0_0> (gfx_v8_0)
amdgpu 0000:01:00.0: detected ip block number 4 <sdma_v3_1_0> (sdma_v3_0)
amdgpu 0000:01:00.0: detected ip block number 5 <smu_v1_0_0> (powerplay)
amdgpu 0000:01:00.0: detected ip block number 6 <dce_v1_0_0> (dm)
amdgpu 0000:01:00.0: detected ip block number 7 <uvd_v6_3_0> (uvd_v6_0)
amdgpu 0000:01:00.0: detected ip block number 8 <vce_v3_4_0> (vce_v3_0)
amdgpu 0000:01:00.0: No more image in the PCI ROM
amdgpu 0000:01:00.0: Fetched VBIOS from ROM BAR
amdgpu 0000:01:00.0: [drm] ATOM BIOS: 113-C9540101-103
amdgpu 0000:01:00.0: [drm] UVD is enabled in VM mode
amdgpu 0000:01:00.0: [drm] UVD ENC is enabled in VM mode
amdgpu 0000:01:00.0: Found VCE firmware Version: 53.26 Binary ID: 3
amdgpu 0000:01:00.0: [drm] VCE enabled in VM mode
amdgpu 0000:01:00.0: vgaarb: deactivate vga console
amdgpu 0000:01:00.0: Trusted Memory Zone (TMZ) feature not supported
amdgpu 0000:01:00.0: vm size is 128 GB, 2 levels, block size is 10-bit, fra=
gment size is 9-bit
amdgpu 0000:01:00.0: System can't access extended configuration space, plea=
se check!!
amdgpu 0000:01:00.0: VRAM: 8192M 0x000000F400000000 - 0x000000F5FFFFFFFF (8=
192M used)
amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=3D8192M, BAR=3D256M
amdgpu 0000:01:00.0: [drm] RAM width 256bits GDDR5
amdgpu 0000:01:00.0:  8192M of VRAM memory ready
amdgpu 0000:01:00.0:  20047M of GTT memory ready.
amdgpu 0000:01:00.0: [drm] GART: num cpu pages 65536, num gpu pages 65536
amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F400=
900000).
amdgpu 0000:01:00.0: [drm] Chained IB support enabled!
amdgpu: hwmgr_sw_init smu backed is polaris10_smu
amdgpu 0000:01:00.0: [drm] Found UVD firmware Version: 1.130 Family ID: 16
amdgpu 0000:01:00.0: [drm] Display Core v3.2.369 initialized on DCE 11.2
amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
amdgpu 0000:01:00.0: SE 4, SH per SE 1, CU per SH 9, active_cu_number 36
amdgpu 0000:01:00.0: Using BACO for runtime pm
[drm] Initialized amdgpu 3.64.0 for 0000:01:00.0 on minor 0
fbcon: amdgpudrmfb (fb0) is primary device
amdgpu 0000:01:00.0: [drm] fb0: amdgpudrmfb frame buffer device
--0894690600177739522214211--
