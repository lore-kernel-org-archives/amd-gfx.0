Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039C9C48BCD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B831D61184
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B831D61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E60C6E09F;
	Wed,  9 Jun 2021 21:06:31 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F6906E0AC
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 21:06:29 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 v27-20020a056830091bb02903cd67d40070so22280154ott.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Jun 2021 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eM255YfYyzxpm7w/SnoF36YvWymLd70dVm9A53d+pXk=;
 b=G3zfVNjMxyRIjTAnjkSfU/GJJRWVuCQgrqCRA1ESzVoPP3nE5FIcGVzKRAQMtuhc7D
 hemwaHQBEIQeCpiar6O6jY0YZs/mFW3jNPrFC6OsGmpa3tqpnTnnnlQQ4NHFfYGqeg0q
 PZekm0jO3rksEAW7z0sA9Sg2aXN+IamU89GWzvh9DEljyaMUylqI/Wsi/oHX3+JJSy6P
 8HABKJ2EcQBPBUQegqqgiTrZrL/O3Gc4IIQEqteBarhMr90Pw40ph1vwBkOT0vSNbtYc
 ORdXYEdbnfKqnOmkG5auSXjZ88L9G3ZtoUYeP57iKGXqFtuQaCN2Dm7ETF0GA4qQxbmT
 Nw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eM255YfYyzxpm7w/SnoF36YvWymLd70dVm9A53d+pXk=;
 b=f61cUgiLD33TfWpo4c1WQonEhvuiQTEWivoBppcnTy3xQxhV5D1QibDh535Eig4ghH
 Hhv1CaM56lKJu1lrXJ9bP6FG2BjYJPYfcbT0ETL711gN+P+CdClsxSxU7Mvj+yocmUo9
 /dt5dWVN+eY55B+O8dYKX4Rfruw2yuzIzxFEg/S1HLo7FL4sNAJRbB0jMwsn00qfiJA+
 RJ/44PVSgwlMl4SQ+77omwHWpUpfNWY8rLN+JZL8mr+Xjv9Au0l/79m9IzsOmKy3GBRD
 PIKGJ85LTOpcP7Y60J79rw+gWqPBjGD0kERXYbDhP8CzJaNxdEvAxF/DVoi3ppcd62to
 GLWA==
X-Gm-Message-State: AOAM533oCVKmRNpj11u/e+z/CoKKFUNktVhwEmkNWRshHLK/1y0ndk6s
 +k1gHC7xX7r6Jhtu45ohBCdYWOxa71+oFL0JsmE=
X-Google-Smtp-Source: ABdhPJwpXtiEbODvr4v81Dc0LPPYzr4myJtAa4meu4GqtM25FF5S4CGLb9l+FijE94hbgfI3UmJs/KpPWeYU23so81I=
X-Received: by 2002:a05:6830:1e64:: with SMTP id
 m4mr1128660otr.23.1623272788304; 
 Wed, 09 Jun 2021 14:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210603104208.5725-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210603104208.5725-1-PengJu.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Jun 2021 17:06:17 -0400
Message-ID: <CADnq5_N5Nw1MK_EuRCbRRK0p+0iPy4xSSHo_=6pzZ1ozgv=z9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: Use IP discovery data to determine
 VCN enablement instead of MMSCH
