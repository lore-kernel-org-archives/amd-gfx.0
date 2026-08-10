Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4115C5B56D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 13:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F1F10E222;
	Mon, 10 Aug 2026 13:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F5MWpIx6";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2003310E222
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 13:16:04 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-384c94c9423so262597a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 06:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786367763; cv=none;
 d=google.com; s=arc-20260327;
 b=KCoHWi9VacvzcZylg42AbB4Y0I1v8of6raE0sLJgf58vVwSfpJXAP7Hx7H/fjjupVC
 wwBVNrUs5BDqbmkO62zhAA2WvII7NBt+jp3AizkdYwOOnXiHiqGBGU+l8AFTFCrEk4G1
 zDTjj5m3g7Ed3mueNXbtnZcIf1qK477PRRWZuHCWpaTbMZMcw6KlOOzcdmFt1VG9xnvH
 jte7XG5CWD5bmkZA7COXqFX9suKGFuzy1vMr7ntaA0IZtY+kUDZFTkdJNaPWo3/exTu4
 XekXteBCH26+tN+LrB3vdcCQn/lQnj1xxwYBS0iANJZ0YdI/RRymW77OesLf5gBWolaw
 pdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dWIC/E87Ra8BuPaDyYevYp9+twOX9v87EV2W6+V6VqM=;
 fh=sjBhvESLaW/EhyR1JeRMPVrGAZEVhivFcDDWAoTEjJE=;
 b=QTWcoV/b3X49GZNU/LQbcPW0bIcOarBrPwAPhU7n0NwX8Wh64NDQAJ5niTO2ley0J8
 l320pfByHoiWoZOJHPa86fGIt+8XpE13g0zZlv9c6xAhIbcOMoUAfBCOblG3naz2ejNO
 k0upth9aa8ruKl2km3qs7cCFaga1wTfOq4ypOT9h4SYzsC9Wp02c52VLExLABiVedbul
 soP9L0YvZk0ySa+A24+i/2HHdbu1PB1C76C2f6PZ03qLqc25ZhVxQZUc4CXyMQUXQhqN
 bC+bLZfzGMDzkl0fN7Z50yAO+di8FGpJ302fABcPJ4pdzdG0yl0ieMyqIesZ2z1SPdxO
 7c4Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786367763; x=1786972563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dWIC/E87Ra8BuPaDyYevYp9+twOX9v87EV2W6+V6VqM=;
 b=F5MWpIx69/PnkEQCo7umSsBrhg1YVN3M/F/FX2DKu8/jh7/m2s7PU+kEW8jjGWdagT
 hJzlzZbmwJro2BgrkJkLCCtZYT4s02O2gkHyMxnQ1Zj4pfvFXDr6g0rygk0sRxcYPoN1
 Nc/W9N7R6leTDBnQPal4UVYlNm1X7fcq4ds/4YgI7xF1o1PstSPvfGOmS6s/r1ycX60g
 vwuvR2WPDUFCRjhMgH3YOeomJSdL/pJ20SWIE1MKmSyUgjloJpV/o5qcBKtgRUtylBXV
 Ef5Ik51VDZuFENRuzW9oqLzF1bicCol3KfbWiXD/AqEsfoVaJboWxvFTACaUyb0xD2tn
 eiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786367763; x=1786972563;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dWIC/E87Ra8BuPaDyYevYp9+twOX9v87EV2W6+V6VqM=;
 b=QdeeYiTVdgaq1zXO3WM+PAdsw1AgQ/2bEISZaVB/kd3jU0svVSM3OPA/uRs5HCZDyj
 Un4b2jMxYLJNy3HEcm92PkNZ/NjKry/GXxaVIgmKbDN3gtb9n0vd/uf4noaxYfmHEEEk
 BAPIJL7Nl8sOBZbR4kG7rqj3jSK3iYypg2F+C/kngtZ/x1Bm/BXG2gSXZh8Ex0vtPAmp
 XijV6YiDiXjFBPd4T5nrTwxIzbsXehZptFPFbyxyxPialOtrmQzcqmoJtrJJxbOrVn7o
 nn+FmfVzCt86CgiH7c4oHjJ8eeZimdXe3q7otU+PKg9wjQ4VlvnmzQFNmxKHzZXz4oPj
 5cMg==
X-Gm-Message-State: AOJu0YwAlPfv8BgBV/Jl18NPQ5eLGNAzVDSLMITkY/33BqIz9YFGWrCd
 L2SZ8ufuwMz961/2BJUPG1JyQpArHpjUnjpG8Y+zRfRIbNpvHEp8fW/jWNM+S686qwn3fYdYavb
 +GHVZXAyarDdNRce5zHCx8Xg05yCyOaA6Gg==
