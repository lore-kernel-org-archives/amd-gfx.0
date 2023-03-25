Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242F6C6FD1F
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Mar 2023 13:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB1410E110;
	Sat, 25 Mar 2023 13:16:14 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55F0B10E05F
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Mar 2023 13:16:10 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 f24-20020a4aeb18000000b0053b78077c9dso683783ooj.12
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Mar 2023 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1679750170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yvrQXsxOcbWlHc/gBzB9tc6Mw6DtquHCVxxuCHy2pLM=;
 b=WlIhhDyN9chem7VpDdS0nSKQXQjBafwVr0qhMmfH0uSlrXDPbc28aDt4N8o1P3DZju
 7ZGHH8u04TDsPMcv0Qgp6vFWu6TIp58JFvN67ReJtSQB11NUR4OseORwsKlpAEIBrqSo
 l1LKnwQyUd7yDA8+Kd7znPkvd6yrEqgdd7rngFhtsk8ahiopkYNWlTf/82lsfl4FKa1A
 hsuRso2tjN9a69sl6L6G6gDbnndo9CcAaTpwq4jlLiOCWeDjicFyuVuZ0E3pD/K/dtDb
 BDH26xabS+AB2QvlTDRg40UWJ2Dk7DYw/HaAXGfrbRILTjUFAF3PphWN8aMgZ5E1g31Z
 grfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679750170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yvrQXsxOcbWlHc/gBzB9tc6Mw6DtquHCVxxuCHy2pLM=;
 b=rTS0+oW/02f3xE15tefDSuHlhVdI4CFJny6s2dTRW/6oWYp44SCoBPSCaUD7rlChQ6
 ASUa4LKLMsJXuSL6vha/1FuTIAaMQ1r6mmWfCRLRCXkkj12aQZBcPU2gz+5ijG7pGjKI
 z1LuSQvo0g7zTe8hBVosUMNEd7qengCMsntBW5bNQK8eSKXcO/sjUQoy7bbycc280Lew
 WAuqf+WZ/KbKnsTTqUsIIC8tMb7gsqRUNQSsnDS925Dry1jtjafd/2+lo4OrEijNvX9L
 WLYNEdEM8lTAh9IHrb0WvaGC6wlY+rupDH9QUdVr0C2QAahqpX1xqoAl6UkIjhOdwkTw
 qQRA==
X-Gm-Message-State: AO0yUKUiv+DFSltOhFTVFRILWVBBEED9CyQr7pmmhxCgKyVevdldty5A
 Qy1sHLW/1A71FwckADelrx7D/Q==
X-Google-Smtp-Source: AK7set+QeKau2HHuhsOv0Eg0JZIAdX7FzbBRRn1kqNKmwioOk+qn/JCbpvsmt6+ol8in4I6pbrXGpA==
X-Received: by 2002:a4a:4542:0:b0:525:a9a9:b44a with SMTP id
 y63-20020a4a4542000000b00525a9a9b44amr3349972ooa.7.1679750170067; 
 Sat, 25 Mar 2023 06:16:10 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a4aad42000000b00525398a1144sm9301369oon.32.2023.03.25.06.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Mar 2023 06:16:09 -0700 (PDT)
From: Caio Novais <caionovais@usp.br>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/scheduler: Fix variable name in function description
Date: Sat, 25 Mar 2023 10:15:32 -0300
Message-Id: <20230325131532.6356-1-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
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
Cc: luben.tuikov@amd.com, airlied@gmail.com, Caio Novais <caionovais@usp.br>,
 daniel@ffwll.ch
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Compiling AMD GPU drivers displays two warnings:

drivers/gpu/drm/scheduler/sched_main.c:738: warning: Function parameter or member 'file' not described in 'drm_sched_job_add_syncobj_dependency'
drivers/gpu/drm/scheduler/sched_main.c:738: warning: Excess function
parameter 'file_private' description in
'drm_sched_job_add_syncobj_dependency'

Get rid of them by renaming the variable name on the function description

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 214364fccb71..7db586e6fce6 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -722,7 +722,7 @@ EXPORT_SYMBOL(drm_sched_job_add_dependency);
 /**
  * drm_sched_job_add_syncobj_dependency - adds a syncobj's fence as a job dependency
  * @job: scheduler job to add the dependencies to
- * @file_private: drm file private pointer
+ * @file: drm file private pointer
  * @handle: syncobj handle to lookup
  * @point: timeline point
  *
-- 
2.40.0

