Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A67C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B03B20814
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul455c1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B03B20814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15AC68825B;
	Thu, 28 May 2020 14:06:26 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EE698825B
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 14:06:25 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id c12so81233qtq.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f7w6fEARvccp7y6ZomHM25HqwnyXjucz/GYPdf9JJ6A=;
 b=Ul455c1PNJCYkza1Yu75suWTTggOr3e7ITjMI3r2rcONVN7YK5kn83xpRQCKhUgAwI
 /WX5bT+zZEWMuSK3z4AmoL1uMb9E+K0eyjl8ycx5VYYNxBqbyg6RnqfdmnZHHagb66mY
 SW2dngc9Fr8X6PSQ7HSGGWqcByqCxUifWn2nIwj7c8BExMw0GJhDB077NQYXzBfxedjS
 Ml1fBHCW3QZgwI01t/mQ7vEq0egl7//EXv5DlP4G7m2/BmOUd2cfgfpaIsWyKYmyW/pO
 EJP32gFDlkiVSEoWV0Pov66UsAbow5G0PHQNklqORpzH7Ds1Jz4ODt9NgqRmVIEIPYZa
 2n+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f7w6fEARvccp7y6ZomHM25HqwnyXjucz/GYPdf9JJ6A=;
 b=in1nQu0639YUmSP2unrRSGJlPlKArKlPHA00n+D26QtAYVuabqlbJDz8VlGkJHgcsQ
 a/BXk0YZqK5CNJZNcH7QhBl7T2opVMnfoVqhNVW5rzX8mQafVatb6AY+n/Za3sduHjzQ
 vZomTFXhCwseYkOLDq2lz9V2PHpoTeV/QacjOXQQ9JWAlSSo+u90cjTAnKsA0g/+T+2L
 NOsba6mZghhNGzIUJoUXkbSHHfgULbjnat6eZELk7WDExD1KdkEOM2+eBSsLUlVmWpMJ
 5nSHaYssrw0EnUKHmrttLeoIW6okspkyOnEjXLTClL2oPGUL+YaCFBsPQAhzAnhg4jww
 hEVw==
X-Gm-Message-State: AOAM533okLi1xgfSwD4v9wLcIiH7DPmcim+nvPSRlOK4mXkaCWBiEmuJ
 PkW0QV7rK5GZQ9Ysrk+vEzbViKdW
X-Google-Smtp-Source: ABdhPJzhvTRNJi99atLl50HkbjStkY7i2F1mtzMaXUEWKg73z6UsWrJyKIz8uEUmAKMB1zarlsFapA==
X-Received: by 2002:ac8:f79:: with SMTP id l54mr3315791qtk.79.1590674784392;
 Thu, 28 May 2020 07:06:24 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id 130sm5157198qko.113.2020.05.28.07.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 07:06:23 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: drop the reduction loop when setting the
 sync groups
Date: Thu, 28 May 2020 10:06:13 -0400
Message-Id: <20200528140613.282473-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The logic for blanked is not the same as having a plane_state. Technically
you can drive an OTG without anything connected in the front end and it'll
just draw out the back color which is distinct from having the OTG be blanked.
If we add planes or unblank the OTG later then we'll still want the
synchronization.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/781
Fixes: 5fc0cbfad45648 ("drm/amd/display: determine if a pipe is synced by plane state")
Cc: nicholas.kazlauskas@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 04c3d9f7e323..6279520f7873 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1040,14 +1040,6 @@ static void program_timing_sync(
 				status->timing_sync_info.master = false;
 
 		}
-		/* remove any other pipes with plane as they have already been synced */
-		for (j = j + 1; j < group_size; j++) {
-			if (pipe_set[j]->plane_state) {
-				group_size--;
-				pipe_set[j] = pipe_set[group_size];
-				j--;
-			}
-		}
 
 		if (group_size > 1) {
 			dc->hwss.enable_timing_synchronization(
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
