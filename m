Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF31C79FB7
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 16:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AABBD10F1F4;
	Wed,  9 Sep 2026 16:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X31CqVxx";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 143E110F1EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 16:12:46 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1ab18b3e6so214274a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 09:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788970365; cv=none;
 d=google.com; s=arc-20260327;
 b=YnJnpCyqg00i7Af5sW/hTe39e5n4kWGgLknK1VowxtESwix3NKwtIrAfj6VwaAJrEC
 /n4jGnuL1uLvKUu79I/nujzxF0eUqDYCnGiS8SgL4KkONDIP8h7PVv8q9LyMnXJfbimW
 mjuwkWxyxjjxdthi2Dpckov2mQxSIMl7XNFeG5iQTODpVZCCROtk67kmpfXPfVrfUVev
 P2j4uMSQHE9L1PJxmExRSsWFuWlG1/iRDgZ1yTICuZk2KCE9ysLCcuJd/0U3BlITkXuu
 U+tR0KRlTyuKvYI+r1AzVX0Etiq1VsHAVl57V8wNf13kpAwo8jb8+q/Gtys54fggIkpC
 SH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jpXXwgV0nLkQduSNgEPxpdam4D/hXx/cqCnorg109hs=;
 fh=an3kn3uLH1j5Kh4bWKpbDMHg8b8hYKr6TqENfASh09E=;
 b=pvnwFNQRoIwTudK1xMVw6FzdO4sWHCYi6sWC8j1/ufIZ5Zc6/gJqNvf92yDEocAVDJ
 v3iFC/DGd1sTjvlRTO2HRYGtR6gHRuEnqRqL+axpgbY+YFe7yEnNwegq06LEYuwx8fAu
 Dcg159rA4M+bEiM6bbkVN9s4bFvS0AsPN2yTStLE41y48/Aw0PfQ543wDTM5ihRSdHUC
 JCinzNeeP7DQURuE9+XaVqnyp/wBYElcjTptiG+ULpcFZkN6TznKQbi3ROILbXaYmhZ7
 2x9Nup+Qnbf6Lq2JVV/SgQw6LSQaLozJ7mdylNCRmKo1MDxJB7/PCu3PRfvVJrOFPgcG
 rxpg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788970365; x=1789575165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jpXXwgV0nLkQduSNgEPxpdam4D/hXx/cqCnorg109hs=;
 b=X31CqVxxvyobywDogIsMOAO0ZQYqG2Xf366k953AN4WHkvcXVU0hz3AcNKl0xsnYXU
 Y7lZzRYuRQ3HeKotx1mioj12U+6yW6eAslKBu+mUjnidwbSbyGjXe+nX9Jpa2uJ6802b
 LkPsXGh+zWulQUaY+09plsrLyAnsUbJNkeozF9NUTh3jBN4Bwe8ERgPEwWR9JPTtgk0i
 fbo5t6qwby9ClcF3JDRVzM4sby9/gsWwTvnbpb5caycMF8QSKrJvnnqAzBCpU8tsnjX2
 ygs1p0DVA3F97YFYjxKQu9WKiPlBlZ+8wW1GCwVfX7uwlj2auYWFWJKOLUELzipjfMyf
 LP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788970365; x=1789575165;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jpXXwgV0nLkQduSNgEPxpdam4D/hXx/cqCnorg109hs=;
 b=Pyw2z2tZsMZqh0g5iRCWUKM/1lvuk/zOLxpIox9+rnNJF46S67ut+Bl5tsP+MZwsI2
 ah2iOLokdilDMOntVKxlEkTsltcQbiAIxc4CYYqcW+Abs2Wmd8rmee0LJPnkEQDgYLRH
 gve01j7F6T6NYOEcRxJujAfJedkE2zj09VawuaCazIayowGby0+3ENC6OOd3ZAq21MOx
 QMElkFIokYC8DkxkjW60sbL2nsTZiOppFsUa8HB9P4ifONkony58A3Lts4i+2kPP838F
 sBZyU5hC1rBCn/FhmU+QiS0KG/W8ZuNJcIWn/NUf/A4To1wG5b4cRfTBo7Ksul3hvT9r
 q9ew==
X-Gm-Message-State: AFuF++nIdMmC8AfTr9rKT4CdRD3F1BtiPrEfJ9LeTK8mcj4KKGDT2ffo
 WD2fA0P+rV6pPc7GdWS7PYnGSi1jWu+4mmBjAhbcmwVNMcgmaC1/5mU0jpQ0Jm2ClQIujRzr4LP
 F1dIpw9YRiRBp9+5iySc617qoaYZhMjLKwQ==
X-Gm-Gg: AYBFou2vwBO2AwZasViNQAKP7p5D3Wd3LbILUYeRoCi7/oZ0E+R6Xgi3LMH7Jd3hl5H
 c/tcJ30Cu9+BB5Qh3QWLWZY9NZwzTZ7kw8iSUeRacwGBMFaeksB1R3lajhoXlZVhtKGAsC4bV4K
 hwVQ2Rs5CtznjMHEPUgW2ckQXuut6BGySL0J5+XEUKpPVLRFRl+NRbhZy44+0UK7f+dVoMWi0Kj
 PRfZx3QDNEhbJRkj1L+zOxIq7zdOf74eiWGyEk0WnmMo5KvQvIDUAfgYfieBTYI7w3GZRKNpjLK
 oQVIgMfGAKXiZn7clEoVLDBhFXMAnC/FYCQ+xgfgrA2dCWRff1eVqsJq+16tuNV9Xu8IEaNdrYt
 C4CQL70o6mCtSDQZy5AGb0vdWXnphw3WX8XWPjU70nw==
X-Received: by 2002:a17:90b:1d83:b0:398:bad2:c10 with SMTP id
 98e67ed59e1d1-39b3d85c011mr26798024a91.6.1788970365131; Wed, 09 Sep 2026
 09:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260908144518.1392218-1-hongkun.zhang@amd.com>
In-Reply-To: <20260908144518.1392218-1-hongkun.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Sep 2026 12:12:31 -0400
X-Gm-Features: AcwNN1U3icFknMdGM6VZ43zzUMiiOdt4cVz7sFrn66fX-4grf1BZNkEMjSEATzE
Message-ID: <CADnq5_MvcZ+s_iOXorLeO-Hj7NEG=uTV0wLfe=VnFekWyG4xFw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: retire the legacy MES design for GFX 12.1
To: Horatio Zhang <hongkun.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
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

