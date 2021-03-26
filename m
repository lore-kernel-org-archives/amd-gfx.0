Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E0CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB3261953
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB3261953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66BC86F4AE;
	Fri, 26 Mar 2021 22:05:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92AAB6F4AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvmR5iQsAVYGsg2EzwKH7AWxl2hXL+77V9uRGM5fd1ErLvzxLjEt5NBujeyELV+cZmpIhPQBNR4xyl1fa3x3QHXhdNOxecequVQvrr7t0BWb+ZGgTsCIe+VJs41LcsqpKk8zXppJxUnbcTRf0LE2EWmai1v3vUd/PLGRNojki1kzEJLZK+GJcgwbj0OLr6EgIbjDVeiTSObcLjBxawvgMqU86QGOWfB3AFrxiy3uIBswtSqWzthfmvI1KHeq68VOxVT8oS0s4Am/ZVY5LFEai37yb4YkEiiDcIJd/nBxPFpo3iA/61JA7+Lz7yElNWBwABRtB0HECjbIM49qNqfi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGfSK0RlAHupohR7sfWBL0YUCL7u4dO/kzwAYrz8BQI=;
 b=maZKuWicX7NA/Wn5Yv6gJAUAORscjtUd5bxiCSSi+ivjG7IaQTLTEFPqlueMbXR9JPewqQg868lT3va3tUvOjMtKzg7fiMiJzcu9Wcb80BmSxCDydZxMEO9IrOu6LsVurdDPcDRfC2z2KAXbVyf3zDPXxe9WH7QLFTElrE0IPgfhXLU5+KR2HQsbGDahuzeYuNzlIWL3P1ctTdzJ2AKJxDms/IkZRWeS/cHZMaVkFHNnw2mhTvgjm31J+4nsPLxXmuqLaa5vLQDIrvmxP6X7UpXvOnULDvTiLcqA49TlIOJ6lYp/mjTeOaJ4WxrV7HIPL7jhBcnzCNr0Vu6ShSVSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGfSK0RlAHupohR7sfWBL0YUCL7u4dO/kzwAYrz8BQI=;
 b=mf0XEcf6TSvncOhRMTX0Bet7QeYm1WNYJnF5oe9gfliupI6a25HWYRknotHVb3TyVIqUSIIkr5App9GODsCFftTgwW+1AgmBZSKxlgRvgq1SnzelBnySH9dNA9eoQ3QMd4DBFkoyIt/wF18XZR4k245dnoGj43c6q6DSQXAzrA8=
Received: from DM3PR12CA0063.namprd12.prod.outlook.com (2603:10b6:0:56::31) by
 CY4PR12MB1478.namprd12.prod.outlook.com (2603:10b6:910:10::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.29; Fri, 26 Mar 2021 22:05:44 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::93) by DM3PR12CA0063.outlook.office365.com
 (2603:10b6:0:56::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29 via Frontend
 Transport; Fri, 26 Mar 2021 22:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:05:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:43 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:05:42 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/21] drm/amd/display: Fix static checker warnings on
 tracebuff_fb
