Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560AEE9413E
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Dec 2025 10:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7BCF10E89A;
	Tue, 30 Dec 2025 10:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=zukunftsfirma.de header.i=@zukunftsfirma.de header.b="UG8Bntbg";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C2FC10E749
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 22:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zukunftsfirma.de;
 s=protonmail; t=1767047202; x=1767306402;
 bh=Yg4kX+P8FMYtSkANlGes/bcs+pX/UGCk4bUyWs0IyMM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=UG8Bntbg4Hsgo79TzVdWa2uDog9GknxfwTmcXhLp9wJsW0XUD5O7ia+klrsTxdK3+
 pAI5cjOJ8e24U6qOO+dxJVvBecHjxTMsvNER793OT2xg3J+AqGnA1ni9StUUmLxgRv
 q6gK4mZsm2X+mU6kbyBP2fhGKiX/YCOO/sAvBMm/yOKYku5uMJB08m/ADhsnCmMRyv
 BLtOJsoQEO7KdWRjZalAN8e+0n9M8+zv/oOupd9YFUsRNb0pixjXjjTQEzm24kvB6Z
 YX3SwblNgDYSyqGzGm6PiS9vIAS9DEqC21rhsarUx/Dyj6eOXN/4obao3CQuGF7rkz
 YlTlL4ElYffTg==
Date: Mon, 29 Dec 2025 22:26:39 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Andreas Bauer <a.bauer@zukunftsfirma.de>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
 "siqueira@igalia.com" <siqueira@igalia.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Subject: [PATCH] drm/amd/display: correct AMDGPU Display Core logging logic
Message-ID: <LVfjg-aB1imeW8XJ78g5RCTXiCx_3MBoRi2qZs-1LpzvAaNe9DP6qgW9yUpUuHLMSd-oNHbyQ5mG8FdcjNsv9o53SMg3UQZgqPrA22t5vX8=@zukunftsfirma.de>
Feedback-ID: 149865295:user:proton
X-Pm-Message-ID: dba1f3d43dc289ce1765e654a5e1784e04fe688e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 30 Dec 2025 10:02:55 +0000
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

In: drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c

dp_is_lttpr_present() does output a DC_LOG_ERROR() when monitor reports
DPCD lane count non zero but no lanes detected, and gracefully falls back
to ignoring what the monitor reports.

dp_retrieve_lttpr_cap() also logs an DC_LOG_ERROR() when hardware returns
wrong count. Fallback means also graceful handling.

According to documentation, DC_LOG_WARNING() is supposed to be used for=20
this case (hardware bug with graceful fallback)

Change DC_LOG_ERROR() to DC_LOG_WARNING() in both cases.

Signed-off-by: Andreas Bauer <a.bauer@zukunftsfirma.de>
---
diff -uprN linux-source-6.18.orig/drivers/gpu/drm/amd/display/dc/link/proto=
cols/link_dp_capability.c linux-source-6.18.modified/drivers/gpu/drm/amd/di=
splay/dc/link/protocols/link_dp_capability.c
--- linux-source-6.18.orig/drivers/gpu/drm/amd/display/dc/link/protocols/li=
nk_dp_capability.c   2025-12-29 21:03:40.477580191 +0000
+++ linux-source-6.18.modified/drivers/gpu/drm/amd/display/dc/link/protocol=
s/link_dp_capability.c       2025-12-29 22:09:47.338435938 +0000
@@ -391,7 +391,8 @@ bool dp_is_lttpr_present(struct dc_link
                        link->dpcd_caps.lttpr_caps.max_lane_count <=3D 4);
=20
        if (lttpr_count > 0 && !is_lttpr_present)
-               DC_LOG_ERROR("LTTPR count is nonzero but invalid lane count=
 reported. Assuming no LTTPR present.\n");
+               DC_LOG_WARNING("LTTPR count is nonzero but invalid lane cou=
nt reported. " +
+                              "Assuming no LTTPR present.\n");
=20
        return is_lttpr_present;
 }
@@ -1638,7 +1639,7 @@ enum dc_status dp_retrieve_lttpr_cap(str
                /* If you see this message consistently, either the host pl=
atform has FIXED_VS flag
                 * incorrectly configured or the sink device is returning a=
n invalid count.
                 */
-               DC_LOG_ERROR("lttpr_caps phy_repeater_cnt is 0x%x, forcing =
it to 0x80.",
+               DC_LOG_WARNING("lttpr_caps phy_repeater_cnt is 0x%x, forcin=
g it to 0x80.",
                             link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
                link->dpcd_caps.lttpr_caps.phy_repeater_cnt =3D 0x80;
                lttpr_count =3D 1;

