Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F97C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 15:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C319F2310C
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 15:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C319F2310C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6797A6E536;
	Thu, 10 Dec 2020 15:02:02 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E65D66E536
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 15:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QQSj6rLbCn8bmwL8wDdAWEQ81KFgxrdhzEsuvqSpEEw=; b=PD3yFF7gOrEghR3YBFHGkMm+W
 jbNKCzA0M64EmD9VA+ComicFXecmvW+bRiaREOz/3pfYg16GBNf4oLh1WswUTWQux2c25aA6E9Fon
 ScJNOVgpczvKzxH6vU233wQGAJEZZ6vFuSMhXeBwxnxup22lAr33almbiC27DHwZJG0aMewkKMDJM
 G5RNEN5tNkrpsrArQ7Bi4OPGgfjLM70hbt1Znzrc92Zkys90ucP7s6RdfqDW7HfKrQOnGmywIQEPF
 hEHaZgw3h374cXtNq4FI30WlU7eMhl+zyIzhCmRm7XaEAnD3JKr0F7gJJSrHOfuf3YuG7vbFwqpTE
 sQC6O9Yug==;
Received: from [2001:8b0:897:1650::2]
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1knNSA-000557-WF; Thu, 10 Dec 2020 15:01:59 +0000
Date: Thu, 10 Dec 2020 13:59:25 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: christian.koenig@amd.com
Subject: Re: [PATCH] amdgpu: resize BAR0 to the maximum available size,
 even if it doesn't cover VRAM
Message-ID: <58E21FF244%devspam@moreofthesa.me.uk>
In-Reply-To: <621ae252-ab39-383e-61a9-746fb47c6e01@gmail.com>
References: <20201210005744.5877-1-devspam@moreofthesa.me.uk> 
 <621ae252-ab39-383e-61a9-746fb47c6e01@gmail.com>
Mail-Followup-To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org, 
 Darren Salt <devspam@moreofthesa.me.uk>
User-Agent: Messenger-Pro/2.73.6.4250 (Qt/5.11.3) (Linux-x86_64)
X-No-Archive: no
X-Orwell-Date: Thu, 13159 Dec 1984 13:59:25 +0000
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1454987343--1007793855--1630567166"
X-SA-Exim-Connect-IP: 2001:8b0:897:1650::2
X-SA-Exim-Mail-From: devspam@moreofthesa.me.uk
X-SA-Exim-Scanned: No (on spam.moreofthesa.me.uk);
 SAEximRunCond expanded to false
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This message is in MIME format.

--1454987343--1007793855--1630567166
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I demand that Christian K=C3=B6nig may or may not have written...

> Am 10.12.20 um 01:57 schrieb Darren Salt:
>> This allows BAR0 resizing to be done for cards which don't advertise
>> support for a size large enough to cover the VRAM but which do adverti=
se
>> at least one size larger than the default. For example, my RX 5600 XT,=

>> which advertises 256MB, 512MB and 1GB.

> I've never seen such a configuration except for engineering samples. Ca=
n
> you send me a dump of the relevant PCI configuration space?

=E2=80=9Clspci -nn -v -xxxx=E2=80=9D output is attached. (Sapphire RX 560=
0 XT Pulse; not an
early one.)

My current kernel has another patch, applied on top of this patch, which
allows ignoring the size list. As such, that BAR is currently 8GB instead=
 of
the 1GB which it should be. I've not noticed any significant problems as =
yet.

If the card should be advertising larger sizes too then its VBIOS needs
fixing; but as a lot of these already out there won't get that fix, some =
sort
of override (quirk, I expect, with a module option for cards not covered)=

would, I think, be warranted.

> In general we could do this, but instead of just blindly trying=20
> different values we should just pick a supported one in the first place=
.

By using pci_rebar_get_possible_sizes() etc.? That looks reasonable to me=
.
It'll also require some patching in the PCI subsystem to expose relevant
functions.


--1454987343--1007793855--1630567166
Content-Type: text/plain; name="gpu-lspci-dump.txt"
Content-Disposition: attachment; filename="gpu-lspci-dump.txt"
Content-Transfer-Encoding: quoted-printable

28:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [A=
MD/ATI] Device [1002:731f] (rev ca) (prog-if 00 [VGA controller])=0A=
	Subsystem: Sapphire Technology Limited Device [1da2:e416]=0A=
	Flags: bus master, fast devsel, latency 0, IRQ 41=0A=
	Memory at 600000000 (64-bit, prefetchable) [size=3D8G]=0A=
	Memory at 500000000 (64-bit, prefetchable) [size=3D256M]=0A=
	I/O ports at e000 [size=3D256]=0A=
	Memory at fcb00000 (32-bit, non-prefetchable) [size=3D512K]=0A=
	Expansion ROM at fcb80000 [disabled] [size=3D128K]=0A=
	Capabilities: [48] Vendor Specific Information: Len=3D08 <?>=0A=
	Capabilities: [50] Power Management version 3=0A=
	Capabilities: [64] Express Legacy Endpoint, MSI 00=0A=
	Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+=0A=
	Capabilities: [100] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=3D=
