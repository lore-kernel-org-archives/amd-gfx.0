Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A556CC6B39
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 08:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3491121B2;
	Thu, 15 Oct 2026 08:21:45 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B094010E146
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 13:34:01 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c315729ad50so679646366b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791984840; x=1792589640; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Do96l1a82m3Ocz3d7RYUiQxcr6BpZfahyyHVqS1BI2I=;
 b=ICLU62wQZ03UsFHgoeOWohLlO1xiVhYh2jLYKIiE0c+yvDL/KS+wbXKGJo+esePdPW
 WDTEwYjRvPJ3EE8gAobnJNdn5gdEx9bVWbkYENkThpRdAomGHWPs0gOEIwiiEbGeCKVH
 +SQfT/AjldkXxQWCoR+m3954xsSS1gDnUvhMoqsFOyVya3BEtf9SSlefImHeJPvCkh1G
 3Et1CpA07hPCfYDwSmOsFztJiUpYl4iBPrrFEUrMYkPIIyjWwLxkwHgvaH6AOebyRlmv
 RcxG+EhdV3jc2L4rn3GaGSUyMBnFlr8OGBipdCZmF/k7XPpyOeQ/rQbTr6ecCgrw9rg5
 kRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791984840; x=1792589640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Do96l1a82m3Ocz3d7RYUiQxcr6BpZfahyyHVqS1BI2I=;
 b=bQob3jj8YIjAHfpd9/m4G7Gk0uWeMRriVeziezpViCry207rZ4H9sGKeSzlHJtSyXc
 AVn9zTfaIW0/MkQHgIEVpCKQqeXOLPQ3WRsARS16pIN//w8tw6xx9sl29XJwOTIONjAv
 VodzuZT2nucPCjmBZwG53QEoN0X7ya1Fuun0NTD3QtlaTo79a8lP5DTK0u70A6G5tj5a
 3xU8uhr3pZQYHCfyOBbwDPMOS1TrtvoTCoFoxgjc4NKwcPJ3+4ypEzGjeVDqWO2hm8lQ
 KqpPz2Vb/uLS+ZED8Jf0TN1D8uaMnEO/dV4K5h204+U3G6JBXKonArufEMuHPoUYUXno
 LALg==
X-Gm-Message-State: AFq9FYL30h7OVwfPyddiKt82x/PEykFeLAt4En+LNrpjCAj0a+fP7T9A
 pyZOKFnCJG73e5W/sS9+34rXJEh0xxYh+NwNGwz4nxrSU6dhWNek8WhuAFK++1pD
X-Gm-Gg: AYBFou2fQJGdG8yxuGvL+tFFRUrM5/S4+UfT9zMnhauA7hRcCC+g31aKGlotaN3Flhp
 S/SHMjD6DPekHzrxBwhZlBDhp0Rl4nYRlnimLer79zznINPPvP6sjNx86Cuu+bYyOD9gNPufH3P
 5h6lGHw3r556EVliJdF8tz9WgqbAQLtd4efPVKqTvcX9Z3HhIIwVGSezrNzTqTAVERFaBS8bs0I
 4pvY4NmI1M7T5Sb4mpj+66+PZls+ayLJ7ON4ogrbugzgfjkNuV6r6aPUTGtVBPGbJkMfifmuPiK
 a33PPEhQ5G3K4sf/+nm5N9RKt9jsJz3VLfdRxQwHxhvrXQ3xNfNlAP6NTs8aFp+nQVARedODEs/
 egRWzHrN6VvXCYLcgqjKv8pgIDnMGCan3cF/DXOikS8eqBjp77OpaW3WVcIl/chkufq//UOAWYz
 rWlS1kCnw/zDpjqaMwi/FHcGCKkVWeY/sw6n5vtvPcBlt7O+u2jKa0QKe3+yP1tuR1PyGQIG1wX
 EruL2v591ZudkCfKG340Wklybwd02szNT+9f1VUMwFWYLpPKIMscFEhs2EHsjbaIMKKEGtG4U4b
 Oqa8+vFy+JJtuHTylom2T1iMMEc=
