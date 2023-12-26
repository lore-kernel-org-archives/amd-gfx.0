Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B48C46CD4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Dec 2023 23:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA3010E0C7;
	Tue, 26 Dec 2023 23:58:07 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C219E10E0C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Dec 2023 23:58:06 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-204a16df055so1313739fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Dec 2023 15:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703635086; x=1704239886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sKLb6QUfTXgud/VtKXnOV/9k3TJuEg6F3AFWXrpck2o=;
 b=iZbjHKSX0450tUrNsoD3swiaohK12hZTa/wPHRELp3+vwVTwd1uaPdDug2DYlYktXF
 iAu9HtAJfkmn9JGYPAbm1l8PL4OBpes0l6D6yhE0Iiof9tb0wqPWzjwWgg4nl0IPl/no
 M8VK7RuT0ojPyNIcIOK64HLcDJQeDgUcY0n9KsBilCpnpfrKKz1UCmTa1LF9pbQS3pCo
 4+dknJDORywAu25uHg3vgs5s9Ka+Z6/QT6WirgHcyI6yGMNvmCwsDBOy7wzIZ9+qZZtP
 /gniCNUY1ITZLFyA/JhitBKMkB2K/JVb4qAzkY1xPdDKfkD4JCbE/Mhij7ru9r2v0cSe
 ZJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703635086; x=1704239886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sKLb6QUfTXgud/VtKXnOV/9k3TJuEg6F3AFWXrpck2o=;
 b=XE7cXJ7yX8R5Nzw/3LVWE6Bl1C3frFSTFXOgv6jZVQe5ScE9Sx72KXBQnR2+Zrz3w5
 3lzdtSSLp2E2zevm5DKANJ5E9yEpTy20pJeVNQ26n810skDynMsulkStIZErKSFP4zpF
 pbYtiOGRqwEhsieCXbQEYR3kLQVHORtNC2pZnxflArMRNpkVgpr8fOLUWGcYu6BhzZgo
 qRxgGik1P7Svxyh4/Xm5DirFe+geBJyFBI2EYW6lBPD9NWIcFaL20J9STJ1Y58X0UVel
 uuK37mP4lTTlGJVKyqhT7cb6aDclB7Znq+0ekd+/q3VKgxTsLFMiYhx/8sondjOWQiK/
 7sSQ==
X-Gm-Message-State: AOJu0YzOCg6Mek3OaJDTGtm9S9Wq5dY34i/2kSRXTAMsnwezLzDwLANu
 JsnYYLU9yrARguhGtzBl7qI=
X-Google-Smtp-Source: AGHT+IF7XZOF9r7muKQC5uWE9eCXiTZ5beeVqUyQ1/cpXaQw/IsAnYteKe3sa6Lc9vm3u2XB/Notpw==
X-Received: by 2002:a05:6870:440f:b0:203:efb2:edfe with SMTP id
 u15-20020a056870440f00b00203efb2edfemr9515645oah.53.1703635085758; 
 Tue, 26 Dec 2023 15:58:05 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a8c2:13af:e16c:ee4d:83e4:91a0])
 by smtp.gmail.com with ESMTPSA id
 u33-20020a17090a51a400b0028bdb4cc5basm9459898pjh.0.2023.12.26.15.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 15:58:05 -0800 (PST)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com
Subject: [PATCH] Removing duplicate copyright text
Date: Tue, 26 Dec 2023 20:57:41 -0300
Message-Id: <20231226235741.4376-1-marcelomspessoto@gmail.com>
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

Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>

The file display/modules/inc/mod_freesync.h has two identical AMD
Copyright texts. This simple patch aims to remove the duplicate one.

---
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

