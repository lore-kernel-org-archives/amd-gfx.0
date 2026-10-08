Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF9CCA600A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 07:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CB710FCE5;
	Thu,  8 Oct 2026 07:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e8y27gnd";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88FEF10E509
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 05:44:37 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3a80e169311so1921018a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 22:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791438277; x=1792043077; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QcVgsc0uGYC00/BSDF3hnxQiScfRE7UF6CYpeycsh/E=;
 b=e8y27gndYJu7ZBYT++Cxt0nQcPtLM06YQMH9VIJ8Sj6zTf4qDNmDcNWaZzn0Z2qnVT
 /vIu39RGE/cnkSK8H/hsIsBiMbDQKVlU+lQGx/7thwbjD3NjSoWI0wErVUB7p2e0Fa+j
 BDOAQVrT6+TLmI9ZIIMdEIR13aCTKKHzMKUfab8p2m17zUHfBYZJjRltjAtkXI5td6km
 Af7pT6Oh+FHzA7PWh0KiGzJPxvBOLHSXt7g1Mhli1X0ZfcHhsyITKN8n0X3H2NbkhBNk
 HogdHuqi8wwgWi/yz4EgkAOhgpEVAF+GdCW9vFntSZPiF6Yw3rhbcSFXFyDLNzd4hSZy
 883A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791438277; x=1792043077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QcVgsc0uGYC00/BSDF3hnxQiScfRE7UF6CYpeycsh/E=;
 b=BHxxk9xoO1mY+FwHZzQo9s8eits2A3ZXdc1vuZ8631yDYF3/zPxMXMU5pDG/PEBTZG
 gg3EzF1XSEelBOgqZ/DcjBVUQEKqYdxj67YM/m6gJSM+h2py4rnUdcorhji03rRhxgss
 c5OAdFxOXesk+K+SYwdTBag6F8991mzHB272A3TbFaXaJMNsTOmkKglK9acJG85IGXtX
 wgTWJRPtHdItmXtTbMwSHIXEbGxIMkXi9G32ymXyzUhrbsBreubGFjmWeCgXRZD6YuGe
 rRZQ1x4wKDTw3r9tF4RnxWwsnldar7kTXGi51BjAjwz7t/j+Dty6+xJUuXcf+Oc3Gv9K
 XuEw==
X-Gm-Message-State: AFq9FYIejYtvTvi5rpisULyz8z7oQJDn5O1qFdHrfQ0ma9gyZFJpdc7B
 uxDPPwgiAFfnbyZGcnK2iEXQ0Iy2ijpSOrKEMlDunjHJUf2mQSsnNdy+MNxYtw==
X-Gm-Gg: AYBFou2JOlCBerHXynryC2N1HsL0NWOWVXX4G9ts0VIjlSHfRPZeErinm10gublU1pD
 YRMQq6Eo1BfHi9kpuuetTmbEL1Jtx6chORZJT3AboovuDmUm/a50aB+2y00uFH9iclRESr1IiwS
 9uUsfgm9f1/8CtYzpWBj/nRo/cZ/uadje8MLYhBPqlDu7VoA+h/JvhOh5Qn7XFxdT5NZWq/SThT
 qy5mox92MO0tnhL9PgJOqivCot+K7n6jE+OLlnRDKSmk1POrvCT/9Fipm+HGyzMcvSVxw5q6BFd
 v0EEux+bPw83gszWlj60TuH5AS9EgvhD+S4gmgkhb9uWsUSsqg6daPZH4b4X7Y9CAS/HTFpfAnX
 PWkEWBFgBykOy0tWMW1aexLH1UwEmS8BbYIxAFGPzVWRhRyrRN/VUSN+RPwjtNhTdGgTBKR5Ey1
 AoeAQsosZtINv7o3qkYAmFqrzgKwJF3BTgy8SI8Jy1CbFQauAIE1kml2CdE5rFV19cRjjEdY4E3
 0EYCG336ZcLIYh4ElS0OA==
X-Received: by 2002:a17:90b:2e46:b0:3a8:1ffc:391b with SMTP id
 98e67ed59e1d1-3a8a117577amr3013534a91.43.1791438276987; 
 Wed, 07 Oct 2026 22:44:36 -0700 (PDT)
Received: from jzy-20260924VRH.localdomain ([180.152.50.90])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a9f1acbd74sm3170712a91.9.2026.10.07.22.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 22:44:36 -0700 (PDT)
From: XF <xffffffffy@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: xf <xffffffffy@gmail.com>
Subject: [PATCH] drm/amdgpu: Drop eviction lock before freeing PD/PT BO
Date: Thu,  8 Oct 2026 13:44:29 +0800
Message-Id: <20261008054429.1873-1-xffffffffy@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Oct 2026 07:43:00 +0000
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

From: xf <xffffffffy@gmail.com>

Fix circular locking warning with drm_buddy allocator.

Signed-off-by: xf <xffffffffy@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7d3659ef11e5..2a4f8d365271 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1252,7 +1252,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		tlb_cb = NULL;
 	}
 
+	amdgpu_vm_end_critical(&params);
 	amdgpu_vm_pt_free_list(adev, &params);
+	kfree(tlb_cb);
+	drm_dev_exit(idx);
+
+	return 0;
 
 error_free:
 	kfree(tlb_cb);
-- 
2.34.1

