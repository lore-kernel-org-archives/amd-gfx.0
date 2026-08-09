Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C78C5B574
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5614D10E6CB;
	Mon, 10 Aug 2026 06:42:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OkmW724F";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C51E210E11F
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 14:46:45 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so1009148a91.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Aug 2026 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786286805; x=1786891605; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=OkmW724F0JUD82UYEoXWy7PXueY5VFVSLeBvYkewSc7MynWPupunMayesXRZBL/CmX
 J300Zk+POFnLne9XqFr8EamjN8gAfEU5mJ/Rftw72HpqH8dtjN0m74GLhcuHMrMakyDE
 i/dC+dMqa7WtpKWQVfiJMrPNZS7Vj82z8YBQu5J8qPtZ0fC4GTrLQX1OX1CoTsTfGupM
 h4YbNjNQj5qzcVfqV1/0T1KD1pLN1nUHhTcuE3JuXCusqScsVrnJBa6frYBLNubV6So+
 T6C1TCz/4lntgIAsN8vP3/Qw0xC+G/CrPhfANSMtcEoo7BkVe7GBJv31Gl+9KXZTRRsC
 oxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786286805; x=1786891605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=LjH6YUzL/z8uMVrp4Y6cx2MRjEI23MLbrhkhgL8a8oWxHYjQetNILpphHWROb4hKsC
 1/obTyMC+ZeXlG77pab8YaymzTueG6gqfQ10MVjuClaBekh5PBI0tC9HRHy3nVpYIboS
 xBS57kY0+PF11BsKH25BCS+KvDPagRbetVsHNje5+x4sxnaOJ8X2c0+0r3yQmwPbwN/5
 jssoNwjSB6Kwl4+dwWwKVzmHZAeC6SFFQ6hdE9Enbo4vEpvdVannMuRAle25CnxDmo3b
 oDDp3KwjL8Mh3sPdIpESwYbBrrkjXblBxmVyYdRjytngijfkXHOjHkwNnDUCONRHkP7j
 bbuQ==
X-Gm-Message-State: AOJu0YzcNXxXlmnKLUlV+9MedFt2mQLjtKoZ47Nuwb95PKptoliSHXhu
 s8o18EWxZL3v3/f87Zp22DaNnf5cRimVCOoBS5nY1gE3duHgXOiLhny1
X-Gm-Gg: AR+sD13KJGzbLiR/fc2+3b2YNBhFJBzVPoRE9vX4ZaOau5YT63ss9WPXKSeF/kK7Ia7
 ZhDkwNpE39a96L52FxToilbR1UW3fN2G7e5viFtLcz9NXF3SlArQXLyuQ9LAmbRpjAWz/32JWXZ
 5eLPpulCV9eyW+bizR0jFB929EYFKrQnr0SnK+h3XvhgKqk2i7G+HSdasx0LfDDw9ht5Yj9bYDV
 m+m1kh/OwsKgUphWI5gvKmIo6JvJPX5A7LBA8PhzaUXG7jE1UpPgjs5HIKbpEIoaqmbSz0v6TIz
 qqhfi6uPyEajDrxcMG7+h2fGuPcyYZ9F/ZbqFhbmhrCKNAWWAqVh238Y8VIP7p8V4FzGJmGpUYk
 4WGUzEC58n0EyuDo+xTuxWvUEv3onTAVh1DtrWjs7Ln+f1WtPuFrSLotTqJhyO663Ekivp38Q/M
 VyxjpxyGP3OK3fKwls1uytDa9yB8ajKtRw+ZPKTIP5Tq3j6FcsaynbTid50mo5XfThf3WCk5qO6
 Sjz821NlbWujetJkGl8Cg==
X-Received: by 2002:a17:90a:d010:b0:38d:eaec:4396 with SMTP id
 98e67ed59e1d1-3903c58bdd2mr36617260a91.11.1786286805186; 
 Sun, 09 Aug 2026 07:46:45 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b7ad29sm25911224c88.13.2026.08.09.07.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 07:46:44 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v5 2/4] drm/amdgpu/aca: Add upper bounds check in
 aca_bank_hwip_is_matched
Date: Sun,  9 Aug 2026 14:44:49 +0000
Message-ID: <20260809144451.35431-3-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
References: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
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

