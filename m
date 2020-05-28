Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A763C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F5120721
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F5120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF806E148;
	Thu, 28 May 2020 14:08:41 +0000 (UTC)
Received: from smtp.ispras.ru (winnie.ispras.ru [83.149.199.91])
 by gabe.freedesktop.org (Postfix) with ESMTP id 06D0A6E575
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 13:54:57 +0000 (UTC)
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
 by smtp.ispras.ru (Postfix) with ESMTP id 9F9E6201D0;
 Thu, 28 May 2020 16:54:54 +0300 (MSK)
Date: Thu, 28 May 2020 16:54:54 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/display: disable dcn20 abm feature for
 bring up"
In-Reply-To: <20200528134807.5665-1-harry.wentland@amd.com>
Message-ID: <alpine.LNX.2.20.13.2005281652440.18802@monopod.intra.ispras.ru>
References: <20200528134807.5665-1-harry.wentland@amd.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 28 May 2020 14:08:39 +0000
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, Michael Chiu <Michael.Chiu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On Thu, 28 May 2020, Harry Wentland wrote:

> This reverts commit 96cb7cf13d8530099c256c053648ad576588c387.
> 
> This change was used for DCN2 bringup and is no longer desired.
> In fact it breaks backlight on DCN2 systems.

Reported-and-tested-by: Alexander Monakov <amonakov@ispras.ru>

Thanks.

> Cc: Alexander Monakov <amonakov@ispras.ru>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: Michael Chiu <Michael.Chiu@amd.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ddc979e3eebe..acd4874e0743 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1356,7 +1356,7 @@ static int dm_late_init(void *handle)
>  	unsigned int linear_lut[16];
>  	int i;
>  	struct dmcu *dmcu = NULL;
> -	bool ret = false;
> +	bool ret;
>  
>  	if (!adev->dm.fw_dmcu)
>  		return detect_mst_link_for_all_connectors(adev->ddev);
> @@ -1377,13 +1377,10 @@ static int dm_late_init(void *handle)
>  	 */
>  	params.min_abm_backlight = 0x28F;
>  
> -	/* todo will enable for navi10 */
> -	if (adev->asic_type <= CHIP_RAVEN) {
> -		ret = dmcu_load_iram(dmcu, params);
> +	ret = dmcu_load_iram(dmcu, params);
>  
> -		if (!ret)
> -			return -EINVAL;
> -	}
> +	if (!ret)
> +		return -EINVAL;
>  
>  	return detect_mst_link_for_all_connectors(adev->ddev);
>  }
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
