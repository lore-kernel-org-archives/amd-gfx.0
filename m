Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824DBC27C76
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 09:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 165EA10E763;
	Wed, 25 Jan 2023 09:52:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957FE10E758
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 09:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674640374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6cPchqoXvC7fz4HOb1ChIaitTq8x3iNoLBlJaQ4TwQ=;
 b=ajymRgqzesHlDyjRtzzf4GoaDIEkCmdhsEAHLfvxU30Iq0plKkALI48ljdmHbkf8KJa0WC
 b0DSPIeD5BSMwNNH+o+IMUoQcjOW/qEexMzUIB8w7mc3ULi00xehGooHi/kaqxwglUJc0x
 YrCFZvTz2WbuHPXgkoHdeP9zB6tAD5Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-606-2LYyywDzONWcChuFosN8RA-1; Wed, 25 Jan 2023 04:52:51 -0500
X-MC-Unique: 2LYyywDzONWcChuFosN8RA-1
Received: by mail-wr1-f70.google.com with SMTP id
 k18-20020adfb352000000b002bdd0a7a2b5so3055855wrd.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 01:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c6cPchqoXvC7fz4HOb1ChIaitTq8x3iNoLBlJaQ4TwQ=;
 b=nD5P5+NVAG44mFZkL90KZrWJHpvBXWSmjzDNCAHhSfZ7a48wxgNMvNkOWTNKovo7sQ
 CkzLiHmGeJx6Y5fI99c58UVOFem/zsimSVgZRu7CK3C2KkfJ3jT4jThq1PVSmOFTsM2B
 g156O+Fl6MPhngWVBnjWXUIFTVUSes3v7yo4GJ04wrtZiGLJtO0QmQyHhalaT+SWR+YA
 Xn8EZFH7Xj40LoyGMvoET5w/uMRz0bGakQ2lXZQI3nnjEs/9wP9lAbVChL7dRRxVql3c
 vyRoWqghcTIBcfqHOFh0gFoi+M7bmUl21pZWQy1a3FVTHkFFHnW1UxhrjyWpksRw5x+g
 PhKg==
X-Gm-Message-State: AFqh2krRYcf/LBZpdezl+FEqyW0eQrhC39hxGUjLks9/k6S6FF7NPoq4
 TaNE3/72DhzTItbPXhpi3G+cL1ntL4CXvmOjosRrYwHu8Aw5oBYgKovSbenyav4lQ50mD1/Pvr0
 SKY4cqWuOT/4xfUCzrYgAXjHMSA==
X-Received: by 2002:adf:df10:0:b0:2bb:e891:1829 with SMTP id
 y16-20020adfdf10000000b002bbe8911829mr26349575wrl.4.1674640370485; 
 Wed, 25 Jan 2023 01:52:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuvmq2QmH2lib1EOjSoV1HyQPmQn7B/0nRysa3FFY81sXz4YqkvR1qkRuVsXj3rXTMZ7umf1Q==
X-Received: by 2002:adf:df10:0:b0:2bb:e891:1829 with SMTP id
 y16-20020adfdf10000000b002bbe8911829mr26349557wrl.4.1674640370241; 
 Wed, 25 Jan 2023 01:52:50 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 q14-20020adff78e000000b002be07cbefb2sm4747862wrp.18.2023.01.25.01.52.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jan 2023 01:52:49 -0800 (PST)
Message-ID: <8e5bb4ed-11fb-272d-4d70-f25252a0c5c5@redhat.com>
Date: Wed, 25 Jan 2023 10:52:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 09/10] drm/fbdev-generic: Inline clean-up helpers into
 drm_fbdev_fb_destroy()
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
References: <20230124134010.30263-1-tzimmermann@suse.de>
 <20230124134010.30263-10-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230124134010.30263-10-tzimmermann@suse.de>
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
> The fbdev framebuffer cleanup in drm_fbdev_fb_destroy() calls
> drm_fbdev_release() and drm_fbdev_cleanup(). Inline both into the
> caller. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

