Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59890C88E77
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 21:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB5410E314;
	Tue, 15 Sep 2026 21:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cq1LvBCE";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4043D10E2A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 13:15:53 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f9f7db0so51549866b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789478151; x=1790082951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4U3SB71ReF0ifx8bqGHa72DWklfVhQ9vcJBUaK3Uflc=;
 b=cq1LvBCEku282kaHiExfLKpyx24QxdLfwW7PZ9bP9NjPEqRRG+pYBXTfaEkTuSZ9qS
 c/Y/cvpq3ac2+m2EnMg6CC6gTAjPE1Fp7ktX/EyhzPTuaGloeI2+R1mdVo3GkE8Q7J2Q
 eJAm9al1cXO6M2V9HffjSoHlA+qyvS2R4GccKco+0HvxF5VeWX50ZtgYIQPieBMvd3q2
 KEWcdjtkTz2oHOeZxvtQvITFHRwPtqmRDqnSJt5+H3DL7PvU0AoQJ6L+eylb7TaL4Frr
 xKsMbOo+5pgslRK8vJ+EcIXY5JySXWMDBiNIDLXVDORA9jGVde0++W0eo64xgGCjhcjQ
 WObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789478151; x=1790082951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4U3SB71ReF0ifx8bqGHa72DWklfVhQ9vcJBUaK3Uflc=;
 b=wgoIdMUXVNq3wclpDwpkwzYrpvOSH1CXfYajWG3P17HTwOtq0yiSoVBlFvTd6lbqIh
 8cdbNTuWqb8OYdhXxbzMuy8Zjaw4XiQ9BJyfkyYk9ZF/U7TQM7lsFzFaMNhlyOLwoyoj
 PJub9XJ/6bdqf5QQq93YMtjRt58vNf13sqvy/iY0U/LIcPOfzIq9hQXGftmBHHLW+M1/
 TG9Zvl8wGWukTA4Oq5g8VpEcrFhbg5+DRVJq7z/kj9/uaq3AUVZ7CydJA9o/2ew9D/Ts
 xpJWnmzYpBFlRGW68A2bq8QvM7++NWvh7GLIw0QCIs9PBvsCpDBrRjkZG2SkJsT2GP8b
 YLrg==
X-Forwarded-Encrypted: i=1;
 AKwUvByGv8IdRYx7cjxpGA4JjdRUH6GxLXpfsJkEu4d/yOv9ZYyJgyTXge8SYxCZgY+pI9/HF7KD5jh2@lists.freedesktop.org
X-Gm-Message-State: AFuF++nbAKqHAvVnxZCyHGlpH6jlrEgYds9DXeFtwQC6TgHcVi0BQDwr
 NipTpBx0geAqiRgAXNWUmVYo0l4vzshCeSF0UkkF5e72FXKbKd1G6IMq
X-Gm-Gg: AYBFou3sTqHOgqJQW/8mv3PWjzQnpEVp8T7X1ROes8SgG/ov8TqcAWuZ3PJH6GrZN/C
 CakHldKdxa3LBjDDYC/aeUKd0xXPzAoiyXcmljmAq6K0Mme6JTz0RvldzgFt2GywGI51bFMauXl
 h6jDq4Pu7d0zCbPj200N0rzBeaKl6JGT/T8clrsPy6AFmqWnJCrTEICa9b68fr5peE6zLopthTO
 NtFZ4uFPvw+pEoswjC4Ey84TFcBvFaiYT2sm72jXOtfQwFeetDD6xgwyiXs9nZei+w9wFnUaazn
 qgsayJNioucprU21x9m5C0tGwIQcfi6xLbRfTrdG/Fi7O9SaOJTnQiodhJ+GslFrK06iDf/GCJA
 uLoGP8O8ibBaQLLD7LvghXWLIy7seI9zVcj0Oq1sq5dAM3Te72YE2qjQKFtV0NJvL30SD8v4vzq
 +yMgDaHtOCEroLwhD/LwAF9uTthYI2t82i/PmcHLiAoCsV5gBUl2Tm99lS64nbYxu8y8Ib0TEoG
 Uize9TPDFlR8HK5uLvX3FprOZ4exjsZmDm2fMdhQ/JqbC+3krKe+C8WGwtJ
X-Received: by 2002:a17:907:c1b:b0:c26:19de:9aec with SMTP id
 a640c23a62f3a-c29d79c7b95mr73457266b.43.1789478151079; 
 Tue, 15 Sep 2026 06:15:51 -0700 (PDT)
Received: from misharu.home
 (2a02-a463-a071-0-a3ef-793b-4960-e77.fixed6.kpn.net.
 [2a02:a463:a071:0:a3ef:793b:4960:e77])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2966066b76sm90275266b.29.2026.09.15.06.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 06:15:50 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, lijo.lazar@amd.com, Jiawei.Gu@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH] drm/amdgpu/atom: bound the VBIOS date, part number,
 version and build getters
