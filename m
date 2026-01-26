Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A62D1950F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9136910E47E;
	Mon, 26 Jan 2026 20:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZMFbLcBL";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF91F10E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwF/aV7xwrI9Ls/a7bnYJNv0otW4ebOvXRHGfcPB2Yug24MN/p1i4E6hp0zSe/fl2/7gT9VaU4WflNVKihG2y/RScEFwSvSOIeWopcTeL80DmSGn8/zq0vR3zwVLg1fRUgtQifmokbCGYUYorgNUQuOwzHznhMqYCjnFNkXPsi1Addg+2sC2CyejXE2I4pYUHRn9RtYbQAQmN1pRGipvMZmWDNIR+5yooyzVqCLV/EuA4NL5rb2uUvOS+FsgsAIbMV23TgxM6GHwypYaEnf728KNVIG/mNh9OvVRFOUP8CDVjkkWfDysnNk2vo7MFvdr31YQye2kXqwIwJLRO2GcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uitqg4X7C1ttNFCU5yJ5YI2cW2JQDQjFIfmBSqrquBU=;
 b=sr0MiauR8idUydqtCHwTm8F+c95spqQM/gG2DehzkfrVKY+XoYKLXegwlVH1V9mwZRAG0kog/PPAgoc0X1Q5TPfF7ojPkiGqp9bi+bWOHBiECA1mLzwAw1+BBWaIa/n6ZrF2GFjy92ropjoJP1mWtEkohMsta84VrQZon5EJ8J7KAkZK+Jm2NWapssFq3nEDV+aEg8obXFUIip/9v0kJGQcFbxWoxNml4IaV6IF8s7UxGzr3ZKdZn0FH9lSdfm75qbFmEfJncUXn3y897NryAo5qqEH2DsRJsWJjOAveha9hIKjiZIZej0WxOaYIBUvixjcPQCDJlW82366pi8p0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uitqg4X7C1ttNFCU5yJ5YI2cW2JQDQjFIfmBSqrquBU=;
 b=ZMFbLcBL6AVKF55klC1F/3TS/HM/TIWVqzcbilTZ3dZpe91Q4MpJNSwK642k2Bl4FdNVWmNQNLjFo+UBHWlyuaC4Wlt8XijXZHvHMQ+lml3x821guY9kuk1pYGlP4LIsALsbR3Os379wLTEG5NnO2A8KGM0aOd6EtQ98kQ4A9C8=
Received: from SJ0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:33a::12)
 by SA1PR12MB9003.namprd12.prod.outlook.com (2603:10b6:806:389::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 20:08:00 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::46) by SJ0PR03CA0007.outlook.office365.com
 (2603:10b6:a03:33a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 20:07:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 20:07:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 14:07:59 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 14:07:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 06/12] drm/amdgpu/sdma5.2: handle gfxoff in interrupt set
 functions
