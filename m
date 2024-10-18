Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F81D2F7E8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 08:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E4710E371;
	Fri, 18 Oct 2024 08:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VnbKtl53";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB4610E371
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 08:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf927vr5nWbkbd0R03MKajgkrRRIfa1JsvaDbKHqO0sefJmqbzxvLS3jsyP45kqjNQWtImsgRHt2VuSw+hgeH1kJ3LToXauwjjyuf5krwaBKjHcB3yWokGrJ1u9hPP2tg2FJXNTOx+eGzMwA43pGFaSxeDcYcR5X7oKb7zBDz+dsY4H9qXKRldyI62j0utItnYtIF9wF8Np1oHRBYhTeUZdaQg/LMSnbaETVQ61SckEdXxDP2DISYX/TIxSM7oZABPpr18XvaoS/nhGdVYbSYlCRFM4/LAZbQBLzPhui6aa3eQsLiGoLLZ4QyGSpGmQgd59pvi1vvNbZqrKi/Cpgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2jsz/osY5AXtmTX2r/iSgzAMfwSBj4n/Z9sfKc62LQ=;
 b=pLbEce1HK2BmecT/VEjxrzVvzYR6nY5ITuyusWMTO9c4bQNFXPPMwrtFgxgUyq0tDY6CJjPDtxF5UbsP9RNdjqZfOJynm7D6M0ccbd24BL/9AfMgp7+deeBssMsDjNZCJxI3WCWE/U7MeK1it6FG746oP7zly2DUnZldjrDyAvsiAuZnvtoTB5knnjVRDGIR+qTH1vBQKkG8qen3iATYioHh2v6DUQ3gH93/PoW+UC51oUzjDCtpzZGdPzNZG3rbpD8FeHrnm/eLyIvUPzXiqBL3vT6aYU6FopQrcGpAsQVTvoxXNmz3MF7T/wL6VJWOwU8XNC03wCvCKYlhqQFI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2jsz/osY5AXtmTX2r/iSgzAMfwSBj4n/Z9sfKc62LQ=;
 b=VnbKtl53EBYHuzqotYik4vOYv1xCmvQve3lX4xP2V6sf22g5hKf8spgceeHz+7FrRJdZeRI1UTfyWgB1X4i2nWWgrwKFIW+TgQlwNmjIUHGtW45PkZSZ3vRUArNyeu9ivn6Ilwy2myi/kv7iwsVinI0AUjZBjuy8tfwDmw/hGDw=
