Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02295C001DB
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 21:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9425510E0E8;
	Tue,  8 Aug 2023 21:01:24 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20CD410E0E8
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 20:58:15 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc8a2f71eeso6531115ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Aug 2023 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691528294; x=1692133094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4mYS0E0S3XpBShTbT2N4ULzE/smbrejxctyKZkmYxrE=;
 b=fnsrIWtdT0z0cFi0yqq9DGs9hps2rgu+7OCt6DQTKclDznTkVtbSHQ01tBc1sL1NMO
 +vozi4FXMbInyy+/vhI31aGqoJEEPuoLtaFSETw8JvAUWdNiO6SwdnawFx9FtDOgkx7o
 lYQfiZqkqYBFaiOQf2BPhHkCc1VtBpjoIGp+5NBls/7IF/QEUWBXQCpnB5jBLPEn8Umt
 pM3jxMPPE/BYVftB1fKcqRqap04IJ3zSXwRzUV5M+cP3kM8UQuALIRqzZa6nHks+3gc9
 fR8IpeUDLx6gOJvFNZwJOmkkZ2TSKvOfk9n5FNh/CfON6bR/5fIPKdhGrQY4ZJEllYbj
 fPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528294; x=1692133094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4mYS0E0S3XpBShTbT2N4ULzE/smbrejxctyKZkmYxrE=;
 b=YrI7E6ZNaS1OUAz+lXVJ66Kwj8a1Gu6pWGUL7aOJUzzmZW4LuY5+mJQ1/bgHcwMXg1
 npFiBmoSpBup2omSTt0S9M8dzlTZhMa3i5mx3euzmpzJa51swP4Pri/+0g8l2QrkCmLD
 nCGGqDsDLoAq+63vEIe/rPcNzJqBSx2QT2eX4jNyNrp/ALBpLpHzxDmafCFqU+tS6QOA
 AL7WKNVBHlRibUetoVxvSkkJTGKy1nVy4kQ3xjEv/NAcE0AkkEWZB5FmxEO8On3auyvY
 PXcN1xoEL93ZjL2GvGE+ij1g5Xc+lx7wqbIkpnq7l6ztpanZ2tcz0SzygdIxx9+LPwKg
 TgkA==
X-Gm-Message-State: AOJu0Yzwqm78phvLZ/wPhooN6M/Oow8fhhlSiLT5T9wBp4a2NNvAcPfw
 5c7xITffTLRzKZVmgj8bvC8=
X-Google-Smtp-Source: AGHT+IGR7E6c3nQAovGoU+QWgAJA+H84RS2ofPzMLXFvA6z5cHclqENykRudtZlcOLkdn8ynLX8Ebw==
X-Received: by 2002:a17:902:f801:b0:1b1:7362:9a18 with SMTP id
 ix1-20020a170902f80100b001b173629a18mr732564plb.27.1691528294548; 
 Tue, 08 Aug 2023 13:58:14 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net
 ([2601:204:df00:9cd0:dc29:7938:e2e3:43a8])
 by smtp.gmail.com with ESMTPSA id
 w8-20020a170902904800b001b9d8688956sm9440692plz.144.2023.08.08.13.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 13:58:14 -0700 (PDT)
From: Atul Raut <rauji.raut@gmail.com>
To: Felix.Kuehling@amd.com
Subject: drm/amdkfd: Use memdup_user() rather than duplicating its 
Date: Tue,  8 Aug 2023 13:57:52 -0700
Message-Id: <20230808205752.23704-1-rauji.raut@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Aug 2023 21:01:22 +0000
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
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To prevent its redundant implementation and streamline
code, use memdup_user.

This fixes warnings reported by Coccinelle:
./drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:2811:13-20: WARNING opportunity for memdup_user

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2df153828ff4..51740e007e89 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2808,12 +2808,9 @@ static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array
 	if (!usr_queue_id_array)
 		return NULL;
 
-	queue_ids = kzalloc(array_size, GFP_KERNEL);
-	if (!queue_ids)
-		return ERR_PTR(-ENOMEM);
-
-	if (copy_from_user(queue_ids, usr_queue_id_array, array_size))
-		return ERR_PTR(-EFAULT);
+	queue_ids = memdup_user(usr_queue_id_array, array_size);
+	if (IS_ERR(Iqueue_ids))
+		return ERR_PTR(queue_ids);
 
 	return queue_ids;
 }
-- 
2.34.1

