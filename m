Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFD3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 09:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DF6110E642;
	Tue, 15 Mar 2022 09:25:29 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A9610E642
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 09:25:28 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae8f9.dynamic.kabel-deutschland.de
 [95.90.232.249])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id C768361EA1927;
 Tue, 15 Mar 2022 10:25:26 +0100 (CET)
Message-ID: <f0de6373-4148-5c56-d677-c2338c14e59f@molgen.mpg.de>
Date: Tue, 15 Mar 2022 10:25:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/amdgpu/vcn: fix vcn ring test failure in igt reload
 test
Content-Language: en-US
To: Tianci Yin <tianci.yin@amd.com>
References: <20220315023315.436797-1-tianci.yin@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220315023315.436797-1-tianci.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Wang Yu <yu.wang4@amd.com>, Zhu James <james.zhu@amd.com>,
 Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Tianci,


Am 15.03.22 um 03:33 schrieb Tianci Yin:
> From: "Tianci.Yin" <tianci.yin@amd.com>

Please remove the dot/period in the name. (`git config --global 
user.name "Tianci Yin"`.

> [why]
> On Renoir, vcn ring test failed on the second time insmod in the reload
> test.

Does Linux log a warning/error? Please paste it.

> After invetigation, it proves that vcn only can disable dpg under

investigation

> dpg unpause mode (dpg unpause mode is default for dec only, dpg pause
> mode is for dec/enc).

Is that documented in a datasheet? Please mention name, revision, and 
section.

Why is this only needed for VCN v2.0 and not the other implementations?

> [how]
> unpause dpg in dpg stopping procedure.
> 
> Change-Id: If6ec3af694e1d6b63ebce386a563f03ca6d291c1

Remove?

> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>

Ditto.

How did you test this exactly? Did you turn on DRM debug messages to 
verify that the function was called?

> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 319ac8ea434b..6e0972cd1f2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -1098,8 +1098,10 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
>   
>   static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *adev)
>   {
> +	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
>   	uint32_t tmp;
>   
> +	vcn_v2_0_pause_dpg_mode(adev, 0, &state);
>   	/* Wait for power status to be 1 */
>   	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS, 1,
>   		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);


Kind regards,

Paul
