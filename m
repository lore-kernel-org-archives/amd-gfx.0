Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F22C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 21:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5841810E1F4;
	Fri, 14 Apr 2023 21:14:56 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4834810E1F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=87Lws74Xk+hGptBqd7JUJZQuhfUy8s+srpz8RDxZ3PI=; b=E+3w2uo8bRI2b0l0vviZHyCddX
 9VWZAGaDDmOZwnKOQrHeJOOlJelksXOis9olXY8tu3s2CltKM22iNHDZIkfUUzNe4Fkq7iK7vT7tk
 imlF5vRJpTunIKLyB1axf2CrBP6gYELLwEqoAHpamWEXWCyzkWwRGCwrCB5PCF/hqmlr60mDi0k6V
 5NGGDdAQce7DQ/rIaDoBM3rImEwSk9OlfSeSsZof9f17ZyzBULZZTBRf3zTaPT5ebjYE8nxZP+5VA
 TLiA5dBvjgobT5ONOYOmF0G5JHrVHHR4ZRTt3c2x6kYfF8htJBs+yf417dUWCSLFqDvRXsS89txgO
 d0kP9YAA==;
Received: from [179.113.251.65] (helo=[192.168.1.111])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1pnQku-001JD8-LF; Fri, 14 Apr 2023 23:14:52 +0200
Message-ID: <db879c2d-185b-838f-93eb-75b1fda31520@igalia.com>
Date: Fri, 14 Apr 2023 18:14:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amdgpu: add new flag to AMDGPU_CTX_QUERY2
Content-Language: en-US
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20230413101823.80732-1-pierre-eric.pelloux-prayer@amd.com>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20230413101823.80732-1-pierre-eric.pelloux-prayer@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Em 13/04/2023 07:18, Pierre-Eric Pelloux-Prayer escreveu:
> OpenGL EXT_robustness extension expects the driver to stop reporting
> GUILTY_CONTEXT_RESET when the reset has completed and the GPU is ready
> to accept submission again.
> 
> This commit adds a AMDGPU_CTX_QUERY2_FLAGS_RESET_IN_PROGRESS flag,
> that let the UMD know that the reset is still not finished.
> 
> Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22290
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Reviewed-by: André Almeida <andrealmeid@igalia.com>

