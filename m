Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD38C52D7B
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 14:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A4610E35B;
	Tue, 13 Aug 2024 14:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CI8Qd64u";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2075210E35B;
 Tue, 13 Aug 2024 14:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rmg9qfndNP24SmtI4wPU+OTwHYNCJ1vD4AXDPZCD/VA=; b=CI8Qd64u1QBRPpP8jhGXaLFk2z
 nHYtU04V0DBW+xFMu1Ik8gKn9wpjbnJULKl814e0JIeynDszh7M+SvicRofnvlVuZsPLrVNx6z3Jj
 wTAl/7p2BW71tz1sz3BZtMGZpjEy3PPJlru3C1p1JxPesZ4Yer82b2g9LTedcl8eMxTXu13XM+hZN
 N+LRGsNrlpAOdlmp9oc2XjjFJuuA0mqqmon9yDt/ewju0x42kuWaWw54WeAxXzDlO9p3o5Q6Kmw0d
 e5nWTdSROSb0bYxFDHhipYsLoUJljkt/YH7o1jw1GGrkeLI4afZIHF6aTWNK3Tn0hGHOdbhBk08J8
 VdoESgWQ==;
Received: from [84.69.19.168] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sds7E-00By3C-7T; Tue, 13 Aug 2024 16:03:12 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH] drm/amdgpu: Remove hidden double memset from amdgpu_cs_ioctl()
Date: Tue, 13 Aug 2024 15:03:10 +0100
Message-ID: <20240813140310.82706-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

When CONFIG_INIT_STACK_ALL_ZERO is set and so -ftrivial-auto-var-init=zero
compiler option active, compiler fails to notice that inside
amdgpu_cs_parser_init() there is a second memset to clear the same on
stack struct amdgpu_cs_parser.

If we pull this memset one level out, into the amdgpu_cs_ioctl(), compiler
can then see it and avoid clearing this struct twice.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 9aa952f258cf..554289eb1913 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -51,7 +51,6 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 	if (cs->in.num_chunks == 0)
 		return -EINVAL;
 
-	memset(p, 0, sizeof(*p));
 	p->adev = adev;
 	p->filp = filp;
 
@@ -1411,6 +1410,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	if (!adev->accel_working)
 		return -EBUSY;
 
+	memset(&parser, 0, sizeof(parser));
 	r = amdgpu_cs_parser_init(&parser, adev, filp, data);
 	if (r) {
 		DRM_ERROR_RATELIMITED("Failed to initialize parser %d!\n", r);
-- 
2.44.0

