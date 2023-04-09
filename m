Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85893C77B6F
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Apr 2023 19:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A882910E1F2;
	Sun,  9 Apr 2023 19:02:07 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 857E610E1ED
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Apr 2023 19:02:05 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-947a47eb908so107519866b.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681066923; x=1683658923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FVYJ1au10rxEnJX58fvFbkZ9mzQm5fCGuW6E9SZYXQ=;
 b=BHlTkwvmKpia0JZeny+ggwnXtHQ3dk1tBD3tVwkf7pqkKbthSGF0ITvIQVE2fO+jTb
 A6EcoK6u1/7n3pNeuB4ZxTOWj78X0zL5fAVv9R7/5/abzfeZ6m0vrjD7ZYmnEiNJs0Ln
 yN3x++LwdUj0fxpAkOvjW6n8nr1DYFL0FGz8nfFICrSig5mXgs41SvNzG2uVmZhjmqOt
 FpuK/TYrIuFEM9aUpya9s/7ToZCcL2XQN2KeUwoGPTwK36eH8fP2h3ZGikH5lwREPTkl
 GQd2Q8OJznv3T88GNPi7U3SYXPm/tJ3jLTI5UE481R9lPEM0sCAKhCcwaIewGGspGbVz
 DoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681066923; x=1683658923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FVYJ1au10rxEnJX58fvFbkZ9mzQm5fCGuW6E9SZYXQ=;
 b=tsw2q5XW22rwLScQ/s+0xmgh7Mx5CIXOMzjZBJA49nkipHVDRPW869IbbNIDWXQJGV
 qOgDfRbC5bGtPoVPFI0OHR1JM+4SyVxMLRXDqF6m2EEq9Xphuu1VXZo728srU0/AZVrT
 cecP4q1fesRF5D6xg2j/jC3rMBDv8u1kn3bVV3XSTUHsBQM7WF8H5Hjq2ARcf5qtDuaF
 Ej5UlCG2CzbMSVQuO4cJBV8mMSNfAqijSu2Ey6iwA4xqpslWwYKozWMpVJTc8uJ4YqMx
 6eOB0Ira2m2YFEDYNoR8jgbKL61PTrEVCm//cQDpsA84xE9MTg1wSuytE0GjRh1ebT6N
 QMFg==
X-Gm-Message-State: AAQBX9cUbXFlJBasgjqaTXxjHG/hCigTxIkWkqHoo2xo6EGcV09f1slJ
 3834JJgG2rIhN4dxj/gYFvuBxgtdTapXQLbEP4H59w==
X-Google-Smtp-Source: AKy350bfX4DYgRbku0KLgQM20erx6MTzxxoqgyVWE+h5wZwsjtVxhVO6Ds1fgj4zN0/Mg6WiRUVz4w==
X-Received: by 2002:a17:906:19c:b0:947:bff2:1c2d with SMTP id
 28-20020a170906019c00b00947bff21c2dmr5063074ejb.3.1681066923032; 
 Sun, 09 Apr 2023 12:02:03 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a782:cc00::ab])
 by smtp.gmail.com with ESMTPSA id
 xb4-20020a170907070400b0094a71869153sm730693ejb.46.2023.04.09.12.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Apr 2023 12:02:02 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 3/3] drm/amdgpu: Add support for querying the max ibs in a
 submission. (v2)
Date: Sun,  9 Apr 2023 20:59:56 +0200
Message-Id: <20230409185956.725016-3-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230409185956.725016-1-bas@basnieuwenhuizen.nl>
References: <20230409185956.725016-1-bas@basnieuwenhuizen.nl>
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
Cc: maraeo@gmail.com, timur.kristof@gmail.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, alexander.deucher@amd.com,
 David Airlie <airlied@gmail.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to introduce a new version of the info struct because
libdrm_amdgpu forgot any versioning info in amdgpu_query_hw_ip_info
so the mesa<->libdrm_amdgpu interface can't handle increasing the
size.

This info would be used by radv to figure out when we need to
split a submission into multiple submissions. radv currently has
a limit of 192 which seems to work for most gfx submissions, but
is way too high for e.g. compute or sdma.

Because the kernel handling is just fine we can just use the v2
everywhere and have the return_size do the versioning for us,
with userspace interpreting 0 as unknown.

Userspace implementation:
https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection
https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection

v2: Use base member in the new struct.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: David Airlie <airlied@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 31 ++++++++++++++-----------
 include/uapi/drm/amdgpu_drm.h           | 14 +++++++++++
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 89689b940493..5b575e1aef1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -360,7 +360,7 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 
 static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			     struct drm_amdgpu_info *info,
