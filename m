Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD74EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 15:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6FD10E4BE;
	Wed, 21 Jun 2023 15:38:48 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A148710E3F9;
 Wed, 21 Jun 2023 08:10:48 +0000 (UTC)
Received: from uno.lan (unknown [IPv6:2001:b07:5d2e:52c9:1cf0:b3bc:c785:4625])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D77F510A;
 Wed, 21 Jun 2023 10:10:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1687335010;
 bh=Hbr+RKqfhbJQ+nkVEm6ASUtLSzb4vRzDpeqBiTu74Uc=;
 h=From:To:Cc:Subject:Date:From;
 b=Ka47U7sYq8LTI/9eb8Yld6aGmYH+a8HD3wvnJXNKCpQi0PdaF53FmBP2lwSvkrEOt
 Xr3PSqCYvdCVdb4KR/6Atiq+4LI+2UXoa8UUs/q/+YPHR1slAymZV6Ix1Ud9jvlJyq
 sLZ06sNCZ5BAUnx0RIVHudF1lR26hRyL/MITQ+CM=
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [RFC 0/9] drm: rcar-du: cmm: Enable 3D LUT support
Date: Wed, 21 Jun 2023 10:10:22 +0200
Message-Id: <20230621081031.7876-1-jacopo.mondi@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Jun 2023 15:38:42 +0000
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
Cc: Victoria Brekenfeld <victoria@system76.com>,
 DRI Development <dri-devel@lists.freedesktop.org>, mdaenzer@redhat.com,
 airlied@gmail.com, aleixpol@kde.org, Rodrigo.Siqueira@amd.com,
 amd-gfx@lists.freedesktop.org,
 wayland-devel <wayland-devel@lists.freedesktop.org>,
 =?UTF-8?q?Jonas=20=C3=85dahl?= <jadahl@redhat.com>,
 Uma Shankar <uma.shankar@intel.com>, harry.wentland@amd.com,
 tzimmermann@suse.de, sunpeng.li@amd.com, maarten.lankhorst@linux.intel.com,
 Sebastian Wick <sebastian.wick@redhat.com>, mripard@kernel.org,
 Melissa Wen <mwen@igalia.com>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>, Simon Ser <contact@emersion.fr>,
 Xinhui.Pan@amd.com, xaver.hugl@gmail.com, linux-renesas-soc@vger.kernel.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello, this series is based on the RFC sent by Melssa Wen:
"[RFC PATCH v2 00/18] Add DRM CRTC 3D LUT interface"
https://lore.kernel.org/dri-devel/20230109143846.1966301-1-mwen@igalia.com/
that introduces CRTC properties to control 3D LUT operations.

The R-Car DU peripheral has a post-blending color management pipeline (CMM)
composed by (in order of processing) a 3D LUT a 1D LUT and a Color conversion
unit.

The CMM driver already supported operating the 1D LUT, this series add support
for the cubic LUT (named CLU).

I've been made aware by Melissa and Pekka that the focus of upstream for
color management properties is now on the definition of the "Plane color
pipeline" properties
https://lore.kernel.org/dri-devel/QMers3awXvNCQlyhWdTtsPwkp5ie9bze_hD5nAccFW7a_RXlWjYB7MoUW_8CKLT2bSQwIXVi5H6VULYIxCdgvryZoAoJnC5lZgyK1QWn488=@emersion.fr/

Unfortunately the model there proposed doesn't match the R-Car DU hardware which
has color management at the post-blending level and not per plane (I've cc-ed
all the receivers of that series, just in case).

The user-space interface has been validated with dedicated unit tests for
the R-Car DU test suite (kms-test) which are available at:
https://git.sr.ht/~jmondi_/kms-test

The series validates the usage of the HW interface in the hope of re-starting
discussions and interests in the definition of CRTC color management
properties.

Thanks
   j

Alex Hung (1):
  drm: Add 3D LUT mode and its attributes

Jacopo Mondi (1):
  drm: rcar-du: crtc: Enable 3D LUT

Kieran Bingham (2):
  drm: rcar-du: cmm: Provide 3D-CLU support
  drm: rcar-du: kms: Configure the CLU

Laurent Pinchart (1):
  drm: rcar-du: cmm: Refactor LUT configuration

Melissa Wen (4):
  drm/drm_color_mgmt: add shaper LUT to color mgmt properties
  drm/drm_color_mgmt: add 3D LUT props to DRM color mgmt
  drm/drm_color_mgmt: add function to create 3D LUT modes supported
  drm/drm_color_mgmt: add function to attach 3D LUT props

 drivers/gpu/drm/drm_atomic_state_helper.c |   7 ++
 drivers/gpu/drm/drm_atomic_uapi.c         |  24 ++++
 drivers/gpu/drm/drm_color_mgmt.c          | 113 +++++++++++++++++++
 drivers/gpu/drm/drm_fb_helper.c           |   5 +
 drivers/gpu/drm/drm_mode_config.c         |  21 ++++
 drivers/gpu/drm/rcar-du/rcar_cmm.c        | 127 ++++++++++++++++------
 drivers/gpu/drm/rcar-du/rcar_cmm.h        |  36 +++++-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c    |  68 +++++++++---
 include/drm/drm_color_mgmt.h              |   7 ++
 include/drm/drm_crtc.h                    |  32 +++++-
 include/drm/drm_mode_config.h             |  25 +++++
 include/drm/drm_mode_object.h             |   2 +-
 include/uapi/drm/drm_mode.h               |  17 +++
 13 files changed, 428 insertions(+), 56 deletions(-)

--
2.40.1

