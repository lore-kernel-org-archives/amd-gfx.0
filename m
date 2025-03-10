Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183CDC28B2E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 09:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D426010E54A;
	Tue, 11 Mar 2025 09:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GJLL1WRN";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D574910E2B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 19:49:14 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3912c09be7dso2530082f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741636153; x=1742240953; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BCAuazpPMbYWsaNkUKxyhzQyMn4S8VMIE7QgIdLar98=;
 b=GJLL1WRNar37VbOHMMmnTFUjISyW6KTa8i9wdGo2se3H+EhVOqOt5EE5l508X8CRPJ
 6DbFpAWLijJ9XPFMs1MKL7HUBu7rvtwH138yBIHCnOKs26AryBv7mDGMObPBCvFQjNtd
 DWd9ELhLp8DbeK8bEfGmLrnw66XXR+tAuFmLq6vOV4vpIZxVGS2748obsFTAoscuAuGq
 IuWvcLjs3BDvv6OYNbtB5pHxEZWzrEMC8myH9LMIEK4fshUSRn5HXXU9jFoS/SvjQFKD
 DIC3+tV3w5BdlCp3e8InI7M7UY4bhjBAMutEaL9FBloBOohG/c6ESpO+ZA3L/elQykPf
 a+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741636153; x=1742240953;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BCAuazpPMbYWsaNkUKxyhzQyMn4S8VMIE7QgIdLar98=;
 b=B/omKQ44TiykMwkGh/y+WsvUJiHjxH+l4vR/Zp3DXaHlOI1I1Ehay1D8pBb2FRyWFj
 rb3R3OZ3452Mb74Bl0F5YVKzyvB68KM3kFVSgNYxrOSTzgig1vPuEUKqHO3Yey27wOju
 8wjilR2Jh7xShgx1ipB7ruSQ4DPNTeBRzCVjPnFG0Uf9nHwMOzcTfBWv2XX4YM4itBKZ
 +ggLR4I4TL8v3NxSj+u+9fuFAFfjmKDRIWDFqy28XVCZWFR52gUqXmcqqb6zyRVdgpGC
 RmggtK9TA7DbMOI5Dj24dicbXB7J18O/nS/QRBqJryIcBnu+IFuylUQfL3cZUZIkXcYg
 2bHw==
X-Gm-Message-State: AOJu0YyNb/6IPaeh2AZRiX+QjHONbEflN9YlIndxV6GCkmTldB5SYRt2
 YQqzte5mw9rOP8cbDd/Y/AprQm83O9kjQs0QoJB1PBZ4WonpfSXCBJf87Pn4fqVollWe2Oc0Zfc
 y
X-Gm-Gg: ASbGncsC5zn9K1jtW0961OazuyESLXFtrMQj6ckHp5mzALevdHMOu33Mlq25T9bGEjg
 Gc8Ps8ZVRrxIz7M58MgeMNVNSdewnWl9uRe90Vcz5jt/Jt3n1cfw/9BKfrKSo5fFE1QB5+sHful
 hEsrKDsG38kRWHxJ2+06MieUZcYgfEaIBNWZljvwBsazsa0U8i1N7R9CoDPbUAuEDZOISLov/36
 4xxjwe/IFpXmWNFMv8EqAJqq6wDXe1yomFCbvehDpCrIeqE1ybkfQglxwlvjg7HsueHfYoetAdL
 Z2oBZfElb1MGmV5UYgtHJgJOnSCTU2yCL0aTLBKOL0q1MX4uCw==
X-Google-Smtp-Source: AGHT+IEka8J41h3IXsy09ddM3TVwMT5BCHjvV2dLC/LpY9IwOCe2fUttv6vpZ6EbGm/a8MCFZFEpMg==
X-Received: by 2002:a5d:59ae:0:b0:390:f5e3:e833 with SMTP id
 ffacd0b85a97d-39132d379e9mr9565860f8f.23.1741636153416; 
 Mon, 10 Mar 2025 12:49:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43ce8a493d0sm94262705e9.1.2025.03.10.12.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 12:49:13 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:49:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Expose HDR output metadata for
 supported connectors
Message-ID: <d6cf4541-37bb-4588-ab94-057c00231415@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 11 Mar 2025 09:36:43 +0000
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

