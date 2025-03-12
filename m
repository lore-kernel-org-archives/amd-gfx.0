Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19439C28B2E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 10:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25E910E754;
	Wed, 12 Mar 2025 10:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RyOnamZF";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7448B10E25E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 08:59:44 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so21471875e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741769983; x=1742374783; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j1lFF3dYoWzDhMcWgfyr3uKMuZdCc759+dudlwbUwJc=;
 b=RyOnamZFHs5g086uZuTl1X0/wzDbOzeZbPlyCwdqxBZA0Ms1yFHGToZYyT0uQzrzOv
 Vo/ARunlVGQv94ON+/cpPAftuk4SOGfnlv1xkLPYbEerMWsvT4QGvAJeifK9ef0uh6OA
 SFaN/jt5BO5dYvzJjEEQqprpY91aSizbE9EW+IM6cGdwcBvjpwRMWg/yqJmGPV4YO2o+
 spKQEc3d++0+ZpMQoIN6HCThAv+W0DFXQO6yGr2IFj44mKWZ7bNL8yJ43t3GA0FRUBmG
 ktqYXNt/sQCwTbS9eEGLEJdD8bl+B9Un463jMl1j0Ql2aOhDBoJo0QlnIfgGdYv5YKH9
 me+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741769983; x=1742374783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1lFF3dYoWzDhMcWgfyr3uKMuZdCc759+dudlwbUwJc=;
 b=PAytuCp84+5+SW633f2unyWpkz5wXo+aXXZ0yMx5iJv8hIUyJP8q6WuNdhoQJuIjuC
 cPu+QN9jimfxA8uf8ikYusKvdAsOa71Bu/PjpaIO/BV6zlGylid5usVN/OaSCIbRIrLF
 3Q+HnaTl1JhVG8ND/Pm5C0N5Ha0RTOHN14u5kROxh0KxN0DojDfkB+fvO4wcq7UaTn3Q
 unbxkeevbK3HyDwoRlaazpc8fLdiWYQgqQ5aK/Gj8fJyQm/fB6lfoYhgIbgLIjsjA5qv
 IQElWlSjh4m/Ee0spSGUGKQr0U4sPitekx23KocYLEooQPG1pOulJuv7vBg+3j/O0vF1
 4O5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvBiHYrZJzRucc3XDUNcZOR2iJUZdLgtbf45j5V8aTvgi5zdAJAAWnQRt82YvtK1TRPjZ5xut9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMbPxo4Kb90smfKItxu1R3TTvaxs0mCfcfUPSW1jWWNzTTC1HL
 7FPawkXoc53hjpPrHtraRLJ4qEqZrwW35OWvlcBEtDqlhvmFGUG0eRqYzLOBVLI=
X-Gm-Gg: ASbGncsUe7BDy1dtyfuL+zZiUR6Fq6VGS9Ix203XRXV2q9Rn6wLftKYIbcXkc2hfYg8
 chCGh7Ezzz2M+EdTfeOXTb3dh5983//qhluVokpELzDiM2T97BJFmWr9Yt7ecFXnpRj4cfqkSjN
 qLBJyYIYkdN6TonTzx10JDkD/4uBP178vFgLaGYjoRqodiIpRj/9FzHbf2sXrb3Ai75t7zNLC6B
 Bj4Z7kuY3VGLBeTpsAKe2/aCwcY6H3fb1ZiXk3l5D8ZbLwhV8Xquqr46ytmLJE114DEzkp1udsb
 KA9l4HNRGAXTlYFwTzO+FWZFGAOJgmEok+eVLM+Zvx9ov0cKig==
X-Google-Smtp-Source: AGHT+IFRYyblJBug3nUydxwK8LKnL+dcpVCv067IXIe4xGqOt0RBaN55ofRlH/pzDjdJEy/xTq29pQ==
X-Received: by 2002:a05:600c:4fd5:b0:43c:fb5b:84d8 with SMTP id
 5b1f17b1804b1-43cfb5b8569mr109455305e9.16.1741769982898; 
 Wed, 12 Mar 2025 01:59:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43d0a75b324sm14465335e9.24.2025.03.12.01.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 01:59:42 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:59:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Roman Li <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer dereferences in
 dm_update_crtc_state()
Message-ID: <7f6541bb-93e9-4ab5-9079-8cdea38019ea@stanley.mountain>
References: <20250312023409.2687233-1-srinivasan.shanmugam@amd.com>
 <22e95ef0-4b07-41a6-b1c9-a5cd123a49e2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e95ef0-4b07-41a6-b1c9-a5cd123a49e2@amd.com>
X-Mailman-Approved-At: Wed, 12 Mar 2025 10:09:06 +0000
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

