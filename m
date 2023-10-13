Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF5ACDB483
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 07:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B752A10E5C0;
	Fri, 13 Oct 2023 07:19:09 +0000 (UTC)
X-Greylist: delayed 916 seconds by postgrey-1.36 at gabe;
 Fri, 13 Oct 2023 02:24:35 UTC
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6F57810E586
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 02:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=l7hzr
 lfLhpSLoZQc2BwbgrP4SPxkiJtn7f4bO6Xpa44=; b=h4ip7ZIxibWNomTfIzriV
 DYVi2p5AoTrOvtWCQlRgORTK1YcGAbVofGE375knqtTq6GbJQRHwZfs43psyC391
 Q6o/uTXAEcihCeIetA+32WNoPkHnKilUIz0nJevdSFXOvurSNV7lyaxi4Clj7Yxk
 O/AXKbTL4VwJGofdru296Q=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
 by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wD337u6pihlYTiWAQ--.28260S4;
 Fri, 13 Oct 2023 10:09:07 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/radeon: fix a possible null pointer dereference
Date: Fri, 13 Oct 2023 10:08:57 +0800
Message-Id: <20231013020857.372163-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD337u6pihlYTiWAQ--.28260S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruryxAF1xKr43KFW5WF4fGrg_yoWfZFX_uF
 yvqa9rXa909asYvF17u3Z3Zr9I93y0yw4ktF1xta4S93s2qF1fGFy3tF1rZw47Xay5AFn8
 J34rK3W3Ar4xGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKfOzJUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyBAIC1p7MIObKgABs5
X-Mailman-Approved-At: Fri, 13 Oct 2023 07:19:07 +0000
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
Cc: Ma Ke <make_ruc2021@163.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In radeon_add_common_modes(), the return value of drm_cvt_mode()
is assigned to mode, which will lead to a NULL pointer dereference
on failure of drm_cvt_mode(). Add a check to avoid null pointer
dereference.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index d2f02c3dfce2..9f7d8ab980e6 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -520,6 +520,8 @@ static void radeon_add_common_modes(struct drm_encoder *encoder, struct drm_conn
 			continue;
 
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
+		if (!mode)
+			continue;
 		drm_mode_probed_add(connector, mode);
 	}
 }
-- 
2.37.2

