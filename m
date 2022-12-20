Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30239C10F1E
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0187588C3D;
	Tue, 20 Dec 2022 09:34:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C6D710E35F
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671528836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVZMgP3yXzrzjDhtvsp+tMbNXy6x5UaaSyaJJzd0B0g=;
 b=e9TRzOd1GM9BZy7nwUeFTzI2fs+3M19xRDSziQ7diozTs1U+dG32FnVeAxrndE+2rscfhV
 6sZIO//1MHH0nEQuphwpdWDT0gBLnOIcHFvZ+SFr87IT8IcNP5ab2G/BsS2RWSaCKvsWYp
 tTh9xmVYGQ0Qy2zAiARa2HEbY71FJ/E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-577-_CffYG1nMJKfLgJTb-I-lg-1; Tue, 20 Dec 2022 04:33:55 -0500
X-MC-Unique: _CffYG1nMJKfLgJTb-I-lg-1
Received: by mail-wr1-f69.google.com with SMTP id
 v14-20020adf8b4e000000b0024174021277so2099234wra.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fVZMgP3yXzrzjDhtvsp+tMbNXy6x5UaaSyaJJzd0B0g=;
 b=C2wQRJoNeOKyqM+YvHPu+IJR/vy78QvixnzunhIlttuPOLn1uFWuTG4ksMG6ZgGRQx
 4jObYN1BQyVqfvqJqHiFMJRV7QUoP3nY6ztkaklswRHENpF8m3y8GQrA5YIL1v8pGbKx
 +TxZ40/RdsPo349imtMvobdwZ/cXdjnu0PPQ7GSy5fF03KWN78BFp/eY2nSNNr8B5D7j
 ZpKW14zTLxu6uh2S2PyuHu/ffst9Xj5CD3TRoiYB4mIDVv7VRGMAtzxIdXCivgxV1X5Q
 b3HxJ5QD6Hgq55gzMdIMjd+SIUD1e7V6FQBOVmVOm37Q62hpjG8tfkmHEEl8SEobG23p
 MS+g==
X-Gm-Message-State: AFqh2krMrcaS69icSzw7dKl1DjkbYztkH/c6LszaBcRIrzlLqTUTzGBC
 mWpAb+GgXpoiulOfwLczGPNH3yisKwuTDC471yjxpA2PebgPo3Bgf+YDbOHkKpcbgKxbgkUsCrN
 jXenykK0/oqcCRIROs2BcJ3UTdA==
X-Received: by 2002:a05:600c:b59:b0:3d6:4ba9:c111 with SMTP id
 k25-20020a05600c0b5900b003d64ba9c111mr241656wmr.40.1671528834238; 
 Tue, 20 Dec 2022 01:33:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsPd0UOZgaV2usn9FHot5yPumcQTQ0WuQ30V9fRvNh8brfS+c9839HDYnoS7vxUK6doBa1czQ==
X-Received: by 2002:a05:600c:b59:b0:3d6:4ba9:c111 with SMTP id
 k25-20020a05600c0b5900b003d64ba9c111mr241645wmr.40.1671528834044; 
 Tue, 20 Dec 2022 01:33:54 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 bd26-20020a05600c1f1a00b003d070e45574sm15319946wmb.11.2022.12.20.01.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:33:53 -0800 (PST)
Message-ID: <8f63bb10-e1e4-0111-5032-dca1b4a2f437@redhat.com>
Date: Tue, 20 Dec 2022 10:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 10/18] fbdev/efifb: Add struct efifb_par for driver data
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-11-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-11-tzimmermann@suse.de>
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
> The efifb_par structure holds the palette for efifb. It will also
> be useful for storing the device's aperture range.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

