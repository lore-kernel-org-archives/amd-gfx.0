Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485D8C77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 09:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E58F610E541;
	Tue, 24 Jun 2025 09:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="Ydlb/TSe";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696BC10E541
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 09:46:58 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-453426170b6so36429065e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 02:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1750758417; x=1751363217;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7KXxwbHVWhaJwWfs+CMcQez53m1pJfDu3vlWMg5CPb0=;
 b=Ydlb/TSeADLRhat9K5AmM+MWsIBmNcYhkRep96FbPA8k8yQCmL4NCgxQDUufmKwBoh
 kPK+Gq38z6A6chprwFC6XyY7fAJ60dLlU9zYI/w9n1e54HjBwgGeUP+MyltWcS3IwM8W
 7wd1cyxuI4ojBIE/vONn5Br39kuXTMoT1V34MuXBQTiBaGuumxFQ0Hy9g8uzlHFuf7Ps
 ldgry4t2EmupnCuo4alElq8B33bin39iRdLQw02D7hErooQyvm51At1kcCEm2LsSiSLB
 NsVjNrl26aUhXqiq7talsur4arqkMLLvLhut8S44WsQWLr2GBjlneXzL5SzDb7iSJv8E
 xFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750758417; x=1751363217;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7KXxwbHVWhaJwWfs+CMcQez53m1pJfDu3vlWMg5CPb0=;
 b=aquA2U4JnovWOkqVlyT6eHp2AX2Hiz+UvRDTpldLZAgdEQQa3x9C4O+yqCE+ZBiH3P
 QEGxbkB0snvfC9gXmpfCyB63OYZU53q3dl/WzBYPdUOlXeYJXZvT4+QWQ3vVrUkSe/TI
 W3pym1J0k0fdW+KHZLKgNKMPWjOsR3/yg638S1KS9LXJwil+u1mJlFxlDPjJ+V7lYy9O
 3spY3nDEFyeSEc/oCk+rFvxnLc3IHwMwmeEdGv02Diwnx8UWG7Oh9jDADakJ9rYuBAXj
 8ao2BLBlkDKmSlbFNztWMhuf/+GfEuaFRC2rcLFL/O4PsvACN8y6PV2wqf1ONtTRL/Ll
 niQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC7eul41pHUr+gmWHnRs/TeLGDnZEC1YNll5ag92mx5nV0O8n0y3Tp1DyuriNanjPgLIb30Mep@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw13oQW/61o6T6MiZ9FtJzYLzTXa/6dnDJrxd03JkOSLOqe96eC
 jowwRFLv81fey/nPCvKS/+O9TIcukDjxZJv1gZ1AXOZcYt5oCQlQq7srm63uH8GSIQMCAv3Xgj8
 2exBK
X-Gm-Gg: ASbGncuP4Vt0k4PYDMg+1QangQrp1SWM3GoUFDN2SYl1dq0pYbXHQMdTvSVwwjYZ7up
 uuFXkwn9yTXFeUmKUaVb83guPJ34cGkCNPvFijbQhzvptER+/NYbC/hZFKVVQs6RCFWxKJhjlRf
 AA1ijkIVscit3KoZMM3+CuEux9HVja1rWrE+ixLRkHey7C5/T86caDUYuPbjs2FSsd/Lt6AQKla
 X5+2ujfRNaKPhWfT18Mm1Vpk+cSBYdskFNm9OdRXPrlY1HCCP4GdAf39Qx7pPVGxY1P2mdb+yQU
 tCCcgsBtu8kgF4f+8hihMWA7BEfDezx+WuuiRWwFT8ppvByfVdubCuh5DbmRemtiA4NUsD+D2D/
 +
X-Google-Smtp-Source: AGHT+IHe98vbPFuP0inahHGYkGgZXsJrrTIOSa5hnhDZWpiX+E23u2PXsQyTQWGjgjcUSW4DdByhDQ==
X-Received: by 2002:a5d:5f92:0:b0:3a5:25e2:6129 with SMTP id
 ffacd0b85a97d-3a6e7206741mr2286030f8f.21.1750758416996; 
 Tue, 24 Jun 2025 02:46:56 -0700 (PDT)
Received: from [192.168.0.101] ([81.79.92.254])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646fd642sm132712455e9.21.2025.06.24.02.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 02:46:56 -0700 (PDT)
Message-ID: <b7fc658e-2778-48dd-8584-3f33bbcc5ab7@ursulin.net>
Date: Tue, 24 Jun 2025 10:46:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: put ctx's ref count in
 amdgpu_ctx_mgr_entity_fini()
To: "Lin.Cao" <lincao12@amd.com>, amd-gfx@lists.freedesktop.org
Cc: haijun.chang@amd.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
References: <20250624091823.3963949-1-lincao12@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250624091823.3963949-1-lincao12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 24/06/2025 10:18, Lin.Cao wrote:
> patch "daf823f1d0cd drm/amdgpu: Remove duplicated "context still
> alive" check" removed ctx put, which will cause amdgpu_ctx_fini()
> cannot be called and then cause some finished fence that added by
> amdgpu_ctx_add_fence() cannot be released and cause memleak.

Ouch I removed the wrong one. :( Probably misread kref_put as kref_read..

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

But is the SHA correct? I see it is dd64956685fa.

Which would mean adding:

Fixes: dd64956685fa ("drm/amdgpu: Remove duplicated "context still 
alive" check")

Regards,

Tvrtko

> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 85567d0d9545..f5d5c45ddc0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -944,6 +944,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>   				drm_sched_entity_fini(entity);
>   			}
>   		}
> +		kref_put(&ctx->refcount, amdgpu_ctx_fini);
>   	}
>   }
>   

