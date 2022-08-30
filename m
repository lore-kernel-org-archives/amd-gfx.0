Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E29ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 17:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 571F710E2D8;
	Tue, 30 Aug 2022 17:29:36 +0000 (UTC)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E5B310E2D2;
 Tue, 30 Aug 2022 17:29:31 +0000 (UTC)
Date: Tue, 30 Aug 2022 17:29:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1661880569; x=1662139769;
 bh=7/DDxIV1Fo8yTklcn2N9EElotUVSHrvK4wKYJ/Ui2ig=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
 Feedback-ID:Message-ID;
 b=OTP5EeLBDiuCLg8enDNackduqRExDN0gZYBd4/+lrA/MXG88aKGEhfc/2SIfmWJvo
 HPCSN4IaIPXztp6iD5HDk0FV0sYYM51IKn1xfeihqYswjGz1d1WGN8gGttTcwUt3sI
 N1j13/eRQPw/hLbi4UHNu/7kjXEESOQL1GNK4qEnXljiQu+AheTDFlNfxHI9bl4A+X
 KgjrpQYiWVws1Mi00evRheDeF2P+KKU1nQ4scTJkJniq8Kov6g9yeyA7PGxQQm3bZk
 YCe1nPyu9JwHNjaoJrESudFkKvp48yfP7lOXp7EQ/DLbFT6yMCE+jMmdmSVqBTQm11
 S+mvWrPEDEUQg==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH v2 2/6] drm: document DRM_MODE_PAGE_FLIP_ASYNC
Message-ID: <20220830172851.269402-3-contact@emersion.fr>
In-Reply-To: <20220830172851.269402-1-contact@emersion.fr>
References: <20220830172851.269402-1-contact@emersion.fr>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: andrealmeid@igalia.com, daniel.vetter@ffwll.ch, mwen@igalia.com,
 ville.syrjala@linux.intel.com, alexander.deucher@amd.com, hwentlan@amd.com,
 nicholas.kazlauskas@amd.com, joshua@froggi.es
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a subset of [1], included here because a subsequent patch
needs to document the behavior of this flag under the atomic uAPI.

v2: new patch

[1]: https://patchwork.freedesktop.org/patch/500177/

Signed-off-by: Simon Ser <contact@emersion.fr>
---
 include/uapi/drm/drm_mode.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index fa953309d9ce..86a292c3185a 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -936,6 +936,13 @@ struct hdr_output_metadata {
 };
=20
 #define DRM_MODE_PAGE_FLIP_EVENT 0x01
+/**
+ * DRM_MODE_PAGE_FLIP_ASYNC
+ *
+ * Request that the page-flip is performed as soon as possible, ie. with n=
o
+ * delay due to waiting for vblank. This may cause tearing to be visible o=
n
+ * the screen.
+ */
 #define DRM_MODE_PAGE_FLIP_ASYNC 0x02
 #define DRM_MODE_PAGE_FLIP_TARGET_ABSOLUTE 0x4
 #define DRM_MODE_PAGE_FLIP_TARGET_RELATIVE 0x8
--=20
2.37.2


