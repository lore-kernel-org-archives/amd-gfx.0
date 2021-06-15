Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD90C48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 19:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F357610EA
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 19:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F357610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA4B89F85;
	Tue, 15 Jun 2021 19:28:59 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89CDB89F85
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 19:28:58 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id h9so19370664oih.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=va0XTNc37El/thZKjWI1Kp03ScocHrlpO0OMVGHHSfM=;
 b=rdwbbUeCdZYoh45tDlsQuitrm14HTlAmw3JiyMKc3q3rgBa6fEoE4VN2/XS6mDKwrB
 35Qkbvq6qmQJZ0IwKPISadAbxrFyrL8qAasA2J7SOJtEyL9WVQ6XEoj93n+Q+UGTBGm+
 V7Dp8wONK7Mp12FK5sVUQxvz/TzzLCC+g5KatPuDJ3L2YciH5vUcDwNqUENDNW669ybJ
 jBWrZNs3bejUzT/KxM3fL6l08m15KbJy0RG8Zhppgg39fV7RIV8xHCfy7IqL1me2cA6w
 aVQv3y0sGv9wny3RmKAjUY56QBNy59kS4xeIgrtdIMkzuGEF+Pf064UvbhGJp+HoQAiB
 52hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=va0XTNc37El/thZKjWI1Kp03ScocHrlpO0OMVGHHSfM=;
 b=WReel8ly2NUxAHRg0t0eKbwHLcGO9YOB1i0XOmenEe5kIlNBcQr2RpbVkP+uNno1Wn
 A4bu2uToXfo+UJ7qXylEGID+AVf9Lyc5+aC9lYeSoO1G90qMMagur8GjkNPzoeM1gKiw
 4kaS5R1IGjrmeNCZQSTwsM3Jm6l3epj1CD+sjO8Sn/mKgst9N16wlv20T8QoJIZPK6RV
 tr7aPoG759c38n6CHzBG/rto62q9mf82emrrc+Ne/Pkp5aCz/VHnKlZ9J6UB3++O8aJB
 oI4B28vi2QssMCl0ygbFeI3JJNCi/18GejxB7g2NBmacdOq8a/Sp7+qTg2ib5F3kpvxI
 CThg==
X-Gm-Message-State: AOAM532bWOzqRpPu3K73qGPSYiM28PwnPqw71VbObL0Nk6IPUlR/uuXo
 IUlSG4PXTdEkloO46tyoYFNmLAQyJATA4ZY1/Ho=
X-Google-Smtp-Source: ABdhPJz/djxASWjExMTTpkqheiwuunU7VK/BwnnHV0JyTe6zqHEFIxecEQuVa5qIucTc1WifYJrmvlGPvhd6z6nJDUI=
X-Received: by 2002:a05:6808:c3:: with SMTP id t3mr4137821oic.5.1623785337835; 
 Tue, 15 Jun 2021 12:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210615074632.31507-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210615074632.31507-1-PengJu.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Jun 2021 15:28:46 -0400
Message-ID: <CADnq5_PBj7frnYown4AY3jcdu7LHCg6sEKeQ5cHU8U1U6Wb0VQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: Use IP discovery data to determine VCN
 enablement instead of MMSCH
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

On Tue, Jun 15, 2021 at 3:46 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  8 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 23 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       | 13 +++++
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 52 +++++--------------
>  5 files changed, 60 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index f949ed8bfd9e..e02405a24fe3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -373,6 +373,14 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
>         return -EINVAL;
>  }
>
> +
> +int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_instance,
> +                                    int *major, int *minor, int *revision)
> +{
> +       return amdgpu_discovery_get_ip_version(adev, VCN_HWID,
> +                                              vcn_instance, major, minor, revision);
> +}
> +

I think you can drop this wrapper and just call
amdgpu_discovery_get_ip_version() directly from
amdgpu_vcn_is_disabled_vcn().

