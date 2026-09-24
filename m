Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82045C98327
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 21:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB2910F79E;
	Thu, 24 Sep 2026 21:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WrClwfXg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF5CB10E206
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 21:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=+VjMkZ3tS0FShslmwCrFzVtn4w0HMmV0NCSm3WPMU3M=; b=
 WrClwfXgez2i+pCVgHdG1ExAUSjSk5192q6JO7nf70cTdDWCdfm+w76uhGZ1HckzKeZN9AXLI2382
 WJE2SZeZfIOb4FbZ0LiVfTK7DV4yYR2nkljIM9CavC/yd55SKVlUZKDiQl4xprC1TPARWqKK2K1YA
 /jJvfG625uqa8SH6YSLGgR1XlImAZbKthnYgbzHRC9IxKeGUd2ooeJz4ztc9QrMKtjJAuY7IdJHG3
 swTY86Hfcx0EqPnv7k7De8T+2aEee/QKlN/GkBWoRbZCZ18Sz98jX4qjtWKQ05L3c1qQ0znz3YtQs
 vx5SKX6hQWBS3apY2HPvIPOhJ6y5O7EOFQ==;
Received: from 113.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.113]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9qlj-006qf4-Gv; Thu, 24 Sep 2026 23:14:15 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 Aurabindo.Pillai@amd.com, christian.koenig@amd.com, David.Francis@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] drm/amd/display: remove redundant cast on
 amdgpu_dc_reg_template printk
Date: Thu, 24 Sep 2026 23:10:09 +0200
Message-ID: <20260924211410.867686-7-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924211410.867686-1-mwen@igalia.com>
References: <20260924211410.867686-1-mwen@igalia.com>
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

Commit 0cf5eb76e2b4 ("drm/amd/display: Add tracing to dc") prints and
casts uint32_t fields in amdgpu_dc_reg_template to unsigned long
unnecessarily. Just print those fields with %08x and remove the
redundant cast.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 26c85d95bcc0..7de4fe355c5d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -57,9 +57,8 @@ DECLARE_EVENT_CLASS(amdgpu_dc_reg_template,
 				   *count = *count + 1;
 		    ),
 
-		    TP_printk("reg=0x%08lx, value=0x%08lx",
-			      (unsigned long)__entry->reg,
-			      (unsigned long)__entry->value)
+		    TP_printk("reg=0x%08x, value=0x%08x",
+			      __entry->reg, __entry->value)
 );
 
 DEFINE_EVENT(amdgpu_dc_reg_template, amdgpu_dc_rreg,
-- 
2.53.0

