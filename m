Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF60C47DA6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3872410E8B4;
	Thu, 11 Jan 2024 09:04:31 +0000 (UTC)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8BC4D10E08C;
 Thu, 11 Jan 2024 03:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=En1CBR0kBxa9quIwfp
 /NIa2YsneYuX52TYhnjn5Zx/c=; b=pxEA2lEBZijLftPdfXwtP3vOjvN2IXaO8c
 FWlVJ81D6ptczWK5Ecs8a4pfMgzBdi2c6XRxUDFiJD0zXg0q2Y3iGU3iBTcpV2Wo
 qY89z6+TezDtesKBKDG0yYvrucHgLCBKAVC/shFGeM7+4BSja48SxeptdwhVTAA0
 2W7/0VVEQ=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3f6f7YZ9l2LwgAA--.42672S2;
 Thu, 11 Jan 2024 11:35:23 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: daniel@ffwll.ch, alexander.deucher@amd.com, airlied@gmail.com,
 Xinhui.Pan@amd.com, christian.koenig@amd.com
Subject: [PATCH] drm/amd/include/navi14_ip_offset: Clean up errors in
 navi14_ip_offset.h
Date: Thu, 11 Jan 2024 03:35:22 +0000
Message-Id: <20240111033522.7791-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3f6f7YZ9l2LwgAA--.42672S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48KrW7JryUCrWruFg_yoW3KFX_Ca
 4xJ3s3WayxuFnFvFnFkFZ7Z34Ik3W09Fn3Xw1ftFy5trnrAr18W3y5Jrs7XrWruFnF9FZr
 Z3WrXFy5ZrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRt8nDUUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHARixWV2zz-RdwABs7
X-Mailman-Approved-At: Thu, 11 Jan 2024 09:04:24 +0000
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
Cc: chenxuebing <chenxb_99091@126.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/navi14_ip_offset.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/navi14_ip_offset.h b/drivers/gpu/drm/amd/include/navi14_ip_offset.h
index c39ef651adc6..508011288dea 100644
--- a/drivers/gpu/drm/amd/include/navi14_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/navi14_ip_offset.h
@@ -25,13 +25,11 @@
 #define MAX_SEGMENT                                        5
 
 
-struct IP_BASE_INSTANCE
-{
+struct IP_BASE_INSTANCE {
     unsigned int segment[MAX_SEGMENT];
 };
 
-struct IP_BASE
-{
+struct IP_BASE {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
 } __maybe_unused;
 
-- 
2.17.1

