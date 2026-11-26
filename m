Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC1606A692
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sjz6QMio
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 556C3112964;
	Fri, 27 Nov 2026 09:58:49 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EDCF10E458
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 23:17:16 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2f0458cc9easo59510025ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 15:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795735036; x=1796339836; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bc6pDRpdQwqOkvZRQt3j3RUC7mrJsd/9trXkMnSGJNY=;
 b=Sjz6QMioA6X+gQc8GdOfECoV/sYenl9GyZwGqf/RLWPgcpEZxnSU1/ri+Vabg+h26S
 pGD4gITJFnwM2k8IFi3SK8SdJJTQgyxcEIc1QQIT4abPIk7TfonNHwuSXU1RtW+G3faO
 o3Eg93SCoCznFnwJy9eg9LI3Svh3Y8Obhhl6veIMiZ/+KpWWrDDYPvldcpTdW1RObGjl
 fCkl4g0lfSY6m2Oe+Nlp/aEa4hudejV3OL35/uj6mF7y9F3a4B9AND/w0t4C9sNWZb23
 jLfKF1Hor0S4UznPiB25qb5E6RLaFIvf+UT2efFMZDN4N8k9BOyovDjE0tWm/BBg+mqv
 6UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795735036; x=1796339836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bc6pDRpdQwqOkvZRQt3j3RUC7mrJsd/9trXkMnSGJNY=;
 b=GYNAsDrqH8LsfAaAHninvSY2fIQqCdVr5HPTfwIT2dCbv+t2dWxtiR8q1O7gFKtTlc
 j5mNBweirLaSmr+9mUco9i+HMv0JA9cAKOmpMsYnJAfJCMxXe5j2AG4upi786jGi78lw
 pokei5T/HTJ5Rh8TkpNMzn9xI1eFdipaLFEsNiQpNZZffHf/NAL+5RtvU2LVpuAVuYPn
 dNX+OFq/ZJVxPtaXuxTUd4MeFL49dENv5VjzVpcIYqx0Se3UAsqV6Bwzm5lYz5CoQ1nM
 vA+XWaXMl6IY7LS4Jsor5VGFecZw4scgXc5xUHrw/Ttnjm6bmFj12xYoSwdufAT15sYS
 I30g==
X-Forwarded-Encrypted: i=1;
 AL+hErE5tyetihyusQH/x8YLN7+TapuYb/L9yJ+CYXK/cG/mMIJHvyIEOBi+9r77qDEGRZ9zBWVakjvK@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+6O/NfrM2sGgz9seb1KMoX8uBNk/svof1c+jdMWAPhHOG14tSb
 CcHpfENHsBtO36coGqp2v46X9xT9cVn8XDXprFockwZr3IlJvp2BjWGU
X-Gm-Gg: AZFdTZcJlaLRcw9sFdIPNdsjIddQut88HZuKOtlvTOwYFVTApTMsXTfpO0qvzDB0nL3
 c6HD0jYjAKutjMeaMr5PIhzMyJED8Q0deZdL20rIgdT8zIoV/2YdIBaJLEKrr//Ozc+uA3+ihES
 7I+nQm5YK9mBNs7HdmWw8pw2C3Mn8F9y4XhgOV3eALgTnMTlDZ/oWk2HJwh5SBuoWvsOcs/gRwN
 qleGKjXu15xgWTxqZvrpPEyBpNbzhdaTA7MA+ke/51PS+2J3nAJT50swjZZzzuKrDfcNGmaUptC
 aW6Zj2Y1UIuwP6tTb9Y7fOcxquEVhJpMhnIcl6zdJKi5cYS48RiVptv2l3mUmp0Oz0eCdtRhOUC
 l2GVb9LViLwv0vzbfkhVpFZOH0In6D2qr+z5LrpS0drLu+7WEoefdzm6+WEsAmdp1VOeCZDFnIj
 hfEodaPTjT9J16R3/YphxO21WDabjbHPPa5Bdt8WzsvVURDhs1uKg7/nf5fKlgn194knU8+DyP5
 XKCkAKNOx/8ychJz3kaSkOhbNaqspc4pSBv72rc5j3iR5ZAF95seBH4dmuaiT6/x3VCx3HjlshZ
 romg/FPZeHIJLpP/L8AsTIK/iQl3WAM3CtCAseffeygL2fdarw==
X-Received: by 2002:a17:902:ea04:b0:2ef:e946:cdc with SMTP id
 d9443c01a7336-2f03f1f0ae8mr246999455ad.56.1795735035597; 
 Thu, 26 Nov 2026 15:17:15 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f0742996aesm81242895ad.11.2026.11.26.15.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 15:17:14 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Artem Novak <artem122novak@gmail.com>
Subject: [PATCH] drm/radeon: add missing newline to sync error
Date: Thu, 26 Nov 2026 17:17:11 -0600
Message-ID: <20261126231711.65592-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 09:58:44 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Terminate the disabled-ring synchronization error message with
a newline so that it is properly formatted in the kernel log.

No functional changes.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_sync.c b/drivers/gpu/drm/radeon/radeon_sync.c
index 6416f129e090..aa7d99a46a83 100644
--- a/drivers/gpu/drm/radeon/radeon_sync.c
+++ b/drivers/gpu/drm/radeon/radeon_sync.c
@@ -135,7 +135,7 @@ int radeon_sync_rings(struct radeon_device *rdev,
 
 		/* prevent GPU deadlocks */
 		if (!rdev->ring[i].ready) {
-			dev_err(rdev->dev, "Syncing to a disabled ring!");
+			dev_err(rdev->dev, "Syncing to a disabled ring!\n");
 			return -EINVAL;
 		}
 
-- 
2.56.1

