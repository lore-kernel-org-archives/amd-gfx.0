Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75732C3DA63
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 21:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7FEC10E147;
	Wed, 24 Jul 2024 21:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NyeUDpV1";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29DE310E147
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 21:16:09 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-70d162eef54so187473b3a.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721855768; x=1722460568; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKbDsIAoyFpfTQp1hgaFLY0GPfIeOvkGuWNLJFNtUnY=;
 b=NyeUDpV1rjbLU8ubrHm6/UxomHmw4yrx8amdeY0WDfhu0Vx8BwyI9f6ofBkO2RCBbd
 /GN/WQyPr9xMgYv45FblElTTypRYoNxjEsZHLvZx90IzktuWXC8V6wpDPqKHw/1zImMp
 zaSAYcxaI/jU9EhZCtE+KcTVNDtfgAP9bnV/5haoTV3yoSITwNrCOk81KmvqWpa4Ni2i
 OW9txnKRVv6jz4pRszbCPdgvJwdVGeZO3EaYCCAL3/wIAGOMvrWPLANi4g9CxlVy0vTC
 Txxv2D3kmsxqKaD7X7G3LnLXi5vLEvEzspD2Qhz7rNEG9NvyzJW1euVw4ODrCPZS82KO
 xGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721855768; x=1722460568;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oKbDsIAoyFpfTQp1hgaFLY0GPfIeOvkGuWNLJFNtUnY=;
 b=g7vMZIqDfzbT0dCn2udKBBGBFieYsM6Yc0dMFWlGtUxQkE8vlKny2eM5muPH/tFGAH
 tbtzfH6YkdZjuxYQdNxWNTxzfv7cgwVjeRSawsQonJVwx4aDyPiLNExj2pYU/r0/5Sg6
 ZwocIjx5A03pnjzOZ2hLjCYiRY0WwVBUVC61dc/T/K/9uo6lPEIY/nRRVyYoBYtNDYEH
 s9BgIKSVqRUvPqwIOYIVfTiqNZm7x4O7jU7Vwowz4875fJBMgk2NBSF9tgfoRvaRcxbM
 jV2Nrd/06PUGu+Nmd4jDXiOs5xcqFhABZKzAmLNMkWjVfa8EUWzOuLatKPdqewNNY0FK
 oTWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5BSDQMLCTgAMZpA/vVlraxk/wlnPHUKEHHOT3gEdHcjW4q3TPqz2xXo1GtQ571ndg41ke5/8XSCmJKY9TPzkhk5kqgHLLuPqEv6PU4Q==
X-Gm-Message-State: AOJu0YxN7R53jfYhwUsyVO1lVujt4fCSkUnvRueCp8FQoCSMztxTZhdD
 enQvRcsuOOhM0XXPMOJKbJndB6ZLb5GemkU0AiK3kw4CvDwC0GIRUjJGujMXA+EwJgyW+Ngw+pF
 LYKaTJAygzmP5ZwjlNlB3Jjr/5iU=
X-Google-Smtp-Source: AGHT+IEs7YP/jlFndr//qxrg+R6hHuz4grBnD7D/7eM/VZb9E2waDcOflX99UikJ2F5/zajy9K1HiIN6m20iFpj8wXY=
X-Received: by 2002:a05:6a00:6f2a:b0:70d:26b5:3b43 with SMTP id
 d2e1a72fcca58-70eaa8fca80mr921784b3a.19.1721855768127; Wed, 24 Jul 2024
 14:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240718175645.1002418-1-Jonathan.Kim@amd.com>
 <e1d3a744-43b9-4fae-a49d-11504fe13a37@amd.com>
