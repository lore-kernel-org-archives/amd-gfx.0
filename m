Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE45C83F17
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B7E10E7F1;
	Wed, 23 Jul 2025 15:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hFMiAyKC";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D5D10E806
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:28 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-45629702e52so32430825e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286307; x=1753891107; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYtFo7gaxKF9/CTK4az4/RM75UBugJj5vvo9hBR2vlQ=;
 b=hFMiAyKCS+WkGq7gEqz94o//sP+jvP6lxOkpjbkAHqguVjM99EKAiwIy1zbh3nwR/R
 Q65mZk02ucANzXrrDTSG8KS/HYoZVGc3nasZOD1pfJeqfv1PzqcR9WhgeomsrZoWkew3
 ZYSUk0HehDEtZNNHq1WiDdkM6wahEu+p5s3OMXpr64IeecGZmznfw8ZY6sgf6JQh/rd3
 HRe39Doew0h5S+Y7BNUWgZWZuUSh2k+vdQmdXwSkwWqsoA0a5a9SBN3eZcegFbUgHMWR
 h5nlA2FRDLxEYLsRmR1nq9l6Az3IZyR5pOOCam6D4UhIZ3hrAxOfBP3RfJyiUoIC/bty
 G5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286307; x=1753891107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYtFo7gaxKF9/CTK4az4/RM75UBugJj5vvo9hBR2vlQ=;
 b=TLtnekiyNGlb2T/k/N1c5zjXiotX2sUlvMaJlJZAVRjFFsXvETuVsBCMBp5Nb2f4kf
 XPS/96eyIwdDSKZk9BXSGUUZyv3NaOoorXgxMYfiwSuiqu9YuPHb1fK4HSLtWL5Dn9RP
 s2GZs10yNOEvVi2m7cBr0Ua+dgq9od5BPdC08pZ05o0obvvdoL/viANrP/HRTPBIgM5i
 lnXR50g2P7I6TFpoWzz5Wmg1P+X8yUlY7E019GsVsyFpZqptfG5cHDpAc+pE8IM2jXKV
 ToSKnTMIHAy4X10Jbruu+MKDHpWCX1Uf4d0qSd7yeHDJNVduecjV4gQnL6InKesei+ln
 iSTw==
X-Gm-Message-State: AOJu0YwNAChzPwQRLsle/9lC+XOu8rfC63bq8WnOpVUnfk1+UhsevLBQ
 GzKIAJCVASC8kDg/5w038S0IRjXBWTXCLGBfMXpwvpmKd/aJ9T0dJCpfnzqHCw==
X-Gm-Gg: ASbGncsb7aH1+HT4bqFQO78NF4sM5CyUo9um+i9ZnT5CuT5HzDcNZo2qZG3bT5+cKK5
 D44AdmqKAibUy5rDVJtF12CpB68AzakQenlSaGWpBjLwxOiNeg/Y23bjpYOLlIOPsFKfZuhCk9D
 CpLq2btHAJ1XNDgbleszQvn1QGrvTUujV4Z8JH+IM39WJhbUMD7hnNkW+kkKx7Z7GQz2t6eth1F
 wAwPnPJYbyeFuQnRoPBQG8E0AXn1aR/yOh7BsITsqad/8JAfWxf5Q8iSym9VYGx4BKxOnl245rW
 +cKsUq9oMUnQ8gvm6Svjat6WmQAC7ghSd4PvmUgcUOAIJzfdAXCmrR7/NggRP+1GkG23w5HIhHt
 OKUie9ZxQAmkGK8xDGTpi9I3VEBcie9VeKilpNXo1yDGgs36YLMsQkPp/LZaw4REmRMUd8bXQ2c
 UNDY/n/aU4KWuhO2PDah+WW+vT3A==
X-Google-Smtp-Source: AGHT+IGki7a6WPs8zHSdCKhvG1KDp/LQSw6jQutft4YnnpqynnuCbcNROBme2WOAXzyt2hQ3tdsaXA==
X-Received: by 2002:a05:6000:290a:b0:3b5:e077:af24 with SMTP id
 ffacd0b85a97d-3b768caffa7mr3170474f8f.14.1753286306703; 
 Wed, 23 Jul 2025 08:58:26 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:26 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 08/20] drm/amd/display: Don't try to enable/disable HPD when
 unavailable
Date: Wed, 23 Jul 2025 17:58:01 +0200
Message-ID: <20250723155813.9101-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGA connectors don't have HPD (hotplug detection), so don't
touch any HPD related registers for VGA.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index c7d13e743e6c..1bb8a9bc673b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -758,6 +758,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	int max_param_num = 11;
 	enum dp_test_pattern test_pattern = DP_TEST_PATTERN_UNSUPPORTED;
 	bool disable_hpd = false;
+	bool supports_hpd = link->irq_source_hpd != DC_IRQ_SOURCE_INVALID;
 	bool valid_test_pattern = false;
 	uint8_t param_nums = 0;
 	/* init with default 80bit custom pattern */
@@ -849,7 +850,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	 * because it might have been disabled after a test pattern was set.
 	 * AUX depends on HPD * sequence dependent, do not move!
 	 */
-	if (!disable_hpd)
+	if (supports_hpd && !disable_hpd)
 		dc_link_enable_hpd(link);
 
 	prefer_link_settings.lane_count = link->verified_link_cap.lane_count;
@@ -887,7 +888,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	 * Need disable interrupt to avoid SW driver disable DP output. This is
 	 * done after the test pattern is set.
 	 */
-	if (valid_test_pattern && disable_hpd)
+	if (valid_test_pattern && supports_hpd && disable_hpd)
 		dc_link_disable_hpd(link);
 
 	kfree(wr_buf);
-- 
2.50.1

