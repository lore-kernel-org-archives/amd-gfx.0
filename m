Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02500CA5FFC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 17:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AE510E161;
	Tue,  6 Oct 2026 17:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DqUYY0/3";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A9910E161
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 17:03:57 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c2e2db5e8e4so540354166b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Oct 2026 10:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791306236; x=1791911036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rwdhe5qGMBEsuNIYT4HuAZHYf0vlSVZa0lqR6n2VyUA=;
 b=DqUYY0/3EPtlyAT6yWCObsnw9zvIMF+7nW1l53tTJLTHkvm/uKEfgvD1ABMs1Ud7H/
 Krw60GcvIhBTOfCqCn0bSZ5bFDuZ7Y7rH4i6BfAJNhxL4tI+H736ua4332bjKVIxM/m5
 YyIbuWTnCfSraGKlqCZLzFmTlVMOKAPL2aNpeXbq0gAdB2K92x5y2FtR6Md7O47Ss8E9
 Ww1INZUj7QQHOH1fuvaRrsgM/VBgDYxePu1DJaRgIvhibdYRvfNHkM9ofUBlUpKccMWp
 ZnyqKAD66VCmbSWRxayWJHs7mGPwkTjg0iTOIGAdH2wkhsZm9z9//O2PiMKZucP0lHX0
 BgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791306236; x=1791911036;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rwdhe5qGMBEsuNIYT4HuAZHYf0vlSVZa0lqR6n2VyUA=;
 b=NcmMgL/3eFEKLqmeTHyIABQoK5nNrU322zdUK1GQWqyC4OBQHS0uebEn1YZWCAqz+S
 2PXGMQMIfUR0ogvoTKSLQQsOAHq/zge1sbweKZr9seIiJGWTH4WzeOidyrbsSVtL0xGR
 Rj5hJIJEd6llyaDi1q7sTuhzpqfno2tb+B6YMtoIrhYEjk20AQge+LdbRh7EEzHQVMbD
 5q4WsK8FeWkghb3R4WzTgEJ+1ukH2Ftuju9JFblH3AFmUd/bnLx5QFZYfOOvPF8SuAdl
 yJIF8zYKhWRozOdQz1NmVrPPZq42W+Zq3mVmALhmUR+3Q0XwJpTRiQqhwTA+fwPjvYOG
 OroQ==
X-Gm-Message-State: AFuF++nSRHRT8fkRmIQGIqTsq1GhxJbSxwugOKPD3oOpbCq3MHww9M/E
 pXB0G55YTJNq6K4zEZEcN3yeBV+numiSHdcH8TdsZ/fsVZBbeP/WU0o/wrV+Bg==
X-Gm-Gg: AYBFou3mZU1f9uTP2a+pkrgaKj+sww9JhAa4Xd2OS7GOuYNHtixC/Z+vnuXOvrmN325
 JHWbqlq42Z36af3OfemhjdnIiw95ict9YMOl9rITpzCWBLt7Mxl7UOj/uFI8w+/L/noIo5OwT/g
 AkLVFJjzJyY31A+/8UDssM5i+BzyHgS4OX2K4cAk1Cn4yo3ocb9yt0+KoPWUKOOXOvL3guc4MQq
 1DpgCtivO+Dkd+p/QSaZ53R1lh+tafIPvZA6kxLYZ12iLvjqvwdQzyLlmOsd3goF7aNV1vVzzps
 PMJYYd8CwV0u/CyrEj8pvESXiL+IefVaXuefdd4rbDqPDfKSSPox6uGQGYfIt4cSmojygKhJtPl
 5rQwnQrHZ1zJhQS7KByniVoaelQjUuSewGW83Krt4wSxU7CZI5uavgMGsVWtB2A5D5mPKMO/HE7
 UbqYXM33ILybzDJ92wRYFhl8gD+9uSGjEiTFSm2TTsKFJj2PzqcEUWPCE8Z3STuROwxovHgJVrm
 RPO1/M6JeDsS69h1GW2YISbKMbdkPQQJxTifN+CTDo=
X-Received: by 2002:a17:907:7f87:b0:c2e:513a:e964 with SMTP id
 a640c23a62f3a-c2e6ee82857mr1085318366b.49.1791306235499; 
 Tue, 06 Oct 2026 10:03:55 -0700 (PDT)
