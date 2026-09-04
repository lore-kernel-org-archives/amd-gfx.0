Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB568C624D3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 18:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA4A10E589;
	Fri,  4 Sep 2026 18:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kTzWSAbA";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7A010E589
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 18:34:29 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so11874515e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788546868; x=1789151668; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QFHNI/tUL4oE4+YziowGcBQkeuk3ySb7gOl7n0UtgYs=;
 b=kTzWSAbA19HzVfeOJzD3A+7+RXghX99ov4rp/Tzh9CtcE0A2BlPphu+WGw3iKIlo53
 WJOIO5CFaswts++Fgb5TxmyMml0bHYu8PjjZH2F0/5SR7CIMt4AUlkPLN/eCGFrx0wiI
 15f8QIywrYlxmSKauD9rfkLWUaE3XC2RscQjft3GxfrR1qT++97eNDkqAoJEKm2NEw2t
 3ZWo/r320q6zxDqOnklYBv7NJq8SfDUIMtEQ0iETObRapY217czFtafUR9SYs8P5Psm2
 cx60Nt3FW/FMNSHTQ0wW7O/qQtxHboHOJyXgKKk76iDkmCQC2k/U4bi4OrwNV7cS9rxn
 VBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788546868; x=1789151668;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QFHNI/tUL4oE4+YziowGcBQkeuk3ySb7gOl7n0UtgYs=;
 b=rWQoBvWp8Sz83oQnFh7uCgtoCNh2Y9/bn3zVkoZlwojsWDlBklc1antaJdEgnhYt0x
 +i6/jgPn7ERq7IFQSw7/DR50xy/mrE+pVxT5Fc/ion/0PNTEAM9h3gJhjl4HAxBoh9/D
 CkUI9GeYgHPXqlacDNolyxN6pnaZKdDE2cMtNm+6KW1IUFo2SXZMqLGRxmRHmbXPM3lW
 8qBhAZFvp4vVNuNFM7ul96h+6yL2qIQzvgZ0JSVDSVzMu/s4PC2+SCFyO7dLEnamHpr6
 oUrrpLSg1pjYFh8adoTAXS0XXtAYfH6GhAglUU9nP9ki5Uu+wBqJmBIOTfOqCdf97EKQ
 jU5w==
X-Gm-Message-State: AFuF++kfNvWBthI3rE41ByF9fORQ3JibR0P9ydNQ0sQBOsALs25rvF8C
 DuoRVUf9oPL0Ie4msPtSMNU08nDpLGKetPCSKUnmAyHaaGFCr0WhT5yc0E5Xc2HO
X-Gm-Gg: AYBFou1fOb2L5OWOKUiA4u/92CASnlo2sMbe1iW4qjAruFWHSwnr9vK2oRzj4V9dQz6
 i43DYCJqGEMtfn30HbVcb1Qz22ZgvaZXfOGIFciZy+kZtKSUeqHO9c7X70OZ4/Soex2MscggRNl
 fNTiLmVS8RSRqOEEBKy21CIfKRjS1WEo94hbd2pBp/iko4sUfGGmJ2WbHJE/JROdvhX3y8ePOrX
 ao9KiOL5sK+eP7cZs3syTHYI/Lj4XOFG/add6so6dZ/uRkbBw7UZCKELm5WIbxRJTqRlUAhxaaF
 0PvgAiMflzxDty29JiF0+jMwSAlC57UYPRrKbCfVuYJEBmOVMEmLbKOV0a+jqDow78E2qoaeoEQ
 3wpTBu+zwxwVHVvZAhGE61sn+eveKPO64Q+PR4ZdqN5Y7Ng7YD2JPt2bUtTidXjMvFvQmeki2Wy
 JJTQ5I6N6YGhk0M6Qq1J1k6zw+qZIQiVV5BOGJhbnlCqPMMnWKiX8yH1pmvKC7rwQns7WhPjMNk
 WpzMWmY0nEfk4wUxuY2REuxge9ddvE=
X-Received: by 2002:a05:600c:a00a:b0:49c:ed94:cdd8 with SMTP id
 5b1f17b1804b1-49cf81f6736mr141207875e9.6.1788546868130; 
 Fri, 04 Sep 2026 11:34:28 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm118373095e9.5.2026.09.04.11.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 11:34:27 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/5] drm/amdgpu: Delete unimplemented IH soft_reset() code
Date: Fri,  4 Sep 2026 20:34:06 +0200
Message-ID: <20260904183409.571117-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904183409.571117-1-timur.kristof@gmail.com>
References: <20260904183409.571117-1-timur.kristof@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The soft_reset() function for IH (interrupt handler) blocks
of Vega and newer have never been implemented, and there are
no plans to implement them.

