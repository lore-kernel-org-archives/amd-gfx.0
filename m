Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7793AC3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2524110E894;
	Thu, 18 Jul 2024 14:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YXm/69xH";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2386710E894
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeUwPgpJ5RTvZe5ZZc7Mc6dPKqojJjbSSeuGJ8zC6nJYXpzuN21w3GM/4KTLGn+tCWRtWEM8DmjgzI6pKVUqzznIFm5af1182Xh1YiN8K6mec+5IsNfds3KgqPYCXhlm5C61vXLUNVlIqs9JorzjS2OMgQoTLnZGAJhC37/bttW3iI07Um4Fzt44BOE5hCD7fgPOIRs+r8Fu6njFJ4G5Orn67ULdYCd/yrZQCbGb5w9ig9hNc/m4QUKcJ4o/inm/tIuDWRV6JuwDJWypgxFqodAU0HJ3PpO/FJpf5n5Im3shIg2URbx5HvUJx4V1sGpqRMsHSTE34CPI1WWg6xmv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjBXO8MgUzMvLjBxU3AoeGn59pcqDb1dc/nx6alJFpM=;
 b=BdyNJC6ATHwQCRMCX6kTIlO0w/DGbDxkcl63h5dTZZ8AN/K46aYX7FTRFrnVOCyERY1+z+aGmjyFC6N3WbSRDQevSln+aPeV+mx0FdSb50rPXDRSYGq3DX5f7bK4JtRPQ06EZIJu//zbrfFOjJdrA0ZMHM/89gj9ma1FGAof+Q+WLWP3mULCA5SY5xtKtgak9xfjtoDb5UB4OXkmzKo2+xUa23OgVCsEHg0DKc0S9spwJlyhl7JsXg2HpD6ZJb4D0Bf4cqsnmkH0EJk11vd7FA8QEiY5Y3oBqTQxMnrjbo2VOUFIbpf1MmFVJ0JitNbr+yhQ6nbPxQfFP1zHM1Xcmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjBXO8MgUzMvLjBxU3AoeGn59pcqDb1dc/nx6alJFpM=;
 b=YXm/69xH8rOPiUc3VWRV+b53qws4XFbcjEs1LtUDDvBm/HlAWFI8WFB+Jm4R3Gob/jFxSvfWsjsl1mSI6ygo4Emp6rSXpBpSWHOSEf0GXn/TgAdFYWeCeO/Fi1JEw2tLNCJUx7qXPQc152iEBBugkHEm4Eodfa25jHOSa+GxeHI=
