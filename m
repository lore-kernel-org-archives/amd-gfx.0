Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5A4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 18:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2B5611C7
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 18:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D2B5611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E906B6E220;
	Fri, 19 Nov 2021 18:54:44 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F2A6E220
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 18:54:44 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id bf8so23538352oib.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 10:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uR9BjBInhOExwIcJntQqXWyzAktJgaPYM5ZNs6UK4pY=;
 b=aHBiNKb9gH9yiYYoWs27jke5Bit6rdQyliWcaMhy9mz/Tfu1W+RYv6LwHcI0s1hScE
 sLf5tvvC6rW4YEoW6iJ4jJmouOdEA5viyZBoOyRtYt5qptLZqC844S6WPPDj2gZhNVbw
 1pnvF32jqztkhWvxmx2nhkDOSOv/kEtHa+lmLSX481nmpX7CdM72kTVrz2ScxVsPMeXP
 LIH9+Y7okNoVdgO5rhHyIt9A6nu5hminKT+0mez1LgKMrCk1bu/ex/qElECjeWpqWuA0
 qBnxFyHYmgy7jfIjHICfEfSvJu4+fO+5RRWZFG/rcqz77feOj1kDwqBM16OGkQ/LumF6
 VQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uR9BjBInhOExwIcJntQqXWyzAktJgaPYM5ZNs6UK4pY=;
 b=o5M3mjU8XI9pzQMuDeaqItTyswdjifgC70Qf4L7xASrGx+JDr6guJzuo6bIQpL1mfz
 u7vgSy6WnvZWbknLW9Di+2Dy1JpVBIYYo5cH5heYH9WymAbb79IA9WBD9N2RT/ZK7aQ4
 YqKpPxkCktzBqbeRgJGQJ91K7/typg7rozJpPFe3Q0SN9rgOuAMJKEQ5xktb3qrnQ3Qr
 COmXDiGpIdnXMg7b5dfjDPSdTpciocwPDhEgaCymUPzExMmHcbWrIXP9navfwnRmKO9S
 LrKnhj6adLK2ocgEffRHaVJeoRwu3RVs+Aa0znUXV6dmGZNjpuBqtm5+W5uOb8XgILMc
 h4sA==
X-Gm-Message-State: AOAM531pi7F6ip0kOuugJMBE3+WQfkP7lFhqIOFXtYEhlkdVVNozLEg9
 dXdmCSboH2tBnuUnMx5X2Dh0Pwip1ksaPqLZlL0=
X-Google-Smtp-Source: ABdhPJxS7w29XUGSZ5V6Rzgfpnle/zT+u5eZyBKGXxW8XvzzdKKzva5sVny2C3Qi4wJHXbnhFAhL0Tu89NQykpNKu1g=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr1881242oib.120.1637348083332; 
 Fri, 19 Nov 2021 10:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20211119162800.2111819-1-Graham.Sider@amd.com>
 <20211119162800.2111819-2-Graham.Sider@amd.com>
In-Reply-To: <20211119162800.2111819-2-Graham.Sider@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Nov 2021 13:54:32 -0500
Message-ID: <CADnq5_NHuMzfXGJAtVfxSwLGYtO+ipxP2noHYWKNjukrw3z=EQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amdkfd: add kfd_device_info_init function
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

On Fri, Nov 19, 2021 at 11:28 AM Graham Sider <Graham.Sider@amd.com> wrote:
>
> Initializes device_info structs given either asic_type (enum) if GFX
> version is less than GFX9, or GC IP version if greater. Also takes in vf
> and the target compiler gfx version.
>
> Inclusion/exclusion to certain conditions for certain GC IP versions may
> be necessary on npi bringup on a case-by-case basis, but for the most
> part should be minimal (e.g. adding one || asic_version == IP_VERSION(X ,X, X) case).
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 58 +++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index e11fc4e20c32..23e35a466cf0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -511,6 +511,64 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
>
>  static int kfd_resume(struct kfd_dev *kfd);
>
> +static void kfd_device_info_init(struct kfd_device_info *device_info,
> +                                uint32_t asic_version, bool is_soc15, bool vf,

I'm not crazy about reusing asic_version for both the GC version and
the asic type.  Seems like it would be easier to just pass adev and
access what you need directly.

Alex


> +                                uint32_t gfx_target_version)
> +{
> +       device_info->max_pasid_bits = 16;
> +       device_info->max_no_of_hqd = 24;
> +       device_info->num_of_watch_points = 4;
> +       device_info->mqd_size_aligned = MQD_SIZE_ALIGNED;
> +       device_info->gfx_target_version = gfx_target_version;
> +
> +       if (is_soc15) {
> +               device_info->doorbell_size = 8;
> +               device_info->ih_ring_entry_size = 8 * sizeof(uint32_t);
> +               device_info->event_interrupt_class = &event_interrupt_class_v9;
> +               device_info->supports_cwsr = true;
> +
> +               if ((asic_version >= IP_VERSION(9, 0, 1)  &&
> +                    asic_version <= IP_VERSION(9, 3, 0)) ||
> +                    asic_version == IP_VERSION(10, 3, 1) ||
> +                    asic_version == IP_VERSION(10, 3, 3))
> +                       device_info->num_sdma_queues_per_engine = 2;
> +               else
> +                       device_info->num_sdma_queues_per_engine = 8;
> +
> +               // Navi2x+, Navi1x+
> +               if (asic_version >= IP_VERSION(10, 3, 0))
> +                       device_info->no_atomic_fw_version = 145;
> +               else if (asic_version >= IP_VERSION(10, 1, 1))
> +                       device_info->no_atomic_fw_version = 92;
> +
> +               // Raven
> +               if (asic_version == IP_VERSION(9, 1, 0) ||
> +                   asic_version == IP_VERSION(9, 2, 2))
> +                       device_info->needs_iommu_device = true;
> +
> +               // Navi1x+
> +               if (asic_version >= IP_VERSION(10, 1, 1))
> +                       device_info->needs_pci_atomics = true;
> +       } else {
> +               device_info->doorbell_size = 4;
> +               device_info->ih_ring_entry_size = 4 * sizeof(uint32_t);
> +               device_info->event_interrupt_class = &event_interrupt_class_cik;
> +               device_info->num_sdma_queues_per_engine = 2;
> +
> +               if (asic_version != CHIP_KAVERI &&
> +                   asic_version != CHIP_HAWAII &&
> +                   asic_version != CHIP_TONGA)
> +                       device_info->supports_cwsr = true;
> +
> +               if (asic_version == CHIP_KAVERI ||
> +                   asic_version == CHIP_CARRIZO)
> +                       device_info->needs_iommu_device = true;
> +
> +               if (asic_version != CHIP_HAWAII && !vf)
> +                       device_info->needs_pci_atomics = true;
> +       }
> +}
> +
>  struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>  {
>         struct kfd_dev *kfd;
> --
> 2.25.1
>
