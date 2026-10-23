Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B15606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lazarus.enterprises header.i=@lazarus.enterprises header.a=rsa-sha256 header.s=google header.b=Icf6dAAw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F377C10ECD6;
	Mon, 26 Oct 2026 08:44:08 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3A010E0D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:22 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c4697404c2bso136390066b.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792772421; cv=none;
 d=google.com; s=arc-20260327;
 b=ccusqdwSGEbBYazu1wNfl0FkMOkyrIdoI6V6r5E9eU1CRQQbTFfgoaoYdU9oOS2aCZ
 0gdl7675mKxVa50+OxtXtY/FHzwAFcJQQ/MgKRvuskIBqy/usGl1GhEBk7Cx/ALKanne
 Kyd6yrjKorKM276TSscGLgZC/yAqtAlhrcZarctA2P5idEXeIT4Cqz0NvEd0+qMq5lQa
 OSOu8BOoidGEbIZR8erh5/HH+qWJz6AAY961wBhGEe5AvHKPXsfOkE3Ski3IDGwDYy3t
 fhu2Mly5QQnmNdDFbleWXHMjG2OQ1MlCCzg/JtV3zoizMav0AsfgVHVFybiJ0MNqJfNl
 aa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=vp0AmgkV+8bYYUGEPqE/GGODWrk9pTBUCtY0uWtKuU0=;
 fh=DfBLKPOyHZ/wEAYSZkVMO/ud9d4D8je29OCNW3+eYZg=;
 b=WL/GED0D5eNARNAhrugRptGvWP4US8EZNPGfasaMtUqpDfV/qR2CwGn+z+7q62URd8
 e6Pm/8LEpIHwft746Xb/HQTxhgaqfy/pW0qvkyqPDQx05FNbjwwvzPEk1TR373fZs2uO
 /bdSTkFouwyZSpxJj+SR3GVOjto09TqKZqjkTWYnI/k3nkxlCJPYZEtBGZFfIEipir4u
 5m1bt/z1lh0Q4hYjCUXsb8itq3Fy8iufAwCmN4y8VtTAPfjXiMnlXuQjhwKPQRmzJQYl
 UZWNQssiMgCH+xXzQBH5RUFLM0IJ8rhqqO/OEqBeZzT/OiaNSHAA/8JnU+EHVRfyntxl
 ERuA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lazarus.enterprises; s=google; t=1792772421; x=1793377221;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vp0AmgkV+8bYYUGEPqE/GGODWrk9pTBUCtY0uWtKuU0=;
 b=Icf6dAAwV1MJzym5YfKVFcrCfduHkDaXFEq6t4hjubg0ekzQJpd1skSyC6fwRJdqIB
 2BBtrWGovV3gcR0TFdP4MVX8i8dtt1W8pnV/vWxwGl+J/oVqs8m8oHv62LC2G1EqQVGR
 YZT+2ETw42ElHUBdVgweXhD48un1j+zlKNeyf86g+GB3gu6vCcbiXhhFfCBWUhLl0qrG
 OTc7sShhsU/EhbezbmLB/Oy5wJ/8VBvkkOVGj/1jnQPlt5dbbInvJpbnD0t98g7mi+Do
 zZjsirlJjBd9/9TJf2A+aMLcCv44ZB8QwviVfv/a32wwI9Q7ywN/FpRekk5ujuzyGhxP
 GxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772421; x=1793377221;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vp0AmgkV+8bYYUGEPqE/GGODWrk9pTBUCtY0uWtKuU0=;
 b=yIQNoJHqg3SbzaDv9eHwf0ihbUV0xlM3+mc7bkG+MWxKaZHotMN5O8r8UAzOpTs/Yi
 oPJs9GyXjagiM/2K7m0mpilQo5HidCO+7leHDbF9RWWZEG1xQtOvUcYK++2DaPJyuTen
 FYXv4uvIvpuZu9//BhA4yZypRWNyLh3Ag0N+WQT8iU8tFXZiDxZHXnK0Xp1Mi0Fl1Bq+
 mCjo3CMth4xdsE/8bFiO7Ci270rOmYl5EibDy3D3OXRK/AetNF73c8LkTSsoM0mXhGUc
 9z0RYXY1Kz3rjFT2MKHQ43DAo108935oeqj//PcLbvB6CPX4KFWZDbBXR0FuLK2gJqnR
 RGMw==
X-Gm-Message-State: AFq9FYIvZS34Zg20JCK/SK2hPN5+t94xQn4iODaWrk+RYD8S2hF6IJz8
 CKTYHCK2N1ClmoTGSDbRwRw6RBffwlrbszozQzT1Z90x5zZfFPqAJNmhtoYwE0Ns/rMeQs0JoQf
 iouHVNxFDQl0UaOJajxpmJSUOVwSUiO+X8TbDFCzYGFMBZVvZ0uowZyFD8Q==