On Wed, Mar 12, 2025 at 03:39:41PM +0800, Chung, ChiaHsuan (Tom) wrote:
> The original code will check the drm_new_conn_state if it's valid in here
> 
> 10712                 if (IS_ERR(drm_new_conn_state)) {
> 

That's checking for error pointers.  It's irrelevant.  The warning is
about NULL pointers.  It should probably be a NULL check.  I have
written a blog that might be related?

https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

> After that the drm_new_conn_state does not touch by anyone before call the
> 
> --> 10751                 ret = fill_hdr_info_packet(drm_new_conn_state,
> 
> I think it should be no issue in this case.
> 
> We call the PTR_ERR_OR_ZERO() just because we need to get the error code and
> return to the caller.
> 
>  10713                         ret = PTR_ERR_OR_ZERO(drm_new_conn_state);
> 
> Maybe it's just a false warning?

Calling PTR_ERR_OR_ZERO() doesn't make sense when we know that
drm_new_conn_state is an error pointer.

regards,
dan carpenter

> 
> Tom
> 
> On 3/12/2025 10:34 AM, Srinivasan Shanmugam wrote:
> > Added checks for NULL values after retrieving drm_new_conn_state and
> > drm_old_conn_state to prevent dereferencing NULL pointers.
> > 
> > Fixes the below:
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:10751 dm_update_crtc_state()
> > 	warn: 'drm_new_conn_state' can also be NULL
> > 
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
> >      10672 static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
> >      10673                          struct drm_atomic_state *state,
> >      10674                          struct drm_crtc *crtc,
> >      10675                          struct drm_crtc_state *old_crtc_state,
> >      10676                          struct drm_crtc_state *new_crtc_state,
> >      10677                          bool enable,
> >      10678                          bool *lock_and_validation_needed)
> >      10679 {
> >      10680         struct dm_atomic_state *dm_state = NULL;
> >      10681         struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
> >      10682         struct dc_stream_state *new_stream;
> >      10683         int ret = 0;
> >      10684
> >      ...
> >      10703
> >      10704         /* TODO This hack should go away */
> >      10705         if (connector && enable) {
> >      10706                 /* Make sure fake sink is created in plug-in scenario */
> >      10707                 drm_new_conn_state = drm_atomic_get_new_connector_state(state,
> >      10708                                                                         connector);
> > 
> > drm_atomic_get_new_connector_state() can't return error pointers, only NULL.
> > 
> >      10709                 drm_old_conn_state = drm_atomic_get_old_connector_state(state,
> >      10710                                                                         connector);
> >      10711
> >      10712                 if (IS_ERR(drm_new_conn_state)) {
> >                                       ^^^^^^^^^^^^^^^^^^
> > 
> >      10713                         ret = PTR_ERR_OR_ZERO(drm_new_conn_state);
> > 
> > Calling PTR_ERR_OR_ZERO() doesn't make sense.  It can't be success.
> > 
> >      10714                         goto fail;
> >      10715                 }
> >      10716
> >      ...
> >      10748
> >      10749                 dm_new_crtc_state->abm_level = dm_new_conn_state->abm_level;
> >      10750
> > --> 10751                 ret = fill_hdr_info_packet(drm_new_conn_state,
> >                                                       ^^^^^^^^^^^^^^^^^^ Unchecked dereference
> > 
> >      10752                                            &new_stream->hdr_static_metadata);
> >      10753                 if (ret)
> >      10754                         goto fail;
> >      10755
> > 
> > Cc: Harry Wentland<harry.wentland@amd.com>
> > Cc: Nicholas Kazlauskas<nicholas.kazlauskas@amd.com>
> > Cc: Tom Chung<chiahsuan.chung@amd.com>
> > Cc: Rodrigo Siqueira<Rodrigo.Siqueira@amd.com>
> > Cc: Roman Li<roman.li@amd.com>
> > Cc: Alex Hung<alex.hung@amd.com>
> > Cc: Aurabindo Pillai<aurabindo.pillai@amd.com>
> > Reported-by: Dan Carpenter<dan.carpenter@linaro.org>
> > Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
> > ---
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++++--------
> >   1 file changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 1b92930119cc..e3df11662fff 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -10727,11 +10727,20 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
> >   		drm_old_conn_state = drm_atomic_get_old_connector_state(state,
> >   									connector);
> > -		if (IS_ERR(drm_new_conn_state)) {
> > -			ret = PTR_ERR_OR_ZERO(drm_new_conn_state);
> > -			goto fail;
> > +		/* Check if drm_new_conn_state is valid */
> > +		if (drm_new_conn_state) {
> > +			dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
> > +
> > +			/* Attempt to fill HDR info packet */
> > +			ret = fill_hdr_info_packet(drm_new_conn_state,
> > +						   &new_stream->hdr_static_metadata);
> > +			if (ret)
> > +				goto fail;
> >   		}
> > +		if (drm_old_conn_state)
> > +			dm_old_conn_state = to_dm_connector_state(drm_old_conn_state);
> > +
> >   		dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
> >   		dm_old_conn_state = to_dm_connector_state(drm_old_conn_state);
> > @@ -10766,11 +10775,6 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
> >   		dm_new_crtc_state->abm_level = dm_new_conn_state->abm_level;
> > -		ret = fill_hdr_info_packet(drm_new_conn_state,
> > -					   &new_stream->hdr_static_metadata);
> > -		if (ret)
> > -			goto fail;
> > -
> >   		/*
> >   		 * If we already removed the old stream from the context
> >   		 * (and set the new stream to NULL) then we can't reuse
