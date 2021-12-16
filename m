Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6921EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 15:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED58010EB81;
	Thu, 16 Dec 2021 15:19:02 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90DE710EB81
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 15:19:01 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 w5-20020a4a2745000000b002c2649b8d5fso6985282oow.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 07:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6abPszCjg/zDg59OfK5MEZ4xu5LLqV/IabtGnJBTqPs=;
 b=FYOoxaGlMBbnz4gke0YBMAZ4NiQvj800H9aZNDmpob0kLJ2MqJ+pYEDsU4FG/awR7n
 gzS49abb81pcMpRjJwCJQr6a0jk0ZmpIqTYJBF5ec6M1nWUiByvhVt8++z0+5NLExI9O
 vj+1gprrEAi/7vAB6hZver2QRSfd6H8RV4PLRMj9SeNJTwXYAa8g4i77oAUK7ue5vU1u
 XES4FIWcOSPfoh5xJzzFIdTtKmwQZLf0vTrvGTFjNL5RHvCIoTSZYJIZnq+KxD0Wsved
 yNwqC/WozavE4zRzjVKGG6yNF9zC9Z0pzVI+q082uRt2f8WEWdM5c090demt+xOUlsev
 IUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6abPszCjg/zDg59OfK5MEZ4xu5LLqV/IabtGnJBTqPs=;
 b=POvjBlCcUzwhhomYX5tpKw4ZG+TeemApCv8In7/+Xn6ZTeXuNqdohaHSFPHg4+Xe/f
 wC9UYbffdY/snxlDkdRCrZvS6Y5KdShxDSeav+h+a+aBxLZ5b2lWUN9YUryxTMyZeIhU
 cBzYvqJKKqMN+iYkJw2apaZx1wQNwAyaFHmvvVm5yb1ab+vlc7BGUbo+3JYvzYxMi4hx
 PQ2BxPihWzEaHBL/UoTkRKZL4qCYCH7B4LCuzIs4BiUbpSMG1eszZ22FEtNcokSlted+
 F8+zUmgWICasu/SOKI0+MLOMVygMjz0Fsw5ycq8+kqcQFU7rAgKNhqCgX7imYGDPklMW
 c3Bg==
X-Gm-Message-State: AOAM532wSQInCVXIsQLFM16Z9FVymIqe2stsf8F4MxYfTj94QcBibUnV
 DSyg5IaLfvwYA02QTSiNS2Dkvv+Jx4cbZ8GXXAw=
X-Google-Smtp-Source: ABdhPJxz3p4gHDMo8cEcpn2QBypTgv497S7oKMQ/xWRfDKwxYG4/WLDGA5dbtaxz4UEV3arGYs31c5nzfFVcT5BGT28=
X-Received: by 2002:a4a:9568:: with SMTP id n37mr11160049ooi.73.1639667940721; 
 Thu, 16 Dec 2021 07:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20211216031758.177296-1-alexander.deucher@amd.com>
