Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D06C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 10:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7298B112BB2;
	Mon,  6 May 2024 10:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rTKSWbdi";
	dkim-atps=neutral
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD5810FCCF
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 May 2024 19:35:20 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-2e2a4c20870so9344421fa.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 04 May 2024 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714851318; x=1715456118; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cdVSQr/7CPcSlh4WK6ZvPRfcGlbe0X3nwpemri+xm6k=;
 b=rTKSWbdid0IxcfW199Atetj/UvqsFMvkwmjX+1YgMpbllvS3jk527ubppsKGM1NUjv
 1DfEopvflCtS1HSyBHNISamRp/XpAvrRq5c6oNp15pDePgdGP4Q0djh02lyVkGU3UQuq
 7B8oKIwq5ITeDzaGRVmKWsflwyKhFZNtSCVXWOOlHCSOSmssNCb+d+BZqjIDLQraduO4
 CL+cNCFXqd9pwxqErFE7GxKAFKOOBJXFSf918FNG12nL/WTZur/6Ga2sJh0a1SXbWn6F
 ku+XLHNJqaHuxhJzXb5qPloN8Zud2O4350UqQxMElBFoLyo72ZwWEKYGR2c0D3n5mu84
 5x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714851318; x=1715456118;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cdVSQr/7CPcSlh4WK6ZvPRfcGlbe0X3nwpemri+xm6k=;
 b=taYlqsDUAZ3o42E7VH3iuLEpuOjMQ0FJg0lFKWYa3sd5YVrE4tCQRQEA5e+QuTDjT1
 mzPn8zpp+t/8E8oFSx/8skHUNO2V4ocEkgsHkJOxEajCQ6GFOWnuEOPa3oXBN91c8ndu
 sfvW/vA/vTBwHt+34+KeFkTOZDjznDVA6Hx1V9Coj9gOdDbGfunE9bxTIun6Qn9ZMnWl
 VfWpuLJOXVw0Nd2VQmp1FoowcPQcegOabVKoB0R18oC7RivyoQkTw9/Cl3fmw9D9TOYh
 icRW2FyUmMByjdjjVNHcSBcHxpe+zhyE1WkvoCtaSGz/4lA9Z85770p4ivNWBKrkt8Js
 C0Kg==
X-Gm-Message-State: AOJu0Yx3L2MlYmwkVsDMrSvfdoyoWOtz/q4+jZFRaoaGPuhMZvImO6hF
 F2RuIe6MlEFaERmqM7E8oSFFkdijb6XFpIPBgPSkH+KFmysBP20TWAvtpKuisJc=
X-Google-Smtp-Source: AGHT+IFLDscnsfbimEunCA6BjoBMvxcyRsk4PiPHBiYqu/BCr6t3Zyor6hntyTEhiVgqSwcquXuWGQ==
X-Received: by 2002:a2e:990c:0:b0:2df:b8f5:2e66 with SMTP id
 v12-20020a2e990c000000b002dfb8f52e66mr3593924lji.15.1714851317635; 
 Sat, 04 May 2024 12:35:17 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 fc16-20020a05600c525000b00418d68df226sm13961554wmb.0.2024.05.04.12.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 12:35:17 -0700 (PDT)
Date: Sat, 4 May 2024 22:35:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: sreekant.somasekharan@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [bug report] drm/amdkfd: mark GFX12 system and peer GPU memory
 mappings as MTYPE_NC
Message-ID: <52b003ec-a570-49f5-9150-79f8feb46339@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 06 May 2024 09:59:59 +0000
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

Hello Sreekant Somasekharan,

This is a semi-automatic email about new static checker warnings.

Commit 628e1ace2379 ("drm/amdkfd: mark GFX12 system and peer GPU
memory mappings as MTYPE_NC") from Mar 26, 2024, leads to the
following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c:518 gmc_v12_0_get_vm_pte()
    warn: variable dereferenced before check 'bo' (see line 500)

drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
   499		struct amdgpu_bo *bo = mapping->bo_va->base.bo;
   500		struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
                                                                ^^^^
   501		bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
                                ^^^^^^^^^
   502		bool is_system = bo->tbo.resource->mem_type == TTM_PL_SYSTEM;
                                 ^^^^^^^
The patch adds unchecked dereferences.

   503	
   504	
   505		*flags &= ~AMDGPU_PTE_EXECUTABLE;
   506		*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
   507	
   508		*flags &= ~AMDGPU_PTE_MTYPE_GFX12_MASK;
   509		*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_GFX12_MASK);
   510	
   511		if (mapping->flags & AMDGPU_PTE_PRT_GFX12) {
   512			*flags |= AMDGPU_PTE_PRT_GFX12;
   513			*flags |= AMDGPU_PTE_SNOOPED;
   514			*flags |= AMDGPU_PTE_SYSTEM;
   515			*flags &= ~AMDGPU_PTE_VALID;
   516		}
   517	
   518		if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
                    ^^
But previously we assumed bo could be NULL.

   519				       AMDGPU_GEM_CREATE_UNCACHED))
   520			*flags = (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |

regards,
dan carpenter
