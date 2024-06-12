Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B23BC27C75
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jun 2024 07:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31D9410E17C;
	Wed, 12 Jun 2024 07:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jv00Z7rX";
	dkim-atps=neutral
X-Greylist: delayed 523 seconds by postgrey-1.36 at gabe;
 Wed, 12 Jun 2024 00:19:35 UTC
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5A010E186
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 00:19:35 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7EEA43F363
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 00:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718151050;
 bh=yA3GemOLta7ptddMW/7rnk7IdpnukaO6SkrLIQz3nbM=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=jv00Z7rXmMaB0IN49bfULAKzmdiXfaoKIcZwFbY2xWZDGy7PEaunOsHeXr4ZsNb9F
 uHBHXbvYAuBLvuNbVPIgoTqpNNjDbI0VRS1YF86XHyCr5xaQoF1/kw64tfXDmZrW+J
 Sf0x54oQb/hdKoGyHc98GAQgPWaFDgaF7Qy3Mdjv62+9Z2GHeAfInS+mCWqzKbpJoz
 lPGgqFajaggWlmFQcBy//hpuPdWs94iTTES7nIQ6WoQC/PfTKhzSeutxqemj8smgag
 HK37T1j3i+RdIskEwy5tMMaAAqu+uHRF0i8Cx76v0kG4RPzWzBajxKx0a7U6l3D9+1
 wliTdKOFN1nRA==
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c1e953176cso5886959a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 17:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718151049; x=1718755849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yA3GemOLta7ptddMW/7rnk7IdpnukaO6SkrLIQz3nbM=;
 b=JDa+XlqcAmPh47GKwFYQeZljcA5Xcaz7tdTq7cv0Fomrl7Chvd8nM3PKmKeHF00BNy
 9PAD0YEf2caCTbiqvXXA2O4hUgOxz9q5Nv9MvEDVg1dzkGXZ1tOg6Xlm98EwOPjEmPYK
 jtGfMMHD5JrikVF+OsAzFJP6JSjqLoaQOssHoQyI3Y/anaEZSiSN22GEL+d5NK1FvmOs
 TkUqGGf7/iLeqt/Y+fPdVRoHHWcsxPJ2ZKzd+Dh3tUrpQeJ7hbGw4u7acv396VQR49uV
 fAfpd3MnJHpc85hNLb9mDE0qI4F4c3S59+7GvCAd2n853sUw58UQji7j1Rm/nrLOMtWu
 s7mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcwM7uTOpnXo31qLBLXaOa5N2I3F8t+i4jCmgb6xb9JDCO1eb3URHa3eeiLYUiADwkiQ0Wn4k+n/l0DD+QRgNdscjOk4EokvQwGF6z5w==
X-Gm-Message-State: AOJu0Yw9tjUYHnpg/9Zd0borNbtRC0QOx04Ktqv25jqU/9eLsztIURF2
 k6W/Fg2x4DKBs2hzwxncSdpTGA87Xb5/AHk4/OQqqizLHVXp9Tsn7zSjzwdyYwyPDrq9v8Z2TTR
 CwFcYPNLc+k3DXwHbFGO55KXx4vgis+ti3rpPVR5UIi9fspMFi0h4aMJJP0rLPQCHYEmw+oyF3/
 rceVc=
X-Received: by 2002:a17:902:db11:b0:1f7:e32f:f067 with SMTP id
 d9443c01a7336-1f83b6eacfemr5651235ad.50.1718151049197; 
 Tue, 11 Jun 2024 17:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtrQz+Z+est4OL6JMDV7Qe9u9duB8be/MwTdrnQYsCLYsrV7LoeCf5ZBBuNVwo06AB7Snq9g==
X-Received: by 2002:a17:902:db11:b0:1f7:e32f:f067 with SMTP id
 d9443c01a7336-1f83b6eacfemr5650975ad.50.1718151048830; 
 Tue, 11 Jun 2024 17:10:48 -0700 (PDT)
Received: from ThinkPad-X1.. (222-154-76-179-fibre.sparkbb.co.nz.
 [222.154.76.179]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f71ad56202sm38921265ad.276.2024.06.11.17.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 17:10:48 -0700 (PDT)
From: Matthew Ruffell <matthew.ruffell@canonical.com>
To: w_armin@gmx.de
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Felix.Kuehling@amd.com, Prike.Liang@amd.com, Xinhui.Pan@amd.com,
 Yifan1.Zhang@amd.com, amd-gfx@lists.freedesktop.org, bkauler@gmail.com,
 dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "drm/amdgpu: init iommu after amdkfd device init"
Date: Wed, 12 Jun 2024 12:10:37 +1200
Message-Id: <20240612001037.10409-1-matthew.ruffell@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <fe03d95a-a8dd-4f4c-8588-02a544e638e7@gmx.de>
References: <fe03d95a-a8dd-4f4c-8588-02a544e638e7@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Jun 2024 07:24:28 +0000
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

Hi Greg KH, Sasha,

Please pick up this patch for 5.15 stable tree. I have built a test kernel and
can confirm that it fixes affected users.

Downstream bug:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2068738

Thanks,
Matthew
