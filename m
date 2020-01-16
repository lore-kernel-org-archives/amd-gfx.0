Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87A9C3F68F
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 19:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FAF2073A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 19:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi8RSsTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FAF2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5C06EEA6;
	Thu, 16 Jan 2020 19:24:52 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89FC76EEA6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 19:24:50 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id g17so20334194wro.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 11:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z/ZuX/zV6gZcTYCBZXn8xxANjGNSdpl87QWKVQLIO84=;
 b=Xi8RSsTvzd5uN0+qJyN+eeMSCPTtCAKGE8xWls/vMpwRR1zk5mABV7q1DfvogKVM/l
 0w/VD7IzT+u+JS9uiAV0czaL9z7YrEwUUdNERqyPQNQASuYeenluwudFzOgPiYqd9nAd
 38hxDN48SfABQBsZ0M63njKWxUitU/vVQOg3FY9xXehwD8mzTwg9ldfozXcgSwYZ76QE
 OSKXtqQA21rKGBjHCT0VNOeEU+5hKs1GHUi9BqpnBMHzDN47/DhKpeyyPjI49GKuzCiL
 x59V1DsVGffczlcLe35yftm81vHcfoDRMdi2pIPoGewZvd3Isa4E8+r7nnoI6KzuX7Yr
 6pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z/ZuX/zV6gZcTYCBZXn8xxANjGNSdpl87QWKVQLIO84=;
 b=atWD8hpbNyHnwCTbkgT76iP4JGBCDihkl3dKblnzpRjPqQAz4h36oPbnNhaEe+3giL
 SQcaGbRUZc0/oFqJ/AUr1Akbnxy0xaI8kZIHonCb6m+cJkZ0z31pmjBoTMhqL79kPsvN
 7T7D4G25YA0ntfahxHIq1U8MmQYRC84lY8fBKbqGpqK4vNcCCOrh/bmKEpGzMYPuwc3H
 3YoDYbNAFZWTCb9TwF/xWnh9PwpdYa0JDK7d4+XiEJ/ekCENIcuVaLFlylxvvssCcLMo
 P87asmXAUknuI8SZIbkGSzN8uZqDS72UgufiVhXMJ++yYpZ2XvwiiEXg+Ce3wLw2ka6t
 sv5w==
X-Gm-Message-State: APjAAAXqRqb+357B4MdZ4MJKma+ac6+c/7fTFTtfh3S9mywdzQsw/6GZ
 C3sDNfo94bq4krqhcA/sdbq8qFAkBrpYAP9pk1XvVQ==
X-Google-Smtp-Source: APXvYqwccAzCdUcGAC+8dBaMDIaKsfzKsavmCpNmaTgdIg4pUozMZsUt1VVKbVqrUIJ1BX+zWD+7WHvqyhDoEPoN8ok=
X-Received: by 2002:a5d:5091:: with SMTP id a17mr4882664wrt.362.1579202688906; 
 Thu, 16 Jan 2020 11:24:48 -0800 (PST)
