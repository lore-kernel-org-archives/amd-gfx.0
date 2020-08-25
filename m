Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB84FC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 13:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CCB20738
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 13:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoN/hWT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CCB20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 136DC6E93E;
	Tue, 25 Aug 2020 13:45:32 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED676E934
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 13:45:31 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id s16so8935745qtn.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cYzKvfn7CXi0IUyvZ9LVQmlxm+kuRB6LEjwtRPD5Ipw=;
 b=IoN/hWT41Cieo7Zr6Rk7bCtZB8+CmDQzTEQ0jIAXu1XyfcCKaHeMk4IK50M7p8AVp2
 Qw0/7LjKhnp6fcqF17/9jMaro93fXZYVuF+CEY8vPEufZ/k3NtTkcaFxVt+UbDZvpvYr
 g5LuewI6D0vQMRdMLLSTgTuW0bzMFBDclLpgyHZAPmJAz/QRSueuJr7OAaEnHlmym+/e
 rz8I0CH7Xbhz4FmIKh7KLOMvhnXl4raa/s7K8rdHEemfsIal71D95dZ0bKQqI80kg1tn
 zPnttrN1mWoFfXnCpPw513CWra7p0hF35hpkGeTkEzqlZSJtdOCL4GR4AgEFAzOyR2dn
 S5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cYzKvfn7CXi0IUyvZ9LVQmlxm+kuRB6LEjwtRPD5Ipw=;
 b=RYiDQ3WSLGNLQueT03EDLXOZZJk6pNCssdXfnGPYygqNkYn72RRxewh8GjiodT/kKN
 YHmyXhXlinmbZRC8FVsWmzKQPWTcB3OOA99dX/IWCSznUeiqqaCwhcEkDa/5ERwkCMu3
 604JZP/Ufk07Aw6cqVmZXJIs4P1PvaHRCSUGlyWlUDcGltG/FtXZdrOuv3wIE8yLSodC
 8nfg5uEABKmPlTekhUT6dwoIf6NIgKztveEfY5a6oZV4UYKEhYFPjzG3gmPnx+8zng4F
 5aJxJivUTglDN+ALk3Zln7ioj0xiGN2ouEyb3FK9LWJe1biAPZ1DkXeb1K4ysj0qBrgL
 9AAw==
X-Gm-Message-State: AOAM530Awb81WPqSTwlg0htLNEvRo01Uj1adEXMWmv3MY2puJPqB73IE
 Ve1mgNat51ORK/l8mHXLK9IUMVJRKJM=
X-Google-Smtp-Source: ABdhPJyQ8C+gaQP+PgZkiIYrdgTBR0ye2LB/EPeMUb64NV8YeAbmyg/5vExLX8wgsNLV1BZFfNHRsQ==
X-Received: by 2002:aed:3c66:: with SMTP id u35mr9754455qte.272.1598363130131; 
 Tue, 25 Aug 2020 06:45:30 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id p26sm11870330qkm.23.2020.08.25.06.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 06:45:29 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: report DC not supported if virtual display is
 enabled
Date: Tue, 25 Aug 2020 09:45:15 -0400
Message-Id: <20200825134515.278350-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

virtual display is non-atomic so report false to avoid checking
atomic state and other atomic things at runtime.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5a948edcc93c..19f1e8449986 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2864,6 +2864,9 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return false;
 
+	if (adev->enable_virtual_display)
+		return false;
+
 	return amdgpu_device_asic_has_dc_support(adev->asic_type);
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
