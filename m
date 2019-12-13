Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E31C2D0CE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B421B24697
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U/soatyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B421B24697
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C7F6E2E0;
	Fri, 13 Dec 2019 14:42:46 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700086.outbound.protection.outlook.com [40.107.70.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F346E2E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 14:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8Q4eUoFGPDXATEps6CrbmkSpwIITy5AobynG9wC42vdqKKaHX0tY6gYxlWJrT97e9WFZ63KEmYgo214B2KqAru8d+mly0R/8n+BuQ+o4kGA3piecvyQDKTxmpu9JaBw8dCjsHeSIdLtbiSDNgb+F19m3Oz7ieC58KmhAuwLPL8YW+iOPdCfLMQlvEyDaF96eY0zp0rK/4slP/BTbQaYzmtPI/WFdPzBIQzsVZ/YKhZHqcLJKrnNOVXC1i1MZzk4Nvz+IvrJMPN9oEywXg2uu06iNB0gI47D0A6jlZeBGhZ8XlX65H7b6v5uGU2rt5q3HAJNGhukcMPRb6G2m5v9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6oDsREG1mRSYAoLW0fNuicM7PfzMv6BtnljHQ1YX2M=;
 b=JuBPcQxA9zImmHDpW6F1n6VQjPi12xkIOkVqSLayyvfgEMtVSLlNAWWTTxTnXV++5nrLunvR0FTrOxFmUEHtLJrnZd2NxSoCDCaOnVz4f0k62O4Z5QzN90N/dlom9Qzt/TZ9X85OlNewqpTjSdLNCnkOOaAP0lKQm2wvprWv01NGH8acjdUlyFy9olDkw6DXU7uyYATEHVoMJhOy3s+eNMrCu2t5AkQ5iYwrQ6ZOG7mQBoUhsxWwvGRhCq4CrHyV5s9TH87YpchWAwF9N9CvaGaZcDHfHelwXibumRwK11I3NrH/BP20OLSJTF5zXctlPx9UTuhArxSk0FkOjvJg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6oDsREG1mRSYAoLW0fNuicM7PfzMv6BtnljHQ1YX2M=;
 b=U/soatyTYlR4XGsDetq/+iU9prRyfREGM5gkUfzZK1sDDYGFWoDhZyyBHsNVmK1mSQZtBFJsW7gNe2j2MltBULROzczU9a51tw9EnHKWHIXxtZYdM3TOfaGvbxiaeWKrKhWg/z9bOLQ5ZhchEtPNNCpH/SeH1VpvRKqsP/hepNc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1401.namprd12.prod.outlook.com (10.168.235.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 13 Dec 2019 14:42:44 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f%3]) with mapi id 15.20.2516.018; Fri, 13 Dec 2019
 14:42:44 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/vcn1.0: use its own idle handler and begin use
 funcs