X-Gm-Gg: AYBFou1r1gpN6WvexyVNfJis82qadehePTMdke103lOmrI1Iv4dyDScgm1OBil1+Ayp
 GI8Lel1HP3HqaKWejxPS2k6V7mJHBgDJXf2tjeCAmIi45jGH+tWo2fTCssXLPVIj82e6JZ8iNNU
 NTSyyYBMKhNmtT0JJw34kpe8Ki5s/+WurUnjMLiPkJhm9dOon6WXJGrelrLHPloMP7OUlyueAVe
 gjDElBvfss6+J4to7M9Xok5qRgLHSMdWBpso1PCTzK5jKkZvhevxjZ1dO2xY4MeL+SliIvop9ga
 Dy3bL/Z2DqyyY0X7rOiEgPXl6349+DqUI0kYa6S6iC/sdA68TPyvMmiTCTCTxUs/X3iXknQPQGl
 bMg+PsPfyw9c1zh6jnqeFihWZchquQVhtCqFGHED7Q3cacXUarjnW8T/KhtA=
X-Received: by 2002:a17:906:c106:b0:c40:231:6ea1 with SMTP id
 a640c23a62f3a-c46a9490b8cmr380827966b.43.1792772420750; Fri, 23 Oct 2026
 09:20:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: "Rob O'Callahan" <rob.ocallahan@lazarus.enterprises>
