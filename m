Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8DC10F3DD9
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Mar 2026 10:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2004010E407;
	Sat, 28 Mar 2026 10:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="llZt98kd";
	dkim-atps=neutral
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2200710EF82
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 23:41:11 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7d77b179b52so2479654a34.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774654870; x=1775259670; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QAtDSZs50EeshBJ9P3Sdb8obeKvPVzY8hUsp0sxpj8Y=;
 b=llZt98kdH1vUnu5+phszopU264C9ZAqSc+n8I2Sw/l9/l3JfNmVEKP3/LzeidngH/8
 aPxLdJfEK8PaujpotwT5pSLqozVqvaV4wHKIr6u81qIYC9PlBPxOUoU0CiMmNCCO9yTG
 RopBQc87Miu5PJB4qPYK1Zls688J/HzVv5hH1NcBQcjqWoV4Cqn271vdfJQ+nJOzfnLn
 Npov7QfK4fbgBAekLb0rHSrFOxtwZ9ewgV8q/liJ36uToPgZwP2nOio6KfPmvPETELDD
 Y1qwowKGNjnT6vuNREonuKkzRltamcTtyXhv9yL+RDhee6hjR7a8hUUCBIl6pX/LK2uO
 wySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774654870; x=1775259670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAtDSZs50EeshBJ9P3Sdb8obeKvPVzY8hUsp0sxpj8Y=;
 b=ShQV3hTu6mKK82qQSlyUUH+bDdfDHzolsplHyEVQdXJ7Gb0087If6liFkk3rt39L0t
 1+AH/d1X7zZcGFMK7sXBuWRJdlkH8nOZrV3Ayxa49uMfXbXruIp/ODbo9b6h+7rf3/Z3
 AdCzA2QY7GV71BvDiLntAn/FAN0Q/Y2hnbYcfWIoDQNZHQ3MUIdM6rRpziCZDNcZ60xt
 Ung7LBEhUwV4qULIFe2Pp9QmwHwGDIl2S20bZIF/UNLBH0Oh2mJyMlBT8RhAJWMD2567
 19evLktnKOL8R7HiMHiFwYmxboMLrm/77peqt4Uhu+KKKsjcOhaLkBzz7vwOJXh/dKRv
 hykQ==
X-Gm-Message-State: AOJu0YyAoIIGKySDQYcp8lLcQrfXGybzRoxglcWZXlxrlz3sOPzN7KK4
 1oSoqO1bZ6AA2ivszHrzBUX86SqXGJB+BsGQDJO3p4S7Q/v162DuCAar
X-Gm-Gg: ATEYQzx1ZpjFf91yOyNo5vbCC1y8qRnpjN7+DEZRpMKMsZpj02vgj8Tya2XK13hBbQ1
 L+rHL7+AXO9HBwE14w+LYEEaOrsSagpEeU2UNvn/J7qtjgnW56JuJk7nq27YV3SVVekAJelQZbU
 lTKtAdWLOxxTyLTdAbnaLQFlv4lsWxoQlPomXlKRXoo5RvQcv9l8EPmP61BGNnOBntqg54ygX55
 /lwJBTCOHP/vXK5GmPIyRjg6SD3WwEBtsgNIsvvrWF9QMlE3cRA8aS9tdiFR+5rwSufA6JEwVYS
 Aoem75dRZDxkdCkw59eEjRD3pIEJ+RWN4b0yg6sVWldnITtfcwBrTSF5R6i7W3KABLWW0ja5Ovm
 GNAl0fkGYclYAoqEbLazGVkJgb1GZJvJmmT7jgG/Lv98OQiNaBvAMdDpMixFWbGitmOmhQNIUB/
 hA5+x/uBkHQ/VVTux0ppS4baWrlZ70FHaFL+k56FVkXO6kCCRIp0g+2hDf9W5vjKdIEGqC
X-Received: by 2002:a05:6830:4118:b0:7d7:d1f0:7493 with SMTP id
 46e09a7af769-7d9faed2cb8mr2537144a34.18.1774654869024; 
 Fri, 27 Mar 2026 16:41:09 -0700 (PDT)
Received: from Mac (c-76-107-126-43.hsd1.tn.comcast.net. [76.107.126.43])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a3b2e37sm529867a34.10.2026.03.27.16.41.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Mar 2026 16:41:08 -0700 (PDT)
From: David Baum <davidbaum461@gmail.com>
To: alexdeucher@gmail.com,
	christian.koenig@amd.com,
	lijo.lazar@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 David Baum <davidbaum461@gmail.com>
Subject: [PATCH] drm/amdgpu: fix resource leak in RAS error query on mode
 check failure
Date: Fri, 27 Mar 2026 18:40:27 -0500
Message-ID: <20260327234027.44745-1-davidbaum461@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Mar 2026 10:22:39 +0000
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

amdgpu_ras_query_error_status_with_event() calls
amdgpu_ras_error_data_init(&err_data) to allocate error data resources,
but when the subsequent amdgpu_ras_get_error_query_mode() call fails,
the function returns -EINVAL directly without calling
amdgpu_ras_error_data_fini() to release those resources.

Fix this by setting the return value and jumping to the existing
out_fini_err_data cleanup label, which is already used by the other
error paths in this function.

Signed-off-by: David Baum <davidbaum461@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c0336ca9b..3c7ac9c13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1515,8 +1515,10 @@ static int amdgpu_ras_query_error_status_with_event(struct amdgpu_device *adev,
 	if (ret)
 		return ret;
 
-	if (!amdgpu_ras_get_error_query_mode(adev, &error_query_mode))
-		return -EINVAL;
+	if (!amdgpu_ras_get_error_query_mode(adev, &error_query_mode)) {
+		ret = -EINVAL;
+		goto out_fini_err_data;
+	}
 
 	memset(&qctx, 0, sizeof(qctx));
 	qctx.evid.type = type;
-- 
2.50.1 (Apple Git-155)

