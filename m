Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A44C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 19:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C78810E144;
	Mon,  7 Mar 2022 19:47:34 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E21610E076
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 16:26:48 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id dr20so33082394ejc.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Mar 2022 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RhoH53PC4G7mNIq+2fN3IYcxf0sCfOg3VAVTpGFNrpw=;
 b=IV14UhpnSvGRStrt9pTMNYknl/03Avr4hiqPCl2Eb1icjtIFLxar6jiIFI3hQCFcMw
 oM4CA+Ceb32VSItNBkdGC081tsYiO5Hyoh3K9xO4y4oCbLeskmYe4CUZhJ3sPpdtyBRg
 MqhoCvlYTaKKYNjDB+oTgB9EoZYh7rFNlt/mm0ATMXCP87zUc0KvLM4rg6I9uY3XEHEO
 y67TBTTf0hZAfl/l+E0Tm33u4zdZgDPS+Bu2iJ6o7eDRLOU2gd8tplYDeq6OOxBlS4BC
 ehbfFjyDLiwBsMTrXYUyxqpw0MFQuzD9t2rc6qE7pxHP+ZmHgYg75bxtf7RRLZVwqbk4
 OVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RhoH53PC4G7mNIq+2fN3IYcxf0sCfOg3VAVTpGFNrpw=;
 b=ymMe63TS38pQbG2Ar4n02PoOAmRgSad+atQZiTnudJvgN74TSlcqW2A8dskGOQ9AUf
 4HCEjcJv/PxHBgZIWx3pkbVmpnW0pMlJ/6nss1v1E1R7J8u/bALIDucltChvnlTvpnFO
 4ZaLAF7ctpipgG4FR94R5H3j1UEuUvZrH8gH5harJqb1Fd++/fltxs7DJ8ldwIzipwNr
 z7+GJTFbbJJLRXMn5DF1o52rnCjGOPXzKw0DRP1n0Ku609l6f/NxoYWuCx+7hahNQQOQ
 vIalml9MutYHFe6tBoPoK5mIQCjz6qf8SD0ZReOcgZdNShyB7yyj+qXcbPXdZyrQwlrX
 HoFw==
X-Gm-Message-State: AOAM532+1AKZIeKMjxZkucwbHVePtv68GajvarXTE1Ln30Zokux5/frN
 rsJxnWPBeu24uA7ONsm4C5AUW+BgtD6aLMti
X-Google-Smtp-Source: ABdhPJzoYF45iYhkI+7PU1EdaJjbReFYwx+hTiI67tnhHSZZ6EERixHS5CRHAvxrAZzAtEvVjdWFEA==
X-Received: by 2002:a17:906:30cf:b0:6da:9da6:b360 with SMTP id
 b15-20020a17090630cf00b006da9da6b360mr9245864ejb.743.1646670406351; 
 Mon, 07 Mar 2022 08:26:46 -0800 (PST)
Received: from shashanks-buildpc.. ([2a02:8109:b540:9438:acf8:f35b:33d6:e937])
 by smtp.gmail.com with ESMTPSA id
 5-20020a508e45000000b003fe03798eafsm6667027edx.32.2022.03.07.08.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 08:26:45 -0800 (PST)
From: Shashank Sharma <contactshashanksharma@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: add work function for GPU reset event
Date: Mon,  7 Mar 2022 17:26:31 +0100
Message-Id: <20220307162631.2496286-2-contactshashanksharma@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Mar 2022 19:47:33 +0000
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
Cc: Alexander Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com, Christian Koenig <christian.koenig@amd.com>,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <shashank.sharma@amd.com>

This patch adds a work function, which will get scheduled
in event of a GPU reset, and will send a uevent to user with
some reset context infomration, like a PID and some flags.

The userspace can do some recovery and post-processing work
based on this event.

V2:
- Changed the name of the work to gpu_reset_event_work
  (Christian)
- Added a structure to accommodate some additional information
  (like a PID and some flags)

Cc: Alexander Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d8b854fcbffa..7df219fe363f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -813,6 +813,11 @@ struct amd_powerplay {
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 #define AMDGPU_PRODUCT_NAME_LEN 64
+struct amdgpu_reset_event_ctx {
+	uint64_t pid;
+	uint32_t flags;
+};
+
 struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
@@ -1063,6 +1068,7 @@ struct amdgpu_device {
 
 	int asic_reset_res;
 	struct work_struct		xgmi_reset_work;
+	struct work_struct		gpu_reset_event_work;
 	struct list_head		reset_list;
 
 	long				gfx_timeout;
@@ -1097,6 +1103,7 @@ struct amdgpu_device {
 	pci_channel_state_t		pci_channel_state;
 
 	struct amdgpu_reset_control     *reset_cntl;
+	struct amdgpu_reset_event_ctx   reset_event_ctx;
 	uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
 
 	bool				ram_is_direct_mapped;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ed077de426d9..c43d099da06d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -73,6 +73,7 @@
 #include <linux/pm_runtime.h>
 
 #include <drm/drm_drv.h>
+#include <drm/drm_sysfs.h>
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
@@ -3277,6 +3278,23 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
 	return amdgpu_device_asic_has_dc_support(adev->asic_type);
 }
 
+static void amdgpu_device_reset_event_func(struct work_struct *__work)
+{
+	struct amdgpu_device *adev = container_of(__work, struct amdgpu_device,
+						  gpu_reset_event_work);
+	struct amdgpu_reset_event_ctx *event_ctx = &adev->reset_event_ctx;
+
+	/*
+	 * A GPU reset has happened, indicate the userspace and pass the
+	 * following information:
+	 *	- pid of the process involved,
+	 *	- if the VRAM is valid or not,
+	 *	- indicate that userspace may want to collect the ftrace event
+	 * data from the trace event.
+	 */
+	drm_sysfs_reset_event(&adev->ddev, event_ctx->pid, event_ctx->flags);
+}
+
 static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 {
 	struct amdgpu_device *adev =
@@ -3525,6 +3543,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			  amdgpu_device_delay_enable_gfx_off);
 
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
+	INIT_WORK(&adev->gpu_reset_event_work, amdgpu_device_reset_event_func);
 
 	adev->gfx.gfx_off_req_count = 1;
 	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
-- 
2.32.0