-			     struct drm_amdgpu_info_hw_ip *result)
+			     struct drm_amdgpu_info_hw_ip2 *result)
 {
 	uint32_t ib_start_alignment = 0;
 	uint32_t ib_size_alignment = 0;
@@ -431,6 +431,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		return -EINVAL;
 	}
 
+	result->max_ibs = UINT_MAX;
 	for (i = 0; i < adev->num_rings; ++i) {
 		/* Note that this uses that ring types alias the equivalent
 		 * HW IP exposes to userspace.
@@ -438,6 +439,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		if (adev->rings[i]->funcs->type == info->query_hw_ip.type &&
 		    adev->rings[i]->sched.ready) {
 			++num_rings;
+			result->max_ibs = min(result->max_ibs,
+					      adev->rings[i]->max_ibs);
 		}
 	}
 
@@ -452,36 +455,36 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	num_rings = min(amdgpu_ctx_num_entities[info->query_hw_ip.type],
 			num_rings);
 
-	result->hw_ip_version_major = adev->ip_blocks[i].version->major;
-	result->hw_ip_version_minor = adev->ip_blocks[i].version->minor;
+	result->base.hw_ip_version_major = adev->ip_blocks[i].version->major;
+	result->base.hw_ip_version_minor = adev->ip_blocks[i].version->minor;
 
 	if (adev->asic_type >= CHIP_VEGA10) {
 		switch (type) {
 		case AMD_IP_BLOCK_TYPE_GFX:
-			result->ip_discovery_version = adev->ip_versions[GC_HWIP][0];
+			result->base.ip_discovery_version = adev->ip_versions[GC_HWIP][0];
 			break;
 		case AMD_IP_BLOCK_TYPE_SDMA:
-			result->ip_discovery_version = adev->ip_versions[SDMA0_HWIP][0];
+			result->base.ip_discovery_version = adev->ip_versions[SDMA0_HWIP][0];
 			break;
 		case AMD_IP_BLOCK_TYPE_UVD:
 		case AMD_IP_BLOCK_TYPE_VCN:
 		case AMD_IP_BLOCK_TYPE_JPEG:
-			result->ip_discovery_version = adev->ip_versions[UVD_HWIP][0];
+			result->base.ip_discovery_version = adev->ip_versions[UVD_HWIP][0];
 			break;
 		case AMD_IP_BLOCK_TYPE_VCE:
-			result->ip_discovery_version = adev->ip_versions[VCE_HWIP][0];
+			result->base.ip_discovery_version = adev->ip_versions[VCE_HWIP][0];
 			break;
 		default:
-			result->ip_discovery_version = 0;
+			result->base.ip_discovery_version = 0;
 			break;
 		}
 	} else {
-		result->ip_discovery_version = 0;
+		result->base.ip_discovery_version = 0;
 	}
-	result->capabilities_flags = 0;
-	result->available_rings = (1 << num_rings) - 1;
-	result->ib_start_alignment = ib_start_alignment;
-	result->ib_size_alignment = ib_size_alignment;
+	result->base.capabilities_flags = 0;
+	result->base.available_rings = (1 << num_rings) - 1;
+	result->base.ib_start_alignment = ib_start_alignment;
+	result->base.ib_size_alignment = ib_size_alignment;
 	return 0;
 }
 
@@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		}
 		return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_HW_IP_INFO: {
-		struct drm_amdgpu_info_hw_ip ip = {};
+		struct drm_amdgpu_info_hw_ip2 ip = {};
 		int ret;
 
 		ret = amdgpu_hw_ip_info(adev, info, &ip);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b6eb90df5d05..6b9e35b6f747 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1128,6 +1128,9 @@ struct drm_amdgpu_info_device {
 	__u32 enabled_rb_pipes_mask_hi;
 };
 
+/* The size of this struct cannot be increased for compatibility reasons, use
+ * struct drm_amdgpu_info_hw_ip2 instead.
+ */
 struct drm_amdgpu_info_hw_ip {
 	/** Version of h/w IP */
 	__u32  hw_ip_version_major;
@@ -1144,6 +1147,17 @@ struct drm_amdgpu_info_hw_ip {
 	__u32  ip_discovery_version;
 };
 
+struct drm_amdgpu_info_hw_ip2 {
+	/** Previous version of the struct */
+	struct drm_amdgpu_info_hw_ip  base;
+	/** The maximum number of IBs one can submit in a single submission
+	 * ioctl. (When using gang submit: this is per IP type)
+	 */
+	__u32  max_ibs;
+	/** padding to 64bit for arch differences */
+	__u32  pad;
+};
+
 struct drm_amdgpu_info_num_handles {
 	/** Max handles as supported by firmware for UVD */
 	__u32  uvd_max_handles;
-- 
2.40.0

