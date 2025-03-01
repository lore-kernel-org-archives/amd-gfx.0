Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21927C282CD
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Mar 2025 04:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 074AA10E117;
	Sat,  1 Mar 2025 04:11:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EE9JYe/x";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2EFC10E100
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Mar 2025 04:11:38 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c0848d475cso372081685a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 20:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740802298; x=1741407098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=seUwH40WaRbj6iz+8R54vZN9nY7fJP0/pRwiCMysjMU=;
 b=EE9JYe/x7vx6tKX1noateCbjHGYzoraY8Q8yQpld4jSQZ/Ybftt/iQjOkbF/y0YU3w
 itXVGPL+hAeppkxmJF1fkBuvWvTWz/cY7cv9snLn2vRiO0Z5czkivxLxIQ8DlMOc6+BG
 DINGapmLY4AMp8ExlidR2Jc9rJOHZQbJ65JCLLCJ0lf3Ak+TAFS9n1e+OHQxdlmI0Qjx
 BiFG0TfId70K6lwY6VyIgM4r+diXfVV4vaUUDjPNa2oHmzpprPI5CQRU29MV9OZk6Aqy
 D5zYbeWdyUE1ze8h6bYhkgMgckmOK0zyF+B/8cqsnoswbYAGhT7SxK31PswdxUTEjEF0
 LH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740802298; x=1741407098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=seUwH40WaRbj6iz+8R54vZN9nY7fJP0/pRwiCMysjMU=;
 b=KucRtpVhGeW6sZMEPYtHLFIwQc/5wiwp3nEEG2ooShUijjTJvHVBw8ujVX/Kw88VB2
 sN0LMXIni22y7Lvvc/M4PJFeUuz22A475mYW1TQeHTF0jXSeTMJXhvXeSVIakiSzhJ8v
 JtS9KiY0sKJxSQ74zrv4rWAhtfQg0uitDTvmV3rCL+aYWRbhDzjxja4NsKdy34ehicVh
 p3U8fJ2RyshqF06IWm1Yb8a1mhtTMt2rFwUxEKe7f1djcxuDWh0SIF5C0B7qj0xdNQh5
 PpqBOkqC11ti4sYwb0CNlpi08fyBSuQrEnrRBm6TwtyH9K/Kp9dh+tqgl1Ecu48o8xxY
 YE4Q==
X-Gm-Message-State: AOJu0YydVqwOtM63j1NMaGetvMnBT+0tYwqlf/QCxScl1JWj5WaWamHF
 kVJ5Cp0KALaePUrs7uwirN4SV02x7oR6Se94NaLTAU9pwe8QJSXjXGrcLQ==
X-Gm-Gg: ASbGncsTyva6XdEnzLwzsX3S86pzUiLnEdhpg5Zw26KkkGNJ/FAgObBiDRlP/QD+5uT
 bcy0U5eV62JghRiipv7s2yH4QKMObBpSG0i7UZ2c52R4rcOBXtftml21qKw4Cvhq+zNk431s4Cv
 Qej4mkbiPMAhNLSTgAWJlmh0ltaSgMl8uAtlZoK/FapAyr90/9l49G0C3Tk/cAFsAxA8xMP7LAK
 Cb+l+deqHjPsEndd7gKywyQx3IvwwWbvZlrEabadEaVjVEbrV0MUCijKAhbmy7EGIie9iErTHj6
 kAMBf6JpKnQHAkc5Ybve6kSxlEfHnp+R+qtRZ2KuwwUJhG7TOQCGGvObvUlKiiz60xQ=
X-Google-Smtp-Source: AGHT+IH7JQxKkV1IJdFX+nroaTyo+Vyz6sWDl5c5GwCMSkmV+ZvVHdxyd/6X2s9aVD3Dp1LjYFTfYQ==
X-Received: by 2002:a05:620a:1a1c:b0:7c0:a89a:2171 with SMTP id
 af79cd13be357-7c39c4d16e6mr749845085a.34.1740802297617; 
 Fri, 28 Feb 2025 20:11:37 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c36ff0f386sm327973085a.60.2025.02.28.20.11.36
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 20:11:37 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 0/2] drm/amdgpu: add empty functions
Date: Fri, 28 Feb 2025 23:11:19 -0500
Message-ID: <20250301041121.9661-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Third set of split patchset.
Add to DCE6
dce_v6_0_soft_reset() 
dce_v6_0_set_crtc_vline_interrupt_state() to DCE6

Alexandre Demers (2):
  drm/amdgpu: add dce_v6_0_soft_reset() to DCE6
  drm/amdgpu: complete dce_v6_0_set_crtc_vline_interrupt_state() in DCE6

 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 97 ++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

-- 
2.48.1

