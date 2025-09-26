Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4388CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 546C010EABD;
	Fri, 26 Sep 2025 18:02:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MSbw3aJm";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C564510EABD
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:02:57 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b54dd647edcso2194517a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909777; x=1759514577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZZESGXiSy3qq2ewlAicH5hEKxGj+v2cGtwiytqFtcg=;
 b=MSbw3aJmqba+fLTVSfv/uEUJ0wn0veV31roE/d6BV+Iu/LgC2Gi5i4ZkcKHQT3oHAa
 u64F5tCTRv+7Bu56fuSdZrtmCB7BHKlpFLx5SBaZmqCPr13J+50qAB8T2OTJi25aAcVj
 Ff6A1yYRWTwEp/zG5AF2Z5/cvR6uL4y8036dBQSko8Lnw/wAA493ZBQK4HPeQQeJx4zE
 TaCy72VGf2G2XgJZ7LWriUcAVnNFcUsGluVj9Sf7fopKLj6isgohyuLsmVOcZCc5KbDB
 8GUqJ7jfmrJJ5k1N5uKtWq3i4Aka92SQLoajkJpOiYLQHKiNpAVGruKK9ENqgbXu2OqU
 vTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909777; x=1759514577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZZESGXiSy3qq2ewlAicH5hEKxGj+v2cGtwiytqFtcg=;
 b=lIFMMSh+Mqbr5mwceNLzknqRBH58VP9sOxZ2eIAd5QOr7tjoYrAThLL8S3/B14TKkJ
 6JLXOxj3sf76NeqjKrO36KCenbjpBaTnnWbvG0+mxUKLqDQv9UiIDFR5NdosYg3ni31q
 sPe+uLNKJoD2tQXqGqCblYJ9jiCdrFJ/cDtSapbA/wfFGcah/CauHnNXRHS019Xe5qVi
 FUoioBLks8+YTh/X6eKsUW8WXD3uX3pXVlbFas4nJVBml1FV72obPEI9rpuqK27oHbzP
 tuO1ZyA6LGveIpLIrjJVJMN23msuXNhpLSSCe30cnqCORnhfru3gYMlYq0s+ImP/EHEj
 PCcA==
X-Gm-Message-State: AOJu0YwY1S2RWHTcLAJayKtepbBc5fAXILoXhCZq9YH4P2U92kIcIs/F
 cKgKT2zjHt9R39iv+eIF+aTfPA4JVlU90l+h3kqbhTmBKdwUuntDqMZaC3qXgQ==
X-Gm-Gg: ASbGnct8tXRDDB0HGYBU3T+apy/UJ9kgVWqYUGGrOk4cqTP/90jZknfXerQ3n+zg4b9
 Vs610hZqb2TeRyp9puuAJNY0A2Y8Mv1cHHBEB0U3e6RUMsYYljr1QZjMasmOT6EWzJlaqYvAl4U
 exHQD0t510E7i3FJO080EuQK32XJEjikRxxsRhBqDSl0pF4zK1P6ztNsjMLrBbrrTIX5PX2g48s
 aCn3ZwKJH3DPZQhmuUo6yU9crrVSgMI6Jn8QGYDaJhVjx5uMFGkH986X9qhbU2rsKH/KwMwXkmv
 x8u63mwF4Nls3CkxuG0ub72sk6WFi2QGsGBGLZAIBsaDojzrFxjAswQkIoFrg6FRWfxl9jO0+6E
 ePWbwCg6RP9LaGr2n0Q8FjLeNj5iUDArwy8dDxX6ytXsHSVXWhYF4PMdqn1e9H7hreXF3Dpp8Al
 tyxy/8+OT9NfRNpQXF8QffE4xB7r6jzg==
X-Google-Smtp-Source: AGHT+IE01EWAW6C1AsE64ZLwFozEpRZa6dFO3IWPJhM85saDMeW5DvyKsxyPvqI9B49fvpoKm4bAlg==
X-Received: by 2002:a17:903:3843:b0:264:7bf5:c520 with SMTP id
 d9443c01a7336-27ed4a56b3bmr85793855ad.44.1758909777250; 
 Fri, 26 Sep 2025 11:02:57 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:02:56 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 08/23] drm/amd/display: Don't try to enable/disable HPD when
 unavailable
Date: Fri, 26 Sep 2025 20:01:48 +0200
Message-ID: <20250926180203.16690-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
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

Determine whether hotplug detection is available by checking that
the interrupt source is invalid.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index f263e1a4537e..cb4bb67289a4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -759,6 +759,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	int max_param_num = 11;
 	enum dp_test_pattern test_pattern = DP_TEST_PATTERN_UNSUPPORTED;
 	bool disable_hpd = false;
+	bool supports_hpd = link->irq_source_hpd != DC_IRQ_SOURCE_INVALID;
 	bool valid_test_pattern = false;
 	uint8_t param_nums = 0;
 	/* init with default 80bit custom pattern */
@@ -850,7 +851,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	 * because it might have been disabled after a test pattern was set.
 	 * AUX depends on HPD * sequence dependent, do not move!
 	 */
-	if (!disable_hpd)
+	if (supports_hpd && !disable_hpd)
 		dc_link_enable_hpd(link);
 
 	prefer_link_settings.lane_count = link->verified_link_cap.lane_count;
@@ -888,7 +889,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	 * Need disable interrupt to avoid SW driver disable DP output. This is
 	 * done after the test pattern is set.
 	 */
-	if (valid_test_pattern && disable_hpd)
+	if (valid_test_pattern && supports_hpd && disable_hpd)
 		dc_link_disable_hpd(link);
 
 	kfree(wr_buf);
-- 
2.51.0

