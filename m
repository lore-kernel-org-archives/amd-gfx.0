Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1570AC48BCF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4FB6139A
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4FB6139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79EE76EB46;
	Wed,  9 Jun 2021 21:24:12 +0000 (UTC)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8040C6EB41;
 Wed,  9 Jun 2021 21:24:10 +0000 (UTC)
Date: Wed, 09 Jun 2021 21:24:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1623273848;
 bh=CRpCmV6JJvjSWIefuOMH4SCsYiJSl92J72nXZg36ElE=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=XTDKNX2oTSMf5r8Z9kCRg0LOrMUAnlSW83jpURVJFYUe2G9xmU1ff6Rlbn5CIhTDL
 wx+NewdFxon7fANrvUD8KISS5ZrZ+bLoDfAb2tCCai4lrkDgFja1bPdVeJevr+oCLi
 pjJWaE/zBfix/endv7nQNt6qXYl8anyDV/h84ZqNfAimI12uCMFu5TQNVXeyLH9P2Z
 5OmKPb9HkvRdIoJlS1zkKomuiINMoqCZuHhmOFhriJebtRyM5gus5mTgFmKHVbbFra
 nlnSaw2toviWN2VQus1cd/1IMTreN2g0IOhcYIZuoBeW2I20EXBYZ54m9/k92sUd+M
 J31em3eI58x+Q==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH v2 6/7] i915/display/dp: send a more fine-grained link-status
 uevent
Message-ID: <s2nCZi12JRcxrixhDW8UTiJsEpPvIQhnFBMtgdRXMk@cp3-web-020.plabs.ch>
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
 daniel@ffwll.ch, alexander.deucher@amd.com, harry.wentland@amd.com,
 intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When link-status changes, send a hotplug uevent which contains the
connector and property ID. That way, user-space can more easily
figure out that only the link-status property of this connector has
been updated.

Signed-off-by: Simon Ser <contact@emersion.fr>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 5c9222283044..0ce44a97dd14 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5276,6 +5276,8 @@ static void intel_dp_modeset_retry_work_fn(struct work_struct *work)
 	mutex_unlock(&connector->dev->mode_config.mutex);
 	/* Send Hotplug uevent so userspace can reprobe */
 	drm_kms_helper_hotplug_event(connector->dev);
+	drm_sysfs_connector_status_event(connector,
+					 connector->dev->mode_config.link_status_property);
 }
 
 bool
-- 
2.31.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
