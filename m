Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05AAE94619
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 10:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F4A10E392;
	Tue, 10 Feb 2026 10:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IxsQ2HhL";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00DE310E1A8;
 Tue, 10 Feb 2026 10:53:01 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f9JLf40JYz9vBm;
 Tue, 10 Feb 2026 11:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770720778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tZJZX1xptoicBpamW57A4g313Qr/N87SByQGrF6aG/s=;
 b=IxsQ2HhLqIAuixDnoXfVqnm3VPaiuYk1JUXBAaaSxm2etsFgILjBdCTKhZ3mhfDjFFiDTP
 fco6u2z9Js6XPm6h+4dYCoVTyafGpGKiqCnY4iloRqMCWmGbLBlBIAH8gNzxeM2zX/3EU0
 5Hzt8mdZlMIyhn3oyEM+3hqC8LzmSr2MUyJ2hy3Ix2PRBAqZ+nAzT1g1Q8/QjT6HlHQx+S
 g7pNHmDtAMtSVBvJq9z97VSFgJV2GJjrs61bGIZD/cf71lnH5/kpRT4POetv+tB1/kj0VT
 HKda4pYuL58hHTjZt0ZGyWrxf3wd70QA+jq88Bl/1gqHaJWXAXgWk0nnaLkr3A==
Message-ID: <cf92dc7a-032c-47b5-9db2-7d8a76a31ac1@mailbox.org>
Date: Tue, 10 Feb 2026 11:52:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V13 49/51] drm/amd/display: Disable CRTC degamma when
 color pipeline is enabled
To: Alex Hung <alex.hung@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: wayland-devel@lists.freedesktop.org, harry.wentland@amd.com,
 leo.liu@amd.com, ville.syrjala@linux.intel.com,
 pekka.paalanen@collabora.com, contact@emersion.fr, mwen@igalia.com,
 jadahl@redhat.com, sebastian.wick@redhat.com, shashank.sharma@amd.com,
 agoins@nvidia.com, joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org,
 xaver.hugl@gmail.com, victoria@system76.com, daniel@ffwll.ch,
 uma.shankar@intel.com, quic_naseer@quicinc.com, quic_cbraga@quicinc.com,
 quic_abhinavk@quicinc.com, marcan@marcan.st, Liviu.Dudau@arm.com,
 sashamcintosh@google.com, chaitanya.kumar.borah@intel.com,
 louis.chauvet@bootlin.com, mcanal@igalia.com, nfraprado@collabora.com,
 arthurgrillo@riseup.net
References: <20251115000237.3561250-1-alex.hung@amd.com>
 <20251115000237.3561250-50-alex.hung@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20251115000237.3561250-50-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: aeea10228f702849291
X-MBO-RS-META: ou4cgaznj5txazpd5o673fwedfqjfhot
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

On 11/15/25 01:02, Alex Hung wrote:
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 38f9ea313dcb..697e232acebf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -736,7 +736,7 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
>  {
>  	struct amdgpu_crtc *acrtc = NULL;
>  	struct drm_plane *cursor_plane;
> -	bool is_dcn;
> +	bool has_degamma;
>  	int res = -ENOMEM;
>  
>  	cursor_plane = kzalloc(sizeof(*cursor_plane), GFP_KERNEL);
> +	if (plane->color_pipeline_property)
> +		has_degamma = false;

AFAICT this doesn't create the DEGAMMA properties at all for CRTCs where the primary plane has the COLOR_PIPELINE property, right?

That's unfortunate, since it means existing user space which uses the DEGAMMA properties can no longer work. I'd suggest something like this instead:

* DEGAMMA properties are created even if the primary plane has the COLOR_PIPELINE property.
* User space can use either the DEGAMMA properties or the COLOR_PIPELINE property. An atomic commit which attempts to enable both is rejected.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
