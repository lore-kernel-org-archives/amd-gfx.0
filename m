Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992EEC52D70
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 20:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF0710E3F8;
	Tue,  6 Aug 2024 20:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="VZB5cNkZ";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A7610E3F8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 20:27:37 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-42803adb420so755275e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Aug 2024 13:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1722976055; x=1723580855;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8E157h2U58HidSZWglQaVqAM8GGWepPtQaevvR1/k2c=;
 b=VZB5cNkZ8xxxpt6FE7Ng2cUY3QQEQKD/slWSIZqnybTGRMuEJn90pHOUannSctCZVP
 vrUSVLvM6ItFQW0FTAv3SuL8CylJeIUNYJQwtDNX14p5UHKuSjlHF9wNHnEmcFq1P3DN
 rQx+fyugvpiiPopsaZAyJLnjAa0AcVvvTdE4UJLY7rka8wRwbrL7UVVyle8Iuq684CPk
 4B6iMCfV618uZGOoU2eQGZ88lyThZcoAPzMM47L7xMm84eg0zEgVWQ0O7c/xzqAvD3nF
 SzpV+2Kz99BAq7pgj32q4TD2xzr3EafJt7Ld7GmQIaeRgOn1eooutVbdkcPKWJUCfbEB
 cHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722976055; x=1723580855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8E157h2U58HidSZWglQaVqAM8GGWepPtQaevvR1/k2c=;
 b=ehnsBQ6XbXlQcA8QL2Am0sM2JHoFceJQI3hSzJB0GDDIIAsuVIHEUVWzl0sm3LXtGF
 sUypN3Fvut/PyH67+taUyK8zrixHW3ZQuiM0zC0vpREtR42WnddnVEE21Zhtd+wBFHKb
 6oIoWK/gzx25Dmxst8AzUaAogxSDGNDzRjmCJJzPBZ7oK03bu5u+MBqAIG9BcFmSVDJq
 xNEtCvXN3QtpUWs6tTMxsemmypxWCk0NpPXemVnDhWQLitewbfPdKOBQU/+yx0aKfO4i
 yli1HdLaaXAChB08xLR2zPCYtG+6xUrPCnx/g1fGb8zQQbzfvHa9Vy4qAswi7HRYF8r/
 bYxA==
X-Gm-Message-State: AOJu0YybeQ41TDatf8n51CPYZjveoq7B8fbypfFrl6HEgyBwsGYv6GN8
 QK3kchZakYMXcuF8BTzoIOiCgJamiZ8yVcust5dCAuxFHXEwGV8Fdp9oHzqIyDTsNoI+G7kpYes
 U
X-Google-Smtp-Source: AGHT+IGyRwWuyDiLPd4/WDbEqvVjhhKg6uOV2OEtQ1R4J8ziVi7Vc0tMNaT61xCjxBMfrpJyU7l4LQ==
X-Received: by 2002:a05:6000:1861:b0:360:8490:74d with SMTP id
 ffacd0b85a97d-36bbc15eaf0mr7576662f8f.5.1722976053995; 
 Tue, 06 Aug 2024 13:27:33 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a781:a500:aaa1:59ff:feea:fd4f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06d7cfsm14004609f8f.96.2024.08.06.13.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 13:27:33 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian-koenig@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH] drm/amdgpu: Actually check flags for all context ops.
Date: Tue,  6 Aug 2024 22:27:32 +0200
Message-ID: <20240806202732.783604-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
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

Missing validation ...

Checked libdrm and it clears all the structs, so we should be
safe to just check everything.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 5cb33ac99f70..c43d1b6e5d66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -685,16 +685,24 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 
 	switch (args->in.op) {
 	case AMDGPU_CTX_OP_ALLOC_CTX:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_alloc(adev, fpriv, filp, priority, &id);
 		args->out.alloc.ctx_id = id;
 		break;
 	case AMDGPU_CTX_OP_FREE_CTX:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_free(fpriv, id);
 		break;
 	case AMDGPU_CTX_OP_QUERY_STATE:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_query(adev, fpriv, id, &args->out);
 		break;
 	case AMDGPU_CTX_OP_QUERY_STATE2:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_query2(adev, fpriv, id, &args->out);
 		break;
 	case AMDGPU_CTX_OP_GET_STABLE_PSTATE:
-- 
2.45.2

