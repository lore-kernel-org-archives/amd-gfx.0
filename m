Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3C606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pQi9IU33
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F090710F963;
	Wed, 21 Oct 2026 06:27:44 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEAD310F96E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmgN9hPMtLuHVa7MKvrUZQ9HwDsTGcNYQBANjC234bOiNot11fmHz7CLguFG7GWYCb8eSHtXWZgOnWWZgysmBv0tqDj9JLpzQv+jT5VHPnOb+0ypg5XQrYDDBPEp1FQqt1EzZXR+bLjnxQssqDhh2ZAyQcfsYG6sjLttGR00bv3G5S/8a+QIsD1ehSnE1TmcBCuGFwT1ioPvx8u/v+lnJpuF409JZLUN4vHjONQG1zBRcFksT6E3Ov/GmkEcNGHcl6+dyTd6Fvrjr2JvLwJ9JmSs2ezhQsSJEjciIO2RCsifesPbP409OGovS3A89kw/SExvsrGdwrEknGY6mGX3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSFvLhuOD/HguVBkC0cDZP7HNYCJFTqYuX3K9Y4Rt4o=;
 b=lQp/3vhaRuUBOQl2SkCfdrFP/DEoIlGrzP1nORhBKZzaV5p+hJ4r/koXCC4lkrbWEhYOVBAmGAivKzqLZRlYWKCPhScyzOHEDGLpptQh7v+m6qds6ifJtRrVqICbDfm1iTQaem07V6U/yXPG54LNVYRKRaTu4awgKzfMVIKwhLrF+fEtNzZeVbLAJmzsWXZYE1OJrhrqoCvwfQCODw3FeyhrYJ6AVD8k8CvzD/v7TAVPjFrsJml32OEqKS9u6+taVFnd7rBQ10wex/dh2DxPywjpdpvTlvWh0YfaX/QMXdl1Gl52+ehUfAwA80rY3sheM/LUCkrN1uxhr9eCyUnvIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSFvLhuOD/HguVBkC0cDZP7HNYCJFTqYuX3K9Y4Rt4o=;
 b=pQi9IU33Gmk0eibV4dD6qvkFGSjyjREHvK6MC+ZRmr+Eu36mutUS7OOaWizmrJ8jz1I61m6dHvANIgdsYCUEWkN9MCaPeGng6h2LxohwEXXb/4G6c6CoOj8/KtGvhF1viG2qSYt0BaXuor7vqLz1XEGH9vhZae50MqaI7t/Vc3g=
Received: from BN9PR03CA0978.namprd03.prod.outlook.com (2603:10b6:408:109::23)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:27:34 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::22) by BN9PR03CA0978.outlook.office365.com
 (2603:10b6:408:109::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.18 via Frontend Transport; Wed,
 21 Oct 2026 06:27:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:33 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:30 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 35/49] drm/amd/display: Add BIOS, link,
 DSC and cursor lock to get_hw_state
