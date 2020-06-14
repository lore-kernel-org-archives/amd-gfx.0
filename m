Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3150C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 07:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FC82068E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 07:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="mGPxDd56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FC82068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F946E261;
	Mon, 15 Jun 2020 07:27:55 +0000 (UTC)
X-Greylist: delayed 329 seconds by postgrey-1.36 at gabe;
 Sun, 14 Jun 2020 02:01:15 UTC
Received: from mta-p5.oit.umn.edu (mta-p5.oit.umn.edu [134.84.196.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B18B6E077
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Jun 2020 02:01:15 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49kyGp2QfTz9vFJL
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Jun 2020 01:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kXm1UxujdriB for <amd-gfx@lists.freedesktop.org>;
 Sat, 13 Jun 2020 20:55:46 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49kyGp0m7Dz9vC9N
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jun 2020 20:55:46 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49kyGp0m7Dz9vC9N
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49kyGp0m7Dz9vC9N
Received: by mail-io1-f72.google.com with SMTP id a16so8944153iow.9
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jun 2020 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TdqIFxgHaPyml2SmCdHxvLQZge/mICMslBYJgjMsN0k=;
 b=mGPxDd568gvpjZYW7B0VV+xmdjn8NF+TD7I3LwqVL2COMehOHnoTIw5DZKtZ2bCFGj
 BMwI50DUWvzIA/tkfqI65XIID6XJlTCB+kdK1dh8rade6ulX7Fi6FgldOo2ERHBlLP2E
 siDnavJnLqqVBTE/lCpswnHpXQ3RILH0X1OcuU63Jb7jg4KONnbJRfSzX+IfyN0IPSRn
 IgppSXNBpwFC8F/DX691Ay6J3ZtLHjW5t8tArT5DtA1b/L9EpEdLoE+k6XLlxU86O5ra
 8lAH96X22H/YvEqm7TkoXs7Lf95zofSOUpbSCv6nAIFhoj7emn26PExmWKYugvvVBMIw
 6VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TdqIFxgHaPyml2SmCdHxvLQZge/mICMslBYJgjMsN0k=;
 b=Gjx0vGuzPNyZx9S4G3YQaWRBG+xzPCy5eQg/52mnvbVO4+Jz80+HUs2IdzkwIoLBy6
 gL9GkTV5K4PUckeNME7VSbHEcJRnHLL7ArEjjHIEhBk08ZwMpQA0n8IOW1HnKj7GrUAq
 9i5yhWepZ9LfU2kp7EUxW24lMdyRpNne73EHYByLiOnbdvCPJ886bcdddSHr44zaUxN0
 CSea52T2RJUhZOJEHzaM4hsubDsVyIJjEPrgTSdSfYgT86grFeJ8jKQwt1AWah9qSfMu
 tBqpTqdh80xToJ55K0Q2ZYhCZxsOMr5GFm9w/pw0mwgdA4S0IcDndWDlVHv8/Tb5eqRG
 8Neg==
X-Gm-Message-State: AOAM530nP7depyBkTyQS8IhFmqym0r50MjzfAgooYo0uSYrwl827mOnx
 B9M5UWpCQ1X9O1+EHmYNCuGfIkoTGf91jxgjDNm9trBPuazPTGHRjlgejj4PQcUf3bjov103Lph
 0lkUBD3hgPpfUWOEWULmg0xqNAHy+zg==
X-Received: by 2002:a05:6e02:be8:: with SMTP id
 d8mr19558111ilu.32.1592099745719; 
 Sat, 13 Jun 2020 18:55:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcVDjXlANd/0Xr752unf8N10VGa47mAE3GfelbMmqQ32kEGlnlBYsVkfVLgyXnIgnf2V8zuQ==
X-Received: by 2002:a05:6e02:be8:: with SMTP id
 d8mr19558104ilu.32.1592099745566; 
 Sat, 13 Jun 2020 18:55:45 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:49fa:9c47:e40b:9c40])
 by smtp.gmail.com with ESMTPSA id w15sm5544402ilq.4.2020.06.13.18.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2020 18:55:45 -0700 (PDT)
From: Aditya Pakki <pakki001@umn.edu>
To: pakki001@umn.edu
Subject: [PATCH] drm/radeon: fix multiple reference count leak
Date: Sat, 13 Jun 2020 20:55:39 -0500
Message-Id: <20200614015539.123654-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 15 Jun 2020 07:27:54 +0000
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
Cc: wu000273@umn.edu, David Airlie <airlied@linux.ie>, kjlu@umn.edu,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On calling pm_runtime_get_sync() the reference count of the device
is incremented. In case of failure, decrement the
reference count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index fe12d9d91d7a..e30834434442 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -879,8 +879,10 @@ radeon_lvds_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	if (encoder) {
@@ -1025,8 +1027,10 @@ radeon_vga_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	encoder = radeon_best_single_encoder(connector);
@@ -1163,8 +1167,10 @@ radeon_tv_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	encoder = radeon_best_single_encoder(connector);
@@ -1247,8 +1253,10 @@ radeon_dvi_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	if (radeon_connector->detected_hpd_without_ddc) {
@@ -1657,8 +1665,10 @@ radeon_dp_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	if (!force && radeon_check_hpd_status_unchanged(connector)) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