On Tue, Sep 8, 2026 at 11:10=E2=80=AFAM Horatio Zhang <hongkun.zhang@amd.co=
m> wrote:
>
> Retire the legacy design, always enable unified MES on GFX 12.1 and drop
> the driver code and MODULE_FIRMWARE entries that only served the legacy
> path.
>
> Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  11 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        | 475 +-----------------
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c        |   9 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        | 246 ++-------
>  5 files changed, 57 insertions(+), 687 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 7710a8ed3d44..1420bb60e015 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -3281,8 +3281,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struc=
t amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &mes_v12_1_ip_block);
>                 adev->enable_mes =3D true;
>                 adev->enable_mes_kiq =3D true;
> -               if (amdgpu_uni_mes)
> -                       adev->enable_uni_mes =3D true;
> +               adev->enable_uni_mes =3D true;
>                 break;
>         default:
>                 break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index a6f95ff47d24..7a132e6d7e42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1235,7 +1235,8 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev=
, uint32_t reg, uint32_t xcc_
>         if (adev->mes.ring[0].sched.ready)
>                 return amdgpu_mes_rreg(adev, reg, xcc_id);
>
> -       BUG_ON(!ring->funcs->emit_rreg);
> +       if (!ring->funcs || !ring->funcs->emit_rreg)
> +               goto failed_kiq_read;
>
>         spin_lock_irqsave(&kiq->ring_lock, flags);
>         if (amdgpu_wb_get(adev, &reg_val_offs)) {
> @@ -1303,8 +1304,6 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, ui=
nt32_t reg, uint32_t v, uint3
>         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
>         struct amdgpu_ring *ring =3D &kiq->ring;
>
> -       BUG_ON(!ring->funcs->emit_wreg);
> -
>         if (amdgpu_device_skip_hw_access(adev))
>                 return;
>
> @@ -1313,6 +1312,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, ui=
nt32_t reg, uint32_t v, uint3
>                 return;
>         }
>
> +       if (!ring->funcs || !ring->funcs->emit_wreg)
> +               goto failed_kiq_write;
> +
>         spin_lock_irqsave(&kiq->ring_lock, flags);
>         r =3D amdgpu_ring_alloc(ring, 32);
>         if (r)
> @@ -1409,9 +1411,8 @@ int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev=
)
>         if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready)
>                 return amdgpu_mes_hdp_flush(adev);
>
> -       if (!ring->funcs->emit_hdp_flush) {
> +       if (!ring->funcs || !ring->funcs->emit_hdp_flush)
>                 return -EOPNOTSUPP;
> -       }
>
>         spin_lock_irqsave(&kiq->ring_lock, flags);
>         r =3D amdgpu_ring_alloc(ring, 32);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index f812d6d81e9c..d7effa43c0fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -203,12 +203,7 @@ static int gfx_v12_1_get_cu_info(struct amdgpu_devic=
e *adev,
>  static uint64_t gfx_v12_1_get_gpu_clock_counter(struct amdgpu_device *ad=
ev);
>  static void gfx_v12_1_xcc_select_se_sh(struct amdgpu_device *adev, u32 s=
e_num,
>                                        u32 sh_num, u32 instance, int xcc_=
id);
> -static void gfx_v12_1_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t =
reg,
> -                                    uint32_t val);
>  static int gfx_v12_1_wait_for_rlc_autoload_complete(struct amdgpu_device=
 *adev);
> -static void gfx_v12_1_ring_invalidate_tlbs(struct amdgpu_ring *ring,
> -                                          uint16_t pasid, uint32_t flush=
_type,
> -                                          bool all_hub, uint8_t dst_sel)=
;
>  static void gfx_v12_1_xcc_set_safe_mode(struct amdgpu_device *adev, int =
xcc_id);
>  static void gfx_v12_1_xcc_unset_safe_mode(struct amdgpu_device *adev, in=
t xcc_id);
>  static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
> @@ -219,142 +214,6 @@ static int gfx_v12_1_init_cp_compute_microcode_bo(s=
truct amdgpu_device *adev);
>  static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
>         struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
>
> -static void gfx_v12_1_kiq_set_resources(struct amdgpu_ring *kiq_ring,
> -                                       uint64_t queue_mask)
> -{
> -       amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
> -       amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
> -                         PACKET3_SET_RESOURCES_QUEUE_TYPE(0)); /* vmid_m=
ask:0 queue_type:0 (KIQ) */
> -       amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask)); /* queue =
mask lo */
> -       amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask)); /* queue =
mask hi */
> -       amdgpu_ring_write(kiq_ring, 0); /* gws mask lo */
> -       amdgpu_ring_write(kiq_ring, 0); /* gws mask hi */
> -       amdgpu_ring_write(kiq_ring, 0); /* oac mask */
> -       amdgpu_ring_write(kiq_ring, 0);
> -}
> -
> -static void gfx_v12_1_kiq_map_queues(struct amdgpu_ring *kiq_ring,
> -                                    struct amdgpu_ring *ring)
> -{
> -       uint64_t mqd_addr =3D amdgpu_bo_gpu_offset(ring->mqd_obj);
> -       uint64_t wptr_addr =3D ring->wptr_gpu_addr;
> -       uint32_t me =3D 0, eng_sel =3D 0;
> -
> -       switch (ring->funcs->type) {
> -       case AMDGPU_RING_TYPE_COMPUTE:
> -               me =3D 1;
> -               eng_sel =3D 0;
> -               break;
> -       case AMDGPU_RING_TYPE_MES:
> -               me =3D 2;
> -               eng_sel =3D 5;
> -               break;
> -       default:
> -               WARN_ON(1);
> -       }
> -
> -       amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
> -       /* Q_sel:0, vmid:0, vidmem: 1, engine:0, num_Q:1*/
> -       amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_=
Q: 1 */
> -                         PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel =
*/
> -                         PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
> -                         PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
> -                         PACKET3_MAP_QUEUES_PIPE(ring->pipe) |
> -                         PACKET3_MAP_QUEUES_ME((me)) |
> -                         PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type=
: normal compute queue */
> -                         PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
> -                         PACKET3_MAP_QUEUES_NUM_QUEUES(1)); /* num_queue=
s: must be 1 */
> -       amdgpu_ring_write(kiq_ring, PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ri=
ng->doorbell_index));
> -       amdgpu_ring_write(kiq_ring, lower_32_bits(mqd_addr));
> -       amdgpu_ring_write(kiq_ring, upper_32_bits(mqd_addr));
> -       amdgpu_ring_write(kiq_ring, lower_32_bits(wptr_addr));
> -       amdgpu_ring_write(kiq_ring, upper_32_bits(wptr_addr));
> -}
> -
> -static void gfx_v12_1_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
> -                                      struct amdgpu_ring *ring,
> -                                      enum amdgpu_unmap_queues_action ac=
tion,
> -                                      u64 gpu_addr, u64 seq)
> -{
> -       struct amdgpu_device *adev =3D kiq_ring->adev;
> -       uint32_t eng_sel =3D ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GF=
X ? 4 : 0;
> -
> -       if (adev->enable_mes && !adev->gfx.kiq[0].ring.sched.ready) {
> -               amdgpu_mes_unmap_legacy_queue(adev, ring, action, gpu_add=
r,
> -                                             seq, kiq_ring->xcc_id);
> -               return;
> -       }
> -
> -       amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
> -       amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_=
Q: 1 */
> -                         PACKET3_UNMAP_QUEUES_ACTION(action) |
> -                         PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
> -                         PACKET3_UNMAP_QUEUES_ENGINE_SEL(eng_sel) |
> -                         PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
> -       amdgpu_ring_write(kiq_ring,
> -                 PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_in=
dex));
> -
> -       if (action =3D=3D PREEMPT_QUEUES_NO_UNMAP) {
> -               amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
> -               amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
> -               amdgpu_ring_write(kiq_ring, seq);
> -       } else {
> -               amdgpu_ring_write(kiq_ring, 0);
> -               amdgpu_ring_write(kiq_ring, 0);
> -               amdgpu_ring_write(kiq_ring, 0);
> -       }
> -}
> -
> -static void gfx_v12_1_kiq_query_status(struct amdgpu_ring *kiq_ring,
> -                                      struct amdgpu_ring *ring,
> -                                      u64 addr, u64 seq)
> -{
> -       uint32_t eng_sel =3D ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GF=
X ? 4 : 0;
> -
> -       amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_QUERY_STATUS, 5));
> -       amdgpu_ring_write(kiq_ring,
> -                         PACKET3_QUERY_STATUS_CONTEXT_ID(0) |
> -                         PACKET3_QUERY_STATUS_INTERRUPT_SEL(0) |
> -                         PACKET3_QUERY_STATUS_COMMAND(2));
> -       amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_=
Q: 1 */
> -                         PACKET3_QUERY_STATUS_DOORBELL_OFFSET(ring->door=
bell_index) |
> -                         PACKET3_QUERY_STATUS_ENG_SEL(eng_sel));
> -       amdgpu_ring_write(kiq_ring, lower_32_bits(addr));
> -       amdgpu_ring_write(kiq_ring, upper_32_bits(addr));
> -       amdgpu_ring_write(kiq_ring, lower_32_bits(seq));
> -       amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
> -}
> -
> -static void gfx_v12_1_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
> -                                         uint16_t pasid,
> -                                         uint32_t flush_type,
> -                                         bool all_hub)
> -{
> -       gfx_v12_1_ring_invalidate_tlbs(kiq_ring, pasid, flush_type, all_h=
ub, 1);
> -}
> -
> -static const struct kiq_pm4_funcs gfx_v12_1_kiq_pm4_funcs =3D {
> -       .kiq_set_resources =3D gfx_v12_1_kiq_set_resources,
> -       .kiq_map_queues =3D gfx_v12_1_kiq_map_queues,
> -       .kiq_unmap_queues =3D gfx_v12_1_kiq_unmap_queues,
> -       .kiq_query_status =3D gfx_v12_1_kiq_query_status,
> -       .kiq_invalidate_tlbs =3D gfx_v12_1_kiq_invalidate_tlbs,
> -       .set_resources_size =3D 8,
> -       .map_queues_size =3D 7,
> -       .unmap_queues_size =3D 6,
> -       .query_status_size =3D 7,
> -       .invalidate_tlbs_size =3D 2,
> -};
> -
> -static void gfx_v12_1_set_kiq_pm4_funcs(struct amdgpu_device *adev)
> -{
> -       int i, num_xcc;
> -
> -       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> -       for (i =3D0; i < num_xcc; i++)
> -               adev->gfx.kiq[i].pmf =3D &gfx_v12_1_kiq_pm4_funcs;
> -}
> -
>  static void gfx_v12_1_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel=
,
>                                    int mem_space, int opt, uint32_t addr0=
,
>                                    uint32_t addr1, uint32_t ref,
> @@ -403,14 +262,9 @@ static int gfx_v12_1_ring_test_ring(struct amdgpu_ri=
ng *ring)
>                 return r;
>         }
>
> -       if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ) {
> -               gfx_v12_1_ring_emit_wreg(ring, xcc_offset, 0xDEADBEEF);
> -       } else {
> -               amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, =
1));
> -               amdgpu_ring_write(ring, xcc_offset -
> -                                 PACKET3_SET_UCONFIG_REG_START);
> -               amdgpu_ring_write(ring, 0xDEADBEEF);
> -       }
> +       amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
> +       amdgpu_ring_write(ring, xcc_offset - PACKET3_SET_UCONFIG_REG_STAR=
T);
> +       amdgpu_ring_write(ring, 0xDEADBEEF);
>         amdgpu_ring_commit(ring);
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> @@ -439,11 +293,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring=
 *ring, long timeout)
