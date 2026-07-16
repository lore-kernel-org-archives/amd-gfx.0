Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0586C4450A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E028610F2F4;
	Thu, 16 Jul 2026 13:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="hK4P4UEJ";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0613410E757
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 12:36:55 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f365afc5aso2731556f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784205414; x=1784810214;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hMlzPGyvzJbIEx1Yj1A1YkSSxKMRLpTm/IL6VYqgYHI=;
 b=hK4P4UEJvrOMDI8JVR4LXfVm/TEThI6BJGn6FCP2amDcsM1cYRVliCzDuzI4QWEsqq
 /pODVH0ZPoG/Lp1NKva9ky7a/+zExnGmsLfQEIi4o2ogzzN6uvaPPD8/PZVvKUiC+53N
 /IncKA8N3f26fTWcRCWAge1F/Biyv1D34KtXWb4ngCisFmRVNLTQaz15NM71EeUTqxWd
 EiCrQ6dN5ltEclgKhACinquuFZyB7ODamilR9+SahjiZn6HKStytc4C3rST87YG+27UD
 CJ6ny2nDVyGS92VecVmCdvE5CTM4aB/JKLl/FM40YgdJ6YyVCdBSJGXXFyuEMFZkw9Or
 EwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205414; x=1784810214;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hMlzPGyvzJbIEx1Yj1A1YkSSxKMRLpTm/IL6VYqgYHI=;
 b=fUvpNdeysljkpAV4A6qyc00Jk3sNj+ww/NI4UYh6eBv/rcAc+Hzn17+DcPbMrfOPuJ
 P3na9R8x+Bppzun4Ij4f5lR0ak+CjxjXwj5+JGCvgJqSnf2qbDymnimu578Dc8GFnwGR
 DY8Um2/MIH+Aq+3OfX8r3efyHc7IyEBg0o920OxQBqA9bKYqs+tRV7ZAu/t5kleNtggU
 5Fv/lMWN86wfOWaGvVzmiKQqeW4dXn2tgdMt1q4QjwjbeNMSV+B5T86Vjjo/sQPt7G85
 EeFCmr5RU8q8dpMyhBJhvjC71LRYocSNnyOZyVuOCo2B0ewMWGCzJGa4e5td4AqQ0D/a
 FNnw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/3ifMPIH7BMVoa6TylRLl/tOTOlr5L+8YKd6rjX4nmiuL/l1zbrDd4BKQmbTX38Ez1gwCaAHe@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5TpzJSmtLAfWb6LTzELrtblI2vQH4/nb8Hyd7K5GT4oPAl1JM
 lDw6Gxl366P1L1t8M1cr0vRLxfkdim3OnnGbgZLWjDpZOh2cuAqg+0q2EPFu/jE95dI=
X-Gm-Gg: AfdE7cmytqaMsvkf7ZaFL5Y2D0xEojL/Orwg+xuaxgBirpzZ1Ckczz6Aw35fYRiezST
 7GlZFibXMLGP1mfSJKkkWCT4UlRtp05q1JgusDtx6G08RUFsqYg2Y0Ky6VxwURxJZLW+EFZFmFr
 k8WJ0n8C4l9EATmw2HfZsaPsuGgQcpv6I+F9vGpEKOKXNje74CI0/QKqhyLSzMWXS+pg6czD4zx
 aY3OMNAARxDP48sRUY6iOb2UBq2t0yEflodeYxnsiAqE4gisg7CPBMkX0A7Uiy2eUgHn6iGOnRv
 UyFbt3nC23vH+zJn/0M4ZIqaeJNNyt8oQN0GBMRRHzZJqfhkJJZfdgQAFhox2FgI5h7Cm4Oas+v
 3AQCB0eieePYdKWDRfRPrDEI45l78RaCTpqrDXiChSVBbPDNP1jRvMtKLdfGTH9UDVLFocn+Fc5
 g1Ty/Lc5tVYLufyK2fHSEjmVmojA8PP85N8eqX53EDbaI/TaX5b2fx4c8occVG4tKwQw==
X-Received: by 2002:a05:6000:22c2:b0:47d:ef62:cae0 with SMTP id
 ffacd0b85a97d-47f488c9ae9mr13456684f8f.51.1784205413893; 
 Thu, 16 Jul 2026 05:36:53 -0700 (PDT)
Received: from localhost
 (p200300f65f47db046a548a0537ec1e67.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:6a54:8a05:37ec:1e67])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f464a96cfsm24325718f8f.20.2026.07.16.05.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:36:53 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: Only define radeon_acpi_vfct_match when actually
 used
Date: Thu, 16 Jul 2026 14:36:45 +0200
Message-ID: <20260716123646.1933293-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497;
 i=u.kleine-koenig@baylibre.com; h=from:subject;
 bh=IKtUF1mcJc4KuUB/Ooi+YU1Vjqw6c7TxzaSph7yF/Ko=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqWNBeLNdSWBkyzCZFGSImvaru90MIq0pcqeEAF
 zy6u8Kq3KqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaljQXgAKCRCPgPtYfRL+
 TtdcB/9JiPDX5arNdnLDQp+bvrkfr0KgD8uJv0WoMoW5hXpj/6+SKiqktl/Wqerc8mH5qE7g/DV
 vNheGPKjYwbZzVxuHJw0L0nlANRtqg4gdLYjOBTQUkp5t6QFGAK9uyj3811uos+R+gG7cgxePus
 yRQeu6vpWUMeJTGVtJrE43mNdvKP5u6YhEdjjLsG54QWw2SnxJoH0ep/O42MUqCAZYdxHJNg04i
 frI6xg1grnSSwlsmpiFMYUE1shT5hi5jt0kwt5Jq2CRT/+bXuFSGj9mJGrliFcrHO4LTqKG1ux/
 RelL9i3jlYE3O1N5FwaHV9WOj+6N3RLXVzmVBTi4u9zDVytn
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 13:04:52 +0000
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

This fixes the build failure

drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: ‘radeon_acpi_vfct_match’ defined but not used [-Werror=unused-function]
  614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
      |            ^~~~~~~~~~~~~~~~~~~~~~

for builds with CONFIG_ACPI unset.

Fixes: 33a18ecd2fbf ("drm/radeon: Fix VFCT bus number matching with soft filter")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

33a18ecd2fbf is currently in next via

	https://gitlab.freedesktop.org/agd5f/linux.git drm-next

.

Best regards
Uwe

 drivers/gpu/drm/radeon/radeon_bios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index cc10880af096..cd7a5d458157 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -596,6 +596,7 @@ static bool radeon_read_disabled_bios(struct radeon_device *rdev)
 		return legacy_read_disabled_bios(rdev);
 }
 
+#ifdef CONFIG_ACPI
 /**
  * radeon_acpi_vfct_match() - Check if a VFCT entry matches the device
  * @rdev: Radeon device
@@ -635,7 +636,6 @@ static int radeon_acpi_vfct_match(struct radeon_device *rdev,
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
 static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 {
 	struct acpi_table_header *hdr;

base-commit: 33a18ecd2fbf6bcbf803836e94eb31c26f4c7f41
-- 
2.55.0.11.g153666a7d9bb

