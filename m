Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E7DC3ABC9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 16:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C8210E927;
	Thu, 15 May 2025 16:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uWOcF/4G";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 852A110E916
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 16:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUPrJihgvG3zqp3UhrKLKshtBMX6u6hy6EarDQ3lPU6GUQpW5drXiy3a20eO7kr3LNMfVzksakl7MZKK0IpupB5sjvmSu+fFBkKWw7Ux1iRmVwKqO9PYyyJ/NKFj5lhlg6IMr9Ob8tIXsCsQ11s7U+0chpujoRRnNEtV+mEnW71R/aS9roN/wmARCv65mDKa2W5A9TZTj0cOUGcSxZa5bqXYEiSeVp+X8cpp8rL24ZinI3Z9BJEbANbpPoP4va21b7LQDHCHisqzDtqS6VBik2Zp9KpRel0/3jx2L3E1JgQS3KhKE1O4qVwO/rLMtSJoJW+iqytLs1UiVHcnM7byZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88mBkpYHoYLJrwpc2GAjnmFx+HDR1Q5ro4IELEhsJb0=;
 b=Fat48C/wPsp/YgAy9Q7tp4PH62oRjDIWiOOw/j+/p0zp4wq6JrA4R5iNudmk0R0cHYZUJRSKFJXq7ENWk+Bp0hw3Kt0YpIyOojcVgSBUKfgE1PIYwFGWsgNywrk7sjxA/46QMR+9rgTTkBDHJJZgKexTa/X/QqknXyqCM/AxzOzQil+oI1VPIK2VCjsJ8e2USEN7O3FL1vWNi3CbRp4rKzIgcocqkaaho4C9cx1OGnoaMMHUvGRYojAEe/YQvQU3mgDL1v33Qm/06DC4+nqQIh9sx2sfmQJOh1rYeEyL/YehhDV/0so0ZxelHsV5tmw4VeW/IueCRX/z/vKVAKheaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88mBkpYHoYLJrwpc2GAjnmFx+HDR1Q5ro4IELEhsJb0=;
 b=uWOcF/4GOXaZVcL4Cw4NSJjIc1gNvW29oh3bD5Vp+hW4P76nhuHT/mL49Dw7MfGr/mwtbFI9uWQBbyEud0nkzGHTpwVSZY3h9Y6SFuaPqbSNPHpUAOKCwBF02V/5n5CeSoHsLuvFHfW7SEdwnT04GXbQwQFIXuI4A1wO5YdKxac=
Received: from MN2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:208:1a0::31)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 16:41:21 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::3e) by MN2PR07CA0021.outlook.office365.com
 (2603:10b6:208:1a0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Thu,
 15 May 2025 16:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 16:41:20 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 May 2025 11:41:19 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v2 7/9] drm/amdgpu: read back register after written
