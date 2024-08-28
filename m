Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB07CC54FAA
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 13:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C1CA10E517;
	Wed, 28 Aug 2024 13:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="gPVHM/bx";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3AFF10E09D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 13:20:40 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4280bca3960so57963305e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1724851239; x=1725456039; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DrU3WmyxC78KZCoAhjbJvDXGODUsxTTVWGQUMyqxx0s=;
 b=gPVHM/bxIGlE5uuh2ZhvveJoc6tpFbAJzJCP5xd+gIBagQ0Ek65twSg8tQs4YvllWy
 9Z7FuFbX59sI45w0Mcbzcd8JVnEPPbNFkzNHX8H8Ldn+j8OqXhq48RaE8cNWPm5LB0XW
 TSswpGV8Q3E+ZLNcy66BeIW+M+1nDPxhW6rI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724851239; x=1725456039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrU3WmyxC78KZCoAhjbJvDXGODUsxTTVWGQUMyqxx0s=;
 b=pl6vAEZ9fR2ZceSUHjxp7j+BiGgWdAEXtaAotg8YCA7ZoyAIbjpwhsS395/BUDEC7Q
 75c7G0Nb+C1jS4edFXalpL0yMbzNRBry9SFf4aNwSPiGpvIHQk4LPL9Dzqz1U/9ubXJf
 C26QAYW8FznHJBjBH6IlFRCpRWeESVZqc0x9x73Z8HZBzTEWDR5wbrXPaXYM3LfAH6Cz
 yhoBTgzheGduF/uBkqkwHhoupPC3zwzic2hfARzAyKCnIcVTjynSMW1vB+mdIJR3soL3
 Z/WxVwKNWD342B/L3TO50e17uLctz8Qe3XxOG5G4DdJF89dGKj7KLyDN8w+4oNSsieXY
 VeIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCCWg42B4t4E4Qbv6g++p20a4TxIqyTuYMdWBfjoFWGyOIjxIEM0xK5aGd1H4zQvDXRZuxjVj0@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxl4VEogL0BRou1fkXRTb95dBNu4S2V0fVTed2XY7GxWNxtm9bL
 7/wbCrPHIkvNq6axeOE4WgNlAKM73IR5fZuHypwLRG9aGYmIpKN9R/mkPoN2Eh8=
X-Google-Smtp-Source: AGHT+IGb48ySIFEO4m9OPJHkwMLgiGPpvj6VxnZ/Ch4KVPdSdlwcJ1NgQylzpGDIOPXmRyXlTUcBrw==
X-Received: by 2002:a05:6000:1842:b0:371:9149:dc54 with SMTP id
 ffacd0b85a97d-37311840ecbmr11751753f8f.3.1724851239010; 
 Wed, 28 Aug 2024 06:20:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ff5b8sm15448373f8f.85.2024.08.28.06.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:20:38 -0700 (PDT)
Date: Wed, 28 Aug 2024 15:20:36 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [RESEND 3/3] drm/amd/display: switch to guid_gen() to generate
 valid GUIDs
Message-ID: <Zs8kJOC2pH7gSfET@phenom.ffwll.local>
References: <20240812122312.1567046-1-jani.nikula@intel.com>
 <20240812122312.1567046-3-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812122312.1567046-3-jani.nikula@intel.com>
X-Operating-System: Linux phenom 6.9.12-amd64 
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

On Mon, Aug 12, 2024 at 03:23:12PM +0300, Jani Nikula wrote:
> Instead of just smashing jiffies into a GUID, use guid_gen() to generate
> RFC 4122 compliant GUIDs.
> 
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> 
> ---
> 
> Side note, it baffles me why amdgpu has a copy of this instead of
> plumbing it into drm mst code.

Yeah ec5fa9fcdeca ("drm/amd/display: Adjust the MST resume flow") promised
a follow-up, but that seems to have never materialized. Really should
materialize though. Patch lgtm

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>


> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++++++++++---------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 72c10fc2c890..ce05e7e2a383 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2568,9 +2568,9 @@ static int dm_late_init(void *handle)
>  
>  static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
>  {
> +	u8 buf[UUID_SIZE];
> +	guid_t guid;
>  	int ret;
> -	u8 guid[16];
> -	u64 tmp64;
>  
>  	mutex_lock(&mgr->lock);
>  	if (!mgr->mst_primary)
> @@ -2591,26 +2591,27 @@ static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
>  	}
>  
>  	/* Some hubs forget their guids after they resume */
> -	ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
> -	if (ret != 16) {
> +	ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, buf, sizeof(buf));
> +	if (ret != sizeof(buf)) {
>  		drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during suspend?\n");
>  		goto out_fail;
>  	}
>  
> -	if (memchr_inv(guid, 0, 16) == NULL) {
> -		tmp64 = get_jiffies_64();
> -		memcpy(&guid[0], &tmp64, sizeof(u64));
> -		memcpy(&guid[8], &tmp64, sizeof(u64));
> +	import_guid(&guid, buf);
>  
> -		ret = drm_dp_dpcd_write(mgr->aux, DP_GUID, guid, 16);
> +	if (guid_is_null(&guid)) {
> +		guid_gen(&guid);
> +		export_guid(buf, &guid);
>  
> -		if (ret != 16) {
> +		ret = drm_dp_dpcd_write(mgr->aux, DP_GUID, buf, sizeof(buf));
> +
> +		if (ret != sizeof(buf)) {
>  			drm_dbg_kms(mgr->dev, "check mstb guid failed - undocked during suspend?\n");
>  			goto out_fail;
>  		}
>  	}
>  
> -	import_guid(&mgr->mst_primary->guid, guid);
> +	guid_copy(&mgr->mst_primary->guid, &guid);
>  
>  out_fail:
>  	mutex_unlock(&mgr->lock);
> -- 
> 2.39.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
