Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F6BC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA4A20738
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G217HFx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA4A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A8E6E30F;
	Mon, 24 Aug 2020 16:15:55 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2A46E30C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 16:15:54 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id 92so1132063qtb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=frk5VxhSfjJORN8UJ3oVp2+aI5ESrJGCBjm0IoHgzc0=;
 b=G217HFx3zIQI5J76lBDoX4dkcwXRaHH/FVrlMZx+bK9C95dWAkhi3hOkmMxmdH7v3m
 CpqlP4NIbiV+vEl6Z64wHm1Ncf5TNVEcO82tC3tb5IZs+BQcZIiIs6amJ8CjEBkzVTdg
 hc3+066DfRzWqyOquAIUQ2c3r3FkQ4m7+ZivxLVKHFLeDyc7WSQX8enGed4GHNuAgYHC
 /3dtxPBEQKbJiVFzGXftnibEIBY6vNK0sC3W3J44aZnhn5u3WXeUnDVAdKb5+aoBlK4o
 7mSxjulpWLGKNuKdBPoBtq1j1r8ZIqAbeCfCfNe2OxHXpeuWJQb3bktCIGCKtZVURdT3
 +uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=frk5VxhSfjJORN8UJ3oVp2+aI5ESrJGCBjm0IoHgzc0=;
 b=Pfiut33krHSSeyojRPKZhaJvdC0HKzdB3zd2K9jRBYRzRiSjp30o5pEZIrxhpwuf/C
 qulaAo46F8SArZFcWCX2xb2Gmruh2sTMuA1U6mmtz6l2sfPvZ93hd/phJmE5n4upa0Oi
 MOlT6ZndRokvFH7ix3ktP1n7UVlH1C6ZGf7hcq+mi22uXqvJL5v+AntgXjvTIK26fvH2
 ZAetiQTThFIq3Ni7g+5vvxWlOxNEIpLpYMAOIT/6xMUnrAUZLXfcYNJqSHEugsDrGgAz
 5sh29Krou7X9kPtclmp1Z2rAtwiluvG/1Sfg5wYV95YQ6lirVEwr1/n2skjbN3gS0oec
 ySsA==
X-Gm-Message-State: AOAM533KAUidTBbIRUMX5jiFXek/mjoBxbAseMUNQRXRHJvdNEU1c7iX
 xBsr6EZJW2acmaNVzYAPHFTtHo5tBoo=
X-Google-Smtp-Source: ABdhPJwNyD6cmwiWqO3bYX9f1hf9Ij55BWqi83ph9MPKf4IgzS1kPsO5dRJYehMaXfdF+xWAcG90rg==
X-Received: by 2002:ac8:320b:: with SMTP id x11mr5163903qta.320.1598285749273; 
 Mon, 24 Aug 2020 09:15:49 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id q7sm9654097qkf.35.2020.08.24.09.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 09:15:48 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] drm/amdgpu: add pre_asic_init callback for CIK
Date: Mon, 24 Aug 2020 12:15:23 -0400
Message-Id: <20200824161527.2001591-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200824161527.2001591-1-alexander.deucher@amd.com>
References: <20200824161527.2001591-1-alexander.deucher@amd.com>
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

Nothing to do for this family.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 7e71ffbca93d..03ff8bd1fee8 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1921,6 +1921,10 @@ static uint64_t cik_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
+static void cik_pre_asic_init(struct amdgpu_device *adev)
+{
+}
+
 static const struct amdgpu_asic_funcs cik_asic_funcs =
 {
 	.read_disabled_bios = &cik_read_disabled_bios,
@@ -1941,6 +1945,7 @@ static const struct amdgpu_asic_funcs cik_asic_funcs =
 	.need_reset_on_init = &cik_need_reset_on_init,
 	.get_pcie_replay_count = &cik_get_pcie_replay_count,
 	.supports_baco = &cik_asic_supports_baco,
+	.pre_asic_init = &cik_pre_asic_init,
 };
 
 static int cik_common_early_init(void *handle)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
