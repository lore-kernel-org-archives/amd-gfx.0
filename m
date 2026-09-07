Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38087C79FAA
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 07:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0F310EA7A;
	Tue,  8 Sep 2026 07:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WV6j5MHZ";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F28710E029
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 14:48:54 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c1677c91969so352452566b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 07:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788792533; cv=none;
 d=google.com; s=arc-20260327;
 b=Y4pmiRqeOKh0ymYmnj5FLf/5bIhC3Gc2GfNuXoaHPJoFnF4xyqrBPtEFLkA0mliAbi
 4QiZAGfSdt+kyVqHw/+vSzjfGx6j+vBuXyWwuuvpDRYg1BBI5puL+nOtJVMbXTa6vKK4
 lxFpe5WeL4c8UFwJXcXkduc3/gya0fW1TPHucye4CzPp1D4ZieeBtbDee71/hilXBgtx
 xrnZwrG67bMHaT/zdF0rlTU+zizUOrU6D134Owv2W+yFT2c1REfbSYJNpBVBhAhyl+Rt
 imAmMwpIHJKO5dKKclhyDQz2FvxofGqEnOSoRS97HwBuOP483/om24Bim23hwYA0Duyq
 pOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=OQ7lVrdGCVQfqjoDQj3oh9/Z+LDJpxNUrYSzk3foVl0=;
 fh=geMBmAMrDI/d0qXCKVZcR+Wx0K45qwayyyBkCttQKm0=;
 b=oniqXzCnbkNdEnBMG4bGym+tVjj2PJfDzECBWtTqET+oNdrXElduRV+go37HpsmVo4
 h9phOFyPbdBBNt5AFhW683r/f+ocYOCFjMpiKtMhmscnCrCI6TqUV5h5OKHhTtvrMzFu
 fnFKMUeeMJg0aSMuRQE3psg7P5kj504YVF8pMloPKaNL5n8rPUssBr+rQpqILz+RnTjp
 1fi3tLnRK1DV0X28pVlX+Q8EQz1PqOKBy7Gjyz1Iz6pfiCPnlthwUXJGcr/CpATNBOZs
 Dw4OOGuL+VKPt0mCBBduZkHpZJbcodOTdw+2M83tX8Dwe8rSVv9/wZVrAP38wO9/7fJO
 2x1w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788792533; x=1789397333; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OQ7lVrdGCVQfqjoDQj3oh9/Z+LDJpxNUrYSzk3foVl0=;
 b=WV6j5MHZvZLVJQDIGrVkBoC9Ui2/GGqJtL4tMZYX0YH1bWPpjtOmWKM1g+WVVxfT4Q
 Y4ADySBRN7hdmis6YBbdqLF6Z0ZaUHPyMkt+/Zt8iKe2jkux1WhdvOIWP9/ub/3HOJlx
 7wL0+0auvdJEkvzjFYNGKGRw5MhVSc0SlaX2GkpJgAyAQKv4meOMeCT/gJRTnPQwN6Zs
 NX6A2oW3gqp1eXOQcRpw3R2fXCp+a3mDop7oVo3Fu+4+xw6WufTN1kO97EmTugbVuYY2
 5o6QVQ5p4cF4xpmx64mgzDYG9ynZvOgqQTZgM9dbr6l8FC8OzrX5YVQ/kMumxbLMPusp
 p4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792533; x=1789397333;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OQ7lVrdGCVQfqjoDQj3oh9/Z+LDJpxNUrYSzk3foVl0=;
 b=cjlwJtK4q32t774Ywa/Y+Ju+AFc9AEm7qRE81Dq8CWm0qtWVyZyrsMcKY9OLGAAwA1
 +KxFm31bD7ZGPx+pMUU+wAsP/+IrGoDx6rGIk41zLWiBAi4XbkMnBbydgXu8g2TAx9b3
 EwXjw29wTWycvX86z9OJ7MYZ7Xx3Nhb+qJpSSin6GnHPInsH3VDf5nByPUedHTclyAdC
 Pd7FEVLYjZBJKsUMaX2m0+6e9jN2FnjMBUxaXzdkHbn/Q3wN+ke1CbLmQplwDtzQJ+3S
 GtYctyBlNUng8UVvC8JGhC1K4cQBtmtJ71B5v4F8ZsSrfVaDcRvhLiIbDUWqrBZFbGOU
 2p0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFu0U5NmWBieZIDRvrKh3RRSPW+rtcxofZ/2QgQLD9nJ/+4jwAcBQrI8MUzPQBZ4+O0Z4ygoVu@lists.freedesktop.org