X-Received: by 2002:a17:907:e109:b0:c31:e19c:fc4f with SMTP id
 a640c23a62f3a-c31e19cfeb2mr1024151466b.14.1791984839629; 
 Wed, 14 Oct 2026 06:33:59 -0700 (PDT)
Received: from localhost.localdomain (93-55-250-55.ip266.fastwebnet.it.
 [93.55.250.55]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaabc3sm12142349f8f.16.2026.10.14.06.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 06:33:57 -0700 (PDT)
From: Luigi Lauro <luigi.lauro@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: require _PR3 for BOCO
Date: Wed, 14 Oct 2026 15:33:56 +0200
Message-ID: <20261014133356.3002808-1-luigi.lauro@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:21:44 +0000
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

amdgpu_device_supports_boco() returns true for an AMD_IS_PX device on a
system with a hybrid ATPX method even when the device has no ACPI power
resource (_PR3). On an APU mini PC with a discrete GPU attached over
OCuLink, the iGPU's ATPX method reports hybrid graphics, the dGPU is
flagged AMD_IS_PX, and runtime PM in auto mode picks BOCO:

  amdgpu: ATPX Hybrid Graphics
  amdgpu 0000:c6:00.0: Using BOCO for runtime pm

In BOCO mode the driver leaves powering the device off to the PCI core,
which can only do it through _PR3 on the upstream bridge. No device on
this dGPU's path has _PR3, so when it runtime suspends the card stays
powered, with its fans at about 700 rpm.

Require has_pr3 for BOCO, as the function's description ("dGPU with ACPI
power resources") says. The same card then picks BACO, which powers it
down:

  amdgpu 0000:c6:00.0: Using BACO for runtime pm

This only changes systems with a hybrid ATPX method and no _PR3 on the
dGPU's upstream bridge, where BOCO cannot cut the power today. Tested on
one such system only, an RX 9070 XT (Navi 48) over OCuLink with a Ryzen
AI 9 HX 470, with the change backported to 7.2.9: the stock module logs
"Using BOCO", the patched one "Using BACO"; BACO runtime suspend powers
the card off and it resumes cleanly. Not tested on a hybrid laptop or a
Thunderbolt eGPU.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5980
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Luigi Lauro <luigi.lauro@gmail.com>
---
Alex asked for this on the issue. Here is the full picture, so you can
judge which approach is best:

Why _PR3: in amdgpu_pmops_runtime_suspend() the BOCO branch does nothing
itself ("PCI core handles it for _PR3"), and has_pr3 checks exactly the
bridge the PCI core would power off (link_partner, past the dGPU's own
switch). On a hybrid ATPX, amdgpu_device_supports_px() is false, so the
ATPX power-control method is not used either.

Who changes: only hybrid-ATPX systems without _PR3 on that bridge. Hybrid
laptops that have _PR3 there, which I understand is the usual design,
are unaffected.

Risks I cannot rule out:
- BACO on older laptop chips that have never used it for runtime PM.
- A platform that cuts the power in a way has_pr3 does not see (_PR3
  somewhere else on the path).
- The other users of the function change too on such a system: the
  DPM_FLAG_SMART_SUSPEND | DPM_FLAG_MAY_SKIP_RESUME flags in
  amdgpu_pci_probe(), amdgpu_pmops_prepare() returning 1, and
  amdgpu_device_supports_smart_shift().

Narrower alternative: leave amdgpu_device_supports_boco() alone and
require has_pr3 only where amdgpu_device_detect_runtime_pm_mode() picks
BOCO in the auto case, falling back to BACO. That fixes this system too
and keeps the other three users as they are, which is the same state as
booting it today with amdgpu.runpm=1.

Please tell me which you prefer; I can send a v2 with the narrower form.

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e001461..96cb4d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -593,10 +593,8 @@ bool amdgpu_device_supports_boco(struct amdgpu_device *adev)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
-	if (adev->has_pr3 ||
-	    ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
-		return true;
-	return false;
+	/* BOCO needs a platform power resource (_PR3) to cut the power */
+	return adev->has_pr3;
 }
 
 /**
-- 
2.56.0

