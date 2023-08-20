Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CFBEE49AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 07:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B0710E208;
	Mon, 21 Aug 2023 07:46:07 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr
 [80.12.242.19])
 by gabe.freedesktop.org (Postfix) with ESMTP id 832EE10E132
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Aug 2023 09:59:12 +0000 (UTC)
Received: from pop-os.home ([86.243.2.178]) by smtp.orange.fr with ESMTPA
 id Xf5hqwKJwP8tnXf5wq04i8; Sun, 20 Aug 2023 11:51:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1692525101;
 bh=yRDJ9XSY8QRbt3yLCfIDe34UtsQbHZ65Dhi1TjJrFY8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qmlzG+dR3ODzfEAyq2nozyOmz/4fk68YdpOo4AtnY/6SRR5teLsTrYBxDg5FMysGf
 a0Wh/hh0H1N4ONZdaePGjGGtyX4S4guy3rN0r2kgTPYQnmcAhc9DAU8V8y3qKdMGiN
 fgMu+e+Ek6rMjUMs/M6suC0sLroIChN8RNZCF2nyWiqLTA2Qon726jqaIRCBRdNgQW
 0Yb9V5RCMqjSq+cKhYv4GPnw9+EAlX0/Ixf0DhnSc7tMXWGqE+23Ctpq6z9mapvCp3
 bcajwwUtPgpph45cFMyaGphBxCsn5YvG/ZUtPj+rPsUhp+qwhoNmTOsu3P0doqPQCd
 5HacW/XYLBkmQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Aug 2023 11:51:41 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Felix.Kuehling@amd.com,
 Arunpravin.PaneerSelvam@amd.com
Subject: [PATCH 2/4] drm/amdgpu: Remove a redundant sanity check
Date: Sun, 20 Aug 2023 11:51:14 +0200
Message-Id: <2f8cf2af583ea6893c6665aae5dcb6d69d0909bd.1692524665.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692524665.git.christophe.jaillet@wanadoo.fr>
References: <cover.1692524665.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Aug 2023 07:46:03 +0000
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
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The case where 'num_entries' is too big, is already handled by
struct_size(), because kvmalloc() would fail.

It will return -ENOMEM instead of -EINVAL, but it is only related to a
unlikely to happen sanity check.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 571fed04eb7a..c8f59a044286 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -78,10 +78,6 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 	unsigned i;
 	int r;
 
-	if (num_entries > (SIZE_MAX - sizeof(struct amdgpu_bo_list))
-				/ sizeof(struct amdgpu_bo_list_entry))
-		return -EINVAL;
-
 	list = kvmalloc(struct_size(list, entries, num_entries), GFP_KERNEL);
 	if (!list)
 		return -ENOMEM;
-- 
2.34.1

