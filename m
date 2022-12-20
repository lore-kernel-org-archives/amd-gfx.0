Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBDAC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0132D10E36E;
	Tue, 20 Dec 2022 09:46:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA86D10E36B
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671529599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ykdKuygOSTPkcM25esQW4i241lwYH2V5lSGsmvsr/ls=;
 b=gCuf+TYmqs899gY3Z/Oreyd0KYIY0DmbgF84SxgL4fK8gHs6rM+m4KMKh3W8ZuretoEyfs
 3mR18buTB6Pw7lrccI31YEKwjFJ2MW2Jbccl9uxljMrNmCuv7x0q20GuZSp95/cQS6epi5
 hb1g0hL5vDbxBQS1TNFLmZcx5FN3l80=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-59-r42lqJLUNOqNN2oOxGPvNA-1; Tue, 20 Dec 2022 04:46:38 -0500
X-MC-Unique: r42lqJLUNOqNN2oOxGPvNA-1
Received: by mail-wm1-f70.google.com with SMTP id
 i132-20020a1c3b8a000000b003d0f49bc21bso7812479wma.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ykdKuygOSTPkcM25esQW4i241lwYH2V5lSGsmvsr/ls=;
 b=e94PuuR6+N6xe6byJqsxN9cWk9A0QDyVP61EP8ezZ4wM+nPYmc9/7Qqoa246VL9in7
 147gvnY/Ih+YKaKbC6Eka6+bbHczk9o5tO/H/ZMMKv6aD2QyKnSKGuh2j5b6vn+HbEGY
 5bmOQxYeRO9hNQ4GJ1qAt/G5NQgUPdFw7+skQoXmMUECfFEwa4rd0hdPPZ2xkAKfMUpc
 lhy3PjYlj411S1QToeRzj3X4/atlFDrcPn79wgf0p+lkBjTkSEyiX2Q8WTs7WBFTgpYf
 nidgL5rU8I2ujH+PxW0Tk5UoPFDAXmA8GaR5sCmSHF3OGgj1/9+Tj583jGcIlg4gBdlu
 agrQ==
X-Gm-Message-State: AFqh2kpu9F0hMiYXYTbBkj+jiKt8XugRFgn9EYmoc7gGjqjYPZziGXZx
 hnjDU1a8AJZdCxETWyxOnNOpcrzN1hqmznJf6a/ipxsgVsIy3csw6JdOzoPawx4Rt1kv6JW41th
 KmFSgtoc77BnMmueoQPOnK7FM/w==
X-Received: by 2002:a05:6000:718:b0:256:ce1b:74ac with SMTP id
 bs24-20020a056000071800b00256ce1b74acmr19147669wrb.29.1671529596403; 
 Tue, 20 Dec 2022 01:46:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvJLK/eM71NU46wbs2aboKoDtpTCvPv8+GeJSh+yzufeE4NK5CbBNZkmGr9N2Pg6bIDfe3F3Q==
X-Received: by 2002:a05:6000:718:b0:256:ce1b:74ac with SMTP id
 bs24-20020a056000071800b00256ce1b74acmr19147664wrb.29.1671529596230; 
 Tue, 20 Dec 2022 01:46:36 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 c16-20020adffb50000000b002365254ea42sm12325758wrs.1.2022.12.20.01.46.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:46:35 -0800 (PST)
Message-ID: <978cd907-65ce-2a89-e046-17a75c0ab832@redhat.com>
Date: Tue, 20 Dec 2022 10:46:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 18/18] drm/fbdev: Remove aperture handling and
 FBINFO_MISC_FIRMWARE
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-19-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-19-tzimmermann@suse.de>
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
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/19/22 17:05, Thomas Zimmermann wrote:
> There are no users left of struct fb_info.apertures and the flag
> FBINFO_MISC_FIRMWARE. Remove both and the aperture-ownership code
> in the fbdev core. All code for aperture ownership is now located
> in the fbdev drivers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/core/fbmem.c   | 33 ------------------------------
>  drivers/video/fbdev/core/fbsysfs.c |  1 -
>  include/linux/fb.h                 | 22 --------------------
>  3 files changed, 56 deletions(-)

Nice patch!

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

