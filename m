Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17302CDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 14:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D1D10E122;
	Tue, 17 Oct 2023 14:01:41 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADABA10E122
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 14:01:39 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507c188c529so188947e87.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1697551297; x=1698156097;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sVXCnESVi6yIaR3wvDcjKCyG9I43Pvn876LU89XVxLg=;
 b=PjlqB8PVeG6PkbXu89squknu2nlOsjFASjkFhG6Sbt49yF6GHQnNfYrhIevoGjP3UO
 njeknhtFwbHlK7b9ux/4YEMgk7Qg+ClbmfM35doXDjeDFllgMC6YceYZiJuxgDEBhZ1c
 JOv0IIwNywvWKCbT7ekbY9UlZ+FIibbhnSwL2/T90NvLX5sqD3zJszipm0f+CricqYSJ
 Py+xbRmR37hsSg2x8yV9KXL4XwgUea/TRAtdGrFEWlF+pvGKuVQ0b+bsYKdQQ3/9WmfA
 6SvlXcOo/BgcSHTiu1MgKwR6PnuuhPfwYOepjLge9w6WaxB89KlWXmxRMYk8pN1Innsb
 gksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551297; x=1698156097;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sVXCnESVi6yIaR3wvDcjKCyG9I43Pvn876LU89XVxLg=;
 b=hxrEE7Y1hfQzTgW0EdPxuYapvX8DW5mLKazurgFHR39BSF8engViCnAbq43hozZAy/
 MDixDeXZuEfbdELAJ55/nnK1G3FOABETH1qVmZPgvS9YRTOPFv88GSasAUydPhoBI8/G
 CRhrGqJDl9i2gdgAlYAMwBqYPMCxGq1KT++/aU7KvckGnuIKflaJTBbH9l4sBZpw6dyK
 6c7tw8CxCOnZnDII5QUqlnm9/8o4qfDzHGt8OMY0t4/cMgwLLKIjFs5TGasLq9lEWU9/
 hUvt4NS0DXv6cmQfaMsl2Btx9ePF2sCxDgNoyblNAwETfjMI4mVferU0bkWHcZ1C8ASU
 awwQ==
X-Gm-Message-State: AOJu0YzFkfMPs3pmY2SAGThq+jpXpCxra+RBhBSDKT3/4wCJxq1Gz1Lu
 /k/BesqIkr3NEfFzOiHf5btgOmqRzlwXK6nFNm9c6A==
X-Google-Smtp-Source: AGHT+IGkVQJBaWNhpc7ZcKAQMuw69SsFCvPvZTczEMnaEXVneH2xmq+U1MjubhquR2tP9arZH04psQ==
X-Received: by 2002:a2e:b5ad:0:b0:2c5:36e:31bf with SMTP id
 f13-20020a2eb5ad000000b002c5036e31bfmr1404911ljn.5.1697551296497; 
 Tue, 17 Oct 2023 07:01:36 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a77e:6d00::d7])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c024100b003fee8793911sm1949566wmj.44.2023.10.17.07.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:01:35 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: Handle non-terminated overdrive commands.
Date: Tue, 17 Oct 2023 16:01:35 +0200
Message-ID: <20231017140135.1122153-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.42.0
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
Cc: alexander.deucher@amd.com, Rex.Zhu@amd.com, stable@vger.kernel.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The incoming strings might not be terminated by a newline
or a 0.

(found while testing a program that just wrote the string
 itself, causing a crash)

Cc: stable@vger.kernel.org
Fixes: e3933f26b657 ("drm/amd/pp: Add edit/commit/show OD clock/voltage support in sysfs")
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index da0da03569e8..f9c9eba1a815 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -760,7 +760,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	if (count > 127)
+	if (count > 127 || count == 0)
 		return -EINVAL;
 
 	if (*buf == 's')
@@ -780,7 +780,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	else
 		return -EINVAL;
 
-	memcpy(buf_cpy, buf, count+1);
+	memcpy(buf_cpy, buf, count);
+	buf_cpy[count] = 0;
 
 	tmp_str = buf_cpy;
 
@@ -797,6 +798,9 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 			return -EINVAL;
 		parameter_size++;
 
+		if (!tmp_str)
+			break;
+
 		while (isspace(*tmp_str))
 			tmp_str++;
 	}
-- 
2.42.0

