Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92411EB271F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071CF10E11F;
	Tue, 10 Feb 2026 21:48:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mc+EQjBz";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099F410E11F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC1I3MRPQuGwke1GIDjPVSMyIm29RzwRpIkGCDpK12Vxw5LIEwsI4L81nOlML7sINO+y9hDCqchr4eJkX8loyJbAC/DbLhWXOn108MG9GZxsO6iaCFJq0qO7qVHFPG3St4f9eleAjsUIigA7wScPpy3fd4Za5PjaBshDCD7BKARmQmVNGkIpD03tthS9sqle4mF80xJGh8XaViDVQOi66T6kTBFuE7WXhRM+yGA8TYnt2yoXJHGlP5xx35aoW4+penfsyFtMKdXhix2okVJQuNAiUqLLbiEocsABcuVOXhVb4jRTGTsHYtAOncTx5XLKHsMJMTg+QwHxv2hkQXJR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSqiH1tj+8IbajuB3Wf66S5pLq6X0Nfye2y6SIqdw90=;
 b=Euyqncph4BPgbVuk1V1hiYVLGhpSp49IH3SDaE4cH9RuZ4ej6DTM2axOVG10RAUAiL/GmwfkcX0hfBWglBUuzuZMiLMxJE18De+Pe1yShJhqziwQdW5U6ePl0D7Nk8lJiJ4H+XDZYvWwhDPcrSRtM5YiKrV3i0y+WrB8cjxSRHsuvLXHNVzJ3zwpR90uchsd2nYDPeNVJG/aUrnh/D/IlayE1+wRVppM6sRe+nIymb9TnJGAfbRuFxoaADoIlwI+g24DnjT+8Enpse2jDBsA9kPpfJVd+vbWxmo2al5Zs54kG2kIgbOcyvQ2soBO59q2uhDOFYLFZt01TO6+vKX5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSqiH1tj+8IbajuB3Wf66S5pLq6X0Nfye2y6SIqdw90=;
 b=Mc+EQjBzxttbJ7N6c4fMFMHBCgLIpIq8kQ48zhjSCPtZ1cv/wd3D3D7Xdk6MhV/udZHjDmaTUYuP0PLOY074UTg3clI37zfanIV7rxTLL6E3O6MURO6nZAttcX1Sn2TzQjmBup6E/dqd8R9hcPyOGNfdykFaj0fk+jr7SR+2+48=
Received: from SJ2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:a03:505::8)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 21:48:04 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::8e) by SJ2PR07CA0008.outlook.office365.com
 (2603:10b6:a03:505::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 21:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:48:04 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:47:58 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>,
 "Saleemkhan Jamadar" <saleemkhan.jamadar@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 04/14] amdgpu/umsch: Update UMSCH interface and mqd structure
