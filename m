Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC3AC2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 16:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140BD218AC
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 16:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LBGI1dSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140BD218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE96F6E8FE;
	Wed, 18 Dec 2019 16:19:24 +0000 (UTC)
Received: from mta-p8.oit.umn.edu (mta-p8.oit.umn.edu [134.84.196.208])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2009B6E8BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 16:15:13 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p8.oit.umn.edu (Postfix) with ESMTP id 47dKq43sLyz9vcq7
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 16:15:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id udGbQJ7aFkKe for <amd-gfx@lists.freedesktop.org>;
 Wed, 18 Dec 2019 10:15:12 -0600 (CST)
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 47dKq42fb1z9vcqS
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 10:15:11 -0600 (CST)
Received: by mail-yw1-f70.google.com with SMTP id j9so1645186ywg.14
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 08:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qOckGjyMkemghi3Y5ghPJ9HepPoz/TI4eTpGQv8uuB0=;
 b=LBGI1dSL721DXiRMdlxO9OgIC+cHa4/bWDIWiGuVIsT9SfjGy0VWgwRkdoaO77FrRk
 kjevZwS20wMMcfEN20PAYvJW2YQeRONsrBRBtYO0XtSYHVYkNlxfgDHzXUQArkqQHStA
 lYclFosKI7BEg3XeENJCDP1nAD9G3FRBAu/fM70AukXjilg141GzlehLzKwUPOW6xHxv
 mXbFx+I4D1C0YITIcmwCFM82yUQiOY4DMj9u8gaHO7GdDgQ3E9cbSSIKc9C0SE8M+G9N
 9PUAPWPEdhJLBESLDgy9ddw6/RUav14ZuinIuXrCUxemaXie9FsYBGEwjdahpeIXcetP
 xx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qOckGjyMkemghi3Y5ghPJ9HepPoz/TI4eTpGQv8uuB0=;
 b=RWC/eJVg9DOns2jdZPkLdrFOsHoBIvGr2evIOZvbQu574YKqZTWDKOIa9/ZJNM2gLm
 4ztwcbqfCTaAUZx4p/kJmKdYEu68Ezdo4wwHGNeMi+YJ4T5hnvXZo0dSbUUcfQLO1yBk
 w18qwKZqb/BopgAhPow0rUnrZSnkCRKhyTz+BVDjFlCOvjHbSIQAtJwI2we6x9hDTWIn
 PB7/oTR1KntleypyOHWiQOqx/SuoB+MArpFTVanH3vvvs4/30MPUUdVaaxWhUKb1viL1
 s7dpIXVKonWm37WojIogUzKmjFj8ZwKwi+ugzsteJ9uki210h77yBByf4xfl+Xs96lX3
 L95Q==
X-Gm-Message-State: APjAAAXSeGvhi/84KzRxGxUqCtBfp9dAmIoDrvkkiS3lTUYSMGesUFAh
 iosJGZgFKwmyiNWrxjOy6HDX/HaS+KKOceySrNKZ7okB3RnP2T5sGjlwBeuyphy2L8C/QE2BitW
 Y6KuvuVjvBEeCaHQzBoAliG1htgOsqg==
X-Received: by 2002:a25:33c2:: with SMTP id z185mr2694543ybz.477.1576685710882; 
 Wed, 18 Dec 2019 08:15:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXNkytcdMy0zBtt0dCkZST2hQpkfH7TiOeIocMwvlZuJgokwWfh/oIOnlpTBiFOFnKN+CPNQ==
X-Received: by 2002:a25:33c2:: with SMTP id z185mr2694522ybz.477.1576685710626; 
 Wed, 18 Dec 2019 08:15:10 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu.
 [128.101.106.66])
 by smtp.gmail.com with ESMTPSA id m16sm1034836ywa.90.2019.12.18.08.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 08:15:10 -0800 (PST)
From: Aditya Pakki <pakki001@umn.edu>
To: pakki001@umn.edu
Subject: [PATCH] drm/amd/display: replace BUG_ON with WARN_ON
Date: Wed, 18 Dec 2019 10:15:03 -0600
Message-Id: <20191218161505.13416-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 18 Dec 2019 16:19:23 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 David Francis <David.Francis@amd.com>, kjlu@umn.edu,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In skip_modeset label within dm_update_crtc_state(), the dc stream
cannot be NULL. Using BUG_ON as an assertion is not required and
can be removed. The patch replaces the check with a WARN_ON in case
dm_new_crtc_state->stream is NULL.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7aac9568d3be..03cb30913c20 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7012,7 +7012,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	 * 3. Is currently active and enabled.
 	 * => The dc stream state currently exists.
 	 */
-	BUG_ON(dm_new_crtc_state->stream == NULL);
+	WARN_ON(!dm_new_crtc_state->stream);
 
 	/* Scaling or underscan settings */
 	if (is_scaling_state_different(dm_old_conn_state, dm_new_conn_state))
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
