Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0386C6FA8A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 14:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAF6910E73C;
	Tue, 13 Sep 2022 14:20:17 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0DCD10E743;
 Tue, 13 Sep 2022 14:18:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 07DE9614A8;
 Tue, 13 Sep 2022 14:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5610C433C1;
 Tue, 13 Sep 2022 14:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1663078718;
 bh=I0CTipt04eDDrxw8dXxjJalEC8kmJXvopncOc6H0PnQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DUaFBCISHKHeuZGBxFvfuU+JyUszIUWtMXlN1qvfn5soqrWYdJ5BwC6md75PP0X2T
 vUNHTnwUTAJ4RSUhxU0MC6ucvGCyphnwCwRde0AYBycOqoRyXa4BA1MpprCNtSq4QM
 deiJsSXWi/uskM8oIW9k1sWpV8VWNamIx3JaQZlw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5.15 038/121] drm/amd/display: fix memory leak when using
 debugfs_lookup()
Date: Tue, 13 Sep 2022 16:03:49 +0200
Message-Id: <20220913140358.996346459@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913140357.323297659@linuxfoundation.org>
References: <20220913140357.323297659@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Sep 2022 14:20:10 +0000
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
Cc: David Airlie <airlied@linux.ie>, Wenjing Liu <wenjing.liu@amd.com>,
 dri-devel@lists.freedesktop.org,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Yongzhi Liu <lyz_cs@pku.edu.cn>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Thelford Williams <tdwilliamsiv@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 Sean Paul <seanpaul@chromium.org>, Mikita Lipski <mikita.lipski@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, stable@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, hersen wu <hersenxs.wu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit cbfac7fa491651c57926c99edeb7495c6c1aeac2 upstream.

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  Fix this up by properly
calling dput().

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: hersen wu <hersenxs.wu@amd.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Thelford Williams <tdwilliamsiv@gmail.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc: Mikita Lipski <mikita.lipski@amd.com>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: Bhanuprakash Modem <bhanuprakash.modem@intel.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3007,7 +3007,7 @@ void crtc_debugfs_init(struct drm_crtc *
 				   &crc_win_y_end_fops);
 	debugfs_create_file_unsafe("crc_win_update", 0644, dir, crtc,
 				   &crc_win_update_fops);
-
+	dput(dir);
 }
 #endif
 /*