Date: Thu, 15 May 2025 12:41:00 -0400
Message-ID: <20250515164102.808954-7-David.Wu3@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 613a36a8-48c0-4a77-07d6-08dd93cf5294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Shht3zWfLe8lqXCBcor+1MQTZAQQm0EiN7Vo77Zs/BQZFQSgWxk0Anh/odxM?=
 =?us-ascii?Q?u0PpcXTuUUUbiVLX201xOcW+4A8Htr7ZA9G0QM9ZjrB7C+HnnHT51Nh+L/j1?=
 =?us-ascii?Q?8rbSLIi6dQcRFfKRHq0ODFeLuCQ7F9ODcQq1uzY5NNTP8glmryg50xp2kowF?=
 =?us-ascii?Q?DfzjFbxuQe15e1CTM2CummzdpO0WQetJTvg4zSfolb9f16FziiWb1MJhq5MW?=
 =?us-ascii?Q?riZ9uJ2g58FNF9NmerjDGilrdoPhUHYvinR2x/nvCpn7mV3HKCR0dDtppgq0?=
 =?us-ascii?Q?pkxh6vm+INPBfY8vXXhle7B1RoPmKLDLFi+7plgub/4itKWJK5I0WPBRGj9s?=
 =?us-ascii?Q?MGqzoEUyOeSBXjoLsJnAEf/OCZjXHqZLz0juu/5JaAKCnfvrp+gHwZcwFeFZ?=
 =?us-ascii?Q?YXNYAAr+k5sNgAcRQS8MUeYAk0v+SlcOSZbBjbm3bOdtijrSx4kGzyhiFCcy?=
 =?us-ascii?Q?HaG/fhNfCZQLKJob6OWeaHPFTbXDvH5TVdKXoDGJVvhqRxiJQlHOJGaOQqH5?=
 =?us-ascii?Q?/XZE21c0KTXp/7B0vwqrvBYZCaJPGfgTJr3BkHfiPv+yLAZOFYzJSszkKkxY?=
 =?us-ascii?Q?lCcJ5RgkDk6kOQlxsFrJLmiA+cTLjxS1vUMNZOaEhOSPj8gT2eqm7YyD6XKf?=
 =?us-ascii?Q?R0T2CbMCBzOlJxdhOZb+tKqUnmlMbHZxkCJMym2jQEPoRkSzEB910Ho7SLfY?=
 =?us-ascii?Q?0dey24rFHyRAjuMSKHKcezocdjquw1ZrsrrJC0uTXP6cQdyirMKFhMKaoMBr?=
 =?us-ascii?Q?oNrhMt3DyEAQd9X0/xYhKriHyNOHByhctkNjVgKJlZ7LzFe7bt9biSdddTwz?=
 =?us-ascii?Q?lExQnDGo+zQSAmf8AxgDHVEeViu8SHvxyCrPwdAQTfqxztehgNXkzGHf/x5v?=
 =?us-ascii?Q?hqOzL6MkhPbtqdUZyqJkJaNmWrIbLdND0n1zctRYWo09zYxediTDKg58d5ft?=
 =?us-ascii?Q?ltekcO9prmKaAveYLu1tlebVF1MNJNoYCJS1sXnXqaAf7jZQ8LfQ1TTCNcUP?=
 =?us-ascii?Q?Y/Vn0jCmS30ZBZfPCsNCaF0e5EC1LOqvgyT8pZm+108QuZY27MIzIfyT8qre?=
 =?us-ascii?Q?PQjNGqYqMjUhN3gq2zzdoOrrASMr4jbQlYV6r1KapSZYULwAxTp9xdvASuWT?=
 =?us-ascii?Q?7oeLr1bRESJ5hJpsUMNBVb078rxaygwn8kOsAMSgP2/Ah0jlr59w5aHxvixH?=
 =?us-ascii?Q?qUPHUVXqemtmhn/+/ldw9myXfoi6NjmH5rjEZCLCgV45mKgynqXufT6nNLER?=
 =?us-ascii?Q?tAHa35EMcSNRJVEKRfiT8PZNlnae6UPaZ7b/2D7ocxQdO+g0mgFpyOZcvzXA?=
 =?us-ascii?Q?wsAC6OlT9dC0KET//EozIO22WsTmthemJUUN3jrihaZAhZaWhEu8P/H5y0Lp?=
 =?us-ascii?Q?wBW3JwCjRZwzpKcbQ0IkpRS+oVXppFredoWwHewwa/2wuFagr9ndFKSeQMws?=
 =?us-ascii?Q?VVjJlwYJoqgzlRLB4ssxKntOFXj/t/kkIY/thglS5CaV9faS4akQ3RwmoBiS?=
 =?us-ascii?Q?HwldeVRuBxCmIpp6MQpusSw5cb6DkG4es+JF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:41:20.9002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 613a36a8-48c0-4a77-07d6-08dd93cf5294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303
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

The addition of register read-back in VCN v4.0.5 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index a09f9a2dd471..46dced751249 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1034,9 +1034,10 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
 
-	/* Keeping one read-back to ensure all register writes are done, otherwise
-	 * it may introduce race conditions */
-	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, regUVD_STATUS);
 
 	return 0;
 }
@@ -1220,9 +1221,10 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
 	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
-	/* Keeping one read-back to ensure all register writes are done, otherwise
-	 * it may introduce race conditions */
-	RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, regUVD_STATUS);
 
 	return 0;
 }
@@ -1254,6 +1256,11 @@ static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 0,
 		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, regUVD_STATUS);
 }
 
 /**
@@ -1337,6 +1344,11 @@ static int vcn_v4_0_5_stop(struct amdgpu_vcn_inst *vinst)
 	/* enable VCN power gating */
 	vcn_v4_0_5_enable_static_power_gating(vinst);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, regUVD_STATUS);
+
 done:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
-- 
2.49.0

