Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDB9CA5FFD
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 07:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE27710EBC3;
	Mon,  5 Oct 2026 07:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JP8QKOl6";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6079710E21F
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2026 17:29:02 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48b02a2359aso459117f8f.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 04 Oct 2026 10:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791134941; cv=none;
 d=google.com; s=arc-20260327;
 b=lIpPjSnNMLrCH0AB/srVHbiTbciIpCdndm2MBSn1cN3bNhxStJYH7qlT+JyuW9iLoU
 NllNhxl47+2MkAesuz8Uoy0smD/L5ewSizyfybLyMAJ6gm3pq4JuijbGsjwOKmrjh5U/
 QJPbRuypwYLJzIsZCranTVt9+848lCqUWbyKmGOQ2lz7o9uIinQsOoqyFvrRSJIhGoeP
 MjV6eOD6cjRsBomwudiw6ESjAqqtZyDs/NfOXELn4fdfki5WJLtFzhnN7oCtyxYvssUS
 8kURGROn6WIBiev9Uv6k+jPiMde+Wd6I2RPMPdSiJRgEabLHkGj/fkWOCe8cIoBYWN7j
 EE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=pz8Mohbk776cxYYJztLeYJf3DdX5MXJtzVfYSMqqboY=;
 fh=TulPHAWbRu/8UKdrvsIytU8mAKZAYIJKZocOZjMI9JY=;
 b=mjPFBnGJqo6qAwTnIMTyp4+qdjVbCPlPOAcuO9E2EMKmTQRd6d5H2Z4suEqmxp20OM
 vQCpdkvmBv3IpB7anolrtLwP4zOVz/FVLo87zLuSImZkSY74TLW/xZYbD6NEFWMbKkb2
 e+H3Qn6BDP65/KOURTrvJX79ZwpOTGf0sifw8/5/Dz5eBB4HcooffNGBHN0ssQTr1lC7
 BjDZ4GPzdP3VfJBtxdXwyYvyNHDHxn9VpOCA3F89K1G6e/sjmFQpOwkTBIafZ8Ludljt
 hRuPidS7b3f7CAhhaZdIWIuLWCep7evipcxwaI1hIBKB3KNaXkAFMeS/Q6fEGT2fJ1ro
 AxrQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791134941; x=1791739741; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pz8Mohbk776cxYYJztLeYJf3DdX5MXJtzVfYSMqqboY=;
 b=JP8QKOl6RlEpSecsyxAJnOxyeQtQ/W/kF+m65uzbvYbxVO3GwTE2iw+BiCRYgZoTtl
 rmpwGsDwX80A+5/tdo8te+YTZ1IsLSYaVQAYgyE2KxZDy5FB5IBjCTMyBdeyYXN0J3Xv
 9QA60t0XwVGrPys5O2I8E42bszDyeLXNIDA57VXC8ef0nsaWVqHUuC5CweuIis37+2NN
 rbQE5RUz6n35A28DeqUhilc/ocnXVL0h/bVBW/3nJb10tFq20ibBZuLXhJ5++Cr9ha32
 6hO1lPKD9hnA7uE9N7TLyTgia1qLt7wQ7p95e7VjJhOzGTqWGKjDCxaD+S5Km61Z/q4U
 h8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791134941; x=1791739741;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pz8Mohbk776cxYYJztLeYJf3DdX5MXJtzVfYSMqqboY=;
 b=kF8VcSIjSy89MUwNXFkUDxaUs5jUdF3ZyQNXZ16LKaGx9pvExF83hP/rlx62yNGbEE
 TRfQO2gzw5lxRR0nnum9xq6JWFHhpy/nOMnLowtZ+3W/aKeKD1+lFDB0M5RbTFKSUgVw
 5XloSqxHk4Bj4I5RctHIOyYhckmgfvTwC7pXbeSxf3ItgN1upBEKkdRHZWwxQDq4kZ2h
 bYyEM6oDY/OjGyZ/a4z2EXLn4i2QXgVF3TLYlOWGVndtH8B7GnW0hzYvda8XIA6tHZ02
 iqeBnVelMxtX6NtilyJ9nSwcWAjfYknKc37fHET1sdeKrfc9nzN4CtbvKj124tkrw9mP
 uR/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFcR9ItBQiGAcygDgmzWSWKmiGt73IaFBKR/ZAfrwLgfksynH1LWwLYawMc+QC9/BeWEaYaFM2@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIJuMXV7FVoRhE7ayLtLmk+oKBcipOurzz6ZNUlJszswAhlrSqM
 mi8kLyXFcbB+3Bf86SsgmB6rqfwWjoRF84Xfkh9ludhRWmDUO70csS+SC7QvE6s5IzPUy3AEQpR
 vojfDvbD79W0xYt2VltqjchziTEDHJLM=
