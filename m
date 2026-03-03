Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D1EEDEBF0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 21:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06D110E8DB;
	Tue,  3 Mar 2026 21:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="Nw3mJ1BB";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7236410E8D6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-953a8a3ca9; t=1772572748;
 bh=8LtyKwPG/bc6wio3zDAJHqbTFoe1AI885LVCRiG/Biw=;
 b=Nw3mJ1BBm3zbrQt0fJ1jIW7eFHsrfWd47QwUQX2VBVqCUiEKAPTfOLdKxnH0wvzxfUTCLn+Fc
 hQpDmZ1xDlAvGLKeHcLf5xYjS7XFjXA60WEDSVxIqC/N34ZLEQAVxBl5WAbpQOsTwoaxSWMmC7n
 eKmQ99k3RDpz8ZjoZwWZCiKAWZ7X1MhRPWPTHOfDkSkEnn5OU89OYtVurqWkEzDADt8soeS//Yi
 JGxR4ru1cgI6Q81Bx4B8lHL+FvsIhNUfaGaqRuu6Xy8OdvgA/8u8BINNHnU721uUUl10Z+eGfpy
 lyLRx3ChEt6Xiv23/EIJNOyP/0+CV7gr+ER2SISgo7Rg==
X-Forward-Email-ID: 69a75046b5d0800e9c1eff89
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.37
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
Subject: [PATCH RESEND 0/2] drm/amdgpu/amdgpu_connectors: Use struct drm_edid 
Date: Tue,  3 Mar 2026 16:18:21 -0500
Message-ID: <20260303211823.76631-1-jpeisach@ubuntu.com>
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

These patches replace uses of struct edid with struct drm_edid, and
updates function calls appropriately.
                                                                                                                                                                                                      
Additionally, amdgpu_connector_free_edid is no longer needed, and can be
removed.

Joshua Peisach (2):
  drm/amdgpu/amdgpu_connectors: use struct drm_edid instead of struct
    edid
  drm/amdgpu/amdgpu_connectors: remove amdgpu_connector_free_edid

 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 54 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  4 +-
 5 files changed, 30 insertions(+), 38 deletions(-)

-- 
2.51.0

