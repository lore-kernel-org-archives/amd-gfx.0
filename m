Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA490C624D0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 07:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C658510E6BD;
	Mon, 31 Aug 2026 07:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SRgUBjrF";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26AD310E069
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Aug 2026 08:00:21 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso11151275e9.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Aug 2026 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787990419; x=1788595219; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/2eNcAW1tigTpuqgp2s8g1GYZ7f9AJxKWb3CPCC/1rU=;
 b=SRgUBjrF6jfPzrxsrOk6xHq0wSzeQmboafmehD872eTRnqS6M7igODICRQ1+RwRyZy
 sfNXbtG587amRXhPGRYn9JvNBr9NhfpeRr8vjFI3a64q451k28LG8Xs2WQjR9Sc6Ry33
 eFTK+6MA08tjqJ9AAKN1nw+loAblE7FaW6MIqbQ8WfDHfRh/dHRjZjYSJUC2ZvmETG5k
 rOzbKQnDiHieaMOW8SHcoFIHwEEQU/PjJh1KudnhtklW2huMOcxDoRiak44tzFvDfI97
 sDMJSsjKw4bzEE3d+pEHM3mYtfsvudoE4toVvsubOm1gj41c89hGq1yXmmCo5jN/EAwb
 OWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787990419; x=1788595219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/2eNcAW1tigTpuqgp2s8g1GYZ7f9AJxKWb3CPCC/1rU=;
 b=IkV3FVZ1hTuBchG3n0bJIKyt+OQGwaRcF9TXE+6uFKujiqY7uM+h0u8u9SDacu8E82
 HlHgEukatIJdL9s4lfshOenIcpCrA39dmF5v2j/Cgaek9TFhiVV3G74lg1NlY4fpyBJD
 80fXpm2dy4NqUeadBdmIembG9MFU18yOaQIm5nn4YIRoW2XwmuP3/Q14WUOhNQk+fGtx
 HBZ9AADsNRKhv80eW5FQ01JRERaUZ9u8t0mbqbWEW1JRDAswTgsTAer84PfzzN4akiYf
 YAhysPBc3PqIzKztiOto0Cd/Amiw2t9Vwyh5qiIu/ehIqf9IbPuAQBGQnG3DFRqwSZb4
 ryJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYJzfnd1E9aOqbkplWiKwi3fkb5j7ql3eJfKJO2iBkJK+q6U0RTIn6G+O8m0wED9IXQbs2B7qZ@lists.freedesktop.org
X-Gm-Message-State: AFuF++kLf8jYn3g8v43URtukcpCiSX/QWQuWlXPgVDxsuJbOBxw/0ZEc
 p/g+6i26V5qpeXMJBGqRUHCYYtoYcKRsV1F8ZXV+rIUHCbBNJlCHbzEF
X-Gm-Gg: AR+sD12wesP3XYhmoNAliBbLJ2UkatVmN3vkIasG5TywKuRkKNDl2URT0e6LiXF84PO
 wfr8Tk6EJW8bKGwcJg/BvsdTeBOQk5kcSzf2fju8dHr+m6kqc9LLth8lyW/of+bWFum26r0terP
 LGNWyYEeRj3WHRFpNtS/i10P+W2iTfaiIIV4j94/q54jmnuuriQdoYmbgnVrDpU6TrL9XhE7rgB
 5KIf4kIapKLBUgykiFY/sVaTGUBWvfdrC+ZgMXN1uSsOsNillqNhcxd1t4j5S8JoBDYOaFzqG4j
 SDZwzLBrvp1oNlBrPbiE07mfbm7ljdZHkOLOTyHq02ZLfaoX0BnJvLFG1POkVecHp7WRIPE/Lav
 ZHn1SYnhicm86dEiRk59DuDE6K4jjAzjCQCxXj3GSpTaIu0XDcCHV28JJhJjPAj0Al8NWkl9Ud2
 oxQwhwj0dEI4Hawyz7++5Aa57nD99TqYsZnnEfAVB56/Q9u+oSuMJZdEXHjVpA5HhUSsW+tUxa5
 C7pTPCHzbQIKsxhD3KNfpNeFJF6NnoF026tpgjY5AYNPKWLXRmad1Ur6LBKvKmyZQOSE8e8AQ==
X-Received: by 2002:a05:600c:620e:b0:49c:c0d4:53d9 with SMTP id
 5b1f17b1804b1-49cc0d4545emr106478415e9.14.1787990419277; 
 Sat, 29 Aug 2026 01:00:19 -0700 (PDT)
Received: from drago.hgw.local ([2a00:1d34:e90c:f900:e29d:3a79:ac40:9edd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b945816f2sm136345955e9.8.2026.08.29.01.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 01:00:18 -0700 (PDT)
From: Deniz Aydogan <denizaydogan1902@gmail.com>
To: lizhi.hou@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Deniz Aydogan <denizaydogan1902@gmail.com>
Subject: [PATCH] accel/amdxdna: fix NULL deref and GEM object leak in error
 paths
Date: Sat, 29 Aug 2026 11:00:16 +0300
Message-ID: <20260829080016.10002-1-denizaydogan1902@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:04:50 +0000
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

amdxdna_cmd_submit() does not set job->cmd_bo for internal driver
commands that pass AMDXDNA_INVALID_BO_HANDLE. If arg BO lookup fails
after that, the cmd_put cleanup calls amdxdna_gem_put_obj(NULL) which
dereferences a NULL pointer.

Separately, amdxdna_cmd_set_error() acquires a GEM reference via
amdxdna_gem_get_obj() when handling a chained command, but leaks it
when the subsequent amdxdna_gem_vmap() returns NULL.

Add a NULL check in the submit cleanup path and release the GEM
reference on vmap failure.

Fixes: 3ba13f5e7180 ("Merge tag 'devicetree-fixes-for-7.3-1'")
Signed-off-by: Deniz Aydogan <denizaydogan1902@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 31a414c3f..c0444454a 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -183,8 +183,10 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 		if (!abo)
 			return -EINVAL;
 		cmd = amdxdna_gem_vmap(abo);
-		if (!cmd)
+		if (!cmd) {
+			amdxdna_gem_put_obj(abo);
 			return -ENOMEM;
+		}
 	}
 
 	memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));
@@ -676,7 +678,8 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 put_bos:
 	amdxdna_arg_bos_put(job);
 cmd_put:
-	amdxdna_gem_put_obj(job->cmd_bo);
+	if (job->cmd_bo)
+		amdxdna_gem_put_obj(job->cmd_bo);
 free_job:
 	if (job->mm)
 		mmdrop(job->mm);
-- 
2.55.0

