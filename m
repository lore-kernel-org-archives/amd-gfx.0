Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1FCC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 18:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE07161AA7
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 18:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE07161AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA4A6E122;
	Fri, 19 Nov 2021 18:50:16 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B7576E122
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 18:50:15 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 b5-20020a9d60c5000000b0055c6349ff22so18113091otk.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 10:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yJyiS2oDkzbHZLyT390b4UbYa+W4Mp1K9EwcJFA52rM=;
 b=g06nS2/eDz4Uhz1ZIL3YWsCLLp6zEVlQK/5NgEdRo+0D+kVLPcf3POfOM6ZHBx9IaT
 Yiszgz81fZ+NnR3fpOT2bhSRS8C3+NYHtlPSxtgwbwr7QlWvcC/olSC/WSZDCnl17Qwt
 17OzgW7/wcZ63t9jBhfuKts5aYq03W1xJViyQfHla1So/bthz9EXXO16WNkV5cwIG34O
 txHct5puVv2v6SEWOG6SG5y/IGhL9u2Q1JRg7040mNp6RS+haa98FGklwLDD9LCGNip2
 mm2Y5tdOVaYViVqNPXB29j1eulTPwZPvCz2zFLKQ1dfjOMaHYkNPNuu35YsunW8FJCbg
 G3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yJyiS2oDkzbHZLyT390b4UbYa+W4Mp1K9EwcJFA52rM=;
 b=Bjm3cjTetQqC2dE/4fXAYSxpgOHQ9VTnQbtG6QNHk6hii95nxDXn75Oz9G29Za4FQp
 oLSirZA8qGgbv5XiQ9TCJDvktqbfvGr+Bb0m27peGXFUFurXpUFrpmUSnGB2DXJOUHgI
 yIdqj57C3W6L0XDS/2zXYomTwvld/AeN+80wiHM9BJGa1C2XCpFV4OUjBr9P+JgLRIaz
 0Ednbeij4C3QL4WbwBV6Th9OIFsJ9l3hJkP4dT/FXgAN/dN0b+7+3VvGf8mCfoP5VWGh
 9h9opPMcJKVWU5Zj9lAVsrIy4RKn6xCE1i2qYdh9B0vIjBElxct4u6u3xISwU1SVRQMh
 EcsQ==
X-Gm-Message-State: AOAM531alw87mxWQ9ttRqSpCKQLKkiP8sRB2nsa7Uk/mcZ9NUbZwburC
 1hCF8TcOJR/krkqbrvRO7BfM9tsK1otRbs02qeOHNGBo
X-Google-Smtp-Source: ABdhPJxwKlUSn809C+BArJ3dlxPP1yoJir2BXPLhsneySSj6+xp0GNomJeNIfeNfChvGprqYtw/MwlcWvtsSdWQupmc=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr6828558oto.357.1637347814427; 
 Fri, 19 Nov 2021 10:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20211119162800.2111819-1-Graham.Sider@amd.com>
 <20211119162800.2111819-4-Graham.Sider@amd.com>
In-Reply-To: <20211119162800.2111819-4-Graham.Sider@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Nov 2021 13:50:03 -0500
Message-ID: <CADnq5_MJbpc1QM+Lie_2SM=WoQ_PVsefmPToyGpiGPUVLYmqsw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdkfd: remove hardcoded device_info structs
To: Graham Sider <Graham.Sider@amd.com>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please use C comments (/* */) rather than C++ comments.  Same for the
previous patches in the series.

Alex