X-Gm-Gg: AYBFou0NoiqzhnetGVRd7yTx4rzeTN8O0dYu2lqZNkV3XS6VhaFo3eHE/62QI+2z38g
 jFceQtp5aqlEo64y46YnHQHJeA1333MbyfZT8dnEEK6zMQacjbkaZvBBOgmoL2ZyeGUX+MwdNem
 CywHQRpZq6O/gVta1VuGDJEMuzWQ1Gie2K81nUeG9OCwXKy0sT3SPgA2tlG++NMwLbnt5Ge2aIX
 P0/iFqAI7c/jJMLTGnz6IygAZz6EUKFyoyrrL6rMjwxt8pz6S+0eHwHFlcxcfHb+YsSUM7291E0
 OOAjLXNS/dy8ZAGkGGPcyd3QEacjFpj95bLoA4l9Gz3Ve/Fzvio+VdA=
X-Received: by 2002:a5d:54cd:0:b0:487:1577:9e33 with SMTP id
 ffacd0b85a97d-48b068bf670mr18038858f8f.25.1791134940425; Sun, 04 Oct 2026
 10:29:00 -0700 (PDT)
MIME-Version: 1.0
From: John Doen <johndoen1965@gmail.com>
Date: Sun, 4 Oct 2026 12:28:48 -0500
X-Gm-Features: AclHuK-37N6r_tlttg0x4xvI3cfhNn-wbnmol2NuDn1a3WNjNTiEuIfYgZp3X9Q
Message-ID: <CAPddu3kdTYPn51R05349V=KozM80+EL044fjDosteXvW9mOaQQ@mail.gmail.com>
Subject: Re: PCI: bridge window undersized when child bridge windows are
 larger than their alignment (regression since 3958bf16e2fe, v7.0)
To: linux-pci@vger.kernel.org
Cc: nbritton@exabit.io, bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, 
 regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="000000000000deb234065d07199c"
X-Mailman-Approved-At: Mon, 05 Oct 2026 07:28:12 +0000
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

--000000000000deb234065d07199c
Content-Type: text/plain; charset="UTF-8"

 This is a follow-up to:
https://mail-archive.com/amd-gfx@lists.freedesktop.org/msg152555.html

Hi,

I appear to have another instance of this multi-composite-resource
bridge-window undersizing regression, this time with two discrete NVIDIA
GPUs behind AMD chipset PCIe switches.

The allocation arithmetic looks equivalent to the original report, but I
have not yet tested Ilpo's newer patch series. Please treat this as an
additional likely instance rather than confirmation that the proposed
series fixes this machine.

The failure was reproduced on Ubuntu 26.04 with its 7.0.0-31-generic
kernel. The same hardware allocated correctly with Ubuntu's
6.17.0-42-generic kernel.

Summary
=======

On Linux 7.0, forcing bridge resource reassignment gives the shared parent
window only the plain sum of two composite child windows. The second child
cannot start immediately after the first because both child windows inherit
the alignment of their largest BAR.

The later sibling bridge, 0000:0b:08.0, consequently receives neither its
prefetchable nor non-prefetchable window. The NVIDIA GPU at 0000:11:00.0
then has BAR0, BAR1, BAR3, its ROM, and its audio-function BAR unassigned.

