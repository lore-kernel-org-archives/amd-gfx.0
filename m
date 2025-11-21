Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79CBCFA466
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 08:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04FA10E1DE;
	Mon, 24 Nov 2025 08:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=freebsd.org header.i=@freebsd.org header.b="DLS2c0pP";
	dkim-atps=neutral
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2834F10E89C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 15:12:44 +0000 (UTC)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R12" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4dCdxk5602z3lDf;
 Fri, 21 Nov 2025 15:12:42 +0000 (UTC)
 (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org
 [IPv6:2610:1c1:1:6074::16:84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "freefall.freebsd.org", Issuer "R12" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4dCdxk3T4dz3n8K;
 Fri, 21 Nov 2025 15:12:42 +0000 (UTC)
 (envelope-from emaste@freebsd.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1763737962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LnZhhazrCnsFMOT4E79BHroufGAGou9v69FtU2sFfGM=;
 b=DLS2c0pPlbKOUiIs9mGK2/bDBq+GWqbpcKY6wAuci2+bPXzRx19dI7ZpKY2/N+IeYTrP2R
 JqYAt/2n1OtBP9NPAWdciSOBlZuYbvch4xzZJibUdTEIpgNuYvGkVmrJv31EQuiN+OT5Yp
 Kfhau5ZSeFaVDR0VAgkzzcs05YolLknQ+SeZrf29EWaZnW0C+SCjubthcsFEGCdltWU7SU
 62BjblkqxdFNf9VlAheU4r8nUpipdnUjx/rCZkHTpeOTVdeZ96k6CSzBFs+ttbMU17XbZH
 kq93LxQh8D6XCKwdrj1V2b5hV0ZhzO0JVXbEmsKsV57HhDFFcjGPUgO2KeTD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1763737962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LnZhhazrCnsFMOT4E79BHroufGAGou9v69FtU2sFfGM=;
 b=dq7uSS+3wNPH+N2h4O0ExRultXgD8xap2r6zmc9KhzvOycMwWesI9m0vJ9OYM4DnTSYdxH
 lW6lZPSbPk3q9yFX4bnYjhktgjj4NDFl/Hqwgd9Pku8ePb0vrYPcZM1KqQrG/C2WQeLsz2
 YaT6sV3W/eFuZljyV045JVoSCG+UWr0nhtGFB0WpnpDJpgAJYWdEhxIRqemo+UAiqwc7wz
 t2AB9XW/A8eD+DRQV1wSwAON4G3t8ZXTnBUQT+V5Vqn2hmEuoNc0JG4k372oFu3VA6ROHY
 jYRdYYSzvT5tunFJzDZf4zsNGrVxWnpiPmOohazsPOt2guTexlRYszt2ikV+DQ==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1763737962; a=rsa-sha256; cv=none;
 b=ubIJl7vt3HuS+AiqK1ffKTPeTOQ85nOzO2EE+Q3asn8AlFNlKirIzqXMT4kVwFH9cAby90
 7OgV7xf7SmSBvKozWXOyuWcE99PZmBzZhH/wxGwHu+s6sL7H6gI4sgb6SA3Lpw9HOZb+C5
 ezBQbWRmj60+hmT9ElLQ4AbcZ1r3IGkVjaFBh9aHm6YklvX8/T7iavYgXjcPj/HKwZPEe/
 iAG3CPPNDcodElaHdY1qv+uHy16pIKsSNeYsW9kRVRWzTomIqpikMlKKGk9X/6nn+erqye
 IJ2auzCTFCSVyjnIJKPa4fhAMHRxgs+b7aNLb8IyTdwdSAZZTy3w50x2IP2EHg==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: by freefall.freebsd.org (Postfix, from userid 1079)
 id 608BF4749; Fri, 21 Nov 2025 15:12:42 +0000 (-00)
From: Ed Maste <emaste@FreeBSD.org>
To: amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Ed Maste <emaste@FreeBSD.org>
Subject: [PATCH] drm/amd/amdgpu: Add missing newline in DRM_DEBUG_DRIVER
 message
Date: Fri, 21 Nov 2025 15:12:36 +0000
Message-ID: <20251121151236.26852-1-emaste@FreeBSD.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Nov 2025 08:12:45 +0000
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

This error message was emitted without a newline during bring-up on
FreeBSD.  Presumably the error doesn't occur on Linux so was not noticed
before.

Signed-off-by: Ed Maste <emaste@FreeBSD.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 6c62e27b9800..d8a4e918846c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1109,7 +1109,7 @@ static int amdgpu_acpi_enumerate_xcc(void)
 		 * one is not found, no need to check the rest.
 		 */
 		if (!acpi_dev) {
-			DRM_DEBUG_DRIVER("No matching acpi device found for %s",
+			DRM_DEBUG_DRIVER("No matching acpi device found for %s\n",
 					 hid);
 			break;
 		}
-- 
2.51.1

