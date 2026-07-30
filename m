Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C67C5516D
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 06:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C65210F191;
	Fri, 31 Jul 2026 06:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ULcVlqnY";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED60210E141
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 17:00:19 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so98003a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785430818; x=1786035618; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8afrmJvJNjiQFgHKILdFDrH8vU7XVuTipqlZKwZMuTE=;
 b=ULcVlqnY1ZfVdyAHx3AlZim9liTHxYfV1mMmbaFhHG5jSiHNImrUEAXY8IAFzMr6/g
 9829vzJgZp4/T5EtB/wKDSwQ1xt6dv1R5JrvrIbd+6F6l6K/jr7Q8f4g9kxNPsB93S36
 lmOSrCSSIv2GOxtw6V1sLsHzw93UXLIlK3oyiJj6jyb5afk7jKNq82CMkuMm2TQNgR30
 tDswyG8FBVVeiebrSsJl+2kzpNN7ggjfFcBP7rpI82Auv59ziO+sSVrMhhgtlaX+oTv9
 z7Suc8srqPTPfZY05LpEfYYlibiDihGAy7OcrMzXzcLLRxenRmJjmk5baa2O2VVX3ucn
 eulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785430818; x=1786035618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8afrmJvJNjiQFgHKILdFDrH8vU7XVuTipqlZKwZMuTE=;
 b=G63EcwSexmLn9MlBw0m7+axWm2sezcmOpwa589IGfYduwU0PWkEul3Nf1IXOa1zE38
 DtEg4f+Y4HIalZLX91xNBiXb47K+r3sy4eDpWvm43MG/lmX31MhyqCkfroDl9Iq8rMVy
 YXS1WVtF57Pwpd+Uz8BkdFJgB0v3FrPP6KrvyQEdLSAdFkz6Fn4UqvvdOYiEnGFm7wDJ
 Qlpuz+OKHPuYAO4qekR0rPZUsTpgP25O40OqxPTty+1R4WOHUIoY0z2OOem4R/ZVVjUt
 23tiR9Y9/ine8z3Kd51t/oVFMXTNKEl5AZSFsilxJkPYdi+MOnOZm2Kt2zGtrBDI2QFk
 h56A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq03I24+2okLxHj56xDMYdTqEoO+fMJ95DghkW/x/sKQ9KY8ySAm3OanOMTHf5MG+EPuu2FwosN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOKkoHoSPl2b3vvlralf6URRB2dCxC5P8c4DQ0l6UHyf74JytC
 X7EggqgtStPdINwry5m7InaXZL14v5fm5MdKvf8jcEAgeRza0esHcm+H
X-Gm-Gg: AR+sD12BR+P3uwgtUSIqeFBZ9+sipiLPJGTv8KMH8bNEe+OWPDtkwTeKdpy8S3FzVgc
 XWaWIiaVPQg4zqJvWTiZrUIwP+evka+1+n588NnBE4IVjLLiXhM3hDSOyFrl9EVG9OJTni799vI
 kWuuhDixrgb7H9k5MshdORqSIRKh3wxYnkKcQ3LfNYlXjnSg1e38+LA4lmC8ZBvlb7rAY15kXr9
 GSFVCzHbAtf9V1seu1FMqdTSBgb3qBgMWpMWOm/N/AtWvOsCLeaiThsVgZDylrjS1E06N9ULqse
 GDsJYuJnBDkOZ8lfoJBKSB3WLe3prDVcv36hpoB6syMgAzXLh8+q9XTJV+/0Hhz0WVvfRSACqA5
 Vok/lcBmDEHZbknHQHWRPLE6hAlyYjseihBnfdxWZu6Tt4NqdJkLE6rJxPAE0+kbIoHvtCQS4NJ
 KXnjnFJZ2rImYLN4HXBK2lLmiHbufvgyyV0XsFDBGe8bpVk8TuLK5Fx33thA7aQ6G1ZmQ8fI0zI
 DmVAPKMVavAdOvNuzffU1C2Y56rX7VhmNnspU4K+ZUJL74J/xx+
X-Received: by 2002:a17:907:3e84:b0:c16:66dc:3abe with SMTP id
 a640c23a62f3a-c1fa54e8f31mr174712266b.28.1785430817965; 
 Thu, 30 Jul 2026 10:00:17 -0700 (PDT)
