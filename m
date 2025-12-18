Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8AED68BF6
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 09:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BFDB10E974;
	Thu, 18 Dec 2025 09:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N2P0k8Mh";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF4710E881
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 09:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HH88clE/1ST+B7aofM+fvI6ZER2UKHcuyF/XxEi32IaJBgrzmutaTJbaq6fCYcjlOzgFpsY0r04FPvJa0xpfzXwoDF7WX11Jfg25l9GKbwMaVwuBzgh9MbxYiF6Kajn/xoanL6oII4cxeGDq94zVoqbRUU4m8oFrd1oUsKB2fVWaYu9uQsFZnUakeIOxhrZyDHC3kKjgNBK0VwONT/UQ2LlV/U98g7skk0t4b1SPq7eRvsBFuoO9ndy5v0MIljbolKYGtSlvz17zpODKJrbDJ9gJXx5K/3b61g7iL2s098l/j+SNolF4F2h3Z83BJ8nHsGXeSVMJwLXzUxdkYfMSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2Wtw8bhudlKg2XAH2l2dkqG2uoteIs8qPEOugi1Xlw=;
 b=PqcVxly5ie+IPyRUI4a2bZg3tf5XvYENWtLRomzc2woqpERpna89a6gMd1NYTVOMYDlQJvUtXJ/n+55/rRcd8IL36amCtDKASs0ES2eYmEcfblRGd3F9fVisnXceHKaC567AWQC6Zdm4Rq6s4tp71GiYtA8Kz6C/LaAoQek3AJjADsytvJJCuUSQ0VIDwXI/4WNPB8RlpexhdLg3xZD0jhgXg+594FXjHEJbdjjg2XxSTTLu1vpt2eNczhZ30SdA160Xc/4EDLSxkMOa4brkw60ifGi2TH2Qz9gFQerolBmaAEK8vk/xwH/NCOq34nubTi7oGnzBcqWWhvvNoEFBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2Wtw8bhudlKg2XAH2l2dkqG2uoteIs8qPEOugi1Xlw=;
 b=N2P0k8MhVuH1noQhmr9ZEmpj+C97pYimapG4QkOJ4eKE0gh3vaNUHCWFZzmAu6AaIUwAaTROM7z96eKB2MK69Tii3mZmuvetwXrVKlWjW8o8CTJFhQ+qpmMLcX27HfXiZeb5bqSSUEfrLffVN2SoUxDXZqc+DUnNbg4+tPbVWVI=
