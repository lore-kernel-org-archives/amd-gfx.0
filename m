Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F4FCA0EF1
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 16:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6594110E431;
	Tue, 12 Sep 2023 16:02:06 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6BF310E435
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 16:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Vj4gxxScw/Vp7v6SP1kCTYDaPepnrtpNmSV80lcUFoc=; b=Td4ri/X4uplZiL2SKWE+zmfnwN
 9Q/iDrqNhqN/O7h0ImgPUd6bhZUMtxWqzF8xy0DcAltB+OL1t7MfOmY7pHqXeKmYw1NLeynGBlSSP
 Otyt0XkzgwPxa2tzOXt6oq/gsTUHz8ebPVQGzQ0N4CvqrFC5LMYx/4lFBtOzXy/opF248TvyccXYO
 cPd/K/vjH5ZJ3bEwzolaopscZzW/11PCxyzcijC4ldp4DbBTyetVy21FBhwCFSK01+Ri7DmzP0Obq
 QKGxxW4oo5dF8y7LGWRIh2syB/v3gaQ3CyGmBZo+NTppYsXFSY0It0fkmT8fZ3tFxUaRA3o6NIn12
 J06L1c4A==;
Received: from [38.44.68.151] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qg5pv-002m4H-7G; Tue, 12 Sep 2023 18:01:59 +0200
From: Melissa Wen <mwen@igalia.com>
To: Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Subject: [PATCH v2 0/2] drm/amd/display: hook up content_type property
Date: Tue, 12 Sep 2023 15:01:55 -0100
Message-Id: <20230912160157.107975-1-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
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
Cc: kernel-dev@igalia.com, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 amd-gfx@lists.freedesktop.org, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

The first version of this series from Joshua [1] was accepted, but never
merged upstream.

During this time, Guilherme reported issues when performing GPU reset
that point to this work, and I identified the need to mark CRTC state for
reset when the property differs between states.

In this v2, I basically rebase the work to amd-staging-drm-next, add
the r-b tag accordingly and include the fix mentioned above.

Thanks,

Melissa

[1] https://lore.kernel.org/amd-gfx/20230117212620.11262-1-joshua@froggi.es/

Joshua Ashton (2):
  drm/amd/display: Hook up 'content type' property for HDMI
  drm/amd/display: Remove unused display_content_support

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 69 ++++++-------------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 14 ----
 4 files changed, 54 insertions(+), 63 deletions(-)

-- 
2.40.1

