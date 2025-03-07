Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194C3C19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 14:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1467210EB84;
	Fri,  7 Mar 2025 14:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="aM49yQ18";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 658F410EB25
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 10:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1741342757; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j9ORHA1cuNqzvnoWBEC62T1wgqIMbszuwnod05fyO8dANI25HjoVR3AjenF57DReCBtjwhuFpUZaYsRo2LfyDfIai1VX4hLJxIjbrMUEGs2/2s80/MPmhlsScF62hmQKPN6LU1q8bKtPRKuQND8BtM+/Cd5Rzie03pRCngU1UIA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1741342757;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=M3+1/avB1798aePiCXDx86re+oU1iPxVvHIF/YggbwY=; 
 b=XY0ouTy6Kq23kJzDImI9+JOWBS486Ukc7tLxj5+Tjtzbcu05rnl3DgTDnlyFlXC59Xv207+7K1E9LViRf5IH1d/FlfpWd+z63+EK+2vAnn9VOnX2/2LgcqkAjVIDFNzGB21/qcvYs5UwVFvcppRU29Qs/uhK4/OcWGOEpEaNTV0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
 dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741342757; 
 s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=M3+1/avB1798aePiCXDx86re+oU1iPxVvHIF/YggbwY=;
 b=aM49yQ18VypDcYfzOdhQgT5ymcyZHjCDAqgGcxYEU5EVirU5D73apFGg4kPvKjB3
 wt9UKUFmoq7mI7IrrwBxrH3WYAUnmdC/jYUHlEwtRVcimgcmda9pvz/LQqqGHT02rtm
 uYHmWO2A8pYrjX20O79nRNgKIyjO5TITwTHOsFCY=
Received: by mx.zohomail.com with SMTPS id 174134275525854.75231547230419;
 Fri, 7 Mar 2025 02:19:15 -0800 (PST)
Message-ID: <111287d9-b9fa-4b6e-9048-e6116a5e952b@collabora.com>
Date: Fri, 7 Mar 2025 15:19:55 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, Xaver Hugl <xaver.hugl@gmail.com>
Subject: Re: [PATCH] drm/amd: Keep display off while going into S4
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250306185124.44780-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250306185124.44780-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Fri, 07 Mar 2025 14:10:39 +0000
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

Hi,

Thank you Mario for finding and fixing!

On 3/6/25 11:51 PM, Mario Limonciello wrote:
> When userspace invokes S4 the flow is:
> 
> 1) amdgpu_pmops_prepare()
> 2) amdgpu_pmops_freeze()
> 3) Create hibernation image
> 4) amdgpu_pmops_thaw()
> 5) Write out image to disk
> 6) Turn off system
> 
> Then on resume amdgpu_pmops_restore() is called.
> 
> This flow has a problem that because amdgpu_pmops_thaw() is called
> it will call amdgpu_device_resume() which will resume all of the GPU.
> 
> This includes turning the display hardware back on and discovering
> connectors again.
> 
> This is an unexpected experience for the display to turn back on.
> Adjust the flow so that during the S4 sequence display hardware is
> not turned back on.
> 
> Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2038
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested on top of amd-drm-next branch and 6.11.11 on 3 different devices.
It fixes all of them. 

It should be included in recent LTS kernels at least. 

Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 11 +++++++++--
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b161daa90019..b54c4b2f3f7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2565,7 +2565,6 @@ static int amdgpu_pmops_freeze(struct device *dev)
>  	int r;
>  
>  	r = amdgpu_device_suspend(drm_dev, true);
> -	adev->in_s4 = false;
>  	if (r)
>  		return r;
>  
> @@ -2577,8 +2576,13 @@ static int amdgpu_pmops_freeze(struct device *dev)
>  static int amdgpu_pmops_thaw(struct device *dev)
>  {
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +	int r;
>  
> -	return amdgpu_device_resume(drm_dev, true);
> +	r = amdgpu_device_resume(drm_dev, true);
> +	adev->in_s4 = false;
> +
> +	return r;
>  }
>  
>  static int amdgpu_pmops_poweroff(struct device *dev)
> @@ -2591,6 +2595,9 @@ static int amdgpu_pmops_poweroff(struct device *dev)
>  static int amdgpu_pmops_restore(struct device *dev)
>  {
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> +
> +	adev->in_s4 = false;
>  
>  	return amdgpu_device_resume(drm_dev, true);
>  }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6f9331fe91c3..5939796db74c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3431,6 +3431,11 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>  
>  		return 0;
>  	}
> +
> +	/* leave display off for S4 sequence */
> +	if (adev->in_s4)
> +		return 0;
> +
>  	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
>  	dc_state_release(dm_state->context);
>  	dm_state->context = dc_state_create(dm->dc, NULL);


-- 
BR,
Muhammad Usama Anjum
