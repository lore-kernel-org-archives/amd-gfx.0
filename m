Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3D1CC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF9E10FD94;
	Wed, 14 Oct 2026 12:48:00 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75D0310FBEC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 08:06:15 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so23033925e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791965174; x=1792569974; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=whTgkbIiuC9Donel3qpzwMVd7wGr7r99N2q4QbEFkeQ=;
 b=fIyXF7cOroQk8dUASadMou9+7h1SxaP2k75Vsuob9E+WePfhdQdGyBULY38/IPJ7s/
 bxi6HhRmNwK9rgqup191Xn2cAyioWrdIVWtWNSoLHBhDyefFBIz0L/MVpteJhBMGPMZ7
 i4aOVt2rwkwhbUCUUkFyR0F/ef4v/eZv3jFMZhM9Qd8Cp90qoJUpRsT0JJ9iUSiEck1C
 YbGJtCAh5XUJAJ3cTdIITyKg4N6gJSD8eWInlH8K64Zj7K5+sh/i5lTx+DmXg1+ljEuM
 eUG4MsDSw70zJo2q0VvOn+ctH/Sl5N3t4JNS9NqVQrXKb6UIwRhchtqef/g7EEyPnVPh
 jffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791965174; x=1792569974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=whTgkbIiuC9Donel3qpzwMVd7wGr7r99N2q4QbEFkeQ=;
 b=VeXJv9ZB/HbgHL8DiFy2hUiEip8W7gd8GnfL9rSDx1EkG0OW0qRvoSpzZbz7IguI2/
 aDvj4gugXKYmxFKMpaOtLIe35TeJMaJPnL/esElAGwPCGukeS96uR98DeYTovLsB0obU
 jlrKJPjrcF07Sf/fp+h8YDY/uJWfuCwVRyjSPCWiPmV8WhBia4Hy4KMYX04jazP7TEvo
 exU/bpS+n7JrDorW3mvcGMjIQssIxBx3fVhcEmY8YGCzYRJ48emZR5G579bk1S95wH5s
 77KIlge8NYqP2F81MxPwSj7QVpkWaCy1e8CA41d2pSIX3JqldTSnFjXYxuzbme2iT0X3
 Txzw==
X-Gm-Message-State: AFq9FYL4aCT8ppFZZUL4RY9OyR/dsAcTECcl20bMusGHg6Rxy+DnpFOj
 4UidFQfZgziSCyW2Apn8MsUEBQlZeVa2IHWdOmjTZq0IUMZFYC04ujMv/62P5MnbrfHM/g==
X-Gm-Gg: AYBFou0VaKc8yuh6XxPav1SLKgpsNZxIgdMFEdog5OS2nmNzC1Fmmkg3Ts8Ek3IT+Aa
 72Z0Zlf5Tu+Dec1u6entbLNKXzwRqrMjlss7BiACjY7GcGbjLIOJLddYnr3CJRhv1JmnmQs45UF
 FieoXubzI53RBikkncaYDCEsUGm9IpqL0El0DS4+bTZd4nw7eZwxSRLfmJTshn3GPAIp4GYCauQ
 C3K6mO4wJ3rfMfO0nGI5NfUkBZKoQ//pWbZqpRbrrLN16CzBBPg2Xm00aJyDjMeU9/wO55Ggtx4
 GcJuyNdmPZg5ruGTjZALYIYQxiu4QHOBP3+L4lFi8DRlp0NEmt0G779VEflX1h1exBfj2YMrIEY
 jczmZzTJ1UAeCjDXhi2vuloI/++E4MUY35zTLFZBylTXnW2aNUiojyZK6CJne9jz2us78jYPUmV
 YAVEnPwf5hT7CIhAftq4kf95ZRps1GaorOt/4Lc+xNfEcK1klRreXigQzkploEcp2whbezfbFye
 GmxRfLr926e254EQvM1a59NmEPWbLqvVg==
X-Received: by 2002:a05:600c:64c7:b0:49f:ff32:803c with SMTP id
 5b1f17b1804b1-4a18e49c536mr285458875e9.16.1791965173650; 
 Wed, 14 Oct 2026 01:06:13 -0700 (PDT)