Hello Nicholas Kazlauskas,

Commit 88694af9e4d1 ("drm/amd/display: Expose HDR output metadata for
supported connectors") from May 28, 2019 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:10751 dm_update_crtc_state()
	warn: 'drm_new_conn_state' can also be NULL

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
    10672 static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
    10673                          struct drm_atomic_state *state,
    10674                          struct drm_crtc *crtc,
    10675                          struct drm_crtc_state *old_crtc_state,
    10676                          struct drm_crtc_state *new_crtc_state,
    10677                          bool enable,
    10678                          bool *lock_and_validation_needed)
    10679 {
    10680         struct dm_atomic_state *dm_state = NULL;
    10681         struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
    10682         struct dc_stream_state *new_stream;
    10683         int ret = 0;
    10684 
    10685         /*
    10686          * TODO Move this code into dm_crtc_atomic_check once we get rid of dc_validation_set
    10687          * update changed items
    10688          */
    10689         struct amdgpu_crtc *acrtc = NULL;
    10690         struct drm_connector *connector = NULL;
    10691         struct amdgpu_dm_connector *aconnector = NULL;
    10692         struct drm_connector_state *drm_new_conn_state = NULL, *drm_old_conn_state = NULL;
    10693         struct dm_connector_state *dm_new_conn_state = NULL, *dm_old_conn_state = NULL;
    10694 
    10695         new_stream = NULL;
    10696 
    10697         dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
    10698         dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
    10699         acrtc = to_amdgpu_crtc(crtc);
    10700         connector = amdgpu_dm_find_first_crtc_matching_connector(state, crtc);
    10701         if (connector)
    10702                 aconnector = to_amdgpu_dm_connector(connector);
    10703 
    10704         /* TODO This hack should go away */
    10705         if (connector && enable) {
    10706                 /* Make sure fake sink is created in plug-in scenario */
    10707                 drm_new_conn_state = drm_atomic_get_new_connector_state(state,
    10708                                                                         connector);

drm_atomic_get_new_connector_state() can't return error pointers, only
NULL.

    10709                 drm_old_conn_state = drm_atomic_get_old_connector_state(state,
    10710                                                                         connector);
    10711 
    10712                 if (IS_ERR(drm_new_conn_state)) {
                                     ^^^^^^^^^^^^^^^^^^

    10713                         ret = PTR_ERR_OR_ZERO(drm_new_conn_state);

Calling PTR_ERR_OR_ZERO() doesn't make sense.  It can't be success.

    10714                         goto fail;
    10715                 }
    10716 
    10717                 dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
    10718                 dm_old_conn_state = to_dm_connector_state(drm_old_conn_state);
    10719 
    10720                 if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
    10721                         goto skip_modeset;
    10722 
    10723                 new_stream = create_validate_stream_for_sink(connector,
    10724                                                              &new_crtc_state->mode,
    10725                                                              dm_new_conn_state,
    10726                                                              dm_old_crtc_state->stream);
    10727 
    10728                 /*
    10729                  * we can have no stream on ACTION_SET if a display
    10730                  * was disconnected during S3, in this case it is not an
    10731                  * error, the OS will be updated after detection, and
    10732                  * will do the right thing on next atomic commit
    10733                  */
    10734 
    10735                 if (!new_stream) {
    10736                         DRM_DEBUG_DRIVER("%s: Failed to create new stream for crtc %d\n",
    10737                                         __func__, acrtc->base.base.id);
    10738                         ret = -ENOMEM;
    10739                         goto fail;
    10740                 }
    10741 
    10742                 /*
    10743                  * TODO: Check VSDB bits to decide whether this should
    10744                  * be enabled or not.
    10745                  */
    10746                 new_stream->triggered_crtc_reset.enabled =
    10747                         dm->force_timing_sync;
    10748 
    10749                 dm_new_crtc_state->abm_level = dm_new_conn_state->abm_level;
    10750 
--> 10751                 ret = fill_hdr_info_packet(drm_new_conn_state,
                                                     ^^^^^^^^^^^^^^^^^^
Unchecked dereference

    10752                                            &new_stream->hdr_static_metadata);
    10753                 if (ret)
    10754                         goto fail;
    10755 

regards,
dan carpenter
