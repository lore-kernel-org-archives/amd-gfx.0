Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B93CCF2C4
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2026 17:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A8E710E471;
	Sat, 17 Oct 2026 17:30:54 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D20A910E0E1
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2026 13:00:54 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6b1b22cd4b8so86350a12.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2026 06:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792242053; x=1792846853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=legVIwX3VgSLwP32JW35R05ueTk+mHVnvshzarqz/HQ=;
 b=stS3itZXw9w4mjOxSIVZske7T8tDwasqQZ2LkZIq/AvVv29ETZysEBLcgd1a4tQBqy
 ZK6Zyz6yqcCEmBvg62pJ/v4MV6D7OP9LbzPHPkcdhtnKSeBZ/46+zPz5DNwbYbdXOcuB
 3HiX1NVyvLHOfaDKp3ky/VtscscYhSHzrnxxUYJ220ViRNpghimPxXy5IxWvJs/aSE0C
 phbFLKS5E3Suo2q85gYhsisk7tk0yfHwJq03O3RPv1phXF6W0N2HcdozO39GG1C9t3cc
 TftByQnjlyHbjehAbFxt/FBf8J2CI+cD3x3KWbpn3EOwnBafGW7a9T6YXCVWE2qmVOnX
 fvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792242053; x=1792846853;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=legVIwX3VgSLwP32JW35R05ueTk+mHVnvshzarqz/HQ=;
 b=PD8OAmYvkNrw5FqsJiT5llOkx94pddFWJPHx4hJim0ylgP4g3VHyOBFFGjwJ88BSnF
 mH6OYnyZajvG/8Tu4QgN8A0+ba9cONipDjRd9yoblCNGFEXbUEqBbldYJcm5Sm9KesJQ
 NqNw2SSYzLtoL8lMAC7z6u3dxlxxwiJnnqeULwLc8xHp6ToCAHPapGJZoP06aUK3XYHT
 vuRN8MBsdz3mCl49zYxeBSJw8PAPWaWLgCR/kTYelj1JgMRSLvaKnPk7T4eh1DQSUaHV
 GEQdRIRB8JvDPrfXYDLu3vo30VqMpQ2Uoyh6Qxs4zI1OWtF3I0NYsXe0d2u8AbdIF64/
 Fc8A==
X-Gm-Message-State: AFq9FYKvdchGQhBlVpAM5gsYU6D82isFZDTBh/8YKNPP1SmwLHfk5ot1
 edw2L5LEy71RqPdAXfa/Vh8w90yOjEwfg86AXB32YxsIqr8JdzjqD+S3bP7kvx098Mz3bA==
X-Gm-Gg: AYBFou1CkdeNE8fmTawNYTPEsEJpy+zIqhflIZlV547LIy2z4hC8CIySQB/jCZxYYaJ
 qc4RFzJgIHlJPS2UwMCl1lGtx0C486igv913Uqwo6rdpGjcjKlCo56zIblQA+CiezLIrsyApNi9
 xttnmQR26Hmo1oFr214X8rZBkvv34yilOMaZZbdh0b1rBuwinQ4/GjFB4KE4X71j+sCt1BYRGDa
 Y3K1pGWK2Q3yGyw68yFjXMbf+o6XXZkeS3f89SCCAFR9JCk4gz7+eLo1jkVHubks5A/VY52ZV8I
 uHa0tHXRZK/HAhFXB/da/PRXw5o7FhtJVPHV9Luw4rUV8I1XWZmDqBOn2+MfW9BzOINu4gAM9F6
 3gj8ltVNRn1V0Esn9lP06xPLnkRyDwi/2m6OnmfetKDaZMzfGkuyNet4lmZWGI/EmkcM3kAocoz
 yqKKaaJLVnbGbZNJjeGmU764uhRWnPlyv7kjaHKv4jnYi87lhPSEa1rA4lMADBrCTTSQHDc8+1e
 C0JfDNLlkMUFNbHGGcKWQ==
X-Received: by 2002:a17:907:2d87:b0:c2d:bbae:703b with SMTP id
 a640c23a62f3a-c419b917404mr204323466b.2.1792242052720; 
 Sat, 17 Oct 2026 06:00:52 -0700 (PDT)
