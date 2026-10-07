Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98554CA6011
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 07:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A336B10FCEB;
	Thu,  8 Oct 2026 07:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kYRzPaBO";
	dkim-atps=neutral
Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0714810E5FE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:26:58 +0000 (UTC)
Received: by mail-lr2-f3.google.com with SMTP id
 38308e7fff4ca-3a77df9781eso23106211fa.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791379616; x=1791984416; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GDQwNh3Y7ViZN9kSjBt6rSxx3bjORoWLA033ou0tHZw=;
 b=kYRzPaBOsCSKqRQS2vizyZ55efSCQN4loX0skpAstw2U6ZzNey5M06/6QYaEtF1M4m
 +Xbjr8e2pRtiHW2jYY7A/jmVeqt1J3USVCyKtZndNO6QDDV0D+bObGUsKrXeVJm+kqkO
 l2Wf9oidP8YtSuhdRNj7iYl1FeLxwcSkZLWLxWMoKvwjX8h787KaOQBU5zxvH4o2CJw8
 Z+6YKAfSx++zHlsKiRNN2y5Cfah4UMQbawpOJkw9HlknDC/5/qa5CGfcrSdiDfA8nC2S
 puMSRKOyadqnKx5w7XMh9woZs2+xlAO80bbsM5LeqoEQxJCDRoIeeHbIyB/8qSJvsJa7
 rHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379616; x=1791984416;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GDQwNh3Y7ViZN9kSjBt6rSxx3bjORoWLA033ou0tHZw=;
 b=nyNwzMLSabsT8ZeRxntuk21fwz2ZmbgrZyjH986z3w4TNY2BenjCSKRjnUxiApbBHf
 xqkcbkg0RTBhxSMcfbx5jYoVluo8ZF7uA/SWHK1kbXxnljC9Yl38+ApFmBuRVQPOxZZ4
 HufuBgQVCc9fVNYuz8mm5jdBDgDAjzgLuGJ+dNhDi8tQ0yOUl+klAewKDR+eGPl8xKZF
 p6Bc2UstBlf8mazhJpJOs9HzgQd0SZ9+ivDPclFOh+JFtWWl3J3OM9Fq3/Pm8MK2G7XS
 3xCJbe3QQ75LlNkOC1x52o8H3mdloZ36tSmP3b58w4J78TNniHXQcwZvuMXDxI/LUlF3
 VxWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/XwN87jp7sdEZTfgYD8CXahA6rZGvRhIw8sjP29V42nLBkIYDYiqVJt3eHO430ItwOItnlgO1@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJIXLef2toomECEoTVRJAENeBmTTcHCVTy1EO0VwHclQW/0Uu5S
 cmGI2wGycwaw3Nmi1nRQZKnz6DNFpsQX/Y8pjpbYyG6HQYOzIWlTAhs5Tth4BLm0
X-Gm-Gg: AYBFou1CPcGcRG3CKRtaYgxTyt1RxtItuNyNo/1MbVOHetAaKQ+6km62Fq3wLdsjrto
 lUI4s5eLEpk1CVecaBFJCpC4LHPyOOPB0YlKwugyrntsQsfWGDpbpOVO380HLV/wKSm0m0p9fiD
 RxxxQ7lskBPowbdbzJ1IXmTUo90915ZiPxuiCJuzeS0mlgkEoy34PVSucs4A6RS8dJ6ppAYJCr/
 puydaQxxTXdwoNC4NfBhT5YECoGhY4erh22XJFRWB687VB3beCgeEe7B/+IzHXisiOwLF4wuaD0
 EwhJfhoBR4l5CaVvK/KXs6if4lCtIF6Y3KM+7UNZma/TOqx5qabl71hFhU3bA3d4kHTrhrk2pXI
 iG38YQMqAl+8aqntDTT7sVzPzyeoUq+WtcwcCuTDGy1GsTg1622pnl3yCvUG/xb4WA9F6eKBA/0
 I0N+78zlfBXfcPJRzuZHeZAwSwB6gzSmqACpNfpe0xj9W0yid25tra8YN1Tr/zSF0mze1I9p/yz
 oD4RYoQ414oLl2y
X-Received: by 2002:a05:6512:3a87:b0:5bc:b962:ccb2 with SMTP id
 2adb3069b0e04-5bcd074b8f1mr877734e87.63.1791379616009; 
 Wed, 07 Oct 2026 06:26:56 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcd3083558sm32201e87.39.2026.10.07.06.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:26:52 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Yinjie Yao <yinjie.yao@amd.com>,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15/6.1] drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring
Date: Wed,  7 Oct 2026 16:26:46 +0300
Message-ID: <20261007132647.121360-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Oct 2026 07:43:00 +0000
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

From: Yinjie Yao <yinjie.yao@amd.com>

commit 79405e774ede411c6b47ed41c651e40b92de64a2 upstream.

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: 14f43e8f88c5 ("drm/amdgpu: move JPEG2.5 out from VCN2.5")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3216a7f4e2642bda5fd14f57586e835ae9202587)
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-63847

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index f87d0f6ffc93..a094dd138c0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -641,6 +641,7 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
@@ -671,6 +672,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
-- 
2.53.0

