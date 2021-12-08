Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68355C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 03:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462BA6E0E3;
	Wed,  8 Dec 2021 03:16:43 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E7F06E250
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 01:32:47 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J7zyw2qx2zF4gk;
 Tue,  7 Dec 2021 17:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1638926792; bh=VJbV97pHTJC8AS8Nd8TffNqFCGGlvcCC144+loyaNqQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tY18vsU0FNv5j9YjUfCQP9+zLc1y/kCL/8YCuzynydg1sDuTgI6Ul472zPssagd2n
 a5DICP+jA8ZJEc+H4hM4hzA+iDuHskt5ptMotR4/RWHCKOn864S/lqLFMn7sOmg9EZ
 rZTlmEY8h4S4ys6Xy1VDG9bnQVAw3Gb5pWihQNlU=
X-Riseup-User-ID: 7477355199DC68DB69D435C2B7857633E972311AC2EE236E5195E1BCCEAED713
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4J7zyt0LBSz5vkY;
 Tue,  7 Dec 2021 17:26:29 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH 05/10] drm/amdkfd: fix function scopes
Date: Tue,  7 Dec 2021 22:25:24 -0300
Message-Id: <20211208012529.372478-6-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-1-isabbasso@riseup.net>
References: <20211208012529.372478-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Dec 2021 03:16:41 +0000
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
Cc: ~lkcamp/patches@lists.sr.ht, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 This turns previously global functions into static, thus removing
 compile-time warnings such as:

 warning: no previous prototype for 'pm_set_resources_vi' [-Wmissing-prototypes]
 113 | int pm_set_resources_vi(struct packet_manager *pm, uint32_t *buffer,
     |     ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index 08442e7d9944..3c0658e32e93 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -110,8 +110,8 @@ static int pm_runlist_vi(struct packet_manager *pm, uint32_t *buffer,
 	return 0;
 }
 
-int pm_set_resources_vi(struct packet_manager *pm, uint32_t *buffer,
-				struct scheduling_resources *res)
+static int pm_set_resources_vi(struct packet_manager *pm, uint32_t *buffer,
+			       struct scheduling_resources *res)
 {
 	struct pm4_mes_set_resources *packet;
 
-- 
2.34.1

