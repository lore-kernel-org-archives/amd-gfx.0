Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9984AC5B56C
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0791410E6BB;
	Mon, 10 Aug 2026 06:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PE1Jo4OS";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E102910E085
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 21:10:42 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so9199455ad.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 14:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786223442; x=1786828242; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6hwMQ2HMVOe/ZrnavsLxJJgOKuAnP/w9GzcsAMiyxO4=;
 b=PE1Jo4OS/TB/1huSea82t2wcTgOuKeAljtlmgNaIZG1B50wih8E8UP1XbyFH+Q7vpk
 7Z7louzpaKJbM0pNeOJtw+jmDFac77We8RVGOQ2iGs5Y8NmJqBlNbdHyNVzuz85g36Xh
 cdOS2DDKZwGddT3pLtlbciPGkWXvFy2mi6Kaoq1tGidKEfpTz905ZmlYaoQZfIN6uEL1
 d/aFGU7Axj/qm79HQV8LaFaeeSPeJDgqJs/xen0t685/71TsYFgU/yWmH27YlmITrMfy
 epp1TSSz+tSUfc6+vqNbTFW8V7WznI2CP/rGxKtLoGo+rwjtT6PybUEVlxX12kbUpM//
 3wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786223442; x=1786828242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6hwMQ2HMVOe/ZrnavsLxJJgOKuAnP/w9GzcsAMiyxO4=;
 b=Ji5RMfkVHXw3nmEXWPsjRkDDro/E3fBY2B1vfHyYdyhGqDeA3+TmjoELRd/rn2R4+I
 sVvoPeBks07hyUv2adXs0klKdZqOZb1vzuyBW6CiYLXxlTd7E7QmcUmcQ4vFZ6KJjN+/
 M9EhccH0F66Q1o2NQPm8XkLRKJ0uWgnTku8+qn4IdyuTsZlyxzwPbU0dNQhUJDAsdNg0
 4IsvopbugJBXfygqDBO292bLY/GhtNQNaKEzO0M/PDGaxkzUMSgQqOZhVEWxOL1wABy1
 uL5TbH7YPxvlC7cBCGKG7VJFntDp86+BiX1XR8DkWDB4vasQGTIVbuls6n2YwVdAJ5Ib
 wsmw==
X-Gm-Message-State: AOJu0Yy9xt+WZtX3SIzumhi5GnWjZaWVDJsL47TlLwkuFnvo4bNxI4s3
 V1JW2jl+3dAkCKHL7G4RtsNYY8iC2w9Hr1n5ZL76psQRqzPntqlpuNZk/7tJJYlN
X-Gm-Gg: AR+sD13A07SPNnSl4B/uvyXSf5+k7JpqvL4gyrQXSawXbX9p0xLNlJ7Voqys+fbWesO
 EvtwBAnFGQjePGLJQvz9pdRMaxDjY9YeUxImS68mMwcJAKsOOF5KKV+OMTgDUTFKizjaT1AT3OV
 gtniDkDP1knKwW4/ot3VcHb2KkGXwETHZZkG3k/35/3hEoMo0eG1eJ4OzkoiQLrkTLyfWGywu67
 Wq5DVzbjXhz6kFd6Pt+OPQ9C58Q7SbfX92R4MejM51jzK9MADBYgygLKldq/inrK57PYolJZgJS
 PIyawYPAr1McUNAyKZ9xC24GpYEafinqA5hZ6im4cugo2hB4HOOYmXrFHXrDe9I82dHHtxKXPz9
 4KhOzttQa/dmDZ5sv5CUODTTusoTADgWaljX38B1NSJzkdjUViW5yRpJU0C+gfjOw0PfVqe0AZ7
 Fe8os4flYR/lwrDvCVSVd9XHy34CoHbmjyKvfRD3tH901rDwsFpl2/41v+7B6eNIwWlPXvvcwod
 wbBNlZ32To=
X-Received: by 2002:a05:6a20:4322:b0:3c3:b57b:6285 with SMTP id
 adf61e73a8af0-3cbc01b4a9bmr11804825637.13.1786223442339; 
 Sat, 08 Aug 2026 14:10:42 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec5aac2sm25713133eec.30.2026.08.08.14.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 14:10:41 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH 4/5] drm/amdgpu/aca: Add missing NULL check for banks
 parameter in aca_banks_add_bank
Date: Sat,  8 Aug 2026 21:08:51 +0000
Message-ID: <20260808210852.2938-5-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
References: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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

aca_banks_add_bank() verified that the 'bank' parameter was non-NULL,
but passed 'banks' directly into list_add_tail(&node->node, &banks->list)
and incremented 'banks->nr_banks' without validating whether 'banks' was
NULL.

Add a NULL check for 'banks' to prevent a kernel NULL pointer
dereference if an invalid pointer is passed by a caller.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 1cddacb7c554..47f3bcd5de0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -49,7 +49,7 @@ static int aca_banks_add_bank(struct aca_banks *banks, struct aca_bank *bank)
 {
 	struct aca_bank_node *node;
 
-	if (!bank)
+	if (!banks || !bank)
 		return -EINVAL;
 
 	node = kvzalloc_obj(*node);
-- 
2.54.0