Date: Tue, 15 Sep 2026 15:15:48 +0200
Message-ID: <20260915131548.28292-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Sep 2026 21:01:04 +0000
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

atom_get_vbios_date(), atom_get_vbios_pn(), atom_get_vbios_version()
and atom_get_vbios_build() all walk the BIOS image using offsets and
counts taken from the image itself, checked only against each other
and never against ctx->bios_size:

 - atom_get_vbios_date() reads 14 bytes at a fixed offset that
   check_atom_bios()'s minimum size (0x49) does not cover.
 - atom_get_vbios_pn() dereferences an image-supplied u16 string
   offset unchecked, then walks and copies from it with only a length
   cap, not an image cap.
 - atom_get_vbios_version() takes its search bounds from image u16s;
   atom_find_str_in_rom() already clamps the search itself, but the
   match is then advanced by a fixed 18 bytes and STRLEN_NORMAL bytes
   are copied from there with no check that this still lands inside
   the image.
 - atom_get_vbios_build() walks from an image-supplied config-string
   offset toward the ROM header; a config offset at or past the
   header makes the pointer difference negative, wrapping through the
   u16 'len' and passing strscpy() a bound far larger than the
   32-byte destination.

Bound each getter's reads, walks and copies to ctx->bios_size, falling
back to an empty string on a malformed image.

Fixes: 29b4c589b43d ("drm/amdgpu: Add vbios info ioctl interface")
Fixes: d6fa80266178 ("drm/amdgpu: Add vbios build number interface")
Assisted-by: gkh_clanker_t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e74253682929..fe9af26ccc11 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1445,6 +1445,11 @@ static void atom_get_vbios_date(struct atom_context *ctx)
 
 	p_rom = ctx->bios;
 
+	if (ctx->bios_size < OFFSET_TO_VBIOS_DATE + 14) {
+		ctx->date[0] = '\0';
+		return;
+	}
+
 	date_in_rom = p_rom + OFFSET_TO_VBIOS_DATE;
 
 	ctx->date[0] = '2';
@@ -1513,17 +1518,24 @@ static void atom_get_vbios_pn(struct atom_context *ctx)
 		vbios_str = p_rom + OFFSET_TO_VBIOS_PART_NUMBER;
 	}
 
-	if (*vbios_str == 0) {
+	if (vbios_str >= p_rom + ctx->bios_size)
+		vbios_str = NULL;
+
+	if (vbios_str == NULL || *vbios_str == 0) {
 		vbios_str = atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64);
 		if (vbios_str)
 			vbios_str += sizeof(BIOS_ATOM_PREFIX) - 1;
+		if (vbios_str >= p_rom + ctx->bios_size)
+			vbios_str = NULL;
 	}
 	if (vbios_str != NULL && *vbios_str == 0)
 		vbios_str++;
 
 	if (vbios_str != NULL) {
 		count = 0;
-		while ((count < BIOS_STRING_LENGTH) && vbios_str[count] >= ' ' &&
+		while ((count < BIOS_STRING_LENGTH) &&
+		       vbios_str + count < p_rom + ctx->bios_size &&
+		       vbios_str[count] >= ' ' &&
 		       vbios_str[count] <= 'z') {
 			ctx->vbios_pn[count] = vbios_str[count];
 			count++;
@@ -1556,9 +1568,10 @@ static void atom_get_vbios_version(struct atom_context *ctx)
 	/* find anchor ATOMBIOSBK-AMD */
 	vbios_ver =
 		atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, start, end, 64);
-	if (vbios_ver != NULL) {
-		/* skip ATOMBIOSBK-AMD VER */
-		vbios_ver += 18;
+	if (vbios_ver != NULL)
+		vbios_ver += 18; /* skip ATOMBIOSBK-AMD VER */
+
+	if (vbios_ver != NULL && vbios_ver + STRLEN_NORMAL <= p_rom + ctx->bios_size) {
 		memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
 	} else {
 		ctx->vbios_ver_str[0] = '\0';
@@ -1574,7 +1587,13 @@ static void atom_get_vbios_build(struct atom_context *ctx)
 	base = CU16(ATOM_ROM_TABLE_PTR);
 	atom_rom_hdr = CSTR(base);
 
+	if ((uint32_t)base + ATOM_ROM_CFG_PTR + sizeof(uint16_t) > ctx->bios_size)
+		return;
+
 	str = CSTR(CU16(base + ATOM_ROM_CFG_PTR));
+	if (str >= atom_rom_hdr)
+		return;
+
 	/* Skip config string */
 	while (str < atom_rom_hdr && *str++)
 		;
-- 
2.43.0

