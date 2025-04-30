Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5FCC3ABA9
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 13:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2ADF10E857;
	Thu,  1 May 2025 13:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hs5MgAWq";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660C810E717
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 08:05:18 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so23473425e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746000317; x=1746605117; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qD6CtIO/TisXjPtHYMRMSY8vPIJC8aCPMTopK7WpI/k=;
 b=hs5MgAWqQnJZ/N2FCOjtup2RwKlamYdJpPYW45yLSbkEzCjWR4EOtby75117HmrIz3
 8nQVfW5T4Vfua7g4T05cWBp7/QYojmVyhtShN8sEc5dlY5vHjxTxGHGJyz7wq/9ze+ne
 zXZl4dPfjKvarNY+d0N5Lpd3+WVuTLfQevvGx2rBbsJAoxABdG6LoCkeD3SnPk/gQiLR
 3APcE0eIzdPI9xXPjyXJa1+DDWnYWPMqv0qPQ1L657E6vt2CdNKlMb1cHZ8mB/+YKd0N
 G+t/tIm8YegusI5UHhJ98e1qYz0N1PnutaXMB7gul6uzNFTOPAo8kK7xq6zU9WabMh0L
 jtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746000317; x=1746605117;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qD6CtIO/TisXjPtHYMRMSY8vPIJC8aCPMTopK7WpI/k=;
 b=licJbH5TY1N7NasNiw9npXYOhnimf5W5W1qDAj5RvcGLGBXp7AxUbEfkzIgCzx4eZh
 DZ+fxgcVYj/nItkgYB+3mCxmm3SCXJENiIjubDepJD0TfmDr/BuC99YPnJEPPvBkEK44
 ypTCygtRsMPokacvmjZBcnIUDwdcpM2IU0PH3hdUX6UN0rmyX1TzAKC6K/9Qwnv8jzdY
 vjf21zL/A6hwfOrcJhWuDGoSw4pAhsabq2i08ak7XkM3fXxnQDJRxIydBiWJ7p4XRAtg
 TNHnxX+6srYPFFsnAQfAr5dWpjS6KPKkFbhcwneDddn1KwqWxSJotFF2+ZdyO2nMcHQH
 lkPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBd3yYr3Ks7Jg+8Gv23GpyPyMhKme77YphSJGRWdDq/A4cCIlXjb5kDQpik/cOdMj48RyaiUTK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybLeq6VfCyMG361ai5OymCN3p5T8khy3wEhTyVRZWBz/NqktNt
 YDkHjOskIIsdiC6kkjXtrRzoGTdQyOEYlSpdIRxmpNAwGQhidZEVdOnZSLGYRRU=
X-Gm-Gg: ASbGncvE05AByBsoEnGu1zhAQh5j7RegVeuOvGuHbUI3fZ/iNBPs3mZQjwC0ulvQVmf
 wGnCY5AxV7nS2UzWtvO7llV2b48GRoRaiEkq1uYgfyDNmXk+1hohE291rvLAlmhXU/OfmqT8qyi
 8huv4UsZVbZZxLIQYUPbDUZIVkoFsDMNTYbUApR+DZzihvmdDZB1y8ZY15jSGNaQ2Lo/PAr3MCF
 aDkmmA7ASZqwpi+gM2AIbChKZoyo14KX4KWa5LpKj+NWL/8RWJ2suyDUtSsqiOXWDgpJ0jVXdHy
 buMUY4iziwjv/P9ivZ4SU+AccXr1vW6ey/XgGLFtZPlgOA==
X-Google-Smtp-Source: AGHT+IHdEtFR63Z6oiW9IVvngwXx6ZQiZzLOjAXgoM9uBkm6EKIWAveHvb1hm/cJiMmkSf12Z002jw==
X-Received: by 2002:a05:600c:c054:b0:43d:300f:fa1d with SMTP id
 5b1f17b1804b1-441b1f5fffbmr15536155e9.31.1746000317302; 
 Wed, 30 Apr 2025 01:05:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-441b2b20c3fsm15479405e9.28.2025.04.30.01.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 01:05:16 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:05:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu/userq: remove unnecessary NULL check
Message-ID: <aBHZuejTTKkdnGaZ@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Thu, 01 May 2025 13:05:51 +0000
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

The "ticket" pointer points to in the middle of the &exec struct so it
can't be NULL.  Remove the check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b0e8098a3988..7505d920fb3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -631,7 +631,7 @@ amdgpu_userq_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
 			clear = false;
 			unlock = true;
 		/* The caller is already holding the reservation lock */
-		} else if (ticket && dma_resv_locking_ctx(resv) == ticket) {
+		} else if (dma_resv_locking_ctx(resv) == ticket) {
 			clear = false;
 			unlock = false;
 		/* Somebody else is using the BO right now */
-- 
2.47.2

