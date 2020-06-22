Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC39C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 13:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7440E20732
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 13:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUfbgdHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7440E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 511AB6E07D;
	Mon, 22 Jun 2020 13:18:17 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 855FA6E037;
 Mon, 22 Jun 2020 13:18:15 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id x16so5706505wmj.1;
 Mon, 22 Jun 2020 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=0YVc/qJS3uYaVW1XnYUha/kxsu6RL3eomb3xoesT22Y=;
 b=ZUfbgdHZPfi6VXHhZk3JHs+NAJf9fyA7ctFWlIdQdh9hMpk0onH7nGO6N0hgMo878D
 /NF6tXlvhP+Sw1KorHLDQjkknwInNESp1K9vKZPhpQewd3/BFk+oj6xybeQEM+rSV9np
 DaFZRbN1Z1cGRJKgEsdLcf6gOuGj9JguMEGw8FLfighdq6AFzBLljvnKVSqt8WXr4+zE
 jAJi4786uKTAyM4H8pkRIny+uOmjf8znjTMs6dE0RH8clVvI2Bb30OoOADfmhFunTd8H
 Z26/PLS+aVZoxNtCt6ilmkt3iwziYRw08NrH+OsiS+lGsFdSyCUX0xjhTM9BE03WBQNW
 QHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=0YVc/qJS3uYaVW1XnYUha/kxsu6RL3eomb3xoesT22Y=;
 b=GG3znSZpdlLbAONBv08Bm+QOdynzSjS5dVLNkOxfoncjUBlALN2wLqqrS+32Us3xN4
 Tbh1I+i2gS82WKZaR+awwKeNVYCllqZKxBw2fJ7/8NyPLqA+0cmxFrgmpel6jNAh3sde
 Tp5uomenSKLSNeexwgrlYuAVD7zRCoBizGZ3x8Sze/sLioJ1vxuSDzDvsd0rEixj7Dkc
 lyc7/yHAG7kvipeqDW3Odvyv/pj24Drwmf+PjpEAsffT5mLrWsHD1PyGc2MPTo34CXdw
 1GPOT/M8b0Hvw7Ec6No/Ix+Ejzp9Y6pC115q9/VeSYDfGIqploGmxghtUEPuFuJxvyAX
 fcRQ==
X-Gm-Message-State: AOAM533kep9DWajiT5sim2G6Zxk+qBX3SiXLs3fU47B3O9eWl0Haekqh
 s6T7t+pvC03wVUIZQXBH2HE39LKv
X-Google-Smtp-Source: ABdhPJw0uoJa9zcRNgv0uoXWmAnNe2zU34Qc6W9SZniPi3ni6HwPPVaIFcY18ffJLhniRgd1n7XUVg==
X-Received: by 2002:a7b:c248:: with SMTP id b8mr17749544wmj.2.1592831894204;
 Mon, 22 Jun 2020 06:18:14 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id z25sm1955783wmk.28.2020.06.22.06.18.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jun 2020 06:18:13 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] drm: Add dummy page per device or GEM object
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
 <1592719388-13819-2-git-send-email-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6809de08-2035-edda-ebd2-05e7f77a1068@gmail.com>
Date: Mon, 22 Jun 2020 15:18:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1592719388-13819-2-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: alexdeucher@gmail.com, daniel.vetter@ffwll.ch, michel@daenzer.net,
 ppaalanen@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.06.20 um 08:03 schrieb Andrey Grodzovsky:
> Will be used to reroute CPU mapped BO's page faults once
> device is removed.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/drm_file.c  |  8 ++++++++
>   drivers/gpu/drm/drm_prime.c | 10 ++++++++++
>   include/drm/drm_file.h      |  2 ++
>   include/drm/drm_gem.h       |  2 ++
>   4 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index c4c704e..67c0770 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -188,6 +188,12 @@ struct drm_file *drm_file_alloc(struct drm_minor *minor)
>   			goto out_prime_destroy;
>   	}
>   
> +	file->dummy_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!file->dummy_page) {
> +		ret = -ENOMEM;
> +		goto out_prime_destroy;
> +	}
> +
>   	return file;
>   
>   out_prime_destroy:
> @@ -284,6 +290,8 @@ void drm_file_free(struct drm_file *file)
>   	if (dev->driver->postclose)
>   		dev->driver->postclose(dev, file);
>   
> +	__free_page(file->dummy_page);
> +
>   	drm_prime_destroy_file_private(&file->prime);
>   
>   	WARN_ON(!list_empty(&file->event_list));
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 1de2cde..c482e9c 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -335,6 +335,13 @@ int drm_gem_prime_fd_to_handle(struct drm_device *dev,
>   
>   	ret = drm_prime_add_buf_handle(&file_priv->prime,
>   			dma_buf, *handle);
> +
> +	if (!ret) {
> +		obj->dummy_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +		if (!obj->dummy_page)
> +			ret = -ENOMEM;
> +	}
> +

While the per file case still looks acceptable this is a clear NAK since 
it will massively increase the memory needed for a prime exported object.

I think that this is quite overkill in the first place and for the hot 
unplug case we can just use the global dummy page as well.

Christian.

>   	mutex_unlock(&file_priv->prime.lock);
>   	if (ret)
>   		goto fail;
> @@ -1006,6 +1013,9 @@ void drm_prime_gem_destroy(struct drm_gem_object *obj, struct sg_table *sg)
>   		dma_buf_unmap_attachment(attach, sg, DMA_BIDIRECTIONAL);
>   	dma_buf = attach->dmabuf;
>   	dma_buf_detach(attach->dmabuf, attach);
> +
> +	__free_page(obj->dummy_page);
> +
>   	/* remove the reference */
>   	dma_buf_put(dma_buf);
>   }
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 19df802..349a658 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -335,6 +335,8 @@ struct drm_file {
>   	 */
>   	struct drm_prime_file_private prime;
>   
> +	struct page *dummy_page;
> +
>   	/* private: */
>   #if IS_ENABLED(CONFIG_DRM_LEGACY)
>   	unsigned long lock_count; /* DRI1 legacy lock count */
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 0b37506..47460d1 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -310,6 +310,8 @@ struct drm_gem_object {
>   	 *
>   	 */
>   	const struct drm_gem_object_funcs *funcs;
> +
> +	struct page *dummy_page;
>   };
>   
>   /**

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
