Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA36C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 15:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3720510E2C1;
	Mon, 19 Aug 2024 15:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PVbAtbMD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0CAB10E2BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 15:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovQ/iqcQW5P5376SmGghe4NZvWPKNjonNnoyk2nTfu3cvEq4NTzOGX866bKlJ7/E7akfs2zmwPtW5z2j9DzIEJ9hhG2/rhLYuCaL3DfczwN1+CCoWEtCWnzRV6+OgiKCCn1LF+h++W9xx6bCz27nE/vVNtxt6Fh94Ng9zJJsh3qlLJz+80jhBer3bFBAIZgp4helafgV7F+9e/REsXMi3g8bhzeymOk47+X4BOmDHQl5zScDSotW5GRz9b/dcipp7RMoegwAgVZKhtPqlY8qeSQrCBjbDjTghcYs+WINQ6LweHP/UYtg01L56h1XJtI3Lle2VaTGgLIlf1dq+XlYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c89Q76DReND24XFSMYfS23K6TaVB1kfcg067ip2WJaQ=;
 b=YGnjroZcFN97ySUj56i4dY5dYQ/z+r5QiGlF2XdnlLtyZ0uoi/AgUQUC9vz5uvxPdJ8xtKyhX/hZXdppX+s8H12KM3oH/YHs6dgMd6OBVoWBTbwQrQ08BXLqeo+k9yxUT5/wwpiiAdvHCMIch4cYPPejeL9ZZFWtyzfjWkikzhvc/Bn9Q9h298yg9gWmzRAK7pKEspiM0RsYrhBCdgyCAPVJVoBle7O+cgoFXPTVqJ/3o7i2nWObxbhQJCdE5rcUEHrdgxQebe4Cg96XkrCdzqnsYnz3D/Ow21R4QilTn9Op/47UybpvyotUJaxwT177l0IFMrQ8LYDLtCmFS8Oiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c89Q76DReND24XFSMYfS23K6TaVB1kfcg067ip2WJaQ=;
 b=PVbAtbMDlWzRRCw0uYX631QSgOKPTEBJtOwdfbjLz9MV8WYrnGVikI0TNrN7oDS+7Ymt0cTvuvxWGWq82xxFFvsgJYZeVia8i5wshCzMVMtI5GdR7rBYvjf14KQxN2QihF+7jPRbbHKOhh2pjEzujZi7RxkJKYEnrX4bpI+zM54=
Received: from BYAPR21CA0024.namprd21.prod.outlook.com (2603:10b6:a03:114::34)
 by SN7PR12MB7297.namprd12.prod.outlook.com (2603:10b6:806:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 15:15:12 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::f3) by BYAPR21CA0024.outlook.office365.com
 (2603:10b6:a03:114::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Mon, 19 Aug 2024 15:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 15:15:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 10:15:10 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 10:15:09
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Shikang Fan <shikang.fan@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: Drop poison hanlding from gfx v10
Date: Mon, 19 Aug 2024 23:14:36 +0800
Message-ID: <20240819151437.13808-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240819151437.13808-1-Hawking.Zhang@amd.com>
References: <20240819151437.13808-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SN7PR12MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 48655c12-88bf-42ba-193f-08dcc061b85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2xmaR+LOuDbjSKv5ldLt3edeXx/VyEz4BcMhmicRT3Y+UKgIvkxWmd7yiNYh?=
 =?us-ascii?Q?0RiMFmJWrRiNrSHat1Q/BNRtm/Iet3ZOMfKU9yvQfS3oUCq6AwH9G04R2vRc?=
 =?us-ascii?Q?aZmSkxpQhT6ADhn4AiOBOJwwsk/a76IaQxXGGTLFgl2myFLdEKiDYjf07OOc?=
 =?us-ascii?Q?t3IN5oPd06CV+4MATo8xFFdO8Pj06FKtIKXR79Gvej3UctnRbKIW7r/HKnNx?=
 =?us-ascii?Q?czCbQRpqmITZup0CH9i73vihmRXWTlwQJlyvk175h9qw5n3C5yhd09U5Ix/b?=
 =?us-ascii?Q?dJqTjPYLHttvqLdcvgtTM8Uo20xvRRhb8bz+ivpporSxuzYs6kJIFu5KPv3U?=
 =?us-ascii?Q?PZhaADs9aAEVjigve8RaMgczSuxW/He65icVuKcjAps5iG59FL6U6V8ij+nU?=
 =?us-ascii?Q?SgIAnlQHgT6m4a2aIiBnXvAad/o1zqnEpg0cFX8PQHxNCOC5DySIcYFvWi3c?=
 =?us-ascii?Q?y65fZ6XmscJf6JTk5GROqFvdRRob+eKePpDWxFUYPi/TkaHwWxbUh4kfqHlD?=
 =?us-ascii?Q?mIoVtJtazCAeXqGnTlC7V64M5V5HbjMrxit56y0q3dB8OrRR19r1hb40+Oex?=
 =?us-ascii?Q?HM06/P3ZG342NNzW5r5V9vgs6dMB4JAE78x9I7rJQcBwFRu5aW/GBYqdyGAp?=
 =?us-ascii?Q?avDHLlG1DgGbz3hl0hO7OKGlVN5oGL6YcGT6K7n/M+NBbJp3F796I7VJBdpt?=
 =?us-ascii?Q?UYVReD7rTvFgYDezYNTiOXVInStAFxDr3FQe0BXs48IyeDfrIJm9w+3Myxlw?=
 =?us-ascii?Q?GdjKVf3OyJZIj0nkk1DnKhKWnA4rxAR6h++CIx6teiO8+sxsBpY3YrJuZZ76?=
 =?us-ascii?Q?9IRuHShOi3RYu04jukhaMsXvqfpFdVeOdFaD0D9AtA55yco8LPgIybGT7Kj8?=
 =?us-ascii?Q?gtafHyqze1o7mqN1fzg76pK0UBEwO1LzZl1wAdEDMVybJtxJpvo6qFMqxUxl?=
 =?us-ascii?Q?ddabapCAc/hun3mxEmTKd74Xv7DC1xaCYj5VHZEXr2A/oHKMVAjiv9CuhT1v?=
 =?us-ascii?Q?cVcOuXcHPDVnKaDYKK8r5bJBZ+PXiZdGXxyurD8myk4rrK0+dxVoBzHSvOmn?=
 =?us-ascii?Q?huFk461caFKClUyhsKbCs27zURpSmg/EOi+jrmBVHAHSThPBhKoRTvwN9ikY?=
 =?us-ascii?Q?nNcLonTwpR4DFqWckz9deDnoNcXaSF2RQC3tu75ACWeHSyIZZSdLEQGNP6JT?=
 =?us-ascii?Q?5n/wEXQIG7C3wGxCCxQcajoDFHQF/BhziDEskQaHzhG3lnLtnslPgwvVZe5a?=
 =?us-ascii?Q?TTZ9+6+jNGBuol0Vkn0QV5RgpxODNbszcf+YSNBhYS6i92cjVh/6CPkpsZYi?=
 =?us-ascii?Q?EWWudyMiIxIytRDS5Tgd18FXIRJM8+viElyc9qjJbt7WeU1xdlixJ7ZUp6pE?=
 =?us-ascii?Q?ozg8ZQ2AE3JuiLzmO9Vr0jKegIIX80JFsdq9z5KMWpN9enYujVmvPyY3+YvW?=
 =?us-ascii?Q?12PKqW1HEIqObfEH7OssUNCUIElaNA/3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:15:11.6325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48655c12-88bf-42ba-193f-08dcc061b85b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297
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

Not supported.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  | 71 -------------------
 1 file changed, 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index 8e0d0356e810..bb8cbfc39b90 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -129,63 +129,6 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 				KFD_DEBUG_CP_BAD_OP_ECODE_MASK)		\
 				>> KFD_DEBUG_CP_BAD_OP_ECODE_SHIFT)
 
