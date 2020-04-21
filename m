Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D511EC2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 06:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98DA206F4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 06:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98DA206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BABE6E8C6;
	Tue, 21 Apr 2020 06:59:31 +0000 (UTC)
Received: from m176115.mail.qiye.163.com (m176115.mail.qiye.163.com
 [59.111.176.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8B06E870
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 02:08:09 +0000 (UTC)
Received: from ubuntu.localdomain (unknown [157.0.31.122])
 by m176115.mail.qiye.163.com (Hmail) with ESMTPA id DF450664DB9;
 Tue, 21 Apr 2020 10:08:02 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Lyude Paul <lyude@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Bernard Zhao <bernard@vivo.com>,
 =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] amdgpu: fixes error branch not return errno issue
Date: Mon, 20 Apr 2020 19:07:50 -0700
Message-Id: <1587434874-123252-1-git-send-email-bernard@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587202042-115745-1-git-send-email-bernard@vivo.com>
References: <1587202042-115745-1-git-send-email-bernard@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSlVOTE5CQkJCTE5JS09PTFlXWShZQU
 hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mz46MRw4EjgxGgMvA0IzLE5K
 TyEKCjdVSlVKTkNMT0hPQ0NITUpNVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
 S1VISlVKSUlZV1kIAVlBT05CSDcG
X-HM-Tid: 0a719a7e090d9373kuwsdf450664db9
X-Mailman-Approved-At: Tue, 21 Apr 2020 06:59:30 +0000
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
Cc: opensource.kernel@vivo.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The "if(!encoder)" branch return the same value 0 of the success
branch, maybe return -EINVAL is more better.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

---
Changes since V1:
* commit message improve
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index f355d9a..1f8c6b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -474,12 +474,12 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 		/* need to find digital encoder on connector */
 		encoder = amdgpu_connector_find_encoder(connector, DRM_MODE_ENCODER_TMDS);
 		if (!encoder)
-			return 0;
+			return -EINVAL;
 
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 
 		if (!amdgpu_encoder->enc_priv)
-			return 0;
+			return -EINVAL;
 
 		dig = amdgpu_encoder->enc_priv;
 		new_coherent_mode = val ? true : false;
@@ -494,7 +494,7 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 		/* need to find digital encoder on connector */
 		encoder = amdgpu_connector_find_encoder(connector, DRM_MODE_ENCODER_TMDS);
 		if (!encoder)
-			return 0;
+			return -EINVAL;
 
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 
@@ -509,7 +509,7 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 		/* need to find digital encoder on connector */
 		encoder = amdgpu_connector_find_encoder(connector, DRM_MODE_ENCODER_TMDS);
 		if (!encoder)
-			return 0;
+			return -EINVAL;
 
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 
@@ -523,7 +523,7 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 		/* need to find digital encoder on connector */
 		encoder = amdgpu_connector_find_encoder(connector, DRM_MODE_ENCODER_TMDS);
 		if (!encoder)
-			return 0;
+			return -EINVAL;
 
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 
@@ -537,7 +537,7 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 		/* need to find digital encoder on connector */
 		encoder = amdgpu_connector_find_encoder(connector, DRM_MODE_ENCODER_TMDS);
 		if (!encoder)
-			return 0;
+			return -EINVAL;
 
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 
@@ -551,7 +551,7 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 		/* need to find digital encoder on connector */
 		encoder = amdgpu_connector_find_encoder(connector, DRM_MODE_ENCODER_TMDS);
 		if (!encoder)
-			return 0;
+			return -EINVAL;
 
 		amdgpu_encoder = to_amdgpu_encoder(encoder);
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
