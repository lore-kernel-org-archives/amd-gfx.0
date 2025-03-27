Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0994CC3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 14:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B9F10E114;
	Thu, 27 Mar 2025 14:26:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gkCkz0b6";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D5C110E114
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 14:26:26 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso7927025e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 07:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743085585; x=1743690385; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s55KwJr+/FuR7bE4QMYHxcXv8x9fjSVO+xJCNHycRT4=;
 b=gkCkz0b6gyOswd+yLF+4nEfC4UZnu/D5tbDDKp5unQ9bH3avUPiaLVpfOR6QH5k9mp
 7CrySeTOfPaQ2d2jN3OZkYSXPBqmTYRaiezOa+lCFBajA87KFZlS03Rw4xqsFCO0rHIC
 cZHn+KFR5r60Y8O4X15oy2dOxeicesMsJ7d2a6iiFnUodmuWswVcOOal5ct+JgN4PsZy
 RNllByOg0GmkpI32qOkiSbCvUNzrCjCqNxvEBmyjvpQdEI/yimHOz3b3qvsU8SGuHXgY
 ezL7x1dSMIdiBg/VtglmnkjPLG7XpNru42BP43yCzCo9KB5t/oOYHq5jODujGXGCvZf2
 aibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743085585; x=1743690385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s55KwJr+/FuR7bE4QMYHxcXv8x9fjSVO+xJCNHycRT4=;
 b=LnwszWAF0edUH8SrCazyK1EtqsnwneOkJigyECIaCqTFRggAxr/QWioyIlSxGDSuF1
 OLx+lo2uEd5TsN4+BdrlU3BYnUf8iP9uh9YCR8ny255xC2V1MM0zk+RQjw3gpwdrekpU
 u20KKGNtq/WvUB2ukfYSavW/5rqRYCwVWVNeaCRr0M+mqNZPR7bNcOoRzijkYwcVXA0a
 8g7pM0pfcyt5Wl+JNntfN7qN8ujOOsCvBjTr15TW6MxaOtGsYVYdomEFaaZh9XbqO4pe
 xhXNmLAYOzDp0iDwiXECGNsYIVbn+1U/lExXLKehI8JPX/6Zcq1EToTlgbWEt12eS0rH
 YY6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7aobwg+vmVu+sNu7ppdX0/4+OZN4L6thxYjqHzNYLH/OsTCphnKS96fZQLVV7+4npKmwnTLbe@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwP+Uk/+o+vnGBMQ2g0f7Uk3XlmYipx45I/Z06J+cWkJoT3W8wm
 Ne5uv8xQXzNXxn9iUw84KATsRi/UltFdInPsUt+GEq7QiXF+AHO7
X-Gm-Gg: ASbGncujeajUVe0PtaS7WPNw8By5o5ERrKupCO6+avLMj6EKEo10Sxvv1OZ826IRvL/
 RaPlWq5TF1MhnvEsFrkHSjL2VaeLMW6PCbz8De2vfQ3Qnoilxab4ISf8xSHnM5WCsXvGSRTUiqP
 jzxZOz0VmA5+YXFy3QV2xYd00T8wNa51FkIfDQkCggMwUKgzyjudH87OmxYsmXStBh/S+1mmjDC
 LNvwkojK1jxKiVGuJ/VuIw+RVG9JKbGnmuVfvkrGLoe7UTGNJSN5H7P+yhiCYZRfLjbFAVgQdla
 0pygppRnGGBro9h533YF4ArD+tkVYQaMK84eqNsKn9gY9jmj76s/RIrFbn1klBQJ+1uvIob0Uw=
 =
X-Google-Smtp-Source: AGHT+IGkBxBYJAzATjmAv5cUbBilnirvGyKZJtX/yXzIyLDyRiEQcklzMML0DLyiG2RBL9vdZfrRfA==
X-Received: by 2002:a05:600c:3d8c:b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-43d871ac058mr28706765e9.13.1743085584571; 
 Thu, 27 Mar 2025 07:26:24 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d830f5f22sm39072535e9.30.2025.03.27.07.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 07:26:24 -0700 (PDT)
