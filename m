Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE186C83F22
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 14:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A15910E20D;
	Sun, 20 Jul 2025 14:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="Dxpn2Aq0";
	dkim-atps=neutral
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D8F010E20D
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Jul 2025 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [88.120.44.86])
 (Authenticated sender: ydirson@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 36C715FFB7;
 Sun, 20 Jul 2025 16:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1753020849;
 bh=hfqXI8jwGuwFDuRqqTfmvmR7TWIoaFqu8ePGrnHsSJI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dxpn2Aq0NHvKlqVfCSw9pfLWbSytNmxn9XFSkeG6h3kP8u2QRQA36asjJqPBnkRVv
 LGDaIiONqTAzHFpdvFJGJvE4WGJO3Lp7XC6vGED7WtGj0n0tSA1mT1EbGSCxP/QOkF
 0OZTlYV0ZTOwCJl0WYO+6QxXj4gp2PNzs3RBAOBgD/xdoyg5dqLsWK4wtdiDW2RuGy
 GjLP/2jumhrsDQ3GiebfKtm/Qq+GO6FRTVyn137zmZAmHomzGAA2P2BEfZs3MBN/QX
 UT6PC5SsW/96dripLwq6yIlGaLnq+MkYqyNugZgf4DnOrR4WLDEhJ/XE93A8QfIZNr
 AU3n1w42NkHFg==
From: Yann Dirson <ydirson@free.fr>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Yann Dirson <ydirson@free.fr>
Subject: [PATCH 1/3] Documentation/amdgpu: fix 'in the amdgfx' formulation
Date: Sun, 20 Jul 2025 16:13:16 +0200
Message-Id: <20250720141318.4845-2-ydirson@free.fr>
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
 Documentation/gpu/amdgpu/display/dc-glossary.rst          | 2 +-
 Documentation/gpu/amdgpu/display/display-contributing.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/display/dc-glossary.rst b/Documentation/gpu/amdgpu/display/dc-glossary.rst
index 7dc034e9e586..3205f80ad471 100644
--- a/Documentation/gpu/amdgpu/display/dc-glossary.rst
+++ b/Documentation/gpu/amdgpu/display/dc-glossary.rst
@@ -5,7 +5,7 @@ DC Glossary
 On this page, we try to keep track of acronyms related to the display
 component. If you do not find what you are looking for, look at the
 'Documentation/gpu/amdgpu/amdgpu-glossary.rst'; if you cannot find it anywhere,
-consider asking in the amdgfx and update this page.
+consider asking in the amd-gfx mailing list and update this page.
 
 .. glossary::
 
diff --git a/Documentation/gpu/amdgpu/display/display-contributing.rst b/Documentation/gpu/amdgpu/display/display-contributing.rst
index 36f3077eee00..eb148065ddc6 100644
--- a/Documentation/gpu/amdgpu/display/display-contributing.rst
+++ b/Documentation/gpu/amdgpu/display/display-contributing.rst
@@ -9,7 +9,7 @@ contribution to the display code, and for that, we say thank you :)
 
 This page summarizes some of the issues you can help with; keep in mind that
 this is a static page, and it is always a good idea to try to reach developers
-in the amdgfx or some of the maintainers. Finally, this page follows the DRM
+in the amd-gfx mailing list or some of the maintainers. Finally, this page follows the DRM
 way of creating a TODO list; for more information, check
 'Documentation/gpu/todo.rst'.
 
-- 
2.39.5

