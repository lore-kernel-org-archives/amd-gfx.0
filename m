Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEABBCD3428
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2026 07:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C9910E50B;
	Fri,  1 May 2026 07:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="e2+NOuif";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7830810F2FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 10:45:34 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso5122345e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777545933; x=1778150733;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tuw4DQUQ8wFwSodwVVRsikXJG5LLCcS+5kiwz8365jg=;
 b=e2+NOuifSs++QfvJif6ThAHuz7mdTPkBB/rX9wyeYAtZs/2mB8v1hPdmCHC33k0pPy
 BbTavMRyDv0M+qsAknYWTLICaW4Ol63i2C5waqcjmL1CbNiNE3m+IrND0KFJer84j6Hx
 T8ySK1mbt6AA629LMXtEtaZzYG00OnDzOBSB0XdvHvHDYcUOxYArKh3BtoiGi9LtNrC6
 IbK3zPszHkiZgPp1OHxJxvb495Kvs/tNJ1qMoR+NXpW6oOl/c69kimTHLiKs8g8AdoEo
 XlnwLDDOWO2hjnBA7Cy6TdDl7x+JkfcGqyLLGhREByMIvUVAYuc1GxSH2lGlTeKKn45Z
 13fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545933; x=1778150733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tuw4DQUQ8wFwSodwVVRsikXJG5LLCcS+5kiwz8365jg=;
 b=VWvL86i6CaNJOdd9/D46EImwKCejqcsDNPRYZ4pVOfEIcMnaHDokeNZCUHxjnBwiv3
 FBNjB3YZAwOnrkMOIFqmuw8GpVAAMw7bJx7QxwjXVxd5IraH88QNW3WUXO7S+0aHEcd3
 jbyo/wQcjpSQhLHSwz2iSQYSqJXpVwYvdI86+jy9sNSjYhqivxAPcXiqLhWon43I3lAj
 LolkK1+aXy9B6eFVXQQSyOrL82nP0V/UBjhmb+SglvAfVUZBImmMPGyhiawHD/xX3lcB
 GiLbS6dgVfTcoqmiU4xAaNqDg6dNp8ma5qHUPWhW4VQisUyz605rt5FIX858ptxuuq3c
 3WMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GHfLbmcSFpJ/1W5HFjS9/h73qiKDSVtKIeLZuORdXSbfHia5L22F4s2RRPyzjlSyXeEv9TKj2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwK+91t9brN3T+ZvxrsgcIWY7hSKw/3abmtaTu1d/wTeHDsnC3l
 l3jlCro48FmqyTlrnpw3Xli7fkldKq2LLNwc5FTQ/R50A9UX6qcbmbDhA2PBtDPzCrQ=
X-Gm-Gg: AeBDievUxZeDiMZXeY4Ve2FQHMTpImA59BQmgyep4EPpqmcU059Jac7lrgHDbDqhrTZ
 oQi7HH0NuqtF//j/Z3z3LEYrxnqFyiPZIVdpc0/zww/vHMGOU0NS+7/x46c2R2kShsxn7tO7sv7
 QxRGR43tKvOp7htK03OB1jsj4OAgOr9biq0M7VWZ5FizTsOo8vGKXbZnxxZdObbgm6ZIfEvj52Q
 bExxt8agJiyBsEl16MShdfo3gz8vEubj3YuQpQRhe+3X1Te3+zh12+iEaLKK9/ykIogLqOL4eSv
 Ax5C3eHXjdMcatZc7m5Vj2YfEmn1QqKTNA5UnHLBYWH5rIhs7PYpt0c934W9+41MsL4SLTmXtux
 SMXjxjfZdCHKsw0Njk3eYIKYqBvAYpVrxziBh1jNNwqIrcRIlsGv+xS9wB76NYvQTAcJ8hlMpvY
 Y9Isv7oV+4yKrlU5Yugsxwhi/DFYW5YqXv9XCfEiq6y7tONo66Yow9Dk8CNuCRDR7gQkv/o4xT2
 T6LjqRNdPa+gUvs5EgTVZhQMPh2VNLyWIIp
X-Received: by 2002:a05:600c:a30b:b0:488:c014:34da with SMTP id
 5b1f17b1804b1-48a8449dee7mr30397465e9.26.1777545932923; 
 Thu, 30 Apr 2026 03:45:32 -0700 (PDT)
Received: from localhost
 (p200300f65f114e08c77bcc4a3b99186a.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:c77b:cc4a:3b99:186a])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48a82307f28sm92585885e9.13.2026.04.30.03.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:45:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Dave Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v1 0/3] drm: Drop unused include of <drm/drm_pciids.h>
Date: Thu, 30 Apr 2026 12:45:12 +0200
Message-ID: <cover.1777545446.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=l+YDHlVs7ftuNxR+PsZazTu554cMr6hKc5EqbljDrkM=;
 b=owGbwMvMwMXY3/A7olbonx/jabUkhszPRjsfzrV/+Pl/U2m10H+L4CmVpbMrag5Msun/t7r47
 TIJFuuXnYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBM5MNn9n/K1s3zmN58X1lQ
 9ffp+jypjMWr2L4ZOC9q3+s60+/l5ce1si8karo41LO8Ntkm6NxWi9Wfb/nsTfjlZb6FzdNzjWQ
 qSvoYGPq6U76vkJMTZv7qGXnxuWkfx92jwnm2ibsuq/nkhp1v/Ou84O6Mv0c7P8cwigmELlc3um
 lUp1TB0uD7e9bl1AinjrBTtpvTtsbvzPnWvj/+TNhdXZ/Cr7XbD53nsbEumWeZtvpxm8WX3qX6/
 g+Xvy9Z1G+abxHGzfYybOVl2cIHNenb7b5oWi55XD2d8bmxqm/qWw8HgamOF/MWPBG39d6/jTMz
 Z2X6sc2WPc2dPycX8qtf03dJrcw97fqOb6H/hBQuY/ZSAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 01 May 2026 07:11:26 +0000
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

Hello,

<drm/drm_pciids.h> is only actually used in the radeon driver but
included in several others. This series drops these includes.

The obvious continuation would be to fold the definition of
radeon_PCI_IDS into the only .c file using it. But I post-pone that
until
https://lore.kernel.org/all/20260430102958.136859-2-u.kleine-koenig@baylibre.com/
is out of the way.

There are no dependencies between the patches, so I suggest that each
maintainer team applies their material to their own tree at their own
pace.

To state the obvious: This is merge window material.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (3):
  drm/amdgpu: Drop unused include of <drm/drm_pciids.h>
  drm/gma500: Drop unused include of <drm/drm_pciids.h>
  drm/mgag200: Drop unused include of <drm/drm_pciids.h>

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 -
 drivers/gpu/drm/gma500/psb_drv.c        | 1 -
 drivers/gpu/drm/mgag200/mgag200_drv.c   | 1 -
 3 files changed, 3 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

