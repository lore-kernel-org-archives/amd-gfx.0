Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4CAC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B35710EC6A;
	Tue, 14 Jul 2026 08:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kwek/o7T";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2EA10E642
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 19:33:51 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493f45e206dso1189885e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783971230; x=1784576030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XPD6fU3GpiZG8+MeQeemIO9L/5IYTOlYLtljr//p+4s=;
 b=kwek/o7T7xBbFnQP0j7B9ma8t7ShW39C41bMxwvARaapmq0GXglOuLzia7dMN50olF
 zIEd/EeJLLRKwROFphEydNmOF1fHHV4dRGFsVjCdjYylvXL1wpS/aoTvtUUVfBMHt0Z+
 A8qQZVDfY/y25gwrPbGqSmENfLVF+6um5oMh+rrnn2RcxDU+X2Ko5cPBoWsqqGNkNiuc
 nGrboeTnq046SSj4011cff1lE0QKdU9XVX/ti6cFPcEkEClVzWT12BMgbPn7FtG3eIws
 gRsDSPBQpduOHKynSFspWY/Q2XbaJlsSe/ubsQr5emjMdo/yzgZGE7B+aHCNTOkeSd9v
 GNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783971230; x=1784576030;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XPD6fU3GpiZG8+MeQeemIO9L/5IYTOlYLtljr//p+4s=;
 b=pZgmFikt3310HEPh7kURCdTgNPDs3ACxp+MSDM70H+/Rm/zDoWv+qiZDm5xh6w2ngP
 0UHvo6aNHaFBVukKnXBlak2jTaDKIP7p9CmGbizTsraEJ2Ib9cklKOboUeFPsE/4v1Ao
 Zt0AUJIt2siYseOMEioBCyKNzqPmw8zdCgSO2ArIh/a8pORBI3FQmH24/lrClXhAP/ON
 /mERDpQza/plNFqi8bSXfDw77wREBKj+6PAcPUYEoDKUz61Q6aZHcWRiwjRzP5xkQ8n+
 fNdbqDXi9IrBM7QyqtCqB6Uq5XOD2YV7vlVKD9qZNfXAygz8L+qEx0kzXoEnHnHDLogr
 r+NQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHrqN81KAlmSWFmT3JOWUidDXkxdIXe0qevYkipsoRt1YZIV9qhjd5xo2z+kJZIJP6wvvCDrUw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrKZ4G9qe4LmXO0VYaMPjK/xqjx0vuRVICaGuIa6jLdj3bMG5b
 77tEHHptb9y5VgBsG6uCF1Vg0S2PMASpBAAHIAoDWOupKZ62mmjPoUiT
X-Gm-Gg: AfdE7ckwBMTImZ4Jj7JyjHQiobsPr7aE8NcT7DOvnhb2kKHvgza2Mv9mAQtHLte8JM+
 Y+FLprV6bnFyo5tkmLVQ2nZ4eP89UoUB8emGa5YD1XdiKQxLhgk08dpNg8oIpI9n0IPBAxw0LjZ
 c1Hsq8ifnk+zWzdixc1PvkA5zQcqiX3h/yywLXf409Vxi9O9W4zxsGjPLeqZDzTQEp4ktIE937g
 oSV8/PSZ1leZNUIwiMWqaU3eVBpdaE6Qvt49N3A7K4/0jQWUG3gdxDledoSyCPoV5xN9Oq1oFMi
 laZxw4GYiw46befS83cuezM7FGqHPvPpfQiT/0XiNX00OtwyCbZz6mGLsRdv1gHEmUpsLi1Xiha
 LzDlVIf/Vts1dwPz9yJwTvSqpu9iPT8792iWi6kjyPEcYxaxjvItbnSnHKdY8v3Vdv8HDwcFjNl
 Nu17aohWd9LEQbn3UoeVmVhe1cgQRZ
X-Received: by 2002:a05:6000:70a:b0:478:3df9:5d8c with SMTP id
 ffacd0b85a97d-47eee0f414cmr17935458f8f.2.1783971229706; 
 Mon, 13 Jul 2026 12:33:49 -0700 (PDT)
Received: from timo-z13.fritz.box ([193.30.163.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e0d9sm1912993f8f.2.2026.07.13.12.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 12:33:49 -0700 (PDT)
From: =?UTF-8?q?Timo=20Pr=C3=B6mer?= <timo.proemer04@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Timo=20Pr=C3=B6mer?= <timo.proemer04@gmail.com>
Subject: [PATCH v2 0/2] drm/amd/display: Fix missing HF-EEODB blocks in EDID
 copies
Date: Mon, 13 Jul 2026 21:32:35 +0200
Message-ID: <20260713193237.2639-1-timo.proemer04@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Jul 2026 08:29:45 +0000
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

Fix an issue in amd/display where devices with HF-EEODB blocks would 
be missing these additional blocks during EDID reads.

The driver previously used `edid->extensions + 1` to calculate the 
number of blocks to copy, but the base extension flag does not include 
HF-EEODB blocks.

Use drm_edid_block_count() directly to get the true number of blocks, 
ensuring that HF-EEODB blocks are properly copied.

Changes in v2:
- Fixed a bug in patch 2 where the bounds check still used the old
  extension count.
- Patch 1 remains unchanged.

Timo Prömer (2):
  drm/edid: Export drm_edid_block_count()
  drm/amd/display: Use drm_edid_block_count() instead of raw extensions

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 11 ++++++++---
 drivers/gpu/drm/drm_edid.c                            |  3 ++-
 include/drm/drm_edid.h                                |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.55.0

