Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D71D3A676
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E81210E6A9;
	Tue, 29 Oct 2024 17:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.b="qYcv+KYz";
	dkim-atps=neutral
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDA5410E652;
 Tue, 29 Oct 2024 13:32:06 +0000 (UTC)
Received: from fpc.intra.ispras.ru (unknown [10.10.165.10])
 by mail.ispras.ru (Postfix) with ESMTPSA id 65B6F40AC4FC;
 Tue, 29 Oct 2024 13:32:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 65B6F40AC4FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1730208724;
 bh=CY9WpoB1ebMA/1wZn75hZzNlIToBl0ATXQ6g1HGBfV4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qYcv+KYzIcnp9KmvvsZoD3pjgBb8IXPILX2ZHTC28ZQIXspvwCHxjVFAKXs1+SQ0c
 RKAiILnJmK3fOtbz2a3+dTYjF0GndeEk8kOSiZ5/aWDs8Wm0HmEvN89e+cj1zULCDt
 UzTZ2CkomfK4bQ4LMTuMeh/BKCKwmr6679HHLSeQ=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
 Jonathan Gray <jsg@jsg.id.au>
Subject: [PATCH 6.1 1/1] Revert "drm/amd/display: Skip Recompute DSC Params if
 no Stream on Link"
Date: Tue, 29 Oct 2024 16:31:41 +0300
Message-Id: <20241029133141.45335-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029133141.45335-1-pchelkin@ispras.ru>
References: <20241029133141.45335-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Oct 2024 17:03:44 +0000
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

This reverts commit 7c887efda1201110211fed8921a92a713e0b6bcd.

It is a duplicate of the change made in 6.1.105 by commit 282f0a482ee6
("drm/amd/display: Skip Recompute DSC Params if no Stream on Link").

This is a consequence of two "similar" upstream commits existence, one of
which has been cherry-picked.

Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 1acef5f3838f..855cd71f636f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1255,9 +1255,6 @@ static bool is_dsc_need_re_compute(
 		}
 	}
 
-	if (new_stream_on_link_num == 0)
-		return false;
-
 	if (new_stream_on_link_num == 0)
 		return false;
 
-- 
2.39.5

