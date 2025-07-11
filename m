Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44854C83F1B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59CB10EAFB;
	Fri, 11 Jul 2025 22:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="txA/4xGf";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF4810EAF9
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFIfRjUihlVkefyWdAbDhO53UB9xsrzkW7RDGGKLNNGqKq0osdYsvLfzGxItZKg9JoLzWTAs/aBaCq+ZLBEB3NtYuKq6A0xHqcVsyPtPH69ydDcgAfUJz7ocTT5coWbj1MLgDZGAn91JxvUEFwdazZuehxyS/lwj23kXGPKS3GrerN5fRhpow/UNZaIPv9K/DcDfnWtNeUGeSuSGzoOKt4yK0xnz/aWghkOCGZF0ic9+vgAo8Oj3CmnqtiAxAyqTeWXQXXPYOZr3S38yfThJb93Chl2uVaf1fZcLUFz7G4rSpKItEuSBl9H6iFSxls3SRaEuSoLOJPgzYVXMAdEcEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3/pbIgpPGchOnymbkcc99Ow5ITUhhWBa5uaVPNniCM=;
 b=puCgHCs+un/SOrKWVhcpY2IhobcXqp0NiGv4X2ILzfOj7KCaVPzHdw/i60UnLnDnldvAVGjoci6/W2E64FoGMarIaN8QCqm6S7m94ooLbj5eng7oVT26zRJJbACj9nxT7g0RGlUHQYqdjqxPEmAKVZFzyiWGYJ7zr8AEFrp94GUiQhAwpA5WDBrmgNeOqEEIWfOGj3v4xjjwObWm3Muv2UY70ct819VWzXwhbdsRb9HKuA7Hu2PMz9rmQHjcZfKvTQpjJ3Qql2XphhkttlNp9+GapM9K+h+q65rfabfgAaE/4GFrrv8r3yqKzo1akAsHxUjOb26EOytt0sfUC3SPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3/pbIgpPGchOnymbkcc99Ow5ITUhhWBa5uaVPNniCM=;
 b=txA/4xGfw2KI16FHzNFbUe9Z+II77Mv0iOiNKJWfwmufI1bou4FA24G54bMLkv8bY6WxVRsnTH5GMKP4kfXyLtSdHp8sEmXgXwmaZVrg39FfxHITsADV4CcNP+Qrkj+rZ/w9U8Ht7cemIu50Tfw+YL4sSL5C+cR843r4dZAXvRM=
Received: from SJ0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:a03:39f::35)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 22:40:55 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::68) by SJ0PR03CA0240.outlook.office365.com
 (2603:10b6:a03:39f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 22:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 25/33] drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:16 -0400
Message-ID: <20250711224024.410506-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 6597bec3-baa0-4858-0492-08ddc0cbff42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ivOdj5PyGB9n2AfVhhfAOv96Ugdf1YFDGE4dZb6NmgmT5oKL8JtkgIdE+dVd?=
 =?us-ascii?Q?4pmlKYaUxuo8azlZJTp52S0VhpARI+8Rt5RAhkmObw8ZbrA3gIpuTBaUZPxI?=
 =?us-ascii?Q?6xZIdO3DTp1pl7Ezsfjk0MztbCz71zENb2od1g8IMoz1BiKAYGBemkzP3dCg?=
 =?us-ascii?Q?bLYos+qSlE///oe1mWYnraMBjOmHzJC8oJELcumT4dcmRMY4R8pR9OJSKem6?=
 =?us-ascii?Q?JE7I0PF1DJdGlrAOkFkkzhKb5Miugxj5QA6pbuAB/Z1z002Tjq/E7Z1FztBu?=
 =?us-ascii?Q?VlkcPlzrInY8S7S0yeIN1lLTL7Gt/BFeYW1a/LfkcMo6EGQ5ON+Ptxb1Asss?=
 =?us-ascii?Q?15ipHJibEFJ6UpXLLtqXE0cO150MzIIg3KPWZpeDqE8oQ/fAT2XIUYJbxpdS?=
 =?us-ascii?Q?CmmaxrWtYh71apkNhzaeGHYQJfufAsXRpjrTA2Jo0Jg69nPuiXufw7tdrFpn?=
 =?us-ascii?Q?xUFB3VrZ7t0HiQxe3kbUOu686pbU8PkddMeirMzgAmDe+PHmRlV6uoimHes5?=
 =?us-ascii?Q?XXctkuy2KuiCsWnRa8x/1vDOC7dRS4JPeE1Ao9yNlFP6YkIKly0lQhxndlbi?=
 =?us-ascii?Q?6fVunGg2YnpZlc2uO8BGtXmE/0PW6bsXqEDHSWlUKHm+H7jy3IlBLihO+q4W?=
 =?us-ascii?Q?cnok2yxK2dVCuLGSPsmIiEqON9aAswlwp8aFkNTMSei5jO/sPma97QbHAIFh?=
 =?us-ascii?Q?WcqWb6GkW4K1rgIHzC3dJC7zDD9XMZX25BNOxwBqxZXK1MGMe/IOby3Xqaam?=
 =?us-ascii?Q?XRuVPM77fhEDARfQAwFxelvWTi4Uw6McVy32uohVbFKwYPmxE8gbefeCfYbt?=
 =?us-ascii?Q?CLKMDMFD4IrV01AZBVxp5RQ8J/AyyI+HBcosDC8Ny3ceIwb2KOo9a+L5KQB9?=
 =?us-ascii?Q?UdiY3C+c1AaQZNA/Qi6VRZRv1FUMkoc4XwgE9TdrkUMsfa3l8D1oa6fAW1/w?=
 =?us-ascii?Q?OZHOKySJEII0Lqa2JfrnGo24jyrAvI5ztkdeDEkTM/eCz8WpcVsgd3rpLmt8?=
 =?us-ascii?Q?sfA1IYvj4wLcWXZzG30eC8Z+aDlU8y8hiqDv1BjEPXhcxOQ6/82Ow42ZzaJe?=
 =?us-ascii?Q?53vdLubhqMkXQGsbzcFtAoaL0FwcVjVjHqpl1hnBMpWBMDBdHBU6WcX6bdZ5?=
 =?us-ascii?Q?ONXJUNzafpQ72iyuL/UBRQ++/byu2rE32HxLE+Xo37ZGe/3DWG0Nzic8NS/C?=
 =?us-ascii?Q?aXZMsXlMt68TzBvYWP45fFdA5bB0/L151A/QQhRaUk6KwKhDbBvj+BYYaeXq?=
 =?us-ascii?Q?Zn4z6VyU3rL/W468yNsdzaHGDC8x1J1XfmZBGOi0r+Hd8G9GA0fQWjfR773t?=
 =?us-ascii?Q?3pu8LchNNK0Bv24HCTajuuCYibH+USLE9Hb8T4GqoKHeRNFSM7geT8Pc+Ccy?=
 =?us-ascii?Q?gplo76zqpyUIQvkKpXZ5o1jWGM41TT+KSvjolThqTTNUAKjWM0hCJbMY1aTo?=
 =?us-ascii?Q?RiWfr/qXGQ4sJl1MrrAXSNVCDvRB2q8Hfq2KPMyE2+4hPdRryFbCmNDJlrN8?=
 =?us-ascii?Q?W6Ds15JczrMQ9KHxpiKFH5TjgG7ojf/Q12Tw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:54.8994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6597bec3-baa0-4858-0492-08ddc0cbff42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 6f8a16da9d608..5473cbaa5c0e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -838,20 +838,13 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
-- 
2.50.0

