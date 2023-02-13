Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95E3C6379F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Feb 2023 20:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6444710E720;
	Mon, 13 Feb 2023 20:50:11 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7671410E71B;
 Mon, 13 Feb 2023 20:50:09 +0000 (UTC)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4PFxL86x8VzDr25;
 Mon, 13 Feb 2023 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1676321409; bh=HgPuyU+/BDFUTh/CtyNSpSpJXSPfMv23ttLd1xyx4NY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Znrik2NdnwL1a/OWPXTIDBC2/4c9T5uLPbr4cKZdpp4wSFq9CpPjlVbaE6GCQ1gdk
 z3QMpJXs6lExErQ7z/Q+1nL92JHATiA7h6Ih2TAZc4X9ykHfChsdqa0JAu1oQPXAzV
 yr56hnx8ExlNLnBIzam67Ll5730Br3T2sfMC8z8U=
X-Riseup-User-ID: 2DAD43A7F1764841A7B072E1B18AC42C55D8B14CE21517B0BE3ABEFB57E14441
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews2.riseup.net (Postfix) with ESMTPSA id 4PFxL35FVGz1y8Z;
 Mon, 13 Feb 2023 20:50:03 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 03/10] drm/amd/amdgpu: Add function prototypes to headers
Date: Mon, 13 Feb 2023 17:49:16 -0300
Message-Id: <20230213204923.111948-4-arthurgrillo@riseup.net>
In-Reply-To: <20230213204923.111948-1-arthurgrillo@riseup.net>
References: <20230213204923.111948-1-arthurgrillo@riseup.net>
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
Cc: sunpeng.li@amd.com, tales.aparecida@gmail.com, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, Arthur Grillo <arthurgrillo@riseup.net>,
 mairacanal@riseup.net, daniel@ffwll.ch, harry.wentland@amd.com,
 alexander.deucher@amd.com, andrealmeid@riseup.net, airlied@gmail.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add function prototypes to headers to reduce the number of
-Wmissing-prototypes warnings.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index bee93ab4298f..b03321e7d2d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -538,6 +538,7 @@ struct amdgpu_firmware {
 
 void amdgpu_ucode_print_mc_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_smc_hdr(const struct common_firmware_header *hdr);
+void amdgpu_ucode_print_imu_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_gfx_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr);
-- 
2.39.1