>         volatile uint32_t *cpu_ptr;
>         long r;
>
> -       /* MES KIQ fw hasn't indirect buffer support for now */
> -       if (adev->enable_mes_kiq &&
> -           ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)
> -               return 0;
> -
>         r =3D amdgpu_wb_get(adev, &index);
>         if (r)
>                 return r;
> @@ -1538,18 +1387,6 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                         }
>                 }
>
> -               if (!adev->enable_mes_kiq) {
> -                       r =3D amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZ=
E, xcc_id);
> -                       if (r) {
> -                               dev_err(adev->dev, "Failed to init KIQ BO=
s!\n");
> -                               return r;
> -                       }
> -
> -                       r =3D amdgpu_gfx_kiq_init_ring(adev, xcc_id);
> -                       if (r)
> -                               return r;
> -               }
> -
>                 r =3D amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v12_1_co=
mpute_mqd), xcc_id);
>                 if (r)
>                         return r;
> @@ -1600,15 +1437,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>         for (i =3D 0; i < adev->gfx.num_compute_rings * num_xcc; i++)
>                 amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
>
> -       for (i =3D 0; i < num_xcc; i++) {
> +       for (i =3D 0; i < num_xcc; i++)
>                 amdgpu_gfx_mqd_sw_fini(adev, i);
>
> -               if (!adev->enable_mes_kiq) {
> -                       amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[i].ring);
> -                       amdgpu_gfx_kiq_fini(adev, i);
> -               }
> -       }
> -
>         gfx_v12_1_rlc_fini(adev);
>         gfx_v12_1_mec_fini(adev);
>
> @@ -2193,8 +2024,6 @@ static void gfx_v12_1_xcc_cp_compute_enable(struct =
amdgpu_device *adev,
>                                                  enable ? 0 : 1);
>         WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_RS64_CNTL, data)=
;
>
> -       adev->gfx.kiq[xcc_id].ring.sched.ready =3D enable;
> -
>         udelay(50);
>  }
>
> @@ -2357,21 +2186,6 @@ static int gfx_v12_1_xcc_cp_compute_load_microcode=
_rs64(struct amdgpu_device *ad
>         return 0;
>  }
>
> -static void gfx_v12_1_xcc_kiq_setting(struct amdgpu_ring *ring,
> -                                     int xcc_id)
> -{
> -       uint32_t tmp;
> -       struct amdgpu_device *adev =3D ring->adev;
> -
> -       /* tell RLC which is KIQ queue */
> -       tmp =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULE=
RS);
> -       tmp &=3D 0xffffff00;
> -       tmp |=3D (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tmp)=
;
> -       tmp |=3D 0x80;
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CP_SCHEDULERS, tmp)=
;
> -}
> -
>  static void gfx_v12_1_xcc_cp_set_doorbell_range(struct amdgpu_device *ad=
ev,
>                                                 int xcc_id)
>  {
> @@ -2527,149 +2341,6 @@ static int gfx_v12_1_compute_mqd_init(struct amdg=
pu_device *adev, void *m,
>         return 0;
>  }
>
> -static int gfx_v12_1_xcc_kiq_init_register(struct amdgpu_ring *ring,
> -                                          int xcc_id)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -       struct v12_1_compute_mqd *mqd =3D ring->mqd_ptr;
> -       int j;
> -
> -       /* inactivate the queue */
> -       if (amdgpu_sriov_vf(adev))
> -               WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE, =
0);
> -
> -       /* disable wptr polling */
> -       WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id), CP_PQ_WPTR_POLL_C=
NTL, EN, 0);
> -
> -       /* write the EOP addr */
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_EOP_BASE_ADDR,
> -              mqd->cp_hqd_eop_base_addr_lo);
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_EOP_BASE_ADDR_HI=
,
> -              mqd->cp_hqd_eop_base_addr_hi);
> -
> -       /* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_EOP_CONTROL,
> -              mqd->cp_hqd_eop_control);
> -
> -       /* enable doorbell? */
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONT=
ROL,
> -              mqd->cp_hqd_pq_doorbell_control);
> -
> -       /* disable the queue if it's active */
> -       if (RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1)=
 {
> -               WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_=
REQUEST, 1);
> -               for (j =3D 0; j < adev->usec_timeout; j++) {
> -                       if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regC=
P_HQD_ACTIVE) & 1))
> -                               break;
> -                       udelay(1);
> -               }
> -               WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_=
REQUEST,
> -                      mqd->cp_hqd_dequeue_request);
> -               WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR,
> -                      mqd->cp_hqd_pq_rptr);
> -               WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_=
LO,
> -                      mqd->cp_hqd_pq_wptr_lo);
> -               WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_=
HI,
> -                      mqd->cp_hqd_pq_wptr_hi);
> -       }
> -
> -       /* set the pointer to the MQD */
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MQD_BASE_ADDR,
> -              mqd->cp_mqd_base_addr_lo);
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MQD_BASE_ADDR_HI,
> -              mqd->cp_mqd_base_addr_hi);
> -
> -       /* set MQD vmid to 0 */
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MQD_CONTROL,
> -              mqd->cp_mqd_control);
> -
> -       /* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_BASE,
> -              mqd->cp_hqd_pq_base_lo);
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_BASE_HI,
> -              mqd->cp_hqd_pq_base_hi);
> -
> -       /* set up the HQD, this is similar to CP_RB0_CNTL */
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_CONTROL,
> -              mqd->cp_hqd_pq_control);
> -
> -       /* set the wb address whether it's enabled or not */
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR_REPORT_A=
DDR,
> -               mqd->cp_hqd_pq_rptr_report_addr_lo);
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR_REPORT_A=
DDR_HI,
> -               mqd->cp_hqd_pq_rptr_report_addr_hi);
> -
> -       /* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MAS=
K=3D1 */
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_POLL_ADD=
R,
> -              mqd->cp_hqd_pq_wptr_poll_addr_lo);
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_POLL_ADD=
R_HI,
> -              mqd->cp_hqd_pq_wptr_poll_addr_hi);
> -
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONT=
ROL,
> -              mqd->cp_hqd_pq_doorbell_control);
> -
> -       /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_LO,
> -              mqd->cp_hqd_pq_wptr_lo);
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_HI,
> -              mqd->cp_hqd_pq_wptr_hi);
> -
> -       /* set the vmid for the queue */
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_VMID, mqd->cp_hq=
d_vmid);
> -
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PERSISTENT_STATE=
,
> -              mqd->cp_hqd_persistent_state);
> -
> -       /* activate the queue */
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE,
> -              mqd->cp_hqd_active);
> -
> -       if (ring->use_doorbell)
> -               WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id), CP_PQ_STA=
TUS, DOORBELL_ENABLE, 1);
> -
> -       return 0;
> -}
> -
> -static int gfx_v12_1_xcc_kiq_init_queue(struct amdgpu_ring *ring,
> -                                       int xcc_id)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -       struct v12_1_compute_mqd *mqd =3D ring->mqd_ptr;
> -
> -       gfx_v12_1_xcc_kiq_setting(ring, xcc_id);
> -
> -       if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
> -               /* reset MQD to a clean status */
> -               if (adev->gfx.kiq[xcc_id].mqd_backup)
> -                       memcpy(mqd, adev->gfx.kiq[xcc_id].mqd_backup, siz=
eof(*mqd));
> -
> -               /* reset ring buffer */
> -               ring->wptr =3D 0;
> -               amdgpu_ring_clear_ring(ring);
> -
> -               mutex_lock(&adev->srbm_mutex);
> -               soc_v1_0_grbm_select(adev, ring->me, ring->pipe, ring->qu=
eue, 0, GET_INST(GC, xcc_id));
> -               gfx_v12_1_xcc_kiq_init_register(ring, xcc_id);
> -               soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_i=
d));
> -               mutex_unlock(&adev->srbm_mutex);
> -       } else {
> -               memset((void *)mqd, 0, sizeof(*mqd));
> -               if (amdgpu_sriov_vf(adev) && adev->in_suspend)
> -                       amdgpu_ring_clear_ring(ring);
> -               mutex_lock(&adev->srbm_mutex);
> -               soc_v1_0_grbm_select(adev, ring->me, ring->pipe, ring->qu=
eue, 0, GET_INST(GC, xcc_id));
> -               amdgpu_ring_init_mqd(ring);
> -               gfx_v12_1_xcc_kiq_init_register(ring, xcc_id);
> -               soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_i=
d));
> -               mutex_unlock(&adev->srbm_mutex);
> -
> -               if (adev->gfx.kiq[xcc_id].mqd_backup)
> -                       memcpy(adev->gfx.kiq[xcc_id].mqd_backup, mqd, siz=
eof(*mqd));
> -       }
> -
> -       return 0;
> -}
> -
>  static int gfx_v12_1_xcc_kcq_init_queue(struct amdgpu_ring *ring,
>                                         int xcc_id)
>  {
> @@ -2700,32 +2371,6 @@ static int gfx_v12_1_xcc_kcq_init_queue(struct amd=
gpu_ring *ring,
>         return 0;
>  }
>
> -static int gfx_v12_1_xcc_kiq_resume(struct amdgpu_device *adev,
> -                                   int xcc_id)
> -{
> -       struct amdgpu_ring *ring;
> -       int r;
> -
> -       ring =3D &adev->gfx.kiq[xcc_id].ring;
> -
> -       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -       if (unlikely(r !=3D 0))
> -               return r;
> -
> -       r =3D amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
> -       if (unlikely(r !=3D 0)) {
> -               amdgpu_bo_unreserve(ring->mqd_obj);
> -               return r;
> -       }
> -
> -       gfx_v12_1_xcc_kiq_init_queue(ring, xcc_id);
> -       amdgpu_bo_kunmap(ring->mqd_obj);
> -       ring->mqd_ptr =3D NULL;
> -       amdgpu_bo_unreserve(ring->mqd_obj);
> -       ring->sched.ready =3D true;
> -       return 0;
> -}
> -
>  static int gfx_v12_1_xcc_kcq_resume(struct amdgpu_device *adev,
>                                     int xcc_id)
>  {
> @@ -2762,6 +2407,9 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_de=
vice *adev, uint16_t xcc_mask
>         int r, i, xcc_id;
>         struct amdgpu_ring *ring;
>
> +       if (!adev->mes.kiq_hw_init)
> +               return -EINVAL;
> +
>         for_each_inst(xcc_id, xcc_mask) {
>                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT=
) {
>                         /* legacy firmware loading */
> @@ -2779,19 +2427,7 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_d=
evice *adev, uint16_t xcc_mask
>
>                 gfx_v12_1_xcc_cp_compute_enable(adev, true, xcc_id);
>
> -               if (adev->enable_mes_kiq && adev->mes.kiq_hw_init) {
> -                       r =3D amdgpu_mes_kiq_hw_init(adev, xcc_id);
> -                       /*
> -                        * With MES, GFX KIQ ring is owned by the MES and=
 is never
> -                        * initialized/used directly by the driver, so it=
 must
> -                        * not be left flagged as ready. mes_v12_0_hw_ini=
t() clears
> -                        * but clear here if MES init fails
> -                        */
> -                       if (r)
> -                               adev->gfx.kiq[xcc_id].ring.sched.ready =
=3D false;
> -               } else {
> -                       r =3D gfx_v12_1_xcc_kiq_resume(adev, xcc_id);
> -               }
> +               r =3D amdgpu_mes_kiq_hw_init(adev, xcc_id);
>                 if (r)
>                         return r;
>
> @@ -3184,7 +2820,6 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_bl=
ock *ip_block)
>                 adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kc=
q(adev),
>                                                   AMDGPU_MAX_COMPUTE_RING=
S);
>
> -       gfx_v12_1_set_kiq_pm4_funcs(adev);
>         gfx_v12_1_set_ring_funcs(adev);
>         gfx_v12_1_set_irq_funcs(adev);
>         gfx_v12_1_set_rlc_funcs(adev);
> @@ -3685,18 +3320,6 @@ static void gfx_v12_1_ring_emit_pipeline_sync(stru=
ct amdgpu_ring *ring)
>                                upper_32_bits(addr), seq, 0xffffffff, 4);
>  }
>
> -static void gfx_v12_1_ring_invalidate_tlbs(struct amdgpu_ring *ring,
> -                                  uint16_t pasid, uint32_t flush_type,
> -                                  bool all_hub, uint8_t dst_sel)
> -{
> -       amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
> -       amdgpu_ring_write(ring,
> -                         PACKET3_INVALIDATE_TLBS_DST_SEL(dst_sel) |
> -                         PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
> -                         PACKET3_INVALIDATE_TLBS_PASID(pasid) |
> -                         PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type))=
;
> -}
> -
>  static void gfx_v12_1_ring_emit_vm_flush(struct amdgpu_ring *ring,
>                                          unsigned vmid, uint64_t pd_addr)
>  {
> @@ -3705,65 +3328,14 @@ static void gfx_v12_1_ring_emit_vm_flush(struct a=
mdgpu_ring *ring,
>         /* compute doesn't have PFP */
>  }
>
> -static void gfx_v12_1_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 =
addr,
> -                                         u64 seq, unsigned int flags)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -
> -       /* write fence seq to the "addr" */
> -       amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> -       amdgpu_ring_write(ring, (PACKET3_WRITE_DATA__DST_SEL(5) | PACKET3=
_WRITE_DATA__WR_CONFIRM(1)));
> -       amdgpu_ring_write(ring, lower_32_bits(addr));
> -       amdgpu_ring_write(ring, upper_32_bits(addr));
> -       amdgpu_ring_write(ring, lower_32_bits(seq));
> -
> -       if (flags & AMDGPU_FENCE_FLAG_INT) {
> -               /* set register to trigger INT */
> -               amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> -               amdgpu_ring_write(ring, (PACKET3_WRITE_DATA__DST_SEL(0) |=
 PACKET3_WRITE_DATA__WR_CONFIRM(1)));
> -               amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, GET_INST(GC,=
 0), regCPC_INT_STATUS));
