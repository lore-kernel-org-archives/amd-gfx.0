Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EA0CA0EC4
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 22:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C82110E55F;
	Mon, 11 Aug 2025 22:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P2OKuOPW";
	dkim-atps=neutral
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D923310E55F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 22:00:23 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-30ba01fca64so1338700fac.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754949623; x=1755554423; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zCP4ho00X+PjquVtQfCWE44fAD3FJKmoX25g0jgSpKM=;
 b=P2OKuOPWt1V+kdos5sLv0ps4j0HaXlP2TNrk1Oo994YlcTTJruHo/y9BV61s2S9ZAv
 fJe5veLvpIbNHWW6tzT1nRoe0Yf7pE1knC/HH/8OgVLeWStMxvqpF+DiX200bZmeZTk/
 w+UlXCGnQTaOvUjGBmi5C+qFV8nniY6krFRGZ+FkAy+yB5N26uSxv8fPbWgrvoW8bcE5
 PBoRI3TXrfndtxwX9kN48lr14Fe2h9CWunvGXNa2uCJIj9xc97PvCgovhXDadqrIXeqc
 CSUtgGAoozp15eQdM2n+cc3clpPmVznrPqNLRXb4OUjHO+K6qCpz8ZxSbmguLuhInUVN
 sKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754949623; x=1755554423;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zCP4ho00X+PjquVtQfCWE44fAD3FJKmoX25g0jgSpKM=;
 b=jqZM6D8NnTdBeG9VoCDDflo/nQd+VLPRsHI326r/n1GLGjPFt0eKebGx7SsaU0SrUe
 QHAuH4F2KkR+B4LjBU0mOpH3rQ4rc7G8ZQ1Ex9YoX+B6GmTo7GBI2fGxpM+w94pStMyx
 BuOy53mQrJY+04MEp8fXb4+CpJnkl0cLYlzIPNoyt37qQdMFFcEoPXpCIQRSCuAUxpQR
 2CNbtvbQell7wT4oDaWbG/q32sBAsP8mmwnWhe2wJl+7Hf2X0GEJgdM1IZqhZZwh9LSB
 10nZJBS0pGZ4HbBJqMezsoGq78ljA+1+lMolcfFN1zSAhY9ibBMvK1/iyMS24QW3jV/F
 WzCA==
X-Gm-Message-State: AOJu0YwuZzuoosgCT7ka2leuCjEH3+AXw+8JZ1YUqJkHhoxzKIojPJat
 H/5If8nt2enGxYF/LOsi7ZwIMq8SGLtXnFbOWDclNYfwJQbmMSgDLDBXU47O+VPtmyxbBiRDpCx
 10y/ejI+zO7z/Qtm1N3ZTlXVqNP3MSKcopboEvg8=
X-Gm-Gg: ASbGncszd9RSkAoCQ+pj4b+sFJKO0QMnfgWujdiVeTj7rbW1THibj21sqEDY2VZT0NU
 qd4tqRsDaeFAjNEpX3uoDRD5YvDNyNwB2D9A9N9g5jDo0sLp+VhhEgL5UuHH4iK+LCpsEM7RiQh
 KTOzRBXAwe0tvePZVCoCLBRgfZM5yqaXGlmhlOuLgM0EK88bGvUFINYnkEQ2vIA9WBbViGo/OGo
 T4fnRbfOtaXxYvWCi4=
X-Google-Smtp-Source: AGHT+IGbncZCKPrV27qiZtr73sFLCzBkAJC7EEdlM88YFZy05NvZTD3o6BjzWKYwpIsbzMh+yw/TaRCMXV5TzpVrXGE=
X-Received: by 2002:a05:6871:d202:b0:30b:cd02:297c with SMTP id
 586e51a60fabf-30c950efbc9mr969546fac.35.1754949622637; Mon, 11 Aug 2025
 15:00:22 -0700 (PDT)
