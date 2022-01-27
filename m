Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769D4C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 08:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25F310E4B5;
	Thu, 27 Jan 2022 08:11:55 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4AC410E724
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 08:11:54 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id c23so3202418wrb.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 00:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=SCeyjR2kms9M93uXOg3g83+7cenWGRLGS6+bPyDFlFg=;
 b=D/AY2+hh8Ke0eLK03Vyh50hg2/H7/1H8dXTdg6O0PmCjBjNswjPtJYIIzVDFn1pJj7
 YYvRvNCq7P8xyCttxD6VtznkbO+kgOtNZu7SNr9jlKKRwrQnysJmkxm0N8buFEOEsPWL
 bF5/WRN+lxsnrHUXFlj+qvKovpeRIAg6aCi1flknTIFNrx78ryRIn4wFxEBF23ISMMSW
 uV20PZupaFgzGv/7sR2QguS9CJpzzLJBR9WguHozFmom1IuNsYT853mF0lOUz4dD5FXF
 Uq3R3ss/q8VWlIm8Td2mrOBtK6UZ/mIw0rW0Ga/zXlKJg39Y+kdH3N/1oFU9XB7HL9Oq
 BVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=SCeyjR2kms9M93uXOg3g83+7cenWGRLGS6+bPyDFlFg=;
 b=7J0/U+ueXBZib9fOoVTWLh+5fYHe/Evob8PUsXVU188eopSDFnEO0A9KRgD5ZMVojG
 bDEuj2fnsW5OfHxeyiEbq4JXNemO/Hbfh22K4dApS0S4kV/S7jFQtWqefBO+3XhmOom1
 MhqAOFDjqN7JfO2TjPlEAKOlR0Y/FV9G+07S+jRnoq6NERRPW9KeQlqYkEdfLpqfZ8hN
 CqiCs8aJpnOQ1cmgF7N1XdCKkAErlGi+jGLYLYMzzP1bsFbLJywuM/HZAc3UvlgE75oe
 GNpcSb5IiPDcRKmf5uMoMRP9GmXxEaDua6ZVv3L5VSpb3widnRBkNSD6EUUdResjp6sm
 TBSg==
X-Gm-Message-State: AOAM531EkmGH9Ll0n9Pw7zWTaWU4TRxbmH36sd6ggeK8JIubqa34o3rP
 1/VyERjM8GuX/HdDOxn1HxM=
X-Google-Smtp-Source: ABdhPJxJLqmNmYNXLch67OMvyzmM6l4dQSBtCjdu01Q5w5kGFZofYCRAaRzhTO3a3JKPb0G+EQYZ9w==
X-Received: by 2002:a05:6000:1548:: with SMTP id
 8mr2101321wry.232.1643271112461; 
 Thu, 27 Jan 2022 00:11:52 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id t4sm1463829wro.71.2022.01.27.00.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 00:11:52 -0800 (PST)
Message-ID: <e040dc1e-d865-7f0d-c64b-775ff57de240@gmail.com>
Date: Thu, 27 Jan 2022 09:11:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amd/amdgpu: Add ip_discovery_text sysfs entry (v2)
Content-Language: en-US
To: Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220125181835.2735521-1-tom.stdenis@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220125181835.2735521-1-tom.stdenis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



Am 25.01.22 um 19:18 schrieb Tom St Denis:
> Newer hardware has a discovery table in hardware that the kernel will
> rely on instead of header files for things like IP offsets.  This
> sysfs entry adds a simple to parse table of IP instances and segment
> offsets.
>
> Produces output that looks like:
>
> $ cat ip_discovery_text
> ATHUB{0} v2.0.0: 00000c00 02408c00
> CLKA{0} v11.0.0: 00016c00 02401800
> CLKA{1} v11.0.0: 00016e00 02401c00
> CLKA{2} v11.0.0: 00017000 02402000
> CLKA{3} v11.0.0: 00017200 02402400
> CLKA{4} v11.0.0: 0001b000 0242d800
> CLKB{0} v11.0.0: 00017e00 0240bc00
> DBGU_NBIO{0} v3.0.0: 000001c0 02409000
> DBGU0{0} v3.0.0: 00000180 02409800
> DBGU1{0} v3.0.0: 000001a0 02409c00
> DF{0} v3.0.0: 00007000 0240b800
> DFX{0} v4.1.0: 00000580 02409400
> DFX_DAP{0} v2.0.0: 000005a0 00b80000 0240c400
> DMU{0} v2.0.2: 00000012 000000c0 000034c0 00009000 02403c00
> FUSE{0} v11.0.0: 00017400 02401400
> GC{0} v10.1.10: 00001260 0000a000 02402c00

Mhm, I'm also leaning more into Alex direction that this should probably 
better represented as directory structure in sysfs.

We could expose the IP discovery table as binary, but parsing it first 
and then not building proper sysfs structures is pretty clearly against 
the documented rules.

Regards,
Christian.

