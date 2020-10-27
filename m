Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C60C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 22:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F58221D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 22:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F58221D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 809A96E215;
	Tue, 27 Oct 2020 22:11:21 +0000 (UTC)
X-Greylist: delayed 568 seconds by postgrey-1.36 at gabe;
 Tue, 27 Oct 2020 22:11:19 UTC
Received: from svt-ETHLX-2.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9CA5D6E212
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 22:11:19 +0000 (UTC)
Received: by svt-ETHLX-2.amd.com (Postfix, from userid 0)
 id BE9EE1840151; Tue, 27 Oct 2020 18:01:50 -0400 (EDT)
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Add rev_id workaround logic for SRIOV setup
Date: Tue, 27 Oct 2020 18:01:48 -0400
Message-Id: <20201027220148.9543-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- When we are under SRIOV setup, the rev_id cannot be read
  properly. Therefore, we will return default value for it

Change-Id: I188d8e1b77f97c2eb29ef01aaf9ff9ea396a51c2
Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index e0048806afaa..04c152843601 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -53,8 +53,20 @@ static void nbio_v2_3_remap_hdp_registers(struct amdgpu_device *adev)
 
 static u32 nbio_v2_3_get_rev_id(struct amdgpu_device *adev)
 {
-	u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
+	u32 tmp;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* workaround on rev_id for sriov
+		* guest vm gets 0xffffffff when reading RCC_DEV0_EPF0_STRAP0,
+		* as a consequence, the rev_id and external_rev_id are wrong.
+		*
+		* workaround it by hardcoding the rev_id to 0,
+		* (which is the default value)
+		*/
+		return 0;
+	}
 
+	tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
 	tmp &= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
