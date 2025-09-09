Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DE2CAC58E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 08:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA23A10E884;
	Wed, 10 Sep 2025 08:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hj5ND5jP";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E79B710E1AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 09:21:09 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b4c53892a56so4765348a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 02:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757409669; x=1758014469; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKDAJyjAQ049TwS7OG7Kz3OMIFj6KbuH8cGsBEe0hLg=;
 b=hj5ND5jPEiLw/3NJzx6wd9ecLR1h2XLbljjC/CNoK1T3leSJC8h01FYEjBWHqlpHG6
 ZgMURHYOqxelRMsHWY/HJGpbPId9DO3pbUGsmJ8ohY2FL73QAZsRypsyVcJoHZjDNOq5
 3uDzsRqUi1h0WCjDicDli1QRBdFuJWq1v5whv+pFnEgOlT9oRxMqIYAUz0KF9BdyVU+O
 52EjHvSKIKQJfC3+rNdePPKRm/05lk0nC5rBLVpjQ9KKlt3fhdLSzM+wDM3cebnVDTpW
 cFJ2kslCAZ9Hh6C554Y5m//M2luv7777j2j17PwmJaGuygWSR7lXjNcDevUUMFmDbAp2
 eQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757409669; x=1758014469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKDAJyjAQ049TwS7OG7Kz3OMIFj6KbuH8cGsBEe0hLg=;
 b=Wc+gDFYcHdj05Y4tPeIoldmpqqmOqhRlgQngZDTkLTNAinpJozS6m6lPSiuv+ReQgm
 IEIW/sv5oLT/eGPHdZgUE+LzAY2tkGLkHP5o6bf4lSl0//cQfmwq9iS1DPxwsTYIdQHs
 Mo6x0oGKd3YWZe5iTDCWu5qTp33qxT1uqujY+Lc13tOrLUvJeCq/7pzITbQxfJywv4IT
 vIolGXYkYN4zVgaWnMjWyhjvUlQODuXuOrp9b+KN9BpkrvDiQyiL0CH8W7qFEzXUiF/3
 HgtVmzUid83Ufp3HWjCWqzHRZYjCzRmEGW4mZz1F6T6EiOVs7M4mZQyttgVS+u1ahWgm
 eiqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNdAVdCJP564v7YDR+Ic5n7MutwQ3AS6uWVnVxWBd1f+DRSi+Kj0Ofzw8U/IQAXbc8yI/DEWUd@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywhlp4+It/9mmdAHQRQTc6ik38D1V0NKJ0WeP4Pfc2+p6VYxq6e
 fYl6b2DUv236NxoHcTsUZpXJPwFC8DS4gWxIdkg663gpVeAP95ohZEYk
X-Gm-Gg: ASbGncvbjMxFPeEJeEVQ9tG3zU4RU+jdnE2HfjvxDBMx5RxcRwy18yHNvjl5X5NmgIz
 qbayfZEQs3gjEj3mwhAhBpddZEy02la/43+q1VEOLpH0jFgx0ugyKVxsuH0dbzU234jbpuFEKnd
 lIComEkqHVZ78sOhTb7YtaHpz7wmTzNCeqKVnEs2rIgbvZCG1p1puLdLihEpDMHnE57/oWoEd3F
 Gauy4c2/zcw98M2K1+clvB8u0LEB5D4QKCGZzuozmmjNomXp7SL96dOnzApyHYIoOUcjSbhBDGH
 r/aOpZYD8ZZQ3tlMbjX9/EoYCRK+63RyRMt465f1hc70N9TIuyFuTTUD0SWEO3i0dDU080sBGaA
 A3EfacH1bZXomHoAYZ7TZK9/Zdq8+xMAPrfct3JG3IdFoGaiPvwGSlu4tnlSWhjE=
X-Google-Smtp-Source: AGHT+IGaOl1wQ4PxTl5LanHyvvod2ptDH/j57RDM1rdkSlxdHYHqnMJKyWpfZPuecG3QE0g5+Xjegg==
X-Received: by 2002:a17:902:dad0:b0:24c:e3bf:b469 with SMTP id
 d9443c01a7336-2516fbdb555mr171735475ad.15.1757409669303; 
 Tue, 09 Sep 2025 02:21:09 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25125d76218sm88522165ad.119.2025.09.09.02.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 02:21:08 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com
Cc: chiahsuan.chung@amd.com, nicholas.kazlauskas@amd.com, wenjing.liu@amd.com,
 jserv@ccns.ncku.edu.tw, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 1/2] drm/amd/display: Optimize reserved time candidates
 sorting using standard sort()
Date: Tue,  9 Sep 2025 17:20:56 +0800
Message-Id: <20250909092057.473907-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909092057.473907-1-visitorckw@gmail.com>
References: <20250909092057.473907-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Sep 2025 08:01:12 +0000
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

Replace the custom bubble sort used for sorting reserved time
candidates in with the kernel's standard sort() helper. The previous
code had O(N^2) time complexity, while the generic kernel sort runs in
O(N log N). This improves efficiency and removes the need for a local
sorting implementation, while keeping functionality unchanged.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes from v1:
- No changes.

Compile test only.

 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
index e763c8e45da8..2b13a5e88917 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
@@ -2,19 +2,21 @@
 //
 // Copyright 2024 Advanced Micro Devices, Inc.
 
+#include <linux/sort.h>
+
 #include "dml2_pmo_factory.h"
 #include "dml2_pmo_dcn3.h"
 
-static void sort(double *list_a, int list_a_size)
+static int cmp_double(const void *a, const void *b)
 {
-	// For all elements b[i] in list_b[]
-	for (int i = 0; i < list_a_size - 1; i++) {
-		// Find the first element of list_a that's larger than b[i]
-		for (int j = i; j < list_a_size - 1; j++) {
-			if (list_a[j] > list_a[j + 1])
-				swap(list_a[j], list_a[j + 1]);
-		}
-	}
+	double da = *(const double *)a;
+	double db = *(const double *)b;
+
+	if (da < db)
+		return -1;
+	if (da > db)
+		return 1;
+	return 0;
 }
 
 static double get_max_reserved_time_on_all_planes_with_stream_index(struct display_configuation_with_meta *config, unsigned int stream_index)
@@ -634,7 +636,8 @@ bool pmo_dcn3_init_for_pstate_support(struct dml2_pmo_init_for_pstate_support_in
 
 		// Finally sort the array of candidates
 		sort(pmo->scratch.pmo_dcn3.reserved_time_candidates[stream_index],
-			pmo->scratch.pmo_dcn3.reserved_time_candidates_count[stream_index]);
+		     pmo->scratch.pmo_dcn3.reserved_time_candidates_count[stream_index],
+		     sizeof(double), cmp_double, NULL);
 
 		remove_duplicates(pmo->scratch.pmo_dcn3.reserved_time_candidates[stream_index],
 			&pmo->scratch.pmo_dcn3.reserved_time_candidates_count[stream_index]);
-- 
2.34.1