Date: Wed, 21 Oct 2026 14:22:41 +0800
Message-ID: <20261021062519.674697-36-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 88596fc2-28af-4e19-80e2-08df2f3c64ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|261009221227099003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SYvG59sYg5fdWavGfNJ+VxT4UQqkdQ0TxfbD0XtLK9bNcFDqLjbTlQynk0+bdduuyPuJv+NbzDUi3VrbiDXugR9VoCTezHutiyLoidjLHonMxtA0SdYujapP9e3XEYonpr994GVNZX/gdF7Su0LLV/s1bo6Tlr5KQ4nLcSZydWwomOdGFOWx8m9hELjgsYI1Lgw2+QPGHIBgKrmjNrrnqX9aPSgtHMbv/210gcKIHCyGzcGl4rjZ6hpLTukMVVJMYj2AUffEvwp3JjhcRkfsM5PERqMMPp7x9M8Z2PT4pzqdyv3xv/17++AYJaJ/d/Io9lN2+FaedLtiQMNlczaDRsUmXWvOEuGYCJqgjsuL0jp+JJWHa9BxX/R1p3uJKlj1lZJlf3xCH1jLHwnINe4rNETivHM3esQVrZ3npocO1mEFVMoSi7QmKk3zb8pPEp5o7dmtZXL4uczM68PM1ExlBxhQJeon2bYb1p2x17YyM6K8uw8uu4l9UGX08C86NOvbIaHQs9Nuq+iWChk8Pei2LWMwBji8ClUEvFOXd39dSLKmjTJYQqup/D28IqAjoWnXHkPMLLOuOKgBXyWaEgNCXSbNGWCYqW9VDWWhRfmL2e7e0SRHx4fErDex4N0q34babvrigIPsCgvRwkLvprMfIXc5VgtOOZ0W4brkqJqgt+3RtcNBHdUcZB6vLBoTuVf5jQphItj8LMtpGEOdl0pO+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009221227099003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MqbBoc67XytU6u4RCzWfyICEDCQUuxgmxETen0hue/xS79HJNIADUFM9QHtTKdQBlHNTpDyiDXgOaoR+oMmOPqgzh0Xxk8cm1F5aUYrgU+Idmyk672q+SZ9FE13EjSGLqzB0WEPwfKz4J4HtHv1Et97t1/kbA92oAnFHErbZLTzECDeQj5lSDZEQhEbW+lVEOEdtV/j/46fVFHFDWVd9jhq6xmhNhH60mup6UMdPSgOsfR9bfsenz17Lk7S88AnDFLA6mH204RPSLNEule4TO1Y0iAeTNXEl3CJ/u5Hm7zSmjA1cUwQnFb9JQfGjNQb9LTWCYOP6I0Hx4EJ0Ebj58nvsG1fRspTs4xa9YSbpYR+RQlEw5qrRCelqc/OwDKd6+g5t53zjxFzEf9xxRd5yQPYfhnYIbL9sqHlYLadutIZSZ1cGkgLaJMrhPAORmjNs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:34.5237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88596fc2-28af-4e19-80e2-08df2f3c64ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

get_hw_state shows OTG timing but not which DIG drives an OTG, so it
cannot tell what VBIOS or GOP left lit. Add four opt-in sections,
read from existing hooks without programming anything:

BIOS (0x10000): acc_mode from is_accelerated_mode.
LINK (0x20000): per physical link, the transmitter, HPD, DIG enable,
mode and frontend, the OTG that frontend sources, the preferred
engine, and phy_on/phy_active from the RDPCS state.
DSC (0x40000): clock enable, slice width and bits per pixel.
CURSOR_LOCK (0x80000): mpcc,opp,cur_lock for each MPCC attached to
an OPP. A lock on an OPP with no MPCC attached is not reported.

Fields a generation's reader does not fill print -1. The bits sit
above the original 16, so mask 0 and 0xFFFF return the same text as
before.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index feb6ca92802c..37a010e0bd6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -44,6 +44,7 @@
 #include "dcn10/dcn10_hubbub.h"
 #include "dcn10_cm_common.h"
 #include "clk_mgr.h"
+#include "dsc.h"
 
 __printf(3, 4)
 unsigned int snprintf_count(char *pbuf, unsigned int bufsize, const char *fmt, ...)
@@ -488,6 +489,149 @@ static unsigned int dcn10_get_clock_states(struct dc *dc, char *pBuf, unsigned i
 	return bufSize - remaining_buffer;
 }
 
