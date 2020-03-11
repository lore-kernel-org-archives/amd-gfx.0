Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED12EC18E5C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 08:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3B9208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 08:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3B9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 371766E935;
	Wed, 11 Mar 2020 08:36:15 +0000 (UTC)
X-Greylist: delayed 424 seconds by postgrey-1.36 at gabe;
 Wed, 11 Mar 2020 05:13:44 UTC
Received: from smtprelay.hostedemail.com (smtprelay0155.hostedemail.com
 [216.40.44.155])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F3A6E0D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 05:13:44 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 37B111802E2C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 05:07:36 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 568831802E2B9;
 Wed, 11 Mar 2020 05:07:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bell19_24f02882e935b
X-Filterd-Recvd-Size: 3579
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Wed, 11 Mar 2020 05:07:33 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH -next 024/491] AMD DISPLAY CORE: Use fallthrough;
Date: Tue, 10 Mar 2020 21:51:38 -0700
Message-Id: <4ee79adcba4e5ea80b3ef6271caeef6df4bf8ca7.1583896349.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 11 Mar 2020 08:36:13 +0000
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
 Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 2f1c958..37fa7b 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -267,7 +267,7 @@ static struct atom_display_object_path_v2 *get_bios_object(
 					&& id.enum_id == obj_id.enum_id)
 				return &bp->object_info_tbl.v1_4->display_path[i];
 		}
-		/* fall through */
+		fallthrough;
 	case OBJECT_TYPE_CONNECTOR:
 	case OBJECT_TYPE_GENERIC:
 		/* Both Generic and Connector Object ID
@@ -280,7 +280,7 @@ static struct atom_display_object_path_v2 *get_bios_object(
 					&& id.enum_id == obj_id.enum_id)
 				return &bp->object_info_tbl.v1_4->display_path[i];
 		}
-		/* fall through */
+		fallthrough;
 	default:
 		return NULL;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 68c4049..743042 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -645,7 +645,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 			case AUX_TRANSACTION_REPLY_AUX_DEFER:
 			case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER:
 				retry_on_defer = true;
-				/* fall through */
+				fallthrough;
 			case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK:
 				if (++aux_defer_retries >= AUX_MAX_DEFER_RETRIES) {
 					goto fail;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 8aa937f..51481e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -479,7 +479,7 @@ static void program_grph_pixel_format(
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
 		sign = 1;
 		floating = 1;
-		/* fall through */
+		fallthrough;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F: /* shouldn't this get float too? */
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
 		grph_depth = 3;
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