In-Reply-To: <20211216031758.177296-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Dec 2021 10:18:45 -0500
Message-ID: <CADnq5_PEP6r1AMEb36NbnzqXJCpR+arwYJnEBHohrqA=FjN7Rg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add support for IP discovery gc_info table v2
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Wed, Dec 15, 2021 at 10:18 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Used on gfx9 based systems. Fixes incorrect CU counts reported
> in the kernel log.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1833
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 76 +++++++++++++------
>  drivers/gpu/drm/amd/include/discovery.h       | 49 ++++++++++++
>  2 files changed, 103 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index ea00090b3fb3..bcc9343353b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -526,10 +526,15 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>         }
>  }
>
> +union gc_info {
> +       struct gc_info_v1_0 v1;
> +       struct gc_info_v2_0 v2;
> +};
> +
>  int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
>  {
>         struct binary_header *bhdr;
> -       struct gc_info_v1_0 *gc_info;
> +       union gc_info *gc_info;
>
>         if (!adev->mman.discovery_bin) {
>                 DRM_ERROR("ip discovery uninitialized\n");
> @@ -537,28 +542,55 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
>         }
>
>         bhdr = (struct binary_header *)adev->mman.discovery_bin;
> -       gc_info = (struct gc_info_v1_0 *)(adev->mman.discovery_bin +
> +       gc_info = (union gc_info *)(adev->mman.discovery_bin +
>                         le16_to_cpu(bhdr->table_list[GC].offset));
> -
> -       adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->gc_num_se);
> -       adev->gfx.config.max_cu_per_sh = 2 * (le32_to_cpu(gc_info->gc_num_wgp0_per_sa) +
> -                                             le32_to_cpu(gc_info->gc_num_wgp1_per_sa));
> -       adev->gfx.config.max_sh_per_se = le32_to_cpu(gc_info->gc_num_sa_per_se);
> -       adev->gfx.config.max_backends_per_se = le32_to_cpu(gc_info->gc_num_rb_per_se);
> -       adev->gfx.config.max_texture_channel_caches = le32_to_cpu(gc_info->gc_num_gl2c);
> -       adev->gfx.config.max_gprs = le32_to_cpu(gc_info->gc_num_gprs);
> -       adev->gfx.config.max_gs_threads = le32_to_cpu(gc_info->gc_num_max_gs_thds);
> -       adev->gfx.config.gs_vgt_table_depth = le32_to_cpu(gc_info->gc_gs_table_depth);
> -       adev->gfx.config.gs_prim_buffer_depth = le32_to_cpu(gc_info->gc_gsprim_buff_depth);
> -       adev->gfx.config.double_offchip_lds_buf = le32_to_cpu(gc_info->gc_double_offchip_lds_buffer);
> -       adev->gfx.cu_info.wave_front_size = le32_to_cpu(gc_info->gc_wave_size);
> -       adev->gfx.cu_info.max_waves_per_simd = le32_to_cpu(gc_info->gc_max_waves_per_simd);
> -       adev->gfx.cu_info.max_scratch_slots_per_cu = le32_to_cpu(gc_info->gc_max_scratch_slots_per_cu);
> -       adev->gfx.cu_info.lds_size = le32_to_cpu(gc_info->gc_lds_size);
> -       adev->gfx.config.num_sc_per_sh = le32_to_cpu(gc_info->gc_num_sc_per_se) /
> -                                        le32_to_cpu(gc_info->gc_num_sa_per_se);
> -       adev->gfx.config.num_packer_per_sc = le32_to_cpu(gc_info->gc_num_packer_per_sc);
> -
> +       switch (gc_info->v1.header.version_major) {
> +       case 1:
> +               adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->v1.gc_num_se);
> +               adev->gfx.config.max_cu_per_sh = 2 * (le32_to_cpu(gc_info->v1.gc_num_wgp0_per_sa) +
> +                                                     le32_to_cpu(gc_info->v1.gc_num_wgp1_per_sa));
> +               adev->gfx.config.max_sh_per_se = le32_to_cpu(gc_info->v1.gc_num_sa_per_se);
> +               adev->gfx.config.max_backends_per_se = le32_to_cpu(gc_info->v1.gc_num_rb_per_se);
> +               adev->gfx.config.max_texture_channel_caches = le32_to_cpu(gc_info->v1.gc_num_gl2c);
> +               adev->gfx.config.max_gprs = le32_to_cpu(gc_info->v1.gc_num_gprs);
> +               adev->gfx.config.max_gs_threads = le32_to_cpu(gc_info->v1.gc_num_max_gs_thds);
> +               adev->gfx.config.gs_vgt_table_depth = le32_to_cpu(gc_info->v1.gc_gs_table_depth);
> +               adev->gfx.config.gs_prim_buffer_depth = le32_to_cpu(gc_info->v1.gc_gsprim_buff_depth);
> +               adev->gfx.config.double_offchip_lds_buf = le32_to_cpu(gc_info->v1.gc_double_offchip_lds_buffer);
> +               adev->gfx.cu_info.wave_front_size = le32_to_cpu(gc_info->v1.gc_wave_size);
> +               adev->gfx.cu_info.max_waves_per_simd = le32_to_cpu(gc_info->v1.gc_max_waves_per_simd);
> +               adev->gfx.cu_info.max_scratch_slots_per_cu = le32_to_cpu(gc_info->v1.gc_max_scratch_slots_per_cu);
> +               adev->gfx.cu_info.lds_size = le32_to_cpu(gc_info->v1.gc_lds_size);
> +               adev->gfx.config.num_sc_per_sh = le32_to_cpu(gc_info->v1.gc_num_sc_per_se) /
> +                       le32_to_cpu(gc_info->v1.gc_num_sa_per_se);
> +               adev->gfx.config.num_packer_per_sc = le32_to_cpu(gc_info->v1.gc_num_packer_per_sc);
> +               break;
> +       case 2:
> +               adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->v2.gc_num_se);
> +               adev->gfx.config.max_cu_per_sh = le32_to_cpu(gc_info->v2.gc_num_cu_per_sh);
> +               adev->gfx.config.max_sh_per_se = le32_to_cpu(gc_info->v2.gc_num_sh_per_se);
> +               adev->gfx.config.max_backends_per_se = le32_to_cpu(gc_info->v2.gc_num_rb_per_se);
> +               adev->gfx.config.max_texture_channel_caches = le32_to_cpu(gc_info->v2.gc_num_tccs);
> +               adev->gfx.config.max_gprs = le32_to_cpu(gc_info->v2.gc_num_gprs);
> +               adev->gfx.config.max_gs_threads = le32_to_cpu(gc_info->v2.gc_num_max_gs_thds);
> +               adev->gfx.config.gs_vgt_table_depth = le32_to_cpu(gc_info->v2.gc_gs_table_depth);
> +               adev->gfx.config.gs_prim_buffer_depth = le32_to_cpu(gc_info->v2.gc_gsprim_buff_depth);
> +               adev->gfx.config.double_offchip_lds_buf = le32_to_cpu(gc_info->v2.gc_double_offchip_lds_buffer);
> +               adev->gfx.cu_info.wave_front_size = le32_to_cpu(gc_info->v2.gc_wave_size);
> +               adev->gfx.cu_info.max_waves_per_simd = le32_to_cpu(gc_info->v2.gc_max_waves_per_simd);
> +               adev->gfx.cu_info.max_scratch_slots_per_cu = le32_to_cpu(gc_info->v2.gc_max_scratch_slots_per_cu);
> +               adev->gfx.cu_info.lds_size = le32_to_cpu(gc_info->v2.gc_lds_size);
> +               adev->gfx.config.num_sc_per_sh = le32_to_cpu(gc_info->v2.gc_num_sc_per_se) /
> +                       le32_to_cpu(gc_info->v2.gc_num_sh_per_se);
> +               adev->gfx.config.num_packer_per_sc = le32_to_cpu(gc_info->v2.gc_num_packer_per_sc);
> +               break;
> +       default:
> +               dev_err(adev->dev,
> +                       "Unhandled GC info table %d.%d\n",
> +                       gc_info->v1.header.version_major,
> +                       gc_info->v1.header.version_minor);
> +               return -EINVAL;
> +       }
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
> index 7ec4331e67f2..a486769b66c6 100644
> --- a/drivers/gpu/drm/amd/include/discovery.h
> +++ b/drivers/gpu/drm/amd/include/discovery.h
> @@ -143,6 +143,55 @@ struct gc_info_v1_0 {
>         uint32_t gc_num_gl2a;
>  };
>
> +struct gc_info_v1_1 {
> +       struct gpu_info_header header;
> +
> +       uint32_t gc_num_se;
> +       uint32_t gc_num_wgp0_per_sa;
> +       uint32_t gc_num_wgp1_per_sa;
> +       uint32_t gc_num_rb_per_se;
> +       uint32_t gc_num_gl2c;
> +       uint32_t gc_num_gprs;
> +       uint32_t gc_num_max_gs_thds;
> +       uint32_t gc_gs_table_depth;
> +       uint32_t gc_gsprim_buff_depth;
> +       uint32_t gc_parameter_cache_depth;
> +       uint32_t gc_double_offchip_lds_buffer;
> +       uint32_t gc_wave_size;
> +       uint32_t gc_max_waves_per_simd;
> +       uint32_t gc_max_scratch_slots_per_cu;
> +       uint32_t gc_lds_size;
> +       uint32_t gc_num_sc_per_se;
> +       uint32_t gc_num_sa_per_se;
> +       uint32_t gc_num_packer_per_sc;
> +       uint32_t gc_num_gl2a;
> +       uint32_t gc_num_tcp_per_sa;
> +       uint32_t gc_num_sdp_interface;
> +       uint32_t gc_num_tcps;
> +};
> +
> +struct gc_info_v2_0 {
> +       struct gpu_info_header header;
> +
> +       uint32_t gc_num_se;
> +       uint32_t gc_num_cu_per_sh;
> +       uint32_t gc_num_sh_per_se;
> +       uint32_t gc_num_rb_per_se;
> +       uint32_t gc_num_tccs;
> +       uint32_t gc_num_gprs;
> +       uint32_t gc_num_max_gs_thds;
> +       uint32_t gc_gs_table_depth;
> +       uint32_t gc_gsprim_buff_depth;
> +       uint32_t gc_parameter_cache_depth;
> +       uint32_t gc_double_offchip_lds_buffer;
> +       uint32_t gc_wave_size;
> +       uint32_t gc_max_waves_per_simd;
> +       uint32_t gc_max_scratch_slots_per_cu;
> +       uint32_t gc_lds_size;
> +       uint32_t gc_num_sc_per_se;
> +       uint32_t gc_num_packer_per_sc;
> +};
> +
>  typedef struct harvest_info_header {
>         uint32_t signature; /* Table Signature */
>         uint32_t version;   /* Table Version */
> --
> 2.33.1
>
