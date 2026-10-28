Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3901A606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FVrCRFtP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4F7112095;
	Thu, 29 Oct 2026 08:05:23 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0253710FE4D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 20:26:54 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-5366ae57896so16518251cf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793219214; x=1793824014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f9jMMzsyGE8ik2YKnuDQiwrOshxrPYBlpSuYyxMmgE8=;
 b=FVrCRFtP5Cvg8zhONA7RaLKnajol1nvJUKzlqjMD+o9OZI4/ZbQp9otJyQIBqgnsdI
 tLVyA6qAMueawiKpcw03mdXw77Vsxl1Arg3Qmv47yN4lezyrE4l245tHShuEvABCR29e
 D/uH8XxQtF81Wb4uLIo5WqCzxUv5T7EQVMGlBL0edbtzXOafMS+eBmfGLweQOXvPN8cG
 uoAW3WoZOMWku2yuehx+JA+NUqWI0G7Wui06kk9NDMsUWgKT7PjNkBeRTs143FeWPJX9
 1oVf8G7rw2RE6iNlf7tgi7qD+vd0oMD5Ae1P3yhnttAWtjlFdp+nltCetS6QDqJfXbQW
 QDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793219214; x=1793824014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f9jMMzsyGE8ik2YKnuDQiwrOshxrPYBlpSuYyxMmgE8=;
 b=vSeWYsj3KmXdRsO7gKg9433TO6B7Xe2X+QcgGsgpERSTDrqfdmh5A5W/jcRBbkxVu6
 Nb3MAOo0GaeFpefPGfrUP+cSF5lDcOe4ktrnoY0JJpJzUFW908YCruzlL74tcIAyi0PK
 HUTCV/bLzGHaNBNB+4pVB60w0UYj7EZOSJFf+jncYZk9964c5xxMdmC2sEwKxo7pUdMI
 /mGhdNrXtBECjwCriK1GuQyfKM2GG95k82yL5MjZgb/qwktD9mwupZ2GKM1kX6G62DLD
 aTXUlb/5YVysgdIytM4E/vQwZsseMAzQIHlnmaAsqVhzkryRKuFrrLut8PFS34TZgooz
 OgzA==
X-Gm-Message-State: AFq9FYLQ3tHzasfk28wbZHUD8Jw0eMKZzrDR/IAjZmB92rowRgFvHuYH
 roLWMoCIfo9+2sHNJlM+GaYjz02LVQR3OTF+9zhdKYq+vus5Fp7KgCwhFWVujO0pQ/E=
X-Gm-Gg: AYBFou3yrezqHWkBk7V1GYTu4kh4qmL+iHxmAKHOeHIZA9E22jQieI/bMlvv5Mew5Zt
 CzG+lMWWpsfBv1Y10iCwpKXOxFj0W8hnr4lfmIb20FVzcCcN8F78zqxufbj5fiGeFhHQ17evrai
 HgcGSuHZ4kphc4+nJVoVW1eVELMbQIC4hHq17Z7ZKgB/LOxu0RWD+M4iN7dbB9lSQBNHXwOer9t
 PDWvb9Fsk1RHG1Kj+qO/ZoZdn/dB0LiIfJeKn49NxIu5SNWWF1ygiVMQPYHu4Wv7Taw5HufioDe
 RZj9AlYH+YCV25xVwTBAazeM0jLQtgvE3vn6bd/zP2aht6avwJj4Kg35VuSGni2r+OvVBplGLLL
 lvlxNzOMBR8iwnqP/n8vXPCmIX/eXKziL3wyTQnXttdSijA6BOuksMGNP8BV0ZAu48G/pNtxYuF
 A7vXteDnIUP3ebpHRvwlUJghDKnvfUnPi4NpMJUJO6sWBcVesdQZoEZHDkkizhPFgMpSi7UOI5b
 J9n0Xj4cCMKoQkV9D7o2NYqt2kVkkVr1JwDrT1e46sroilOBfSy2X6t9n76oV54GEyMeDgtOxyR
 teBVBGnaRVhBjQtcl9cso2vsaH+NtwRRnj0=
X-Received: by 2002:a05:622a:90b:b0:535:cc6:659 with SMTP id
 d75a77b69052e-53fcb7fb52emr58748511cf.37.1793219213813; 
 Wed, 28 Oct 2026 13:26:53 -0700 (PDT)
Received: from falcon.baltimore.nuwat.tech ([2601:14d:5284:47e0::1262])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c8d5ee885sm10190956d6.41.2026.10.28.13.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:26:53 -0700 (PDT)
From: Abdulla Bubshait <darkstego@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, dominik.kaszewski@amd.com,
 dri-devel@lists.freedesktop.org, Abdulla Bubshait <darkstego@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Abort DPMS ON when enabling the link fails
Date: Wed, 28 Oct 2026 16:26:41 -0400
Message-ID: <20261028202641.549955-1-darkstego@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 08:05:22 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 843049bac7c0 ("drm/amd/display: Split DPMS ON into
parts"), link_set_dpms_on_enable_link() returns
DC_DPMS_FAILED_HANDSHAKE when enable_link() fails and the stream
enable has to be aborted: any failure other than link training, or a
link training failure on DP MST. The link has already been disabled at
that point. The step loop in link_set_dpms_on() treats
DC_DPMS_FAILED_HANDSHAKE like DC_DPMS_SUCCESS and goes on to
link_set_dpms_on_post_enable_link().

Before the split, this path returned right after disable_link(),
because MST displays can't proceed without link training. Now, for
failed MST handshakes MST slots are still allocated.  When the link
trains again later, the new payload starts after the leaked slots so
ACT never completes, and the display stays black until
reboot. Replugging or power-cycling the monitor does not recover it.

Seen on Navi 33 (DCN 3.2.1) with a DP 2.1 MST monitor (Odyssey Neo G9)
at UHBR10 x4 with DSC. Link training sometimes fails on DPMS
wake. With this change, the failed attempt leaves no payload behind,
and the next modeset after the sink reconnects bring the monito back
up.

Return early on DC_DPMS_FAILED_HANDSHAKE, as for
DC_DPMS_SKIPPED_HANDSHAKE. This restores the pre-split behaviour. Link
training failures on non-MST signals still return DC_DPMS_SUCCESS and
continue as before.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6047
Fixes: 843049bac7c0 ("drm/amd/display: Split DPMS ON into parts")
Cc: stable@vger.kernel.org # 7.3
Signed-off-by: Abdulla Bubshait <darkstego@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 75e232ebffe8..b355e29b178d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2813,11 +2813,11 @@ enum dc_status link_set_dpms_on(
 
 		switch (step_result) {
 		case DC_DPMS_SUCCESS:
-		case DC_DPMS_FAILED_HANDSHAKE:
 			// Enum is ordered from "best" to "worst" results
 			result = max(result, step_result);
 			break;
 
+		case DC_DPMS_FAILED_HANDSHAKE:
 		case DC_DPMS_SKIPPED_HANDSHAKE:
 			return step_result;
 
-- 
2.56.0

