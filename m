Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2C5C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 19:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F259410E34D;
	Wed,  5 Jun 2024 19:24:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IplzL9fa";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD35710E34D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 19:24:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEccj3a8Gak3315ixvUDehk664FmH/Gm33xR2nndNYNixfOrm54E/xJ5dLvupwofWUQNDzjOwV5UnhMqSTDsEzc+IaVX4gQ3oGRh0xQ1a73lmiaVu9un0Sz6LjkoXy9IkY/tnVbl7be70nTRiZldXpuOdqc08q7DrsAG8kZI4EOjceeJYR05P9T5aS30Hi4+dZx4vsrmpSpXGbSijXblnkas0DiQvrajxch2FXWfPQZgcb0Ep4QFDAxYUcT2XOTwYNoQqSemI4M7nSlotjcVT9WAKwyqUJ2HfJyM1t/wMiZOeiIn5uvhyCEqZzrDy6Xng2aiXDVlPT40qL0X4WuSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Axl62/nXwQizhoshp0Ku27LEwni3iYNa9e2Bx63JHn8=;
 b=VO0FfRwybm0c3XbCIYiDSdyhkE3vsEHuZ/tCGGDl9Tf07dBstHZGERgt+JDJ3juILPmfZ6wInCEiHHxAZrDYPW5XcWvyiUTPuOHWKbQH7bvN/hoMybQJh3UrttHfj/HdNaJAVXL3YcWfpyHNYvl4yhNfNTw6rWUErsjUxe7mEP7gnf9rtMsPVVKWS4MfYRQ0Dqw4INbdBhEtEl15DveK4/+49tc1StRomBcphqkM/tAJxhhWG4jX46T2kp9mWjaWFh0lgOOJbT/5HEhkD2VjFujXvxJCDNx8rSxZKGNJDaBn8QJbWJBDlAPpw6nv5wWkB3vqcI+ajFePazQz14TqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Axl62/nXwQizhoshp0Ku27LEwni3iYNa9e2Bx63JHn8=;
 b=IplzL9faWy8AKeju8vUyWqa4R4gwCI71k9Ra85iQZnonrEHBSH90SKp9ILrUM/Wr6Vzp1ecjfdTVdNGobV8fy9wI9tCwsvWbyZhKnR0ysv9w9PUZDslBYZSGjivHteyC6b3V06jf7yWdYj0722cXRPFc93o5rL2kbxxtYR94RkE=
