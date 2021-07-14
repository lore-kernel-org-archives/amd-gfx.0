Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE54C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 14:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4746613B2
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 14:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4746613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7FC6E3BB;
	Wed, 14 Jul 2021 14:49:38 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD066E3BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 14:49:37 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 i12-20020a05683033ecb02903346fa0f74dso2697333otu.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fpgcSwV8lbe991eyMJ/w05wQMYh9HPhgz0eZCUVagYs=;
 b=AujAZqYlwmxCCD/Aw47kXRR91NYLeoyxSepHl57wxbo2v9BTPFeAhnp0QsdKWYZOdP
 D1pW7pUwWLE9oljolxEnJyUH2jLtx5okzXvY+y98NtL1X/vte40Xr7c7NTEg65RecmPI
 7GlFG/8xqUykfBBDmIUb+RC+YgG0jF/q9EkHjMpAEe9uoqh/eh1uSTgNmiZ92hVrvzu9
 p7yIaKcvBDXVNrc6wCUbACrYmK08qHiIrdM/dyqJL/2Xm+MMKWTwVtW5EY+T2w86XpqR
 eEpGY8ZqY3kEUlv8fLH/2oIVgew9t4iJXW1TjIEYbnWe7RxRjV/4fYQZx2SqX8rL58JF
 RkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fpgcSwV8lbe991eyMJ/w05wQMYh9HPhgz0eZCUVagYs=;
 b=eSDdDrr70caJ9Met3Ng4dS5SiQg0k5lX6RS7y9Oeh2BySdyarpGRLD1DbijNoVlCHm
 +1OmsbjtfO/1J3uzCOUwzVYdZlmjHxhm2AWYOd8T1ajU7wNGF4x+sx8ZQtyTCXvX2Bo/
 /A5s9jW8dNSL9iWtEklYbTAcVC+r9CsBcbsEOVLRK/LBSGtaxdTogPpAr8aZhoWKA7y3
 cekUt98fzteBdlxLY8VBQzafohb9IbOWS+410vw10tTw0om5wei+ZhD4k7neNMGvRafD
 mID5En0afBs1Ao6A9+gWs0KpaML+bZwotYYxwYXhitNo0bUmLqk2qQlTlQizD1BOAWFs
 MMsQ==
X-Gm-Message-State: AOAM531Eb5qaD20Kk+5Uf/N33ASbBMWW1v5uEazNWvvjyZzuydqxGU34
 L8LJ5LObg5nqG9EcJkqbe8SX2bduHOnp3OCHoos=
X-Google-Smtp-Source: ABdhPJyUq9BHY5TqRhjsOfiKm6WikaXRSkUiKqKG9kyALVs9kPQEJJdz2F9eY2M1OS/lIIDjLmW2onTsPoC1UiPGuZQ=
X-Received: by 2002:a9d:2482:: with SMTP id z2mr5822399ota.132.1626274175424; 
 Wed, 14 Jul 2021 07:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210713103054.4161-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210713103054.4161-1-PengJu.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Jul 2021 10:49:24 -0400
Message-ID: <CADnq5_OOhNpLE1uibK_L09epxyzymDxi4aAZzdWTqq6tt-wbVg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 13, 2021 at 6:31 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>
> The previous logic is recording the amount of valid vcn instances
> to use them on SRIOV, it is a hard task due to the vcn accessment is
> based on the index of the vcn instance.
>
> Check if the vcn instance enabled before do instance init.
>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 33 ++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index c3580de3ea9c..d11fea2c9d90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -88,9 +88,7 @@ static int vcn_v3_0_early_init(void *handle)
>         int i;
>
>         if (amdgpu_sriov_vf(adev)) {
> -               for (i = 0; i < VCN_INSTANCES_SIENNA_CICHLID; i++)
> -                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i))
> -                               adev->vcn.num_vcn_inst++;
> +               adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
>                 adev->vcn.harvest_config = 0;
>                 adev->vcn.num_enc_rings = 1;
>
> @@ -151,8 +149,7 @@ static int vcn_v3_0_sw_init(void *handle)
>                 adev->firmware.fw_size +=
>                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
>
> -               if ((adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) ||
> -                   (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)) {
> +               if (adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) {
>                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
>                         adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
>                         adev->firmware.fw_size +=
> @@ -322,18 +319,28 @@ static int vcn_v3_0_hw_init(void *handle)
>                                 continue;
>
>                         ring = &adev->vcn.inst[i].ring_dec;
> -                       ring->wptr = 0;
> -                       ring->wptr_old = 0;
> -                       vcn_v3_0_dec_ring_set_wptr(ring);
> -                       ring->sched.ready = true;
> -
> -                       for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> -                               ring = &adev->vcn.inst[i].ring_enc[j];
> +                       if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
> +                               ring->sched.ready = false;
> +                               dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
> +                       } else {
>                                 ring->wptr = 0;
>                                 ring->wptr_old = 0;
> -                               vcn_v3_0_enc_ring_set_wptr(ring);
> +                               vcn_v3_0_dec_ring_set_wptr(ring);
>                                 ring->sched.ready = true;
>                         }
> +
> +                       for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +                               ring = &adev->vcn.inst[i].ring_enc[j];
> +                               if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
> +                                       ring->sched.ready = false;
> +                                       dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
> +                               } else {
> +                                       ring->wptr = 0;
> +                                       ring->wptr_old = 0;
> +                                       vcn_v3_0_enc_ring_set_wptr(ring);
> +                                       ring->sched.ready = true;
> +                               }
> +                       }
>                 }
>         } else {
>                 for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
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
