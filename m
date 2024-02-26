Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CB1C54798
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Feb 2024 08:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672B310E8AC;
	Tue, 27 Feb 2024 08:34:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w2JiP+P3";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7395510E75C
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 14:42:26 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-41296dce264so21088465e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 06:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708958544; x=1709563344; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uhG0zl17kqV2ALBl65EWz032nuAYP36b6nXpBEU2nSc=;
 b=w2JiP+P3r/Kx8aB1JxmGiEsJ3Nl6id6tEhKDuL5Wzdg7t+5mbvGRhlIgGpK/I2DuvX
 wSupvbSwQEhL/KBT/Bualm9VZELuMs66D45V48+lRSnMRps69KDVl2uvTN7SgXY/5Y0G
 RldE5EsTUo5AIgai2R4PDDS9jwxEov5caxlMIBjaGfMujI5gASqLyXi3JH+7QIFL6ydN
 wr8V0SjBuzMRmh0IduNNeqHw37UnzUeGyff+GvrlMu8yt9p6vCHBYB/ghLWcb8+7YvuJ
 Kc4gbe63XcpL48phvY8WEiVDrbNJx6lFZZYK02Vnv9lHfR82XAg+ahhzGOXWI80mImiA
 qA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708958544; x=1709563344;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uhG0zl17kqV2ALBl65EWz032nuAYP36b6nXpBEU2nSc=;
 b=jVpM0E2M1OLpIJT5ARSXlYbZqMQhEMOUXkDREZRrN4dQoiiHYbNr9g1qRzkLBWw+Lx
 LaO/PNzYVL8v4Gz5V1FPAf7qBGxZ1KEPBdWXw+oRU/yNjYePJj23MuWJxYAqDDsUabyG
 ga+91ipmYMNtyGTLVaHSSjh5mOYdXTSQ2vrW0+dr6G4Sq8y+Q8evlv539Mif4MAdwLtg
 ZrvcMT8wvDUfZiaFCm10nuo6Du7nllcFaZ5B2rUgVOhRWtlv9OXBnXhcvLCr9IKOcDtB
 rXjyk/YWR2O1jJsRanrxW3QjPlwXb0y9rsXTKulmBcBCsvP4TaaUil/iRoU/jsKMqxln
 Qjfg==
X-Gm-Message-State: AOJu0YxwFr5nqdjYEaATXf8mBTOjiHbqQ2Bj5XedX1zF5sNNXpXgVx5q
 Hr1FgwX3M5IQ1pe59OHslUF7UslX57utBLFiSwd03lfy36MASsqNP4g8ZmspBx0tiZaQlavZcEO
 4
X-Google-Smtp-Source: AGHT+IEuH5jAK+G+iVwtktxRmetJ+FQGOf84Z0suGs74yw5Bn3BVjfngD54NB8kwyOCsc75yQ7uD/Q==
X-Received: by 2002:a05:600c:46ca:b0:412:a8e3:e910 with SMTP id
 q10-20020a05600c46ca00b00412a8e3e910mr726877wmo.7.1708958544619; 
 Mon, 26 Feb 2024 06:42:24 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 l15-20020a05600c1d0f00b00412a31d2e2asm5044397wms.32.2024.02.26.06.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 06:42:24 -0800 (PST)
Date: Mon, 26 Feb 2024 17:42:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: mwen@igalia.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [bug report] drm/amd/display: fix null-pointer dereference on edid
 reading
Message-ID: <72a396f0-f580-4139-8b5c-c0152611ac7f@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 27 Feb 2024 08:34:00 +0000
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

Hello Melissa Wen,

This is a semi-automatic email about new static checker warnings.

    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6683 amdgpu_dm_connector_funcs_force()
    warn: variable dereferenced before check 'dc_link' (see line 6663)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
  6662	
  6663		if (dc_link->aux_mode)
                    ^^^^^^^^^
The patch adds an unchecked dereference

  6664			ddc = &aconnector->dm_dp_aux.aux.ddc;
  6665		else
  6666			ddc = &aconnector->i2c->base;
  6667	
  6668		/*
  6669		 * Note: drm_get_edid gets edid in the following order:
  6670		 * 1) override EDID if set via edid_override debugfs,
  6671		 * 2) firmware EDID if set via edid_firmware module parameter
  6672		 * 3) regular DDC read.
  6673		 */
  6674		edid = drm_get_edid(connector, ddc);
  6675		if (!edid) {
  6676			DRM_ERROR("No EDID found on connector: %s.\n", connector->name);
  6677			return;
  6678		}
  6679	
  6680		aconnector->edid = edid;
  6681	
  6682		/* Update emulated (virtual) sink's EDID */
  6683		if (dc_em_sink && dc_link) {
                                  ^^^^^^^
The existing code assumed dc_link could be NULL?  Can it?  If not then
let's delete this check.

  6684			memset(&dc_em_sink->edid_caps, 0, sizeof(struct dc_edid_caps));
  6685			memmove(dc_em_sink->dc_edid.raw_edid, edid, (edid->extensions + 1) * EDID_LENGTH);

regards,
dan carpenter
