Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F5FCD6E4A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 20:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27701124EC;
	Fri, 29 May 2026 20:31:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="paxNBY0t";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2AB51124EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 20:31:26 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-304dc707c7eso173521eec.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 13:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780086686; cv=none;
 d=google.com; s=arc-20240605;
 b=OHFnf7tD/YDTK4Y1495NZUvqgig3mBeaxHSMCUuXWr2/c89PjQ15Hpa7G2UYsuAjnn
 e95sam20xqGhp4ZzikV8EdzD2ZmCqh1fv0nxZWIOpKrYVwxngUzZruIfeUy9YOcTIbW2
 A2okREZxPGqo0pKARnHZ7g4uwycfRJhfxujZ3PcDscb/IoZ+8mbngKXawpYDlqP6wmBL
 05aacIYKe8v3NFvc/+J0E6VNuMOVNvAZghE3oeCkdAQ709M7uzwJDbMhQ3/d79qBa6DF
 M1XqG+ChlHeq5xG4zZy9UzQI+tyRbZU9ddBUg9wQsYag4SLNceJkLkZBgu3Kk8C2BtI1
 g7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LT36OWEyA7XIR7OdXZqS/tzw9S63tMBExNt/UgSkkiE=;
 fh=fwblGE1A9xprFneR/FXb/uCj1MpcbKf7WRrbjQABfAo=;
 b=ieyfJdJfrPQmyfaoGfcCaEcxCaOKfniDqx0u6AdM4Z3S7WVKUpbVszOBLaWMrOBZ4K
 k0tUddQw4gGeTFfWWqSF4hf8MXtPCQT8DaiNNACuRlik20eLE3I9Esgoexd8bXUVZl3M
 ZYbrZNmh3u818NViMuOEdj8IoyL5EdBfu01kse6UGr17dl/osMsdqjmBwDEIVgj0VuFv
 Eg9/VosXpCPlL8QLUcBfgk9eGSefPucRVRDuTj3eo2YiJ3UMnG3sqdhlmXLvT6KuVx8D
 Y+yfruw2BX+Lgg7DJQajOMnWZeUlAM6+SspMfcq6V1pangFkUB+bcwVSLTV/ncoyFZ7Z
 rHvA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780086686; x=1780691486; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LT36OWEyA7XIR7OdXZqS/tzw9S63tMBExNt/UgSkkiE=;
 b=paxNBY0t38+ZVwuA8a+N+vlewo4uH6OhteiEjgbN+QvSoX91ZoikM6ce3fDFhLCxgX
 AVpFX87ZYmph49roqBwrfux0C6RwA/Wli1+MRk6qDg398ASjgOQhzGKAx2MEaqajCUS+
 YViKISlssnRzIP9LVR8deUC8nwnV7kI7/svuQ5sazi/zSMJdgIIk/QucFH8BSOzarAOF
 1S45kE7V8xUWG7ZuRoUYV0b/toEgS3UTBQ1Ji4zhx3+udGlC8YsR10VzBlxfr6kot0BG
 cB4SNjf9F8ynYQ9iuNnJwNY4fdaUf2yrdW+xY9QRuRFQIXtrtC/b5jdsBaagH42xMtBM
 JElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780086686; x=1780691486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LT36OWEyA7XIR7OdXZqS/tzw9S63tMBExNt/UgSkkiE=;
 b=kx8n13kXUfacbXINHrFGd0RIJgH9zQBuYD7nlJPwXcOOKwH/YPWxj0PFca/Aa5MJx5
 pijEkBXtrXjjNBzvoIU5G578If3agl8rZ4iFKFKZE4m0rl1l6ZBfHCGB72I8JoqK7ogX
 fKw4K/t8fF+gTmQEfKWqnHfvcvAuXvshNpUosx+HOPhlSZvqAZYzzBLv3Qlqh8s7lhWu
 PFMEMuVOXBma4Hn8Q4aiDypM4QGD+y6oQmC+3DmZgZDvwaahdqz7hcdfF7CUYCqcfm7U
 z3LR0EfBiPLybof+CGbqr1MaFc4KMh8GNBp+Hg6bsH97KOhKeaMdiZ3Ai4zn6DQic2Ry
 BGbQ==
X-Gm-Message-State: AOJu0YzG63K2cM78brpphSHazE36Z+h3mrRn0lU6ymJzvwwaTn99jxKk
 GHOj7MLl9QrHcE2FFjpDHWKvXk83OZG4R+t2lUeea7p9vy14qxKq1Mw/cz/D+O7l8UDXC7bIbIp
 +JZt2Mg834Er+cZtyq+lrXwWRpbgpQPY=
X-Gm-Gg: Acq92OGhdWI88qpN2OXfcxKG/Yon4IsXfsfHrBpro7Ok3GlKIYvMbYtdkSeZW0Pa3Cu
 uDei2ve2WL4/RV9a9IdxI3V7fEGPiFs+nUdgNdrMcb0o0WW25sVaeQ6Xx2n33OnfYHtV8v0LUFm
 c0GulUmDdQJo5D45+/oN5w1qedOiXgPmFFLD7y3aqHv1xfI9gWqRO4SQMkx/qfXjFlEB4kR7xVR
 NdB7IdmNFzoIAK2Db2xgzJfCp9Yr9WCyIqaZt2OeX5RCHUSGL91GnVk3zmp/nbqMfpc3szurAl7
 YFNWX5mvAWe+4MIf63TIoMLe7e1aD3bnbD0TRa7Zyjdghvoofca2HlkFZxY+r3TMJBWi782AlBh
 PZXdD
