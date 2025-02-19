Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA528C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 18:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 748CF10E36A;
	Wed, 19 Feb 2025 18:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cHBolhbF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15EE010E4AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 18:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2pSe7Qe4/i9BOa9RVZfFghHp+mZzc1kq2e9gbulZZME=; b=cHBolhbFoTP+UyloEjGW41mC4P
 McBtXgBNa6gF8b6RnBXynfN4SdraHT7cBct9WXHWO63VNztgnREpXS04GyyAv/QtCCVThei0sCYpt
 YXCrU5jiRo3jZ9wGxtRtDxMHD8lAU26J5gSe3UoZ62Fyt4AeyNyT2qiQxki5xCk73wv8LwIwnXMer
 Ph2B/xTV7L8a1bieTkcIZs1i0PGMmMIABaVHoF+Qrk5zT9SQpx1++WurJhxWrkOKs/+I8g1kbBVOz
 KpRsv9p4boaVHcfy91iYC7ksGjQWQW+L8uWyeoJgxpSUHiO+j+1bd9QV1AOif3bzYVrwZMklBxM1a
 Enj4yNaA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tkp6O-00EwF0-6g; Wed, 19 Feb 2025 19:47:26 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 1/2] MAINTAINERS: Change my role from Maintainer to Reviewer
Date: Wed, 19 Feb 2025 11:46:19 -0700
Message-ID: <20250219184702.242924-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219184702.242924-1-siqueira@igalia.com>
References: <20250219184702.242924-1-siqueira@igalia.com>
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

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8b35ca294a0..a94abf72e117 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1024,7 +1024,7 @@ F:	drivers/crypto/ccp/hsti.*
 AMD DISPLAY CORE
 M:	Harry Wentland <harry.wentland@amd.com>
 M:	Leo Li <sunpeng.li@amd.com>
-M:	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
+R:	Rodrigo Siqueira <siqueira@igalia.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/agd5f/linux.git
-- 
2.48.1

