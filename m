Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38297D3E2BC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A0510E533;
	Mon, 28 Oct 2024 19:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NciiMvS0";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 776EF10E533
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:41:44 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-71e52582d28so324407b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730144504; x=1730749304; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7r3lsSnnwMH7xat1iyMvDuL7zMeZ6YOA1v6SnVfHwTY=;
 b=NciiMvS0Is6mW7n24eNokp3wDovyV4SaywZW0TUMyEkga0JARP6SwtrRNXLpcQOVpe
 DY0ZHT3j7MoYX+O+j82cUsa/uz9wV3mfLYmaneZ9rZRgORjxTpIb96Pfa+R0bVbJKuEK
 8ZsEKJOd/vIx8Oanqt2FhrwkM5lZ1CV85FkaMOE7edbcRtnw24zoJ9qI5Az6Zx5bA6NI
 fJxAuU+0fvynhpVZvnvzJNpqk4jKNvIxl+nxOqL4lu6zXyE9lktt6PkYLs1kVANmSMfE
 r81cXZZQtirhbIeDgdBbgfQF5Y4Mv4DGmdJYpyMncpSxWwvYNePZycj30IDE1RKZuTCg
 +GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730144504; x=1730749304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7r3lsSnnwMH7xat1iyMvDuL7zMeZ6YOA1v6SnVfHwTY=;
 b=qO+Jg/Hq9nbwAWPhMMq/ov5iww52QL+USmlQmUGxcmb8xO1o0vmUSmOIXe2xBhUTvH
 i8bPMZMrA7PbW+4ZLmMtya32P4zNamrLd7UzTx8bHPXvLxvFGir06R1IpE4AEddsLtMc
 ohHVeN4axwIYOCyRKO9BvZSTDUcKGAG0N/Dw+EK/WjOQvpZDk7ftunCEsXnPmqO7R7Aa
 p45q7aNuPNd0S5eECCQzJpUySl3x37kXlDMrxVuzBPCiSCN5tXrnKm5leJEos+AAt7YM
 DNncdafDvXJ/xV8DGm0pr4XxJbkDg5e5ElJmztrkHOSMkNxF82ZP569OGOAghU8UoGIg
 3awg==
X-Gm-Message-State: AOJu0YwgUy+OPBmKTwRz9mddbUuwYt+iqXmaTiumwtEXpdDY6Qv3U4I+
 kQWIUaTDLUTyRClPKnnMsEyLPhWeNEVSOijRV+mPPH8KlRSc8rs7lPPzUBSfSN4MlmppC8XXiRC
 LSIyymzmylLjdj9Llt8v5ioOJjhHXSfqL
X-Google-Smtp-Source: AGHT+IFMhM/vMasHBUFNhVrILRamcNS27+W/0UkPztMVHRsPtx51fX+0lQx65/8ml4MeLrVhJvPybgUDOb3cjKPLkJ4=
X-Received: by 2002:a05:6a00:1ace:b0:71e:4842:55fe with SMTP id
 d2e1a72fcca58-720630065d6mr5863851b3a.4.1730144503796; Mon, 28 Oct 2024
 12:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-24-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-24-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:41:32 -0400
