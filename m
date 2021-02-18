Return-Path: <SRS0=9dkd=HU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7692C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 22:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCDF64EB4
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 22:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCDF64EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 693D46EA6C;
	Thu, 18 Feb 2021 22:49:07 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397FC6EA6A;
 Thu, 18 Feb 2021 22:49:06 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82CD164DFD;
 Thu, 18 Feb 2021 22:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613688545;
 bh=SGNPeiZEIHSwqt1VUZYZ9K9idlNdJU7dXBV+/C03bbc=;
 h=From:To:Cc:Subject:Date:From;
 b=qf72mZ0ibMde6JSaiwo3z9u0PSmey7GqBjkO/kHW63QNTDh5qTnC+v3pZM2cK8m53
 kci+DlNpoQSBrLdL9n+ve0IIHyu75/z4/3RDexTH0x6qtfCCACtJaV05iEd/Puw+LJ
 9JY6MSC2ke9p2aMSKoHNW6x3GJ7DWeakB3dZGBMk5eRbRqbqMIbYOMCuJdTLMZZHps
 +0kznePsP6inGcIO3y5s91gwIN9qnTyATqgCf/mMdWquxETo2RNlYOnY8gPgaJASSi
 boUX1t/+bTKj+pUBP3WNRdCxoGfudBGGt//XgihjphTVawJmKjRSEVhja34s0KlH8Y
 Jn+gBttahZe+A==
From: Nathan Chancellor <nathan@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amd/pm/swsmu: Avoid using structure_size uninitialized in
 smu_cmn_init_soft_gpu_metrics
Date: Thu, 18 Feb 2021 15:48:50 -0700
Message-Id: <20210218224849.5591-1-nathan@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
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
Cc: Kevin Wang <kevin1.wang@amd.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Nathan Chancellor <nathan@kernel.org>,
 clang-built-linux@googlegroups.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Clang warns:

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:764:2: warning:
variable 'structure_size' is used uninitialized whenever switch default
is taken [-Wsometimes-uninitialized]
        default:
        ^~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:770:23: note:
uninitialized use occurs here
        memset(header, 0xFF, structure_size);
                             ^~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:753:25: note:
initialize the variable 'structure_size' to silence this warning
        uint16_t structure_size;
                               ^
                                = 0
1 warning generated.

Return in the default case, as the size of the header will not be known.

Fixes: de4b7cd8cb87 ("drm/amd/pm/swsmu: unify the init soft gpu metrics function")
Link: https://github.com/ClangBuiltLinux/linux/issues/1304
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index bb620fdd4cd2..bcedd4d92e35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -762,7 +762,7 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
 	default:
-		break;
+		return;
 	}
 
 #undef METRICS_VERSION
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
