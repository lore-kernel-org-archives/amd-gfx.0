Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA7C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 03:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B476108D
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 03:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B476108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 257E96EAC0;
	Fri, 16 Apr 2021 03:18:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AEA16EAC0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 03:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQbQjeUTQISFw/ETMfLbmhtDcOFf0fgJTbHIXDWXCnUg1PosK4Vseq4TZtszjSp5/eWkXJVtNyiHcYPT6sW7aAGPbMoQTSNFUmqwXc73vkpFp84ZNzAti9vlqzNhzKP0TpggooW1/mmPjjiS6eJiSPGmZtD6MDlQkgvrNj0E2O1dimFetQRqPf780b2hb/GJG3fMssN5Uxs2Z/0NiE14zlBsG12qQ3n0VSad523TOmd0IkmBmh/zDytx8TunBz3i+gIkxGKU5aK94HN2Zmh9eseNfezDHkCtnRd32JwrwsU3RT68aTT2CyuadXoNwFyNpQEY0FCw7bgBKUt6ezL/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3+s/ZUOPHEiNNenbrN7177gAfJRZDZpx+L3HTf2uuc=;
 b=D20ToPudS/jh/YbfD/tHYVsy15W3DAwOznfC9Vb+h4IvYnI2S+3vrhTajriv/8SIkil3O81TRFfwvgN1u/A5KoyFWO6ZWpQRWWCv1o3BhAMX9LyQ97DYIdwBmH8uXPfPD04NO+39umf+pXJvBtjC5iGD5V95ZlOgQrEQ3Yx16Ro9XWq+moAo72d/CtLKRn7k1AJUPhjdz9NYAq/rlIAnHTsN1fqfhxdu1PWHH8VkRToKrFYr9FakBJdmL3V/VDYsHGftJnrK53jHH+Sj8My2IjhArVs/cvchMly6vpGO2rRYVwkrQbUubStJvSvuh4BnSt0rQuVUgG3cXLhi39fiSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3+s/ZUOPHEiNNenbrN7177gAfJRZDZpx+L3HTf2uuc=;
 b=LtBdphLU/MpOCCYyyy0Qiqk1MQ0v+3/IscKO74bFpL7w2Ue9eShtEIcj4MXapdxqOsXPsSOVA3w4yBQ9428lDmNqGwK6Qpq4/qzVDVsuumy+sh5mkZ9kGY/8jyoz+l49vetkR74GrqrdBiwWYNujp2jo+fTHDvdTGt5j0HfAkKA=
