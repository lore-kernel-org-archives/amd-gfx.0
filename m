Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591DBC3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 20:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF4E910E1A3;
	Fri, 26 Jul 2024 20:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SCd/GOnj";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D07F10E1A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 20:25:21 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-70ea93aa9bdso1113589b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722025521; x=1722630321; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4uS9iNm7MmmWVeq47NDp3+tQd70pK9WAp7Ov0yJ2tU=;
 b=SCd/GOnj8UjHi7xHdaF+ACxjroXwPr527wRWd5J7svL5tM+2PlBtpE2VdGC/kBr4Nc
 jQnQDigwqWpg4TVIXyd6WHTdwbWTpLOcfuG8vUHBPnSghUwle07dyRNU/YGbB3UehzcX
 PV5UfOHoNwLIo55idTLHb+8LtbzUqrmM/x27AtKJlgPV/g/QLd3QIHU0htK57VCkRwgO
 2ev6KMDR+7293HfDpiB/3aBekJnxowDGKDMM6q8noX67gMdXzUDGmydI+iEc453MLuGl
 +xrY9AUJXSRc7f9futoZuY1cg+uoFc+FAqJnpthIQV90ExNqXrUpN8xkiH3k/GkoGa+v
 EbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722025521; x=1722630321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4uS9iNm7MmmWVeq47NDp3+tQd70pK9WAp7Ov0yJ2tU=;
 b=B1JOoEBHFBre9/6cXtM9nU9HOfglLYxvMempnHvMs0eJSw4e8F1VfdrOp4SHgwssZv
 vEERG/RnkgnLym9Q2xsjiJrRXmCjpHcsNUsoTN37w6ZbNVX3JqwyUdyGGy00gWvgOIn+
 2jzlwG0MRXpliiIvNwQOBI1EDSg4eZc75iRXj4BsJHhFEfmRC09nKZOFvQwkSfe/rD6y
 lGLtbyrsxlmalXebiLp/h5FwxrXpZGVfjh/ugWRJRjSkWAl6Pyx4CHp2KCCfth/rmipz
 ediCtLhTbWXYiOsZ4W9crHDrT/VMuznsVjfva/dE6A/nhotW+GVr0EEILGSpYs54z0IE
 sGQA==
X-Gm-Message-State: AOJu0Yxc2W3KQyNLI3FuZk1+Hh5JbXnEgGq0dJDmwmV+tBqZmMI/LDRs
 ySbxI+3Qq6p6wAw9Pw3gCXGZWJq+Y8bFIuCoGNHJk+LRno0sPDFhONpSU9XsIVoQ32L+yAisXAy
 Flkw0L1EcwnLe7U8ouE42lm65GoA=
X-Google-Smtp-Source: AGHT+IEO1lyIwD6wiPRxw+IOXHAGIgH2pS1YlQfmSFA5El5mNMSl4oiV40IfQ2LHqpDMrrr2P5cru3PBv2WOITpVp+w=
X-Received: by 2002:a05:6a20:72a3:b0:1c4:a1f4:3490 with SMTP id
 adf61e73a8af0-1c4a1f44e94mr629802637.39.1722025520678; Fri, 26 Jul 2024
 13:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240726153049.1296575-1-Jonathan.Kim@amd.com>
In-Reply-To: <20240726153049.1296575-1-Jonathan.Kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jul 2024 16:25:08 -0400
Message-ID: <CADnq5_M3m6Gr4xbrGNXKVpc7wMMM_9Og5oF83do47rntROf3tQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdkfd: support per-queue reset on gfx9
To: Jonathan Kim <Jonathan.Kim@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, 
 Alexander.Deucher@amd.com
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

