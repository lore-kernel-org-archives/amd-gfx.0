Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3EAC3600B
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 18:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DCFC10E169;
	Sat, 22 Mar 2025 18:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AbtuaBQr";
	dkim-atps=neutral
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 349FC10E15F
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 18:37:57 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7c5a88b34a6so298862385a.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668676; x=1743273476; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sNFp4oShbOWRMa/mdMDVibBhsy93UqMBwnqjHkbmNik=;
 b=AbtuaBQrf6BaY3ZbK44tH4fIUsswEUAhQOAs3clrGhn5pZegVXoRtWemkp0OkrrRSi
 EG8se9Z7fiuKClpvxrQXP7Y0nKuM9eNUcL/AK0PtmUXeqYdSU1vLVI/M60S1bdropElz
 m2R1kYnouqNEnfoRG87Og2X/cRqMc80fd3uzrKDc2FOUrH0joS58r5/0B78HnqZvp8kW
 6ldoFwuXBa1vhAr+z/Hty7vkrbRFyyBEd2GNVKR++DPkJMfZ0q3yMi6jEPDf8LBJJ3qC
 1BMWFJj4pq99IsaF9oq+esNleMaLCSrobKSkviPfcUUzD3pXiySC+ZDH3bsa6GbqyBFF
 f9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668676; x=1743273476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNFp4oShbOWRMa/mdMDVibBhsy93UqMBwnqjHkbmNik=;
 b=aIU6jzR4fVjlLeQBxLY2hFzFOgTw54wyqQEA6glmEjxZiCUKBrP361duiL4Ts3dE9P
 lR8WF7wtZRI5NECFjE9PWDQmPcO4/qILg3PSL1neKPXD4pSFRgpkR5D5+1miGFgnXbw5
 U2PdPEKetUB01eYZd7P7rUmj4l4z1TLRu30uWIpfVkhsGiI6wN5uLdnl6L9Rl5+WmlJd
 5J9MBBss1JtwvP0vgkNGB/h1Xv05kCAH/ZoFYmQkHvdAlIZmbA8BYOvwsOHmqWzmZdNW
 7llB4Zq//dAYhC6rlovvrXu/j8OWXfJq7fmF//TOzbQVRxd+BvtVg7xbftnURp3ju+Ci
 ls1w==
X-Gm-Message-State: AOJu0YwZOwK5k//0M1oO65+GBpDO1ezPE4Zj61S8YpsQCd6bI4Dac+9+
 /BngCsNySVWGlVS31sy29duVW6WFwBPCGsuiGoGYpDMUmW52l2AFMIcU2w==
X-Gm-Gg: ASbGncs3Uwd2NjkzGuWgNp8FLubGio09dyYmk3UqdpZHb/ZpLyoCfWKXT/rG4dyULUm
 vLoncwmz+j656v/BcY0+2ZDhD6ZondvDsQyvOkpfAKL7PoY37GhDsH4BHYXO9vUW5uK4RPs8942
 gUJqKIjZULbeKrSbvdD1s0RaDZbGe/tTarRyg/AfrkcX1bKlCwcbge3Zkm5/ATFEAYhEdVmFuWs
 d3kCs143ST5SexramX8fRn2dV5F1F9zW9b3e4WDlQJOia4cjoZ+g1do/F52DtlmoX6NmUVgNPmQ
 0S2vmjAPAvdLtoE3uxSoe4ZfSm4oTW6acQbzwv+NklS3lgcZp4O1evTopEUSUkU6Ojs34C0mO1H
 T9A==
X-Google-Smtp-Source: AGHT+IHvDP1S8Ckfdyk9qznc25ZJ5QWhWm83O3UnWnJ+hkvg13ziBX5ffIHC0BCtJA/R5ShX2hg+QQ==
X-Received: by 2002:a05:620a:bca:b0:7c5:9a1b:4f22 with SMTP id
 af79cd13be357-7c5ba1ffa70mr1263095785a.56.1742668676139; 
 Sat, 22 Mar 2025 11:37:56 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec688sm279895085a.64.2025.03.22.11.37.55
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:37:55 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: small cleanup to CIK SDMA
Date: Sat, 22 Mar 2025 14:37:44 -0400
Message-ID: <20250322183746.86002-4-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
References: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
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

Tidy cik_sdma_hw_init() by returning directly cik_sdma_start()'s result.

Keep amdgpu_cik_gpu_check_soft_reset() early declaration with others.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index e7c06ce7ffae..4289f437bef6 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -56,6 +56,8 @@ static void cik_sdma_set_buffer_funcs(struct amdgpu_device *adev);
 static void cik_sdma_set_vm_pte_funcs(struct amdgpu_device *adev);
 static int cik_sdma_soft_reset(struct amdgpu_ip_block *ip_block);
 
+u32 amdgpu_cik_gpu_check_soft_reset(struct amdgpu_device *adev);
+
 MODULE_FIRMWARE("amdgpu/bonaire_sdma.bin");
 MODULE_FIRMWARE("amdgpu/bonaire_sdma1.bin");
 MODULE_FIRMWARE("amdgpu/hawaii_sdma.bin");
@@ -67,9 +69,6 @@ MODULE_FIRMWARE("amdgpu/kabini_sdma1.bin");
 MODULE_FIRMWARE("amdgpu/mullins_sdma.bin");
 MODULE_FIRMWARE("amdgpu/mullins_sdma1.bin");
 
-u32 amdgpu_cik_gpu_check_soft_reset(struct amdgpu_device *adev);
-
-
 static void cik_sdma_free_microcode(struct amdgpu_device *adev)
 {
 	int i;
@@ -991,14 +990,9 @@ static int cik_sdma_sw_fini(struct amdgpu_ip_block *ip_block)
 
 static int cik_sdma_hw_init(struct amdgpu_ip_block *ip_block)
 {
-	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	r = cik_sdma_start(adev);
-	if (r)
-		return r;
-
-	return r;
+	return cik_sdma_start(adev);
 }
 
 static int cik_sdma_hw_fini(struct amdgpu_ip_block *ip_block)
-- 
2.49.0

