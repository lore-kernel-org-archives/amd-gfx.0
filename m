Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EBEC282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 22:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0959B2053B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 22:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ist4kfsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0959B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D2D6E351;
	Wed,  8 Jan 2020 22:49:21 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719526E34D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 22:49:20 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id y67so2190349yba.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 14:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gq6XENK7lksTd50TlGkFOcbjAJ/e6XA00P8/k2mhvnk=;
 b=ist4kfsLw//2VYRadE0EMU67bK05rf+0Y5cFNKEzycwPWogdpHxa9TO/E+ZaK6Btd8
 18onRkOwH5gRFWq5Emg+QBqZGa5VwDzaYStsy8M/fLECq+qab0JtGj3nvx60nzNgnh+U
 00TeOZJWypxUiQaNR9S149sYzWr7DiFzl1m+pqYy5fQMbDHSvrNB5OwWMKsb0sde6+V8
 VKA+C7zDTk6AhKVCFeiSe6O1NGviyN5RDNDS49fwSvs6LLXiPr9TCQ51pObXjeQTjQRH
 OgptToYSs+VtpfaVf9x0ZN53sO9OHvSFi7RhmczbXSkaZGVfW1YxbSvi0X84UUWdXw3y
 AwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gq6XENK7lksTd50TlGkFOcbjAJ/e6XA00P8/k2mhvnk=;
 b=kuJix40R/IeYg52FX5tXs6ISnghroWL3bepCZ2y+iEQ4JR/7At77SA6Aqh7gYg+Jfc
 DxAAXhkPfo1vB/vH5RXxxcVD+ktC6pt6+sG7/JgowvI2K5mNAiq8aL8AjFGGHB67FhQT
 yFfvr6xu5T6fbN3JsJcXPjtAOpqXinqGJGfvh2bOcFAY2yQVTS1hfldqkU85o3ntaXrX
 OS2VcFy/MS3Y0OOtJ9X9dnfTaYeViYY1MyLn4XZvx17pgj2qX0xfwI1tlr7FWTllVZdw
 CN+TFMPODdPT+T46ZLg7na/cSS1p1mCYNHHum8AtiZc4sA7zdFQ/5mKtUB6mD53Tri66
 PzVg==
X-Gm-Message-State: APjAAAXXgXdlVY0OZUPThn2I5CVknwKIcIMPrm5K/vcAMAvwPLTCtQOw
 iXEteSCWzB6cFIvMeJznGFKmT5hg
X-Google-Smtp-Source: APXvYqxsA9dgWR5oQh03cYjV2bcQwXoUZCaniwhH/+Vmuyn9cvgGMTCTfbqm0lhQpVmvOBHa4+OrmA==
X-Received: by 2002:a25:4188:: with SMTP id o130mr5856989yba.150.1578523759462; 
 Wed, 08 Jan 2020 14:49:19 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t15sm1209519ywg.67.2020.01.08.14.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 14:49:19 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: enable S/G display on PCO and RV2 (v2)
Date: Wed,  8 Jan 2020 17:49:09 -0500
Message-Id: <20200108224910.289731-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108224910.289731-1-alexander.deucher@amd.com>
References: <20200108224910.289731-1-alexander.deucher@amd.com>
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

It should work on all Raven variants, but some users have
reported issues with original Raven with IOMMU enabled.
So far there have been no issues observed with PCO or RV2.

v2: split out the dm init and domain changes into separate
    patches.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 22 +++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 78733af5cc85..ca9056b0472a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -513,13 +513,23 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 * will not allow USWC mappings.
 	 * Also, don't allow GTT domain if the BO doens't have USWC falg set.
 	 */
-	if (adev->asic_type >= CHIP_CARRIZO &&
-	    adev->asic_type < CHIP_RAVEN &&
-	    (adev->flags & AMD_IS_APU) &&
-	    (bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
+	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_asic_has_dc_support(adev->asic_type))
-		domain |= AMDGPU_GEM_DOMAIN_GTT;
+	    amdgpu_device_asic_has_dc_support(adev->asic_type)) {
+		switch (adev->asic_type) {
+		case CHIP_CARRIZO:
+		case CHIP_STONEY:
+			domain |= AMDGPU_GEM_DOMAIN_GTT;
+			break;
+		case CHIP_RAVEN:
+			/* enable S/G on PCO and RV2 */
+			if (adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8)
+				domain |= AMDGPU_GEM_DOMAIN_GTT;
+			break;
+		default:
+			break;
+		}
+	}
 #endif
 
 	return domain;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
