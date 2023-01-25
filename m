Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4C8C27C76
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 09:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D28A010E765;
	Wed, 25 Jan 2023 09:54:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2440C10E765
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 09:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674640468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TouYpeVIY3sVaURhe3OBQ2as0Nh1mIpj/44gYLj7/xc=;
 b=drh/E+7mDMGR49LUHRQH72giJXmyEJfT7HphMML1jyITbr0g5bocRge7O7EIjQxf8i/g+k
 ZbRoyA/AP6Ol9OrA9a7Pb5eUodiS44NHOrIquEVZYHcBzlQ/oF7fVU0ylfW/sfd0W8IqOU
 AwwSFVp6sDMTIW0zdUmOYtxP2Ed/0G8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-390-1ouB8mzeNLSby6BcBf3LzQ-1; Wed, 25 Jan 2023 04:54:27 -0500
X-MC-Unique: 1ouB8mzeNLSby6BcBf3LzQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 o5-20020a05600c4fc500b003db0b3230efso810784wmq.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 01:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TouYpeVIY3sVaURhe3OBQ2as0Nh1mIpj/44gYLj7/xc=;
 b=d2W7pWT7ScOO2w0cMTUxX7C3RzlCM4rxXkgbQXEwY2MEHbQV+Gb03AQkRfZRuitniz
 JsiXL4RMDj9H4vhLyYpiuU/zyg8My2x1+GCF0CWxCqcXo/m69rGrxDfc6kqh1CiRVUZh
 130ZO56Pdhr+w/1FZq5ALe6wQObQb04OhtcxBhuVWczu56oL91//2+OdWlUBNq27UpZ9
 UD2GFRPolHOKgKi5Zok7oFqe0np2iVD1x52M6yl47N50xjNb04lItbeHwyLknv2Pxza5
 0xAOj5vR/WzIbYlOkZ0c683UQdZ4RMsmKRuFYVHLsz+qLavsI47taisW+ack0Jnqkalh
 G30w==
X-Gm-Message-State: AFqh2koL0JJ0v48n+A/5kqYME6qWf7+g4miPCo4f5LTBXmHTLMUdlQJf
 VJv+C5ulSonH/2eOidl7fVXdDka1YwhVebcqbezf9/zdgUUZe5bbVhBKN4PXyVX5bXcIdEafqS7
 dPCGRxdDOQH60dzSd9sQrG2mN1Q==
X-Received: by 2002:a5d:6944:0:b0:2bf:960b:7282 with SMTP id
 r4-20020a5d6944000000b002bf960b7282mr15280445wrw.44.1674640465869; 
 Wed, 25 Jan 2023 01:54:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs0qhPZq4DvvRBWKlYakMR9y6Uj+/MSQrsj/7lcQHcP5rYP7V12fMSxLIHPoxhHoCWiXuL3sg==
X-Received: by 2002:a5d:6944:0:b0:2bf:960b:7282 with SMTP id
 r4-20020a5d6944000000b002bf960b7282mr15280426wrw.44.1674640465680; 
 Wed, 25 Jan 2023 01:54:25 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 t9-20020adff049000000b002bddaea7a0bsm3982230wro.57.2023.01.25.01.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jan 2023 01:54:24 -0800 (PST)
Message-ID: <f1441822-c85d-4a2e-7e0c-98c3a6de31ac@redhat.com>
Date: Wed, 25 Jan 2023 10:54:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 10/10] drm/fbdev-generic: Rename struct fb_info 'fbi'
 to 'info'
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
References: <20230124134010.30263-1-tzimmermann@suse.de>
 <20230124134010.30263-11-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230124134010.30263-11-tzimmermann@suse.de>
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
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/24/23 14:40, Thomas Zimmermann wrote:
> The generic fbdev emulation names variables of type struct fb_info
> both 'fbi' and 'info'. The latter seems to be more common in fbdev
> code, so name fbi accordingly.
> 
> Also replace the duplicate variable in drm_fbdev_fb_destroy().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

