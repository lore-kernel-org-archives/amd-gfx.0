Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA902CA5FDD
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 16:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF3010E158;
	Sat,  3 Oct 2026 16:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BQx87v+6";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56BFB10E67E
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 16:15:53 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e66390995so4155975e9.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 03 Oct 2026 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791044152; x=1791648952; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CXy/DNnrFOcs2YniGE+Wy2Sq/wAf4lmRqZM5O5dATBs=;
 b=BQx87v+6H59leReV2rfw/nIGU4E2doLtTyxcNftOIZPqMt/Y098JVo5TKwcpjA1nVj
 bk5vyPFKZEqi+ZUditWb8xwCOKCwZZPRVBYbw/oNUe4g4174A7WYJEMf/iz4eLRSKjry
 0kjC4gruCKBoxVidrVNDJa4WJagmNLfcU1ABZAMlZhfmhpcJr/PAsmQqKaJ9bMTtIF2z
 RFRaAp5oHP/7X0vbBgTEYFHjRacBunnu3lHGGuXTwHGJYyvs5tVB9FVAl/ViIYktsaQk
 t5gctQYMrZuz2unG1Mf2gWK8IEchUxxy69BukR+PDeMhLeO8keHwRJzN7dA1Hu+/Gb7x
 GdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791044152; x=1791648952;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CXy/DNnrFOcs2YniGE+Wy2Sq/wAf4lmRqZM5O5dATBs=;
 b=jQbzXHpjtoYv3LH6lvcgOZD4w0NHDDhUYKCwO8Fzd7otVyLqYap9Fg0YAXvl6A6X1B
 G8MiylZW1o4oLQXlazLDtdjX3bNGVO3lYQwGutZM0fZ72KXdqOInO02X9LsIwBkoPOMi
 JfUbJyvhiVd2qK2VAfVXtDd8XX8r9QIBHXledJ1j8sooS3mfAgBrGnZgUOMxv48rgJas
 xgxmVYbCLOAmkrLPWWcW11klsZH4zbfDc34Mh3GM4QFyVMz/F8k13/6PCyoHxrmyvA0W
 8+xHnk1//fg2/zcEnE7pDwrZRHEBYLLro7itIy4EJg5RU8i1BxIokTfk4jA/hj3jmrLY
 6EKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3oxgOjbiBjKC+RQXsVLbBnYZu3humlmR2KG9bgNUKL4iFmeRt2y4BuRxE23Wzp4/GYv0zZwiy@lists.freedesktop.org
X-Gm-Message-State: AFuF++nnuW6ixQeoq1RTaorG7jO636OA2nkuQ0/wGJTLZdgcgQRy4t1p
 2R/sw7OMuHlsFvXSmIZjgjL+k2SFvGHNpYR++BalEFvaW4yAEkXupJHb
X-Gm-Gg: AYBFou0jVtuE0ULH0sF1k8brnBG1KbSabuOosGEFttKl7nLVmEliV6YCuFDjg7OwpjN
 vBtomiD+mFwaZHh80o5OCrwB8hVoyoco0PWW6WXctRspgdXOiNwdOWdvvwTdvWKHoTwr6eb7xKc
 Wf9ZdBQrQrAhMyyKPhQGiOTiiYCxc5KDWlvb1pgmeY0D5KEJiDWEqWbmYcpZRz+pii6FzsuczIv
 fGQcaJkrvBwsl9z60js9dpinpS6PpdM39NX7NNPfJt35B0C0Vl6WtnYO/84UmafDH43kBKwFW+o
 +mN0MQ9LOEp4DocTFamDX05zJwMSC5gzGDD264aLkLiw1sk5UffQzVS06LHsnEf5mjvXQnscB9E
 upSzepvWpACbcnJ+r1ZhRT3WavHEcGjTIwdQnpZSrgHQQATu5Uryn2Uy7JCWh8kUZlnI/hGy5/7
 Ni9F/BxM7ebllipf53EJ2mA/FwFIcWtt1iN8zE/qAJgy0VTddEczg8d7v/uRA1105bZQ7zp4wql
 KclxVs6Tw2/0YSJFwk7eUmUx9EwN5rvVcRtyQiMuiU6tfbyDzBRO3VjdIl0mP3nc/rE
