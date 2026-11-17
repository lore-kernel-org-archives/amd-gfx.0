Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFA8606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beerstra.org header.i=@beerstra.org header.a=rsa-sha256 header.s=mail header.b=qGKVpAx8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D49AB10F767;
	Tue, 17 Nov 2026 14:05:49 +0000 (UTC)
X-Greylist: delayed 327 seconds by postgrey-1.36 at gabe;
 Tue, 17 Nov 2026 12:41:35 UTC
Received: from mail.beerstra.org (mail.beerstra.org [217.148.134.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6611B10E5C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 12:41:35 +0000 (UTC)
From: Jeroen Beerstra <jeroen@beerstra.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beerstra.org;
 s=mail; t=1794918966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=eWjwnEgKO9R2nXDJa9SM8ySPZ0eDiREDtDmUcebwr1A=;
 b=qGKVpAx82zKRP8ONCDSwC0qGEGW6RyZi6CIT2ihou8ERmXP9b/WLocVq30AdCIBVaOEyMv
 TNkCYEM2dvaXRNAqvQnFsmaqY5Skomjd6HBVIkyXnBX3bVxJ7SMqes5NmekkW5D8f+utZl
 xVeU11+sWVIMCGMLEDCYYR/dqLLFYXqR2nxAYW3tmSGF3Cpr8BAijUEvKimTE8jdVVbHTe
 9fptCR/qGcGnxFQIxBVJ+YvM6NxTTUzjBMX308+jCBT3O/hgHHwvsSSFVSDrfjWgZQWToV
 OScTW6Y/U0pstNnkjQG8OFjtkJ7Cm5XfrKuF1GTsMsEy5KHEGg0tlWg0FCu+0g==
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_266D6F71-E04A-429E-8A32-C7B79640EB06"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Subject: [REGRESSION] Suspected amdgpu graphics regression on Ryzen 9 7950X
 since 6.18.58
X-MS-Reactions: disallow
Message-Id: <8C195BCD-0939-4BE9-B910-3C57A5977984@beerstra.org>
Date: Tue, 17 Nov 2026 13:35:55 +0100
Cc: stable@vger.kernel.org,
 regressions@lists.linux.dev
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Tue, 17 Nov 2026 14:05:41 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Apple-Mail=_266D6F71-E04A-429E-8A32-C7B79640EB06
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I am experiencing graphics problems on AlmaLinux 9 using the
integrated graphics of an AMD Ryzen 9 7950X.

Last known good: Linux 6.18.56
First known bad: Linux 6.18.58
Still affected: Linux 6.18.63

The symptoms vary between affected versions:

I first noticed a hard lockup when I powered off my Windows 11 kvm =
session where graphics are rendered to a dedicated Nvidia RTX 5080.
So the first suspect was either the Nvidia hardware or kvm/qemu. Later =
the problem got worse and I was unable to boot into run level 5 where my =
onboard AMD graphics for my Ryzen 9 7950X gets activated. At some point =
it appeared my system even needed a cold boot to get in a usable state =
as there were hardware errors unrelated to the graphics at booted that =
prevented the boot to continue that disappeared after a complete power =
off. I think this was with 6.18.59 and 6.18.60 but not completely sure. =
Currently with 6.18.63 the problem is: hard lockup when I power off my =
Windows 11 kvm/qemu session with the RTX 5080 in passthrough mode and =
hard lockup when I end my Gnome session in Linux that uses the onboard =
AMD graphics, so my primary suspect is the amd driver. Because of the =
hard lockups nothing gets logged, but I=E2=80=99m sure there are ways =
around that.

Steps to reproduce:

Boot into run level 5 on AMD graphics
Reboot
Lockup

I currently use 6.18.56, which does not exhibit the problem.

These kernels are built using rpmbuild from unmodified upstream
sources, without additional source patches. The RPM spec is based
on ELRepo's spec, with local changes for Secure Boot signing.
Secure Boot is enabled.

I haven=E2=80=99t changed the kernel config or firmware in between.
My setup is:
AlmaLinux 9
A custom build 6.18 kernel with secure boot but without patches or other =
modifications
I have kernel modules via dkms for: zfs, nvidia and anbox. However the =
nvidia modules are currently completely disabled at boot.
System has 128GB RAM, a Ryzen 9 7950X and Nvidia RTX 5080. On the Linux =
side I run the standard Gnome that comes with AlmaLinux 9: 40 on the =
onboard graphics for the 7950X and at the same time Windows 11 via =
kvm/qemu on the RTX 5080.

Willing to provide further details if required or perform further =
debugging.

#regzbot introduced: v6.18.56..v6.18.58
Kind regards,
Jeroen Beerstra=

--Apple-Mail=_266D6F71-E04A-429E-8A32-C7B79640EB06
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><pre dir=3D"ltr" style=3D"font-size: =
medium;"><code>I am experiencing graphics problems on AlmaLinux 9 using =
the
integrated graphics of an AMD Ryzen 9 7950X.

Last known good: Linux 6.18.56
First known bad: Linux 6.18.58
Still affected: Linux 6.18.63
</code></pre><pre dir=3D"ltr" style=3D"font-size: medium;"><code>
The symptoms vary between affected versions:
<br></code></pre><pre dir=3D"ltr" style=3D"font-size: medium;"><code>I =
first noticed a hard lockup when I powered off my Windows 11 kvm session =
where graphics are rendered to a dedicated Nvidia RTX =
5080.</code></pre><pre dir=3D"ltr" style=3D"font-size: medium;"><code>So =
the first suspect was either the Nvidia hardware or kvm/qemu. Later the =
problem got worse and I was unable to boot into run level 5 where my =
onboard AMD graphics for my Ryzen 9 7950X gets activated. At some point =
it appeared my system even needed a cold boot to get in a usable state =
as there were hardware errors unrelated to the graphics at booted that =
prevented the boot to continue that disappeared after a complete power =
off. I think this was with 6.18.59 and 6.18.60 but not completely sure. =
Currently with 6.18.63 the problem is: hard lockup when I power off my =
Windows 11 kvm/qemu session with the RTX 5080 in passthrough mode and =
hard lockup when I end my Gnome session in Linux that uses the onboard =
AMD graphics, so my primary suspect is the amd driver. Because of the =
hard lockups nothing gets logged, but I=E2=80=99m sure there are ways =
around that.

Steps to reproduce:
<br></code></pre><pre dir=3D"ltr" style=3D"font-size: medium;"><ul =
style=3D"list-style-type: &quot;-&nbsp;&nbsp;&quot;;" =
class=3D"Apple-dash-list MailOutline"><li>Boot into run level 5 on AMD =
graphics</li><li>Reboot</li><li>Lockup</li></ul></pre><pre dir=3D"ltr" =
style=3D"font-size: medium;"><code>
I currently use 6.18.56, which does not exhibit the problem.

These kernels are built using rpmbuild from unmodified upstream
sources, without additional source patches. The RPM spec is based
on ELRepo's spec, with local changes for Secure Boot signing.
Secure Boot is enabled.

I haven=E2=80=99t changed the kernel config or firmware in =
between.</code></pre><pre dir=3D"ltr" style=3D"font-size: =
medium;"><code>My setup is:</code></pre><pre dir=3D"ltr" =
style=3D"font-size: medium;"><ul style=3D"list-style-type: =
&quot;-&nbsp;&nbsp;&quot;;" class=3D"Apple-dash-list =
MailOutline"><li>AlmaLinux 9</li><li>A custom build 6.18 kernel with =
secure boot but without patches or other modifications</li><li>I have =
kernel modules via dkms for: zfs, nvidia and anbox. However the nvidia =
modules are currently completely disabled at boot.</li><li>System has =
128GB RAM, a Ryzen 9 7950X and Nvidia RTX 5080. On the Linux side I run =
the standard Gnome that comes with AlmaLinux 9: 40 on the onboard =
graphics for the 7950X and at the same time Windows 11 via kvm/qemu on =
the RTX 5080.</li></ul><div><br></div><div>Willing to provide further =
details if required or perform further debugging.</div></pre><pre =
dir=3D"ltr" style=3D"font-size: medium;"><code>
#regzbot introduced: v6.18.56..v6.18.58</code></pre><pre dir=3D"ltr" =
style=3D"font-size: medium;"><code>Kind regards,</code></pre><pre =
dir=3D"ltr" style=3D"font-size: medium;"><code>Jeroen =
Beerstra</code></pre></body></html>=

--Apple-Mail=_266D6F71-E04A-429E-8A32-C7B79640EB06--
