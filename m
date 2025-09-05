Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AD0CA1013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 10:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C710310EB66;
	Fri,  5 Sep 2025 10:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bsmt9GfS";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD4110EB66
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 10:12:53 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8080a88a32aso203080985a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Sep 2025 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757067173; x=1757671973; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NewwMVaLbnIa4fJGnIXjeDAy1/vDsin+IJMIPV9C0rc=;
 b=Bsmt9GfSLVL7pPbf1tXlcTVJKgueEGeMf+KWH++9OrQeplzHweT6GrnRymAQoEyfDd
 JshqzFlrGmJm3DY/09F8/O4USK9AgrT+8p9nd/3mWh7TC+DLj98Pv0pBXROkWn/glkeG
 7UroWD8LGhUJkjIcd6IMuq92JXp6Vq9pdu8p8LbP48+4Ho+crWIdUwbGBEf7Mvn7Fuc6
 m29I7erS0eJ5lRN4G4QMMWSwzAcBQJZyeUF2mm0NvPPuWgZx/1/7qOj0Tm901PRZi2eW
 pL3u5LNbUqUWhGUwF9K0bvzKh0YJC4B8FDoVwo6EyXU7erhPxOKkYlw7qIMgfJaT6PVr
 OmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757067173; x=1757671973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NewwMVaLbnIa4fJGnIXjeDAy1/vDsin+IJMIPV9C0rc=;
 b=kdPOoMkcM33of3ytH6hJ+fOqfNmcQFZS4c0QQS0AZ2VIV3JpHnUiv87Bz3eJ4wwuIt
 aNo7kD3QQeDWKVkLrbcPcyUOUytGPJMrueyKhhtVTzRIgmLh4z1xp1Wbmk8NCe+/AGjv
 81jhVXv7WoYdnGy0QW1bngGHfgi7G26eOtdQxceGHYlP3jukeaNHRl8nSZUJkpdsg608
 rMnTsVWF28wKr4NyJVuLRAqWe9tnUyTA/EdMgrUDqSHvKW+uuNJ0j4jJeRWX8MyWBlcy
 49mTsKCmgA/+D2wQkcn/CRTeB+ZnCKHNQoLBYdgWvcXUk3MjFN1BZM24Ul9PqEevwQ1W
 k6rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUofjbDzS9gfQtfO2QD1OMpK0iYxYeF5trpEgzjCF7cpU5TSzQWNh/H20IBvLJGo4M8cvMgTZ+V@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy76KLIOrZfZW/l2myBe3CiS6i+BriR6Jys9q+V2msSXpsIeKZf
 WTGTrlNG4TzRag+A0crxDOv3BKau2aZhtXrXHPIUcleysDd55E6EQhw6
X-Gm-Gg: ASbGncs5wDcnpvsedsMk4Pk30Ckm5e4tfiIWS8lpSRbSr3K99jrhAFDjQvymjM5BQEJ
 dbbiwmmX4Irnv+YiuzvtInUEkKcHTqxl5ira/Ni+xnOI1HrPmetp9jvgo/r1Af6PYTJvEUQFf3t
 /8qb6W9XoVjLU4YN8OvKZ4Ar42NQY61IEi4lk4eL5gmK7VBjcWREuckHcEKsCTziRQ4nXTCWj+l
 ZmtqVPlj4H/eMFsTUC6GlFNSA/SGr6p9psGQ5cC2d/GjOMnIkE4PnGX5RGU8lfMsr8KGidpiBwl
 8FgukmELU0X07qezbf7BzmpxH4uwfbsD0f8JBpyIPllWFOV5lRt6244WB+bvG7SRBwf+qSlzJjs
 PfzM9sdkw5dZ854mT/B8+ClMYTjtSvWZe
X-Google-Smtp-Source: AGHT+IEQiYWUBVqc0B1QdpxfEzvGinfpogrxCM22uhPtpp6Ac4rI/HLXEw8yO4M/hLvhc77eTWBTOQ==
X-Received: by 2002:a05:620a:45a8:b0:812:be4:670e with SMTP id
 af79cd13be357-8120be48073mr62609385a.43.1757067172478; 
 Fri, 05 Sep 2025 03:12:52 -0700 (PDT)
Received: from johnnyzero.szero ([32.220.111.111])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f660361sm44317711cf.17.2025.09.05.03.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 03:12:52 -0700 (PDT)
From: John Olender <john.olender@gmail.com>
To: KevinYang.Wang@amd.com, Lijo.Lazar@amd.com, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Ce.Sun@amd.com,
 John Olender <john.olender@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix NULL ptr deref in
 amdgpu_device_cache_switch_state()
Date: Fri,  5 Sep 2025 06:11:28 -0400
Message-ID: <20250905101128.3058191-1-john.olender@gmail.com>
X-Mailer: git-send-email 2.47.2
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

Kaveri has no upstream bridge, therefore parent is NULL.

$ lspci -PP
...
00:01.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Kaveri [Radeon R7 Graphics] (rev d4)

For comparison, Raphael:

$ lspci -PP
...
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Internal GPP Bridge to Bus [C:A]
...
00:08.1/0e:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Raphael (rev c5)

Fixes: e5e203e0cd53 ("drm/amdgpu: Save and restore switch state")
Link: https://lore.kernel.org/amd-gfx/38fe6513-f8a9-4669-8e86-89c54c465611@gmail.com/
Signed-off-by: John Olender <john.olender@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7783272a7930..ca58cde66446 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7148,7 +7148,7 @@ static void amdgpu_device_cache_switch_state(struct amdgpu_device *adev)
 	struct pci_dev *parent = pci_upstream_bridge(adev->pdev);
 	int r;
 
-	if (parent->vendor != PCI_VENDOR_ID_ATI)
+	if (!parent || parent->vendor != PCI_VENDOR_ID_ATI)
 		return;
 
 	/* If already saved, return */

base-commit: 035edba1e204b302ae74269d4f09e355153a79ac
-- 
2.47.2

