Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41F5C2D0C6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5F92173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QwXh4FDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5F92173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EBC16EB8C;
	Wed, 11 Dec 2019 15:33:44 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760050.outbound.protection.outlook.com [40.107.76.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D1D26EB8C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6Jiv43oIrv77/CbUUsOoWaVIGgvX61am/SAXq1C5heGJkW8uV9NtMF/tqeFMa0qGk8jTrYVOvsQfP/QDtOp2IBsZeAYAEFGK28oZkt//dPzwJD+lblMYHb7wvVGzFtkY1xNSIa147JCnVK3u6/W3PD8ZaMm93EOwLPyeAsuFQzeJ2Z0kHBAYC8t8YazfKli/27xSpKdvhyDCdPSwzMMOtYWhHHF/2qdFyCh0gO94FTjxMR5gKyg0YfZAoA5iG4rxAW5LPSTienNTbg9ngL9/cpxcKMVrk9WVPOhDvCLtm+w24xnFVzQYwelDtcvUNnT57HcUsJA33b3UM/Q4/vESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLugb/Ih7TbWxNzFx/zoq2AsNj/2+gfFfAA9zKMuzj0=;
 b=OgNoV+ucPC2UasCwuVztJs+XL39YYsZyAB4pzFHF8bzywbWkZ2lleXvau8Ggw2yt9tca6iXNIfqzhQQoRYNRvSiPHQmVS3U7f7B5Ap8DOAevjN8zldbRtisTZ3WNP6bg1qtUMeSJ8jJxinQ5MLsFpTFaEJOs7aVcN7wkC/clp833YORIJakNgIcw1uIa/dv5eiG0guDpuXYmHhWEihrdd0htL/d+YWhupuofwWfRTQ0h15GCWcuASAcL/U7YK+7o8sucdp/En0op3BvIssqL5R8EFyHm4rKEP+IpEqkL5wwL1nq4nuq8IAUn1mtq9KWU/oMOrnpJG69yERRwrvfARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLugb/Ih7TbWxNzFx/zoq2AsNj/2+gfFfAA9zKMuzj0=;
 b=QwXh4FDf2Z4ILZKGGyKIqXPiZ6pw6jxmEFua21hL9chO57icn5hv++6YFNDvCegkKJ3lVn7mvQuC4CWRWf98/7nl01WdTdDO/1TfpQVF9/y1BBPLnmMDZcV4yLHUtFyth0iJEi7CsoZYK/b0SwvyqnSEk9Ars9sBibanlyU+AQM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:40 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:40 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/39] drm/amd/display: Get cache window sizes from DMCUB
 firmware
Date: Wed, 11 Dec 2019 10:32:41 -0500
Message-Id: <20191211153253.2291112-28-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c768917-9c0c-4f49-ee1f-08d77e4f7f9d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB249190B5F0AE86BF2DA77CD5985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Da7OU8GzNjIXxV3iQt0tenMaXpB9sEYWjdaox5VoeYle/z6v6nUez4Tc1nWyLSUGp0hNRgtg15pMeHglgdE33SL+h+O8RdtnVssUAV/Sv4Fy7SaFUkxY8FsEtwEUtkfkNqEg8oeJfXVBQm14o/yuVrVSmVKffNxcL1MdSh9zSCkDzTAPsdU2RFfQ63ppoA6U0Q4LfCLhAv3SqIRuhMhreIs5TN+erglVhrTDcQVvgC17EsV4jNt6BNZAkz8S1L/Huflp0AuRD5/NAURe6+13g/FSDsMijeSm7xKeV5MBskNrFVP0qrfW2OlwZSA4V9mut0sSXXX9Qi+q+0cWdWuMRRInvt+Wb6reO29kXdmybLdivQ+eJMoBIkpMM+p5dHjhnxkwJsxnaFU++2GnBaeS1RALdIKwi1QKgR0CdIvdFAMAvqi+zhaEvhZ30KIbqoP5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c768917-9c0c-4f49-ee1f-08d77e4f7f9d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:40.6576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWfdEQaBu3raigzApzr6SEV8oBaj3h+UuS858uD2PRk6Cih39HzAQYpkk0CVuv9VRD+N+E70pF3h8CHPE4r12w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Firmware state and tracebuffer shouldn't be considered stable API
between firmware versions.

Driver shouldn't be querying anything from firmware state or tracebuffer
outside of debugging.