Let's delete these functions, they don't do anything and
also aren't called from anywhere.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   | 7 -------
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c   | 7 -------
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c   | 7 -------
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 7 -------
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 8 --------
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 8 --------
 6 files changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index d6554add485c..8dee48649650 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -693,12 +693,6 @@ static int ih_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int ih_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-	return 0;
-}
-
 static void ih_v6_0_update_clockgating_state(struct amdgpu_device *adev,
 					       bool enable)
 {
@@ -815,7 +809,6 @@ static const struct amd_ip_funcs ih_v6_0_ip_funcs = {
 	.suspend = ih_v6_0_suspend,
 	.resume = ih_v6_0_resume,
 	.wait_for_idle = ih_v6_0_wait_for_idle,
-	.soft_reset = ih_v6_0_soft_reset,
 	.set_clockgating_state = ih_v6_0_set_clockgating_state,
 	.set_powergating_state = ih_v6_0_set_powergating_state,
 	.get_clockgating_state = ih_v6_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index 0fc348010ac7..ad370b326e88 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -643,12 +643,6 @@ static int ih_v6_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int ih_v6_1_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-	return 0;
-}
-
 static void ih_v6_1_update_clockgating_state(struct amdgpu_device *adev,
 					       bool enable)
 {
@@ -769,7 +763,6 @@ static const struct amd_ip_funcs ih_v6_1_ip_funcs = {
 	.suspend = ih_v6_1_suspend,
 	.resume = ih_v6_1_resume,
 	.wait_for_idle = ih_v6_1_wait_for_idle,
-	.soft_reset = ih_v6_1_soft_reset,
 	.set_clockgating_state = ih_v6_1_set_clockgating_state,
 	.set_powergating_state = ih_v6_1_set_powergating_state,
 	.get_clockgating_state = ih_v6_1_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 3745439b86b3..e5f8742553eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -700,12 +700,6 @@ static int ih_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int ih_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-	return 0;
-}
-
 static void ih_v7_0_update_clockgating_state(struct amdgpu_device *adev,
 					       bool enable)
 {
@@ -863,7 +857,6 @@ static const struct amd_ip_funcs ih_v7_0_ip_funcs = {
 	.suspend = ih_v7_0_suspend,
 	.resume = ih_v7_0_resume,
 	.wait_for_idle = ih_v7_0_wait_for_idle,
-	.soft_reset = ih_v7_0_soft_reset,
 	.set_clockgating_state = ih_v7_0_set_clockgating_state,
 	.set_powergating_state = ih_v7_0_set_powergating_state,
 	.get_clockgating_state = ih_v7_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 1dae7df9ee17..df2245fa35b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -635,12 +635,6 @@ static int navi10_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int navi10_ih_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-	return 0;
-}
-
 static void navi10_ih_update_clockgating_state(struct amdgpu_device *adev,
 					       bool enable)
 {
@@ -698,7 +692,6 @@ static const struct amd_ip_funcs navi10_ih_ip_funcs = {
 	.suspend = navi10_ih_suspend,
 	.resume = navi10_ih_resume,
 	.wait_for_idle = navi10_ih_wait_for_idle,
-	.soft_reset = navi10_ih_soft_reset,
 	.set_clockgating_state = navi10_ih_set_clockgating_state,
 	.set_powergating_state = navi10_ih_set_powergating_state,
 	.get_clockgating_state = navi10_ih_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 4509e6130bc2..c9dca49fc2b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -561,13 +561,6 @@ static int vega10_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int vega10_ih_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-
-	return 0;
-}
-
 static void vega10_ih_update_clockgating_state(struct amdgpu_device *adev,
 					       bool enable)
 {
@@ -625,7 +618,6 @@ const struct amd_ip_funcs vega10_ih_ip_funcs = {
 	.suspend = vega10_ih_suspend,
 	.resume = vega10_ih_resume,
 	.wait_for_idle = vega10_ih_wait_for_idle,
-	.soft_reset = vega10_ih_soft_reset,
 	.set_clockgating_state = vega10_ih_set_clockgating_state,
 	.set_powergating_state = vega10_ih_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 460f4bf195e8..0bda48558d4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -661,13 +661,6 @@ static int vega20_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int vega20_ih_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* todo */
-
-	return 0;
-}
-
 static void vega20_ih_update_clockgating_state(struct amdgpu_device *adev,
 					       bool enable)
 {
@@ -722,7 +715,6 @@ const struct amd_ip_funcs vega20_ih_ip_funcs = {
 	.suspend = vega20_ih_suspend,
 	.resume = vega20_ih_resume,
 	.wait_for_idle = vega20_ih_wait_for_idle,
-	.soft_reset = vega20_ih_soft_reset,
 	.set_clockgating_state = vega20_ih_set_clockgating_state,
 	.set_powergating_state = vega20_ih_set_powergating_state,
 };
-- 
2.55.0

