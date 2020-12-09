Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6CCC4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 19:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3182123AAC
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 19:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3182123AAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B98726E160;
	Wed,  9 Dec 2020 19:15:17 +0000 (UTC)
X-Greylist: delayed 1173 seconds by postgrey-1.36 at gabe;
 Wed, 09 Dec 2020 19:15:16 UTC
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A3DE6E160
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 19:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yv6BxB2jNfOzzyblrJkfMPvL7jtnKYgvUsrfnpVImG4=; b=kZ4H7y/OOSDSksOmqFR/3sWWwv
 +XGmNd3nmfF2ibVnD7zDRcSqahqoQ3JABAkCpkgHUvAL4IEnDrgKAJNiSusvLLaZ/3w0hVTJQWbzH
 FzOn4WzT6kwBYIq+hGc7KMRCtDdMcVWWDAn4gsvJuD0ysmWBfbjNBCwx/Y74EPqXqHEckp0qzuZjv
 ZDQzjw6gXy4XHEJAPW/Vyv8GK7k5lg5/X6A3B0RiYZ9fag/zPFEUh66EHG1C8ImLmfDaJoy7Aorz6
 tg91jyyM4fradXR/PswfsvirZvVm6hqwcejgFI31pDJkAClyx8sXxNII9X7eQMKwTJWagldMgLlCI
 xiyxbw2Q==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1kn4cm-0000v2-C0; Wed, 09 Dec 2020 18:55:40 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu: don't treat BAR resize failure due to unsupported
 requested size as an error
Date: Wed,  9 Dec 2020 18:55:40 +0000
Message-Id: <20201209185540.2032-1-devspam@moreofthesa.me.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:8b0:897:1650::2
X-SA-Exim-Mail-From: devspam@moreofthesa.me.uk
X-SA-Exim-Scanned: No (on spam.moreofthesa.me.uk);
 SAEximRunCond expanded to false
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
Cc: Darren Salt <devspam@moreofthesa.me.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On the resize attempt failing with -EINVAL, instead report an informational
message indicating that the requested BAR size is not listed as supported by
the VBIOS.

Without this, as I have an RX 5600 XT which lists only 256MB, 512MB and
1024MB as supported, I see
    [drm:amdgpu_device_resize_fb_bar] *ERROR* Problem resizing BAR0 (-22).

Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 355fa0057c26..d80ba03913a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1136,6 +1136,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	r = pci_resize_resource(adev->pdev, 0, rbar_size);
 	if (r == -ENOSPC)
 		DRM_INFO("Not enough PCI address space for a large BAR.");
+	else if (r == -EINVAL)
+		DRM_INFO("VBIOS does not support exposing all VRAM via a large BAR.");
 	else if (r && r != -ENOTSUPP)
 		DRM_ERROR("Problem resizing BAR0 (%d).", r);
 
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
