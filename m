Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BADFC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 20:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F139B2072A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 20:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7wsGC4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F139B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8BFB6EA94;
	Fri, 10 Jan 2020 20:11:24 +0000 (UTC)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B596EA94
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 20:11:22 +0000 (UTC)
Received: by mail-pg1-x544.google.com with SMTP id l24so1499532pgk.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 12:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hSE1WP4baSoWa0lsh+1cONjUYMwb87dwgvf7GrlO8rc=;
 b=s7wsGC4NNnbqIz8mNqpJxYYRtem+WkVQeGd4NCWP9l0Bmj2HxA2NR6w957SNdYprO/
 6CxyItV3OchsbFzKn/uTnAheoGkemN2onmRVC4gn1EuoPIVQ3jULHAoouy6+j8rMh0uc
 1GX4XcuWRt9K3CxdIu61w25wvZixqx/CKS1ULfMetnzfLJA88qTsrqtWsF9CEWo4C4nh
 ZoCeT6uYzOOmpwOcs1Etr+2Cx22l3prnMe7T26dKLKF1jBFq0cSDplOJgAgYpiZuYoIa
 q6sYgcJefJxOskcNmq/dUPa4JqHQcw5DZ6JUcMcf27TVe+LfkKnqrNHMCyL0+TYylRWV
 BzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hSE1WP4baSoWa0lsh+1cONjUYMwb87dwgvf7GrlO8rc=;
 b=jXIHSw807pf8vti/AQRlIvOy/Lz5Yg0TMuobS7DjPy+ic2y9RS3tiCF2WHkGRdgRVx
 2aPTf0SiqUsxu94Z+FLma7TCD0OnL4jhO7fbpiOgHHaLPAiPdNCmcrE3zlE6EIbpS3mj
 wUqRWqHb0Qmeet5LOAf5vIZPLGpaNyNU3tSMZox5mMlmr7E0OYmEf7OoeCfuFRgheoy1
 BaYcFPIhURk6Oig2iw70UVklEcLmXPhzegCrVP1aQaOS90nsGKce3wikhYwjum03/B88
 dkllvG0otVrLYaJ2SWfrIjrwvOqYnQAwtXQdYeCv+Jq0tX6JDqt+s9nxAcK4CvwqVx3O
 R26A==
X-Gm-Message-State: APjAAAUxxfELf4wUriUBM3i6CLkKToS/Z4IuVrDmdFfKtJpifZS57Vmp
 2wclxluqvk0k9s0sI/TpEcPuI+cS
X-Google-Smtp-Source: APXvYqwgAAU1JvzhMBtU3/miiq65gy6B+AcimuQNw1KLR+9RWwbc4lvKmv8fSRFB9vWpeLoLmL1gXg==
X-Received: by 2002:aa7:98d0:: with SMTP id e16mr5883646pfm.77.1578687082416; 
 Fri, 10 Jan 2020 12:11:22 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id z130sm3782417pgz.6.2020.01.10.12.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 12:11:21 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, Wenjing.Liu@amd.com,
 Bhawanpreet.Lakha@amd.com
Subject: [PATCH] drm/amdgpu/display: fix logic inversion in
 program_timing_sync()
Date: Fri, 10 Jan 2020 15:11:10 -0500
Message-Id: <20200110201110.117166-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

It looks like we should be reducing the group size when we don't
have a plane rather than when we do.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/781
Fixes: 5fc0cbfad45648 ("drm/amd/display: determine if a pipe is synced by plane state")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3d89904003f0..01b27726d9c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1003,9 +1003,9 @@ static void program_timing_sync(
 				status->timing_sync_info.master = false;
 
 		}
-		/* remove any other pipes with plane as they have already been synced */
+		/* remove any other pipes without plane as they have already been synced */
 		for (j = j + 1; j < group_size; j++) {
-			if (pipe_set[j]->plane_state) {
+			if (!pipe_set[j]->plane_state) {
 				group_size--;
 				pipe_set[j] = pipe_set[group_size];
 				j--;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
