Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79AEC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 19:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27B120658
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 19:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8BNVS0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27B120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536D489CB2;
	Mon, 17 Aug 2020 19:53:40 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DAFD89CB2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 19:53:39 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id p4so16171382qkf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 12:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3LqefvGhTxiQWFEORkoB7x5e3Po+keGA25ln0xpGhUw=;
 b=Q8BNVS0V0xwZcIPW/p//YpNq2JbTzgVZu6xqACbxgkNaHJwED66r8H1eilqCFNx2Ob
 kwjEkadSLow+PRf6lQI69awZnRg4eR6oIgtztduHuWrAHMUIZUVaTN7RkB5qfjffCXRC
 s91kKI8ld4dGC7zUxHnKkeccO5LAJ/SAi7zLd6Biery5CtKH+75vJfVfR3mNMyy54FbG
 RmGiR7FYihctvw3PQ+Mv1kD9m0e2GJG3fTK6W5GSOwZ/WoOSpGjViUgsJR6M7W8KJMBk
 DK469mGuDttWx0ePX/GkVvDQQU9cWitj0Ld+mIJGIHhdchhW6RtEnUBIBLET8l0ZUimP
 SBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3LqefvGhTxiQWFEORkoB7x5e3Po+keGA25ln0xpGhUw=;
 b=A0TzQuOGsotj1j9zSRsvEK7I5KN2XQChdAsOk8yVfL8logTm//C7JJjj7YMG6LeMoa
 uIQv8U1PPcTm8dvZihLyO4nMnEvJMaroIO+NUGC8Qz9Tj7cJ5/6nEAvP0lEC9l+SgG/a
 AD8sojRywBsWv6rDH9XnhnM365YsZ39J41jiLHOLmycxqbJPF4ibghdDI6s9ys9a4XXL
 2mTxdkwIwiS2Pm9HMB3tEzCSjmcmgFaBFUJPmcN7ODtujc7jjXf7a2PGYhTbIJXY3cl5
 1rw9gqzH412cN01cK3YW6eaF1xUIqXw7YbDrXjFiGofrjowoczRZd9uS7x0+E4o9fmxy
 6TbQ==
X-Gm-Message-State: AOAM530BZPnr49TEcEQ8nNMHcq6TxAOmwCKY69dPW9zAZl5Q5rqTK2UL
 LAU7/rkNzGlBw8mQ9iHrZLAZcMiDSnQ=
X-Google-Smtp-Source: ABdhPJz5JlfGg0NGkPOciVJz1tNuun9EZgVIq7zpWaGcfmIlqDV89B2Olgu2X/PM+Ph8LRKppGul9w==
X-Received: by 2002:a05:620a:16af:: with SMTP id
 s15mr13168432qkj.304.1597694017574; 
 Mon, 17 Aug 2020 12:53:37 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id p189sm18103161qkb.61.2020.08.17.12.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 12:53:37 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu/pm: remove duplicate check
Date: Mon, 17 Aug 2020 15:53:26 -0400
Message-Id: <20200817195329.1971490-1-alexander.deucher@amd.com>
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

FAMILY_KV is APUs and we already check for APUs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5fc6a9a13096..f2e70655e8d9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3311,8 +3311,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	}
 
 	if (((adev->flags & AMD_IS_APU) ||
-	     adev->family == AMDGPU_FAMILY_SI ||	/* not implemented yet */
-	     adev->family == AMDGPU_FAMILY_KV) &&	/* not implemented yet */
+	     adev->family == AMDGPU_FAMILY_SI) &&	/* not implemented yet */
 	    (attr == &sensor_dev_attr_power1_average.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr||
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
