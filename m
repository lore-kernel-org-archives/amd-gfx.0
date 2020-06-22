Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519B0C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 19:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23BE92078E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 19:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQy5zGaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BE92078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DECCE6E0AB;
	Mon, 22 Jun 2020 19:55:23 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B066E8D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 19:55:22 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id y10so4872104eje.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FOWJlZLl7Ctf0BXVUFLfvGcXg3GEQu6yLrvLfkIlrRg=;
 b=cQy5zGajxu4LK13OStTGJpxqxZrTsQBspxwIf6KEhqe6mwgOF7DkDYg+wfsU7NzIBK
 2V5NrO5LhoahK2USMc5GUsJOCzY524ccyKHF+VMAW3Eg84+6cyCM4kC5c71w3NK5/Ocz
 GmlDd/ee7YvrZiB/Gh4dnmva28yf1s0aw5JQwB50VS4rUrJrB1FYP2A4ZGxDhajOrBUK
 4kcTPZos5m6n6P+Vxu/1okgy8j2kB3JuJGYvEdY/WIaQOOwyhSu5IK3qBjYMfUTr2vsG
 aqvgYlJKr0bR5J7WBIztzSGVPgoSNsH2wMSSGTXgrN8l7RqAk05ZXy7Ih8+x4/Acc+Mt
 tJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FOWJlZLl7Ctf0BXVUFLfvGcXg3GEQu6yLrvLfkIlrRg=;
 b=j9KsMAAX0ed1Pm83L0AgFvbolg2CKvDxsbiBg+Iad3X3wxoQNjfffV5z6+HOE4FnGl
 8QL4KcfuynbmLzBlEejE0SiY5/Ws/cLoExVENqVlPKXhZ6DZZD+A2RVJxvei6bL/8IDv
 p+E6fZH16aE4EHe74UUfhs6ptXcZqJfH5t029s1AHSbbLenlzBYvBY4VsLYgt0WEEQ32
 aJSrhKgAO/NXQHHKr7vaqpYHBTwSZWOz26Htw9zcgkNVey2V9CJMY+ZMWUnaACKpfFX4
 ejh9Uyw8n2UcAc5HOb6y/5/HvPzTRFtZRGjlWBRWuhF0hiFXyq1tBpdWqtHXJrHmfXS5
 8h4w==
X-Gm-Message-State: AOAM531UE1M/U0RRzUQW/0BKLPr9d36kAYC1+xg2Mz7hCfo/0aatvDSD
 3fTcB/Q0PfSqi1lILs8YYuR9X8UJC58bLQ==
X-Google-Smtp-Source: ABdhPJwbKl1GgisL/a1KB+69gIvY66RVjTQZdl6qiBToFN1GyO3s3/aKk6fxBH9Yj69WpmdDMkAq5Q==
X-Received: by 2002:a17:906:560b:: with SMTP id
 f11mr17722482ejq.11.1592855720925; 
 Mon, 22 Jun 2020 12:55:20 -0700 (PDT)
Received: from brihaspati.fritz.box (pd9567980.dip0.t-ipconnect.de.
 [217.86.121.128])
 by smtp.gmail.com with ESMTPSA id f16sm823744ejr.0.2020.06.22.12.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 12:55:20 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/powerplay: fix compilation warning
Date: Mon, 22 Jun 2020 21:56:44 +0200
Message-Id: <20200622195644.35797-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.27.0
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
Cc: nirmoy.das@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If (smu)->ppt_funcs->intf is not initialized then
smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32, &bottom32) and
smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32, &top32) will not
touch bottom32 and top32.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index b27d0b18eafa..d93f8a43a96f 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2371,7 +2371,7 @@ static void arcturus_i2c_eeprom_control_fini(struct smu_context *smu, struct i2c
 static void arcturus_get_unique_id(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t top32, bottom32, smu_version;
+	uint32_t top32 = 0, bottom32 = 0, smu_version;
 	uint64_t id;
 
 	if (smu_get_smc_version(smu, NULL, &smu_version)) {
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
