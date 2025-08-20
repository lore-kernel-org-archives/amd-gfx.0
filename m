Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F44CA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 12:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C454F10E25D;
	Wed, 20 Aug 2025 12:32:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YI3N7AEx";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCDC910E163
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 04:29:40 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so554166b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 21:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755664180; x=1756268980; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zYdMpU8vMjvK2DOSIHRQXqU5/Lf0GAx2OK6XP3SZnEs=;
 b=YI3N7AExZYjUWnKluMed11o/OT2mQ0HwD4LkXnz8f1wKnB3Dvu5AycCVvtRwdBciz3
 20zyfWw+QJ2bXl7afGL7MlUsjk/aW/6av+LcjNBZ0//1jS2Pt1Rso/bIQR6pXWn7I1eb
 QeqIqL6JHT89oqf1p688A1j93LlEijmTnSgicm9HrJNACU5zQ2Vbzdf5r1MhqOtkgdwg
 tIg9uxx/2Qt1mSl3k/Bg6oTkKjil2U+YBq7OzKpr/2BDoFaG5PoWdOqq7SD9x6n+z1ol
 WJRQI/sfVX3QTuTZBQz5uvyILvQxiTiIR5MYieW8Zbje2UJM7iWaWyaQZLgqWV9Ozs22
 G3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755664180; x=1756268980;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYdMpU8vMjvK2DOSIHRQXqU5/Lf0GAx2OK6XP3SZnEs=;
 b=I16Z+1AyyEVMuMLfB10yKDmz+aWIg1jo+AgrtfqHb5YoEzJ73fESxFgnCumglq/bIb
 0HFfkDlOpBY7CRGq2ekF+cHGIab1AvR4uu/AqWKQGwa5YEu8o5MNYyQjVfOfgEKBJT4l
 X05BR1lf7TsYIc3txeXpY+BD7gov/F2j05vutZ48iaB+q4Anjae+mMp++K7lJEJJOBpr
 /qYWMyPtozsLdwkHDcyTs5WnFtHZZh20oTdmKJeZsEF53zz8TG1v/ZbsCJsckWt6+Aq7
 GGXeOVXERpx6+aYJ9aR0YcqG2ILr5yPQHjSK3t+5WC9aCTpN/6FzfFBqizRMoXLBTB0u
 5Uxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/OG9BdeWoQtNzLA65yxTsJZyo9TUu2PY0cJeYcP/Y020oYfqOMk3xElgDDJofISJ4fHpbXbZ/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7tkfxvbsrQKlEoDbIj5iN4ugPV6042ggrN4dv4lgqxMrwIvgC
 cSjd5SRGPhgtSj1EJJODjdsaer5hzYGbZRmdgrv/Yic6WI2hI3doDiX9
X-Gm-Gg: ASbGnctkH8DvHJR3hXvGtic27Btded9dt4wbCjhG+GG2d+c8w2GdVLCZtc3/rfi0T8B
 GHqjRTx0DtrfJgrdY0eYeaMJ+mdZG3JIyRPc2IER34kQSKxFMCt9ablamWFxAqDSeHN4kEqGClT
 ZLRppXI5tccdoaPFsdIhbdKRDnpWXpCKZ7mfgiwIz0gMJIWQTLQeXUnnEtUVnoUrbWVPUtrEHqK
 co+mqtdle7mnomDwKs9A/2cOcSGrNU8XTMQRFoXHTbI+aonGyDa7s3spYFNGC+t4eFOqc6RXalU
 0+6rv2oQ1MUnNOX3QtN7Ka2KHinTPYjQwIDbdFRTqXoRw87hfh1QKnrlK9Bo160o5u/XeDz3JA+
 /Brvz2IaPzY4eEC1FmoAODy9r6Nog8OzwMn3K9FjO1X46pjA/jw==
X-Google-Smtp-Source: AGHT+IHF+rjqgbLfRW+bQuDEElr4xApCdVU0xbOq6N+xH763334TwG5tSwmdgIyqdHYlkb8aoiMetA==
X-Received: by 2002:a05:6a00:14c5:b0:736:5969:2b6f with SMTP id
 d2e1a72fcca58-76e8d6163f6mr2099243b3a.6.1755664180252; 
 Tue, 19 Aug 2025 21:29:40 -0700 (PDT)
Received: from localhost.localdomain ([202.164.136.133])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e7d5513fcsm3939537b3a.111.2025.08.19.21.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 21:29:39 -0700 (PDT)
Received: (nullmailer pid 63721 invoked by uid 1000);
 Wed, 20 Aug 2025 04:28:12 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: skhan@linuxfoundation.org
Cc: corbet@lwn.net, alexander.deucher@amd.com, christian.koenig@amd.com,
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Kathara Sasikumar <katharasasikumar007@gmail.com>
Subject: [PATCH] ktest: fix typo in comment
Date: Wed, 20 Aug 2025 04:24:45 +0000
Message-ID: <20250820042444.63439-2-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Aug 2025 12:32:38 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct the spelling of "usefull" to "useful" in xapic_ipi_test comment.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
Hi,

Submitted as part of LFX Linux Kernel Mentorship (LKMP) task.
Thank you for your time and review.

Thanks,
Kathara

 tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 35cb9de54a82..d7abf9a91b65 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -17,7 +17,7 @@
  * amongst the available numa nodes on the machine.
  *
  * Migration is a command line option. When used on non-numa machines will 
- * exit with error. Test is still usefull on non-numa for testing IPIs.
+ * exit with error. Test is still useful on non-numa for testing IPIs.
  */
 #include <getopt.h>
 #include <pthread.h>
-- 
2.47.2