Date: Tue, 10 Feb 2026 16:47:19 -0500
Message-ID: <20260210214729.80964-5-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb2d848-a25b-4d48-7fff-08de68ee11fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVRick1nMUFPUXBiS2NvaFJlZUVVWEtZNk95VGxwVzFqWTQzUTQxQnEySjRG?=
 =?utf-8?B?WjZlL0VEZTJJU09jUURYeUQvOTcvdXdIZkV4d3NjSm1WRUg0V011anVINFZ3?=
 =?utf-8?B?emRaeHNyM2RMZG0zaVllZFlzcFZvVU91NXBvQ1FCWjNLb2tYa2tsemdmUzhn?=
 =?utf-8?B?T3g4UGhZN0lBRXRNeVZmTGNsbmdUVW1GSG5mNm85Q1NXVURuQjhmYk93L1JN?=
 =?utf-8?B?NkU1VlhGdmpGTGVRVkl5TEhDcjdIVGdieTFEaERZYmdJVjFjVUdjcDU1V1U2?=
 =?utf-8?B?c3RwMVZSQms1c1FTNEFSNGpIZHkxVWRQRktsanJyOVpOZ2tuRTY2V0hPd3dH?=
 =?utf-8?B?ZEtZclM0SDlkWXQvOFoxWEVqNEgyN3ZiMzdDRUF2V3U1UlJJQzVlUlF2cktU?=
 =?utf-8?B?V0ZkYk9BMy9kbmhtUkJjbmFFQmdMWnBxUDNCL2pJN0lBalZiNTBFMk9OSU1r?=
 =?utf-8?B?ME5sWVZZekhFcnp5NHp5ZmNaT0s2NlREK2VWVjVhUlBSM0JjMkRaU0xlZGRP?=
 =?utf-8?B?TnpwVFhVVU1YeHhuNUQ1cXh4ZHI0VlpxUHZqMXhKMFV3RFRWb0FtVUdPUE1h?=
 =?utf-8?B?QjV1dnBJU1lEVllhVHVOVitLTkJzTlQ0YUk1R25EbnZVdzB3YWZra2Q3aVVK?=
 =?utf-8?B?VnB0enlBZlk3bmsrOEliR29yelFUL0FwcnlEMkF4L0hiS0pXdDg1Vmp3YXh2?=
 =?utf-8?B?eURpdHZsdHBiVVRtUXdtVkNlUElDT1ZkWTR4SjFQenZNSk9RN3ozTFhjelEy?=
 =?utf-8?B?cEthNnhpajBMMm5VZU13RUlvaGdUNjZXMXBZaUc2bDFqOEoxVEs2VVhjVm5M?=
 =?utf-8?B?ZDdhRWQvOStFOXd4RzJPdjlhaHJQNFk4ckhhTktKWU1DUFh0Vk9PeGZZcnV5?=
 =?utf-8?B?UWVlQWJnWHJWMDYrVlRBc2tYY2MwdEhDTUtkUHZ0Ti9sbkowdE5JNDk1NnlX?=
 =?utf-8?B?RXN4TGd0ZHhyZW9tb245VzVTZnRnbmpXTU0rM3JUVkhneEk4cURacVlCZXRi?=
 =?utf-8?B?aHFuQTQ1YkdhaHRRUVNxLzYrbEJTVkFPdVQzRE96RzFGeDZ2aGhsbm0wQldx?=
 =?utf-8?B?RXIyNGx6eVVEa2s0QUV2MENJb2pXRjN4NlM1b2MvNFNablhrZlBCTGR5RVhz?=
 =?utf-8?B?bExhdVVQdEJ0bmV5VnpYL0pIdkdmQ1M0Z2xaUC83K0M2dmhIZFB3dG5qREZX?=
 =?utf-8?B?blBJZWEwY1doRlJaVGRiWkErSzhFa1dvNm5yd2MvcjBNRzlLeGc5NDJSNEZO?=
 =?utf-8?B?UXk3MThST1gvYU9OME5EK0g0cFlCNlUzbDV2OTBYeC9YSnFDZkRPeUVwTWY0?=
 =?utf-8?B?U2xoTXJ0UzJUbm5BWFg5dWhaNEZ1UWlDT28wRThWT29Fd3M0bmNKaUJwakdp?=
 =?utf-8?B?SzdWeWNKc2pxdlgzU3J2TXJlYjhCeSszWmRHWis2NzJTd3BETDUzbDRDSFFJ?=
 =?utf-8?B?STZkRmNzQ0RESFViR1lxVFJWbVY2a1YwSi9aQlcxV1BYZks5QTdxdFJFTUZL?=
 =?utf-8?B?RVNUaUQ4UTd3OVBha0FobFVRR1ovVTMyeWJDQXlwU1lLYWtOUUxUZzlzYlBo?=
 =?utf-8?B?ejQ0d3I3Nm1Oc0tULy9BcVJiT1Vaais4cENTeWVWcjRKWHpxK0VLdkI4YXFV?=
 =?utf-8?B?RUlhYzhpS0lKZkZWdVVEV3FQQThZOEs5UXczVXpkL0NNRXBJSEFLNzB2YzJ0?=
 =?utf-8?B?VlJ5dVZ5L2ZMdXhWdkFrYU9nNWtuUVZBbjBDUy9ZM04vVmoyek4xZ3ZRMDR5?=
 =?utf-8?B?M0JEbXVLbVl2eDdnOU1CanhObWN3TGhJWEVIVVh5ZUQvTVduTXlEemZhTnRY?=
 =?utf-8?B?SUpsVWJseGY0LzVUeHNCNnR4cEFIS1lyWHY2UVFZcVBoZ2Z2YS8wNmRCU0ZL?=
 =?utf-8?B?bTcvWVFaOVFxeGNlUHY1MDByenhXQTNnRlg5SzVqaythUVB2MVZRY2lIdXlq?=
 =?utf-8?B?YTl6ZnZOeDNZUlQ5akNYK2hQTi9HSnJ4YkpJSHFpWElaV3psdHhscXNhRjJU?=
 =?utf-8?B?ZHR5SWRZbTZaM0hjcXc5M3RrUk11UU5WT2hGYVhOV0FJOWhzdWw5SHN5WjZy?=
 =?utf-8?B?VUk4akR2NTNKT1l3cGYvRHFjT3p6VU8vc3FXVSszNXJScmdvdVpJdkdPMms4?=
 =?utf-8?B?alV1Y3Y5VVZldDF1a1Z1akl5K09zSHgxb1RWT1d1RDdHUW1ra3k2M212NkNi?=
 =?utf-8?B?UGJ2dmtub1BZTnZST1ZBaXRiV1c4QmUxdE9kdU5Gc1lzZ2QzUEtBZDVEcTVE?=
 =?utf-8?B?cWVCQ2JRNWJDQTlhNHZpK2hXVVR3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JLRZYVzKF4/HpMWB1cYF1FL8vty60SquBT185Cpmv0zxbQiGkhxsXU/DXerZNbqiBhaxioJcHdnpYHnp1ZhIknlR7J46PAC+cFX270xjFoWy23sIrCRZ/D5rT+ngUHrwS3P6k4i6EImo2sNp+mr9bsWEQ+mZQ9RAfzn2Wc75+jdRZSSsk87u5GFjYLo6Rg7s9JyjqHQaTfBsdAVl5Dga5XQQzwWmWeJ42JRsooVg7JbaACyql3Oow3thh/v3Ai+kTaoV4Su3pjy4s/rqu0lQ4A0GZcItS5VwL6X1w7U7OMn1LsFiSNKhnDjKUoA1k1yFruZGmg12f9acb6lHZffnhotKmS1yCn2mriY5g9k8h3Y6Lf4MbSYa/HdqcpacgK/bjt9ecwR+UPYObSr50qt8BGndATKPW9vD0dwA2ZrBzkjLCIjPvpaIUBwOzwGerbQq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:48:04.5055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb2d848-a25b-4d48-7fff-08de68ee11fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
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

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

