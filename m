Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E77FC2BBCA
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 03:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 987BD10E0A6;
	Wed, 26 Jun 2024 03:01:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eBnRTsr2";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE47810E0A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 03:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBSFxPjaoJgnXdpfHidGx0stuLNFafarIOE5ThNnzro3t5pul8mI1oZ4iAuFpx4sYIn/yfx186S9y8D8HkVHYBXNgRSuK8JobsMvaoy0oEI3NTD0lqXU2SOUPzL1rr7/93Z9FPjxku7BRPkYI/hgw6ww1PVvCeHsKCiumQfLXjfLqAbWyeSUMZFc6LfK+Z6UfIsZ+n2ZzbKjxsjxPwTaff9TipfJcEEW5vBMkGixUZZ6LBZxMoh+TQ/4VWh50RksKiQRsnFgdhEez+T40pOKkFMNdP/m6klSKKScIiMthZJMeWYnwJfsd0PoAgr6hfDDkbTuNfhQAV08dvmvU9hTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQN0X72lSHZCtZ21LI7s/02F2IZ9gjmLyDvBk9A5xGo=;
 b=IbvisqWyvbv3ZVu4XCKtEVBMTKv4kIDFfex6qHGYqanOZakqf8BThyCLrHbagAmxRB0EaeG3Vc2runQjvra3G006tlqwgZ19Ja8YQaO4XtrDOuM+ww9+GlQxkUacc4x/qT6JSkp/Ka7MhLs3/03wDQD/AisuH5IfDVFtYffk+0CeaqTN6tT/PC9mg0/AwYOVp7Oyc3ouK5eoXNoYSrCkRRgiiqrCfD2au7EFYBM5qgWB1rtcGCwhTjhOVaxxK5D/uubiLZCj0MlKed72PIdQ0P6/LAHyJsu3ngNsJhBAxqOHUo+L4PVlk9LFNf2CAICPfhp4YM9Cv+DWd9xNxr/Wmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQN0X72lSHZCtZ21LI7s/02F2IZ9gjmLyDvBk9A5xGo=;
 b=eBnRTsr2m0bs9jS69+Q4CdXDsQNitZkwLGMLHbyDMkthiFdcyeYaFXt6z+SQFKKTOGMsknMmzZBRlBpLzV4oRQkzLSSZPFir6WxhCAWK2eix2UMTB/d274fRkLxzebuMqVo1UjhztaSjBpfd3kb/nU9d2FEgFtYdirflUqkBLCI=