Received: from DM6PR04CA0017.namprd04.prod.outlook.com (2603:10b6:5:334::22)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Thu, 18 Jul
 2024 14:00:30 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::9d) by DM6PR04CA0017.outlook.office365.com
 (2603:10b6:5:334::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 14:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:00:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:00:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: handle second gfx pipe
Date: Thu, 18 Jul 2024 10:00:11 -0400
Message-ID: <20240718140011.1727562-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: ad68f8e5-5119-46a2-dc74-08dca731fc26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?meYnZl9/YASabhuochnpMaaGpXW6XxJi0EuJgEFyHdNRlEAKdnYLmZ4TqdGj?=
 =?us-ascii?Q?0KvtI9v055V2Cjo7+Y7/MD2/hqYheIszEl2HH8m+u8wdZ1nE2NBytNBq2D6I?=
 =?us-ascii?Q?cXuAayVBLiLVnJmShxL34nkewZnAfTmz8kO2NkU5ANiS59BXaF5yCUC2gSOc?=
 =?us-ascii?Q?cFQYCuqz0C45VmLyqj3hyYRDoU6KLu5WzAu7j3IVysLVKRWPmUm4gRoWV22z?=
 =?us-ascii?Q?Kk0andz+wMRLxxyWZ/tgkxEy/xYZD0V1Z5c+MPKffIiPoSX2E4UWyhcTBCGU?=
 =?us-ascii?Q?euiuHJVTn9L3RIaa7VRa9B46mzFLaGvh9s4D2e5dTTIO169vVmTwh9uAB4Eq?=
 =?us-ascii?Q?Fvjwvi9A7PVrb9LESgaPoD6YH+CVf729MyZ5khl5qC2NOjIZiCffvcWQ788e?=
 =?us-ascii?Q?g6bFnyStS3WpJz6noKyyBtnw4oM9YAPOIpfUkT9MYN6KxSdvTatbGt3P0fva?=
 =?us-ascii?Q?TbMeTrtPdkjmS5u4Y7TfeqIfHads2LrDh/NxEWgermuOH770LAbUqwX9Xk2Z?=
 =?us-ascii?Q?C2aN5nSSMpkvuKrAuWQDi7CQTCDDjk0UEAl/v6Y49HR1ODjxcQq3Zf/SAI8D?=
 =?us-ascii?Q?rDRWK4gk75d1Q/cZsDkMOszudox6BF5nGcYdMoCOkTXq2mzoWA8g3XTN/7L/?=
 =?us-ascii?Q?w0LvyDH36CwO4JPtUJq5QX1p8RwKj3gOG19wtC08R5bIlbwVjvJ7cMySbxLm?=
 =?us-ascii?Q?7Clm6FpuvgK3nfl/lrVx9dAQOKqU7WgZ0tlUbApCR6fDqH0gb/R2K8WeVAgR?=
 =?us-ascii?Q?lqWmfkOxt0vgjSW3QjmMa40cb4XUY0uYqrrRMdcPGEukGdsBzZ/WxUb74X0L?=
 =?us-ascii?Q?n/J/6O9Ihhh3SArASt13X4+rdRnwUddqq8rbSGR71qnbxqIV2RnAhoFRRGYd?=
 =?us-ascii?Q?952O6AyW0lKaGGanQKbN45Z0YgR9tSyuioQBUTO/CU60OU5AXGmH1gGNJXOH?=
 =?us-ascii?Q?hV0sMQ6zLADqKS6apl5qncwr+5If3Q1+oqB6qDEA88SnbsskexAueKn8hbby?=
 =?us-ascii?Q?bZsdpQUurT5cQQq3NOkWjwrwowxClny9xl49M+zNeDoNFmLLKvwnzmLc6ass?=
 =?us-ascii?Q?KebFmv3uuoEgAZOMX6QVloWMh9n2B659s+Ub44p0lEtcTqvrzA+12vkN2b2d?=
 =?us-ascii?Q?kalcfLtsmR4CiuvSCFHvccizQtvUDP7S8VRAROZ8mXL62zkXFDyx3E1pGJvC?=
 =?us-ascii?Q?gg4XgdKBbU4VhEYXCDDtX9mhOLRfpSADPjmBHNTDvq9lI2gf37NS2rykztkS?=
 =?us-ascii?Q?lkQUibbjsNil2c+ckqdYMJLMDLfMJ1OK91PKSp1KzNrsURm/m+xXc+tzNOFA?=
 =?us-ascii?Q?r6nhLx2vPCqEq0X9qT6iWCLzPRZ0o3eyk6cIAOjmzYa84PArNMQxf11cm5iK?=
 =?us-ascii?Q?J/SbUIrt74LCyUCwYnMM6TMMezYNPfisyD77GwCqhI7XRu5j4nujIlKfbIRN?=
 =?us-ascii?Q?aXAP744uNQwoh5IMqL9f53ol9qatHAZP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:00:30.4315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad68f8e5-5119-46a2-dc74-08dca731fc26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
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

Handle the second pipe in mes_v11_0_set_hw_resources().

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 8ce51b9236c1..27d54ec82208 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -544,6 +544,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	mes_set_hw_res_pkt.second_gfx_pipe_enabled =
+		(adev->gfx.me.num_pipe_per_me > 1);
 	if (amdgpu_mes_log_enable) {
 		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
 		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =
-- 
2.45.2

