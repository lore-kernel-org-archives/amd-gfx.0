Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D1FC5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 15:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85A0010F639;
	Fri, 14 Aug 2026 15:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bGIYjE+Z";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED0310F63A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 15:08:52 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38dd1cc8dc8so166009a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 08:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786720132; cv=none;
 d=google.com; s=arc-20260327;
 b=hWNvkHPsQkY6G7G10k+Z/kJfzi3aSCzmds81s+1BLPQ+E7rM+EwgGehpiPFkOzITPL
 aqbGNMe+7p32Z+jgy1XYEpiQnMBrvr8oYJHpZq06bQTsn/5tlSmBaWNWZ4T0KqH12IVm
 l8MvKgwnGVEbUXmi50HQEYMr20/lVtOklpNM2fogTChRbPUCL8w4DtfdfJm+Ayn+u622
 h3hyqBJHt4OPV95kjnM+iuYN4gkF7vYcOoDO/M+htmNKShaV64Jp5DWOrajWArtr0FLK
 mbFktOBXdmtRrTCUQaE95I45YcILAfMrpe+fTUv8wU3aLWqv/Qd7zSkmJdklu9DZVBJC
 WM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z2xTbGCBPJPqIpX4jtKxi4W4ED5opqTtU47wYYcqYSs=;
 fh=sjBhvESLaW/EhyR1JeRMPVrGAZEVhivFcDDWAoTEjJE=;
 b=iz5IbS1K9vP2ACl6fMBJPxKKw+Fuboro/J62Z/jmiNcr8anVTbEz9olI/n8oCVW8BK
 NvlGRU5oZpxL4LvVdR/mozVxZWPg8K6osn5AyjKwOk0ubFMS1si3nlzmdFeRJInkAoLD
 cG4WNZZBLHenj2/aSgWoOD7hk1ZiN5wHxFQhRWI7vXJI2Cr8NwkLM9SkRjg4oJ3lGlBo
 P0dVrRH6yfzl5Ei9LSXDzWkAsPLSx2S+9C1a8ik16zc7r28/jJDfP7QacFYH8hvAtiNc
 C12+q/PGyt8TrBzGasGCZf9DklqsBEf9Hr2aBrgI8g/IhqHKlVKVRSmfsakk85/db8aH
 fqQw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786720132; x=1787324932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z2xTbGCBPJPqIpX4jtKxi4W4ED5opqTtU47wYYcqYSs=;
 b=bGIYjE+Zz4Uk0NAFbKWEfvwJnLVfknniuzLE1U0vHwt7bRqsDBTRaM/esQnFX03jv0
 YXnUCskZf6vEayLMBMzaiBQpWkFLxeCSsR7KmxIjvReGdupNxmhj0aQ0YcrGB1t9NzS2
 +mLpGdrR/yzSFsNAypSrTbV1ZPPeFVNW52ISiLBRWeEyq3JCvyAIb3BPNTO4mgkLAQTd
 +gJ9NMEfQjLVBBuAiIJvRuvxeV6GcKPHtCNsF0Q2Fsk05ySVc07vgyjq/Xl3BFaYO6ca
 +LmKe7Trf4sGC6SMsuTAvxyFtszQsK0taOG+m9q5Z+CzJBBirs+xEOzeF5k4F9Q5WlBQ
 lPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786720132; x=1787324932;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z2xTbGCBPJPqIpX4jtKxi4W4ED5opqTtU47wYYcqYSs=;
 b=TZAnmQG/ug9ZpPYd6KpJO4fs2L7ZTtTEsB7V8Qj5wP9gww36TwQeGHr8cquYF8+tep
 zs3SMQ2N0M1IDJ5CZWF+vlNeQ0XpXpd97zYWgE4AkfoPFJmCaUrWMqpkI+Amfzv22ArT
 58SWaus9NoAgFa2QlswGDlyKvL7GRxeTxyEwv+YYCGQo1lc3O2AE7NKYkKvfzNpYacrK
 jHV3qkE20SLLL6elrRY2k55TlI38a1HTMR1xCnpu6fEfBG56hHDxWo2RYhhH8+1oMqyD
 DVV/WuYar2/ahzVj46if0nsNvjBqnGX1QMh7bCx9IkVQtEVAUNL0FLsdrKm8p3FnwF0h
 Dv5w==
X-Gm-Message-State: AOJu0YxXxJpzHWLffbydzPTTjci5/wjrxMAa7OVzlcdtIcehu2XogNRJ
 peQztde9JuThPkMAR55fuYXkeA7QcBQPcGg9cf3MsSAJzGBI6rV5HZ5Y1yQ44msO9rBgQo+RaOG
 wP6Fl6fsATWKJTX6ybFgbT8KY9Uv1Nnc=
