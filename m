Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6C3C83F1A
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 14:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4416310E36A;
	Sun, 20 Jul 2025 14:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="hX9+XLV8";
	dkim-atps=neutral
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC5010E36A
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Jul 2025 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [88.120.44.86])
 (Authenticated sender: ydirson@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 71EAC5FFB7;
 Sun, 20 Jul 2025 16:14:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1753020859;
 bh=zhGzzFgssENWKki4CJgsxhckAYzCUGAjZa/p23Z7Is0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hX9+XLV8r5pNVe7WzTbjo4KBDL8cIvI8+8mH1LUGiyn5DR7u318sUPohj34UW35y0
 mi3em4O5MUtXBq7ppNrkeCTOc2o3xW2tuG408ZlvERadWkhU0z0w8BvEtSYglOqJtp
 9NIfKQQBrZ/RpmGgQcfFMYtmXbCqNGl7cNtKiftMYTUWleBMiwcmrh+H5Cp/n9AgMp
 E0IFF42XNWq84TW9RxmGj0sJgy2hRBi3eJ7dVV8J+aemFwZEbLGuvWSKRxO0si/bQl
 j4+phbDJzAWBwia1BXqP8w6DFAk7fDOHdOkU6Zep0i4V+eC9aORU34xeJtYHY7FaLM
 8xvFlSCm40Mdw==
From: Yann Dirson <ydirson@free.fr>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Yann Dirson <ydirson@free.fr>
Subject: [PATCH 3/3] Documentation/amdgpu: add a few acronyms to glossary
Date: Sun, 20 Jul 2025 16:13:18 +0200
Message-Id: <20250720141318.4845-4-ydirson@free.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720141318.4845-1-ydirson@free.fr>
References: <1103498267.150074445.1752966181999.JavaMail.root@zimbra39-e7.priv.proxad.net>
 <20250720141318.4845-1-ydirson@free.fr>
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

Signed-off-by: Yann Dirson <ydirson@free.fr>
---

Notes (patch):
    test patch note

 Documentation/gpu/amdgpu/amdgpu-glossary.rst     | 3 +++
 Documentation/gpu/amdgpu/display/dc-glossary.rst | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 30812d9d53c6..ad9e6f0f91ba 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -12,6 +12,9 @@ we have a dedicated glossary for Display Core at
       The number of CUs that are active on the system.  The number of active
       CUs may be less than SE * SH * CU depending on the board configuration.
 
+    ACA
+      Accelerator Check Architecture
+
     BACO
       Bus Alive, Chip Off
 
diff --git a/Documentation/gpu/amdgpu/display/dc-glossary.rst b/Documentation/gpu/amdgpu/display/dc-glossary.rst
index 3205f80ad471..d6a6ed4e6374 100644
--- a/Documentation/gpu/amdgpu/display/dc-glossary.rst
+++ b/Documentation/gpu/amdgpu/display/dc-glossary.rst
@@ -88,6 +88,9 @@ consider asking in the amd-gfx mailing list and update this page.
     DIO
       Display IO
 
+    DPIA
+      DisplayPort Input Adapter
+
     DPP
       Display Pipes and Planes
 
-- 
2.39.5

