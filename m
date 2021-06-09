Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAF3C48BCF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22334613EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 21:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22334613EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AC2D6EB54;
	Wed,  9 Jun 2021 21:24:24 +0000 (UTC)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B39EC6EB4C
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 21:24:22 +0000 (UTC)
Date: Wed, 09 Jun 2021 21:24:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1623273861;
 bh=HOJnTStK1H9lEzyOT9wp33tz33iSfinHkHc1uA7cHQA=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=eIHkNV2RswfouuTGnfK6xEBmk7KaBbLlKGHYmpg9cfPGWvDGItXEchqsKM1d6DXM1
 4cnjx8ymKKRfCRkuOEoXs0fWnW3YaJeQ42XyqaWLLEJlgC5ZPIhcGv3RwsOEI1uAr0
 h687RKsGU1rDwGsCRUeXGfgzMPtlKfEoErHOV2R3xFVTQKeaBZF16mIrtvnI1Xs5Vu
 TK5zQjAkWZ3w3Vs9DbO6XNp1flytul1c0WUm2G+IrLYGNQ8+YQVJgU5moUJnnFcvm+
 LKxsZ0zzeWdxWwq/xlJ7bcgTEbyS1Qi4lzIUZj63HMhDmbC9ctpVY+FmGULv2Q470K
 oDj9UlfpAz7Ww==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH v2 7/7] drm/connector: add ref to drm_connector_get in iter
 docs
Message-ID: <KRoUI7OC9lRIvk3YzdGm6tcMVAVlG1fR78Ll7kTZZT4@cp3-web-051.plabs.ch>
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

Mention that connectors need to be referenced manually if they are
to be accessed after the iteration has progressed or ended.

Signed-off-by: Simon Ser <contact@emersion.fr>
---
 include/drm/drm_connector.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 714d1a01c065..c1af1e4ca560 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1735,6 +1735,11 @@ void drm_mode_put_tile_group(struct drm_device *dev,
  * drm_connector_list_iter_begin(), drm_connector_list_iter_end() and
  * drm_connector_list_iter_next() respectively the convenience macro
  * drm_for_each_connector_iter().
+ *
+ * Note that the return value of drm_connector_list_iter_next() is only valid
+ * up to the next drm_connector_list_iter_next() or
+ * drm_connector_list_iter_end() call. If you want to use the connector later,
+ * then you need to grab your own reference first using drm_connector_get().
  */
 struct drm_connector_list_iter {
 /* private: */
-- 
2.31.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
