Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50B4C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 14:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCC910E1DF;
	Wed, 26 Oct 2022 14:21:06 +0000 (UTC)
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3E57410E26A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 10:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uVhyx
 g9tFqJVC+JXQX6McT29RjtavAh5YjVtvhZD9RY=; b=kDaOuCV1QSjaab0OfFAq7
 IxoBo12DuJGfUT3HPHk2XfbSNSPxBQEPpodLz/8WQKoZKECuBMnnacRmV8Tp+WGc
 M5Wzy+PoqfDI0ENN+eNV9IU/8bTJbBvlzsnmb4ynCcSmeJzqPIzJIg7TXiqqoxYq
 O29lh3X+lDxMJ46A5weMOw=
Received: from localhost.localdomain (unknown [111.48.58.12])
 by smtp7 (Coremail) with SMTP id C8CowABXQ_gvA1ljHKFvOA--.47014S2;
 Wed, 26 Oct 2022 17:51:44 +0800 (CST)
From: gehao618@163.com
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, alex.hung@amd.com, HaoPing.Liu@amd.com,
 aurabindo.pillai@amd.com, amd-gfx@lists.freedesktop.org
Subject: [RESEND PATCH] drm/amd/display: prevent memory leak
Date: Wed, 26 Oct 2022 17:54:05 +0800
Message-Id: <20221026095405.51434-1-gehao618@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowABXQ_gvA1ljHKFvOA--.47014S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFy3WrW3JF13Gr17Ww47XFb_yoW8uF48pw
 4xJ3yFkr1kX3W7trn8JF4UXFZ3ua4IgFW5Kry3twn3u3WrAry5Ary3Ja45WrW8WasFyrya
 qF1kJFW7XFnFkF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jMyIUUUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: 5jhkt0qwryqiywtou0bp/xtbCoQimFlzmVrbJ3wAAsV
X-Mailman-Approved-At: Wed, 26 Oct 2022 14:20:40 +0000
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
Cc: gehao <gehao@kylinos.cn>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: gehao <gehao@kylinos.cn>

In dce6(0,1,4)_create_resource_pool and dce80_create_resource_pool
the allocated memory should be released if construct pool fails.

Signed-off-by: gehao <gehao@kylinos.cn>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index fc6aa098bda0..8db9f7514466 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -1128,6 +1128,7 @@ struct resource_pool *dce60_create_resource_pool(
 	if (dce60_construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
@@ -1325,6 +1326,7 @@ struct resource_pool *dce61_create_resource_pool(
 	if (dce61_construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
@@ -1518,6 +1520,7 @@ struct resource_pool *dce64_create_resource_pool(
 	if (dce64_construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index b28025960050..5825e6f412bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -1137,6 +1137,7 @@ struct resource_pool *dce80_create_resource_pool(
 	if (dce80_construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
@@ -1336,6 +1337,7 @@ struct resource_pool *dce81_create_resource_pool(
 	if (dce81_construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
-- 
2.25.1

