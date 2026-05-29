Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02014CD6E43
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 10:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7F810FCB8;
	Fri, 29 May 2026 10:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZYF4cGuI";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E250210FCB6
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 10:31:10 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso118931715e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 03:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780050669; x=1780655469; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyEcsTBTKDINOgT7pQEyx8XWPJZeK4RBs9/96AaS5JQ=;
 b=ZYF4cGuIzUIGShpLhF7lrDKFUaupF+K6ZidaTZCoRNyCH05FkpDIMAr4ezR+xQtZxY
 qIumN4vBHDDECmuHlTiZPATFeHTsE6ohqTiIIwwbHjUvPDIYuWY/rfPI7yEO65hT17Ja
 nojQGNuFEeDS94nGRL8+f+AxlK+qzL55UsNTGsejhjBdr1QW8TnLV9iPEveR4AGfyPu2
 +yRN0Px3X1wPt1G7YXIPl3Uqv2YQfS5CUuG8hCQzpz9b7/L7GHYY9Yq7IwlgVpLXz/Cb
 70WEDmV02DhP0tlJgCEJIgY3Y1ufsySYQWimH1Dkrmz6USfNTcSqtJ2D8pISGpvZGXbJ
 k2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780050669; x=1780655469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MyEcsTBTKDINOgT7pQEyx8XWPJZeK4RBs9/96AaS5JQ=;
 b=N99G8IvigjvnifBgKK1e83tXuTG2kZ2THhdq82/DWvVPfuB/YdH2tDzebLRZIHOg8V
 XLB06OWHncjNDV9Vrl9cMh4NxIL3YIbrsPA/Z+8p3GBGr6bFYs8PtP6/pKM7qhFQG9j+
 poGf0jyEdfjyZFKx1SYZxwRTxzPwXj9HOSih5ZxyDjG22yVToV7ul5r3iRBvexNXakGT
 5W3tQeprrdBVYkRCD3vm7CGZL6O0SxQgA7IMKQmf/o+TNnapSoSgRhJVbBcyhAbezwTM
 uHeVy+bKkDWjPRFd/lx95ri+4V/hneTRwfGxxWkKA8wdqLPxy/W6fCO2AWeSZGbvl+fz
 0Whw==
X-Gm-Message-State: AOJu0Yzy8eu0dIal1kJblqkaOI4c4l7kUmBeqQnlQog1ABrFr+dNrpaT
 pMUDMBkBX/xIizNzz3BT0RgAgdiB6SBzOoALpnW3ZB8GRRJGgI9ggIh2Q7QwHWZjdGU=
X-Gm-Gg: Acq92OEtEdJhkULRNwGH6u5Fw7zptEOEQdoQ7+R2T0sRsL4AKViL+5DC1KwTbEF77iL
 ntKQvTzjxLDOMbbG3hif+DYB/WWnO9MRPfiBAsTLG+vT6NDOwburtfvb6B3SpUEDUH1DcHhX6sM
 Ai2UQM/2lNwsS7aynOHAuF31Z7jsinm1TPLzJBFxdHpHvfkeQ2RwgKgwhH7fBA9KO5EE1WEuHo4
 P0OO23+MvS7f6Iw5GVsHDTO/VNyLbeyD2Y6CLQPvMIACQgkiBczbaNA1iyjnCHX9rMxhednpXjM
 PLFBaOAZ/5z9HncrYFVEDo9AOjJdyoNdBnqOVwUuTCsPlY3ZrXB3KwLyiL4qDJ2rQomOptsW6R8
 +NYqkINuX/faM2M0ll0cEWihs3+ADqp5ydVXaYZtS8vSe11m/8rHT3I0deJEgrF5LlDDebv+VE/
 ea6yjlQQf/mSvzqlwZGUKoA2/pPxMc7MRhzoIXsNsNOEisGlI+UPNa30LHN0hgcR1urCOFkJDFY
 IlMRrPCHH1EeKdG
X-Received: by 2002:a05:600c:581a:b0:48a:557e:6b4f with SMTP id
 5b1f17b1804b1-4909c0c6beemr27527845e9.23.1780050669243; 
 Fri, 29 May 2026 03:31:09 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0a89sm40895945e9.7.2026.05.29.03.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:31:08 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 7/7] drm/amdgpu/gmc12: Pass cam_index to retry fault handler
Date: Fri, 29 May 2026 12:30:59 +0200
Message-ID: <20260529103059.21470-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529103059.21470-1-timur.kristof@gmail.com>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
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

This is necessary if we want to make use of the filter CAM.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 7bbf5f848ce1b..90568d8ea0cf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -99,6 +99,7 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 	bool write_fault = !!(entry->src_data[1] &
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
 	uint32_t status = 0;
+	uint32_t cam_index;
 	u64 addr;
 
 	addr = (u64)entry->src_data[0] << 12;
@@ -110,7 +111,9 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 		hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	if (retry_fault) {
-		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
+		cam_index = entry->src_data[2] & 0x3ff;
+
+		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, cam_index, 0,
 							write_fault);
 		/* Returning 1 here also prevents sending the IV to the KFD */
 		if (ret == 1)
-- 
2.53.0

