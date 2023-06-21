Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4937EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 15:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A150810E4C6;
	Wed, 21 Jun 2023 15:38:50 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06EA410E3FA;
 Wed, 21 Jun 2023 08:10:49 +0000 (UTC)
Received: from uno.lan (unknown [IPv6:2001:b07:5d2e:52c9:1cf0:b3bc:c785:4625])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id A5036556;
 Wed, 21 Jun 2023 10:10:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1687335012;
 bh=w1iXcw/V3spckvEgKXCmL4tvJ5rQs45envQm9GmietU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lijEoFGnxbBm9UH+qEciP0O20xYkPzvcOmQZI9V7xuKhb0TOaQ1cL5nBuq8pcIRAd
 C6229VvyMxhIzx8qb5JiZiLKcVjaUHdpVoBrTO059t988qV8D8rufYJAURSi7+cpZR
 MXOBMtk2mcUkk5OIOA6JtlhslxhviA/IHEIubY3Y=
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [RFC 1/9] drm: Add 3D LUT mode and its attributes
Date: Wed, 21 Jun 2023 10:10:23 +0200
Message-Id: <20230621081031.7876-2-jacopo.mondi@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621081031.7876-1-jacopo.mondi@ideasonboard.com>
References: <20230621081031.7876-1-jacopo.mondi@ideasonboard.com>
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
 Alex Hung <alex.hung@amd.com>,
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

From: Alex Hung <alex.hung@amd.com>

A struct is defined for 3D LUT modes to be supported by hardware.
The elements includes lut_size, lut_stride, bit_depth, color_format
and flags.

Note: A patchset "IGT tests for pre-blending 3D LUT interfaces" for this
proposal is sent to IGT mailing list.

Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 include/uapi/drm/drm_mode.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 43691058d28f..3b40694259c7 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -854,6 +854,23 @@ struct drm_color_lut {
 	__u16 reserved;
 };
 
+/*
+ * struct drm_mode_lut3d_mode - 3D LUT mode information.
+ * @lut_size: number of valid points on every dimension of 3D LUT.
+ * @lut_stride: number of points on every dimension of 3D LUT.
+ * @bit_depth: number of bits of RGB. If color_mode defines entries with higher
+ *             bit_depth the least significant bits will be truncated.
+ * @color_format: fourcc values, ex. DRM_FORMAT_XRGB16161616 or DRM_FORMAT_XBGR16161616.
+ * @flags: flags for hardware-sepcific features
+ */
+struct drm_mode_lut3d_mode {
+	__u16 lut_size;
+	__u16 lut_stride[3];
+	__u16 bit_depth;
+	__u32 color_format;
+	__u32 flags;
+};
+
 /**
  * struct hdr_metadata_infoframe - HDR Metadata Infoframe Data.
  *
-- 
2.40.1

