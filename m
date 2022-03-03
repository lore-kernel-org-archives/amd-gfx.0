Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7453C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 17:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346A910EA4E;
	Thu,  3 Mar 2022 17:47:19 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB54210E321
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 17:43:29 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id z2so5200797plg.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Mar 2022 09:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=3mNZQL2VC2uYb431PEz6jnFD5ZTmVgeO3AWfSaB6+TY=;
 b=TSou/dg3MxKfuVnSlJ7/9Ygb6rTt3uj1IAV4FuRAP0EFPtQzGCi18SqZsbllXX+6S8
 ntcMT0x0I5bMkPvRf+RymUl7ybQA3dv1GWojQ1350VFS3FT8qE2h7SFFXSceT7yfD2T8
 voM8RJe8gyMdGEmB0QSQndTKjgdU+d71aw2BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3mNZQL2VC2uYb431PEz6jnFD5ZTmVgeO3AWfSaB6+TY=;
 b=OfiPWqMcP1ZzKuPfO6F5NYSdWSsVXWhfJbKshl5hnA+DpM+sCyWDGbClf0u2ds2Pjg
 YpY6ryKk/Lh80BEowYAfumU0UFSUYka0WZTUxjShp3yrdHnlsE13VMeca6OXSrmnkx8G
 On/sSKr0PDAAOzywclGjEnUL4O6Eys/kz28WBK4ptNkRRlxkQu+9b0Yw6i0CXulWMRyM
 r0RkHZmR/S8Stb2nzH7wvce5Yx7IUm7HqSEW2aTIBYhijNVnSTW8oXIOEwFK4JTyi7cV
 IWpjF/Jix2FMrDZR18gDPBqjEf7MOnjl2MAzzZk/ily3PUOHGImyMVjcwSU+Nbri3zAI
 xQkQ==
X-Gm-Message-State: AOAM533RSbdb8n2DxPTAtDPkDkufqg3F2K6mkjP7yYxobaU1q5OEL5qQ
 nWWhN9RGmuyCzugvYPulbRO4cg==
X-Google-Smtp-Source: ABdhPJwuuWN6vPSVt7Mv7dHURNIv9eDx1oLiv+vp7zPxRp6zIMVlyTuNFHJ/8c8jo+dQfkkeI/rm5Q==
X-Received: by 2002:a17:902:d2cd:b0:14f:c169:dc6f with SMTP id
 n13-20020a170902d2cd00b0014fc169dc6fmr36769598plc.170.1646329409448; 
 Thu, 03 Mar 2022 09:43:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a655549000000b0036570f81245sm2536433pgr.84.2022.03.03.09.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 09:43:29 -0800 (PST)
Date: Thu, 3 Mar 2022 09:43:28 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH][next] drm/amd/display: Fix Wstringop-overflow warnings
 in dc_link_dp.c
Message-ID: <202203030937.5BFE3EF@keescook>
References: <20220303172503.GA1731116@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220303172503.GA1731116@embeddedor>
X-Mailman-Approved-At: Thu, 03 Mar 2022 17:47:18 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-hardening@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 03, 2022 at 11:25:03AM -0600, Gustavo A. R. Silva wrote:
> Fix the following Wstringop-overflow warnings when building with GCC-11:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:493:17: warning: ‘dp_decide_lane_settings’ accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]

Can you "show your work" a little more here? I don't actually see the
what is getting fixed:

enum dc_lane_count {
	...
        LANE_COUNT_FOUR = 4,
	...
        LANE_COUNT_DP_MAX = LANE_COUNT_FOUR
};

struct link_training_settings {
	...
        union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX];
};

void dp_hw_to_dpcd_lane_settings(
		...
		union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX])
{
	...
}

static enum link_training_result dpia_training_cr_transparent(
		...
                struct link_training_settings *lt_settings)
{
	...
                dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
                                lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
	...
}

Everything looks to be the correct size?

-- 
Kees Cook