In-Reply-To: <e1d3a744-43b9-4fae-a49d-11504fe13a37@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Jul 2024 17:15:56 -0400
Message-ID: <CADnq5_PLcXMcjSNA45ixUV5grQgi8hxQFQEjSbMc+aAcKmsAwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdkfd: support per-queue reset on gfx9
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Jul 24, 2024 at 4:34=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.=
com> wrote:
>
>
> On 2024-07-18 13:56, Jonathan Kim wrote:
> > Support per-queue reset for GFX9.  The recommendation is for the driver
> > to target reset the HW queue via a SPI MMIO register write.
> >
> > Since this requires pipe and HW queue info and MEC FW is limited to
> > doorbell reports of hung queues after an unmap failure, scan the HW
> > queue slots defined by SET_RESOURCES first to identify the user queue
> > candidates to reset.
> >
> > Only signal reset events to processes that have had a queue reset.
> >
> > If queue reset fails, fall back to GPU reset.
> >
> > Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> > ---
> >   .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   1 +
> >   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   3 +-
> >   .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |   3 +-
> >   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   9 +
> >   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   6 +
> >   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   3 +-
> >   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  11 +-
> >   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  56 +++++
> >   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   6 +
> >   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 195 ++++++++++++++++-=
-
> >   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  12 ++
> >   drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  15 ++
> >   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   6 +-
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   4 +
> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +
> >   .../gpu/drm/amd/include/kgd_kfd_interface.h   |   4 +
> >   16 files changed, 310 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> > index aff08321e976..1dc601e4518a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> > @@ -191,4 +191,5 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
> >       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
> >       .build_grace_period_packet_info =3D kgd_gfx_v9_build_grace_period=
_packet_info,
> >       .program_trap_handler_settings =3D kgd_gfx_v9_program_trap_handle=
r_settings,
> > +     .hqd_detect_and_reset =3D kgd_gfx_v9_hqd_detect_and_reset
> >   };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> > index 3a3f3ce09f00..534975c722df 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> > @@ -418,5 +418,6 @@ const struct kfd2kgd_calls arcturus_kfd2kgd =3D {
> >       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
> >       .build_grace_period_packet_info =3D kgd_gfx_v9_build_grace_period=
_packet_info,
> >       .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
> > -     .program_trap_handler_settings =3D kgd_gfx_v9_program_trap_handle=
r_settings
> > +     .program_trap_handler_settings =3D kgd_gfx_v9_program_trap_handle=
r_settings,
> > +     .hqd_detect_and_reset =3D kgd_gfx_v9_hqd_detect_and_reset
> >   };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> > index a5c7259cf2a3..b53c1cfa34de 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> > @@ -541,5 +541,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {
> >                       kgd_gfx_v9_4_3_set_wave_launch_trap_override,
> >       .set_wave_launch_mode =3D kgd_aldebaran_set_wave_launch_mode,
> >       .set_address_watch =3D kgd_gfx_v9_4_3_set_address_watch,
> > -     .clear_address_watch =3D kgd_gfx_v9_4_3_clear_address_watch
> > +     .clear_address_watch =3D kgd_gfx_v9_4_3_clear_address_watch,
> > +     .hqd_detect_and_reset =3D kgd_gfx_v9_hqd_detect_and_reset
> >   };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> > index 3ab6c3aa0ad1..dd449a0caba8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> > @@ -1070,6 +1070,14 @@ static void program_trap_handler_settings(struct=
 amdgpu_device *adev,
> >       unlock_srbm(adev);
> >   }
> >
> > +uint64_t kgd_gfx_v10_hqd_detect_and_reset(struct amdgpu_device *adev,
> > +                                       uint32_t pipe_id, uint32_t queu=
e_id,
> > +                                       uint32_t inst, unsigned int uti=
meout,
> > +                                       bool detect_only)
> > +{
> > +     return 0;
> > +}
> > +
> >   const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
> >       .program_sh_mem_settings =3D kgd_program_sh_mem_settings,
> >       .set_pasid_vmid_mapping =3D kgd_set_pasid_vmid_mapping,
> > @@ -1097,4 +1105,5 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
> >       .get_iq_wait_times =3D kgd_gfx_v10_get_iq_wait_times,
> >       .build_grace_period_packet_info =3D kgd_gfx_v10_build_grace_perio=
d_packet_info,
> >       .program_trap_handler_settings =3D program_trap_handler_settings,
> > +     .hqd_detect_and_reset =3D kgd_gfx_v10_hqd_detect_and_reset
> >   };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> > index 67bcaa3d4226..9eeda8808a3c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> > @@ -56,3 +56,9 @@ void kgd_gfx_v10_build_grace_period_packet_info(struc=
t amdgpu_device *adev,
> >                                              uint32_t grace_period,
> >                                              uint32_t *reg_offset,
> >                                              uint32_t *reg_data);
> > +uint64_t kgd_gfx_v10_hqd_detect_and_reset(struct amdgpu_device *adev,
> > +                                       uint32_t pipe_id,
> > +                                       uint32_t queue_id,
> > +                                       uint32_t inst,
> > +                                       unsigned int utimeout,
> > +                                       bool detect_only);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> > index 8c8437a4383f..9872bca4156b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
> > @@ -680,5 +680,6 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd =3D {
> >       .set_wave_launch_trap_override =3D kgd_gfx_v10_set_wave_launch_tr=
ap_override,
> >       .set_wave_launch_mode =3D kgd_gfx_v10_set_wave_launch_mode,
> >       .set_address_watch =3D kgd_gfx_v10_set_address_watch,
> > -     .clear_address_watch =3D kgd_gfx_v10_clear_address_watch
> > +     .clear_address_watch =3D kgd_gfx_v10_clear_address_watch,
> > +     .hqd_detect_and_reset =3D kgd_gfx_v10_hqd_detect_and_reset
> >   };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> > index b61a32d6af4b..483937c571ab 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> > @@ -786,6 +786,14 @@ static uint32_t kgd_gfx_v11_clear_address_watch(st=
ruct amdgpu_device *adev,
> >       return 0;
> >   }
> >
> > +static uint64_t kgd_gfx_v11_hqd_detect_and_reset(struct amdgpu_device =
*adev,
> > +                                              uint32_t pipe_id, uint32=
_t queue_id,
> > +                                              uint32_t inst, unsigned =
int utimeout,
> > +                                              bool detect_only)
> > +{
> > +     return 0;
> > +}
> > +
> >   const struct kfd2kgd_calls gfx_v11_kfd2kgd =3D {
> >       .program_sh_mem_settings =3D program_sh_mem_settings_v11,
> >       .set_pasid_vmid_mapping =3D set_pasid_vmid_mapping_v11,
> > @@ -808,5 +816,6 @@ const struct kfd2kgd_calls gfx_v11_kfd2kgd =3D {
> >       .set_wave_launch_trap_override =3D kgd_gfx_v11_set_wave_launch_tr=
ap_override,
> >       .set_wave_launch_mode =3D kgd_gfx_v11_set_wave_launch_mode,
> >       .set_address_watch =3D kgd_gfx_v11_set_address_watch,
> > -     .clear_address_watch =3D kgd_gfx_v11_clear_address_watch
> > +     .clear_address_watch =3D kgd_gfx_v11_clear_address_watch,
> > +     .hqd_detect_and_reset =3D kgd_gfx_v11_hqd_detect_and_reset
> >   };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > index 5a35a8ca8922..9428e98ac12b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > @@ -1144,6 +1144,61 @@ void kgd_gfx_v9_program_trap_handler_settings(st=
ruct amdgpu_device *adev,
> >       kgd_gfx_v9_unlock_srbm(adev, inst);
> >   }
> >
> > +uint64_t kgd_gfx_v9_hqd_detect_and_reset(struct amdgpu_device *adev,
> > +                                      uint32_t pipe_id, uint32_t queue=
_id,
> > +                                      uint32_t inst, unsigned int utim=
eout,
> > +                                      bool detect_only)
>
> This is a bit misleading. This function doesn't detect anything. It just
> returns a queue address and optionally resets the queue. And the way
> it's called is like "detect and reset, but don't reset", except that
> last part is not obvious if you don't know what the last parameter
> means. It would make the code easier to read if you split this into two
> functions: hqd_get_pq_addr and hqd_reset.
>
>
> > +{
> > +     uint32_t low, high, temp;
> > +     unsigned long end_jiffies;
> > +     uint64_t queue_addr =3D 0;
> > +
> > +     kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
> > +     if (!RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE))
> > +             goto unlock_out;
> > +
> > +     low =3D RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE);
> > +     high =3D RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE_HI=
);
>
> You may need to disable GFXOFF before accessing these registers. Maybe
> you're assuming that the GPU is not idle when you're getting here, and
> maybe that's a good assumption, so I'm not sure.

