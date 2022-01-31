Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F36C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jan 2022 13:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9893510E404;
	Mon, 31 Jan 2022 13:52:51 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BAF510E404
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 13:52:50 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id jx6so43651298ejb.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 05:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0SSiIZQ49heLyfWRIO9M1yzFS2BLPUdWyAIWWPeQg4I=;
 b=omQWguSPt9zF1HFdEZb8lP/p/wZe6WSkdmJJE7cHrlpPlONlj5F9nb8ZKjfazYu/x9
 zBOoaO1G8Pp6pkyQf093QvvVL4H0zaiiSa6CUdYsawK1eZibTLdcDqsYZtRRLf2X8xQ/
 vduZzZPYoXeEJdAHeTdO518qioLd1aF4WYP15fn0bdziayrI74YHXKnzeDAAXeJXEoHs
 1H3vMr44fEQN+swesodncCpUEwgSUzfjEHInSYlEZSbtPNSGKpWSOi4dVjtxS+IuxBh2
 r8K5mUE8Rohd4mRjUcA2Gd/YpvDgDFk9nGZVD6EXKgpLKy8wvUODkfkgJzZyYZFj7HCN
 eyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0SSiIZQ49heLyfWRIO9M1yzFS2BLPUdWyAIWWPeQg4I=;
 b=hMMo+NnlN0CWfXXU5bxMDbPLDeleGONuXQQstzwEmi0+zClSubb6z0SdQ9krqHEkYP
 r9vhxZBTNs439D1J+mXRJv2/YLdgX4Wn0pBJYdNsvPiIHh0ijG8FumOJFAZ7RFQXcHHk
 CuP8K3xTI9kP8ZWoJwo6RYVm9jeMdMxBeHEXL4iiPTMLCgkG8hIJnkml31KznqjsGKlU
 ekAUnr0UJSp2gfHoxzMHvWHKVbvcVncnNwV+BbuPygtzgpXaX77tafUDl3O0CtApSfZF
 R+HCwlmK/JoZ5iVx7NT6579AkrDMnQg6Mw7e5QNVLud+PPQCclR50cYQjA9Q9kHr31ws
 kMHg==
X-Gm-Message-State: AOAM531XGcdase0Y0xL8P+uF8oefV2Vi/jwHCn+yxfgE0O1LMimfJmwt
 MhIb2DvFgmwwKBjWBmCZvzDwYP/VAVo=
X-Google-Smtp-Source: ABdhPJw/3KYd0juRlRVmDoDIx8Z/VwzLjB/kHbdFf4+sSg9CtR7uwyIEw8TQpJorEk/UG42ioQ6Nkg==
X-Received: by 2002:a17:907:16a2:: with SMTP id
 hc34mr17888559ejc.330.1643637169083; 
 Mon, 31 Jan 2022 05:52:49 -0800 (PST)
Received: from baker.fritz.box (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id co19sm17893557edb.7.2022.01.31.05.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jan 2022 05:52:48 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: harish.kasiviswanathan@amd.com, benjaminadam.price@amd.com,
 felix.kuehling@amd.com
Subject: [PATCH 1/4] drm/amdgpu: fix logic inversion in check
Date: Mon, 31 Jan 2022 14:52:43 +0100
Message-Id: <20220131135246.1521-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We probably never trigger this, but the logic inside the check is
inverted.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3d8a20956b74..2b0e83e9fa8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1938,7 +1938,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 	unsigned i;
 	int r;
 
-	if (direct_submit && !ring->sched.ready) {
+	if (!direct_submit && !ring->sched.ready) {
 		DRM_ERROR("Trying to move memory with ring turned off.\n");
 		return -EINVAL;
 	}
-- 
2.25.1

