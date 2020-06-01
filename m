Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D38C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF632073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEBaAkAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF632073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99DC86E2E9;
	Mon,  1 Jun 2020 18:21:14 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 971736E2E8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:13 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id j32so8456808qte.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S0w7ibU9oT/N9ntQA5IFgUWfKLg38fC5+glqq0AbS4k=;
 b=aEBaAkAQ4WjgNoRhh4zy5EnG0vQwjTR3HIlLrz0/JrOLGj47mpTyDvsWZcWvZ2qNQN
 R/hGWc0yzzlXPGJprROZh+FM7m5eImagQQrUnaEt050g7VXZT8YVtUJU5yaSwaNLqIUn
 28HaKYuqD6haXkSkNaMKOHDYsI/8byigAd1VzaZlLfAtf53NXzbi6QQMZSXfV6jzbLHe
 ePTn/GaN3kA/hfrvmz540+K2i+DHaDcHwPuOuQxxs9sUZim6E+or9C0QUsqMWR31ZtqQ
 IPPgMuKTwipVhufw0vW730ViDrR1IXjS26Ix1wsyNOQ9F5berOJAGlzgTCtdq+BPTm5B
 HZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S0w7ibU9oT/N9ntQA5IFgUWfKLg38fC5+glqq0AbS4k=;
 b=ZYDoI6XKTuCGZrh6brcFq7XmmcLQwystTaCy4aKt3iDeat4sDoERoNRW1/NkhQfzbb
 VA3/KzRIcdPmR8mPUWHAucuyW7IgQIabtSrPoXKaZCPRTkmEGFJBcDnRK572BqN8cUNp
 1U4cd2VKhW+TtG5G8eR9+QJLww6YWCN9cSn4kDDUdyyL5fP3i4q/EYapMBGM/6+udYYL
 v5YlFrQoAhGs5yjkm/PQq+toE+5uYjtQaOV+KSh3mGyTeGvJp9Nw1Jhpj4wAGNE/tmTE
 x5IQkSPLbr8dUsXXfyOUWWmjp0c4tHQFfAKcz5bQR8tLlqxDsexFaC413ghup1oVO4Uq
 H4XQ==
X-Gm-Message-State: AOAM530r7zu4NmZzNMDud3W2LiI6vNpDy6+JeFyEYl3CU02UJr/ylL3r
 nO7NER3LKS0iCH4X175b1rQAxpa8
X-Google-Smtp-Source: ABdhPJzzVO2az9sHtv0f66hvStJ0v2iOhr0N/91vPpi1XZMd89yRuLi7yzxXMcOjU8rBx80/O5+lOA==
X-Received: by 2002:ac8:2dea:: with SMTP id q39mr23512193qta.2.1591035672625; 
 Mon, 01 Jun 2020 11:21:12 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:12 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 096/207] drm/amdgpu: support query vram info for sienna_cichlid
Date: Mon,  1 Jun 2020 14:19:03 -0400
Message-Id: <20200601182054.1267858-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

support query vram_module v11 and vram_info v2_5
for sienna_cichlid

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 58f9d8c3a17a..659d845dbebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -120,11 +120,13 @@ union umc_info {
 union vram_info {
 	struct atom_vram_info_header_v2_3 v23;
 	struct atom_vram_info_header_v2_4 v24;
+	struct atom_vram_info_header_v2_5 v25;
 };
 
 union vram_module {
 	struct atom_vram_module_v9 v9;
 	struct atom_vram_module_v10 v10;
+	struct atom_vram_module_v11 v11;
 };
 
 static int convert_atom_mem_type_to_vram_type(struct amdgpu_device *adev,
@@ -260,6 +262,26 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 				if (vram_vendor)
 					*vram_vendor = mem_vendor;
 				break;
+			case 5:
+				if (module_id > vram_info->v25.vram_module_num)
+					module_id = 0;
+				vram_module = (union vram_module *)vram_info->v25.vram_module;
+				while (i < module_id) {
+					vram_module = (union vram_module *)
+						((u8 *)vram_module + vram_module->v11.vram_module_size);
+					i++;
+				}
+				mem_type = vram_module->v11.memory_type;
+				if (vram_type)
+					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+				mem_channel_number = vram_module->v11.channel_num;
+				mem_channel_width = vram_module->v11.channel_width;
+				if (vram_width)
+					*vram_width = mem_channel_number * (1 << mem_channel_width);
+				mem_vendor = (vram_module->v11.vender_rev_id) & 0xF;
+				if (vram_vendor)
+					*vram_vendor = mem_vendor;
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
