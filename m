Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3579DC4727E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56D7206FC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUuzUpih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56D7206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5F26E96A;
	Wed,  7 Oct 2020 16:32:39 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E956C6E0F7
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:37 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id q26so2403501qtb.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B2NsprHNxhKQKTkWdPxIwQTAadRUPafKTcIaiZb4TvU=;
 b=QUuzUpihNzdo1lXKAHcoHlqoFJ+x44K5frlmwz152Trs0HT/jhLwbcm2Me7PHhDoOR
 4QwmWv552M7JVq8wE1NZ/PJBkqD+xnUH8ze+VaYeU5QdV98Funsv9UhO6y1BPjmHdQb0
 4mlmE7/Jp6Rns5K0jihW1NMa+aYwP+QO5rwZI8Die1pO+Qvu1Fw1wIhw9LlximpKQuCD
 m7ecCls41hPptqXs22KSF49ajgc52dOUtT5lXfksJHg6Z+0yhoUIzMf+Hn4nvdNMZGS4
 72XSQhd6paQ8ZJ5xdaxEdGlSHZpQj/sfwITjQM+qFxOgXtk9g3tnKphAJeGmf/OJQemk
 QKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B2NsprHNxhKQKTkWdPxIwQTAadRUPafKTcIaiZb4TvU=;
 b=YXcgipG8+pmJ/wqax4Xo7OT9i1sQQLuLzUF+NRe1Gty7chveVlMVeT+OYBR/BdfKSt
 Niaa889NRMUplfIaIK2VVY63w0HflazGKEbzqOA6psZ8AwxinR6cKcFWlA2+GfofWDOU
 x7JeK6BcKi4jXDC5/qVARQjYqJNIZimnyhnj80tYJW74lueh3pcJJwUMXm0kuJxaomQb
 X410+VpXzt0wKm2qkGUlnRbvXqh20sOQYRb8H5ZBgnGIof/U99eDjxpZCVwKIRttaeqR
 jawJWDuyohge8LISdkoks3Ofe9X+lXG+QALfQ7XtqRDXJcKl8VGNMraK97nwLaAjxXWx
 7nBw==
X-Gm-Message-State: AOAM530D83zFvF0qB2dbkL8OsVb8wq+6XTFlI04DZwrpdYl91sgoMOcK
 MDwrGq/K1wgtNwebZZdElwfigZ9QbWM=
X-Google-Smtp-Source: ABdhPJzuu6lx56aRIOq72L2UGXopdw2HR4Amtswi12D1D+nFAI4uZSjGl2x1AHUnKkIyS/a+MNjxEQ==
X-Received: by 2002:ac8:3417:: with SMTP id u23mr4019254qtb.80.1602088356977; 
 Wed, 07 Oct 2020 09:32:36 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:36 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 34/50] drm/amdgpu: support athub cg setting for
 dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:19 -0400
Message-Id: <20201007163135.1944186-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Same as navy_flounder, the athub ip of dimgrey_cavefish is v2.1.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
index 939eca63b094..66c183ddd43e 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
@@ -74,6 +74,7 @@ int athub_v2_1_set_clockgating(struct amdgpu_device *adev,
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		athub_v2_1_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE ? true : false);
 		athub_v2_1_update_medium_grain_light_sleep(adev,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
