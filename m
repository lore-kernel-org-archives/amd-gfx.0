Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA107C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6076A10EC71;
	Thu,  9 Dec 2021 16:54:51 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B87589F8B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 15:47:50 +0000 (UTC)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J8z2G26mKzF4c9;
 Thu,  9 Dec 2021 07:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1639064870; bh=9KJQEOv/RC545ZfllzydEV6wW6T92E7IH/sZjij8tds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l+vAS5UNPbUvbhSQJ3WZ2guF6aw7Jwqdhcf2iiKhBqXlcqg/iRgojLrwlo3ssQbJS
 jP7JyvdQ24CY+Qwh4joyPb0GMZj6PCD6v32BRe7dKBvZp31v986c+k7QEXLTViKv7U
 tN2vN/T0KMKSpLfOzZRY69pezxFQ7dwvWcoh3nhk=
X-Riseup-User-ID: EACED30E0EB1F41DE5C5697771BC4CA1EEED45D07BD3575A8939FBAFFBA08B28
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews2.riseup.net (Postfix) with ESMTPSA id 4J8z2C6gMzz20Ts;
 Thu,  9 Dec 2021 07:47:47 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH v2 03/10] drm/amdgpu: fix amdgpu_ras_mca_query_error_status
 scope
Date: Thu,  9 Dec 2021 12:47:19 -0300
Message-Id: <20211209154722.4018279-2-isabbasso@riseup.net>
In-Reply-To: <20211209154722.4018279-1-isabbasso@riseup.net>
References: <20211209154722.4018279-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: ~lkcamp/patches@lists.sr.ht, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit fixes the compile-time warning below:

 warning: no previous prototype for ‘amdgpu_ras_mca_query_error_status’
 [-Wmissing-prototypes]

Changes since v1:
- As suggested by Alexander Deucher:
  1. Make function static instead of adding prototype.

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 00f94f6b5287..dc2a8d58d578 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -867,9 +867,9 @@ static int amdgpu_ras_enable_all_features(struct amdgpu_device *adev,
 /* feature ctl end */
 
 
-void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
-				       struct ras_common_if *ras_block,
-				       struct ras_err_data  *err_data)
+static void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
+					      struct ras_common_if *ras_block,
+					      struct ras_err_data  *err_data)
 {
 	switch (ras_block->sub_block_index) {
 	case AMDGPU_RAS_MCA_BLOCK__MP0:
-- 
2.34.1

