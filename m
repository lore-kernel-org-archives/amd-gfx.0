Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C02C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 16:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0709E21655
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 16:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p9ZAWjhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0709E21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF1B36E1BC;
	Thu, 12 Dec 2019 16:07:24 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690051.outbound.protection.outlook.com [40.107.69.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 717236E1BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 16:07:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgsBJ2MQwc1cFwctP+wiiWBr3UxHlq9OMxfU9eOAaMcofCK9ta1wde7ZaDbG07M2wJM2yw1C/ladmgifNQ6UjHjTJ4vJpbUacUv8KqgInN8zFac03BEcfoEFCIbyfU0gSgwsy0Yma1ooEVNa5b1SsfF3v+nS4mo2m32akgDUaMKvCezNi1hRcYtSC7GOepDKvO2p6xYkzkfLMlE+7WU//jhyzso8u9zj3H2/S4NxUU5MSfGF5lmklg9AiEpMmg35LXASMW0B03XUAhM/Bd9aIJR3lCu3cATITmNOXs33q1Jltn0k27nxTXSwhdw9uPhTRro+ThY9NdLmEgV/SOEahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HcPUACA8PkiBzWFyaRwQIFw76zGUQIux1nCY1h9zYc=;
 b=hP8xNYvHU2fJTVLOrDvG/Gd24Z6FpyKb5Mo1gyVdj5AsNaMDePVNS1/kl3XauAnMABDYw4yV+ikclsE5iqDhYYALv1E1Bn4WlrTqb8PHeD0hRYRUJVHP9LfUEy03uaGisMsHSQbxshWaJ77d/Zb/ZsaONO22kfg06cktY10RpV9X7eKUZWVCjJMnrPg4MFU02T5R6O9h2mBrnnZaPLe+VYNuOHXnkqkVp8ATt0WqazRU3dIlCng+x+pXMfpxcId4VYaKcjF4HctDzW/UZDhfu+GvzCP7l0t4phKwO1Ec++GGDg637h/WSpAjs2CE1vGicTqbTBW/pSkkc7uIzjAp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HcPUACA8PkiBzWFyaRwQIFw76zGUQIux1nCY1h9zYc=;
 b=p9ZAWjhgJa9Su7QcTe6Xy3TiojPvpjsZd0rfXG1M45Nl1SxJqn82mwcHu4ilFygz+Uvi2gYO3DUHsZavfbMYbhtm9aaAweMfBDV080BJYwzij03D+w91BtSQW3nGg3Ll6gHWWmtxwxg+qRbvK4k4glTtVCxTqIbsaE//tmQgbOk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1756.namprd12.prod.outlook.com (10.175.86.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 16:07:22 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f%3]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 16:07:22 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/vcn1.0: use its own idle handler and begin use
 funcs
Date: Thu, 12 Dec 2019 11:06:48 -0500
Message-Id: <20191212160649.20375-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211194824.11146-1-leo.liu@amd.com>
References: <20191211194824.11146-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::40) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5110662a-ba33-441e-9e79-08d77f1d5ee1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1756:|DM5PR12MB1756:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17568C0D652AF842D00383F5E5550@DM5PR12MB1756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(189003)(199004)(8936002)(81156014)(26005)(81166006)(52116002)(478600001)(6512007)(36756003)(5660300002)(1076003)(186003)(2616005)(2906002)(6666004)(66476007)(4326008)(66946007)(66556008)(44832011)(6916009)(8676002)(6486002)(86362001)(6506007)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1756;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YOyRwMiuqennvCOeL5xOB4cfymV6WWvAKZwRQ/xOIwgQSioSYNegagQ1Jrh4aCuJRnZ66QzbqUACc72eV3O8Zh1IlN/E1hr9O7kP7iHu7PnDo4s3nbm5lHYYC0xEwC2Bouk4zRDAbfxmtsnld66hZDxtNniKl2nomO+czljWk2NALtb49ADVZ22kkZryM4Utz5h9sHA9QaD9tPeudDB1nu5yntdzDR56KJvOGd3+hDlXIBBx73n7DR+6N68NA9R2k9rD2Tv8PTriFiiiiXI4yT0FYyOsLcvAZ7+vGF11gczes6lI92mHrsJRg6hrgt3+Md2Twm9n4gK3vMZB0Qd/lNwIM7rVCnZdlbDYxNdawdE9YYr9dcmSKAKqIAggkTWtteJyyNUed97BlTJ4KOYVnWWcynadR85b9mJv9s/dtnuI98ntCMNxHq/VDVdYQ9A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5110662a-ba33-441e-9e79-08d77f1d5ee1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 16:07:22.1936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4HQh6Cm6I9LD14knaEXJElurnnYyHHPz62yHU04OMpMBJ96hWCbk76Igq17nS8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
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

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 88 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h   |  2 +
 5 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 428cfd58b37d..e962c87d04cf 100644
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
@@ -71,7 +68,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	unsigned char fw_check;
 	int i, r;
 
-	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
+	/* For VCN2.0 and above */
+	if (adev->asic_type >= CHIP_ARCTURUS)
+		INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
 
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
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
index 652cecc030b3..7395286540e1 100644
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
@@ -101,6 +104,7 @@ static int vcn_v1_0_sw_init(void *handle)
 			return r;
 	}
 
+	INIT_DELAYED_WORK(&adev->vcn.idle_work, vcn_v1_0_idle_work_handler);
 	r = amdgpu_vcn_sw_init(adev);
 	if (r)
 		return r;
@@ -1758,6 +1762,86 @@ static int vcn_v1_0_set_powergating_state(void *handle,
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
@@ -1804,7 +1888,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
 	.insert_start = vcn_v1_0_dec_ring_insert_start,
 	.insert_end = vcn_v1_0_dec_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.begin_use = amdgpu_vcn_ring_begin_use,
+	.begin_use = vcn_v1_0_ring_begin_use,
 	.end_use = amdgpu_vcn_ring_end_use,
 	.emit_wreg = vcn_v1_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v1_0_dec_ring_emit_reg_wait,
@@ -1836,7 +1920,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs = {
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
