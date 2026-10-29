Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248DC606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bZ68b6Bj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE903112392;
	Thu, 29 Oct 2026 15:14:43 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1A2112380
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 15:14:32 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso23229695e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1793286871; x=1793891671;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mCgbPzgmzkjrJ90WgvEpu49LYgOAawOzi/i2D+jOo74=;
 b=bZ68b6Bjwh7cSosJV21IGEJCtJ1+qe2YV5JbawiXJ6I0/qVFRWgfUdrM+yiHrYtulH
 BgrKlJE4ypahP466smCLyiY+GpvGAQ5/QMoAD7zXLo/43WqOmfFRlkjvjCXcYhOAM33P
 NkN+S14lZEVPaKNleMfqJrXeyE+W2KjvwelUEzLlBf/efx+Pt57vbMpuf5uKKHPeOI12
 ADczufPjuaRVs4qU2/BHVt24nJGzyyIKNI+xttm1X7VoGPZiSdc3+AyllGQEUtq2ohHt
 NfTubYpFEYkVsj9SL6ucXm0t8WwUv98B65AZjQheYVNmijxwPMO8NT2DjQKcbLIEndPL
 krRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286871; x=1793891671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mCgbPzgmzkjrJ90WgvEpu49LYgOAawOzi/i2D+jOo74=;
 b=OF+Nq9R3SH2wKHhTZPGPzm0Bqqx8QNt3sY1OnIJtuxW1fM67gV3TFRR+8tZtzpcmW/
 XZoaDiattKBsUmRDQGZyM0MmfdW+lDO5/jj5g8MMWOewp+C4656sVbuXiXaHM0LtBUjm
 9HS7t7mRVbMcJWv8ylXzk8QHlXpD4l4HX3+h9FD5+o03yOobjCkIhBIXJmGH0UjvSFvE
 m5CDpXvzxFuEOsSg9cEJVsNUCkS8S0ylQpikOsKUXFIi8pkwZwb9NzmCI/TMTxm9feav
 XJX39JXJssQT9yZt6o/JG8XAQIVvw1sGiZG5FQocKJwXkVDBf/OwHaU+rPU2dyCOc+0j
 qcRw==
X-Gm-Message-State: AFq9FYKH8lYmp5w7g28JKMLoYK9JiY0OQFh7mamPkRmwZ6ErCl8EM57s
 VcxUhs88b0w3SJGmdpMp4Z6n9wgFOkQx07DBak8Ypi0P66q8EnDeMD48xYPFhS4FeAzM/rrb2DH
 uZNrEWgZV
X-Gm-Gg: AYBFou2dQMPQUe2L/aLvaL4nq3zjGjekEE8qcUTm4UoMlkAm9W3/7I+u2w3s6b3+R60
 j995Dhb0ZRoOF6D23n+uYYIqLO/GDmJHz/6v3xS3g9p9eEUsPeZXDrPHYp5scANsir6knWfBoR5
 9zfT+hxSuU+HPIZGyESOtu1GOdW49G68kNmm3cXYZQHV/W87ZunB6ESAdBBkuyKbDoEsDeZwt6r
 uV5Z0rNX87nlSIfn6IpDvnn40h60L9+PqljA2wulDTrOP4xhDCDmJLyel0iLLdRlh88dDF/rszm
 Gp1kfRbRIdWmAy/4jrSFPMbWuly3JxFfB1LyxUejtpeVGlc9lr1SiuJb+bJkJCquF1Xhoamgfnw
 GcjqZzwzN+2Z9djsCz7xfWo+dota/I5/oLx5DgsVEyxwCS0JGW/BJsitmGNauiB3Jv24+fLwTon
 opUYRr7cizscxXHgQCCdd3YxBdrXXTPl+OmL7MJ4hrrSUbbBwRGRdOCP+6Y+J/o2JT/YYdbUXpJ
 tIz71ovhvnH+nEOVd6X9g4t084dsdDQcU7pXOaZRxLw2p3bijXmk2ZUTapjEgdbLn4nC3LrtFyE
 x1UVrXH4fyYsguBKnlUKGD2k7Z6VWdDIp91KTnQc6I05XLJ+JD7xdNfJQkkepmYxzlTZVtQyQg+
 s
