Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C43C71136
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 16:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E03D10EA36;
	Fri, 13 Jun 2025 16:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=r26.me header.i=@r26.me header.b="XQAIh+u2";
	dkim-atps=neutral
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A190710E402
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jun 2025 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r26.me;
 s=protonmail3; t=1749478981; x=1749738181;
 bh=JQSxPuSgebu8ngU9w0fbtaPNsN1gzZlPt15SLF4hvf4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=XQAIh+u2WdmTWrdVozzGrqHM0fzEeqw3KYJcnwJOqCl9oit4MkOjRsfZ/ZlmmPSEb
 B2rsNhQsOYpc4P6b7htniepsKAGvdHS7JKFrBs8VkQMrEtZ7Gxb/DsnjijvccwJGmU
 joOaaJlA6o8pejq8QE0SWVh22W5TB3kc8zyEdVPMX0Re7H5L+iV7HR2tlWXwUt4I96
 WLnfgkQ7h2Cko+TVb+F1apq2iIQKEQqX1CKX0Y7r43H+9TVCNR4AVPYLJMWVVn67p2
 YAnhuUIauz5ZLH1SFVMy6M4IZ103fw8QyveXPVX8vnIKcrAkHtiGSKMvHoMgL/jA1y
 VedWy3z4w1bMg==
Date: Mon, 09 Jun 2025 14:22:55 +0000
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Rio Liu <rio@r26.me>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [REGRESSION] amdgpu fails to load external RX 580 since PCI:
 Allow relaxed bridge window tail sizing for optional resources
Message-ID: <w3gGcmhWNmeGetzLnhgkjfx0JTEyIOKN5sDu-uShZ_7JWthMgGP6plgDuhDbkYyaA7vtGbdl1WbMTZ5zM80OyJoqUa69krqDpuhqDangkLY=@r26.me>
In-Reply-To: <7a7a3619-902c-06ee-6171-6d8ec2107f97@linux.intel.com>
References: <o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NOzOW1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=@r26.me>
 <7a7a3619-902c-06ee-6171-6d8ec2107f97@linux.intel.com>
Feedback-ID: 77429777:user:proton
X-Pm-Message-ID: 9e591caaea3c8cdf34da3a0674d87646d7d67758
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 13 Jun 2025 16:05:52 +0000
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

On Monday, June 9th, 2025 at AM 5:09, Ilpo J=C3=A4rvinen <ilpo.jarvinen@lin=
ux.intel.com> wrote:

>=20
>=20
> On Mon, 9 Jun 2025, rio@r26.me wrote:
>=20
> > Hello,
> >=20
> > I have an external Radeon RX580 on my machine connected via Thunderbolt=
, and
> > since upgrading from 6.14.1 the setup stopped working. Dmesg showed war=
ning from
> > resource sanity check, followed by a stack trace https://pastebin.com/n=
jR55rQW.
> > Relevant snippet:
> >=20
> > [ 12.134907] amdgpu 0000:06:00.0: BAR 2 [mem 0x6000000000-0x60001fffff =
64bit pref]: releasing
> > [ 12.134910] [drm:amdgpu_device_resize_fb_bar [amdgpu]] ERROR Problem r=
esizing BAR0 (-16).
> > [ 12.135456] amdgpu 0000:06:00.0: BAR 2 [mem 0x6000000000-0x60001fffff =
64bit pref]: assigned
> > [ 12.135524] amdgpu 0000:06:00.0: amdgpu: VRAM: 8192M 0x000000F40000000=
0 - 0x000000F5FFFFFFFF (8192M used)
> > [ 12.135527] amdgpu 0000:06:00.0: amdgpu: GART: 256M 0x000000FF00000000=
 - 0x000000FF0FFFFFFF
