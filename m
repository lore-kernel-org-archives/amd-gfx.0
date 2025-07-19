Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A85AC83F34
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Jul 2025 23:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED56110E120;
	Sat, 19 Jul 2025 23:03:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="cL25L5TL";
	dkim-atps=neutral
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF4110E120
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Jul 2025 23:03:03 +0000 (UTC)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
 by smtp1-g21.free.fr (Postfix) with ESMTP id 2BB31B00548
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Jul 2025 01:03:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1752966182;
 bh=KdNEvEhbaar9SHDcH0J3G1sfqvuiEEBz3r5VBy+fLFg=;
 h=Date:From:To:In-Reply-To:Subject:From;
 b=cL25L5TLdPoYf2Ly6OVlji6DZMSV9klcbXuPFXCfpYqQjBcZ1apu5AWx9JIUfFEl4
 Eir3HbT8OalFPyw0MvAPBaZighNeWEC/bNwat0fOcpYxh+sFPrkYe2OsUw6X5gra3E
 88rZRKWqg42tIPaC6h7pjHTZVpuQUFYeePvlJA8XwIeB5UoAlNEmHaWe6Wl8lM2mHP
 1urEY3iCQcn59tTX6b56HT8PQHCsZIO97q7LFB7rEGI5GhrtvonA2TB4xZZhllzbjN
 Smsd7LPClNHQjlUoVmDCNFK3oBdTvlTwlzhMIPGlOQhQVmWe9kUfljS4/Bb5vFjPax
 opuXhLTouBSnA==
Date: Sun, 20 Jul 2025 01:03:02 +0200 (CEST)
From: Yann Dirson <ydirson@free.fr>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Message-ID: <1103498267.150074445.1752966181999.JavaMail.root@zimbra39-e7.priv.proxad.net>
In-Reply-To: <1501262214.149072942.1752943848461.JavaMail.root@zimbra39-e7.priv.proxad.net>
Subject: A few more items for the glossary, and understanding GPU switching
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
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

Back to reading some amdgpu code, I stumbled on a few things that probably =
ought
to be added to the glossary.  Well, to be fair, I actually just had to read=
 the kernel
logs to see most of them, so those likely make sense to explain.

* ATPX (could not find anything about that on the net). "PX" alone seems to=
 be used=20
  as a synonym.  Referred to as "ATPX power control", and closely linked to=
 vga_switcheroo.
  This seems to be a preferred alternative to
  BOCO and BACO, but those are only tersely mentioned in the glossary, and =
could maybe
  use more details.  There also seem to be the notion of "ATPX hybrid" (whi=
ch apparently
  applies to the RENOIR in my laptop)
* MACO and BAMACO looks similarly related (I may have missed some ;)
* CRAT seems to be known as "Component Resource Attribute Table" ACPI table=
 according
  to various Internet sources (it is listed as "Component Resource Associat=
ion Table"
  in kfd_crat.h, do we want to adjust this?), but I could not locate any de=
tails on this
  table (ACPI 6.5 seems to list it as deprecated, but even 6.4 just gives e=
rroneous
  information, "Links to ACPI-related Documents" in=E3=80=80https://uefi.or=
g/acpi has no info)
  Is it useful to add to the glossary, with some info about its role in the=
 amdgpu context?


Now about the init on my MSI Bravo17 (Renoir APU, Navi10 dGPU)...

What I understand about ATPX is that this is a "PX system", as shown by amd=
gpu_atpx_detect()
logging:
 amdgpu: vga_switcheroo: detected switching method \_SB_.PCI0.GP17.VGA_.ATP=
X handle

So amdgpu seems to imply vga_switcheroo is supposed to get initialized at s=
ome point, right?
Similarly with another similar-looking log:

 snd_hda_intel 0000:03:00.1: Handle vga_switcheroo audio client

But no other log see vga_switcheroo actually getting enabled (and the debug=
fs dir does not
appear either, confirming this).

That is, no call to vga_switcheroo_enable() gets done (both would trigger a
"vga_switcheroo: enabled" log).  The 2 call chains from amdgpu would be:

amdgpu_init()
-> amdgpu_register_atpx_handler()
   -> vga_switcheroo_register_handler()

amdgpu_device_init()
-> vga_switcheroo_register_client()
   -> register_client()

Booting with "tp_printk ftrace=3Dfunction ftrace_filter=3Dvga_switcheroo_re=
gister_handler,vga_switcheroo_register_client,vga_switcheroo_ready" it gets=
 obvious vga_switcheroo_register_client() never not gets called.

The answer seems to lie in amdgpu_device_supports_px(), but I'm not sure to=
 get everything straight here:
amdgpu_device_supports_px() is documented as "Returns true if the device is=
 a dGPU with ATPX power control",
but amdgpu_is_atpx_hybrid() it calls seems to take info from a single stati=
c struct, so does the quoted
docstring really make sense?  And if an "APTX hybrid" system does not suppo=
rt vga_switcheroo in the end,
couldn't we just avoid any mention of vga_switcheroo in the logs (since it =
is indeed amdgpu itself sending
the user on that track), or at least just print once that it is not support=
ed and a short reason?

Best regards,
--=20
Yann
