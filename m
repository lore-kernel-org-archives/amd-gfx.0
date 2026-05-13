Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDA3CD37AC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 17:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF63610EF94;
	Wed, 13 May 2026 17:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E3RlEk6E";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF0210EF94
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 17:08:54 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48374014a77so62653325e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778692133; x=1779296933; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pyuc+YUpWmNiaP1dIFaI3qSdNN+wsu+Uo6KUndOWvCc=;
 b=E3RlEk6EI+WOUtGhwhfPODWiD/iVA0FoYjt4gdoIMkUhJ/z4VKltktRN4tv0Qtps4s
 3edZGBJ953JgKCDkouSAOjfDss3Hn2qxW9qzlLQ61vj7F0UPIKGO7brM/Z6y1+GxOBuI
 kxqmnLa0brjag6ObrAGv9/jrOx6rM6Z5T29PloQuVHygToZNC4+ZO19wJXnh46qpQF67
 +Uz3t6/5IMblVdguZu3RAsVBuZNMR2TPfXOS1YydthJChkQuBDiRF1c/ZwGkRfgRaTSz
 sjXY8LBRlrjiYMCh+iyogRYEe+jMGe4CEivneWJqWui2+YrEIs9zhqPxf3EHuA0fLL2O
 LptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778692133; x=1779296933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pyuc+YUpWmNiaP1dIFaI3qSdNN+wsu+Uo6KUndOWvCc=;
 b=hyS4ozSpwoANEhm3Fsny0+OR5YVBeHjKRNMscn7i/Mo8Th0b972GQZADapJH+kQKgV
 9nQcBbsPPqQwF7wogJ+k7f0uN+UO3+79XPxQidepbQ8E0s3+YktRd/KkTio5OVaQd9u1
 sg3HCuOof5lhGfoAHrVExtRxRmWwit2eyweoA7LW9DxFFgCo9P6C1WoB705qbEvangpD
 UpcyBL20UFVqBc11TdsKZIiXktzt1D5HcQduHtiL714jAGJG73ZAQweXeIfYDWF/Gh5/
 mUOFZYQJpMfr6IJutNQ/q6wBtCBNJsj9qLJ+XUDryGpEYKPVQHUU6aM/zQzklftyeXrG
 2TTA==
X-Gm-Message-State: AOJu0Yz/LCgZQU+wD25zyiEnwXtRBH2e5hK9Iz+cmS15mmwQ1OX36ih+
 Po026x7QglmerHBB28DIrexziFAK7VO+j/smMHTg2d3WCpFFz8TArufBoLyBfeLN
X-Gm-Gg: Acq92OGUx0+UctN4vj4CWCjqQW+6LVq68YURtziJ0uh1EPHjMgdXx/sIzYhSuTF4IUD
 FeFA8ucPu0tWMJta0bPBtYcnSnhWhTdrNgVtPb2Kx5BjZ8o7VVLErAKSnbIH7uLkbE7ADryjpsQ
 jd9Tx+FzmnBRBa8FqQUWGGfEG4Sw1UNUkzoHIUciNUEO57Y1MRO/nfU+mBayJRoqi55iv4VoRIr
 xPPyTOL2YB8v4bFNrX+2R+/v4r2ZugIhpePPS3sx2R4k41Y/cMiwAL037QHXUwOIb00oI/z7OkO
 VcKXyH4N0gH10dg2yWXUP+IhuQMPjhvLlvX1XL56ONWFaH/shcP1FaFVRO9E8Ys9OQ1inJfd6d2
 Grg4IqNkd6CkU/zHyShPvDRwSiJ2iDPnzWutgQsQD9pHcAAqkSqYU18taNRxphyJMe0lzQDdyK5
 ej4munW7bnW7P96sTJX8OYZPEySoJtWogwxb4DHguuRvkzoPlwnx8dCGuCdg==
X-Received: by 2002:a05:600c:4f53:b0:48e:8974:c377 with SMTP id
 5b1f17b1804b1-48fc9a53d16mr61120505e9.29.1778692133022; 
 Wed, 13 May 2026 10:08:53 -0700 (PDT)
Received: from Timur-Hyperion (540017BE.dsl.pool.telekom.hu. [84.0.23.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64a017esm4339175e9.9.2026.05.13.10.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:08:52 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 amir.shetaia@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/3] amdgpu/ih6.1: Fix minor version
Date: Wed, 13 May 2026 19:08:47 +0200
Message-ID: <20260513170849.27061-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513170849.27061-1-timur.kristof@gmail.com>
References: <20260513170849.27061-1-timur.kristof@gmail.com>
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

Report the correct version of IH v6.1 (previously it showed v6.0).

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index 95b3f4e55ec3..699c274d357e 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -790,7 +790,7 @@ static void ih_v6_1_set_interrupt_funcs(struct amdgpu_device *adev)
 const struct amdgpu_ip_block_version ih_v6_1_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_IH,
 	.major = 6,
-	.minor = 0,
+	.minor = 1,
 	.rev = 0,
 	.funcs = &ih_v6_1_ip_funcs,
 };
-- 
2.54.0

