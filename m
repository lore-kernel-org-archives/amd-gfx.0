Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B58C63797
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Jan 2023 15:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD1C110E013;
	Sun, 15 Jan 2023 15:29:31 +0000 (UTC)
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9CE10E0EA;
 Sun, 15 Jan 2023 10:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
 t=1673776843; bh=/iD5FdGsACL4AeAQezA9XNB8C/O5bx6Q/X5pHtL9znk=;
 h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
 Content-Type;
 b=j/AHSimET66MvDWv+l8/PtEAWvnrhLtKagZQwJmMQZcGGc2STk00RUpyw8LALrtNM
 ZnsIOPFDKQvAX/0CNhJx6g+LV5WxkZpCK/+5ao00eYs/low/H+qAJjJcLjhzpGnWfw
 tEoHNhFdf3SdsMewyN0YhTKDmukAc7EcXt/C0cQo=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Sun, 15 Jan 2023 11:00:43 +0100 (CET)
X-EA-Auth: QUVQkKdtaa3ThPmH0jN9hkKBEF3clhbPL9AScoOFF2o6Ipb8m9b2YiEd1CacQfHgw+lTtqJAFAhum5ZmXRrFw35fBU6TjDC8
Date: Sun, 15 Jan 2023 15:30:38 +0530
From: Deepak R Varma <drv@mailo.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Simplify same effect if/else blocks
Message-ID: <Y8POxreeC3EvOXhC@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The if / else block code has same effect irrespective of the logical
evaluation.  Hence, simply the implementation by removing the unnecessary
conditional evaluation. While at it, also fix the long line checkpatch
complaint. Issue identified using cond_no_effect.cocci Coccinelle
semantic patch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: The proposed change is compile tested only. If there are any
inbuilt test cases that I should run for further verification, I will appreciate
guidance about it. Thank you.

 drivers/gpu/drm/amd/display/dc/core/dc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0cb8d1f934d1..776209e5d21f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3470,14 +3470,9 @@ static void commit_planes_for_stream(struct dc *dc,
 		/* Since phantom pipe programming is moved to post_unlock_program_front_end,
 		 * move the SubVP lock to after the phantom pipes have been setup
 		 */
-		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
-			if (dc->hwss.subvp_pipe_control_lock)
-				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
-		} else {
-			if (dc->hwss.subvp_pipe_control_lock)
-				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
-		}
-
+		if (dc->hwss.subvp_pipe_control_lock)
+			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes,
+							 NULL, subvp_prev_use);
 		return;
 	}
 
-- 
2.34.1



