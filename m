Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5648C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 13:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF9811AA3E;
	Fri, 22 Jul 2022 13:16:52 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2FD811B4F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 13:16:48 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id z23so8467018eju.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 06:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3SqpgEw+Yj0r00IOTZmaF80bpVxXIHtBXVj99Gwozns=;
 b=euTtFcTvmpUXyUPY5v/NL0HQIJRIq1cgGQpF1aWSX9WH6cfn9nDHxxI7FnEkHqVn7v
 Pfrxs3/s1YjUTBSnZIeAKKYQfUYI/JkLSN3TS+Zoag3DpWNvF3KcvTZ/wo0o9K6aoR+t
 FD7TKk9GBom4UlUXmJyvqnW8ACAB4tKlP5wB0gtyGVrL75+3aZh2cojyZsnbCTvV7MDF
 58uGsNWpareWlUwBWYs8TY8GcvwnhCyhARpekkhfpFeYDZOMn/vdXpwpcJgN69s1yZ/t
 gjjn7jdOFp9nXdPQ3EJUvZEy41WFTupDlyHTrjpF6aHNmBymIsQeKHND63yGjX5goQSA
 RNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3SqpgEw+Yj0r00IOTZmaF80bpVxXIHtBXVj99Gwozns=;
 b=6lf2/5jQ5JMTwXz01/gGaFNyxLskRlEqmJm1b2D0G2tDGIcA2hIzNwhAWSzbIn2nUy
 rI57ljuCv6Q/zoNYQor9nzpQp7ux+uz/J2CUzeWIfNd00oBW4A5yJu09CQ+UXIDwYr19
 XJP9WBWw8QEOhi4WFIMWeCjUxxxmMWBh1T6ghOqhPUPJOlUjN4Cx8w8s74JqT60ZSCsw
 MwTsp2Pwv3BJKHFi+3K+JOu/QIuYbeylBOvgdXhW4xSK1jQS8/PZz/NXe0rhlSg1J8tB
 0kgUTfD9LptwmLxM24I6HEfzUKP+FaUEejSG8bulsZ7adrmkceuD5rJ9CNDCfmlbyff0
 VjYA==
X-Gm-Message-State: AJIora+gOiHktda/+ldDMTm//o0RUv4HJJ+XOsGwjrxiui1BIFUefket
 j05fVIyMESPgKEnc7RE2AP0UbKObiIa64z6XHcCOyRCXAO8=
X-Google-Smtp-Source: AGRyM1txrlPHo7BurhwxWsOE9RoFKVCkZ/k8sCqhS+/A2boKZhESfyLfUB7qNBJGZgVlsnwkbG9TVfjGUzqE+4dDOzA=
X-Received: by 2002:a17:907:a427:b0:72b:8cc5:5487 with SMTP id
 sg39-20020a170907a42700b0072b8cc55487mr462889ejc.354.1658495807183; Fri, 22
 Jul 2022 06:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220721095210.37519-1-horace.chen@amd.com>
 <20220721095210.37519-2-horace.chen@amd.com>
