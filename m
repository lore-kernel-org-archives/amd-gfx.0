Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EA4C5B56D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46F010E6D2;
	Mon, 10 Aug 2026 06:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AQAMmFj5";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2DEE10E10B
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 08:49:37 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cace91f112so8804605ad.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Aug 2026 01:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786265377; x=1786870177; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=AQAMmFj5pQNZsVpQum2+2NCnuMuBbYHYou2ddQaOBfONDF7h2NmYBDFNJU4NQi9U6Q
 HqPz5jf+ACDR9AxsLGt7iYD7uF7lk4AVof5/+HXDV6LZzkJuXcAfHmHYYLFVe3YLJITZ
 qVE7/BVqu5uWVq2Uw74ofIekXk5WdUEcZgnbyGu3nBAKSCDo6iUzLxnMabKzBXtgL7UA
 IYqW6T1ilFmpKdzEOhbYAGBSHbviJ29a/P+2+0QdFlK/PCkHTIhLYsvehJvyp6WWCBRi
 guBsM71m7l+NbuwfWgTnUlAseu5x5ucGrZPJyUL6LhIss8T2z1aUpmw6ZspB82wnRi/e
 sW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786265377; x=1786870177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=qZcn9PTH4Oh1n1pzu1mCUUVdy0oizZqrM40DQw3x82q25xM+SVKWmwJjsRtjDCQ8ib
 YDOqnylB+HL7hK5U1WGNrUDe51ddhN6+CvIvu3qYaF7HAl/LqBQeVI0/rK9JY2oPjSWL
 oLQbP5Lyz1IStr/qsOGACS9jsANuLWx1IafeOo4bcqzJk7UvqxUB8XEp24iTuIoObJyp
 iO0ShV07j0Tqe8w5dAxRyxX8Su7ze9iZr8goPKsgGYIZXIfzolB7e0r+/207AdKHcZbK
 J9vrNrmrochtrAoJ8yOqXm3TS4WHF2T5uoa3ZNC2aH1Tru9hM4n4QC+JutoltqDSw5PP
 9Z8Q==
X-Gm-Message-State: AOJu0YxB+06UhDAJdZPW65BAKKVXeMPQmwyF/VWNTddS0r5lXJa3DRx+
 QF9pwMsnb8XxpTufYeaaHt+8S3SOVDlVB8mg4jUBj0u3Iz4L1OozjhAY
X-Gm-Gg: AR+sD10/QjripwbhYlUYc66FdoglisJKRQdbEUFK35mhIewKWT7YfOrpPVsEGVRsmlz
 juaLSzfLIOdUmgg/GOGKiaZD6lsQepFaiaNsCibhjj1wTMIrKvQbVUD/zjVaZMQgANwxceLJ0Ns
 Lu6tVxMm7TqTNWLc3l0HZmS3Rqb5sPuxagBIrAk+8pvZg8AGw2DeiI0CUBMDU7xztoQHWZ/43l0
 PyHDPLL04ikJwp+ekcrR5S9yFHRN82SiuOahfvTrMZbTpWsxP5HIIAtGrDWzrEg/MLhTZfwVhZe
 DuSXaFGlDNE9wkSxrAnEuQ7/aTQ3IFW8ESbgePVC12BRgXqH5YrXOgryy8/7YYuFW1MDRf/MMMz
 6NyHszNYENcMXY6nVL4Is+VqwaemFF4zOGTz+frHdnTbIFXTsTEAX6aCTWSyBO4v5QdDOcliYQE
 JJn/2uhtNNRoV/OS9E8e8Npi1ytjwVR7LkuLdxIqf0TzjRbTFmCkZw1cooRnXf/VJDQ6rY+d1+Z
 jX8n9YpEDEv9wNmjcFVZg==
X-Received: by 2002:a17:903:46c7:b0:2c9:b48c:fdec with SMTP id
 d9443c01a7336-2d0ca75d2admr449178665ad.12.1786265376710; 
 Sun, 09 Aug 2026 01:49:36 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm28800025eec.1.2026.08.09.01.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:49:36 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v4 2/6] drm/amdgpu/aca: Add upper bounds check in
 aca_bank_hwip_is_matched
Date: Sun,  9 Aug 2026 08:47:31 +0000
Message-ID: <20260809084735.9743-3-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

In aca_bank_hwip_is_matched(), the 'type' parameter is used directly
as an array index into aca_hwid_mcatypes[]. The function previously
checked whether 'type' was equal to ACA_HWIP_TYPE_UNKNOW, but did not
validate whether 'type' was less than ACA_HWIP_TYPE_COUNT or negative.

If an invalid or out-of-bounds enum value is passed, an out-of-bounds
memory read occurs on the aca_hwid_mcatypes array.

Fix this by validating that 'type' is strictly greater than
ACA_HWIP_TYPE_UNKNOW and less than ACA_HWIP_TYPE_COUNT before
performing the array lookup.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index d0d473082431..c76664af9902 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -138,7 +138,7 @@ static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum aca_hwip_type t
 	int hwid, mcatype;
 	u64 ipid;
 
-	if (!bank || type == ACA_HWIP_TYPE_UNKNOW)
+	if (!bank || type <= ACA_HWIP_TYPE_UNKNOW || type >= ACA_HWIP_TYPE_COUNT)
 		return false;
 
 	hwip = &aca_hwid_mcatypes[type];
-- 
2.54.0

