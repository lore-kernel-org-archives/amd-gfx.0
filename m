Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78476606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wbinvd.org header.i=@wbinvd.org header.a=rsa-sha256 header.s=wbinvd header.b=c2qin1NU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B1F10EBF8;
	Mon,  2 Nov 2026 08:06:59 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DFF10E254
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 15:27:02 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2e8f2c3ad6bso5721855ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wbinvd.org; s=wbinvd; t=1793374022; x=1793978822; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rUR59C26+fvlbiQB0TxzW5qGZeRM/5x6JJF3AdPnsXA=;
 b=c2qin1NUyRlvA0plFO7MfoA11f+I3s2Ul+ApZP8Ru/4n7nuiczenjjMKslPhsZ7wLo
 omyjTFDcyA+0XyDK9+KgdOqP1F7i4KkO2gXWcNo7wI2i7p47Y1b2JAvppSpK4Te5V8Oe
 5oNY353++TmptvUozRydFXDTLXiMvM8OOplDj0sKQ+9LiUDZj2RgfAWLr2w46fT0LwqM
 VRIdVNL+edoJSSB4ALUtQmRTED7xK+wd4oT2z3nxWEaQopXYZT6HobKGZmQlZIS3jM6Y
 yWV2pHF1GDwbE8YQCBSDkqSeYlh99woev67cp4XlCGNU7N4UHvpF6QxXT1k6D7UNM9zd
 fFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793374022; x=1793978822;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rUR59C26+fvlbiQB0TxzW5qGZeRM/5x6JJF3AdPnsXA=;
 b=YIhnt4445AgM5Ygk3OcDQb/K71cWj3qsRBGos1riuh1wz/h+W9Z90UkHEm0VHayIAL
 sRdsit2edoj7T/jT9SYr/gdm41FCee3QWxw+q1oqelTnDPAJxKI/Ef7/InLWglZC0zxQ
 j8BkKMccnnxw5KkSJ7cb6qYo5DIk4UV6tvTtIVdsFjE6Du6EjckDc64B6EL0nQAVc7OU
 jfSa8v4m7SCoC/rku6jic6RsZtS8RqR45i3khGGR8QTWEkfBwdtIOkd8jm5ZeNq+tlx+
 eo0F6zrCy5oQiDrbpgc/b6YxicrxIBNP4SjyUU6PyvASsjvXTVS0epnQchRZrVgo62Ta
 CasQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByIElgj+OSdP2WnThplRKP2r21MsNrAIxPL0EZeS9H60CKhQr5xJnI4zdOjgxRps2c0Toq68Qc/@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ0yJqnozqO+vE6RbTGBrdqITzJvREXIEPPHcjzy+5ZB4WQntD1
 CXN3iXcT6Qg3mBbl78qCnqbfPutljC4ADOBSPDSdufXIavceYDGhhrutDsUFHty65fo=
X-Gm-Gg: AYBFou3Ri37w11AEMZ9QFwdxjuSKzH9ZFyfGAHakKcVWUC9JeARGmQ2RRrRwzt0/uVz
 fbW8dpEjEgM9D3Srj+yhD18n3I0Zy6pF5BDNpdFnLpm1iqJqaq1CuvtkU3ZDZVPzG9IImDz/YuI
 DG68WDreDtOLj2TvePpVIbJLwXUcKkjTK/u0JE0awtA7iQkN71bJZ6/tfOMeJtyv6d6TuEYWbds
 xa35TQahhozAmkENfTumGZ9uOoaiWF+aTi8yhc/0+OZ0jUdeWwUiCc/bpWobOjbp51Qj9/Cfj8x
 4eP595A9CxQC3fU1xJArD6RHUvQvPeBRonF61W6N9ntU/rwn67K37AS0alPUjftP4sDeyCM2oi7
 I0dRtYtAEhSg7eBGn+gRp/qU6xkWDJTQu8NfvVX/JMR6sz3NRqKAtD2oMrvw65v3rd2Sg+sxJKy
 Y9ulWt2Is4pA/w5YJUZBdo+S4a5g/RgMwBOl09MjTknjHFOn35gYH0MJWUz49e6PO4OWPAm5cFu
 Dq8UJP6TSu6Jwo9jSBUxFZBiIt/bLA+65uyq08hPUzjMWXEieO+gX5qnLBcJGMsKcrwVKIruibT
 e9WN7frsRO4QERfmaUpZf4U1Wh1rPlCH
X-Received: by 2002:a17:903:948:b0:2e9:9522:ed3a with SMTP id
 d9443c01a7336-2eb364b8b8dmr28518335ad.22.1793374022240; 
 Fri, 30 Oct 2026 08:27:02 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:25ca:cbda:d0bd:f452])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3927e856sm8905135ad.50.2026.10.30.08.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:27:01 -0700 (PDT)
Date: Fri, 30 Oct 2026 08:26:59 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, George Zhang <george.zhang@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Allocate DCN32/1 dmub memory to
 GTT"
