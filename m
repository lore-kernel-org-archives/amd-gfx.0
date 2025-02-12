Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69E5C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 19:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6265010E975;
	Wed, 12 Feb 2025 19:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fqp7GZ4M";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9E010E975
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 19:46:33 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2fa200c3d16so33836a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 11:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739389593; x=1739994393; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Ge7AL52B9nbp5y+Fb8tSJOBMZU/xTaCXGWmxmrAHBs=;
 b=fqp7GZ4MthUbdZ2EhVwKEqfZ80XtnuDHURZiWk69g8HzJXbWzqZWxAyF+GLTmqVg2E
 v5XxgN9YkFlvQjAyAKwJWosNE2SUU2KNEG9PDbPn8RDPEWOyJE3e+muSuUExZG5ZE7O5
 1vpM8NUsV8fHtuqqUyMnVGLnsj6KUfa6n+uLpEfDfyGW7cgbOOlqR0n6KjM8lNVYJU2Y
 1g+DOSeZzV90Jl14j451DHxfncC3uzz9gb0gHX7insYdUmD3aVfTYg+V/SXo45gzV9cm
 SS6k7VwL6espQ5eviosfIdLXWTE7uZWgDyvjiijDM26gqGYV3qmUoEQBMUstBj8h4fBz
 q4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739389593; x=1739994393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Ge7AL52B9nbp5y+Fb8tSJOBMZU/xTaCXGWmxmrAHBs=;
 b=ALnCeVQ0+vSmvcPHEjQBOhAcBQJyUR/7jdnsZ/uR2UYYxuUgRL473kZlD557Y/IHJB
 FZSmtR55AWG7Xa7lpGKyWG7PPZLull9/oTdf8LHHB6qt1mBjYO9G6IX7BdwrMUVTHeA2
 MHWp/5cqci8ALPBiWgY2VllAb9R557L3ZbXae61soCPhvct5+i/G6xjxA+Go2/bXkk0d
 vOfLpFavt79aYLV4eTe1oGfgrtFfxjezPObdLloG4nxfgnlaiuvVoODt0Z9QJVlnSU86
 WKdloPTX8Tj1tdVIqyDMju6t0rX/uLH2k/1Z43tqZx7O4YIOC8WvcXUfAczl1LlLB90t
 8LKA==
X-Gm-Message-State: AOJu0YxsCy5DT1l+oyb5TJcW+Qlw/sa+KiH8ADfaIYDbuvtSi/2Swd++
 /AYAJyYhBc7aHrZcbHGXwr5bOuTnZGMYL6Z8eyjgNOzFf1C82dkaLkgMyxB6fusfpAw0n3azex8
 938J6LWa4yjV7L+jA6qGJ1n1f2zs=
X-Gm-Gg: ASbGnctpIC+fVfFPOKgQn5ZOH1aw/7HEpfg6wQLLLWnKIbikVFRQoAEB7TPd4jN+P0B
 Nf4kF+M2m978C6p6ruspz+2u4UR9WY6/2lDGXpoH6qg2lNv++bKnREUeazm1qFEMiSxP6c5tN
X-Google-Smtp-Source: AGHT+IEpf4eI4amviaFDfVUhWffrOfYk93ssZmqiqjCcDw6o/g0YJY0ZfZBCywaUzE9ZQhz8813WQQt/EYP5xtoWESY=
X-Received: by 2002:a17:90b:1b07:b0:2ef:c419:6930 with SMTP id
 98e67ed59e1d1-2fbf5c668d2mr2592332a91.6.1739389592904; Wed, 12 Feb 2025
 11:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20250211051454.2811943-1-jesse.zhang@amd.com>
 <20250211051454.2811943-2-jesse.zhang@amd.com>
In-Reply-To: <20250211051454.2811943-2-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Feb 2025 14:46:21 -0500
X-Gm-Features: AWEUYZnqLNlLfHPV8Uq0Qua0KLqA2mA90PUL6_TK4seHmEms3pJSAwiPTg1JS7c
Message-ID: <CADnq5_MgDU7SQ9N2yKavN9QqTmB-o0efcRn4E8h1FPc5NBiBcw@mail.gmail.com>
Subject: Re: [PATCH 2/4 v6] drm/amdgpu/sdma: Refactor SDMA reset functionality
 and add callback support
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 felix.kuehling@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>
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