MIME-Version: 1.0
References: <1579201021-7109-1-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1579201021-7109-1-git-send-email-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jan 2020 14:24:37 -0500
Message-ID: <CADnq5_OFFAWgdm5WbSDU7TxM3nVhhyOLK8b_=9auPOdz1QaeBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: allow init discovery tmr region per ASIC
To: Hawking Zhang <Hawking.Zhang@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 16, 2020 at 1:57 PM Hawking Zhang <Hawking.Zhang@amd.com> wrote:
>
> discovery tmr size should be ASIC specific setting, instead
> of fixed 64KB for all ASICs.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 58 ++++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 12 +++---
>  3 files changed, 39 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 63eab0c..792fe16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -756,7 +756,6 @@ struct amdgpu_device {
>         uint8_t                         *bios;
>         uint32_t                        bios_size;
>         struct amdgpu_bo                *stolen_vga_memory;
> -       struct amdgpu_bo                *discovery_memory;
>         uint32_t                        bios_scratch_reg_offset;
>         uint32_t                        bios_scratch[AMDGPU_BIOS_NUM_SCRATCH];
>
> @@ -908,7 +907,9 @@ struct amdgpu_device {
>         struct amdgpu_display_manager dm;
>
>         /* discovery */
> -       uint8_t                         *discovery;
> +       uint8_t                         *discovery_bin;
> +       uint32_t                        discovery_tmr_size;
> +       struct amdgpu_bo                *discovery_memory;
>
>         /* mes */
>         bool                            enable_mes;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index f950927..800cc78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -135,9 +135,10 @@ static int hw_id_map[MAX_HWIP] = {
>  static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *binary)
>  {
>         uint64_t vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
> -       uint64_t pos = vram_size - DISCOVERY_TMR_SIZE;
> +       uint64_t pos = vram_size - adev->discovery_tmr_size;
>
> -       amdgpu_device_vram_access(adev, pos, (uint32_t *)binary, DISCOVERY_TMR_SIZE, false);
> +       amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
> +                                 adev->discovery_tmr_size, false);
>         return 0;
>  }
>
> @@ -169,17 +170,18 @@ int amdgpu_discovery_init(struct amdgpu_device *adev)
>         uint16_t checksum;
>         int r;
>
> -       adev->discovery = kzalloc(DISCOVERY_TMR_SIZE, GFP_KERNEL);
> -       if (!adev->discovery)
> +       adev->discovery_tmr_size = DISCOVERY_TMR_SIZE;
> +       adev->discovery_bin = kzalloc(adev->discovery_tmr_size, GFP_KERNEL);
> +       if (!adev->discovery_bin)
>                 return -ENOMEM;
>
> -       r = amdgpu_discovery_read_binary(adev, adev->discovery);
> +       r = amdgpu_discovery_read_binary(adev, adev->discovery_bin);
>         if (r) {
>                 DRM_ERROR("failed to read ip discovery binary\n");
>                 goto out;
>         }
>
> -       bhdr = (struct binary_header *)adev->discovery;
> +       bhdr = (struct binary_header *)adev->discovery_bin;
>
>         if (le32_to_cpu(bhdr->binary_signature) != BINARY_SIGNATURE) {
>                 DRM_ERROR("invalid ip discovery binary signature\n");
> @@ -192,7 +194,7 @@ int amdgpu_discovery_init(struct amdgpu_device *adev)
>         size = bhdr->binary_size - offset;
>         checksum = bhdr->binary_checksum;
>
> -       if (!amdgpu_discovery_verify_checksum(adev->discovery + offset,
> +       if (!amdgpu_discovery_verify_checksum(adev->discovery_bin + offset,
>                                               size, checksum)) {
>                 DRM_ERROR("invalid ip discovery binary checksum\n");
>                 r = -EINVAL;
> @@ -202,7 +204,7 @@ int amdgpu_discovery_init(struct amdgpu_device *adev)
>         info = &bhdr->table_list[IP_DISCOVERY];
>         offset = le16_to_cpu(info->offset);
>         checksum = le16_to_cpu(info->checksum);
> -       ihdr = (struct ip_discovery_header *)(adev->discovery + offset);
> +       ihdr = (struct ip_discovery_header *)(adev->discovery_bin + offset);
>
>         if (le32_to_cpu(ihdr->signature) != DISCOVERY_TABLE_SIGNATURE) {
>                 DRM_ERROR("invalid ip discovery data table signature\n");
> @@ -210,7 +212,7 @@ int amdgpu_discovery_init(struct amdgpu_device *adev)
>                 goto out;
>         }
>
> -       if (!amdgpu_discovery_verify_checksum(adev->discovery + offset,
> +       if (!amdgpu_discovery_verify_checksum(adev->discovery_bin + offset,
>                                               ihdr->size, checksum)) {
>                 DRM_ERROR("invalid ip discovery data table checksum\n");
>                 r = -EINVAL;
> @@ -220,9 +222,9 @@ int amdgpu_discovery_init(struct amdgpu_device *adev)
>         info = &bhdr->table_list[GC];
>         offset = le16_to_cpu(info->offset);
>         checksum = le16_to_cpu(info->checksum);
> -       ghdr = (struct gpu_info_header *)(adev->discovery + offset);
> +       ghdr = (struct gpu_info_header *)(adev->discovery_bin + offset);
>
> -       if (!amdgpu_discovery_verify_checksum(adev->discovery + offset,
> +       if (!amdgpu_discovery_verify_checksum(adev->discovery_bin + offset,
>                                               ghdr->size, checksum)) {
>                 DRM_ERROR("invalid gc data table checksum\n");
>                 r = -EINVAL;
> @@ -232,16 +234,16 @@ int amdgpu_discovery_init(struct amdgpu_device *adev)
>         return 0;
>
>  out:
> -       kfree(adev->discovery);
> -       adev->discovery = NULL;
> +       kfree(adev->discovery_bin);
> +       adev->discovery_bin = NULL;
>
>         return r;
>  }
>
>  void amdgpu_discovery_fini(struct amdgpu_device *adev)
>  {
> -       kfree(adev->discovery);
> -       adev->discovery = NULL;
> +       kfree(adev->discovery_bin);
> +       adev->discovery_bin = NULL;
>  }
>
>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
> @@ -258,13 +260,13 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>         int hw_ip;
>         int i, j, k;
>
> -       if (!adev->discovery) {
> +       if (!adev->discovery_bin) {
>                 DRM_ERROR("ip discovery uninitialized\n");
>                 return -EINVAL;
>         }
>
> -       bhdr = (struct binary_header *)adev->discovery;
> -       ihdr = (struct ip_discovery_header *)(adev->discovery +
> +       bhdr = (struct binary_header *)adev->discovery_bin;
> +       ihdr = (struct ip_discovery_header *)(adev->discovery_bin +
>                         le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
>         num_dies = le16_to_cpu(ihdr->num_dies);
>
> @@ -272,7 +274,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>
>         for (i = 0; i < num_dies; i++) {
>                 die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
> -               dhdr = (struct die_header *)(adev->discovery + die_offset);
> +               dhdr = (struct die_header *)(adev->discovery_bin + die_offset);
>                 num_ips = le16_to_cpu(dhdr->num_ips);
>                 ip_offset = die_offset + sizeof(*dhdr);
>
> @@ -286,7 +288,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>                                 le16_to_cpu(dhdr->die_id), num_ips);
>
>                 for (j = 0; j < num_ips; j++) {
> -                       ip = (struct ip *)(adev->discovery + ip_offset);
> +                       ip = (struct ip *)(adev->discovery_bin + ip_offset);
>                         num_base_address = ip->num_base_address;
>
>                         DRM_DEBUG("%s(%d) #%d v%d.%d.%d:\n",
> @@ -335,24 +337,24 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
>         uint16_t num_ips;
>         int i, j;
>
> -       if (!adev->discovery) {
> +       if (!adev->discovery_bin) {
>                 DRM_ERROR("ip discovery uninitialized\n");
>                 return -EINVAL;
>         }
>
> -       bhdr = (struct binary_header *)adev->discovery;
> -       ihdr = (struct ip_discovery_header *)(adev->discovery +
> +       bhdr = (struct binary_header *)adev->discovery_bin;
> +       ihdr = (struct ip_discovery_header *)(adev->discovery_bin +
>                         le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
>         num_dies = le16_to_cpu(ihdr->num_dies);
>
>         for (i = 0; i < num_dies; i++) {
>                 die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
> -               dhdr = (struct die_header *)(adev->discovery + die_offset);
> +               dhdr = (struct die_header *)(adev->discovery_bin + die_offset);
>                 num_ips = le16_to_cpu(dhdr->num_ips);
>                 ip_offset = die_offset + sizeof(*dhdr);
>
>                 for (j = 0; j < num_ips; j++) {
> -                       ip = (struct ip *)(adev->discovery + ip_offset);
> +                       ip = (struct ip *)(adev->discovery_bin + ip_offset);
>
>                         if (le16_to_cpu(ip->hw_id) == hw_id) {
>                                 if (major)
> @@ -375,13 +377,13 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
>         struct binary_header *bhdr;
>         struct gc_info_v1_0 *gc_info;
>
> -       if (!adev->discovery) {
> +       if (!adev->discovery_bin) {
>                 DRM_ERROR("ip discovery uninitialized\n");
>                 return -EINVAL;
>         }
>
> -       bhdr = (struct binary_header *)adev->discovery;
> -       gc_info = (struct gc_info_v1_0 *)(adev->discovery +
> +       bhdr = (struct binary_header *)adev->discovery_bin;
> +       gc_info = (struct gc_info_v1_0 *)(adev->discovery_bin +
>                         le16_to_cpu(bhdr->table_list[GC].offset));
>
>         adev->gfx.config.max_shader_engines = le32_to_cpu(gc_info->gc_num_se);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index ae1b00d..967f6d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1819,15 +1819,15 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>                 return r;
>
>         /*
> -        * reserve one TMR (64K) memory at the top of VRAM which holds
> +        * reserve TMR memory at the top of VRAM which holds
>          * IP Discovery data and is protected by PSP.
>          */
>         r = amdgpu_bo_create_kernel_at(adev,
> -                                      adev->gmc.real_vram_size - DISCOVERY_TMR_SIZE,
> -                                      DISCOVERY_TMR_SIZE,
> -                                      AMDGPU_GEM_DOMAIN_VRAM,
> -                                      &adev->discovery_memory,
> -                                      NULL);
> +                       adev->gmc.real_vram_size - adev->discovery_tmr_size,
> +                       adev->discovery_tmr_size,
> +                       AMDGPU_GEM_DOMAIN_VRAM,
> +                       &adev->discovery_memory,
> +                       NULL);

The indentation looks wrong here.  With that fixed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>         if (r)
>                 return r;
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
