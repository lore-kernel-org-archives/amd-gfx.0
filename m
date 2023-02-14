Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAE8C64ED6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 12:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF04310E8A6;
	Tue, 14 Feb 2023 12:14:13 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F2610E1E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VXNuM2Q0JHGOXpY0JQ2FsN4bpU/a23X4yQRVwHk5wkU=; b=dVX6QhbV6Pr9mJSLyqFDpQ0ogy
 H331QqlPPE2/dudiGbmw1oQVOdvtXdd37ccR3Mc3idGV/bTX9B6SGiYGlCuxL48XvUVbzuc8Ad7OU
 u6XZ0xHb92BJfua4aX9sRs2d5kdE22UYDGzMAzQXnTiQDs3l9OyhanoEE0ho+WOd/d7n7OEXAk7qK
 iePzZ64Ek3hpf64MsiX7EHNBVtt+3RyDd6B9p1JaNzCE7eo1ra+KHF7ALfLhLNltL2YolIAgK4Xpy
 k4xKN52K0z/vIN+REz+NThHkt63Z18qDj9c5DYhKB/bws9evkp2lycBoukFe6nsopoRSeZpTVk9LR
 wLsLX9Qw==;
Received: from [38.44.66.31] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pRuCG-0022pF-VF; Tue, 14 Feb 2023 13:14:09 +0100
From: Melissa Wen <mwen@igalia.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amd/display: ident braces in
 dcn30_acquire_post_bldn_3dlut correctly
Date: Tue, 14 Feb 2023 11:14:01 -0100
Message-Id: <20230214121406.97750-2-mwen@igalia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230214121406.97750-1-mwen@igalia.com>
References: <20230214121406.97750-1-mwen@igalia.com>
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
Cc: sunpeng.li@amd.com, Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
 kernel-dev@igalia.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index feb4bb491525..60bb5634b6e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1477,8 +1477,8 @@ bool dcn30_acquire_post_bldn_3dlut(
 				state->bits.mpc_rmu2_mux = mpcc_id;
 			ret = true;
 			break;
-			}
 		}
+	}
 	return ret;
 }
 
-- 
2.39.0

