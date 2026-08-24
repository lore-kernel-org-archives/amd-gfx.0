Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7119AC5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 07:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E738B10E61A;
	Mon, 24 Aug 2026 07:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e/DR28yI";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0408F10E0C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 07:22:53 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-499b57cf2f3so16969315e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 00:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787556171; cv=none;
 d=google.com; s=arc-20260327;
 b=BvQ+0x+QjmBWPr/aEGdiF7TOP/yEmBPn6WlK24ioFhswfRBW4u1nQ+ZTEn2JHGE7m3
 1eCv/Kxv6mR0Di4C1gI+s8TJRRoUC+Txn7OSA+H/W9gFhbNojXhkD7jGHZDXBOY1RVrl
 +duSAKeTHHxrRzKbH8vJwp/qAc+3s5l1lE38H1BmgRDuxQRl3aq7HfyhBU/BQ5xzpWba
 VxR3YpQrTi9bkLpdr60v7nzjhzwnH0ouXtMCKfkV8adzvcdCL+Q1evYCiO5+FdRTVS4h
 IBAdjwc3pemy5B69Ht5nzNL3XszyHl2mkotIgvlFW76hv8NCuiqQt4dULEJw1voZwMto
 KApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=fTwAXzwEroGRnFaFDuQgzHLGJ55DUd2hD43uQnL4NWw=;
 fh=LYN8rUkjKrk8P/z4hxTLJgSk8ZFtrFPhcLjEY5H8VoM=;
 b=TnBlkBuO86/oWEv6tjS+fHPrW99XvNgDDKMU1+g4Jz+Qm96wntnpx21Cv69noiklCV
 wy+Cj7c/B+McRIzPNmVzpM0B6WCwcEN9+mripbP0Od7hHPVwQ1yiN0ig94rfV6AOtPdx
 z9Srug9Gz/AVTV15QYe5LCF5O8V/chcVtRyz19A3Nvxhrd7iRjFHI8+ArJV0YYsETxba
 L/KXzWe5M4Zg1qPVfIZ79NSOrsZsk2pc4oJNUgPSK99aMAtn0a+o/BZw6cJy8NQE27jH
 IqtCBR8IA3JyNHKt+P3Jr609QY64RXRVNkhBRNPiuB99q1aNY8plPitbJvRnHrFVZ3yL
 rXLQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787556171; x=1788160971; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fTwAXzwEroGRnFaFDuQgzHLGJ55DUd2hD43uQnL4NWw=;
 b=e/DR28yI6RvvSEezkvayz3Yu70cl7aLZJlps2zRd94xoD2+cSgw9MdKHSmvFNOsyDe
 Zh75F2Iz+0tvoXTCD7k5IHadY27q3XzhwvAsPqQ9zi6sJ6lGmOsHx5s4BWQgGqrqgXfN
 GyfkHuPhJD4PDRu/ZH4s2BUFnB8JohhpsweHmoi9l3EhBF0q4HML6Wk+5MwlnbYkp/Ui
 enjaBXYBIbHTxIMMuP/t96KGFaJjIGYFidcj8uICR93rKosM/pebZYeiVTelfNmQhz/q
 IewV10XBYtcx5pENz+Sp1BSTdHS2kHAND8xm+DOiov54Zx8ql2kJnF4apABXPJaKxIia
 oZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787556171; x=1788160971;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fTwAXzwEroGRnFaFDuQgzHLGJ55DUd2hD43uQnL4NWw=;
 b=f1Bihdm4HcnKBBAbQDgKeeD0U/sn5gGvqo09j4aaqKeC45021TFkvJt+57ILKIehI1
 CKK4GlR+WbibmWjsl9QvvjS4OW4kS1s5m/Ndihe2w7zcIo+hSr5kL6+3G/CdjHNP5tnI
 6wPD/DIlDHTkJGsVd/+DhY8Yx0DcouQpIMhZzqtBTRwQTKVgc/w9NVbjySIZuYOcokOE
 aGyCguf6pvj2LgZwSRepd4i1UocdNqGV3WAinMAjj1NNaX/WANRJX4VHNmipz78S2Gvd
 VROHpUQw+JWASb1I/5mupgXCZzujj63iVWTEAhvsmT4EjLADh0MZ4ZdLm+HRm9kCqT5W
 KUCg==