Received: from misharu.home
 (2a02-a463-a071-0-ee66-8497-94b5-6e78.fixed6.kpn.net.
 [2a02:a463:a071:0:ee66:8497:94b5:6e78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa851d4b7sm93725366b.4.2026.07.30.10.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 10:00:17 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Mario Limonciello <superm1@kernel.org>, Tao Zhou <tao.zhou1@amd.com>,
 Kees Cook <kees@kernel.org>, Candice Li <candice.li@amd.com>,
 Jammy Zhou <Jammy.Zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH] drm/amdgpu: bound ATOM bytecode cursor within the VBIOS image
Date: Thu, 30 Jul 2026 19:00:11 +0200
Message-ID: <20260730170011.28915-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 06:58:24 +0000
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

The ATOM interpreter executes bytecode straight out of the VBIOS
image and multiple cursor-mutation paths are not bounded against the
image size:

 - the main opcode fetch loop follows jump/skip targets anywhere
   (jump targets are u16 offsets that can point past a small image),
 - atom_op_switch scans for ATOM_CASE_END with no limit; a table that
   omits the marker walks off the allocated BIOS copy,
 - atom_op_processds advances the cursor by an unchecked u16 taken
   from the table itself,
 - the command-table base offset from the master table is used
   unchecked before its header fields are read.

On a malformed/malicious VBIOS image, these reads could run past the
kmalloc'd BIOS buffer and the out-of-bounds bytes get interpreted as
further opcodes/operands.

atom_context::bios_size and the corresponding amdgpu_atom_parse()
parameter already exist in this tree; this uses that existing
infrastructure to bound the four sites above. atom_index_iio() is
already bounds-checked separately and is not touched here.

Assisted-by: gkh_clanker:t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f280e2..56c8a17edea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1032,8 +1032,12 @@ static void atom_op_switch(atom_exec_context *ctx, int *ptr, int arg)
 	uint32_t src, val, target;
 	SDEBUG("   switch: ");
 	src = atom_get_src(ctx, attr, ptr);
-	while (U16(*ptr) != ATOM_CASE_END)
+	while ((uint32_t)*ptr + 2 <= ctx->ctx->bios_size &&
+	       U16(*ptr) != ATOM_CASE_END)
 		if (U8(*ptr) == ATOM_CASE_MAGIC) {
+			/* magic byte + immediate (up to 4) + 2-byte target */
+			if ((uint32_t)*ptr + 7 > ctx->ctx->bios_size)
+				break;
 			(*ptr)++;
 			SDEBUG("   case: ");
 			val =
@@ -1087,7 +1091,14 @@ static void atom_op_debug(atom_exec_context *ctx, int *ptr, int arg)
 
 static void atom_op_processds(atom_exec_context *ctx, int *ptr, int arg)
 {
-	uint16_t val = U16(*ptr);
+	u16 val;
+
+	/* the skip count is bytecode-supplied; validate before reading it */
+	if ((uint32_t)*ptr + 2 > ctx->ctx->bios_size) {
+		ctx->abort = true;
+		return;
+	}
+	val = U16(*ptr);
 	(*ptr) += val + 2;
 	SDEBUG("PROCESSDS output: 0x%02X\n", val);
 }
@@ -1237,6 +1248,13 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	if (!base)
 		return -EINVAL;
 
+	/* the table offset itself comes from the VBIOS master table */
+	if ((uint32_t)base + ATOM_CT_CODE_PTR >= ctx->bios_size) {
+		DRM_ERROR("atombios command table %d offset 0x%x outside VBIOS image\n",
+			  index, base);
+		return -EINVAL;
+	}
+
 	if (ctx->execute_depth >= ATOM_EXECUTE_MAX_DEPTH) {
 		DRM_ERROR("atombios command table nesting exceeded limit (%u)\n",
 			  ATOM_EXECUTE_MAX_DEPTH);
@@ -1273,6 +1291,13 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 
 	debug_depth++;
 	while (1) {
+		/* jump/skip targets are bytecode-supplied; stay inside the image */
+		if ((uint32_t)ptr >= ctx->bios_size) {
+			DRM_ERROR("atombios cursor 0x%x outside VBIOS image (table %04X)\n",
+				  ptr, base);
+			ret = -EINVAL;
+			goto free;
+		}
 		op = CU8(ptr++);
 		if (op < ATOM_OP_NAMES_CNT)
 			SDEBUG("%s @ 0x%04X\n", atom_op_names[op], ptr - 1);
-- 
2.43.0