X-Gm-Message-State: AFuF++n5urrjb2uB5yjc5xLqUOhO++K37p5F5EaOhjZQ0zcMGeKiTWV5
 P3hOyB8NpO9qx/jAKw4YAyBaa7B7E1AiTTHFKwsdaau2qNJ1xxfBAX4qAPrNIScROhAqASYF1cP
 OW4xf0OTP4P8Z2O4j6I2IYFQwTcTu2g==
X-Gm-Gg: AYBFou0u+MB0/3JZ2kUzslK0/hcR1qQuR746Gxe0A//ylDMx2ihlFrneVwkLN9cXI4y
 Jw1pb2Si8/RKFlKM53tU5jtc+2VZBqkg7mFFBWGq6dtULb241Aieo6kmzbaIW4U+RkSYXj3rGRU
 rDoXVgi4dz2ttT2DudgcxgMTRS6OzZNaGfP0OuTVLsdbDi0NDf56v6fm8oPSVMnww3v8xzhJPaH
 eFikq13Y0kS346vY6j1nBMPp4DXRUFbZIX3A0ppgsyVUlfOevNuE8BJew+btxft3C7kjtpNTwVx
 fxBrFtVD8WNP3aWHX+Y8Mtv1HSLnXmzx4o1wVOF8Qp0mSex1L97nf1MMRNqZZauz3CRRSihYExW
 ClA==
X-Received: by 2002:a17:907:6ea3:b0:c26:1649:47b6 with SMTP id
 a640c23a62f3a-c261649567dmr708618466b.44.1788792532708; Mon, 07 Sep 2026
 07:48:52 -0700 (PDT)
MIME-Version: 1.0
From: Danilo Machado <danilomachado2002@gmail.com>
Date: Mon, 7 Sep 2026 11:48:39 -0300
X-Gm-Features: AcwNN1UYGAl9fInNCucS_mKxp2HpZrVX_UzawXxul5SC_lkUXXXY-amPXm2bMTA
Message-ID: <CAJ9xWrJNbB1H6r-bTsTXzhagck2L-Cz0zQczd2Qqbi9-W9oPOA@mail.gmail.com>
Subject: Re: [BUG REPORT] AMD Radeon R9 380 (Tonga) - HDMI no signal after
 suspend / regression tracking update
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, dri-devel@lists.freedesktop.org, 
 linux@leemhuis.info
Content-Type: multipart/alternative; boundary="0000000000007d3250065ae5b7af"
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:21:13 +0000
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

--0000000000007d3250065ae5b7af
Content-Type: text/plain; charset="UTF-8"

#regzbot back in-progress
#regzbot monitor
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389
#regzbot monitor https://gitlab.freedesktop.org/drm/amd/-/work_items/5123

Hi Thorsten, Alex, and Linux Kernel Maintainers,

I am writing to update the status of this regression after checking the
Regzbot tracking dashboard:
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAOnW2VTGBP=MMWM=W41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.com/

The dashboard currently lists this issue as "fizzled out / resolved:
inconclusive", but I want to clarify that this bug is ACTIVE, UNRESOLVED,
and actively tracked. The lack of recent email activity on LKML was due to
ongoing technical data collection on Launchpad and GitLab while awaiting
upstream feedback.

Current Status & Verification:

