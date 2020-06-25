Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE57C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 22:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6393620672
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 22:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLhbc61G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6393620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A24E6E878;
	Thu, 25 Jun 2020 22:05:06 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C01B6E878
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 22:05:04 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id u17so6034948qtq.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lm7cg5Agd55IfjuGXuUl6h/Ar8IcvTTkpFVjwpt0Kas=;
 b=lLhbc61GMcs0jeIXjXRzQKplY1TqmDs0MrKHIYccAP/D9SvmMU+eh/3qS/Zv5jLvqO
 uxCn0pxen1QK78ltxFowv7M7yhm8vAWzovGyi25I9nKcd2ZScR89tnX2+cj9xBJ1bHmo
 e9qxBmvlcRUrjs4Qa083DSb8lL6jh/H4mrIT7XxN/0640VMBWBvKS1s6LJenfMCvKaM5
 FHxuCSsjdo7V2g0Ghj5u9CaOEQ4YQP4p3u9MNxcJz3oxxgdwdMgOLTJLuy19dTCPbL1E
 xGkpknfc+Zm0fY2YnjqbHcoo8ZM4PqupSb1AIHkzEC1MKmHd6h5+p5nimW9w/2c8mgGw
 cjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lm7cg5Agd55IfjuGXuUl6h/Ar8IcvTTkpFVjwpt0Kas=;
 b=OBeL4viyB8kvRph/g0k73uCGgo4v8KVzvj52VCe4iuSuUBsrmg9YZLtblnZ5R7ds8L
 SYb9HqHSCleT4Rs9EZgSStEVo90rQv8Vwwyz+qG5zCpgqlI08UJOvP0JVhIhNTIKR5ex
 1vlNn7p5WZQr3r0ejwu2Y9b1FqOqTbrT4qf5ztI0/iU7Gtg9JZCSZliWEBzrAcO/or6O
 6cInB+OigVKbuizS4H1TSM/El1g/rPEe6xYvsVc3QHSsvzC/Gn1U7bPn3gcqkRNQILMm
 nB0tmAbq12C7WZ6gIcIJ7DcZmNnzrsbs4kRZ+8EinI83d0jlWszDpaGiDmC+nY8bqyHq
 i4lg==
X-Gm-Message-State: AOAM533tZGrp77/AUigcgQrEjc7hzBGWqnV27vM5vopba3C/xD6FiwNP
 gdmF2FKiJ4Nb5qMppkWLHh3zyAZD
X-Google-Smtp-Source: ABdhPJz3+FnpdcQUlbBf5NaZGaXqHMsYGzukNqCzar9UFtpXYFQU0fw1qMw6Wi5Em8q8Q0Xwc6YBqA==
X-Received: by 2002:ac8:2af4:: with SMTP id c49mr32786405qta.42.1593122703243; 
 Thu, 25 Jun 2020 15:05:03 -0700 (PDT)
Received: from localhost.localdomain ([71.219.51.205])
 by smtp.gmail.com with ESMTPSA id x197sm6670885qka.74.2020.06.25.15.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 15:05:02 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/atomfirmware: update vram info handling for
 renoir
Date: Thu, 25 Jun 2020 18:04:53 -0400
Message-Id: <20200625220453.1367084-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200625220453.1367084-1-alexander.deucher@amd.com>
References: <20200625220453.1367084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for integrated_system_info table v12.  Use the actual
v12 structure.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 4b8aad1c0b51..1279053324f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -111,6 +111,7 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 
 union igp_info {
 	struct atom_integrated_system_info_v1_11 v11;
+	struct atom_integrated_system_info_v1_12 v12;
 };
 
 union umc_info {
@@ -206,7 +207,6 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 				(mode_info->atom_context->bios + data_offset);
 			switch (crev) {
 			case 11:
-			case 12:
 				mem_channel_number = igp_info->v11.umachannelnumber;
 				/* channel width is 64 */
 				if (vram_width)
@@ -215,6 +215,15 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 				if (vram_type)
 					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
 				break;
+			case 12:
+				mem_channel_number = igp_info->v12.umachannelnumber;
+				/* channel width is 64 */
+				if (vram_width)
+					*vram_width = mem_channel_number * 64;
+				mem_type = igp_info->v12.memorytype;
+				if (vram_type)
+					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+				break;
 			default:
 				return -EINVAL;
 			}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
