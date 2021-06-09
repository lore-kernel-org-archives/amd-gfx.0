Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B504FC48BCD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833DD608FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 10:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833DD608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C5A6E526;
	Wed,  9 Jun 2021 10:39:34 +0000 (UTC)
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch
 [185.70.41.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E4F6E529
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 10:39:33 +0000 (UTC)
Received: from mail-02.mail-europe.com (mail-0201.mail-europe.com
 [51.77.79.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail-41104.protonmail.ch (Postfix) with ESMTPS id 4G0Ns028Mxz4xHJ8
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 10:39:32 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="bX7ZLXKR"
Date: Wed, 09 Jun 2021 10:39:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1623235167;
 bh=9pG2VJ91c52VpOx8wxL38EnhB/qY4lpRu/zW6swuMbM=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=bX7ZLXKRjz7nyHfmN1h0OfpQ+tQaStZxDl7cUGJHQMNJxW3M0kBMFOBsszBiZn0lU
 yvTehbIRG+g2kOpWiQKog5RpAsGRuPQWWgOxya2CX3x3P6XELurZh99F7vR4ofVPwW
 3E3T+VTlAjuJVE2zz7dtOnIH1Mwu+sF/9/bMlEb3397XGg4Jqzj7Rb0VedwW0mCyPl
 5D0PDICENlNXVXK9A/2vWNpOtbRAJdFqp7EQHYG9cTxbWuELMAVaHfdQkHRs00kdke
 Jd1Fqt7XtwmZucn5fdIQXBiYYiJWl5RUuBY2ei7boJxiV6+t6Qj/fWbwwzJkoswvQQ
 +YlWZdQRFe57w==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 3/4] drm/connector: use drm_sysfs_connector_hotplug_event
Message-ID: <cSXLbnlidFNybiEgGG4rnEP5JM1GNRPLkDpviHfTW0@cp4-web-040.plabs.ch>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: pekka.paalanen@collabora.com, michel@daenzer.net, daniel@fooishbar.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In drm_connector_register, use drm_sysfs_connector_hotplug_event
instead of drm_sysfs_hotplug_event, because the hotplug event
only updates a single connector.

Signed-off-by: Simon Ser <contact@emersion.fr>
---
 drivers/gpu/drm/drm_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index da39e7ff6965..76930e0b8949 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -530,7 +530,7 @@ int drm_connector_register(struct drm_connector *connector)
 	connector->registration_state = DRM_CONNECTOR_REGISTERED;
 
 	/* Let userspace know we have a new connector */
-	drm_sysfs_hotplug_event(connector->dev);
+	drm_sysfs_connector_hotplug_event(connector);
 
 	goto unlock;
 
-- 
2.31.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