>  void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>  {
>         struct binary_header *bhdr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> index 02e340cd3a38..48e6b88cfdfe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -32,6 +32,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);
>  void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev);
>  int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
>                                      int *major, int *minor, int *revision);
> +
> +int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_instance,
> +                                    int *major, int *minor, int *revision);
>  int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
>
>  #endif /* __AMDGPU_DISCOVERY__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 9492b505e69b..84b025405578 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -287,6 +287,29 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>         return 0;
>  }
>
> +bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
> +{
> +       bool ret = false;
> +
> +       int major;
> +       int minor;
> +       int revision;
> +
> +       /* if cannot find IP data, then this VCN does not exist */
> +       if (amdgpu_discovery_get_vcn_version(adev, vcn_instance, &major, &minor, &revision) != 0)

Just call amdgpu_discovery_get_ip_version() directly here.

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
>  int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>  {
>         unsigned size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index bc76cab67697..d74c62b49795 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -280,6 +280,16 @@ struct amdgpu_vcn_decode_buffer {
>         uint32_t pad[30];
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
>  int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>  int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>  int amdgpu_vcn_suspend(struct amdgpu_device *adev);
> @@ -287,6 +297,9 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev);
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
>  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
>
> +bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
> +                               enum vcn_ring_type type, uint32_t vcn_instance);
> +
>  int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring);
>  int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>  int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index ce3c794c176f..a79ae86bc752 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -85,9 +85,12 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
>  static int vcn_v3_0_early_init(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +       int i;
>
>         if (amdgpu_sriov_vf(adev)) {
> -               adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
> +               for (i = 0; i < VCN_INSTANCES_SIENNA_CICHLID; i++)
> +                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i))
> +                               adev->vcn.num_vcn_inst++;
>                 adev->vcn.harvest_config = 0;
>                 adev->vcn.num_enc_rings = 1;
>
> @@ -99,7 +102,6 @@ static int vcn_v3_0_early_init(void *handle)
>         } else {
>                 if (adev->asic_type == CHIP_SIENNA_CICHLID) {
>                         u32 harvest;
> -                       int i;
>
>                         adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
>                         for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> @@ -154,7 +156,7 @@ static int vcn_v3_0_sw_init(void *handle)
>                 adev->firmware.fw_size +=
>                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
>
> -               if (adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) {
> +               if (adev->asic_type == CHIP_SIENNA_CICHLID) {

Is this change safe?  Will this break anything on harvested boards?
Other than these comments the patch looks good.

Alex

>                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
>                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
>                         adev->firmware.fw_size +=
> @@ -324,19 +326,17 @@ static int vcn_v3_0_hw_init(void *handle)
>                                 continue;
>
>                         ring = &adev->vcn.inst[i].ring_dec;
> -                       if (ring->sched.ready) {
> -                               ring->wptr = 0;
> -                               ring->wptr_old = 0;
> -                               vcn_v3_0_dec_ring_set_wptr(ring);
> -                       }
> +                       ring->wptr = 0;
> +                       ring->wptr_old = 0;
> +                       vcn_v3_0_dec_ring_set_wptr(ring);
> +                       ring->sched.ready = true;
>
>                         for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
>                                 ring = &adev->vcn.inst[i].ring_enc[j];
> -                               if (ring->sched.ready) {
> -                                       ring->wptr = 0;
> -                                       ring->wptr_old = 0;
> -                                       vcn_v3_0_enc_ring_set_wptr(ring);
> -                               }
> +                               ring->wptr = 0;
> +                               ring->wptr_old = 0;
> +                               vcn_v3_0_enc_ring_set_wptr(ring);
> +                               ring->sched.ready = true;
>                         }
>                 }
>         } else {
> @@ -1303,8 +1303,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
>         uint32_t table_size;
>         uint32_t size, size_dw;
>
> -       bool is_vcn_ready;
> -
>         struct mmsch_v3_0_cmd_direct_write
>                 direct_wt = { {0} };
>         struct mmsch_v3_0_cmd_direct_read_modify_write
> @@ -1496,30 +1494,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
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
