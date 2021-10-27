Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5154FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6E460F39
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F6E460F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C706E8A9;
	Wed, 27 Oct 2021 14:27:52 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC4089E63
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 14:27:51 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 82-20020a1c0055000000b0032ccc3ad5c1so4504280wma.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 07:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GqFANoanWXn6ovdg+1SbZfAAZF64NnBFCBChrTz/0Fs=;
 b=QaD/w9NQTL1LCso0Fs35pH/2kZeWOHaTy6FCb0hzpewWK6C/rjH8cbkt1B/KmKJPTS
 ZR8HcoamgkoDeGWLQxeewpDRbW+V2b4KIGKIdp7iWjeDJcCm5kioJGQI7zN7kRoUjAD3
 SNaNWRmRtZNaAtvL85nTMbsdUjTF81rp8/jsa6VN2dSZWnUadRbohl/gj4wo4NRZn3q4
 Q8J4WCN4MqSYSHaeL5vscHNNvvrCsspEP2YHGSiVnrZAeanCGzEG5oRUD5IIGKQ/VMhY
 M/LSlCqALheKeaXx0emFVPPLy1PiEv3g1QSXKYaYlDdYkozrssCts6ZvKwvzfc0tGZ0n
 cUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GqFANoanWXn6ovdg+1SbZfAAZF64NnBFCBChrTz/0Fs=;
 b=bstueto6shLfPv9BwFZVo8/wrcaR5EiTtyd4/jeFQOjqBxeCSAA8kNWYgy7Zfm5xFP
 Zi62fEwaHxGjPjsKTbuI1z7KRwsUeBVpnWPVDXKgv/g7gqIFK1zDcgCA40JeiZSOU1w4
 NDgAi8UpPVYuL8l+xlO8bv293hQjwT75uKnVfGNtEVkczoybY4/0AMj5aGJR4gsAWEfm
 ZyojYonMcFwvizQkKntT2nBcLP4FjM84PFSmxgAHJhY2f/Q5PQlKPCOmcutPsvYDjvHh
 INo/lAWI4VF2WQENpDHLLyulwqA6irG4YSU3TVxZhAWL+zFbArMpkVHrOgNAiKNjMr5s
 9Uwg==
X-Gm-Message-State: AOAM5307pFnMnNo6z8bpnZnrqc3+jz8dZoPf/pHcOKrEPoMWHO6BfZo8
 RDemVkmB7qrOR4Jf198CyinnmeaIrKEPWLvc
X-Google-Smtp-Source: ABdhPJzUkswp9SGRenKUuhjUeixZv/XLmQ0A67vhTzHWQPh/YVlrmFtVjNB37VumW+9DX73nm89ClA==
X-Received: by 2002:a1c:98c8:: with SMTP id a191mr6081438wme.84.1635344869441; 
 Wed, 27 Oct 2021 07:27:49 -0700 (PDT)
Received: from workstation.suse.de (81-229-85-231-no13.tbcn.telia.com.
 [81.229.85.231])
 by smtp.gmail.com with ESMTPSA id k7sm56998wrn.16.2021.10.27.07.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 07:27:48 -0700 (PDT)
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: tdwilliamsiv@gmail.com, alexdeucher@gmail.com, harry.wentland@amd.com,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Patrik Jakobsson <pjakobsson@suse.de>
Subject: [PATCH v2] drm/amdgpu: Fix even more out of bound writes from debugfs
Date: Wed, 27 Oct 2021 16:27:30 +0200
Message-Id: <20211027142730.1962-1-patrik.r.jakobsson@gmail.com>
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

v2:
	* Add missing fix in dp_max_bpc_write (Harry Wentland)

Fixes: 918698d5c2b5 ("drm/amd/display: Return the number of bytes parsed than allocated")
Signed-off-by: Patrik Jakobsson <pjakobsson@suse.de>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1a68a674913c..3655663e079b 100644
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
@@ -2386,7 +2386,7 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					   (long *)param, buf,
 					   max_param_num,
 					   &param_nums)) {
-- 
2.33.0