Date: Fri, 23 Oct 2026 09:20:09 -0700
X-Gm-Features: AclHuK_Ak4m_jQ6teOOkEJXQnPh_rMdlAmPFfeH3dB_-8VHqdjW8y-BX_HWPz70
Message-ID: <CAA5hP1ZA4h=dbOwUycRY+VW+aaVcOKmA37pD3rTp9pknUvRT9g@mail.gmail.com>
Subject: drm/amdgpu: please add Fixes/stable tags to 871467ce5bce ("don't leak
 bo_va when gem_object_open fails")
To: amd-gfx@lists.freedesktop.org
Cc: xiang.liu@amd.com, mukul.joshi@amd.com, felix.kuehling@amd.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, eric@quixi.ai
Content-Type: multipart/alternative; boundary="0000000000004deffb065e845b7c"
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:43:34 +0000
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

--0000000000004deffb065e845b7c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We hit the bug fixed by 871467ce5bce ("drm/amdgpu: don't leak bo_va
when gem_object_open fails", currently in amd-staging-drm-next) in
production, and the result was much worse than a leak: the node locked
up. Could the patch get Fixes: tags and Cc: stable when it goes to
drm-fixes / drm-next?

  Fixes: 50661eb1a2c8 ("drm/amdgpu: Auto-validate DMABuf imports in compute
VMs")
  Fixes: 31f7efcdca4d ("drm/amdgpu: enable eviction fence")
  Cc: stable@vger.kernel.org # v6.9+

Setup: 8x MI300X, ROCm 7.2.4, amdgpu DKMS 6.16.13 (roc-7.2.x). HIP
processes imported large VMM allocations (~149 GB per GPU) from another
process as dma-bufs. A later hipDeviceEnablePeerAccess() mapped the
imports for all peers, so amdgpu_gem_object_open() had to validate them
into GTT, and that failed with -ENOMEM. Each failure leaked a bo_va.
After about 6000 failures, in roughly 20 minutes, the TTM LRU walk
dereferenced NULL while holding the LRU lock. Every task that touched
amdgpu then soft-locked (process teardown, prime import, rocm-smi sysfs
reads), and the node had to be rebooted:

  amdgpu 0000:e5:00.0: amdgpu: validate_and_fence failed: -12
  WARNING: CPU: 128 PID: 1308908 at amdgpu_object.c:1340
amdgpu_bo_release_notify+0x1b3/0x1e0 [amdgpu]
   amdgpu_gem_object_free+0x59/0x120 [amdgpu]
   drm_gem_prime_fd_to_handle+0x186/0x1f0
  amdgpu: VM memory stats for proc dstrain_gate(1308908) ... is non-zero
when fini
  ...
  BUG: kernel NULL pointer dereference, address: 0000000000000000
   __ttm_bo_lru_cursor_next+0xa2/0x330 [amdttm]
   amdttm_lru_walk_for_evict+0x8d/0x260 [amdttm]
   ...
   amdgpu_amdkfd_bo_validate_and_fence+0x53/0x100 [amdgpu]
   amdgpu_gem_object_open+0x168/0x2c0 [amdgpu]
  watchdog: BUG: soft lockup - CPU#153 stuck for 26s! [dstrain_lab:1327943]

Mainline and the stable kernels from v6.9 on still have the leak. So do
ROCK-Kernel-Driver master and roc-7.2.x. Please also include the fix in
the next ROCm 7.2.x DKMS release. That branch has neither the drm_exec
locking in gem_object_open nor the evf_mgr rework, so the commit does
not apply as is. Eric Hartford has prepared a roc-7.2.x backport and
can send it if that would help.

Reported-by: Eric Hartford <eric@quixi.ai>

Thanks,
Robert =C3=93 Callaghan

--0000000000004deffb065e845b7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>We hit the bug fixed by 871467ce5bce (&quot;drm=
/amdgpu: don&#39;t leak bo_va<br>when gem_object_open fails&quot;, currentl=
y in amd-staging-drm-next) in<br>production, and the result was much worse =
than a leak: the node locked<br>up. Could the patch get Fixes: tags and Cc:=
 stable when it goes to<br>drm-fixes / drm-next?<br><br>=C2=A0 Fixes: 50661=
eb1a2c8 (&quot;drm/amdgpu: Auto-validate DMABuf imports in compute VMs&quot=
;)<br>=C2=A0 Fixes: 31f7efcdca4d (&quot;drm/amdgpu: enable eviction fence&q=
uot;)<br>=C2=A0 Cc: <a href=3D"mailto:stable@vger.kernel.org">stable@vger.k=
ernel.org</a> # v6.9+<br><br>Setup: 8x MI300X, ROCm 7.2.4, amdgpu DKMS 6.16=
.13 (roc-7.2.x). HIP<br>processes imported large VMM allocations (~149 GB p=
er GPU) from another<br>process as dma-bufs. A later hipDeviceEnablePeerAcc=
ess() mapped the<br>imports for all peers, so amdgpu_gem_object_open() had =
to validate them<br>into GTT, and that failed with -ENOMEM. Each failure le=
aked a bo_va.<br>After about 6000 failures, in roughly 20 minutes, the TTM =
LRU walk<br>dereferenced NULL while holding the LRU lock. Every task that t=
ouched<br>amdgpu then soft-locked (process teardown, prime import, rocm-smi=
 sysfs<br>reads), and the node had to be rebooted:<br><br>=C2=A0 amdgpu 000=
0:e5:00.0: amdgpu: validate_and_fence failed: -12<br>=C2=A0 WARNING: CPU: 1=
28 PID: 1308908 at amdgpu_object.c:1340 amdgpu_bo_release_notify+0x1b3/0x1e=
0 [amdgpu]<br>=C2=A0 =C2=A0amdgpu_gem_object_free+0x59/0x120 [amdgpu]<br>=
=C2=A0 =C2=A0drm_gem_prime_fd_to_handle+0x186/0x1f0<br>=C2=A0 amdgpu: VM me=
mory stats for proc dstrain_gate(1308908) ... is non-zero when fini<br>=C2=
=A0 ...<br>=C2=A0 BUG: kernel NULL pointer dereference, address: 0000000000=
000000<br>=C2=A0 =C2=A0__ttm_bo_lru_cursor_next+0xa2/0x330 [amdttm]<br>=C2=
=A0 =C2=A0amdttm_lru_walk_for_evict+0x8d/0x260 [amdttm]<br>=C2=A0 =C2=A0...=
<br>=C2=A0 =C2=A0amdgpu_amdkfd_bo_validate_and_fence+0x53/0x100 [amdgpu]<br=
>=C2=A0 =C2=A0amdgpu_gem_object_open+0x168/0x2c0 [amdgpu]<br>=C2=A0 watchdo=
g: BUG: soft lockup - CPU#153 stuck for 26s! [dstrain_lab:1327943]<br><br>M=
ainline and the stable kernels from v6.9 on still have the leak. So do<br>R=
OCK-Kernel-Driver master and roc-7.2.x. Please also include the fix in<br>t=
he next ROCm 7.2.x DKMS release. That branch has neither the drm_exec<br>lo=
cking in gem_object_open nor the evf_mgr rework, so the commit does<br>not =
apply as is. Eric Hartford has prepared a roc-7.2.x backport and<br>can sen=
d it if that would help.<br><br>Reported-by: Eric Hartford &lt;<a href=3D"m=
ailto:eric@quixi.ai">eric@quixi.ai</a>&gt;<br><br>Thanks,<div>Robert =C3=93=
 Callaghan</div></div>

--0000000000004deffb065e845b7c--
