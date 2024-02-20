Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCA2C48BF6
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 08:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE7BA10E65E;
	Wed, 21 Feb 2024 08:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="KPZq/onh";
	dkim-atps=neutral
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D9910E548
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 19:47:32 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-59a8b9b327aso2136801eaf.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 11:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1708458451; x=1709063251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kKavcfBG3gYthrGqVOpoeYHIL94CsI6zaGPhx9ie61o=;
 b=KPZq/onhpIFi33kKBdRsARMi3qXeoxKvwqBsrBNYjfcRH1Wb2P2C8HPCKM/vxjXWO7
 f2E2ivoWqMNYH3f3Nkoz1j1tzILmpi6RVJrQmKsHajgsw+Xf5BAQJJbl7UWEtAAIQ2hl
 yv/uCXAU7M+VUgSrorFAdU3/NmeO+TngovYGwK0fJOcivYQKGUC/WmH5w4jk+cYnX0jF
 L+UeGX3KU4l6gu8I6QOCZgIN0Vi95I1Ne5+Gthujq8hBj2uzq/xt6nB5DXG1TfcTvfIv
 eXVs+lte5gcGrhV2eZ+rN62ffK3lOSIaBTGZeXPOree61CiCC6xzk3tmILsYNqnVjFg6
 e/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708458451; x=1709063251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kKavcfBG3gYthrGqVOpoeYHIL94CsI6zaGPhx9ie61o=;
 b=JcJGg64eF9csA1Im1RMI1/TBUiB4Q5ZBtnrSiMpNePHN1TBIIE1oB1r8vebPoUxBx/
 Avrkicz/WStdclLSXuSwdsXxW+s71nd2rcosXMRVv964HSGQpUD70b+9uvOP2YMVRhFY
 xP0J+BKfmnDuJmgAW68f35ZFTPV4+SIeOcjx+6pMaXqnsypY2RFUW+s+gwxgPlOkzGdN
 9MWzsebvF05q3hhLt7yIhn9/SQKs6Poggvk7egBLEq2tIeiI6Q+yaM1XGQrSW0kIn4bh
 pqRb7NnSz1poOJQzsD2+/TIZoNyX9NGXef9b+nnQOnjvmfgKcSKWakTk3ocp033xwbgI
 gNzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLvPamc1bT1aTSKIiauxzjc8zuD4qmMGxXptXYMRntpmVWNvtWHrnD3v7GqXfvfEjIdRAWHnSkDWtVmzD6buI7p9dmkmSnAVO6mdTJJg==
X-Gm-Message-State: AOJu0YwC0yZVJJoFDQwF8yP27+KFVeRoISnjinul4i7eDI8ZoNhV0NHi
 UUK374/8wpZXKb0eisq6r3QabsIcVeAykI2Gw/cEAE5qc0pLHQOExMokroYJmAY=
X-Google-Smtp-Source: AGHT+IFaxPRYGN4RZZRfBvd1pSE4Ni2wV7jOEJ2+/DGSa0VJSWJ8krniwu+QP83KwkF++aasN5nciw==
X-Received: by 2002:a05:6359:c8c:b0:178:fe3e:1e35 with SMTP id
 go12-20020a0563590c8c00b00178fe3e1e35mr18504857rwb.13.1708458451428; 
 Tue, 20 Feb 2024 11:47:31 -0800 (PST)
Received: from localhost.localdomain ([185.153.176.89])
 by smtp.gmail.com with ESMTPSA id
 u21-20020aa78395000000b006e0ad616be3sm7293482pfm.110.2024.02.20.11.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 11:47:31 -0800 (PST)
From: David Tadokoro <davidbtadokoro@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 daniel@ffwll.ch, harry.wentland@amd.com, Rodrigo.Siqueira@amd.com,
 sunpeng.li@amd.com, Xinhui.Pan@amd.com
Cc: David Tadokoro <davidbtadokoro@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 0/3] drm/amd/display: add prefix to dc/clk_mgr/dcn10 functions
Date: Tue, 20 Feb 2024 16:46:54 -0300
Message-Id: <20240220194657.243378-1-davidbtadokoro@usp.br>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Feb 2024 08:14:29 +0000
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

This patchset has three commits that add prefix to all the functions defined in
dc/clk_mgr/dcn10 that indicate the file that they were defined. Enforcing this
pattern makes filtering results in debug tools like ftrace better.

David Tadokoro (3):
  drm/amd/display: add prefix to rv1_clk_mgr_clk.c function
  drm/amd/display: add prefix to rv1_clk_mgr.c functions
  drm/amd/display: add prefix to rv1_clk_mgr_vbios_smu.c functions

 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    | 24 +++++++++----------
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c        |  2 +-
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  | 14 +++++------
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.h  |  4 ++--
 4 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.39.2

