Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA73C33C9E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 08:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE0D206D5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 08:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmLK3Ae8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE0D206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D476F8FE;
	Thu, 30 Jan 2020 08:34:58 +0000 (UTC)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFCFA6E519;
 Thu, 30 Jan 2020 01:24:54 +0000 (UTC)
Received: by mail-ot1-x341.google.com with SMTP id i6so1588432otr.7;
 Wed, 29 Jan 2020 17:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m24GYwzOSVWU+XgAxv5NZs3essGtF+Xv5GVsT6y+oQ0=;
 b=SmLK3Ae8l49DBLrp/TyTcGyk46WdEdjUx6FKHNpKRhBw9rTaOz876P6OfK77iim7e1
 MddSYRqGP5ni4xD8KuRd7Of4iUtVDcB928Ak72Fey9l8UnhdViUomoJtetz5CqymXQZx
 cm8bRQqgdyv3W8lUAOyIl1xwy+R2keLecloC+YKhM73fSWIg+vNkHRC9+kmCT95+0VGE
 SklY3eRTKam9mcq1T3MYXaNEg85e44va9QEMcDPt70pZRvf9+aSc+e39nUKouD81ly+O
 kCYuF4Mxkn9szjWp0adK7dEvmbylf2/tdG/vtf/y3aJK+EmhJCyGFzzgCbeBXbQFehyt
 aL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m24GYwzOSVWU+XgAxv5NZs3essGtF+Xv5GVsT6y+oQ0=;
 b=E1n3vxe1zT1WhVOBlldmDjlMbbjFnCfq13R3IFQ5fNZfVAMjU3i8sJGw4/a8D1gbxb
 OiCvBMrFIaDe7J5WkX8uLhVL5B0EB+kXSgwSjR7MibgTpVDrZTX4PrCRnnkzu/mg7BFL
 ogkmHY1C2ARNFFA0UXptnIlflJ20ArzNL/ddDyXiU6xUl1O7Vb8F+rjWzr1XUe8FGDCa
 xK+nl2J3tFdA1vuFZpJjLh7xnDpUtsQRWbAHdTEr2zUyOt/N8yN++rCt842muMlpL+bn
 kIKqtVPAdcqh9ZVsyhWaWVSxQwieYFDA8vVACmi4uP/urWqtl9Q79h+1jF0iiKlMZJZY
 nBGw==
X-Gm-Message-State: APjAAAUwh0z0sVTIoi6H7HhXpr+swyrdDBEILLlAucCOVQgzfXqzs2+z
 ZHP4PaJcqP/EFzA9S5eM244=
X-Google-Smtp-Source: APXvYqxPPGBp3KYwUcU6vqfn1qJZSerBLkruC3uBx8UzrQIyDAYRD458ao+PQYaeLP+w76nr1cOfng==
X-Received: by 2002:a05:6830:15d7:: with SMTP id
 j23mr1517474otr.357.1580347494042; 
 Wed, 29 Jan 2020 17:24:54 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
 by smtp.gmail.com with ESMTPSA id v10sm930917oic.32.2020.01.29.17.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 17:24:53 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: Fix implicit enum conversion in
 gfx_v9_4_ras_error_inject
Date: Wed, 29 Jan 2020 18:24:35 -0700
Message-Id: <20200130012435.49822-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
X-Mailman-Approved-At: Thu, 30 Jan 2020 08:34:56 +0000
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
Cc: clang-built-linux@googlegroups.com,
 Nathan Chancellor <natechancellor@gmail.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Clang warns:

../drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c:967:35: warning: implicit
conversion from enumeration type 'enum amdgpu_ras_block' to different
enumeration type 'enum ta_ras_block' [-Wenum-conversion]
        block_info.block_id = info->head.block;
                            ~ ~~~~~~~~~~~^~~~~
1 warning generated.

Use the function added in commit 828cfa29093f ("drm/amdgpu: Fix amdgpu
ras to ta enums conversion") that handles this conversion explicitly.

Fixes: 4c461d89db4f ("drm/amdgpu: add RAS support for the gfx block of Arcturus")
Link: https://github.com/ClangBuiltLinux/linux/issues/849
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index e19d275f3f7d..f099f13d7f1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -964,7 +964,7 @@ int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return -EINVAL;
 
-	block_info.block_id = info->head.block;
+	block_info.block_id = amdgpu_ras_block_to_ta(info->head.block);
 	block_info.sub_block_index = info->head.sub_block_index;
 	block_info.inject_error_type = amdgpu_ras_error_to_ta(info->head.type);
 	block_info.address = info->address;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