In-Reply-To: <20220721095210.37519-2-horace.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Jul 2022 09:16:35 -0400
Message-ID: <CADnq5_M5NU1Vp_Pqs_Lvn7Gf6445QrwXmfa1V-uWWiSNC1Q-bg@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amdgpu: add sriov nbio callback structure
To: Horace Chen <horace.chen@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 21, 2022 at 5:52 AM Horace Chen <horace.chen@amd.com> wrote:
>
> [Why]
> under SR-IOV, the nbio doorbell range will be defined by PF. So VF
> nbio doorbell range registers will be blocked. It will cause violation
> if VF access those registers directly.
>
> [How]
> create an nbio_v4_3_sriov_funcs for sriov nbio_v4_3 initialization to
> skip the setting for the doorbell range registers.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c        | 44 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h        |  1 +
>  3 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 242d1847c4aa..f559fda2811f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2232,7 +2232,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>                 break;
>         case IP_VERSION(4, 3, 0):
>         case IP_VERSION(4, 3, 1):
> -               adev->nbio.funcs = &nbio_v4_3_funcs;
> +               if (amdgpu_sriov_vf(adev))
> +                       adev->nbio.funcs = &nbio_v4_3_sriov_funcs;
> +               else
> +                       adev->nbio.funcs = &nbio_v4_3_funcs;
>                 adev->nbio.hdp_flush_reg = &nbio_v4_3_hdp_flush_reg;
>                 break;
>         case IP_VERSION(7, 7, 0):
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> index 982a89f841d5..15eb3658d70e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> @@ -488,3 +488,47 @@ const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
>         .get_rom_offset = nbio_v4_3_get_rom_offset,
>         .program_aspm = nbio_v4_3_program_aspm,
>  };
> +
> +
> +static void nbio_v4_3_sriov_ih_doorbell_range(struct amdgpu_device *adev,
> +                                       bool use_doorbell, int doorbell_index)
> +{
> +}
> +
> +static void nbio_v4_3_sriov_sdma_doorbell_range(struct amdgpu_device *adev, int instance,
> +                                         bool use_doorbell, int doorbell_index,
> +                                         int doorbell_size)
> +{
> +}
> +
> +static void nbio_v4_3_sriov_vcn_doorbell_range(struct amdgpu_device *adev, bool use_doorbell,
> +                                        int doorbell_index, int instance)
> +{
> +}
> +
> +static void nbio_v4_3_sriov_gc_doorbell_init(struct amdgpu_device *adev)
> +{
> +}
> +
> +const struct amdgpu_nbio_funcs nbio_v4_3_sriov_funcs = {
> +       .get_hdp_flush_req_offset = nbio_v4_3_get_hdp_flush_req_offset,
> +       .get_hdp_flush_done_offset = nbio_v4_3_get_hdp_flush_done_offset,
> +       .get_pcie_index_offset = nbio_v4_3_get_pcie_index_offset,
> +       .get_pcie_data_offset = nbio_v4_3_get_pcie_data_offset,
> +       .get_rev_id = nbio_v4_3_get_rev_id,
> +       .mc_access_enable = nbio_v4_3_mc_access_enable,
> +       .get_memsize = nbio_v4_3_get_memsize,
> +       .sdma_doorbell_range = nbio_v4_3_sriov_sdma_doorbell_range,
> +       .vcn_doorbell_range = nbio_v4_3_sriov_vcn_doorbell_range,
> +       .gc_doorbell_init = nbio_v4_3_sriov_gc_doorbell_init,
> +       .enable_doorbell_aperture = nbio_v4_3_enable_doorbell_aperture,
> +       .enable_doorbell_selfring_aperture = nbio_v4_3_enable_doorbell_selfring_aperture,
> +       .ih_doorbell_range = nbio_v4_3_sriov_ih_doorbell_range,
> +       .update_medium_grain_clock_gating = nbio_v4_3_update_medium_grain_clock_gating,
> +       .update_medium_grain_light_sleep = nbio_v4_3_update_medium_grain_light_sleep,
> +       .get_clockgating_state = nbio_v4_3_get_clockgating_state,
> +       .ih_control = nbio_v4_3_ih_control,
> +       .init_registers = nbio_v4_3_init_registers,
> +       .remap_hdp_registers = nbio_v4_3_remap_hdp_registers,
> +       .get_rom_offset = nbio_v4_3_get_rom_offset,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
> index ade43661d7a9..711999ceedf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
> @@ -28,5 +28,6 @@
>
>  extern const struct nbio_hdp_flush_reg nbio_v4_3_hdp_flush_reg;
>  extern const struct amdgpu_nbio_funcs nbio_v4_3_funcs;
> +extern const struct amdgpu_nbio_funcs nbio_v4_3_sriov_funcs;
>
>  #endif
> --
> 2.25.1
>
