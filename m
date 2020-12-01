Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF3BC64E7A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 17:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5C720870
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 17:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oX9eneTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5C720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C4436E86F;
	Tue,  1 Dec 2020 17:44:23 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B86CA6E588
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 17:44:22 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id l7so1741919qtp.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 09:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DV13z9W6SKfao3NOPETunFMAY10GiqFYr3K4+UXibXQ=;
 b=oX9eneTbkh3oJEFy4roAkpXBaohfZnK5yRMwbKXm96FwbYrp2FUWyfr0uAD+HjK1nf
 l1ROtfFtkewap8tQTbmJQyUiCV2TVZ1z9/LlpHAmfYIMaoAjXDCCfb7L2Z33K91Hxw30
 /Hla//GvXwwV5qNw5YOaOHC/bU50jWZN/JvQlOwU8P3sc34jP4YqprJwzOzWvtAnx+J1
 8x5y4f/ypPiOFOTsQpfT1KJOkS0g2mFi6DljWqGoatx9bfMuiRXqxQ8dzxiF6ViLAzva
 b1CQ4c0upZ0ckVKOYF4pIOJSwevVeCPmy8yxuPoa9Gk6tO2kREAmWD78TKKGCKvesF9F
 um2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DV13z9W6SKfao3NOPETunFMAY10GiqFYr3K4+UXibXQ=;
 b=DOApP/Vryco3Nxv7OTCwrWA13m93NZBrBAUAIoSa+xOu/StZMUQXyy8OzHBiFkZJJL
 7Dz6N+jrSbufCFetPoRzXGvBSk2XzZSQxh/8OEcz2L5ncrN/3twuLMzIMWmVJiahplen
 0zzUmRpmzVgL+gTuJQX+Kr5yqQcw0A9a3tCIijy/Y7+MCODpjGeTGppicN35Fz1yPbuE
 jKHWs7FNvAih65Kzmc02M1C8VuXTwMZunuVF4It4/Nzt2OMjtDM3GBlgkaXY/+y9v9wp
 4gGnqPG+86gUuxgpzuAbxwC7md+SiKj9H0qGGA9nioc3mPLobJazvz2eiFcglvOLl0Qs
 R0JA==
X-Gm-Message-State: AOAM532RRskkccshO4lfF3fBJhr1899egBbUHwhYdb44ZpYCJhjZm/QI
 mhxuddkVWX7jWdN8wqkKh5RFU24Kluk=
X-Google-Smtp-Source: ABdhPJwty4YwabuIE5Dub+Qtkzmi5c8jl7laha+bhICM9ltfrskefhoT627OGPkNA2ULZB1k/dN9Ew==
X-Received: by 2002:ac8:5786:: with SMTP id v6mr4087479qta.268.1606844661742; 
 Tue, 01 Dec 2020 09:44:21 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id o9sm302170qko.53.2020.12.01.09.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 09:44:21 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu/powerplay/vega10: handle error in getting
 pptable
Date: Tue,  1 Dec 2020 12:44:09 -0500
Message-Id: <20201201174413.643254-1-alexander.deucher@amd.com>
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

Rather than just silently dropping it.  Also fixes a set but
unused variable warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 7eada3098ffc..1b47f94e0331 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3141,6 +3141,8 @@ static int vega10_get_pp_table_entry(struct pp_hwmgr *hwmgr,
 
 	result = vega10_get_powerplay_table_entry(hwmgr, entry_index, state,
 			vega10_get_pp_table_entry_callback_func);
+	if (result)
+		return result;
 
 	/*
 	 * This is the earliest time we have all the dependency table
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
