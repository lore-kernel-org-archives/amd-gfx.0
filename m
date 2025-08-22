Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41557CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 15:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE23E10EB3E;
	Fri, 22 Aug 2025 15:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZbwpnOWx";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FD810EB3E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 15:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2lJK4dvbQb7FpDfVu/xxKvs9HG+DFNbTUH/nJADY17nju8rgQmKnCs6e+hl3Dgf9YzB1C/q7kGrHejFTJ/BNx9G5EnJI1vW8flU75/zm1wAkvd925z9Otqf3nDOLkBJFDJaWElAzfBgwaWTnuj96mReNSe6/xcAfnUwbP5ORVfGff9vHqprcd2+NVrZdO0I0qTttYKdc3yCvuWODdTRkS7iGqSjA+YPTxEF94uM55kPdc67s7mekwFQbV2jurqJXlS5xS3OnNpruuZLhsekt9wI1vAMzzH3P9RZiojFsx60ZTHKpVZu0993rw7AKoctDtLEH431BIQuyEWoPN2wtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yLwiXld9WEdqsUKuvugij+vxh8sf0XpJik0LCLwfAY=;
 b=kJQxK5T1aZjRWYJH6ZCx1dkKT6Tg432gAYiv/7lnyMgStuR+qx8vfiaM/bf/3IqqPMppSTV67c3TZ/A1sAQm4ZEhC3057TdcRDERgWhdzcaKa1NgZSRSkswAd+nKawDAqu32HzQ5yOIz2VDhEr0YCctKyCXD7+HgrTvQIl23QiYPbu5gSoIS4hYCQUZaMT/M7opHgFbZA4c3pnSam6LsvfAIfSRMhHkpicboG/VcPrUYArZdmYIyH9koUMGA0lMbB+xNdZI8G4mALOL2MPK3aHLbS0KbkPogm5ZYVYOFj9+okOZa89tRiC9Z1HTHQs315gSI/Vx8I1piIYlum1gWNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yLwiXld9WEdqsUKuvugij+vxh8sf0XpJik0LCLwfAY=;
 b=ZbwpnOWxMrAV4AQgvnz+dAe15/NKCIAqgMLQrP2xAdpzdFcN8crWFmbA4Dj1Cx5/fgihLdd4EnOCjrSAfqhXuQvpoRk7FPD1W71WxlnL6AFOp58MKdfo13j5/c9HIcIlMDBuS4LpaNISNdZwL0Mr2x2CgeXaLTW+a6Lc+V/MRNk=