>
> (v2): Use a macro for buffer size and fix alignment in amdgpu.h
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 79 ++++++++++++++++++-
>   2 files changed, 79 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3bc76759c143..43caeb4bdc07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1019,6 +1019,7 @@ struct amdgpu_device {
>   	struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
>   	uint32_t		        harvest_ip_mask;
>   	int				num_ip_blocks;
> +	char            *ip_discovery_text;
>   	struct mutex	mn_lock;
>   	DECLARE_HASHTABLE(mn_hash, 7);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 07623634fdc2..d036977dab8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -267,6 +267,19 @@ static void amdgpu_discovery_harvest_config_quirk(struct amdgpu_device *adev)
>   	}
>   }
>   
> +static ssize_t ip_discovery_text_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +	return sysfs_emit(buf, "%s", adev->ip_discovery_text);
> +}
> +
> +static DEVICE_ATTR(ip_discovery_text, S_IRUGO,
> +				ip_discovery_text_show, NULL);
> +
> +
>   static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   {
>   	struct table_info *info;
> @@ -351,6 +364,11 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   		goto out;
>   	}
>   
> +	// init sysfs for ip_discovery
> +	r = sysfs_create_file(&adev->dev->kobj, &dev_attr_ip_discovery_text.attr);
> +	if (r)
> +		dev_err(adev->dev, "Could not create amdgpu device attr\n");
> +
>   	return 0;
>   
>   out:
> @@ -363,7 +381,11 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   void amdgpu_discovery_fini(struct amdgpu_device *adev)
>   {
>   	kfree(adev->mman.discovery_bin);
> +	kfree(adev->ip_discovery_text);
> +	sysfs_remove_file(&adev->dev->kobj, &dev_attr_ip_discovery_text.attr);
> +
>   	adev->mman.discovery_bin = NULL;
> +	adev->ip_discovery_text = NULL;
>   }
>   
>   static int amdgpu_discovery_validate_ip(const struct ip *ip)
> @@ -382,6 +404,22 @@ static int amdgpu_discovery_validate_ip(const struct ip *ip)
>   	return 0;
>   }
>   
> +#define IP_DISCOVERY_BLOCK_SIZE 4096
> +
> +static int add_string(char **dst, unsigned *size, char *src)
> +{
> +	if (strlen(src) + strlen(*dst) >= *size) {
> +		void *tmp = krealloc(*dst, *size + IP_DISCOVERY_BLOCK_SIZE, GFP_KERNEL);
> +		if (!tmp) {
> +			return -1;
> +		}
> +		*dst = tmp;
> +		*size = *size + IP_DISCOVERY_BLOCK_SIZE;
> +	}
> +	strcat(*dst, src);
> +	return 0;
> +}
> +
>   int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   {
>   	struct binary_header *bhdr;
> @@ -396,6 +434,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   	int hw_ip;
>   	int i, j, k;
>   	int r;
> +	unsigned txt_size = IP_DISCOVERY_BLOCK_SIZE;
> +	char *linebuf;
>   
>   	r = amdgpu_discovery_init(adev);
>   	if (r) {
> @@ -410,6 +450,15 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   
>   	DRM_DEBUG("number of dies: %d\n", num_dies);
>   
> +	adev->ip_discovery_text = kzalloc(txt_size, GFP_KERNEL);
> +	linebuf = kzalloc(IP_DISCOVERY_BLOCK_SIZE, GFP_KERNEL);
> +	if (!adev->ip_discovery_text || !linebuf) {
> +		DRM_ERROR("Out of memory\n");
> +		kfree(linebuf);
> +		kfree(adev->ip_discovery_text);
> +		return -ENOMEM;
> +	}
> +
>   	for (i = 0; i < num_dies; i++) {
>   		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
>   		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
> @@ -419,6 +468,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   		if (le16_to_cpu(dhdr->die_id) != i) {
>   			DRM_ERROR("invalid die id %d, expected %d\n",
>   					le16_to_cpu(dhdr->die_id), i);
> +			kfree(linebuf);
> +			kfree(adev->ip_discovery_text);
>   			return -EINVAL;
>   		}
>   
> @@ -458,6 +509,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   			    le16_to_cpu(ip->hw_id) == SDMA3_HWID)
>   				adev->sdma.num_instances++;
>   
> +			snprintf(linebuf, IP_DISCOVERY_BLOCK_SIZE-1, "%s{%d} v%d.%d.%d: ",
> +				  hw_id_names[le16_to_cpu(ip->hw_id)],
> +				  ip->number_instance,
> +				  ip->major, ip->minor,
> +				  ip->revision);
> +			if (add_string(&adev->ip_discovery_text, &txt_size, linebuf)) {
> +				DRM_ERROR("Out of memory\n");
> +				kfree(linebuf);
> +				kfree(adev->ip_discovery_text);
> +				return -ENOMEM;
> +			}
> +
> +
>   			for (k = 0; k < num_base_address; k++) {
>   				/*
>   				 * convert the endianness of base addresses in place,
> @@ -465,6 +529,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   				 */
>   				ip->base_address[k] = le32_to_cpu(ip->base_address[k]);
>   				DRM_DEBUG("\t0x%08x\n", ip->base_address[k]);
> +				snprintf(linebuf, IP_DISCOVERY_BLOCK_SIZE-1, "%08lx ", (unsigned long)ip->base_address[k]);
> +				if (add_string(&adev->ip_discovery_text, &txt_size, linebuf)) {
> +					DRM_ERROR("Out of memory\n");
> +					kfree(linebuf);
> +					kfree(adev->ip_discovery_text);
> +					return -ENOMEM;
> +				}
> +			}
> +			if (add_string(&adev->ip_discovery_text, &txt_size, "\n")) {
> +				DRM_ERROR("Out of memory\n");
> +				kfree(linebuf);
> +				kfree(adev->ip_discovery_text);
> +				return -ENOMEM;
>   			}
>   
>   			for (hw_ip = 0; hw_ip < MAX_HWIP; hw_ip++) {
> @@ -491,7 +568,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
>   		}
>   	}
> -
> +	kfree(linebuf);
>   	return 0;
>   }
>   