Received: from hope ([2.184.155.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2343asm764060535e9.9.2026.10.14.01.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 01:06:13 -0700 (PDT)
From: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Frank Min <Frank.Min@amd.com>,
 Zhigang Luo <Zhigang.Luo@amd.com>, YuBiao Wang <YuBiao.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: prefer exact bus match when selecting VFCT VBIOS
 image
Date: Wed, 14 Oct 2026 11:35:23 +0330
Message-ID: <20261014080523.186533-1-rezanikzadch@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

amdgpu_acpi_vfct_match() accepts an entry whose bus number differs from
the runtime bus number as long as vendor, device, slot and function
match. The caller takes the first entry that matches and stops.

On systems with several GPUs of the same model (e.g. mining boards) every
card matches every entry on vendor/device/function, so an earlier entry
is selected for a later card even when the table contains an entry with
the exact bus number. The later card then runs with another board's
VBIOS (different power/clock/memory tables) and can fail to initialize,
for example with "UVD not responding" and a fatal error during GPU init.

Search the table first for an exact bus match, and only if none exists
fall back to matching by device identity.

Reproduced with two RX 580 (Polaris10, 1002:67df) from different vendors
on an ASUS B250 mining board: VFCT holds entries for bus 1 and bus 12,
the card at bus 12 was given the bus 1 image.

Signed-off-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 71 +++++++++++++++---------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f9315e047..d42485e6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -441,10 +441,15 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
  * the bus numbers disagree we accept the entry if the device identity
  * matches.
  *
+ * @exact: if true, only an exact bus number match is accepted.  The caller
+ * first searches the whole table with @exact set, and only retries with it
+ * cleared when no entry matched exactly, so that an earlier entry for an
+ * identical card on a different bus cannot shadow the correct one.
+ *
  * Returns: 0 on match, -ENODEV on no match
  */
 static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
-				  VFCT_IMAGE_HEADER *vhdr)
+				  VFCT_IMAGE_HEADER *vhdr, bool exact)
 {
 	/* Vendor and device IDs must always match */
 	if (vhdr->VendorID != adev->pdev->vendor ||
@@ -459,6 +464,9 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
 	if (vhdr->PCIBus == adev->pdev->bus->number)
 		return 0;
 
+	if (exact)
+		return -ENODEV;
+
 	/* Bus mismatch but device identity matches (PCI renumbering case) */
 	dev_notice(adev->dev,
 		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
@@ -474,6 +482,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 	UEFI_ACPI_VFCT *vfct;
 	unsigned int offset;
 	bool r = false;
+	bool exact;
 
 	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
 		return false;
@@ -484,38 +493,50 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 	}
 
 	vfct = (UEFI_ACPI_VFCT *)hdr;
-	offset = vfct->VBIOSImageOffset;
 
-	while (offset < tbl_size) {
-		GOP_VBIOS_CONTENT *vbios = (GOP_VBIOS_CONTENT *)((char *)hdr + offset);
-		VFCT_IMAGE_HEADER *vhdr = &vbios->VbiosHeader;
+	/*
+	 * Pass 1 looks for an entry whose bus number matches exactly.  Only if
+	 * there is none does pass 2 accept an entry that matches by device
+	 * identity alone.  Without this, on a system with several identical
+	 * GPUs an earlier entry would be picked for a later card.
+	 */
+	for (exact = true; ; exact = false) {
+		offset = vfct->VBIOSImageOffset;
 
-		offset += sizeof(VFCT_IMAGE_HEADER);
-		if (offset > tbl_size) {
-			dev_info(adev->dev, "ACPI VFCT image header truncated,skipping\n");
-			goto out;
-		}
+		while (offset < tbl_size) {
+			GOP_VBIOS_CONTENT *vbios = (GOP_VBIOS_CONTENT *)((char *)hdr + offset);
+			VFCT_IMAGE_HEADER *vhdr = &vbios->VbiosHeader;
 
-		offset += vhdr->ImageLength;
-		if (offset > tbl_size) {
-			dev_info(adev->dev, "ACPI VFCT image truncated,skipping\n");
-			goto out;
-		}
+			offset += sizeof(VFCT_IMAGE_HEADER);
+			if (offset > tbl_size) {
+				dev_info(adev->dev, "ACPI VFCT image header truncated,skipping\n");
+				goto out;
+			}
 
-		if (vhdr->ImageLength &&
-		    !amdgpu_acpi_vfct_match(adev, vhdr)) {
-			adev->bios = kmemdup(&vbios->VbiosContent,
-					     vhdr->ImageLength,
-					     GFP_KERNEL);
+			offset += vhdr->ImageLength;
+			if (offset > tbl_size) {
+				dev_info(adev->dev, "ACPI VFCT image truncated,skipping\n");
+				goto out;
+			}
 
-			if (!check_atom_bios(adev, vhdr->ImageLength)) {
-				amdgpu_bios_release(adev);
+			if (vhdr->ImageLength &&
+			    !amdgpu_acpi_vfct_match(adev, vhdr, exact)) {
+				adev->bios = kmemdup(&vbios->VbiosContent,
+						     vhdr->ImageLength,
+						     GFP_KERNEL);
+
+				if (!check_atom_bios(adev, vhdr->ImageLength)) {
+					amdgpu_bios_release(adev);
+					goto out;
+				}
+				adev->bios_size = vhdr->ImageLength;
+				r = true;
 				goto out;
 			}
-			adev->bios_size = vhdr->ImageLength;
-			r = true;
-			goto out;
 		}
+
+		if (!exact)
+			break;
 	}
 
 	dev_info(adev->dev, "ACPI VFCT table present but broken (too short #2),skipping\n");
-- 
2.53.0

