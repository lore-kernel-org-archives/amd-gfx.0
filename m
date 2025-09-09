Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E84ACAC58D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 08:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D363310E892;
	Wed, 10 Sep 2025 08:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eJ7teZrE";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC96910E1AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 09:21:13 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2445806e03cso69165585ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 02:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757409673; x=1758014473; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgYXDmNS5TPYvh6DaUTaZYQ5qn88r6ADOa7zbs+TQrQ=;
 b=eJ7teZrElQycQvmJu9m/kL/tP/s83yEsN+lnJsxgNOZ6fxdJfaj6lkB3DxV3aiJl6F
 bMvId9QUQgwqSP7gy7DHquwfzWUTRwbE5xoJDdUJKd4T8tNSJ1EZa85OG0/kcFYqXKTm
 upEjF61T9fKOCmwTCRhPjub3xtftEcwDPxdlvUlj0NBUWVpjqyk7doG9eGx1KvUo00Pj
 c2HJC/9u1QjzgsFobhnLmjOVRBKMcIqP2DU6ksXIL5bs00QQZGo0HhAezF/0bG3PbLBL
 W0LkcBioDaN+IeQ0IkVwWgfqowC+YniYtWO3DNM2v4hs8zaYTPZGCMiFP8ujfKgWuIih
 ceUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757409673; x=1758014473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MgYXDmNS5TPYvh6DaUTaZYQ5qn88r6ADOa7zbs+TQrQ=;
 b=H6tLghZamql9CQoaGkNomtRKO7GSvtW9AwjhzYiBlOa/4YZhG1htwKkIl/pubt/LSd
 soApouoVB92Xdw3G+/WoMaWAfoXVwNdGSCplK6fCpxgKhmt8822JfnOLck1n8UY6Vfj3
 sjVdz+wVUfpY5tU7NkOvGpD4N8gRDs8cvdvRN7/EU0CJTVNNKrv4aFIEpCgxCipL+CkQ
 oJEAyHmvmPJBNare9r/NHef8bTPOTQShgHDDK8pdKmEWyTWRWF+fdb5hJZQzWZvyCbjb
 lQJj1Dp2r9BM9z7SwoWkXmuMutbiaw5w7IbrSkdwBa5Ytjx1sqYvtR4zZVWvXeamEu7f
 hWLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKT9f7gcqxmUI3k0GdCT+kKb6QFzJW8idANIsnJCt51TPSTRfILiDJqe4FFxYPrA6qpRezsy1y@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6gBUI79LQlqQtA145rDcAumnfjMnNTdmMKj2D6jXixV88f4zP
 iXNYt/veLLUxK9UQ3ruvnpZaMlmLCJVdXoymzmt7LHfNdMu+Ttv5skzg
X-Gm-Gg: ASbGnct4L9Fx9joP+zbOAtzDZ1enlEJ5hYsyrWU+TPKQW8CHzERGbyapSJXFcP9H3jh
 PYmWX0x1xOehH+gpmdKcuAuWgGabMmrtFhUYty8kLKQbQm2rPu5Ko8UKfB7X6sGnvHQAESnn0XF
 fOLEfjOzVV90QUocJqsCMZKAgQl8ZBtOpQS1xGJ7AncCVOHlyZBCqAeSjv2EFYU1DmnRNEHSwlS
 3B1STNjloprEgQfHzl9TQAw3PtgBRjBK5izAmbyaqbcGUBt7dD4ZIJgD7IuD5at/U4XBbj1NRED
 7JakfzGXUbeF47Pxf5qnL3PfzXomDn3qMTxzSrWM9WTV4AS/lirf2cnRxaoN5KJHJ7/wbNa9tWD
 oliB9vn4SWK8JDmmk8i1wMCHlK4PXOfK114CiC6jMWTSm1Io8ev8AuUWc1F90uqZQIUmo9lk1Ze
 uMmX+EJcE4
X-Google-Smtp-Source: AGHT+IFdcm+mr14A3IwT0n08p0oRz5nQAIr1eSpJ3PkFHX08AqwueO/aLVNQTRumMCN2+FK+josA3g==
X-Received: by 2002:a17:903:19ce:b0:249:147:95bb with SMTP id
 d9443c01a7336-2516dfcd7ddmr127430655ad.13.1757409673219; 
 Tue, 09 Sep 2025 02:21:13 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25125d76218sm88522165ad.119.2025.09.09.02.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 02:21:12 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com
Cc: chiahsuan.chung@amd.com, nicholas.kazlauskas@amd.com, wenjing.liu@amd.com,
 jserv@ccns.ncku.edu.tw, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 2/2] drm/amd/display: Optimize remove_duplicates() from
 O(N^2) to O(N)
Date: Tue,  9 Sep 2025 17:20:57 +0800
Message-Id: <20250909092057.473907-3-visitorckw@gmail.com>
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

Replace the previous O(N^2) implementation of remove_duplicates() with
a O(N) version using a fast/slow pointer approach. The new version
keeps only the first occurrence of each element and compacts the array
in place, improving efficiency without changing functionality.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes from v1:
- Add early return when *list_a_size = 0 to fix a corner case.

double arr1[] = {1,1,2,2,3}; int size1=5;
remove_duplicates(arr1,&size1);
assert(size1==3 && arr1[0]==1 && arr1[1]==2 && arr1[2]==3);

double arr2[] = {1,2,3}; int size2=3;
remove_duplicates(arr2,&size2);
assert(size2==3 && arr2[0]==1 && arr2[1]==2 && arr2[2]==3);

double arr3[] = {5,5,5,5}; int size3=4;
remove_duplicates(arr3,&size3);
assert(size3==1 && arr3[0]==5);

double arr4[] = {}; int size4=0;
remove_duplicates(arr4,&size4);
assert(size4==0);

 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
index 2b13a5e88917..1068ddc97859 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
@@ -50,18 +50,19 @@ static void set_reserved_time_on_all_planes_with_stream_index(struct display_con
 
 static void remove_duplicates(double *list_a, int *list_a_size)
 {
-	int cur_element = 0;
-	// For all elements b[i] in list_b[]
-	while (cur_element < *list_a_size - 1) {
-		if (list_a[cur_element] == list_a[cur_element + 1]) {
-			for (int j = cur_element + 1; j < *list_a_size - 1; j++) {
-				list_a[j] = list_a[j + 1];
-			}
-			*list_a_size = *list_a_size - 1;
-		} else {
-			cur_element++;
+	int j = 0;
+
+	if (*list_a_size == 0)
+		return;
+
+	for (int i = 1; i < *list_a_size; i++) {
+		if (list_a[j] != list_a[i]) {
+			j++;
+			list_a[j] = list_a[i];
 		}
 	}
+
+	*list_a_size = j + 1;
 }
 
 static bool increase_mpc_combine_factor(unsigned int *mpc_combine_factor, unsigned int limit)
-- 
2.34.1

