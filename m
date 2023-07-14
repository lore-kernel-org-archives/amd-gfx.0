Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3237DEB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 07:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A34A310E7DD;
	Fri, 14 Jul 2023 07:16:17 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C8610E11D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 05:35:37 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R2Kv96JzdzBR9sN
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 13:35:33 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1689312933; x=1691904934; bh=gK7OprNNceFo1/5i9J6sc3labxZ
 QSM4pPR64BkZs428=; b=l7xv629ePLJGpQM3RAx01xvNGyOjVn+M9SN8p8cXPBV
 2nzy+d40AhZPhM8g4Lg++HheDAKIF+XMBo5DOjjFQS7+QNNoDk9rI7uwUnw3veLE
 8ebRbEQYmsuRo5uNjPh5WjX4JUCKpHRgs9nPh2diq/etCS+TfDLijdsV/YH16K2I
 tyW/cbp6hY6CjThf2sMts6x0YP4gPMAIyfk405Ds5eRDaSLblCU0o26mfDqw3MOK
 rMrmynSEOyQ6Q4fkzXLePRvQ8rA2fkIuIMU1kPn95s62VTYB2f6CrjzEBVXxy43P
 F3bAPwZ+NW9ljx1Hv/RDYpWK854X4YwhD6XTVAWrcuQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Wmo6erc4xGnR for <amd-gfx@lists.freedesktop.org>;
 Fri, 14 Jul 2023 13:35:33 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R2Kv9304TzBR7bB;
 Fri, 14 Jul 2023 13:35:33 +0800 (CST)
MIME-Version: 1.0
Date: Fri, 14 Jul 2023 13:35:33 +0800
From: shijie001@208suo.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/radeon: ERROR: "(foo*)" should be "(foo *)"
In-Reply-To: <tencent_16FACBDCDA61595C4219E185613C85C8BF0A@qq.com>
References: <tencent_16FACBDCDA61595C4219E185613C85C8BF0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <26d3424f83f1f394614e2a774d1bf1e9@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 14 Jul 2023 07:16:15 +0000
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

Fix one occurrence of the checkpatch.pl error:
ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  drivers/gpu/drm/radeon/uvd_v1_0.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/uvd_v1_0.c 
b/drivers/gpu/drm/radeon/uvd_v1_0.c
index 58557c2263a7..5684639d20a6 100644
--- a/drivers/gpu/drm/radeon/uvd_v1_0.c
+++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
@@ -142,7 +142,7 @@ int uvd_v1_0_resume(struct radeon_device *rdev)
      addr = (rdev->uvd.gpu_addr >> 32) & 0xFF;
      WREG32(UVD_LMI_EXT40_ADDR, addr | (0x9 << 16) | (0x1 << 31));

-    WREG32(UVD_FW_START, *((uint32_t*)rdev->uvd.cpu_addr));
+    WREG32(UVD_FW_START, *((uint32_t *)rdev->uvd.cpu_addr));

      return 0;
  }
