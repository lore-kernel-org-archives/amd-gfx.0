Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AD5CD98E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 08:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B456B10E286;
	Mon, 15 Jun 2026 08:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l98ndnW/";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C4410F532
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 13:12:58 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-68bac6e24fdso1378758a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 06:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781269977; cv=none;
 d=google.com; s=arc-20240605;
 b=fvi6YJh2N+OQvaTNmc+2zpe7/93P9YECFEOCJow2x2fe898a3pXFpRzwQL0PtwWaQJ
 0I8KGmzs9OWWngVcNwN0WhMS4JhCm4PC1ddseTas5wsfwaZGO3N9dd6Vz88BNSB1FmOR
 mI0KicZzoTc02egl68Sy9mZdaP/FCfBfgMuiFzd4vNmSmsjSEuZe1LVuBeaT+49XEiZr
 DbhL5pU/jYToYjikYqEtckqP1omdt9FzFi5I1b+rtPfI8rrYJCeRM0Dne3HvgOQ78yQp
 jrgzcmNBy859Ey8BQkpb6WHuAKoEaYG3utEdlmtd09gO2966myhjHTwc28aoPdP0mkBL
 j54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=GSSknmasOOr0Sk4JQ3Fp8HwhccUZOTuxyttvWjwU/xQ=;
 fh=cEzkBcAwPRFfNJNEZvYrTvCyjGQ21UcqxHoc4leqpzQ=;
 b=Hjd0/V6CJRUgNYyUpseo0etgV8G6HxXN71WMCW808f8j/JbU0c59/KaMcdUpk42swd
 84Y10TiWB37I/LUQEDWM4/WHfxfoIYgyLE4vpa63Uc23iG9fX3S9Gi340rRpaTL2nMq7
 vKIc3JCWWdrhSzlyg25eR7/9GFwXib2J9uNy58p+2HUf2a3yJkPUaq0yvpjDUVJExJRa
 u7bZ04veUeqZLjDA0NFq9J27dV/4oUdm1nIREX+1os7mEaTZ9HJf3Ha8Pux1nTLeDV19
 WD5W/wcmDA9I/u/8T5y6fEEGpOnSMyzhARlk6OVzIGCHB0Zzh+Yf1kLMgEe3Zqmrbglq
 y4uQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781269977; x=1781874777; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GSSknmasOOr0Sk4JQ3Fp8HwhccUZOTuxyttvWjwU/xQ=;
 b=l98ndnW/VIY/2MfAHU+mvFpkSrh7mnR714glXDeBrDF9g5YIlYd6pY0GgPjb1U4NSE
 bKwr59szzsO2ebx1ksSkxId1x2vw1CHLAG69OXEUAKp19SaXvAlhKHA9sr9HGgCJmo6p
 b6wHdP0lCa8S1ljV0CuQg7S+aKyfOt0WY9cBv0blWnQL5+TdYTGz5xYv+IbxXy1QovHv
 hUQNR8DiSCBjlAs2rCZ1+LrXYRsr6C7or3wLnoo82zRvfuzEood3/GyDpg8d951JEL00
 ww7/u3WaiIgqC3jvUwy8wHtcdW4/0mbEIsrTziUfBPZDDqiRZQPKY8G3kUCYb5lfsiqk
 LJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781269977; x=1781874777;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GSSknmasOOr0Sk4JQ3Fp8HwhccUZOTuxyttvWjwU/xQ=;
 b=ipmo2BX/fdMc8ZqDV+EnOFN4oTlx8/qZ9TZhMueTit6bz/4b9qkyU/bq2T+No7hP5w
 I6hOFeCBn2581N94XP8LxuVt5mYL88M5Ea+uwIvNomQehjMXkqH+Be9m0Uq3fPQ0jFdv
 ypKpnfGD2bWHG+rqaXuiyrXBkNogMDDJ4Nxxo2bFCsubCK/zJqUAyCVpAwnhMc+HCSxF
 0Zsr3pBnLO2YfEP/fevlZ9PypTKtGRSkJC2YRbzV0/hEOcFhEpyBD3Ju/111H4mTNBcF
 JYxw+LthgEKD1xc418memUf1W4UalOXVF9mcYRkVFOG2MRmZJOGEtBe4SLsAyfTwaP09
 3xRg==
X-Gm-Message-State: AOJu0Yz9MgUUZbUZOiT4kwHb9dK0gGKRL3LWfI9dCcKlNaCYB4NfsoVF
 6n+dNVjXpPmZm8/yiww1/tZIVkUpN+YoRM6kwXO6ozlgjou+IMySOlMbB7Ih7LlCSQ4yelV0d1e
 qJXArA0w09BDN20uXWFy/AXYWoc+KksPgah0RemE=
X-Gm-Gg: Acq92OFz4a7WIg5lks2hXNjKTGejD+Mlme6I0Sw93uBr9Sqe09J7K4FHnISinTeWE+V
 TddM6xuvgsYP0ANC3zbK12bW5qQBlUPBhbbG7Ndukp4RNEL7aC8HCg5DmqF//0Q1+PFHqQMVBwU
 1pshEdGFl06KkVVhwG8ie6ZPC7cf+/RNZ1imchRDnj4cg/Kme36z5lehBSatwNZjGjUo2SDgF5n
 PEfX33TDzQqsJZO+5i71JiAG6PFpTJhfcDL5smZ3LHboIGT/d1Q9rCAVytE6d24UDjfEYz7X/qg
 sJ8sK4unDEs1c9d62AOa3KNf6FVEHvxzQpiJAHVm1UrpeQnfEwOfqnGxVisAaYEbRTZhXA==
