Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B10D5C0CF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 14:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA0410E9CE;
	Fri,  8 Nov 2024 14:23:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bA0xG7X0";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 795E710E953
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 09:58:23 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-539e690479cso1862579e87.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Nov 2024 01:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731059901; x=1731664701; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5H92Szh7zfoJ1X3k0f3O/M8Kef9HnGfDZM9F62PdTF8=;
 b=bA0xG7X0gOhixolLNx/weTbVgAWqN1evm3jZ4e+Ta9m9uUh0LGBwFGKAMc8kNdXh5v
 b+ZoQyWdEs0Y1eRE2sTd3ujQldYWDdLdHV6D+XJxgUTbDBUOqRRqMVvMr6ZHwqwpr9um
 p8p5gVzIxtkxcReIxUvgn0NKEp8HvrI8fofFmhVB8J4aJw84H2ecFFdY9F/+Dc+jTzSi
 Mb7EmWKMbnm3o8AwVeqtmHC8gN8jW37kiAtYAtDl5BirioOsRoKiihVIjM1YillNlGZY
 NGVZuA1gJugAZoCf9MIRdnGRAlFTXPnjbhCsx9bE6sQNYWv9HpkACEGYFYEwioFOMdMb
 AQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731059901; x=1731664701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5H92Szh7zfoJ1X3k0f3O/M8Kef9HnGfDZM9F62PdTF8=;
 b=XbQxTKbrRWY6dF9krJdXFeStn1rodf5AUZllIXZAhiR3zpfIoyhqN1icuqlpIjv8OX
 prdk/Knv8H2NUwtnSsFPI6aweD09JvRYyDcjU3yMdxFuOxYYoV8McLuuIwpUddXhgDNe
 mBp3xtf5sZDfM40o0t0lbkyot2VrrG4lCZ1JEFVh9OW8IgdYMz3SY+4aQIx+1uEnh3Ne
 X6NvPBUUTQ7ntbehKv5h9CxbFOk5KlqLaBiQJomdSqcTX3af/FDd5XQ/PqAchL3GscA6
 jUUrUttGbBo6Xl0dW6T4Gr1hnAFRMUOXARboXt9wv3bHhQdhNfy8EAadOghvDsQXzlso
 vkfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtHPIrB/P7DyqM2B0iflD7cOZLw1qCa7cHiGPsm1dHahvdtXhQvEHvnLLQKkIb3tLBYIXsxkzX@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywf2MxZBQim8hfyHdDD6X2tGFtrtKHoWRxP8rFD7RUFi/5KoHTd
 4sNcsOpRsBbalgdXI7bHPBO7EjVE777nN7qdM1aR5dtWswnM/FesI+gzzdKyGa4=
X-Google-Smtp-Source: AGHT+IFRdqMG06HtkdzkHICdIIWrY7d6GXyCPZ8Qa2uAHGCAECQ9+blFxeuQwDqlNWgVG3erwh8s3g==
X-Received: by 2002:a05:6512:2256:b0:539:905c:15ab with SMTP id
 2adb3069b0e04-53d862e3e86mr1089619e87.32.1731059901467; 
 Fri, 08 Nov 2024 01:58:21 -0800 (PST)
Received: from [172.20.143.194] ([154.14.63.34])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432b05e6042sm57204805e9.44.2024.11.08.01.58.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 01:58:21 -0800 (PST)
Message-ID: <fe2f0356-ef90-4fc4-85c1-6a42da209b88@linaro.org>
Date: Fri, 8 Nov 2024 09:58:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] nvmem: core: calculate bin_attribute size
 through bin_size()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Frederic Barrat <fbarrat@linux.ibm.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Logan Gunthorpe <logang@deltatee.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-mtd@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
 <20241103-sysfs-const-bin_attr-v2-4-71110628844c@weissschuh.net>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20241103-sysfs-const-bin_attr-v2-4-71110628844c@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:23:15 +0000
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



On 03/11/2024 17:03, Thomas Weißschuh wrote:
> Stop abusing the is_bin_visible() callback to calculate the attribute
> size. Instead use the new, dedicated bin_size() one.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
Thanks for the patch,

LGTM.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

>   drivers/nvmem/core.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 33ffa2aa4c1152398ec66b8dd7b30384c5346a6e..63370c76394ee9b8d514da074779617cef67c311 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -303,11 +303,19 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct nvmem_device *nvmem = to_nvmem_device(dev);
>   
> -	attr->size = nvmem->size;
> -
>   	return nvmem_bin_attr_get_umode(nvmem);
>   }
>   
> +static size_t nvmem_bin_attr_size(struct kobject *kobj,
> +				  const struct bin_attribute *attr,
> +				  int i)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct nvmem_device *nvmem = to_nvmem_device(dev);
> +
> +	return nvmem->size;
> +}
> +
>   static umode_t nvmem_attr_is_visible(struct kobject *kobj,
>   				     struct attribute *attr, int i)
>   {
> @@ -383,6 +391,7 @@ static const struct attribute_group nvmem_bin_group = {
>   	.bin_attrs	= nvmem_bin_attributes,
>   	.attrs		= nvmem_attrs,
>   	.is_bin_visible = nvmem_bin_attr_is_visible,
> +	.bin_size	= nvmem_bin_attr_size,
>   	.is_visible	= nvmem_attr_is_visible,
>   };
>   
> 
