Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F7AC3DA6D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 16:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D9010E926;
	Thu, 15 May 2025 16:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bJ0AxoOr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D66A10E915
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 16:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDzYRUFEst0NfPCA321VEg/oCfv8S6LP1NbxkfYH0WFMpWHnNrLHuCKxrglDek0c2O7Dl9eneG4n2YP3/TsgispGhlHc+AWbV64MNhHlq3fn4VQBxooqSvK01kayy3JVHT3mz1xFWdIekesEAp/wtkXf8CPauI0ptg+WV+oO7PZR18tLvFhgHZF32sPDcU8lOQoKeINZh8+7ZmsKykOSMOnZeu7Hc7L8XXLCr1wtgkCR/zP7xutjT63+ARHpVMoiqlvJJkHvW8PrUAaHoRPK6Pzt462dyy2CWuppPC8yK3aIjSJoNX4bAOi1haOItCV/DPDKt3pmE1eH5PLywyyeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxDIzTwVtUgRaanlCUvMUSQTRTaPEVGowWq4QIcxa5Y=;
 b=M4BIL7NKtorVLuIgr/8dcooZc7fj1R64hF4VI2+kElXoCN9iDyfOxH4u8R5BxLRrI1i7D/r86ooH/oyrDPka5jUVRqBpxBiivK/UivbWtSMU5pq8Mzc/sLdzslc/c0rWLCw8AiF9dd7zgKG/iKmB/TJc/Yv63xddaR3S4yHUBlVvbR9Uh2MuDDKqLqH0860Nq0zugzQLRbNWfgrhiVYn47+GPtLY+6e2rCrs49ci1/3bazVdj0W9gm5qfiKHh/k1SgSHYwDDNBAqmmA3EqRTwATm2NUPLSalzgsLnZnG6RvxsY9xsC6/218gnVM5xx0EdDomlxVgM4LG+JLMQWfRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxDIzTwVtUgRaanlCUvMUSQTRTaPEVGowWq4QIcxa5Y=;
 b=bJ0AxoOrPnED81Bpgyex9T5bj02iREqkhCAOXv8QqgQr+zhl26Fm1BaOeJ9LKaq/S+RkgExqwmN/7xpP7V8VCO4FpRX2/tbWeAxVlFrPWevBoAtWZkltmIERNdd41ab/5owDcelCpf2QiZaMSgyNzFl90vd92Hn2R3awa7O1L2o=
Received: from MN2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:208:1a0::28)
 by SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 16:41:20 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::eb) by MN2PR07CA0018.outlook.office365.com
 (2603:10b6:208:1a0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Thu,
 15 May 2025 16:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 16:41:19 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 May 2025 11:41:19 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v2 6/9] drm/amdgpu: read back register after written