Message-ID: <CADnq5_NGww7GBTcZ8aPHWdbJ3eu97B5_Fj9y6NSemo_0Xgmoug@mail.gmail.com>
Subject: Re: [PATCH 23/29] drm/amdgpu: hw_init for each vcn instance
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Thu, Oct 24, 2024 at 10:58=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass instance parameter to amdgpu_vcn_hw_init(), and perform
> hw init ONLY for the given vcn instance, instead of for all
> vcn instances. Modify each vcn generation accordingly.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 39 +++++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 73 ++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 37 ++++++-------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 67 +++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 21 ++++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 21 ++++---
>  6 files changed, 123 insertions(+), 135 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index d135e63e7301..8ce3cea6cf44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -338,37 +338,36 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block =
*ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct amdgpu_ring *ring;
> -       int i, j, r =3D 0;
> +       int inst =3D ip_block->instance;
> +       int i, r =3D 0;
>
>         if (amdgpu_sriov_vf(adev))
>                 r =3D vcn_v2_5_sriov_start(adev);
>
> -       for (j =3D 0; j < adev->vcn.num_vcn_inst; ++j) {
> -               if (adev->vcn.harvest_config & (1 << j))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return r;
>
> -               if (amdgpu_sriov_vf(adev)) {
> -                       adev->vcn.inst[j].ring_enc[0].sched.ready =3D tru=
e;
> -                       adev->vcn.inst[j].ring_enc[1].sched.ready =3D fal=
se;
> -                       adev->vcn.inst[j].ring_enc[2].sched.ready =3D fal=
se;
> -                       adev->vcn.inst[j].ring_dec.sched.ready =3D true;
> -               } else {
> +       if (amdgpu_sriov_vf(adev)) {
> +               adev->vcn.inst[inst].ring_enc[0].sched.ready =3D true;
> +               adev->vcn.inst[inst].ring_enc[1].sched.ready =3D false;
> +               adev->vcn.inst[inst].ring_enc[2].sched.ready =3D false;
> +               adev->vcn.inst[inst].ring_dec.sched.ready =3D true;
> +       } else {
> +
> +               ring =3D &adev->vcn.inst[inst].ring_dec;
>
> -                       ring =3D &adev->vcn.inst[j].ring_dec;
> +               adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_door=
bell,
> +                                                ring->doorbell_index, in=
st);
>
> -                       adev->nbio.funcs->vcn_doorbell_range(adev, ring->=
use_doorbell,
> -                                                    ring->doorbell_index=
, j);
> +               r =3D amdgpu_ring_test_helper(ring);
> +               if (r)
> +                       return r;
>
> +               for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> +                       ring =3D &adev->vcn.inst[inst].ring_enc[i];
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
>                                 return r;
> -
> -                       for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> -                               ring =3D &adev->vcn.inst[j].ring_enc[i];
> -                               r =3D amdgpu_ring_test_helper(ring);
> -                               if (r)
> -                                       return r;
> -                       }
>                 }
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index d00b7a7cbdce..36100c2612d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -345,8 +345,9 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *i=
p_block)
>  static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         struct amdgpu_ring *ring;
> -       int i, j, r;
> +       int j, r;
>
>         if (amdgpu_sriov_vf(adev)) {
>                 r =3D vcn_v3_0_start_sriov(adev);
> @@ -354,57 +355,53 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>                         return r;
>
>                 /* initialize VCN dec and enc ring buffers */
> -               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -                       if (adev->vcn.harvest_config & (1 << i))
> -                               continue;
> +               if (adev->vcn.harvest_config & (1 << inst))
> +                       return 0;
> +
> +               ring =3D &adev->vcn.inst[inst].ring_dec;
> +               if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, ins=
t)) {
> +                       ring->sched.ready =3D false;
> +                       ring->no_scheduler =3D true;
> +                       dev_info(adev->dev, "ring %s is disabled by hyper=
visor\n", ring->name);
> +               } else {
> +                       ring->wptr =3D 0;
> +                       ring->wptr_old =3D 0;
> +                       vcn_v3_0_dec_ring_set_wptr(ring);
> +                       ring->sched.ready =3D true;
> +               }
>
> -                       ring =3D &adev->vcn.inst[i].ring_dec;
> -                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_R=
ING, i)) {
> +               for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
> +                       ring =3D &adev->vcn.inst[inst].ring_enc[j];
> +                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_R=
ING, inst)) {
>                                 ring->sched.ready =3D false;
>                                 ring->no_scheduler =3D true;
>                                 dev_info(adev->dev, "ring %s is disabled =
by hypervisor\n", ring->name);
>                         } else {
>                                 ring->wptr =3D 0;
>                                 ring->wptr_old =3D 0;
> -                               vcn_v3_0_dec_ring_set_wptr(ring);
> +                               vcn_v3_0_enc_ring_set_wptr(ring);
>                                 ring->sched.ready =3D true;
>                         }
> -
> -                       for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
> -                               ring =3D &adev->vcn.inst[i].ring_enc[j];
> -                               if (amdgpu_vcn_is_disabled_vcn(adev, VCN_=
ENCODE_RING, i)) {
> -                                       ring->sched.ready =3D false;
> -                                       ring->no_scheduler =3D true;
> -                                       dev_info(adev->dev, "ring %s is d=
isabled by hypervisor\n", ring->name);
> -                               } else {
> -                                       ring->wptr =3D 0;
> -                                       ring->wptr_old =3D 0;
> -                                       vcn_v3_0_enc_ring_set_wptr(ring);
> -                                       ring->sched.ready =3D true;
> -                               }
> -                       }
>                 }
> -       } else {
> -               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -                       if (adev->vcn.harvest_config & (1 << i))
> -                               continue;
> +       }
>
> -                       ring =3D &adev->vcn.inst[i].ring_dec;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -                       adev->nbio.funcs->vcn_doorbell_range(adev, ring->=
use_doorbell,
> -                                                    ring->doorbell_index=
, i);
> +       ring =3D &adev->vcn.inst[inst].ring_dec;
>
> -                       r =3D amdgpu_ring_test_helper(ring);
> -                       if (r)
> -                               return r;
> +       adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +                                        ring->doorbell_index, inst);
>
> -                       for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
> -                               ring =3D &adev->vcn.inst[i].ring_enc[j];
> -                               r =3D amdgpu_ring_test_helper(ring);
> -                               if (r)
> -                                       return r;
> -                       }
> -               }
> +       r =3D amdgpu_ring_test_helper(ring);
> +       if (r)
> +               return r;
> +
> +       for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
> +               ring =3D &adev->vcn.inst[inst].ring_enc[j];
> +               r =3D amdgpu_ring_test_helper(ring);
> +               if (r)
> +                       return r;
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 7c3a62f84707..00ff7affc647 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -299,37 +299,34 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct amdgpu_ring *ring;
> -       int i, r;
> +       int inst =3D ip_block->instance;
> +       int r;
>
>         if (amdgpu_sriov_vf(adev)) {
>                 r =3D vcn_v4_0_start_sriov(adev);
>                 if (r)
>                         return r;
>
> -               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -                       if (adev->vcn.harvest_config & (1 << i))
> -                               continue;
> +               if (adev->vcn.harvest_config & (1 << inst))
> +                       return 0;
>
> -                       ring =3D &adev->vcn.inst[i].ring_enc[0];
> -                       ring->wptr =3D 0;
> -                       ring->wptr_old =3D 0;
> -                       vcn_v4_0_unified_ring_set_wptr(ring);
> -                       ring->sched.ready =3D true;
> -               }
> +               ring =3D &adev->vcn.inst[inst].ring_enc[0];
> +               ring->wptr =3D 0;
> +               ring->wptr_old =3D 0;
> +               vcn_v4_0_unified_ring_set_wptr(ring);
> +               ring->sched.ready =3D true;
>         } else {
> -               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -                       if (adev->vcn.harvest_config & (1 << i))
> -                               continue;
> +               if (adev->vcn.harvest_config & (1 << inst))
> +                       return 0;
>
> -                       ring =3D &adev->vcn.inst[i].ring_enc[0];
> +               ring =3D &adev->vcn.inst[inst].ring_enc[0];
>
> -                       adev->nbio.funcs->vcn_doorbell_range(adev, ring->=
use_doorbell,
> -                                       ((adev->doorbell_index.vcn.vcn_ri=
ng0_1 << 1) + 8 * i), i);
> +               adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_door=
bell,
> +                               ((adev->doorbell_index.vcn.vcn_ring0_1 <<=
 1) + 8 * inst), inst);