On Tue, Feb 11, 2025 at 12:22=E2=80=AFAM Jesse.zhang@amd.com
<jesse.zhang@amd.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch refactors the SDMA reset functionality in the `sdma_v4_4_2` dr=
iver
> to improve modularity and support shared usage between AMDGPU and KFD. Th=
e
> changes include:
>
> 1. **Refactored SDMA Reset Logic**:
>    - Split the `sdma_v4_4_2_reset_queue` function into two separate funct=
ions:
>      - `sdma_v4_4_2_stop_queue`: Stops the SDMA queue before reset.
>      - `sdma_v4_4_2_restore_queue`: Restores the SDMA queue after reset.
>    - These functions are now used as callbacks for the shared reset mecha=
nism.
>
> 2. **Added Callback Support**:
>    - Introduced a new structure `sdma_v4_4_2_reset_funcs` to hold the sto=
p and
>      restore callbacks.
>    - Added `sdma_v4_4_2_set_reset_funcs` to register these callbacks with=
 the
>      shared reset mechanism using `amdgpu_set_on_reset_callbacks`.
>
> 3. **Fixed Reset Queue Function**:
>    - Modified `sdma_v4_4_2_reset_queue` to use the shared `amdgpu_sdma_re=
set_queue`
>      function, ensuring consistency across the driver.
>
> This patch ensures that SDMA reset functionality is more modular, reusabl=
e, and
> aligned with the shared reset mechanism between AMDGPU and KFD.

A few minot nits below, otherwise looks good.

>
> Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 32 +++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index 64c163dd708f..3e60456b0db0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -105,6 +105,7 @@ static void sdma_v4_4_2_set_buffer_funcs(struct amdgp=
u_device *adev);
>  static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
> +static void sdma_v4_4_2_set_reset_funcs(struct amdgpu_device *adev);
>
>  static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
>                 u32 instance, u32 offset)
> @@ -1330,6 +1331,7 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_=
block *ip_block)
>         sdma_v4_4_2_set_vm_pte_funcs(adev);
>         sdma_v4_4_2_set_irq_funcs(adev);
>         sdma_v4_4_2_set_ras_funcs(adev);
> +       sdma_v4_4_2_set_reset_funcs(adev);
>
>         return 0;
>  }
> @@ -1605,8 +1607,14 @@ static int sdma_v4_4_2_soft_reset(struct amdgpu_ip=
_block *ip_block)
>  static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned in=
t vmid)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       int i, r;
> +       u32 id =3D GET_INST(SDMA0, ring->me);
> +       return amdgpu_sdma_reset_instance(adev, id);
> +}
> +
> +static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t i=
nstance_id)
> +{
>         u32 inst_mask;
> +       struct amdgpu_ring *ring =3D &adev->sdma.instance[instance_id].ri=
ng;
>
>         if (amdgpu_sriov_vf(adev))
>                 return -EINVAL;
> @@ -1617,10 +1625,16 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_=
ring *ring, unsigned int vmid)
>         if (adev->sdma.has_page_queue)
>                 sdma_v4_4_2_inst_page_stop(adev, inst_mask);
>
> -       r =3D amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, ring->me))=
;
> -       if (r)
> -               return r;
> +       return 0;
> +}
>
> +static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_=
t instance_id)
> +{
> +       int i;
> +       u32 inst_mask;
> +       struct amdgpu_ring *ring =3D &adev->sdma.instance[instance_id].ri=
ng;
> +
> +       inst_mask =3D 1 << ring->me;
>         udelay(50);
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> @@ -1638,6 +1652,16 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_r=
ing *ring, unsigned int vmid)
>         return sdma_v4_4_2_inst_start(adev, inst_mask, true);
>  }
>
> +static struct sdma_on_reset_funcs sdma_v4_4_2_reset_funcs =3D {

sdma_v4_4_2_engine_reset_funcs

> +       .pre_reset =3D sdma_v4_4_2_stop_queue,
> +       .post_reset =3D sdma_v4_4_2_restore_queue,
> +};
> +
> +static void sdma_v4_4_2_set_reset_funcs(struct amdgpu_device *adev)

sdma_v4_4_2_set_engine_reset_funcs()


> +{
> +       amdgpu_sdma_register_on_reset_callbacks(adev, &sdma_v4_4_2_reset_=
funcs);
> +}
> +
>  static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
>                                         struct amdgpu_irq_src *source,
>                                         unsigned type,
> --
> 2.25.1
>
