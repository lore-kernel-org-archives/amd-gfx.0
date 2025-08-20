Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFB9CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 18:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE6D10E7D5;
	Wed, 20 Aug 2025 18:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="358CVw9o";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C486F10E7D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 18:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edzUv4vBnZxvjotpLpFWMU33elq02l6eAVsxOrw4CmuOlE3BZOYLTxp/kgmw7V4ZRlaq7f0QV8halkSYNyUGuymRzS9W/EpgQ2/ZUP3kcWNXI8s4yOys/2KMV76tIUFTKJzXDxIsS6zL+VVwFof1hIGPWW2K/Zr/iphpH0pA4pkjnx6VYoVE8sEttZfBiKHWKdZAHWqKfAvGyW1f5eqaaRqeBSyILycH+pBKzqa665oaW979MuVohFcS1hj4f6OaKeNW3iJIxNRntFJpHBq5AfiJS2cPNvYlocTrhTgdhxv6By16kHRBHl0OcKvoNktXlDpYbLnkw48VkmUZ3j10pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcrxCEgqe8mc9RSdu2yqbJK1YsgmJEVxNmpIMMVcJA8=;
 b=lRVneriSEHRkYdGdfWEH9nCgocoG66fHmP0umyV4Ig4lFZ1uqCc4qlUMw0WBv5wylLiUdXHz+pYBmEbL2ADAAvEx6sz4gtYFsKYSgw0kxQ/pZ62lODZ8iCTPg5a0o34ZxI7LR07AzMSPhpl83Hh/yrn3R/3LaA69EE4qk+lIiIFhklztxzhMyMk8XR1NBSqoz1qkoPXId0rW7MakHU7y05u/+3P+oiQ3rNP0NndeHhQU+YNY4Cncafzvmnj2Bau8Nq/PXes+NeXb+fXEldU4NPLWNM3bKeVnZEJrKGvf4pUkwPhONvRKSS2wFIUNF7ls2TLN/YtaaLNC4srNXGk9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcrxCEgqe8mc9RSdu2yqbJK1YsgmJEVxNmpIMMVcJA8=;
 b=358CVw9osdelF1IBPjvqlMEU9kDNHkXG5V/786F4DuvH7nzoAXEnunQN+pq4y0wlImEEtC12ywwcf2FqczsYbxIYjzxphSkKEzq94oCxlw02gWhgwdGbdF94q5DhcQAHoQm2JacghQfEgQfVTNfhu/t3SRRkM3xqIhBUx1DUu0Y=