Received: from Nuel20.localdomain ([105.112.97.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c408e328780sm174827366b.6.2026.10.17.06.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 06:00:52 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, paulmck@kernel.org, rostedt@goodmis.org, ast@kernel.org,
 peterz@infradead.org, gregkh@linuxfoundation.org, emmaonana18@gmail.com,
 abo@medichon.fr, skhan@linuxfoundation.org
Subject: [PATCH v2] drm/amd/display: remove unused cgs register accessor
 typedefs
Date: Sat, 17 Oct 2026 14:00:46 +0100
Message-ID: <20261017130047.42080-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com>
References: <981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Oct 2026 17:30:48 +0000
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

kernel-doc reports prototype mismatches for the cgs register accessor
typedefs, e.g.:

  drivers/gpu/drm/amd/include/cgs_common.h:89: expecting prototype
  for cgs_read_register(). Prototype was for uint32_t() instead

Each of the four typedefs is used exactly once, as
the type of a struct cgs_ops member, so they are merely an
unnecessary layer of indirection. Drop the typedefs along with their
kernel-doc comments and write the function pointer types directly in
struct cgs_ops.

Suggested-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/all/981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com/
Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
---
 drivers/gpu/drm/amd/include/cgs_common.h | 60 +++++++-----------------
 1 file changed, 18 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/cgs_common.h b/drivers/gpu/drm/amd/include/cgs_common.h
index f40b6a03fe63..1750401c7d08 100644
--- a/drivers/gpu/drm/amd/include/cgs_common.h
+++ b/drivers/gpu/drm/amd/include/cgs_common.h
@@ -80,43 +80,6 @@ struct cgs_firmware_info {
 
 typedef unsigned long cgs_handle_t;
 
-/**
- * cgs_read_register() - Read an MMIO register
- * @cgs_device:	opaque device handle
- * @offset:	register offset
- *
- * Return:  register value
- */
-typedef uint32_t (*cgs_read_register_t)(struct cgs_device *cgs_device, unsigned offset);
-
-/**
- * cgs_write_register() - Write an MMIO register
- * @cgs_device:	opaque device handle
- * @offset:	register offset
- * @value:	register value
- */
-typedef void (*cgs_write_register_t)(struct cgs_device *cgs_device, unsigned offset,
-				     uint32_t value);
-
-/**
- * cgs_read_ind_register() - Read an indirect register
- * @cgs_device:	opaque device handle
- * @offset:	register offset
- *
- * Return:  register value
- */
-typedef uint32_t (*cgs_read_ind_register_t)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
-					    unsigned index);
-
-/**
- * cgs_write_ind_register() - Write an indirect register
- * @cgs_device:	opaque device handle
- * @offset:	register offset
- * @value:	register value
- */
-typedef void (*cgs_write_ind_register_t)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
-					 unsigned index, uint32_t value);
-
 #define CGS_REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
 #define CGS_REG_FIELD_MASK(reg, field) reg##__##field##_MASK
 
@@ -137,14 +100,27 @@ typedef int (*cgs_get_firmware_info)(struct cgs_device *cgs_device,
 				     enum cgs_ucode_id type,
 				     struct cgs_firmware_info *info);
 
+/**
+ * struct cgs_ops - Common Graphics Services operations
+ * @read_register: read register value
+ * @write_register: write register value
+ * @read_ind_register: read indirect register value
+ * @write_ind_register: write indirect register value
+ * @get_firmware_info: get firmware information
+ */
 struct cgs_ops {
 	/* MMIO access */
-	cgs_read_register_t read_register;
-	cgs_write_register_t write_register;
-	cgs_read_ind_register_t read_ind_register;
-	cgs_write_ind_register_t write_ind_register;
+	uint32_t (*read_register)(struct cgs_device *cgs_device, unsigned int offset);
+	void (*write_register)(struct cgs_device *cgs_device, unsigned int offset,
+			       uint32_t value);
+	uint32_t (*read_ind_register)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
+				      unsigned int index);
+	void (*write_ind_register)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
+				   unsigned int index, uint32_t value);
 	/* Firmware Info */
-	cgs_get_firmware_info get_firmware_info;
+	int (*get_firmware_info)(struct cgs_device *cgs_device,
+				 enum cgs_ucode_id type,
+				 struct cgs_firmware_info *info);
 };
 
 struct cgs_os_ops; /* To be define in OS-specific CGS header */
-- 
2.43.0

