Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C76C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 06:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4269610E3F1;
	Mon, 21 Mar 2022 06:14:37 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C93110E3F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 06:14:36 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5aef4e.dynamic.kabel-deutschland.de
 [95.90.239.78])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 108CA61E6478B;
 Mon, 21 Mar 2022 07:14:34 +0100 (CET)
Message-ID: <f33ad0c6-78b0-e422-52d4-f741060c011d@molgen.mpg.de>
Date: Mon, 21 Mar 2022 07:14:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH Review 1/1] drm/amdgpu/pm: add asic smu support check
Content-Language: en-US
To: Stanley Yang <Stanley.Yang@amd.com>
References: <20220321054533.15218-1-Stanley.Yang@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220321054533.15218-1-Stanley.Yang@amd.com>
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
Cc: Evan.Quan@amd.com, Tao.Zhou1@amd.com, Candice.Li@amd.com,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Stanley,


Thank you for your patch.


Am 21.03.22 um 06:45 schrieb Stanley.Yang:

Some nits:

Could you please remove the dot from the name:

     $ git config --global user.name "Stanley Yang"
     $ git commit --amend -s --author="Stanley Yang <Stanley.Yang@amd.com>"

The prefix drm/amd/pm seems to be more common for changes in the file. 
Instead of *add … check*, you can also just use the verb *check*:

drm/amd/pm: Check ASIC SMU support

> It must check asic whether support smu
> before call smu powerplay function, otherwise
> it may cause null point on no support smu asic.

Please reflow for 75 characters per line. Also maybe write:

… it may cause a null pointer dereference on systems without an SMU ASIC.

(I am no native speaker myself though.)

On what device did you reproduce this null pointer dereference?

> Change-Id: Ib86f3d4c88317b23eb1040b9ce1c5c8dcae42488

Without documenting the Gerrit instance, the Change-Id is of no use.

I guess this also should go to the stable series? Please add a Fixes tag 
with the commit missing these checks.

> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 89fbee568be4..c73fb73e9628 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -500,6 +500,9 @@ int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size)
>   	struct smu_context *smu = adev->powerplay.pp_handle;
>   	int ret = 0;
>   
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +

I wonder, why `struct smu_context *smu = adev->powerplay.pp_handle` 
seems to work further up? Maybe the assignment should also be moved 
after the newly introduced check?

>   	mutex_lock(&adev->pm.mutex);
>   	ret = smu_send_hbm_bad_pages_num(smu, size);
>   	mutex_unlock(&adev->pm.mutex);
> @@ -512,6 +515,9 @@ int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev, uint32_t si
>   	struct smu_context *smu = adev->powerplay.pp_handle;
>   	int ret = 0;
>   
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
>   	mutex_lock(&adev->pm.mutex);
>   	ret = smu_send_hbm_bad_channel_flag(smu, size);
>   	mutex_unlock(&adev->pm.mutex);


Kind regards,

Paul
