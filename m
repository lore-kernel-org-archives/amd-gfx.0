Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610FDC18E5A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 11:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F6724692
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 11:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPi05+o2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F6724692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E951A6E160;
	Tue, 10 Mar 2020 11:24:19 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ADE26E160
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 11:24:19 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id 25so939274wmk.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 04:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BQhpJ7MNeyUw9rUzOzev+aJevFWsy5vf5dq/09wDCA0=;
 b=pPi05+o2+y077AQVUR7oAl/tbXdheqc1mTTQx0Gz3e4Zx8S3FSvvvwNjrWXDPF7C95
 X6iV8lyGWBas38cCx84UjcQ4NuYtqYQxb4wMWXMSTIHoHhI41bvYrckORWy2fnzTqk9I
 qUQFdECNPGTDgnvPg1q89z/nUGRgpky3cfHlq/HSsuR7rFhJ2By0PDkfqoV9GzcYXmrq
 IMtHEUwRQi+tSoA6xg7u9c6FMNo8tcaQ0c7i8kDZT0o8X6nJv8SeXCSIWJjkNL/hNes8
 5nKgPHj3flB+wiFjwmu8YV82fJns3Tkh3rkxpZWmDB5YjlqajZJpSwdJ4y59MJaWQaLG
 veDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BQhpJ7MNeyUw9rUzOzev+aJevFWsy5vf5dq/09wDCA0=;
 b=TP5pm3hYZ3lIWlPwpLzT37BOgP2v2FT132tnAcqU/bDCDCB+gi1dSJduFbNEpz5Bb6
 x4nyDU+cLeZTZ8ZS1sYImHzXsUd5Y9b8dL66hZvEaCUP/c97rRzcLTppMJHOC6yfQ9ge
 AaXYDspGM4RdDlXY6TW5p4McjP83ddAWNlFf6qAyUfVfisrawA5IPNMAjw1Lqr20B8XZ
 Qt0wjB+RNSYDPjszg4rt4FEuxHCzScLpsK3S+61pR/gVG83nGrmmKTdnaC4L3FAK2uzF
 yppicSNk4ioOmvdpOkXkAhzRdXt6gS8KECcOaS1XhMVY9guythMIRsTwn6imPdadci48
 yoZA==
X-Gm-Message-State: ANhLgQ22V3VdEKE0EdlDYT3OMhmfO/FNbL5BdRmAaQhH8PIs4koLXOVr
 SXgOzdnl/peGtCgf3s0QhiZ2Xs/ZAhZnvg==
X-Google-Smtp-Source: ADFU+vtt89r2IUY3/nHYiUWES0vn/sJdlKPPTrMlhBcnSgD+oqeEH+LwcA3PQK2MFM8mEG64yPdf7A==
X-Received: by 2002:a1c:2ed2:: with SMTP id u201mr1688867wmu.3.1583839457771; 
 Tue, 10 Mar 2020 04:24:17 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F32A80070E0F409F1853DFD.dip0.t-ipconnect.de.
 [2003:c5:8f32:a800:70e0:f409:f185:3dfd])
 by smtp.gmail.com with ESMTPSA id i6sm611560wru.40.2020.03.10.04.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 04:24:16 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: do not set nil entry in compute_prio_sched
Date: Tue, 10 Mar 2020 12:27:47 +0100
Message-Id: <20200310112748.4899-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200310112748.4899-1-nirmoy.das@amd.com>
References: <20200310112748.4899-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If there are no high priority compute queues available then set normal
priority sched array to compute_prio_sched[AMDGPU_GFX_PIPE_PRIO_HIGH]

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 99875dd633e6..01faeb8b4ef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -478,10 +478,18 @@ static void amdgpu_ring_init_compute_sched(struct amdgpu_device *adev)
 	adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
 
 	i = AMDGPU_GFX_PIPE_PRIO_HIGH;
-	adev->gfx.compute_prio_sched[i] =
-		&adev->gfx.compute_sched[num_compute_sched_high - 1];
-	adev->gfx.num_compute_sched[i] =
-		adev->gfx.num_compute_rings - num_compute_sched_normal;
+	if (num_compute_sched_high == (AMDGPU_MAX_COMPUTE_RINGS - 1)) {
+		/* When compute has no high priority rings then use */
+		/* normal priority sched array */
+		adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
+		adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
+	} else {
+
+		adev->gfx.compute_prio_sched[i] =
+			&adev->gfx.compute_sched[num_compute_sched_high - 1];
+		adev->gfx.num_compute_sched[i] =
+			adev->gfx.num_compute_rings - num_compute_sched_normal;
+	}
 }
 
 /**
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
