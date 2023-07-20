Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BE2C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 10:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385D310E597;
	Thu, 20 Jul 2023 10:23:20 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E3510E07F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 08:59:54 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso4683685e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 01:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689843592; x=1690448392;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4JZ2SCUbxBizdeZIrNdjtWYCyJiy2KCeoSe2gDEk9EY=;
 b=Y+JUum3nn5PhhS8K91O9St5QR4Mf6ITdUQCZYwZeOWBIqe3xmQoggf8zLMNHfSO92f
 UBwAz0qU0bypkJbWxNW+/oKx/JZnr38yimm5+JAqtGk2Okqz2tVTHTE+qdpnfVABFJSI
 0OcVD1SQnTrIPo+OmaJVE4cC/O37pXaoCALe6elgt2mN+z57gWGI37kSzacA+ogYgp85
 U0/N4i96Anpe1chCghtNVSUoDniniyXUvTaijPAeoHrOgIHr9H3XDFOlBrFw2hnuQ27P
 n7kJ3A1ooeJOhkDeOdJbtxvxxHs1pGi6BOcwq8NX7KpLm899MO4r4gv7VNHMxRHlpIwm
 qh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689843592; x=1690448392;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4JZ2SCUbxBizdeZIrNdjtWYCyJiy2KCeoSe2gDEk9EY=;
 b=UkJaIm+qtvumzn+3wkI0u7dy/3iOQtwGBHY0OmNwYi0uSY5BDIgZjKyqTMsTzHH9CS
 HqlkQTBR9J1K5ajVcpZy/YW2zs8wqhG69U8EvdnXs3eLu/dR3bs0LoMnym+saFD2zZ7w
 Vlk4dLDJX+hFOWHTQwtsJmpThMA/QNIzyiireE+4eBNemDFwRVDWw1v5o41uiPuE4vpJ
 VOS5BT1goWApsScGd2OAcVmQ1DhhKOJ6hVE4NyemhwhLPDK80BwoWytU1oAij+/+/Bs+
 vlU9cgX/ISCQKZjg1gw+ZzglKMl2Gj8QFA7G/k7pmQDC/Ot6HV1b5C18V50BNbb+03fV
 KDJQ==
X-Gm-Message-State: ABy/qLaVWHBcY1KdMBYIVP8/QTyIqIy91NA29pWOaF41MckhXhv1/k0U
 xKr0yaqm6sgoG2YKNRNX7X7EYXiDRcDfkjQczo0=
X-Google-Smtp-Source: APBJJlFRR8OTJ/9sz9B3iHl7m6BOmnjLLNRbzG4MGZ71JbaAn15xK001iZ8Bh2jD305nyELiaHCO1w==
X-Received: by 2002:a1c:ed08:0:b0:3fa:97ad:2b9f with SMTP id
 l8-20020a1ced08000000b003fa97ad2b9fmr6639238wmh.16.1689843592522; 
 Thu, 20 Jul 2023 01:59:52 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 a21-20020a05600c225500b003fbb8c7c799sm3436514wmm.30.2023.07.20.01.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 01:59:49 -0700 (PDT)
Date: Thu, 20 Jul 2023 11:59:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: rodrigo.siqueira@amd.com
Subject: [bug report] drm/amd/display: Reduce stack size
Message-ID: <ade9a6f6-58b2-45f1-9900-8df5a43ab791@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 20 Jul 2023 10:23:18 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Rodrigo Siqueira,

The patch 135fd1b35690: "drm/amd/display: Reduce stack size" from Jun
21, 2023 (linux-next), leads to the following Smatch static checker
warning:

	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8785 amdgpu_dm_atomic_commit_tail()
	error: potential null dereference 'dummy_updates'.  (kzalloc returns null)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
    8771                 status = dc_stream_get_status(dm_new_crtc_state->stream);
    8772 
    8773                 if (WARN_ON(!status))
    8774                         continue;
    8775 
    8776                 WARN_ON(!status->plane_count);
    8777 
    8778                 /*
    8779                  * TODO: DC refuses to perform stream updates without a dc_surface_update.
    8780                  * Here we create an empty update on each plane.
    8781                  * To fix this, DC should permit updating only stream properties.
    8782                  */
    8783                 dummy_updates = kzalloc(sizeof(struct dc_surface_update) * MAX_SURFACES, GFP_ATOMIC);

This needs a NULL check.

    8784                 for (j = 0; j < status->plane_count; j++)
--> 8785                         dummy_updates[j].surface = status->plane_states[0];
                                 ^^^^^^^^^^^^^^^^
Kaplooey!

    8786 
    8787 
    8788                 mutex_lock(&dm->dc_lock);
    8789                 dc_update_planes_and_stream(dm->dc,
    8790                                             dummy_updates,
    8791                                             status->plane_count,
    8792                                             dm_new_crtc_state->stream,
    8793                                             &stream_update);
    8794                 mutex_unlock(&dm->dc_lock);
    8795                 kfree(dummy_updates);

regards,
dan carpenter
