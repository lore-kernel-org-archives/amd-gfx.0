Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1A5C54E94
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 09:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D1410E74B;
	Wed, 25 Jan 2023 09:41:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA30910E0DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 09:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674639667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZiXmPj1TLICEH85h0g9ObpieXhmW8hbY1dyGTe1WVko=;
 b=J3iwWPojAw1r21u96X8vQ83x9esyc3Tyf4hR52WkZ6Z6kFaLTobFu6dzih8UT48cvAuKCQ
 dXwyidPASxkP27gPG6CfueB2aHDP2gHRIQSLaDlP9dvGbbKzYKl70G4kBMVGJ07rmcHArl
 lbA3MqFZFMdJK9R8yNoTLbD2ieXi9+k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-27-1nut0WxQN_2MaNJePalwHw-1; Wed, 25 Jan 2023 04:41:06 -0500
X-MC-Unique: 1nut0WxQN_2MaNJePalwHw-1
Received: by mail-wr1-f69.google.com with SMTP id
 b15-20020adfc74f000000b002be276d2052so3014355wrh.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 01:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZiXmPj1TLICEH85h0g9ObpieXhmW8hbY1dyGTe1WVko=;
 b=KWHR8XnWaAFevmIFDR4wTdq2mZyoJjgWI1cHKKvOqKXsn2x+ipEokUC+BueDKOMxa3
 gggfUV71TJnRiU4go5nKRG2l3PbNhGxlR6t6EIj4Lg2gwsMiEmSP7hbVfiRlADTzXEBr
 bWffIo687wCJoOBwmxR9s2qGEK8nkH0Ct0u476zeoNqmP1Z0SU148n/qsGZ9i4sltz0y
 pTsVcDnU0NGKupWay3WTrc7ZO86CcAeNW56lqU4m4/ebTQ8eQaiXCi6hIVnBQw6klUqW
 9pt8ISWHN3lcrqFAU4VWYtyEaEA4V+NBylfOBo4rqzj0CI+Kxe2CO03zjPHnEWYBR1zd
 CR0Q==
X-Gm-Message-State: AFqh2kokd553yMqFlh5sH4k/SbbcBdFyuy6pk/zFTp82DRrQZW76eoTt
 71DkVM+WfGIuQswSUsqvJ3i0FNcIoDFs1WnMhJzDiB+9+QfPFUkXZ/FoXL7bO52GFO7N9wocQNA
 680bWDHoQA9EHQkyjpyxlLLv3tQ==
X-Received: by 2002:a5d:5c0b:0:b0:2bd:15ef:fe7 with SMTP id
 cc11-20020a5d5c0b000000b002bd15ef0fe7mr27416469wrb.3.1674639665557; 
 Wed, 25 Jan 2023 01:41:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXspvSYF5UcTCX9Syl/sB5Wttapk1TJmAOGMxlySA2rIPpJprAbwV2wYhJQSWjxg72A43lgFrQ==
X-Received: by 2002:a5d:5c0b:0:b0:2bd:15ef:fe7 with SMTP id
 cc11-20020a5d5c0b000000b002bd15ef0fe7mr27416452wrb.3.1674639665344; 
 Wed, 25 Jan 2023 01:41:05 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 a18-20020a056000101200b002be25db0b7bsm4010247wrx.10.2023.01.25.01.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jan 2023 01:41:04 -0800 (PST)
Message-ID: <66114220-d226-e0e9-bf09-707388ce98f3@redhat.com>
Date: Wed, 25 Jan 2023 10:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 06/10] drm/fb-helper: Initialize fb-helper's preferred
 BPP in prepare function
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
References: <20230124134010.30263-1-tzimmermann@suse.de>
 <20230124134010.30263-7-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230124134010.30263-7-tzimmermann@suse.de>
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
> Initialize the fb-helper's preferred_bpp field early from within
> drm_fb_helper_prepare(); instead of the later client hot-plugging
> callback. This simplifies the generic fbdev setup function.
> 
> No real changes, but all drivers' fbdev code has to be adapted.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

