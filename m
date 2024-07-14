Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9102C3DA45
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 08:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F0E610E301;
	Mon, 15 Jul 2024 08:39:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bAGhr4L2";
	dkim-atps=neutral
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 020B610E05E
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Jul 2024 00:51:58 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-8100f08b5a8so1005406241.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jul 2024 17:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720918318; x=1721523118; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RKNNtoRYyRFaWrLCKwWk1hyHdEXa7o4btSdNDP9UG5k=;
 b=bAGhr4L2XvdQi3EzfOc1ELTUzR/bd9Q61JcsljpnYrY2N2T61GsOdq/nqrW7nbdKzl
 vU8ht2QSIzawSQHiruCqMMKjWK+sig81dvC6CmK4FWYOAzEULlHaZAkSVxAaaZ5aeKMR
 WTdyt5jmbCjMc+KTTBEH0G+drj22X1XUA6JFooH2Su81Q7V2cCGCjvKEzN74Wfx2zowU
 x6Pa1qrYIJ/owi0jnJ6Q9PpUkUlHshaxa1Sfq16Ndw+MpKVODdqrMzrNNOrmbrkzmrwb
 r3PKGfTSv6txuWsc5koUQrmnuR586M+I/nurKeyVLbqOUJ95yJtsy2SEktVRasg38DmQ
 rbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720918318; x=1721523118;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RKNNtoRYyRFaWrLCKwWk1hyHdEXa7o4btSdNDP9UG5k=;
 b=BSRX0sxDEnlWNm+qEKsDjkaBqBvBU27TCP7auwTycg3NsgSQrZEIoYAl9erKUfi/28
 UF+dlIw2z18HcyjLeE7Zi88dOdT17YsnPfgIlZIno+iEwPmJ1mhtsSqYYwokXxPyFTVj
 CajKTqzH2ubT+IqoUP6ecxebUeBYcUsc57yFAjEKonyr8X1+H+TWvtlmdhUHtUuJ2y7G
 oQZ82eWVaPfCrY+oPFxjiOeDQ+cxWEs6d7zXwmgFgizJuU9slM54BhVEYVcRQMGNPCyG
 LLFgp2bAuixtU+9pBlrwvhOyHX8OGlIHv/ngVKKZdl6fa7k19MJCOh9F62kNnSgPfRNr
 2arQ==
X-Gm-Message-State: AOJu0YwqKGikDRg4Ri81p8SoBr/A4D0zmAG6XeTqBu0GblFd0H03bB+Y
 kpq2xX8uHdzMsLtGdWQ5LxfRTmxwvtMXAWaCsN9apbDfAjx20YofAYiuHvQslF4=
X-Google-Smtp-Source: AGHT+IH+buhQ0cCMpdvHUc6btN6ANwPmc6vY4DSaLjLkEIzXcsRHChaRPUrKZ6l+6T+XelexiNJYOQ==
X-Received: by 2002:a05:6102:6d0:b0:48f:de85:2b4c with SMTP id
 ada2fe7eead31-490321d51famr19517689137.23.1720918317349; 
 Sat, 13 Jul 2024 17:51:57 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1cb1])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ce74ee4ba8sm346355eaf.7.2024.07.13.17.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 17:51:56 -0700 (PDT)
Date: Sat, 13 Jul 2024 19:51:54 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stylon Wang <stylon.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Fix ineffective setting of max bpc
 property
Message-ID: <b5a259e8-193a-4895-a34b-c62d0af86e61@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 15 Jul 2024 08:39:00 +0000
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

Hello Stylon Wang,

Commit fa7041d9d2fc ("drm/amd/display: Fix ineffective setting of max
bpc property") from Jun 12, 2020 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7201 create_validate_stream_for_sink()
	error: we previously assumed 'dm_state' could be null (see line 7194)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
    7185 struct dc_stream_state *
    7186 create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
    7187                                 const struct drm_display_mode *drm_mode,
    7188                                 const struct dm_connector_state *dm_state,
    7189                                 const struct dc_stream_state *old_stream)
    7190 {
    7191         struct drm_connector *connector = &aconnector->base;
    7192         struct amdgpu_device *adev = drm_to_adev(connector->dev);
    7193         struct dc_stream_state *stream;
    7194         const struct drm_connector_state *drm_state = dm_state ? &dm_state->base : NULL;
                                                               ^^^^^^^^
                                     ^^^^^^^^^
This used check connector->state but then we changed it to dm_state instead

    7195         int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
    7196         enum dc_status dc_result = DC_OK;
    7197 
    7198         do {
    7199                 stream = create_stream_for_sink(connector, drm_mode,
    7200                                                 dm_state, old_stream,
                                                         ^^^^^^^^

But dm_state is dereferenced on the next line without checking.  (Presumably
the NULL check can be removed).

--> 7201                                                 requested_bpc);
    7202                 if (stream == NULL) {
    7203                         DRM_ERROR("Failed to create stream for sink!\n");
    7204                         break;
    7205                 }
    7206 
    7207                 if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_WRITEBACK)

regards,
dan carpenter
