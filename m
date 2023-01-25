Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4F3C61DA4
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 09:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8552510E27D;
	Wed, 25 Jan 2023 09:31:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3874610E0DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 09:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674639069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/WkTUKbzuIyITLmeh/5Sbr5wRBScMiQq+Y/7HiPtGw=;
 b=OfK3zKcB1isdL/EGhdqOytLkF69cqVhTSaO1ki1ytPPq1xlE1KkWuW7+T181WAtGXfM3bH
 7/TOaM3XjJ0k8g/OMvefkK2wOh7TGlyQxu5QLAYrDRCTaj7WXKNNTaCl/po4D+kmlrbQL9
 2313j4I//YcaU/GJwoom02tsDLgjrRI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-rnVcUeHFPuKB8sxIjSOqAw-1; Wed, 25 Jan 2023 04:31:08 -0500
X-MC-Unique: rnVcUeHFPuKB8sxIjSOqAw-1
Received: by mail-wr1-f69.google.com with SMTP id
 bj7-20020a0560001e0700b002bfb3c6ec00so608712wrb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 01:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e/WkTUKbzuIyITLmeh/5Sbr5wRBScMiQq+Y/7HiPtGw=;
 b=YN3EOpaQ8pCCW1lHjQgpWrqgmjI+D7JAZtJRiPvZPKbALDj7T04WXGOTO+vfXkY48z
 oNxlAR75zHMcZOe2hldxWcQt8sFFdOrCv2osAwHkz81LCC3jSti7PoEsP9R994lgp4yu
 iGrY0O+ukVFv09D/5JyB6cleI3FoMEGre56xNC3cW4p+b8HOd6K+A4qrXG1SUf8nIyng
 32lCH2XyWp80L5weHgl36+4OsWrwf5HOKzbMzqAYwxupGlPe2i1Nk8dNwTmYOMrRqoxk
 GVnkGuDH85sjDs92PyBi2ZHJ4+23JBhPu9AkmsVkcGK0SlhB+rzLuZ8wCbKNph/yrplA
 Edqg==
X-Gm-Message-State: AFqh2kpoNgh3skx3VbgVrw3Z8UgWoNuec0Vv0QhjcI8VqrpHtCuZGVQr
 j8PDw1HEyp3z8k+jMLYgDD7WEH/IrUo+BBgULy601T44YPAgWTB60W8B22sH+JAqxgqlcyUkeJh
 BnM8uQqqUvGdhOeQ+l66qfJMxRA==
X-Received: by 2002:a05:600c:c10:b0:3da:f5e6:a320 with SMTP id
 fm16-20020a05600c0c1000b003daf5e6a320mr35822716wmb.22.1674639066890; 
 Wed, 25 Jan 2023 01:31:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtFX/Kp2mSluNmLe5a+pgmO0l5es7cQOLhWqEKWjvp22TqYJWLpxeu0OJ4sOlzZNMpRvS8iog==
X-Received: by 2002:a05:600c:c10:b0:3da:f5e6:a320 with SMTP id
 fm16-20020a05600c0c1000b003daf5e6a320mr35822702wmb.22.1674639066649; 
 Wed, 25 Jan 2023 01:31:06 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 t20-20020adfa2d4000000b002bdcce37d31sm4573358wra.99.2023.01.25.01.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jan 2023 01:31:06 -0800 (PST)
Message-ID: <6bb09a17-2f13-4920-b156-3be80e507f48@redhat.com>
Date: Wed, 25 Jan 2023 10:31:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 05/10] drm/fb-helper: Remove preferred_bpp parameter
 from fbdev internals
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
References: <20230124134010.30263-1-tzimmermann@suse.de>
 <20230124134010.30263-6-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230124134010.30263-6-tzimmermann@suse.de>
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
> Store the console's preferred BPP value in struct drm_fb_helper
> and remove the respective function parameters from the internal
> fbdev code.
> 
> The BPP value is only required as a fallback and will now always
> be available in the fb-helper instance.
> 
> No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

That's much better indeed.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