+static unsigned int dcn10_get_bios_state(struct dc *dc, char *pBuf, unsigned int bufSize)
+{
+	struct dc_bios *bios = dc->ctx->dc_bios;
+	int acc_mode = -1;
+
+	if (bios && bios->funcs->is_accelerated_mode)
+		acc_mode = bios->funcs->is_accelerated_mode(bios);
+
+	return snprintf_count(pBuf, bufSize, "acc_mode\n%d\n", acc_mode);
+}
+
+/* Preset in a read_state struct for fields that only some generations read. */
+#define HW_STATE_NOT_READ 0xFFFFFFFF
+
+static int dcn10_dig_source_otg(struct dc *dc, unsigned int fe)
+{
+	struct resource_pool *pool = dc->res_pool;
+	unsigned int i;
+
+	for (i = 0; i < pool->stream_enc_count; i++) {
+		struct stream_encoder *se = pool->stream_enc[i];
+
+		if (se && se->id == fe && se->funcs->dig_source_otg)
+			return se->funcs->dig_source_otg(se);
+	}
+	return -1;
+}
+
+static unsigned int dcn10_get_link_states(struct dc *dc, char *pBuf, unsigned int bufSize)
+{
+	unsigned int chars_printed = 0;
+	unsigned int remaining_buffer = bufSize;
+	unsigned int i;
+
+	chars_printed = snprintf_count(pBuf, remaining_buffer,
+		"link,enc,hpd,dig_en,dig_mode,dig_fe,src_otg,preferred_otg,phy_on,phy_active\n");
+	remaining_buffer -= chars_printed;
+	pBuf += chars_printed;
+
+	for (i = 0; i < dc->link_count && remaining_buffer > 0; i++) {
+		struct dc_link *link = dc->links[i];
+		struct link_encoder *enc = link ? link->link_enc : NULL;
+		int hpd = -1, dig_en = -1, dig_mode = -1, dig_fe = -1, src_otg = -1;
+		int phy_on = -1, phy_active = -1;
+		struct link_enc_state s = {0};
+
+		if (!enc || link->connector_signal == SIGNAL_TYPE_VIRTUAL)
+			continue;
+
+		if (enc->funcs->get_hpd_state)
+			hpd = enc->funcs->get_hpd_state(enc);
+		if (enc->funcs->is_dig_enabled)
+			dig_en = enc->funcs->is_dig_enabled(enc);
+		if (dig_en == 1 && enc->funcs->get_dig_mode)
+			dig_mode = enc->funcs->get_dig_mode(enc);
+		if (dig_en == 1 && enc->funcs->get_dig_frontend) {
+			dig_fe = enc->funcs->get_dig_frontend(enc);
+			src_otg = dcn10_dig_source_otg(dc, dig_fe);
+		}
+		s.rdpcs_phy_reset = HW_STATE_NOT_READ;
+		s.rdpcs_tx_data_en = HW_STATE_NOT_READ;
+		if (enc->funcs->read_state)
+			enc->funcs->read_state(enc, &s);
+		if (s.rdpcs_phy_reset != HW_STATE_NOT_READ)
+			phy_on = s.rdpcs_phy_reset == 0;
+		if (s.rdpcs_tx_data_en != HW_STATE_NOT_READ)
+			phy_active = s.rdpcs_tx_data_en != 0;
+
+		chars_printed = snprintf_count(pBuf, remaining_buffer,
+			"%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
+			i, enc->transmitter, hpd, dig_en, dig_mode, dig_fe,
+			src_otg, enc->preferred_engine, phy_on, phy_active);
+		remaining_buffer -= chars_printed;
+		pBuf += chars_printed;
+	}
+
+	return bufSize - remaining_buffer;
+}
+
+static unsigned int dcn10_get_dsc_states(struct dc *dc, char *pBuf, unsigned int bufSize)
+{
+	struct resource_pool *pool = dc->res_pool;
+	unsigned int chars_printed = 0;
+	unsigned int remaining_buffer = bufSize;
+	unsigned int i;
+
+	if (pool->res_cap->num_dsc == 0)
+		return 0;
+
+	chars_printed = snprintf_count(pBuf, remaining_buffer,
+		"dsc,clock_en,slice_width,bits_pp\n");
+	remaining_buffer -= chars_printed;
+	pBuf += chars_printed;
+
+	for (i = 0; i < (unsigned int)pool->res_cap->num_dsc && remaining_buffer > 0; i++) {
+		struct display_stream_compressor *dsc = pool->dscs[i];
+		struct dcn_dsc_state s = {0};
+
+		if (!dsc || !dsc->funcs->dsc_read_state)
+			continue;
+
+		dsc->funcs->dsc_read_state(dsc, &s);
+		chars_printed = snprintf_count(pBuf, remaining_buffer,
+			"%d,%d,%d,%d\n", i, s.dsc_clock_en,
+			s.dsc_slice_width, s.dsc_bits_per_pixel);
+		remaining_buffer -= chars_printed;
+		pBuf += chars_printed;
+	}
+
+	return bufSize - remaining_buffer;
+}
+
+static unsigned int dcn10_get_cursor_lock_states(struct dc *dc, char *pBuf, unsigned int bufSize)
+{
+	struct resource_pool *pool = dc->res_pool;
+	unsigned int chars_printed = 0;
+	unsigned int remaining_buffer = bufSize;
+	unsigned int i;
+
+	chars_printed = snprintf_count(pBuf, remaining_buffer, "mpcc,opp,cur_lock\n");
+	remaining_buffer -= chars_printed;
+	pBuf += chars_printed;
+
+	for (i = 0; i < pool->mpcc_count && remaining_buffer > 0; i++) {
+		struct mpcc_state s = {0};
+		int lock = -1;
+
+		s.cur_vupdate_lock = HW_STATE_NOT_READ;
+		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
+		if (s.opp_id == 0xf)
+			continue;
+		if (s.cur_vupdate_lock != HW_STATE_NOT_READ)
+			lock = s.cur_vupdate_lock;
+
+		chars_printed = snprintf_count(pBuf, remaining_buffer, "%d,%d,%d\n",
+			i, s.opp_id, lock);
+		remaining_buffer -= chars_printed;
+		pBuf += chars_printed;
+	}
+
+	return bufSize - remaining_buffer;
+}
+
 static void dcn10_clear_otpc_underflow(struct dc *dc)
 {
 	struct resource_pool *pool = dc->res_pool;
@@ -548,6 +692,7 @@ void dcn10_get_hw_state(struct dc *dc, char *pBuf, unsigned int bufSize, unsigne
 	 *  Mask Format
 	 *  Bit 0 - 15: Hardware block mask
 	 *  Bit 15: 1 = Invariant Only, 0 = All
+	 *  Bit 16 and up: opt-in blocks, never selected by mask 0
 	 */
 	const unsigned int DC_HW_STATE_MASK_HUBBUB			= 0x1;
 	const unsigned int DC_HW_STATE_MASK_HUBP			= 0x2;
@@ -559,6 +704,10 @@ void dcn10_get_hw_state(struct dc *dc, char *pBuf, unsigned int bufSize, unsigne
 	const unsigned int DC_HW_STATE_MASK_OTG				= 0x80;
 	const unsigned int DC_HW_STATE_MASK_CLOCKS			= 0x100;
 	const unsigned int DC_HW_STATE_INVAR_ONLY			= 0x8000;
+	const unsigned int DC_HW_STATE_MASK_BIOS			= 0x10000;
+	const unsigned int DC_HW_STATE_MASK_LINK			= 0x20000;
+	const unsigned int DC_HW_STATE_MASK_DSC				= 0x40000;
+	const unsigned int DC_HW_STATE_MASK_CURSOR_LOCK		= 0x80000;
 
 	unsigned int chars_printed = 0;
 	unsigned int remaining_buf_size = bufSize;
@@ -619,4 +768,28 @@ void dcn10_get_hw_state(struct dc *dc, char *pBuf, unsigned int bufSize, unsigne
 		pBuf += chars_printed;
 		remaining_buf_size -= chars_printed;
 	}
+
+	if ((mask & DC_HW_STATE_MASK_BIOS) && remaining_buf_size > 0) {
+		chars_printed = dcn10_get_bios_state(dc, pBuf, remaining_buf_size);
+		pBuf += chars_printed;
+		remaining_buf_size -= chars_printed;
+	}
+
+	if ((mask & DC_HW_STATE_MASK_LINK) && remaining_buf_size > 0) {
+		chars_printed = dcn10_get_link_states(dc, pBuf, remaining_buf_size);
+		pBuf += chars_printed;
+		remaining_buf_size -= chars_printed;
+	}
+
+	if ((mask & DC_HW_STATE_MASK_DSC) && remaining_buf_size > 0) {
+		chars_printed = dcn10_get_dsc_states(dc, pBuf, remaining_buf_size);
+		pBuf += chars_printed;
+		remaining_buf_size -= chars_printed;
+	}
+
+	if ((mask & DC_HW_STATE_MASK_CURSOR_LOCK) && remaining_buf_size > 0) {
+		chars_printed = dcn10_get_cursor_lock_states(dc, pBuf, remaining_buf_size);
+		pBuf += chars_printed;
+		remaining_buf_size -= chars_printed;
+	}
 }
-- 
2.43.0

