Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984A4C54FAA
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 13:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F21D10E50F;
	Wed, 28 Aug 2024 13:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="XwUL7GpT";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB3E10E513
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 13:16:37 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4280bbdad3dso57617655e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 06:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1724850996; x=1725455796; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+GuWcYwb98mXctju6QIX6zx5w/lP8XusSTgA+B+emfo=;
 b=XwUL7GpTbeAA9yutMqPtCG4P1Rj0oRPIKaEtAHg1dXjd1KQiC7rKKZpprTaKlquS5T
 bTaY1ZsN7uQ5fv+KMFG+ge9X95/8wchcww6o6vwON3mr7q2EaNmwNLXSg8yfUvkWOmpE
 D6pUfzk3NCGs+pE46GsJbxfn5hY34bIK/j9S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724850996; x=1725455796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GuWcYwb98mXctju6QIX6zx5w/lP8XusSTgA+B+emfo=;
 b=KCMCnum4IVf1GD6oFt4zLys/5+UVJWfRclmMMxfRuf5TDMAfZ1tSJlYSi4KVhaBFms
 FngyEKoosu3d3lcm2WsHKigkpbNFrOKnf7pluFjA88UeAj7SvQ3JQs06bCdl6eDUvols
 CgwVUv1zdulLttRNE6u4F0QDQ4TxVLzyrqthXQYxflu/TI7N2x5RU4qXfsZukpb5gKIL
 DOKVhplPjlSVDACr5uWbIJkBxY5k2i1R78KCEwVSbk1bIeZNLSi9wYeBdRjEz7CtfK0b
 HUyl9VdKicGIWRtW/xRASTM2V/4g/jE2wmLAxxZCJI9/lxdBT0KsLGOP+ylOreGraCtV
 VTrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkFsX72s5wrLsTLxWWKz5o9UEMQww6N5vytWf1HJVD24qXZJ4V/RyvP4hHyzP0EuiU1DMeaXK2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMDN1cVd1u1ddVKw3iq0v9HH8FcidJIOLINh0AElLJrveQLVc5
 iIUsfsgOvj8r4GubKW1mlaVmWnPyK0wEj7MLo84O1JxaohydkG+NHer5/XvbHlk=
X-Google-Smtp-Source: AGHT+IFyrvRfV1Bsun+i0qfWC3WuXS2/4Tt9W1VckkKODBJ3APsaIIwcExj9PQRmAaQ8jQnsYvF8Yg==
X-Received: by 2002:a05:600c:354a:b0:426:593c:935d with SMTP id
 5b1f17b1804b1-42acd534d3fmr114033575e9.5.1724850995711; 
 Wed, 28 Aug 2024 06:16:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba6425b95sm21248305e9.43.2024.08.28.06.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:16:35 -0700 (PDT)
Date: Wed, 28 Aug 2024 15:16:33 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [RESEND 2/3] drm/mst: switch to guid_gen() to generate valid GUIDs
Message-ID: <Zs8jMZadvxeGhTjn@phenom.ffwll.local>
References: <20240812122312.1567046-1-jani.nikula@intel.com>
 <20240812122312.1567046-2-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812122312.1567046-2-jani.nikula@intel.com>
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

On Mon, Aug 12, 2024 at 03:23:11PM +0300, Jani Nikula wrote:
> Instead of just smashing jiffies into a GUID, use guid_gen() to generate
> RFC 4122 compliant GUIDs.
> 
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Read a bit the RFC, definitely sounds better than stuffing jiffies into
the guid ...

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 39f1dc45004e..38a9a1441e62 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -2700,18 +2700,10 @@ static void drm_dp_mst_queue_probe_work(struct drm_dp_mst_topology_mgr *mgr)
>  static bool drm_dp_validate_guid(struct drm_dp_mst_topology_mgr *mgr,
>  				 guid_t *guid)
>  {
> -	u64 salt;
> -	u8 buf[UUID_SIZE];
> -
>  	if (!guid_is_null(guid))
>  		return true;
>  
> -	salt = get_jiffies_64();
> -
> -	memcpy(&buf[0], &salt, sizeof(u64));
> -	memcpy(&buf[8], &salt, sizeof(u64));
> -
> -	import_guid(guid, buf);
> +	guid_gen(guid);
>  
>  	return false;
>  }
> -- 
> 2.39.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
