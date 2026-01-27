Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49D9D2FEF9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 22:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4586010E5D5;
	Tue, 27 Jan 2026 22:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LSs+OoMZ";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACD3610E5D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 22:55:49 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12335a3e1edso199681c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 14:55:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769554549; cv=none;
 d=google.com; s=arc-20240605;
 b=DC8nkO5eq8BwVvyJIWOwZEghS5/WFl3jObVtrP99V84bMANjtr7m6ox2eHeE4VQXzM
 Ey4bOP3Q8TDA8w1Cij7TxQ+qLd0ZvZiUIjWCz3shN9NpoiYbNj/d2cUW8Og8limzUtjd
 weW5RAuxiahjAMc4urhOq3fH4wjuh134sRKt+wW+FQaP1N4e4/9msgMMbx3thRkk9lm5
 ds9gZIWNlZ+15rxXGJtu6loLZqol6k3Y0IxfcL2aodNa1lUJDgIoGaBy7IUs7X4Eby1u
 0bpqBQ31YDjIvqCkcI4xR8FbMYz45aREalqECIoAK1W3eTxe3Ei++mMMDyL2f2HjUmPk
 jsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qyIXQotvbiL/evGABR7+c0tgC1up1zy1PTLkT3MuH7U=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=FB/0bk48NvaW1h/gHc+dDh4DnV5XJOscm9FKB0vwyQgFVat69YQaA3oqap3OZ8iCsr
 S8iP6YsF9aO7AEfCZ4hp3+UvS3uQmZAVliTR+uRRqtMUUjiZOtpPjLEOgDkjHRafKyTb
 X9zQmBuggKcy8LBsufI/BmMrgf8mVZdffaCiVUn+sbCMzOvf6KR93/TzJ1UK0GrAuTKc
 oDq+FNcC1/mig34pdPs2pm3sMRE7BmavnbdXWQaQNT+AUFZCfOIAmaO7BUWaHETy8Hz6
 wtMFLv8BsCgsRdFchsEFjNZScL7EXRBXzqAZil4qRyuLdg5bKJ9xCC7QNQ6J5jwuydHJ
 aSEw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769554549; x=1770159349; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyIXQotvbiL/evGABR7+c0tgC1up1zy1PTLkT3MuH7U=;
 b=LSs+OoMZqi/f4AedyhR/9GC4jlfRlrXEBlnWA0A18m2ZWUkr9aw52Hjtf3uTRxlI8X
 QBf2Mhezbk38hsdVE/zhp2fUurmjNtGE2Vfc8cFsMdaDxcOEou5pBvQSi4QFVfXt50nY
 YEzNmTyHejZYiKMNJBcb0QY+a7G2WRU6/fgR1pkz4Ad5fNsGjAELANenJgbutY/ORKp0
 utRqnD/Dw/ss1vaZQyCY8p3cR4NirmMTuC4j3Rr6BbQ2ifRyCYQw5Rp3ZfeQUORYObAl
 N5uG5Q4r2kIpF0/OMBpJ6u1Kjdb67XtUuDba7i5NZ3PWQmQ8Q0TAOjbAXx0hesAyhhng
 +cAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769554549; x=1770159349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qyIXQotvbiL/evGABR7+c0tgC1up1zy1PTLkT3MuH7U=;
 b=mwJB3/+lscxKAVPi96v2wHgko+h0bFZn3AVlvvqEqFUvqObhmDiQVLDdmAA/HkbNzG
 aSdw1+qN4pzF9LD7O2L58uvBbvWuL42qZvkyD3d7gkxHeqQrmNulu9WHNXVcrL08C7Bh
 KCOTOzIRrcTPM2PnGqKcSk/AgDQIBS5Jpxi70eG4NQwasJTIA2nsLt5dlnKEsMwRAOUY
 goKceqe30VcNIb8PL4nVD4jInmGqkFcKHItlydlpgvDWLmXP7ZwF/qEauK/83F97zAif
 LTiBdg+GV6BHeenJJS67RI+fz8qh88WXHOInA+NZ2+hrA17JqKsikusx2gScHnHldmzS
 dIVA==
X-Gm-Message-State: AOJu0Yxm8s46x2ettV6kpPTcXBOKydeajpBqrMj5HKzx+Sh0KJvvau3z
 s6plFi3qNtiOs7cd0lWw8nQtPIcnVbKxgfZRH1uY5qGYTMPm9FEkEs9jkZgIuBTJyXGHMIy/SlO
 4txz1ScAWGvOedDgWJCtL9ks3/gWC/+wBiA==
X-Gm-Gg: AZuq6aJUzuWFuPt3neESYVbQ64bRksts+iAZ2K+8dVSL3WWyFauJkdd8RkO6YKbtae9
 NohWHtrm+iSWK9mX0Nsm0bKEMbZTX6ESKsQBOnOxcCWmvzfssQSncRZM5khnsHtYlpuU8rLd5XL
 +QzbVvKah+aA1rfGavb3yDL5b/eXbYaAHP4bwlmNX5wo8Wa+hxcEyaG68L+l32voGpB3RXGpmHj
 dHZe10ynCSL1Di83KSgXeL5X4iaiqVjmlB5YRwWE7dhhTYh3h081Mua3k4PTYvMp7ekrpjs
X-Received: by 2002:a05:7023:b85:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-124a99cf629mr122540c88.3.1769554548914; Tue, 27 Jan 2026
 14:55:48 -0800 (PST)
MIME-Version: 1.0
References: <20260127052733.54360-1-alexander.deucher@amd.com>
In-Reply-To: <20260127052733.54360-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Jan 2026 17:55:37 -0500
X-Gm-Features: AZwV_Qi3tDmX2_DpDoBkh-HhadxK0Ro54P5LVpxqchvD0uDHBI0IgkO-XH_03RE
Message-ID: <CADnq5_PDUqV5E_t1k3pnoZVHs3OP87D1PdUnwK4EKvBA-PGv3w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix cond_exec handling in amdgpu_ib_schedule()
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

On Tue, Jan 27, 2026 at 12:37=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> The EXEC_COUNT field must be > 0.  In the gfx shadow
> handling we always emit a cond_exec packet after the gfx_shadow
> packet, but the EXEC_COUNT never gets patched.  This leads
> to a hang when we try and reset queues on gfx11 APUs.
>
> Fixes: c68cbbfd54c6 ("drm/amdgpu: cleanup conditional execution")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4789
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index 72ec455fa932c..44f230d67da24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -235,7 +235,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>
>         amdgpu_ring_ib_begin(ring);
>
> -       if (ring->funcs->emit_gfx_shadow)
> +       if (ring->funcs->emit_gfx_shadow && adev->gfx.cp_gfx_shadow)
>                 amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_=
va,
>                                             init_shadow, vmid);
>
> @@ -291,7 +291,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>                                        fence_flags | AMDGPU_FENCE_FLAG_64=
BIT);
>         }
>
> -       if (ring->funcs->emit_gfx_shadow && ring->funcs->init_cond_exec) =
{
> +       if (ring->funcs->emit_gfx_shadow && ring->funcs->init_cond_exec &=
&
> +           adev->gfx.cp_gfx_shadow) {
>                 amdgpu_ring_emit_gfx_shadow(ring, 0, 0, 0, false, 0);
>                 amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr)=
;
>         }
> --
> 2.52.0
>
