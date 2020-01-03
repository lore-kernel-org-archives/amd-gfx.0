Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F79C32767
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 19:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8E2215A4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 19:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqa1jDSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8E2215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 546096E334;
	Fri,  3 Jan 2020 19:34:53 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEAA36E32D;
 Fri,  3 Jan 2020 19:19:00 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z3so43417872wru.3;
 Fri, 03 Jan 2020 11:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=5dSmFZluAq2raBNcYBXyZnuaNy9LKDAB9e+tRyUJHwo=;
 b=gqa1jDSZE/L2osiIIKIHEf+8Onp0s7+Cl2aUOZUBp+CtkWBbOIKaeR6eus9Vzoj1Vv
 6i+XsbG8uR26Xo7qKmLKHQYud4nDhF6fnAXleOx9b44hvqA93sQvv1ARppStS1+x5utU
 Ric5b3G9qOEMjLILKGf3JERRqYvkuiIjbvGsEENkNX01RxeFU5i8gvuX50GRDK3QzFKX
 T5Eub4OTbgzNRIfrPlHCa6tGC86MhsizMIpq1Xeq6WapTX8W6hYhjXr23OzZ6o0d+K/k
 Sj3ncLy9Xy07e1Te1YGN+hj7oCcmZhKl+tiSNeU8wZ8TJRKoTHkwrPAbbX4+drs1YCfi
 mBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=5dSmFZluAq2raBNcYBXyZnuaNy9LKDAB9e+tRyUJHwo=;
 b=AHaxn12258JncNUkL1ZrZdiucE5gupr0YQPLHn9fCgyWEuaqGd1a7rc+If6T1cxH5F
 oVGb1i73/FzolxzZlkOaxemcPUtBNgne9mReZEU4KeNyAHTz1TeT0oT0wSuc4Me8+k7R
 fn9buaqDOg8GPw5odkTjhpxqLrs5NrcTlbIMvyfBfVuRjGaYY7UU/TJI5VSZRTgIXgqF
 wia6Risz4J9SiE0OUuvmJvntz6uFgnPZPQi794axXkLIyga4SCEimzSzN4zA6DC8/Wfx
 a9ABwQh/4RM9qsRUpSw7ITmIdAFAREZ/QylUjvdY3i9R7NmcxN7aWCnnWFCFn+G3WK5q
 TeDA==
X-Gm-Message-State: APjAAAXMRSgeY4MOdGwAoqRNHqjlRIQxzhmoXoOgK6BMBBjHlBheA+Br
 e19GDFPIwrmZYMv9d7BEcyY=
X-Google-Smtp-Source: APXvYqyAZ9YT29a+Bji26Yxf3C6hFa6tQzM7Yxyt9Q6hkpdzZ3R0E5g3lmpymrKxzVHacfySLQm2zQ==
X-Received: by 2002:adf:a109:: with SMTP id o9mr95675914wro.189.1578079139609; 
 Fri, 03 Jan 2020 11:18:59 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
 by smtp.googlemail.com with ESMTPSA id w8sm13270262wmm.0.2020.01.03.11.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2020 11:18:58 -0800 (PST)
From: Wambui Karuga <wambui.karugax@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com,
 airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH] drm/amd: use list_for_each_entry for list iteration.
Date: Fri,  3 Jan 2020 22:18:52 +0300
Message-Id: <20200103191852.15357-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Fri, 03 Jan 2020 19:34:52 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

list_for_each() can be replaced by the more concise
list_for_each_entry() here for iteration over the lists.
This change was reported by coccinelle.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 64445c4cc4c2..cbcf504f73a5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -111,17 +111,12 @@ static void init_handler_common_data(struct amdgpu_dm_irq_handler_data *hcd,
  */
 static void dm_irq_work_func(struct work_struct *work)
 {
-	struct list_head *entry;
 	struct irq_list_head *irq_list_head =
 		container_of(work, struct irq_list_head, work);
 	struct list_head *handler_list = &irq_list_head->head;
 	struct amdgpu_dm_irq_handler_data *handler_data;
 
-	list_for_each(entry, handler_list) {
-		handler_data = list_entry(entry,
-					  struct amdgpu_dm_irq_handler_data,
-					  list);
-
+	list_for_each_entry(handler_data, handler_list, list) {
 		DRM_DEBUG_KMS("DM_IRQ: work_func: for dal_src=%d\n",
 				handler_data->irq_source);
 
@@ -528,19 +523,13 @@ static void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
 					 enum dc_irq_source irq_source)
 {
 	struct amdgpu_dm_irq_handler_data *handler_data;
-	struct list_head *entry;
 	unsigned long irq_table_flags;
 
 	DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
 
-	list_for_each(
-		entry,
-		&adev->dm.irq_handler_list_high_tab[irq_source]) {
-
-		handler_data = list_entry(entry,
-					  struct amdgpu_dm_irq_handler_data,
-					  list);
-
+	list_for_each_entry(handler_data,
+			    &adev->dm.irq_handler_list_high_tab[irq_source],
+			    list) {
 		/* Call a subcomponent which registered for immediate
 		 * interrupt notification */
 		handler_data->handler(handler_data->handler_arg);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
