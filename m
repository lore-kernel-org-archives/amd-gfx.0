Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7D6C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 16:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C95322B48
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 16:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4kDW/k9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C95322B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90376EB8E;
	Wed, 11 Dec 2019 16:42:40 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 947726EB8E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 16:42:39 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id s187so9159986ywe.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 08:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=asBCMdxyZ3ycdZhOnxJ8OzPA3b+drcJFJzvC6P33liI=;
 b=d4kDW/k9CNLO2tXVIfxZMX7kECN54OB8SmsLAFptIEleeMxabxrjfWFrGrtUHmcQpE
 ANEowu9k9jDX9FdHUAm9kSyfskSrXMbD6RZCgBBlotImYjkPI8f2PW6qCtAXq8olRqs6
 b13KaOz17lymaQs33X99Jml8/vifLdTUjtAk+yrpJmfNMrpf/ipEsOVaocwFL4oZc477
 CF9HUqV+4q6FiLOwMj0x5egBsJaz+sZBv5y1HlOyfRxsgQk7N0QeAZuU2Sn/hgulxO5w
 nZNUG7dbhW3kyR9kgPBzdRhkRY5UzvbK8/8OPm6HkHnM3TX33OgihoAPi98eqp+L8CaM
 4pKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=asBCMdxyZ3ycdZhOnxJ8OzPA3b+drcJFJzvC6P33liI=;
 b=hqh7pn4dQ7qUN8dZT+rAMLSFhXtwfS42xuHRtEH+ijvqXQdVwayLAkeupuIpD5TiJ5
 1coRk+gzmDdb4poxdzUZWKOxJgITIcA3f7ktKvqX6xD4GsyJB9JspBukuCNMGPHqK2Xk
 av9eFHCUaX/Beg75PBPP2yHB5u5So4mYNhnw4V24+KOh+CnxCR+GWIg0lDN0dXjQQNLL
 q9mEgwOCE/kzdLJpu0wN1B+iIv/fEBwJ7lCw8bys0OO1VuUlHuoTruop+RnBThdzSOIR
 vNcrvcDAzcWaYIp5UEOccx7dvlKi+bv+9jtHSjrN/2u2DMaSP5RVHIHbSNBWuul2Clgz
 FLdQ==
X-Gm-Message-State: APjAAAWCJP/TuNkofijI1svSxdZOnkQKTwhigx7pDSsZTaPzvzRvahpY
 epjqDlzP17frEZHydyEhNCNNKGXO
X-Google-Smtp-Source: APXvYqw8uw7h3wRsV6t6gotYVkvxzHksZggXb0tKt/a3naOyeEWmxXkECoIcarj0aB8q8DGyX9z0Pg==
X-Received: by 2002:a0d:d183:: with SMTP id t125mr496248ywd.77.1576082558401; 
 Wed, 11 Dec 2019 08:42:38 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id v19sm1196941ywh.60.2019.12.11.08.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 08:42:37 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: dont schedule jobs while in reset"
Date: Wed, 11 Dec 2019 11:42:30 -0500
Message-Id: <20191211164230.2027237-1-alexander.deucher@amd.com>
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

This reverts commit f2efc6e60089c99c342a6b7da47f1037e06c4296.

This was fixed properly for 5.5, but came back via 5.4 merge
into drm-next, so revert it again.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 2cdaf3b2a721..6614d8a6f4c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -604,11 +604,8 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 			continue;
 		}
 
-		for (i = 0; i < num_entities; i++) {
-			mutex_lock(&ctx->adev->lock_reset);
+		for (i = 0; i < num_entities; i++)
 			drm_sched_entity_fini(&ctx->entities[0][i].entity);
-			mutex_unlock(&ctx->adev->lock_reset);
-		}
 	}
 }
 
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
