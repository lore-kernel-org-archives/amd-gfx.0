Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09439C10F09
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 08:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A7E10E359;
	Mon, 11 Dec 2023 08:29:03 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B35510E036
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Dec 2023 18:24:14 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-425922f5b89so26250861cf.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Dec 2023 10:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702232653; x=1702837453; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
 :message-id:references:cc:to:from:subject:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFC+Ld7HDeMUs4re+B6x4b2YLJQHbLSKDEyx71KqL3A=;
 b=fKE/efylAhD7R1F4K7FV2AyTkR6RKJ8RSDJ6iulFJrQ8hTT7ScFjelXKBoTCZ1gea0
 Kq8ELrC1Mfz5v3PKN3TuY3kwweGut+TNCTJv1KvKRZzpEaJeCe24yE+JvkiCTC4OU7ho
 OxQLysH7GtNvOtghFpx8TbmYzzJxtS0k55GfWynQyrST1R3NnZuvDFP1ogw0hl+YZm0n
 7eDuxNQQ1GiZ3U2ruarzreElhftFC6diR1gYPsjhpVqzpSk/JT7C4J+Bz23gSMZNkJf5
 8Q/nlezoeifrREKgjaE0KzF1ePB+HjJiNGi0mcImdEVhdo0NEc6mAzjTNF6VuWjSdPAm
 VmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702232653; x=1702837453;
 h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
 :message-id:references:cc:to:from:subject:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VFC+Ld7HDeMUs4re+B6x4b2YLJQHbLSKDEyx71KqL3A=;
 b=IIMBWGSgVzp/dP7KW+wETo70LBxibs76j8tMNv8O47TdRJsuIIzMrYDZdyFVXRIXI4
 OGu4tbNBzJcAZuQ4sDXG1rV57igmO74deFKdpIU18xxw8BhnrPE19+Hvn+pbMi2BaRIs
 gR7KfylQG2Ty2rYDGCyMSoDuXQWHy9V+VJ9kLULIi4c/LYUz4p/tYkstvhBwTcDkWv4W
 j6NcKcK6+YGkyLhNUPaXJBE/dUjtOlP6vZeHjGgqygBQHA+8tpRQzb7yI7c1qkc5ePMZ
 UAQa9Ag5T3MzRZPEDg5cQdz7A2LaYOW/dqdrsndpvIA7VNXMnWO6vPJ8vlb0Lf5YikgZ
 NwiQ==
X-Gm-Message-State: AOJu0YwVeeY+ZWAvCg0yE70lAplh5wNB0c6fiXe5HCn8vzSPlxZj85IU
 +tXRXiAOb5uzbAIUNPa+IQ==
X-Google-Smtp-Source: AGHT+IGiwVuS82uMmowPDIIs+WOardV+vbpfdEESKrFXKPIXGeQUK50jQvQcMakDsJIXeyWrqcn+LA==
X-Received: by 2002:ac8:5795:0:b0:418:1a5c:dcc2 with SMTP id
 v21-20020ac85795000000b004181a5cdcc2mr5288319qta.19.1702232653469; 
 Sun, 10 Dec 2023 10:24:13 -0800 (PST)
Received: from [120.7.1.23] (198-84-239-141.cpe.teksavvy.com. [198.84.239.141])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ac84806000000b004255638e8b9sm2534715qtq.79.2023.12.10.10.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Dec 2023 10:24:13 -0800 (PST)
Subject: Re: [PATCH] drm/radeon: Prevent multiple error lines on suspend
From: Woody Suwalski <terraluna977@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
References: <78cc3067-b458-5cf2-d9f4-908aa5a4c5d5@gmail.com>
Message-ID: <6beb3bab-b559-9333-320f-f0c03eb24326@gmail.com>
Date: Sun, 10 Dec 2023 13:24:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18
MIME-Version: 1.0
In-Reply-To: <78cc3067-b458-5cf2-d9f4-908aa5a4c5d5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Dec 2023 08:29:01 +0000
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 terraluna977@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello, it has been now over 2 weeks and I have not seen any response to 
this patch.
Has it been lost in the cracks of the wide internet ? :-(

Thanks, Woody


Woody Suwalski wrote:
> # Fix to avoid multiple error lines printed on every suspend by Radeon 
> driver's debugfs.
> #
> # radeon_debugfs_init() calls debugfs_create_file() for every ring.
> #
> # This results in printing multiple error lines to the screen and 
> dmesg similar to this:
> # debugfs: File 'radeon_ring_vce2' in directory '0000:00:01.0' already 
> present!
> #
> # The fix is to run lookup for the file before trying to (re)create 
> that debug file.
>
> # Signed-off-by: Woody Suwalski <terraluna977@gmail.com>
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ring.c 
> b/drivers/gpu/drm/radeon/radeon_ring.c
> index e6534fa9f1fb..72b1d2d31295 100644
> --- a/drivers/gpu/drm/radeon/radeon_ring.c
> +++ b/drivers/gpu/drm/radeon/radeon_ring.c
> @@ -549,10 +549,15 @@ static void radeon_debugfs_ring_init(struct 
> radeon_device *rdev, struct radeon_r
>  #if defined(CONFIG_DEBUG_FS)
>      const char *ring_name = radeon_debugfs_ring_idx_to_name(ring->idx);
>      struct dentry *root = rdev->ddev->primary->debugfs_root;
> -
> -    if (ring_name)
> -        debugfs_create_file(ring_name, 0444, root, ring,
> -                    &radeon_debugfs_ring_info_fops);
> +    struct dentry *lookup;
> +
> +    if (ring_name) {
> +        if ((lookup = debugfs_lookup(ring_name, root)) == NULL)
> +            debugfs_create_file(ring_name, 0444, root, ring,
> +                        &radeon_debugfs_ring_info_fops);
> +        else
> +            dput(lookup);
> +    }
>
>  #endif
>  }
>

