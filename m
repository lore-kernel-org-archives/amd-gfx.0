Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE88EC55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B46210E6DB;
	Mon,  3 Aug 2026 13:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XcUyfhlo";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58F0910E6DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:23:24 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-69c1220bd51so5070088a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785763403; x=1786368203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JInteY48y8f73gtOAnfAEV53MBN8yaSqKSC36ft+Aj4=;
 b=XcUyfhloyBo1KjZueVdeEkW1uKjeD+/78gjS3CC/EQp/0sjeDqbPX3NzYKN8nHyd49
 d94JE1++0oZnLbZqDOTjkOOptLObiUa3Dt8TpWYLBIMaSqWX75DJUvZGv6SDduTeMpj5
 BBL+nJyvACvB4+ypsxtoSpFEqNIEcNk71jYdbYxHk0HxL8U3U/w+MjGmBqnyYbNH6ZD1
 Vvi7hmy93UBTqow7mZg0q0sig3dVCODPuqy6BKRb4tHXfNWyANNVePxUrJ6sK3DxAQ+5
 AjfgVtdiW88dmNMkYCGeU7c+6G3EKYI3SRe7dmYXNeEZS98IKrijCehZXes/ASD/j9GM
 KydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763403; x=1786368203;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JInteY48y8f73gtOAnfAEV53MBN8yaSqKSC36ft+Aj4=;
 b=ogIiYkNc9VRUua5i4y0T1nZbrkVXi/xlyB7pYRLdHHIEoUlGsrUqFed7nxYb8fhycq
 Orj81fKxQZJjKw/w9WSI10YVSsTvekxtJBEtSIEozhdM2E+ax0iIrnGUjy4Wc64eV5QK
 xt/4kwP3kceKC7HuSLW54lvp8PWho3ffdXMLHEwvdzJ3CmjqEGoqJOE+NgGtR78FFNZ+
 tMWVvAM0cD+u4SEjIaCZC8WU6IrZCfHJjo6SGrwkK8raayYqTuMhvyIcGx7CdmOoVKUx
 lzBq9JRKrL7P3scW4/FDL/HGIxyFRGJo/TeH/L+lUZYBepwRgJiPRhVZHPfNtfSf3Hh7
 Fbiw==
X-Gm-Message-State: AOJu0YxBetgIcWHnA/g9w5jOPS0gxj1VRsfBJwjJUPhdzm4UMnT+BSt4
 3jVbDBU5NWEAjf3kKRQ/98RLxvwKiUQ5XVXJoCKqEmC/g6iN5DYoPUQVh31Eb3WV
X-Gm-Gg: AR+sD11v7CukUvFeDQPv/w20A69vPQiPvUFCrJobte0zVqjM8LvTEzOI20txEyqEc/+
 SqFsgf/fCnjnoBKGAKQxVdzKZ334jMKjNMgKFv/NG0mqz8Zpj9CRBrmedlCx9U19qdxmTTtoUg9
 ijN2pk8P9Jg9knGncJdQb9NfVaPEKf19KZ1rR/kJng0dml2pvNPSQGoXNkgEkoFXcHRBtmbUJna
 LF3MlEuCcQ8yHzTBKJcUqwxFeLZXEi6jO5UxJMzSziWjySCFi/Xyy/m1+ucCJoh9gAh+lXXgIE4
 b8KPH2BlRa7qpDa3EC+oAywdqxn9MH/XOwmFnWGqejxzPNJFnfAij3OLHECLyNAUIL7ZmGTQsfh
 T22PyPKR8Dk/grbK0bbPxto0v6HoewwkLnaxMfRp+fylKuK0GLmyNxir3HMvNcGhyKjgJwQr/ih
 KLmK2Ii/pKJ17MUWaGxGS1cRn8K9khLNl8xaxpYfVzkaVNtPYqrNsrGNsta9GRdmVeCzFebrLQA
 wIkMkIbSUa/nuUoEHSomE+SvjMbnqjP
X-Received: by 2002:a17:906:d8c3:b0:c12:b227:614b with SMTP id
 a640c23a62f3a-c1fe80d4099mr674841466b.27.1785763402665; 
 Mon, 03 Aug 2026 06:23:22 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd445432dsm549201266b.41.2026.08.03.06.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:23:22 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 10/10] drm/amdgpu/gfx6: Enable IP block soft reset as a GPU
 recovery method
Date: Mon,  3 Aug 2026 15:23:09 +0200
Message-ID: <20260803132309.36326-11-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803132309.36326-1-timur.kristof@gmail.com>
References: <20260803132309.36326-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Enable IP block soft reset as a GPU recovery method for GFX6
graphics and compute rings.

This improves current user experience on all GFX6 chips.
The current GPU recovery method is a legacy ASIC reset which
always clears the contents of VRAM, which means that a buggy
(hanging) app can crash the whole graphical session, which
is less than ideal. Also on some GPUs the ASIC reset causes
the GPU to fall off the PCIe bus so it's not desireable.

Using GFX IP block soft reset means that we can now
move on from GFX hangs on GFX6 dGPUs without crashing the
whole system.

Tested with the "hard_reset_cp_wait" test case from the
Hang Test Suite created by Natalie Vock and Konstantin Seurer.
This Vulkan testcase waits for an event that never occurs,
effectively a WAIT_REG_MEM packet that intentionally hangs.
IP block soft reset can resolve that hang and allow
the rest of the system to move on and keep functioning
without needing a full ASIC reset.

Tested on the following chips:

Tahiti (FirePro W9000, Radeon HD 7870 XT)
Cape Verde (Radeon R7 450)
Pitcairn (Radeon R9 270X)
Oland (Radeon 430)

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 6de58e85a3ae..563abcf718b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3230,6 +3230,11 @@ static int gfx_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.compute_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
 
+	if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_ip_block_soft_reset) {
+		adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+	}
+
 	return r;
 }
 
-- 
2.55.0