Date: Mon, 26 Jan 2026 15:07:41 -0500
Message-ID: <20260126200747.13527-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126200747.13527-1-alexander.deucher@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|SA1PR12MB9003:EE_
X-MS-Office365-Filtering-Correlation-Id: e136f1b1-c624-4027-b9a3-08de5d169aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oukWxpEFzgQXW3Lwnp9dLBaQ+XS7JpHPbfpG87UE79s/66MowwlYLX+hkKwW?=
 =?us-ascii?Q?bT3XYxv9SsB/3P5KfIPFy1zAQQOpaei5WUqPBj6vh3YMawQpy8qRI1y8C0lL?=
 =?us-ascii?Q?7nE/jF92OmxIc5GAFRUdyK04WAqq33hEOu8kMGqro61WafuZHeq5k0Y1aFwZ?=
 =?us-ascii?Q?Rij9mcJ35qXkyqcoIbk7rGfISqTOnEuANnIFmyjoDz3Q6nn3xuSq3paU0KBk?=
 =?us-ascii?Q?s3g2XN8RYkv89KHM3/xx0t6Z+CDZHfFnJQpWRPHPXNp8Vpfv7nv1IeKu1cNX?=
 =?us-ascii?Q?Nkht5mXpGZ4NGmAZ5M3T3ycc9Z9zRI4IySY1hxodaPHEQr9dlpwuw1XL1Vm2?=
 =?us-ascii?Q?0m77NE//4DP6tDlkuRBx8s3L9nSQyIHws3il9zBqZvAc3XKNFjtmnybyrAXt?=
 =?us-ascii?Q?vrZFJ/oxOiq6T4Xjxg8QUUvWX+SG/FwpZuCIzqa3K4aoEmlQ5G2LJi6T10Uu?=
 =?us-ascii?Q?6tAgrJEOsspo9p1hN7b2XdoKBlWwnpqwG8VlFQlfnqFhHmWDw771M3Sd8qkG?=
 =?us-ascii?Q?5aI9NUFN8msXXtXx/Hf8oUvq76VxLL35RJBdTTnGx5BDkqcqzkGFYwGg/6UO?=
 =?us-ascii?Q?zoogiFUXFdycyHuVtDAqfAdZvNUHUtseUaKnkI4eodGhUTj8g/tI/4AWfu7T?=
 =?us-ascii?Q?2psKOE9ZORCWogjxcjQfOUViBQnQkjWQGcvkv8BZ3GPPoAC0ltb6RE7U+lAA?=
 =?us-ascii?Q?yTOKg4oGXtmGEvRJz8Mqr5dKg5nWQGjFoQSc8Nr40LtRdtD1CopI9fLBNTPl?=
 =?us-ascii?Q?BHpChNthMrf5BneJLH44AnTr2/UaaWm3Mu8D+t4zDgMST/1+yl8CYKAigjWv?=
 =?us-ascii?Q?5zKcv1Y1dL4aFmDRdzcww2CLb9JASTfbyn9rn+YrBl5W4yoICuRwY6Sr8MsX?=
 =?us-ascii?Q?FGf1Efx7vbEOgue4ssqnBNNJPSlOFnE7UEyvQbq+x3daQqgi9lzLRUQZhLaM?=
 =?us-ascii?Q?j4qb5HsxjcFcGyY5s2UTnBcGSHCLj/NugkulJg8x+n842XCl+a0fXa37H0KK?=
 =?us-ascii?Q?gb+aL1/XVUTf2Jx4DoJm8GnB2eg4tGTeF347umsI0Cx0IG30oyVZw9GpW8W+?=
 =?us-ascii?Q?oD3B3b7YALx6g8auz6BFa72m/LkWIu9UyJ9XzzJqpY7q/QNd4Drjn9jKMgBY?=
 =?us-ascii?Q?aDo9cJVSa7vBzyNufio6kFjnJ3gELACTM/wmfeOigMxlwgnXejAn4iLBKUQd?=
 =?us-ascii?Q?GlikQTB8uYjiMvcEiHKDnkcAlUKvB2V0qPXdXOQicE1ACJTycKaKqrQzfQLo?=
 =?us-ascii?Q?J4796K9QceD1UR5aS920noJap2uRF7Qo4qUpRJOLPgox0bzzH7nRH52oHplr?=
 =?us-ascii?Q?IlLjUv8EAs4D46jzPtxbiwqyZPNSS04R58PQ8UIICd7o3mkbXn+x5zj91xep?=
 =?us-ascii?Q?1Sdr0DWCxkciYuR6f8cWx2kp2PyPqEGsKB8I6H4sRZ2COUZYzgWAWObb7dMp?=
 =?us-ascii?Q?a/kPa+ktWw5Mf6HLsGLaMkLe4BGrlCS/6E6mBQS3862i2+nCndqTXoLg4Pzj?=
 =?us-ascii?Q?BlkDCisaeda01EsQ7q2WQ/O/MMYzo7jvQxnxOutHIXs+NLRN4M8cLtYFux/g?=
 =?us-ascii?Q?2U8Y6XUI+OhxEeSufE/Jq7kE/9ZLB/juQhawONnJzxvuR7c7UC7nx2oLsEON?=
 =?us-ascii?Q?EHooxHTGJVQcZt7quPW47DpW536AcnDyFUxSfisEZJB5nQmQDoWhhKS1AABx?=
 =?us-ascii?Q?+20FAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:07:59.8009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e136f1b1-c624-4027-b9a3-08de5d169aab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9003
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

Need to make sure gfxoff is disallowed when we touch GC
registers over MMIO.

Cc: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index a57fe976cccaf..861d48b7fe9bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1607,12 +1607,14 @@ static int sdma_v5_2_set_trap_irq_state(struct amdgpu_device *adev,
 	u32 sdma_cntl;
 	u32 reg_offset = sdma_v5_2_get_reg_offset(adev, type, mmSDMA0_CNTL);
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	if (!amdgpu_sriov_vf(adev)) {
 		sdma_cntl = RREG32(reg_offset);
 		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
 			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
 		WREG32(reg_offset, sdma_cntl);
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
-- 
2.52.0

