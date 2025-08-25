Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555D8CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 22:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD78E10E03E;
	Mon, 25 Aug 2025 22:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a0R2CNYT";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB9410E03E
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 22:07:36 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3c46686d1e6so3059207f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756159655; x=1756764455; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wBo0v485+Fz5ftE0Njb3DTQ8+bJCyfpUUKGS6XQb9LU=;
 b=a0R2CNYTZDgZ+iD7DnQ3MmPwpPg8yVChy7r2IAIGmX549b6kgNCEMnd7NvKYqMJdMv
 ju4/us3GXBFon5xkG4D3uyxXhFAAMCbr9yNZ4MFsRY52vGzoj92lLuJuWHExm1lo/qE1
 QFrADBwQUQWXOl0PsPMfFVptveYIlvWiY7N702oqRzu2tLZ9+TVU7/JJ8YNZImHjsg6g
 r+WMUFxQk4zgj7GzZTemdLH55q+4I2RkSBGd/ZG3kZ0Ny3BA/wCWFwuIvDVeMLyiITD5
 68c9C4KzjZAWSWQchCf65+LBieOMcZbAxG6pWutFt4OwEZ3XqAdyzxYpnGQAhZ5Vzo8r
 P6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756159655; x=1756764455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wBo0v485+Fz5ftE0Njb3DTQ8+bJCyfpUUKGS6XQb9LU=;
 b=rttS2uhwhLW9ftInn9Z3LVqB8J8r/5+WhOVMxU7brXuBD3M7d+V33mThkCzMDBI/RX
 4k5HntFhZXPVKb7dg5oi7VEoyAGqu428mXIqKeQqfT9/mI00hcGvON+14yrH3E/Adtvg
 fSdUT2ATbUqTU9Fy1p8H3JEg524USPINlrOlGcA0AylieB6AqmILksKOnPRD9K/wo7fG
 cANclGwbs7mO88kOpy6Db+AesK9XKnpiD0oUTYKc3SJHLEBvhpb9AvumKaWpzEIFjEkO
 XNfAmfjyTnBWS8yhlIOXbnG8SqsjJF5w9NYAW76Tkctg9l0x2xePeT4mui70Nr+AxVeh
 au8Q==
X-Gm-Message-State: AOJu0YyOaUd7dGgvvAnduDCXrJcX950tugLXw/2yY/Tto26iY7d20rzm
 I1ZXwt0LLq+qMWvAAXRzW68bSNUfKct+mqf0WtjHqxzoScowgRpefbYHCEARjg==
X-Gm-Gg: ASbGnctV5H8+a2VkkiGGuHK4EvAehAS/ObMEs2ckT1xc2580lvIKjfx/CRn2gMR30FI
 svHIpG9x3P32EDADTbl4zEuyiejbXDz4VZbIe1P+R29aBUU5ED0SidWlXYxwaGkug/isVp8ig/v
 YOnckgiBITFlmGnxbu3naPwo3RmnpuPEmyqGttThYY1G99dFvgMqwG8cK1G5kaOZeMbJN3X4OJc
 yRRjggEdF8ezMGE4p3j2I7Hs/CNIx1dlqzNjjKVc65BnuaCxTZ0O+O+1eEVfJ6l/ICob0EslCLj
 lsi4Rq/Ax2ZyTVfrGXEwkBDJHs3xVm/wPVt1DvL7Jds+2LXeuAt23GXiPMDfQfUX/EwlurRVu7Z
 lqsBz565c6uO8p+HHgj31CQXfRJVPbwnRECH8LhMlClUMNz5r2K+Wd3IV1ZPQ2OMUDu31tCj3UQ
 OEpJuRYVZglclsSAQeG3balM4ecw==
X-Google-Smtp-Source: AGHT+IFcVokaYWzmLZqy8alPXKDn5ftDYowkoyX0lWUmLQBLD2ggCknSgWfFLUjPB5N3CcgpF6uS9Q==
X-Received: by 2002:a05:6000:2509:b0:3cb:424:c3f4 with SMTP id
 ffacd0b85a97d-3cb0424d4d2mr759510f8f.22.1756159654937; 
 Mon, 25 Aug 2025 15:07:34 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66a64023sm1296395e9.1.2025.08.25.15.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:07:34 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/3] Hook up DC to legacy_dpm
Date: Tue, 26 Aug 2025 00:07:29 +0200
Message-ID: <20250825220732.636810-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
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

Hook up DC to legacy DPM. Now SI and KV DPM are aware of power
management related requirements that come from DC, which is
necessary for DC to function correctly on these chips when DPM
is enabled.

Based on the "SI power management fixes (v2)" series.

Background:
The power management code (DPM) needs to be aware of requirements
from the display engine in order to select power states that are
compatible with the display engine being able to interact with the
currently connected displays.
On chips that rely on legacy_dpm (SI and KV), the DPM was not aware
of any requirements from DC because it used a different struct and
was not able to handle the information coming from DC.

Timur Kristóf (3):
  drm/amd/display: Add pixel_clock to amd_pp_display_configuration
  drm/amd/pm: Use pm_display_cfg in legacy DPM
  drm/amd/pm: Remove unneeded legacy DPM related code.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  1 +
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  2 +-
 .../drm/amd/display/dc/dm_services_types.h    |  2 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 87 +++++++++----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 -
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 +-
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  9 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 64 ++++----------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 11 +--
 13 files changed, 70 insertions(+), 123 deletions(-)

-- 
2.50.1
