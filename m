Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC1606A33E
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=VXYWJ++t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7CCD10F130;
	Tue, 10 Nov 2026 11:44:04 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD4910E168
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 15:52:22 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so15192555e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2026 07:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudlinux.com; s=google; t=1794239540; x=1794844340;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=y58qGbx1bt3ohAjkcIc78J8UW3dBJ8T2wsogW/UvgDY=;
 b=VXYWJ++tfX4w0m1lNCAeAdbFuSL/on35UBRSOXlLT5y24WIuVI4yTPf3eEUqAp9410
 q0pH5D370P6B/w/veSw/NXSiTd1DxkPQrq+My6XVGFIlnrwapZ3WIA2DlWqJVGkxC5Uk
 vIgnZhxVBab07nWaR2KKYsgzGba6kCd4F56DnDeX5pTQHbaNTpIy0ExfpnM5W5u+IKXx
 mAahvMKXk/k9Bp4TOPueRBKzlHmQsT13zFCaYHhP/SMr78NQzkY+wnBB6GHHPQvPvmJG
 mRQi4i2o79K/hePwNGnNyPjCO6wDwb5/sS9qYjpymt8t4WjVq74BrFGaAG/2dCt3TWSg
 lXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794239540; x=1794844340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y58qGbx1bt3ohAjkcIc78J8UW3dBJ8T2wsogW/UvgDY=;
 b=DBwJp54pwN/56gMAeA+P639N/uYhoiZd3c/IqQydIjmPPaSi0NGPLYvuOZNOlInwJ6
 vPNPPkcC9rqYImp1Z2BbXxGgSVggPXqJxU5SBPCfb+hZvKwMBhw/qAS51uFmsfYjGiZv
 LRRjhh8ke7iwo6QzTACY7oaueST9//k+Fuw2AjKiWlbtwyZPnDQLpPPFameB9knAM88b
 Gur6xkJtOkERHw2oOPiwZauaNUfqEh6FCCcLdbX6pOkrpOgHYYTQ9EeQJULF/laqXEvr
 maaSmURFMRkOJhdwVwgQAcHPqqqf1B3I/lh5qN3NMM9eFxwa7kR9Gtg89fKNJeqC8Imx
 Y1lQ==
X-Gm-Message-State: APuU4Z+kDhoTV3stKTY/0Wc2+QWb6KUEKl/07rAbVMrchWi/cqrkBp3a
 w3K5SGt6YZoGbqq/weINni4xP164/nJ7rZvNa+24aaFYTuLvaFVDS/y2FMZDJEA3WNY=
X-Gm-Gg: AYBFou1jkCQn8H7KhyVxyAG2VljHDQFF7R7hqCn1rNUQRIYO1xPXtbiJ2mmcZHCENwO
 zHmmwGbiTGtrnJIhZyMFGvNiTJyuA270Ct0YyzryZ3TwDqBTziJOxvFZlPgrfSLHu6O0Yn3D7kv
 ThwHXh2M6puvN+dgptN0LNyDThn9AvdtBM5Z+FkDjNoDREXCvc9zjOk/18j6p2eB1GQgNkqJcpB
 86A6pcUYcCzC1kOeotvqrUL9dy0YsYsNVFt0hsIoBaBxKuyBCBNg1a6j/5D5U0gvYs7lSIZ5RPa
 wJOQ5hLaNaKH3zJelltOa7O8B9/kqG+sa4J0xnOSVCL2TjytTIF5iSoxb/HUQfSfS5QecDwfBJD
 /LBneeQT8O0w7jc9K0H+F8icyGRNAXdvBQGNmrv7x3v5w29f90IyNo3K4pKPgZpyuiaY6tvMeKW
 3eAmzZWpjzDBpwanUqT24FymGh+uLu2YryO9ex06ShMb3UeElhQyzym3WMleELAdjAz+D99+7YC
 j5IQ9IPrCfn0oMS1om3cmbnhNk4vDgF8P9uvh8RxTrblzWqPF4LfOVjOHLe2L4ZHGflYo5geoR1
 Q5wi0Ok1GsyxBvQUQ6eNCNif
