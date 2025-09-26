Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472D1CAC5BB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5AD710EACE;
	Fri, 26 Sep 2025 18:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sbdl0DHi";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB8510EACE
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:26:37 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-78104c8cbb4so2413873b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758911197; x=1759515997; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfhR/97/waanrF0HF84NdT5YOwwiKq6dSNuUeP0Yp0Y=;
 b=Sbdl0DHiy9Gdi3lL4tMDDRb+Ywm1Sh+CHoW22ZSwRAcA3EolePKNDnCF9hw0NcvjBK
 XUxg5a0ceqnf6zCw+tgBG9KNa6nsRpoMHQXr5j5JK5BWYG3rlmWgk0mirSCPDyKx4JFM
 3wBWqDKqgEx4c8EdS63cjhlMKaEW87hKQkuRACNFJOYKMuJ4BHJzin7vTc2Txls57pJI
 Zqq46b9zQjJmwTgOB5oa+XyB5Rd2CBAanMwFtojjC3r0d+1jpWARxbAhg2y3I7afX6M8
 q9adg2FClEfYbS120gnQiq0M6mJvah51Y1klwv2xWdoDVGZNc9mtBMm2I79TTW8/0CuM
 aIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758911197; x=1759515997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LfhR/97/waanrF0HF84NdT5YOwwiKq6dSNuUeP0Yp0Y=;
 b=sk/D4Vqh5GV+f75r/2cUzld3ralggJ9ldcrVAdS5SEPTHhPWwdw53ADVE8Xxnnam8Y
 FI2VTJ/yAow9VMqNrTIUUtKJtlUVjLR6FhBdxRXPOuDjNFPxJxbpqwWifZ74xCYwsqcK
 VZqKI1QdHpC2HLT9JnmaZjbczkXEZvGJAKeTRFlTQ3VpnpsXQDpw6Ahen6nQfVuY4aZ2
 xnLk2lqAAzh6+9Crr6MUYJGoTm0fh6l7owXIh58IudwNX/++ggikIs71KeAI4OuaBp9Q
 yJ7L39xKvzu1big7ChYsOaB3w7h0kRIPQCcX92ALQ50bs3cnMSy78+aHtsl9bkfmg4Cs
 PndA==
X-Gm-Message-State: AOJu0YynrGFXd6GvpH47aDCx3iFA5u2e/1CvhTLHj7L6WWJfdJ7tq0dL
 EMvWmb/dPyFlzACuBc+I9Xsn0PmMEGdS1YFQd4O8fD4dlySFLaY0SFhGag8wgSGO
X-Gm-Gg: ASbGnctYYsdHzWTmLhDRBmkS9iyNRzbuPLJnEm0F115g4ZviXvZ2YFMzX5WU+CktZbG
 PL/legOtI1DE8dEuPrLR0969WyybYgV9oyAvKio1F7lzSWqgFuwQvAiNNa1TNZlyjHrE5qy2Uu0
 8W+d0q4vbeBRlS4nTNu1cKL3oOXnUPBIKzNBwu65HstnTT1+dOwmWWHvyZ/jHErwaYjj5Rn9AO9
 ffkfeb+Wq1xLf++SEZD3zc7DAIic6wRcAGSdSv72izd2lgf3taXN5y2UADqJdQb205jQLx+hc5R
 dvbCFhz+uUG8Vhwr8RQGfJlRHThTLu8LSW2C+/K1pCJPC3YwaHsYbwFBzXxgRzQi+RySipJ/UiF
 k57mfzSyzcYmD7dV+jkUoXT32A/SzRRH7K7bqvYx/2g7dG1oN8ZA9GYn5BXZpUAHg6Q5wWsFITm
 ETNz9rpLqeZWDm0YtJneg=
X-Google-Smtp-Source: AGHT+IG4LTmFFBEIxqYGdatxjmU/cyStadxxCXsn/Gntnsl471bxVU3b33/Hz8prveVQlTT9pnXZOQ==
X-Received: by 2002:a05:6a20:728f:b0:2fa:26fb:4a5c with SMTP id
 adf61e73a8af0-2fa2729122emr2644175637.59.1758911196670; 
 Fri, 26 Sep 2025 11:26:36 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb255sm5352131a12.5.2025.09.26.11.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:26:36 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/3] drm/amd: Disable ASPM on SI
Date: Fri, 26 Sep 2025 20:26:13 +0200
Message-ID: <20250926182614.26629-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926182614.26629-1-timur.kristof@gmail.com>
References: <20250926182614.26629-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Enabling ASPM causes randoms hangs on Tahiti and Oland on Zen4.
It's unclear if this is a platform-specific or GPU-specific issue.
Disable ASPM on SI for the time being.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a77000c2e0bb..279b6912be2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1882,6 +1882,13 @@ static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device
 
 static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
 {
+	/* Enabling ASPM causes randoms hangs on Tahiti and Oland on Zen4.
+	 * It's unclear if this is a platform-specific or GPU-specific issue.
+	 * Disable ASPM on SI for the time being.
+	 */
+	if (adev->family == AMDGPU_FAMILY_SI)
+		return true;
+
 #if IS_ENABLED(CONFIG_X86)
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
-- 
2.51.0

