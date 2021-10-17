Return-Path: <SRS0=QO8y=PF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ECCC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Oct 2021 11:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B9760F46
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Oct 2021 11:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17B9760F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=net-c.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DE46E5CE;
	Sun, 17 Oct 2021 11:35:08 +0000 (UTC)
Received: from msg-6.mailo.com (ip-16.mailobj.net [213.182.54.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C0C6E7D2
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Oct 2021 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
 t=1634470504; bh=9aYpAk8ke5yNrj/XbYquYFYv/cvOLiIapCejGUA4C8c=;
 h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding;
 b=TeZt608ysPGw56pk5ZvFBD5P8YWwFKB96ijP+nu5P5Qx03yUWwrjS/KcbuCWiBhMK
 L7muZjwh4xTrJG0o59H0DuMyOyGXdh77WWycWhxgig2Ng2r1oFak6MKwCTASnUl/Fq
 9u5Kmi50q54nzwBGkOPF4zg/WZiQooSQt9XFtQ90=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Sun, 17 Oct 2021 13:35:04 +0200 (CEST)
X-EA-Auth: wy6VgHX5gh6YhrFNZ00BAtN1quAqs2R6zRL/x+94NHsqtyyEGljMqp3hnjz5KRQrwK3BBziEWHvgagHplhs0WWkMjN9fakuy
From: Claudio Suarez <cssk@net-c.es>
To: amd-gfx@lists.freedesktop.org
Cc: Claudio Suarez <cssk@net-c.es>
Subject: [PATCH 2/3] drm/amdgpu: use drm_edid_get_monitor_name() instead of
 duplicating the code
Date: Sun, 17 Oct 2021 13:34:59 +0200
Message-Id: <20211017113500.7033-3-cssk@net-c.es>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017113500.7033-1-cssk@net-c.es>
References: <20211017113500.7033-1-cssk@net-c.es>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use drm_edid_get_monitor_name() instead of duplicating the code that
parses the EDID in dm_helpers_parse_edid_caps()

Signed-off-by: Claudio Suarez <cssk@net-c.es>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6fee12c91ef5..bc58ee29306a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -59,7 +59,6 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	int sad_count = -1;
 	int sadb_count = -1;
 	int i = 0;
-	int j = 0;
 	uint8_t *sadb = NULL;
 
 	enum dc_edid_status result = EDID_OK;
@@ -78,20 +77,9 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	edid_caps->manufacture_week = edid_buf->mfg_week;
 	edid_caps->manufacture_year = edid_buf->mfg_year;
 
-	/* One of the four detailed_timings stores the monitor name. It's
-	 * stored in an array of length 13. */
-	for (i = 0; i < 4; i++) {
-		if (edid_buf->detailed_timings[i].data.other_data.type == 0xfc) {
-			while (j < 13 && edid_buf->detailed_timings[i].data.other_data.data.str.str[j]) {
-				if (edid_buf->detailed_timings[i].data.other_data.data.str.str[j] == '\n')
-					break;
-
-				edid_caps->display_name[j] =
-					edid_buf->detailed_timings[i].data.other_data.data.str.str[j];
-				j++;
-			}
-		}
-	}
+	drm_edid_get_monitor_name(edid_buf,
+				  edid_caps->display_name,
+				  AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
 
 	edid_caps->edid_hdmi = drm_detect_hdmi_monitor(
 			(struct edid *) edid->raw_edid);
-- 
2.33.0



