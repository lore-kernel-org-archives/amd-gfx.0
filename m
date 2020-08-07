Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F590C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 08:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF89206B5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 08:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QHZlkb6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF89206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B4026E981;
	Fri,  7 Aug 2020 08:52:18 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D55BA6E986
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 08:52:17 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id d190so1036186wmd.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Aug 2020 01:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=v5Sy/iGXl/ZOwBfSsungmIvGx/+wZokjulOswUfq7cg=;
 b=QHZlkb6/jBAPRhTXzh1tie+ahrgcJ3DrsuaZH3jxEAwiNd0RC7DYkPDxliWEeAxb6E
 f07yPY/7KurDAKTK9NIV1zxoqcjO+1bCYYo1xmRALqpJAEvWj3u0chnWoUEGfskuc8Re
 1NKyv9SY1WBfrUuiEW0vqG9Sd6oZe2HRpGa5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=v5Sy/iGXl/ZOwBfSsungmIvGx/+wZokjulOswUfq7cg=;
 b=biN6LQHLIxP3HB2gv+Xfi5wLtsbbqq7t90hjiweuUoMXWdXR0kpRCimmYYAr6zQUYq
 x44avlM2+R7NpWKoCtbPBt3mRcu2KJGdejl4X/Y1NQJqRKy9TaBOOlgLUKmo3l14XFLw
 0NuaETGdUAUhrKko3hVyIYTGGxy43Fye2Sz81dqsvykBvinnnIXU/SNZN8DB+64QF6WY
 8LZca23oQBVQZL7d3YISTiJGYGsqD+azoTQz8ZKBqmFpUHKhvVyYKzSt6WWPoDAIqAzE
 ml8hBNxieKW5SHNzYG+Q9gWwLZKoywvcRXohc4TSecvcYmM9KuY1HYnChp2N2JXiNvNh
 +v/w==
X-Gm-Message-State: AOAM5339BA15x2zwcDtA7S/AY4X3z8OVeMU/E7MGkY8wT8aljAwtpvDV
 CV248hMAO9BnIcIgKLENeXPdKMPgzos=
X-Google-Smtp-Source: ABdhPJwj8KUbOAfPYNomCnBAdTgDN1jPrq5Vx0yNs4xxcLQ2dvKEPt6QxTpBYI9BzNCS/8LOkxb+tg==
X-Received: by 2002:a05:600c:2112:: with SMTP id
 u18mr1278371wml.7.1596790336538; 
 Fri, 07 Aug 2020 01:52:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id z6sm10384860wml.41.2020.08.07.01.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 01:52:15 -0700 (PDT)
Date: Fri, 7 Aug 2020 10:52:14 +0200
From: daniel@ffwll.ch
To: 
Subject: Re: [PATCH 7/7] drm/amd/display: Replace DRM private objects with
 subclassed DRM atomic state
Message-ID: <20200807085214.GP6419@phenom.ffwll.local>
References: <20200730203642.17553-1-nicholas.kazlauskas@amd.com>
 <20200730203642.17553-8-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200730203642.17553-8-nicholas.kazlauskas@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 30, 2020 at 04:36:42PM -0400, Nicholas Kazlauskas wrote:
> @@ -440,7 +431,7 @@ struct dm_crtc_state {
>  #define to_dm_crtc_state(x) container_of(x, struct dm_crtc_state, base)
>  
>  struct dm_atomic_state {
> -	struct drm_private_state base;
> +	struct drm_atomic_state base;
>  
>  	struct dc_state *context;

Also curiosity: Can't we just embed dc_state here, instead of a pointer?
Then it would become a lot more obvious that mostly this is a state object
container like drm_atomic_state, but for the DC specific state structures.
And we could look into moving the actual DC states into drm private states
perhaps (if that helps with the code structure and overall flow).

Maybe as next steps.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