Message-ID: <auS3QzinEAmV-mtk@mozart.vkv.me>
References: <25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org>
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:06:53 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tuesday 10/27 at 13:35 -0700, Calvin Owens wrote:
> After commit a637a140ab860310 ("drm/amd/display: Allocate DCN32/1 dmub
> memory to GTT"), a machine with a Radeon RX 7900 shows random garbage on
> the screen. It reproduces sporadically, but at times it is so bad the
> machine is more or less unusable.
> 
> The garbage is always horizontal bars extending across the entire
> screen, always approximately 200 pixels tall on a 3840x2160 screen,
> for what looks like a single frame. The bars are mostly black, but will
> sometimes exhibit striping and periodic artifacts which smell like
> non-framebuffer data is being rendered to the screen.
> 
> It took some patience on the "good" side, but I was able to nail it down
> to commit a637a140ab860310818a14fb4d37e39e51a06be4 with this bisect:
> 
>   bad: [cee9395acd8043be0644b25c34bfa86623f2b935] Linux 7.3-rc1
>   good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
>   good: [55ab7e14222e5f0b0fd9f7711ca391d2924b35e3] Merge tag 'for-7.3/block-20260819' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
>   bad: [df51bdc5e80dae43cab81f6cc641e98638303c88] Merge tag 'mtd/for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
>   bad: [29daacacf4cd84e6917f09de6a99fb170071c14c] Merge tag 'drm-rust-next-2026-08-08' of https://gitlab.freedesktop.org/drm/rust/kernel into drm-next
>   good: [fff648aec5e2790d117a0ec5c849a284d9d33d70] drm/amdgpu: include amdgpu_video_codecs.h only where needed
>   bad: [336e0cd576817ac64a4b394ca2b3680029f3e37f] Revert "drm/amdgpu: fix aperture mapping leak"
>   bad: [789f7486a384ca58b9d7a76abba5efa0e80e8dab] drm/amd/display: Test plane colorop helper walkers
>   good: [e0e426f10ad653c5e9dd33fb4a76d55f06101992] drm/amd/display: Test helper_check_state rejects
>   bad: [982b2a43682b55e7d9800000f2592832ff2865ba] drm/amdgpu: Fix IP block NULL check during soft reset
>   bad: [9102b39fa924dcc3dc75a3137bfa9633c40b88c0] drm/amdgpu/userq: fix indefinite fence wait during GPU reset
>   bad: [b23470a026afe64de5c1df4ad181587b49c22923] drm/amd/display: Exit LS for ISHARP before coefficient write
>   bad: [f02b2e47355e9d381a7f34acc997e1c47879ca21] drm/amd/display: Add KUnit test for wb jobs
>   bad: [c6a13d145cc811b19c8a0620f25868cf7d5700c0] drm/amd/display: remove unused dcn42 socbb values
>   good: [1d8327353de6f1f34063840f362c208c84064f54] drm/amd/display: Fix VABC Init and OLED Support
>   bad: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/display: Allocate DCN32/1 dmub memory to GTT
>   first 'bad' commit: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/display: Allocate DCN32/1 dmub memory to GTT
> 
> Sure enough, reverting a637a140ab860310818a14fb4d37e39e51a06be4 on top
> of v7.3 completely and totally eliminates the problem for me.
> 
> Mikhail has separately reported this regression:
> 
>   https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@gmail.com/
> 
> ...but it seems to be much more consistent for me than for Mikhail, it's
> never taken more than 30 minutes even when the machine is completely
> idle. I've also never been able to reproduce any artifact one single
> time without commit a637a140, despite a lot of effort.
> 
> I'm not sure reverting this is the right way forward, since presumably
> this would re-regress the timing issue Fangzhi alluded to in the
> original commit. But nobody has proposed anything concrete yet... so
> let's start the discussion here.
> 
> I'm happy to help test other better ideas as well :)

Friendly ping.

> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c    | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> index 9ff25bc8ee5ae..870534b7cf46d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> @@ -511,7 +511,6 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
>  		DMUB_WINDOW_MEMORY_TYPE_FB,		/* DMUB_WINDOW_CURSOR_OFFLOAD */
>  	};
>  	int r;
> -	int mem_domain = AMDGPU_GEM_DOMAIN_GTT;
>  
>  	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>  	case IP_VERSION(2, 1, 0):
> @@ -648,19 +647,13 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
>  		return -EINVAL;
>  	}
>  
> -	/* Limit to allocate dmub to GTT on DCN32/1
> -	 * TODO: Other asics with GDDR7 may have worse latency
> -	 */
> -	if (dmub_asic != DMUB_ASIC_DCN32 &&
> -	    dmub_asic != DMUB_ASIC_DCN321)
> -		mem_domain |= AMDGPU_GEM_DOMAIN_VRAM;
> -
>  	/*
>  	 * Allocate a framebuffer based on the total size of all the regions.
>  	 * TODO: Move this into GART.
>  	 */
>  	r = amdgpu_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
> -				    mem_domain,
> +				    AMDGPU_GEM_DOMAIN_VRAM |
> +				    AMDGPU_GEM_DOMAIN_GTT,
>  				    &adev->dm.dmub_bo,
>  				    &adev->dm.dmub_bo_gpu_addr,
>  				    &adev->dm.dmub_bo_cpu_addr);
> -- 
> 2.47.3
> 
