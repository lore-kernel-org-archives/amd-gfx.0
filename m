Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2E8C3DA78
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Jan 2023 15:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B83610E0A6;
	Sun, 15 Jan 2023 15:29:33 +0000 (UTC)
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F019210E270;
 Sat, 14 Jan 2023 21:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
 t=1673731183; bh=owq0V8Z5J5JXHykzSdI48m2IFtIiUsNYU2CP5ngYPr0=;
 h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:In-Reply-To;
 b=mUufoRU+8iSF5aXSDt3h7gFlOj8ZSAFBukg/PowlUKMV1bfjgYMcr1KCErQf9uvO4
 S5WgCuiEU+ohY3zJ6xdXtdlgmwSuK7Lap0yFZZ/y33dRL3kfcrdetIJXJ3QLWGPkKD
 +U/iNDsDJ8KICHOFmRgVgwLxIX0YL7uPMOFuQoTA=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Sat, 14 Jan 2023 22:19:43 +0100 (CET)
X-EA-Auth: XjbgxV8xfhLFIR/KHb5unaAxENENTr1v3YYLJmUp0lp/06kHa7M69jD4pjH5hvopgPaes/9RFKsiI3zxVKjnvNz2UL7P7CaC
Date: Sun, 15 Jan 2023 02:49:39 +0530
From: Deepak R Varma <drv@mailo.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/amd/display: Use min()/max() macros in dcn_calc_math
Message-ID: <fd6e5bea063d2cfde8bde7d10a7309214acf9251.1673730293.git.drv@mailo.com>
References: <cover.1673730293.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673730293.git.drv@mailo.com>
X-Mailman-Approved-At: Sun, 15 Jan 2023 15:29:29 +0000
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
Cc: Praveen Kumar <kumarpraveen@linux.microsoft.com>,
 Saurabh Singh Sengar <ssengar@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the standard min() / max() helper macros instead of direct variable
comparison using if/else blocks or ternary operator. Change identified
using minmax.cocci Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 .../gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c   | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
index cac72413a097..81629f3715d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
@@ -52,12 +52,12 @@ float dcn_bw_min2(const float arg1, const float arg2)
 		return arg2;
 	if (isNaN(arg2))
 		return arg1;
-	return arg1 < arg2 ? arg1 : arg2;
+	return min(arg1, arg2);
 }
 
 unsigned int dcn_bw_max(const unsigned int arg1, const unsigned int arg2)
 {
-	return arg1 > arg2 ? arg1 : arg2;
+	return max(arg1, arg2);
 }
 float dcn_bw_max2(const float arg1, const float arg2)
 {
@@ -65,7 +65,7 @@ float dcn_bw_max2(const float arg1, const float arg2)
 		return arg2;
 	if (isNaN(arg2))
 		return arg1;
-	return arg1 > arg2 ? arg1 : arg2;
+	return max(arg1, arg2);
 }
 
 float dcn_bw_floor2(const float arg, const float significance)
@@ -93,12 +93,12 @@ float dcn_bw_ceil2(const float arg, const float significance)
 
 float dcn_bw_max3(float v1, float v2, float v3)
 {
-	return v3 > dcn_bw_max2(v1, v2) ? v3 : dcn_bw_max2(v1, v2);
+	return max(v3, dcn_bw_max2(v1, v2));
 }
 
 float dcn_bw_max5(float v1, float v2, float v3, float v4, float v5)
 {
-	return dcn_bw_max3(v1, v2, v3) > dcn_bw_max2(v4, v5) ? dcn_bw_max3(v1, v2, v3) : dcn_bw_max2(v4, v5);
+	return max(dcn_bw_max3(v1, v2, v3), dcn_bw_max2(v4, v5));
 }
 
 float dcn_bw_pow(float a, float exp)
-- 
2.34.1



