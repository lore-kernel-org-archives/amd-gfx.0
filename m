Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E564CC83F26
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 14:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8181C10E373;
	Wed, 30 Jul 2025 14:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xAvIApYY";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE4D10E36F
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 14:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xV1qsXHkje8epp6uef+LNYHUZmoyLFUcIaOJIQCb5xbd4nd9lQ5AFeirth1ybh5Jw30GRWkAYwgWZXsyfW8jiwOELhgjhfZNOxJQCVXvEHdEFI6VuOmlQ+ULuseQpM/boEwYK16ml70uj4NPEzbthgVspa09xBPmTu3ZzgMJqXM264ElikcFA3uaMiOkzb2B6TDvLri+vH9kA04VpKEtWnf/gHynyo+5AnaYqVZ9GexJ2hnzreoBOH7jzYF98e7miG/dTSwJAWdmZspjzWJgk6tg3ezJD05rHX/AnSK743TQnrCCO9YMUUlOP3YbbG2VknaGgAOeBPDl4/Vm6qmlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HR9QKQN+8f8OKt4Rl9iAiXJ0Vv9CJS/AHrHhJhw798Q=;
 b=XfIrhj3E0Liux0ebYIm9quFSPDV5TLrl9CFjgQsfoR37iWEM1mJxFyAQJ7yxvQTyoKy1Iu6T4/igYhBmWb6VkJnCgTRu5iyhia0eMkTDTxtKT9pfYCVE2AxGUQWUpvSSdmmfusWWjdxdPIGmsZiPIFcniXMZWk1QanLysNIW6gfGxIs0Xm+TNdvo86+xrzTBes/eOiEoEdCMWbtOcRLQTjBMadQPVwxE10TpPT41E57T97jbCRXJxWafZsrPXpw9CVosppwZsSA4O7hH/JO5isRaPZiprRSGtMliWJ5kRSBL+s+r93v21tbhUTn+DoMneyXotTJF8PFw/K+/C5nnKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HR9QKQN+8f8OKt4Rl9iAiXJ0Vv9CJS/AHrHhJhw798Q=;
 b=xAvIApYYZEtQ/8ko2BtQjVplEng5FSJ3krR5yGJi+f6k+OjLMIhsNrHYdvzZmv9ff8HLAGrbk9SMAMrAmXPE/AkEsT+KebCEyob/dbeQhD2YOVubZK4/3ckEN1AyZrBAxE6CbOVa631Zq/vKay8odkfufC5HWDcPzV8ojZHHTtA=
