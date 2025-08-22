Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AFFCA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 21:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CECA910E176;
	Fri, 22 Aug 2025 21:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GpmXWaRk";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 438B910E176;
 Fri, 22 Aug 2025 21:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1zTRYu0shRUoazcBnxVUPHtcyqFoRoGTns37iV4c0hs=; b=GpmXWaRk1xda+njbZ3TdStktTL
 XFRKeTHHsmqHC742HpHFxm98Vs0TrGgHd5akNNrWIwSJVHuFr935wliOkr4F9S54deQv2fYYkUF3/
 o3FMm2Mk8w2+JJ984tQPRqZyXyncfMtvanX6AM7EhEo1xYm9KUerJiInxnJyj0OKW3D1oBLRKMBVD
 42Uo0de2aBBkPTEhW7QE6R6fYyEq/iE67mdPKSZXuHP4TlONokn7zFBc3hJ4O7V67nXRIHtjWpj0R
 5s2f8By36lZ26SlTlDENkbgYnHkHIN/mQjvEoY/XMiE5ADa/91BrteU40Zh8BWYCVkXm3fa8ZROy+
 ImiVpFXw==;
Received: from [189.6.13.79] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1upZ7A-000Hyz-4X; Fri, 22 Aug 2025 23:16:00 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, sunpeng.li@amd.com
Cc: Xaver Hugl <xaver.hugl@gmail.com>, Christopher Snowhill <kode54@gmail.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
Subject: [PATCH 0/2] drm/amd/display: don't overwrite regamma LUT with empty
 data
Date: Fri, 22 Aug 2025 18:14:06 -0300
Message-ID: <20250822211552.1472375-1-mwen@igalia.com>
X-Mailer: git-send-email 2.47.2
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

Hey,


KDE/Plasma users reported some flickering when applying the regamma CRTC
LUT to an AMD display hardware set using an external or integrated
screen. There is some instability in how the driver stores and updates
color blocks based on color management changes or full update request.
It uses update_flag bits for surface and stream and forces some color
blocks to update without considering the previous settings.

This two-patch series avoids this issue by
(1) not calling set_output_transfer_func when the output TF has not
changed;
(2) preserve the previous out_tf value in the case of a full
update, which was unconditionally setting all update_flag bits to true
regardless of previous values.

This modifies DC and may affect behavior on other platforms. On the
other hand, it avoids unnecessary reprogramming of MPC output gamma.

Melissa

Melissa Wen (2):
  Revert "drm/amd/display: program output tf when required"
  drm/amd/display: don't update out gamma if out_tf didn't change

 drivers/gpu/drm/amd/display/dc/core/dc.c                | 5 +++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 5 +----
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.47.2

