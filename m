Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6B2C27C76
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 09:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBB710E75F;
	Wed, 25 Jan 2023 09:06:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 215F410E75F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 09:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674637564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibAilFrTZpaXjvkv+J4hBVKGt8aImsFqCRRw10Pzcew=;
 b=CuVvC46Zctg4o++wrTdflDdbEX8uz2l+o1NbpWjZIzT+ZrZugPGfNRSP3ge4MOxs3hduMH
 S1TbXKppE3SUCUogIngULIMkw94JJOMje1rovoiB/6kqRxhpdQQdn+GIoyBK2f84uKllKc
 78h6afWYKFieLv/VcZJFeK4ayT7E05g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-5Q0DEz7mOjOkArlJ2lPydQ-1; Wed, 25 Jan 2023 04:06:00 -0500
X-MC-Unique: 5Q0DEz7mOjOkArlJ2lPydQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 c66-20020a1c3545000000b003d355c13229so791718wma.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 01:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ibAilFrTZpaXjvkv+J4hBVKGt8aImsFqCRRw10Pzcew=;
 b=N37Ih3HctXLmqpuAGRw6k3xBaMms7zj4zrQKmT1LB5Gt1V8Lsu2oRLAoi89NSiATWQ
 DkLKq913nDpis/Qt1BDp86yS6L0pcYlO8bmgTPtw3/HTZe+8fGep+Q8zNKMqFaBnkiYR
 dUPx9pby89wQrrEqnMYQEqvrK+jwsSAwxWJccCwvGl2GFy2fNMRYCGiG/sHlkEYHjPTp
 ZkEy+2SvB+VDe2xVO488jBRygYjqZHBD6+I0KTkykSgvMEqDaoI+BrG9w+6+pg29FtVo
 /0aNeOuSAbePC5qfYLoUyVa5PyaTbsDn68uLZ1U6MCETRMHKByIIk1AMMw1tAJvIat/z
 oedg==
X-Gm-Message-State: AFqh2ko4DH7E6BU3h5bGaaGSwVDH/5EAo+hQksnjTrW7psS+kMOXs6Pq
 5a6o/R4GyEbEJTOVrl8ISSP9wIyc59dBnpaSJkBTMeVyonI5dqYjDTY9HCrGTyaV4Ll5bldKP0T
 0zBo5oFcSX+hapgdrCKYWfYvQCA==
X-Received: by 2002:adf:c614:0:b0:248:ab8a:5144 with SMTP id
 n20-20020adfc614000000b00248ab8a5144mr21094648wrg.63.1674637559805; 
 Wed, 25 Jan 2023 01:05:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtMP+tIsLwCvIpxNk0o5l1ZP8xAGyOaXYfWMtnUqU1wHmPoAjbKjb1Za9A6b4DyRU3i/fPKxQ==
X-Received: by 2002:adf:c614:0:b0:248:ab8a:5144 with SMTP id
 n20-20020adfc614000000b00248ab8a5144mr21094625wrg.63.1674637559560; 
 Wed, 25 Jan 2023 01:05:59 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 y15-20020a5d470f000000b002bc8130cca7sm3865503wrq.23.2023.01.25.01.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jan 2023 01:05:59 -0800 (PST)
Message-ID: <a8beffd8-5977-aa51-97aa-feef314541e0@redhat.com>
Date: Wed, 25 Jan 2023 10:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 02/10] drm/client: Add hotplug_failed flag
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
References: <20230124134010.30263-1-tzimmermann@suse.de>
 <20230124134010.30263-3-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230124134010.30263-3-tzimmermann@suse.de>
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
> Signal failed hotplugging with a flag in struct drm_client_dev. If set,
> the client helpers will not further try to set up the fbdev display.
> 
> This used to be signalled with a combination of cleared pointers in
> struct drm_fb_helper, which prevents us from initializing these pointers
> early after allocation.
> 
> The change also harmonizes behavior among DRM clients. Additional DRM
> clients will now handle failed hotplugging like fbdev does.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