>
> -                       r =3D amdgpu_ring_test_helper(ring);
> -                       if (r)
> -                               return r;
> -               }
> +               r =3D amdgpu_ring_test_helper(ring);
> +               if (r)
> +                       return r;
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 5a3de3dbc3c9..feb373a96cfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -257,49 +257,46 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct amdgpu_ring *ring;
> -       int i, r, vcn_inst;
> +       int inst =3D ip_block->instance;
> +       int r =3D 0, vcn_inst;
>
>         if (amdgpu_sriov_vf(adev)) {
>                 r =3D vcn_v4_0_3_start_sriov(adev);
>                 if (r)
>                         return r;
>
> -               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -                       ring =3D &adev->vcn.inst[i].ring_enc[0];
> -                       ring->wptr =3D 0;
> -                       ring->wptr_old =3D 0;
> -                       vcn_v4_0_3_unified_ring_set_wptr(ring);
> -                       ring->sched.ready =3D true;
> -               }
> +               ring =3D &adev->vcn.inst[inst].ring_enc[0];
> +               ring->wptr =3D 0;
> +               ring->wptr_old =3D 0;
> +               vcn_v4_0_3_unified_ring_set_wptr(ring);
> +               ring->sched.ready =3D true;
>         } else {
> -               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -                       vcn_inst =3D GET_INST(VCN, i);
> -                       ring =3D &adev->vcn.inst[i].ring_enc[0];
> -
> -                       if (ring->use_doorbell) {
> -                               adev->nbio.funcs->vcn_doorbell_range(
> -                                       adev, ring->use_doorbell,
> -                                       (adev->doorbell_index.vcn.vcn_rin=
g0_1 << 1) +
> -                                               9 * vcn_inst,
> -                                       adev->vcn.inst[i].aid_id);
> -
> -                               WREG32_SOC15(
> -                                       VCN, GET_INST(VCN, ring->me),
> -                                       regVCN_RB1_DB_CTRL,
> -                                       ring->doorbell_index
> -                                                       << VCN_RB1_DB_CTR=
L__OFFSET__SHIFT |
> -                                               VCN_RB1_DB_CTRL__EN_MASK)=
;
> -
> -                               /* Read DB_CTRL to flush the write DB_CTR=
L command. */
> -                               RREG32_SOC15(
> -                                       VCN, GET_INST(VCN, ring->me),
> -                                       regVCN_RB1_DB_CTRL);
> -                       }
> -
> -                       r =3D amdgpu_ring_test_helper(ring);
> -                       if (r)
> -                               return r;
> +               vcn_inst =3D GET_INST(VCN, inst);
> +               ring =3D &adev->vcn.inst[inst].ring_enc[0];
> +
> +               if (ring->use_doorbell) {
> +                       adev->nbio.funcs->vcn_doorbell_range(
> +                               adev, ring->use_doorbell,
> +                               (adev->doorbell_index.vcn.vcn_ring0_1 << =
1) +
> +                                       9 * vcn_inst,
> +                               adev->vcn.inst[inst].aid_id);
> +
> +                       WREG32_SOC15(
> +                               VCN, GET_INST(VCN, ring->me),
> +                               regVCN_RB1_DB_CTRL,
> +                               ring->doorbell_index
> +                                               << VCN_RB1_DB_CTRL__OFFSE=
T__SHIFT |
> +                                       VCN_RB1_DB_CTRL__EN_MASK);
> +
> +                       /* Read DB_CTRL to flush the write DB_CTRL comman=
d. */
> +                       RREG32_SOC15(
> +                               VCN, GET_INST(VCN, ring->me),
> +                               regVCN_RB1_DB_CTRL);
>                 }
> +
> +               r =3D amdgpu_ring_test_helper(ring);
> +               if (r)
> +                       return r;
>         }
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index 2c9f863c40b1..fb1e1d5bcdbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -268,21 +268,20 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct amdgpu_ring *ring;
> -       int i, r;
> +       int inst =3D ip_block->instance;
> +       int r;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               ring =3D &adev->vcn.inst[i].ring_enc[0];
> +       ring =3D &adev->vcn.inst[inst].ring_enc[0];
>
> -               adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_door=
bell,
> -                               ((adev->doorbell_index.vcn.vcn_ring0_1 <<=
 1) + 8 * i), i);
> +       adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +                       ((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 =
* inst), inst);
>
> -               r =3D amdgpu_ring_test_helper(ring);
> -               if (r)
> -                       return r;
> -       }
> +       r =3D amdgpu_ring_test_helper(ring);
> +       if (r)
> +               return r;
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 9d67e884952a..137c3b452433 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -232,21 +232,20 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct amdgpu_ring *ring;
> -       int i, r;
> +       int inst =3D ip_block->instance;
> +       int r;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               ring =3D &adev->vcn.inst[i].ring_enc[0];
> +       ring =3D &adev->vcn.inst[inst].ring_enc[0];
>
> -               adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_door=
bell,
> -                       ((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 =
* i), i);
> +       adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +               ((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst),=
 inst);
>
> -               r =3D amdgpu_ring_test_helper(ring);
> -               if (r)
> -                       return r;
> -       }
> +       r =3D amdgpu_ring_test_helper(ring);
> +       if (r)
> +               return r;
>
>         return 0;
>  }
> --
> 2.34.1
>
