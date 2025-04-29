Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92A7C3ABAD
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 07:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81BCF10E6EE;
	Wed, 30 Apr 2025 07:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.b="YalX09V5";
	dkim-atps=neutral
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2256610E484
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 13:16:09 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8133640E01DA; 
 Tue, 29 Apr 2025 13:09:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
 reason="fail (body has been altered)"
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id f4oL8dHl4dyp; Tue, 29 Apr 2025 13:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1745932172; bh=wtbBvXDrMYxsRuJrHeO0mppsIEcYqE8ss6S2Tym5P7Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YalX09V5Jn/emuSzAx/9801BQWqvqHzXhkFxnNZimFQ4LZvlaGGDuOm8UyfMVn2Nl
 l9+eQ2gqrYMyARkDKGYL2YKw+enSasfFkbTJrzregWS0YM6+5CT9850x0rLSLaQHGI
 ZGTFAOexpdHw/Lxek//TydGg/1b7m96N3WiShCH4KrMNgEZmwMFe02YzEkQsROSBL+
 8RO5Gbd2ov6YNOvNHi7tcrK7F9GjwphF5vL6R9Ld3N3zfx2o4lEJ6Du2sK4oEMH8HR
 6NwAstF+ErRsCyeJBsAbZMCpQPB8QQc345ApXnShwy9r1c4ozo9TX36QDB5MkeM9OK
 y1WiJ1gzZWnteFTmVUakeURLryLJ8+fSPYC/7Nd0Dv/TAnojudPotBkI3BM/x5a/0Y
 nHFzFqlI0wqprEXkGsm5vC0ifd/isJHVn1AHymmqVFMtYggxKRlxI8VJwgV1UU/WYn
 d/G1fr5/vRqA/aiECjF6VXGsZtDaBQ7vnRoyajsLNohEM7HPrgu87zbM52/yxPi28f
 jcO+axsieG9d0zg6Yz3t1t58Rl+XWcni8RA44PDmvW2U4RmOvO+zelbEfGUL07wy4S
 bQDJD/Mtajn29zqUP1a3rwAqV7jGA6qWPTJLMrQ0Zty6dJHBo9d0pfj/zor17DcBkQ
 BDMPI/gl2GkZ3eHgSzQMbeJ4=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9CE6340E0173;
 Tue, 29 Apr 2025 13:09:30 +0000 (UTC)
Date: Tue, 29 Apr 2025 15:09:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: amd-gfx@lists.freedesktop.org
Cc: Marcus =?utf-8?Q?R=C3=BCckert?= <amd@nordisch.org>
Subject: amdgpu: Reproducible soft lockups when playing games
Message-ID: <20250429130929.GCaBDPiT_CwyKmHB5o@fat_crate.local>
References: <123e013307ad395b3e26c2dd53fb99594191dda0.camel@nordisch.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <123e013307ad395b3e26c2dd53fb99594191dda0.camel@nordisch.org>
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 30 Apr 2025 07:55:07 +0000
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

+ amdgpu folks

On Tue, Apr 29, 2025 at 02:51:56PM +0200, Marcus R=C3=BCckert wrote:
> Hardware:=20
> - ASUS ROG Swift OLED PG27AQDP @ 480 Hz
> - LG 27GL850-B @ 144Hz
> - XFX Mercury Radeon RX 9070 XT OC Gaming Edition with RGB, 16GB GDDR6,=
 HDMI, 3x DP RX-97TRGBBB9
> - Ryzen 9 9950X3D on ASUS ProArt X870E-Creator WiFi
> - be quiet! Dark Power 13 850W ATX 3.0
>=20
> Software:
> - kernel-default-6.15~rc4-1.1.g62ec7c7.x86_64 from https://build.opensu=
se.org/project/show/Kernel:HEAD
> - Mesa-25.1+git442.5841d44f9-1747.1.x86_64 from https://build.opensuse.=
org/package/show/home:darix:playground/Mesa
> - GE-Proton 9-27 https://github.com/GloriousEggroll/proton-ge-custom/re=
leases/tag/GE-Proton9-27
> - Overwatch via steam
>=20
> ```
> [Mon Apr 28 23:10:56 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: Dump=
ing IP State
> [Mon Apr 28 23:10:56 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: Dump=
ing IP State Completed
> [Mon Apr 28 23:10:56 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: [drm=
] AMDGPU device coredump file has been created
> [Mon Apr 28 23:10:56 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: [drm=
] Check your /sys/class/drm/card1/device/devcoredump/data
> [Mon Apr 28 23:10:56 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: ring=
 gfx_0.0.0 timeout, but soft recovered
> [Mon Apr 28 23:11:07 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: Dump=
ing IP State
> [Mon Apr 28 23:11:07 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: Dump=
ing IP State Completed
> [Mon Apr 28 23:11:07 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: [drm=
] AMDGPU device coredump file has been created
> [Mon Apr 28 23:11:07 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: [drm=
] Check your /sys/class/drm/card1/device/devcoredump/data
> [Mon Apr 28 23:11:07 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: ring=
 gfx_0.0.0 timeout, but soft recovered
> ```
>=20
> Usually I have that like once a day or so. But yesterday it was especia=
lly bad:
>=20
> ```
> Apr 28 21:46:57 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> Apr 28 21:47:08 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> Apr 28 21:47:18 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> Apr 28 21:47:28 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> Apr 28 21:54:34 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> Apr 28 22:00:40 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> Apr 28 22:00:50 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> Apr 28 22:01:00 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> Apr 28 23:10:56 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> Apr 28 23:11:07 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> ```
>=20
> Together with my coworker Patrik Jakobsson and Takashi Iwai we already =
chased down a few other issues (like the dreaded flip_done).
> But this last issue remains. We first backported some fixes to our 6.14=
.x kernel for flip_done. To get even more fixes I switched to the 6.15~rc=
 kernels.
>=20
> Then also went with Mesa 25.1~rc which didnt fix it. so now it is a sna=
pshot package of main.
>=20
> Some observations. While gaming I started run https://github.com/Umio-Y=
asuno/amdgpu_top on the 2nd monitor to see if overheating might be an iss=
ue.
>=20
> but the memory temps are at around 82 and the GPU core itself is usuall=
y lower.
> One observation is that the card is supposed to have a boost clock of 3=
100MHz but amdgpu_top sees it boost over 3200. I tried both onboard bios =
and the behavior is the same.
>=20
> currently I run both my wayland session as well as my game with RADV_DE=
BUG=3Dnohiz but that didnt provide more details adding nodcc drop the per=
formance from 480-500Hz ( the card could go faster but I limit the game t=
o 500)
> to 330-360.
>=20
> Please let me know, if I can provide more details
>=20
>    darix
>=20
>=20
> ```
> --=20
> Always remember:
>   Never accept the world as it appears to be.
>     Dare to see it for what it could be.
>       The world can always use more heroes.
>=20
>=20
>=20
>=20
> ```
>=20

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