Received: from CH2PR05CA0027.namprd05.prod.outlook.com (2603:10b6:610::40) by
 PH0PR12MB5680.namprd12.prod.outlook.com (2603:10b6:510:146::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.29; Wed, 26 Jun 2024 03:01:33 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::da) by CH2PR05CA0027.outlook.office365.com
 (2603:10b6:610::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 03:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 03:01:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 22:01:31 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Jun 2024 22:01:30 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <christian.koenig@amd.com>, <Haijun.Chang@amd.com>, 
 <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: normalize registers as local xcc to read/write in
 gfx_v9_4_3
Date: Wed, 26 Jun 2024 11:01:29 +0800
Message-ID: <20240626030129.2551363-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|PH0PR12MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 3696eb11-e347-464f-286a-08dc958c48dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|1800799022|82310400024|36860700011|376012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TKS52sKjnmPYWXboqJUC+B9YqTFZzYbZdiT9KEafWht4l3bY8BvqQJJHr2sf?=
 =?us-ascii?Q?ZU0lUyjiD9iQOCUxY6xXNMpRspdBPVSPsSeh3FInFxXowT5+zyii+lRny3wz?=
 =?us-ascii?Q?bWvoy+QwAYsx58xmGhyspRESHwX248fQlKdAfxICD/LJIOPuLBZdLgv879nE?=
 =?us-ascii?Q?v2r/P0Ws4Ew1mNAN8yJTm9MjR+YD/NsmtvqFztWchAITVwjv/RfpDFmKw39a?=
 =?us-ascii?Q?Z67onk4fKvlMDkhIxUAoWhZbsEzF5ms0+rhVsWEaR+Xl3n2YeMGD8UJv4CHE?=
 =?us-ascii?Q?tWAPcdzCh7O1qZmCHnTIefJp1iZwtKDsjdkj7rB1xirtTVxo0/f5dD7FMNOw?=
 =?us-ascii?Q?nRMHU8m+xR50nKCPl+pmU8WYSKNT6UfBy+yYHMpBpa4Hfv2d2aWb5ExIgNO3?=
 =?us-ascii?Q?HUx8vXJS5j7wc8uHxwasVbX24Hio1ZL6oFbldvlgKrdIVvmlZ5QgYheYS0jd?=
 =?us-ascii?Q?GJeGP/XZOOW1TnbvGd36guC/s920Uu9UQ/FAR2sSa8AGdV52gTbOGqviC6gG?=
 =?us-ascii?Q?mTaeQzPp0/SeBxaqi9ouwRBTOhPZCNmGSkN5V6gV69xI4VQywCWaGDKoWNik?=
 =?us-ascii?Q?DRjhY30xG4zyY/RP2LyYr4AZc3bYNZXBT0G36u9c+jNY/SC3FKZ2R/CFcxxp?=
 =?us-ascii?Q?Lj60PuSCllH0T974sGAeJ5eEK7YhsLxmgM1xPAIctgTpd7KAvOZap3WD+ov5?=
 =?us-ascii?Q?Vv8KcupfyjtnRCHaevce8oBBiKTqPE4i1E3zkNXsrbWz+MYeN7wiBwjuR/c+?=
 =?us-ascii?Q?3HvTGR4uQcU9rz587a99k8wc1HYmdG2iGhFI5DmH1v9aMkQ29PYQwQzB9Ypt?=
 =?us-ascii?Q?cIP47rW33qbh4tak5WXKFPF9/RC1qz2XJ9sDBp1YzWqdVhJ5HaUnrwBKJjd2?=
 =?us-ascii?Q?E58tXR/BB+Bq/dENh680pESFRYHWAH9SCNUu+phgaAPSi2a/wScQcb42ttVx?=
 =?us-ascii?Q?osugfviEGoLDIqPQ/XGfLrJHCEAwxF2/s7eNYfmMU+nquBEyc3UzMlaSvLEy?=
 =?us-ascii?Q?+RgiG/Or5D2ZqpjgCT7mrSix5i5CGM6+feNBBNYSdsqSRz56I80VqXW4Os4I?=
 =?us-ascii?Q?Nuw4f9Kfb+tZlyI5Dpsp7PgCFc5JnvzyvEJEcOGc3PUPu2ThYcIk2bZcT2Cr?=
 =?us-ascii?Q?PrKwR+e55qebcxgzXlsGa0CZZmdmgTIj6ZXgYT8j3rg7Zn9YjWQxc6gTP68b?=
 =?us-ascii?Q?4iLegYRqXUcwntOMmUYOQf64lrsxsEQEtxdv2UZ9rmjHTb2oMb/beNf5TaRj?=
 =?us-ascii?Q?tir1lW0ncMt+Qd2y0/hhY4tPrRQ0ZudHrrGPpbzO2f3diJXakS249ri/SxOS?=
 =?us-ascii?Q?gFxXE0z0+trUcwC75gH8FaWy3OoNIxsCGcbpAiSVIgeQRq7LSC9+JDgcdQ9a?=
 =?us-ascii?Q?Hci3ZQYVnvga5R/cgoTFaZqDuBD5cUzhaEOOLAAw/myflvKLzmu6MRSyx4Ah?=
 =?us-ascii?Q?Mgj84FgxG5FOBdgor8oj+rVsTwK0GOh4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 03:01:32.9087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3696eb11-e347-464f-286a-08dc958c48dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5680
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

[WHY]
sriov has the higher bit violation when flushing tlb

[HOW]
normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
RLCG will mask xcd out and always assume it's accessing its own xcd

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8d8763ebe027..87a6a610e467 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -55,6 +55,14 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
 #define mmSMNAID_XCD1_MCA_SMU 0x38430400	/* SMN AID XCD1 */
 #define mmSMNXCD_XCD0_MCA_SMU 0x40430400	/* SMN XCD XCD0 */
 
+#define XCC_REG_RANGE_0_LOW  0x2000     /* XCC gfxdec0 lower Bound */
+#define XCC_REG_RANGE_0_HIGH 0x3400     /* XCC gfxdec0 upper Bound */
+#define XCC_REG_RANGE_1_LOW  0xA000     /* XCC gfxdec1 lower Bound */
+#define XCC_REG_RANGE_1_HIGH 0x10000    /* XCC gfxdec1 upper Bound */
+
+#define NORMALIZE_XCC_REG_OFFSET(offset) \
+	(offset & 0xFFFF)
+
 struct amdgpu_gfx_ras gfx_v9_4_3_ras;
 
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev);
@@ -217,9 +225,24 @@ static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
 	}
 }
 
+static uint32_t gfx_v9_4_3_normalize_xcc_reg_offset(uint32_t reg)
+{
+	uint32_t normalized_reg = NORMALIZE_XCC_REG_OFFSET(reg);
+
+	/* If it is an XCC reg, normalize the reg to keep
+	   lower 16 bits in local xcc */
+
+	if (((normalized_reg >= XCC_REG_RANGE_0_LOW) && (normalized_reg < XCC_REG_RANGE_0_HIGH)) ||
+		((normalized_reg >= XCC_REG_RANGE_1_LOW) && (normalized_reg < XCC_REG_RANGE_1_HIGH)))
+		return normalized_reg;
+	else
+		return reg;
+}
+
 static void gfx_v9_4_3_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
 				       bool wc, uint32_t reg, uint32_t val)
 {
+	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, WRITE_DATA_ENGINE_SEL(eng_sel) |
 				WRITE_DATA_DST_SEL(0) |
@@ -234,6 +257,8 @@ static void gfx_v9_4_3_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 				  uint32_t addr1, uint32_t ref, uint32_t mask,
 				  uint32_t inv)
 {
+	addr0 = gfx_v9_4_3_normalize_xcc_reg_offset(addr0);
+	addr1 = gfx_v9_4_3_normalize_xcc_reg_offset(addr1);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring,
 				 /* memory (1) or register (0) */
@@ -2725,6 +2750,8 @@ static void gfx_v9_4_3_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 {
 	struct amdgpu_device *adev = ring->adev;
 
+	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
+
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
 				(5 << 8) |	/* dst: memory */
@@ -2742,6 +2769,8 @@ static void gfx_v9_4_3_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
 {
 	uint32_t cmd = 0;
 
+	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
+
 	switch (ring->funcs->type) {
 	case AMDGPU_RING_TYPE_GFX:
 		cmd = WRITE_DATA_ENGINE_SEL(1) | WR_CONFIRM;
-- 
2.34.1

