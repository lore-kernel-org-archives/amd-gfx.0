Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7DDC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 18:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC3710E872;
	Wed, 10 Jul 2024 18:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C2y035w3";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E87A10E875
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 18:17:43 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-6eab07ae82bso3707400a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720635463; x=1721240263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKPMsSRRMC7XD5vyPh91/OSl/OZtsFOUiVpU6m3+2uQ=;
 b=C2y035w3m/5zPQ9J2LofhwoqWj/F0+YO8vDNQVwze1icFhlgf2DQiffKlAeusTXTaw
 hgPfdODazEABZtHLcEALdy/Rd7qO8DCMOP+otUhvwysHr75QZ1C4sNQTg1uetdkqQztb
 FIvIlFj/FI5NgUmdXtiagq+zLYDLv1ixbh0fHXZQZ/otl49ga3U1ucLw9XoXR1DEhbC+
 HiBjEOHGWyUXBh/dwcq6UKe8Rtnk8MKF1w8+HxamE0u5b1oyr40myzsZD1K8LWMta+Q/
 N4K5s1w+3awXkOGr1YGG7DHgJloBH/VP02T5vgCmZzPv5g7sa0h321tncKQlQI4GLUPf
 L7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720635463; x=1721240263;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKPMsSRRMC7XD5vyPh91/OSl/OZtsFOUiVpU6m3+2uQ=;
 b=Y4Gbf+/5wpTjobZsxoU2rnWgpH35VcjG+cLIeizZWwifGG7utBVgVuVkYtFwLfqVoY
 qjitSEBtvLOeS1pidiklspvpo7SjvSr6lnCOTH1kurUjriyMjPaPOWFk8cS7Y5uliZUF
 /1DqEvJeGJrS2imbTyFTOuo9qX3uHX/DGZohYWuxkMoLUijFb31kJlfXN5trxxJSQoXh
 UfBZUju78+GZkNrMOvYJ2d5j2MQfwx9+WJRRqYweiFijNuzMAKiENqQAL8SnZLAzyIft
 f9amPguFIexPgv2PFW2TxQiA1/DJRypom1uLnDInlRuz+rXyEBZ9MvnruvtSXacspRWN
 rabg==
X-Gm-Message-State: AOJu0YyUoknNZTy9xq5rfwvwkMPqPOqdujNNj/iZb/61W9n2MIFYxn9h
 pILAz1mtroy0+YYleHNafkcb7QscFW+E2y65R/mM8oPpwwoC/e802KULtvTd4EmARK8xWezHcyq
 h90A5AdngVGdF6VuMSnQtV+i02rOM3u4t
X-Google-Smtp-Source: AGHT+IGCk1b/q5kZzlsg40h8Vfa/5T6cX7anF1m3i1fmYIIiiwQ3OtcKh2zk04rZrSWYIIb4yudDYY6Axs96kU083NM=
X-Received: by 2002:a05:6a20:394a:b0:1c0:f17d:d81f with SMTP id
 adf61e73a8af0-1c298220948mr6595698637.21.1720635462643; Wed, 10 Jul 2024
 11:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240710180140.182275-1-boyuan.zhang@amd.com>
In-Reply-To: <20240710180140.182275-1-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Jul 2024 14:17:31 -0400
Message-ID: <CADnq5_NbX918h8FMPJO+t+bavZ=jheJ852JLdiReQeM3jdpvSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/vcn: identify unified queue in sw init
To: boyuan.zhang@amd.com
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

On Wed, Jul 10, 2024 at 2:10=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Determine whether VCN using unified queue in sw_init, instead of calling
> functions later on.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 39 ++++++++++---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>  2 files changed, 16 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index dad5f9722e14..43bed7730bd1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -139,6 +139,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>                 }
>         }
>
> +       /* from vcn4 and above, only unified queue is used */
> +       adev->vcn.using_unified_queue =3D
> +               amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_VERSION(4, 0=
, 0) ? true : false;

You can drop the "? true : false" part.  A lot of static checkers will
complain about that as it's not necessary.

