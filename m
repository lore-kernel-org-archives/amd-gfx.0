Return-Path: <SRS0=bOP+=ZI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BA5C432C3
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 16:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC974214DE
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 16:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC974214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 922C66E184;
	Sat, 16 Nov 2019 16:25:07 +0000 (UTC)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0DCC6E180
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2019 16:22:13 +0000 (UTC)
Received: by mail-ot1-x342.google.com with SMTP id 19so824329otz.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2019 08:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=Qej+l/EyujvFjhIzT86Yo6gM1P2Xqkr228ppXC/Ez2E=;
 b=DyD3KT68/snlgb3lczCZqwT8LwhMaH2GMqm3RDIEna1g8b21dQ5I+FbWj/hOcrYZnh
 SI4t3rutvdetAcNnoZUyPxmY3h5M310Y+V/G6So9mAIhdaRL2yek3dZ70R0DIANPS2HB
 cXagunrckYzK98XEAKO0uNc9LAUO0wZLhxKwXFEyQxCvjaaeUKPqvFAHFtf3p/YCmVKA
 sa76IKUzMpYwZiOdlNgSncJsgrloreYz4o7ld84FazCnqMYQRZPzzG2SL1NdpXHNwJNz
 gS8ZSteA6agNob7c+zjFYi7Aw1DL1ofvy0olbkMgDWnOKMF22bQPdEQcjhIr+1xYTf6e
 3FQw==
X-Gm-Message-State: APjAAAW8mPCEB1gyrXJz+ZV9I+Z69DZJ+ypgyuXVek8tSDn1uC1Ppw6C
 fnjPi8p6TxoKX7lAPGWomNNUWm0x8cDc4CLDsno=
X-Google-Smtp-Source: APXvYqyL0NKH2OxK6vowdNdRUDcLolfT43AAHA/grMC8byn2JBqhtgh2R6GeHPyw3F5XEDQpNvpDY3iJ8lkXHNm/NcY=
X-Received: by 2002:a9d:6f92:: with SMTP id h18mr9169868otq.242.1573921333200; 
 Sat, 16 Nov 2019 08:22:13 -0800 (PST)
MIME-Version: 1.0
From: Iago Abal <iago.abal@gmail.com>
Date: Sat, 16 Nov 2019 17:21:37 +0100
Message-ID:
 <CAGbDTvpmPfrK=7a=mbnR-gKgi2ah+w6AeGYDU+9M9JOnWTzhBQ@mail.gmail.com>
Subject: Potential BUG: [PATCH 2/8] drm/amdgpu: add a generic fb accessing
 helper function(v3)
To: "Tianci.Yin" <tianci.yin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
X-Mailman-Approved-At: Sat, 16 Nov 2019 16:25:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=Qej+l/EyujvFjhIzT86Yo6gM1P2Xqkr228ppXC/Ez2E=;
 b=szL3CmF95u0l7A3p0cRo+EuEJqGW4nAiAlbNNp0C1g/QWxEoIE6rCYo5v6bml0Ro0/
 aOd4rc3T1Z2lbxAJFsJo4Y6SgyFUHkQowQgFfSe/JO+kii2FFckAKFkmdvlWn68XnA+D
 Qomf7aAVCP/uYW9VuLAKfhbltOj9OdEAl1SQrqhSo5EqMWFlyWlqBgzzY5EFjEoaWSAm
 AF0l5No6GHiS8fZLv0SEZowlSN4qqyiWTIzFH0lus9GhwF17Qv9/OamFHGlLE739kzas
 haoLDawzG/s92OFmcv0DceYM1cKDGsyW5PNsNAAHTinMDebv44mYPwJUIMzLbXA6s4w3
 5anQ==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Content-Type: multipart/mixed; boundary="===============0846713704=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191116162137.ch23-AWmteas0QpFwf-mWdqsbzg--r1XfXzkAUWUtDY@z>

--===============0846713704==
Content-Type: multipart/alternative; boundary="000000000000f84ab90597791de4"

--000000000000f84ab90597791de4
Content-Type: text/plain; charset="UTF-8"

Hi,

With the help of a static bug finder (EBA - https://github.com/IagoAbal/eba)
I have found a potential double lock in Linux Next tag next-20191115, file
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c.

This bug seems to be introduced by commit
e35e2b117f4 ("drm/amdgpu: add a generic fb accessing helper function(v3)").

The steps to reproduce it would be:

1. Start in function `amdgpu_device_vram_access`.
2. Enter for-loop `for (last += pos; pos <= last; pos += 4)`.
3. First lock: `spin_lock_irqsave(&adev->mmio_idx_lock, flags)`.
4. Call to `WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000)`.
   5. Note `#define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v),
AMDGPU_REGS_NO_KIQ)`.
   6. Continue in function `amdgpu_mm_wreg`.
   7. Take else-branch in the third if-statement.
   8. Double lock: `spin_lock_irqsave(&adev->mmio_idx_lock, flags)`.

I think the control flow could reach that second lock, but you may know
better.

Hope it helps!

-- iago

--000000000000f84ab90597791de4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>With the help of a static bug finder (EBA - <a =
href=3D"https://github.com/IagoAbal/eba">https://github.com/IagoAbal/eba</a=
>) I have found a potential double lock in Linux Next tag next-20191115, fi=
le drivers/gpu/drm/amd/amdgpu/amdgpu_device.c.<br><br>This bug seems to be =
introduced by commit<br>e35e2b117f4 (&quot;drm/amdgpu: add a generic fb acc=
essing helper function(v3)&quot;).<br><br>The steps to reproduce it would b=
e:<br><br>1. Start in function `amdgpu_device_vram_access`.<br>2. Enter for=
-loop `for (last +=3D pos; pos &lt;=3D last; pos +=3D 4)`.<br>3. First lock=
: `spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock, flags)`.<br>4. Call to `W=
REG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000)`.<br>=C2=A0 =C2=A05.=
 Note `#define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGP=
U_REGS_NO_KIQ)`.<br>=C2=A0 =C2=A06. Continue in function `amdgpu_mm_wreg`.<=
div>=C2=A0 =C2=A07. Take else-branch in the third if-statement.<br>=C2=A0 =
=C2=A08. Double lock: `spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock, flags=
)`.<br><br>I think the control flow could reach that second lock, but you m=
ay know better.</div><div><br>Hope it helps!<br clear=3D"all"><div><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><br>-=
- iago</div></div></div></div>

--000000000000f84ab90597791de4--

--===============0846713704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0846713704==--
