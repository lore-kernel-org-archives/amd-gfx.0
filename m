Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6995BD2ECE6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 20:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE4B10E514;
	Mon, 19 Jan 2026 20:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KIO9BJiL";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C8B110E511
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 20:36:36 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-64b9d01e473so7856568a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768854995; x=1769459795; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HImTu9Z3oRMm/WXrZCUZO82RISkApDdvuK2xPqIvNhI=;
 b=KIO9BJiLClCr0rWLnNPCkD93+fJQHlWyhlJC0JFCypbG5ZoNdm7uWQVKzAta9q3aa0
 2ULEKoVCoXOFhRYEMXG99qVZWDFCIgF/oKb0PoJkPqn+5zwxbJ8WSCb8qUQ1wV17wBnW
 dV67puCSiNhEUDQmKsrZ0iwU2XuAJOrLU4xPNnCNM2r73tTCOaNfiVM0sqNqp9N150+j
 VIB1KplWucHM4r2viXNGW1Y/G80DuqtGXfTv3xK0al3YDIoEeM94qTdUH1ih6jkxcvTd
 wyMEmMj9h5GjTK+4lY4hhpU8SNrv7p9Xxr7tuGyi153KOqVsLhW6I41Cw3LfNgWUGMI3
 9R6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768854995; x=1769459795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HImTu9Z3oRMm/WXrZCUZO82RISkApDdvuK2xPqIvNhI=;
 b=mTBrLwrMiwcEUrZpnokQsTqzd2b1uptRmz7BQYRuq/fQVuGzu1SVl4j9awmedCs9p+
 Y0pALS8e6b6sy/Wwry/3sFtS8EDlU/uB8jqSxbwk0BWhoKNNSD1/45JgEI0uet9/uV8j
 z8k9dgZForcpqeVVuBtxEFCHWABbk8NXArHihzvU66eQ9DsuLbgBnS7PnRAnDjJVjKDb
 CsAl3JB3skppGC+soq0wze4dG92XJiDzgeRPj8FmMClhc9NKQUlP+h2XKOB14WOp5u68
 TZxad24MSlH/QngDLiTnw4K23fOKMDC6Mqlnon7eTo/1ooMQXAUs+GFKs2e30j0qMcU6
 Rl7A==
X-Gm-Message-State: AOJu0YzkxYFw+LmlTpzqUwubqXYPWqKlrdIzq7QNwZJ5iKOyPo0u3OOA
 3QU2wgSycboH++wDMvXBa/7rfM2dML6NmrB33+YQ0W8ytAuJRSOWGxscJLteCw==
X-Gm-Gg: AZuq6aKZGH0zbqsBwsTZ83/MvRbs5Hh7XTySv2J7HrBerywEHhz8U/BMHu0/+oTmf2x
 Iw33T+ABasQRXkTeixyGniiXNG7h3DFCl4mq/UDzAWZwHFbg+xkOZsRzb4PnrCRlaQrH3QebzRk
 gJ0KQCyVJuVm0G0hCekZSsl4TIiqO3pOc5RTtkWKHCROH0X77xkRSufZfq3AGnjckNtcK2Y4I8t
 6Lv9FwAGLYw2KISkFYSK82iqin+lwHWvKw+IvrOYhx6upkkvIuZJ/vEBgyLUXK1GvCc82KcjJ1U
 jUhj6T9oj1tzYeICZTB7vd7AUntRZnYd/u4sygyzQ0pAJFmaBODxhFz22KbsBn0STbD7fCh+k7n
 MigCBlae5bgJdtCMasZQpwJa92Oq5Z0IUG9cKXVnqNJxguSUpZMzct5dsuF+vI9K5sCM/TU35xC
 Llj0SvWUkhsXGR3RjbHy+Brhv+w4U8tfG1Uv7qYdM1RRM/hL69IvkoxTB+gSTDJPQBUbAi2PCZ0
 3m1Bpy8fFx6
X-Received: by 2002:a05:6402:5113:b0:64d:2920:ef17 with SMTP id
 4fb4d7f45d1cf-65452bcebebmr10131493a12.28.1768854994972; 
 Mon, 19 Jan 2026 12:36:34 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452bce213sm11375492a12.2.2026.01.19.12.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 12:36:34 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/5] drm/amd/pm: Return -EOPNOTSUPP when can't read power limit
Date: Mon, 19 Jan 2026 21:36:25 +0100
Message-ID: <20260119203626.16070-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119203626.16070-1-timur.kristof@gmail.com>
References: <20260119203626.16070-1-timur.kristof@gmail.com>
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

So that hwmon_attributes_visible() will see that the power2_cap
attributes should not be visible on GPUs that don't support
the get_power_limit() function.

This fixes an error when running the "sensors" command on SI.

Fixes: f9005c8896f8 ("drm/amd/pm: Expose ppt1 limit for gc_v9_5_0")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index b27e4c2e550f..4214f7314963 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1569,7 +1569,7 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
 	int ret = 0;
 
 	if (!pp_funcs->get_power_limit)
-		return -ENODATA;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_power_limit(adev->powerplay.pp_handle,
-- 
2.52.0

