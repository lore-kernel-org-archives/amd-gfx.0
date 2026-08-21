Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F25BC5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 21:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E0410F3C3;
	Fri, 21 Aug 2026 21:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OCvI99X3";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 428B710F3C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 21:51:12 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso16496755e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787349070; x=1787953870; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G9nEAq8dd8HBASqEEGqYLV+jFQU/igwOT5rBEti5Jus=;
 b=OCvI99X3uN9R0Ah3/GZZYnYe4kCO3+LruMWzDGOHHoVfkamlXMr76t5Od3W5JRuOww
 sH7+XRg04pvNooH7mltYHG+MH0YDudOSCe0YzxtoTCfsaZ0NXRxvcPT4HNqlShEVA2tg
 0SjAnlohMUba5jD9xbD8XNForsXSOlxFITkeSrmOcdVLF4VjjnUH3niOYpGwX6C66npb
 6GuTFEHfSVJQ12Lr3hesd5QTp+ITjoEymKSRR/B2W2MNkKofOVqRnHIimH7ea6dR4Gj5
 IVRBFxZXzDbzCXq5SUMX9JfcHW1mD1lDRKvgms2LgJymWjz+zWoeZOrhcAkUki7t9jOm
 Ymhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787349070; x=1787953870;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G9nEAq8dd8HBASqEEGqYLV+jFQU/igwOT5rBEti5Jus=;
 b=Cy7mnFbMlx+eerAZO9q/5rQ1yu7nehfIR8jOiB1b8bgD8PRuclEDVV1e40qy/z8cEp
 BM///JwIVwdZQYVYT+ykogQhnHfaVfor/dKfom85XwH2R8nJU9Zsg1zlf4QP9TN0Ydv3
 /fnWoefIpxarv5pFXGE901EApZKGa1UDcHEEVMBw4GAXJFwzh5dyOkSD4EvOQuipWH8F
 /RW8bKmT5RgYJGXoLK/Qie1qzvus9gPLwC+aiMseMQ1q3JvxYALC0OT1HP14xHzFXOxm
 skBTyv+kWZHMe7POQG6Oyfc0LXqRi0fwZLM+X0EEYUXpnauu5u/QPOHhauY6jFYrQepD
 wMcw==
X-Gm-Message-State: AFuF++nNDoGktlIVYh/gIiA1cDZtEgKpVG45Iz4Rk/YTsWTfqo7AaGOa
 Z4Zd9gUwQEtc71nr+2K6sWYj4GA+9avWNmqSIXJ13Xl/5j2H4lylFEBPX2SIIse1tnc=
X-Gm-Gg: AR+sD10lVs59qVhegFjcPvVoTFw+hw1y+Co2jLRdN+nSL7JkMAzJIE7jjglldnRAKb/
 vLbbDBP2YCCFYvgRYC+8G6geoNSVBa1Ih6XCUKZ+BjFThxzPDFJUzNQ2w5rejonvV6ncbI1MAYw
 ZMj4YnC6PfJZIqmErBazUtuaPL4dp2zf/Ccu1G1r/g7yNzscBVCHikHRjc46XVLhmovMpiL2zZy
 2MtO2GV3n6ntiqUbdpL22GaZ9A9tZQrH5d1b3/2gA0tqgg1o3lGYsSoO7JUNFvSnS78BVDzlvQK
 0Z/O4uvI0pALIp2WrGp/UHMsAgdptGm5StmuQZU6N5LHigh+HParKAD/b8OVRncQpfiDUkV+O14
 Fi8VENuIOLJemO0OcAcJZJt7KWBH8hmTOcMYF4aMqYUyKCujeEfJj5Q+WGP7dyYEJnJa1BiOJVl
 Yv1nJN+a37FD9tMaYJimeHuidUkdq3OMTXzIo05lWX0qKH3hWRQgJf8YGFLBlAGOfs4QstfnDmy
 mIFPk45FNWuaznyIkPrd3DBeszmO1ti
X-Received: by 2002:a05:600c:5486:b0:499:ae94:be05 with SMTP id
 5b1f17b1804b1-499b825a4bcmr134752325e9.0.1787349070111; 
 Fri, 21 Aug 2026 14:51:10 -0700 (PDT)
Received: from Timur-Max (static-133-28-26-46.ipcom.comunitel.net.
 [46.26.28.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499c3566d4esm365415e9.8.2026.08.21.14.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 14:51:08 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Melissa Wen <mwen@igalia.com>,
 harry.wentland@amd.com, Leo Li <sunpeng.li@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Roman Li <roman.li@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Fix HPD consideration for VGA/LVDS
 connectors on DCE
Date: Fri, 21 Aug 2026 23:50:58 +0200
Message-ID: <20260821215059.312868-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After a refactor that landed in Linux 7.0,
DC now crashes when it is initialized on GPUs
that have a VGA or LVDS connector. This is because
these connectors have no HPD so the hpd_gpio is NULL
and therefore DC takes the code path meant for
DCN 4.2+ which sets irq_source_hpd = 255 that
causes the subsequent code to try to register
the HPD interrupt, which fails, and causes
a crash.

This commit should be backported to Linux 7.0 and newer.

Cc: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Cc: Roman Li <roman.li@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5490
Fixes: def3488eb0fd ("drm/amd/display: refactor HPD to increase flexibility")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 8560ee727bfa..a83693ea43c0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -643,7 +643,7 @@ static bool construct_phy(struct dc_link *link,
 
 		DC_LOG_DC("BIOS object table - hpd_gpio id: %d", enc_init_data.hpd_gpio->id);
 		DC_LOG_DC("BIOS object table - hpd_gpio en: %d", enc_init_data.hpd_gpio->en);
-	} else {
+	} else if (link->ctx->dce_version > DCN_VERSION_4_01) {
 		struct graphics_object_hpd_info hpd_info;
 
 		if (link->ctx->dc_bios->funcs->get_hpd_info(link->ctx->dc_bios, link->link_id, &hpd_info) == BP_RESULT_OK) {
-- 
2.55.0

