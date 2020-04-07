Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37353C2BA1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 18:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0079720768
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 18:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="YtVBKm45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0079720768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aurabindo.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EFF26E8CC;
	Tue,  7 Apr 2020 18:30:02 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E7B89F38
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 18:26:24 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id i186so428028qke.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Apr 2020 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tIzZDxt4owy5jO/YbfXWS31RiPx2ETthbOiAb1EV9P4=;
 b=YtVBKm457AxFLluMcN6Nh5lxMwkhKLfQcFmIzF16UjpYwbi574i9IUsdKd+i1y8jEZ
 QO7YgInPHWArXiIBcjFTESZaFPpm/XZUbS9LyoPsfi1H5/izGjt26qENa5Ffhy2rpsAf
 kRbqe9ODSQeEpnL+6EleAyr9WmqvD6gXi++mPr+wsYADbd9cXnt4oPEXFO3pqcvfrQ3x
 X6hUV8VWzIz1RB8h0egnBjFrOPNp5ewI4jMMUYtXnxzdx1hqS4quXLMc1USlubqy7332
 HSu19PvLsoWcJkcu6IrFEeYVF9yuwTMSCOnTnl7maeVFD3V58yJZBio0R7w8JP8TRr3Y
 NOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tIzZDxt4owy5jO/YbfXWS31RiPx2ETthbOiAb1EV9P4=;
 b=PTQrIcnNaGG0hPn3bs03dtX9ljR9WgnLMZRk8+9CwNeSf6hPnJHlrZd/R8+8J84WzL
 rlXQY8d5mvXcH5TqN1bbSGNGzhtonuXejKQakbfsNc2y3ILdoCMkTB38t9VatFG3ktcw
 3IxHnoTgziFVdIPe+0EbRt/48VWiBcKCMFwiFlfOqT0TO6PooWwzUwRQKKmtlrx+vqaP
 zFjygfgUMuXhDpcabyGMXDE+23d9bH8nltw1SpyJ3mYm7UL63KeGul9YlNxdUC2IOb4a
 s40TT+Rm/qUu1XY0bL59slhnIw3TBJ14nzXjExhw4M68O7377MgIBa7Qegj4vXEyZXfY
 lj+g==
X-Gm-Message-State: AGi0PubhVd3BAN9ootTcvZWHbgSdaUJroUnZpgWwN3Uo0+9lwC6A7Zzz
 Rh+gvcZJh0IsEu138gH1CnSPbw==
X-Google-Smtp-Source: APiQypI8YWAgQPWSYcS57KN14S6Q6DPtZWqlj+0qOHI2e6co5FZjn/hZaZ4asuloc3R4ftyLEEuEsA==
X-Received: by 2002:a37:6356:: with SMTP id x83mr3757099qkb.339.1586283984192; 
 Tue, 07 Apr 2020 11:26:24 -0700 (PDT)
Received: from localhost.localdomain (135-23-249-169.cpe.pppoe.ca.
 [135.23.249.169])
 by smtp.gmail.com with ESMTPSA id f1sm16232830qkl.72.2020.04.07.11.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 11:26:21 -0700 (PDT)
From: Aurabindo Pillai <mail@aurabindo.in>
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com
Subject: [PATCH] amdgpu_kms: Remove unnecessary condition check
Date: Tue,  7 Apr 2020 14:26:18 -0400
Message-Id: <20200407182618.2488-1-mail@aurabindo.in>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 07 Apr 2020 18:30:01 +0000
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
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Execution will only reach here if the asserted condition is true.
Hence there is no need for the additional check.

Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 60591dbc2..9fedfa531 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -179,12 +179,10 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	/* Call ACPI methods: require modeset init
 	 * but failure is not fatal
 	 */
-	if (!r) {
-		acpi_status = amdgpu_acpi_init(adev);
-		if (acpi_status)
-			dev_dbg(&dev->pdev->dev,
-				"Error during ACPI methods call\n");
-	}
+
+	acpi_status = amdgpu_acpi_init(adev);
+	if (acpi_status)
+		dev_dbg(&dev->pdev->dev, "Error during ACPI methods call\n");
 
 	if (adev->runpm) {
 		dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
