Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06C4C5DF74
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 03:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF4A10E4AC;
	Tue, 18 Aug 2026 03:38:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IsmlWPuP";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF9110E47C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 03:38:09 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cf4c37dbe6so6662765ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 20:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787024288; cv=none;
 d=google.com; s=arc-20260327;
 b=I50t9JW6mpfe2QUMvIEV6BcfAyM2Zs7bfEZ3YS1tpphh5LZmxvpGG62wiU+sUvR9rB
 iGqkI9CuZ39HwWJS3OlbdaZfoFncBJIjz69gCzJV0AxU2ufFtkH4Ydi+lt2PRaYRDKqT
 QdoGrHOb1GkS+wCWcUU43/AbECz6jlL0lhfDeAMgNL5W+Jpq/XSZpIWg7Rf2B7XxkZ4H
 ijl9EihyvxBg6wp8/OsFz9kpcWWEg/9kPAlyxfQrlsFAi4eRieM81r2AGQK81YulbvZK
 7hRWoNXJNW8NKVKpxU6QwZ9jcqxc64gBL/M4JliGpyI7lximzQja/Ifh9glt0RY0fwlI
 PMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zpAcAN+mTNpqh7BgPFv+GrRajps8PvLNMzS/IQFzHlU=;
 fh=owwHazWs97Rzgl08lFSKv/EcjcJ5ww1JR2BXRPmhh/w=;
 b=f9ILc1he46RSXz6KC/4+nWUtaJAg3GaKGWpBoS/acoEjci7HeKOhBNs3oP1FookPGA
 0jZCBrTQEfwqnnnewk8FcCOg+KscYY8HWf57farH0ikqCCC6XARaLEHOuXBU2dtC6X3D
 MvQyxWe3sigLmhVi2CzM3KJm8XGoFgMaLRXr1txl+ARj+LzO18p/dTbSDyVEcR3J5QFV
 MFEFfH4ISjHjuji2qr87eoBX8ueFG6QMd4Os8vnJZ9ktsDeooqxeyxZN5LTJ5R6koF9R
 3KjIpjvijWSbSSdqt/ey0HBGleYYDRbV7wYPUI76ptpy4DUxO1fMhEGiYf2J7fxH/aKp
 pdTg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787024288; x=1787629088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zpAcAN+mTNpqh7BgPFv+GrRajps8PvLNMzS/IQFzHlU=;
 b=IsmlWPuPnOj2SFP0cHe+f4J0yEByGjpV7CjIswPea77UbBOGxayokVPqVb8PNoyNHF
 ppFlBEXDnnPhH7Bo6Lyu31S1e+G9pa58dwTq1bSWTho4P1OPTIh0ZMBjVAypuLfnHPxm
 cLEWOs7xEBld2nPAPmQsw8COjHEzwfvNsdj9tX7sDc5kl8jLM96MTqPdFddXxBwPa9Ti
 5Hul2VLoizO9t2sm9ktiVN3pUTCzPukkL/iaPbyhfWiIukTadkxvUpCzaZd45TVZ/v4Z
 zKrJ966DqnUG6ANvJmZq9KV8CpAOHM1ehzhOsn4pHtb9oGgbgOJn4mzgzPjJkzsQOvRt
 IJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787024288; x=1787629088;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zpAcAN+mTNpqh7BgPFv+GrRajps8PvLNMzS/IQFzHlU=;
 b=KSBtny12Sj3/Hv2VvJ/Ag2FpE/689b4y+w+gQO7ZWgk0hoaCdnikcyLFwlWF12d3wL
 WXO5EYM8zC9U0WSbzNcyYl9XgXlZQYb7CTZDeWtK90auFi2yiBK1orOlksii4NiI22Bo
 D1j4YKfUnReIt2uWTFVDMK56YQXpeszq6CnGgJa1Y3CHl7w1NEq8kpMnUT66QqqDKKV8
 Ft9F41daI8d0kXKPIPZseZQMxgHtuu2ILJWU0pgPwdEbdJVdlmDDeDuti+nSYyUKw8sS
 0Q3oefVnzVaQ+kQJRYBmhIjTwar/SG/2d0Qf+TFZipE3qu2ccNXgYAmxd8gRZE85h/kK
 JhLA==
X-Gm-Message-State: AOJu0Yy6j6EbU5elk3bhqcYPMyFDVkXNgE6nUPnR//qZLKfqaOxSzV0s
 MFSIf7NYORTLZuiFzb1cvowh8YQUi8XCq1e2/+oGIAsI8ZLCi0iSRpMWpwHyQi9jKEUFPTLuZYT
 X5fzFXT9WkzirBnxv4Y0RxX5vIrEcQd90xw==
