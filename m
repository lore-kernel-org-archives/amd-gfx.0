Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F413FC369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 12:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A02010E772;
	Tue, 15 Apr 2025 12:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LvgwWRBy";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B849210E720
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 10:44:55 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3965c995151so2384785f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 03:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744713894; x=1745318694; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fdo8dneaizrUoQYs0r04kTs5qLNomw+odVlo3gYg1Fw=;
 b=LvgwWRByd5kfb6fsU3zBt9+geIRB8MNYpgB1lSeHqqdzze7+IbUz3Jt95QrdCufyJ5
 H/6KBi9UNyh+7U9+zdc4ZR3bt8UICh5DSm/wQge1HST/zt3+6K9T9zuvy+wtqiFPYoZm
 I3nZjolxyqnRVtoxV8MB1xmXJQu/5Q7m1ZRwN3slBSxuCHp2bpm7ME15FRvVsebi+M68
 3RzJfibrfvCNLtkHAyfrrApscms711C/JprAHXME+xAGwc23wjjafL3ra0TevcI94nqg
 XGm6ZUNuAJUlILKMJoqeqW4SSDDhTcG8vywCcFZd80eYUrFXnG+d46fdBNdK4Kjr2iS6
 O/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744713894; x=1745318694;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fdo8dneaizrUoQYs0r04kTs5qLNomw+odVlo3gYg1Fw=;
 b=H/mOYTL/8llsORLoajZ561mf13VWqLzrTeOVZQuqZ4VfNdZJEogTfJPR9sYnzCL291
 BHb61NVWor+yzrFeoaWo16JcFvMjTUTB6NTcTqdC1awIJ+MgpMKrPVkU6Hvfpdj0n2cx
 RuiTqfvrI6admsr9TTxu87YW1wbIiuL9xKTeRkzeD8LGamIjrk4KSg21MVn8m6vMddb6
 xrwsJVc4C/taN05YOhuDuSUMeZoH+VCm37NAI5fq/EjPVhwK8QE3sJ3V/yyzEWFNxYPA
 YFbryz2BR9c2grUc/BIRTbOv5fwBvoTcjCU1GF4xzb09rpmeaWQ2EMpYGZlXQ3N/NnFd
 6wjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt+QKaO9tom3I5d/guMYHtjSffw/837ZRqpGsZT7su85ZI41VaZgOe99Ak8eH2D7C5Pc0N4bqq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD6DFmnnqYD3qDa2hbyt2U1rD5P6tf0dj9RxhJ6iv5kkl23aDg
 mlVQspS7kkpTudaxOnDiODpl1NQVJsj9Etxc/V2R3xQI79Qg9kSxR2nLh/QDtRU=
X-Gm-Gg: ASbGncvgQnhsokSG6B2/64MbmLrz2QR4ZEGN8aklaT6k6M3rsiXDBy+FGYehONOw7Fk
 MfPZybiAEJ9POo26RwOQzqpWZVXoP3mkCsT6HFdKI5voalItHPFA50Yv3/V5kM8WpunuhvglE6c
 IQMnUlyJQfOybPNk5GIIjqEpcEGlvITqPWDHIlnxWj9+MxokThB/YZjJlOw9RHvCxpUZnB+DVAb
 uVHI3jbT4MLWCwXI1/5pIAuMKU/yGdr/I4EEiRKhfrvdJSVyU9VsxVXBDVDXs5um02GCeWvV2AQ
 MkZeFM1OGSomq/VECaxjsc3MN82LzJRGdcbXAY4ut/asr8/MW8yuCt5j
X-Google-Smtp-Source: AGHT+IGc9RW10knIr3MFj1Pzt4vKOq0H3enobQU/zlnoeN7SKpLX1yrOkCKkuW4z4l4oMeg39rDQgQ==
X-Received: by 2002:a05:6000:2403:b0:39c:30fd:ca7 with SMTP id
 ffacd0b85a97d-39ea51d10a1mr13006863f8f.7.1744713894209; 
 Tue, 15 Apr 2025 03:44:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-39eae977a7fsm13703803f8f.45.2025.04.15.03.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 03:44:53 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:44:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Eric Huang <jinhuieric.huang@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdkfd: Fix kfd_smi_event_process()
Message-ID: <Z_44oq-aSZOsvxTN@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Tue, 15 Apr 2025 12:30:11 +0000
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

The "pdd->drm_priv" NULL check is reversed so it will lead to a NULL
dereference on the next line.

Fixes: 4172b556fd5b ("drm/amdkfd: add smi events for process start and end")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 727a4ce29fe6..c27fd7aec1c3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -350,7 +350,7 @@ void kfd_smi_event_process(struct kfd_process_device *pdd, bool start)
 	struct amdgpu_task_info *task_info;
 	struct amdgpu_vm *avm;
 
-	if (pdd->drm_priv)
+	if (!pdd->drm_priv)
 		return;
 
 	avm = drm_priv_to_vm(pdd->drm_priv);
-- 
2.47.2