Received: from BY3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:254::17)
 by MW4PR12MB7381.namprd12.prod.outlook.com (2603:10b6:303:223::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 19:24:39 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::d3) by BY3PR05CA0012.outlook.office365.com
 (2603:10b6:a03:254::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Wed, 5 Jun 2024 19:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 19:24:39 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 5 Jun 2024 14:24:38 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <sourabh.betigeri@amd.com>,
 <joseph.greathouse@amd.com>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: Indicate CU havest info to CP
Date: Wed, 5 Jun 2024 15:24:23 -0400
Message-ID: <20240605192423.415988-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|MW4PR12MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8203a5-f617-452d-b430-08dc859524d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wR8fBir0KiNoamgs2w8oJjGSB5/95ambWCbqI2mmtBBSB6gpoNTMQGe4Oj4j?=
 =?us-ascii?Q?vPTMk/j9ES2NBW45yR72IXdGd9KU95z9llrLrvsK8FrvUs5YQPCe3hGj8cg1?=
 =?us-ascii?Q?lNyrYnAvZ5j2SEKclf9cPH94KYYboA9HNsRtjnS7mVHqROTj8Tec1xA4JeYc?=
 =?us-ascii?Q?QaD6yYzGBQfkJOHZN0HSFhcyv6V80A9poLZYZ4sd+6ppP8O3BvSqUL/T40R3?=
 =?us-ascii?Q?7lWZVHFnn1lXa1kpYOV1AflBOjaIPQntu3g4f51xg6LDuV010AAGtw8lvRfh?=
 =?us-ascii?Q?ZMmaC17N7X7t5kweqGo3wr8aC4OdXQ3HMJacjrYEVZf5C1RBYboNS2b1FuV/?=
 =?us-ascii?Q?hpPyDXZlo+NSpLHjBe8hSEyt56/bTw5kAVmVlZjjvJuS+9/MkioodM+xEzCw?=
 =?us-ascii?Q?Gfee7lMI8I0PS34ey8buSWE/IyinL4qbkuRhRKrqKWVi8mNmwMLGKEzMHIKE?=
 =?us-ascii?Q?ZM3wXa9QtFPPA232imd16Ro/cNyuci/xTQUQoSfjHqIQuGQRGuI0mIOh4e+n?=
 =?us-ascii?Q?w+VFYumxjQz8ELi5yEo8jLoBnljdYGUcdnMoFkLyhpygd5ZiwTYqhUPG4QZO?=
 =?us-ascii?Q?3kqsKHapDJRngkV8bA+BRyPl6Ya3D5gutipXUds6GTfUYIvaiwYNaiqlxcGL?=
 =?us-ascii?Q?y6tExZCFqHig4yS8llizLEAQkk7YamltdmN6/eC5f3yd6rWkV+nof1qPOu8y?=
 =?us-ascii?Q?RFNCcGjcgS1vIe7OaT3gfeqNwDPPptXkUgOwP7HEis3DMJJnIroA7LobtiMA?=
 =?us-ascii?Q?/JAWtM1pMJtTWjDOBX7g65UzAbBQMejCkEsO6WFNyRZZ8OlPjPUyJsLiS9St?=
 =?us-ascii?Q?tatbQpygTCBzp1fXfOdlDSqOVhBw24sZ7Zg/5F0XMV1DJuxygxYI8vlK+zeP?=
 =?us-ascii?Q?jDdqctgiWZxU+bLOr5Hvb+5BgM8U3XLmMonvYww5H70K5TWt7ZLdIp9XElYm?=
 =?us-ascii?Q?khAf5mVpyH0I43pskutDfDYwW0oBenfF2kmR5RveaIyXIByds5ry7aNuOdFY?=
 =?us-ascii?Q?dwMqV+189LscLBmWOaAV6hyJSbewgIGupXGvLDjrYqUEnSB+te86/prrJGeZ?=
 =?us-ascii?Q?hr9XjzEBCTv5ZmeTqeYSae4uq5rlM+Io9cm5zyUznLnEcCxhnAqOVyoZYloI?=
 =?us-ascii?Q?pTUTzSIj9rrVS2S6rxaSfh2it3xe1a1AeT4KL4fHfG6heUJAFMTXli81f+tQ?=
 =?us-ascii?Q?S7F9Xd0CzTZaKYq/tr8C3kvvuOX+XLulBBzKMUtWAYtPY4w0KYYfed4kmbRw?=
 =?us-ascii?Q?ZGMxiY7YwOo2qamE3MwajVfk5V/a+6nbdCoSlHM04GXw2tINwec8l4t/29vu?=
 =?us-ascii?Q?xBCy+TT8lbcTMEUvH1HLgJBTzzfngOXKBXobFtRnoeJWX+i7MVf81PICGsZ7?=
 =?us-ascii?Q?rbWE1AM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 19:24:39.2171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8203a5-f617-452d-b430-08dc859524d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7381
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

To achieve full occupancy CP hardware needs to know if CUs in SE are
symmetrically or asymmetrically harvested

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index aecc2bcea145..651995292aaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4203,9 +4203,10 @@ static u32 gfx_v9_4_3_get_cu_active_bitmap(struct amdgpu_device *adev, int xcc_i
 static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info)
 {
-	int i, j, k, counter, xcc_id, active_cu_number = 0;
-	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0;
+	int i, j, k, prev_counter, counter, xcc_id, active_cu_number = 0;
+	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0, tmp;
 	unsigned disable_masks[4 * 4];
+	bool is_symmetric_cus = true;
 
 	if (!adev || !cu_info)
 		return -EINVAL;
@@ -4250,6 +4251,15 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 					ao_cu_mask |= (ao_bitmap << (i * 16 + j * 8));
 				cu_info->ao_cu_bitmap[i][j] = ao_bitmap;
 			}
+			if (i && is_symmetric_cus && prev_counter != counter)
+				is_symmetric_cus = false;
+			prev_counter = counter;
+		}
+		if (is_symmetric_cus) {
+			tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_DEBUG);
+			tmp = REG_SET_FIELD(tmp, CP_CPC_DEBUG, CPC_HARVESTING_RELAUNCH_DISABLE, 1);
+			tmp = REG_SET_FIELD(tmp, CP_CPC_DEBUG, CPC_HARVESTING_DISPATCH_DISABLE, 1);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_DEBUG, tmp);
 		}
 		gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
 					    xcc_id);
-- 
2.34.1