Received: from CH2PR05CA0065.namprd05.prod.outlook.com (2603:10b6:610:38::42)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 14:27:32 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::e9) by CH2PR05CA0065.outlook.office365.com
 (2603:10b6:610:38::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 14:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 14:27:32 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 09:27:31 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/amdgpu : Use the MES INV_TLBS API for tlb
 invalidation on gfx12
Date: Wed, 30 Jul 2025 10:27:19 -0400
Message-ID: <20250730142719.7184-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c3de2e-a460-4604-5e35-08ddcf7538a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|3613699012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hcmqiJINVFQqC9fHxQZMm1SNPb3zPOzljAhNBlfWV5ASgZu4H0XYkEzpcyBo?=
 =?us-ascii?Q?Af464ZUqbWDZhvfIWcEBjjXhHcnrE5Yea7d4cYMK6TU37SEYoMufSSfvS/SX?=
 =?us-ascii?Q?iwcu28FP5CthMhM/TIXgPyeABbEVq5XIJu5dE8tLowIvY1ihF8zTUjeyLumw?=
 =?us-ascii?Q?SslPbUEpV5caN2SN+r/GU7JdOrZZbLyNoBmYZFVnw1YgNTay7xNW67JmToPM?=
 =?us-ascii?Q?9XYV836Hdd+eLP8zNG9gBY4mdIx5v1DaASnLVmAT4rTXJpeEJa/t/iHxOaOK?=
 =?us-ascii?Q?Xl1TjUfban0OdGz33TP2C5ZEiI0EAX8oZwi391QThNH+WSVpi444X6TMchwH?=
 =?us-ascii?Q?NKrf9f7DvHkjuODilteb1muLSnukeM77hW2iqW++MRNBuloEWt3+fHwv49kX?=
 =?us-ascii?Q?D+ToR+QE08xh1SBnBhW15l8ZlR5aTMaoDkuR+XCtfKr6czcGxuHyCq7X5769?=
 =?us-ascii?Q?uXYkV4EQWpZ6OOqNt5UmyYuBFprsdxTmbvyArVMCindNviuCdkMxJxLwqMej?=
 =?us-ascii?Q?+vEKfR+q2RiB8eFwPqq9iTBQpTKg7b3UpcwZAxC2qFEriaQbeDWZ9Ojo12g/?=
 =?us-ascii?Q?E31TqTJJ+pMTWrve6NJIl2qvsOkwHX8ssVU+aoZsrp1HWhgRY2LkRVyR0C8e?=
 =?us-ascii?Q?yB7sPdEUmEQvIxYrDEzraQmL1NlTVwWNYYT9yoI2HZY2Ajv3FIpJT4RM4kRB?=
 =?us-ascii?Q?ECOYfZc3rbCTT8tPHDHZoOk/oWIOJY56v48IoR23xs3WD4lhgD0s8/hFbhEW?=
 =?us-ascii?Q?yHuIoVXJJd+WkoLwKTBCJ6DLwsBTucPJvZ9HYQt2/OBkunm2CSfHDh9GwIlW?=
 =?us-ascii?Q?0qM2QSQjrgt4XsgwiPP7WlCZLoDXbX43E509NhpfS4FGj86q1jWWXWPr1eAJ?=
 =?us-ascii?Q?9pMeL7f7OSr4tqsFCUcF3R3rQjIe31JICr1//8FCL6BfeU48mgGVhNwrnejl?=
 =?us-ascii?Q?qz8Y51TZ6VQ3MZYIrUNK1cufy/N4Ph8y+Xd10vaL+/EAyqcyDTRFFGNgJFAd?=
 =?us-ascii?Q?hI1KNJrP+0wn09h+Dso/54532mleyOxOq/jBlD7OUlfP81hb2sKRVCJqH+x6?=
 =?us-ascii?Q?NBojaUkaPjL9bR1RcalzLvjyn6Wl99XiJuQAoss4/QHgjOcsklbKqG7jceVT?=
 =?us-ascii?Q?LaV6QHTH03tfIGkZrM6LsvOfPxNgXXX5yOEIKdXCbwAJpLPP1TbqB0YaeqtR?=
 =?us-ascii?Q?s9lUYHoDSZXXMJu50MmlZ76kgP6l/IhSBoXbRV7FiYPPqJf2+B5nxLXgrR8V?=
 =?us-ascii?Q?BiIsufFj1AhbHojfFq1TkdL+M7UHl2mMryq95v1dY3CfvFs63GeblXCM5LQv?=
 =?us-ascii?Q?/w41XMuoKD/jyl7b2qqVwUm0EeGumw3JNU0sVVR75NNEDtsON8/YjAnRGhr5?=
 =?us-ascii?Q?Rm7FPPEmQKRbKoHQKxGCnaSzubC8A5nIvK6IOakKSxR7r3XgJxOrShztB5Yy?=
 =?us-ascii?Q?P3J27GfAnFUCTa2+GBJkgxQMPg9kcXfbULgVMLv69h5S4mnXGMd/Lnvs7fQE?=
 =?us-ascii?Q?K5YsK4G87K8VmXz3EgSrV9MlvN9Pgljym+8Irjtda/iSbny2dkyARrGFaOle?=
 =?us-ascii?Q?AphCUttFSfkTmWaloxQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 14:27:32.4175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c3de2e-a460-4604-5e35-08ddcf7538a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From MES version 0x81, it provide the new API INV_TLBS that support
invalidate tlbs with PASID.

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 24 ++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index c0d2c195fe2e..f4c40f1aecd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -280,6 +280,12 @@ struct mes_reset_queue_input {
 	bool                               is_kq;
 };
 
+struct mes_inv_tlbs_pasid_input {
+	uint16_t        pasid;
+	uint8_t         hub_id;
+	uint8_t         flush_type;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -367,6 +373,9 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_hw_queue)(struct amdgpu_mes *mes,
 			      struct mes_reset_queue_input *input);
+
+	int (*invalidate_tlbs_pasid)(struct amdgpu_mes *mes,
+			      struct mes_inv_tlbs_pasid_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index feb92e107af8..323ec04094ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -339,6 +339,21 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
+	if (adev->enable_uni_mes && adev->mes.ring[0].sched.ready &&
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x81) {
+
+		struct mes_inv_tlbs_pasid_input input = {0};
+		input.pasid = pasid;
+		input.flush_type = flush_type;
+		adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+		if (all_hub) {
+			/* hub_id = 1 means  for mm_hub*/
+			input.hub_id = 1;
+			adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+		}
+		return;
+	}
+
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..2e9191fffaf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -108,6 +108,7 @@ static const char *mes_v12_0_opcodes[] = {
 	"SET_SE_MODE",
 	"SET_GANG_SUBMIT",
 	"SET_HW_RSRC_1",
+	"INVALIDATE_TLBS",
 };
 
 static const char *mes_v12_0_misc_opcodes[] = {
@@ -879,6 +880,28 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v12_0_inv_tlbs_pasid(struct amdgpu_mes *mes,
+				    struct mes_inv_tlbs_pasid_input *input)
+{
+	union MESAPI__INV_TLBS mes_inv_tlbs;
+
+	memset(&mes_inv_tlbs, 0, sizeof(mes_inv_tlbs));
+
+	mes_inv_tlbs.header.type = MES_API_TYPE_SCHEDULER;
+	mes_inv_tlbs.header.opcode = MES_SCH_API_INV_TLBS;
+	mes_inv_tlbs.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_inv_tlbs.invalidate_tlbs.inv_sel = 0;
+	mes_inv_tlbs.invalidate_tlbs.flush_type = input->flush_type;
+	mes_inv_tlbs.invalidate_tlbs.inv_sel_id = input->pasid;
+	mes_inv_tlbs.invalidate_tlbs.hub_id = (uint32_t)input->hub_id;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_KIQ_PIPE,
+			&mes_inv_tlbs, sizeof(mes_inv_tlbs),
+			offsetof(union MESAPI__INV_TLBS, api_status));
+
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -888,6 +911,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.invalidate_tlbs_pasid = mes_v12_0_inv_tlbs_pasid,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.34.1

