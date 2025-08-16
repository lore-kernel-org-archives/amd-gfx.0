Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C973CA0EE9
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Aug 2025 16:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3398210E3AF;
	Sat, 16 Aug 2025 16:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MAacpWeH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ADF510E3A8
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q017RKjyMe2cIuPNOv7biM87qpDk8m8hoIvmXuSdyOc=; b=MAacpWeHZ97/DIz7jhYnUlX5QF
 wKdn6TTisW1FIiMMVTqknSjVDZAupWDpc3VDI/15aKl3yTY7EV6G4LNgMHddy0N/NUJMycWeLD+HY
 mVponZDL5yDrxYGDeIOO4ZsmM+oaMYJ3tAc7TatcuesO+cE3MXn/5BLgf3ScGcYRrf+vqxin1vh5y
 Ym9NExdg4abu3zr1Jeiu6vjU1gVyo58tuRDEiA7EbquTmCsjc/jlDatnCBAqOvIhdBVuAQpi9JYT3
 bWgVv0E0Lwy3c43uou/xMwOvDrzMZw+xO9TeF/SayncSOhYeVo/Ap2xvMAY41JjJh9xZj1QGPAsGC
 5CstQKkg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1unJlb-00FASr-VN; Sat, 16 Aug 2025 18:28:28 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 3/3] drm/amdgpu/vcn: Ensure that sysfs reset run in the fini
Date: Sat, 16 Aug 2025 10:27:28 -0600
Message-ID: <20250816162806.1301791-4-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250816162806.1301791-1-siqueira@igalia.com>
References: <20250816162806.1301791-1-siqueira@igalia.com>
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

The function amdgpu_vcn_sysfs_reset_mask_fini() in the
vcn_v5_0_1_sw_fini() is invoked at the end of the function, after
amdgpu_vcn_sw_fini(). This can be a problem if amdgpu_vcn_sw_fini()
returns early, since the VCN reset sysfs interface will not be removed.
This commit addresses the issue by moving
amdgpu_vcn_sysfs_reset_mask_fini() above amdgpu_vcn_sw_fini(), aligning
the fini code with vcn_v4_0_3_sw_fini().

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 7cb21e2b4eb0..3b7372861032 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -245,14 +245,14 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		r = amdgpu_vcn_sw_fini(adev, i);
 		if (r)
 			return r;
 	}
 
-	amdgpu_vcn_sysfs_reset_mask_fini(adev);
-
 	return 0;
 }
 
-- 
2.47.2

