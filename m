Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A259C47422
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 09:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A66401126D1;
	Mon, 29 Jan 2024 09:10:34 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 751DD112726
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jan 2024 16:20:38 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-783cdbecfe2so68207185a.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jan 2024 08:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706458777; x=1707063577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkFK2+4N/mKaw8xs4tJly4vP7nov7ElLkbj/0fopy7I=;
 b=Ipbj5hjPwOh/FXniEogVH8F4uqrenERkbmXPAyZS4CE8XJ+zlaVqsv+7mDl1Rz2RQz
 3if5rm+fHrW86kjrmvAtn+2tYaysuaLMmAicIIck8AWBaMIaQlLOCJWoAE0tUOkn5aIZ
 Bd5AwE4zqDgo/ZXxwF/iEwN/CYh2jykT+LaS74UvQ/VLtCxPw9XFKBm4OjODqmpo+PYe
 K8giWXKTtyRByk0LBPp1C9VkkZg8W+qsfypR6VlpldJDFCK5Lc5YlnSMUKKlxGb0H2tU
 OGLjD6kR8JexXckO4BfKcTZV2MeJMbIPY/1JZ+rusz9o8npzDhAdi65w3n9Qf2ljZad7
 z74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706458777; x=1707063577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xkFK2+4N/mKaw8xs4tJly4vP7nov7ElLkbj/0fopy7I=;
 b=adS7p1uvEavyK+FE+MfhMqxrTvGLq5xPM5lWqkI+ikICis5107Q19Cg2VlMfPKdADu
 yjpYHTxhzumvR6pBOm/QT4/YLagy1HTxt+Du9M+fdxLAc48hKdmc/f3QDx7Cq6eL5L3J
 yuRsS+c6D0bZ/oLS745Ze8IjNu90R74z3U3OxVfvXSV2s0K7YvtGPmmZBoOOECobljl2
 aSvMLfMJFoledP73tQjKbjPd2Mk1WepIAJs100pxgE73+osQ/BHG4PXau68Bmg6NkuGr
 g5jkPo9PtcXsSMdaS0zNXjWuPFvlFSiH+Z4K6hmW+fOqtXLNMfhO+y7Ktb8+Gz932f9Y
 9RPA==
X-Gm-Message-State: AOJu0YyaHK50ZvD/yj4CElPwwNVLx3waKh3HQbTZuZlEY3KbaZAWYZ6q
 93E4cSk4kLgW3kBDZZO8Pe8V4ctE059KSG4umrwTYcLsq64gUaEEhq/G3XiY
X-Google-Smtp-Source: AGHT+IGFSgMVqucX22+edrfVWHvd0GKeHnqURs5EsjsKWLWMmLHl0S1nOPgjhJ5kFJoXuYoqOqEyvA==
X-Received: by 2002:a05:6214:48d:b0:686:9443:87b1 with SMTP id
 pt13-20020a056214048d00b00686944387b1mr6314250qvb.2.1706458777340; 
 Sun, 28 Jan 2024 08:19:37 -0800 (PST)
Received: from davidm-laptop.home
 (hlfxns018gw-134-41-187-249.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [134.41.187.249]) by smtp.gmail.com with ESMTPSA id
 a23-20020a05620a067700b007838362da2dsm2336155qkh.111.2024.01.28.08.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 08:19:36 -0800 (PST)
From: David McFarland <corngood@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amd: Don't init MEC2 firmware when it fails to load
Date: Sun, 28 Jan 2024 12:18:06 -0400
Message-Id: <20240128161803.1224103-2-corngood@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240128161803.1224103-1-corngood@gmail.com>
References: <20240128161803.1224103-1-corngood@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jan 2024 09:10:23 +0000
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
Cc: David McFarland <corngood@gmail.com>, mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The same calls are made directly above, but conditional on the firmware
loading and validating successfully.

Fixes: 9931b67690cf ("drm/amd: Load GFX10 microcode during early_init")
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d63cab294883..b0ba68016a02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4022,18 +4022,16 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
 	if (!err) {
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
 	} else {
 		err = 0;
 		adev->gfx.mec2_fw = NULL;
 	}
-	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
-	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
 
 	gfx_v10_0_check_fw_write_wait(adev);
 out:
 	if (err) {
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
 		amdgpu_ucode_release(&adev->gfx.me_fw);
 		amdgpu_ucode_release(&adev->gfx.ce_fw);
 		amdgpu_ucode_release(&adev->gfx.rlc_fw);
-- 
2.40.1

