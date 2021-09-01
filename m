Return-Path: <SRS0=BBbY=NX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306CFC4320E
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 16:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A986108E
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 16:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6A986108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE806E1E6;
	Wed,  1 Sep 2021 16:37:30 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 824356E1E6
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Sep 2021 16:37:28 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 l7-20020a0568302b0700b0051c0181deebso368678otv.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Sep 2021 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V2zA9PUqRXuJXmjw+bunbz7as+kmxnoEJBCeyxIQzNw=;
 b=dT2yYzhXMa2stCa/io2cUD5p/E5R9rmxvTaTZoIX5whYVrIlp3S6jBUnhRV2bORmTO
 PEouuQ89YUykWZcoIv4XFlfJZ5+cnvVS/TsB1qOVS72NSbGd0bKD65TSDU0i7BFvxhIe
 8AIIFPTJ/zyZwl4auPmWTXzdo4XQiJcOM9tqYjk4HwaCYCxOoXH5C7baCbXPXCaO5KMb
 1DTSj2qZCxW5TXyF+tiXLoNNc2j3F6B5go4gO63ptg9vLX+2z/2n1lijC+IStT8yfmPv
 NkskMz7WeDUxZuURUv6fAMWslcdEXZudAKbtzH7Hful7iZUzP7Ppi61YnLxJK2mzeqLz
 u7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V2zA9PUqRXuJXmjw+bunbz7as+kmxnoEJBCeyxIQzNw=;
 b=th/AyqIMQw58p6oRyYsPl92QOaKBcbsXQaU8ixQpX/NOC59TqzCV2U6JzIF01WvDuf
 WL93FuU0XA1DR3mOZmYDmURssrpSmZlYrptb6HyuWySMvDIArUBJZDKsuH5xMB762BQM
 Qn/WgLAcGhLInnjE6voFjf7P60rOWOgd30+KXg+bnb7gZVOHjpIGNvFG2aW3Vk1W+62+
 nF8PN7dswfYq895CiCJkHAqBfE+v9DsYFfkcLEyLjBc2iHKRqrfYpNkUyz7i+5tdxuYW
 zObGTLu8oUDeth8NqgXKcYFIQD75Qtyfxt2IDQzndRdDh1ONmN1fUs0lcLRqYGdF9b2R
 u6Wg==
X-Gm-Message-State: AOAM531tXVm3xOcGv/ApQ0qYvIAXu3GL94K0zMLOxtLSn3x7mHVeHcqx
 Y6LovVE5aLpqPrU2o7O2/cyTBSQZhZMLhf4X9yk=
X-Google-Smtp-Source: ABdhPJzpHe2z13v/D6n+NQjgwA49Egs2k2ZeEmlus+zOMX6aB2HR+AlGb4nuZUyhdbcPvurUzj1YlfXooX10aeVqnaE=
X-Received: by 2002:a05:6830:4:: with SMTP id c4mr253269otp.23.1630514247621; 
 Wed, 01 Sep 2021 09:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210831215632.195506-1-Felix.Kuehling@amd.com>
 <239a99fd-835f-cbbc-152f-afae6861bf60@amd.com>
 <2c63bf17-2404-8c68-fa63-b14d94de3e90@amd.com>
 <BL1PR12MB5349845ADA6A373FBA45609197CD9@BL1PR12MB5349.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5349845ADA6A373FBA45609197CD9@BL1PR12MB5349.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Sep 2021 12:37:16 -0400
Message-ID: <CADnq5_OBw1=PNx-iSc1-pq3At=GKtQu8RgAcT9+mucwefqsh7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-version
 dependent
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 1, 2021 at 12:30 PM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>
> [Public]
>
>
> What I wanted to ask was -
>
> Whether user mode application relies only on link properties alone to assume atomic ops are supported? If they check only link properties and if the firmware doesn't work fine, should it be still marked as supported?
>
> Basically, what is the purpose of exposing atomic capability in link properties and whether that can be utilised by upper mode applications just based on PCIe atomics support?
>

