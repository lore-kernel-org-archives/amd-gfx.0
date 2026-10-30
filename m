Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AC606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=mU/J96BJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C887112849;
	Fri, 30 Oct 2026 14:27:42 +0000 (UTC)
X-Greylist: delayed 1802 seconds by postgrey-1.36 at gabe;
 Fri, 30 Oct 2026 13:03:31 UTC
Received: from mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F3810E886
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 13:03:30 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=J6yTWKvyYdR4sg8KhoLGX7qxgtJ97l4XZ+Y485k12dw=; 
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793365409; v=1; x=1793970209;
 b=mU/J96BJhUjkb4lGesNgcsqylfGsI9XcWau6+yzYhM9zymxchFY4in1Q2DWaSZ3RfPEyy27a
 w/RC5uDOEXy0Y+pTyvPit5n0rRqd0wLx9aLWohIqIZNc6gy50gYUmbar6s1MpJWmZhLrZ/uvc01
 9GkbNQeXMxQVPzLJV8YSInGAy1DZIyZfxLt/HZuC6tKrgez/nucSh4IfE5rzsOBwE/0CskE7Tn9
 /cqklWoDSHjTbriZ+S4+MgAzOFkz/R71J4/2jRKN0ErFaTApzjes/OMaCcZyHo36sMFLeB9RCS2
 6hHE/ZlY343DlfKGUVinyTrKZMK+kvhJSsxHiNuvY6u/g==
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 323cb4c8f6ab2be3;
 Fri, 30 Oct 2026 12:27:23 +0000
X-Mizu-Trace-ID: 323cb4c8f6ab2be3
X-Migadu-Flow: FLOW_OUT
Date: Fri, 30 Oct 2026 20:27:13 +0800
From: Weijie Yuan <kernel@wyuan.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry VanZyllDeJong <hvanzyll@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sreeja Golui <sreeja.golui@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Use a plain comment for panel polarity
 declarations
Message-ID: <dfd520477e9987eca7719e537b2865f4abe43043.1793362629.git.wy@wyuan.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 30 Oct 2026 14:27:34 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi, when running 'make htmldocs', Sphinx complains:

WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:3883 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * Panel Polarity Control

But since I am not familiar with your workflow, if this is duplicate,
please feel free to ignore.

Also for this file:

WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:329 struct member 'max_gamut_remap_coeff' not described in 'mpc_color_caps'
WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:2225 struct member 'u' not described in 'dc_probe_status'
WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:329 struct member 'max_gamut_remap_coeff' not described in 'mpc_color_caps'
WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:2225 struct member 'u' not described in 'dc_probe_status'

Thanks.

-- >8 --
From: Weijie Yuan <wy@wyuan.org>

The Panel Polarity Control heading introduces several declarations
rather than documenting a single function. Its kernel-doc opener
causes a warning because the heading is not a valid kernel-doc block.

Use an ordinary block comment for this section heading.

Fixes: 7dcd85c2241f ("drm/amd/display: eDP panel polarity control and test support")
Signed-off-by: Weijie Yuan <wy@wyuan.org>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3c484f45333..03286f6aa651 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -3880,7 +3880,7 @@ unsigned int dc_override_memory_bandwidth_request(
 		struct dc *dc,
 		unsigned int bw_mbps);
 
-/**
+/*
  * Panel Polarity Control
  */
 void dc_link_set_panel_polarity_enable(struct dc_link *link, bool enable);
-- 
2.56.0.438.g30c3f27cb8

