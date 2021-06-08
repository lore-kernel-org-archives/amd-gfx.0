Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D37AC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 07:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F7276124B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 07:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7276124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7BBE6EAB4;
	Tue,  8 Jun 2021 07:05:21 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA02A6EA96
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 04:32:47 +0000 (UTC)
Received: by mail-yb1-xb49.google.com with SMTP id
 d6-20020a2568060000b0290535b52251cfso25246769ybc.18
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jun 2021 21:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=1CsAHJB1drzJFE9aMs2rQoto13RGg0fVp1ldOeOJhJM=;
 b=AODPeS3Rxy2dCzZVvlT77V++MmhgHwq/LXwUy62+WDULLkPs3l7t2Y3YlSU2OjGQxR
 wRSr6oKoRjTEq51NPDaNczweGae+Jm19rFf8p0D5OaFId+n1nPwvgzxFuLh4LXw1S3QA
 MlDb9Z41YtIo7OVegofT3m75hTP5y4ZKA8kLLhHCTMA3VMmJxMvAugXCIMSbiEfuHiPX
 l+2sM+hwGu4aP8yjEWplKd/vPOAJeenAlCNz4bOpqFQQmQe5Eiee/FvebF7i5MxXku5F
 PHbrhdGGqnsemAsDaDo5A53MJ4cVUbzYoHZdk1btN6z0Gl0BwAEeWgU7kEOQooBIeWs0
 GOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=1CsAHJB1drzJFE9aMs2rQoto13RGg0fVp1ldOeOJhJM=;
 b=rCyj+8WRWBDfP2IFXsKlYFQ5XyYRfcEJ5q25GMbFjFpaPrbIVXKQe/OnOI9ZvFXmJE
 5ahQulPOTLHCetLnJWffemlHC7jNe9TCUI6N8cfeKbIu3T8H8s2QCbF53SynKG+DvfBm
 jxKZsubTtMbC44gBsLzU391zRNIIE8PpDeqVKhMV83O/vG2jpQvhSTVu4/fs5/W7G+Ax
 1ZaOVWLEwbz6u8HpAcvFNaK6YYPyT4vaqq60WL23p8bEYBM1vTqkWxUIHOgOP+AcBD5J
 4uiY4kjHWMBOH3ec0KNQuvhoVNyo7KpUIFYoAfGnq95u7XqPDSda0C92aQ5errFhSqT4
 5/Zw==
X-Gm-Message-State: AOAM533moynY2Y8a7lqmV46X00N4IlCnpLINnoO6qm+LLjFAPmvsfW01
 +Qy4mw9ZAQpgK7nmcVUX3mgjj3dapeVTTdG2OBDz10i2d4hBNQ9fy36ycjO65gWOskVZiAfVzuz
 r9lsKpOzxYH2NQEo58mi7p3bwFBrJ9KXeepnvPUy4UoPV4cbBUFsNl0LTpNg9zU3LuOAnAmFmyw
 ==
X-Google-Smtp-Source: ABdhPJzGFYSJkGjEYy0wczei19iWM6Y/PFAcqGhaMiTDjHXzZj8TJzkLVLUqX7h6ji794vCiYrmvD3iMRwb6
X-Received: from nandos.syd.corp.google.com
 ([2401:fa00:9:14:7455:f4f3:5253:80b3])
 (user=amistry job=sendgmr) by 2002:a25:7a41:: with SMTP id
 v62mr28852515ybc.225.1623126766754; Mon, 07 Jun 2021 21:32:46 -0700 (PDT)
Date: Tue,  8 Jun 2021 14:32:38 +1000
Message-Id: <20210608143159.1.I230026301243fbcee23d408c75aa468c1fec58f7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH] drm/amd/display: Fix error code on failure to set brightness
From: Anand K Mistry <amistry@google.com>
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Tue, 08 Jun 2021 07:05:21 +0000
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
Cc: Anand K Mistry <amistry@google.com>, Eryk Brol <eryk.brol@amd.com>,
 David Airlie <airlied@linux.ie>, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>,
 Nikola Cornij <nikola.cornij@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The backlight_ops.update_status function is required to return a
negative error code on failure. Returning a positive code may be
interpreted as a success. This is true for the 'brightness' sysfs file,
which passes through a non-zero value as the return value of the write()
syscall. This is interpreted in user-space as a successful write of 1
character, which is obviously wrong.

It's not clear exactly what error code to use, but EINVAL should be
reasonable.

Signed-off-by: Anand K Mistry <amistry@google.com>
---

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 652cc1a0e450..ad322613390d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3431,7 +3431,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 	else
 		rc = dc_link_set_backlight_level(dm->backlight_link, brightness, 0);
 
-	return rc ? 0 : 1;
+	return rc ? 0 : -EINVAL;
 }
 
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
-- 
2.32.0.rc1.229.g3e70b5a671-goog

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
