Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D007C7115D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jun 2025 09:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A0D610EB0F;
	Fri, 20 Jun 2025 09:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kode54.net header.i=@kode54.net header.b="tFdrnwT5";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="c8qmWgzl";
	dkim-atps=neutral
X-Greylist: delayed 542 seconds by postgrey-1.36 at gabe;
 Fri, 20 Jun 2025 09:31:09 UTC
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C470C10EB0F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 09:31:09 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 534E51140209;
 Fri, 20 Jun 2025 05:22:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Fri, 20 Jun 2025 05:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1750411325;
 x=1750497725; bh=u2NHG32j5uohDQO1htg5QwUsS29004mFqgWiUIgfFEU=; b=
 tFdrnwT5wyt6ijJHri0U0VZRj7uPBqoHIIo0OG98TvPBvkNfRV7kOKfn0tyEkTXe
 30eVzNhnseVY49lSKO3qora7+8nAwzfM7OYxxc6iNkBrJTcGxFiUcF8AzNHLxLOD
 3A3CgCdX0avywI+5VDnc6Er65l1WPRSWRd7JwZK/kmBGOlzeFYoHjhHNfuD0FwRU
 DpqL4AkRszTTF9DvbJ2FhaX9ZzTOc1mHsor4TNZ8DjBGndWhTyq4ubkYOAz4SZGp
 LPwTlpOqBNikpsaWN+SLNRIvsnvp09wmxfm8WtW/xwTlkKqgmZV8V7ufblfz5tSr
 OmjfdkTZIvRJ3FH/dCa5ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750411325; x=
 1750497725; bh=u2NHG32j5uohDQO1htg5QwUsS29004mFqgWiUIgfFEU=; b=c
 8qmWgzlsEaCtpduVYOkEXQU87/3neT+BkRZb97yN2dFy1zNCeq6HRyIm0FpTdlBq
 cc7kr5G7mguIVTnmB4CcTmoVYjBK2ie3hiYSjzEvirwDs34h2N7sVdPRYbbhOurb
 DRtg4WQEMLYslD5ubxpUR+jzaHcWPfrZ60jfzTYBtO/pq8F9IZvlQBR5W2Y+qfI4
 Uexi96sT9xSRp+CcG/6gUeBbmS+fnCyZ5joeJeqyEwX+j0Nd32bgOXsvYVsYrcmR
 DlYc8vU0GM1RZBornWD+ZurjLJA8v1wEw6UOKLPKpFt1U9svMdhhm+okcftqftI5
 T12NhZrJemNQDuuJ5ZxFg==
X-ME-Sender: <xms:PChVaCQWrzOGG-Lk2Rr7xSR-9FNXFU-7MscvO1o68A5LMHaVtwQTTg>
 <xme:PChVaHzhljhYi6kqk4qkgk-Z7F_faF2DypthQQMU0j4mtqPeZQfpXCRPwPfxBRFCx
 QqGQB8XknDyxbk8MU8>
X-ME-Received: <xmr:PChVaP3BgwTYWO7vpsB-_NgBTy5TEzLc765TZLOkTVvo0F_WssgD0jnHs2rkjCoYGdWmiR2LRAPSHNRsv8JZkaq-sW0JluKEGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdektdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 epggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfvehhrhhishht
 ohhphhgvrhcuufhnohifhhhilhhlfdcuoegthhhrihhssehkohguvgehgedrnhgvtheqne
 cuggftrfgrthhtvghrnhepfeffgeffleffueefffejhfffvefhvdehgeevheduueeghfej
 geefveduuedvveefnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuve
 hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrhhishes
 khhouggvheegrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuth
 dprhgtphhtthhopehkohguvgehgeesghhmrghilhdrtghomhdprhgtphhtthhopegrmhgu
 qdhgfhigsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprg
 hlvgigrghnuggvrhdruggvuhgthhgvrhesrghmugdrtghomhdprhgtphhtthhopegthhhr
 ihhsthhirghnrdhkohgvnhhighesrghmugdrtghomh
