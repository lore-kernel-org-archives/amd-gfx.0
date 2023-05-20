Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB45C77B7A
	for <amd-gfx@archiver.kernel.org>; Sat, 20 May 2023 05:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF64F10E477;
	Sat, 20 May 2023 05:34:27 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B8910E477
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 May 2023 05:34:26 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5617d793160so54762547b3.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 22:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684560865; x=1687152865;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gjCMIsUxnLWH4poT76UvO5RtAJR3pg0U5e/wbtdAXd0=;
 b=lMLKQ0AlaBxR3YygwqX2L/7nGcJOcJ9ahiFV+iIlparoUPfecgPPhz8uj9DDSWCkvx
 GREj/xB7AcqE04SmUjqbW//AH/vcmih/ZIKBInuj2UR4prSlj2dYFLX/1JR9L648YWYX
 K6Y0lvztA9MK3ic7W51nhNP9a3iVk6Rr6Zzffpi+Gj+Xl0S/R1wEMPX2VqNMrfgU8c1j
 QllKtUxqin1MHXxC/uTDOUC01JLB3rcgmw9Zcq+yD5MVcMS5yQA6tskjcF2bWfKPGCZ9
 +yzyn4HYoSDtARbvwm8o5yiRS12Kulyd5wXUdzlUWi3UUD55SJzPuUWG5LshUuS91FZi
 RCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684560865; x=1687152865;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gjCMIsUxnLWH4poT76UvO5RtAJR3pg0U5e/wbtdAXd0=;
 b=XzR1mIf9oD9D/yG/FVZjMa/1B/vDfYqgb8L76aq6Amx2MY+hsuKr2UXMJRn92VEDVb
 hDELRIJutTHeFgpOiCxEza/u5cZGxDjBCyZZ4p/z0H1M08CmF/wHkagubkuYy2chkqWS
 35ZjJxLJRfXeZhwQMMFUF8ZfGBTtcMNesdL32SzQWXIfyjT5lfb7Jc3FD05UVmAMpea8
 okX3R6Pmc8jtkd2ijvCwvXQWbeC6OItb9p5pRDrfIlC2rYdDDMJ4dVBctkc5sHdE03ha
 5zGH7/Tmt6NBW4pBsc69B3BECj7vy4pZ4S58BOkTxNPaPdmzKqLNSPAKlcGfH6x7yXlM
 dRkQ==
X-Gm-Message-State: AC+VfDxKLb37M7zx45BGqoxwWcca/7gcpCEkfgwYwxxx50LSUnGuwuwE
 d/T1Uga24glSwH4/H+y5OktSMiZZa+YXnZh2GB3Hs4MYdcen//S6q7M=
X-Google-Smtp-Source: ACHHUZ6TmlPF0bpHpMB8PxUdFhsnVaH+xuGskEiZgUTOzS9d6LAFiYiF3lrCsj07PT49R9Si6NcQ20TUrHJUlMyt3gI=
X-Received: by 2002:a81:4606:0:b0:561:c1ac:2877 with SMTP id
 t6-20020a814606000000b00561c1ac2877mr3608676ywa.52.1684560864933; Fri, 19 May
 2023 22:34:24 -0700 (PDT)
MIME-Version: 1.0
From: Zibin Liu <ghostfly23333@gmail.com>
Date: Sat, 20 May 2023 13:34:13 +0800
Message-ID: <CABKykwm30UKMWmzPhN3DDsDa7L1x-DhP7rPMVMvqAwzPk2sDFg@mail.gmail.com>
Subject: [QUESTION] gfvhub_v2_1 updates CNTL regs before initialize related
 page table address
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000f4f95d05fc1963a8"
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

--000000000000f4f95d05fc1963a8
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm looking at the initialization sequences in gfxhub_v2_1.c. I'm
confused on whether the GCVM_CONTEXT1_CNTL CNTL reg can be written
before the corresponding GCVM_CONTEXT1_PAGE_TABLE_START_ADDR and
GCVM_CONTEXT1_PAGE_TABLE_END_ADDR reg is written.

Here is the background:
 * gfxhub_v2_1_setup_vmid_config() enables GPU clients to use GPUVM
VMIDs to access memory.

The code related to this questions is below:

 324               WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
 325                                   i * hub->ctx_distance, tmp);

 326               WREG32_SOC15_OFFSET(GC, 0,
mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
 327                                   i * hub->ctx_addr_distance, 0);
 328               WREG32_SOC15_OFFSET(GC, 0,
mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
 329                                   i * hub->ctx_addr_distance, 0);
 330               WREG32_SOC15_OFFSET(GC, 0,
mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
 331                                   i * hub->ctx_addr_distance,
 332
lower_32_bits(adev->vm_manager.max_pfn - 1));
 333               WREG32_SOC15_OFFSET(GC, 0,
mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 334                                   i * hub->ctx_addr_distance,
 335
upper_32_bits(adev->vm_manager.max_pfn - 1));

Just wondering, is the behavior expected or is it a bug?

Thanks,
Zibin Liu

--000000000000f4f95d05fc1963a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><pre style=3D"white-space:pre-wrap;color:rgb(0,0,0)">Hi,

I&#39;m looking at the initialization sequences in gfxhub_v2_1.c. I&#39;m c=
onfused on whether the GCVM_CONTEXT1_CNTL CNTL reg can be written before th=
e corresponding GCVM_CONTEXT1_PAGE_TABLE_START_ADDR and GCVM_CONTEXT1_PAGE_=
TABLE_END_ADDR reg is written.</pre><pre style=3D"white-space:pre-wrap;colo=
r:rgb(0,0,0)"><pre style=3D"white-space:pre-wrap">Here is the background:
 * gfxhub_v2_1_setup_vmid_config() enables GPU clients to use GPUVM VMIDs t=
o access memory.</pre></pre><pre style=3D"white-space:pre-wrap;color:rgb(0,=
0,0)">The code related to this questions is below:</pre><pre style=3D"white=
-space:pre-wrap;color:rgb(0,0,0)">=C2=A0324 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,<br>=C2=
=A0325 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i * hub-&gt;ctx_distan=
ce, tmp);</pre><pre style=3D"white-space:pre-wrap;color:rgb(0,0,0)">=C2=A03=
26 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WREG32_SOC15_OFFSET(GC,=
 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,<br>=C2=A0327 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i * hub-&gt;ctx_addr_distance, 0);<br>=C2=
=A0328 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WREG32_SOC15_OFFSET=
(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,<br>=C2=A0329 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i * hub-&gt;ctx_addr_distance, 0);<br>=
=C2=A0330 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WREG32_SOC15_OFF=
SET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,<br>=C2=A0331 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i * hub-&gt;ctx_addr_distance,<br>=
=C2=A0332 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lower_32_bits(adev-=
&gt;vm_manager.max_pfn - 1));<br>=C2=A0333 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END=
_ADDR_HI32,<br>=C2=A0334 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i * h=
ub-&gt;ctx_addr_distance,<br>=C2=A0335 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 upper_32_bits(adev-&gt;vm_manager.max_pfn - 1));

Just wondering, is the behavior expected or is it a bug?

Thanks,
Zibin Liu</pre><br></div>

--000000000000f4f95d05fc1963a8--