X-Received: by 2002:a05:7022:11f:b0:135:1b09:db43 with SMTP id
 a92af1059eb24-137d425ef73mr291738c88.6.1780086685807; Fri, 29 May 2026
 13:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260529183353.64803-1-vitaly.prosyak@amd.com>
In-Reply-To: <20260529183353.64803-1-vitaly.prosyak@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 May 2026 16:31:11 -0400
X-Gm-Features: AVHnY4K4lhnddB32vkiTCCk_rJJdEv2vV3AodX2uGuXRO6nBYBc99ptbNRFLTPo
Message-ID: <CADnq5_NtQrE4AOq=G1Kjg3Qrgke3pU69yJ1Zf7Dd=-0mbi4EdA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: set noretry=1 as default for GFX 10.1.x
 (Navi10/12/14)
To: vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, Christian Koenig <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, May 29, 2026 at 4:29=E2=80=AFPM <vitaly.prosyak@amd.com> wrote:
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Problem:
> While developing the amd_close_race IGT test (which intentionally trigger=
s
> execute permission faults by removing VM_PAGE_EXECUTABLE from GPU page ta=
ble
> entries), we discovered that on Navi10 (GFX 10.1.x) these faults produce
> zero diagnostic output. The GPU simply hangs silently for ~10s until the
> scheduler timeout fires. There is no way to distinguish an execute
> permission fault from any other type of GPU hang.
>
> Root cause:
> GFX 10.1.x defaults to noretry=3D0, which sets
> RETRY_PERMISSION_OR_INVALID_PAGE_FAULT=3D1 in the GFXHUB UTCL2 registers
> (gfxhub_v2_0.c line 313). With this bit set, permission faults (valid PTE=
,
> wrong R/W/X bits) are handled entirely within the UTCL1/UTCL2 hardware
> loop: UTCL2 returns an XNACK to UTCL1, and UTCL1 re-requests the
> translation indefinitely, expecting software to eventually fix the
> permission bits (as happens in SVM/HMM recovery). No interrupt of any kin=
d
> reaches the IH ring.
>
> This is different from invalid-page faults (V=3D0) which DO generate a re=
try
> fault interrupt that the driver can escalate to a no-retry fault. Permiss=
ion
> faults with valid PTEs loop silently forever in hardware.
>
> GFX 10.3+ already defaults to noretry=3D1, which makes permission faults
> generate immediate L2 protection fault interrupts. GFX 10.1.x was
> inadvertently left out of this default.
>
> Fix:
> Change the noretry=3D1 threshold from IP_VERSION(10, 3, 0) to
> IP_VERSION(10, 1, 0) in amdgpu_gmc_noretry_set(). This is a one-line
> change that aligns GFX 10.1.x behavior with GFX 10.3+ and all newer
> generations.
>
> With noretry=3D1, the existing non-retry fault handler
> (gmc_v10_0_process_interrupt) already decodes and prints the full
> GCVM_L2_PROTECTION_FAULT_STATUS register including PERMISSION_FAULTS,
> faulting address, VMID, PASID, and process name. No additional logging
> code is needed =E2=80=94 the fix is purely routing permission faults to t=
he
> existing, fully-capable non-retry interrupt handler.
>
> v2: Dropped GFX10-specific logging from gmc_v10_0.c and
> kfd_int_process_v10.c (Felix Kuehling). v1 added logging in the retry
> fault handler, but with noretry=3D1 permission faults take the non-retry
> path =E2=80=94 the v1 retry handler code was dead and would never execute=
.
>
> Tested on Navi10 (GFX 10.1.10):
> - Execute permission faults now produce immediate, clear output:
>     [gfxhub] page fault (src_id:0 ring:64 vmid:4 pasid:592)
>      Process amd_close_race pid 13380 thread amd_close_race pid 13384
>       in page at address 0x40001000 from client 0x1b (UTCL2)
>     GCVM_L2_PROTECTION_FAULT_STATUS:0x00700881
>          PERMISSION_FAULTS: 0x8
> - No regressions with properly-mapped GPU workloads
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 13bec8461cde..a9bb01c6cb58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1014,7 +1014,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *a=
dev)
>                                 gc_ver =3D=3D IP_VERSION(9, 4, 3) ||
>                                 gc_ver =3D=3D IP_VERSION(9, 4, 4) ||
>                                 gc_ver =3D=3D IP_VERSION(9, 5, 0) ||
> -                               gc_ver >=3D IP_VERSION(10, 3, 0));
> +                               gc_ver >=3D IP_VERSION(10, 1, 0));
>
>         /* For GFX12.1 B0, set xnack (retry) on as default */
>         if (gc_ver =3D=3D IP_VERSION(12, 1, 0) && (adev->rev_id & 0xf) =
=3D=3D 0x1)
> --
> 2.54.0
>
