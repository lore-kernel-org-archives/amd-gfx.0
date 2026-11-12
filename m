Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C2606A334
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Fm0N6plG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D65C911214C;
	Thu, 12 Nov 2026 13:56:26 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD36810EB24
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 07:48:36 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so41542125e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 23:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794469715; x=1795074515;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UwhXMZbe22iQmsBp72ciLus1kA6qYbwYDKSne6ab3+o=;
 b=Fm0N6plGko1YxaY7g3KCqXh+uoJG34rY5hvDzd6DA26uUZM0U4Oz+ZJwOpODehQcus
 ee1RHX8GmC1bv9/px8VquMSKfGXebYPjeCGnajXoFVAD/0m3KO0cLNGyZ70TT2rum5rt
 FpqdLvuc/r6WMVLAxPDcKkvXjpbojYrBAnqt1oNgIsZAhzFCJ1Hwy8l5V8gM01YgtTKT
 dfycy89Q9xxScBDMee/mM9DAou5z66/N1pXtJeLNkjTKvZeM2ZN3EpRua1T0/4zJ7/VP
 eikyAg3MqMZQu5YrZ4fOAmObrMyR6Z6rmXp416Z4EyYV/QrwgVtvmsck31zSsVg2OXWS
 TFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794469715; x=1795074515;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UwhXMZbe22iQmsBp72ciLus1kA6qYbwYDKSne6ab3+o=;
 b=NWp1oixPYGAZ23h5k46t0haB9HsbwYAaiThvYGRl+K6l6W8RBOrIk7f+PWBQr1RV/U
 NY4ELuuApWn7DQbKJrc5Snv4MNfh78ayQMRaJOVBRlx2PNhCft45jIeuN579vrt/X+Ma
 2eKZJX/HoiGfEVBBU6Ji3273pUDetNqVFN22b+HUHeoq0J2BFanTZfsoOnEGAI5LV2QP
 dDgMIMSLIOKSrLBHFM14xABFwsbRARsE2FupfpSd5p/W+XKcpOTzxXumQYzUXZj7YoGI
 3T1aWhzUpY9nhtAYZDhCyQv2JacDOtZLYHjEMasYMbXwddIamBcgiNRbFa4Pl/+pjd9j
 QmGg==
X-Gm-Message-State: APuU4Z/HlaHIXD6nSlCwgSIfximSgLVYCLTisgOX1CpnApLataPAfDbR
 S7KtodvQJkkhJvqIfv2YoGcz6b2Vsl1TsXj4YufNxztMOpwtGi7a0s3LLVevrsJO0IA=
X-Gm-Gg: AYBFou0SjlKkemqH6TT+xjHbP5E6cJH8Deo2fmQYnC+wIKJuAq+v1yjD/gnQ+SQAGjS
 XK1GTTg91Ajp5AbQRUcuaF0g/klVhk2IhtAmjDnv5esKdFUwX55n9tW3aXoSHxG2Am6tcnknkwR
 o4qqjnSRkYVxtGVfxhBBjpxU51gpG1EcvWh05fU6no/F9mM7pX9jJbhl8hiGBs8lQWvFZhwobW7
 j0IJDnnldBGNxkbhp8gzM3ZC/cJRWzNUsNqJXAnF/UjUXLeimdBU+ebs4CYt6ClxA34doX4/dSG
 +DJSvEvp310KnadFZz3R6YmBaGdAKzAC3/SzDUktvtGoS0FmaVEHOapfpLJroLEYA9lMdvfsius
 3u7e+jlhn7aD16Rw4fHjlXAtgyzaAO5jgCTk2spdlHttZs2J2zdfk7+jdvYE0srJSjBqIFCeQsY
 0QWZOpLlKtkl5UskN5nCdcve/Z9zflQzxJ1YRG3katDg1FnWRmgh6PwEILTctrPHW2seO4XbRwq
 ZwoCwIPqD9LTJb01Syl/lSK0PFdWGSiMiPBQp1Cvcxmz1Xwrp42fi1o6FiKAcgTwypmftBdHqW8
 OUpe4UGOpbfWKXb0fyoi8av5p7GP8cHo8ZQ=
X-Received: by 2002:a05:600d:82e3:b0:4a2:1867:10e8 with SMTP id
 5b1f17b1804b1-4ba093953c6mr93839235e9.25.1794469714985; 
 Wed, 11 Nov 2026 23:48:34 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb4e251c26sm47937395e9.1.2026.11.11.23.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 23:48:34 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/3] drm/radeon: Cleanups around <drm/drm_pciids.h>
Date: Thu, 12 Nov 2026 08:48:16 +0100
Message-ID: <cover.1794469153.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1328;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=AkVfD2ObCC4bhOHDAfA5BKGm5mgIKuoHTZJqQo/8ZVY=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq9W9BScA0+nYRt3yC2T7cr25ILj5751cPstvsE
 VG4JNhUqxiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCavVvQQAKCRCPgPtYfRL+
 TlJZB/9kjr6nRh1MxK+MrZrzSYTOgRy62OirClM2afA5eie9OEK+ITW4tzTlRX8Q2GTFoqvesZz
 GzYU4PEN0H080z+veBBYHXRn+NhV6JQL2Zp9z8VKlB2au2FYJPGnEVdSdNtvA8EfbSU2yc3MhSH
 P4lZOXONv1iseKuAyKB5vY5ueIOq+0hi76XXOoyQcfLxk4F6P+P+7Bbzy2/LeRBzg4kBSs8cCjR
 L+0HmMku0nmvg9lCCs97N36nePub/ZpkqibDo8HyeHDTsZLkRswfzRrZT9wCFVFSwxF46uuw8YK
 qzYqRmMt4mCgJNGLlVGgZPaC2P+5jAd77z8PIbgoyUeDjAdm
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 13:56:07 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

patches 1 and 2 were already sent before
(https://lore.kernel.org/3205129f75aba48bd1ad8fc810cf6a18e718206d.1777545446.git.u.kleine-koenig@baylibre.com
and
https://lore.kernel.org/20260430102958.136859-2-u.kleine-koenig@baylibre.com
respectively). Alex asked to resend as they fell through the cracks. My
motivation here is to have the pci_device_id items defined using named
initializers to be able to modify struct pci_device_id. See
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for the general idea.

Note that patch 3 depends on patches 1 and 2, so if amdgpu and radeon go
in via different trees or branches, patch 3 has to wait.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (3):
  drm/amdgpu: Drop unused include of <drm/drm_pciids.h>
  drm/radeon: Consistently define pci_device_ids using named
    initializers
  drm/radeon: Fold <drm/drm_pciids.h> into its only consumer

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 -
 drivers/gpu/drm/radeon/radeon_drv.c     | 702 +++++++++++++++++++++++-
 include/drm/drm_pciids.h                | 702 ------------------------
 3 files changed, 700 insertions(+), 705 deletions(-)
 delete mode 100644 include/drm/drm_pciids.h


base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
-- 
2.56.0.rc1