I think you should wrap any reset MMIO in
amdgpu_gfx_rlc_enter_safe_mode() and amdgpu_gfx_rlc_exit_safe_mode().

Alex

>
>
> > +
> > +     /* only concerned with user queues. */
> > +     if (!high)
> > +             goto unlock_out;
> > +
> > +     queue_addr =3D (((queue_addr | high) << 32) | low) << 8;
> > +
> > +     if (detect_only)
> > +             goto unlock_out;
> > +
> > +     pr_debug("Attempting queue reset on XCC %i pipe id %i queue id %i=
\n",
> > +              inst, pipe_id, queue_id);
> > +
> > +     /* assume previous dequeue request issued will take affect after =
reset */
> > +     WREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_COMPUTE_QUEUE_RESET, 0=
x1);
> > +
> > +     end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
> > +     while (true) {
> > +             temp =3D RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_AC=
TIVE);
> > +
> > +             if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
> > +                     break;
> > +
> > +             if (time_after(jiffies, end_jiffies)) {
> > +                     queue_addr =3D 0;
> > +                     break;
> > +             }
> > +
> > +             usleep_range(500, 1000);
> > +     }
> > +
> > +unlock_out:
> > +     if (!detect_only)
> > +             pr_debug("queue reset on XCC %i pipe id %i queue id %i %s=
\n",
> > +                      inst, pipe_id, queue_id, !!queue_addr ? "succeed=
ed!" : "failed!");
> > +     kgd_gfx_v9_release_queue(adev, inst);
> > +
> > +     return queue_addr;
> > +}
> > +
> >   const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
> >       .program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
> >       .set_pasid_vmid_mapping =3D kgd_gfx_v9_set_pasid_vmid_mapping,
> > @@ -1172,4 +1227,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
> >       .build_grace_period_packet_info =3D kgd_gfx_v9_build_grace_period=
_packet_info,
> >       .get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
> >       .program_trap_handler_settings =3D kgd_gfx_v9_program_trap_handle=
r_settings,
> > +     .hqd_detect_and_reset =3D kgd_gfx_v9_hqd_detect_and_reset
> >   };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> > index ce424615f59b..cf70d8fc3d10 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> > @@ -101,3 +101,9 @@ void kgd_gfx_v9_build_grace_period_packet_info(stru=
ct amdgpu_device *adev,
> >                                              uint32_t grace_period,
> >                                              uint32_t *reg_offset,
> >                                              uint32_t *reg_data);
> > +uint64_t kgd_gfx_v9_hqd_detect_and_reset(struct amdgpu_device *adev,
> > +                                      uint32_t pipe_id,
> > +                                      uint32_t queue_id,
> > +                                      uint32_t inst,
> > +                                      unsigned int utimeout,
> > +                                      bool detect_only);
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/dr=
ivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index 4f48507418d2..037b75a64e66 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -153,6 +153,19 @@ void program_sh_mem_settings(struct device_queue_m=
anager *dqm,
> >
> >   static void kfd_hws_hang(struct device_queue_manager *dqm)
> >   {
> > +     struct device_process_node *cur;
> > +     struct qcm_process_device *qpd;
> > +     struct queue *q;
> > +
> > +     /* Mark all device queues as reset. */
> > +     list_for_each_entry(cur, &dqm->queues, list) {
> > +             qpd =3D cur->qpd;
> > +             list_for_each_entry(q, &qpd->queues_list, list) {
> > +                     q->properties.is_reset =3D true;
> > +                     q->process->has_reset_queue =3D true;
>
> Both seem to track the same information, but one does it per queue, the
> other does it per process. Why do you need to track this per queue at
> all? The only place where I see q->properties->is_reset used is in
> update_queue. I think you can use the per-process tracking there.
>
> That said, I think it would be better to track has_reset_queue in the
> pdd or qpd because GPU resets are per GPU, and these fields are accessed
> under the per-GPU DQM lock and reset events sent to user mode are per
> GPU as well.
>
>
> > +             }
> > +     }
> > +
> >       /*
> >        * Issue a GPU reset if HWS is unresponsive
> >        */
> > @@ -880,6 +893,12 @@ static int update_queue(struct device_queue_manage=
r *dqm, struct queue *q,
> >               else if (prev_active)
> >                       retval =3D remove_queue_mes(dqm, q, &pdd->qpd);
> >
> > +             /* queue is reset so inaccessable  */
> > +             if (q->properties.is_reset) {
>
> You could use pdd->process->has_reset_queue (or pdd->has_reset_queue)
> here and get rid of is_reset.
>
>
> > +                     retval =3D -EACCES;
> > +                     goto out_unlock;
> > +             }
> > +
> >               if (retval) {
> >                       dev_err(dev, "unmap queue failed\n");
> >                       goto out_unlock;
> > @@ -1629,7 +1648,7 @@ static int initialize_cpsch(struct device_queue_m=
anager *dqm)
> >   static int start_cpsch(struct device_queue_manager *dqm)
> >   {
> >       struct device *dev =3D dqm->dev->adev->dev;
> > -     int retval;
> > +     int retval, num_hw_queue_slots;
> >
> >       retval =3D 0;
> >
> > @@ -1682,6 +1701,14 @@ static int start_cpsch(struct device_queue_manag=
er *dqm)
> >                                       &dqm->wait_times);
> >       }
> >
> > +     /* setup per-queue reset detection buffer  */
> > +     num_hw_queue_slots =3D  dqm->dev->kfd->shared_resources.num_queue=
_per_pipe *
> > +                           dqm->dev->kfd->shared_resources.num_pipe_pe=
r_mec *
> > +                           NUM_XCC(dqm->dev->xcc_mask);
> > +
> > +     dqm->detect_hang_info_size =3D num_hw_queue_slots * sizeof(struct=
 dqm_detect_hang_info);
> > +     dqm->detect_hang_info =3D kzalloc(dqm->detect_hang_info_size, GFP=
_KERNEL);
> > +
> >       dqm_unlock(dqm);
> >
> >       return 0;
> > @@ -1715,6 +1742,7 @@ static int stop_cpsch(struct device_queue_manager=
 *dqm)
> >       kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
> >       if (!dqm->dev->kfd->shared_resources.enable_mes)
> >               pm_uninit(&dqm->packet_mgr);
> > +     kfree(dqm->detect_hang_info);
> >       dqm_unlock(dqm);
> >
> >       return 0;
> > @@ -1931,6 +1959,143 @@ static int map_queues_cpsch(struct device_queue=
_manager *dqm)
> >       return retval;
> >   }
> >
> > +static void set_queue_as_reset(struct device_queue_manager *dqm, struc=
t queue *q,
> > +                            struct qcm_process_device *qpd)
> > +{
> > +     pr_err("queue id 0x%0x at pasid 0x%0x is reset\n",
> > +            q->properties.queue_id, q->process->pasid);
> > +
> > +     q->properties.is_reset =3D true;
> > +     q->process->has_reset_queue =3D true;
> > +     if (q->properties.is_active) {
> > +             q->properties.is_active =3D false;
> > +             decrement_queue_count(dqm, qpd, q);
> > +     }
> > +}
> > +
> > +static int detect_queue_hang(struct device_queue_manager *dqm)
> > +{
> > +     int i;
> > +
> > +     memset(dqm->detect_hang_info, 0, dqm->detect_hang_info_size);
> > +
> > +     for (i =3D 0; i < AMDGPU_MAX_QUEUES; ++i) {
> > +             uint32_t mec, pipe, queue;
> > +             int xcc_id;
> > +
> > +             mec =3D (i / dqm->dev->kfd->shared_resources.num_queue_pe=
r_pipe)
> > +                     / dqm->dev->kfd->shared_resources.num_pipe_per_me=
c;
> > +
> > +             if (mec || !test_bit(i, dqm->dev->kfd->shared_resources.c=
p_queue_bitmap))
> > +                     continue;
> > +
> > +             amdgpu_queue_mask_bit_to_mec_queue(dqm->dev->adev, i, &me=
c, &pipe, &queue);
> > +
> > +             for_each_inst(xcc_id, dqm->dev->xcc_mask) {
> > +                     uint64_t queue_addr =3D dqm->dev->kfd2kgd->hqd_de=
tect_and_reset(
> > +                                             dqm->dev->adev, pipe, que=
ue, xcc_id,
> > +                                             0, true);
> > +                     struct dqm_detect_hang_info hang_info;
> > +
> > +                     if (!queue_addr)
> > +                             continue;
> > +
> > +                     hang_info.pipe_id =3D pipe;
> > +                     hang_info.queue_id =3D queue;
> > +                     hang_info.xcc_id =3D xcc_id;
> > +                     hang_info.queue_address =3D queue_addr;
> > +
> > +                     dqm->detect_hang_info[dqm->detect_hang_count] =3D=
 hang_info;
> > +                     dqm->detect_hang_count++;
> > +             }
> > +     }
> > +
> > +     return dqm->detect_hang_count;
> > +}
> > +
> > +static struct queue *find_queue_by_address(struct device_queue_manager=
 *dqm, uint64_t queue_address)
> > +{
> > +     struct device_process_node *cur;
> > +     struct qcm_process_device *qpd;
> > +     struct queue *q;
> > +
> > +     list_for_each_entry(cur, &dqm->queues, list) {
> > +             qpd =3D cur->qpd;
> > +             list_for_each_entry(q, &qpd->queues_list, list) {
> > +                     if (queue_address =3D=3D q->properties.queue_addr=
ess)
> > +                             return q;
> > +             }
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +/* only for compute queue */
> > +static int reset_queues_cpsch(struct device_queue_manager *dqm, uint16=
_t pasid)
> > +{
> > +     int retval =3D 0, reset_count =3D 0, i;
> > +
> > +     if (pasid) {
> > +             dqm_lock(dqm);
> > +
> > +             retval =3D unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTE=
R_BY_PASID,
> > +                                         pasid, USE_DEFAULT_GRACE_PERI=
OD, true);
> > +
> > +             dqm_unlock(dqm);
> > +             return retval;
> > +     }
> > +
> > +     if (!dqm->detect_hang_info || dqm->is_hws_hang)
> > +             return -EIO;
> > +
> > +     /* assume dqm locked. */
>
> This is weird, the same function does different things and has different
> assumptions about its locking context depending where it's called from.
> Maybe keep the original function and and make this a new function with a
> distinct name.
>
>
> > +     if (!detect_queue_hang(dqm))
> > +             return -ENOTRECOVERABLE;
> > +
> > +     for (i =3D 0; i < dqm->detect_hang_count; i++) {
> > +             struct dqm_detect_hang_info hang_info =3D dqm->detect_han=
g_info[i];
> > +             struct queue *q =3D find_queue_by_address(dqm, hang_info.=
queue_address);
> > +             struct kfd_process_device *pdd;
> > +             uint64_t queue_addr =3D 0;
> > +             int pipe =3D hang_info.pipe_id;
> > +             int queue =3D hang_info.queue_id;
> > +             int xcc_id =3D hang_info.xcc_id;
>
> Why do you need these local variables. hang_info is already a local
> variable. Now you have two copies of this on your stack.
>
> Regards,
>    Felix
>
>
> > +
> > +             if (!q) {
> > +                     retval =3D -ENOTRECOVERABLE;
> > +                     goto reset_fail;
> > +             }
> > +
> > +             pdd =3D kfd_get_process_device_data(dqm->dev, q->process)=
;
> > +             if (!pdd) {
> > +                     retval =3D -ENOTRECOVERABLE;
> > +                     goto reset_fail;
> > +             }
> > +
> > +             queue_addr =3D dqm->dev->kfd2kgd->hqd_detect_and_reset(
> > +                             dqm->dev->adev, pipe, queue, xcc_id,
> > +                             KFD_UNMAP_LATENCY_MS, false);
> > +
> > +             if (queue_addr !=3D q->properties.queue_address) {
> > +                     retval =3D -ENOTRECOVERABLE;
> > +                     goto reset_fail;
> > +             }
> > +
> > +             set_queue_as_reset(dqm, q, &pdd->qpd);
> > +             reset_count++;
> > +     }
> > +
> > +     if (reset_count =3D=3D dqm->detect_hang_count)
> > +             kfd_signal_reset_event(dqm->dev);
> > +     else
> > +             retval =3D -ENOTRECOVERABLE;
> > +
> > +reset_fail:
> > +     dqm->detect_hang_count =3D 0;
> > +
> > +     return retval;
> > +}
> > +
> >   /* dqm->lock mutex has to be locked before calling this function */
> >   static int unmap_queues_cpsch(struct device_queue_manager *dqm,
> >                               enum kfd_unmap_queues_filter filter,
> > @@ -1981,11 +2146,14 @@ static int unmap_queues_cpsch(struct device_que=
ue_manager *dqm,
> >        */
> >       mqd_mgr =3D dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
> >       if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.pri=
v_queue->queue->mqd)) {
> > -             while (halt_if_hws_hang)
> > -                     schedule();
> > -             kfd_hws_hang(dqm);
> > -             retval =3D -ETIME;
> > -             goto out;
> > +             if (reset_queues_cpsch(dqm, 0)) {
> > +                     while (halt_if_hws_hang)
> > +                             schedule();
> > +                     dqm->is_hws_hang =3D true;
> > +                     kfd_hws_hang(dqm);
> > +                     retval =3D -ETIME;
> > +                     goto out;
> > +             }
> >       }
> >
> >       /* We need to reset the grace period value for this device */
> > @@ -2003,21 +2171,6 @@ static int unmap_queues_cpsch(struct device_queu=
e_manager *dqm,
> >       return retval;
> >   }
> >
> > -/* only for compute queue */
> > -static int reset_queues_cpsch(struct device_queue_manager *dqm,
> > -                     uint16_t pasid)
> > -{
> > -     int retval;
> > -
> > -     dqm_lock(dqm);
> > -
> > -     retval =3D unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_BY_PAS=
ID,
> > -                     pasid, USE_DEFAULT_GRACE_PERIOD, true);
> > -
> > -     dqm_unlock(dqm);
> > -     return retval;
> > -}
> > -
> >   /* dqm->lock mutex has to be locked before calling this function */
> >   static int execute_queues_cpsch(struct device_queue_manager *dqm,
> >                               enum kfd_unmap_queues_filter filter,
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/dr=
ivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> > index 3b9b8eabaacc..dfb36a246637 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> > @@ -210,6 +210,13 @@ struct device_queue_manager_asic_ops {
> >                                struct kfd_node *dev);
> >   };
> >
> > +struct dqm_detect_hang_info {
> > +     int pipe_id;
> > +     int queue_id;
> > +     int xcc_id;
> > +     uint64_t queue_address;
> > +};
> > +
> >   /**
> >    * struct device_queue_manager
> >    *
> > @@ -264,6 +271,11 @@ struct device_queue_manager {
> >       uint32_t                wait_times;
> >
> >       wait_queue_head_t       destroy_wait;
> > +
> > +     /* for per-queue reset support */
> > +     struct dqm_detect_hang_info *detect_hang_info;
> > +     size_t detect_hang_info_size;
> > +     int detect_hang_count;
> >   };
> >
> >   void device_queue_manager_init_cik(
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_events.c
> > index 9b33d9d2c9ad..30a55d3733e8 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > @@ -31,6 +31,7 @@
> >   #include <linux/memory.h>
> >   #include "kfd_priv.h"
> >   #include "kfd_events.h"
> > +#include "kfd_device_queue_manager.h"
> >   #include <linux/device.h>
> >
> >   /*
> > @@ -1250,6 +1251,20 @@ void kfd_signal_reset_event(struct kfd_node *dev=
)
> >                       continue;
> >               }
> >
> > +             if (dev->dqm->detect_hang_count && !p->has_reset_queue)
> > +                     continue;
> > +
> > +             if (dev->dqm->detect_hang_count) {
> > +                     struct amdgpu_task_info *ti;
> > +
> > +                     ti =3D amdgpu_vm_get_task_info_pasid(dev->adev, p=
->pasid);
> > +                     if (ti) {
> > +                             DRM_ERROR("Process info: process %s tid %=
d thread %s pid %d\n",
> > +                             ti->process_name, ti->tgid, ti->task_name=
, ti->pid);
> > +                             amdgpu_vm_put_task_info(ti);
> > +                     }
> > +             }
> > +
> >               rcu_read_lock();
> >
> >               id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/=
gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> > index 66c73825c0a0..84e8ea3a8a0c 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> > @@ -321,8 +321,11 @@ static void update_mqd(struct mqd_manager *mm, voi=
d *mqd,
> >   static bool check_preemption_failed(struct mqd_manager *mm, void *mqd=
)
> >   {
> >       struct v9_mqd *m =3D (struct v9_mqd *)mqd;
> > +     uint32_t doorbell_id =3D m->queue_doorbell_id0;
> >
> > -     return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_i=
d0, 0);
> > +     m->queue_doorbell_id0 =3D 0;
> > +
> > +     return kfd_check_hiq_mqd_doorbell_id(mm->dev, doorbell_id, 0);
> >   }
> >
> >   static int get_wave_state(struct mqd_manager *mm, void *mqd,
> > @@ -624,6 +627,7 @@ static bool check_preemption_failed_v9_4_3(struct m=
qd_manager *mm, void *mqd)
> >               m =3D get_mqd(mqd + hiq_mqd_size * inst);
> >               ret |=3D kfd_check_hiq_mqd_doorbell_id(mm->dev,
> >                                       m->queue_doorbell_id0, inst);
> > +             m->queue_doorbell_id0 =3D 0;
> >               ++inst;
> >       }
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_priv.h
> > index 2b3ec92981e8..e244242fd1b4 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -504,6 +504,7 @@ struct queue_properties {
> >       bool is_being_destroyed;
> >       bool is_active;
> >       bool is_gws;
> > +     bool is_reset;
> >       uint32_t pm4_target_xcc;
> >       bool is_dbg_wa;
> >       bool is_user_cu_masked;
> > @@ -982,6 +983,9 @@ struct kfd_process {
> >       struct semaphore runtime_enable_sema;
> >       bool is_runtime_retry;
> >       struct kfd_runtime_info runtime_info;
> > +
> > +     /* Tracks queue reset status */
> > +     bool has_reset_queue;
> >   };
> >
> >   #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_process.c
> > index 17e42161b015..9a1d69f83a08 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > @@ -1851,6 +1851,8 @@ int kfd_process_evict_queues(struct kfd_process *=
p, uint32_t trigger)
> >                       goto fail;
> >               }
> >               n_evicted++;
> > +
> > +             pdd->dev->dqm->is_hws_hang =3D false;
> >       }
> >
> >       return r;
> > diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/=
gpu/drm/amd/include/kgd_kfd_interface.h
> > index 6d094cf3587d..20bb4a0c893e 100644
> > --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> > +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> > @@ -318,6 +318,10 @@ struct kfd2kgd_calls {
> >       void (*program_trap_handler_settings)(struct amdgpu_device *adev,
> >                       uint32_t vmid, uint64_t tba_addr, uint64_t tma_ad=
dr,
> >                       uint32_t inst);
> > +     uint64_t (*hqd_detect_and_reset)(struct amdgpu_device *adev,
> > +                                      uint32_t pipe_id, uint32_t queue=
_id,
> > +                                      uint32_t inst, unsigned int utim=
eout,
> > +                                      bool detect_only);
> >   };
> >
> >   #endif      /* KGD_KFD_INTERFACE_H_INCLUDED */