X-Received: by 2002:a05:600c:4ece:b0:4a2:1960:6db with SMTP id
 5b1f17b1804b1-4a9677ca10emr132657275e9.26.1793286870938; 
 Thu, 29 Oct 2026 08:14:30 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb851sm30191373f8f.26.2026.10.29.08.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:14:30 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: superm1@kernel.org, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/amdgpu: runtime resume dGPU on ACPI notify from its
 own node
Date: Thu, 29 Oct 2026 15:14:21 +0000
Message-ID: <20261029151422.56791-2-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029151422.56791-1-mike@fireburn.co.uk>
References: <20261029151422.56791-1-mike@fireburn.co.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On BOCO platforms the SBIOS can signal a display hotplug on a powered
off dGPU by notifying the dGPU's ACPI node. On the ASUS ROG Strix G513QY
the USB-C DP alt mode lanes are driven by the Navi 22, and the CPM
D3cold table handles the HPD GPE with only:

  Method (_L05) { Notify (\_SB.PCI0.GPP0.VGA, 0x81) }

Nothing in Linux listens on that node: ATIF is bound to the iGPU and the
dGPU node is not an ACPI video bus. If the dGPU is in D3cold when a dock
is attached it stays off, no hotplug reaches userspace, the external
displays stay dark, and the level-triggered GPE keeps firing until the
dock is removed.

Install an ACPI device notify handler on the dGPU's companion when BOCO
is used, and request a runtime resume on 0x81. Runtime resume already
re-detects all links and sends a hotplug event, so the new displays are
picked up; the device autosuspends again if nothing is enabled.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 31 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7974f9b7944f..deb63122828d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -641,6 +641,7 @@ struct amdgpu_device {
 	bool				need_swiotlb;
 	bool				accel_working;
 	struct notifier_block		acpi_nb;
+	bool				acpi_dgpu_notify;
 	struct notifier_block		pm_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper debugfs_vbios_blob;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 7f5abb03be1b..a4041f90b374 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1280,6 +1280,23 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
 	return amdgpu_atif_handler(adev, entry);
 }
 
+/*
+ * On BOCO platforms the SBIOS signals display hotplug on a powered-off dGPU
+ * (e.g. USB-C DP alt mode HPD wired to the dGPU) with Notify(<dGPU>, 0x81)
+ * on the dGPU's own ACPI node. Nothing else listens there, so wake the
+ * device; runtime resume re-detects all links and sends a hotplug event.
+ */
+static void amdgpu_acpi_dgpu_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct amdgpu_device *adev = data;
+
+	if (event != ACPI_VIDEO_NOTIFY_PROBE)
+		return;
+
+	dev_dbg(adev->dev, "ACPI notify 0x%x, requesting runtime resume\n", event);
+	pm_request_resume(adev->dev);
+}
+
 /* Call all ACPI methods here */
 /**
  * amdgpu_acpi_init - init driver acpi support
@@ -1325,6 +1342,14 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	adev->acpi_nb.notifier_call = amdgpu_acpi_event;
 	register_acpi_notifier(&adev->acpi_nb);
 
+	if (!(adev->flags & AMD_IS_APU) && ACPI_COMPANION(adev->dev) &&
+	    adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
+		adev->acpi_dgpu_notify =
+			!acpi_dev_install_notify_handler(ACPI_COMPANION(adev->dev),
+							 ACPI_DEVICE_NOTIFY,
+							 amdgpu_acpi_dgpu_notify,
+							 adev);
+
 	return 0;
 }
 
@@ -1344,6 +1369,12 @@ void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)
  */
 void amdgpu_acpi_fini(struct amdgpu_device *adev)
 {
+	if (adev->acpi_dgpu_notify) {
+		acpi_dev_remove_notify_handler(ACPI_COMPANION(adev->dev),
+					       ACPI_DEVICE_NOTIFY,
+					       amdgpu_acpi_dgpu_notify);
+		adev->acpi_dgpu_notify = false;
+	}
 	unregister_acpi_notifier(&adev->acpi_nb);
 }
 
-- 
2.56.0