Received: from DM5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:3:23::15) by
 MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 03:18:07 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::bc) by DM5PR13CA0005.outlook.office365.com
 (2603:10b6:3:23::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend
 Transport; Fri, 16 Apr 2021 03:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 03:18:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Apr
 2021 22:18:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Apr
 2021 22:18:05 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 15 Apr 2021 22:18:03 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdkfd: add edc error interrupt handle for poison
 propogate mode
Date: Fri, 16 Apr 2021 11:17:50 +0800
Message-ID: <20210416031750.32391-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16a6ac00-7467-4e25-6811-08d90086413e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4272:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4272A47E50CC0C890996EA40ED4C9@MN2PR12MB4272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:203;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zv7pGxe2D05xk3bZsDzvS5x1NiL1ZdGGkNYCg/Yfo3Jk9oAjivHj6xA5Eaqfltc/FMg743m1fpqnKDZ9Y6V2763sPZfksrOu1W892vFwqOErAAXtCI53nYZiAyZGClmNHn8wn5Ki3nm/5DP0WgXHOCiENSEnckE9Al1viIOnpOaBL2VZQ09Mw/VbMknZkvoqpCn77llb53NuoiSKvxRaXyw+UEZ4Z2ogn5IjHQmVWci1k2adXIacLddooGetFb8sj6CUWJLMPV4EWWBDM0GQw7wD8Aq3T+5b4/fi02no0B4kFf08Tq7Ln6t2uKQbUjDLnN1lKN1UG1YioBW5cvKrYIWhQvWBKCwOECZKpCQKApM1ePR18+s1vScaDUZeBd2rrNNvWb4a1tX6mgyQVzbFVEim/YftiQFjOZMBfALWWAvnj1jROUi84WwVWbCMO2aAAlFg5pinvNdhFujhr8VdsH5DTqfhJaDxW64SYeShKj0RKy3ab8WHbvYPYmynEasPJctwc3l14PJjzRyTBzfQ9pdE9p1SPyY1rPnzJ+dSE3G2lO46yY3AUKIU3hSsnhfyuR0Jf/vBaK0W3W9qTtW/jrQJkCQw415C6ulp5qLiUx4Mg/q3eafwpWkSJaxaT+x1VZtdykmpGwymqmS00sviOJV6ze2g6Uo8jiTh+St7wv0Z3sgvaW3120LjlreGEGW337AN72LHUw7bK1nKATVvLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(46966006)(47076005)(82310400003)(26005)(36860700001)(6666004)(6636002)(36756003)(86362001)(4326008)(1076003)(186003)(7696005)(316002)(356005)(478600001)(110136005)(82740400003)(70586007)(2906002)(70206006)(426003)(336012)(81166007)(5660300002)(8676002)(2616005)(8936002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 03:18:06.8793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a6ac00-7467-4e25-6811-08d90086413e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In poison progogate mode, when driver receive the edc error interrupt
from SQ, driver should kill the process by pasid which is using the
poison data, and then trigger GPU reset.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 1c20458f3962..696944fa0177 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -25,6 +25,70 @@
 #include "soc15_int.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_smi_events.h"
+#include "amdgpu.h"
+
+enum SQ_INTERRUPT_WORD_ENCODING {
+	SQ_INTERRUPT_WORD_ENCODING_AUTO = 0x0,
+	SQ_INTERRUPT_WORD_ENCODING_INST,
+	SQ_INTERRUPT_WORD_ENCODING_ERROR,
+};
+
+enum SQ_INTERRUPT_ERROR_TYPE {
+	SQ_INTERRUPT_ERROR_TYPE_EDC_FUE = 0x0,
+	SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST,
+	SQ_INTERRUPT_ERROR_TYPE_MEMVIOL,
+	SQ_INTERRUPT_ERROR_TYPE_EDC_FED,
+};
+
+/* SQ_INTERRUPT_WORD_AUTO_CTXID */
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE__SHIFT 0
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__WLT__SHIFT 1
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_BUF_FULL__SHIFT 2
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__REG_TIMESTAMP__SHIFT 3
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__CMD_TIMESTAMP__SHIFT 4
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__HOST_CMD_OVERFLOW__SHIFT 5
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__HOST_REG_OVERFLOW__SHIFT 6
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__IMMED_OVERFLOW__SHIFT 7
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_UTC_ERROR__SHIFT 8
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__SE_ID__SHIFT 24
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__ENCODING__SHIFT 26
+
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_MASK 0x00000001
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__WLT_MASK 0x00000002
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_BUF_FULL_MASK 0x00000004
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__REG_TIMESTAMP_MASK 0x00000008
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__CMD_TIMESTAMP_MASK 0x00000010
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__HOST_CMD_OVERFLOW_MASK 0x00000020
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__HOST_REG_OVERFLOW_MASK 0x00000040
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__IMMED_OVERFLOW_MASK 0x00000080
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_UTC_ERROR_MASK 0x00000100
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__SE_ID_MASK 0x03000000
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__ENCODING_MASK 0x0c000000
+
+/* SQ_INTERRUPT_WORD_WAVE_CTXID */
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__DATA__SHIFT 0
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__SH_ID__SHIFT 12
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__PRIV__SHIFT 13
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__WAVE_ID__SHIFT 14
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__SIMD_ID__SHIFT 18
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__CU_ID__SHIFT 20
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__SE_ID__SHIFT 24
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__ENCODING__SHIFT 26
+
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__DATA_MASK 0x00000fff
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__SH_ID_MASK 0x00001000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__PRIV_MASK 0x00002000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__WAVE_ID_MASK 0x0003c000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__SIMD_ID_MASK 0x000c0000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__CU_ID_MASK 0x00f00000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__SE_ID_MASK 0x03000000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__ENCODING_MASK 0x0c000000
+
+#define KFD_CONTEXT_ID_GET_SQ_INT_DATA(ctx0, ctx1)                             \
+	((ctx0 & 0xfff) | ((ctx0 >> 16) & 0xf000) | ((ctx1 << 16) & 0xff0000))
+
+#define KFD_SQ_INT_DATA__ERR_TYPE_MASK 0xF00000
+#define KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
 
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
@@ -108,13 +172,15 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry)
 {
 	uint16_t source_id, client_id, pasid, vmid;
-	uint32_t context_id;
+	uint32_t context_id0, context_id1;
+	uint32_t sq_intr_err, sq_int_data, encoding;
 
 	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
 	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
 	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
 	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
-	context_id = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
+	context_id0 = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
+	context_id1 = SOC15_CONTEXT_ID1_FROM_IH_ENTRY(ih_ring_entry);
 
 	if (client_id == SOC15_IH_CLIENTID_GRBM_CP ||
 	    client_id == SOC15_IH_CLIENTID_SE0SH ||
@@ -122,10 +188,59 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 	    client_id == SOC15_IH_CLIENTID_SE2SH ||
 	    client_id == SOC15_IH_CLIENTID_SE3SH) {
 		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
-			kfd_signal_event_interrupt(pasid, context_id, 32);
-		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG)
-			kfd_signal_event_interrupt(pasid, context_id & 0xffffff, 24);
-		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
+			kfd_signal_event_interrupt(pasid, context_id0, 32);
+		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG) {
+			sq_int_data = KFD_CONTEXT_ID_GET_SQ_INT_DATA(context_id0, context_id1);
+			encoding = REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, ENCODING);
+			switch (encoding) {
+			case SQ_INTERRUPT_WORD_ENCODING_AUTO:
+				pr_debug(
+					"sq_intr: auto, se %d, ttrace %d, wlt %d, ttrac_buf_full %d, reg_tms %d, cmd_tms %d, host_cmd_ovf %d, host_reg_ovf %d, immed_ovf %d, ttrace_utc_err %d\n",
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, SE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, THREAD_TRACE),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, WLT),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, THREAD_TRACE_BUF_FULL),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, REG_TIMESTAMP),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, CMD_TIMESTAMP),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, HOST_CMD_OVERFLOW),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, HOST_REG_OVERFLOW),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, IMMED_OVERFLOW),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, THREAD_TRACE_UTC_ERROR));
+				break;
+			case SQ_INTERRUPT_WORD_ENCODING_INST:
+				pr_debug("sq_intr: inst, se %d, data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, intr_data 0x%x\n",
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, DATA),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SH_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, PRIV),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, WAVE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SIMD_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, CU_ID),
+					sq_int_data);
+				break;
+			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
+				sq_intr_err = REG_GET_FIELD(sq_int_data, KFD_SQ_INT_DATA, ERR_TYPE);
+				pr_warn("sq_intr: error, se %d, data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, err_type %d\n",
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, DATA),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SH_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, PRIV),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, WAVE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SIMD_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, CU_ID),
+					sq_intr_err);
+				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
+					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
+					kfd_signal_hw_exception_event(pasid);
+					amdgpu_amdkfd_gpu_reset(dev->kgd);
+					return;
+				}
+				break;
+			default:
+				break;
+			}
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xffffff, 24);
+		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
 			kfd_signal_hw_exception_event(pasid);
 	} else if (client_id == SOC15_IH_CLIENTID_SDMA0 ||
 		   client_id == SOC15_IH_CLIENTID_SDMA1 ||
@@ -136,7 +251,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		   client_id == SOC15_IH_CLIENTID_SDMA6 ||
 		   client_id == SOC15_IH_CLIENTID_SDMA7) {
 		if (source_id == SOC15_INTSRC_SDMA_TRAP)
-			kfd_signal_event_interrupt(pasid, context_id & 0xfffffff, 28);
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
 		   client_id == SOC15_IH_CLIENTID_VMC1 ||
 		   client_id == SOC15_IH_CLIENTID_UTCL2) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