1. Launchpad Report (#2142389):
   - Status: Confirmed (assigned to maintainer Timo Aaltonen).
   - Heat/Users: 220 Bug Heat points with 44+ explicitly confirmed affected
users across various AMD architectures (Tonga R9 380, Polaris RX 400/500,
and recent Vega APUs).
   - Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389

2. Freedesktop GitLab Issue (#5123):
   - Status: Open.
   - Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5123

3. Technical Summary:
   - I have executed 3 full git bisect routines on hardware testbenches,
isolating the regression behavior between kernel transitions.
   - Recent user reports confirm the same black screen / no EDID handshake
failure upon resume and DPMS display wake-up across multiple Linux
distributions (Ubuntu, Fedora, Void Linux) and kernel versions (up to
kernel 7.0).

Please re-open and maintain active tracking for this regression on Regzbot.
I remain available to test candidate patches, kernel builds, or debug flags
on physical hardware.

Best regards,
Danilo Machado

--0000000000007d3250065ae5b7af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br clear=3D"all"></div>#regzbot back in-progress<br>=
#regzbot monitor <a href=3D"https://bugs.launchpad.net/ubuntu/+source/linux=
/+bug/2142389">https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389=
</a><br>#regzbot monitor <a href=3D"https://gitlab.freedesktop.org/drm/amd/=
-/work_items/5123">https://gitlab.freedesktop.org/drm/amd/-/work_items/5123=
</a><br><br>Hi Thorsten, Alex, and Linux Kernel Maintainers,<br><br>I am wr=
iting to update the status of this regression after checking the Regzbot tr=
acking dashboard:<br><a href=3D"https://linux-regtracking.leemhuis.info/reg=
zbot/regression/lore/CAOnW2VTGBP=3DMMWM=3DW41uPDLrzTVHM1sw8P1myvftnNk0vEMMF=
w@mail.gmail.com/">https://linux-regtracking.leemhuis.info/regzbot/regressi=
on/lore/CAOnW2VTGBP=3DMMWM=3DW41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.=
com/</a><br><br>The dashboard currently lists this issue as &quot;fizzled o=
ut / resolved: inconclusive&quot;, but I want to clarify that this bug is A=
CTIVE, UNRESOLVED, and actively tracked. The lack of recent email activity =
on LKML was due to ongoing technical data collection on Launchpad and GitLa=
b while awaiting upstream feedback.<br><br>Current Status &amp; Verificatio=
n:<br><br>1. Launchpad Report (#2142389):<br>=C2=A0 =C2=A0- Status: Confirm=
ed (assigned to maintainer Timo Aaltonen).<br>=C2=A0 =C2=A0- Heat/Users: 22=
0 Bug Heat points with 44+ explicitly confirmed affected users across vario=
us AMD architectures (Tonga R9 380, Polaris RX 400/500, and recent Vega APU=
s).<br>=C2=A0 =C2=A0- Link: <a href=3D"https://bugs.launchpad.net/ubuntu/+s=
ource/linux/+bug/2142389">https://bugs.launchpad.net/ubuntu/+source/linux/+=
bug/2142389</a><br><br>2. Freedesktop GitLab Issue (#5123):<br>=C2=A0 =C2=
=A0- Status: Open.<br>=C2=A0 =C2=A0- Link: <a href=3D"https://gitlab.freede=
sktop.org/drm/amd/-/work_items/5123">https://gitlab.freedesktop.org/drm/amd=
/-/work_items/5123</a><br><br>3. Technical Summary:<br>=C2=A0 =C2=A0- I hav=
e executed 3 full git bisect routines on hardware testbenches, isolating th=
e regression behavior between kernel transitions.<br>=C2=A0 =C2=A0- Recent =
user reports confirm the same black screen / no EDID handshake failure upon=
 resume and DPMS display wake-up across multiple Linux distributions (Ubunt=
u, Fedora, Void Linux) and kernel versions (up to kernel 7.0).<br><br>Pleas=
e re-open and maintain active tracking for this regression on Regzbot. I re=
main available to test candidate patches, kernel builds, or debug flags on =
physical hardware.<br><br>Best regards,<br>Danilo Machado</div>

--0000000000007d3250065ae5b7af--