Add mqd configuration for VCN IP.
Update the UMSCH interface w.r.t FW change.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h     | 16 +++++++++-------
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c       |  4 ++--
 .../gpu/drm/amd/include/umsch_mm_4_0_api_def.h   | 12 +++++-------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
index 2c771a753778..af34faa5e1ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
@@ -26,10 +26,8 @@
 #define __AMDGPU_UMSCH_MM_H__
 
 enum UMSCH_SWIP_ENGINE_TYPE {
-	UMSCH_SWIP_ENGINE_TYPE_VCN0 = 0,
-	UMSCH_SWIP_ENGINE_TYPE_VCN1 = 1,
-	UMSCH_SWIP_ENGINE_TYPE_VCN = 2,
-	UMSCH_SWIP_ENGINE_TYPE_VPE = 3,
+	UMSCH_SWIP_ENGINE_TYPE_VCN = 0,
+	UMSCH_SWIP_ENGINE_TYPE_VPE = 1,
 	UMSCH_SWIP_ENGINE_TYPE_MAX
 };
 
@@ -92,8 +90,10 @@ struct umsch_mm_add_queue_input {
 	struct {
 		uint32_t is_context_suspended : 1;
 		uint32_t collaboration_mode : 1;
-		uint32_t reserved : 30;
+		uint32_t mqd_type : 2;
+		uint32_t reserved : 28;
 	};
+	u64 fence_signal_addr;
 };
 
 struct umsch_mm_remove_queue_input {
@@ -107,8 +107,10 @@ struct MQD_INFO {
 	uint32_t rb_base_hi;
 	uint32_t rb_base_lo;
 	uint32_t rb_size;
-	uint32_t wptr_val;
-	uint32_t rptr_val;
+	u32 wptr_addr_monotonic_hi;
+	u32 wptr_addr_monotonic_lo;
+	u32 rptr_addr_monotonic_hi;
+	u32 rptr_addr_monotonic_lo;
 	uint32_t unmapped;
 	uint32_t vmid;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index ce3bb12e3572..79e1ec9933c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -282,8 +282,6 @@ static int umsch_mm_v4_0_set_hw_resources(struct amdgpu_umsch_mm *umsch)
 		adev->vpe.collaborate_mode ? 0x3 : 0x0;
 	set_hw_resources.engine_mask = umsch->engine_mask;
 
-	set_hw_resources.vcn0_hqd_mask[0] = umsch->vcn0_hqd_mask;
-	set_hw_resources.vcn1_hqd_mask[0] = umsch->vcn1_hqd_mask;
 	set_hw_resources.vcn_hqd_mask[0] = umsch->vcn_hqd_mask[0];
 	set_hw_resources.vcn_hqd_mask[1] = umsch->vcn_hqd_mask[1];
 	set_hw_resources.vpe_hqd_mask[0] = umsch->vpe_hqd_mask;
@@ -356,6 +354,8 @@ static int umsch_mm_v4_0_add_queue(struct amdgpu_umsch_mm *umsch,
 	add_queue.vm_context_cntl = input_ptr->vm_context_cntl;
 	add_queue.is_context_suspended = input_ptr->is_context_suspended;
 	add_queue.collaboration_mode = adev->vpe.collaborate_mode ? 1 : 0;
+	add_queue.mqd_type = input_ptr->mqd_type;
+	add_queue.fence_signal_addr = input_ptr->fence_signal_addr;
 
 	add_queue.api_status.api_completion_fence_addr = umsch->ring.fence_drv.gpu_addr;
 	add_queue.api_status.api_completion_fence_value = ++umsch->ring.fence_drv.sync_seq;
diff --git a/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h b/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h
index ca83e9e5c3ff..735ec05859fe 100644
--- a/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h
+++ b/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h
@@ -159,10 +159,8 @@ enum UMSCH_AMD_PRIORITY_LEVEL {
 };
 
 enum UMSCH_ENGINE_TYPE {
-	UMSCH_ENGINE_TYPE_VCN0 = 0,
-	UMSCH_ENGINE_TYPE_VCN1 = 1,
-	UMSCH_ENGINE_TYPE_VCN = 2,
-	UMSCH_ENGINE_TYPE_VPE = 3,
+	UMSCH_ENGINE_TYPE_VCN = 0,
+	UMSCH_ENGINE_TYPE_VPE = 1,
 	UMSCH_ENGINE_TYPE_MAX
 };
 
@@ -215,8 +213,6 @@ union UMSCHAPI__SET_HW_RESOURCES {
 		uint32_t collaboration_mask_vpe;
 		uint32_t engine_mask;
 		uint32_t logging_vmid;
-		uint32_t vcn0_hqd_mask[MAX_VCN0_INSTANCES];
-		uint32_t vcn1_hqd_mask[MAX_VCN1_INSTANCES];
 		uint32_t vcn_hqd_mask[MAX_VCN_INSTANCES];
 		uint32_t vpe_hqd_mask[MAX_VPE_INSTANCES];
 		uint64_t g_sch_ctx_gpu_mc_ptr;
@@ -299,11 +295,13 @@ union UMSCHAPI__ADD_QUEUE {
 		struct {
 			uint32_t is_context_suspended : 1;
 			uint32_t collaboration_mode : 1;
-			uint32_t reserved : 30;
+			uint32_t mqd_type : 2;
+			uint32_t reserved : 28;
 		};
 		struct UMSCH_API_STATUS api_status;
 		uint32_t process_csa_array_index;
 		uint32_t context_csa_array_index;
+		u64 fence_signal_addr;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-- 
2.43.0

