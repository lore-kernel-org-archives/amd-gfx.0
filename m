Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67493C47DAC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F7C10E88E;
	Thu, 11 Jan 2024 09:04:29 +0000 (UTC)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
 by gabe.freedesktop.org (Postfix) with ESMTP id 62E7710E070;
 Thu, 11 Jan 2024 02:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=Min6HQZdPP4HIWPzo8
 E6GmraGnokuJZHOP0OMZ3zKh0=; b=iM3b7cxiG7g15xMQrddMpxGqs0tBY/caTn
 aBpbznq4wNTbZF27trQ1WrUzDMwLF/eO65X9U0ihTZEMeuQJ+O/+GR+K6MQHZFIc
 X+SdV1Ux4dAbGde0m9dW4L2XAZFF2uk4zXv7c2N2IDsvHTOJqajF5zHWbOui17lT
 GRvrDgNKU=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3P18VUJ9lgSucAA--.27798S2;
 Thu, 11 Jan 2024 10:19:01 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: airlied@gmail.com, Xinhui.Pan@amd.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, daniel@ffwll.ch
Subject: [PATCH] drm/amdgpu: Clean up errors in gfx_v9_4.c
Date: Thu, 11 Jan 2024 02:19:00 +0000
Message-Id: <20240111021900.6062-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3P18VUJ9lgSucAA--.27798S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWDZrWxuFW8uFW5XFyfCrg_yoWDZrX_C3
 yUtrnxur4q93Z2gF129w4rt34qqr9xZFZ7WF40ya4FkF1qq343K3srKrn3Xa18WFs3uF95
 A3Z0gF13ZwnrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRubk5UUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGAJixWVLZWLE5AABs1
X-Mailman-Approved-At: Thu, 11 Jan 2024 09:04:24 +0000
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
Cc: chenxuebing <chenxb_99091@126.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index bc8416afb62c..f53b379d8971 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -970,8 +970,9 @@ static void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_DSM_INDEX, 255);
 }
 
-static const struct soc15_reg_entry gfx_v9_4_ea_err_status_regs =
-	{ SOC15_REG_ENTRY(GC, 0, mmGCEA_ERR_STATUS), 0, 1, 32 };
+static const struct soc15_reg_entry gfx_v9_4_ea_err_status_regs = {
+	SOC15_REG_ENTRY(GC, 0, mmGCEA_ERR_STATUS), 0, 1, 32
+};
 
 static void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 {
-- 
2.17.1

