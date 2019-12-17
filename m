Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68538C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 21:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BE12082E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 21:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7fwWDc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BE12082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0CAA6E143;
	Tue, 17 Dec 2019 21:45:54 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 435BA6E143
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 21:45:54 +0000 (UTC)
Received: by mail-yb1-xb2a.google.com with SMTP id a124so3833664ybg.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PMrto1OAOulTet5ZKh7GCxBDhQdSZOPlS3WV/W+N+3U=;
 b=E7fwWDc9RgesuuhN2CxL7npS7RDe00BuZ3UkljAYHWIeRva+HqOMqrUk4UMdZHRzd3
 CUnyAu+xgrnsVjLH8QYah1/tg1v4gl9hgyZ27rMI+IDHrFdb5k2rnMEzBtsXMgqNuWZs
 xhGN3vj7SDEiKkbxgJK5HMDvkrRqXzojnjX+15I3IqHjo2tJrj2jj07F6fj8B2tfa0Vh
 hRSb6giBrd920n1mOIREyaMIsS01D1i00H+8axZOvhwpvlqUIKKJm7YaBvUMl+WfgK6D
 OlOck7lMLsuzNcIgQWKq14VBjFWt8Z0rx1CG9ogLs/HdG1+5mPDiA91lcXJk4ce22r6i
 xhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PMrto1OAOulTet5ZKh7GCxBDhQdSZOPlS3WV/W+N+3U=;
 b=WYW1oxfrPi0B7uOtFWP2Qya0v6xCa/UYSkF9TBrPwrKUgGb+LnvryxkwEY5CYvwgmo
 /q4kKUy76/P54HeT/o2uw4Owsl+fu90wmIxwY5F2+WJneY7OOauQTyEyxT0XS1YeIWEn
 WQRXkfXNpf/fNojIdQMnQO2cdH7py01pgdNEHR9P4nvitAJ7GhLZKs3gZ2zEWwU69HLv
 udyQEstXCH7Yw8Qm9MZua2EGISBNloYvEOCKH5fS6MJIe6sOzuZQMqaT9iKLmW6l/qOv
 MUE19rr7hhD2maxed0CGyHPe0fI73/Fdar8r6H5Na34ZRrnacAEEbaljl32seFTVdUoP
 6fAg==
X-Gm-Message-State: APjAAAXax9cVGuMAaq6eFGDDMKui1gQXR8oVZMUlQ12OK9SddPYGPTnB
 6kf6yl2e5GFcGmHhJjSc9RIG7Svs
X-Google-Smtp-Source: APXvYqxMmM2MTRT02kows8gaR2lyC2Ii6Qdfz4gBLLfe8G6AHrBoPuVVngHxHDs4pA+KocGAgacnGA==
X-Received: by 2002:a25:3fc3:: with SMTP id m186mr180795yba.314.1576619153092; 
 Tue, 17 Dec 2019 13:45:53 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c1sm32728ywe.67.2019.12.17.13.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 13:45:52 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/5] drm/amdgpu/smu: add metrics table lock
Date: Tue, 17 Dec 2019 16:45:39 -0500
Message-Id: <20191217214543.2285700-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
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

This table is used for lots of things, add it's own lock.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/900
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 1 +
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index f76a1717ffbd..936c68298786 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -872,6 +872,7 @@ static int smu_sw_init(void *handle)
 	smu->smu_baco.platform_support = false;
 
 	mutex_init(&smu->sensor_lock);
+	mutex_init(&smu->metrics_lock);
 
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index a7d0ad831491..541cfde289ea 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -350,6 +350,7 @@ struct smu_context
 	const struct pptable_funcs	*ppt_funcs;
 	struct mutex			mutex;
 	struct mutex			sensor_lock;
+	struct mutex			metrics_lock;
 	uint64_t pool_size;
 
 	struct smu_table_context	smu_table;
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