Received: from CH0P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::35)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 08:39:24 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:116:cafe::31) by CH0P223CA0009.outlook.office365.com
 (2603:10b6:610:116::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Fri, 18 Oct 2024 08:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Fri, 18 Oct 2024 08:39:24 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 03:39:22 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: Add nps_mode in RAS init_flag
Date: Fri, 18 Oct 2024 16:39:03 +0800
Message-ID: <20241018083903.3660339-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fec122-19b0-4fd3-1e03-08dcef505e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dEaRMKbOuiCig6i+We/R05X680Qfa/LEswDhYGGMGMAuhvXXSrJuIUIz4FqI?=
 =?us-ascii?Q?MXzXA5sMr6T5kugJxpj/LTrbJWy1LGorRKjTJ+1XXzWDqYif4x70FcM2e1qU?=
 =?us-ascii?Q?3DKpCM+khz7IfxEODY3sowNI0h0DnygL6NvMRueSCgXzjcBiaVyiDAkygRaw?=
 =?us-ascii?Q?juJsOrMu4tkKV1D71DLRLF9ZDV2Kg6dSfCpBgZ1wT/jWaPIiVLSsINEW8oDm?=
 =?us-ascii?Q?lrpI2ZtTvPGFj+jUDDnN2DLBcvbcitcjULt/q3CQ85XVB8ne5mzw4w6st+AM?=
 =?us-ascii?Q?QF8lNWMkEDSOC5pXPQZREW9NP3lqGEnJjblFI2lCDjEpubgYgPD9tzRSep2Z?=
 =?us-ascii?Q?MMQAOsKkB2SzdOFE5aa5vnWw6M/IHp8d0uCpl3ujLlrP4Jg6O4nR3cdKVeif?=
 =?us-ascii?Q?2OcvAJgo88l4Xev06W3mPNDSpBvTHi0EdDf0TAm7LsaJgQUvhBX9OpbQPBrZ?=
 =?us-ascii?Q?3qCm4s9cp1UoBd5cb9KzzP5v6kUMp9h8gCVgkEA5hyw0X81K+tp6Vkq+D5CE?=
 =?us-ascii?Q?meHxqc0daye7zxhp6BU4J9yDxYXD9ymcFiUWRRcFjPDJ0KbJwKErCFC2ACDy?=
 =?us-ascii?Q?6jl1mbEF5Lj1s0IiBZK2+k+Kg3XyUPScWO8JIoG8KDDKjaGUkihMEyMJtTrW?=
 =?us-ascii?Q?xCD2TcJP6nx/QcN+zfBVpyQysdcZBgDhRxLerGJtSOIKg/AkCyMpiEQbfX7C?=
 =?us-ascii?Q?cy2ZJ22zPXwOkbT6i+X/DdTWqGF2GEHwPsTq5OlhIIfgTbZjgx+nnyFLV/OG?=
 =?us-ascii?Q?7/yADN/xQaGW/GK8S04Yp31DvN5byfw0XDCANJ0VuEK1KAG0XjSOVcv5LECv?=
 =?us-ascii?Q?TpuHIZFbbLRs4TNk0rMaklHOiTSXxUQ6bF/jATD84KcJVqJQ2P879cw70RVU?=
 =?us-ascii?Q?2T4KAK90I78A4DjiE4zWMjQ4MlqQzuiND8UaO/DX1EsoqgSEZCJUWQLnJAkk?=
 =?us-ascii?Q?DaOrg+XRJf7BduZKXcqEyx4WDTLrHTq9ZmhmNJalupjUXcmXtNUeXApVPRBi?=
 =?us-ascii?Q?N7/WSn72lzUE6zAQi0nwHHm3nREVtU3D1oCKyv2gQEobpvmQAZbMFloXIrgc?=
 =?us-ascii?Q?lZpZ26P7QC0/c0y3yTMCWZ3nNn0d/QNqOHv76achMfTatVwaXmZPqwvvtS1X?=
 =?us-ascii?Q?oy3phhpdxW2giW8p6X40sreFtKJ4j1t89OgHM45EmOhtjEUBFi92mqRothvu?=
 =?us-ascii?Q?Ijhf36E5VFto/lbxmNVAii//GFVzrqS30dC5g84vNsbqAdk8htESdjaADFs8?=
 =?us-ascii?Q?JQo1ISwNplnA/jgrSx0kBjLOWYxzUPNNpaANWEAwBcb4BoUtLg+VPmblCqbU?=
 =?us-ascii?Q?mVrwdjWdap7eli51D5fbNeU1uoyQD/pvLmDJ+ujgpdZzsP9ndpWXgzRAlvSh?=
 =?us-ascii?Q?Er0qwOFUXG4PB/Mvbp5kz9pMzP17QfyrI8VxVQ5mTT1gMBfPOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 08:39:24.0732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fec122-19b0-4fd3-1e03-08dcef505e7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486
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

Add nps_mode in RAS init_flag.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cad153e333d824..a545892e51802e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1834,6 +1834,9 @@ int psp_ras_initialize(struct psp_context *psp)
 	ras_cmd->ras_in_message.init_flags.xcc_mask =
 		adev->gfx.xcc_mask;
 	ras_cmd->ras_in_message.init_flags.channel_dis_num = hweight32(adev->gmc.m_half_use) * 2;
+	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
+		ras_cmd->ras_in_message.init_flags.nps_mode =
+			adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 
 	ret = psp_ta_load(psp, &psp->ras_context.context);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 3ac56a9645ebdf..21b71a427b1fdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -113,6 +113,14 @@ enum ta_ras_address_type {
 	TA_RAS_PA_TO_MCA,
 };
 
+enum ta_ras_nps_mode {
+	TA_RAS_UNKNOWN_MODE = 0,
+	TA_RAS_NPS1_MODE = 1,
+	TA_RAS_NPS2_MODE = 2,
+	TA_RAS_NPS4_MODE = 4,
+	TA_RAS_NPS8_MODE = 8,
+};
+
 /* Input/output structures for RAS commands */
 /**********************************************************/
 
@@ -139,6 +147,7 @@ struct ta_ras_init_flags {
 	uint8_t dgpu_mode;
 	uint16_t xcc_mask;
 	uint8_t channel_dis_num;
+	uint8_t nps_mode;
 };
 
 struct ta_ras_mca_addr {
-- 
2.25.1

