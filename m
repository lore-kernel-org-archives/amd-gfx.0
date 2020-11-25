Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D253C56201
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 16:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3188B2067C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 16:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdY4aG2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3188B2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811A46EA19;
	Wed, 25 Nov 2020 16:21:47 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 105566EA19
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 16:21:45 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id y11so1168855qvu.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4Ao9LznfbiXgo/rhyXK+EEa+W+dJtro962dE4HdBREE=;
 b=AdY4aG2vKPwffsKYBl51qhCNUzIseaNbrTshNjh8Nr6W59pNyM43piPDDbsx2a9U3L
 SxI4Gsz85+N3/AFI36qaI86DB+pn/XRCa2v2i1axr+TJuvQlWMmy823+MfTBd8YULuM5
 wFqlAbGuNY8pKXsiuc9JwAPcoqWqo8SV8XJEA1xM7KCTa7+3wLUkU05V8wJnT6xXGsXq
 D7Z4/qG422P0OduofKSyNlWryBTNnf+m4qzyrlL9MHqMzArlI3VH5bxZEUP1pG8VmIBJ
 ruINQ1bK818J0piw6ZIJomYRPJhkRg0vW6PCFNy9xTBsoq8bhWhn5BLY9SSOPCGlgM3j
 tE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4Ao9LznfbiXgo/rhyXK+EEa+W+dJtro962dE4HdBREE=;
 b=tRwrssgju2KVkIJVR8Lf+peGyosX8KPwdBvvuNEnlN9YfEidzgUIM4fL6Ahi5nv3A6
 WptzcdJ7XUA8VrAZ4mw3e28ChhZKl4QNjoeI8koLVDt6+eRiKrpPJDnGdfz5kqfYbLTE
 UuuU+qD1oHVDQmi+9YNdcpT5Aiaoh43tzN1Qg5S2zKHWhFmnDca4OFnJ8Dvpbd1bCOQu
 xiI9EmB0ACxecxHBHo/bWfhHpWf1rIK9MhgA7pz2AMJnjoyp+cujJpe5Hqw0Cqf5SEnZ
 1kncp+ExtGg6a26AFeOP6/9UbmkaBB1A7joD5vcPn2OYLmyJHPZRl2AMFoCLuDGmyQhA
 CA5A==
X-Gm-Message-State: AOAM532DgoVEjpbszFZOBtOdFTr+dWUuB6k/+RyWkJyb22jYSnqk1aNt
 9WEg02qdWoOeNpQ2FMyX65Z+ZkOXLjo=
X-Google-Smtp-Source: ABdhPJwbZGt2BUK8yqEH0sHuIddjafzJJvCtD/1kEC86FIz1CnC09DjZfA543z9PXGteAgnVwrQrYw==
X-Received: by 2002:a0c:9e20:: with SMTP id p32mr4274376qve.44.1606321303993; 
 Wed, 25 Nov 2020 08:21:43 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id u24sm3093367qtb.33.2020.11.25.08.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 08:21:43 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: Enable GPU reset for vangogh
Date: Wed, 25 Nov 2020 11:21:32 -0500
Message-Id: <20201125162132.237264-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201125162132.237264-1-alexander.deucher@amd.com>
References: <20201125162132.237264-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable GPU reset when we encounter a hang.

Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 79dd85f71fab..355fa0057c26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4189,6 +4189,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_NAVI14:
 		case CHIP_NAVI12:
 		case CHIP_SIENNA_CICHLID:
+		case CHIP_VANGOGH:
 			break;
 		default:
 			goto disabled;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
