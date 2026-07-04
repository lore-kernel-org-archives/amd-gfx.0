Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82758C43458
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2026 10:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF1210E04A;
	Sat,  4 Jul 2026 10:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ri2NZIxz";
	dkim-atps=neutral
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ADE110E04A
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jul 2026 10:12:16 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-8ee6912d86dso8959306d6.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 04 Jul 2026 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783159935; x=1783764735; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rxyX6fPkI3zWrnoU4WDHMcsIhojSui+4pYl/gbAuI/o=;
 b=Ri2NZIxzbmMAMmmoVPrz3mwt4X2JinpkYeJw5qg0mpxpJCNjTbWzu6HRD4BzGURRsV
 G9v3LvfOqnKQupZOBT6UITVhFjOlN5xUiGV+Wk/CTLt91q3OU33tM4U2MV4eIpUZc7nW
 wXyfOxE/1SXBtsR8r0bjPSlF6DyeXrcw74lLKnq/xPT916Tvx+sF5MZYyvHzUETk+akI
 2jAEbnmT3mr9Nl1c9Q5TbQqo7Ox/UUT9++FSBTrD6YKyo8k/wCboNZthnpp99taNI6f/
 i6qnTFnFZFnPe2ZR7rVJ0GjYUPe/2T2mLIDvS86pigjCWBJm2lZNfx+ZYgipBANiAvvO
 PjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783159935; x=1783764735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rxyX6fPkI3zWrnoU4WDHMcsIhojSui+4pYl/gbAuI/o=;
 b=qhbHucZe4LAUSxoUNY3m8bK6+mqU5TepIKLuRkXgEwbVjldN+SnTB7iEjpTnP1TG2/
 qjcNVPNMs6EK6R4FquAKCIUEkTOI5vAlyXJiltCeo+m/19+QkylZ3Qa0XcfwD4T6ME+M
 XYh1QGLm+jfbCthGzPEVHcF2GZXPZ9KfvomW2UgQx8FGfzLYLkqbV/HB44Kt7cp2NgUR
 Yk71My0V/5kGQRkW56Jfazovz4URN4Id8GkII0BcHtKAs2XDdG3B38Hoj+3cA1q4vBOs
 kVpJsYQbBtO8Eg2YuOlvI54Noq9IgNKKGsvSDPTL6hT4EeKgnik8ZOaniENhFKeVfATG
 +QBw==
X-Gm-Message-State: AOJu0YwDvAPj1ijDhii4u6kAulnqgWQyO924+Q6QMU6Dhrba5IGHTh36
 6LzFKFp2YX93n41+lQkvtDTS19Pm454S5N9p7xTdPXctEJN9U4XlIe/VhRbIzMDl
X-Gm-Gg: AfdE7clV3/eSAd4VgwWd8mnHbzxiEsKy/e7VLNhHA7HNq97BGTMwnBQa5wRs8bkew9G
 dZ/lV4Sj/CYtb/55xlwcum4B0eUmKMRerHeEiAiLoMTEpHeTN6XAloC5Xyowj20RxO4fXx3EffQ
 UBoNh4MKAiILdrxbTtETZVQL7mcMJrRvSR4hccs6JvdTKNY3G/Ofy+7WSSl5vgGKZ1Y5Whg1wT8
 iWyUz2LhylFISu09X+sRUBE2RXoBdmtde3Uy9ZjUqMt7sNWp02yCyDiGjRocLlCqLL8pBRA86CT
 qtkf7/orGw9mzoevlVWOHvLPCQFf9ipHz8OVy0AzGYohaYqbkvULC2Ju1FEF7UouTd02nq3OGXq
 G0Ew3J1rR961/r3WQZweyM6gH59Hpd6NIpzPnHnOGnk4OKhK026aTge7cpy/goOqsOhyP/3WV1+
 Q8Up5KPbyA1ryDbGrwQI0=
X-Received: by 2002:ad4:5aec:0:b0:8ef:5103:df9e with SMTP id
 6a1803df08f44-8f74a32ab33mr40294156d6.8.1783159935270; 
 Sat, 04 Jul 2026 03:12:15 -0700 (PDT)
Received: from johnnyzero.szero ([32.220.73.95])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f4724b9ff8sm75981446d6.40.2026.07.04.03.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 03:12:14 -0700 (PDT)
From: John Olender <john.olender@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: kenneth.feng@amd.com, alexander.deucher@amd.com, asad.kamal@amd.com,
 lijo.lazar@amd.com, hawking.zhang@amd.com, kevinyang.wang@amd.com,
 John Olender <john.olender@gmail.com>
Subject: [PATCH] drm/amd/pm: Remove vbios bounds check from pp_entries_max()
Date: Sat,  4 Jul 2026 06:11:20 -0400
Message-ID: <20260704101120.674980-1-john.olender@gmail.com>
X-Mailer: git-send-email 2.47.3
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

The soft_pp_table is not contained within the vbios when using a
pp_table override since commit 3cfe433630508 ("drm/amd/pm: Use uploaded
size for legacy custom PPTable").

Fixes: e30b3e3ab51ad ("drm/amdgpu/pm: add pp_entries_max() helper")
Signed-off-by: John Olender <john.olender@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 7ebc1344023ff..19023a850e882 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -833,14 +833,10 @@ static inline uint32_t pp_entries_max(const struct pp_hwmgr *hwmgr,
 				      const void *sub_table,
 				      size_t hdr_size, size_t rec_size)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr->adev;
-	const char *bios_end = (const char *)adev->bios + adev->bios_size;
 	const char *pp_end   = (const char *)hwmgr->soft_pp_table
 			       + hwmgr->soft_pp_table_size;
 	const char *entries  = (const char *)sub_table + hdr_size;
 
-	if (pp_end > bios_end)
-		return 0;
 	if (!rec_size || entries >= pp_end)
 		return 0;
 	return (uint32_t)((pp_end - entries) / rec_size);

base-commit: e3cc8c108f9a91728f9ff6e24cbf3b41c58b8f8b
-- 
2.47.3