Message-ID: <9dd129db-8877-4496-996e-2353561a67d5@gmail.com>
Date: Thu, 27 Mar 2025 15:26:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0] kernel: resource: add
 devm_request_free_mem_region_from_end()
To: Bert Karwatzki <spasswolf@web.de>, Ingo Molnar <mingo@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Balbir Singh <balbirs@nvidia.com>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20250327120216.14083-1-spasswolf@web.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250327120216.14083-1-spasswolf@web.de>
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

Am 27.03.25 um 13:02 schrieb Bert Karwatzki:
> devm_request_free_mem_region() places resources at the end of the
> physical address space, DIRECT_MAP_PHYSMEM_END. If the the dma mask
> of a pci device is smaller than DIRECT_MAP_PHSYMEM_END then this
> resource is not dma accessible by the device which can cause the
> device to fallback to using 32bit dma which can lead to severe
> performance impacts.
>
> This adds the devm_request_free_mem_region_from_end() function which
> allows to select the endpoint from which to place the resource
> independently from DIRECT_MAP_PHYSMEM_END.

Adding Felix and Philip as well. They need to take a look.

Regards,
Christian.

>
> Link: https://lore.kernel.org/all/20250322122351.3268-1-spasswolf@web.de/
>
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  3 ++-
>  include/linux/ioport.h                   |  3 +++
>  kernel/resource.c                        | 31 ++++++++++++++++++------
>  3 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index d05d199b5e44..e1942fef3637 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -1042,7 +1042,8 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
>  		pgmap->range.end = adev->gmc.aper_base + adev->gmc.aper_size - 1;
>  		pgmap->type = MEMORY_DEVICE_COHERENT;
>  	} else {
> -		res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
> +		res = devm_request_free_mem_region_from_end(adev->dev,
> +				&iomem_resource, size, dma_get_mask(adev->dev));
>  		if (IS_ERR(res))
>  			return PTR_ERR(res);
>  		pgmap->range.start = res->start;
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 5385349f0b8a..a9a765721ab4 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -407,6 +407,9 @@ walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
>
>  struct resource *devm_request_free_mem_region(struct device *dev,
>  		struct resource *base, unsigned long size);
> +struct resource *devm_request_free_mem_region_from_end(struct device *dev,
> +		struct resource *base, unsigned long size,
> +		resource_size_t seek_end);
>  struct resource *request_free_mem_region(struct resource *base,
>  		unsigned long size, const char *name);
>  struct resource *alloc_free_mem_region(struct resource *base,
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 12004452d999..82f40407c02d 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1875,12 +1875,14 @@ EXPORT_SYMBOL(resource_list_free);
>  #endif
>
>  static resource_size_t gfr_start(struct resource *base, resource_size_t size,
> -				 resource_size_t align, unsigned long flags)
> +				 resource_size_t align, resource_size_t seek_end,
> +				 unsigned long flags)
>  {
>  	if (flags & GFR_DESCENDING) {
>  		resource_size_t end;
>
>  		end = min_t(resource_size_t, base->end, DIRECT_MAP_PHYSMEM_END);
> +		end = min_t(resource_size_t, end, seek_end);
>  		return end - size + 1;
>  	}
>
> @@ -1920,8 +1922,8 @@ static void remove_free_mem_region(void *_res)
>  static struct resource *
>  get_free_mem_region(struct device *dev, struct resource *base,
>  		    resource_size_t size, const unsigned long align,
> -		    const char *name, const unsigned long desc,
> -		    const unsigned long flags)
> +		    resource_size_t seek_end, const char *name,
> +		    const unsigned long desc, const unsigned long flags)
>  {
>  	resource_size_t addr;
>  	struct resource *res;
> @@ -1946,7 +1948,7 @@ get_free_mem_region(struct device *dev, struct resource *base,
>  	}
>
>  	write_lock(&resource_lock);
> -	for (addr = gfr_start(base, size, align, flags);
> +	for (addr = gfr_start(base, size, align, seek_end, flags);
>  	     gfr_continue(base, addr, align, flags);
>  	     addr = gfr_next(addr, align, flags)) {
>  		if (__region_intersects(base, addr, size, 0, IORES_DESC_NONE) !=
> @@ -2021,17 +2023,30 @@ struct resource *devm_request_free_mem_region(struct device *dev,
>  	unsigned long flags = GFR_DESCENDING | GFR_REQUEST_REGION;
>
>  	return get_free_mem_region(dev, base, size, GFR_DEFAULT_ALIGN,
> -				   dev_name(dev),
> +				   DIRECT_MAP_PHYSMEM_END, dev_name(dev),
>  				   IORES_DESC_DEVICE_PRIVATE_MEMORY, flags);
>  }
>  EXPORT_SYMBOL_GPL(devm_request_free_mem_region);
>
> +struct resource *devm_request_free_mem_region_from_end(struct device *dev,
> +		struct resource *base, unsigned long size,
> +		resource_size_t seek_end)
> +{
> +	unsigned long flags = GFR_DESCENDING | GFR_REQUEST_REGION;
> +
> +	return get_free_mem_region(dev, base, size, GFR_DEFAULT_ALIGN,
> +				   seek_end, dev_name(dev),
> +				   IORES_DESC_DEVICE_PRIVATE_MEMORY, flags);
> +}
> +EXPORT_SYMBOL_GPL(devm_request_free_mem_region_from_end);
> +
>  struct resource *request_free_mem_region(struct resource *base,
>  		unsigned long size, const char *name)
>  {
>  	unsigned long flags = GFR_DESCENDING | GFR_REQUEST_REGION;
>
> -	return get_free_mem_region(NULL, base, size, GFR_DEFAULT_ALIGN, name,
> +	return get_free_mem_region(NULL, base, size, GFR_DEFAULT_ALIGN,
> +				   DIRECT_MAP_PHYSMEM_END, name,
>  				   IORES_DESC_DEVICE_PRIVATE_MEMORY, flags);
>  }
>  EXPORT_SYMBOL_GPL(request_free_mem_region);
> @@ -2055,8 +2070,8 @@ struct resource *alloc_free_mem_region(struct resource *base,
>  	/* Default of ascending direction and insert resource */
>  	unsigned long flags = 0;
>
> -	return get_free_mem_region(NULL, base, size, align, name,
> -				   IORES_DESC_NONE, flags);
> +	return get_free_mem_region(NULL, base, size, align, DIRECT_MAP_PHYSMEM_END,
> +				   name, IORES_DESC_NONE, flags);
>  }
>  EXPORT_SYMBOL_GPL(alloc_free_mem_region);
>  #endif /* CONFIG_GET_FREE_REGION */
> --
> 2.49.0
>
> One of the problems (I'm sure there are more ...) with this patch is that
> it uses dma_get_mask(adev->dev) as the endpoint from which to place the
> memory, but dma_get_mask(adev->dev) returns the dma mask of the discrete
> GPU, but what actually is needed to avoid the bug would be the dma mask
> of the built-in GPU. In my case both are equal (44bits), but I'm not
> sure if they are equal in all cases.
>
>> So this patch does the trick for Bert, and I'm wondering what the best
>> fix here would be overall, because it's a tricky situation.
>>
>> Am I correct in assuming that with enough physical memory this bug
>> would trigger, with and without nokaslr?
> I think the bug triggers as soon as DIRECT_MAP_PHYSMEM_END is bigger
> then the dma mask of the integrated GPU.
>
>> I *think* the best approach going forward would be to add the above
>> quirk the the x86 memory setup code, but also issue a kernel warning at
>> that point with all the relevant information included, so that the
>> driver's use_dma32 bug can at least be indicated?
>>
>> That might also trigger for other systems, because if this scenario is
>> so spurious, I doubt it's the only affected driver ...
>>
>> Thanks,
>>
>> 	Ingo
> Or one could make the endpoint from which the memory resource will be
> placed selectable.
>
> Bert Karwatzki

