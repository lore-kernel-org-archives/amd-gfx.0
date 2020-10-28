Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E073BC4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37AC2070E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="U+e7QDXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37AC2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5518E6E81C;
	Wed, 28 Oct 2020 23:52:43 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A3C6E81A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 23:52:41 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id 7so1421440ejm.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+YVhHIklo7cha3kQZKv494B/qPhmmwFXz33tGqkcUE0=;
 b=U+e7QDXCSw/I9LwGOEuhp+php5CIgzf7pm/yWYWJFZ0ugK/Xfptm0yb93CgRJqlBO3
 6SYh7aoihfbBzpZbbGuEvrcE14wQQHmtjgSEr4lXzkFmH964VfJl5Nt2ChJUcOis1ZmH
 xkcXQbezZPr5ercKMT540XqVUPwG3z174g6Z9OJ/rMrIKdM2AnGrqcaE0l8ZqWgJjLe6
 D6BcAHU/uHSOJgYRsg3qSr8QjjHz0FCE4cDhYDRmpeoBTSJuDhsnBqPjKft3agOpQPqv
 qwsVaOf18CGtchVm2bjpCyMckd2pV7xscIbbL4cKyYl8HTQY6qJgAV012qZgHjvWY4xZ
 8ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+YVhHIklo7cha3kQZKv494B/qPhmmwFXz33tGqkcUE0=;
 b=US+Z3YmpM2tRZhKMAW+QkOlK2hUyPPNlij75uEKq//07t7wurIuOScECkF5Za3jHX+
 AvswQPhdpnGGSodwF2daJG6242Ag5mLB4mUDRstXQ6XdWXBGfN0upeEvD2LK4r++axDQ
 /PCMd/nAuqsdHK4VTAmZlLpdHB7Hz/kV4tUW4hwX3CnJ0VQgCqRzORUcmyrqVQTutVcc
 M1A9AIAIBlHxJnoi966KUwEhqyVjRIL2ZbHf+BV4QztgLC4DPKy/0XHejlfa/UVQxrWz
 R34lY+w/oquyBrOYGEuy57iLMYJOS3YMnMbqtyr+jCoFldYtW2U03U3iKa6xWxCFKKiP
 RznQ==
X-Gm-Message-State: AOAM533Mp+5fSQNq+FYt03YoCZmdbDtXQmdP1BDTyVl8xg9Qj6SKWeVE
 iJWmc073AC/XD2dZtuIsVUZZkl0feA17Zw==
X-Google-Smtp-Source: ABdhPJwRmgBEgtccuwfhcHnUgsGUy3otaBCIH7CgNaQc09yMgSZzEoyUksdRAncc3hETH+9NcK+Sjw==
X-Received: by 2002:a17:906:171a:: with SMTP id
 c26mr1570475eje.380.1603929160294; 
 Wed, 28 Oct 2020 16:52:40 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id o13sm479174ejr.120.2020.10.28.16.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 16:52:39 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 01/11] drm/amd/display: Do not silently accept DCC for
 multiplane formats.
Date: Thu, 29 Oct 2020 00:52:31 +0100
Message-Id: <20201028235241.3299-2-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028235241.3299-1-bas@basnieuwenhuizen.nl>
References: <20201028235241.3299-1-bas@basnieuwenhuizen.nl>
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
Cc: alexdeucher@gmail.com, Alex Deucher <alexander.deucher@amd.com>,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Silently accepting it could result in corruption.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2713caac4f2a..73987fdb6a09 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3908,7 +3908,7 @@ fill_plane_dcc_attributes(struct amdgpu_device *adev,
 		return 0;
 
 	if (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
-		return 0;
+		return -EINVAL;
 
 	if (!dc->cap_funcs.get_dcc_compression_cap)
 		return -EINVAL;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
