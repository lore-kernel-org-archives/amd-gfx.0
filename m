Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D1EC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 11:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDE210E353;
	Mon,  6 Jul 2026 11:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BujReDTG";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B62210E353
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 11:36:19 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-92e533aacf2so129124285a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2026 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783337778; x=1783942578; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eI2RFBADatE519dR/g8Z358f1+0B3inK+oU4BAAsg9w=;
 b=BujReDTGEJTFP6aAuKic2+aRZMrBPx/BlZZVCseK78l97U/pgKGZi/bsKIkP/J+iGF
 hPJhVqcwzRJrEbishF3JlSKJeKQBm1Q4tELM6ziCQkxEsVpmY8TTcoWFoKwG+GCjjH/g
 0V/sW5EGw+w8GDoQV98KZbhIXRLZfW+6qRaxzjmm2xvS+l+OscynL5jQOeofrpxlUcCa
 j6NkXkawmjVmOrQQ6Qhg07wKkzIuNWrsczr4y2fHRbrPimvI2v/kgwzIYXnX5EfXDQSU
 sKn761hARe1nrDJhRiSphIeSGL8Zvxgq0C/2rfsW+jxVvB6HJHB4p3XezyIfXYAQpzQ5
 rIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783337778; x=1783942578;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eI2RFBADatE519dR/g8Z358f1+0B3inK+oU4BAAsg9w=;
 b=CKNs69zmxrqBcfYtGP/3vegvtIU3fWXlnlan6VCONqzkkanx7ZD8BZgUZYc4Kb+eNl
 S+uqHqfhfzWZ7xLOi4ttyRZPbJTpNbqNu6WTmerF14FWEZJEwyJvB69JLnWrkU+0aWsI
 UcrVoiicmq5SgUS6k3LOlRCW6VbgwsiBckl1PAdfygI1uEePAgcm76XvmEUisPzAQuzH
 bKUbqmj/DpSubo2EHXtRzGgaUieWPy5RcE8d1J/Nxy1p5yOlNQjpTBCZ58MfG/fmYk0Q
 W/wF47NIN3/4jhJOv/nFq/gRybyBtCOeV0Z+gPpJKUNhLJSYbkOlAoMc3Q+stAF3n7He
 uNJw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUrFMeV70VKECMHljIJG7TvLD+vEyRUCeXXNC4rMbt52byjvNYKNCSgLBmjUF5GX8cs3D9vFUr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyemWcD4mVkfDUCHZT+zqKIX0HeEY3vaw9PeWOFQw66YnPEhOEk
 Oa3q9V+MiFULjMfnMqkZ+xmbjLzlDM0yxyEvoFXfnjoGtq/ymEp+rVrY
X-Gm-Gg: AfdE7clqLnXh5qySBPwtf3V8kYJgqL18ikVc5xViPh8UKTWnW/uzc09JowoIkWmfCnO
 RE8L1HlxhvR4zdWllfTfZQsPs41PaSfJTYjD+pvJyJwY/aX2Cnl0bjne16YWTXndExiCY9C79iU
 3SWEzLWTRNYiU/dRWq+3fPszW4N20QenSVA7/QlUltLWygq/o/+KoF1B1AYlvgt9RwRla/OV6ff
 tWS4iGRLG8mMv6syYogYhfrYERFSUkmW6y94pI0mWTMooKcUJkc+iUaZpGmxVTACWiBJ51/NnhS
 0pmmkAfSuPIChOsHudil3ik3FjgnaB1QQndfqrCl8loG6s7tOMSe2nj/xRzqiqpw3cWXsnKNvOx
 u1NTceQs+WV3jOCKxduh8RLkRUuyCXLRAC5L25huSWjHZkOMFTPq+Po3+bhNarkLlieA+Dd5ExU
 6DjRkWxoOR8pbycnkI5mQsySABLh1flq28raZ0WyKKZnDW
X-Received: by 2002:a05:620a:4486:b0:928:f440:2dc7 with SMTP id
 af79cd13be357-92ebb5dec59mr16408385a.35.1783337777641; 
 Mon, 06 Jul 2026 04:36:17 -0700 (PDT)
Received: from [10.254.122.221] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90cfe34dsm947412485a.46.2026.07.06.04.36.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jul 2026 04:36:17 -0700 (PDT)
Message-ID: <48d65314-02fd-401e-b2a6-1b09c6f8da5f@gmail.com>
Date: Mon, 6 Jul 2026 13:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: read FB through BAR0 when aperture is
 unavailable
To: chong li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: HaiJun.Chang@amd.com, Emily.Deng@amd.com, Cursor <cursoragent@cursor.com>
References: <20260701055355.20478-1-chongli2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260701055355.20478-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 7/1/26 07:53, chong li wrote:
> Allow early VRAM reads to fall back to a temporary BAR0 mapping
> when the normal aperture mapping has not been established yet.

Clear NAK.

You are just trying to fix a symptom of incorrect initialization order here.

Regards,
Christian.

> 
> Signed-off-by: chong li <chongli2@amd.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 43 +++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5442a1fc1c37..610d82b79de3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -743,6 +743,44 @@ void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
>  	drm_dev_exit(idx);
>  }
>  
> +static int amdgpu_device_read_fb_via_bar0(struct amdgpu_device *adev,
> +					  u64 offset, void *buf, size_t size)
> +{
> +	resource_size_t bar_start, bar_size, map_base;
> +	void __iomem *vram;
> +	size_t map_offset, map_size;
> +	unsigned long flags;
> +	u64 end;
> +
> +	if (!buf || !size)
> +		return -EINVAL;
> +
> +	flags = pci_resource_flags(adev->pdev, 0);
> +	if ((flags & IORESOURCE_UNSET) || !(flags & IORESOURCE_MEM))
> +		return -EINVAL;
> +
> +	bar_size = pci_resource_len(adev->pdev, 0);
> +	if (!bar_size)
> +		return -ENODEV;
> +
> +	if (check_add_overflow(offset, size, &end) || end > bar_size)
> +		return -EINVAL;
> +
> +	bar_start = pci_resource_start(adev->pdev, 0);
> +	map_offset = offset_in_page(offset);
> +	map_base = bar_start + (offset & PAGE_MASK);
> +	map_size = PAGE_ALIGN(map_offset + size);
> +
> +	vram = ioremap_wc(map_base, map_size);
> +	if (!vram)
> +		return -ENOMEM;
> +
> +	memcpy_fromio(buf, (u8 __iomem *)vram + map_offset, size);
> +	iounmap(vram);
> +
> +	return 0;
> +}
> +
>  /**
>   * amdgpu_device_aper_access - access vram by vram aperture
>   *
> @@ -762,8 +800,11 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
>  	size_t count = 0;
>  	uint64_t last;
>  
> -	if (!adev->mman.aper_base_kaddr)
> +	if (!adev->mman.aper_base_kaddr) {
> +		if (!write && !amdgpu_device_read_fb_via_bar0(adev, pos, buf, size))
> +			return size;
>  		return 0;
> +	}
>  
>  	last = min(pos + size, adev->gmc.visible_vram_size);
>  	if (last > pos) {