X-Gm-Message-State: AFuF++lv8CMOBzny6PckRlzVdXTX9LgbMFviPRKrIgzvq8q2lkkCypzz
 UGLH3QPiGXFCs1QVz2J4G3nhQJi3Eg5L9j6EqJUE3avydnBrK9BeFdurOigQkOwyQ17/9I/B+t6
 PfMIF9smBbvC+Zsg4WtXLtQWFX4AMAFHnGfTk
X-Gm-Gg: AR+sD13VTijNo8yuSjguddXXnlwKluPDReKAEFoQfm1CimzRRflLFxBpQN5+k3G9jY3
 4H8n7MF+1Opax3i3yJq78zgpFJf0+PfKYd+Lfs4aehcXYnEvKVqPuRbCZ5ax5vXlVLS5fVVsi2s
 Rl0Lpq7c+2tUoq8SUQ1LCwYPfqwr4ICM99f9s6bVwLTjE3oOG005crU9CVddbenS44Zqiu8AtxB
 zvqAUt8gOIkvdu+aUM5OBAPy6G2udPpRWIbdx4emWxjBXQ6fWSnkULTdCDSV2zs3SLILvtoFjCv
 K5q6vv+JlTXUnhLR6ZiAvWv8HrLw/4JSEXeN2ufTzraz07w2rcAglQ==
X-Received: by 2002:a05:600d:644a:10b0:499:bdf1:de07 with SMTP id
 5b1f17b1804b1-499bdf1de10mr137644995e9.5.1787556171178; Mon, 24 Aug 2026
 00:22:51 -0700 (PDT)
MIME-Version: 1.0
From: Abdulaziz Al-Mutairi <abdulazizalmkw@gmail.com>
Date: Mon, 24 Aug 2026 10:22:40 +0300
X-Gm-Features: AcwNN1UaD6hJv00Qs3xLv57zwU-l6VJ32zbRPdVNnyi3tAOlkpvyT1X8ljlmW_Q
Message-ID: <CAGUR40bXYXppUrJM=1aSa4SyecHN0bpzRSEofxHeD2wDYDzOxw@mail.gmail.com>
Subject: =?UTF-8?Q?Strix_Halo_gfx1151_=28ASUS_GZ302EA=29=3A_PSP_hw=5Finit_fails?=
 =?UTF-8?Q?_on_one_unit_=E2=80=94_mmhub_fault_from_MP0_during_TMR_setup_=28drm=2F?=
 =?UTF-8?Q?amd_issue_=235679=29?=
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: multipart/alternative; boundary="00000000000099646e0659c5da0d"
X-Mailman-Approved-At: Mon, 24 Aug 2026 07:56:52 +0000
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

--00000000000099646e0659c5da0d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I filed https://gitlab.freedesktop.org/drm/amd/-/issues/5679 a couple of
days
ago and wanted to flag it here since it may be interesting to whoever owns
the
PSP init path on gfx1151.

Short version: on my ASUS ROG Flow Z13 GZ302EA (Ryzen AI MAX+ 395 / Radeon
8060S), amdgpu has never initialized. The PSP itself raises a memory fault
while setting up its Trusted Memory Region, and hw_init of the psp block
fails. The exact sequence, identical on every attempt:

  amdgpu 0000:65:00.0: [mmhub] page fault ... Faulty UTCL2 client ID: MP0
(0x6)
  amdgpu 0000:65:00.0: amdgpu: psp gfx command ID_LOAD_TOC(0x20) failed and
response status is (0x0)
  amdgpu 0000:65:00.0: amdgpu: PSP tmr init failed!
  amdgpu 0000:65:00.0: amdgpu: hw_init of IP block <psp> failed -22

On top of that, the cleanup path then hits a vcn_v4_0_5_sw_fini Oops with
IRQs
disabled, which can hard-hang the machine. nomodeset is the only stable
state.