Date: Fri, 26 Mar 2021 18:05:16 -0400
Message-ID: <20210326220534.918023-4-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c388a7b-7c7d-4423-9280-08d8f0a34d9d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1478:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1478A219E9AC2E4A4E55D3A1EB619@CY4PR12MB1478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5W3sO8m3YltUtSb7LxWTCXxCiLSUl5sy/g8EOaZzAUHIok84DO1ijC9YjI1GAkULY67lNt0HUrvFxTAOFTOZmxrMFh2gGLYH4U99/o8z3+UC/DhlksyfPgZTSR9IlXfEmAGeEkTGe+JbOHcQxHRY4xQulHVdufysQZOXLuX7/iKAenSTGSt7nTlOnOP23hxq0BVjBNlFtDc7i+NcjuIRNk2tRC5+2McKWPq0Hsk0fQrbiAXAyZ+IGaSSWiUxQfhrEPIW7SlB4sTjU73gmdOVuAvs2EjzaLdcRYwUKAm/yrS7n0ln+3MNO/JlrgHqcsbt80WENt3InuuDXgkIl1S9e06T8vFHjnc1lZM2iDdp6WLBzcMMHGRIXK0FbfA5Lp2hDeakiSYstDgoOWCgfoG2huzP8Y95/VRD7ZXOLRtZTgNKZt3oJqN3bPuskAPpp+Wfg+SuP0+q+q+eDQ793R3d/cx1jG9PZxthN8i26Ne61U/slaR4a6183CGUfrg7jAtsR9ADq97ncGlwxdhuqXFvRuhOqpqgySgeOj+J7u+n+yPu0l+seck+bFVBhC/uDweg4B/9SiD9O4cwFuEsbkJ9sA4CagiEhdiqT4LXMFOFgY2YN2/TYl0ZRNdCt50qU5jbwnrN4QVTG1zvFWXq8S5keTClo+KExWLuhmkIeeo55SQbbR7hRZ3GIXfUawJyILad
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(46966006)(426003)(54906003)(70586007)(70206006)(83380400001)(316002)(2906002)(2616005)(5660300002)(356005)(4326008)(186003)(26005)(8676002)(6916009)(36860700001)(86362001)(336012)(82740400003)(36756003)(47076005)(6666004)(1076003)(82310400003)(478600001)(8936002)(7696005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:05:44.4493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c388a7b-7c7d-4423-9280-08d8f0a34d9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1478
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
Static analysis on linux-next has found a potential null pointer
dereference;

[How]
Refactor the function, add ASSERT and remove the unnecessary check.

Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 142 +++++++++---------
 1 file changed, 68 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 8ba0a9e2da54..743d3b7f6f24 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -415,6 +415,12 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	if (!dmub->sw_init)
 		return DMUB_STATUS_INVALID;
 
+	if (!inst_fb || !stack_fb || !data_fb || !bios_fb || !mail_fb ||
+		!tracebuff_fb || !fw_state_fb || !scratch_mem_fb) {
+		ASSERT(0);
+		return DMUB_STATUS_INVALID;
+	}
+
 	dmub->fb_base = params->fb_base;
 	dmub->fb_offset = params->fb_offset;
 	dmub->psp_version = params->psp_version;
@@ -422,97 +428,85 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	if (dmub->hw_funcs.reset)
 		dmub->hw_funcs.reset(dmub);
 
-	if (inst_fb && data_fb) {
-		cw0.offset.quad_part = inst_fb->gpu_addr;
-		cw0.region.base = DMUB_CW0_BASE;
-		cw0.region.top = cw0.region.base + inst_fb->size - 1;
-
-		cw1.offset.quad_part = stack_fb->gpu_addr;
-		cw1.region.base = DMUB_CW1_BASE;
-		cw1.region.top = cw1.region.base + stack_fb->size - 1;
-
-		if (params->load_inst_const && dmub->hw_funcs.backdoor_load) {
-		    /**
-		     * Read back all the instruction memory so we don't hang the
-		     * DMCUB when backdoor loading if the write from x86 hasn't been
-		     * flushed yet. This only occurs in backdoor loading.
-		     */
-		    dmub_flush_buffer_mem(inst_fb);
-		    dmub->hw_funcs.backdoor_load(dmub, &cw0, &cw1);
-		}
-
-	}
-
-	if (inst_fb && data_fb && bios_fb && mail_fb && tracebuff_fb &&
-	    fw_state_fb && scratch_mem_fb) {
-		cw2.offset.quad_part = data_fb->gpu_addr;
-		cw2.region.base = DMUB_CW0_BASE + inst_fb->size;
-		cw2.region.top = cw2.region.base + data_fb->size;
+	cw0.offset.quad_part = inst_fb->gpu_addr;
+	cw0.region.base = DMUB_CW0_BASE;
+	cw0.region.top = cw0.region.base + inst_fb->size - 1;
 
-		cw3.offset.quad_part = bios_fb->gpu_addr;
-		cw3.region.base = DMUB_CW3_BASE;
-		cw3.region.top = cw3.region.base + bios_fb->size;
-
-		cw4.offset.quad_part = mail_fb->gpu_addr;
-		cw4.region.base = DMUB_CW4_BASE;
-		cw4.region.top = cw4.region.base + mail_fb->size;
+	cw1.offset.quad_part = stack_fb->gpu_addr;
+	cw1.region.base = DMUB_CW1_BASE;
+	cw1.region.top = cw1.region.base + stack_fb->size - 1;
 
+	if (params->load_inst_const && dmub->hw_funcs.backdoor_load) {
 		/**
-		 * Doubled the mailbox region to accomodate inbox and outbox.
-		 * Note: Currently, currently total mailbox size is 16KB. It is split
-		 * equally into 8KB between inbox and outbox. If this config is
-		 * changed, then uncached base address configuration of outbox1
-		 * has to be updated in funcs->setup_out_mailbox.
+		 * Read back all the instruction memory so we don't hang the
+		 * DMCUB when backdoor loading if the write from x86 hasn't been
+		 * flushed yet. This only occurs in backdoor loading.
 		 */
-		inbox1.base = cw4.region.base;
-		inbox1.top = cw4.region.base + DMUB_RB_SIZE;
-		outbox1.base = inbox1.top;
-		outbox1.top = cw4.region.top;
+		dmub_flush_buffer_mem(inst_fb);
+		dmub->hw_funcs.backdoor_load(dmub, &cw0, &cw1);
+	}
 
-		cw5.offset.quad_part = tracebuff_fb->gpu_addr;
-		cw5.region.base = DMUB_CW5_BASE;
-		cw5.region.top = cw5.region.base + tracebuff_fb->size;
+	cw2.offset.quad_part = data_fb->gpu_addr;
+	cw2.region.base = DMUB_CW0_BASE + inst_fb->size;
+	cw2.region.top = cw2.region.base + data_fb->size;
 
-		outbox0.base = DMUB_REGION5_BASE + TRACE_BUFFER_ENTRY_OFFSET;
-		outbox0.top = outbox0.base + tracebuff_fb->size - TRACE_BUFFER_ENTRY_OFFSET;
+	cw3.offset.quad_part = bios_fb->gpu_addr;
+	cw3.region.base = DMUB_CW3_BASE;
+	cw3.region.top = cw3.region.base + bios_fb->size;
 
+	cw4.offset.quad_part = mail_fb->gpu_addr;
+	cw4.region.base = DMUB_CW4_BASE;
+	cw4.region.top = cw4.region.base + mail_fb->size;
 
-		cw6.offset.quad_part = fw_state_fb->gpu_addr;
-		cw6.region.base = DMUB_CW6_BASE;
-		cw6.region.top = cw6.region.base + fw_state_fb->size;
+	/**
+	 * Doubled the mailbox region to accomodate inbox and outbox.
+	 * Note: Currently, currently total mailbox size is 16KB. It is split
+	 * equally into 8KB between inbox and outbox. If this config is
+	 * changed, then uncached base address configuration of outbox1
+	 * has to be updated in funcs->setup_out_mailbox.
+	 */
+	inbox1.base = cw4.region.base;
+	inbox1.top = cw4.region.base + DMUB_RB_SIZE;
+	outbox1.base = inbox1.top;
+	outbox1.top = cw4.region.top;
 
-		dmub->fw_state = fw_state_fb->cpu_addr;
+	cw5.offset.quad_part = tracebuff_fb->gpu_addr;
+	cw5.region.base = DMUB_CW5_BASE;
+	cw5.region.top = cw5.region.base + tracebuff_fb->size;
 
-		dmub->scratch_mem_fb = *scratch_mem_fb;
+	outbox0.base = DMUB_REGION5_BASE + TRACE_BUFFER_ENTRY_OFFSET;
+	outbox0.top = outbox0.base + tracebuff_fb->size - TRACE_BUFFER_ENTRY_OFFSET;
 
-		if (dmub->hw_funcs.setup_windows)
-			dmub->hw_funcs.setup_windows(dmub, &cw2, &cw3, &cw4,
-						     &cw5, &cw6);
+	cw6.offset.quad_part = fw_state_fb->gpu_addr;
+	cw6.region.base = DMUB_CW6_BASE;
+	cw6.region.top = cw6.region.base + fw_state_fb->size;
 
-		if (dmub->hw_funcs.setup_outbox0)
-			dmub->hw_funcs.setup_outbox0(dmub, &outbox0);
+	dmub->fw_state = fw_state_fb->cpu_addr;
 
-		if (dmub->hw_funcs.setup_mailbox)
-			dmub->hw_funcs.setup_mailbox(dmub, &inbox1);
-		if (dmub->hw_funcs.setup_out_mailbox)
-			dmub->hw_funcs.setup_out_mailbox(dmub, &outbox1);
-	}
+	dmub->scratch_mem_fb = *scratch_mem_fb;
 
-	if (mail_fb) {
-		dmub_memset(&rb_params, 0, sizeof(rb_params));
-		rb_params.ctx = dmub;
-		rb_params.base_address = mail_fb->cpu_addr;
-		rb_params.capacity = DMUB_RB_SIZE;
+	if (dmub->hw_funcs.setup_windows)
+		dmub->hw_funcs.setup_windows(dmub, &cw2, &cw3, &cw4, &cw5, &cw6);
 
-		dmub_rb_init(&dmub->inbox1_rb, &rb_params);
+	if (dmub->hw_funcs.setup_outbox0)
+		dmub->hw_funcs.setup_outbox0(dmub, &outbox0);
 
-		// Initialize outbox1 ring buffer
-		rb_params.ctx = dmub;
-		rb_params.base_address = (void *) ((uint8_t *) (mail_fb->cpu_addr) + DMUB_RB_SIZE);
-		rb_params.capacity = DMUB_RB_SIZE;
-		dmub_rb_init(&dmub->outbox1_rb, &rb_params);
+	if (dmub->hw_funcs.setup_mailbox)
+		dmub->hw_funcs.setup_mailbox(dmub, &inbox1);
+	if (dmub->hw_funcs.setup_out_mailbox)
+		dmub->hw_funcs.setup_out_mailbox(dmub, &outbox1);
 
-	}
+	dmub_memset(&rb_params, 0, sizeof(rb_params));
+	rb_params.ctx = dmub;
+	rb_params.base_address = mail_fb->cpu_addr;
+	rb_params.capacity = DMUB_RB_SIZE;
+	dmub_rb_init(&dmub->inbox1_rb, &rb_params);
+
+	// Initialize outbox1 ring buffer
+	rb_params.ctx = dmub;
+	rb_params.base_address = (void *) ((uint8_t *) (mail_fb->cpu_addr) + DMUB_RB_SIZE);
+	rb_params.capacity = DMUB_RB_SIZE;
+	dmub_rb_init(&dmub->outbox1_rb, &rb_params);
 
 	dmub_memset(&outbox0_rb_params, 0, sizeof(outbox0_rb_params));
 	outbox0_rb_params.ctx = dmub;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