Received: from SN7P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::13)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:02:25 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::56) by SN7P222CA0019.outlook.office365.com
 (2603:10b6:806:124::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 15:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:02:24 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:02:24 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/amdgpu : Use the MES INV_TLBS API for tlb
 invalidation on gfx12
Date: Fri, 22 Aug 2025 11:02:11 -0400
Message-ID: <20250822150211.796535-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c96a537-ac13-4c88-37b6-08dde18ce716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|3613699012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CR++pcHP2SHrOrmWjaq0e/yWArtZzFLaS/FUVnMIbFllF3to+/tErER9w8Ze?=
 =?us-ascii?Q?PGPxBM4kAGsATPPbZ3bnNkDw1UIu9Awxzv9hCmIOcF6Xw/2efIFXzdSFdZOG?=
 =?us-ascii?Q?JhKgHyDzig+v8GQ5l95O9iR1JKxWnXoJLGCIbVh/w9Zw8jJFTDLFGpTxOku1?=
 =?us-ascii?Q?JqmxBn+je4VXEeXpH7hPPXTpo6HZuei9FLeRzvP/j3/21MwsJ076WJB8BDww?=
 =?us-ascii?Q?mKOF3b2Nwzso6PFHljh7M7lfi+A4hyPNh+HBAGBdVvVmcwomEIEnD2n4NAeS?=
 =?us-ascii?Q?8302dqMlR+8+9JreS/NTRM6wnXL5GKGq/GwpqOA8bebUe2kW2t5C2/u0q2VZ?=
 =?us-ascii?Q?obdt9HgbuC3fSqf7rcLG6wDZySI2oiigaqxu55BaMSANKdVWZ+3jdM5ChUYm?=
 =?us-ascii?Q?3n9ujWWk8vNEGBHRtl5cPbeygAKsEn/Jd7VhFJ8YfovVr3h94N6/13E0ozR7?=
 =?us-ascii?Q?Y+cAN9R6cVRfDwocy7NE6jHoPZbEpTejFiI4TeZayTAuqyqlQSuis8BkRBal?=
 =?us-ascii?Q?vkeND7PtR5AW/bpl3u/pkHfJyfluHbFWWNlrdPyVmVxCZpyGHLGyeWLQtuqk?=
 =?us-ascii?Q?NiQ90x/4yC0XVtcxBBnIdhhembrSO8czmgLIU/Zu4339Qodkid+5uaSLJLvP?=
 =?us-ascii?Q?rAm5sjcgnVt6HAR2uUfNp912l8hMhjfoHaopuNIVCJXuj5uKia5/mcOR0JT2?=
 =?us-ascii?Q?EwQtP9l9E6hvobFukHP1mehvf1dk6uawEIMYr8AQl1ZVuGhb74DJK4QHllUR?=
 =?us-ascii?Q?TvxHSr+t/3nSa/eWDfl1Iyl0bTEsntV2jIIlC/mNZLVIdW+RQHRI185yaV4b?=
 =?us-ascii?Q?vQcuw0O860ukIpGUA3qjazayYfJ0M2smR37KdFtJSM0FMvB6Wdba8Oo3J7MI?=
 =?us-ascii?Q?Gtc1zw6LgVESWffu31V/9xlmSKU68tnpn5hLY33uorecD1KBQmHZPm+sYyRu?=
 =?us-ascii?Q?ju6DzbHV6csylQ79lP8/9ShiCG9DhQdxvNTPrNY57XSrjihHeq9Fyatpxlvg?=
 =?us-ascii?Q?3zED6ZAG8oS7SG6RC2zniuBGQVHH5H0PAS6cIcPQAZ6rAIsNgAa5iL4yeLLY?=
 =?us-ascii?Q?LuAi8L2MIGOqiG733kSZjrHHYBg3P3FoS3Wtu8etFw+vs11KVg6rf6dFd/Rn?=
 =?us-ascii?Q?CP+8HxUbSiNNeJSISp5oJzIiIa07UQGbpRzSuyXAHaV0Oq1sHAGAXHUDpj6D?=
 =?us-ascii?Q?Sy/ByjoOh8NwrBVFQU+1nYwKSechbwonb3w/kuHVdL1wmg6ozWWdC37XbYbD?=
 =?us-ascii?Q?L542JLmDY/Jo/GnxBUf6Vw5Si9h5sF6IHFn1WczFwZ6c+nKVX3Lu5ICkgSZD?=
 =?us-ascii?Q?QUEXjADeWq42PxjqEsdSty8EUL8RmUjsC8eI62dtkTSnf//iWZ4vnCs6ge9d?=
 =?us-ascii?Q?fPRn5ez+eyWBYWGhmThpk/LaI9/OCcPZ2t6XZOae9dKjQI3TXcto7bTNOpje?=
 =?us-ascii?Q?PktpR5+uqhVlOdcS1kHFTeSDuOOxoKvYmrCnBvcUaYU2MvOTP5+Mh0kjL/+b?=
 =?us-ascii?Q?nHf7XG2AGheUpX4Aw84ijToO5l1CSyqOL/rtMeViPYMNtJJSxP7sVhzImHfE?=
 =?us-ascii?Q?e144JURxyZcMYfzg6Ao=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:02:24.4406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c96a537-ac13-4c88-37b6-08dde18ce716
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 10 ++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 16 +++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 43 +++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index c0d2c195fe2e..489a4a0f0610 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -280,6 +280,13 @@ struct mes_reset_queue_input {
 	bool                               is_kq;
 };
 
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
@@ -367,6 +374,9 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_hw_queue)(struct amdgpu_mes *mes,
 			      struct mes_reset_queue_input *input);
+
+	int (*invalidate_tlbs_pasid)(struct amdgpu_mes *mes,
+			      struct mes_inv_tlbs_pasid_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index feb92e107af8..eed62e9a9b96 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -339,6 +339,22 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
+	if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready &&
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x81) {
+		struct mes_inv_tlbs_pasid_input input = {0};
+		input.pasid = pasid;
+		input.flush_type = flush_type;
+		input.hub_id = AMDGPU_GFXHUB(0);
+		/* MES will invalidate all gc_hub for the device from master */
+		adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+		if (all_hub) {
+			/* Only need to invalidate mm_hub now, gfx12 only support one mmhub */
+			input.hub_id = AMDGPU_MMHUB(0);
+			adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+		}
+		return;
+	}
+
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..d0b5deed245d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -108,6 +108,7 @@ static const char *mes_v12_0_opcodes[] = {
 	"SET_SE_MODE",
 	"SET_GANG_SUBMIT",
 	"SET_HW_RSRC_1",
+	"INVALIDATE_TLBS",
 };
 
 static const char *mes_v12_0_misc_opcodes[] = {
@@ -879,6 +880,47 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v12_inv_tlb_convert_hub_id(enum amdgpu_mes_hub_id id)
+{
+	int mes_hub_id = id;
+	/*
+	 * MES doesn't support invalidate gc_hub on slave xcc individually
+	 * master xcc will invalidate all gc_hub for the partition
+	 */
+	if (AMDGPU_IS_GFXHUB(id))
+		return 0;
+	else if (AMDGPU_IS_MMHUB0(id))
+		return 1;
+	else
+		return -EINVAL;
+
+}
+
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
+
+	/*convert amdgpu_mes_hub_id to mes expected hub_id */
+	mes_inv_tlbs.invalidate_tlbs.hub_id = mes_v12_inv_tlb_convert_hub_id(input->hub_id);
+	if (mes_inv_tlbs.invalidate_tlbs.hub_id < 0)
+		return -EINVAL;
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_KIQ_PIPE,
+			&mes_inv_tlbs, sizeof(mes_inv_tlbs),
+			offsetof(union MESAPI__INV_TLBS, api_status));
+
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -888,6 +930,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.invalidate_tlbs_pasid = mes_v12_0_inv_tlbs_pasid,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.34.1

