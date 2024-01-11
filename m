Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCB5C47DA7
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C706410E8AC;
	Thu, 11 Jan 2024 09:04:30 +0000 (UTC)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
 by gabe.freedesktop.org (Postfix) with ESMTP id CA34810E070;
 Thu, 11 Jan 2024 02:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=6XnZjv2AWPiI5dqzax
 Rd+P/BdNiXsS2TWUib8qNZYKo=; b=iBgjqxt4vjbfmHHDs60si/oISpoy7ig8nT
 LTK3ltXA48wnW8Dfpbju1D9ZlHi6q3+y9JA7wVMbIHRZDJ9hVEfU1mH3MSmd1kOQ
 t72tNk3nr6O7uRAIWUHmJ7tx21VrbISJjXZdpfV3GqZO85BDGMh+9t0VPDEVgoqk
 D09sQzXRE=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wDnD9uXWJ9lwy+dAA--.10032S2;
 Thu, 11 Jan 2024 10:55:19 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: Xinhui.Pan@amd.com, daniel@ffwll.ch, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com
Subject: [PATCH] drm/amd/include: Clean up errors in arct_ip_offset.h
Date: Thu, 11 Jan 2024 02:55:17 +0000
Message-Id: <20240111025517.6687-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDnD9uXWJ9lwy+dAA--.10032S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48Kry8Zr1xWw4rKrg_yoWfJrc_Ca
 4xJ395W3y7uFnFqF1akFn3u34j9a1ruFnYqw1fta4rtrZFkr4UW395Jr42qr4ruFs3CFsr
 Z3WkXFW5ZrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUj2NtUUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiGA5ixWVLZWL-aQADsN
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
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, chenxuebing <chenxb_99091@126.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/arct_ip_offset.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/arct_ip_offset.h b/drivers/gpu/drm/amd/include/arct_ip_offset.h
index af1c46991429..7dd876f7df74 100644
--- a/drivers/gpu/drm/amd/include/arct_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/arct_ip_offset.h
@@ -25,13 +25,11 @@
 #define MAX_SEGMENT                                         6
 
 
-struct IP_BASE_INSTANCE
-{
+struct IP_BASE_INSTANCE {
     unsigned int segment[MAX_SEGMENT];
 } __maybe_unused;
 
-struct IP_BASE
-{
+struct IP_BASE {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
 } __maybe_unused;
 
-- 
2.17.1