X-Received: by 2002:a05:600c:4eca:b0:4a2:5267:3cd4 with SMTP id
 5b1f17b1804b1-4b94d762f4dmr78506415e9.3.1794239540400; 
 Mon, 09 Nov 2026 07:52:20 -0800 (PST)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b9f93c04afsm91196685e9.3.2026.11.09.07.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 07:52:19 -0800 (PST)
From: Andrey Misiurov <amisiurov@cloudlinux.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm/radeon: Bound GPIO I2C table entry count from VBIOS
Date: Mon,  9 Nov 2026 16:52:15 +0100
Message-ID: <20261109155215.3946844-1-amisiurov@cloudlinux.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 11:44:03 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

radeon_atombios_i2c_init() derives the number of GPIO I2C entries from
the size field of the VBIOS GPIO_I2C_Info table and stores a bus for
every valid entry in rdev->i2c_bus[i], which has RADEON_MAX_I2C_BUS
(16) slots.  A table that claims more than 16 entries makes it write
past the end of the array into the rest of struct radeon_device.  A
size smaller than the common header wraps the subtraction and the loop
walks far past the table.  radeon_lookup_i2c_gpio() uses the same
calculation.

Reject undersized tables and cap the entry count at
RADEON_MAX_I2C_BUS.

Fixes: f376b94fbc0a ("drm/radeon/kms: unify i2c handling")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>
---
Found by code inspection.  Not reproduced at runtime; it needs a VBIOS
with a malformed GPIO_I2C_Info table.

 drivers/gpu/drm/radeon/radeon_atombios.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 3dd9724..c4e1272 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -125,6 +125,22 @@ static struct radeon_i2c_bus_rec radeon_get_bus_rec_for_i2c_gpio(ATOM_GPIO_I2C_A
 	return i2c;
 }
 
+/*
+ * The VBIOS table size is not checked against the image; cap the
+ * entry count to RADEON_MAX_I2C_BUS, the size of rdev->i2c_bus[].
+ */
+static int radeon_atombios_gpio_i2c_num_entries(uint16_t size)
+{
+	u32 bytes;
+
+	if (size < sizeof(ATOM_COMMON_TABLE_HEADER))
+		return 0;
+
+	bytes = size - sizeof(ATOM_COMMON_TABLE_HEADER);
+	return min_t(u32, bytes / sizeof(ATOM_GPIO_I2C_ASSIGMENT),
+		     RADEON_MAX_I2C_BUS);
+}
+
 static struct radeon_i2c_bus_rec radeon_lookup_i2c_gpio(struct radeon_device *rdev,
 							       uint8_t id)
 {
@@ -142,8 +158,7 @@ static struct radeon_i2c_bus_rec radeon_lookup_i2c_gpio(struct radeon_device *rd
 	if (atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_offset)) {
 		i2c_info = (struct _ATOM_GPIO_I2C_INFO *)(ctx->bios + data_offset);
 
-		num_indices = (size - sizeof(ATOM_COMMON_TABLE_HEADER)) /
-			sizeof(ATOM_GPIO_I2C_ASSIGMENT);
+		num_indices = radeon_atombios_gpio_i2c_num_entries(size);
 
 		gpio = &i2c_info->asGPIO_Info[0];
 		for (i = 0; i < num_indices; i++) {
@@ -176,8 +191,7 @@ void radeon_atombios_i2c_init(struct radeon_device *rdev)
 	if (atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_offset)) {
 		i2c_info = (struct _ATOM_GPIO_I2C_INFO *)(ctx->bios + data_offset);
 
-		num_indices = (size - sizeof(ATOM_COMMON_TABLE_HEADER)) /
-			sizeof(ATOM_GPIO_I2C_ASSIGMENT);
+		num_indices = radeon_atombios_gpio_i2c_num_entries(size);
 
 		gpio = &i2c_info->asGPIO_Info[0];
 		for (i = 0; i < num_indices; i++) {
-- 
2.43.7

