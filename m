Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C454C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 04:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1824E23BA7
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 04:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1824E23BA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E7A6E82C;
	Thu, 10 Dec 2020 04:00:52 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B4C6E82C
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 04:00:51 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id f14so2768917qto.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Dec 2020 20:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=htEr4u04AKbfWqWFrl/+xmkbw6n8EVmSbHs5cAkQ0aw=;
 b=Bbtq9q6Nxc37Nq+lp8qD7xswYO+x7jofTRrMtCiN+Xicsi+1BW+OK6TCrSthbRQz1a
 V4F/mV3LrcmEMwRBX0lngihx5VsYhtzc85I6q0tErJ6MCN/MC3DgxfwdH2KGcJjEckYx
 DOpPnEZQfzof/RHDKHZO0sfe31rU/svRZaxW26tfLwamcS+EsUibC1DUUG8dsvxoqsZt
 rwwKWBAsx4nVSFG/cxASFfhT1X/F8tLKYrwuY59byV301SWR+gdQwfU3l+XKSVe+6ABG
 v+23XguuAVSfMliidD2UKKqqzZGRArgvelvp05Lee7ZL7cHNmlLTpzmxPMrXTtW3EP6R
 Ygbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=htEr4u04AKbfWqWFrl/+xmkbw6n8EVmSbHs5cAkQ0aw=;
 b=o52IHe0IXj2Dcy8t2MajzxpGwJEAWQyCLJ2F/a1gWSMZMpQuWcpKWktRybkm0qVBvA
 s3pfcd/lH/l0uOxkrMJDyefiD8t5TgKDO/VvL0A2kdvrjZibupvlW2r/baF2to8XBlb/
 TlL1K/P+rWMy/Hk0GjeGJ4yAIrD1MqyicaeNlQTnfpjCoK8IYH5X763zNqd2+CS6xSVN
 6oklCDvHRvSNpU6Gl5ENV86lZZzl12VtqsnV0899IziOcx6DsehaCszHJWUIhFNzHY1B
 4vr6HchtPXkIws4Vv6IufmkdkOLkxYBU49pZsWiJn8YxCcoEAzsmdqPZkzp+OgiUe0Tu
 /+fg==
X-Gm-Message-State: AOAM533NZk9YVEEHX5+myyudolkb7nnF7MiXvFZ7NcuwvoKfBdMOnTrS
 eosae+w7X1cCJD3jzowdCOIDlJjEqAA=
X-Google-Smtp-Source: ABdhPJx9Hz+7uy8e0vWPJKgBToJD/RhFs/ohmLbjZLWy3asJXaRx2Bku/F3m21uoz7JumFl6fOk6wQ==
X-Received: by 2002:ac8:690f:: with SMTP id e15mr6569179qtr.100.1607572850713; 
 Wed, 09 Dec 2020 20:00:50 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id 60sm2684013qth.14.2020.12.09.20.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 20:00:50 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove leftover function declaration
Date: Wed,  9 Dec 2020 23:00:43 -0500
Message-Id: <20201210040043.246672-1-alexander.deucher@amd.com>
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

The function was removed, but the declaration was leftover
leading to a warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ab92ce307731..877b2209c901 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -196,10 +196,6 @@ static int amdgpu_dm_encoder_init(struct drm_device *dev,
 
 static int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
 
-static int amdgpu_dm_atomic_commit(struct drm_device *dev,
-				   struct drm_atomic_state *state,
-				   bool nonblock);
-
 static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state);
 
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
