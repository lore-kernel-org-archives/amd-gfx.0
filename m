Return-Path: <SRS0=AVpe=EL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EE0C388F7
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 10:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 161312087D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 10:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvffOctS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161312087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF756E1D7;
	Thu,  5 Nov 2020 10:08:12 +0000 (UTC)
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68EBD6E1D7
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2020 10:08:11 +0000 (UTC)
Received: by mail-lj1-x243.google.com with SMTP id l10so957646lji.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2020 02:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eEue8Bau+pupF7CyTGHXC2yqWeY8Sj18qJXhmeK0+qY=;
 b=rvffOctSKYH+6isvUsZ6vjuDGiRiPXrriws2tYpmxIOJoDbVaUBBLJZNLsZfPTViCm
 OB7UJ7kJVc74V/wH1kAJWs50qUWe8BxYk+3Bh0Ntwrn4R80Kw+RHuzDoPIDkFuxVKOMP
 awvWPavfta6vj9AUR/6i26T0t+QGvBOviGEDNRn+gsaMK+rwApX3VuBwIy6OffxGwIGI
 Q9ElrJtiii5nM3Ug/hNAa7sMnYOfnIMkNbbQWWsd9e9E4LqYfoNACefZyIQWVQxYvven
 erCA3D+b6EoRTgIG3bxLlMg5PeozREFm5ydwy7sAu7xfjUKeSkZzmy6N/j40DftaLQPo
 OSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eEue8Bau+pupF7CyTGHXC2yqWeY8Sj18qJXhmeK0+qY=;
 b=U9hIhmejfXm+A16Upj2/60q5w3E/NlyYke0i2Ow76b2dYMxeF+uGYjRE//Wd5lU3xw
 zXRsyM9zZyc5Qnzi486/YXBVL6zfprEI7vkfQx/+SwOqsiFl+KTSGqoCYJtCoAXLErjz
 OPm2sFe4DA1h6mJS76yNQd0d27MxLapfC43RuRSsYEMQIMsXVq1n7SMmvQpKeYi3GlZ6
 yLAkimrtPqelCtClLggWa+3VzG/P2Ybb2VHT8f2yvJ/562G7vsE97xGNVD6+F8S0KbOW
 2F94tjrWgLBhbE8iH5ch7eVGWFA1ObYEw1hSPTnvEYgeEJi7jjDxGS+66ZMictreIjVz
 xi+A==
X-Gm-Message-State: AOAM533vX8CrTjR6aTeNv7fLJ/pJ5SyFJZebUcDRlcAd9T9caqHdjsGV
 zBrfC21yCBn1miCWeHN1KeAknWsf2d0mlSf8le/7eg==
X-Google-Smtp-Source: ABdhPJzTsAT/B7g6yG/tiOPWkhIyiq+coc///CuocOp+hPojlZHj2TddLjwWNxDtJai798d/HI10cYYk95MMhchsZzo=
X-Received: by 2002:a05:651c:1205:: with SMTP id
 i5mr658065lja.283.1604570889728; 
 Thu, 05 Nov 2020 02:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20201020122046.31167-1-tzimmermann@suse.de>
 <20201020122046.31167-10-tzimmermann@suse.de>
In-Reply-To: <20201020122046.31167-10-tzimmermann@suse.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Nov 2020 11:07:59 +0100
Message-ID: <CACRpkdbvGWKo8y323actUJn9xXmxpgDw1EKLiPH4RqB_kFx=XQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] dma-buf-map: Add memcpy and pointer-increment
 interfaces
To: Thomas Zimmermann <tzimmermann@suse.de>
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
Cc: luben.tuikov@amd.com, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Dave Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>, melissa.srw@gmail.com,
 Eric Anholt <eric@anholt.net>, ray.huang@amd.com,
 Gerd Hoffmann <kraxel@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Emil Velikov <emil.velikov@collabora.com>, Rob Herring <robh@kernel.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, lima@lists.freedesktop.org,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, steven.price@arm.com,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Kukjin Kim <kgene@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
 linux+etnaviv@armlinux.org.uk, spice-devel@lists.freedesktop.org,
 alyssa.rosenzweig@collabora.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 etnaviv@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Inki Dae <inki.dae@samsung.com>, Hans de Goede <hdegoede@redhat.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org,
 Sean Paul <sean@poorly.run>, apaneers@amd.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Sandy Huang <hjc@rock-chips.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Qinglang Miao <miaoqinglang@huawei.com>, yuq825@gmail.com,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Overall I like this, just an inline question:

On Tue, Oct 20, 2020 at 2:20 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:

> To do framebuffer updates, one needs memcpy from system memory and a
> pointer-increment function. Add both interfaces with documentation.

(...)
> +/**
> + * dma_buf_map_memcpy_to - Memcpy into dma-buf mapping
> + * @dst:       The dma-buf mapping structure
> + * @src:       The source buffer
> + * @len:       The number of byte in src
> + *
> + * Copies data into a dma-buf mapping. The source buffer is in system
> + * memory. Depending on the buffer's location, the helper picks the correct
> + * method of accessing the memory.
> + */
> +static inline void dma_buf_map_memcpy_to(struct dma_buf_map *dst, const void *src, size_t len)
> +{
> +       if (dst->is_iomem)
> +               memcpy_toio(dst->vaddr_iomem, src, len);
> +       else
> +               memcpy(dst->vaddr, src, len);
> +}

Are these going to be really big memcpy() operations?

Some platforms have DMA offload engines that can perform memcpy(),
drivers/dma, include/linux/dmaengine.h
especially if the CPU doesn't really need to touch the contents
and flush caches etc.
An example exist in some MTD drivers that move large quantities of
data off flash memory like this:
drivers/mtd/nand/raw/cadence-nand-controller.c

Notice that DMAengine and DMAbuf does not have much in common,
the names can be deceiving.

The value of this varies with the system architecture. It is not just
a question about performance but also about power and the CPU
being able to do other stuff in parallel for large transfers. So *when*
to use this facility to accelerate memcpy() is a delicate question.

What I'm after here is if these can be really big, do we want
(in the long run, not now) open up to the idea to slot in
hardware-accelerated memcpy() here?

Yours,
Linus Walleij
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
