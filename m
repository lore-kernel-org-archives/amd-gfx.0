Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62CBC369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 07:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6778010E40F;
	Wed, 23 Apr 2025 07:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AKy0i+eQ";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04BA10E1D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 05:38:52 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so33354725e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 22:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745386730; x=1745991530; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MeGAt7xRvc//bByV4JLU0wax0Kl1QxwZERbFWrDsKGU=;
 b=AKy0i+eQkGdeS2vtn1rSSisyPd4Mj+3pGIAqJ4alzs40l/K0pDypzNn5xPTMtXdsv6
 2KqhdE4dKsQ/KYwh524rircn+94Obczttl+2tS+N6M9HIEP6YIzIyFHOzPRhV06WtJhg
 VbVEfxfeRTPIQswfsjcPLUaT7bN3apwcZSn5QdqbGIvOYFWwhGe1vDkffaAAfaxR4PFt
 PUXO6E+emi5VakVZxL9ijt2wuqX4jby8ihUakJwFSqrbYBu/VIBymNgr8MFoQcBwUWzG
 NjRKp0K8iE5JNKnavuYKpZSDvSKqI9FVm9qjCD8iZvEoSqYkokeQpK71qK6XEy6D6IAp
 kdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745386730; x=1745991530;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MeGAt7xRvc//bByV4JLU0wax0Kl1QxwZERbFWrDsKGU=;
 b=XFRd0Eh1exOaj78PJxC5tQBlzSvcVRRIKqmx7fztITHq56c1A/GRmuw+IlOVLIN2Dc
 o7p1o/eZaxZLjr3KyOxzyzUTfeMG7Z+loaYpIRwphDuMYghNRTPGG3UBdjgCLacl8EYo
 YMw3E2zPBj1OfLqN2+5BtElY2r8ijnGh6wPdOH4y//h1tO6RxmobpH5uSjdfEvJ70X/K
 gjjp/eWtgcEpQs8cuVrY5WxYjVUEC1PngQqoCTgl1zGz8/ZL/AIG321n/BnqVfpvM7cO
 1PKriS5u81JB3MCrMwGgSrRGJVh0fT2D8eDpsYJXh9PNR5mjthfHWT9DCDLzoHMQT0uH
 I/0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3phw9CiIgwe8a2+KiTZAb3cQzqHtzuiLFYcNtN6+rDr5x08ipAp6b1wcZn5gkzjC34c/rvU/k@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxi/E5yy543dpkVgH4tQVW+wwhWWfg3m33yXHAH5ATciSohEdGk
 fj99g6CFgrxbQVH7EInsJyTxS94fV7H+J8tl+qOTkhM0ZoLaHNRVn5dnGmSZmeI=
X-Gm-Gg: ASbGnctOFBoHDUvWS9vwD/H9eLP4OdPrtNjUbD63F/UnqwzJPSsD2bGzd4iCyWEhy36
 xBj7kEV7dtrg+W1hk15/p9QMNFJ0CB9b4vnQREH9+5tEWg4EFeZzzegkylBPAEhQPmSs4qNo5Q/
 dPTYUg3D6Gs1GrpVXftYm90GunTR9B5HR4V62B7EMJYDyyw+L6KazizyxXpFU5DvkA/oFm0byw3
 hjw1s8WJ9f7ZLVbFFWfEAkPcWC18c5Ed3GSEeapKrIEOQLrh6GrVfOl6lrxbhKONUsf7TX2S/oZ
 KufceHWrGiTw7bHs2tqVRHz2CsROQcc12bmMyiyB/CD5bQ==
X-Google-Smtp-Source: AGHT+IH+JvzhiiuPxp21fXThiXa4KKOQdZUrXylVOtl86V8GVkFQMLpklekA4Wo6RfFX01DamvuYdg==
X-Received: by 2002:a05:600c:3d19:b0:440:68db:a045 with SMTP id
 5b1f17b1804b1-4406abff89emr146908795e9.26.1745386730581; 
 Tue, 22 Apr 2025 22:38:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-44092d214acsm12361645e9.11.2025.04.22.22.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 22:38:49 -0700 (PDT)
Date: Tue, 22 Apr 2025 17:15:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/amdgpu: Add NULL check for 'bo_va' in
 update_bo_mapping v2
Message-ID: <306b6484-41a2-4ce0-88f5-a009c893de5d@stanley.mountain>
References: <20250411150052.3321230-1-srinivasan.shanmugam@amd.com>
 <20250422131726.3873364-1-srinivasan.shanmugam@amd.com>
 <7c581b1b-5174-4238-8a4f-1724e8977b45@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c581b1b-5174-4238-8a4f-1724e8977b45@amd.com>
X-Mailman-Approved-At: Wed, 23 Apr 2025 07:38:20 +0000
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

On Tue, Apr 22, 2025 at 03:34:58PM +0200, Christian König wrote:
> Am 22.04.25 um 15:17 schrieb Srinivasan Shanmugam:
> > This change adds a check to ensure that 'bo_va' is not null before
> > dereferencing it. If 'bo_va' is null, the function returns early,
> > preventing any potential crashes or undefined behavior
> 
> That commit message doesn't reflect the changes any more.
> 
> >
> > Fixes the below:
> > 	drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:139 amdgpu_gem_update_bo_mapping()
> > 	error: we previously assumed 'bo_va' could be null (see line 124)
> >
> > drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >     115 static void
> >     116 amdgpu_gem_update_bo_mapping(struct drm_file *filp,
> >     117                              struct amdgpu_bo_va *bo_va,
> >     118                              uint32_t operation,
> >     119                              uint64_t point,
> >     120                              struct dma_fence *fence,
> >     121                              struct drm_syncobj *syncobj,
> >     122                              struct dma_fence_chain *chain)
> >     123 {
> >     124         struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
> >                                   ^^^^^^^^^^ If bo_va is NULL then bo is also NULL
> >
> > 	...
> >     135         case AMDGPU_VA_OP_REPLACE:
> >     136                 if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
> >                             ^^
> >
> >     137                         last_update = vm->last_update;
> >     138                 else
> > --> 139                         last_update = bo_va->last_pt_update;
> >                                               ^^^^^ This pointer is dereferenced without being checked.
> >
> >     140                 break;
> 
> Please completely drop that. This conclusion is actually incorrect.
> 
> BO might be NULL here because bo_va->base.bo is NULL and *not* because bo_va is NULL.
> 
> @Dan your script seems to reports false positives here.
> 

I mean my analysis was only based on only looking at the function itself
without looking at the caller.

It turns out that it's a false positve because "bo_va" is only NULL when
the operation is AMDGPU_VA_OP_CLEAR.  You need to look at the caller and
also where fpriv->prt_va is set in amdgpu_driver_open_kms().  It's a bit
too complicated for Smatch to do this level of analysis.

Anyway, yes, please don't silence static checker false positives, just
ignore them.

regards,
dan carpenter

