Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C6CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 13:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B8F60F39
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 13:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8B8F60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CABE8994A;
	Wed, 27 Oct 2021 13:03:35 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C26F38994A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 13:03:34 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id p14so4005818wrd.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=opxNXz1T3m3G3FCdwqeV3Dk6Y/bjIQjCisdv6eT1sgM=;
 b=KrnJvxdL65VMNDFlf31Pq3vg+JQoNrsu2dhZ8/Q3iFPRZ0rs/melgAmrkMozJmAWMc
 kvJlVdvOOA2Rly0GrQtiwvwZCAHr1WxM+PQ9rBMqie7RAPw4Zqi2p8OH/ki6urUgYyh2
 ey3eHlQPVplJgSabewLQIUOPH+KF8vb4WCAFJCuvfNmLwHn6D3ttwbUL4eU1Gfy+pu2o
 Dg3SIITotgMH+AiMjGlE856ec8sdhbp45XYkI5DoF9eHl0tdaleLq4HrUTRRCTQ+BJvY
 B0gqzHhDh9AXGW/39SeHKLQ4xplU0gwo6bwuFezzwX1S6JIKIYlV6twKgW+JKS8bEiu0
 oDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=opxNXz1T3m3G3FCdwqeV3Dk6Y/bjIQjCisdv6eT1sgM=;
 b=OSlHOmWG7gyr6pnS3jRd7LASF4Gs2QIdM5FUeO9hdDn7LNPvSJIMAb/tnmjrNqL70Q
 LNHYVp78FrVC3LrQf4z47JthDtaYhk3tPeccgFDaLIDzwLoJ2dJ+vgcHoUrSJYAoFWuR
 /waEeREN/RKctQRm8EHgelraM2+eu+rNztVYOIAOUd0GEKz6CFVvLHtTsAwIYLxbnFnu
 j8C1O8WDviXrwb5YPcYO+Rw6x1j7d0E6iPYggvlhfbHBCSW8k5MdZejt6i3+IBUgeaQ3
 eA81HyJjdr6VWmCZkH9NBbCZ7rkJIqogqWeEOtT1nlZ2aif1z5fvduLFcg/3y++LPOFo
 8xAA==
X-Gm-Message-State: AOAM533pkG+kQPnEmVvQ5kG9BUX+/KlZO9FG9eFQREhL6GnCLwFxLC1G
 Ti1FZU7Hs/VcvSlz6E53UBn2oxoCuxgl+Hzz
X-Google-Smtp-Source: ABdhPJzUdCGsgJpdeUxdQQ32wv5E7EMlcJhvrhZi3FW1VVzHKm/CbKdwUfwPSVDI41CBv51dJ5C4iQ==
X-Received: by 2002:adf:e709:: with SMTP id c9mr4746039wrm.78.1635339812692;
 Wed, 27 Oct 2021 06:03:32 -0700 (PDT)
Received: from workstation.suse.de (81-229-85-231-no13.tbcn.telia.com.
 [81.229.85.231])
 by smtp.gmail.com with ESMTPSA id b7sm3074740wrv.72.2021.10.27.06.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 06:03:32 -0700 (PDT)
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: tdwilliamsiv@gmail.com, alexdeucher@gmail.com,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Patrik Jakobsson <pjakobsson@suse.de>
Subject: [PATCH] drm/amdgpu: Fix even more out of bound writes from debugfs
Date: Wed, 27 Oct 2021 15:03:12 +0200
Message-Id: <20211027130312.28383-1-patrik.r.jakobsson@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
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

CVE-2021-42327 was fixed by:

commit f23750b5b3d98653b31d4469592935ef6364ad67
Author: Thelford Williams <tdwilliamsiv@gmail.com>
Date:   Wed Oct 13 16:04:13 2021 -0400

    drm/amdgpu: fix out of bounds write

but amdgpu_dm_debugfs.c contains more of the same issue so fix the
remaining ones.

Fixes: 918698d5c2b5 ("drm/amd/display: Return the number of bytes parsed than allocated")
Signed-off-by: Patrik Jakobsson <pjakobsson@suse.de>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1a68a674913c..33bdf15febc6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -491,7 +491,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 	if (!wr_buf)
 		return -ENOSPC;
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					   (long *)param, buf,
 					   max_param_num,
 					   &param_nums)) {
@@ -643,7 +643,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	if (!wr_buf)
 		return -ENOSPC;
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					   (long *)param, buf,
 					   max_param_num,
 					   &param_nums)) {
@@ -918,7 +918,7 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					   &param, buf,
 					   max_param_num,
 					   &param_nums)) {
@@ -1215,7 +1215,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 						(long *)param, buf,
 						max_param_num,
 						&param_nums)) {
@@ -1400,7 +1400,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1585,7 +1585,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1770,7 +1770,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1948,7 +1948,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
-- 
2.33.0

