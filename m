Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6F3107BCD8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3760D10EC9D;
	Fri, 13 Mar 2026 16:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cy2pEatb";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 749B210EC13
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:50 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-46708149af2so1223912b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408290; x=1774013090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVWjZWuErU/TT0M/gLtU2+Pv2Hf/DF/3aPzw5cJbYqU=;
 b=Cy2pEatbmGnoDRrLfCijQ5Qka7X715kGRZl6XvU8E5Ha7mV3HsiKtgOoJ7BcQ9P/hr
 shN8lfkRgtXwwRXFq/1IMrYBqJRkLsBzcLCpbIgakMYs1Q3azBDH9f2RzT1gC6L/dJxP
 aX2AUwpIlGIgPpqpf70f+5fpyUputSEhXKPVrsYNTCtsEXGxzFDEcRl9DnOWTB8rlQT1
 1eyqhG3GiV1JdoSF0/GHcTMWUbbpqoJCJzeGKmSDqPJLw13W1mGHiCjAprRORlf4eMEi
 gbQB2HuHmGthvQWo2DzE4TUg/bQPnN0zR+4ZTI4TUvmtKoa6ibSNzVRH4SRJi57rmgu9
 HO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408290; x=1774013090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hVWjZWuErU/TT0M/gLtU2+Pv2Hf/DF/3aPzw5cJbYqU=;
 b=sXCOk6VMysUCjTCmObJh0n6pI8Xqfy0GOfrVf59LBKETfP9NqXl/bexBAT2Hba4q8O
 ELxgRk2eDlBSztC2eRtj8NTzLtThFzL78/JCzMQAGXWapxAGmc4yqNn1HJIHp6pQ34y+
 DRqi079J6I166IK8YBtzVnhyvYYgXhf1UrXBO6HD8/vML5F8DGtcxEwZkYx4t3ZelegX
 wCnS3NGk4M4ADagiG/37Ee2yz6M53yv2J/0RP5nOO+gqyPnUOXzx7OaUL2N/KnqX8JRu
 6vztQ/2Yt9ZeB+KMkyM5oYZ4Sqc6Kx/R/Nzb2t/CqizimffK3qhGx9okE/rZja9JQtpq
 msdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCVUtlNksNVrvt0dBERdfzlN3FAlSDXEgubvG6SBJkIFqXXxUj79zzOeWvvrCyiAmmFBsjra+N@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUq9lVcJzQQ2hhzkKHF+LdSwPqLOf/LoDhPhelbyAbwcBcf8jt
 0tgsP+HfzkqkW8tVR19cmS3YD9VoGBTgigvBjI/PyHM4dBZKhbb0mO7j
X-Gm-Gg: ATEYQzxELv7t8UiD9Bc8k1cshnFBX784K6USbJraPZeJ7qFJCjp7SktrkEIPzOhnvg2
 Z3znianSv6KcQU6ziBi3AXwksW77DSmNFGbHK4ewsyc/+bi5z71zwxwryoVQhxPPSA+ieAV520J
 oPKfWKnsElt4bRcfk3grcNR/QVEdW7M/1guExaBRL/3luv06TNo0UTZUDYocTQTZfCV6/WjROZN
 gQXP7106BmyvOOtgL/0HQo3HyaHrPXmM7+Z6fRjFDASHQyn5qOB65hFpiggU1oL/19GiAW0gTGH
 6NGL/ick79VfydhBGCB/QusV37MgTfuyAJOf5sDQUsmUVGhcgaCrfd2wVouSfQ4lvqAoV4a7PgM
 1o0hNZo03wPMYdRmLcsWnSDvnjL83fDhlZqSoX9ZJ0D3A8BpTsjCU5RSNP3N0g1b+/HtDXKmYVx
 sfNrNTaHxJoNKf4yVfpi8BNMVFOIQmibOSPwGlRjnxf687G/7T
X-Received: by 2002:a05:6808:2386:b0:450:89ee:922c with SMTP id
 5614622812f47-467570dd9e9mr1673636b6e.27.1773408289722; 
 Fri, 13 Mar 2026 06:24:49 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:49 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Dave Airlie <airlied@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 54/65] drm-dyndbg: add DRM_CLASSMAP_USE to mgag200 driver
Date: Fri, 13 Mar 2026 07:20:19 -0600
Message-ID: <20260313132103.2529746-55-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Mar 2026 16:51:10 +0000
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

The mgag200 driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/mgag200/mgag200_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index a32be27c39e8..02a703e5de80 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -28,6 +28,8 @@ static int mgag200_modeset = -1;
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, mgag200_modeset, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 int mgag200_init_pci_options(struct pci_dev *pdev, u32 option, u32 option2)
 {
 	struct device *dev = &pdev->dev;
-- 
2.53.0