X-Gm-Gg: AR+sD11PX1iNNo8vylEzhvjNRKezKcTwmVAAIhrFkxOSfXdaC8nxtVUm5wvb4yFLGkC
 oJx1WfZffHGc5se6LUtOi+ymc3KYvs5CyIojMNExBORp09YHmDJ5QJoGvZiPyarKc8Cd7MhSOdr
 lPkZeVpMJITOzvfvwcjL/mFWIlIl77Bg5K9Lqe8iN7552Y/jnwQS/7FWbZPTobPboAivByttX9s
 gbxfjldujelJsP4JX+LpP6lO4wMoAons/x/tSeGnRBaxTNXQpApeHaud/5fUqvRL8vXcBq9EWvb
 2+Dm2AV7XTsupn18UDqXx87WD3Vv+82CBnk7oMNKhYQDGPrdIxIKOCl52zVszw7w6indwgS+Rn2
 Db+RZzPFvhd6mXY0uE16k4PAQERwzes0=
X-Received: by 2002:a17:90b:3803:b0:38e:55ec:e436 with SMTP id
 98e67ed59e1d1-3903b9c95aamr29570907a91.0.1786367763421; Mon, 10 Aug 2026
 06:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260810095440.9135-2-david.rosca@amd.com>
In-Reply-To: <20260810095440.9135-2-david.rosca@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 09:15:51 -0400
X-Gm-Features: AUfX_mwCUDgiqWpMrgFa3Q2DNKNSls2bQDIW7MN3crzXxKP7CvBsFRhKou7C3O0
Message-ID: <CADnq5_M-H-zaLFMHFzYQd2CNywxFxUaSJK+G0uD3c0t5ZqwUhw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Implement insert_end for VCE 3
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

On Mon, Aug 10, 2026 at 5:55=E2=80=AFAM David Rosca <david.rosca@amd.com> w=
rote:
>
> After a recent change VCE now hangs when VCE_CMD_END is emitted
> after a pipeline sync without VM flush.
> Implement insert_end to correctly insert only one VCE_CMD_END per job.
>
> Fixes: 83a8dee2bdfb ("drm/amdgpu: always emit the job vm fence")
> Signed-off-by: David Rosca <david.rosca@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v3_0.c
> index 9f4e88440c0a..a9497e2e07f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -809,6 +809,23 @@ static void vce_v3_0_ring_emit_ib(struct amdgpu_ring=
 *ring,
>         amdgpu_ring_write(ring, ib->length_dw);
>  }
>
> +static void vce_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
> +                       u64 seq, unsigned flags)
> +{
> +       WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> +
> +       amdgpu_ring_write(ring, VCE_CMD_FENCE);
> +       amdgpu_ring_write(ring, addr);
> +       amdgpu_ring_write(ring, upper_32_bits(addr));
> +       amdgpu_ring_write(ring, seq);
> +       amdgpu_ring_write(ring, VCE_CMD_TRAP);
> +}
> +
> +static void vce_v3_0_ring_insert_end(struct amdgpu_ring *ring)
> +{
> +       amdgpu_ring_write(ring, VCE_CMD_END);
> +}
> +
>  static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
>                                    unsigned int vmid, uint64_t pd_addr)
>  {
> @@ -818,7 +835,6 @@ static void vce_v3_0_emit_vm_flush(struct amdgpu_ring=
 *ring,
>
>         amdgpu_ring_write(ring, VCE_CMD_FLUSH_TLB);
>         amdgpu_ring_write(ring, vmid);
> -       amdgpu_ring_write(ring, VCE_CMD_END);
>  }
>
>  static void vce_v3_0_emit_pipeline_sync(struct amdgpu_ring *ring)
> @@ -884,17 +900,19 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring=
_vm_funcs =3D {
>         .set_wptr =3D vce_v3_0_ring_set_wptr,
>         .patch_cs_in_place =3D amdgpu_vce_ring_parse_cs_vm,
>         .emit_frame_size =3D
> -               6 + /* vce_v3_0_emit_vm_flush */
> +               5 + /* vce_v3_0_emit_vm_flush */
>                 4 + /* vce_v3_0_emit_pipeline_sync */
> -               6 + 6, /* amdgpu_vce_ring_emit_fence x2 vm fence */
> +               5 + 5 + /* vce_v3_0_ring_emit_fence x2 vm fence */
> +               1, /* vce_v3_0_ring_insert_end */
>         .emit_ib_size =3D 5, /* vce_v3_0_ring_emit_ib */
>         .emit_ib =3D vce_v3_0_ring_emit_ib,
>         .emit_vm_flush =3D vce_v3_0_emit_vm_flush,
>         .emit_pipeline_sync =3D vce_v3_0_emit_pipeline_sync,
> -       .emit_fence =3D amdgpu_vce_ring_emit_fence,
> +       .emit_fence =3D vce_v3_0_ring_emit_fence,
>         .test_ring =3D amdgpu_vce_ring_test_ring,
>         .test_ib =3D amdgpu_vce_ring_test_ib,
>         .insert_nop =3D amdgpu_ring_insert_nop,
> +       .insert_end =3D vce_v3_0_ring_insert_end,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .begin_use =3D amdgpu_vce_ring_begin_use,
>         .end_use =3D amdgpu_vce_ring_end_use,
> --
> 2.43.0
>
