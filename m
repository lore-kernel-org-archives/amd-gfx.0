Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F13606A31F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VLf3APqW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B5A10F352;
	Tue, 27 Oct 2026 09:34:12 +0000 (UTC)
Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE0D10F1A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 22:46:40 +0000 (UTC)
Received: by mail-wm2-f2.google.com with SMTP id
 5b1f17b1804b1-4a210b0d5c3so12639055e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 15:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793054799; x=1793659599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uLTFgSWVH5PgtNiCYE4Ye5g7oFVHKv8jMWdCl4mPxv0=;
 b=VLf3APqW55gkOsYU6DorkLmOhaAU2l4BUTtp9u5cgHC/vlraFP6iGLcnL07W9o01yG
 ovUN3rozWTL+JmST6of9dAxLIu2EM2NLn86IebKMHiZuw0bbNHcWQpE0uINUyIMiL+xQ
 arQCMgrijcBCzc8JA8x6opbQuBjQx1OKZHNeWQZoA3KoktxrQVQ6p2pdrJDKl50CQ9ex
 ZAwivUApm9GxJw4dsMr07eU4zFt3DelH6hq52jXZiJerxSLkZFMlCe+o9G0fATWcrnPH
 +vIerM+ZUtjNA39NbKrDxwXYV9EMj3shbXl9nnRo5Cu8gCMCsjXY/5mj+/6MbpeBuVO/
 JBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793054799; x=1793659599;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uLTFgSWVH5PgtNiCYE4Ye5g7oFVHKv8jMWdCl4mPxv0=;
 b=sU3/kDEb1ODlBWgTiodvRiE5qa1ENNvE+oRnw0TRhD4aRpk+sl9L9py5oMpjFHnSuR
 DkF9ZHmIVUl1xSLcYfZRqwOrAVJELwS72fUwwbEk0W8syhBSAgqm0rXYtHukF26/S4jw
 lp22xRy6aVSi7WAvgFciLYc6yv7yVo4Id64YHk6CNOp90nvdgmJ7ZzkkArUp0sDPkiJk
 TX58ooZYSzRd/JmhQdUDnbB9dlxezUsPE0poNzcJWiOFLUyD/uaLJoBBo8mRUzDvGYwF
 22oP7fKG2W9REe3kp/8ktTlORqnBXby36hyG7OEiuWJX6RIiebmiVMb3+Ge4v98JDDHc
 n0vA==
X-Gm-Message-State: AFq9FYIBHam2dDn+t7ws068q0F2RVg0cRhtpT2dvbkTqPmNymoLTtKZB
 fheHUIzIBQEN1wA7Dd59nrC6fcyrWqZvmCC1x7LpPWoUDDW1eJF7uYB1+K2oT38SvdMML/Ko
X-Gm-Gg: AYBFou3cSfdgT92Id52nrMozUKRjrbxlvCFcUFAqS89zf3T9LZU2HDpV1Hdpx0USWbM
 lbrUdy0jJn9cphnXyl7j3fx3FUcFO/e0trTAkh3lKCYGMR+d60+hBNeCxaUX3AuNQNLLhWAj2Cg
 /8Az4MsTtfbg8dk7P8c32ksme0l+O9q22BnhQqeG/4J0mxNfZoXrgLWfjSM5fQxtYu4XkSxZ7wO
 5/edo6dR6rxh7Q0XrMpnxTZjpiuNfUo/vWZK5auUvNcwPQcBvrv32YKhCJB/aMuAlM0G4lzqKKB
 LoyDWMpam8fb6AzVRaaMFQgE2mAbCDvuAI6o+qz2vlZRKOGdHknoPFQeomjIvVW2zDOzJfDU36J
 OroyYvDLBbG8rYmrREPoP+nlGQI898f3IA+KA7FluFFxeqq8yhvvMOl3f66T+IHagQ7WsFuqwnx
 n2YpbSPs8Iy93xX8jexAImCvoTFmKT8jaBl2AecYh0FWMOozuMELvdTP3hR9CtSFASAjBABVa/7
 0gowyEo/WMQh3yYCfKlduxOAEmN827U6Xdr9psGOd1vj4HfVVrg3pYOxzMVb+Q4En9YO2w=
X-Received: by 2002:a05:600c:524c:b0:4a2:105f:ab88 with SMTP id
 5b1f17b1804b1-4a35ac963f8mr148226215e9.18.1793054799133; 
 Mon, 26 Oct 2026 15:46:39 -0700 (PDT)
Received: from [192.168.1.12] ([31.94.68.191])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f3e00asm390740105e9.0.2026.10.26.15.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 15:46:38 -0700 (PDT)
Message-ID: <a826b32d-597a-4c01-8b30-218cbca8627a@gmail.com>
Date: Mon, 26 Oct 2026 22:46:37 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Richard Lane <richardlanedev@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH 1/3] drm/amdgpu: reserve 64M stolen memory for Apple 5K iMac
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:34:11 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Apple 27" 5K iMacs report a single 2560x2880 tile (28.125 MiB) in
VIEWPORT_SIZE while scanning out up to 64 MiB across the relocated EFI
framebuffer.

Override the stolen VGA memory allocation size to 64 MiB when matching
PCI_VENDOR_ID_APPLE with a 2560x2880x4 viewport size to prevent
framebuffer corruption during boot handover.

Signed-off-by: Richard Lane <richardlanedev@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4204c3c750a8..8b196fbfa724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1232,7 +1232,15 @@ void amdgpu_gmc_init_vga_resv_regions(struct amdgpu_device *adev)
 	} else {
 		size = amdgpu_gmc_get_vbios_fb_size(adev);
 
-		if (adev->mman.keep_stolen_vga_memory)
+		/*
+		 * Apple 5K iMacs report one 2560x2880 tile in VIEWPORT_SIZE
+		 * while scanning out up to 64M across the relocated EFI
+		 * framebuffer.
+		 */
+		if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+		    size == (2560 * 2880 * 4))
+			size = 64U * 1024 * 1024;
+		else if (adev->mman.keep_stolen_vga_memory)
 			size = max(size, (unsigned)AMDGPU_VBIOS_VGA_ALLOCATION);
 	}
 
-- 
2.55.0
