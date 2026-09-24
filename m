Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F239EC9831F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 21:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A69E10E206;
	Thu, 24 Sep 2026 21:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nsekJl5z";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E73410E206
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 21:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=zd8JDVNIyfZYZl0PT+G4EhtcGlYUQGrv7pfbpIGnP6I=; b=
 nsekJl5zAj1F5wu/mbPPmJ6X/NdIc2CRiGaSfJ50eo7Ko2FsLbrHtszXqUTGIRx91Vjpv2Z4TwrDN
 mTU2Up/9ERQJrmBdTwccXP+QLCXyU7hyg27dSFtBKG0+kUIwvV6jy9nhQ/6f5dyJB8INKirT7Up+d
 E1I8e7STpSnZsAddybvLPvVo7YpinONZZDIVXMkXGGw3/RAdnKnoTyHIPQzbyiQwKun0oOl4IUMdI
 q+3hpPX7A3i5dGsGjvgW9XVMXEfTLOlbeYKuPIGH8tj2X5Gab7fSulNO8meyGSqEnCJ5yeTtblCW2
 GFY2GNV7zcQavYPhPjuC7SLuHVJD2e/aRA==;
Received: from 113.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.113]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9qli-006qf4-Bf; Thu, 24 Sep 2026 23:14:14 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 Aurabindo.Pillai@amd.com, christian.koenig@amd.com, David.Francis@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] drm/amd/display: declare amdgpu_dm_atomic_state_template
 as an event class
Date: Thu, 24 Sep 2026 23:10:07 +0200
Message-ID: <20260924211410.867686-5-mwen@igalia.com>
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

Don't create an amdgpu_dm_atomic_state_template event since this is just
a template. Declare the template as an event class that will be used by
actual event tracers.

Fixes: e8a982355f96 ("drm/amd/display: Add tracepoint for amdgpu_dm")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 56 +++++++++----------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index f5c2f589f691..c59ba41a9721 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -314,36 +314,32 @@ DEFINE_EVENT(amdgpu_dm_plane_state_template, amdgpu_dm_atomic_update_cursor,
 	     TP_PROTO(const struct drm_plane_state *state),
 	     TP_ARGS(state));
 
-TRACE_EVENT(amdgpu_dm_atomic_state_template,
-	    TP_PROTO(const struct drm_atomic_commit *state),
-	    TP_ARGS(state),
-
-	    TP_STRUCT__entry(
-			     __field(const struct drm_atomic_commit *, state)
-			     __field(bool, allow_modeset)
-			     __field(bool, legacy_cursor_update)
-			     __field(bool, async_update)
-			     __field(bool, duplicated)
-			     __field(int, num_connector)
-			     __field(int, num_private_objs)
-	    ),
-
-	    TP_fast_assign(
-			   __entry->state = state;
-			   __entry->allow_modeset = state->allow_modeset;
-			   __entry->legacy_cursor_update = state->legacy_cursor_update;
-			   __entry->async_update = state->async_update;
-			   __entry->duplicated = state->duplicated;
-			   __entry->num_connector = state->num_connector;
-			   __entry->num_private_objs = state->num_private_objs;
-	    ),
-
-	    TP_printk("state=%p allow_modeset=%d legacy_cursor_update=%d "
-		      "async_update=%d duplicated=%d num_connector=%d "
-		      "num_private_objs=%d",
-		      __entry->state, __entry->allow_modeset, __entry->legacy_cursor_update,
-		      __entry->async_update, __entry->duplicated, __entry->num_connector,
-		      __entry->num_private_objs)
+DECLARE_EVENT_CLASS(amdgpu_dm_atomic_state_template,
+		    TP_PROTO(const struct drm_atomic_commit *state),
+		    TP_ARGS(state),
+		    TP_STRUCT__entry(__field(const struct drm_atomic_commit *, state)
+				     __field(bool, allow_modeset)
+				     __field(bool, legacy_cursor_update)
+				     __field(bool, async_update)
+				     __field(bool, duplicated)
+				     __field(int, num_connector)
+				     __field(int, num_private_objs)
+		    ),
+		    TP_fast_assign(__entry->state = state;
+				   __entry->allow_modeset = state->allow_modeset;
+				   __entry->legacy_cursor_update = state->legacy_cursor_update;
+				   __entry->async_update = state->async_update;
+				   __entry->duplicated = state->duplicated;
+				   __entry->num_connector = state->num_connector;
+				   __entry->num_private_objs = state->num_private_objs;
+		    ),
+		    TP_printk("state=%p allow_modeset=%d legacy_cursor_update=%d "
+			      "async_update=%d duplicated=%d num_connector=%d "
+			      "num_private_objs=%d",
+			      __entry->state, __entry->allow_modeset,
+			      __entry->legacy_cursor_update, __entry->async_update,
+			      __entry->duplicated, __entry->num_connector,
+			      __entry->num_private_objs)
 );
 
 DEFINE_EVENT(amdgpu_dm_atomic_state_template, amdgpu_dm_atomic_commit_tail_begin,
-- 
2.53.0

