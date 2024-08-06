Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B68C52D6F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 20:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 541A510E3F6;
	Tue,  6 Aug 2024 20:27:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MizeeT3K";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2DB410E3F6
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 20:27:33 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1fd66cddd07so11008345ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Aug 2024 13:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722976053; x=1723580853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2SlQTvaT7TROuoEV6PEh4kEx+2lH41v4ixI88Tg6soE=;
 b=MizeeT3KT+2hR20cpWxmUdEBP+E6zXeWEOLc/TTBjqEYdAmmpGJE+3+kcgUhXgSky1
 w5xG4me0OZ6u47YoHndCPwOtaAL5q8GBI0CEwgB111FFj2vB5yzl8FKlWVz4/im+MWhs
 v/IYLSVdDuXeJCK2QvkfR3WBRYhbweTeE9K/9hZs5rnvPsI+2VZw8kULizjG7fUn2aKC
 OVrBPIfASpePZdW+D6W3CdtNeOwnXuP5AH1PaqqPfAlNwjCBhQgDkj7CZQeJ6nBLjoTs
 aiaRVyTkzBEpRboLszHt/nTUXGA/Hqr8brOgbgP0Y+w9va4JNdf4wa0Khv15VOSQC+/q
 KVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722976053; x=1723580853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2SlQTvaT7TROuoEV6PEh4kEx+2lH41v4ixI88Tg6soE=;
 b=gndOZRViBmfBLV2niRS/paBurnA501w0AB/SC3f1feW2+6zB6eGgBTOnOeikqI1DtE
 oBQBvBqtC6KllXJaselHRIlZ/REVzowUAcUbhXCfNmD3GI7akPey707svZ8O37qJ0eZA
 3e1GdfJy8oE7ngqEHf3tL7sRDse4UBHd51HHDZem12ngMGwa3gGyN6Jn82f86TRWV+aZ
 bCKnGkhZa8ZpMn7aHHxTSctbW7g1uAeIbevV6cTVoi0k1XJOaj4KLi5F4ImMUUb34vrA
 pomJGLA6/y+kQ3KLp8yE677BTCuwIbmlSD51+I1MD1dThERWC4insxV8FC1ri2ocKw7H
 8NgQ==
X-Gm-Message-State: AOJu0Yyfbgd+1q2/u/ohVbFIahnAgO5xq1wIfkzrEB6ieQ4baoaJVMPG
 DCUBQUDZNIpGC1wl2xIRXnunpgcmoHHg1g3qCzzn3hYA2F8s1Cx4BAOj7SbzoeHxpncKh8+Lena
 HMN0iA1ybPiPhHhXpGr4Va1lcdttsEkCx
X-Google-Smtp-Source: AGHT+IH5IsxHUgLrbMKglzHFT4g3BtkMM3rKEfcm52wrlSA3pxv9lpwxPmHsb+W7l6GfEWe9PVR/WoWd+LrM09ju6Jw=
X-Received: by 2002:a17:902:c402:b0:1fd:d4c2:a2ef with SMTP id
 d9443c01a7336-1ff572910d9mr188796435ad.21.1722976053102; Tue, 06 Aug 2024
 13:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240806160012.234633-1-David.Wu3@amd.com>
 <20240806160012.234633-2-David.Wu3@amd.com>
In-Reply-To: <20240806160012.234633-2-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Aug 2024 16:27:20 -0400
Message-ID: <CADnq5_Nw7G44i37z_b8iHiJfVmD3BB9NfM1gTrqoF0ZE1A34EA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu: cleanup parse_cs callbacks
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com, leo.liu@amd.com
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

On Tue, Aug 6, 2024 at 12:00=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> Because gpu_addr is updated in the calling routine
> (amdgpu_cs_patch_ibs()),it is removed in the callback.
>
> Use .patch_cs_in_place instead of .parse_cs for
> amdgpu_vce_ring_parse_cs_vm() as there is no need for keeping
> a temporary IB, therefore ib->sa_bo is NULL and amdgpu_ib_free()
> is removed.

Took me a while to page this all back into my head, but this works
because in this case, we still use the user's IB, we just use the
parsing to deal with the session handles.  This code really should
have used patch_cs_in_place from the beginning, but it didn't exist at
that point.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 --
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   | 2 +-
>  4 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index 07d930339b07..98863e920e00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1088,7 +1088,6 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parse=
r *parser,
>         int r;
>
>         job->vm =3D NULL;
> -       ib->gpu_addr =3D amdgpu_sa_bo_gpu_addr(ib->sa_bo);
>
>         if (ib->length_dw % 16) {
>                 DRM_ERROR("UVD IB length (%d) not 16 dwords aligned!\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.c
> index 968ca2c84ef7..6efb15c5fa1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -749,7 +749,6 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser =
*p,
>         int i, r =3D 0;
>
>         job->vm =3D NULL;
> -       ib->gpu_addr =3D amdgpu_sa_bo_gpu_addr(ib->sa_bo);
>
>         for (idx =3D 0; idx < ib->length_dw;) {
>                 uint32_t len =3D amdgpu_ib_get_value(ib, idx);
> @@ -1044,7 +1043,6 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_pa=
rser *p,
>         if (!r) {
>                 /* No error, free all destroyed handle slots */
>                 tmp =3D destroyed;
> -               amdgpu_ib_free(p->adev, ib, NULL);
>         } else {
>                 /* Error during parsing, free all allocated handle slots =
*/
>                 tmp =3D allocated;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v3_0.c
> index 32517c364cf7..4bfba2931b08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -950,7 +950,7 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_v=
m_funcs =3D {
>         .get_rptr =3D vce_v3_0_ring_get_rptr,
>         .get_wptr =3D vce_v3_0_ring_get_wptr,
>         .set_wptr =3D vce_v3_0_ring_set_wptr,
> -       .parse_cs =3D amdgpu_vce_ring_parse_cs_vm,
> +       .patch_cs_in_place =3D amdgpu_vce_ring_parse_cs_vm,
>         .emit_frame_size =3D
>                 6 + /* vce_v3_0_emit_vm_flush */
>                 4 + /* vce_v3_0_emit_pipeline_sync */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v4_0.c
> index 06d787385ad4..0748bf44c880 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -1102,7 +1102,7 @@ static const struct amdgpu_ring_funcs vce_v4_0_ring=
_vm_funcs =3D {
>         .get_rptr =3D vce_v4_0_ring_get_rptr,
>         .get_wptr =3D vce_v4_0_ring_get_wptr,
>         .set_wptr =3D vce_v4_0_ring_set_wptr,
> -       .parse_cs =3D amdgpu_vce_ring_parse_cs_vm,
> +       .patch_cs_in_place =3D amdgpu_vce_ring_parse_cs_vm,
>         .emit_frame_size =3D
>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
> --
> 2.34.1
>
