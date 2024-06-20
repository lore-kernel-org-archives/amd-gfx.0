Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1ABC2BB85
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 07:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4AD10EA7F;
	Fri, 21 Jun 2024 07:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NkOm0QuC";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0585F10E883
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 08:49:36 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-a6f9fe791f8so109589966b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718873375; x=1719478175; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vplqWI8cKIJ52zF1aYYCsDVAV72MV1EuoajGM0seqQU=;
 b=NkOm0QuCRuRMMB6lbJfZrW6V+962D/6Ti6j64r3VQmJzV0CR/PiLjAC0MksfTaOdSs
 qRruB98Jp0Vje2iNTZFbsrMDJF0SKcjHHKthk+qvz17xjHcdcSFRl2G+TFmbsBUMjoKa
 q+3ot4bKn658/tw5lcrAmTj5DP9y/2Dh3p8Nkvynea6nqTnst9+D1/+uRY+UVZFXNoK9
 iXlEwwAiZQf76RMC9fOCN2vShVaKvuqOj19naqoUAcV4tl6PYvXC4+e0M7yTG+UyNdHI
 vEwJIhoh8d7GkubnJ2BrQPSI93cnMsgo9M++SPhV0pa8pwODEsTuNlAWKyxMFHKWbIY7
 LMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718873375; x=1719478175;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vplqWI8cKIJ52zF1aYYCsDVAV72MV1EuoajGM0seqQU=;
 b=Tmeba3u3GKMEQjKO7u1UulQ2nGdH4DJ7PVA7MsliexcdhTPgH2rXkMyeCo6sDkc/Vc
 e2+2GZEWXs6VEGUvChj7BlrOg4vJM6nwek/pOFkzhDbicy6gkpkmcSQXC5Vd6sX2AkDJ
 BZFnsQhVUlgw1M6HtwEaWVJ0cQvT40O3nboxrrk7KYZ9l7gYo5MEp0ojrj6L77XW0twf
 5K71UKXxemTf81Tijf16BO+9lFL7/H71WgcsJkIsFJ30LdPrMVzfcbCOzS4TRUwD/ydZ
 R8/5zNRbO7Bez3lY883t+ut46lru5HZBBFM+uSogC5QbqelCJLT6/Kwwp7ls4IGDWpeR
 usbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfNQj8EFlqpqJQVjaWwja1i4l9rtqgNnMhkqyeoJmMMfNKn2A/QkizsDL8x/fc/oVtTbYldDg1nc1zZDV2MhaoXos35b4yAjJrC3JrvQ==
X-Gm-Message-State: AOJu0YwtYYSsGyIU0X7LcrtYKQFwGdUT5acH7s9Br5IovIz3i/17MwTn
 Phs4XEBqfiO+5Bak/cm0ewLOoUYEuFEQj1LC6cpYBZp+IYJr9avxvkk6CvtPWdk=
X-Google-Smtp-Source: AGHT+IF0HJWu5+9qrzpdj+2IohqmI65R3iM9YQiZqQ/II9cNRx507OWzSUKesTfdkh9pqQPDzJtJrg==
X-Received: by 2002:a17:906:3643:b0:a6f:6bad:b5a9 with SMTP id
 a640c23a62f3a-a6f94c047c4mr519564166b.7.1718873374898; 
 Thu, 20 Jun 2024 01:49:34 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed0ea4sm741387066b.116.2024.06.20.01.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 01:49:34 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:49:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yunxiang Li <Yunxiang.Li@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu/kfd: Add unlock() on error path to add_queue_mes()
Message-ID: <10510733-a59a-4419-afb5-e75fdd802794@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Fri, 21 Jun 2024 07:13:20 +0000
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

We recently added locking to add_queue_mes() but this error path was
overlooked.  Add an unlock to the error path.

Fixes: 1802b042a343 ("drm/amdgpu/kfd: remove is_hws_hang and is_resetting")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d2fceb6f9802..4f48507418d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -230,6 +230,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	if (queue_type < 0) {
 		dev_err(adev->dev, "Queue type not supported with MES, queue:%d\n",
 			q->properties.type);
+		up_read(&adev->reset_domain->sem);
 		return -EINVAL;
 	}
 	queue_input.queue_type = (uint32_t)queue_type;
-- 
2.43.0