Received: from Timur-Hyperion.home (86FF63C5.dsl.pool.telekom.hu.
 [134.255.99.197]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31563008casm228200066b.47.2026.10.06.10.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 10:03:55 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Rosca <david.rosca@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amdgpu/vce1: Fix checking whether VCE1 is idle
Date: Tue,  6 Oct 2026 19:03:52 +0200
Message-ID: <20261006170352.26722-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

It turns out that the VCE_STATUS register bits that we
used to check whether VCE1 is idle are actually not useful:
VCE_STATUS.JOB_BUSY doesn't exist until VCE3
VCE_STATUS.UENC_BUSY seems to be stuck high on Cape Verde

Instead, do the following:
Check that the read and write pointer matches for each ring.
Check VCE_STATUS.VCPU_REPORT bits to check busy status.
Finally, also check SRBM_STATUS2.VCE_BUSY just in case,
although this one seems bogus on VCE1.

Fixes: d4a640d4b9f3 ("drm/amdgpu/vce1: Implement VCE1 IP block (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         | 25 ++++++++++++++-----
 .../include/asic_reg/vce/vce_1_0_sh_mask.h    |  2 --
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index b1428f5bbc81..38e21d1a3ebb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -47,6 +47,9 @@
 #define VCE_V1_0_STACK_SIZE	(64 * 1024)
 #define VCE_V1_0_DATA_SIZE	(ALIGN(7808 * (AMDGPU_MAX_VCE_HANDLES + 1), VCE_V1_0_ALIGNMENT))
 #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
+#define VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK   0x08
+#define VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK    0x10
+#define VCE_STATUS_VCPU_REPORT_RB1_BUSY_MASK    0x20
 
 static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
 static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev);
@@ -349,19 +352,29 @@ static int vce_v1_0_mc_resume(struct amdgpu_device *adev)
  *
  * @ip_block: amdgpu_ip_block pointer
  *
- * Check whether VCE is busy according to VCE_STATUS.
+ * Check whether VCE is busy according to VCE_STATUS
+ * and whether the ring pointers match.
+ *
  * Also check whether the SRBM thinks VCE is busy, although
- * SRBM_STATUS.VCE_BUSY seems to be bogus because it
+ * SRBM_STATUS2.VCE_BUSY seems to be bogus because it
  * appears to mirror the VCE_STATUS.VCPU_REPORT_FW_LOADED bit.
  */
 static bool vce_v1_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	bool busy =
-		(RREG32(mmVCE_STATUS) & (VCE_STATUS__JOB_BUSY_MASK | VCE_STATUS__UENC_BUSY_MASK)) ||
-		(RREG32(mmSRBM_STATUS2) & SRBM_STATUS2__VCE_BUSY_MASK);
 
-	return !busy;
+	/* Check whether the rings are busy. */
+	if (RREG32(mmVCE_RB_RPTR) != RREG32(mmVCE_RB_WPTR) ||
+	    RREG32(mmVCE_RB_RPTR2) != RREG32(mmVCE_RB_WPTR2))
+		return false;
+
+	/* Check whether the VCPU is busy. */
+	if (RREG32(mmVCE_STATUS) & (VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK |
+				    VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK |
+				    VCE_STATUS_VCPU_REPORT_RB1_BUSY_MASK))
+		return false;
+
+	return !(RREG32(mmSRBM_STATUS2) & SRBM_STATUS2__VCE_BUSY_MASK);
 }
 
 static int vce_v1_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
index 1f82d6f5abde..13c15c2138b3 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
@@ -63,8 +63,6 @@
 #define VCE_SOFT_RESET__ECPU_SOFT_RESET__SHIFT 0x00000000
 #define VCE_SOFT_RESET__FME_SOFT_RESET_MASK 0x00000004L
 #define VCE_SOFT_RESET__FME_SOFT_RESET__SHIFT 0x00000002
-#define VCE_STATUS__JOB_BUSY_MASK 0x00000001L
-#define VCE_STATUS__JOB_BUSY__SHIFT 0x00000000
 #define VCE_STATUS__UENC_BUSY_MASK 0x00000100L
 #define VCE_STATUS__UENC_BUSY__SHIFT 0x00000008
 #define VCE_STATUS__VCPU_REPORT_MASK 0x000000feL
-- 
2.55.0