The NVIDIA driver subsequently reports:

    NVRM: This PCI I/O region assigned to your NVIDIA device is invalid:
    NVRM: BAR0 is 0M @ 0x0 (PCI:0000:11:00.0)
    nvidia 0000:11:00.0: probe with driver nvidia failed with error -1

The BAR allocation failure occurs before the NVIDIA driver probes, so this
does not appear to originate in the NVIDIA driver.

System
======

Distribution:

    Ubuntu 26.04.1 LTS (Resolute)

Failing kernel:

    linux-image-7.0.0-31-generic 7.0.0-31.31

The failing dmesg identifies it as:

    Linux version 7.0.0-31-generic
    #31-Ubuntu SMP PREEMPT_DYNAMIC
    Ubuntu 7.0.0-31.31-generic 7.0.14

Known-good kernel:

    linux-image-6.17.0-42-generic 6.17.0-42.42+1

CPU:

    AMD Ryzen 9 9950X3D
    x86_64
    48-bit physical address space

Motherboard/current DMI information:

    Board vendor:   Micro-Star International Co., Ltd.
    Board name:     PRO X870E-P WIFI (MS-7E70)
    Board version:  2.0
    BIOS vendor:    American Megatrends International, LLC.
    BIOS version:   2.A52
    BIOS date:      06/29/2026

I did not save a separate DMI dump in the failing-boot artifact, so the BIOS
information above is from the current machine. I believe it is unchanged
from the failing test, but cannot prove that solely from the saved dmesg.

GPU configuration at the time of the failing 7.0 capture:

    0000:01:00.0  NVIDIA GeForce RTX 5090 [10de:2b85]
    0000:0d:00.0  NVIDIA GeForce RTX 3090 [10de:2204]
    0000:11:00.0  NVIDIA GeForce RTX 3090 [10de:2204]

The RTX 5090 is attached directly under a separate root port. The two
RTX 3090s are sibling endpoints behind the affected chipset/switch path.

The machine now also contains an RTX 3060 behind 0000:0b:07.0. That GPU
was added after the failing 7.0 capture and is not part of the comparison
or arithmetic below. The current four-GPU configuration works on 6.17.

