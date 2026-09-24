Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09472C98325
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 21:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A82010E55F;
	Thu, 24 Sep 2026 21:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OQ2/IJoG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFAF10E206
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 21:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=M84mPs65aJFN8Y8PkL2D6LYbGgiqN1ylfaTstFz/I04=; b=
 OQ2/IJoGgJhy0hFHV3CK9NVJlWwF+keBlvah7BsNr/qRqho8PVPd8pGbbikqJigt1Lc2+j6IqUdtq
 bYHOmMw5eJOxiyuAEmzuIaZ7UOkQJSb2b1u9PwBDlmAHmFBcdgXF0IxyZT46rZl0iBf+Rq2akKxPJ
 Pj/KwF/FFOFyUZ2W6WqcbiPDtDupWReaMdwYXJ0e3XM+6zL3G6AL+y8GC5oZesdDHaB/FjcrSeDd9
 XKNAluBAQ3KAu463CPDtz6mZ/EIsNGQ/LdVnNU2WiPyDwJYd3hBeK6m19wGA9pKwiaIy1q/CpVyQb
 ua6i9dpS7YZ23qL1RtnBWrTXxW56gJdhRg==;
Received: from 113.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.113]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9qlk-006qf4-Nu; Thu, 24 Sep 2026 23:14:16 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 Aurabindo.Pillai@amd.com, christian.koenig@amd.com, David.Francis@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] drm/amd/display: copy function name into
 dcn_optc_lock_unlock_state trace event
Date: Thu, 24 Sep 2026 23:10:11 +0200
Message-ID: <20260924211410.867686-9-mwen@igalia.com>
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
dcn_optc_lock_unlock_state to copy the function name into the trace
event.

Fixes: f1943a51f0f9 ("drm/amd/display: Add events log to trace OPTC lock and unlock")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index b2f38654e489..7f05f73e5b33 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -660,7 +660,7 @@ TRACE_EVENT(dcn_optc_lock_unlock_state,
 	    TP_ARGS(optc_state, instance, lock, function, line),
 
 	    TP_STRUCT__entry(
-			     __field(const char *, function)
+			     __string(function, function)
 			     __field(int, instance)
 			     __field(bool, lock)
 			     __field(int, line)
@@ -678,7 +678,7 @@ TRACE_EVENT(dcn_optc_lock_unlock_state,
 			     __field(int, vready_offset)
 	    ),
 	    TP_fast_assign(
-			   __entry->function = function;
+			   __assign_str(function);
 			   __entry->instance = instance;
 			   __entry->lock = lock;
 			   __entry->line = line;
@@ -700,7 +700,7 @@ TRACE_EVENT(dcn_optc_lock_unlock_state,
 		      "min_v_blank_interlace=%d vstartup_start=%d vupdate_offset=%d vupdate_width=%d "
 		      "vready_offset=%d",
 		      __entry->lock ? "Lock" : "Unlock",
-		      __entry->function,
+		      __get_str(function),
 		      __entry->line,
 		      __entry->instance,
 		      __entry->opp_count,
-- 
2.53.0

