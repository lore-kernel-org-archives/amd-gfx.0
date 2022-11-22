Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92047C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 16:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8152A10E413;
	Tue, 22 Nov 2022 16:12:03 +0000 (UTC)
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CABA10E40C;
 Tue, 22 Nov 2022 15:36:59 +0000 (UTC)
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1669131416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f8yks6Nly8vAvHQB6r3QpAU5Ke7J6yBlMIAgEuvrAOM=;
 b=asKczoD4dJp2+N/Cet6LXyR2LzNIHadPUGMIXX2juB59YA0JHdumreH3Kubgw7sEnvsdW8
 UM5OcWzjMxxzqqXdFna0SjdvLqC3MtIdwy47eC3YGmhY9QxD4DIZsENrLZmFvYvj+Aapzj
 bUTrydDqt/QnwHnRZeGR7/0eXRcnpr8=
To: Evan Quan <evan.quan@amd.com>
Subject: [PATCH] drm/amd/pm: added result check
Date: Tue, 22 Nov 2022 18:36:56 +0300
Message-Id: <20221122153656.28495-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Nov 2022 16:11:59 +0000
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
Cc: trufanov@swemel.ru, lvc-project@linuxtesting.org, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, vfh@swemel.ru, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The return value of the 'div64_s64'
function called in ppevvmath.h:371
was not checked.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
index dac29fe6cfc6..82aa7130d143 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
@@ -357,6 +357,7 @@ static fInt fDivide (fInt X, fInt Y)
 {
 	fInt fZERO, fQuotient;
 	int64_t longlongX, longlongY;
+	int64_t result;
 
 	fZERO = ConvertToFraction(0);
 
@@ -367,10 +368,11 @@ static fInt fDivide (fInt X, fInt Y)
 	longlongY = (int64_t)Y.full;
 
 	longlongX = longlongX << 16; /*Q(16,16) -> Q(32,32) */
+	longlongY = longlongY << 16;
 
-	div64_s64(longlongX, longlongY); /*Q(32,32) divided by Q(16,16) = Q(16,16) Back to original format */
+	result = div64_s64(longlongX, longlongY);
 
-	fQuotient.full = (int)longlongX;
+	fQuotient = ConvertToFraction((int)result);
 	return fQuotient;
 }
 
-- 
2.25.1