To: Peng Ju Zhou <PengJu.Zhou@amd.com>
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 3, 2021 at 6:42 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>
> From: Bokun Zhang <Bokun.Zhang@amd.com>
>
> In the past, we use MMSCH to determine whether a VCN is enabled or not.
> This is not reliable since after a FLR, MMSCH may report junk data.
>
> It is better to use IP discovery data.
>
> Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 73 +++++++++++++++++----------
>  1 file changed, 45 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index ce3c794c176f..92f88ea69035 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -27,6 +27,7 @@
>  #include "amdgpu_pm.h"
>  #include "soc15.h"
>  #include "soc15d.h"
> +#include "soc15_hw_ip.h"
>  #include "vcn_v2_0.h"
>  #include "mmsch_v3_0.h"
>
> @@ -63,6 +64,17 @@ static int amdgpu_ucode_id_vcns[] = {
>         AMDGPU_UCODE_ID_VCN1
>  };
>
> +#define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
> +#define VCN_BLOCK_DECODE_DISABLE_MASK 0x40
> +#define VCN_BLOCK_QUEUE_DISABLE_MASK 0xC0
> +
> +enum vcn_ring_type {
> +       VCN_ENCODE_RING,
> +       VCN_DECODE_RING,
> +       VCN_UNIFIED_RING,
> +};
> +
> +static bool vcn_v3_0_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance);
>  static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
>  static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
> @@ -324,18 +336,26 @@ static int vcn_v3_0_hw_init(void *handle)
>                                 continue;
>
>                         ring = &adev->vcn.inst[i].ring_dec;
> -                       if (ring->sched.ready) {
> +                       if (vcn_v3_0_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
> +                               ring->sched.ready = false;
> +                               dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
> +                       } else {
>                                 ring->wptr = 0;
>                                 ring->wptr_old = 0;
>                                 vcn_v3_0_dec_ring_set_wptr(ring);
> +                               ring->sched.ready = true;
>                         }
>
>                         for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
>                                 ring = &adev->vcn.inst[i].ring_enc[j];
> -                               if (ring->sched.ready) {
> +                               if (vcn_v3_0_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
> +                                       ring->sched.ready = false;
> +                                       dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
> +                               } else {
>                                         ring->wptr = 0;
>                                         ring->wptr_old = 0;
>                                         vcn_v3_0_enc_ring_set_wptr(ring);
> +                                       ring->sched.ready = true;


I think it would be cleaner to use the IP discovery data in
vcn_v3_0_early_init() to set the harvest config and just use that
here.


>                                 }
>                         }
>                 }
> @@ -1286,6 +1306,29 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
>         return 0;
>  }
>
> +static bool vcn_v3_0_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
> +{
> +       bool ret = false;
> +
> +       int major;
> +       int minor;
> +       int revision;
> +
> +       /* if cannot find IP data, then this VCN does not exist */
> +       if (amdgpu_discovery_get_ip_version(adev, VCN_HWID, vcn_instance, &major, &minor, &revision) != 0)
> +               return true;
> +
> +       if ((type == VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
> +               ret = true;
> +       } else if ((type == VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_DISABLE_MASK)) {
> +               ret = true;
> +       } else if ((type == VCN_UNIFIED_RING) && (revision & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
> +               ret = true;
> +       }
> +
> +       return ret;
> +}
> +

I don't think this is VCN 3.0 specific.  This could probably be moved
to amdgpu_vcn.c or amdgpu_discovery.c

Alex

>  static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
>  {
>         int i, j;
> @@ -1303,8 +1346,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
>         uint32_t table_size;
>         uint32_t size, size_dw;
>
> -       bool is_vcn_ready;
> -
>         struct mmsch_v3_0_cmd_direct_write
>                 direct_wt = { {0} };
>         struct mmsch_v3_0_cmd_direct_read_modify_write
> @@ -1496,30 +1537,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
>                 }
>         }
>
> -       /* 6, check each VCN's init_status
> -        * if it remains as 0, then this VCN is not assigned to current VF
> -        * do not start ring for this VCN
> -        */
> -       size = sizeof(struct mmsch_v3_0_init_header);
> -       table_loc = (uint32_t *)table->cpu_addr;
> -       memcpy(&header, (void *)table_loc, size);
> -
> -       for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -
> -               is_vcn_ready = (header.inst[i].init_status == 1);
> -               if (!is_vcn_ready)
> -                       DRM_INFO("VCN(%d) engine is disabled by hypervisor\n", i);
> -
> -               ring = &adev->vcn.inst[i].ring_dec;
> -               ring->sched.ready = is_vcn_ready;
> -               for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> -                       ring = &adev->vcn.inst[i].ring_enc[j];
> -                       ring->sched.ready = is_vcn_ready;
> -               }
> -       }
> -
>         return 0;
>  }
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
