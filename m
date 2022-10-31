Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5101C38A02
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 12:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EABA10E1E7;
	Mon, 31 Oct 2022 12:19:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88DC10E1F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667218756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=riNVOBu8e2pIZERXBmAvmwAOPdhd6MsYxn78jTBB4dE=;
 b=OBolPdy1AF2o/wp/D6pjRilLNmLCu644iVdp5xYog2AGWhwfTXstwshmx++UNF4iRTd/IR
 jS9w5k7O4w9vyLefikbi3kfZncrS0YuBJ6WI0VA/zfuZcxwuMYDzb81+LuY9T31pd3vlIg
 mCYLNeoX02c0cqrZteXZnpM1aBeklys=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-eLcCz12hNFuk6yLueXgOuA-1; Mon, 31 Oct 2022 08:19:14 -0400
X-MC-Unique: eLcCz12hNFuk6yLueXgOuA-1
Received: by mail-wm1-f70.google.com with SMTP id
 az11-20020a05600c600b00b003c6e3d4d5b1so5224058wmb.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 05:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=riNVOBu8e2pIZERXBmAvmwAOPdhd6MsYxn78jTBB4dE=;
 b=kDakIGdmt4wjM4GvMxSmzfV4zqcI7rTVgHwAFo6q+pWniX7IGzrB8J0c1dVQojKnvg
 Nwh19Ir797sChUeICVtSHSi8qRngm1UBbiYEPI7+lTWqjfdZrntGOdJtqnFVizJYr6pS
 bembgN5GvNHOlA/P8l9Xdatwjv7UH0+sDYQjgeStpfad7+Qrke6xKalnD9j23JQp+rkx
 uKnG2pzNUA65ITGrkrERH4SpTrcxi2DByTk8ABblBegNF+WK2hiEsLAsTooBYuGIDyla
 6HCsrTN1ECSbg1s9G2TyOl6s4KfTxPnorWMKEQ7xsUAGTN1EG5DC2vr/QWq3PI4kq2Yf
 lncw==
X-Gm-Message-State: ACrzQf2axzoNRxGgYBodlJ0EG7Ial9xRJspq8CoPLK9sftSpoiKb5XK4
 IpnZ4huJKB25+FIrTOD93ws8j6YUqofFjZdcTeSCARs+Gvw/UjGESfF45i+3Gu/TLAU75fNd5G/
 XqruzDtOq2cWzjmzEIEpFOLFZ2Q==
X-Received: by 2002:a1c:7405:0:b0:3cf:55ea:6520 with SMTP id
 p5-20020a1c7405000000b003cf55ea6520mr7948712wmc.46.1667218753686; 
 Mon, 31 Oct 2022 05:19:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4oPDcyHgSUP9i1GOihR+fx3MXqkZeIX2xB6yE7P9f9dsxB6V14E0IWVQPIhFCjpfp7XUuGLg==
X-Received: by 2002:a1c:7405:0:b0:3cf:55ea:6520 with SMTP id
 p5-20020a1c7405000000b003cf55ea6520mr7948695wmc.46.1667218753455; 
 Mon, 31 Oct 2022 05:19:13 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 x11-20020adff0cb000000b0023660f6cecfsm7060089wro.80.2022.10.31.05.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Oct 2022 05:19:13 -0700 (PDT)
Message-ID: <01f85874-6beb-c325-8b94-7a7aeec30d5a@redhat.com>
Date: Mon, 31 Oct 2022 13:19:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 08/21] drm/rockchip: Don't set struct
 drm_driver.output_poll_changed
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, sam@ravnborg.org, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
References: <20221024111953.24307-1-tzimmermann@suse.de>
 <20221024111953.24307-9-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221024111953.24307-9-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Cc: linux-hyperv@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-sunxi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 spice-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 freedreno@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/24/22 13:19, Thomas Zimmermann wrote:
> Don't set struct drm_driver.output_poll_changed. It's used to restore
> the fbdev console. But as rockchip uses generic fbdev emulation, the
> console is being restored by the DRM client helpers already. See the
> functions drm_kms_helper_hotplug_event() and
> drm_kms_helper_connector_hotplug_event() in drm_probe_helper.c.
> 
> v2:
> 	* fix commit description (Christian)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