Received: from DM6PR11CA0020.namprd11.prod.outlook.com (2603:10b6:5:190::33)
 by DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 09:57:12 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:190:cafe::67) by DM6PR11CA0020.outlook.office365.com
 (2603:10b6:5:190::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 09:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Thu, 18 Dec 2025 09:57:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Dec 2025 03:57:08 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, darlington Opara <darlington.opara@amd.com>,
 Jinage Zhao <jiange.zhao@amd.com>, Monk Liu <Monk.Liu@amd.com>, Emily Deng
 <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Use explicit VCN instance 0 in SR-IOV init
Date: Thu, 18 Dec 2025 15:26:52 +0530
Message-ID: <20251218095652.755871-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|DS4PR12MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd43a37-70eb-4682-2de3-08de3e1bd02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODFieEtTSU1LNm1DbmRoTHJLUVg4SWYyQVoxZmhhTUQ1LzB1cXZYQUZFbTAz?=
 =?utf-8?B?NmZhWC9FSm5YTkN3N3NraGpGdlpVWHgxbzFVL3pGOHlJaE52cEh5THlMdzdm?=
 =?utf-8?B?L2Fza3FhY0RTbHJHTExabm4rUEl3d1BQYnRpeWhhNThSNWllNzltUHcwcHlP?=
 =?utf-8?B?L2svRHZIM1B6WkoxckJBMXBWcGhPeC9BWFZYOUJXU2ptUFVNZU9rZXRSWi9E?=
 =?utf-8?B?K3phYUdWazl2bG45NnBQVHNITjh1dThvU3Fud1pvZ2RCeTJsa2pTMlUralNn?=
 =?utf-8?B?Qndva3h1cUkvNG8rK0NqeTk0WUluZXp3MnlPNFlhSzVEK1BZd0JSblN4MFo0?=
 =?utf-8?B?VUhjeXdpRDVmQlloRlRGekhDcCtaSEZoZDNDTFlCdjVpbUJjeEhSQmtwV2Fo?=
 =?utf-8?B?bVdJdjhLU2J1dlNPMmEwL3JTUEwvMndBUFRoK2NHY1BCb0k1U3RNT2VESXdh?=
 =?utf-8?B?SHBXdG96YU52VEdjNHk2eXpsWlR1YmJvMVMrTHBRRlRLUEprMEUwQVRpQWtj?=
 =?utf-8?B?MmtoOTlSWDY1bjZ3UG94d1U5L3hYVVM1eVBFZG9Wc2FFRUdFQ1ZQcWV4bkM2?=
 =?utf-8?B?N2NDNVlsTmNHaW8yUHVkWkYxc1YwNzVDeURUKzFQYlNVcThtYUt2Q1Y2WmZq?=
 =?utf-8?B?dFRIa25vMGU4dDF2dUVkV1pCbkk1dzZFTzBTQjFvZ0Vsb1JLZzlZSGNCYjNQ?=
 =?utf-8?B?aXlqWDlCY2xicncyb0cyb3VibDNkeEdCMlR1TGFHdmhZM1lhNXBnelNNUURD?=
 =?utf-8?B?M3VpTXRjZDl5ZTZqd2IrMTlLTzhrNThDSGhVTEVRM3FublFDUlB6OUhuRDZU?=
 =?utf-8?B?TU5OaHFlQjd5MVRrVVZCNHpsZSt1NzcrL2d3ZzMydXMzcGJUdWxoWjRqVk1p?=
 =?utf-8?B?c3d2emNveFBUN2xEWlhEdXpPMkxVUFVWa01uMEdlOVVJQzJVQ0w3d1c1U21t?=
 =?utf-8?B?eWFmSWM1VUZGbUhHSVNsMFY4ZWhQR1NWSEFLT3gyMEovR3ZBOFQ3S05SUFZI?=
 =?utf-8?B?T3RLWXNtTVh0YWtKTElnRVkzVERLRUVtRjJZamRveExTTlN2S2NrN09CeGpt?=
 =?utf-8?B?dkFpS0ZvWE8wbkl2emJMOW8yOHdQNkZaa3Y1NHRiNk00RTdTWk9SbmR2YmNI?=
 =?utf-8?B?SFJWRmVqOFd6b1NoTCtjczZObHNQS1ZaVHk1My91UUtBZlhuZnlrQ2ZjKzYr?=
 =?utf-8?B?eDBDWTBJZE1mSVluaTZFa3c5WHhBUFpodUdOeVNGaC9yTnF6NmNWQkpnK3Jz?=
 =?utf-8?B?SnMzd2wzWU0wd3Rrd3hyRFFYZndEK3M4bHE4ZUZEMFE1d1A3YkpxcmZvUXNa?=
 =?utf-8?B?ZzZPc1pwSjhLR095NmVYNkJ4UUJHMXY0ay9ndmUrZWsyUGd2cmVMK0s2Tm52?=
 =?utf-8?B?bHlZQWo3bmZUTEJVdkg2YkIzaEszNFVDZWpTR0ZXWTdkTi8ydWh1UlJVMUNh?=
 =?utf-8?B?eEhXYTY5L3k3NnFLbEpKK2dpcXN1UThZWi9DRExMVTRBSTRiZFZEN3VSQnIy?=
 =?utf-8?B?c2dkNHZyY0t5aEE1cklZb3lVVmpRQlVsZ0JWZThCcEhCbkZSL1luY3V0dWZF?=
 =?utf-8?B?TjhoL1hlQitnZEh0MWNoUEMrV1prSGdsZTZwUkt0Nzd4Z2JNNndYaVRIUFJU?=
 =?utf-8?B?RzdBZ1RRdFNsSlNVNUVKM1l4eGlZNjIzOXNiMEtOQ2N1dlViK2llakxmTVlM?=
 =?utf-8?B?WHhXdGFudEpKWnNvMkt0bDcrNkZadVJlanllYmk4K1YyTGRMc3NRaFFLQWhj?=
 =?utf-8?B?a25tYnBqc28xWWNZVU5WWmg5cDNDTElDV1VMdmNIbHhVaGVXQ3BTSFFPR0Jo?=
 =?utf-8?B?UENZdk5HT0NrbWtKTWsyNzdZUHNBS3RUVmdqVjZYbmxNcjRTK3N6SVZ1aWFS?=
 =?utf-8?B?Z3JtWXJobituelp2V3VFVTNVcXNvbldrNHlxdi9tQ2JDVlpaN3ZqTlBLSk04?=
 =?utf-8?B?OTNDT2hhY1pZOENxaTZZNzh4T3RITUpGSHlKcytkYzZJeHBvSDRHNXBjcThO?=
 =?utf-8?B?MWpqNURFZXFScGVoc016K0RRYkJDSGd1U3oxY09OZks4ZDF6amVtWU9QM29P?=
 =?utf-8?B?NndjdUlpL1dQckNBb1BGK1hhclFCQlFPR2lMUkZQT2VaL09wRXZTZHVEckx4?=
 =?utf-8?Q?u4us=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 09:57:11.0305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd43a37-70eb-4682-2de3-08de3e1bd02d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635
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

vcn_v2_0_start_sriov() declares a local variable "i" initialized to zero
and uses it only as the instance index in SOC15_REG_OFFSET(UVD, i, ...).
The value is never changed and all other fields are taken from
adev->vcn.inst[0], so this path only ever programs VCN instance 0.

This triggered a Smatch:
warn: iterator 'i' not incremented

Replace the dummy iterator with an explicit instance index of 0 in
SOC15_REG_OFFSET() calls.

Fixes: dd26858a9cd8 ("drm/amdgpu: implement initialization part on VCN2.0 for SRIOV")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: darlington Opara <darlington.opara@amd.com>
Cc: Jinage Zhao <jiange.zhao@amd.com>
Cc: Monk Liu <Monk.Liu@amd.com>
Cc: Emily Deng <Emily.Deng@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I447f68cd988561309de8da8dd4a65275bd8c99ab
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 45 ++++++++++++++-------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8897dcc9c1a0..e35fae9cdaf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1964,7 +1964,8 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
 	struct mmsch_v2_0_cmd_end end = { {0} };
 	struct mmsch_v2_0_init_header *header;
 	uint32_t *init_table = adev->virt.mm_table.cpu_addr;
-	uint8_t i = 0;
+
+	/* This path only programs VCN instance 0. */
 
 	header = (struct mmsch_v2_0_init_header *)init_table;
 	direct_wt.cmd_header.command_type = MMSCH_COMMAND__DIRECT_REG_WRITE;
@@ -1983,93 +1984,93 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
 		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 
 		MMSCH_V2_0_INSERT_DIRECT_RD_MOD_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS),
