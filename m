Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91E0CDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 07:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5145210E5C2;
	Fri, 13 Oct 2023 07:19:11 +0000 (UTC)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7DAD410E582;
 Fri, 13 Oct 2023 01:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5Tz6+
 l/Q7+gJHUeIVALmKaMD4X5CcMraadvh54wQsoc=; b=WHxvWJ2BWOQp3LI1ZmB2S
 av1mDSUnP9JWp0HX8NL1YhFI6gjTt47Pip0ahqsXo8Lm2y7jWDu5U2A7wWmAidWa
 iPsVUThkLvZOQhN4c0GJDTObTQG4p1PK5J7VzqMbRPI3wayvSyv8OCfS9Yd51H3u
 EaytMOawdDyZGsC/TYpNiY=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
 by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wDHr60poyhlbuSdAQ--.16620S4;
 Fri, 13 Oct 2023 09:53:53 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, guchun.chen@amd.com,
 yifan1.zhang@amd.com, Tim.Huang@amd.com, make_ruc2021@163.com,
 zackr@vmware.com
Subject: [PATCH] drm/amdgpu/vkms: fix a possible null pointer dereference
Date: Fri, 13 Oct 2023 09:53:43 +0800
Message-Id: <20231013015343.290456-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHr60poyhlbuSdAQ--.16620S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruryxAF1xKr43KFW5ZryUtrb_yoWftrg_uF
 W8Xrn3Zw43ZF10vr17Zw4fZwn0yF15Za1kGr1Sva9av3sFva17XryDtrn5X3WxuF17CFnr
 X34jgr13A3ZrCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKpnQ7UUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFR0IC2B9ofy3QAAAs8
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In amdgpu_vkms_conn_get_modes(), the return value of drm_cvt_mode()
is assigned to mode, which will lead to a NULL pointer dereference
on failure of drm_cvt_mode(). Add a check to avoid null pointer
dereference.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 7148a216ae2f..db6fc0cb18eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -239,6 +239,8 @@ static int amdgpu_vkms_conn_get_modes(struct drm_connector *connector)
 
 	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
+		if (!mode)
+			continue;
 		drm_mode_probed_add(connector, mode);
 	}
 
-- 
2.37.2