Received: from BYAPR01CA0011.prod.exchangelabs.com (2603:10b6:a02:80::24) by
 SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 18:47:42 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a02:80:cafe::4b) by BYAPR01CA0011.outlook.office365.com
 (2603:10b6:a02:80::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 18:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 18:47:42 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 13:47:40 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/amdgpu : Use the MES INV_TLBS API for tlb
 invalidation on gfx12
Date: Wed, 20 Aug 2025 14:47:25 -0400
Message-ID: <20250820184725.432071-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|SN7PR12MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 951d840c-dfc6-4028-a7ea-08dde01a0b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|3613699012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?95UL60M8Uw77fuzXyNfMVmLUE6f2YMilEJWLuiUezBA6mhANhG/4gYSWrqW0?=
 =?us-ascii?Q?9buV9wYk8dAeReSb6C+XmKZf/ADr1SSP+xtnMa2kDbFDwSUJ3HeuN6TM818h?=
 =?us-ascii?Q?jXIWjSyxFDL5QhjiJKfr5QHcwbepwqKCzkeK4U+gUsaGAnPh6PaqH3qi4/3X?=
 =?us-ascii?Q?YjfJVkklhOPJsTKPtZHc/Kay08RQGBdz5lS+WladWs7trOxMeh4kRu0kinO+?=
 =?us-ascii?Q?i+gSMwwccL7I/g4oj4bMH1kB4cJF37oDtoYIQtpgRU9QUfXt8NiqdtImLKnJ?=
 =?us-ascii?Q?KIGx6utbku9Ub35cxxKjcuDp3Yvduaz9bcaCguAXUpRq6swKUQDWpCRFBA8C?=
 =?us-ascii?Q?x6HD3jMxzkForSuK19De/o9yLppabIY2SyDvIgC4TAjW+nrcKHn41e8E/TcL?=
 =?us-ascii?Q?HquelGGZLxmdA4r7EWAA5R5fRyXXIcK9I8svhaX2/gl2xjWUPR9LVp5sa0ip?=
 =?us-ascii?Q?eEzQ+2sQOrjT8awMW5a5BYZ5etqEvJrXfx8ehPW92p7NvNSyMNfyJ5n4cW2+?=
 =?us-ascii?Q?/Q1JZC4lZMB+OXBcQQZPaV9zE8GcQzDqxzWktRgbcN6EaKYYkWhHyiWgIQuS?=
 =?us-ascii?Q?ZsCMS1GfR/MF5BnZUw2jYWbqjZEE4CmMuAsGHDMMF/Wv1vt9xjuKnWP/zKUK?=
 =?us-ascii?Q?0eZOJ6sSoDTIiEksOzJzvIl1g1Aa91E5q2PSxEdNn/tsk43ePkXqZ8h1VPfG?=
 =?us-ascii?Q?Q2Dpstt3nlylhSJUZEFDSiFEwKUDKgcw1pLtV7C18CzPLbtAWWMUPUpfQxzg?=
 =?us-ascii?Q?Hm0oHt6GS8SgHi4sNzkU4du+RIfgez//hFrobi34LR28TMc9OeCxg1urnnXr?=
 =?us-ascii?Q?bXwKRRAyXq7IZwyu1uutIJu8Z0yni0QkqhxuRys0u5Ni3vKQbbj2EyI9cYq/?=
 =?us-ascii?Q?Dcr2abeCVL7/nw0i1Nqaiyi/WQGoiM5icSECZO+PDGuV588jfOUUShQDlMVU?=
 =?us-ascii?Q?XpPaScvLbM2K+lPpz+xp6eKcF0JTnZDqM3HKB9ceT/b0QtyMQTsLqq/MnSMQ?=
 =?us-ascii?Q?c4L7HcqK3hOFE7G9zuEdsI7skNHwo0VvrWqXyxP5RkUBxZuCGULUo0ENc8Wb?=
 =?us-ascii?Q?X871ipJ+fymUBTD6E5kK4up5vRj5mJCO56kwhHZCOcvmtdiKH6WiKsdcqNu7?=
 =?us-ascii?Q?pB888vgCG66pCL14UiLBLhzB1PADIUpu/D+aVCsmG+UcCelE8WRZ5QJBzx7C?=
 =?us-ascii?Q?uC0wW6oIlnCBcml4BBAO5D6Udutka0etMa4Fe17aC8bBlTcV1GSEC1YETSV9?=
 =?us-ascii?Q?yoYAVYsmOEY9lL+r8Y8CuqDSTB1AXbe+wJ87bklfTq8wdrevNcpe3mFbNdh+?=
 =?us-ascii?Q?Ope4puM7CBXp9gqhWf4NqmSgTe0MURoBr2TP9dSMOtJJbLpkalxclKXOwBt8?=
 =?us-ascii?Q?pAenn42haqI0ll5BxR2TAL4xoK0F/W/SbYQE4BiK8daXITuPU1rp0zySoAKj?=
 =?us-ascii?Q?kvfnjm0nzt5qnTU3DTw0L6D5ufPDMiaIn6rHQ2bkEf+bh8WhExIAUbScDQFY?=
 =?us-ascii?Q?vD/39eUUU/Yx9gRG4xPV4F9I6w/ZVdX61YH3nB5F1zmHOhW361NGGa9T3uob?=
 =?us-ascii?Q?Miqp81Rd9/fkKmaGOgA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 18:47:42.1694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 951d840c-dfc6-4028-a7ea-08dde01a0b7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 25 +++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index c0d2c195fe2e..1b6e7b4fde36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -280,6 +280,19 @@ struct mes_reset_queue_input {
 	bool                               is_kq;
 };
 
+enum amdgpu_mes_hub_id {
+	AMDGPU_MES_GC_HUB = 0,
+	AMDGPU_MES_MM_HUB0 = 1,
+	AMDGPU_MES_MM_HUB1 = 2,
+};
+
+struct mes_inv_tlbs_pasid_input {
+	uint32_t        xcc_id;
+	uint16_t        pasid;
+	uint8_t         hub_id;
+	uint8_t         flush_type;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -367,6 +380,9 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_hw_queue)(struct amdgpu_mes *mes,
 			      struct mes_reset_queue_input *input);
+
+	int (*invalidate_tlbs_pasid)(struct amdgpu_mes *mes,
+			      struct mes_inv_tlbs_pasid_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index feb92e107af8..ef58a849d67d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -339,6 +339,28 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
+	if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready &&
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x81) {
+
+		struct mes_inv_tlbs_pasid_input input = {0};
+		input.pasid = pasid;
+		input.flush_type = flush_type;
+		if (all_hub) {
+			for_each_set_bit(i, adev->vmhubs_mask,
+					 AMDGPU_MAX_VMHUBS) {
+				/*
+				 * For gfx12, the index i from vmhubs_mask matchs AMDGPU_MES_HUB_ID,
+				 * Need to convert them if they are not match in future asic
+				 */
+				input.hub_id = i;
+				adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+			}
+		} else {
+			adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+		}
+		return;
+	}
+
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..bcaaccf28765 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -108,6 +108,7 @@ static const char *mes_v12_0_opcodes[] = {
 	"SET_SE_MODE",
 	"SET_GANG_SUBMIT",
 	"SET_HW_RSRC_1",
+	"INVALIDATE_TLBS",
 };
 
 static const char *mes_v12_0_misc_opcodes[] = {
@@ -879,6 +880,29 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
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
+	/*The AMDGPU_MES_HUB_ID from input matchs mes expection on gfx12*/
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
@@ -888,6 +912,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.invalidate_tlbs_pasid = mes_v12_0_inv_tlbs_pasid,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.34.1

