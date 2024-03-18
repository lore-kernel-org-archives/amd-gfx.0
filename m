Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA11C54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 08:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 326B410F492;
	Mon, 18 Mar 2024 08:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HjtCtW7P";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8129410E29E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 06:52:33 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-6e6b729669bso3736460b3a.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Mar 2024 23:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710744752; x=1711349552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jOWE335x4OAcoc2h1XUIwObJoGhE/NGUvk/ruhLaEj8=;
 b=HjtCtW7PmsH6hYX6Rqv8aWH9P+khVz9I3qmvhaffbUXVoTd+eH5VndCjv2jlabRqHZ
 sb38Y9nwK1y1TzWXHWvv0BbL0aXEAUq8W7kIBTM70KoQ4NKCaERocZmz0NH/lSwhZxGY
 c7ClCjpwPdD3Xq9r6j3w5waOh5bOHdsbemNZoH0F/CA713WQV1WLxAHhbbqHHK1HLvD0
 oBNMnLokA7cIg/XgsbPYOyHDVKqHsKrz/QyLUvFbuuLfyEPicy4GqEpFunQ+UthrFEuE
 iizhDldZ8HiOLecugt1LIpEQU1vWlrI+vhn1TGOU4nFwg7fd7DY+JCQtptNjGasdJXly
 rI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710744752; x=1711349552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jOWE335x4OAcoc2h1XUIwObJoGhE/NGUvk/ruhLaEj8=;
 b=ute9NY8MnAzrT8uwBBXkvB5MUU8tal0esWFwh+6P7lDJT/37em9pWWx/BrYzADXZDR
 XjUu5P0zeAnvv01Kg8V6zKY7X+wj0VAzadjkfUlKfosAEXCCSoczCHZUpfPhZyaoqzDV
 6EjDLyZh9h1i/9+ptQbGZ7Q+l6W4SKP90lUXAAK4yz0nhPwj3Ub6dR6zGleDi0kCjeRV
 xql8L7sbPU9iyoBqSHcG7MJyQuUEJDZYbPBT9WdAa4m7DHycbr/Fwj0/Air3w/PW0WQ4
 DwgzhUdPdd73WRxMZT4ThyqrRYGkDzr36Z/SCbsIetogk1lafvXrrg0cgJiIgiIWRp9w
 5+aQ==
X-Gm-Message-State: AOJu0YxllWP1HklS5fCkWN2pioxwhKiiD2GC3otgKUD2UfKqaFGVYk9M
 kKh7iD6zRHhx+bYYpcC4qrT5ywLInAhLTidAjiJqDAha3pgqGAAJ7NhA9oZo
X-Google-Smtp-Source: AGHT+IFAlRACTa/1iV7eDnxU8DVmrQTCAxEQ10W8X32UqWofyq7VwCg9kPR7o33+90s2rOtCAbfI4Q==
X-Received: by 2002:a05:6a21:9988:b0:1a3:564e:a56b with SMTP id
 ve8-20020a056a21998800b001a3564ea56bmr7819174pzb.3.1710744751785; 
 Sun, 17 Mar 2024 23:52:31 -0700 (PDT)
Received: from alfheim.fenrir-cloud.ts.net
 (c-98-248-157-37.hsd1.ca.comcast.net. [98.248.157.37])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a170902e54200b001dd67d69848sm2115855plf.82.2024.03.17.23.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 23:52:31 -0700 (PDT)
From: Kurt Kartaltepe <kkartaltepe@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: kkartaltepe@gmail.com
Subject: [PATCH] drm/amdgpu: Remove pci address checks from acpi_vfct_bios
Date: Sun, 17 Mar 2024 23:52:11 -0700
Message-ID: <20240318065211.11097-1-kkartaltepe@gmail.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 Mar 2024 08:22:07 +0000
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

These checks prevent using amdgpu with the pcie=assign-busses parameter
which will re-address devices from their acpi values.

Signed-off-by: Kurt Kartaltepe <kkartaltepe@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 618e469e3622..932ce13ad232 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -386,9 +386,6 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		}
 
 		if (vhdr->ImageLength &&
-		    vhdr->PCIBus == adev->pdev->bus->number &&
-		    vhdr->PCIDevice == PCI_SLOT(adev->pdev->devfn) &&
-		    vhdr->PCIFunction == PCI_FUNC(adev->pdev->devfn) &&
 		    vhdr->VendorID == adev->pdev->vendor &&
 		    vhdr->DeviceID == adev->pdev->device) {
 			adev->bios = kmemdup(&vbios->VbiosContent,
-- 
2.44.0

