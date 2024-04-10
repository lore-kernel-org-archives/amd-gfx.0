Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750D4CD11C2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 22:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F2D10E947;
	Wed, 10 Apr 2024 22:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=froggi.es header.i=joshua@froggi.es header.b="XgKe7PCN";
	dkim-atps=neutral
X-Greylist: delayed 902 seconds by postgrey-1.36 at gabe;
 Wed, 10 Apr 2024 22:28:50 UTC
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE36610F31C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 22:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1712787222; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NIme88Y99u/o7KXtbjhENTFxzC9hG4Ph8OscvnsySAJhhIWBi6DMrJqECiei8oAwKIqLVDHg8KeUPyHSAIkUGoG/oIjdLFwF3Jvmn6LdpWdx361NVG0Z0JYE28AcPUwui3Olm4rQqGoMa1GdGC39H35/AsVvKxGD5lyq9EQ4pZY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1712787222;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=NYQHue/l0O5zHnjuKrtBVQRTxpu30Oo0fhaRaFOjCk4=; 
 b=NA/qAdzagyNe9Mv73TZEPZXb2zISUXb5gT+bKIWD6jJmFG0qYoi32ELrIBRKCN5HbJnq6Zh//oIS3j41TQw+saOSArFzUNgURxtUfNTD2WbkXnkGoOuuQz0riGkOSEOjXt52lGoTnjh0lXXbb+rb/zzX4pOO6Ni96TF2u6ov1/Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=froggi.es;
 spf=pass  smtp.mailfrom=joshua@froggi.es;
 dmarc=pass header.from=<joshua@froggi.es>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1712787222; 
 s=mail; d=froggi.es; i=joshua@froggi.es;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=NYQHue/l0O5zHnjuKrtBVQRTxpu30Oo0fhaRaFOjCk4=;
 b=XgKe7PCN0ixSQuJmApZ4zJ83QDJf/YCn0W88JnTTiYyB4nYdCXCCvcs3TkvnEUcV
 Qc9uuf5wwTuUVeC5SXJqRiGbi+SsrjcxNu7XJ9F7hbxW0rjl6chDU4AR1XjbMRZrZBv
 J2YgBx50xc+SMOyrnaLh88sc7HLJq4Uga4zxEdks=
Received: by mx.zohomail.com with SMTPS id 1712787220750896.7568469994259;
 Wed, 10 Apr 2024 15:13:40 -0700 (PDT)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Cc: Joshua Ashton <joshua@froggi.es>, Harry Wentland <harry.wentland@amd.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Melissa Wen <mwen@igalia.com>,
 Ethan Lee <flibitijibibo@gmail.com>
Subject: [PATCH] drm/amd/display: Enable ogam_ram for dcn32+dcn35+dcn351
Date: Wed, 10 Apr 2024 23:13:22 +0100
Message-ID: <20240410221336.34627-1-joshua@froggi.es>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

The comment here states "no OGAM in DPP since DCN1", yet that is not
true.

Testing on an RX 7900XTX (dcn32), it actually does exist in hardware and
works fine.
My best guess is the comment is confused with OGAM ROM for DPP, rather
than OGAM RAM.

I did not test dcn35/351 as I do not have that hardware, but I assume
the same follows there given the seemingly erroneous comment.
Someone at AMD should check that before merging this commit.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Ethan Lee <flibitijibibo@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 9aa39bd25be9..94f5d2b5aadf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2182,7 +2182,7 @@ static bool dcn32_resource_construct(
 	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
 	dc->caps.color.dpp.hw_3d_lut = 1;
-	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
+	dc->caps.color.dpp.ogam_ram = 1;
 	// no OGAM ROM on DCN2 and later ASICs
 	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
 	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 25ac450944e7..708d63cc3f7f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1861,7 +1861,7 @@ static bool dcn35_resource_construct(
 	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
 	dc->caps.color.dpp.hw_3d_lut = 1;
-	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
+	dc->caps.color.dpp.ogam_ram = 1;
 	// no OGAM ROM on DCN301
 	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
 	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 8a57adb27264..053e8ec6d1ef 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1841,7 +1841,7 @@ static bool dcn351_resource_construct(
 	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
 	dc->caps.color.dpp.hw_3d_lut = 1;
-	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
+	dc->caps.color.dpp.ogam_ram = 1;
 	// no OGAM ROM on DCN301
 	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
 	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
-- 
2.44.0

