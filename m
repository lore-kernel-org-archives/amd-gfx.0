Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A0AC3DA6E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Dec 2023 22:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A0610E04B;
	Thu, 28 Dec 2023 22:18:17 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322DA10E066
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Dec 2023 22:18:16 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6d9ac0520b0so1544198b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Dec 2023 14:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703801895; x=1704406695; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=InjhV79RwxavLTIGIl1BlCHqZ5mQpy1MOMNGvhjV260=;
 b=c8NXJIAivQFcUhD7+g4QtN5/NkFnRcgPddybGoTKlwI29SyoQKARviQvQ9I9i2HIRp
 EpE6fbzMkWCOubh53QcNZyqDvQkhqFbXtgHgCvHZ5Nfg7PY8MjBMlA9RQ4l93YvsN5gi
 7hr/tMg7nJcvw6QaiXMySe/ZKGz+REqk7HMYfA+cO5aNho19lpak+BTBwzc9oT3m0FB8
 G6k9ERtZtzqUlFU4H90HsyfmWD4VK3Lw9UlChtWfsrrZz3KDTzxymWMF9tBpF9inw7BQ
 oKlkVmAPLi7CRK5rmBqAo/9i1wsNFSmEiTE1EuL+LzyKuadM9svXWT+aXn9/SFH7SaOK
 eO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703801895; x=1704406695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=InjhV79RwxavLTIGIl1BlCHqZ5mQpy1MOMNGvhjV260=;
 b=tMUVDZojc2UfCalFnoJ9ew7okyuiMw3CS1oyuewtYXTo8brZSBKPlaW2yacW+CROoo
 t3zQkEmJdPZfvzJOA/zL3s8XZNsTW4vHanixYHIrLa0Y9NS5ioL9zec3zi68Ppkxitbd
 88256b7aYsCMAXiXayFkhJFK0K589XraclgF54CAL9hP8y2sn5hR9FnjFwXMmqIXKlOv
 LiLclw5Q/wAjVZEMAaJlINSxga3kukSrlQ/pKSC7F9PKruiyvQ7ZKnTf3oAEML6gYMCk
 GZnmrDGcdXZV8aRHicFJ7qZEmqT6eTYeXVJoDOKfKDXUv6e6Ojp94cuBTt3V6gA5+aRv
 ET/g==
X-Gm-Message-State: AOJu0YyRYMP8VBXgSjJ5tLB8nY643zuZ3WMTvQOhZov0hysTUoR/g6R1
 G6k93jEcIxnpAGEpli5CHJA=
X-Google-Smtp-Source: AGHT+IGUp4hcBY6aIN7ZfTcUq6LNxYWzOwRiH6uQlnwbMg+P91cL4b8ysFwVyJ6UY4N1g45ExosAkQ==
X-Received: by 2002:a17:902:db02:b0:1d3:29be:efba with SMTP id
 m2-20020a170902db0200b001d329beefbamr7578127plx.18.1703801895495; 
 Thu, 28 Dec 2023 14:18:15 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a8c2:13af:e16c:ee4d:83e4:91a0])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a170902db8500b001d04c097d32sm14352542pld.270.2023.12.28.14.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 14:18:15 -0800 (PST)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com
Subject: [PATCH v2] drm/amd/display:  Removing duplicate copyright text
Date: Thu, 28 Dec 2023 19:15:13 -0300
Message-Id: <20231228221513.2069-1-marcelomspessoto@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

mod_freesync header file has duplicated copyright boilerplate. Drop the
duplicate.

Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
---
v2:
   fix the structure of the patch 

 .../amd/display/modules/inc/mod_freesync.h    | 28 -------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
index afe1f6cce..cc3dc9b58 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -1,31 +1,3 @@
-/*
- * Copyright 2016 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-
-
-
 /*
  * Copyright 2016 Advanced Micro Devices, Inc.
  *
-- 
2.39.2

