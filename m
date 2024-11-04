Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65F4D132A0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 09:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C6710E3AF;
	Mon,  4 Nov 2024 09:05:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="kmGlBaoK";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6EC10E34D;
 Mon,  4 Nov 2024 02:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=a3nXRmMUduQ2/YHll+SByumVwEVppPq0Utwsrag57XM=; b=kmGlBaoKJLdzBbp1
 h97eoq4mbYQLTmYs5iwFH5VZW8kpqmjQWS0uc4aPbaOOjjHA7LcqvCX16NE8539saqvlzrphyUR5y
 G92oI0PpfSGWYh1678l4SGwIbDWI1ey5C5dXY8oU+UYZx39/7BMMwdlhHppHJPn5pFVFSeXOrWwqq
 vIJ3iEYYsI0UwpufMNXQrC5OvAav/SDTxRjnxwUEG6OWR5bFDigCL2/i2UYN8rS8BIXP4+Afa9qAt
 L14qEn+j1ye8ip0xUw6AwR8uVKncK68VdhZBvke/fe7nxOcgUpO2emWFdOsGtGOJArmOmPI/N29Dn
 LY2rb4o2UryRIoySwg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <linux@treblig.org>) id 1t7mzW-00FECw-1x;
 Mon, 04 Nov 2024 02:38:54 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 chaitanya.dhere@amd.com, jun.lei@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/5] Some more drm/amd/display deadcoding
Date: Mon,  4 Nov 2024 02:38:47 +0000
Message-ID: <20241104023852.492497-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 04 Nov 2024 09:05:01 +0000
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This removes a bunch more functions (and a field) from
drm/amd/display that are unused.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Dave

Dr. David Alan Gilbert (5):
  drm/amd/display: Remove unused enable_surface_flip_reporting
  drm/amd/display: Remove unused dwb3_set_host_read_rate_control
  drm/amd/display: Remove unused dc_stream_warmup_writeback
  drm/amd/display: Remove unused mmhubbub_warmup field
  drm/amd/display: Remove unused dcn_find_dcfclk_suits_all

 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  11 --
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   7 -
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 -
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  | 132 ------------------
 .../drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c  |  13 --
 .../drm/amd/display/dc/dwb/dcn30/dcn30_dwb.h  |   1 -
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   1 -
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   1 -
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   1 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 -
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 -
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   4 -
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 -
 .../gpu/drm/amd/display/dc/inc/dcn_calcs.h    |   4 -
 17 files changed, 187 deletions(-)

-- 
2.47.0

