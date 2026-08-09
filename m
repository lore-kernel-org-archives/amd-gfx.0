Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A353CC5B570
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F44810E6A9;
	Mon, 10 Aug 2026 06:42:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CyUzRy7F";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27F5110E0CB
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 05:13:14 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso6495495ad.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 22:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786252393; x=1786857193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=CyUzRy7Fl9mcKpeXKlJZCE6dcn2r7CVUIjVqJQsWZpGdXa5kAEUarKf7MNB3LctRU9
 Vv8hbHbHq06ccSF6v8OJm33r5XWrscsteD/ROsiym+rGMPrNJ3w4kO3RsVfpRBJ5HfnF
 BOfRCu1GTeUMVMfYFMUKTEuhBvPlP5ddv4n0tFOW5Wx1LXOwBUYfO9o+Lfsnxe0rUG5W
 r50QTj552Udz9qnIjoW2WTQ3G3Fa9f4+9L6Qa+7UuoKauh+2o7DRkmpQEw/ZSV2m0dBb
 PFXEnXtc50ZNLOFJydOyZeOJT5WJ4QQxexnxd1rH1VS5ee8E5GPf7iSJHPF94idi3IMk
 6fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786252393; x=1786857193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=K4pBkuycfrQa/FLDADa8coqiiA8rMrDWB4EGUEPhdiMqRzMflqsrZTg8Vvqt/dqX/Y
 CdtiaQdt1h7jPQfkNAz/vzbLWh3B/5IAASBhnvVRJCQwS5auU/SxrgM6p+XXYK1HMEzJ
 2esTFcrYlH88XZoEMwea4zPtNVI4btZ2TjCgoS/3aoa/Q+YteyM9NZhWPHIyxtiSNQHR
 Jgo0CBAjUKlqdqpGzmpqExRzuAWPALwAlrjLvwQLQSVD2Jpz+8i94tn3NR83JAi8KTvG
 hNU5lJ9sq5VojcjuPb8m2J2DtmX43qeC00Z17ICL7xBghyqvbxRIUtPOf6HRxGQ5b5BZ
 mVOg==
X-Gm-Message-State: AOJu0YyFGLD75aFrls08R8OMafADz9y6/ywCbXTRZtbPj1REN9Zsw9FF
 A3EdiGSgCrRoFb0btVzC1i3xysd+dcY5nYnMO5k69kJARfJf0K4UFFgw
X-Gm-Gg: AR+sD13405N6+9wiVpYaF+L9LhRjPPOaKkuTWJCilfNYe+zyw2qduosjs0WyxVN/7vQ
 f0zrO2SThoCnyCi6rgZEYBdVnzv5nDImnFobaTHg6Kod7J5uTatQWQu/zjOISVMGXW084wTxqN7
 cEvLH4i08OebwL+DVuPOQaSGThlwdH06sLrs68DGOMY5Q7jxe+2dnwmLawMS1dHUEqu6vgKutPv
 foVa0xizOEdYVgG8OJv9wNN/4PVk+AK9mBqRYt+E0Tc4ychaj/oJBng2qrn/fFiNvfo4ifsFhOY
 2fT6+rnGllrCt6W8eOLuh4FqjoJI3u+7MUUa8VGZrzCjqQ1lFMIFX4Oy33bWEPszqi+8vU4dPSu
 EKu2dYpJ2G4jhYzmVm3uToDYp3OdIxdgbeFVvukGzOaaKJ/EF+EpQYrLSO2cWS/QpcO+zsTsmzQ
 lolV8ePs42QyPhHYNIpt0S1nUHBAdaiirLW6FbEVdseSEcKSg4I0O0JAne4UqEdqGTHfs8g6JQT
 AAnxCQNj8TQOuFyNMR5VOjN
X-Received: by 2002:a17:902:f608:b0:2ce:d957:59c4 with SMTP id
 d9443c01a7336-2d2a8692dfamr135589535ad.6.1786252393509; 
 Sat, 08 Aug 2026 22:13:13 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm27095702eec.9.2026.08.08.22.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:13:13 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3 2/6] drm/amdgpu/aca: Add upper bounds check in
 aca_bank_hwip_is_matched
Date: Sun,  9 Aug 2026 05:11:56 +0000
Message-ID: <20260809051200.3276-3-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
References: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
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

