Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A2FCD98F2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 07:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5E510EC9F;
	Thu, 18 Jun 2026 07:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F0TVBBmN";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A32CA10EADB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 18:37:43 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8422a92b6d6so33012b3a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781721463; x=1782326263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HBTeI2fu2gLidQ2w1YzFRkzMgZ3dP5HPVmfeBg+Z4uc=;
 b=F0TVBBmN9B/bORFw5WVAhSnJ8sKOMQzI/+VqRj6JNwCXCteaALuqlcFYyP22b3+C+m
 CXdTZxLzS/hDZlV1T+wh/sltOL79EGjkMxS4/4rtBcwqeVDbUPEYDNslhtql3RmLmsNu
 RQ3eBUIrcFWW5cBz/o1e10qxO8BGvWLylLOCaB0avTuygYjcf2R7b3KMSBeEBj0kJ4hZ
 cQ46rbdi0rKUKmELB1LkztpkBEM/46RCPnT2UD+3uKeMuylIBZAqk1/9GSmWq2eWhPEH
 jsj/irO+LwqSzyWFDalaDlhqRGWghmc91rB9eOA4XB911TwFrOnq7PWdiQUpIa62+LIe
 vmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781721463; x=1782326263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HBTeI2fu2gLidQ2w1YzFRkzMgZ3dP5HPVmfeBg+Z4uc=;
 b=lVdN53o5Rra8V8qaZB+w+fjzOVY+UrzRBcL4MTM3ssS+TA90oOdmp0x1BrQKxlAatr
 WfyvMVGQ0ImU1EFgiySIZ01YfiCOsu+gLUPz0fYKBrlEJCmNxZDgRFtMq2yX3dT/qt5n
 OJl2TzmL0o7bs1YQtUzAwWTXk0LMqpw8XXCmsVbq0F+AI3mq6wRE5ZIP8qybFohdzq69
 12i+5AiTabDB31pUimmbVXO/7WRhxUOxZFxsJs9JYg+750A9e3CSMRpm5l11myMOxw2X
 FX3IC9qkdIx322q9BwodxlTG3tgRQf5BZPLI4Md8mEeuKxXzh7P/Ozrt03Y+zEwLyerE
 Ha8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8E6pChuUeXfCYTaBW84bKC/X0s4uG4OZi7PhMyNa1lLlqgthqQZSjFbv6wxIw3cIQp20P+dAMq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJZgGgS9sXIJprez7Ob775LH851R/lkaaarf3h/SBkWNwS+HRs
 n7fQYxJHUCD0aaHtkFgIf6hqqRW1e3bwnjWyhVsZVos1wratJvg7AOAZ
X-Gm-Gg: Acq92OE4Ivpawtq9yPNyLOMLQGnjtW9yMnT2ZoSBwn2/ICIxBQ4XXK7tqZFJm1kx9CS
 OCg7yHhPq1XAeiNqz0V2Qbod6xdcabIwmSDGYVy1wvhUUXPtL7yg0oJSs9Rsec/pjZxMECEBoVc
 2+vlffzQKrAdZtaPEJJJtqpVSm4Z3koo+aYxGR1LIUr/KvHjFqRMxozPNfdMudJP23Rn2NjPT2L
 p3gIEDspQzGKFCegkUg7U7ttOZMrv4yRJKDvd1wS1cDVeYkcYlXnyGd7i4L2nvW+yzKDBbcKz4q
 8+6qj1ZGOf9f5+Ndz6KUikNzblKwnBg71gbGGc7+fZcn7zBUo94ncg4Pqm9+wTKeiK+rvVR94av
 wMbXjoje/etsf6DLqb34vWCNSGvjx1MUYVPnpuiyOqs60Mnnw3SzmO4o6WdaonbxY7svssGcrqS
 mYvL7khJeFULsKcb513X8Ky0ONtYarSw9i
X-Received: by 2002:a05:6a00:138b:b0:7e8:3fcb:9b03 with SMTP id
 d2e1a72fcca58-84539561caamr527712b3a.25.1781721463031; 
 Wed, 17 Jun 2026 11:37:43 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:1886:6b7a:3e78:272c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434accae18sm17380924b3a.17.2026.06.17.11.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 11:37:42 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: initialize ret in UMC error record fill
Date: Thu, 18 Jun 2026 02:37:37 +0800
Message-ID: <20260617183737.1101458-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Jun 2026 07:15:16 +0000
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

umc_v12_0_fill_error_record() returns ret after walking the pages
reported by amdgpu_umc_lookup_bad_pages_in_a_row(). That helper can
return zero, including when its temporary allocation fails, leaving the
loop skipped and ret uninitialized.

Initialize ret to 0 so the zero-page path reports a deterministic status
instead of returning stack data.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 14092150336a5..77a9f6a47d428 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -681,7 +681,7 @@ static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
-	int ret, i, count;
+	int ret = 0, i, count;
 
 	if (!err_data || !ecc_err)
 		return -EINVAL;
-- 
2.51.0
