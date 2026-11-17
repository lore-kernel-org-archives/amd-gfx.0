Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2C9606A333
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=beerstra.org header.i=@beerstra.org header.a=rsa-sha256 header.s=mail header.b=y/ZroHuZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A9C910ED32;
	Tue, 17 Nov 2026 14:05:42 +0000 (UTC)
Received: from mail.beerstra.org (mail.beerstra.org [217.148.134.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7139389C68
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 12:46:42 +0000 (UTC)
From: Jeroen Beerstra <jeroen@beerstra.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beerstra.org;
 s=mail; t=1794919601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eCziB/Q75kz0zuPVvzXqrd7ybLKVWo+1grfK7ZO6L4Q=;
 b=y/ZroHuZ7T9atYM8ayhrYRYPWhJtppVH6KDZUrahJ1WeYDGnlEdqRURzwGf237GbczTPxQ
 dqxuWg5rrPScJ2cauZ+ay0VnDYssSFnf7JsUr1ZkW/T7OE4Q5jYWgbgoBbMnCuzow2/AUD
 QeVjWqLOkijopQvjSg7v3m5eKDFwWk4+EVwjEI5eOh6VAqnLX8Tr+VSLBIc+gaYz29zs3u
 albDhTeAadNV04o2PbciczQXIOEdXsvS+TOzzVVmfZ/TQN2en0yDk/Q8t/RuJWM+iU7WQp
 2r/cgDvnMidNtYMFcnUlVXaozNFkwk59ZBYZmKdYrN3MEwcEduhTaMmjcMU9Fg==
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Subject: [REGRESSION] Suspected amdgpu graphics regression on Ryzen 9 7950X
 since 6.18.58
X-MS-Reactions: disallow
Message-Id: <729A37E1-250D-469B-B89D-E24DFA4CABE6@beerstra.org>
Date: Tue, 17 Nov 2026 13:46:31 +0100
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

    =E2=80=A2 Boot into run level 5 on AMD graphics
    =E2=80=A2 Reboot
    =E2=80=A2 Lockup

I currently use 6.18.56, which does not exhibit the problem.

These kernels are built using rpmbuild from unmodified upstream
sources, without additional source patches. The RPM spec is based
on ELRepo's spec, with local changes for Secure Boot signing.
Secure Boot is enabled.

I haven=E2=80=99t changed the kernel config or firmware in between.
My setup is:
    =E2=80=A2 AlmaLinux 9
    =E2=80=A2 A custom build 6.18 kernel with secure boot but without =
patches or other modifications
    =E2=80=A2 I have kernel modules via dkms for: zfs, nvidia and anbox. =
However the nvidia modules are currently completely disabled at boot.
    =E2=80=A2 System has 128GB RAM, a Ryzen 9 7950X and Nvidia RTX 5080. =
On the Linux side I run the standard Gnome that comes with AlmaLinux 9: =
40 on the onboard graphics for the 7950X and at the same time Windows 11 =
via kvm/qemu on the RTX 5080.

Willing to provide further details if required or perform further =
debugging.


#regzbot introduced: v6.18.56..v6.18.58

PS second attempt, didn=E2=80=99t ment to send a HTML message :(=20

Kind regards,
Jeroen Beerstra
