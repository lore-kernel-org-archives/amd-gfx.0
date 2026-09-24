Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FDDC98326
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 21:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB14110F79C;
	Thu, 24 Sep 2026 21:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="EhbQyeWs";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28AEE10E206
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 21:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=5wbo90drhctlfwJ8CsrDNmKRLKeNmRyIMleVH6A8EAw=; b=
 EhbQyeWsmT+wcvDtfYJ7H8RgQydnFpn/m6Ooaq0ErTxoZGkwP8wING4tTE/i8HKK9HjjNSa96fQ+q
 kZm/t2yWZX1zJg8In661/8YE6QiSGJzfoJ7Aif5Dy9ZTvkoy++960FcZW4TasFWM4GTFxDZvvq3tG
 jU31YULhMEzKuGPha/z37U1FHdWhQ6KfEIux1LWGmZrFW8O2/WFqS3rLNolsECeBO2zWyDjUakFYr
 boDAKGU3HONtq2VSx+7hfSsYQki76pka9i36Mttcy12R4REQgY/ve4Iz6RRw8joD4o6tczW1T5uCr
 gCwIc1lL/vD5bm/NuLt9zexDPkkSahLo0Q==;
Received: from 113.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.113]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9qlk-006qf4-4y; Thu, 24 Sep 2026 23:14:15 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 Aurabindo.Pillai@amd.com, christian.koenig@amd.com, David.Francis@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] drm/amd/display: copy function name into dcn_fpu trace
 event
Date: Thu, 24 Sep 2026 23:10:10 +0200
Message-ID: <20260924211410.867686-8-mwen@igalia.com>
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

Userspace trace tools that use libtraceevent to read binary buffer only
see a kernel address when printing const char *. Use string macros in
dcn_fpu to copy the function name into the trace event.

Fixes: 96ee63730fa3 ("drm/amd/display: Add control mechanism for FPU")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 7de4fe355c5d..b2f38654e489 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -637,20 +637,20 @@ TRACE_EVENT(dcn_fpu,
 
 	    TP_STRUCT__entry(
 			     __field(bool, begin)
-			     __field(const char *, function)
+			     __string(function, function)
 			     __field(int, line)
 			     __field(int, recursion_depth)
 	    ),
 	    TP_fast_assign(
 			   __entry->begin = begin;
-			   __entry->function = function;
+			   __assign_str(function);
 			   __entry->line = line;
 			   __entry->recursion_depth = recursion_depth;
 	    ),
 	    TP_printk("%s: recursion_depth: %d: %s()+%d:",
 		      __entry->begin ? "begin" : "end",
 		      __entry->recursion_depth,
-		      __entry->function,
+		      __get_str(function),
 		      __entry->line
 	    )
 );
-- 
2.53.0