PCI atomics in general and the requirement for PCI atomics in the CP
firmware are independent.  The firmware can operate either with
atomics or without.  The operation of the firmware does not affect
user processes that might want to use atomics for other things.

Alex


> Thanks,
> Lijo
> ________________________________
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Wednesday, September 1, 2021 8:24:56 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-version dependent
>
> Am 2021-09-01 um 7:04 a.m. schrieb Lazar, Lijo:
> >
> >
> > On 9/1/2021 3:26 AM, Felix Kuehling wrote:
> >> On some GPUs the PCIe atomic requirement for KFD depends on the MEC
> >> firmware version. Add a firmware version check for this. The minimum
> >> firmware version that works without atomics can be updated in the
> >> device_info structure for each GPU type.
> >>
> >> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++++--
> >>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 1 +
> >>   2 files changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >> index 16a57b70cc1a..655ee5733229 100644
> >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >> @@ -688,6 +688,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
> >>       struct kfd_dev *kfd;
> >>       const struct kfd_device_info *device_info;
> >>       const struct kfd2kgd_calls *f2g;
> >> +    uint32_t fw_version;
> >>         if (asic_type >= sizeof(kfd_supported_devices) / (sizeof(void
> >> *) * 2)
> >>           || asic_type >= sizeof(kfd2kgd_funcs) / sizeof(void *)) {
> >> @@ -713,8 +714,12 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
> >>        * supported.
> >>        */
> >>       kfd->pci_atomic_requested =
> >> amdgpu_amdkfd_have_atomics_support(kgd);
> >
> > Should the check be grouped inside amdgpu_amdkfd_have_atomics_support?
> >
> > This flag is used for setting some link properties. If there is HW
> > support but comes with incompatible firmware, should the link be still
> > marked as atomic?
>
> Our GPU HW always supports PCIe atomics (it's part of the PCIe 3 spec).
> But some mainboards with older PCIe chipsets do not. Sometimes even
> different ports on the same mainboard differ in their PCIe version and
> atomic support.
>
> amdgpu_device_init always tries to enable atomics on the root port an
> all the bridges leading to the GPU by calling
> pci_enable_atomic_ops_to_root. The result is saved in
> adev->have_atomics_support, which is returned to KFD by
> amdgpu_amdkfd_have_atomics_support.
>
> The firmware change here does not affect whether atomics are
> _supported_. It changes whether atomics are _required_ for the basic
> operation of AQL user mode queues. The coming firmware update will
> remove that requirement, which allows us to enable KFD for these GPUs+FW
> on systems without PCIe atomics.
>
> Enabling PCIe atomics with the updated FW is still beneficial because
> shader programs can use a subset of atomic instructions for accessing
> system memory atomically on supported systems.
>
> Regards,
>   Felix
>
>
> >
> > Thanks,
> > Lijo
> >
> >> -    if (device_info->needs_pci_atomics &&
> >> -        !kfd->pci_atomic_requested) {
> >> +    fw_version = amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1);
> >> +    if (!kfd->pci_atomic_requested &&
> >> +        device_info->needs_pci_atomics &&
> >> +        (!device_info->no_atomic_fw_version ||
> >> +          amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1) <
> >> +            device_info->no_atomic_fw_version)) {
> >>           dev_info(kfd_device,
> >>                "skipped device %x:%x, PCI rejects atomics\n",
> >>                pdev->vendor, pdev->device);
> >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >> index ab83b0de6b22..6d8f9bb2d905 100644
> >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >> @@ -207,6 +207,7 @@ struct kfd_device_info {
> >>       bool supports_cwsr;
> >>       bool needs_iommu_device;
> >>       bool needs_pci_atomics;
> >> +    uint32_t no_atomic_fw_version;
> >>       unsigned int num_sdma_engines;
> >>       unsigned int num_xgmi_sdma_engines;
> >>       unsigned int num_sdma_queues_per_engine;
> >>
