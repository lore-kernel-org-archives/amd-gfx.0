Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB0BC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 13:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD9810E9F5;
	Thu, 10 Apr 2025 13:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NOocmX0j";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA4610E7BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 07:06:31 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso2903185e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 00:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744268790; x=1744873590; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cwxfCTEdetiKaMfqynDfn0wx7lhTuU9HpsdLJoyDrmE=;
 b=NOocmX0j4D9lop0z6AvBKjUqIf2bzoLe3BPlDqkkGevwOhRW93EI1/uDocO8oVMewW
 qeOuGH7Q9C/fi5QIYNxzaF5iYPXi2ZA2JvUAFWzwGe7TVkvS8eA16VN8+bDumFJjk1Ai
 Bn8Hval/Jn1vRgGt22CrUsaZjWGmRsNnnb+bLpPW6hf4Ba86CdLsAE6Iv3Du50cZsupo
 EGKupR3l7/WeTPvOQPQ/taztTJow1EHjjBZnHtE3bDZ+KuNo4Fndo3qzakhEY9VDx0mj
 QH2AAXeVJsT3bccTzIO52R/jRpJhDiIN7kdyScn/19JKQ6a7j/dT4ClENcVtUw+O2r63
 nOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744268790; x=1744873590;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cwxfCTEdetiKaMfqynDfn0wx7lhTuU9HpsdLJoyDrmE=;
 b=LGrBLf34qnrfZv6vwN/6cE/FhNc06fWla9Qi8Syu2Em+Ac9SPEjI0q6dwYQAinT186
 9h6XVdv2kigftwAydEC3mpmZ2dHn+EAM48iDws/hcWtoCn8Pb9591xwkAk8/2SsrIOTq
 Trg4YhVs5BkH24k4W6Zc5omHSJnoFN4m9onQZ6g9CkJrMw1VZIqRyv0OmmYMnAC4o9dc
 /9fqvcznOdF4jDTqoSfHoDivqEYOttO34k4ySTte54xtYS4w3nPf4WpN+m/MqIvbHUpk
 UWd3OAmhqrNlwV9LdTitPVDrqVGCSEIK4hNOItnAGVwkiaJQl1c0ABLottR2PwX83Dmc
 vxYw==
X-Gm-Message-State: AOJu0YzzZ8xhRBc4bnGiUC2/3qqohtfFEeBjvUACoIaV+pF6xWE/NiGx
 oYu1Bk7P6v7pjpPlkWSF08ZMIhJ2MQOF1eW8PvUWw0innU/BsVGWlpTpYIHfiLttMnDvhJFXLsa
 X
X-Gm-Gg: ASbGncvYjnETIWEGwyf0dHK48fHECtNvupwh0aESUAkkz65Q9l0vDKCNM/Bax803LHE
 Gv+nTm5WJE0S5CcXCEjMDkCCzVOfoi/praT69/JMGYdJWfGnvMszX8AHRyhXoyjQT5xNKJzCuXE
 A+zqCYTzlv0h3u9NiA8jvlD9TFDtlhBR6WNGev+OcAdPlWDXI3bHXd2+ms4fZKONP46eReegZ0P
 86b8THRUjNBhNNdmm0E0/KOofxqdz78wjk3OoDllJzsznsdfPN4AofSRUWmwdngdAC1636keAFJ
 7lyGqNXVP1d7YCpBomD5E7wbiJHNfEJyJC1RpgE5fd2qJQ==
X-Google-Smtp-Source: AGHT+IFau3e6qLoWSMO48vbZxGVOkcueBOlGBmRLhV5G/YbYHafg1UvVvF2Fh7TwwHwhx79axI8RGA==
X-Received: by 2002:a05:600c:34c2:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-43f2efe1e4dmr12810115e9.3.1744268790084; 
 Thu, 10 Apr 2025 00:06:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43f2066d6e8sm45924755e9.23.2025.04.10.00.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 00:06:29 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:06:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arvind Yadav <arvind.yadav@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: update userqueue BOs and PDs
Message-ID: <7074cf24-b136-44fc-a86d-4394d62c5242@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 10 Apr 2025 13:08:33 +0000
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

Hello Arvind Yadav,

Commit 70773bef4e09 ("drm/amdgpu: update userqueue BOs and PDs") from
Sep 25, 2024 (linux-next), leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:139 amdgpu_gem_update_bo_mapping()
	error: we previously assumed 'bo_va' could be null (see line 124)

drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
    115 static void
    116 amdgpu_gem_update_bo_mapping(struct drm_file *filp,
    117                              struct amdgpu_bo_va *bo_va,
    118                              uint32_t operation,
    119                              uint64_t point,
    120                              struct dma_fence *fence,
    121                              struct drm_syncobj *syncobj,
    122                              struct dma_fence_chain *chain)
    123 {
    124         struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
                                  ^^^^^^^^^^
If bo_va is NULL then bo is also NULL

    125         struct amdgpu_fpriv *fpriv = filp->driver_priv;
    126         struct amdgpu_vm *vm = &fpriv->vm;
    127         struct dma_fence *last_update;
    128 
    129         if (!syncobj)
    130                 return;
    131 
    132         /* Find the last update fence */
    133         switch (operation) {
    134         case AMDGPU_VA_OP_MAP:
    135         case AMDGPU_VA_OP_REPLACE:
    136                 if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
                            ^^

    137                         last_update = vm->last_update;
    138                 else
--> 139                         last_update = bo_va->last_pt_update;
                                              ^^^^^
This pointer is dereferenced without being checked.

    140                 break;
    141         case AMDGPU_VA_OP_UNMAP:
    142         case AMDGPU_VA_OP_CLEAR:
    143                 last_update = fence;
    144                 break;
    145         default:
    146                 return;
    147         }
    148 
    149         /* Add fence to timeline */
    150         if (!point)
    151                 drm_syncobj_replace_fence(syncobj, last_update);
    152         else
    153                 drm_syncobj_add_point(syncobj, chain, last_update, point);
    154 }

regards,
dan carpenter
