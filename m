Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6557DC001E0
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 07:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1F110E24E;
	Wed,  9 Aug 2023 07:14:53 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C2D010E232
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 05:30:43 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-687ca37628eso1866329b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Aug 2023 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691559043; x=1692163843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jqVBe5pt9GZ7aYDqfwkD/WWrE8SCWRSIo2SjG3OVAgU=;
 b=MM7eLh7HIOK4VQ7mjvl2km+GxCVraxI3FmtGC/e1X2dlLHwM2wunzn0PO+39GW7XGB
 xYNheiS7f/b0DBUVWJLT+uSRKTs5Opoy5211SCFtPyrRspa8BbSjcq1V+nDofiWqI+jl
 ArdNg4OSo/89hx8QQRXKRV9ycRGdIEnzg2zlfHCGotYUJ1nq4Rh4cWvV+gCaLnnD5JWd
 rc1aWa3En8/OLn/pDEev6iep/0ZT2RXMU5tXzWxgnnDeyz2Is0CP/lQDHxTPz5kEZwd0
 bdZwToWnkeIEwhdTYcHCey4kJJXxIhdgXWDQeYK04ose9NlVPINiu06/waL5RuKHRDbI
 HW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691559043; x=1692163843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jqVBe5pt9GZ7aYDqfwkD/WWrE8SCWRSIo2SjG3OVAgU=;
 b=T3EJRlKoZQsrHE0TjhHR8Ax6Xtih3At7U2ocegvpzkHKi5huE/HhKnC6Ru8vTN1Wa+
 1A3/KpDbgstOxErYtOXRTDAq6RA4pFB6POgOzKPnE5D7FwYaWo/YTQprr/gtQ/GSKa6f
 MxmCh+yD0ggAxPP1TZLjgR0yGxenQD1Y+D1YN8gulUbFq+wT29IN4kTSIIcM5C2Vn0nt
 QR1LqRmgHGK6FFyNtp7lpQ3CmmjBpb3CcBbDumruAIAeXzaFAxNyOk/ou8+t6LVWx8TD
 XOWiE2HajbEaurNL9co6WRUpsj6ASPyAamVX6I6qgk53cyvqvnPcTi2f7+jLVtwSgdwf
 2bLg==
X-Gm-Message-State: AOJu0Yw9y1in8zUJCQ1dGxB34A+VZAbW7N+Zo4y33Q+d2Y226MGe20Sc
 VAfsR6k9uFMEKpMbgvN4aBgOJ9EWjr7J4g==
X-Google-Smtp-Source: AGHT+IF8YXJ5+u1OlAQhMTZIOC/FvpTkv+YYhZbdzEmzkD6hXk2WE0zkQSSRVA4O3SYOMJGDlXJtrw==
X-Received: by 2002:a05:6a20:3251:b0:13e:e053:1050 with SMTP id
 hm17-20020a056a20325100b0013ee0531050mr1475021pzc.56.1691559042883; 
 Tue, 08 Aug 2023 22:30:42 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net
 ([2601:204:df00:9cd0:d26e:9bde:5e8b:6cb6])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a62ee10000000b00686940bfb77sm8986255pfi.71.2023.08.08.22.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 22:30:42 -0700 (PDT)
From: Atul Raut <rauji.raut@gmail.com>
To: Felix.Kuehling@amd.com
Subject: [PATCH v2] drm/amdkfd: Use memdup_user() rather than duplicating its
 implementation
Date: Tue,  8 Aug 2023 22:30:18 -0700
Message-Id: <20230809053018.88004-1-rauji.raut@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Aug 2023 07:14:50 +0000
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
v1 -> v2
  caller checks for errors, hence removed
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2df153828ff4..df9b618756e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2803,19 +2803,11 @@ static void copy_context_work_handler (struct work_struct *work)
 static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
 {
 	size_t array_size = num_queues * sizeof(uint32_t);
-	uint32_t *queue_ids = NULL;
 
 	if (!usr_queue_id_array)
 		return NULL;
 
-	queue_ids = kzalloc(array_size, GFP_KERNEL);
-	if (!queue_ids)
-		return ERR_PTR(-ENOMEM);
-
-	if (copy_from_user(queue_ids, usr_queue_id_array, array_size))
-		return ERR_PTR(-EFAULT);
-
-	return queue_ids;
+	return memdup_user(usr_queue_id_array, array_size);
 }
 
 int resume_queues(struct kfd_process *p,
-- 
2.34.1

