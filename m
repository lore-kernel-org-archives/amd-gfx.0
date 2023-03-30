Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E45EC76196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 07:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D74A10F10F;
	Fri, 31 Mar 2023 07:36:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A0510E00E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 23:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680219789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sxdUBC3+7/+FoRE3AV8lIbZMqGBJVuxDsooJhZM+Js0=;
 b=d67SPFPVM7ZtAUKXhW4+8eMD2E/ndwCzQ7bgU/pm8Qi+3odrJ+NjcIK0w5s+ik+O+EyvWL
 GMD6ihhNQV3FtwXue2LfOLZ3uz71B58mgXIS2ZfuAKG91zS91dkWKWMKFYrQLfh29vPJZl
 f4vTjhPO7hrXNmV7VtbtMjIOaosy78c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-w0CMWEyiMG26bu7xHr9jYQ-1; Thu, 30 Mar 2023 19:43:08 -0400
X-MC-Unique: w0CMWEyiMG26bu7xHr9jYQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 pe26-20020a056214495a00b005df3eac4c0bso5933714qvb.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 16:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680219787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sxdUBC3+7/+FoRE3AV8lIbZMqGBJVuxDsooJhZM+Js0=;
 b=zHcUJk2z99mD9sIStPmhY72zHe8IRXAF87eV9lXa5rzBWVPDsIdMq3OFQuOjzSPAAC
 rqFGObsP/VvJfZb1iMqH6AvuVWY8QjkM9yamzE3DoT728y/NYKrbSpWbo2g2CMGkW1uX
 NJUB4nAWIhB70Do1JDV06Hr8xOstnBF1QvRsFfEbCCUtt0dbmQC/IULa8oVchnFrJLNh
 99vSNeLP874uTI4NIUZuz/cBBIPUa9iCsydk+6a7BkEZzWM3pC8NGkiaay++PCm8U0Pm
 3nxIzCi81BjKrjNfhexniuqaMfOhI/2mJQ1J0zy+IePd8qxosh5DPNK22knAhUImCRF2
 1Syw==
X-Gm-Message-State: AO0yUKXkkEz+lC9zf01KHgvRNPm7stprIb7nEyD0n1YXE6k81sV1zoaV
 +D/xRDofCXgBX8hREKHpCq8UleWhuZtCgwpwgE7F0RUQwoQY2zDZa/bYbmeLiAqDaPHyI3/tWCm
 93MUdEoKrzUJ04mBsFJ/YIodRDQ==
X-Received: by 2002:a05:622a:1a98:b0:3d8:9b45:d362 with SMTP id
 s24-20020a05622a1a9800b003d89b45d362mr38620998qtc.28.1680219787542; 
 Thu, 30 Mar 2023 16:43:07 -0700 (PDT)
X-Google-Smtp-Source: AK7set8e+7pjqcJzugW+87SA4B2ztfpVpwfdIdmQmFB4Xnk8pbSHqG3Dep8cVHiY/IIHhrhVsGayJA==
X-Received: by 2002:a05:622a:1a98:b0:3d8:9b45:d362 with SMTP id
 s24-20020a05622a1a9800b003d89b45d362mr38620961qtc.28.1680219787200; 
 Thu, 30 Mar 2023 16:43:07 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 q19-20020ac87353000000b003e387a2fbdfsm235015qtp.0.2023.03.30.16.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Mar 2023 16:43:06 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
 ndesaulniers@google.com, HaoPing.Liu@amd.com, aric.cyr@amd.com,
 chiahsuan.chung@amd.com, felipe.clark@amd.com, Angus.Wang@amd.com,
 hanghong.ma@amd.com, lv.ruyi@zte.com.cn, Dillon.Varone@amd.com
Subject: [PATCH] drm/amd/display: remove unused average_render_time_in_us and
 i variables
Date: Thu, 30 Mar 2023 19:43:03 -0400
Message-Id: <20230330234303.1845377-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Fri, 31 Mar 2023 07:36:28 +0000
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
Cc: Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

clang with W=1 reports
drivers/gpu/drm/amd/amdgpu/../display/modules/freesync/freesync.c:1132:15: error: variable
  'average_render_time_in_us' set but not used [-Werror,-Wunused-but-set-variable]
        unsigned int average_render_time_in_us = 0;
                     ^
This variable is not used so remove it, which caused i to be unused so remove that as well.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../drm/amd/display/modules/freesync/freesync.c    | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 315da61ee897..5c41a4751db4 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1129,7 +1129,6 @@ void mod_freesync_handle_preflip(struct mod_freesync *mod_freesync,
 {
 	struct core_freesync *core_freesync = NULL;
 	unsigned int last_render_time_in_us = 0;
-	unsigned int average_render_time_in_us = 0;
 
 	if (mod_freesync == NULL)
 		return;
@@ -1138,7 +1137,6 @@ void mod_freesync_handle_preflip(struct mod_freesync *mod_freesync,
 
 	if (in_out_vrr->supported &&
 			in_out_vrr->state == VRR_STATE_ACTIVE_VARIABLE) {
-		unsigned int i = 0;
 		unsigned int oldest_index = plane->time.index + 1;
 
 		if (oldest_index >= DC_PLANE_UPDATE_TIMES_MAX)
@@ -1147,18 +1145,6 @@ void mod_freesync_handle_preflip(struct mod_freesync *mod_freesync,
 		last_render_time_in_us = curr_time_stamp_in_us -
 				plane->time.prev_update_time_in_us;
 
-		/* Sum off all entries except oldest one */
-		for (i = 0; i < DC_PLANE_UPDATE_TIMES_MAX; i++) {
-			average_render_time_in_us +=
-					plane->time.time_elapsed_in_us[i];
-		}
-		average_render_time_in_us -=
-				plane->time.time_elapsed_in_us[oldest_index];
-
-		/* Add render time for current flip */
-		average_render_time_in_us += last_render_time_in_us;
-		average_render_time_in_us /= DC_PLANE_UPDATE_TIMES_MAX;
-
 		if (in_out_vrr->btr.btr_enabled) {
 			apply_below_the_range(core_freesync,
 					stream,
-- 
2.27.0