Date: Thu, 15 May 2025 12:40:59 -0400
Message-ID: <20250515164102.808954-6-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515164102.808954-1-David.Wu3@amd.com>
References: <20250515164102.808954-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SJ0PR12MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c02b4f4-4fa3-47cf-dde5-08dd93cf51e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nZESUFnY45k9NM8wznjIxzwY03Qe0VC9z+VSrlP+vA+PXvsbTFekXEIddqBz?=
 =?us-ascii?Q?/elt47sZoBhJBb3Kr4nTpGjOufrAgAq5sHPdzSiCBVAopeYE2jWXqjay+Wjy?=
 =?us-ascii?Q?DUH0uwHtee/ivtvTX9//P6IwMflP8ImuyTuKqP4Y/tMN3lLovhUqzS2hegyK?=
 =?us-ascii?Q?T6ZLuGavGrOiIx4VXYaqBoK+MRp2XDxz1iLWPtwpBbQ7bgVcAed4RaFuEM/H?=
 =?us-ascii?Q?uAkmPzZytCOwABrBP08vIkx5FYDez7IyOOQoS4+3EOv4Cp9Bc45N5ZzhecI8?=
 =?us-ascii?Q?mRdQuraSJXiGMvzqjE8GCHcWFbbPFwccMZFIEJC0Ypwk1To92QIkaDIv6YFk?=
 =?us-ascii?Q?92Oe4CfISzhjBMZys3kmftuFMksVZwbKSy8mTZLtsNpcqazwBc7lebIDZEE5?=
 =?us-ascii?Q?8Oa8SGFSIvBjNjElvL5EsUPuth0o92GAhfxclIBD6Ao6Dsxg8SqrxeawQkUu?=
 =?us-ascii?Q?HC+KbQVX9ROQdezVM5zty26p4V81p/EeAi99z7s4jsVufshr//aTCnv8m1wK?=
 =?us-ascii?Q?odvyi4DLwzdri/g4egpmVc0ukGAFu0vhEJy+7wKZP2aHOIpA8QqmtIhhkNGX?=
 =?us-ascii?Q?dN1gML2LAL9R6SLucIC50xQlQJ9Uc9dOil3kuAcsTAWLsJDqQyZ9n5j629/m?=
 =?us-ascii?Q?/OWhCRNG+3hlLQcsGWdC1Xgc5ANg3Hdl/sBwoyDJtHlZgl2vtSg/WUM/VLEo?=
 =?us-ascii?Q?OaEmoTkiysPQPPcU3y/jsgtnjic0kwq8v42hLBszcF3pJ/NOxU2ZN4L21POO?=
 =?us-ascii?Q?4vJKbDsDMDfY/04L0nYZqQArmXdF6Xdw41l6wfjiZm/BTGfKc4qWjut+8VLr?=
 =?us-ascii?Q?BtbT8T4dKPXj24R3aLq38UHjmbGf/qk0I1/QepIC14H3bZ3x4CiWjYOejpon?=
 =?us-ascii?Q?4xEkeFKrRGUH9UO/dGN/wtK3nG2rciv+/yDIZzDQtAzJoUIXBxjOlL+ZlOTE?=
 =?us-ascii?Q?AfILky6Xu8w/hDLxziFGXlkhNILfb/pNWCxPtZbdD1OPDtsTc9Fj5DgmjNt6?=
 =?us-ascii?Q?fGCDzUWSw859pQvtz/3MHtzAnPpkL7ivYyjQujcnQeZjddtR0EnXyC+we2nh?=
 =?us-ascii?Q?mk/f+HPT25/HSJOClBdlZAYWZR/T9HWPurDoMrub5Qa9ZOaixj7qWOPgY+TR?=
 =?us-ascii?Q?SiYAVXNrfZ0LXrP1v5+cZ2GZlJgHcpig1A0dQMkQUixjriiPUEtY8IfaGvTr?=
 =?us-ascii?Q?SHmU7jivrWBR+UjbLprOwmyeSKY07MoBznE5xb32y9E13Gf+i8klF2pXGVhs?=
 =?us-ascii?Q?TCkYzFPLharx2pBTzrUpIj2GYzd+jWK/MBN0C1l1DZTsJE5yFE0N1hvv7awB?=
 =?us-ascii?Q?/JfhG7i9j6VsGdKHhaPmDzcp9txjIEoc2+lRrhU6/3yaDct5ECqUY5XBHvE9?=
 =?us-ascii?Q?tSM9j5a3AzmpHUmqsr031jpISHxmSHiQBOnN14lHlzGAvp0Z+FD3FTxFDjNt?=
 =?us-ascii?Q?nFi1evxI5uCbhNxT/m6IUO6vSNf7ieBzOEQt00xr+khaOqlgq2rdeDdlt9++?=
 =?us-ascii?Q?IQVPr+Q1SOjZP9eYFc/9AaPbN5WemnodUHuh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:41:19.7738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c02b4f4-4fa3-47cf-dde5-08dd93cf51e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7082
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

The addition of register read-back in VCN v4.0.3 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 712e1fba33ce..872ab1193fac 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -970,6 +970,11 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	/*resetting done, fw can check RB ring */
 	fw_shared->sq.queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -1363,6 +1368,12 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
 		 ~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -1446,6 +1457,11 @@ static int vcn_v4_0_3_stop(struct amdgpu_vcn_inst *vinst)
 	/* apply HW clock gating */
 	vcn_v4_0_3_enable_clock_gating(vinst);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 Done:
 	return 0;
 }
-- 
2.49.0