> -               amdgpu_ring_write(ring, 0);
> -               amdgpu_ring_write(ring, 0x20000000); /* src_id is 178 */
> -       }
> -}
> -
> -static void gfx_v12_1_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t =
reg,
> -                                    uint32_t reg_val_offs)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -
> -       reg =3D soc_v1_0_normalize_xcc_reg_offset(reg);
> -
> -       amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
> -       amdgpu_ring_write(ring, 0 |     /* src: register*/
> -                               (5 << 8) |      /* dst: memory */
> -                               (1 << 20));     /* write confirm */
> -       amdgpu_ring_write(ring, reg);
> -       amdgpu_ring_write(ring, 0);
> -       amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
> -                               reg_val_offs * 4));
> -       amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
> -                               reg_val_offs * 4));
> -}
> -
>  static void gfx_v12_1_ring_emit_wreg(struct amdgpu_ring *ring,
>                                      uint32_t reg,
>                                      uint32_t val)
>  {
> -       uint32_t cmd =3D 0;
> -
>         reg =3D soc_v1_0_normalize_xcc_reg_offset(reg);
>
> -       switch (ring->funcs->type) {
> -       case AMDGPU_RING_TYPE_KIQ:
> -               cmd =3D (1 << 16); /* no inc addr */
> -               break;
> -       default:
> -               cmd =3D PACKET3_WRITE_DATA__WR_CONFIRM(1);
> -               break;
> -       }
>         amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> -       amdgpu_ring_write(ring, cmd);
> +       amdgpu_ring_write(ring, PACKET3_WRITE_DATA__WR_CONFIRM(1));
>         amdgpu_ring_write(ring, reg);
>         amdgpu_ring_write(ring, 0);
>         amdgpu_ring_write(ring, val);
> @@ -4157,41 +3729,12 @@ static const struct amdgpu_ring_funcs gfx_v12_1_r=
ing_funcs_compute =3D {
>         .emit_mem_sync =3D gfx_v12_1_emit_mem_sync,
>  };
>
> -static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_kiq =3D {
> -       .type =3D AMDGPU_RING_TYPE_KIQ,
> -       .align_mask =3D 0xff,
> -       .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
> -       .support_64bit_ptrs =3D true,
> -       .get_rptr =3D gfx_v12_1_ring_get_rptr_compute,
> -       .get_wptr =3D gfx_v12_1_ring_get_wptr_compute,
> -       .set_wptr =3D gfx_v12_1_ring_set_wptr_compute,
> -       .emit_frame_size =3D
> -               7 + /* gfx_v12_1_ring_emit_pipeline_sync */
> -               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> -               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> -               2 + /* gfx_v12_1_ring_emit_vm_flush */
> -               8 + 8 + 8, /* gfx_v12_1_ring_emit_fence_kiq x3 for user f=
ence, vm fence */
> -       .emit_ib_size =3D 7, /* gfx_v12_1_ring_emit_ib_compute */
> -       .emit_ib =3D gfx_v12_1_ring_emit_ib_compute,
> -       .emit_fence =3D gfx_v12_1_ring_emit_fence_kiq,
> -       .test_ring =3D gfx_v12_1_ring_test_ring,
> -       .test_ib =3D gfx_v12_1_ring_test_ib,
> -       .insert_nop =3D amdgpu_ring_insert_nop,
> -       .pad_ib =3D amdgpu_ring_generic_pad_ib,
> -       .emit_rreg =3D gfx_v12_1_ring_emit_rreg,
> -       .emit_wreg =3D gfx_v12_1_ring_emit_wreg,
> -       .emit_reg_wait =3D gfx_v12_1_ring_emit_reg_wait,
> -       .emit_reg_write_reg_wait =3D gfx_v12_1_ring_emit_reg_write_reg_wa=
it,
> -};
> -
>  static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev)
>  {
>         int i, j, num_xcc;
>
>         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
>         for (i =3D 0; i < num_xcc; i++) {
> -               adev->gfx.kiq[i].ring.funcs =3D &gfx_v12_1_ring_funcs_kiq=
;
> -
>                 for (j =3D 0; j < adev->gfx.num_compute_rings; j++)
>                         adev->gfx.compute_ring[j + i * adev->gfx.num_comp=
ute_rings].funcs =3D
>                                                 &gfx_v12_1_ring_funcs_com=
pute;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_1.c
> index 565ee7fba3cd..3349e8bc1c20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -407,9 +407,8 @@ static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>         /* This is necessary for SRIOV as well as for GFXOFF to function
>          * properly under bare metal
>          */
> -       if (((adev->gfx.kiq[inst].ring.sched.ready ||
> -             adev->mes.ring[MES_PIPE_INST(inst, 0)].sched.ready) &&
> -           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)))) {
> +       if (adev->mes.ring[MES_PIPE_INST(inst, 0)].sched.ready &&
> +           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>                 struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub];
>                 const unsigned eng =3D 17;
>                 u32 inv_req =3D hub->vmhub_funcs->get_invalidate_req(vmid=
, flush_type);
> @@ -432,7 +431,7 @@ static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>   * @pasid: pasid to be flush
>   * @flush_type: the flush type
>   * @all_hub: flush all hubs
> - * @inst: is used to select which instance of KIQ to use for the invalid=
ation
> + * @inst: XCC instance to use for the invalidation
>   *
>   * Flush the TLB for the requested pasid.
>   */
> @@ -443,7 +442,7 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdg=
pu_device *adev,
>         uint16_t queried;
>         int vmid, i;
>
> -       if (adev->enable_uni_mes && adev->mes.ring[0].sched.ready &&
> +       if (adev->mes.ring[0].sched.ready &&
>             (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x6f=
) {
>                 struct mes_inv_tlbs_pasid_input input =3D {0};
>                 input.xcc_id =3D inst;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_1.c
> index c827eb46058a..a69f9b9c5cd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -34,8 +34,6 @@
>  #include "gfx_v12_1_pkt.h"
>  #include "sdma_v7_1_0_pkt_open.h"
>
> -MODULE_FIRMWARE("amdgpu/gc_12_1_0_mes.bin");
> -MODULE_FIRMWARE("amdgpu/gc_12_1_0_mes1.bin");
>  MODULE_FIRMWARE("amdgpu/gc_12_1_0_uni_mes.bin");
>
>  static int mes_v12_1_hw_init(struct amdgpu_ip_block *ip_block);
> @@ -414,15 +412,11 @@ static int mes_v12_1_map_legacy_queue(struct amdgpu=
_mes *mes,
>                 convert_to_mes_queue_type(input->queue_type);
>         mes_add_queue_pkt.map_legacy_kq =3D 1;
>
> -       if (mes->adev->enable_uni_mes) {
> -               /* Keep scheduler queue on KIQ pipe; map all other kernel=
 queues on sched pipe. */
> -               if (input->queue_type =3D=3D AMDGPU_RING_TYPE_MES)
> -                       pipe =3D AMDGPU_MES_KIQ_PIPE;
> -               else
> -                       pipe =3D AMDGPU_MES_SCHED_PIPE;
> -       } else {
> +       /* Keep scheduler queue on KIQ pipe; map all other kernel queues =
on sched pipe. */
> +       if (input->queue_type =3D=3D AMDGPU_RING_TYPE_MES)
> +               pipe =3D AMDGPU_MES_KIQ_PIPE;
> +       else
>                 pipe =3D AMDGPU_MES_SCHED_PIPE;
> -       }
>
>         return mes_v12_1_submit_pkt_and_poll_completion(mes,
>                         input->xcc_id, pipe,
> @@ -459,15 +453,11 @@ static int mes_v12_1_unmap_legacy_queue(struct amdg=
pu_mes *mes,
>                         convert_to_mes_queue_type(input->queue_type);
>         }
>
> -       if (mes->adev->enable_uni_mes) {
> -               /* Keep scheduler queue on KIQ pipe; map all other kernel=
 queues on sched pipe. */
> -               if (input->queue_type =3D=3D AMDGPU_RING_TYPE_MES)
> -                       pipe =3D AMDGPU_MES_KIQ_PIPE;
> -               else
> -                       pipe =3D AMDGPU_MES_SCHED_PIPE;
> -       } else {
> +       /* Keep scheduler queue on KIQ pipe; map all other kernel queues =
on sched pipe. */
> +       if (input->queue_type =3D=3D AMDGPU_RING_TYPE_MES)
> +               pipe =3D AMDGPU_MES_KIQ_PIPE;
> +       else
>                 pipe =3D AMDGPU_MES_SCHED_PIPE;
> -       }
>
>         return mes_v12_1_submit_pkt_and_poll_completion(mes,
>                         input->xcc_id, pipe,
> @@ -567,7 +557,7 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
>         int pipe;
>
>         /*OP_WRM_REG_WR_WAIT is used to do tlb invalidation which need to=
 be handled in sched pipe for gfx_12_1.*/
> -       if (mes->adev->enable_uni_mes && input->op !=3D MES_MISC_OP_WRM_R=
EG_WR_WAIT)
> +       if (input->op !=3D MES_MISC_OP_WRM_REG_WR_WAIT)
>                 pipe =3D AMDGPU_MES_KIQ_PIPE;
>         else
>                 pipe =3D AMDGPU_MES_SCHED_PIPE;
> @@ -766,7 +756,7 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_m=
es *mes,
>
>         if (pipe =3D=3D AMDGPU_MES_SCHED_PIPE)
>                 adev->mes.sched_version =3D RREG32_SOC15(GC, GET_INST(GC,=
 xcc_id), regCP_MES_GP3_LO);
> -       else if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
> +       else if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE)
>                 adev->mes.kiq_version =3D RREG32_SOC15(GC, GET_INST(GC, x=
cc_id), regCP_MES_GP3_LO);
>
>         soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> @@ -880,10 +870,7 @@ static int mes_v12_1_reset_legacy_queue(struct amdgp=
u_mes *mes,
>                 mes_reset_queue_pkt.doorbell_offset =3D input->doorbell_o=
ffset;
>         }
>
> -       if (mes->adev->enable_uni_mes)
> -               pipe =3D AMDGPU_MES_KIQ_PIPE;
> -       else
> -               pipe =3D AMDGPU_MES_SCHED_PIPE;
> +       pipe =3D AMDGPU_MES_KIQ_PIPE;
>
>         return mes_v12_1_submit_pkt_and_poll_completion(mes,
>                         input->xcc_id, pipe,
> @@ -1100,10 +1087,8 @@ static void mes_v12_1_enable(struct amdgpu_device =
*adev,
>
>                 if (amdgpu_emu_mode)
>                         msleep(500);
> -               else if (adev->enable_uni_mes)
> -                       udelay(500);
>                 else
> -                       udelay(50);
> +                       udelay(500);
>         } else {
>                 data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MES=
_CNTL);
>                 data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_ACTIV=
E, 0);
> @@ -1426,31 +1411,6 @@ static void mes_v12_1_queue_init_register(struct a=
mdgpu_ring *ring,
>         mutex_unlock(&adev->srbm_mutex);
>  }
>
> -static int mes_v12_1_kiq_enable_queue(struct amdgpu_device *adev, int xc=
c_id)
> -{
> -       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
> -       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[xcc_id].ring;
> -       int r, inst =3D MES_PIPE_INST(xcc_id, AMDGPU_MES_SCHED_PIPE);
> -
> -       if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
> -               return -EINVAL;
> -
> -       r =3D amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
> -       if (r) {
> -               DRM_ERROR("Failed to lock KIQ (%d).\n", r);
> -               return r;
> -       }
> -
> -       kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring[inst]);
> -
> -       r =3D amdgpu_ring_test_ring(kiq_ring);
> -       if (r) {
> -               DRM_ERROR("kfq enable failed\n");
> -               kiq_ring->sched.ready =3D false;
> -       }
> -       return r;
> -}
> -
>  static int mes_v12_1_queue_init(struct amdgpu_device *adev,
>                                   enum amdgpu_mes_pipe pipe,
>                                   int xcc_id)
> @@ -1458,13 +1418,9 @@ static int mes_v12_1_queue_init(struct amdgpu_devi=
ce *adev,
>         struct amdgpu_ring *ring;
>         int r;
>
> -       if (!adev->enable_uni_mes && pipe =3D=3D AMDGPU_MES_KIQ_PIPE)
> -               ring =3D &adev->gfx.kiq[xcc_id].ring;
> -       else
> -               ring =3D &adev->mes.ring[MES_PIPE_INST(xcc_id, pipe)];
> +       ring =3D &adev->mes.ring[MES_PIPE_INST(xcc_id, pipe)];
>
> -       if ((adev->enable_uni_mes || pipe =3D=3D AMDGPU_MES_SCHED_PIPE) &=
&
> -           (amdgpu_in_reset(adev) || adev->in_suspend)) {
> +       if (amdgpu_in_reset(adev) || adev->in_suspend) {
>                 *(ring->wptr_cpu_addr) =3D 0;
>                 *(ring->rptr_cpu_addr) =3D 0;
>                 amdgpu_ring_clear_ring(ring);
> @@ -1475,10 +1431,7 @@ static int mes_v12_1_queue_init(struct amdgpu_devi=
ce *adev,
>                 return r;
>
>         if (pipe =3D=3D AMDGPU_MES_SCHED_PIPE) {
> -               if (adev->enable_uni_mes)
> -                       r =3D amdgpu_mes_map_legacy_queue(adev, ring, xcc=
_id);
> -               else
> -                       r =3D mes_v12_1_kiq_enable_queue(adev, xcc_id);
> +               r =3D amdgpu_mes_map_legacy_queue(adev, ring, xcc_id);
>                 if (r)
>                         return r;
>         } else {
> @@ -1527,39 +1480,6 @@ static int mes_v12_1_ring_init(struct amdgpu_devic=
e *adev,
>                                 AMDGPU_RING_PRIO_DEFAULT, NULL);
>  }
>
> -static int mes_v12_1_kiq_ring_init(struct amdgpu_device *adev, int xcc_i=
d)
> -{
> -       struct amdgpu_ring *ring;
> -       int inst =3D MES_PIPE_INST(xcc_id, AMDGPU_MES_KIQ_PIPE);
> -
> -       spin_lock_init(&adev->gfx.kiq[xcc_id].ring_lock);
> -
> -       ring =3D &adev->gfx.kiq[xcc_id].ring;
> -
> -       ring->me =3D 3;
> -       ring->pipe =3D 1;
> -       ring->queue =3D 0;
> -       ring->xcc_id =3D xcc_id;
> -       ring->vm_hub =3D AMDGPU_GFXHUB(xcc_id);
> -
> -       ring->adev =3D NULL;
> -       ring->ring_obj =3D NULL;
> -       ring->use_doorbell =3D true;
> -       ring->eop_gpu_addr =3D adev->mes.eop_gpu_addr[inst];
> -       ring->no_scheduler =3D true;
> -       ring->doorbell_index =3D
> -               (adev->doorbell_index.mes_ring1 +
> -                xcc_id * adev->doorbell_index.xcc_doorbell_range)
> -               << 1;
> -
> -       snprintf(ring->name, sizeof(ring->name), "mes_kiq_%hhu.%hhu.%hhu.=
%hhu",
> -                (unsigned char)xcc_id, (unsigned char)ring->me,
> -                (unsigned char)ring->pipe, (unsigned char)ring->queue);
> -
> -       return amdgpu_ring_init(adev, ring, 1024, NULL, 0,
> -                               AMDGPU_RING_PRIO_DEFAULT, NULL);
> -}
> -
>  static int mes_v12_1_mqd_sw_init(struct amdgpu_device *adev,
>                                    enum amdgpu_mes_pipe pipe,
>                                    int xcc_id)
> @@ -1568,10 +1488,7 @@ static int mes_v12_1_mqd_sw_init(struct amdgpu_dev=
ice *adev,
>         struct amdgpu_ring *ring;
>         int inst =3D MES_PIPE_INST(xcc_id, pipe);
>
> -       if (!adev->enable_uni_mes && pipe =3D=3D AMDGPU_MES_KIQ_PIPE)
> -               ring =3D &adev->gfx.kiq[xcc_id].ring;
> -       else
> -               ring =3D &adev->mes.ring[inst];
> +       ring =3D &adev->mes.ring[inst];
>
>         if (ring->mqd_obj)
>                 return 0;
> @@ -1606,8 +1523,8 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         adev->mes.kiq_hw_fini =3D &mes_v12_1_kiq_hw_fini;
>         adev->mes.enable_legacy_queue_map =3D true;
>
> -       adev->mes.event_log_size =3D
> -               adev->enable_uni_mes ? (AMDGPU_MAX_MES_PIPES * AMDGPU_MES=
_LOG_BUFFER_SIZE * num_xcc) : AMDGPU_MES_LOG_BUFFER_SIZE;
> +       adev->mes.event_log_size =3D AMDGPU_MAX_MES_PIPES *
> +                                  AMDGPU_MES_LOG_BUFFER_SIZE * num_xcc;
>
>         r =3D amdgpu_mes_init(adev);
>         if (r)
> @@ -1623,15 +1540,11 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                         if (r)
>                                 return r;
>
> -                       if (!adev->enable_uni_mes && pipe =3D=3D
> -                           AMDGPU_MES_KIQ_PIPE)
> -                               r =3D mes_v12_1_kiq_ring_init(adev, xcc_i=
d);
> -                       else
> -                               r =3D mes_v12_1_ring_init(adev, xcc_id, p=
ipe);
> +                       r =3D mes_v12_1_ring_init(adev, xcc_id, pipe);
>                         if (r)
>                                 return r;
>
> -                       if (adev->enable_uni_mes && num_xcc > 1) {
> +                       if (num_xcc > 1) {
>                                 r =3D mes_v12_1_allocate_shared_cmd_buf(a=
dev,
>                                                               pipe, xcc_i=
d);
>                                 if (r)
> @@ -1662,12 +1575,10 @@ static int mes_v12_1_sw_fini(struct amdgpu_ip_blo=
ck *ip_block)
>                                               &adev->mes.eop_gpu_addr[ins=
t],
>                                               NULL);
>
> -                       if (adev->enable_uni_mes || pipe =3D=3D AMDGPU_ME=
S_SCHED_PIPE) {
> -                               amdgpu_bo_free_kernel(&adev->mes.ring[ins=
t].mqd_obj,
> -                                                     &adev->mes.ring[ins=
t].mqd_gpu_addr,
> -                                                     &adev->mes.ring[ins=
t].mqd_ptr);
> -                               amdgpu_ring_fini(&adev->mes.ring[inst]);
> -                       }
> +                       amdgpu_bo_free_kernel(&adev->mes.ring[inst].mqd_o=
bj,
> +                                             &adev->mes.ring[inst].mqd_g=
pu_addr,
> +                                             &adev->mes.ring[inst].mqd_p=
tr);
> +                       amdgpu_ring_fini(&adev->mes.ring[inst]);
>                 }
>         }
>
> @@ -1675,13 +1586,6 @@ static int mes_v12_1_sw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>                 amdgpu_ucode_release(&adev->mes.fw[pipe]);
>
>         for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> -               if (!adev->enable_uni_mes) {
> -                       amdgpu_bo_free_kernel(&adev->gfx.kiq[xcc_id].ring=
.mqd_obj,
> -                                     &adev->gfx.kiq[xcc_id].ring.mqd_gpu=
_addr,
> -                                     &adev->gfx.kiq[xcc_id].ring.mqd_ptr=
);
> -                       amdgpu_ring_fini(&adev->gfx.kiq[xcc_id].ring);
> -               }
> -
>                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT=
) {
>                         mes_v12_1_free_ucode_buffers(adev,
>                                        AMDGPU_MES_KIQ_PIPE, xcc_id);
> @@ -1694,44 +1598,6 @@ static int mes_v12_1_sw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>         return 0;
>  }
>
> -static void mes_v12_1_kiq_dequeue_sched(struct amdgpu_device *adev,
> -                                         int xcc_id)
> -{
> -       uint32_t data;
> -       int i;
> -
> -       mutex_lock(&adev->srbm_mutex);
> -       soc_v1_0_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0,
> -                            GET_INST(GC, xcc_id));
> -
> -       /* disable the queue if it's active */
> -       if (RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1)=
 {
> -               WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_=
REQUEST, 1);
> -               for (i =3D 0; i < adev->usec_timeout; i++) {
> -                       if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regC=
P_HQD_ACTIVE) & 1))
> -                               break;
> -                       udelay(1);
> -               }
> -       }
> -       data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOOR=
BELL_CONTROL);
> -       data =3D REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
> -                               DOORBELL_EN, 0);
> -       data =3D REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
> -                               DOORBELL_HIT, 1);
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONT=
ROL, data);
> -
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONT=
ROL, 0);
> -
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_LO, 0);
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_HI, 0);
> -       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR, 0);
> -
> -       soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> -       mutex_unlock(&adev->srbm_mutex);
> -
> -       adev->mes.ring[MES_PIPE_INST(xcc_id, 0)].sched.ready =3D false;
> -}
> -
>  static void mes_v12_1_kiq_dequeue(struct amdgpu_device *adev, int xcc_id=
)
>  {
>         int i;
> @@ -1780,10 +1646,7 @@ static int mes_v12_1_kiq_hw_init(struct amdgpu_dev=
ice *adev, uint32_t xcc_id)
>         int r =3D 0;
>         struct amdgpu_ip_block *ip_block;
>
> -       if (adev->enable_uni_mes)
> -               mes_v12_1_kiq_setting(&adev->mes.ring[inst], xcc_id);
> -       else
> -               mes_v12_1_kiq_setting(&adev->gfx.kiq[xcc_id].ring, xcc_id=
);
> +       mes_v12_1_kiq_setting(&adev->mes.ring[inst], xcc_id);
>
>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
>
> @@ -1818,19 +1681,17 @@ static int mes_v12_1_kiq_hw_init(struct amdgpu_de=
vice *adev, uint32_t xcc_id)
>         if (r)
>                 goto failure;
>
> -       if (adev->enable_uni_mes) {
> -               r =3D mes_v12_1_setup_coop_mode(adev, xcc_id);
> -               if (r)
> -                       goto failure;
> +       r =3D mes_v12_1_setup_coop_mode(adev, xcc_id);
> +       if (r)
> +               goto failure;
>
> -               r =3D mes_v12_1_set_hw_resources(&adev->mes,
> -                                                AMDGPU_MES_KIQ_PIPE, xcc=
_id);
> -               if (r)
> -                       goto failure;
> +       r =3D mes_v12_1_set_hw_resources(&adev->mes,
> +                                      AMDGPU_MES_KIQ_PIPE, xcc_id);
> +       if (r)
> +               goto failure;
>
> -               mes_v12_1_set_hw_resources_1(&adev->mes,
> -                                              AMDGPU_MES_KIQ_PIPE, xcc_i=
d);
> -       }
> +       mes_v12_1_set_hw_resources_1(&adev->mes,
> +                                    AMDGPU_MES_KIQ_PIPE, xcc_id);
>
>         if (adev->mes.enable_legacy_queue_map) {
>                 r =3D mes_v12_1_xcc_hw_init(ip_block, xcc_id);
> @@ -1850,12 +1711,8 @@ static int mes_v12_1_kiq_hw_fini(struct amdgpu_dev=
ice *adev, uint32_t xcc_id)
>         int inst =3D MES_PIPE_INST(xcc_id, AMDGPU_MES_SCHED_PIPE);
>
>         if (adev->mes.ring[inst].sched.ready) {
> -               if (adev->enable_uni_mes)
> -                       amdgpu_mes_unmap_legacy_queue(adev,
> -                                     &adev->mes.ring[inst],
> -                                     RESET_QUEUES, 0, 0, xcc_id);
> -               else
> -                       mes_v12_1_kiq_dequeue_sched(adev, xcc_id);
> +               amdgpu_mes_unmap_legacy_queue(adev, &adev->mes.ring[inst]=
,
> +                                             RESET_QUEUES, 0, 0, xcc_id)=
;
>
>                 adev->mes.ring[inst].sched.ready =3D false;
>         }
> @@ -1916,26 +1773,6 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_=
block *ip_block, int xcc_id)
>         if (adev->mes.ring[MES_PIPE_INST(xcc_id, 0)].sched.ready)
>                 goto out;
>
> -       if (!adev->enable_mes_kiq) {
> -               if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT=
) {
> -                       r =3D mes_v12_1_load_microcode(adev,
> -                                      AMDGPU_MES_SCHED_PIPE, true, xcc_i=
d);
> -                       if (r) {
> -                               DRM_ERROR("failed to MES fw, r=3D%d\n", r=
);
> -                               return r;
> -                       }
> -
> -                       mes_v12_1_set_ucode_start_addr(adev, xcc_id);
> -
> -               } else if (adev->firmware.load_type =3D=3D
> -                          AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
> -
> -                       mes_v12_1_set_ucode_start_addr(adev, xcc_id);
> -               }
> -
> -               mes_v12_1_enable(adev, true, xcc_id);
> -       }
> -
>         /* Enable the MES to handle doorbell ring on unmapped queue */
>         mes_v12_1_enable_unmapped_doorbell_handling(&adev->mes, true, xcc=
_id);
>
> @@ -1948,10 +1785,7 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_=
block *ip_block, int xcc_id)
>         if (r)
>                 goto failure;
>
> -       if (adev->enable_uni_mes) {
> -               mes_v12_1_set_hw_resources_1(&adev->mes,
> -                                              AMDGPU_MES_SCHED_PIPE, xcc=
_id);
> -       }
> +       mes_v12_1_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE, x=
cc_id);
>         mes_v12_1_init_aggregated_doorbell(&adev->mes, xcc_id);
>
>         r =3D mes_v12_1_query_sched_status(&adev->mes,
> @@ -1963,12 +1797,6 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_=
block *ip_block, int xcc_id)
>
>         amdgpu_mes_validate_fw_version(adev);
>  out:
> -       /*
> -        * Disable KIQ ring usage from the driver once MES is enabled.
> -        * MES uses KIQ ring exclusively so driver cannot access KIQ ring
> -        * with MES enabled.
> -        */
> -       adev->gfx.kiq[xcc_id].ring.sched.ready =3D false;
>         adev->mes.ring[MES_PIPE_INST(xcc_id, 0)].sched.ready =3D true;
>
>         return 0;
> --
> 2.43.0
>