On Fri, Jul 26, 2024 at 11:31=E2=80=AFAM Jonathan Kim <Jonathan.Kim@amd.com=
> wrote:
>
> Support per-queue reset for GFX9.  The recommendation is for the driver
> to target reset the HW queue via a SPI MMIO register write.
>
> Since this requires pipe and HW queue info and MEC FW is limited to
> doorbell reports of hung queues after an unmap failure, scan the HW
> queue slots defined by SET_RESOURCES first to identify the user queue
> candidates to reset.
>
> Only signal reset events to processes that have had a queue reset.
>
> If queue reset fails, fall back to GPU reset.
>
> v2: move reset queue flag for house keeping to process device.
> split detect and reset into separate functions.
> make reset call safe during power saving modes.
> clean up some other nitpicks.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   2 +
>  .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   4 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |   4 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  16 ++
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   9 +
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   4 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  18 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  85 +++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   9 +
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 172 +++++++++++++++++-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  12 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  21 +++
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   6 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |   6 +
>  16 files changed, 360 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index aff08321e976..8dfdb18197c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -191,4 +191,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
>         .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
>         .build_grace_period_packet_info =3D kgd_gfx_v9_build_grace_period=
_packet_info,
>         .program_trap_handler_settings =3D kgd_gfx_v9_program_trap_handle=
r_settings,
> +       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
> +       .hqd_reset =3D kgd_gfx_v9_hqd_reset,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 3a3f3ce09f00..017e8a3013aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -418,5 +418,7 @@ const struct kfd2kgd_calls arcturus_kfd2kgd =3D {
>         .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
>         .build_grace_period_packet_info =3D kgd_gfx_v9_build_grace_period=
_packet_info,
>         .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
> -       .program_trap_handler_settings =3D kgd_gfx_v9_program_trap_handle=
r_settings
> +       .program_trap_handler_settings =3D kgd_gfx_v9_program_trap_handle=
r_settings,
> +       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
> +       .hqd_reset =3D kgd_gfx_v9_hqd_reset
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index a5c7259cf2a3..e2ae714a700f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -541,5 +541,7 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {
>                         kgd_gfx_v9_4_3_set_wave_launch_trap_override,
>         .set_wave_launch_mode =3D kgd_aldebaran_set_wave_launch_mode,
>         .set_address_watch =3D kgd_gfx_v9_4_3_set_address_watch,
> -       .clear_address_watch =3D kgd_gfx_v9_4_3_clear_address_watch
> +       .clear_address_watch =3D kgd_gfx_v9_4_3_clear_address_watch,
> +       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
> +       .hqd_reset =3D kgd_gfx_v9_hqd_reset
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 3ab6c3aa0ad1..62176d607bef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -1070,6 +1070,20 @@ static void program_trap_handler_settings(struct a=
mdgpu_device *adev,
>         unlock_srbm(adev);
>  }
>
> +uint64_t kgd_gfx_v10_hqd_get_pq_addr(struct amdgpu_device *adev,
> +                                    uint32_t pipe_id, uint32_t queue_id,
> +                                    uint32_t inst)
> +{
> +       return 0;
> +}
> +
> +uint64_t kgd_gfx_v10_hqd_reset(struct amdgpu_device *adev,
> +                              uint32_t pipe_id, uint32_t queue_id,
> +                              uint32_t inst, unsigned int utimeout)
> +{
> +       return 0;
> +}
> +
>  const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
>         .program_sh_mem_settings =3D kgd_program_sh_mem_settings,
>         .set_pasid_vmid_mapping =3D kgd_set_pasid_vmid_mapping,
> @@ -1097,4 +1111,6 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
>         .get_iq_wait_times =3D kgd_gfx_v10_get_iq_wait_times,
>         .build_grace_period_packet_info =3D kgd_gfx_v10_build_grace_perio=
d_packet_info,
>         .program_trap_handler_settings =3D program_trap_handler_settings,
> +       .hqd_get_pq_addr =3D kgd_gfx_v10_hqd_get_pq_addr,
> +       .hqd_reset =3D kgd_gfx_v10_hqd_reset
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index 67bcaa3d4226..9efd2dd4fdd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -56,3 +56,12 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct=
 amdgpu_device *adev,
>                                                uint32_t grace_period,
>                                                uint32_t *reg_offset,
>                                                uint32_t *reg_data);
> +uint64_t kgd_gfx_v10_hqd_get_pq_addr(struct amdgpu_device *adev,
> +                                   uint32_t pipe_id,
> +                                   uint32_t queue_id,
> +                                   uint32_t inst);
> +uint64_t kgd_gfx_v10_hqd_reset(struct amdgpu_device *adev,
> +                             uint32_t pipe_id,
> +                             uint32_t queue_id,
> +                             uint32_t inst,
> +                             unsigned int utimeout);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> index 8c8437a4383f..c718bedda0ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> @@ -680,5 +680,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd =3D {
>         .set_wave_launch_trap_override =3D kgd_gfx_v10_set_wave_launch_tr=
ap_override,
>         .set_wave_launch_mode =3D kgd_gfx_v10_set_wave_launch_mode,
>         .set_address_watch =3D kgd_gfx_v10_set_address_watch,
> -       .clear_address_watch =3D kgd_gfx_v10_clear_address_watch
> +       .clear_address_watch =3D kgd_gfx_v10_clear_address_watch,
> +       .hqd_get_pq_addr =3D kgd_gfx_v10_hqd_get_pq_addr,
> +       .hqd_reset =3D kgd_gfx_v10_hqd_reset
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> index b61a32d6af4b..a4ba49cb22db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> @@ -786,6 +786,20 @@ static uint32_t kgd_gfx_v11_clear_address_watch(stru=
ct amdgpu_device *adev,
>         return 0;
>  }
>
> +static uint64_t kgd_gfx_v11_hqd_get_pq_addr(struct amdgpu_device *adev,
> +                                           uint32_t pipe_id, uint32_t qu=
eue_id,
> +                                           uint32_t inst)
> +{
> +       return 0;
> +}
> +
> +static uint64_t kgd_gfx_v11_hqd_reset(struct amdgpu_device *adev,
> +                                     uint32_t pipe_id, uint32_t queue_id=
,
> +                                     uint32_t inst, unsigned int utimeou=
t)
> +{
> +       return 0;
> +}
> +
>  const struct kfd2kgd_calls gfx_v11_kfd2kgd =3D {
>         .program_sh_mem_settings =3D program_sh_mem_settings_v11,
>         .set_pasid_vmid_mapping =3D set_pasid_vmid_mapping_v11,
> @@ -808,5 +822,7 @@ const struct kfd2kgd_calls gfx_v11_kfd2kgd =3D {
>         .set_wave_launch_trap_override =3D kgd_gfx_v11_set_wave_launch_tr=
ap_override,
>         .set_wave_launch_mode =3D kgd_gfx_v11_set_wave_launch_mode,
>         .set_address_watch =3D kgd_gfx_v11_set_address_watch,
> -       .clear_address_watch =3D kgd_gfx_v11_clear_address_watch
> +       .clear_address_watch =3D kgd_gfx_v11_clear_address_watch,
> +       .hqd_get_pq_addr =3D kgd_gfx_v11_hqd_get_pq_addr,
> +       .hqd_reset =3D kgd_gfx_v11_hqd_reset
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 5a35a8ca8922..32f28c12077b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1144,6 +1144,89 @@ void kgd_gfx_v9_program_trap_handler_settings(stru=
ct amdgpu_device *adev,
>         kgd_gfx_v9_unlock_srbm(adev, inst);
>  }
>
> +uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
> +                                   uint32_t pipe_id, uint32_t queue_id,
> +                                   uint32_t inst)
> +{
> +       uint32_t low, high;
> +       uint64_t queue_addr =3D 0;
> +
> +       kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
> +       amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
> +
> +       if (!RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE))
> +               goto unlock_out;
> +
> +       low =3D RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE);
> +       high =3D RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE_HI=
);
> +
> +       /* only concerned with user queues. */
> +       if (!high)
> +               goto unlock_out;
> +
> +       queue_addr =3D (((queue_addr | high) << 32) | low) << 8;
> +
> +unlock_out:
> +       amdgpu_gfx_rlc_exit_safe_mode(adev, inst);
> +       kgd_gfx_v9_release_queue(adev, inst);
> +
> +       return queue_addr;
> +}
> +
> +uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
> +                             uint32_t pipe_id, uint32_t queue_id,
> +                             uint32_t inst, unsigned int utimeout)
> +{
> +       uint32_t low, high, temp;
> +       unsigned long end_jiffies;
> +       uint64_t queue_addr =3D 0;
> +
> +       kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
> +       amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
> +
> +       if (!RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE))
> +               goto unlock_out;
> +
> +       low =3D RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE);
> +       high =3D RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE_HI=
);
> +
> +       /* only concerned with user queues. */
> +       if (!high)
> +               goto unlock_out;
> +
> +       queue_addr =3D (((queue_addr | high) << 32) | low) << 8;
> +
> +       pr_debug("Attempting queue reset on XCC %i pipe id %i queue id %i=
\n",
> +                inst, pipe_id, queue_id);
> +
> +       /* assume previous dequeue request issued will take affect after =
reset */
> +       WREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_COMPUTE_QUEUE_RESET, 0=
x1);
> +
> +       end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
> +       while (true) {
> +               temp =3D RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_AC=
TIVE);
> +
> +               if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
> +                       break;
> +
> +               if (time_after(jiffies, end_jiffies)) {
> +                       queue_addr =3D 0;
> +                       break;
> +               }
> +
> +               usleep_range(500, 1000);
> +       }
> +
> +       pr_debug("queue reset on XCC %i pipe id %i queue id %i %s\n",
> +                inst, pipe_id, queue_id, !!queue_addr ? "succeeded!" : "=
failed!");
> +
> +unlock_out:
> +       amdgpu_gfx_rlc_exit_safe_mode(adev, inst);
> +       kgd_gfx_v9_release_queue(adev, inst);
> +
> +       return queue_addr;
> +}
> +
>  const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
>         .program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
>         .set_pasid_vmid_mapping =3D kgd_gfx_v9_set_pasid_vmid_mapping,
> @@ -1172,4 +1255,6 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
>         .build_grace_period_packet_info =3D kgd_gfx_v9_build_grace_period=
_packet_info,
>         .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
>         .program_trap_handler_settings =3D kgd_gfx_v9_program_trap_handle=
r_settings,
> +       .hqd_get_pq_addr =3D kgd_gfx_v9_hqd_get_pq_addr,
> +       .hqd_reset =3D kgd_gfx_v9_hqd_reset
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index ce424615f59b..988c50ac3be0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -101,3 +101,12 @@ void kgd_gfx_v9_build_grace_period_packet_info(struc=
t amdgpu_device *adev,
>                                                uint32_t grace_period,
>                                                uint32_t *reg_offset,
>                                                uint32_t *reg_data);
> +uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
> +                                   uint32_t pipe_id,
> +                                   uint32_t queue_id,
> +                                   uint32_t inst);
> +uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
> +                             uint32_t pipe_id,
> +                             uint32_t queue_id,
> +                             uint32_t inst,
> +                             unsigned int utimeout);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index fdc76c24b2e7..e335703eff84 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -153,6 +153,20 @@ void program_sh_mem_settings(struct device_queue_man=
ager *dqm,
>
>  static void kfd_hws_hang(struct device_queue_manager *dqm)
>  {
> +       struct device_process_node *cur;
> +       struct qcm_process_device *qpd;
> +       struct queue *q;
> +
> +       /* Mark all device queues as reset. */
> +       list_for_each_entry(cur, &dqm->queues, list) {
> +               qpd =3D cur->qpd;
> +               list_for_each_entry(q, &qpd->queues_list, list) {
> +                       struct kfd_process_device *pdd =3D qpd_to_pdd(qpd=
);
> +
> +                       pdd->has_reset_queue =3D true;
> +               }
> +       }
> +
>         /*
>          * Issue a GPU reset if HWS is unresponsive
>          */
> @@ -878,6 +892,12 @@ static int update_queue(struct device_queue_manager =
*dqm, struct queue *q,
>                 else if (prev_active)
>                         retval =3D remove_queue_mes(dqm, q, &pdd->qpd);
>
> +               /* queue is reset so inaccessable  */
> +               if (pdd->has_reset_queue) {
> +                       retval =3D -EACCES;
> +                       goto out_unlock;
> +               }
> +
>                 if (retval) {
>                         dev_err(dev, "unmap queue failed\n");
>                         goto out_unlock;
> @@ -1627,7 +1647,7 @@ static int initialize_cpsch(struct device_queue_man=
ager *dqm)
>  static int start_cpsch(struct device_queue_manager *dqm)
>  {
>         struct device *dev =3D dqm->dev->adev->dev;
> -       int retval;
> +       int retval, num_hw_queue_slots;
>
>         retval =3D 0;
>
> @@ -1680,6 +1700,14 @@ static int start_cpsch(struct device_queue_manager=
 *dqm)
>                                         &dqm->wait_times);
>         }
>
> +       /* setup per-queue reset detection buffer  */
> +       num_hw_queue_slots =3D  dqm->dev->kfd->shared_resources.num_queue=
_per_pipe *
> +                             dqm->dev->kfd->shared_resources.num_pipe_pe=
r_mec *
> +                             NUM_XCC(dqm->dev->xcc_mask);
> +
> +       dqm->detect_hang_info_size =3D num_hw_queue_slots * sizeof(struct=
 dqm_detect_hang_info);
> +       dqm->detect_hang_info =3D kzalloc(dqm->detect_hang_info_size, GFP=
_KERNEL);
> +
>         dqm_unlock(dqm);
>
>         return 0;
> @@ -1713,6 +1741,7 @@ static int stop_cpsch(struct device_queue_manager *=
dqm)
>         kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
>         if (!dqm->dev->kfd->shared_resources.enable_mes)
>                 pm_uninit(&dqm->packet_mgr);
> +       kfree(dqm->detect_hang_info);
>         dqm_unlock(dqm);
>
>         return 0;
> @@ -1929,6 +1958,131 @@ static int map_queues_cpsch(struct device_queue_m=
anager *dqm)
>         return retval;
>  }
>
> +static void set_queue_as_reset(struct device_queue_manager *dqm, struct =
queue *q,
> +                              struct qcm_process_device *qpd)
> +{
> +       struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);
> +
> +       pr_err("queue id 0x%0x at pasid 0x%0x is reset\n",
> +              q->properties.queue_id, q->process->pasid);
> +
> +       pdd->has_reset_queue =3D true;
> +       if (q->properties.is_active) {
> +               q->properties.is_active =3D false;
> +               decrement_queue_count(dqm, qpd, q);
> +       }
> +}
> +
> +static int detect_queue_hang(struct device_queue_manager *dqm)
> +{
> +       int i;
> +
> +       memset(dqm->detect_hang_info, 0, dqm->detect_hang_info_size);
> +
> +       for (i =3D 0; i < AMDGPU_MAX_QUEUES; ++i) {
> +               uint32_t mec, pipe, queue;
> +               int xcc_id;
> +
> +               mec =3D (i / dqm->dev->kfd->shared_resources.num_queue_pe=
r_pipe)
> +                       / dqm->dev->kfd->shared_resources.num_pipe_per_me=
c;
> +
> +               if (mec || !test_bit(i, dqm->dev->kfd->shared_resources.c=
p_queue_bitmap))
> +                       continue;
> +
> +               amdgpu_queue_mask_bit_to_mec_queue(dqm->dev->adev, i, &me=
c, &pipe, &queue);
> +
> +               for_each_inst(xcc_id, dqm->dev->xcc_mask) {
> +                       uint64_t queue_addr =3D dqm->dev->kfd2kgd->hqd_ge=
t_pq_addr(
> +                                               dqm->dev->adev, pipe, que=
ue, xcc_id);
> +                       struct dqm_detect_hang_info hang_info;
> +
> +                       if (!queue_addr)
> +                               continue;
> +
> +                       hang_info.pipe_id =3D pipe;
> +                       hang_info.queue_id =3D queue;
> +                       hang_info.xcc_id =3D xcc_id;
> +                       hang_info.queue_address =3D queue_addr;
> +
> +                       dqm->detect_hang_info[dqm->detect_hang_count] =3D=
 hang_info;
> +                       dqm->detect_hang_count++;
> +               }
> +       }
> +
> +       return dqm->detect_hang_count;
> +}
> +
> +static struct queue *find_queue_by_address(struct device_queue_manager *=
dqm, uint64_t queue_address)
> +{
> +       struct device_process_node *cur;
> +       struct qcm_process_device *qpd;
> +       struct queue *q;
> +
> +       list_for_each_entry(cur, &dqm->queues, list) {
> +               qpd =3D cur->qpd;
> +               list_for_each_entry(q, &qpd->queues_list, list) {
> +                       if (queue_address =3D=3D q->properties.queue_addr=
ess)
> +                               return q;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +/* only for compute queue */
> +static int reset_queues_on_hws_hang(struct device_queue_manager *dqm)
> +{
> +       int r =3D 0, reset_count =3D 0, i;
> +
> +       if (!dqm->detect_hang_info || dqm->is_hws_hang)
> +               return -EIO;
> +
> +       /* assume dqm locked. */
> +       if (!detect_queue_hang(dqm))
> +               return -ENOTRECOVERABLE;
> +
> +       for (i =3D 0; i < dqm->detect_hang_count; i++) {
> +               struct dqm_detect_hang_info hang_info =3D dqm->detect_han=
g_info[i];
> +               struct queue *q =3D find_queue_by_address(dqm, hang_info.=
queue_address);
> +               struct kfd_process_device *pdd;
> +               uint64_t queue_addr =3D 0;
> +
> +               if (!q) {
> +                       r =3D -ENOTRECOVERABLE;
> +                       goto reset_fail;
> +               }
> +
> +               pdd =3D kfd_get_process_device_data(dqm->dev, q->process)=
;
> +               if (!pdd) {
> +                       r =3D -ENOTRECOVERABLE;
> +                       goto reset_fail;
> +               }
> +
> +               queue_addr =3D dqm->dev->kfd2kgd->hqd_reset(dqm->dev->ade=
v,
> +                               hang_info.pipe_id, hang_info.queue_id, ha=
ng_info.xcc_id,
> +                               KFD_UNMAP_LATENCY_MS);
> +
> +               /* either reset failed or we reset an unexpected queue. *=
/
> +               if (queue_addr !=3D q->properties.queue_address) {
> +                       r =3D -ENOTRECOVERABLE;
> +                       goto reset_fail;
> +               }
> +
> +               set_queue_as_reset(dqm, q, &pdd->qpd);
> +               reset_count++;
> +       }
> +
> +       if (reset_count =3D=3D dqm->detect_hang_count)
> +               kfd_signal_reset_event(dqm->dev);
> +       else
> +               r =3D -ENOTRECOVERABLE;
> +
> +reset_fail:
> +       dqm->detect_hang_count =3D 0;
> +
> +       return r;
> +}
> +
>  /* dqm->lock mutex has to be locked before calling this function */
>  static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>                                 enum kfd_unmap_queues_filter filter,
> @@ -1979,11 +2133,14 @@ static int unmap_queues_cpsch(struct device_queue=
_manager *dqm,
>          */
>         mqd_mgr =3D dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
>         if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.pri=
v_queue->queue->mqd)) {
> -               while (halt_if_hws_hang)
> -                       schedule();
> -               kfd_hws_hang(dqm);
> -               retval =3D -ETIME;
> -               goto out;
> +               if (reset_queues_on_hws_hang(dqm)) {
> +                       while (halt_if_hws_hang)
> +                               schedule();
> +                       dqm->is_hws_hang =3D true;
> +                       kfd_hws_hang(dqm);
> +                       retval =3D -ETIME;
> +                       goto out;
> +               }
>         }
>
>         /* We need to reset the grace period value for this device */
> @@ -2002,8 +2159,7 @@ static int unmap_queues_cpsch(struct device_queue_m=
anager *dqm,
>  }
>
>  /* only for compute queue */
> -static int reset_queues_cpsch(struct device_queue_manager *dqm,
> -                       uint16_t pasid)
> +static int reset_queues_cpsch(struct device_queue_manager *dqm, uint16_t=
 pasid)
>  {
>         int retval;
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 3b9b8eabaacc..dfb36a246637 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -210,6 +210,13 @@ struct device_queue_manager_asic_ops {
>                                  struct kfd_node *dev);
>  };
>
> +struct dqm_detect_hang_info {
> +       int pipe_id;
> +       int queue_id;
> +       int xcc_id;
> +       uint64_t queue_address;
> +};
> +
>  /**
>   * struct device_queue_manager
>   *
> @@ -264,6 +271,11 @@ struct device_queue_manager {
>         uint32_t                wait_times;
>
>         wait_queue_head_t       destroy_wait;
> +
> +       /* for per-queue reset support */
> +       struct dqm_detect_hang_info *detect_hang_info;
> +       size_t detect_hang_info_size;
> +       int detect_hang_count;
>  };
>
>  void device_queue_manager_init_cik(
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_events.c
> index 9b33d9d2c9ad..3a6e7a4c8895 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -31,6 +31,7 @@
>  #include <linux/memory.h>
>  #include "kfd_priv.h"
>  #include "kfd_events.h"
> +#include "kfd_device_queue_manager.h"
>  #include <linux/device.h>
>
>  /*
> @@ -1244,12 +1245,32 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>         idx =3D srcu_read_lock(&kfd_processes_srcu);
>         hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>                 int user_gpu_id =3D kfd_process_get_user_gpu_id(p, dev->i=
d);
> +               struct kfd_process_device *pdd =3D kfd_get_process_device=
_data(dev, p);
>
>                 if (unlikely(user_gpu_id =3D=3D -EINVAL)) {
>                         WARN_ONCE(1, "Could not get user_gpu_id from dev-=
>id:%x\n", dev->id);
>                         continue;
>                 }
>
> +               if (unlikely(!pdd)) {
> +                       WARN_ONCE(1, "Could not get device data from pasi=
d:0x%x\n", p->pasid);
> +                       continue;
> +               }
> +
> +               if (dev->dqm->detect_hang_count && !pdd->has_reset_queue)
> +                       continue;
> +
> +               if (dev->dqm->detect_hang_count) {
> +                       struct amdgpu_task_info *ti;
> +
> +                       ti =3D amdgpu_vm_get_task_info_pasid(dev->adev, p=
->pasid);
> +                       if (ti) {
> +                               DRM_ERROR("Process info: process %s tid %=
d thread %s pid %d\n",
> +                               ti->process_name, ti->tgid, ti->task_name=
, ti->pid);
> +                               amdgpu_vm_put_task_info(ti);

Use dev_err() here so we know which device issued the error on
multi-GPU systems.  With that fixed, the patch looks good to me.  I'm
not a KFD expert, so:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

> +                       }
> +               }
> +
>                 rcu_read_lock();
>
>                 id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 66c73825c0a0..84e8ea3a8a0c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -321,8 +321,11 @@ static void update_mqd(struct mqd_manager *mm, void =
*mqd,
>  static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
>  {
>         struct v9_mqd *m =3D (struct v9_mqd *)mqd;
> +       uint32_t doorbell_id =3D m->queue_doorbell_id0;
>
> -       return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_i=
d0, 0);
> +       m->queue_doorbell_id0 =3D 0;
> +
> +       return kfd_check_hiq_mqd_doorbell_id(mm->dev, doorbell_id, 0);
>  }
>
>  static int get_wave_state(struct mqd_manager *mm, void *mqd,
> @@ -624,6 +627,7 @@ static bool check_preemption_failed_v9_4_3(struct mqd=
_manager *mm, void *mqd)
>                 m =3D get_mqd(mqd + hiq_mqd_size * inst);
>                 ret |=3D kfd_check_hiq_mqd_doorbell_id(mm->dev,
>                                         m->queue_doorbell_id0, inst);
> +               m->queue_doorbell_id0 =3D 0;
>                 ++inst;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index b5cae48dff66..892a85408c09 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -843,6 +843,9 @@ struct kfd_process_device {
>         void *proc_ctx_bo;
>         uint64_t proc_ctx_gpu_addr;
>         void *proc_ctx_cpu_ptr;
> +
> +       /* Tracks queue reset status */
> +       bool has_reset_queue;
>  };
>
>  #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 9e29b92eb523..a902950cc060 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1851,6 +1851,8 @@ int kfd_process_evict_queues(struct kfd_process *p,=
 uint32_t trigger)
>                         goto fail;
>                 }
>                 n_evicted++;
> +
> +               pdd->dev->dqm->is_hws_hang =3D false;
>         }
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gp=
u/drm/amd/include/kgd_kfd_interface.h
> index 6d094cf3587d..7744ca3ef4b1 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -318,6 +318,12 @@ struct kfd2kgd_calls {
>         void (*program_trap_handler_settings)(struct amdgpu_device *adev,
>                         uint32_t vmid, uint64_t tba_addr, uint64_t tma_ad=
dr,
>                         uint32_t inst);
> +       uint64_t (*hqd_get_pq_addr)(struct amdgpu_device *adev,
> +                                   uint32_t pipe_id, uint32_t queue_id,
> +                                   uint32_t inst);
> +       uint64_t (*hqd_reset)(struct amdgpu_device *adev,
> +                             uint32_t pipe_id, uint32_t queue_id,
> +                             uint32_t inst, unsigned int utimeout);
>  };
>
>  #endif /* KGD_KFD_INTERFACE_H_INCLUDED */
> --
> 2.34.1
>