On Fri, Nov 19, 2021 at 11:28 AM Graham Sider <Graham.Sider@amd.com> wrote:
>
> With device_info initialization being handled in kfd_device_info_init,
> these structs may be removed. Also add comments to help matching IP
> versions to asic names.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 469 +-----------------------
>  1 file changed, 17 insertions(+), 452 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 65e0eb5e2926..536cd227c9d3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -53,458 +53,6 @@ extern const struct kfd2kgd_calls aldebaran_kfd2kgd;
>  extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
>  extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
>
> -#ifdef KFD_SUPPORT_IOMMU_V2
> -static const struct kfd_device_info kaveri_device_info = {
> -       .gfx_target_version = 70000,
> -       .max_pasid_bits = 16,
> -       /* max num of queues for KV.TODO should be a dynamic value */
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 4,
> -       .ih_ring_entry_size = 4 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_cik,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = false,
> -       .needs_iommu_device = true,
> -       .needs_pci_atomics = false,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info carrizo_device_info = {
> -       .gfx_target_version = 80001,
> -       .max_pasid_bits = 16,
> -       /* max num of queues for CZ.TODO should be a dynamic value */
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 4,
> -       .ih_ring_entry_size = 4 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_cik,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = true,
> -       .needs_pci_atomics = false,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info raven_device_info = {
> -       .gfx_target_version = 90002,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = true,
> -       .needs_pci_atomics = true,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -#endif
> -
> -#ifdef CONFIG_DRM_AMDGPU_CIK
> -static const struct kfd_device_info hawaii_device_info = {
> -       .gfx_target_version = 70001,
> -       .max_pasid_bits = 16,
> -       /* max num of queues for KV.TODO should be a dynamic value */
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 4,
> -       .ih_ring_entry_size = 4 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_cik,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = false,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = false,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -#endif
> -
> -static const struct kfd_device_info tonga_device_info = {
> -       .gfx_target_version = 80002,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 4,
> -       .ih_ring_entry_size = 4 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_cik,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = false,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = true,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info fiji_device_info = {
> -       .gfx_target_version = 80003,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 4,
> -       .ih_ring_entry_size = 4 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_cik,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = true,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info fiji_vf_device_info = {
> -       .gfx_target_version = 80003,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 4,
> -       .ih_ring_entry_size = 4 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_cik,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = false,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -
> -static const struct kfd_device_info polaris10_device_info = {
> -       .gfx_target_version = 80003,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 4,
> -       .ih_ring_entry_size = 4 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_cik,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = true,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info polaris10_vf_device_info = {
> -       .gfx_target_version = 80003,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 4,
> -       .ih_ring_entry_size = 4 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_cik,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = false,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info polaris11_device_info = {
> -       .gfx_target_version = 80003,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 4,
> -       .ih_ring_entry_size = 4 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_cik,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = true,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info polaris12_device_info = {
> -       .gfx_target_version = 80003,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 4,
> -       .ih_ring_entry_size = 4 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_cik,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = true,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info vegam_device_info = {
> -       .gfx_target_version = 80003,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 4,
> -       .ih_ring_entry_size = 4 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_cik,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = true,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info vega10_device_info = {
> -       .gfx_target_version = 90000,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = false,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info vega10_vf_device_info = {
> -       .gfx_target_version = 90000,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = false,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info vega12_device_info = {
> -       .gfx_target_version = 90004,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = false,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info vega20_device_info = {
> -       .gfx_target_version = 90006,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = false,
> -       .num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info arcturus_device_info = {
> -       .gfx_target_version = 90008,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = false,
> -       .num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info aldebaran_device_info = {
> -       .gfx_target_version = 90010,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = false,
> -       .num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info renoir_device_info = {
> -       .gfx_target_version = 90012,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .supports_cwsr = true,
> -       .needs_iommu_device = false,
> -       .needs_pci_atomics = false,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info navi10_device_info = {
> -       .gfx_target_version = 100100,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .needs_iommu_device = false,
> -       .supports_cwsr = true,
> -       .needs_pci_atomics = true,
> -       .no_atomic_fw_version = 145,
> -       .num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info navi12_device_info = {
> -       .gfx_target_version = 100101,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .needs_iommu_device = false,
> -       .supports_cwsr = true,
> -       .needs_pci_atomics = true,
> -       .no_atomic_fw_version = 145,
> -       .num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info navi14_device_info = {
> -       .gfx_target_version = 100102,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .needs_iommu_device = false,
> -       .supports_cwsr = true,
> -       .needs_pci_atomics = true,
> -       .no_atomic_fw_version = 145,
> -       .num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info sienna_cichlid_device_info = {
> -       .gfx_target_version = 100300,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .needs_iommu_device = false,
> -       .supports_cwsr = true,
> -       .needs_pci_atomics = true,
> -       .no_atomic_fw_version = 92,
> -       .num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info navy_flounder_device_info = {
> -       .gfx_target_version = 100301,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .needs_iommu_device = false,
> -       .supports_cwsr = true,
> -       .needs_pci_atomics = true,
> -       .no_atomic_fw_version = 92,
> -       .num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info vangogh_device_info = {
> -       .gfx_target_version = 100303,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .needs_iommu_device = false,
> -       .supports_cwsr = true,
> -       .needs_pci_atomics = true,
> -       .no_atomic_fw_version = 92,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info dimgrey_cavefish_device_info = {
> -       .gfx_target_version = 100302,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .needs_iommu_device = false,
> -       .supports_cwsr = true,
> -       .needs_pci_atomics = true,
> -       .no_atomic_fw_version = 92,
> -       .num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info beige_goby_device_info = {
> -       .gfx_target_version = 100304,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .needs_iommu_device = false,
> -       .supports_cwsr = true,
> -       .needs_pci_atomics = true,
> -       .no_atomic_fw_version = 92,
> -       .num_sdma_queues_per_engine = 8,
> -};
> -
> -static const struct kfd_device_info yellow_carp_device_info = {
> -       .gfx_target_version = 100305,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .needs_iommu_device = false,
> -       .supports_cwsr = true,
> -       .needs_pci_atomics = true,
> -       .no_atomic_fw_version = 92,
> -       .num_sdma_queues_per_engine = 2,
> -};
> -
> -static const struct kfd_device_info cyan_skillfish_device_info = {
> -       .gfx_target_version = 100103,
> -       .max_pasid_bits = 16,
> -       .max_no_of_hqd  = 24,
> -       .doorbell_size  = 8,
> -       .ih_ring_entry_size = 8 * sizeof(uint32_t),
> -       .event_interrupt_class = &event_interrupt_class_v9,
> -       .num_of_watch_points = 4,
> -       .mqd_size_aligned = MQD_SIZE_ALIGNED,
> -       .needs_iommu_device = false,
> -       .supports_cwsr = true,
> -       .needs_pci_atomics = true,
> -       .num_sdma_queues_per_engine = 8,
> -};
> -
>  static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
>                                 unsigned int chunk_size);
>  static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
> @@ -632,11 +180,13 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>                 break;
>         default:
>                 switch (gc_version) {
> +               // Vega 10
>                 case IP_VERSION(9, 0, 1):
>                         gfx_target_version = 90000;
>                         f2g = &gfx_v9_kfd2kgd;
>                         break;
>  #ifdef KFD_SUPPORT_IOMMU_V2
> +               // Raven
>                 case IP_VERSION(9, 1, 0):
>                 case IP_VERSION(9, 2, 2):
>                         gfx_target_version = 90002;
> @@ -644,69 +194,84 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>                                 f2g = &gfx_v9_kfd2kgd;
>                         break;
>  #endif
> +               // Vega12
>                 case IP_VERSION(9, 2, 1):
>                         gfx_target_version = 90004;
>                         if (!vf)
>                                 f2g = &gfx_v9_kfd2kgd;
>                         break;
> +               // Renoir
>                 case IP_VERSION(9, 3, 0):
>                         gfx_target_version = 90012;
>                         if (!vf)
>                                 f2g = &gfx_v9_kfd2kgd;
>                         break;
> +               // Vega20
>                 case IP_VERSION(9, 4, 0):
>                         gfx_target_version = 90006;
>                         if (!vf)
>                                 f2g = &gfx_v9_kfd2kgd;
>                         break;
> +               // Arcturus
>                 case IP_VERSION(9, 4, 1):
>                         gfx_target_version = 90008;
>                         f2g = &arcturus_kfd2kgd;
>                         break;
> +               // Aldebaran
>                 case IP_VERSION(9, 4, 2):
>                         gfx_target_version = 90010;
>                         f2g = &aldebaran_kfd2kgd;
>                         break;
> +               // Navi10
>                 case IP_VERSION(10, 1, 10):
>                         gfx_target_version = 100100;
>                         if (!vf)
>                                 f2g = &gfx_v10_kfd2kgd;
>                         break;
> +               // Navi12
>                 case IP_VERSION(10, 1, 2):
>                         gfx_target_version = 100101;
>                         f2g = &gfx_v10_kfd2kgd;
>                         break;
> +               // Navi14
>                 case IP_VERSION(10, 1, 1):
>                         gfx_target_version = 100102;
>                         if (!vf)
>                                 f2g = &gfx_v10_kfd2kgd;
>                         break;
> +               // Cyan Skillfish
>                 case IP_VERSION(10, 1, 3):
>                         gfx_target_version = 100103;
>                         if (!vf)
>                                 f2g = &gfx_v10_kfd2kgd;
>                         break;
> +               // Sienna Cichlid
>                 case IP_VERSION(10, 3, 0):
>                         gfx_target_version = 100300;
>                         f2g = &gfx_v10_3_kfd2kgd;
>                         break;
> +               // Navy Flounder
>                 case IP_VERSION(10, 3, 2):
>                         gfx_target_version = 100301;
>                         f2g = &gfx_v10_3_kfd2kgd;
>                         break;
> +               // Van Gogh
>                 case IP_VERSION(10, 3, 1):
>                         gfx_target_version = 100303;
>                         if (!vf)
>                                 f2g = &gfx_v10_3_kfd2kgd;
>                         break;
> +               // Dimgrey Cavefish
>                 case IP_VERSION(10, 3, 4):
>                         gfx_target_version = 100302;
>                         f2g = &gfx_v10_3_kfd2kgd;
>                         break;
> +               // Beige Goby
>                 case IP_VERSION(10, 3, 5):
>                         gfx_target_version = 100304;
>                         f2g = &gfx_v10_3_kfd2kgd;
>                         break;
> +               // Yellow Carp
>                 case IP_VERSION(10, 3, 3):
>                         gfx_target_version = 100305;
>                         if (!vf)
> --
> 2.25.1
>
