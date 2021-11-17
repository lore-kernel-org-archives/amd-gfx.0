Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0251C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 16:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DC161BFE
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 16:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B3DC161BFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cavoj.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F8789F9F;
	Wed, 17 Nov 2021 16:38:13 +0000 (UTC)
Received: from lithium.sammserver.com (lithium.sammserver.com
 [IPv6:2a01:4f8:c2c:b7df::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D8789E0D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 16:37:39 +0000 (UTC)
Received: from mail.sammserver.com (sammserver.wg [10.32.40.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by lithium.sammserver.com (Postfix) with ESMTPS id 1DC853115D1B;
 Wed, 17 Nov 2021 17:37:38 +0100 (CET)
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
 by mail.sammserver.com (Postfix) with ESMTP id 1ADBD273DD;
 Wed, 17 Nov 2021 17:37:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
 t=1637167057; bh=My8ZECGsaEyJpXWcxz3swuylCpwbUuGijtfR8z0XdPw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kgfUGJQR7zaPNc827sXkHw2DH9z1/rvLhToKXype4lbM24U5wR8yMYpz0dGE1FOW4
 7aPImzO5+4fKghEJpmJ5CvtXkjmv/Fcu0XsAGQe/JuORIIqwOWO6o1CMnnNh0dEVD/
 Ig/ZFnGx1+NCJLd7s4HvoFJrq0zJsCZrG0RI7rt4=
Received: by fastboi.localdomain (Postfix, from userid 1000)
 id 08C881421378; Wed, 17 Nov 2021 17:37:36 +0100 (CET)
Date: Wed, 17 Nov 2021 17:37:36 +0100
From: Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
To: Roman.Li@amd.com
Subject: Re: [PATCH] drm/amd/display: Fix OLED brightness control on eDP
Message-ID: <20211117163736.4so75nz644djwspc@fastboi.localdomain>
References: <1637162530-23015-1-git-send-email-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1637162530-23015-1-git-send-email-Roman.Li@amd.com>
X-Mailman-Approved-At: Wed, 17 Nov 2021 16:38:12 +0000
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
Cc: Alexander.Deucher@amd.com, Sunpeng.Li@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 17.11.2021 10:22, Roman.Li@amd.com wrote:
> From: Roman Li <Roman.Li@amd.com>
> 
> [Why]
> After commit ("drm/amd/display: add support for multiple backlights")
> number of eDPs is defined while registering backlight device.
> However the panel's extended caps get updated once before register call.
> That leads to regression with extended caps like oled brightness control.
> 
> [How]
> Update connector ext caps after register_backlight_device
> 
> Fixes: b1c61212d8dc ("drm/amd/display: add support for multiple backlights")
> Link: https://www.reddit.com/r/AMDLaptops/comments/qst0fm/after_updating_to_linux_515_my_brightness/

Tested-By: Samuel Čavoj <samuel@cavoj.net>

> 
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 26fcc89..44c9994 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4243,7 +4243,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  		} else if (dc_link_detect(link, DETECT_REASON_BOOT)) {
>  			amdgpu_dm_update_connector_after_detect(aconnector);
>  			register_backlight_device(dm, link);
> -
> +			if (dm->num_of_edps)
> +				update_connector_ext_caps(aconnector);
>  			if (psr_feature_enabled)
>  				amdgpu_dm_set_psr_caps(link);
>  		}
> -- 
> 2.7.4
> 
