Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A830CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 13:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4368D10F6A7;
	Thu, 16 Dec 2021 13:18:14 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D291410E59C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 09:45:14 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id i22so13268572wrb.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 01:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=ARN4qeir3Hz4c3b/QWXg3h+IBfZ0AX5ARmmNbEMD7Bg=;
 b=j0vD1zZLVa8psUzy5p/QOX2FqK+FVc6pWNRPLwbPdsMOjQVTfyuSA/zGc4t+j+FSAQ
 fZCmaFjE0Ffel/LFeaAVrQqMg4/dvvuoqiC+qfV4Ai11W/X0igTRNoyIj7q36X/c0gu7
 SpL7mSlWWiBnyKip4f577voNtQFgbaawN/7+IQ+6ZwpekyvnFpQX4f+L7IMiWmTegT9D
 SVBabQ3M6MUmHEN4rMkhf+Y+20RdfdT3yB+uWjUnif80Uk1AQ/oIiu6msPHcv6QSs9Tz
 FQ/Sl23i+zDy15ar70TbUbCq8MVAxtXniu7P43mhsTlQMiKZIp49sNPLC253NnMvv3XQ
 BPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ARN4qeir3Hz4c3b/QWXg3h+IBfZ0AX5ARmmNbEMD7Bg=;
 b=WCL9ffUr+DnG4t46AQ4oEQEJMOD1D42eZP/1s6lAjVssFS4kdbzNqpEwTq/8MpoHzE
 wFAccLA3nshm4COUX+pWJU/0lQh4WeSq0L4Am6RrODilyl5Snqjg3SFVl+xXLAziLn+u
 /5BI15Atz40gIOzejZianpXJxVn3LILI5Z00QtS18jJKvIFe6FtIce6K8Uu1xXUJWYP1
 QpD4jhkkxmOIiFPd9fxt8BWfMCjTJMCbHvBzrBslOS8wS0GBxuz9IyykdckhUGt9skIj
 LL93UfPu/Uiz7DMwSi/3eIWrO57dI46H9x+gLt9TefNOibcARwmuWuhaMMSIY9WqORQV
 FRIw==
X-Gm-Message-State: AOAM531MiwRIpsIRKWNDxYzROV80NqHU6uBuwm/b5X9h/xL1xFxId8Lg
 dCOgJyWBf5N+nRkxIgVWpsg=
X-Google-Smtp-Source: ABdhPJwbIjTPzZFy8VT5f8JT2Une97QMgC0Zd0FEEOycuRTMmUs5Tfgz4ZnfOy19zcLP6lRHpdTVYA==
X-Received: by 2002:adf:dcd2:: with SMTP id x18mr8196312wrm.173.1639647913304; 
 Thu, 16 Dec 2021 01:45:13 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:267b:1200:18af:bb55:aabf:94a8])
 by smtp.gmail.com with ESMTPSA id g18sm4294270wrv.42.2021.12.16.01.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 01:45:13 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: make SPDX License expression more sound
Date: Thu, 16 Dec 2021 10:45:03 +0100
Message-Id: <20211216094503.10597-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 16 Dec 2021 13:18:13 +0000
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
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-spdx@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Commit b5f57384805a ("drm/amdkfd: Add sysfs bitfields and enums to uAPI")
adds include/uapi/linux/kfd_sysfs.h with the "GPL-2.0 OR MIT WITH
Linux-syscall-note" SPDX-License expression.

The command ./scripts/spdxcheck.py warns:

  include/uapi/linux/kfd_sysfs.h: 1:48 Exception not valid for license MIT: Linux-syscall-note

For a uapi header, the file under GPLv2 License must be combined with the
Linux-syscall-note, but combining the MIT License with the
Linux-syscall-note makes no sense, as the note provides an exception for
GPL-licensed code, not for permissively licensed code.

So, reorganize the SPDX expression to only combine the note with the GPL
License condition. This makes spdxcheck happy again.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
I am not a lawyer and I do not intend to modify the actual licensing of
this header file. So, I really would like to have an Ack from some AMD
developer here.

Maybe also a lawyer on the linux-spdx list can check my reasoning on the
licensing with the exception note?

 include/uapi/linux/kfd_sysfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
index e1fb78b4bf09..3e330f368917 100644
--- a/include/uapi/linux/kfd_sysfs.h
+++ b/include/uapi/linux/kfd_sysfs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 OR MIT WITH Linux-syscall-note */
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
 /*
  * Copyright 2021 Advanced Micro Devices, Inc.
  *
-- 
2.17.1