> > [ 12.135536] resource: resource sanity check: requesting [mem 0x0000000=
000000000-0xffffffffffffffff], which spans more than PCI Bus 0000:00 [mem 0=
x000a0000-0x000bffff window]
> > [ 12.135542] ------------[ cut here ]------------
> > [ 12.135543] WARNING: CPU: 6 PID: 599 at arch/x86/mm/pat/memtype.c:721 =
memtype_reserve_io+0xfc/0x110
> > [ 12.135551] Modules linked in: ccm amdgpu(+) snd_hda_codec_realtek ...
> > [ 12.135652] CPU: 6 UID: 0 PID: 599 Comm: (udev-worker) Tainted: G S 6.=
15.0-13743-g8630c59e9936 #16 PREEMPT(full) 3b462c924b3ffd8156fc3b77bcc8ddbf=
7257fa57
> > [ 12.135654] Tainted: [S]=3DCPU_OUT_OF_SPEC
> > [ 12.135655] Hardware name: COPELION INTERNATIONAL INC. ZX Series/ZX Se=
ries, BIOS 1.07.08TCOP3 03/27/2020
> > [ 12.135656] RIP: 0010:memtype_reserve_io+0xfc/0x110
> > [ 12.135659] Code: aa fb ff ff b8 f0 ff ff ff eb 88 8b 54 24 04 4c 89 e=
e 48 89 df e8 04 fe ff ff 85 c0 75 db 8b 54 24 04 41 89 16 e9 69 ff ff ff <=
0f> 0b e9 4b ff ff ff e8 b8 5c fc 00 0f 1f 84 00 00 00 00 00 90 90
> >=20
> > Bisecting the stable branch pointed me to the following commit:
> >=20
> > commit 22df32c984be9e9145978acf011642da042a2af3 (HEAD)
> > Author: Ilpo J=C3=A4rvinen ilpo.jarvinen@linux.intel.com
> > Date: Mon Dec 16 19:56:11 2024 +0200
> >=20
> > PCI: Allow relaxed bridge window tail sizing for optional resources
> >=20
> > [ Upstream commit 67f9085596ee55dd27b540ca6088ba0717ee511c ]
> >=20
> > I've tested on stable (as of now 8630c59e99363c4b655788fd01134aef9bcd92=
64), and
> > the issue persists. Reverting the offending commit via `git revert -n 2=
2df32c984be9e9145978acf011642da042a2af3` allowed amdgpu to load again.
> > Dmesg: https://pastebin.com/xd76rDsW.
> >=20
> > Additional information
> > - Distribution: Artix
> > - Arch: x86_64
> > - Kernel config: https://pastebin.com/DWSERJL5
> > - eGPU adapter: https://www.adt.link/product/R43SG-TB3.html
> > - Booting with pci=3Drealloc,hpbussize=3D0x33,hpmmiosize=3D256M,hpmmiop=
refsize=3D1G
> >=20
> > I'm reporting here as these are the contacts from the commit message.
> > Please let me know if there's a more appropriate place for this, as wel=
l
> > as any more information I can provide.
>=20
>=20
> Hi Rio,
>=20
> Thanks for the report and I'm sorry about causing this issue. Could you
> please try if the patch below solves the issue.
>=20
> --
> From b94823a193032b5f87114cff9e8edc5c67e4ef40 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D ilpo.jarvinen@linux.inte=
l.com
>=20
> Date: Mon, 9 Jun 2025 12:05:20 +0300
> Subject: [PATCH 1/1] PCI: Relaxed alignment should never increase min_ali=
gn
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> When using relaxed tail alignment for the bridge window,
> pbus_size_mem() also tries to minimize min_align, which can under
> certain scenarios end up increasing min_align from that found by
> calculate_mem_align().
>=20
> Ensure min_align is not increased by the relaxed tail alignment.
>=20
> Eventually, it would be better to add calculate_relaxed_head_align()
> similar to calculate_mem_align() which finds out what alignment can be
> used for the head without introducing any gaps into the bridge window
> to give flexibility on head address too. But that looks relatively
> complex algorithm so it requires much more testing than fixing the
> immediate problem causing a regression.
>=20
> Reported-by: Rio rio@r26.me
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen ilpo.jarvinen@linux.intel.com
>=20
> ---
> drivers/pci/setup-bus.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 07c3d021a47e..f90d49cd07da 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1169,6 +1169,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsig=
ned long mask,
> resource_size_t children_add_size =3D 0;
> resource_size_t children_add_align =3D 0;
> resource_size_t add_align =3D 0;
> + resource_size_t relaxed_align;
>=20
> if (!b_res)
> return -ENOSPC;
> @@ -1246,8 +1247,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsig=
ned long mask,
> if (bus->self && size0 &&
>=20
> !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
> size0, min_align)) {
> - min_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> - min_align =3D max(min_align, win_align);
> + relaxed_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> + relaxed_align =3D max(relaxed_align, win_align);
> + min_align =3D min(min_align, relaxed_align);
> size0 =3D calculate_memsize(size, min_size, 0, 0, resource_size(b_res), w=
in_align);
> pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignment =
rules\n",
>=20
> b_res, &bus->busn_res);
>=20
> @@ -1261,8 +1263,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsig=
ned long mask,
> if (bus->self && size1 &&
>=20
> !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
> size1, add_align)) {
> - min_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> - min_align =3D max(min_align, win_align);
> + relaxed_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> + relaxed_align =3D max(min_align, win_align);
> + min_align =3D min(min_align, relaxed_align);
> size1 =3D calculate_memsize(size, min_size, add_size, children_add_size,
> resource_size(b_res), win_align);
> pci_info(bus->self,
>=20
>=20
> base-commit: 3719a04a80caf660f899a462cd8f3973bcfa676e
> --
> 2.39.5

Hello Ilpo,

I've tested the patch and it seems to fix the issue. Thank you!

Rio Liu