X-Gm-Gg: AR+sD13lRM+VLZlXTPtDvRMVuFPAOvAmtWtMFLyjzMD3lYSW7cJP9PR+BAw9BfzMb9A
 p2NXv++z4k4zengzwauJEPnKbvNkUN+UZe7HM/31+DQQY1AWHurg7uL4U6C1x51x9soFTjblpxJ
 wzjJlHmyB+8Apoy6siXCppMzqc+nFqnED7gmfTOCEuOJi7XCBL5hKelX5Oq/Etv1foIcRKS2UoI
 gaZD1++CiaT40WDT5WXOoGghkbdNAGykOg0YLy809ennFFi3gXwSGpbCqLUKy84KELwd8I3gV6m
 QQofckzFwS/1XtK9HXwB1+AcO+gNYT55DgkbFH5UTUOSfhJzV2w6IPYmDEO5oDCNLFEvsDnoC6/
 6t0CJShTexmJy35XMQGSGPT7ueJzaNi0zUoCzHPZGbEE=
X-Received: by 2002:a17:90b:1d44:b0:38f:57f0:1f51 with SMTP id
 98e67ed59e1d1-3933b84ddd6mr4757867a91.0.1786720131720; Fri, 14 Aug 2026
 08:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260814145448.11178-2-david.rosca@amd.com>
In-Reply-To: <20260814145448.11178-2-david.rosca@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Aug 2026 11:08:38 -0400
X-Gm-Features: AUfX_my94hrw7sQoHkkYjGNyRA2p47AKW7i_rrWCMaj-VUA4lCmAJLoQ0pDJgAA
Message-ID: <CADnq5_PL-XC6_Y2au9OQxsD6xRm4dYqPX0xGh7PeLkHHTDf0FQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: Implement insert_end for VCE 3"
To: David Rosca <david.rosca@amd.com>
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

On Fri, Aug 14, 2026 at 11:05=E2=80=AFAM David Rosca <david.rosca@amd.com> =
wrote:
>
> This doesn't solve the issue, VCE still hangs in some cases.
>
> 4959138b6461 ("drm/amdgpu: handle GDS and SPM without a VM fence")
> fixes the regression, originally introduced in
> 83a8dee2bdfb ("drm/amdgpu: always emit the job vm fence").

This doesn't make sense to me.  GDS and SPM are not supported on VCN
in the first place so they would never be emitted for VCN.

Alex

>
> This reverts commit 7591335141a06d5b176510054576d9c64519f348.
>
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 26 ++++----------------------
>  1 file changed, 4 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v3_0.c
> index a9497e2e07f7..9f4e88440c0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -809,23 +809,6 @@ static void vce_v3_0_ring_emit_ib(struct amdgpu_ring=
 *ring,
>         amdgpu_ring_write(ring, ib->length_dw);
>  }
>
> -static void vce_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
> -                       u64 seq, unsigned flags)
> -{
> -       WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> -
> -       amdgpu_ring_write(ring, VCE_CMD_FENCE);
> -       amdgpu_ring_write(ring, addr);
> -       amdgpu_ring_write(ring, upper_32_bits(addr));
> -       amdgpu_ring_write(ring, seq);
> -       amdgpu_ring_write(ring, VCE_CMD_TRAP);
> -}
> -
> -static void vce_v3_0_ring_insert_end(struct amdgpu_ring *ring)
> -{
> -       amdgpu_ring_write(ring, VCE_CMD_END);
> -}
> -
>  static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
>                                    unsigned int vmid, uint64_t pd_addr)
>  {
> @@ -835,6 +818,7 @@ static void vce_v3_0_emit_vm_flush(struct amdgpu_ring=
 *ring,
>
>         amdgpu_ring_write(ring, VCE_CMD_FLUSH_TLB);
>         amdgpu_ring_write(ring, vmid);
> +       amdgpu_ring_write(ring, VCE_CMD_END);
>  }
>
>  static void vce_v3_0_emit_pipeline_sync(struct amdgpu_ring *ring)
> @@ -900,19 +884,17 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring=
_vm_funcs =3D {
>         .set_wptr =3D vce_v3_0_ring_set_wptr,
>         .patch_cs_in_place =3D amdgpu_vce_ring_parse_cs_vm,
>         .emit_frame_size =3D
> -               5 + /* vce_v3_0_emit_vm_flush */
> +               6 + /* vce_v3_0_emit_vm_flush */
>                 4 + /* vce_v3_0_emit_pipeline_sync */
> -               5 + 5 + /* vce_v3_0_ring_emit_fence x2 vm fence */
> -               1, /* vce_v3_0_ring_insert_end */
> +               6 + 6, /* amdgpu_vce_ring_emit_fence x2 vm fence */
>         .emit_ib_size =3D 5, /* vce_v3_0_ring_emit_ib */
>         .emit_ib =3D vce_v3_0_ring_emit_ib,
>         .emit_vm_flush =3D vce_v3_0_emit_vm_flush,
>         .emit_pipeline_sync =3D vce_v3_0_emit_pipeline_sync,
> -       .emit_fence =3D vce_v3_0_ring_emit_fence,
> +       .emit_fence =3D amdgpu_vce_ring_emit_fence,
>         .test_ring =3D amdgpu_vce_ring_test_ring,
>         .test_ib =3D amdgpu_vce_ring_test_ib,
>         .insert_nop =3D amdgpu_ring_insert_nop,
> -       .insert_end =3D vce_v3_0_ring_insert_end,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .begin_use =3D amdgpu_vce_ring_begin_use,
>         .end_use =3D amdgpu_vce_ring_end_use,
> --
> 2.43.0
>
