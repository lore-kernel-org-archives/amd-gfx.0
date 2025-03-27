Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A14BC3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 14:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3861210E108;
	Thu, 27 Mar 2025 14:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YLyKI/QT";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD7C10E108
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 14:24:40 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso569597f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743085479; x=1743690279; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jA5zWc8usfXQIkiUrHzxol1e/E4uzM1rG9F1JKDhHqk=;
 b=YLyKI/QTQhhdeGW8vn47ezQb1/m9q+Gji0lbW2D99M8TBuX9nkWFSiUXkEKGrrtIDf
 XnOaMfb+S2MbrHGKyCSgkMVmOmRUuMgsP165bICbpew9OXaaXAu5agm7dEit4Sa7c5nH
 IaCKxC6gYHlgxR0SsyUj9KIm1s/dUtnjx7rz2KubiNAkgGh4DM/s0ToJ6rI3mNBwG78q
 61cqYqhzyq8SjQ4W5173kvcfMsbv0/VSEMoL0zPAj7viKXR+iZi7LfLHw/OCLQGPk8GN
 bZaAeWbQ7POLM4XDH1jhpxM3CzRpbANxpKMnHncULwMw+9hccNyJYD6xArExc+QKMd//
 axBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743085479; x=1743690279;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jA5zWc8usfXQIkiUrHzxol1e/E4uzM1rG9F1JKDhHqk=;
 b=sIfTJaf3FW/byKywMSYbSTtA6sDvFUYhbnD6m8ZXHQWIouzRY+cz0gfgUdE2Q2LWUq
 ItCZaEhclNggXrrfDupElX57VkD3ubT8YkcWzg/QIX7Y/GaUTIo2BKwAeo92d32ro2LX
 faB8TPHayzY+a9aBsniRqOatBG0sVapibiMy+WypFonWspIki7Yg4I8XxfoE5kkg3vae
 RF5SYiQmRkwnawicK8MXpgYk+ZMtLj+t5PGLqj5Vl2vJR4dvNizb4udjoD4XWamSEPjD
 /B6JxdnrwQCHFFJ7CLW56gtKZHaPPn4uwtN/HiXTLg0ib/TwL37KVe3THNukZNgsnM/P
 Mh6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwEcor5clVChE6arHdsyMZM/kOMFW73mESCS6SpOfOS4KSmQ/PfUzcbwG3lTUDjBuYfdB7a9/L@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBF2UdiaRAPjG/pM47ZO0CWUvOZ65y9qx9XT2R9FX0HDJvuHSB
 +YTjobe0UVrPTRtRXbnLCtQJ3T1111+4ETpvdZY95ctlbFwEexaB
X-Gm-Gg: ASbGncuXbbnoC+wjgf36bO1r5TuJj0B3OBRIZ91eEOONUjZeG7gPdn5NE4hRZdRvzCY
 w1Ik42mM7VOow3LNKoUpAt7WDPzlJo5iMe6cAjr/lYFRvBX0/J2ylOjSuaKJ0rlz3XVaugsTQm2
 5hBTDJARvmvkrm/dvdTcb+33DrcJ7Ui5SBmAOOH0imOdqDj/d7KGLXxOJchHc5SelFEivGCwkwU
 B6Qj0nIUTdCtQmHhH0BEF4zNY+bv8oDONws8kAbnuiLck5xuN168J6ixMbZkFQGNPHUJQ+cLdgR
 e4hqGYVAvTTpHDnv57WHzjMG+yuCbNY/hQaq6zYwctfGR3CF9HYJRs6ig0yuFfBEeJD0lp3xwA=
 =
X-Google-Smtp-Source: AGHT+IFYzviFio5hiQaPZAlwsm03GGLIGfPafzcB9/TyjLJx2SInBFsgqY3Ja+W2M0jSBzmfazAs1g==
X-Received: by 2002:a05:6000:22c7:b0:391:2ab1:d4c2 with SMTP id
 ffacd0b85a97d-39ad1770662mr3553728f8f.37.1743085478891; 
 Thu, 27 Mar 2025 07:24:38 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b26a6sm19722992f8f.44.2025.03.27.07.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 07:24:38 -0700 (PDT)
Message-ID: <fda52a2a-d5da-404b-97ed-1154ddc940cc@gmail.com>
Date: Thu, 27 Mar 2025 15:24:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: only lock the valid list of invalidated bo
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250327092752.1734634-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250327092752.1734634-1-Prike.Liang@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 27.03.25 um 10:27 schrieb Prike Liang:
> Before locking and traversing the user queue invalidated BO list,
> it requires ensuring the VM done list is available.

No it doesn't. This patch here is just a no-op.

list_for_each_entry() works perfectly fine on empty lists.

Regards,
Christian.

>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 20 ++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index ecd49cf15b2a..cb6b89da73c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -479,15 +479,17 @@ amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
>  		}
>  
>  		/* Lock the done list */
> -		list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> -			bo = bo_va->base.bo;
> -			if (!bo)
> -				continue;
> -
> -			ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
> -			drm_exec_retry_on_contention(&exec);
> -			if (unlikely(ret))
> -				goto unlock_all;
> +		if (!list_empty(&vm->done)) {
> +			list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> +				bo = bo_va->base.bo;
> +				if (!bo)
> +					continue;
> +
> +				ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
> +				drm_exec_retry_on_contention(&exec);
> +				if (unlikely(ret))
> +					goto unlock_all;
> +			}
>  		}
>  	}
>  

