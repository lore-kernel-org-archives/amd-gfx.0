Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771DFC0015E
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Jul 2023 19:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C16910E210;
	Sat, 29 Jul 2023 19:10:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA4BA10E117
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jul 2023 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690657805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YOCFbmaqJDliMmq4qRXmQzpcNBbZ0rghMQxEBFeZeig=;
 b=JEXB2HrUkMgCyeFCzoeQ5LcomrPt1WYJyQMBmhgpUnN6b5jBHpvYXNi2dCZjFTl1wLJlXX
 nd4/8gIYNqPwHNu6+XoQ3wIqO6DN/dv0coPGs6eWkPdwAjWR7hK9o9kjuLtKPYZ6jhtatU
 xuJhTDZB+AFuXBgTeCtUFQEQwJlWhmg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-bqIunHubMoqa_A4Y2HOkfg-1; Sat, 29 Jul 2023 15:10:04 -0400
X-MC-Unique: bqIunHubMoqa_A4Y2HOkfg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe11910e46so7645065e9.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jul 2023 12:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690657802; x=1691262602;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YOCFbmaqJDliMmq4qRXmQzpcNBbZ0rghMQxEBFeZeig=;
 b=EPvMeCJ6kaSDevxkbWc8LAImGEex37AOdzTvUDWkCeViRdC+X8p319F56rNZHgj3kv
 SByISJy32YLC4WUDnoZkXuvOrY53dIjQ9o23Fevq1LgC3TVvmiL6+N2ytL3vKBgT0kLF
 1mHT+HzsS3r22f1SzXoixSSkJpok+CpOSS2QBqfJFQXymJ8wv1SjDt1bvUCWzv48EKea
 2d5EaWXjozhahsuF9uLD/TVm/jwbab2VPbb7VDc50TtvkTuBfliU0AXSmaYwOVmuNqjO
 RQ0/P2+pyliOXtER7DndSJqO8zqpAHeVZwf7Uh1K8+tK7hE6INU7iWB5M8SQ0nZ6kxNC
 eHpg==
X-Gm-Message-State: ABy/qLa/tXmkFYX6a6WH/6UFomdiugg1ZPRlss375q+yJQiB5LCxej3R
 HwhOhMXSvbipYzUDtdQby1bZw9OQv2ExE9ojfVmQ81xzCYlyf+OkxFYG+72rLjfLozPZcF+W3J2
 vWuekTVrMPXTkmr+MvG+gn/HDuqIe5zx3iA==
X-Received: by 2002:a05:600c:22c6:b0:3fc:1a6:79a9 with SMTP id
 6-20020a05600c22c600b003fc01a679a9mr4764486wmg.16.1690657802669; 
 Sat, 29 Jul 2023 12:10:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHLhWwdb9e5stl9mtFYazDKO5IGT18IwiQdgIdt9oSkXWPDup+CMG32gUcSUxlzRYbRdSzBsA==
X-Received: by 2002:a05:600c:22c6:b0:3fc:1a6:79a9 with SMTP id
 6-20020a05600c22c600b003fc01a679a9mr4764469wmg.16.1690657802420; 
 Sat, 29 Jul 2023 12:10:02 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 x20-20020a1c7c14000000b003fc01f7b415sm9897722wmc.39.2023.07.29.12.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 12:10:02 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2] drm: Spelling s/sempahore/semaphore/
In-Reply-To: <8b0542c12a2427f34a792c41ac2d2a2922874bfa.1689600102.git.geert+renesas@glider.be>
References: <8b0542c12a2427f34a792c41ac2d2a2922874bfa.1689600102.git.geert+renesas@glider.be>
Date: Sat, 29 Jul 2023 21:10:01 +0200
Message-ID: <877cqiy1o6.fsf@minerva.mail-host-address-is-not-set>
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> Fix misspellings of "semaphore".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
> v2:
>   - Add Reviewed-by.
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

