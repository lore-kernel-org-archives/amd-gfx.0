Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBBCC77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 16:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7697310EE0E;
	Fri, 14 Apr 2023 16:17:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C151210E1A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681484916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dntWt6MEzqE7MJUvMHAAGJ0dlLTaBYPZeQAgzMBHF18=;
 b=F+M7RY0MxHgqtvAlzXEoqoXq462Gf+ioNYgyeG5Os4eVb9RxZpxYD6R1Oau3T6BODFkhku
 zhr4GXxi8JdALe7Jk6atmguvMKIU00CmvmFeeIAs1Md7yQM3y86TQOPyC3Sv0GRTqAKJUy
 sCCXMprNjfZOfY3LfhMcc93ig1p0co8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-BIDguVPdMjqGcezlqxL-Og-1; Fri, 14 Apr 2023 11:08:34 -0400
X-MC-Unique: BIDguVPdMjqGcezlqxL-Og-1
Received: by mail-qv1-f71.google.com with SMTP id
 l1-20020a0cc201000000b005ad0ce58902so8751182qvh.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 08:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681484914; x=1684076914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dntWt6MEzqE7MJUvMHAAGJ0dlLTaBYPZeQAgzMBHF18=;
 b=fu2HKUaH3ODqqw+2Zi6eAIg4rR1dkLsHzbvvhJ8n04YYZpuy5NOuo80b5rRc/FezxF
 24Jinm8M8Nf0v8pJYMCZkdhO/8UKOLhIwnlQuqADFJDAmbYQ0VMiaKy7SgJdYJ2fRc1Y
 2Xy5Hq/xbxW5SniwucojxY77xBTLg9mxyeSFqJ3JAqITd+2X9Skz/4l8P2pA79q5b6z2
 inbqTd4Ok4yKsnmravbecp9dcoFCP7DeLOdIHdc7KYODJjecnLcLnNq5J0nFxVD3REgl
 uzoVwoyAA3kUEQKq4lJJ/ovsODj12V3/0BKZS/H5G+ZVZ5ffrPOUy4oHado9Q5PAICEn
 SlSg==
X-Gm-Message-State: AAQBX9fZdpvio0HcUqMPhJJzkzskC/yOnsvfI1sdYd9xYmqGSdNlHL6h
 tN7C7gDz2K9zZp9HLzgWW2oCNl0hmwHHrW8qrV/ZoPbLy03qAwA3KqAm2olf5v4/CeJ72kbTgw3
 0wSp6sOGP6aXzk6iQFcHqLN9hIA==
X-Received: by 2002:ac8:5ccb:0:b0:3e6:4e79:7401 with SMTP id
 s11-20020ac85ccb000000b003e64e797401mr9604123qta.29.1681484914448; 
 Fri, 14 Apr 2023 08:08:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350YGN/ZPCYxibgTViJjjyz5pv87pPzhZ5EyrP/e3wwVcRZqPGm413XGTEu5OHq/fnESmP3RN0w==
X-Received: by 2002:ac8:5ccb:0:b0:3e6:4e79:7401 with SMTP id
 s11-20020ac85ccb000000b003e64e797401mr9604084qta.29.1681484914150; 
 Fri, 14 Apr 2023 08:08:34 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 eb3-20020a05620a480300b0074b5219b63esm342074qkb.121.2023.04.14.08.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Apr 2023 08:08:33 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, HaoPing.Liu@amd.com, aric.cyr@amd.com,
 qingqing.zhuo@amd.com, hanghong.ma@amd.com, felipe.clark@amd.com,
 Dillon.Varone@amd.com, Mike.Hsieh@amd.com
Subject: [PATCH] drm/amd/display: remove unused variable oldest_index
Date: Fri, 14 Apr 2023 11:08:30 -0400
Message-Id: <20230414150830.3173504-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Fri, 14 Apr 2023 16:17:04 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

cpp_check reports
drivers/gpu/drm/amd/display/modules/freesync/freesync.c:1143:17: style: Variable
  'oldest_index' is assigned a value that is never used. [unreadVariable]
   oldest_index = 0;
                ^

This variable is not used so remove.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 5c41a4751db4..5798c0eafa1f 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1137,10 +1137,6 @@ void mod_freesync_handle_preflip(struct mod_freesync *mod_freesync,
 
 	if (in_out_vrr->supported &&
 			in_out_vrr->state == VRR_STATE_ACTIVE_VARIABLE) {
-		unsigned int oldest_index = plane->time.index + 1;
-
-		if (oldest_index >= DC_PLANE_UPDATE_TIMES_MAX)
-			oldest_index = 0;
 
 		last_render_time_in_us = curr_time_stamp_in_us -
 				plane->time.prev_update_time_in_us;
-- 
2.27.0

