Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A5DC369B8
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Apr 2025 20:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C541B10E3EB;
	Sat, 12 Apr 2025 20:22:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CQW+MANd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED53410E3E9
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 20:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iEj+coXIu52ukeWieUUVuKc95+5zkfwU3J5mQAYkpX4=; b=CQW+MANddbe9Q++S0Or94yfTf/
 HyLFNmXsCUT37xTB+4nOYnf+hm+vnlk/Br8h9/uvZIo72bTx8v/cvZEzndYRcUzEY8e5FKi5mWyG/
 rHgV9Nn3ihKeTwPTVAzMhBUp9tcDKB1UYO3xgjpi/eOCXx8u8ha5wgYpDg/GGR/9Nvv1qxsmkWyKs
 1uj3VaKTxu2g+jrngsBpZVCWP2uL16sN7fCmWFV/YrGmNWGCqXqgBi9T+MOi7JZb0Osa3V+MFevvJ
 tNz97kao02059dC/Rdzmps6Zbj2/NC/IDMfTFDWSijzFeCeaRhnHNQiPiudbY3DVe3ACRYunTmg8l
 tgJ2yXfA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u3hMT-00Fepq-Sf; Sat, 12 Apr 2025 22:21:58 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v2 7/9] drm/amdgpu/gfx: Clean up gfx_v7_0_get_csb_buffer
Date: Sat, 12 Apr 2025 14:21:12 -0600
Message-ID: <20250412202134.3025051-8-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250412202134.3025051-1-siqueira@igalia.com>
References: <20250412202134.3025051-1-siqueira@igalia.com>
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

CHIP_KAVERI, CHIP_KABINI, and CHIP_MULLINS have the same buffer
manipulation as the default option in the switch case. Remove those
specific manipulations and rely on the default behavior for them.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 16b94ff5a959..4d8d68b737d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3902,15 +3902,6 @@ static void gfx_v7_0_get_csb_buffer(struct amdgpu_device *adev,
 		buffer[count++] = cpu_to_le32(0x16000012);
 		buffer[count++] = cpu_to_le32(0x00000000);
 		break;
-	case CHIP_KAVERI:
-		buffer[count++] = cpu_to_le32(0x00000000); /* XXX */
-		buffer[count++] = cpu_to_le32(0x00000000);
-		break;
-	case CHIP_KABINI:
-	case CHIP_MULLINS:
-		buffer[count++] = cpu_to_le32(0x00000000); /* XXX */
-		buffer[count++] = cpu_to_le32(0x00000000);
-		break;
 	case CHIP_HAWAII:
 		buffer[count++] = cpu_to_le32(0x3a00161a);
 		buffer[count++] = cpu_to_le32(0x0000002e);
-- 
2.49.0

