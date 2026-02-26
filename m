Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BB5FCE085
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 13:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09CBB10E955;
	Thu, 26 Feb 2026 13:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RMekyBs7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A1E10E85B;
 Thu, 26 Feb 2026 03:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772074918; x=1803610918;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fXiqbnsskQzssrhJsmRaWZ7ZTaOaC057lWgLPTfrR3M=;
 b=RMekyBs78HnK1OU4rIsKBdySLYlrwYLr9K11fGck4w0MspBGOUVrjW57
 9PtKLkKu9LekwX+tGYzfa8tC7JFm51Vrf/L4OhMgvU2lv838wDhoW0zhq
 Rnlg7x47vdNQ7MgdxvVPTZPMWFvfITVLN5zX5VsN8y7CeWKp+mToO0P6F
 z8t5TKTeyM/e6PCDCyDsCMjsTqjnF3NVGJ49haUVDe9YiD+qXFhSBT7qW
 lny2xgMHJHyNellTKSpcdERftQ3Ycwpu1MpaGtXl09oGd8/VTXYNnpVNi
 tGX6VZGC7g2jAzleUq/64vjcXuQk20ZDc80NQpUfpoSiYi0VMfYPRCn1/ A==;
X-CSE-ConnectionGUID: dIfD8DD2SXq8E0JxXo/0kw==
X-CSE-MsgGUID: qkUaxueHQUSCcmqBO3Mx+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="72160392"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="72160392"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:01:57 -0800
X-CSE-ConnectionGUID: T60CfZXfQeuaL5+HQFuayw==
X-CSE-MsgGUID: QSXSv/JkSn+q0nQ58gpQZQ==
X-ExtLoop1: 1
Received: from x299.sh.intel.com ([10.239.159.77])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:01:50 -0800
From: Yujie Liu <yujie.liu@intel.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Asad Kamal <asad.kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Gangliang Xie <ganglxie@amd.com>, Candice Li <candice.li@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Subject: [PATCH 3/7] drm/gma500: fix kernel-doc warning for framebuffer
 init/create functions
Date: Thu, 26 Feb 2026 11:00:34 +0800
Message-ID: <20260226030038.1182961-4-yujie.liu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226030038.1182961-1-yujie.liu@intel.com>
References: <20260226030038.1182961-1-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Feb 2026 13:55:07 +0000
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

Warning: drivers/gpu/drm/gma500/framebuffer.c:34 function parameter 'info' not described in 'psb_framebuffer_init'
Warning: drivers/gpu/drm/gma500/framebuffer.c:101 function parameter 'info' not described in 'psb_user_framebuffer_create'

Fixes: 4a792c59203b ("drm/gma500: Pass along the format info from .fb_create() to drm_helper_mode_fill_fb_struct()")
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 drivers/gpu/drm/gma500/framebuffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index fe1f43f0abff..5263eff6e462 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -21,6 +21,7 @@ static const struct drm_framebuffer_funcs psb_fb_funcs = {
  *	psb_framebuffer_init	-	initialize a framebuffer
  *	@dev: our DRM device
  *	@fb: framebuffer to set up
+ *	@info: pixel format information
  *	@mode_cmd: mode description
  *	@obj: backing object
  *
@@ -91,6 +92,7 @@ struct drm_framebuffer *psb_framebuffer_create(struct drm_device *dev,
  *	psb_user_framebuffer_create	-	create framebuffer
  *	@dev: our DRM device
  *	@filp: client file
+ *	@info: pixel format information
  *	@cmd: mode request
  *
  *	Create a new framebuffer backed by a userspace GEM object
-- 
2.43.0

