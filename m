Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5CBCCD18D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 04:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A439110E31C;
	Fri, 10 Oct 2025 04:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fsjXntHr";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3694E10E267
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 04:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMl6/0heT28QhO3O3Ckvtd3+5I5dr30FRuwRafYnFPlXJFwSi+AGzJgTyfnfRoIODA6A1Bkq9WgJ7K0eT2qdH3OqS+377RJtX6WsSXEjwo8JaQJiteyhYv2pIB2CCfvklbCpvWmRIurOZGai1WjLV7J3z/qPKISJwztX1x/nEseZ+5+Xe+3aWsj5y34ubQBVbL2lUDtB80maek8r60WjFdL8/D7YMXCLc3Vfmh9qAN+SMxBUy6zMaPq3P6XGbZIg8r2czWEyDoXaMH66bnCXopQ9Zal1te3i93oliLuymTUNM4Cii3H6LmFME58K+Utiq4YGP/S+a7jPZXpXr/PaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIn4eO3eMZ8oiJo76xHNEoflXNqJ0W4EkyM0mmF0QW4=;
 b=RuGM1lw9ewSqtlqux8sQLTIGbmqd7uq0JhI3F0IJJVo6mJQxaIV7ZUYA+1ZncR94dMsAARbPTu+vnHmstkWeUNvo9fEzdxRburfrghN5N/4wKBD3ZmjPartA74Xyyo08SbfV5MPXP156L/mopNFcBK0B9ZmL3b2B9XiDl7YYmjNW9mx0zMVOx3R1soexgZB99FNY5yukGN0PQtetT1ke2kYwAheIlp3ZFpN79Sv7s3LJyZbJddcelTIcQ/RpZls2CVq2chtmCMyWTn+Dof2oaULWXJqsmXtLTQDLhqhy23KcEQ/LlHN6w9MbCbqCrFOKhytTw5QKlKdPJXsWt0yP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIn4eO3eMZ8oiJo76xHNEoflXNqJ0W4EkyM0mmF0QW4=;
 b=fsjXntHrgkjGykYzkYZcsbylDHTo74kq9HLkrkBKo9/F88QEFPRRfSjS5bT8Id8Rbe/kChmek0PxFM3jrEfmp007N2jyVDqzx14D0tz7tiVpcpb1pdNPN2sCq1a16OFTigyvszz1BMhCQbpr1SgxMFJHUMKw7CDqPF05BA4+j24=