MIME-Version: 1.0
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Mon, 11 Aug 2025 18:00:11 -0400
X-Gm-Features: Ac12FXxzkHJXPEEjjCVSmYjWaPGQD3sQxNY72D0MB0sOTcn3-KCaZ9krPqoVEhE
Message-ID: <CAPEhTTH90Rz-UFVJCdsi=vP5BSuQxVB3W-Qe1yVKH93txBLFsA@mail.gmail.com>
Subject: AMDGPU's rings VS Radeon's
To: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>, 
 Alexander Deucher <alexander.deucher@amd.com>
Content-Type: multipart/alternative; boundary="000000000000db31c3063c1e0c03"
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

--000000000000db31c3063c1e0c03
Content-Type: text/plain; charset="UTF-8"

Hi,

For those who know, I'm still working on VCE1 enablement under AMDGPU.
Progress is happening, slowly but surely. While investigating the ring init
calls, a few elements catched my attention and I'd like some help in
figuring out the differences between AMDGPU's ring sizes and Radeon's ones.

1- I understand that the size parameter changed from bytes
under radeon_ring_init to dword under amdgpu_ring_init. That being said,
some values don't seem to be equivalent between Radeon and AMDGPU. For
example, GFX ring size went from 1024 * 1024 bytes to 1024 dwords (for most
GFX versions), which seems off even when taking into account how
amdgpu_ring_init calculates the final allocated size. This question is more
about understanding than a problem strictly speaking.

2- Under AMDGPU, SI's GFX (GFX6) ring size is 2048, while this value is
1024 for all the other GFX versions. Under Radeon, the GFX ring size values
are all the same (1024 * 1024) under Evergreen/SI/CIK/NI and others. Is
there any reason why SI's GFX6 ring size would be twice the size of the
other values under AMDGPU?

3- Would it be acceptable to add names to rings under Radeon, the same
names as the ones used under AMDGPU? I think it is more talkative for the
average user and for debugging purposes to deal with ring names than
indexes. I already have patches in my code to address this suggestion.

That's all for now.

Cheers
Alexandre Demers

--000000000000db31c3063c1e0c03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>For those who know, I&#3=
9;m still working on VCE1 enablement under AMDGPU. Progress is happening, s=
lowly but=C2=A0surely. While investigating the=C2=A0ring init calls, a few =
elements catched my attention and I&#39;d like some help in figuring out th=
e differences between AMDGPU&#39;s ring sizes and Radeon&#39;s ones.</div><=
div><br></div><div>1- I understand that the size parameter changed from byt=
es under=C2=A0radeon_ring_init to dword under amdgpu_ring_init. That being =
said, some values don&#39;t seem to be equivalent between Radeon and AMDGPU=
. For example, GFX ring size went from 1024 * 1024 bytes to 1024 dwords (fo=
r most GFX versions), which seems off even when taking into account how amd=
gpu_ring_init calculates the final allocated size.=C2=A0This question is mo=
re about understanding than a problem strictly speaking.</div><div><br></di=
v><div>2- Under AMDGPU, SI&#39;s GFX (GFX6) ring size is 2048, while this v=
alue is 1024 for all the other GFX versions. Under Radeon, the GFX ring siz=
e values are all the same (1024 * 1024) under Evergreen/SI/CIK/NI and other=
s. Is there any reason why SI&#39;s GFX6 ring size would be twice the size =
of the other values under AMDGPU?</div><div><br></div><div>3- Would it be a=
cceptable to add names to rings under Radeon, the same names as the ones us=
ed under AMDGPU? I think it is more talkative for the average user and for =
debugging purposes to deal with ring names than indexes. I already have pat=
ches in my code=C2=A0to address this=C2=A0suggestion.</div><div><br></div><=
div>That&#39;s all for now.</div><div><br></div><div>Cheers</div><div>Alexa=
ndre Demers</div></div>

--000000000000db31c3063c1e0c03--