X-Received: by 2002:a05:600c:6217:b0:4a0:1ea1:477a with SMTP id
 5b1f17b1804b1-4a0276a31b1mr96713305e9.27.1791044151611; 
 Sat, 03 Oct 2026 09:15:51 -0700 (PDT)
Received: from localhost
 (p200300eba703ae00ca7f54fffe019321.dip0.t-ipconnect.de.
 [2003:eb:a703:ae00:ca7f:54ff:fe01:9321])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f98ffsm13461784f8f.38.2026.10.03.09.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 09:15:51 -0700 (PDT)
From: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 0/2] drm/amd: fix HDMI output with non-HDMI EDID
 overrides
Date: Sat,  3 Oct 2026 18:15:06 +0200
Message-ID: <20261003161525.23600-1-johanneswueller@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Resend: my first attempt at sending v2 went out without any of the Cc
recipients, including the mailing lists. This is the same series,
unchanged. Sorry for the noise! I'm doing these for the first time.

This series lets amdgpu drive an HDMI display at its native resolution
when a non-HDMI EDID is injected via drm.edid_firmware or debugfs
edid_override.

The motivating case is a Dell U3011 (2560x1600) connected via HDMI,
whose native HDMI EDID only advertises CEA modes up to 1920x1080. By
injecting the monitor's DisplayPort EDID (which contains the native
2560x1600 mode), the correct resolution becomes available. However,
the injected EDID lacks an HDMI VSDB, so amdgpu treats the physical
HDMI connector as a passive HDMI-DVI dongle and rejects the required
pixel clock.

Patch 1 adds an edid_overridden flag to drm_connector, set by the
existing EDID override mechanisms in _drm_do_get_edid(), so that
drivers can detect when an override is in effect and adjust their
behavior accordingly, without duplicating the override mechanism.

Patch 2 uses that flag in amdgpu to trust the physical connector type
over the EDID when selecting the signal type.

Tested on AMD Ryzen 9 7950X (Raphael iGPU, DCN 3.1.5) with a Dell U3011
connected via HDMI and drm.edid_firmware=HDMI-A-1:<DisplayPort EDID>:
- amd-staging-drm-next at 53750a937420: the override EDID is loaded,
  but 2560x1600 is pruned from the connector's mode list.
- with this series applied: 2560x1600@60Hz RGB 8bpc works, alongside
  another Dell U3011 connected via DisplayPort in the same mode.

Changes in v2:
- Rebased onto current amd-staging-drm-next.
- Patch 2: follow the move of create_eml_sink() to
  amdgpu_dm_connector.c.
- Dropped "drm/amd: treat max_tmds_clock==0 as unconstrained": The
  return value of adjust_colour_depth_from_display_info() is no longer
  used to reject the stream, so the patch has no effect anymore.
- Dropped "drm/amd: fix force_yuv420/422_output being ignored": The
  flags were replaced by force_yuv_pixel_format.
- I am (hopefully) sending this version to the right people, since v1's
  cover letter only went to the lists. Please let me know otherwise!

v1: https://lore.kernel.org/amd-gfx/20260315223307.45807-1-johanneswueller@gmail.com/

Johannes Wüller (2):
  drm: add edid_overridden flag to drm_connector
  drm/amd: fix HDMI signal type for EDID overrides

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c  | 9 ++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c    | 9 ++++++++-
 drivers/gpu/drm/drm_edid.c                               | 2 ++
 include/drm/drm_connector.h                              | 8 ++++++++
 4 files changed, 26 insertions(+), 2 deletions(-)


base-commit: 53750a937420a01acf41bf74010557666f679aab
-- 
2.56.0