Relevant topology during the failing test
=========================================

    0000:00:02.1  AMD GPP root port [1022:14db]
      `-- 0000:03:00.0  AMD 600 Series switch upstream [1022:43f4]
           `-- 0000:04:08.0  AMD 600 Series switch downstream [1022:43f5]
                `-- 0000:0a:00.0  AMD 600 Series switch upstream [1022:43f4]
                     `-- 0000:0b
                          |-- 0000:0b:04.0 [bus 0d]
                          |    |-- 0000:0d:00.0 RTX 3090 [10de:2204]
                          |    `-- 0000:0d:00.1 NVIDIA HDA [10de:1aef]
                          |-- 0000:0b:05.0 [bus 0e] -- Realtek RTL8126
                          |-- 0000:0b:06.0 [bus 0f] -- Qualcomm WCN785x
                          |-- 0000:0b:08.0 [bus 11]
                          |    |-- 0000:11:00.0 RTX 3090 [10de:2204]
                          |    `-- 0000:11:00.1 NVIDIA HDA [10de:1aef]
                          |-- 0000:0b:0c.0 [bus 12] -- AMD USB
                          `-- 0000:0b:0d.0 [bus 13] -- AMD SATA

Failing test command line
=========================

The saved 7.0 boot used:

    BOOT_IMAGE=/vmlinuz-7.0.0-31-generic
    root=/dev/mapper/ubuntu--vg-ubuntu--lv
    ro
    crashkernel=2G-4G:320M,4G-32G:512M,32G-64G:1024M,64G-128G:2048M,128G-:4096M
    pci=realloc=on
    pci=resource_alignment=0000:00:02.1;0000:03:00.0;0000:04:08.0;0000:0a:00.0;0000:0b:04.0;0000:0b:08.0

The resource_alignment list was used to force reassignment of the affected
bridge path.

This is an important limitation of my existing comparison: the failing 7.0
capture used the targeted resource_alignment list, while the successful
6.17 boot used pci=realloc=on without that list. The 6.17 kernel still had
to reassign this hierarchy because the firmware-provided non-prefetchable
window conflicted with AMDIF031:00.

Prefetchable-window failure
===========================

Each RTX 3090 has:

    BAR1: 0x800000000 = 32 GiB, prefetchable
    BAR3: 0x02000000  = 32 MiB, prefetchable

Therefore each downstream bridge needs a composite prefetchable window of:

    0x802000000 = 32 GiB + 32 MiB

The composite child window inherits 32 GiB alignment from BAR1.

On the failing 7.0 boot, the parent at 0000:0a:00.0 was assigned:

    0000:0a:00.0:
      [mem 0x1000000000-0x2003ffffff 64bit pref]

Its size is:

    0x1004000000 = 64 GiB + 64 MiB

This is exactly the plain sum of two 32 GiB + 32 MiB child windows.

The first child was assigned successfully:

    0000:0b:04.0:
      [mem 0x1000000000-0x1801ffffff 64bit pref]

This consumes 32 GiB + 32 MiB. Its exclusive end is 0x1802000000.

Because the second child also requires 32 GiB alignment, it cannot start at
0x1802000000. Its next legal start is 0x2000000000. Placing another
0x802000000-byte child there requires an exclusive end of 0x2802000000.

Thus the required parent span is:

    0x1000000000-0x2801ffffff
    size 0x1802000000 = 96 GiB + 32 MiB

But Linux 7.0 allocated only:

    size 0x1004000000 = 64 GiB + 64 MiB

The shortfall is:

    0x7fe000000 = 32 GiB - 32 MiB

The kernel then reports:

    pci 0000:0b:08.0: bridge window
      [mem size 0x802000000 64bit pref]: can't assign; no space
    pci 0000:0b:08.0: bridge window
      [mem size 0x802000000 64bit pref]: failed to assign

This appears to be the same arithmetic as the original Vega20 report,
except that my composite windows contain a 32 GiB NVIDIA BAR1 plus a
32 MiB BAR3 rather than a 32 GiB AMD BAR plus a 2 MiB doorbell BAR.

On 6.17, the same hierarchy received:

    0000:0a:00.0:
      [mem 0xd000000000-0xe801ffffff 64bit pref]

That window is 0x1802000000 bytes, exactly 96 GiB + 32 MiB.

Both children then fit:

    0000:0b:08.0:
      [mem 0xd000000000-0xd801ffffff 64bit pref]

    0000:0b:04.0:
      [mem 0xe000000000-0xe801ffffff 64bit pref]

Both RTX 3090 BAR1 and BAR3 resources were assigned.

Non-prefetchable-window failure
===============================

The same boot also shows an analogous failure for the ordinary memory
window.

Each RTX 3090 branch contains approximately:

    GPU BAR0:        16 MiB
    GPU ROM:        512 KiB
    HDA BAR0:        16 KiB

With bridge-window granularity, each child requests a 17 MiB ordinary
memory window. Its alignment is 16 MiB because of GPU BAR0.

Linux 7.0 assigned the nested parent at 0000:0a:00.0:

    [mem 0xf2000000-0xf46fffff]

This is 39 MiB. The ordinary-memory child requirements below that parent
are 17 + 1 + 2 + 17 + 1 + 1 = 39 MiB, again the plain sum.

The two 17 MiB GPU child windows alone cannot be packed into 34 MiB because
each requires a 16 MiB-aligned start. If the first begins at offset zero,
it ends at 17 MiB. The second cannot begin until offset 32 MiB and ends at
49 MiB. The smaller resources may fill some of the intervening gap, but
they do not make the 39 MiB parent large enough.

The first GPU child succeeds:

    pci 0000:0b:04.0: bridge window
      [mem 0xf2000000-0xf30fffff]: assigned

The second fails:

    pci 0000:0b:08.0: bridge window
      [mem size 0x01100000]: can't assign; no space
    pci 0000:0b:08.0: bridge window
      [mem size 0x01100000]: failed to assign

On 6.17, reassignment produced:

    0000:00:02.1:
      [mem 0xf2000000-0xf59fffff]              size 58 MiB
    0000:0a:00.0:
      [mem 0xf2000000-0xf57fffff]              size 56 MiB
    0000:0b:04.0:
      [mem 0xf2000000-0xf37fffff]              size 24 MiB
    0000:0b:08.0:
      [mem 0xf3800000-0xf4ffffff]              size 24 MiB

Both GPU BAR0 resources were then assigned.

Endpoint result on Linux 7.0
============================

Once 0000:0b:08.0 loses both bridge windows, allocation failure cascades to
the endpoint. BAR0, BAR1, BAR3, the ROM, and the audio BAR all report
"can't assign; no space". The resulting sysfs resources for GPU BAR0,
BAR1, and BAR3 are all zero.

NVIDIA then refuses to probe the device because BAR0 is zero. Only the RTX
5090 and the first RTX 3090 were usable.

Known-good result
=================

With 6.17.0-42 and:

    pci=realloc=on module_blacklist=nouveau

all relevant bridge windows and all physical BAR0, BAR1, and BAR3 resources
were assigned.

The system currently boots 6.17.0-42 and directly enumerates all four of
its current NVIDIA GPUs: RTX 5090, RTX 3090, RTX 3060, and RTX 3090.

Relationship to 3958bf16e2fe
=============================

The observed behavior seems consistent with the tail-side
multi-composite-resource problem described in this thread:

  * pbus_size_mem() sizes the parent as the plain sum of child sizes;
  * each composite child is larger than, and not an exact multiple of, its
    effective alignment;
  * assignment then inserts alignment padding between sibling children;
  * the parent did not budget for that padding;
  * 6.17 allocates a large enough parent while 7.0 does not.

The one-line max(r_size, align) -> ALIGN(r_size, align) change appears as if
it would cover this particular fixed topology, but I understand from the
discussion that it is not an acceptable general fix because it restores
unnecessary over-allocation and can regress systems with constrained
address space.

I have not verified the exact Ubuntu source against commit 3958bf16e2fe,
and I have not yet booted a kernel containing the newer proposed general
solution. Therefore I cannot yet prove the regression attribution by an
A/B test of the proposed patch.

Questions
=========

1. Does this look like the same multiple-composite-resource sizing
   regression to you?

2. Would this NVIDIA/AMD-X870E topology be useful as another test case for
   the newer series?

3. If so, which exact branch or patch-series revision should I test?

4. Is the intended solution expected to account for tail padding only when
   multiple composite children are present, using the final calculated
   alignment rather than unconditionally rounding every child to its own
   alignment?

5. Once accepted upstream, is this fix expected to be marked for stable
   backport to 7.0.y? Ubuntu 26.04 uses the 7.0 kernel series.

I have the complete failing 7.0 dmesg, complete successful 6.17 dmesg,
focused sysfs resource dumps, and current lspci output available. I can
provide sanitized copies or collect any additional read-only information
requested.

I can also test a candidate kernel, but this is a production multi-GPU
machine and I need to preserve the known-good 6.17 boot entry. Any test
would therefore be a one-time boot with a local-console and cold-power
recovery path rather than immediately replacing the default kernel.

Thanks,
JD

--000000000000deb234065d07199c
Content-Type: text/plain; charset="US-ASCII"; name="6.17-pci-success.txt"
Content-Disposition: attachment; filename="6.17-pci-success.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_muu3chhk0>
X-Attachment-Id: f_muu3chhk0

IyBOb3JtYWxpemVkIGV4Y2VycHQgZnJvbSBwcmU3LXN1Y2Nlc3Mta2VybmVsLmxvZyBhbmQgc3lz
ZnMgc25hcHNob3RzLgpMaW51eCB2ZXJzaW9uIDYuMTcuMC00Mi1nZW5lcmljCkNvbW1hbmQgbGlu
ZTogcGNpPXJlYWxsb2M9b24gbW9kdWxlX2JsYWNrbGlzdD1ub3V2ZWF1CjAwMDA6MDA6MDIuMSBN
ZW1vcnkgYmVoaW5kIGJyaWRnZTogZjIwMDAwMDAtZjU5ZmZmZmYgW3NpemU9NThNXQowMDAwOjBi
OjA0LjAgTWVtb3J5IGJlaGluZCBicmlkZ2U6IGYyMDAwMDAwLWYzN2ZmZmZmIFtzaXplPTI0TV0K
MDAwMDowYjowOC4wIE1lbW9yeSBiZWhpbmQgYnJpZGdlOiBmMzgwMDAwMC1mNGZmZmZmZiBbc2l6
ZT0yNE1dCjAwMDA6MTE6MDAuMCBCQVIwOiAweGY0MDAwMDAwLTB4ZjRmZmZmZmYKMDAwMDoxMTow
MC4wIEJBUjE6IDB4ZDAwMDAwMDAwMC0weGQ3ZmZmZmZmZmYKMDAwMDoxMTowMC4wIEJBUjM6IDB4
ZDgwMDAwMDAwMC0weGQ4MDFmZmZmZmYK
--000000000000deb234065d07199c
Content-Type: text/plain; charset="US-ASCII"; name="7.0.0-31-pci-failure.txt"
Content-Disposition: attachment; filename="7.0.0-31-pci-failure.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_muu3chj01>
X-Attachment-Id: f_muu3chj01

IyBOb3JtYWxpemVkIGV4Y2VycHQgZnJvbSBicmlkZ2UtdGVzdC1rZXJuZWwubG9nICgyMDI2LTA5
LTExKS4KIyBGdWxsIGhpc3RvcmljYWwgbG9nIG1heSBiZSBnaXRpZ25vcmVkOyB0aGlzIGV4Y2Vy
cHQgaXMgZGVsaWJlcmF0ZWx5IHRyYWNrZWQuCkxpbnV4IHZlcnNpb24gNy4wLjAtMzEtZ2VuZXJp
YwpwY2kgMDAwMDoxMTowMC4wOiBCQVIgMCBbbWVtIHNpemUgMHgwMTAwMDAwMCA2NGJpdF06IGNh
bid0IGFzc2lnbjsgbm8gc3BhY2UKcGNpIDAwMDA6MTE6MDAuMDogQkFSIDAgW21lbSBzaXplIDB4
MDEwMDAwMDAgNjRiaXRdOiBmYWlsZWQgdG8gYXNzaWduCnBjaSAwMDAwOjExOjAwLjA6IEJBUiAx
IFttZW0gc2l6ZSAweDgwMDAwMDAwMCA2NGJpdCBwcmVmXTogY2FuJ3QgYXNzaWduOyBubyBzcGFj
ZQpwY2kgMDAwMDoxMTowMC4wOiBCQVIgMyBbbWVtIHNpemUgMHgwMjAwMDAwMCA2NGJpdCBwcmVm
XTogZmFpbGVkIHRvIGFzc2lnbgowMDAwOjBiOjA4LjAgTWVtb3J5IGJlaGluZCBicmlkZ2U6IFtk
aXNhYmxlZF0KMDAwMDoxMTowMC4wIHJlc291cmNlIEJBUjA6IDB4MCAweDAgMHgwCjAwMDA6MTE6
MDAuMCByZXNvdXJjZSBCQVIxOiAweDAgMHgwIDB4MAowMDAwOjExOjAwLjAgcmVzb3VyY2UgQkFS
MzogMHgwIDB4MCAweDAK
--000000000000deb234065d07199c--
