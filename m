Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46F7C44515
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 19:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0AE810E023;
	Fri, 17 Jul 2026 19:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IKNOA3G/";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622F710E023
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 19:40:02 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-51c21495722so56729661cf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784317201; x=1784922001; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xHB5NxrD/rMftUaPseZlwylWwJtFzftjqDhuyU7Xe/Y=;
 b=IKNOA3G/vuPZ62SKIorrE6Kl0H515jQYORKBrpxaFyvA4SsVcxAOeJsUtqN3qd9OwY
 n+oqnAmHl8Ifq2d1C1/376PWK1d96XcC8+w+wqz+XcFFonUOLq8A8n/wIX1TT5vhOWEw
 UfHGyggjD2TEzW0H94svTp+OhhW+sLjlm44AWD+GeZy3RTEOHSScYw1jmqCLMcySvJG+
 SPaCdNmjn94QFoYX3FgB7wA4A9Wqh8Hb1fIaxcgv1p9c1acciCUiBZJINA9DTi8/iCWB
 lnxdfNLNzgFIzeQ8GV6YhOq/xTNrjLJdmIebeE0X/hd5MxrSrrbdgVM5UdSzxwg1F4lj
 wI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784317201; x=1784922001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xHB5NxrD/rMftUaPseZlwylWwJtFzftjqDhuyU7Xe/Y=;
 b=CWJ9Yox1PKWivb0fXgti4YCHxyZe1IrXiKeNRZpqM/EnMyo1UA6V315K/YWfk/r97m
 VO/3cSLAWo3Q6EHVDk2n8dZ9BbG8ZRHNvQC/pgaz2CK3KyoZiyoFYC8l05oR5+0YI3O0
 TlK/qwe1pwVz6JjRbz5lT3tuNErj8375PLY+r4llVs5PZkEH48YnSGfwN7CiqzQy1HdE
 jlFE9eFAJP87y3beFZka7VXeCoOUXfRIbXFCfean/FjOJcc0ggOosyKRQ/kPGCDAy7nV
 QHqF71pebb0JNLskCjgpEgmOST1Vt8IiDpehprM88BuNj7UNdD0uQ7T20/qNM43gVHV2
 iW5w==
X-Gm-Message-State: AOJu0YxHIH0mzjQfMySAPzs4OZQEhck8oAwp71uyMtURjwzP4Bzr0pwT
 aSlYzLPdstymPzE5BjhqI76L8qLib2omCx/QzqdGan9QslKIGGsC2T08iMIfsYvK
X-Gm-Gg: AfdE7cmsWdK+Nk9vXTi+5GFG2Op2BSQyUdMRWtwjTURmZRI4TZvHncdDJxh+zi0R5Gm
 wwIhMIomOMbY3pj3eTYjylqqKkD5xGa4AUcaq87RCoF/wWu92Vxu6v2wcTwKXNsuuSRQYujX+23
 Eq8uiBVz2sYDsJOsYS8sh4/x2wQfr8LkDPtXPf8Mc3Oi6S0dLtpe92OLRQBYzTVeoRhInOCg3mL
 LoeJs6HagSKaqJ/IAFbMg+B8q9A96YhMjbl1bhNxQurcvSoVe53uyRxRro98OklMURway//p573
 euhu1zi6XleQPkHCJBlCz4hNjvukT18uUxilk55zvBtuPnbTMsWPfhpuQamejelR6mjIQQgw5hA
 YjjzrBgejT9YqxivT+2M3XU2MrK0Ssk2x2o8I5iqgqbkKE1LFFw+4XwqDsg4qPlTN7f1wblTJ1R
 0nM0/CN6YMngl21aT11F8cvg==
X-Received: by 2002:ac8:5a04:0:b0:519:f420:d780 with SMTP id
 d75a77b69052e-5213c7e64a6mr39548271cf.30.1784317201079; 
 Fri, 17 Jul 2026 12:40:01 -0700 (PDT)
Received: from j0-desktop.szero ([32.219.251.147])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5214fae3268sm18796761cf.24.2026.07.17.12.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:40:00 -0700 (PDT)
From: John Olender <john.olender@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, mjacob@feralsw.com,
 feralmatt@pm.me, John Olender <john.olender@gmail.com>
Subject: [PATCH] drm/amdgpu: Add missing Polaris 10 PCI device ID
Date: Fri, 17 Jul 2026 15:39:15 -0400
Message-ID: <20260717193915.3431030-1-john.olender@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Device ID 0x67D7 is used by the Barco MXRT-6700.

Signed-off-by: John Olender <john.olender@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5362705143bc7..ce386c0e5a30c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2039,6 +2039,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x67C7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
 	{0x1002, 0x67D0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
 	{0x1002, 0x67D4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
+	{0x1002, 0x67D7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
 	{0x1002, 0x67DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
 	{0x1002, 0x67C8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
 	{0x1002, 0x67C9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},

base-commit: 04764d6c56dbf1efec626716b7b36ac121f014e0
-- 
2.47.3