+			SOC15_REG_OFFSET(UVD, 0, mmUVD_STATUS),
 			0xFFFFFFFF, 0x00000004);
 
 		/* mc resume*/
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V2_0_INSERT_DIRECT_WT(
-				SOC15_REG_OFFSET(UVD, i,
+				SOC15_REG_OFFSET(UVD, 0,
 					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo);
 			MMSCH_V2_0_INSERT_DIRECT_WT(
-				SOC15_REG_OFFSET(UVD, i,
+				SOC15_REG_OFFSET(UVD, 0,
 					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi);
 			offset = 0;
 		} else {
 			MMSCH_V2_0_INSERT_DIRECT_WT(
-				SOC15_REG_OFFSET(UVD, i,
+				SOC15_REG_OFFSET(UVD, 0,
 					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 				lower_32_bits(adev->vcn.inst->gpu_addr));
 			MMSCH_V2_0_INSERT_DIRECT_WT(
-				SOC15_REG_OFFSET(UVD, i,
+				SOC15_REG_OFFSET(UVD, 0,
 					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 				upper_32_bits(adev->vcn.inst->gpu_addr));
 			offset = size;
 		}
 
 		MMSCH_V2_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET0),
+			SOC15_REG_OFFSET(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0),
 			0);
 		MMSCH_V2_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE0),
+			SOC15_REG_OFFSET(UVD, 0, mmUVD_VCPU_CACHE_SIZE0),
 			size);
 
 		MMSCH_V2_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i,
+			SOC15_REG_OFFSET(UVD, 0,
 				mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst->gpu_addr + offset));
 		MMSCH_V2_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i,
+			SOC15_REG_OFFSET(UVD, 0,
 				mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst->gpu_addr + offset));
 		MMSCH_V2_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET1),
