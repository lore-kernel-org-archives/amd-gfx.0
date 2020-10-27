Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7152CC4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0333820878
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmiThCpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0333820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A3D6EC41;
	Tue, 27 Oct 2020 20:13:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595256EC3D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603829238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=SHVkPineI031WVJrbCGteqt14oTNuWFr/V9p8cK86AE=;
 b=QmiThCpSS6ULANkkigSJsaQ8g2B9aGAhRXUqd3ukDk/CsFZBeEOiYCnAo6SHJAWntwSSaQ
 Sw/dQi9FOakjMBiaNPiFi6yMK+Pv935ckaiJt2NxVJanpAYil1gUqukNbvugiUgzTh6yVL
 a1F7RZJFMDSeVWlXV7zPQapAwOJOvXY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-i5y-FYAfPtW6j8WXaboJ2A-1; Tue, 27 Oct 2020 16:07:16 -0400
X-MC-Unique: i5y-FYAfPtW6j8WXaboJ2A-1
Received: by mail-oi1-f197.google.com with SMTP id v145so1200609oie.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 13:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=SHVkPineI031WVJrbCGteqt14oTNuWFr/V9p8cK86AE=;
 b=h6BVGDzSoyzAj/TDYoR/Fv6XDiSqxZAJOj6x/aociEEfwUk4OrbyhGnM+R6msFrkbW
 cNzCkULebtitSm6bGNGWN8rWFK9Fs6kwiNppNjJVoWLiapxPUVq0o2o9OoAejnCWkM0u
 CuIZ2PM7YI8au9vIMwJ1D+kZngEivhH77GLAwkM+FfpwAo+d4VcHegr0MwxeYgXR9YJY
 FVn6tqrcrMvh9jNcVX+LvvRvyap6xiCFB512LJn0lY7ajRmMngy5QaNmPDz92aX3huJo
 8+fanxsjpVWQjpW5gHBZvw4MbOZ0dx9Icg1/Tew+k5IOjAKhAxc66PMLztS1oKiNjfbd
 imuw==
X-Gm-Message-State: AOAM532gTFAtGdPbPXLpNc8d3RGA3V1Oc5sT/McawYxphIXD5aOX2QxV
 ZZmhAmG4n32XvEh3P7yII4tGR2dueeb9A5zZDa0tHFcLnzh8Yo4c/4/xzblPQtlPSxFuLPYsmrU
 GUiwZRF0m7u12/6pdIDTEfpCwtw==
X-Received: by 2002:a4a:6f4d:: with SMTP id i13mr3144431oof.25.1603829235878; 
 Tue, 27 Oct 2020 13:07:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa7KOheJ0ATgvhFY4mH04BC/Alap4L0XFHAP4s1GjDF+o8lWmc2BUU9x307je7dwCZ/9PAwA==
X-Received: by 2002:a4a:6f4d:: with SMTP id i13mr3144389oof.25.1603829235626; 
 Tue, 27 Oct 2020 13:07:15 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id o8sm1981630oog.47.2020.10.27.13.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 13:07:15 -0700 (PDT)
From: trix@redhat.com
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 Rodrigo.Siqueira@amd.com, Anthony.Koo@amd.com, Aric.Cyr@amd.com,
 Tony.Cheng@amd.com, Igor.Kravchenko@amd.com, Charlene.Liu@amd.com,
 colin.king@canonical.com, Wenjing.Liu@amd.com, joseph.gravenor@amd.com,
 Bhawanpreet.Lakha@amd.com
Subject: [PATCH] drm/amd/display: remove unneeded semicolon
Date: Tue, 27 Oct 2020 13:07:08 -0700
Message-Id: <20201027200708.1596235-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Tue, 27 Oct 2020 20:13:43 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 2 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 7b4b2304bbff..5feb804af4be 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -858,7 +858,7 @@ static struct clock_source *find_matching_pll(
 		return pool->clock_sources[DCE112_CLK_SRC_PLL5];
 	default:
 		return NULL;
-	};
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
index fb6a19d020f9..ee5230ccf3c4 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
@@ -280,6 +280,6 @@ char *mod_hdcp_state_id_to_str(int32_t id)
 		return "D2_A9_VALIDATE_STREAM_READY";
 	default:
 		return "UNKNOWN_STATE_ID";
-	};
+	}
 }
 
-- 
2.18.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
