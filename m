Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F47C433F2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B5C225AA
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6RUKyvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B5C225AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 124EE6E832;
	Tue, 14 Jul 2020 18:24:27 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 429ED6E832
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:25 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id a32so13609865qtb.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mkdg4vjoZgD0qlQk/sMtPmHLwuqBfD0d6UecCLAXpak=;
 b=k6RUKyvQMY13lsctUgfm6X5Je/FXlREnoJAMx8Qj5G0zytqWe9BbbipCs+jheSky01
 7FNhxDm9rNS8eoKat7BgV9SYBuc0l/7GgTwBpPVhrg9E2P24rlSiB/JIPx9FoB6Yt7Pe
 zKkkbgTt42Z7+KtyH2lr0OXULdJgMQ3iJ0d7Z0tQS/gPDmtLqCx6h8FsLefGT4DLOIxg
 Lv03+yEOfWIenbMVKetBT89CDvCsfByMnVTfvUu2F54Rwy1qBzLW6q036AREt4REsTtI
 4AAsuBco+FGxjrplTSwqH1qZ7P488+nal6IyrmALxNnJ0OXQLMrWgxjC+ghZEOUyYys/
 tkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mkdg4vjoZgD0qlQk/sMtPmHLwuqBfD0d6UecCLAXpak=;
 b=s9JyLd6m01mEzrTwlGMVr12lHGluSl0QgDLPFcW59zcFFxhxeKElJq0NHciAOXbwmq
 c8tRx6nohJz+KgwGr7PysabJ7wPyXHK5Ggh4vN6OZ7PlGPuaNuw01Oh3wog97FcLJfDt
 Yovf+/xwWoPFhgmGHo9Dc3T5jMC+JqMUWdYvEg00pzvNFlEkJsPoQkRLIvU2mgOKwY8/
 PzWJqz5QFVdUTCNaeaDy0A1USWRNt3ssZRb5FKznR5jFIKmvZ6RVjellvLKKJptxSVfK
 ycnmNOJJIy/q2F5KTaK7LlnoLplGjoUH0ZE6IoXGsQEAZ+nkjOEij0M91pg+/duATGfA
 BMEQ==
X-Gm-Message-State: AOAM533yZBeOTLOeBbDvDLZmjv6WEQspo9ZUkXZ9xzdczoY+psJWKhBL
 GOcmVrGCWCXhUbise/gGbi2dWOu6
X-Google-Smtp-Source: ABdhPJzK0rVhQBtI0Q7N4zdmg4+bLCqfQXFu9bE8vWJ5QBud14M6tlymVXUpopNUt7u9/t/aRBhODQ==
X-Received: by 2002:ac8:4c85:: with SMTP id j5mr6363307qtv.219.1594751064215; 
 Tue, 14 Jul 2020 11:24:24 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:23 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/42] drm/amdgpu: add common ip block for navy_flounder
Date: Tue, 14 Jul 2020 14:23:23 -0400
Message-Id: <20200714182353.2164930-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <Tao.Zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <Tao.Zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index a8260a51432a..91b4d4e27a13 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -508,6 +508,9 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (adev->enable_mes)
 			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
 		break;
+	case CHIP_NAVY_FLOUNDER:
+		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
