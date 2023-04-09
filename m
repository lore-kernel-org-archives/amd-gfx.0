Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02080C77B61
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Apr 2023 14:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB8C610E192;
	Sun,  9 Apr 2023 14:46:56 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F1210E192
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Apr 2023 14:46:55 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-94a342f4c8eso12259866b.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 07:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681051612; x=1683643612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfvKhQ+oV1l4cha8UMDqL2oyVB7mtYaHhVuM37/Ma98=;
 b=dtswPVVbbqVIdJojH4B3ZTvZB+Dnol9eJ67cQuzkEB/r+5N4xQBr+p1UAmFqs9huU6
 rQo/BPbysgix9ppGi6Q4WRjH1bP4Nb8mgvrYqhyZ8Z3Yy5XnlJ29RQiWWS/NRb/wjc1R
 qouOGxsEcfSw0HIyYU0wgQZEfy9v3Ay1fJe15vn6kBUba2495pwZk69cYrvMxuzQU0bg
 fxflOWMZhsTqiM1FEYowLrfzRk71RpKMEmWRa8dWHoXZKbyIREBSikrp+5FLbcMkceCI
 P3e/wMWV+sgejaU3l9gGhTbLm0KKcEN++WCFxo7hbMyeExdaQuxubq4AWG1OT8DoAk66
 WiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681051612; x=1683643612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfvKhQ+oV1l4cha8UMDqL2oyVB7mtYaHhVuM37/Ma98=;
 b=xc5rpIXUhf55WJfUwt+tGGj4y+cju3t4t6b/GqnuiI1B09qhbbAspyD+F3WfGLUqfS
 LYghRKV81MGpztTVmHmWCyhCT+CHrwmjpqLjo9gECY5bj5DlvEp+1dwfsSZrZU1S8E92
 Cj/4dmCJijWeYAb3U6CVn27uPeyaOzdX/t3ynSEv5fI81vn0e4S89Rg8wobtgDptRa4D
 0eeH68F6fvSyNrd22xDEaFC0CP69CREATkTfD8vF6xpcehb1xlPMuLAQDZg5H4+gmyA2
 qPGnrV8/SZGrky/arx8+deFzY+PhtAnqobktspZCXJbSlKYdw0YR3hEbCK+6FPGBiJ2w
 RX1w==
X-Gm-Message-State: AAQBX9cqTeh3HLL2ma0wO4UdhqciVbsoNLn7sV1i+gLXHsRz0/nldIMN
 59u7rC0nMLKmegnKSU9fjONvxYYNohQqXNMT00C3yA==
X-Google-Smtp-Source: AKy350arG1dLP2rUhMRERhmFY89x9QTvytHAPtFKJr1+o32iwL2gfU7vsXZJJmrSpOUB7F+Qtcg4vw==
X-Received: by 2002:a17:906:208a:b0:94a:8619:2893 with SMTP id
 10-20020a170906208a00b0094a86192893mr515242ejq.3.1681051612685; 
 Sun, 09 Apr 2023 07:46:52 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a782:cc00::ab])
 by smtp.gmail.com with ESMTPSA id
 xj5-20020a170906db0500b00924d38bbdc0sm4155587ejb.105.2023.04.09.07.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Apr 2023 07:46:52 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: Add support for querying the max ibs in a
 submission.
Date: Sun,  9 Apr 2023 16:44:45 +0200
Message-Id: <20230409144445.374816-3-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230409144445.374816-1-bas@basnieuwenhuizen.nl>
References: <20230409144445.374816-1-bas@basnieuwenhuizen.nl>
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

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: David Airlie <airlied@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  7 ++++--
 include/uapi/drm/amdgpu_drm.h           | 29 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 89689b940493..c7e815c2733e 100644
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
 
@@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		}
 		return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_HW_IP_INFO: {
-		struct drm_amdgpu_info_hw_ip ip = {};
+		struct drm_amdgpu_info_hw_ip2 ip = {};
 		int ret;
 
 		ret = amdgpu_hw_ip_info(adev, info, &ip);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b6eb90df5d05..45e5ae546d19 100644
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
@@ -1144,6 +1147,32 @@ struct drm_amdgpu_info_hw_ip {
 	__u32  ip_discovery_version;
 };
 
+/* The prefix fields of this are intentionally the same as those of
+ * struct drm_amdgpu_info_hw_ip. The struct has a v2 to resolve a lack of
+ * versioning on the libdrm_amdgpu side.
+ */
+struct drm_amdgpu_info_hw_ip2 {
+	/** Version of h/w IP */
+	__u32  hw_ip_version_major;
+	__u32  hw_ip_version_minor;
+	/** Capabilities */
+	__u64  capabilities_flags;
+	/** command buffer address start alignment*/
+	__u32  ib_start_alignment;
+	/** command buffer size alignment*/
+	__u32  ib_size_alignment;
+	/** Bitmask of available rings. Bit 0 means ring 0, etc. */
+	__u32  available_rings;
+	/** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
+	__u32  ip_discovery_version;
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

