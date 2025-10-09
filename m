Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ED7CCD18D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 07:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C206310E95B;
	Thu,  9 Oct 2025 07:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TosnUF6l";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1888E10E18B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 02:18:01 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so274677f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 19:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759976280; x=1760581080; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMwXLPH27WuiEOjKg3ccYDptKtMt8Wlr4nTnNsdwDvo=;
 b=TosnUF6lk8VXc/kQC0zUCqJ06YBjP9XV56059ROpXuNlHZFj/ldLGl3ZdAJ8jKML0X
 qtLUGCoHLbXXcS6fHlQXyM6VzPA8o0IJgU6naSMLPeZTEnqEnE6OXFRstl/lkSsaI7g2
 qLx/1F6j+A+63xNGgOPIEJwkkbzDGj28IAWGIw4wdqE+jw0JtP2rA+kG3JCOSqG29/md
 b87vBuawwFNpWkefF5R/TuPaizj/VV0DQEDL6XaeZK4/xDrxvqHbFez4BEmJ9kAuWW8S
 a727jhOqRb87UypyfHvgIVkH8OtQA2+/XSL5HOosY9/IHDPJFkmB4bCas4vB9bNGdujR
 gFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759976280; x=1760581080;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZMwXLPH27WuiEOjKg3ccYDptKtMt8Wlr4nTnNsdwDvo=;
 b=eP0kwTp3LFQ9MhruRlGjFVrBl+7Yg3pqqfoUG1VXazG6kle1jnoamjgOQ+4yHAuCbw
 U6eg8vfWBNf+Xt/xUo0mwgWLDu5xUHiu680NdVSEN9DDaBta3FJcldspx/veGvVfFUsi
 ufR5C9fKVvdUmFVA0Hw0Xe/c1/pdFwDfIt/dvQgaW3MrRVnJn+g657wOng2i7A/WMth+
 V+liY1HT7ioxKZzyolaoQSH/EkVjBdKLvWJouLzJ2WjJg0WsqVVTI1SkesHpTWmDFCyO
 VEPJFcRYsO5cAwi37HTrPO6LsV6+55F2veOqHdSObuWX2AHaE9G9EwpIx4ivQbuO/QPs
 GMtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgV4D/IADz4B6NpJUvudGVJ1VxWGIWutu/Vm1M5OAmrh+bd/YjEigBluvWudc22lvbPadP0qbL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwElp+6avvpTZy/J5ccvED2pLs3TeXSZbi374CaKVjUeAg4tWi4
 B2hDcv3hxiNbKW6uVa9hZMunynfTGvKk/tu0JcrmK6J3od1D31ABE2kr
X-Gm-Gg: ASbGncvH3VzejRylE93rRDkjEvak/8L6OV9JGw2VK3bFZc9eSq3uB8myZ+XclARy8uL
 Eirdqx27fMhBrrrKIx+YMStJPuQEva3mM5G+4arHtBrgeEf9aAW+E7hh8BOoLsfjbbNNtbXbCBz
 G47OHRb8Bvwxb9jDnm+nh3r78YUVAAQvMVrSFjZ3NyU9QPoTfUPDtFDobS5BVmPZoZdVDayIdrI
 mO6wKbmnUjsP9mAxDAGV+5OejD+fvIe4820Hrju45teuiRimAQo0kszBWqaLSe6b/8MtVFhfKS5
 XGct90Vy+eh90ccXXCjynNbNw4ps9i5t6y/G1rU/JGamVJcHzRtG6QthV3mLinVwA1Vt6DBdcWt
 dtN0dS0oj5Vz7PvC1h/wwyDCTIU6vnYaa5/sZzp02TUcuJ9pC+fLpEkyp2gKwAck=
X-Google-Smtp-Source: AGHT+IGkF8cnCg0NUgJr87v3b6RBEHWZZ8L7rvOevRDn7+hjom4Wb24Qm/GEl5r+wlLmW+LXsMv0Yw==
X-Received: by 2002:a05:6000:4025:b0:403:8cc:db66 with SMTP id
 ffacd0b85a97d-4266e7df9c6mr3333203f8f.32.1759976279696; 
 Wed, 08 Oct 2025 19:17:59 -0700 (PDT)
Received: from ekhafagy-ROG-Strix.. ([41.37.1.171])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d7f91esm60094215e9.20.2025.10.08.19.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 19:17:59 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 mario.kleiner.de@gmail.com, hersenxs.wu@amd.com, Igor.A.Artemiev@mcst.ru,
 nikola.cornij@amd.com, srinivasan.shanmugam@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, eslam.medhat1993@gmail.com
Subject: [PATCH 5.10.y 0/2] drm/amd/display: Fix potential null dereference
Date: Thu,  9 Oct 2025 05:17:10 +0300
Message-ID: <cover.1759974167.git.eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Oct 2025 07:45:21 +0000
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

This series backports commit [52f1783ff414 ("drm/amd/display: Fix potential null dereference")]
to stable branch 5.10.y. However to apply this i had to backport commit
[3beac533b8da ("drm/amd/display: Remove redundant safeguards for dmub-srv destroy()")] first.

Igor Artemiev (1):
  drm/amd/display: Fix potential null dereference

Roman Li (1):
  drm/amd/display: Remove redundant safeguards for dmub-srv destroy()

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--
2.43.0

