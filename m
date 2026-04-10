Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E27DEBFD14
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 08:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F6210E358;
	Mon, 13 Apr 2026 08:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CYDW+JhK";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DCE310E8BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 07:32:59 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488971db0fdso17033995e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 00:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775806378; x=1776411178; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KaKXwNgDTe/cTcSLDr5a9iy5kqjhw13CM3LHHvC+Yps=;
 b=CYDW+JhKcJHCPtKIf2Ma71VqPCs/ewwyR74mPTi4lJo76GH0kQRZzDT0ovEgXb25ij
 yUOkD+YpqcW9rImw2nxXy69/+HsVovkBUBI1+rrNamV9beCK4qa/NCj7gIGb9MqNPV1D
 ui0Hw4xKQEffFwGq4TqxguHD0FJ4IxtnIKV74Nw/T1tBRQ0WnPUMinSf0ihrTK20lHkf
 HG3ntgBxzWneVpBx63Xbs0iuILhugsCVosayp9ASGvaBwM+qRqgWvpgOG7xAR13lgtXK
 hIyqj0lGwjkT9H1k2Pe4lnA6+gNbVso7IV/abgB4t5tegFE7PuW4TVIwnqfFbW0gsS6W
 EfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775806378; x=1776411178;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KaKXwNgDTe/cTcSLDr5a9iy5kqjhw13CM3LHHvC+Yps=;
 b=PjmB2WBiMSdZUmIvXYStw1ZIbitAOqVfx8YFnp7PA6IV1Zocnn9BV1Z2Uo37xeIT1Y
 BzrxRLWd6emzozpfI3GRhjBH3M53gEZnm4cvpxYsmfQmRqRwSngNGOLo8H7igKDJkW4q
 8v0mJVBEaXS9zSmDXssC/KAEpfZVMXrgS7Q3osqGLA6aKZTJIGrtkyWmV+IeGfLoGzdb
 6W7ga+eiP8APrgi163ngdSpazBk+AEsFTKFld+GTmomnhiMAbCB3n5DzEVx643UlRIJv
 CtXCA11ejI+CK+JzOGvVcHAYSb5bsXdVJzH21FNGfSlmDCXGYI+QsIlrs2fPF3LWdntC
 9EFw==
X-Gm-Message-State: AOJu0YxBu0515EAbum8+5gv+G8tYrqtLHt0Iu5YQ2quYnm9+4IXBN5c2
 ULcFm8vd51d+z6IUMDzljDrJUvbiH8eS3pDeCdc1re83dTp4l4u7YQC3
X-Gm-Gg: AeBDies5uqpDVlvNmjOdIUxV4Mezxmuv8QSYxkjw0B8BzS4/EnNGzWSzHa/v9lWuL9U
 0nveOX8ntIPCjB9V8iLS0Mj2pAXT+NtDgL0J0i42wqnGYw+87C/3iYOBv+JxgoIWVraxiSLjpi4
 Sj8KDghd/zg/igYegB9oA3CTzsrkc3FQ/8db9um+DXad6lRXKWKDhTi7KOZX95ZCB+hQjIRGhtY
 NQA0IqXPasBu+OAnaRUaPPdHU+r9jPhz3p/qX4exKZIkmw5pOQuHALI8EHsr/8DHWEgOQ7mEFJ4
 CRatxU57rdG8RS5YCY4p//Wquzr4ZS4mb/iN0fJOxQeHtgpI/TLAHmG2ZGuuhcltYlT4wx2Fm0v
 tNhGI/4XfA/ah+s58XrJI5/QK2QAlzsDJRovQixOe1BASh+fnQnFU26haxEV6KCTCLRLajzylCf
 fB611fXMel3u+r/NQF5Gg=
X-Received: by 2002:a05:600c:1391:b0:483:6d42:25c6 with SMTP id
 5b1f17b1804b1-488d687af33mr24678825e9.23.1775806377524; 
 Fri, 10 Apr 2026 00:32:57 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5347ea5sm63347445e9.8.2026.04.10.00.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 00:32:56 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:32:53 +0300
From: Dan Carpenter <error27@gmail.com>
To: Joshua Peisach <jpeisach@ubuntu.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu/amdgpu_connectors: remove
 amdgpu_connector_free_edid
Message-ID: <adinpZORBkhVcw31@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 13 Apr 2026 08:02:59 +0000
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

Hello Joshua Peisach,

Commit 71036457ad85 ("drm/amdgpu/amdgpu_connectors: remove
amdgpu_connector_free_edid") from Mar 3, 2026 (linux-next), leads to
the following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:1058 amdgpu_connector_dvi_detect()
	warn: passing freed memory 'amdgpu_connector->edid' (line 1048)

drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
    1032                 /* Sometimes the pins required for the DDC probe on DVI
    1033                  * connectors don't make contact at the same time that the ones
    1034                  * for HPD do. If the DDC probe fails even though we had an HPD
    1035                  * signal, try again later
    1036                  */
    1037                 if (!dret && !force &&
    1038                     amdgpu_display_hpd_sense(adev, amdgpu_connector->hpd.hpd)) {
    1039                         DRM_DEBUG_KMS("hpd detected without ddc, retrying in 1 second\n");
    1040                         amdgpu_connector->detected_hpd_without_ddc = true;
    1041                         schedule_delayed_work(&adev->hotplug_work,
    1042                                               msecs_to_jiffies(1000));
    1043                         goto exit;
    1044                 }
    1045         }
    1046         if (dret) {
    1047                 amdgpu_connector->detected_by_load = false;
    1048                 drm_edid_free(amdgpu_connector->edid);
                                       ^^^^^^^^^^^^^^^^^^^^^^
This frees ->edid.  The old code used to set amdgpu_connector->edid = NULL
after freeing it.

    1049                 amdgpu_connector_get_edid(connector);
                                                   ^^^^^^^^^
This function call is supposed to re-assign ->edid but because it's no
longer NULL then it's just a no-op.  (It's so annoying that the naming
switches between amdgpu_connector which and connector which are basically
castings of each other).

    1050 
    1051                 if (!amdgpu_connector->edid) {
    1052                         drm_err(adev_to_drm(adev), "%s: probed a monitor but no|invalid EDID\n",
    1053                                         connector->name);
    1054                         ret = connector_status_connected;
    1055                         broken_edid = true; /* defer use_digital to later */
    1056                 } else {
    1057                         amdgpu_connector->use_digital =
--> 1058                                 drm_edid_is_digital(amdgpu_connector->edid);
                                                             ^^^^^^^^^^^^^^^^^^^^^^
Use after free.

    1059 
    1060                         /* some oems have boards with separate digital and analog connectors

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