X-ME-Proxy: <xmx:PShVaOBSgswr_4Uvpnr7cG6QuanwaVUuVoW_TFNsRzu4m22hRIlQ4w>
 <xmx:PShVaLhNtgyPFBNzPOvtZHQLs_KlB2x0e8f-AHjxQYRNB4-_oioThA>
 <xmx:PShVaKoD-ekaUAsCFZQi1nXc-Q9Fmo5AvKI3mB1NQipkq25dCsrz-Q>
 <xmx:PShVaOjcppdxaVDCnp-5EsRofTviF0W1Yr4mDz9d1IUsaMu-CFrZ8Q>
 <xmx:PShVaOelvPlXn_-yKicBRBZVSIbdXcy8SmaEO6K_6Q075nQugk1TTKMp>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 05:22:04 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 02:22:03 -0700
Message-Id: <DAR9111NPTH9.70OKP0N231BE@kode54.net>
Cc: "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [RFC PATCH] drm/amdgpu: Enable async flip for cursor planes
From: "Christopher Snowhill" <chris@kode54.net>
To: "Christopher Snowhill" <kode54@gmail.com>, <amd-gfx@lists.freedesktop.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250619125507.54384-1-kode54@gmail.com>
In-Reply-To: <20250619125507.54384-1-kode54@gmail.com>
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

On Thu Jun 19, 2025 at 5:55 AM PDT, Christopher Snowhill wrote:
> From: Christopher Snowhill <chris@kode54.net>
>
> amdgpu apparently fudges atomic flips if some software is also tweaking
> the cursor planes during flips, which results in lovely fallback to non-
> atomic flips.
>
> Fixes: 41129e236f14 ("drm/amdgpu: Enable async flip on overlay planes")
> Signed-off-by: Christopher Snowhill <chris@kode54.net>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
>  Is there some reason why this was decided to be this way? I see it
>  hasn't changed much since 2018, until the addition of overlay
>  plane checking.
>
>  Re: https://gitlab.freedesktop.org/drm/amd/-/issues/4263
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index b7c6e8d13435..f0c98d67e1f3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1268,7 +1268,8 @@ static int amdgpu_dm_plane_atomic_async_check(struc=
t drm_plane *plane,
>  	struct dm_crtc_state *dm_new_crtc_state;
> =20
>  	if (flip) {
> -		if (plane->type !=3D DRM_PLANE_TYPE_OVERLAY)
> +		if (plane->type !=3D DRM_PLANE_TYPE_OVERLAY &&
> +		    plane->type !=3D DRM_PLANE_TYPE_CURSOR)
>  			return -EINVAL;
>  	} else if (plane->type !=3D DRM_PLANE_TYPE_CURSOR) {
>  		return -EINVAL;

This is called from drm_atomic_set_property in
drivers/gpu/drm/drm_atomic_uapi.c, and clearly, that wants to perform an
async_check even if an above function call determines that the
properties being applied are a no-op according to check_prop_changes.

I do not know whether all of the tearing capable DEs or compositors are
in the wrong here, or whether the DRM subsystem is doing something wrong
for AMD, and possibly other GPU vendors if they support async cursor
changes. Clearly something is sending prop changes on the cursor plane,
whether they are allowed-for-primary fb_id, in_fence_fd, or
fb_damage_clips, or whether they are no-ops. The only thing stopping the
transaction is that a cursor plane check hits async_check, and it's
failing for AMD.

Perhaps I should be running full DRM debug logging against Plasma and
labwc to determine what they're writing during the game presentation?
Seems strange that there are atomic cursor plane updates, when KDE is
supposed to be disabling the cursor plane for tearing, and in this case,
the game itself is not presenting a moving cursor at the time, as it is
in the main game view, and even if the target reticle is a cursor, it is
neither moving from the center of the screen nor is its plane being
changed in a visible way.

Something screwy is going on, that's for sure.
