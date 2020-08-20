Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D735C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 05:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433062078D
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 05:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mOlrm/yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433062078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C5A6E8A4;
	Thu, 20 Aug 2020 05:29:43 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 854F56E8A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 05:26:04 +0000 (UTC)
Received: by mail-pl1-x649.google.com with SMTP id w20so862477plp.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 22:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=lsbX1Xry7gppehECQgaCRYNE8or1PEFLIhmR1NXSOR0=;
 b=mOlrm/ypAWHV53bMT3Ty7Jh+auz977mwz7G2JytM7UUrOhtUX/Gx554bonVEsH8D+X
 n7EsfeRFgRsTd7fqJ6DGZi/OA2wlnW+LGGsLaN0fj/gFqnY4CqsjHgJZN0iyWBMDu/3a
 /xfrlcz6YiHxaw8TVMZZP/MvtrqfyIGOhLCn3vmSki/qgPs91Eu8Es6nLqhme6jpNHVw
 5uHNPVl9bAmg0ooISIwvdf3XtWpBlCW9V9DM/nAGGpxbjm1QAk6yFcTTjWax49GTa+60
 +hvFa0oTQm2qStaSIEAe+eq+HOvyDpzQ0vjxnwL3Ou49EV0FWnS4N8bE3PoIvOSOmi8o
 YgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=lsbX1Xry7gppehECQgaCRYNE8or1PEFLIhmR1NXSOR0=;
 b=YGJBWftatvQKaq57zjCpL87z8wh6WUtkV/VNDxlI0LBBUzkFvSQin0cFtqk49SJw+s
 2nhQ/lUbgQf9qPp2+8X8lVLgIRd5q1xon+QfE+MgW2GS99WmUPT7CKu7BQuQVu1NLZ3V
 Uim+o8dD37cNSpL8KDgxNRb9JB7DnAQLpIvgNYMwGfumOlS5xEkUo/NNwoZQGx3qbwOi
 JH1a01Ix2wCQJCo7CUSNvmtbiVHRV4gpv9OqOuWf/0oEIlqxW+1GHn+y1MFbMbtHag3d
 fM2/42AoIjAF69fV3DfavHasYX/Gu6ZuTf7IyjXKo6IaoQ+G5bekI8gqbaa6YGsGeMeT
 6zEQ==
X-Gm-Message-State: AOAM5312DJKmc1uDRDN7nEb935vfIs8a4vc46IJLshDG9ISbrpqHcBUa
 OrLpvCo+1fozAyZrZhK7MY+a8yVCo6HB
X-Google-Smtp-Source: ABdhPJyih8WdgObyYBpQNCGv4zrgvvHc7FA9Luht98sh6VTtC3hEyRDd6ObmxGoUW4L6Dtpjj42SS2nGdSg1
X-Received: from furquan.mtv.corp.google.com
 ([2620:15c:202:1:7220:84ff:fe09:13a4])
 (user=furquan job=sendgmr) by 2002:a62:aa05:: with SMTP id
 e5mr1051919pff.70.1597901163900; Wed, 19 Aug 2020 22:26:03 -0700 (PDT)
Date: Wed, 19 Aug 2020 22:26:00 -0700
Message-Id: <20200820052600.3069895-1-furquan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] drivers: gpu: amd: Initialize amdgpu_dm_backlight_caps object
 to 0 in amdgpu_dm_update_backlight_caps
From: Furquan Shaikh <furquan@google.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
X-Mailman-Approved-At: Thu, 20 Aug 2020 05:29:42 +0000
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
Cc: Stylon Wang <stylon.wang@amd.com>, deepak.sharma@amd.com,
 Furquan Shaikh <furquan@google.com>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, Roman Li <roman.li@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 adurbin@google.com, Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In `amdgpu_dm_update_backlight_caps()`, there is a local
`amdgpu_dm_backlight_caps` object that is filled in by
`amdgpu_acpi_get_backlight_caps()`. However, this object is
uninitialized before the call and hence the subsequent check for
aux_support can fail since it is not initialized by
`amdgpu_acpi_get_backlight_caps()` as well. This change initializes
this local `amdgpu_dm_backlight_caps` object to 0.

Signed-off-by: Furquan Shaikh <furquan@google.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e4b33c67b634..725d8af634ee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2853,7 +2853,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
 {
 #if defined(CONFIG_ACPI)
-	struct amdgpu_dm_backlight_caps caps;
+	struct amdgpu_dm_backlight_caps caps = { 0 };
 
 	if (dm->backlight_caps.caps_valid)
 		return;
-- 
2.28.0.297.g1956fa8f8d-goog

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
