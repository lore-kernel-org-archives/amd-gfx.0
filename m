Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BE2C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 14:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CF220721
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 14:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON4kgdL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CF220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CE06E936;
	Thu, 21 May 2020 14:16:25 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77FB6E937
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 14:16:23 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id l18so6815829wrn.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zK3J0XfQsUKokXTZOsOWwi78bejrut+PtOLaxC0xbPs=;
 b=ON4kgdL5U5LZyJ0XArEW4vQRkvHQHmXXLN0MDzhrEn8RKy+N4FwcqxKOgvbIUMgEQA
 WHBqIukjIV5TgGDdSX0o5yYeqHVsEcWSQB31RXs6UcpHkFPq2Br/6QEDyOs4fp64qtRe
 sKqQTRXsFfAenv+GSnoWJBubdvP5xC093c5PjFCLaUwDXRPR54xTceOIIRcQQQkNwvA6
 /XMu4y4glt8bOJK1hwPzufkEL/1xpgdSUozMoCHQyNCItFKbapOTK5AVnDLsbv6BISAg
 7cW3aqlb0d7sqMX594ERYYu+MCLB6MQI2xCB66dIR7Pjh0obU06RkpasMZLgSZDgpL3S
 U+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zK3J0XfQsUKokXTZOsOWwi78bejrut+PtOLaxC0xbPs=;
 b=F/AzkeJ1zZmCRo3waqIDTzYRpLTiyoH/ICuzjlL0y1avrJXUxsPPwoke3ABzgKGwGi
 L+dbsxrrEjPDvhaMOAkqPndibxDdRMIZqGUTrejBvaN2y7J3UjDdTm5UHtN9m+pk1OTn
 azSZbNidfHLxeyCN3d/LJONLDbAwjp0PvQhDJbWg6pYRtKsHewZuVQHw0NiLW2Sq6OkP
 wGVimgtUqXdbUPBsqQizQf1cHIvWnHJey0R9wGRRz9FU3o55L6QcGfYNMGaE9Ron4T2E
 IyR7cvBFSVIAI0e4ShTTAY1+cZzx1wIyTNAx45XTR7FnR7ZmSQHpf5a4tSgS5soKCsQD
 Sv7Q==
X-Gm-Message-State: AOAM5313hUkoPYMr0n8c/X6FB+6xB4JmOcLB+dS8QIJdwVsSpq6S2Fbd
 IG9X3T4aT8ZJ5RXaSw0A6rBuIyoEgEL8yMqCsohh3A==
X-Google-Smtp-Source: ABdhPJznkg7TUf+jONY7OqzQeFv127axMu1xgywh+8WZhuIWTVlHyy5oiEIsbozkqFDu3oki8jWp6iCdayfpOfoaGJ4=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr9250034wrp.419.1590070582443; 
 Thu, 21 May 2020 07:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200515183135.626855-1-alexander.deucher@amd.com>
In-Reply-To: <20200515183135.626855-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 May 2020 10:16:11 -0400
Message-ID: <CADnq5_P16h9KJ=gT3wfGU8Kg0XjrJVwZoFNqJC3U4G4_LNO37A@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: move discovery gfx config fetching
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series?  It fixes an ordering issue for raven2.

Alex

On Fri, May 15, 2020 at 2:31 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Move it into the fw_info function since it's logically part
> of the same functionality.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cc41e8f5ad14..bab1be7abdf0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1617,8 +1617,10 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>                         (const struct gpu_info_firmware_v1_0 *)(adev->firmware.gpu_info_fw->data +
>                                                                 le32_to_cpu(hdr->header.ucode_array_offset_bytes));
>
> -               if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
> +               if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10) {
> +                       amdgpu_discovery_get_gfx_info(adev);
>                         goto parse_soc_bounding_box;
> +               }
>
>                 adev->gfx.config.max_shader_engines = le32_to_cpu(gpu_info_fw->gc_num_se);
>                 adev->gfx.config.max_cu_per_sh = le32_to_cpu(gpu_info_fw->gc_num_cu_per_sh);
> @@ -1768,9 +1770,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>         if (r)
>                 return r;
>
> -       if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
> -               amdgpu_discovery_get_gfx_info(adev);
> -
>         amdgpu_amdkfd_device_probe(adev);
>
>         if (amdgpu_sriov_vf(adev)) {
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
