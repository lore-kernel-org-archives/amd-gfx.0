Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2027C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 17:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F01410E1B1;
	Thu, 14 Apr 2022 17:58:56 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67E8210E1B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 17:58:54 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae92a.dynamic.kabel-deutschland.de
 [95.90.233.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id D1B1F61EA1928;
 Thu, 14 Apr 2022 19:58:52 +0200 (CEST)
Message-ID: <9d77bd3d-782b-7866-7ae2-c2f88f1e1002@molgen.mpg.de>
Date: Thu, 14 Apr 2022 19:58:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amd/amdgpu: Remove static from variable in RLCG Reg
 RW.
Content-Language: en-US
To: Gavin Wan <Gavin.Wan@amd.com>
References: <20220413152641.830023-1-Gavin.Wan@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220413152641.830023-1-Gavin.Wan@amd.com>
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

Dear Gavin,


Thank you for your patch.

Am 13.04.22 um 17:26 schrieb Gavin Wan:

Should you re-roll your patch (v2), please remove the dot/period from 
the end of the git commit message summary (subject).

> [why] These static variables saves the RLC Scratch registers address.

s/saves/save/

>        When we installed multiple GPUs (for example: XGMI setting) and

s/installed/install/

>        multiple GPUs call the function at same time. The RLC Scratch

… same time, the RLC …

>        registers address are changed each other. Then it caused

s/caused/causes/

>        reading/writing to wrong GPU.

I see from other patches posted here, that [why] is put on a separate 
line, so you do not need to indent the text.

[why]

These static …

> 
> [fix] Removed the static from the variables. The variables are
>        in stack.

Same here, though *how* instead of *fix* seems more common.

s/Removed/Remove/
s/in stack/on the stack/

> 
> Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
> Change-Id: Iee78849291d4f7a9688ecc5165bec70ee85cdfbe

Without the Gerrit URL that line is useless.


Kind regards.

Paul


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index d5eea031c3e3..d18a05a20566 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -868,11 +868,11 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
>   	uint32_t timeout = 50000;
>   	uint32_t i, tmp;
>   	uint32_t ret = 0;
> -	static void *scratch_reg0;
> -	static void *scratch_reg1;
> -	static void *scratch_reg2;
> -	static void *scratch_reg3;
> -	static void *spare_int;
> +	void *scratch_reg0;
> +	void *scratch_reg1;
> +	void *scratch_reg2;
> +	void *scratch_reg3;
> +	void *spare_int;
>   
>   	if (!adev->gfx.rlc.rlcg_reg_access_supported) {
>   		dev_err(adev->dev,
