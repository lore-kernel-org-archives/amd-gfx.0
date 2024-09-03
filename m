Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE620CD342C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E0D10E4E9;
	Tue,  3 Sep 2024 11:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JKTrQ+M4";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B39A810E4E8
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725363351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TSTF58qr8+XEIh+oYno8E8uAlH24T+aQUMezZd/qxQM=;
 b=JKTrQ+M4my8w6o38ZEh07qmsk0aYNgCRIjx/lHxq5gxttndbdd0Jv8nPZhtuqoxLIyDxSv
 AeMZHm0Qnp+yyot03ZkqD3cGaFZi0J/8VsmSWl+0sEpLAOVyYOvwenR2vOWtZz98L5ykgU
 hPiNvd3YWi3GkgOUwTDbETCvtJYnHCU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-C7U8Nig7OGuZSAVxn5JkLg-1; Tue, 03 Sep 2024 07:35:49 -0400
X-MC-Unique: C7U8Nig7OGuZSAVxn5JkLg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42bbe70c1c2so35394615e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725363348; x=1725968148;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TSTF58qr8+XEIh+oYno8E8uAlH24T+aQUMezZd/qxQM=;
 b=jV53EWT4RAdXjXgBjl9kmllzrHTwqGEbqixetywszxxqGrx58UnfaC431f8u5mYrzB
 omAXU4bx55KzmKETAg7v10nn9ePOCCLMsh1qz+dj6jIMMXtTXtusBpx22cdVpTU/5SHi
 Y3dDifmRPwF2fcxNqwXHDlj9a3XH+/7WIHiyAmsSIm8inh7WXHFv81ykLWn1X3Kntnlf
 Fw303VKsL02E16+OL5bmTArXnfbi0jmghMLYE84butQ3TS9DozHqqzAZHYZOeLvZ5CTh
 pvLzn8VPjzyIofGY7D04XZnalLY3gxGVM7TivAL3G18Y/CSpN41SPDGdGZv8z/921Z/U
 GA+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHgtVJdLjc+cFi+hx4YZtR4YikjWoZn2w94GTphDeIcnvLZe12G0A38liHN07s7q/HThx6VBpJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdyEuvbXxGODxehCkSLm+5k7hmbFvcI64NHQoj8wIDEHqx2zlp
 2t3nx+ral/T90i71qoLDL9saZSflFGfdOLopVBd05Pnnsvzy03k8DXTYv9QJEsvn6luusDKsjFP
 BmXAVaQRAhte/ilYgQoGH/aZ/ltmjkoC/b1nz+OmLrL6v3I6/2zabjj0audFy41Y=
X-Received: by 2002:a05:600c:1ca8:b0:426:6f17:531 with SMTP id
 5b1f17b1804b1-42bb02edaf6mr130000865e9.13.1725363348473; 
 Tue, 03 Sep 2024 04:35:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtyX2uOKVFE476IZPot6lc0AMFObvLiZGeI1TgAffaxGluqt7ZPRIl9eZVAwWXt4J+zTGPbA==
X-Received: by 2002:a05:600c:1ca8:b0:426:6f17:531 with SMTP id
 5b1f17b1804b1-42bb02edaf6mr130000635e9.13.1725363347900; 
 Tue, 03 Sep 2024 04:35:47 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df0a42sm165399665e9.11.2024.09.03.04.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:35:47 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 49/81] drm/fbdev-dma: Remove obsolete setup function
In-Reply-To: <20240830084456.77630-50-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-50-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:35:46 +0200
Message-ID: <87o755dl65.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The old setup function drm_fbdev_dma_setup() is unused. Remove it and
> its internal callbacks. New drivers should call drm_client_setup()
> instead.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_fbdev_dma.c | 120 +-------------------------------
>  include/drm/drm_fbdev_dma.h     |   7 --
>  2 files changed, 1 insertion(+), 126 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

