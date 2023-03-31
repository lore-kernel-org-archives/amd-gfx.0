Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4957C6FD18
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 07:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AE6210E306;
	Fri, 31 Mar 2023 07:36:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF19F10F0B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 00:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680221437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sxdUBC3+7/+FoRE3AV8lIbZMqGBJVuxDsooJhZM+Js0=;
 b=SJF3Z32iSA1mOhjUHDFUQxL0c1EtE8/qbawEPmNtJa8Z0au/uswhH/WrQAcq6dQdx0X/Dm
 l/S/PEt8ABtkzj+l9FMBAnBEABMCYrYkIkPbvoygzXM39ve3/CiF5MKoaz4JT6MWSryI9H
 ThQbIpY8/h45xWI/+6CO1+EdCjymWl0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-xuaRfuAnPx2_AYv7jz55FQ-1; Thu, 30 Mar 2023 20:10:36 -0400
X-MC-Unique: xuaRfuAnPx2_AYv7jz55FQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 v7-20020a05622a188700b003e0e27bbc2eso13512264qtc.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 17:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680221436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sxdUBC3+7/+FoRE3AV8lIbZMqGBJVuxDsooJhZM+Js0=;
 b=pRu5OdGredJjXGo3RoMQQhwPSD63A6t9zu6k9Bx715yevho1gxZOsavDCremphapTb
 36rwB2NVnS7ArXUrUtoVILMlVLQ5g/sF3Qeh9oBqgrJXoZ3bha3RHOveh2//ZRgi6jbl
 2aMXUvN2I2eOh9ZhaIS8/eYxZJNJii3M8JR6vFxJgcaB8fauBSK16K4pB/VMzVKEDVfp
 EgVfv6A3oEdC2UvJJa3U3/4M2i4QHmRFff7gloBO/dN7Zaz1xtcoPHluGKFZuQpM+gz5
 xBo9xMJdW3tRIoOhcTQqOO+/jgfv1loKgnxQ4flgZsBtsySAJMifBPdTlhxTZa+W7fWn
 3q7Q==
X-Gm-Message-State: AAQBX9fXU7xH3+QyO1VmistL6qjLCv1ArqsavyqvnZ19SQelgk4dOI7q
 Mv4TFeE451/zgD7XB8mwgiOnU06XyeAhKtFo9wIm+vVVD0duBejinxIVUc265ZiVbpZFHULkOIs
 v8oGFZ8tmDCHGKmqtTtXR5fSpaw==
X-Received: by 2002:ac8:5b01:0:b0:3e6:3851:b949 with SMTP id
 m1-20020ac85b01000000b003e63851b949mr5096990qtw.18.1680221436254; 
 Thu, 30 Mar 2023 17:10:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZfvmPI/ZvqdmyfvzOcRsU2w4va42Sg5iZv/lqX0s90R5xmXd2ghuy7behp6ugqVkYCdP5wxg==
X-Received: by 2002:ac8:5b01:0:b0:3e6:3851:b949 with SMTP id
 m1-20020ac85b01000000b003e63851b949mr5096964qtw.18.1680221436015; 
 Thu, 30 Mar 2023 17:10:36 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 e14-20020ac8670e000000b003e38d6c013dsm223281qtp.60.2023.03.30.17.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Mar 2023 17:10:35 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
 ndesaulniers@google.com, aric.cyr@amd.com, HaoPing.Liu@amd.com,
 Anthony.Koo@amd.com, hanghong.ma@amd.com, Angus.Wang@amd.com,
 Dillon.Varone@amd.com
Subject: [PATCH] drm/amd/display: remove unused average_render_time_in_us and
 i variables
Date: Thu, 30 Mar 2023 20:10:32 -0400
Message-Id: <20230331001032.1846456-1-trix@redhat.com>
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