Date: Fri, 13 Dec 2019 09:42:24 -0500
Message-Id: <20191213144224.4848-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211194824.11146-1-leo.liu@amd.com>
References: <20191211194824.11146-1-leo.liu@amd.com>
X-ClientProxiedBy: YTBPR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::31) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fdb146f9-4ed4-43d3-70f8-08d77fdab67a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1401:|DM5PR12MB1401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14012EF348F794847E14B46FE5540@DM5PR12MB1401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0250B840C1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(478600001)(26005)(81166006)(81156014)(186003)(8676002)(6916009)(2616005)(316002)(52116002)(4326008)(6666004)(66556008)(2906002)(36756003)(86362001)(6486002)(66946007)(6506007)(44832011)(5660300002)(8936002)(66476007)(6512007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1401;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duKWmTzzfRE1p+uOCJjHAvRDh7/vC/lfex5WtCuhR7g0ulc2z/twB7ox7I9FVFc7nQvZqvzPNa+GBSVIVxJkEI6igdcqhy16HnEOdLMh1PhMa8w1c+0OO0t/nw477LcYkA7F8FukHwJVY6trM9t0/7yw5vHvKjuB1xXLEjec8/vN5uSL9+tifRcvA/njevAFsNfAuNjjq/5GY8hKPW3ZmYUstC1vXaBWWuujR0X7FKM4DqQwEGlzjyACL5QBfLjt0VPBeTILyPA1cwCuv4T12Wo5FFTjfKDfzeU/uT0lmJCryT1Rsa4U0AkQuHDg8BN0SEMSgXL7ppeJNYDgzrlmkHjBqbFdh3M9d+ll3Iqox7P714iK5bIFXfp31R7vi+1MI2Ht8zSuWAcTI0X8dfOnF6ha7YKCl2KvosknMbLIFPpR3fQDqLW8uPwiW718fA6R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb146f9-4ed4-43d3-70f8-08d77fdab67a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 14:42:43.9748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uo/2K6KYLL8V/OEmg38LMSisZYip07vobEBLPu8OtR3Gzw6ErNmNlxMpgDew1POt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1401
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Because VCN1.0 power management and DPG mode are managed together with
JPEG1.0 under both HW and FW, so separated them from general VCN code.
Also the multiple instances case got removed, since VCN1.0 HW just have
a single instance.

v2: override work func with vcn1.0's own

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 90 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h   |  2 +
 5 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 428cfd58b37d..717f0a218c5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -39,9 +39,6 @@
 #include "vcn/vcn_1_0_offset.h"
 #include "vcn/vcn_1_0_sh_mask.h"
 
-/* 1 second timeout */
-#define VCN_IDLE_TIMEOUT	msecs_to_jiffies(1000)
-
 /* Firmware Names */
 #define FIRMWARE_RAVEN		"amdgpu/raven_vcn.bin"
 #define FIRMWARE_PICASSO	"amdgpu/picasso_vcn.bin"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 402a5046b985..3484ead62046 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -56,6 +56,9 @@
 #define VCN_VID_IP_ADDRESS_2_0		0x0
 #define VCN_AON_IP_ADDRESS_2_0		0x30000
 
+/* 1 second timeout */
+#define VCN_IDLE_TIMEOUT	msecs_to_jiffies(1000)
+
 #define RREG32_SOC15_DPG_MODE(ip, inst, reg, mask, sram_sel) 				\
 	({	WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_MASK, mask); 			\
 		WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_CTL, 				\
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index a141408dfb23..0debfd9f428c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -25,6 +25,7 @@
 #include "amdgpu_jpeg.h"
 #include "soc15.h"
 #include "soc15d.h"
+#include "vcn_v1_0.h"
 
 #include "vcn/vcn_1_0_offset.h"
 #include "vcn/vcn_1_0_sh_mask.h"
@@ -561,7 +562,7 @@ static const struct amdgpu_ring_funcs jpeg_v1_0_decode_ring_vm_funcs = {
 	.insert_start = jpeg_v1_0_decode_ring_insert_start,
 	.insert_end = jpeg_v1_0_decode_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.begin_use = amdgpu_vcn_ring_begin_use,
+	.begin_use = vcn_v1_0_ring_begin_use,
 	.end_use = amdgpu_vcn_ring_end_use,
 	.emit_wreg = jpeg_v1_0_decode_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v1_0_decode_ring_emit_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 652cecc030b3..3b025a3f8c7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -25,6 +25,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_vcn.h"
+#include "amdgpu_pm.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "soc15_common.h"
@@ -51,6 +52,8 @@ static int vcn_v1_0_set_powergating_state(void *handle, enum amd_powergating_sta
 static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
 				struct dpg_pause_state *new_state);
 
+static void vcn_v1_0_idle_work_handler(struct work_struct *work);
+
 /**
  * vcn_v1_0_early_init - set function pointers
  *
@@ -105,6 +108,9 @@ static int vcn_v1_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	/* Override the work func */
+	adev->vcn.idle_work.work.func = vcn_v1_0_idle_work_handler;
+
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		const struct common_firmware_header *hdr;
 		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
@@ -1758,6 +1764,86 @@ static int vcn_v1_0_set_powergating_state(void *handle,
 	return ret;
 }
 
+static void vcn_v1_0_idle_work_handler(struct work_struct *work)
+{
+	struct amdgpu_device *adev =
+		container_of(work, struct amdgpu_device, vcn.idle_work.work);
+	unsigned int fences = 0, i;
+
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+		fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_enc[i]);
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		struct dpg_pause_state new_state;
+
+		if (fences)
+			new_state.fw_based = VCN_DPG_STATE__PAUSE;
+		else
+			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+
+		if (amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec))
+			new_state.jpeg = VCN_DPG_STATE__PAUSE;
+		else
+			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
+
+		adev->vcn.pause_dpg_mode(adev, &new_state);
+	}
+
+	fences += amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec);
+	fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_dec);
+
+	if (fences == 0) {
+		amdgpu_gfx_off_ctrl(adev, true);
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_uvd(adev, false);
+		else
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+			       AMD_PG_STATE_GATE);
+	} else {
+		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+	}
+}
+
+void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+	if (set_clocks) {
+		amdgpu_gfx_off_ctrl(adev, false);
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_uvd(adev, true);
+		else
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+			       AMD_PG_STATE_UNGATE);
+	}
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		struct dpg_pause_state new_state;
+		unsigned int fences = 0, i;
+
+		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+			fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_enc[i]);
+
+		if (fences)
+			new_state.fw_based = VCN_DPG_STATE__PAUSE;
+		else
+			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+
+		if (amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec))
+			new_state.jpeg = VCN_DPG_STATE__PAUSE;
+		else
+			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
+
+		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
+			new_state.fw_based = VCN_DPG_STATE__PAUSE;
+		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
+			new_state.jpeg = VCN_DPG_STATE__PAUSE;
+
+		adev->vcn.pause_dpg_mode(adev, &new_state);
+	}
+}
+
 static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
 	.name = "vcn_v1_0",
 	.early_init = vcn_v1_0_early_init,
@@ -1804,7 +1890,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
 	.insert_start = vcn_v1_0_dec_ring_insert_start,
 	.insert_end = vcn_v1_0_dec_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.begin_use = amdgpu_vcn_ring_begin_use,
+	.begin_use = vcn_v1_0_ring_begin_use,
 	.end_use = amdgpu_vcn_ring_end_use,
 	.emit_wreg = vcn_v1_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v1_0_dec_ring_emit_reg_wait,
@@ -1836,7 +1922,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.insert_end = vcn_v1_0_enc_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.begin_use = amdgpu_vcn_ring_begin_use,
+	.begin_use = vcn_v1_0_ring_begin_use,
 	.end_use = amdgpu_vcn_ring_end_use,
 	.emit_wreg = vcn_v1_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v1_0_enc_ring_emit_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h
index 2a497a7a4840..f67d7391fc21 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h
@@ -24,6 +24,8 @@
 #ifndef __VCN_V1_0_H__
 #define __VCN_V1_0_H__
 
+void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring);
+
 extern const struct amdgpu_ip_block_version vcn_v1_0_ip_block;
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
