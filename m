Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F4DE7BDB7
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 12:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E7310E1B5;
	Mon, 16 Feb 2026 12:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="etdmPV+f";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D15BF10E04C
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 12:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-953a8a3ca9; t=1771246047;
 bh=V1Z3hGz1dpz3ZD/ONtlOtYsxZmcalA1tBPvg9ZVacI4=;
 b=etdmPV+flGieq3lq0W2vlRcpjarsSd7VETF12CVAzXkpHWmk8pOx2Lo6qwLx3V39ftXmuqJnn
 5odaV7XmJjMAY3L/qW3rjKG8bkaOVg0jKPfqUjspLzkHvUh7W3mf7u+j2IqHdvXOqYfRo0XhqA9
 hjj0sWIcg8cKbmk/XGVvlSv+MaZUNIygcYWMTRVcsd6tUiX8tUQrUW/5Qbt4ekW8vVoGwhDxb1w
 O+yPg7ZeCRhkQHw06r0/9LnVuonLwbvQhu+TGLGSd+RRB78rfh7pnVz7DHVwK8/15OKBjPOpqbn
 rccGRkWzDF8S1s+6eCf/UvUxsswFSYoFm0KfS5dlY8Mg==
X-Forward-Email-ID: 699311dbcde16816033f1b8a
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Joshua Peisach <jpeisach@ubuntu.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Peisach <jpeisach@ubuntu.com>
Subject: [PATCH 0/2] drm/radeon: use struct drm_edid
Date: Mon, 16 Feb 2026 07:46:31 -0500
Message-ID: <20260216124633.42644-1-jpeisach@ubuntu.com>
X-Mailer: git-send-email 2.51.0
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

This series replaces uses of struct edid with struct drm_edid, to
remove usage of deprecated functions.

radeon_connector_free_edid is also no longer necessary, and is removed.

These changes are essentially the same as what I've sent for amdgpu.

Untested, testing and review much appreciated.

Link: https://lore.kernel.org/amd-gfx/20260212222029.15777-1-jpeisach@ubuntu.com/T/

Joshua Peisach (2):
  drm/radeon: use struct drm_edid instead of struct edid
  drm/radeon: remove radeon_connector_free_edid

 drivers/gpu/drm/radeon/radeon_audio.c      |  4 +-
 drivers/gpu/drm/radeon/radeon_combios.c    |  4 +-
 drivers/gpu/drm/radeon/radeon_connectors.c | 52 +++++++++-------------
 drivers/gpu/drm/radeon/radeon_mode.h       |  4 +-
 4 files changed, 28 insertions(+), 36 deletions(-)

-- 
2.51.0