010 <?>=0A=
	Capabilities: [150] Advanced Error Reporting=0A=
	Capabilities: [200] #15=0A=
	Capabilities: [240] Power Budgeting <?>=0A=
	Capabilities: [270] #19=0A=
	Capabilities: [2a0] Access Control Services=0A=
	Capabilities: [2b0] Address Translation Service (ATS)=0A=
	Capabilities: [2c0] Page Request Interface (PRI)=0A=
	Capabilities: [2d0] Process Address Space ID (PASID)=0A=
	Capabilities: [320] Latency Tolerance Reporting=0A=
	Capabilities: [400] #25=0A=
	Capabilities: [410] #26=0A=
	Capabilities: [440] #27=0A=
	Kernel driver in use: amdgpu=0A=
00: 02 10 1f 73 07 04 10 00 ca 00 00 03 10 00 80 00=0A=
10: 0c 00 00 00 06 00 00 00 0c 00 00 00 05 00 00 00=0A=
20: 01 e0 00 00 00 00 b0 fc 00 00 00 00 a2 1d 16 e4=0A=
30: 00 00 b8 fc 48 00 00 00 00 00 00 00 ff 01 00 00=0A=
40: 00 00 00 00 00 00 00 00 09 50 08 00 a2 1d 16 e4=0A=
50: 01 64 03 f0 08 00 00 00 00 00 00 00 00 00 00 00=0A=
60: 00 00 00 00 10 a0 12 00 a1 8f 00 00 30 29 09 00=0A=
70: 04 0d 40 00 40 00 04 11 00 00 00 00 00 00 00 00=0A=
80: 00 00 00 00 00 00 00 00 9f 09 73 00 40 04 00 00=0A=
90: 1e 00 80 01 04 00 1f 00 00 00 00 00 00 00 00 00=0A=
a0: 05 00 81 00 00 40 e0 fe 00 00 00 00 22 40 00 00=0A=
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
100: 0b 00 01 15 01 00 01 01 00 00 00 00 00 00 00 00=0A=
110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
150: 01 00 02 20 00 00 00 00 00 00 00 00 30 20 46 00=0A=
160: 00 20 00 00 00 20 00 00 a0 00 00 00 00 00 00 00=0A=
170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
1a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
200: 15 00 01 24 00 70 00 00 40 0d 00 00 e0 1f 00 00=0A=
210: 02 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
240: 04 00 01 27 00 00 00 00 00 81 07 00 00 00 00 00=0A=
250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
270: 19 00 01 2a 00 00 00 00 00 00 00 00 00 7f 00 7f=0A=
280: 00 7f 00 7f 00 7f 00 7f 00 7f 00 7f 00 7f 00 7f=0A=
290: 00 7f 00 7f 00 7f 00 7f 00 7f 00 7f 00 00 00 00=0A=
2a0: 0d 00 01 2b 00 00 00 00 00 00 00 00 00 00 00 00=0A=
2b0: 0f 00 01 2c 20 00 00 80 00 00 00 00 00 00 00 00=0A=
2c0: 13 00 01 2d 00 00 00 01 00 01 00 00 00 00 00 00=0A=
2d0: 1b 00 01 32 06 10 00 00 00 00 00 00 00 00 00 00=0A=
2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
320: 18 00 01 40 01 10 01 10 00 00 00 00 00 00 00 00=0A=
330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
390: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
3a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
3b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
3c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
3d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
400: 25 00 01 41 01 00 00 80 01 00 00 80 00 00 00 00=0A=
410: 26 00 01 44 00 00 00 00 00 00 00 00 0f 00 00 00=0A=
420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
430: f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0=0A=
440: 27 00 01 00 00 00 00 00 38 9c 00 00 38 9c 00 00=0A=
450: 38 9c 00 00 38 9c 00 00 38 9c 00 00 38 9c 00 00=0A=
460: 38 9c 00 00 38 9c 00 00 38 9c 00 00 38 9c 00 00=0A=
470: 38 9c 00 00 38 9c 00 00 38 9c 00 00 38 9c 00 00=0A=
480: 38 9c 00 00 38 9c 00 00 00 00 00 00 00 00 00 00=0A=
490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
4a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
710: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
7a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
8b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
910: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
930: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
9a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
9b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
9c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
9d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
a10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
aa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
cc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
cd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
d10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
da0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
f10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
f20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
f30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
f40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
f50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
f60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
f70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
f90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
fa0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=

--1454987343--1007793855--1630567166
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--1454987343--1007793855--1630567166--
