Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3924C47409
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 16:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921882465A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 16:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCXMbvvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921882465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C6F6F5EE;
	Wed, 22 Jan 2020 16:46:33 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921D16F5EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 16:46:32 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id e12so71158qto.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 08:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FfRxljJ31Sd+AeC0qSUPKG+paZc/yJ8HP3fHKX92efA=;
 b=PCXMbvvNV9b+uf7RZN5MfRgq07EluunzfBEtFSIw7dXDlg8gi2SjD+41nn6JCsVZlD
 Ejqwt1qvoU4fgBbRSiUXGxyIaeOF59sGQ4g+sqw/mjhxEcC6WZne2aGwp1348IFNXhwn
 nl9JWw0BBvO6H4MQXyZMm5VpHDJ/23r9HnKY2bNMA6Y7yppO0KMupnpoSsMJ/vJnI1xF
 qczG5T5pOG+QCxnzD4zcyQu4RirdCiTIKJ+yMvl8MIZDT8A/Y7tFXRc+jqxInEA5FUme
 0xHwmuVSebPV1L20h4PupYsgXHThYedNrBQQaqXj9ngUAALJ31//Ug3D3yspwqbZh3fk
 GjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FfRxljJ31Sd+AeC0qSUPKG+paZc/yJ8HP3fHKX92efA=;
 b=GgQjeMA+VVyN+Gixlt5AoFenoz3+TrrCUV7YBO4MJf8J8bc2QMUetWLI1pe6Y8BXao
 0D03BdkbNx4fw9ajE0jtN1hEmJWZA2uL6fgeqUk0KkkU3f+vhetSBW79ba0TcJ1VIZax
 ubI7fPGQY3zPhW3OvE6876nnEMnMgQGi+DQ0Fj8qTW5y/2i9La+Il02kADf+C9l9448U
 fK2hFKfCRsdSs5wMSww8cvhs0oskZcWccBieM7fG0drgptpRnoVAx727uDzwDs9MSzZn
 ix/5zKjVcw3Z1+ro5vAhEaNs6nobxxeRM9lzjKXMexkPgNQTfYmzu4WVh0X4AO8nffXn
 CR6w==
X-Gm-Message-State: APjAAAVEY3GkH+yro6fB6YJwzN2dkn7ZLzzwujhM3w7ojVSUpaL6WNrv
 FW8u/2gAjJoJ8sI3sVE2Z5eVW/Z6
X-Google-Smtp-Source: APXvYqybuAjuAGxVwMNwjjerbnIXlhxGmJp2WJHnj1jjo0nLCg8DdJaUqVnd/pMc7RzgoWZBPD8WHg==
X-Received: by 2002:aed:3ea7:: with SMTP id n36mr11352926qtf.258.1579711591248; 
 Wed, 22 Jan 2020 08:46:31 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id f42sm21400921qta.0.2020.01.22.08.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 08:46:30 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove the experimental flag for renoir
Date: Wed, 22 Jan 2020 11:46:23 -0500
Message-Id: <20200122164623.239931-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

Should work properly with the latest sbios on 5.5 and newer
kernels.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 01a793a0cbf7..30a1e3ac21d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1004,7 +1004,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x734F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI14},
 
 	/* Renoir */
-	{0x1002, 0x1636, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x1636, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
 
 	/* Navi12 */
 	{0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12|AMD_EXP_HW_SUPPORT},
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