X-Gm-Gg: AR+sD11fHQ3PjEOAfzqY44rfXxqLInvNa0x/yELG5VUs2Y6Fy58BivRM6N5UWUrGus4
 SJpd82jNkXcrCt5JXaRY07keRcNwg70pu+bVwus0LaBJDAC/1HNBAbSV76Pd2D0ZPiRxNWxM8d0
 sHozXoQ+Rdc9aFx2yIVJlMsyAMnBboGN3Aar7UDrvJFMA2ZYwZi4BuMEgo5mB7WOCAF2/xEtcV6
 l0WEYUnMfyVUhl6ZKwnGt0s/EqN/Uvp17UFe84pBoVftD6ARLryYcC/vY/8ZC6wExmCFsk/8lwf
 w2oFJ33xNvdbEVuVmsqHWXdl5OZ0zc8T6Ea81pmhsQS5mYLfH0euHJfJn8ii/y/0npjUxujfA7d
 hefZG8hcT0/pAM2gc0xZ79bXklmLexl0=
X-Received: by 2002:a17:903:3847:b0:2cc:f4d4:29a0 with SMTP id
 d9443c01a7336-2d3b0c9938cmr261981905ad.3.1787024288400; Mon, 17 Aug 2026
 20:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260817194953.97887-1-david.belanger@amd.com>
In-Reply-To: <20260817194953.97887-1-david.belanger@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 23:37:56 -0400
X-Gm-Features: AcwNN1U4gI8w-fMW0u_n_SLkqr-pyFiSxzR2oFZks3s1C5VbjM2gkVeR70yOApk
Message-ID: <CADnq5_NdV+ZX-gTS-fL8rSRX3AQAc1LRU-mS9nTUG3vPGuu1WQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/kfd: Add CU occupancy support to GFX11
To: David Belanger <david.belanger@amd.com>
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

On Mon, Aug 17, 2026 at 4:45=E2=80=AFPM David Belanger <david.belanger@amd.=
com> wrote:
>
> Port changes from GFX9 to GFX11 mostly as-is.
> Minor changes to register access code.

While you are at it, can you port this to gfx10 10 and 10.3 as well?

