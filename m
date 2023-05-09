Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FCDC7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 16:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2317110E39C;
	Tue,  9 May 2023 16:52:30 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D2D10E39C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 16:52:29 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-965aa9d1d19so170457966b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 May 2023 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1683651147; x=1686243147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8C6kI3O8xJ4OMDBXMXJHiolbzb7+spDbFFSs8vfTZI=;
 b=Q+TjRvaJyVbSCqV85WTwPRbVKeoYtAQtHV6v42tDbetID8k5156VT/4epB9bBEHY4J
 mnbk/QnSCQfxxUyb/aTfkUB/Kwvesg/P9d/9xb/6G/uqEaZ0TQPllGMnX573v8X7cbyG
 6+xwzgg8EFrnnh0ISuPJKelUAgUAtefCO3PLHoeYlGqWWmcEueoAszXbm3v4ozxcH+Fd
 jWV9/toGrC0jFLSEoVchCXVmQ3AtESscdzrLlbOhG6/iMPhtx6HYaKOLSNJcZiyLWfan
 7Ev4SZOiqSVIBjAtJ4QoPDtFtvXjcdozyF+yJ5IQneq66DSffQz7bwVYFV1fiuyeUVTF
 exFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683651147; x=1686243147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8C6kI3O8xJ4OMDBXMXJHiolbzb7+spDbFFSs8vfTZI=;
 b=OUnl5Q2FVofujPKNqQ7wT4IPTu+748y9qRk7KMVU0x7oFGxVLU81Paz84htPhTWzD6
 iBS/OP95wQnpv8TzWbOHrOQoQ+wjMAQZSBY/pcR8tnzuSoSpDvlefQTU7m0GRR7rI9iD
 5+o9auMyhJi2G8ICGSgCsoyu3uhFZl2UJyJLb+LdYKi8kFvA5LimSi4nmy8zWKAQhS19
 FHkwEi4bpI8IJHP3p7Phrj/Oh5oJ930ZiK8kXLOiGSe4WKirj+5I3noMCwV+yoUzFnDT
 0BSohxTbSJwRHdHHHPxePTGX0OAYEUjXL+jMIFcLYnlg3y6K+ubOrqc8RqeXWQeGVuL+
 1FQA==
X-Gm-Message-State: AC+VfDzVHlMoBsG8SmtvckaBLdf27rowRkhVcV5caPjXUBE3Bxfq+V3C
 nUKBPvE0PM0HGOgzFbkTgaaIju49TJiF1Kcr66I=
X-Google-Smtp-Source: ACHHUZ7UHieBpcGaYR6cmBR+quqtacxaDEQcDwTrb+BuI9TguC3R4YbZdsCB3QiHdaMxnrnZObT9qg==
X-Received: by 2002:a17:906:2d2:b0:965:9c7d:df92 with SMTP id
 18-20020a17090602d200b009659c7ddf92mr12742354ejk.2.1683651146716; 
 Tue, 09 May 2023 09:52:26 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a781:180::a8])
 by smtp.gmail.com with ESMTPSA id
 tk13-20020a170907c28d00b0094f185d82dcsm1521337ejc.21.2023.05.09.09.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 May 2023 09:52:26 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/gfx11: Adjust gfxoff before powergating on
 gfx11 as well
Date: Tue,  9 May 2023 18:49:47 +0200
Message-Id: <20230509164947.455753-2-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509164947.455753-1-bas@basnieuwenhuizen.nl>
References: <20230509164947.455753-1-bas@basnieuwenhuizen.nl>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>

(Bas: speculative change to mirror gfx10/gfx9)

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f09e2558e73b..3585edd07db5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5084,8 +5084,14 @@ static int gfx_v11_0_set_powergating_state(void *handle,
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
+		if (!enable)
+			amdgpu_gfx_off_ctrl(adev, false);
+
 		gfx_v11_cntl_pg(adev, enable);
-		amdgpu_gfx_off_ctrl(adev, enable);
+
+		if (enable)
+			amdgpu_gfx_off_ctrl(adev, true);
+
 		break;
 	default:
 		break;
-- 
2.40.1

