Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D660DC433E1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 15:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDA7206DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 15:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGbFxcEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDA7206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4A66E931;
	Fri,  5 Jun 2020 15:34:47 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD6E76E931
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 15:34:46 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id w3so10072880qkb.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jun 2020 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pvUDcOVZ9qMpaeSTSDY8PmdR1ZA44oS6ztSNDdZWX+k=;
 b=NGbFxcEA3hnZP1QOzw2dgbiRcgga2jnCXJx8qjxhhcQFPd/rpHFLlCNRhcYc7xuOuk
 c0KUf6lmZtCYmSfb5El4amj5ceMwNqoP0A9SICsjsOjDF88Qkg1uiD0xgY0FOcfFlfor
 mzPSgv8Lf2G1amTVQRp0tIroIrce+D/evkTVB6fPG3J/zI4Uu+aNXS7WbfwqCKSn2bBy
 cF+Il1VyFOJk4FcSXk002/atCyA3xeB4a6g9abgYPpXIw6zwebUZAq/9S75Jrbnlcsb0
 zpKrAE/gX0e2fmzO2F81eO6wV9cJjzsTnlBg9adM6X6sVpFc9vo6GIWZdjQIKsPxwunr
 pIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pvUDcOVZ9qMpaeSTSDY8PmdR1ZA44oS6ztSNDdZWX+k=;
 b=rGqo8mHbhLPfEcyo1E1m0AD/uS8qcJ0LdJpoxK2PJ1C3aHFp/b8Q4VZ4UqgcLoDZID
 rhfBU3nzNB7PZySiWbAwjirvoH66UsahQfI/2IoyjBCIDc6THjLRLLjdXq+hqJlKG6uy
 x1EWfMRXxQXZ7fzvSJ/ex0IgayzxFFJEKhz1MICwmzMR4NDpznk68m41lDB+WMqfnGUc
 6ujD6t69MBjUYzw5kuUF3ypP3PxC0N2qG19cr13I8lwjL3xzFN41tmLFDPPty4l7M5Tx
 QbYQ/V/yFqWgl0BVXZeBnb38iA2UR6HJ4t6yQXXBo1ZKwTTc6f9VJ7wpUSf/lCJftcv7
 YyCA==
X-Gm-Message-State: AOAM533xPeABjzOO7xIY85NzfWZn8t389voGzdcEjVbml66yURuIa0+U
 LpIdIQ6hbpbmjCkySNGAgCjjKfW/
X-Google-Smtp-Source: ABdhPJzLDj6yqu1fdVJ1CG2HcKZVpPNxv6zOinMHKKyodpKjFIvKX6yoYMUY1EzoX6ShkIAdZhgMLw==
X-Received: by 2002:a37:a09:: with SMTP id 9mr10691515qkk.84.1591371285695;
 Fri, 05 Jun 2020 08:34:45 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id c201sm77764qkg.57.2020.06.05.08.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:34:45 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/soc15: fix using ip discovery tables on renoir
Date: Fri,  5 Jun 2020 11:34:32 -0400
Message-Id: <20200605153432.83159-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The PWR block moved into SMUIO, so the ip discovery table
doesn't have an entry for PWR, but the register has the
same absolute offset, so just patch up the offsets after
updating the offsets from the IP discovery table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 623745b2d8b3..21f29685f158 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -670,7 +670,7 @@ static uint32_t soc15_get_rev_id(struct amdgpu_device *adev)
 
 int soc15_set_ip_blocks(struct amdgpu_device *adev)
 {
-	int r;
+	int r, i;
 
 	/* Set IP register base before any HW register access */
 	switch (adev->asic_type) {
@@ -686,6 +686,10 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 				DRM_WARN("failed to init reg base from ip discovery table, "
 					 "fallback to legacy init method\n");
 				vega10_reg_base_init(adev);
+			} else {
+				/* PWR block was merged into SMUIO on renoir */
+				for (i = 0 ; i < HWIP_MAX_INSTANCE; ++i)
+					adev->reg_offset[PWR_HWIP][i] = adev->reg_offset[SMUIO_HWIP][i];
 			}
 		}
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
