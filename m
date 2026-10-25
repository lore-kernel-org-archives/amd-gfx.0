Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3A606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fshSUgf8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 830DC10ECC1;
	Mon, 26 Oct 2026 08:43:57 +0000 (UTC)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70CE710E67F
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 04:03:56 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-14fd9dafb0dso1649910c88.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Oct 2026 21:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792901035; x=1793505835; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LMc3CYZEKLGD01XMea94oTj/yeGbugpGFxEInSpf2Xs=;
 b=fshSUgf8RIHkR2+DE/j6KVWwPtV0X+TA/f3ElwTvfZH+8Hw9kMLY/bVdbHXUHBXvAG
 AMDgwuJZgeAaIW11YV7SVv4hwajbEUnNkcJTR6U0mVA2ziFC+xPStF1AlG3MnGS6h6gO
 KWlmyICHC+LYAedH29NcXd2ZSCpeohjpzimaCRgVDp8EEg07PrOjVkk/Q6/dYfz6eosl
 e5ylscrmkoIYj+Rde0joWkesDkqPhbB67lLCJiMelO4b2VNQxv4vJjBPKZpecsnLkpGr
 vesw4V6/09ROMl0Cg/FmX/S6cz13oqyuVZD26A35CgNYvMNtza5kKlhtPkepp7bZKh/H
 cM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792901035; x=1793505835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LMc3CYZEKLGD01XMea94oTj/yeGbugpGFxEInSpf2Xs=;
 b=1aPSkNDik+V6/GYh7/JM4WYQtPi9+u/PvB+UyFy/emxh+7lM7vN11Ad5nm58M8WEh1
 WeEZPJFLimjeaTMzwAWWVusZ/B+7RnMNXdSBQEhg8KmFktvSFfRFpXxl1TSqPMdCjiR7
 9CZfjyeNzbv0fxec3E0zXDlMTiWhBNd70BqUVbeOk+P86i90g65Sj0uyrfphZQF2w2zp
 LHLm6+4/Vd7n3IElMFAOYclAG2tDKwBIBM2jOQPNqF+eWggo/oSewm06tnNkatx7LjcW
 Y2F7FgbmC4Ku2Waj532rzLVlzCEjMxPFtwVA5Emi0TtPahxFZzbbzkQxvVYHB76KQ40C
 lrLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz35/cGbzuO/LXLaKzQS/lb73KqzYHrEk2LuovJNhK75k+I/tsRimC1s32vYH/Od1CzcbNGbYFK@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI83Gv5aMlAREj9GHYb22ThPcYcnL1EShBnecX1FO81Mcbv4SXD
 KfA6yZ+8bbMv/E/brRuHDTjR8e8KQYTWRqZZ/fmo33XcESNNcIMOcDY=
X-Gm-Gg: AYBFou0wa2cgb0rhPREAGymcHYOQcS7W+MN44hP+aQLk2zk5tpk3X3rmr7/NSjRfl7l
 emgsk9Yt1I8Y3skget0AWDFTu32tYT+/0xBLxDXBR/vNVXFHi4jIsVOxIzqp9xoOCZtjZKVkpzB
 Qzth9DboLJGm5dda5xbbIOypLVPG+r5cvVijV1jeFUHebZZ0VYjZANLpvwPjvY7miSUwvUJnscP
 /tSR2qmkamEjLiBOQDHLIDoDbUpXa6edMNCd2NnKpdTboZA+bPIn6dO1DSoi/hJ+n8HuMJikwVt
 GVvkTmMgo/8AH/JtcsISCnNy4ohQJc4lZKjfyLjEy0YnhoNv2iwPY7hjfWy/rKz19nWyZWL6ZJe
 aZBj3Ok9fYN3sRbAyJhzjKAB54vQoWZeUr6PLCSqBAyyUu1QmMlMu7MVRv7TL8jaPEwcj2F83Pw
 hzvJTUr+C1VnioTZdxOcCLPAPcs11WF2RiIUNoRpbtKH7iqX5I7vMiBwGi8yXtm8dBJWsqmEHd1
 yPYvvrIBmDwqsBY4KRZF/iVldAyqT9eRephmyDYihSVcheqZuVFMwUCPpDfKjcKCZoYXHb79Z4o
 zLTGV1wdHi1gXD0=
X-Received: by 2002:a05:7023:885:b0:16e:6e3:9a9f with SMTP id
 a92af1059eb24-1993639e6efmr6212921c88.34.1792901035199; 
 Sat, 24 Oct 2026 21:03:55 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:03:54 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 11/13] drm/amd/display: Refuse DP AUX while GMUX keeps the GPU
 off
Date: Sat, 24 Oct 2026 23:59:47 -0400
Message-ID: <20261025040046.1602-12-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:43:34 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andre Eikmeyer <dev@deq.rocks>

fwupd reads /dev/drm_dp_aux* while the GPU is runtime suspended. The AUX
device holds no runtime PM reference, so the transfer touched registers of
the powered off GPU and caused a CPU CATTER.

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7261317d4..b099bf520 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -24,6 +24,7 @@
  *
  */
 
+#include <linux/pm_runtime.h>
 #include <linux/vmalloc.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/display/drm_dp_mst_helper.h>
@@ -111,6 +112,20 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
 
+	ddc = TO_DM_AUX(aux)->ddc_service;
+	adev = ddc->ctx->driver_context;
+
+	/*
+	 * User space reaches this through the drm_dp_aux_dev character device
+	 * without a runtime PM reference. Refuse the transfer while GMUX keeps
+	 * the GPU powered off, a register access then hangs the PEG link.
+	 */
+	pm_runtime_get_noresume(adev->dev);
+	if (READ_ONCE(adev->gmux_off)) {
+		pm_runtime_put_noidle(adev->dev);
+		return -EBUSY;
+	}
+
 	payload.address = msg->address;
 	payload.data = msg->buffer;
 	payload.length = msg->size;
@@ -126,13 +141,13 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	result = dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, &payload,
 				      &operation_result);
 
+	pm_runtime_put_autosuspend(adev->dev);
+
 	/*
 	 * w/a on certain intel platform where hpd is unexpected to pull low during
 	 * 1st sideband message transaction by return AUX_RET_ERROR_HPD_DISCON
 	 * aux transaction is succuess in such case, therefore bypass the error
 	 */
-	ddc = TO_DM_AUX(aux)->ddc_service;
-	adev = ddc->ctx->driver_context;
 	if (adev->dm.aux_hpd_discon_quirk) {
 		if (msg->address == DP_SIDEBAND_MSG_DOWN_REQ_BASE &&
 			operation_result == AUX_RET_ERROR_HPD_DISCON) {
-- 
2.55.0

