Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B245FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 08:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA9810EA44;
	Fri, 14 Jan 2022 08:27:28 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4C010E5A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 06:52:20 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id x4so13953327wru.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 22:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+aCUMeN/pwTcI/jyjtGOazClrsdePBfCZ+NCC3aiwEs=;
 b=aUKBmK/6hNZ2b+ctMk82PTZdXNBuzhcJZQReqNLHaSdJsdLJ2NGTwLMC2Wk+d3NNNR
 clvqKdXxFA8IfvDv0yNh+ng/RUFL8rtFENQVe/VsHkEXo+BQDrQBqsMfMxOJPEU/op5N
 koDJuv5TGWxT30DxXrRc9FEPdCiHPakienRqWKbqfNxTKG5o+a4A8ZuRWz5CSE6Jr8u1
 tidDwMvOkZADGChPdI5d95nxtyHSaxu+961rz2oovYTeEiYtmywkoF2ZoKGrlH2RDbrb
 dDEjEsxHPjnhfMCI7etCUQLB3ehiSXuLPtMgXUUVoZ2zLpuGZbm57QJG0KJyDbg1YppP
 AwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+aCUMeN/pwTcI/jyjtGOazClrsdePBfCZ+NCC3aiwEs=;
 b=V00+dcJ3H7c0IO9kbS76l8W+dEYconeRCujK8pDGczYvTxdr3gvxa7Jhro6q/Sob3Z
 4kBN2nC++8uvbkM5lKAU9Ofjuz0kWpu30g+uxcOmuhmAbjREv1LPBWqCp73R/BRal5Zy
 n2bRdU8qu33C2oHqsXFA5ENfBK8wZDEj3Pm3FVhBkpat4oxhYjpmR6BeZa3Lmy/eSY5W
 TJtmI2Ar+TRo1OpFeCK7nCNBaQbb8pHGpLK8ox1CM0LLzxb77hu7TxUddMn26jznDixh
 V+6yO4ul14AyQZzgPNlJPbuUQ9MWVWazb3ZSgM7d57PHR7h7EP3qLXnirFVWDRDY+4lm
 LTJA==
X-Gm-Message-State: AOAM530vaTMOHH/sOEJ39KY/RZ/VsaM+s62+CXf4tMjVrhoqR0f9r8TS
 2EsgGoM7S20mogDccH/HejU=
X-Google-Smtp-Source: ABdhPJxfoWycRSPJTt9RbgHaKC2zlzA1CwchyupHnqyvPMjwVA1z+jBZI5L/jsmjtYSdazMaPF5WTA==
X-Received: by 2002:a5d:4343:: with SMTP id u3mr6705543wrr.504.1642143138969; 
 Thu, 13 Jan 2022 22:52:18 -0800 (PST)
Received: from lukas-pc.fritz.box
 (p200300f6671a9600e06cd1ebd7837a58.dip0.t-ipconnect.de.
 [2003:f6:671a:9600:e06c:d1eb:d783:7a58])
 by smtp.gmail.com with ESMTPSA id e12sm897903wrg.33.2022.01.13.22.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jan 2022 22:52:18 -0800 (PST)
From: Lukas Fink <lukas.fink1@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Subject: [PATCH] drm/amdgpu: Fix rejecting Tahiti GPUs
Date: Fri, 14 Jan 2022 07:51:41 +0100
Message-Id: <20220114065141.14506-1-lukas.fink1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Jan 2022 08:27:26 +0000
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Lukas Fink <lukas.fink1@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

eb4fd29afd4a ("drm/amdgpu: bind to any 0x1002 PCI diplay class device") added
generic bindings to amdgpu so that that it binds to all display class devices
with VID 0x1002 and then rejects those in amdgpu_pci_probe.

Unfortunately it reuses a driver_data value of 0 to detect those new bindings,
which is already used to denote CHIP_TAHITI ASICs.

The driver_data value given to those new bindings was changed in
dd0761fd24ea1 ("drm/amdgpu: set CHIP_IP_DISCOVERY as the asic type by default")
to CHIP_IP_DISCOVERY (=36), but it seems that the check in amdgpu_pci_probe
was forgotten to be changed. Therefore, it still rejects Tahiti GPUs.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1860
Fixes: eb4fd29afd4a ("drm/amdgpu: bind to any 0x1002 PCI diplay class device")

Signed-off-by: Lukas Fink <lukas.fink1@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9ec58bf74012..224d073022ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1903,7 +1903,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			return -ENODEV;
 	}
 
-	if (flags == 0) {
+	if (flags == CHIP_IP_DISCOVERY) {
 		DRM_INFO("Unsupported asic.  Remove me when IP discovery init is in place.\n");
 		return -ENODEV;
 	}
-- 
2.34.1

