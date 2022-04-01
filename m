Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84549C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 05:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B7F10EB5D;
	Fri,  1 Apr 2022 05:51:58 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286DF10EB5D
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Apr 2022 05:51:57 +0000 (UTC)
Received: from [192.168.0.4] (ip5f5aef67.dynamic.kabel-deutschland.de
 [95.90.239.103])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 91F1B61EA192A;
 Fri,  1 Apr 2022 07:51:55 +0200 (CEST)
Message-ID: <d5255baa-d957-bae2-d29a-b654ae48237d@molgen.mpg.de>
Date: Fri, 1 Apr 2022 07:51:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: don't use BACO for reset in S3
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>
References: <20220331145623.1854199-1-alexander.deucher@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220331145623.1854199-1-alexander.deucher@amd.com>
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

Dear Alex,


Thank you for your patch.

Am 31.03.22 um 16:56 schrieb Alex Deucher:
> Seems to cause a reboots or hangs on some systems.

It’d be great if you listed the systems from the bug reports.

> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1924
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1953
> Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend (v2)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index c73fb73e9628..1ff6c42fb110 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -173,6 +173,9 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
>   
>   	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
>   		return false;
> +	/* don't use baco for reset in S3 */

In issue #1924, I think you also write, it’s a workaround. Maybe make 
that clear in the comment?

> +	if (adev->in_s3)
> +		return false;
>   
>   	mutex_lock(&adev->pm.mutex);
>   


Kind regards,

Paul
