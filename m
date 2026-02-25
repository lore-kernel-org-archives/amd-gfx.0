Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971D7FCE088
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 13:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 147E510E956;
	Thu, 26 Feb 2026 13:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cQ9bxgce";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C574710E83A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 21:50:31 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so222220b3a.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 13:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772056231; x=1772661031; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g+0HTxMeqTjjKK+AV+/0N3w+kuUR+oo3BRlsZmyUWtc=;
 b=cQ9bxgcea5qu8w+imziWp0UGi1RJ0Uc0i/sK4LlF2A5WVyoRHG3wivhjVaSXgRAZX8
 /eNFB0rrQ2Z0t8fcIGXfldg3XyIvY1feYBrxQBSYY7zhMaUSpiJs48ueNPvKNwE0W3uU
 uC3lGoRXN5/MNxnOc1+CWnU2c5gcMS83898UiFRXxu+66kQd4xn12mzfHp07C4nefSys
 Fp0Hb9DwQZJLgjKyR6F5vvDqN2BqvVGYHyVn8Pjq50eTGxfOULwMeKIz2Kzeh9wn2atv
 QOnFvFzTPmCFdXiKDqEPqrbEndq8yAvwTMYMkjWpPQ6+66n1J00gpP70VM8MFHhS4VeI
 dHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772056231; x=1772661031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+0HTxMeqTjjKK+AV+/0N3w+kuUR+oo3BRlsZmyUWtc=;
 b=n1X0mg9ZnHmOhEtU51V3s7JF+YTJY8hXeymR8bIwNDHAjIRVTHZUVm3qUgQwlw/f9D
 l34twSYu210sKVj3LgdM6BOcmHinlSWLLdQGrrkdMsTfMOjo9vhOi94Cl24aMLkN5oTV
 VZmD7YEnaj+m7/UjozxUpqOArWjGF5hJ8JbytlyLrJt5hfTkwUJJ+XvNRTxe8fgashMO
 ALbSN8snGH63xsfrK6eEULmAT0t2fOiB5bTTFLs+M9OVpTCXb1KxjC/G9a5fdXdfkhDL
 Dw+4uQsS/Nn6uK23qJHDHApPmO0Jw7Te/Rshv2v7ERaVeDIZrDEJXPRYS+WI3Q4aMVuA
 aKLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGQ05Jzaox+IQnX7/SYhwlM4GtrIwIvzgp9EBF0SooR4yGJziadt1wEoqtajCto+MijzESdM4R@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6VYHch7R0mUc47icXxzgW+FCYLfjXikjUPJ7FZKExREtCFBfc
 4yYmYZH6/84spyv61V4vfBzOWAKWC1EGj16DoS82yViGFUoehVtR61ES
X-Gm-Gg: ATEYQzw8QJJxFcfJ58ijz41wAKjNKP/LvU/w+cBKvE6FrfqVjrFkWiuSWccG+L30FXU
 OLePufha1v1Gp9G1ZiAMLLCfE/HgHSCSb3jce7NbXtMAC0HlxjF4s6aJu5KmFYlNxegswp01aFH
 HuobmhXX4IgbhcNDbEPPH/NvGfae6O+2YQCgSnta+8mo2fH9NtEEq69nV4w2qegv9/5eGFU7XWC
 TL9P1w5Mm0VlwiU4+0vQlimOPKWXgyrpRZjR9K4B3QqWJgEaXx831LS6HBgURzhU3+dJnMhH5q8
 8tDdvEM+1hcqhIl/k52SbByJULbXFpALHWabMQHppnZfKG8hWilE8bSVbjVI5J+kgBbnJfpPxmK
 nC3TsRpGmAtBcdWd4kGWlH4i/OGgaZzYsbWcO/HCJ6g76W0LPTkTWAaLQ1WEqRAmVO0MuCU4e0f
 q5Ce/kgXDOMFTYjaqai6MG9I5o+tC7XZrHjBHJvjgq2A8+c2Qmx92BzEwNBMZyKSLv
X-Received: by 2002:a05:6a21:e90:b0:389:8f3f:50d0 with SMTP id
 adf61e73a8af0-395b496d418mr16743637.60.1772056231247; 
 Wed, 25 Feb 2026 13:50:31 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c70fa8059bcsm11990a12.18.2026.02.25.13.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 13:50:30 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kenneth Feng <kenneth.feng@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Hung <alex.hung@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 "chr[]" <chris@rudorff.com>, Sasha Levin <sashal@kernel.org>,
 Wentao Liang <vulab@iscas.ac.cn>,
 amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 and 6.6 0/2] amdgpu: fix panic on old GPUs
Date: Wed, 25 Feb 2026 13:50:11 -0800
Message-ID: <20260225215013.11224-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Feb 2026 13:55:07 +0000
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

Because of incomplete backports to stable kernels, DC ended up breaking
on older GCN 1 GPUs. This patchset adds the missing upstream commits to
at least fix the panic/black screen on boot.

They are applicable to 6.12, 6.6, and 6.1 as those are the currently
supported kernels that 7009e3af0474aca5f64262b3c72fb6e23b232f9b got
backported to.

6.1 needs two extra backports for these two commits to be cherry-picked
cleanly. Those are

96ce96f8773da4814622fd97e5226915a2c30706
d09ef243035b75a6d403ebfeb7e87fa20d7e25c6

Timur Kristóf (2):
  drm/amd/display: Add pixel_clock to amd_pp_display_configuration
  drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)

 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  1 +
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  2 +-
 .../drm/amd/display/dc/dm_services_types.h    |  2 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 67 +++++++++++++++++++
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  2 +
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 +-
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 65 ++++++------------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 11 +--
 10 files changed, 101 insertions(+), 60 deletions(-)

--
2.53.0