Commands are the stable API for this once we have the outbox.

[How]
Add metadata struct to the end of the data firmware that describes
fw_state_size and some reserved area for future use.

Drop the tracebuffer and firmware state headers since they can differ
per version.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++
 .../inc/{dmub_fw_state.h => dmub_fw_meta.h}   | 64 ++++++++-----------
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   |  3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 51 +++++++++++++--
 4 files changed, 78 insertions(+), 44 deletions(-)
 rename drivers/gpu/drm/amd/display/dmub/inc/{dmub_fw_state.h => dmub_fw_meta.h} (57%)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8cdfb3ccb710..745d8719ccc1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1234,6 +1234,10 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 					PSP_HEADER_BYTES - PSP_FOOTER_BYTES;
 	region_params.bss_data_size = le32_to_cpu(hdr->bss_data_bytes);
 	region_params.vbios_size = adev->bios_size;
+	region_params.fw_bss_data =
+		adev->dm.dmub_fw->data +
+		le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
+		le32_to_cpu(hdr->inst_const_bytes);
 
 	status = dmub_srv_calc_region_info(dmub_srv, &region_params,
 					   &region_info);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_state.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h
similarity index 57%
rename from drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_state.h
rename to drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h
index c87b1ba7590e..242ec257998c 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_state.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h
@@ -22,52 +22,42 @@
  * Authors: AMD
  *
  */
-
-#ifndef _DMUB_FW_STATE_H_
-#define _DMUB_FW_STATE_H_
+#ifndef _DMUB_META_H_
+#define _DMUB_META_H_
 
 #include "dmub_types.h"
 
 #pragma pack(push, 1)
 