X-Received: by 2002:a05:6402:e02:b0:68e:4c0:f5b1 with SMTP id
 4fb4d7f45d1cf-693786035c8mr1207306a12.2.1781269976597; Fri, 12 Jun 2026
 06:12:56 -0700 (PDT)
MIME-Version: 1.0
From: "Jonathan L." <jonaphin@gmail.com>
Date: Fri, 12 Jun 2026 09:12:29 -0400
X-Gm-Features: AVVi8Cfa_fmFnHK-LMWO6VadNW3EvoWNvQ7mkgsssnLWKCJOqUEzCNB57SX61lQ
Message-ID: <CAPs_=oyWXJuQ4VS7LNQgM=jGKPMDoj1OnagU9YNQY+7aEeabHw@mail.gmail.com>
Subject: =?UTF-8?Q?Linux_7=2E1=2Drc7_regression_=E2=80=94_ROCm_GPU_memory_ops_han?=
 =?UTF-8?Q?g_on_Strix_Halo_=28gfx1151=29?=
To: amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com, 
 Harish.Kasiviswanathan@amd.com, timur.kristof@gmail.com
Content-Type: multipart/alternative; boundary="00000000000034497906540e3c7a"
X-Mailman-Approved-At: Mon, 15 Jun 2026 08:22:58 +0000
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

--00000000000034497906540e3c7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi team,

I am reporting a regression in the AMDGPU driver affecting the Strix Halo
APU (Radeon 8060S, gfx1151). While everything works correctly on kernel
7.1.0-rc5, upgrading to 7.1.0-rc7 causes GPU memory operations to hang
indefinitely. This occurs during tasks like torch.empty() or model weight
transfers in ComfyUI (PyTorch 2.11.0+rocm7.13).

I have bisected the changes in drivers/gpu/drm/amd/ between rc5 and rc7 and
identified the following potential causes:

1.  amdgpu_hmm.c (Christian K=C3=B6nig):

  - 1c824497d: Changing the invalidate callback to wait on the VM root BO
reservation lock may be introducing a deadlock.
  - 962d684b5: Moving the notifier_seq read outside the retry loop could
cause infinite retries with a stale sequence number.
  - 58bafc666: Changes to userptr submission waiting.

2.  gfxhub_v12_0.c (Timur Krist=C3=B3f):

  - 40bab7c60: The change to CRASH_ON_*_FAULT bits might be causing the GPU
to retry failed memory accesses indefinitely rather than surfacing a fault.

3.  gmc_v12_0.c (Harish Kasiviswanathan):

  - ae4e30f24 and e3fa02872: If the new per-version PTE address masks for
gfx1151 are incorrect, it could result in corrupted page table entries.

4.  amdgpu_gart.c (Donet Tom):

  - ec4c462e2: The updated PTE iteration grouping may be producing
incorrect page tables when combined with the new PTE mask.

Downgrading to 7.1.0-rc5 resolves the issue. Please let me know if you
require any specific debug output or further testing.

Best regards,
Jonathan

--00000000000034497906540e3c7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi team,<br><br>I am reporting a regression in the AMDGPU =
driver affecting the Strix Halo APU (Radeon 8060S, gfx1151). While everythi=
ng works correctly on kernel 7.1.0-rc5, upgrading to 7.1.0-rc7 causes GPU m=
emory operations to hang indefinitely. This occurs during tasks like torch.=
empty() or model weight transfers in ComfyUI (PyTorch 2.11.0+rocm7.13).<br>=
<br>I have bisected the changes in drivers/gpu/drm/amd/ between rc5 and rc7=
 and identified the following potential causes:<br><br>1. =C2=A0amdgpu_hmm.=
c (Christian K=C3=B6nig):<br><br>=C2=A0 - 1c824497d: Changing the invalidat=
e callback to wait on the VM root BO reservation lock may be introducing a =
deadlock.<br>=C2=A0 - 962d684b5: Moving the notifier_seq read outside the r=
etry loop could cause infinite retries with a stale sequence number.<br>=C2=
=A0 - 58bafc666: Changes to userptr submission waiting.<br><br>2. =C2=A0gfx=
hub_v12_0.c (Timur Krist=C3=B3f):<br><br>=C2=A0 - 40bab7c60: The change to =
CRASH_ON_*_FAULT bits might be causing the GPU to retry failed memory acces=
ses indefinitely rather than surfacing a fault.<br><br>3. =C2=A0gmc_v12_0.c=
 (Harish Kasiviswanathan):<br><br>=C2=A0 - ae4e30f24 and e3fa02872: If the =
new per-version PTE address masks for gfx1151 are incorrect, it could resul=
t in corrupted page table entries.<br><br>4. =C2=A0amdgpu_gart.c (Donet Tom=
):<br><br>=C2=A0 - ec4c462e2: The updated PTE iteration grouping may be pro=
ducing incorrect page tables when combined with the new PTE mask.<br><br>Do=
wngrading to 7.1.0-rc5 resolves the issue. Please let me know if you requir=
e any specific debug output or further testing.<br><br>Best regards,<br>Jon=
athan<br><br></div>

--00000000000034497906540e3c7a--