+			SOC15_REG_OFFSET(UVD, 0, mmUVD_VCPU_CACHE_OFFSET1),
 			0);
 		MMSCH_V2_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE1),
+			SOC15_REG_OFFSET(UVD, 0, mmUVD_VCPU_CACHE_SIZE1),
 			AMDGPU_VCN_STACK_SIZE);
 
 		MMSCH_V2_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i,
+			SOC15_REG_OFFSET(UVD, 0,
 				mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst->gpu_addr + offset +
 				AMDGPU_VCN_STACK_SIZE));
 		MMSCH_V2_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i,
+			SOC15_REG_OFFSET(UVD, 0,
 				mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst->gpu_addr + offset +
 				AMDGPU_VCN_STACK_SIZE));
 		MMSCH_V2_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET2),
+			SOC15_REG_OFFSET(UVD, 0, mmUVD_VCPU_CACHE_OFFSET2),
 			0);
 		MMSCH_V2_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE2),
+			SOC15_REG_OFFSET(UVD, 0, mmUVD_VCPU_CACHE_SIZE2),
 			AMDGPU_VCN_CONTEXT_SIZE);
 
 		for (r = 0; r < adev->vcn.inst[0].num_enc_rings; ++r) {
 			ring = &adev->vcn.inst->ring_enc[r];
 			ring->wptr = 0;
 			MMSCH_V2_0_INSERT_DIRECT_WT(
-				SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_LO),
+				SOC15_REG_OFFSET(UVD, 0, mmUVD_RB_BASE_LO),
 				lower_32_bits(ring->gpu_addr));
 			MMSCH_V2_0_INSERT_DIRECT_WT(
-				SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_HI),
+				SOC15_REG_OFFSET(UVD, 0, mmUVD_RB_BASE_HI),
 				upper_32_bits(ring->gpu_addr));
 			MMSCH_V2_0_INSERT_DIRECT_WT(
-				SOC15_REG_OFFSET(UVD, i, mmUVD_RB_SIZE),
+				SOC15_REG_OFFSET(UVD, 0, mmUVD_RB_SIZE),
 				ring->ring_size / 4);
 		}
 
 		ring = &adev->vcn.inst->ring_dec;
 		ring->wptr = 0;
 		MMSCH_V2_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i,
+			SOC15_REG_OFFSET(UVD, 0,
 				mmUVD_LMI_RBC_RB_64BIT_BAR_LOW),
 			lower_32_bits(ring->gpu_addr));
 		MMSCH_V2_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i,
+			SOC15_REG_OFFSET(UVD, 0,
 				mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH),
 			upper_32_bits(ring->gpu_addr));
 		/* force RBC into idle state */
@@ -2080,7 +2081,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
 		MMSCH_V2_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_RBC_RB_CNTL), tmp);
+			SOC15_REG_OFFSET(UVD, 0, mmUVD_RBC_RB_CNTL), tmp);
 
 		/* add end packet */
 		tmp = sizeof(struct mmsch_v2_0_cmd_end);
-- 
2.34.1

