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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4757C10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 11:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A57524692
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 11:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/bS9kLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A57524692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30ED66E1B7;
	Tue, 10 Mar 2020 11:24:22 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD5B6E1B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 11:24:20 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a132so947130wme.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 04:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7yT3+OP4u57AqLIl11N15fckLmFG3NMULGi2jx1Jg7o=;
 b=C/bS9kLDz7aZKh19KqA2o5P5czhFqbnLFf3vVh570JPMIylAO0Do55//Lt6cGP6gW+
 3wjlXlFE2CSypAEB23GSsBhSUNnQVOPUDttOmYUiZDnLdskXhIWcnvhZtbKzIpXQf+uK
 j5+gWyR6oaufQHFEjBrKxo2JM7h0OINI0KeG8uUrzgCvQ90DYLeH4OVkGQaAUfIVsIBu
 vtcL7ELhAqYEcw2cEYvq3W5PfMAc00IiJUAmXMe2WPGUMAZhIAzFM4F6ehKtm5ZdboVp
 W9d/sBP7elSuzqF9cEysbxssVIMVx5PEzMSK5lAtWP+akZw6NaQFO7czuh2V4VHOy2XY
 T/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7yT3+OP4u57AqLIl11N15fckLmFG3NMULGi2jx1Jg7o=;
 b=fQgCkHyFrideRYVSbUHVYRwybD8J5S+Oy+XuReZXg32trpkabhZkYX908ljgsxqVne
 FzntWukj03GNEywTHD0rdeZ33Yzxm5dTqIojQ0A5z3LJIQgXvorD9mPgDLaUNcgxh10f
 qj4mOD1mooD/xs01oGtIGfuQWprZpXX15u1lgr13MSruJIpPlzpzLKOIvUc1me8mmNZw
 nqxMTw4w79KaI/ov0h5T17tSNgwj8CIP4wSd0KRcS7TLXWXYpN5H+Ji4z3fvIi9uc4y/
 aTqKBrNQW5RCb1j89B85ywfiqTXWdiZwXstyZVVr3Bu+GvwV0CCjRHRPgee7qTyYtk6+
 E0Sg==
X-Gm-Message-State: ANhLgQ1EbF//9D1Wq6+c/aBwIYDr2UePYqdl/97u/ZuSNKEazXT1Fztb
 H6vqyRNyk4Znk0n6Q0oSU4iFTXr4apOaQg==
X-Google-Smtp-Source: ADFU+vt0LoEwow10jjpEznr6rRsvRZiBOUmoB7at/U6WMmN714ZggGVtoHcqZM6YkIHlVKC3Oh7pMQ==
X-Received: by 2002:a1c:de82:: with SMTP id v124mr1715278wmg.70.1583839459056; 
 Tue, 10 Mar 2020 04:24:19 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F32A80070E0F409F1853DFD.dip0.t-ipconnect.de.
 [2003:c5:8f32:a800:70e0:f409:f185:3dfd])
 by smtp.gmail.com with ESMTPSA id i6sm611560wru.40.2020.03.10.04.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 04:24:18 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: fix assigning nil entry in compute_prio_sched
Date: Tue, 10 Mar 2020 12:27:48 +0100
Message-Id: <20200310112748.4899-3-nirmoy.das@amd.com>
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

If there is no high priority compute queue then set normal
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
