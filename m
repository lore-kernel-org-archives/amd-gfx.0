Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF76C433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Oct 2022 23:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AA310E5DE;
	Sun,  9 Oct 2022 23:56:28 +0000 (UTC)
X-Greylist: delayed 391 seconds by postgrey-1.36 at gabe;
 Sun, 09 Oct 2022 23:56:20 UTC
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC6710E5DB;
 Sun,  9 Oct 2022 23:56:20 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 317C8CE1044;
 Sun,  9 Oct 2022 23:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15C2C433D7;
 Sun,  9 Oct 2022 23:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1665359777;
 bh=IqXIc2zb1gPqjZAiZAuDXqBufstMjobSxTTlD79UXjo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vHoL5kBNDazaWPJCLoFqyom6jsACj53P4JdQ4cVIxCPge90Kjls3P0wFT9ecjLq2T
 2iirsr8mDjO9Lks7mTtlDfjbgko/EhI3ld8ANulKMIqJgJWMqPS3q88mrUyu5mqcaj
 ibJqGCUrPb/HkumWx67oYktTeWNeEHCeaxu2V1b2umj66oyWPyEesrghJydT8UIIb9
 fsacNaY8CG83BoMqrgiQQVOJ9O2DMrfRS4Qqir9AN03E3mi4Z5Isb9nTYEBKPOHNMM
 2YnIqgu0SHXCGo1IkzJubHbCRSQ3NiX2wMa/DPtiQTcubpLdbXCXkCuAQ1x6ONTx3E
 jtKawdxl1oEFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 05/22] drm/amd/display: fix overflow on MIN_I64
 definition
Date: Sun,  9 Oct 2022 19:55:23 -0400
Message-Id: <20221009235540.1231640-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221009235540.1231640-1-sashal@kernel.org>
References: <20221009235540.1231640-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, daniel@ffwll.ch, sunpeng.li@amd.com,
 Tales Aparecida <tales.aparecida@gmail.com>, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org, isabbasso@riseup.net,
 dri-devel@lists.freedesktop.org, David Gow <davidgow@google.com>,
 Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com,
 harry.wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Gow <davidgow@google.com>

[ Upstream commit 6ae0632d17759852c07e2d1e0a31c728eb6ba246 ]

The definition of MIN_I64 in bw_fixed.c can cause gcc to whinge about
integer overflow, because it is treated as a positive value, which is
then negated. The temporary positive value is not necessarily
representable.

This causes the following warning:
../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/calcs/bw_fixed.c:30:19:
warning: integer overflow in expression ‘-9223372036854775808’ of type
‘long long int’ results in ‘-9223372036854775808’ [-Woverflow]
  30 |         (int64_t)(-(1LL << 63))
     |                   ^

Writing out (-MAX_I64 - 1) works instead.

Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c b/drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c
index 6ca288fb5fb9..2d46bc527b21 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c
@@ -26,12 +26,12 @@
 #include "bw_fixed.h"
 
 
-#define MIN_I64 \
-	(int64_t)(-(1LL << 63))
-
 #define MAX_I64 \
 	(int64_t)((1ULL << 63) - 1)
 
+#define MIN_I64 \
+	(-MAX_I64 - 1)
+
 #define FRACTIONAL_PART_MASK \
 	((1ULL << BW_FIXED_BITS_PER_FRACTIONAL_PART) - 1)
 
-- 
2.35.1

