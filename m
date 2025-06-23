Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C89FC77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 08:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5DAE10E517;
	Tue, 24 Jun 2025 08:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W2zEcxAa";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5024110E430
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:49:29 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-553bcf41440so4782605e87.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750697367; x=1751302167; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xw5fgUlYCzuWQShMydsoGvu+L3uBmSPFwBeprXNUxNw=;
 b=W2zEcxAabVaZhcWZer5MrNpqw8cXUj+Bf9OsDiQpLqWU6o2tY3yicmPP95/Y5odF5p
 Yuk5szKdTZtnKNNzC+OFQbpksfBeaum548yh5y4KXTzAwrnVK9pi/aVPDeogmvoUJd1/
 lYNx3wAAh8S31KJD1lT7d3MGMdMSmDVxPYeTI29cALzHDAPkvMPR14UJLyeF/cLIzqio
 0hiJh++gXB2tkE6MqaNSutte5cV2N3NMpSoPgNhIPY+6xoYyoSfWyBl3giQjGsNUZlY7
 vji3vUZi4jXWz5K9KOA5YvldR84U+JvppO4pI7OQfcNzpdj9RV0f+E37qatSBLrSBa7B
 dWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750697367; x=1751302167;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xw5fgUlYCzuWQShMydsoGvu+L3uBmSPFwBeprXNUxNw=;
 b=BiWWgaSbojlZkbAmlCWUXoAOqMrYwV3hhMO9OwYnzzgRYy4UCwaQW5zwzX1EIQCQLT
 gXShk6HaG4/yMDtPeKWXDR7YjzDu4kduMU9dK0XwLWexpCrve3DwEkb6IobFlMRou5GA
 d3xeicXpkn/onT1eZDTkHinylbivMSNDZW+Ci9idsDw6EzRVC5fMpZepGGMxjWTtuuT0
 jT/PguIL/E4IUW1MUjMF2O5SDQr/4LCVkznGJR63WUg06a3+VV4i+A+chNlEvYFQG5ZG
 cQd0Uun4Vwzh4W2Eot/1Iy/HXrX72zZEKeX0TcOQNB49mJoNi4zj39lMyj+eU7nFZanw
 NI3w==
X-Gm-Message-State: AOJu0YwrRSH8wswe/f3XoKw9vSu4fdXB+4uxNB2+QAMirQ++iDlTOp06
 aRipkZTNkMgNh4/reTkiraj2FRk43bHlMg9MDEyExuzT5ihmKNnLTU6PslqekywPM7EnSFdLhxt
 9kc9X/OvLTDL/jo+M/s2kmicYv+i7GUs=
X-Gm-Gg: ASbGnctlt/uBNqB1Vu6ZnAZvFd99DdSURglhE6WFzlZ6kV/wG8sUXOnOz6usdC/9OZ+
 o5cHIi9mj/XVhzFgGclY+oX2lc8KYl3z6Le8O37aEmxZ5SMsvJgZNNoe8M/PqW+uXsK8lvOA1Ai
 efAjqujEggn5jLwoaBjFwU8VVmsi6dk/eIx91dVajR0WoKhA0bRZbWBy1nKFbqHiQCXZYZbhq5e
 asw9drP74xgc4g=
X-Google-Smtp-Source: AGHT+IGI5qQg6x//9IH4v7r0ZJr6BYdhZy+SJZ1waHU4VFizK0ZyrCfH2jNrWTd3cGXjiGvEffyR7QdTyVr0/mCgsVo=
X-Received: by 2002:a05:6512:3b24:b0:553:aadd:1987 with SMTP id
 2adb3069b0e04-553e3bea921mr3830461e87.30.1750697367032; Mon, 23 Jun 2025
 09:49:27 -0700 (PDT)
MIME-Version: 1.0
From: Marcus Seyfarth <m.seyfarth@gmail.com>
Date: Mon, 23 Jun 2025 18:49:16 +0200
X-Gm-Features: Ac12FXxaT-f23KSNG-OzM13KrEpN-mBAa34_O_DkrZ1ijLaTRtiVtbPMhljfuNE
Message-ID: <CA+FbhJO5rzT0T8uWM+mtVqAVx4qiY3G3nfaHmSL-jb01GmwEuQ@mail.gmail.com>
Subject: [PATCH] drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value
To: mario.limonciello@amd.com
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 24 Jun 2025 08:17:27 +0000
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

Just FYI, using Clang-21git, I see this new warning with the current patch:

drivers/gpu/drm/amd/amdgpu/atombios_encoders.c:131:11: warning:
implicit conversion from 'int' to 'u8' (aka 'unsigned char') changes
value from 65535 to 255 [-Wconstant-conversion]
 131 |                 level = AMDGPU_MAX_BL_LEVEL;
     |                       ~ ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h:438:29: note: expanded from
macro 'AMDGPU_MAX_BL_LEVEL'
 438 | #define AMDGPU_MAX_BL_LEVEL 0xFFFF
     |                             ^~~~~~
1 warning generated.
