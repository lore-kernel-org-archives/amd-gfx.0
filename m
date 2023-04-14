Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9A6C77B78
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 21:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D33C89453;
	Fri, 14 Apr 2023 21:12:21 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6978589453
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 21:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SJ4dq8DLVRpQ7EcK8yqMjD9fVFSqBZ7G8ISuEQmddFI=; b=Wv1g4ubzTqNQg9lPghqZFoB9CH
 aFsMw7QBG+ZDGTJjDG4aRq6C9/Uq1D84B+hJy+v7+MsKk5s5JxcPA63L7s1L/39SKGM3PZw2fcv2K
 jcYg9xzsKW8nYlxO3jk9b8R1nXHUv4pP4msMDq0bitdbjoyfVJnKQTzLXN+AifEaNPVwYVje5Nb4T
 AtvX3cnG8+usJayjJoB68a81euWVAM+TrOTRS5oUHuC6rySPdeOt9C9HN6woKKGM7BbvBdfTHsJB3
 5I1Q0ZQ026fVoCt9kN1t2fLVXN6sLbt1ZvE3P0VOs9kjzRlzsC3lc4EnNUF1or5WZjD5eMAuqJg8z
 rJ78L7QA==;
Received: from [179.113.251.65] (helo=[192.168.1.111])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1pnQiO-001J9j-RB; Fri, 14 Apr 2023 23:12:16 +0200
Message-ID: <ea433d88-507b-5b0f-e3c6-8711e15bd166@igalia.com>
Date: Fri, 14 Apr 2023 18:11:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
Content-Language: en-US
To: Alan Liu <HaoPing.Liu@amd.com>
References: <20230414162215.1201883-1-HaoPing.Liu@amd.com>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20230414162215.1201883-1-HaoPing.Liu@amd.com>
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
Cc: bhawanpreet.lakha@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alan,

Em 14/04/2023 13:22, Alan Liu escreveu:
> [Why]
> After gpu-reset, sometimes the driver would fail to enable vblank irq,
> causing flip_done timed out and the desktop freezed.
> 
> During gpu-reset, we will disable and enable vblank irq in dm_suspend()
> and dm_resume(). Later on in amdgpu_irq_gpu_reset_resume_helper(), we
> will check irqs' refcount and decide to enable or disable the irqs
> again.
> 
> However, we have 2 sets of API for controling vblank irq, one is
> dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
> its own refcount and flag to store the state of vblank irq, and they
> are not synchronized.
> 
> In drm we use the first API to control vblank irq but in
> amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.
> 
> The failure happens when vblank irq was enabled by dm_vblank_get()
> before gpu-reset, we have vblank->enabled true. However, during
> gpu-reset, in amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state
> checked from amdgpu_irq_update() is DISABLED. So finally it will disable
> vblank irq again. After gpu-reset, if there is a cursor plane commit,
> the driver will try to enable vblank irq by calling drm_vblank_enable(),
> but the vblank->enabled is still true, so it fails to turn on vblank
> irq and causes flip_done can't be completed in vblank irq handler and
> desktop become freezed.
> 
> [How]
> Combining the 2 vblank control APIs by letting drm's API finally calls
> amdgpu_irq's API, so the irq's refcount and state of both APIs can be
> synchronized. Also add a check to prevent refcount from being less then
> 0 in amdgpu_irq_put().
> 

How have you tested this patch?

> v2:
> - Add warning in amdgpu_irq_enable() if the irq is already disabled.
> - Call dc_interrupt_set() in dm_set_vblank() to avoid refcount change
>    if it is in gpu-reset.
> 

If this is a v2, please use [PATCH v2] in the subject.

Thanks,
	André