Received: from BL0PR0102CA0037.prod.exchangelabs.com (2603:10b6:208:25::14) by
 IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 04:43:30 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::72) by BL0PR0102CA0037.outlook.office365.com
 (2603:10b6:208:25::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Fri,
 10 Oct 2025 04:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 04:43:30 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Oct 2025 21:43:29 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: Add logic for VF data exchange region to init
 from dynamic crit_region offsets
Date: Thu, 9 Oct 2025 23:43:09 -0500
Message-ID: <20251010044309.11822-6-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010044309.11822-1-yunru.pan@amd.com>
References: <20251010044309.11822-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d5ec97-0e1c-4dbc-0b2d-08de07b78fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E8TVheRuBFjrFAjyW+6zFAQvEYeU1HJZcwnZM8f/Xi/OsXm2XpxVAoSJHk5m?=
 =?us-ascii?Q?0nWnojuHo8XRDhhtPmN/SqVDtjzp6wNGi083gCY0IULXfHUwQ8As5wPvJFx3?=
 =?us-ascii?Q?DlG/F5C1NN+FLdVv28BjsuRPk41+1KpTTbRDtL2T2jd6VFb+lxfIS0RKikeC?=
 =?us-ascii?Q?yiqHUhpF/GkA/gDWWOuRHCFn83ccsM8oHcqoxjuqjP6+Royjnyb5Ip+qbk9O?=
 =?us-ascii?Q?CiHSDzPrNFtwxPONXLQnSMYUlsyKvnXogBy6RZMOX8Dg7R1+LgzKA7gsegyh?=
 =?us-ascii?Q?1B/MVBvdYS05kDvRhvAPfDAqsuZHmGh4f+5aMUoV/CyimK1zEm98BiULjXib?=
 =?us-ascii?Q?b1Z2mhPPITzmlDIl9mQ+NEkVFHP8Fumd01oOO1daeLtz3lPFWFqZ0xqAMSX0?=
 =?us-ascii?Q?GdiqRXbx2O4X/TEINn1DgT/iCsmBasr9P7HEeoxmH+bXuSmzVzrVsKbnKhhM?=
 =?us-ascii?Q?3Mj4RbJNFtzznHP46PqwEiiXAW9L4kPM/xCFDsb2iIEbgGAOzF8p5ZjPzJDR?=
 =?us-ascii?Q?Ryy1PWy6FQUlQksDJd6Qa1bwJ0cDys8IJGo5vUZvHutrnIUFTZ5bVN8oUTKT?=
 =?us-ascii?Q?uuvrr3gk/lVGetNg+wRFVSMbjSWqXJrvrtZh+JQ8jFGkXoPMfLoo8nIJqp0z?=
 =?us-ascii?Q?E+1LA9oN6J9jnPbLwxCuDjv07qdhNKLA4JpcoOHsDU4mgR1cRVSrO1ZTp8LI?=
 =?us-ascii?Q?XpoMPKme+OYv0GwFjBZH569pJQfKTkzKWpNqPCwr09Y1+uhQeDHwBwDfXA/5?=
 =?us-ascii?Q?5kXa3AdfzLL/WVI506xOuA6kLC1ACykCPgpbcw572XtvURFvp+zYJnNhZPbW?=
 =?us-ascii?Q?Cw3S8Hw4rhB9jVNtbvlFQKxPpLhsqB0TW46HBWQyOyHZiGUF6S9KifQCTUNS?=
 =?us-ascii?Q?I7nq3HLzX4IH5o89sthA3dCwZ9HOK+PqOIFlPnmmx13yu9/rTgRrTWGSQISO?=
 =?us-ascii?Q?9gD9NKQpFyjpJjVajAuRmkiV7PpMov2NjWjPoBVEOb7EMZ2P2VWLkXR1HiUf?=
 =?us-ascii?Q?e4rvBlPALNVGz9kOOcsM8ApsbUTRqktwOa/k468xZiWZGGCNLZu1IM+M1dbr?=
 =?us-ascii?Q?cspKOtZgRLelxpUDqvXDZMvKpCyhDfCfFBDH//Ge+rXrU2/pNk+eVe+XLciE?=
 =?us-ascii?Q?M8csTT/rbwpn0TpdxciFPYq7XdP07+D/bViHVc3vj+JBh1OmWcosxDrf3DwX?=
 =?us-ascii?Q?8sNS9ZSemgoZSEa/mev8h+gW8FEbv3AHXhD97up+p4oL2wyO82PLGerx0RsE?=
 =?us-ascii?Q?aMh5vK4wEjj5uyd72hnxyXuJdQnczoDe0UtLzJ+F7r7JXCYr4PA+R0V19NUp?=
 =?us-ascii?Q?nY7KLo+kibKhuW/lPBICpcCHafFqu74y7/RcnmW/ZwVxxHlHgPe2O+7fUfuI?=
 =?us-ascii?Q?nAjj8w+pI9q+AKql59Tm6m0mz9tuHxr+ItQIYDZC4sF1Gpn2msecqpWIlImj?=
 =?us-ascii?Q?FIct4LLcQpNmgcuV6CeVOn3gDNbOhE39f88uUc29+vmf04JuuTihiKf700DF?=
 =?us-ascii?Q?lvQR+GICOQ+0K74+V6SP44Nrttvot1Mdkm2RHuqA3kUBzdCDJNbWbDsrDtZ0?=
 =?us-ascii?Q?Vzn5SWS9s6bjGEZTBV8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 04:43:30.5413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d5ec97-0e1c-4dbc-0b2d-08de07b78fc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495
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

1. Added VF logic to init data exchange region using the offsets from dynamic(v2) critical regions;

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 88 ++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  1 +
 2 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 67d5f15a72a1..f96382fb0070 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -670,6 +670,8 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 {
+	uint32_t *pfvf_data = NULL;
+
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
@@ -685,11 +687,34 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
 	} else if (adev->bios != NULL) {
 		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
-		adev->virt.fw_reserve.p_pf2vf =
-			(struct amd_sriov_msg_pf2vf_info_header *)
-			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+			pfvf_data =
+				kzalloc(adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
+					GFP_KERNEL);
+			if (!pfvf_data) {
+				DRM_ERROR("Failed to allocate memory for pfvf_data\n");
+				return;
+			}
 
-		amdgpu_virt_read_pf2vf_data(adev);
+			if (amdgpu_virt_read_exchange_data_from_mem(adev, pfvf_data))
+				goto free_pfvf_data;
+
+			adev->virt.fw_reserve.p_pf2vf =
+				(struct amd_sriov_msg_pf2vf_info_header *)pfvf_data;
+
+			amdgpu_virt_read_pf2vf_data(adev);
+
+free_pfvf_data:
+			kfree(pfvf_data);
+			pfvf_data = NULL;
+			adev->virt.fw_reserve.p_pf2vf = NULL;
+		} else {
+			adev->virt.fw_reserve.p_pf2vf =
+				(struct amd_sriov_msg_pf2vf_info_header *)
+				(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+
+			amdgpu_virt_read_pf2vf_data(adev);
+		}
 	}
 }
 
