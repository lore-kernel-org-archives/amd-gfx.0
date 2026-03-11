Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CB5FED2E3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 07:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6C7010E988;
	Thu, 12 Mar 2026 07:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="nPpcykP3";
	dkim-atps=neutral
X-Greylist: delayed 1866 seconds by postgrey-1.36 at gabe;
 Wed, 11 Mar 2026 17:45:29 UTC
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk
 [78.40.148.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9784510E321
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 17:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
 References; bh=WpbKujUg/je3z1rxJtYDPy/DfekoUNAkqxPV46uYOx8=; b=nPpcykP3AI4ZPa
 lZH+n4DMR1kMe3pVMqwIAwADp87XJJXyS11hSh6AHSLD0vOVoEX89/n6MarL+NpgDLM5ssvBEECuU
 eeohTcej4Gi2Yoi3urJ7WUb7U6szlans9LrpUPOaJHwcK5bLbOwttsXywwl9mzjMevNPYd+ziq4ps
 hRw7AGHVrxLPjjj9bEyh/xQ+Wft30vddEA4/NVWwVsXuGUZv2dbViUO6S8KCbTdlLiiG9AWefWgRD
 UQn726fdDMa1SPXaPn16dfPcDXMl3C8pkZAnfAI67q2D+nNy9NGTiuPOUbGzCOphD9a2731hZG09M
 heJuK2E0qOp2kuTnNXzA==;
Received: from [63.135.74.212] (helo=rainbowdash)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1w0N8X-00G9Qs-0B; Wed, 11 Mar 2026 17:14:21 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
 (envelope-from <ben@rainbowdash>) id 1w0N8W-00000002LTF-0opz;
 Wed, 11 Mar 2026 17:14:20 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com
Cc: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] drm/radeon/cik: fix endian cik_cp_gfx_load_microcode()
Date: Wed, 11 Mar 2026 17:14:19 +0000
Message-Id: <20260311171419.559180-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Mar 2026 07:48:09 +0000
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

The cik_cp_gfx_load_microcode() has __be32 in one of
the paths where it is assigning to an __le32. This looks
to be a copy error from the other branch of the if in
that code.

Fix the following sparse warning by changing to __le32:

drivers/gpu/drm/radeon/cik.c:3926:25: warning: incorrect type in assignment (different base types)
drivers/gpu/drm/radeon/cik.c:3926:25:    expected restricted __le32 const [usertype] *[assigned] fw_data
drivers/gpu/drm/radeon/cik.c:3926:25:    got restricted __be32 const [usertype] *

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/gpu/drm/radeon/cik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 51a3e0fc2f56..1f9167d5ec6e 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -3923,7 +3923,7 @@ static int cik_cp_gfx_load_microcode(struct radeon_device *rdev)
 		WREG32(CP_CE_UCODE_ADDR, le32_to_cpu(ce_hdr->header.ucode_version));
 
 		/* ME */
-		fw_data = (const __be32 *)
+		fw_data = (const __le32 *)
 			(rdev->me_fw->data + le32_to_cpu(me_hdr->header.ucode_array_offset_bytes));
 		fw_size = le32_to_cpu(me_hdr->header.ucode_size_bytes) / 4;
 		WREG32(CP_ME_RAM_WADDR, 0);
-- 
2.37.2.352.g3c44437643

