Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3DECE8E73
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 13:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899A410E938;
	Thu, 24 Oct 2024 13:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="SQQmd0Ba";
	dkim-atps=neutral
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com
 [51.81.35.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA68F10E937
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 13:07:27 +0000 (UTC)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
 by relay-us1.mymailcheap.com (Postfix) with ESMTPS id EA44620CEE
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 13:07:25 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
 by relay5.mymailcheap.com (Postfix) with ESMTPS id 6D5422000E
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 13:07:23 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
 by relay3.mymailcheap.com (Postfix) with ESMTPS id 76C823E8D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 15:07:21 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 by nf2.mymailcheap.com (Postfix) with ESMTPSA id 76FEC400E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 13:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1729775239; bh=Uv3D0Lky/V/CFgPfmHHnWGfTCwKwr+GZwJGgFVBkcoQ=;
 h=Date:From:To:Subject:From;
 b=SQQmd0Bai+inG2Y0/cmiR6cY/hovb2GnzjTHq+5F5B9biXCPkP/YqcbXqDar4cgOY
 J688SizZi6mcZVZJH+Fc/3jD7ivEFEG9a0W71tUDQ2bGk36K5ZkwBUK14Q+zfbMuVX
 hpIZ/TxTRt89F9VCiHMCARcaieHQzujkMXFxV2Fs=
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id DBD5841432
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 13:07:18 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 21:07:18 +0800
From: jeffbai@aosc.io
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm: amdgpu: fix comment about amdgpu.abmlevel defaults
Message-ID: <43965fdb4f4a7c4223885c8e417bdc69@aosc.io>
X-Sender: jeffbai@aosc.io
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Queue-Id: 76FEC400E2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.10 / 10.00]; MIME_GOOD(-0.10)[text/plain];
 ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; FROM_NO_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[amd-gfx@lists.freedesktop.org];
 FROM_EQ_ENVFROM(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_NONE(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]
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

Since 040fdcde288a2830edc31dd507963d6aadf990d2 ("drm/amdgpu: respect the
abmlevel module parameter value if it is set"), the default value for
amdgpu.abmlevel was set to -1, or auto. However, the comment explaining
the default value was not updated to reflect the change (-1, or auto; 
not
-1, or disabled).

Clarify that the default value (-1) means auto.

Fixes: 040fdcde288a2830edc31dd507963d6aadf990d2 ("drm/amdgpu: respect 
the abmlevel module parameter value if it is set")
Reported-by: Ruikai Liu <rickliu2000@outlook.com>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 81d9877c8735..b248d7096abc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -892,7 +892,7 @@ module_param_named(visualconfirm, 
amdgpu_dc_visual_confirm, uint, 0444);
   * the ABM algorithm, with 1 being the least reduction and 4 being the 
most
   * reduction.
   *
- * Defaults to -1, or disabled. Userspace can only override this level 
after
+ * Defaults to -1, or auto. Userspace can only override this level 
after
   * boot if it's set to auto.
   */
  int amdgpu_dm_abm_level = -1;
-- 
2.47.0

