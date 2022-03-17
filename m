Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E26C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 14:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE05110EB6C;
	Thu, 17 Mar 2022 14:23:20 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3949A10E624
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 14:19:38 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id h16so2637278wmd.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 07:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=vOnzxJlH628gKK791oOxGy9dmx+tXiUp5rK1D8p/Qyc=;
 b=kDa19YjHt8tRsYBiCBRfz6pxQ6UQoy4iCEQZlW16D9UkkNnJ5lJWdzG5326YcKXBbe
 wXqwKuhekffzEpU/DSQxmw8BngtaGdfZqJb+dcnZFsBEvsulNkyI+Ewh6bkGRNbnsNL3
 iTsuRvUa5JouyV37vWooKUnnwgTmoilWrVXbPZqGYIkHky8DmZ7n4SzCUBsggTqvfvRK
 5JwbkPO2e5PRQCviaoDuQaaHS8QpAIMPmrOTTm6DFGb55TOkSyDDwA6xan0PlhGk4R26
 FPZPX7kc3a+Taa39eA1Ls/isLKM7mMxkqlekhijkOVXc2WWIowYHwAPx9xa+rzaDIC3u
 7YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vOnzxJlH628gKK791oOxGy9dmx+tXiUp5rK1D8p/Qyc=;
 b=55y1EezLapJrui4plXZsi2bQJro6C50WLhJpbyt+lI9XMjzpFsdRJ1fTwpmdO46ffE
 U4HvBIg9MiykiGaKBDwZ1WmaAcUmaLvN9bgRAkktF6st+ciSLCO/Cp0Mh0REkuv5XEzP
 PxHYQa48IsZ3X37igEU1dowetvw4JOLO32daDYn8MSdIkNp0WfX7AuYaiUqlFwStMuex
 cZHWS9hTrT5g9UdqxMJZ3NXLI6oEr0Xq8O+TdUsPkno5nHffrfC+yIvKVk6y4UKyIPGT
 v/pXuXqSlrr3Lzygt9SSOmLEzGklquj5vCS+mbZbPZBKW0YMO/uJs3lEatQCgn+2Qu/U
 TV+g==
X-Gm-Message-State: AOAM532k5mr4DmCJWYJj3q/MsS0avP4asBa0mBf3P8Va0FuQam9NgzJJ
 tNSNl9P30ITsX5Mrq7tezy8gOMYL9JnsLQ==
X-Google-Smtp-Source: ABdhPJxHZZo33eVHgCXtOwWiAcwRItKQpqcB0Hn2WCbkLjhRmwjh4xDZTHa0HI9wyEJ/oy2JZF1G3w==
X-Received: by 2002:a05:600c:3c9f:b0:38c:6dc6:6de2 with SMTP id
 bg31-20020a05600c3c9f00b0038c6dc66de2mr6739347wmb.132.1647526776607; 
 Thu, 17 Mar 2022 07:19:36 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 v20-20020a7bcb54000000b0037fa63db8aasm7975546wmj.5.2022.03.17.07.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 07:19:35 -0700 (PDT)
Date: Thu, 17 Mar 2022 14:19:33 +0000
From: Lee Jones <lee.jones@linaro.org>
To: linux-kernel@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/1] drm/amdkfd: Protect the Client whilst it is being
 operated on
Message-ID: <YjNDdXXOMYNuHJcV@google.com>
References: <20220317131610.554347-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317131610.554347-1-lee.jones@linaro.org>
X-Mailman-Approved-At: Thu, 17 Mar 2022 14:23:19 +0000
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

On Thu, 17 Mar 2022, Lee Jones wrote:

> Presently the Client can be freed whilst still in use.
> 
> Use the already provided lock to prevent this.
> 
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

I should have clarified here, that:

This patch has only been *build* tested.

Since I have no way to run this on real H/W.

Please ensure this is tested on real H/W before it gets applied, since
it *may* have some undesired side-effects.  For instance, I have no
idea if client->lock plays nicely with dev->smi_lock or whether this
may well end up in deadlock.

TIA.

>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index e4beebb1c80a2..3b9ac1e87231f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -145,8 +145,11 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
>  	spin_unlock(&dev->smi_lock);
>  
>  	synchronize_rcu();
> +
> +	spin_lock(&client->lock);
>  	kfifo_free(&client->fifo);
>  	kfree(client);
> +	spin_unlock(&client->lock);
>  
>  	return 0;
>  }
> @@ -247,11 +250,13 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>  		return ret;
>  	}
>  
> +	spin_lock(&client->lock);
>  	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops, (void *)client,
>  			       O_RDWR);
>  	if (ret < 0) {
>  		kfifo_free(&client->fifo);
>  		kfree(client);
> +		spin_unlock(&client->lock);
>  		return ret;
>  	}
>  	*fd = ret;
> @@ -264,6 +269,7 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>  	spin_lock(&dev->smi_lock);
>  	list_add_rcu(&client->list, &dev->smi_clients);
>  	spin_unlock(&dev->smi_lock);
> +	spin_unlock(&client->lock);
>  
>  	return 0;
>  }

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
