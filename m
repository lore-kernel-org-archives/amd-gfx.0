Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BE5C3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 16:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9A110E30B;
	Mon, 15 Jan 2024 16:11:53 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E3010E035
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 16:06:38 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e7fce1abcso4555665e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 08:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1705334797; x=1705939597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2nfzXYtohis0OwCD+AmIl/qoZqPN5SyFIj+AeVDGrUY=;
 b=Vib1ZBP/CfjnsPKUneq3MhVGzPIEI7vK/Ip1teCt5rtjTfkszJoqZ2Dx6ykC+ReZB+
 yCPqJeUbID0JHxCM2GTzdUapMBh2q6MSiZyV+4B+u2ESmElJPIBZZljH/pMfN5/WYvlC
 QDAO2EnCGOlF6b2CBE6lmfWQQKHnCzeQN5NEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705334797; x=1705939597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2nfzXYtohis0OwCD+AmIl/qoZqPN5SyFIj+AeVDGrUY=;
 b=a60nBKliLwnNHSZhAzWJTsj50P8n0qWc97BqezhSvwMOaeBXhkcr8gB5i1IpBxPcjE
 g1qqmS6FDpdfGm9UghB2gRW2aFvm/vBxZQltI3Ez2nnv4HzCdT33JYrAwTkftnCAn7Jb
 tpkHEzXu3gRMxf5sl1AeXcxgStxf07tCwxVNpDjiiktEpMEArSFcQ4wyq/lRusf3rlyg
 IEDCaVX/KTzDil5PbfAamPIUuZtsClvIbt8sZdGHslT/BT1dmRMc4GyxoQjPgcN5fyWI
 Up0HxRYGnTOiNrDhqss5B4elkUgNdh6dJTr7/OQMsdtnhPKl6D1aAF1ZwXhbZK/D4K1f
 KGCQ==
X-Gm-Message-State: AOJu0YylaeyuePxwL0L2OJfLOxF0NY0zqhQmGNS6wNUIra9zvGPxQh4a
 gHorat/CrrlWZpaHLvIhLcgnvwvV2jeIeg==
X-Google-Smtp-Source: AGHT+IEUUc5iRjuXbMJ2dngkv+RJCZlkEQjqC7ossePXJRfMhg+lS/5kV7bU5iCCs/lMM5nEnzQUkw==
X-Received: by 2002:a7b:cbc7:0:b0:40e:6707:b758 with SMTP id
 n7-20020a7bcbc7000000b0040e6707b758mr2317948wmi.178.1705334796754; 
 Mon, 15 Jan 2024 08:06:36 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com
 ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c4f1600b0040d6b91efd9sm20174140wmq.44.2024.01.15.08.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 08:06:36 -0800 (PST)
From: Andri Yngvason <andri@yngvason.is>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: [PATCH v2 0/4] New DRM properties for output color format
Date: Mon, 15 Jan 2024 16:05:50 +0000
Message-ID: <20240115160554.720247-1-andri@yngvason.is>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Jan 2024 16:11:52 +0000
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
Cc: amd-gfx@lists.freedesktop.org, Simon Ser <contact@emersion.fr>,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Werner Sembach <wse@tuxedocomputers.com>, Andri Yngvason <andri@yngvason.is>,
 dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After some discussion, we decided to drop the "active color format"
property and rename the "preferred color format" property to "force
color format". 

The user can probe available color formats in combination with other
properties using TEST_ONLY commits.

v1: https://lore.kernel.org/dri-devel/20240109181104.1670304-1-andri@yngvason.is/

v2
 - Dropped "active color format"
 - Replaced "preferred color format" with "force color format"


Werner Sembach (4):
  drm/amd/display: Remove unnecessary SIGNAL_TYPE_HDMI_TYPE_A check
  drm/uAPI: Add "force color format" drm property as setting for
    userspace
  drm/amd/display: Add handling for new "force color format" property
  drm/i915/display: Add handling for new "force color format" property

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 67 ++++++++++++++++---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 ++
 drivers/gpu/drm/drm_atomic_helper.c           |  4 ++
 drivers/gpu/drm/drm_atomic_uapi.c             |  4 ++
 drivers/gpu/drm/drm_connector.c               | 48 +++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c       | 35 ++++++++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |  5 ++
 drivers/gpu/drm/i915/display/intel_hdmi.c     | 29 ++++++--
 include/drm/drm_connector.h                   | 16 +++++
 9 files changed, 190 insertions(+), 22 deletions(-)


base-commit: 052d534373b7ed33712a63d5e17b2b6cdbce84fd
-- 
2.43.0

