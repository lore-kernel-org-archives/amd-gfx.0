Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90674C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 08:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0ABF10EBE1;
	Wed,  2 Mar 2022 08:38:01 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE75710EBE1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 08:38:00 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 x8-20020a05600c21c800b0038553f49821so214254wmj.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Mar 2022 00:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=LaxiwdbyVSYcHKiGFBMkPFdCUpbtqyBJx+c7kKsJCt4=;
 b=nbbIWBjP1FAakEH29yUsEyrh0oVYg4FmPwdsBuHR5PDbHg55BQbDVfhmjfcovnIDPq
 2Y35f7ig3zRcw8QKvl9J/6U8nf7+WudJYlKVPVkyhLfSh6H/HQ8w83ISluwTzy2SRZb0
 n8z5sL+dfWa4OdwNkyVO/BQlxCNxlS+BsVADRubKF37edF5xCtv9J9FLuN5n45NmDmSR
 c0HYliTjZZi/dy9IbuYQJRzC/wdj6gRmk5F6TkuFmEbEQEN+bByfC0D6z6ZoW/+Wqmcb
 GqHWaiuVT5CJhSW+VOZFyDklvOnqlr/uAbRoHdAU/m3RO/swEWr3ZGt/fLCWJR9kjobR
 pS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=LaxiwdbyVSYcHKiGFBMkPFdCUpbtqyBJx+c7kKsJCt4=;
 b=PShkhA8abheckS0Ps3A7T+f8lq6CGjqqHkDxMKcuX9N5hLMYbNcfsErTRS6PO6qpd/
 6hb/ycgkh/nujQ4X/FelQHOZYCPJS5oqeUHyQXOjxfgr63dZmnP6t2OSmLigPQUTYiRv
 7xC3nS2I5iXI89k92lnGT8Qf/ADvYniquFkLui2eEXmwhhB/jtLu2dkm9kORBUOxduyC
 3ensHZ6hxCzE619HHDgDP+EahYjYB5yT/3uNx1fJ04G9ERglQ1zDXixFSuZR5v/Xsiuz
 Tp9rT4NiOXsunet+cfk8VuruwmW273nmIqiP2hd6ARTXaXQWCVmKQAW6t2mtkAZkXorg
 CbeQ==
X-Gm-Message-State: AOAM532e3CqJoFD613ngaxHK9VFuYlKnQJUM7eaEcI6QvhPQC8eeBW7l
 Sa76E0EZdoP5AVGw3+IYxLE=
X-Google-Smtp-Source: ABdhPJxMMeOBUm4ncC6/DilPCBsrK1EpJ2hKIqcohPZ3n9Dw5rLVGtFANQQocVDpDgJwiWEWKZwIFg==
X-Received: by 2002:a05:600c:3ac5:b0:381:5257:3df8 with SMTP id
 d5-20020a05600c3ac500b0038152573df8mr12417606wms.175.1646210279250; 
 Wed, 02 Mar 2022 00:37:59 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:91d6:cd7c:ea5f:1ff5?
 ([2a02:908:1252:fb60:91d6:cd7c:ea5f:1ff5])
 by smtp.gmail.com with ESMTPSA id
 m2-20020adff382000000b001f022ef0375sm3107091wro.102.2022.03.02.00.37.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Mar 2022 00:37:58 -0800 (PST)
Message-ID: <09402cd4-8cc2-2ec2-e239-823bae762c1f@gmail.com>
Date: Wed, 2 Mar 2022 09:37:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix sigsev when accessing MMIO on hot
 unplug.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220301180800.1781042-1-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220301180800.1781042-1-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.03.22 um 19:07 schrieb Andrey Grodzovsky:
> Protect with drm_dev_enter/exit
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for this one here.

Regarding the version bumb you should probably sync up with Alex.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index f522b52725e4..4294f17cedcb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -23,6 +23,7 @@
>    */
>   
>   #include <drm/drm_auth.h>
> +#include <drm/drm_drv.h>
>   #include "amdgpu.h"
>   #include "amdgpu_sched.h"
>   #include "amdgpu_ras.h"
> @@ -339,7 +340,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
>   {
>   	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
>   	struct amdgpu_device *adev = ctx->adev;
> -	unsigned i, j;
> +	unsigned i, j, idx;
>   
>   	if (!adev)
>   		return;
> @@ -350,7 +351,12 @@ static void amdgpu_ctx_fini(struct kref *ref)
>   			ctx->entities[i][j] = NULL;
>   		}
>   	}
> -	amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
> +
> +	if (drm_dev_enter(&adev->ddev, &idx)) {
> +		amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
> +		drm_dev_exit(idx);
> +	}
> +
>   	kfree(ctx);
>   }
>   