-struct dmub_fw_state {
-	/**
-	 * @phy_initialized_during_fw_boot:
-	 *
-	 * Detects if VBIOS/VBL has ran before firmware boot.
-	 * A value of 1 will usually mean S0i3 boot.
-	 */
-	uint8_t phy_initialized_during_fw_boot;
-
-	/**
-	 * @intialized_phy:
-	 *
-	 * Bit vector of initialized PHY.
-	 */
-	uint8_t initialized_phy;
+/* Magic value for identifying dmub_fw_meta_info */
+#define DMUB_FW_META_MAGIC 0x444D5542
 
-	/**
-	 * @enabled_phy:
-	 *
-	 * Bit vector of enabled PHY for DP alt mode switch tracking.
-	 */
-	uint8_t enabled_phy;
+/* Offset from the end of the file to the dmub_fw_meta_info */
+#define DMUB_FW_META_OFFSET 0x24
 
-	/**
-	 * @dmcu_fw_loaded:
-	 *
-	 * DMCU auto load state.
-	 */
-	uint8_t dmcu_fw_loaded;
+/**
+ * struct dmub_fw_meta_info - metadata associated with fw binary
+ *
+ * NOTE: This should be considered a stable API. Fields should
+ *       not be repurposed or reordered. New fields should be
+ *       added instead to extend the structure.
+ *
+ * @magic_value: magic value identifying DMUB firmware meta info
+ * @fw_region_size: size of the firmware state region
+ * @trace_buffer_size: size of the tracebuffer region
+ */
+struct dmub_fw_meta_info {
+	uint32_t magic_value;
+	uint32_t fw_region_size;
+	uint32_t trace_buffer_size;
+};
 
-	/**
-	 * @psr_state:
-	 *
-	 * PSR state tracking.
-	 */
-	uint8_t psr_state;
+/* Ensure that the structure remains 64 bytes. */
+union dmub_fw_meta {
+	struct dmub_fw_meta_info info;
+	uint8_t reserved[64];
 };
 
 #pragma pack(pop)
 
-#endif /* _DMUB_FW_STATE_H_ */
+#endif /* _DMUB_META_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
index 689806b6ee31..f34a50dd36ea 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
@@ -67,7 +67,6 @@
 #include "dmub_types.h"
 #include "dmub_cmd.h"
 #include "dmub_rb.h"
-#include "dmub_fw_state.h"
 
 #if defined(__cplusplus)
 extern "C" {
@@ -145,11 +144,13 @@ struct dmub_fb {
  * @inst_const_size: size of the fw inst const section
  * @bss_data_size: size of the fw bss data section
  * @vbios_size: size of the vbios data
+ * @fw_bss_data: raw firmware bss data section
  */
 struct dmub_srv_region_params {
 	uint32_t inst_const_size;
 	uint32_t bss_data_size;
 	uint32_t vbios_size;
+	const uint8_t *fw_bss_data;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 16837003721e..9a959f871f11 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -26,7 +26,7 @@
 #include "../inc/dmub_srv.h"
 #include "dmub_dcn20.h"
 #include "dmub_dcn21.h"
-#include "dmub_trace_buffer.h"
+#include "dmub_fw_meta.h"
 #include "os_types.h"
 /*
  * Note: the DMUB service is standalone. No additional headers should be
@@ -46,6 +46,11 @@
 /* Mailbox size */
 #define DMUB_MAILBOX_SIZE (DMUB_RB_SIZE)
 
+/* Default state size if meta is absent. */
+#define DMUB_FW_STATE_SIZE (1024)
+
+/* Default tracebuffer size if meta is absent. */
+#define DMUB_TRACE_BUFFER_SIZE (1024)
 
 /* Number of windows in use. */
 #define DMUB_NUM_WINDOWS (DMUB_WINDOW_6_FW_STATE + 1)
@@ -62,6 +67,27 @@ static inline uint32_t dmub_align(uint32_t val, uint32_t factor)
 	return (val + factor - 1) / factor * factor;
 }
 
+static const struct dmub_fw_meta_info *
+dmub_get_fw_meta_info(const uint8_t *fw_bss_data, uint32_t fw_bss_data_size)
+{
+	const union dmub_fw_meta *meta;
+
+	if (fw_bss_data == NULL)
+		return NULL;
+
+	if (fw_bss_data_size < sizeof(union dmub_fw_meta) + DMUB_FW_META_OFFSET)
+		return NULL;
+
+	meta = (const union dmub_fw_meta *)(fw_bss_data + fw_bss_data_size -
+					    DMUB_FW_META_OFFSET -
+					    sizeof(union dmub_fw_meta));
+
+	if (meta->info.magic_value != DMUB_FW_META_MAGIC)
+		return NULL;
+
+	return &meta->info;
+}
+
 static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 {
 	struct dmub_srv_hw_funcs *funcs = &dmub->hw_funcs;
@@ -162,6 +188,9 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 	struct dmub_region *mail = &out->regions[DMUB_WINDOW_4_MAILBOX];
 	struct dmub_region *trace_buff = &out->regions[DMUB_WINDOW_5_TRACEBUFF];
 	struct dmub_region *fw_state = &out->regions[DMUB_WINDOW_6_FW_STATE];
+	const struct dmub_fw_meta_info *fw_info;
+	uint32_t fw_state_size = DMUB_FW_STATE_SIZE;
+	uint32_t trace_buffer_size = DMUB_TRACE_BUFFER_SIZE;
 
 	if (!dmub->sw_init)
 		return DMUB_STATUS_INVALID;
@@ -176,6 +205,11 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 	data->base = dmub_align(inst->top, 256);
 	data->top = data->base + params->bss_data_size;
 
+	/*
+	 * All cache windows below should be aligned to the size
+	 * of the DMCUB cache line, 64 bytes.
+	 */
+
 	stack->base = dmub_align(data->top, 256);
 	stack->top = stack->base + DMUB_STACK_SIZE + DMUB_CONTEXT_SIZE;
 
@@ -185,14 +219,19 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 	mail->base = dmub_align(bios->top, 256);
 	mail->top = mail->base + DMUB_MAILBOX_SIZE;
 
+	fw_info = dmub_get_fw_meta_info(params->fw_bss_data,
+					params->bss_data_size);
+
+	if (fw_info) {
+		fw_state_size = fw_info->fw_region_size;
+		trace_buffer_size = fw_info->trace_buffer_size;
+	}
+
 	trace_buff->base = dmub_align(mail->top, 256);
-	trace_buff->top = trace_buff->base + TRACE_BUF_SIZE;
+	trace_buff->top = trace_buff->base + dmub_align(trace_buffer_size, 64);
 
 	fw_state->base = dmub_align(trace_buff->top, 256);
-
-	/* Align firmware state to size of cache line. */
-	fw_state->top =
-		fw_state->base + dmub_align(sizeof(struct dmub_fw_state), 64);
+	fw_state->top = fw_state->base + dmub_align(fw_state_size, 64);
 
 	out->fb_size = dmub_align(fw_state->top, 4096);
 
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