@@ -702,14 +727,29 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 
 	if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
 		if (adev->mman.fw_vram_usage_va) {
-			adev->virt.fw_reserve.p_pf2vf =
-				(struct amd_sriov_msg_pf2vf_info_header *)
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
-			adev->virt.fw_reserve.p_vf2pf =
-				(struct amd_sriov_msg_vf2pf_info_header *)
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
-			adev->virt.fw_reserve.ras_telemetry =
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
+			if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+				adev->virt.fw_reserve.p_pf2vf =
+					(struct amd_sriov_msg_pf2vf_info_header *)
+					(adev->mman.fw_vram_usage_va +
+					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset);
+				adev->virt.fw_reserve.p_vf2pf =
+					(struct amd_sriov_msg_vf2pf_info_header *)
+					(adev->mman.fw_vram_usage_va +
+					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset +
+					(AMD_SRIOV_MSG_SIZE_KB_V1 << 10));
+				adev->virt.fw_reserve.ras_telemetry =
+					(adev->mman.fw_vram_usage_va +
+					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset);
+			} else {
+				adev->virt.fw_reserve.p_pf2vf =
+					(struct amd_sriov_msg_pf2vf_info_header *)
+					(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+				adev->virt.fw_reserve.p_vf2pf =
+					(struct amd_sriov_msg_vf2pf_info_header *)
+					(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
+				adev->virt.fw_reserve.ras_telemetry =
+					(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
+			}
 		} else if (adev->mman.drv_vram_usage_va) {
 			adev->virt.fw_reserve.p_pf2vf =
 				(struct amd_sriov_msg_pf2vf_info_header *)
@@ -1072,6 +1112,30 @@ bool amdgpu_virt_read_bios_from_vram(struct amdgpu_device *adev)
 	return true;
 }
 
+int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data)
+{
+	uint32_t dataexchange_offset =
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset;
+	uint32_t dataexchange_size =
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10;
+	uint64_t pos = 0;
+
+	dev_info(adev->dev,
+			"Got data exchange info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+			dataexchange_offset, dataexchange_size);
+
+	if (!IS_ALIGNED(dataexchange_offset, 4) || !IS_ALIGNED(dataexchange_size, 4)) {
+		DRM_ERROR("Data exchange data not aligned to 4 bytes\n");
+		return -EINVAL;
+	}
+
+	pos = (uint64_t)dataexchange_offset;
+	amdgpu_device_vram_access(adev, pos, pfvf_data,
+					dataexchange_size, false);
+
+	return 0;
+}
+
 void amdgpu_virt_init(struct amdgpu_device *adev)
 {
 	bool is_sriov = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index f2aa306f4192..ae456bde6a5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -440,6 +440,7 @@ void amdgpu_virt_init(struct amdgpu_device *adev);
 int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
 int amdgpu_virt_init_discovery_from_mem(struct amdgpu_device *adev, uint8_t *binary);
 bool amdgpu_virt_read_bios_from_vram(struct amdgpu_device *adev);
+int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
-- 
2.34.1