>
> Assisted-by: Claude:Sonnet 4.6
> Signed-off-by: David Belanger <david.belanger@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    | 148 ++++++++++++++++++
>  1 file changed, 148 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> index 724beb96ed1aa..46042f72741b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> @@ -807,6 +807,153 @@ static uint32_t kgd_gfx_v11_hqd_sdma_get_doorbell(s=
truct amdgpu_device *adev,
>         return 0;
>  }
>
> +static void lock_spi_csq_mutexes(struct amdgpu_device *adev)
> +{
> +       mutex_lock(&adev->srbm_mutex);
> +       mutex_lock(&adev->grbm_idx_mutex);
> +
> +}
> +
> +static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
> +{
> +       mutex_unlock(&adev->grbm_idx_mutex);
> +       mutex_unlock(&adev->srbm_mutex);
> +}
> +
> +/**
> + * get_wave_count: Read device registers to get number of waves in fligh=
t for
> + * a particular queue. The method also returns the doorbell offset assoc=
iated
> + * with the queue.
> + *
> + * @adev: Handle of device whose registers are to be read
> + * @queue_idx: Index of queue in the queue-map bit-field
> + * @queue_cnt: Stores the wave count and doorbell offset for an active q=
ueue
> + * @inst: xcc's instance number on a multi-XCC setup
> + */
> +static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
> +               struct kfd_cu_occupancy *queue_cnt, uint32_t inst)
> +{
> +       int pipe_idx;
> +       int queue_slot;
> +       unsigned int reg_val;
> +       unsigned int wave_cnt;
> +       /*
> +        * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
> +        * parameters to read out waves in flight. Get VMID if there are
> +        * non-zero waves in flight.
> +        */
> +       pipe_idx =3D queue_idx / adev->gfx.mec.num_queue_per_pipe;
> +       queue_slot =3D queue_idx % adev->gfx.mec.num_queue_per_pipe;
> +       soc21_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
> +       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, 0,
> +                                 regSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_s=
lot);
> +       wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
> +       if (wave_cnt !=3D 0) {
> +               queue_cnt->wave_cnt +=3D wave_cnt;
> +               queue_cnt->doorbell_off =3D
> +                       (RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTRO=
L) &
> +                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK=
) >>
> +                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHI=
FT;
> +       }
> +}
> +
> +/**
> + * kgd_gfx_v11_get_cu_occupancy: Reads relevant registers associated wit=
h each
> + * shader engine and aggregates the number of waves that are in flight f=
or the
> + * process whose pasid is provided as a parameter. The process could hav=
e ZERO
> + * or more queues running and submitting waves to compute units.
> + *
> + * @adev: Handle of device from which to get number of waves in flight
> + * @cu_occupancy: Array that gets filled with wave_cnt and doorbell offs=
et
> + *               for comparison later.
> + * @max_waves_per_cu: Output parameter updated with maximum number of wa=
ves
> + *                    possible per Compute Unit
> + * @inst: xcc's instance number on a multi-XCC setup
> + *
> + * Note: It's possible that the device has too many queues (oversubscrip=
tion)
> + * in which case a VMID could be remapped to a different PASID. This cou=
ld lead
> + * to an inaccurate wave count. Following is a high-level sequence:
> + *    Time T1: vmid =3D getVmid(); vmid is associated with Pasid P1
> + *    Time T2: passId =3D getPasId(vmid); vmid is associated with Pasid =
P2
> + * In the sequence above wave count obtained from time T1 will be incorr=
ectly
> + * lost or added to total wave count.
> + *
> + * The registers that provide the waves in flight are:
> + *
> + *  SPI_CSQ_WF_ACTIVE_STATUS - bit-map of queues per pipe. The bit is ON=
 if a
> + *  queue is slotted, OFF if there is no queue. A process could have ZER=
O or
> + *  more queues slotted and submitting waves to be run on compute units.=
 Even
> + *  when there is a queue it is possible there could be zero wave fronts=
, this
> + *  can happen when queue is waiting on top-of-pipe events - e.g. waitRe=
gMem
> + *  command
> + *
> + *  For each bit that is ON from above:
> + *
> + *    Read (SPI_CSQ_WF_ACTIVE_COUNT_0 + queue_idx) register. It provides=
 the
> + *    number of waves that are in flight for the queue at specified inde=
x. The
> + *    index ranges from 0 to 7.
> + *
> + *    If non-zero waves are in flight, store the corresponding doorbell =
offset
> + *    of the queue, along with the wave count.
> + *
> + *    Determine if the queue belongs to the process by comparing the doo=
rbell
> + *    offset against the process's queues. If it matches, aggregate the =
wave
> + *    count for the process.
> + *
> + *  Reading registers referenced above involves programming GRBM appropr=
iately
> + */
> +static void kgd_gfx_v11_get_cu_occupancy(struct amdgpu_device *adev,
> +                               struct kfd_cu_occupancy *cu_occupancy,
> +                               int *max_waves_per_cu, uint32_t inst)
> +{
> +       int qidx;
> +       int se_idx;
> +       int se_cnt;
> +       int queue_map;
> +       int max_queue_cnt;
> +       DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
> +
> +       lock_spi_csq_mutexes(adev);
> +       soc21_grbm_select(adev, 1, 0, 0, 0);
> +
> +       /*
> +        * Iterate through the shader engines and arrays of the device
> +        * to get number of waves in flight
> +        */
> +       bitmap_complement(cp_queue_bitmap, adev->gfx.mec_bitmap[0].queue_=
bitmap,
> +                         AMDGPU_MAX_QUEUES);
> +       max_queue_cnt =3D adev->gfx.mec.num_pipe_per_mec *
> +                       adev->gfx.mec.num_queue_per_pipe;
> +       se_cnt =3D adev->gfx.config.max_shader_engines;
> +       for (se_idx =3D 0; se_idx < se_cnt; se_idx++) {
> +               amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst=
);
> +               queue_map =3D RREG32_SOC15(GC, 0,
> +                                        regSPI_CSQ_WF_ACTIVE_STATUS);
> +
> +               for (qidx =3D 0; qidx < max_queue_cnt; qidx++) {
> +                       /* Skip queues that are not associated with
> +                        * compute functions
> +                        */
> +                       if (!test_bit(qidx, cp_queue_bitmap))
> +                               continue;
> +
> +                       if (!(queue_map & (1 << qidx)))
> +                               continue;
> +
> +                       /* Get number of waves in flight and aggregate th=
em */
> +                       get_wave_count(adev, qidx, &cu_occupancy[qidx], i=
nst);
> +               }
> +       }
> +
> +       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,=
 inst);
> +       soc21_grbm_select(adev, 0, 0, 0, 0);
> +       unlock_spi_csq_mutexes(adev);
> +

I think you need to disallow gfxoff around the MMIO accesses unless
that is already handled elsewhere.  Same comment on the gfx12
implementation.

Alex

> +       /* Update the output parameters and return */
> +       *max_waves_per_cu =3D adev->gfx.cu_info.simd_per_cu *
> +                               adev->gfx.cu_info.max_waves_per_simd;
> +}
> +
>  const struct kfd2kgd_calls gfx_v11_kfd2kgd =3D {
>         .program_sh_mem_settings =3D program_sh_mem_settings_v11,
>         .set_pasid_vmid_mapping =3D set_pasid_vmid_mapping_v11,
> @@ -832,5 +979,6 @@ const struct kfd2kgd_calls gfx_v11_kfd2kgd =3D {
>         .clear_address_watch =3D kgd_gfx_v11_clear_address_watch,
>         .hqd_get_pq_addr =3D kgd_gfx_v11_hqd_get_pq_addr,
>         .hqd_reset =3D kgd_gfx_v11_hqd_reset,
> +       .get_cu_occupancy =3D kgd_gfx_v11_get_cu_occupancy,
>         .hqd_sdma_get_doorbell =3D kgd_gfx_v11_hqd_sdma_get_doorbell
>  };
> --
> 2.51.1
>
