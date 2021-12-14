Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C900AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 14:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508D310E48B;
	Tue, 14 Dec 2021 14:10:21 +0000 (UTC)
X-Greylist: delayed 448 seconds by postgrey-1.36 at gabe;
 Tue, 14 Dec 2021 14:02:35 UTC
Received: from smtpbg501.qq.com (smtpbg501.qq.com [203.205.250.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C3CD10E119;
 Tue, 14 Dec 2021 14:02:35 +0000 (UTC)
X-QQ-mid: bizesmtp46t1639489947t4knmgn0
Received: from wangx.lan (unknown [171.221.148.2])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 14 Dec 2021 21:52:19 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: eTtJes0duVuCV5I93GIB5ZyjA1+F5l2Dnf6qN24mxYOihzHztWcvdOgxEkCCa
 xz1TlrTAmtFmvsa8csE4t08n5PSZFY5PmMgyImpBqir0QDkeLuBClrnFH0HcxFArQ/5XG1H
 QTdrX0k+6hpRSWIecxKu5GlelLBat3YCEI9fTBJCp6nI05Jx1gSAkFFP1mpZIYlvEK7l9B9
 cGQtGI2mRNodkr7MHyBDQWWNTm33hhKZygr5phkqN15CQehSMJQv6AYpIYx5siCGFTc5XSY
 bZcIFptTIGFbZiJshCv4cP3bSLhOEWjsKT9efdu8J7U3mYGzQshagYGSlhbKZY3tjo9Pl5r
 Coo7DllVHSccTqgKsWe3Z0aHtse2A==
X-QQ-GoodBg: 0
From: Xiang wangx <wangxiang@cdjrlc.com>
To: airlied@linux.ie
Subject: [PATCH] drm/radeon: Fix syntax errors in comments
Date: Tue, 14 Dec 2021 21:52:17 +0800
Message-Id: <20211214135217.24444-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
X-Mailman-Approved-At: Tue, 14 Dec 2021 14:10:19 +0000
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
Cc: Xiang wangx <wangxiang@cdjrlc.com>, Xinhui.Pan@amd.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Delete the redundant word 'we'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/gpu/drm/radeon/radeon_vce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index 511a942e851d..ca4a36464340 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -513,7 +513,7 @@ int radeon_vce_cs_reloc(struct radeon_cs_parser *p, int lo, int hi,
  * @allocated: allocated a new handle?
  *
  * Validates the handle and return the found session index or -EINVAL
- * we we don't have another free session index.
+ * we don't have another free session index.
  */
 static int radeon_vce_validate_handle(struct radeon_cs_parser *p,
 				      uint32_t handle, bool *allocated)
-- 
2.20.1

