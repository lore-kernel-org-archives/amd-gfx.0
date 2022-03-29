Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156D6C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 08:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9362A10E78E;
	Tue, 29 Mar 2022 08:16:27 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FAA10E363
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 08:16:25 +0000 (UTC)
Received: from [192.168.0.4] (ip5f5aef5a.dynamic.kabel-deutschland.de
 [95.90.239.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 99D7A61EA1929;
 Tue, 29 Mar 2022 10:16:23 +0200 (CEST)
Message-ID: <1b99c19a-b2fd-5ad3-4313-eea56f42e369@molgen.mpg.de>
Date: Tue, 29 Mar 2022 10:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
Content-Language: en-US
To: Ruili Ji <ruili.ji@amd.com>
References: <20220328045845.1986195-1-ruili.ji@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220328045845.1986195-1-ruili.ji@amd.com>
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
Cc: yifan1.zhang@amd.com, Aaron.Liu@amd.com, amd-gfx@lists.freedesktop.org,
 prike.liang@amd.com, Ray.Huang@amd.com, Alexander.Deucher@amd.com,
 Ruili Ji <ruiliji2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Ruili,


Thank you for your patch.

Am 28.03.22 um 06:58 schrieb Ji, Ruili:
> From: Ruili Ji <ruiliji2@amd.com>
> 
> gfx10.3.3/gfx10.3.6/gfx10.3.7 shall use 0x1580 address for GCR_GENERAL_CNTL

Is any “user-visible“ problem fixed by this?

Please add a Fixes tag.


Kind regards,

Paul


> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 99df18ae7316..e4c9d92ac381 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3300,7 +3300,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_3[] =
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000242),
> -	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
> +	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff, 0x00000500),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x000000e4),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210),
> @@ -3436,7 +3436,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_6[] =
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000042),
> -	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
> +	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff, 0x00000500),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x00000044),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210),
> @@ -3461,7 +3461,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_7[] = {
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000041),
> -	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
> +	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff, 0x00000500),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x000000e4),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210),
>   	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210),
