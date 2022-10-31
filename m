Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C4AC38A02
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 12:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E02810E1BF;
	Mon, 31 Oct 2022 12:08:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1352D10E1C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667218101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UzviKTRQBMSKwIl6kvNWZgMaFQwic4ec30sKv7m652k=;
 b=HVwgxIFnTQWShJIbAp+p3yMHeOQrB6J5obh03OwUqlJlXbm90w49w/nPJiu98HKGScM9Uj
 vcR2K1W6wwdh1fa05SHdk+3fuL31eun9CsHTnQBBPzXgM2GVsUWvjC59Qd/0aT4EbN9Vql
 WRS4q8gCbvbwjjBXqhS0GpswFgCgaLQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-Jj9__jlWPrCa3ckfX1KRXQ-1; Mon, 31 Oct 2022 08:08:20 -0400
X-MC-Unique: Jj9__jlWPrCa3ckfX1KRXQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 p14-20020a05600c204e00b003cf4cce4da5so2543727wmg.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 05:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UzviKTRQBMSKwIl6kvNWZgMaFQwic4ec30sKv7m652k=;
 b=ziJbJoFhhCMNCTEX3CclIHSyqMU8cVBQSMXQLbRgxIGAcsPFzsMrMIRiWjKsr6wAUI
 PvcFs5B4E51QAbvuaFmAvT5s5+ZjlxFYXL7De9B8ERln76NwilWRBV5LxCyUtgYwMF5q
 mASALNrZ8G45UDzeppnkldQpUzMKs3y5y3dUJWe6TR6LPuP/GsNyQhNKZagOoa75rmk6
 UqtB4rwmXuE0WGUR1UettIvGK5fqvwfN+HqGQ+3zsi/SA7cyb2EJAHw4p3tlsMZo12sp
 Fuw7B82tUWc0ZPk89uIpTiNa09m7VopHS0Zl5zVlFuko/tx86gVMcy4hU3qTofSB+CHc
 CO0A==
X-Gm-Message-State: ACrzQf2EMqpJcDrRgL1JKtVURCDS294qL/WMAIuNLbPsz2bcuBoGkZ8s
 y2ldSi6wRKfPVmZIiavNK+eTxrIBeeGFOGhzAY5DA8kxRpwprLrP99gHf5GdO2U7MDmiYugopfl
 GjqYh7w2qldF1b8wIwQoPPC/3Dg==
X-Received: by 2002:a05:6000:15cd:b0:236:9701:7939 with SMTP id
 y13-20020a05600015cd00b0023697017939mr7691201wry.248.1667218098875; 
 Mon, 31 Oct 2022 05:08:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Xfc/ao13H30KX93ABjLq4iUJ6oQF+1EOXF8gvz+3LvWSBMjjIijdjEWsEsBBK0GpYNHL8UA==
X-Received: by 2002:a05:6000:15cd:b0:236:9701:7939 with SMTP id
 y13-20020a05600015cd00b0023697017939mr7691171wry.248.1667218098682; 
 Mon, 31 Oct 2022 05:08:18 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 bn26-20020a056000061a00b0022cd0c8c696sm6948033wrb.103.2022.10.31.05.08.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Oct 2022 05:08:18 -0700 (PDT)
Message-ID: <fd53a4f9-34a8-f5f3-1b1f-baf4a456bcc9@redhat.com>
Date: Mon, 31 Oct 2022 13:08:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 04/21] drm/amdgpu: Don't set struct
 drm_driver.output_poll_changed
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, sam@ravnborg.org, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
References: <20221024111953.24307-1-tzimmermann@suse.de>
 <20221024111953.24307-5-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221024111953.24307-5-tzimmermann@suse.de>
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
> the fbdev console. But as amdgpu uses generic fbdev emulation, the
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

Do you think that the fbdev helpers kernel doc has to be updated to mention
that drm_fb_helper_lastclose() and drm_fb_helper_output_poll_changed() are
not needed when generic fbdev emulation is used? Because by reading that is
not clear that's the case:

https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/drm_fb_helper.c#L86

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