With that fixed, the series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +
>         hdr =3D (const struct common_firmware_header *)adev->vcn.fw->data=
;
>         adev->vcn.fw_version =3D le32_to_cpu(hdr->ucode_version);
>
> @@ -266,18 +270,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -/* from vcn4 and above, only unified queue is used */
> -static bool amdgpu_vcn_using_unified_queue(struct amdgpu_ring *ring)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -       bool ret =3D false;
> -
> -       if (amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_VERSION(4, 0, 0)=
)
> -               ret =3D true;
> -
> -       return ret;
> -}
> -
>  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_rin=
g_type type, uint32_t vcn_instance)
>  {
>         bool ret =3D false;
> @@ -747,12 +739,11 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu=
_ring *ring,
>         struct amdgpu_job *job;
>         struct amdgpu_ib *ib;
>         uint64_t addr =3D AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
> -       bool sq =3D amdgpu_vcn_using_unified_queue(ring);
>         uint32_t *ib_checksum;
>         uint32_t ib_pack_in_dw;
>         int i, r;
>
> -       if (sq)
> +       if (adev->vcn.using_unified_queue)
>                 ib_size_dw +=3D 8;
>
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
> @@ -765,7 +756,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_r=
ing *ring,
>         ib->length_dw =3D 0;
>
>         /* single queue headers */
> -       if (sq) {
> +       if (adev->vcn.using_unified_queue) {
>                 ib_pack_in_dw =3D sizeof(struct amdgpu_vcn_decode_buffer)=
 / sizeof(uint32_t)
>                                                 + 4 + 2; /* engine info +=
 decoding ib in dw */
>                 ib_checksum =3D amdgpu_vcn_unified_ring_ib_header(ib, ib_=
pack_in_dw, false);
> @@ -784,7 +775,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_r=
ing *ring,
>         for (i =3D ib->length_dw; i < ib_size_dw; ++i)
>                 ib->ptr[i] =3D 0x0;
>
> -       if (sq)
> +       if (adev->vcn.using_unified_queue)
>                 amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, ib_pack=
_in_dw);
>
>         r =3D amdgpu_job_submit_direct(job, ring, &f);
> @@ -874,15 +865,15 @@ static int amdgpu_vcn_enc_get_create_msg(struct amd=
gpu_ring *ring, uint32_t hand
>                                          struct dma_fence **fence)
>  {
>         unsigned int ib_size_dw =3D 16;
> +       struct amdgpu_device *adev =3D ring->adev;
>         struct amdgpu_job *job;
>         struct amdgpu_ib *ib;
>         struct dma_fence *f =3D NULL;
>         uint32_t *ib_checksum =3D NULL;
>         uint64_t addr;
> -       bool sq =3D amdgpu_vcn_using_unified_queue(ring);
>         int i, r;
>
> -       if (sq)
> +       if (adev->vcn.using_unified_queue)
>                 ib_size_dw +=3D 8;
>
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
> @@ -896,7 +887,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgp=
u_ring *ring, uint32_t hand
>
>         ib->length_dw =3D 0;
>
> -       if (sq)
> +       if (adev->vcn.using_unified_queue)
>                 ib_checksum =3D amdgpu_vcn_unified_ring_ib_header(ib, 0x1=
1, true);
>
>         ib->ptr[ib->length_dw++] =3D 0x00000018;
> @@ -918,7 +909,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgp=
u_ring *ring, uint32_t hand
>         for (i =3D ib->length_dw; i < ib_size_dw; ++i)
>                 ib->ptr[i] =3D 0x0;
>
> -       if (sq)
> +       if (adev->vcn.using_unified_queue)
>                 amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>
>         r =3D amdgpu_job_submit_direct(job, ring, &f);
> @@ -941,15 +932,15 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct am=
dgpu_ring *ring, uint32_t han
>                                           struct dma_fence **fence)
>  {
>         unsigned int ib_size_dw =3D 16;
> +       struct amdgpu_device *adev =3D ring->adev;
>         struct amdgpu_job *job;
>         struct amdgpu_ib *ib;
>         struct dma_fence *f =3D NULL;
>         uint32_t *ib_checksum =3D NULL;
>         uint64_t addr;
> -       bool sq =3D amdgpu_vcn_using_unified_queue(ring);
>         int i, r;
>
> -       if (sq)
> +       if (adev->vcn.using_unified_queue)
>                 ib_size_dw +=3D 8;
>
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
> @@ -963,7 +954,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdg=
pu_ring *ring, uint32_t han
>
>         ib->length_dw =3D 0;
>
> -       if (sq)
> +       if (adev->vcn.using_unified_queue)
>                 ib_checksum =3D amdgpu_vcn_unified_ring_ib_header(ib, 0x1=
1, true);
>
>         ib->ptr[ib->length_dw++] =3D 0x00000018;
> @@ -985,7 +976,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdg=
pu_ring *ring, uint32_t han
>         for (i =3D ib->length_dw; i < ib_size_dw; ++i)
>                 ib->ptr[i] =3D 0x0;
>
> -       if (sq)
> +       if (adev->vcn.using_unified_queue)
>                 amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>
>         r =3D amdgpu_job_submit_direct(job, ring, &f);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index 081695e74932..838c0935f683 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -329,6 +329,7 @@ struct amdgpu_vcn {
>
>         uint16_t inst_mask;
>         uint8_t num_inst_per_aid;
> +       bool using_unified_queue;
>  };
>
>  struct amdgpu_fw_shared_rb_ptrs_struct {
> --
> 2.34.1
>
