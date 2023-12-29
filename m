Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8E4C47074
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Dec 2023 17:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DABE110E1A2;
	Fri, 29 Dec 2023 17:43:14 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9A810E1A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 17:43:13 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so1152028b3a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 09:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703871793; x=1704476593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X9X6ZB7FeanCSy1/xGxwiuRSlabOIimw2qpZmG+rkj0=;
 b=TjCAr+RRHjkN9HsT74SpSDWAiVlAa1JviDK8ut0J/TyY5eMEFd9V2/xujKm+8Au7dI
 cs8ZKx6ohjvL2u2aC+pbYxVsITgh7YG2lyWSBMuFa5iWz3HSQ9Q/uU22ofFjSZUoEE32
 Ea+xRYTvm/MVyEPFl2i2JozxW7x1mFIdsq/gqu0qBIzOlbrT1JpJoVAUbz3NzWMbYBR2
 pu5HY+z9Gm3OWB7gC7brBSEoz+UfaD44VRPZDZFe/l32uk5FpjTK1GpsI4BY37ntYgbI
 d/wzvkmJ3DI+VPTGIxRz8ig/3HGu1pqStQYx1MlpxqU8ybAgE751u+MfL4ej65lBKcBU
 s0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871793; x=1704476593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X9X6ZB7FeanCSy1/xGxwiuRSlabOIimw2qpZmG+rkj0=;
 b=CBo6m9hZuBzRSXWNgiyVzfsid8Oso2ggTLNRLEI6uNIH4Ta3Ar/kUqZ+Udq6/19VFz
 hw0DF8np6LvkO1nVaWPHKG1IzSriEEaOdYwVVwd6y+R+b7rhe4O1MR3S5cVi1UW0kgmG
 0ls7lyyM3ZVzyRleTQsiUt4hWRGS0nQQsdKI0JAtFG7ypHALPal/ycmEm0FMUm6Q86jX
 Hnc6ks9D+oTv/mg+axDupTOPevtREK0LB2R7MrlMuHxgASdXiCiCQyknKzNYYNd43J8v
 9/bygo6lEoRgseFLOReu1gICyug45CxWTm3hYyTUwfJ58+pdZXtHAX/Sz2PQOpOWIxDB
 Jvmg==
X-Gm-Message-State: AOJu0YzYC2F1bWSyzj8SHf7e3+mLeGLZcfY4Hd3YyWUITro/tBszgcck
 4bzV26/6GF8Z3HsPJ1R9UqY=
X-Google-Smtp-Source: AGHT+IH+pbX+C2WEJV/WSjLwjqHPRaxK4WTlhPmzpEl/rtDzQ96KbTjN21/NBsJB/16EbZCzSlBDLA==
X-Received: by 2002:a05:6a00:2315:b0:6d9:c0a0:b1f2 with SMTP id
 h21-20020a056a00231500b006d9c0a0b1f2mr8242705pfh.46.1703871792806; 
 Fri, 29 Dec 2023 09:43:12 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a8c2:13af:e16c:ee4d:83e4:91a0])
 by smtp.gmail.com with ESMTPSA id
 m25-20020aa78a19000000b006d9b38f2e75sm10056424pfa.32.2023.12.29.09.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:12 -0800 (PST)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com
Subject: [PATCH 0/7] drm/amd/display: Fix codestyle issues for modules
Date: Fri, 29 Dec 2023 14:41:49 -0300
Message-Id: <20231229174156.1800-1-marcelomspessoto@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset aims to fix most of codestyle issues present in the
modules directory

Marcelo Mendes Spessoto Junior (7):
  Fix hdcp1_execution.c codestyle
  Fix hdcp_psp.c codestyle
  Fix freesync.c codestyle
  Fix hdcp_psp.h codestyle
  Fix hdcp2_execution.c codestyle
  Fix hdcp_log.h codestyle
  Fix power_helpers.c codestyle

 .../gpu/drm/amd/display/modules/freesync/freesync.c    |  4 ++--
 .../gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c |  4 ++--
 .../gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c |  6 ++----
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h    | 10 ++++++----
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |  4 ++--
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h    | 10 +++++-----
 .../gpu/drm/amd/display/modules/power/power_helpers.c  |  2 +-
 7 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.39.2

