Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE7EC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 13:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B27110EECD;
	Wed, 29 May 2024 13:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="EvN9Cct9";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B031410E045
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 13:10:50 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-6f4ed9dc7beso607833b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1716901850; x=1717506650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N4tw5Zk4wf6z5pZ1c7E5nJ8v49b+H89ox9BNVmWVrgc=;
 b=EvN9Cct9BFBpY6Ridwh81XDow6SPDVf00TQtBDuqpCHTfcaFr8WHgjP0bMA8GXEuqE
 fZZWUoXpPOWY8PHug8XRQwc71jC7s7yoqKDbCz8M3EBCbQmVfPBxZMIkxSUBITOYQZMC
 3+gChVH2Zx99g74H7Rcr5ZuLs1J/s/WHqWIn8F/YUJ8f38RSVuQYQhWNHKj6QPqNlPly
 3qfpuIvATMFudW5Qeg5VsaajRwmecGkq9krGd0h/Al82z456nuW9d38z0tn54TfbpnKV
 leCGWzKgEnvCHc/Pa1fS1DzWpK/Gjg5iFb+xlQHeOWTkE0/2oewsw85dw+RJK6jzD5oX
 bgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716901850; x=1717506650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N4tw5Zk4wf6z5pZ1c7E5nJ8v49b+H89ox9BNVmWVrgc=;
 b=eYsIyXmw31WoUStP1Ped12EBTAg9oX4lGVkX3i9BI7re3DH2UKc9jrnAzNJmHj36i9
 x7rpGzGPcYrX0etKA7cwMUWCxGhBAzqiAAGQ6h/YoFIo9R/aXXGIUQ8UCLA4ZWy0U4XC
 9nDmFSPoM84ab+HX0X5+k1mCCRwCkuD15lfALexrwGs+pErePP7eZkrjlz5egadQpRZV
 kkVaNIa+lx+JZzbEKBmwtaz89DO0uvG+xM9Ki+4501rEHPnHCduvpK6/PqLQ2rrh/C8X
 8zK0DflpmTdzS2rqU4BbDMbGUkr4LZBwVGEYWVH64DTeUaGevoKHUabEYjwMhl4v0KO7
 86Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhz7ZMHuOxjfwHwIAeKrYBG2P4+u8y5n9ZzD+OQ1CfJGDeHuFfT3XSgnGCAbtePgz+EC+0iB3a08tC+IOog2XMAVRVTV9LeubM4LGniQ==
X-Gm-Message-State: AOJu0YyU1Wsf1eKXKUMFVLcflTonQvqc1OxizkzQE6Odxc93wkvgqklS
 y9QjtRMovlHF9INskk/7DAs5h16p5i9Kvca3uHpfK1Mm/pPkpGcvWNm7QRzW2wI=
X-Google-Smtp-Source: AGHT+IENIbL4eqrAuRni3H9gjq87QLavVAgLpj1kLIlhPBLtOpZrF1dvpvJpm4KfTgXo+QjOzfVo8w==
X-Received: by 2002:a05:6a20:3cac:b0:1af:ab23:82ce with SMTP id
 adf61e73a8af0-1b205c7ac3fmr22367809637.3.1716901849903; 
 Tue, 28 May 2024 06:10:49 -0700 (PDT)
Received: from ccsl-Inspiron-7472.semfio.usp.br ([143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682226fc4dcsm7507164a12.42.2024.05.28.06.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 06:10:49 -0700 (PDT)
From: Bruno Rocha Levi <brunolevilevi@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mairacanal@riseup.net,
 melissa.srw@gmail.com, mripard@kernel.org, rodrigosiqueiramelo@gmail.com,
 tzimmermann@suse.de, Xinhui.Pan@amd.com
Cc: Bruno Rocha Levi <brunolevilevi@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] Fix alignment in comment blocks
Date: Tue, 28 May 2024 10:08:02 -0300
Message-ID: <20240528131026.214773-1-brunolevilevi@usp.br>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 May 2024 13:24:11 +0000
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

Hi!

This patchset fixes two alignment issues in comment blocks throughout
the codebase. These changes fix codestyle warnings reported from
checkpatch and are intended to improve code readability.

Thanks,

Bruno Rocha Levi (2):
  drm/vkms: Fix misalignment in comment block
  drivers/gpu: Fix misalignment in comment block

 drivers/gpu/drm/amd/acp/include/acp_gfx_if.h | 2 +-
 drivers/gpu/drm/vkms/vkms_drv.c              | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.45.1