What makes it interesting: Windows 11 + Adrenalin works perfectly on the
same
unit, and at least one other GZ302EA on the same BIOS (.311) reportedly
boots
Linux fine =E2=80=94 so this smells like per-unit PSP/firmware state rather=
 than a
generic driver bug. I reproduced it across 5 kernels (6.18 LTS through 7.2 =
=E2=80=94
newer ones actually fail earlier), a BIOS re-flash via EZ Flash, live USB,
and
every relevant module parameter I could find. Full 837-line dmesg of the
manual modprobe sequence is attached to the issue.

Two questions I couldn't answer from the outside:

1. Is there any way to dump or reset the PSP NVRAM/state on Strix Halo from
   the OS or BIOS? (The firmware setup variables include an ASUS
   "AsusClearPspNvram" knob I have not touched yet =E2=80=94 is that path
known/safe?)
2. Is there an expected TMR base/size on this platform that the BIOS might
be
   misprogramming on some units?

The machine is set up for safe remote testing (SSH from a second laptop,
amdgpu blacklisted at boot), so I'm happy to try patches or dump anything
useful.

Thanks,
Abdulaziz AlMutairi

--00000000000099646e0659c5da0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I filed <a href=3D"https://gitlab.freedesktop.o=
rg/drm/amd/-/issues/5679">https://gitlab.freedesktop.org/drm/amd/-/issues/5=
679</a> a couple of days<br>ago and wanted to flag it here since it may be =
interesting to whoever owns the<br>PSP init path on gfx1151.<br><br>Short v=
ersion: on my ASUS ROG Flow Z13 GZ302EA (Ryzen AI MAX+ 395 / Radeon<br>8060=
S), amdgpu has never initialized. The PSP itself raises a memory fault<br>w=
hile setting up its Trusted Memory Region, and hw_init of the psp block<br>=
fails. The exact sequence, identical on every attempt:<br><br>=C2=A0 amdgpu=
 0000:65:00.0: [mmhub] page fault ... Faulty UTCL2 client ID: MP0 (0x6)<br>=
=C2=A0 amdgpu 0000:65:00.0: amdgpu: psp gfx command ID_LOAD_TOC(0x20) faile=
d and response status is (0x0)<br>=C2=A0 amdgpu 0000:65:00.0: amdgpu: PSP t=
mr init failed!<br>=C2=A0 amdgpu 0000:65:00.0: amdgpu: hw_init of IP block =
&lt;psp&gt; failed -22<br><br>On top of that, the cleanup path then hits a =
vcn_v4_0_5_sw_fini Oops with IRQs<br>disabled, which can hard-hang the mach=
ine. nomodeset is the only stable state.<br><br>What makes it interesting: =
Windows 11 + Adrenalin works perfectly on the same<br>unit, and at least on=
e other GZ302EA on the same BIOS (.311) reportedly boots<br>Linux fine =E2=
=80=94 so this smells like per-unit PSP/firmware state rather than a<br>gen=
eric driver bug. I reproduced it across 5 kernels (6.18 LTS through 7.2 =E2=
=80=94<br>newer ones actually fail earlier), a BIOS re-flash via EZ Flash, =
live USB, and<br>every relevant module parameter I could find. Full 837-lin=
e dmesg of the<br>manual modprobe sequence is attached to the issue.<br><br=
>Two questions I couldn&#39;t answer from the outside:<br><br>1. Is there a=
ny way to dump or reset the PSP NVRAM/state on Strix Halo from<br>=C2=A0 =
=C2=A0the OS or BIOS? (The firmware setup variables include an ASUS<br>=C2=
=A0 =C2=A0&quot;AsusClearPspNvram&quot; knob I have not touched yet =E2=80=
=94 is that path known/safe?)<br>2. Is there an expected TMR base/size on t=
his platform that the BIOS might be<br>=C2=A0 =C2=A0misprogramming on some =
units?<br><br>The machine is set up for safe remote testing (SSH from a sec=
ond laptop,<br>amdgpu blacklisted at boot), so I&#39;m happy to try patches=
 or dump anything<br>useful.<br><br>Thanks,<br>Abdulaziz AlMutairi</div>

--00000000000099646e0659c5da0d--