-static void event_interrupt_poison_consumption(struct kfd_node *dev,
-				uint16_t pasid, uint16_t client_id)
-{
-	enum amdgpu_ras_block block = 0;
-	int old_poison, ret = -EINVAL;
-	uint32_t reset = 0;
-	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
-
-	if (!p)
-		return;
-
-	/* all queues of a process will be unmapped in one time */
-	old_poison = atomic_cmpxchg(&p->poison, 0, 1);
-	kfd_unref_process(p);
-	if (old_poison)
-		return;
-
-	switch (client_id) {
-	case SOC15_IH_CLIENTID_SE0SH:
-	case SOC15_IH_CLIENTID_SE1SH:
-	case SOC15_IH_CLIENTID_SE2SH:
-	case SOC15_IH_CLIENTID_SE3SH:
-	case SOC15_IH_CLIENTID_UTCL2:
-		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
-		block = AMDGPU_RAS_BLOCK__GFX;
-		if (ret)
-			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
-		break;
-	case SOC15_IH_CLIENTID_SDMA0:
-	case SOC15_IH_CLIENTID_SDMA1:
-	case SOC15_IH_CLIENTID_SDMA2:
-	case SOC15_IH_CLIENTID_SDMA3:
-	case SOC15_IH_CLIENTID_SDMA4:
-		block = AMDGPU_RAS_BLOCK__SDMA;
-		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
-		break;
-	default:
-		break;
-	}
-
-	kfd_signal_poison_consumed_event(dev, pasid);
-
-	/* resetting queue passes, do page retirement without gpu reset
-	 * resetting queue fails, fallback to gpu reset solution
-	 */
-	if (!ret)
-		dev_warn(dev->adev->dev,
-			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
-			client_id);
-	else
-		dev_warn(dev->adev->dev,
-			"RAS poison consumption, fall back to gpu reset flow: client id %d\n",
-			client_id);
-
-	amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, reset);
-}
-
 static bool event_interrupt_isr_v10(struct kfd_node *dev,
 					const uint32_t *ih_ring_entry,
 					uint32_t *patched_ihre,
@@ -332,11 +275,6 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
 							WGP_ID),
 					sq_intr_err_type);
-				if (sq_intr_err_type != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
-					sq_intr_err_type != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
-					event_interrupt_poison_consumption(dev, pasid, source_id);
-					return;
-				}
 				break;
 			default:
 				break;
@@ -362,9 +300,6 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 		   client_id == SOC15_IH_CLIENTID_SDMA7) {
 		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
-		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
-			event_interrupt_poison_consumption(dev, pasid, source_id);
-			return;
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
 		   client_id == SOC15_IH_CLIENTID_VMC1 ||
@@ -388,12 +323,6 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 		if (vmid_type && client_id == SOC15_IH_CLIENTID_VMC)
 			hub_inst = node_id / 4;
 
-		if (amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev,
-					hub_inst, vmid_type)) {
-			event_interrupt_poison_consumption(dev, pasid, client_id);
-			return;
-		}
-
 		info.vmid = vmid;
 		info.mc_id = client_id;
 		info.page_addr = ih_ring_entry[4] |
-- 
2.17.1

