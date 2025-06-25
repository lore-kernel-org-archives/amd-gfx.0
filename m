Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58391C83010
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC02210E820;
	Wed, 25 Jun 2025 21:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bbjw3h9K";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF73A10E803
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0EpXOu+L7BtsjzF1iF04ybbVU9nTRwNVVVYzkT6tdln3NnPMWbBPkpXwGkDWVL2KMPXbFAFfPK6vJih6T3uQyllYnfQCxOo4eu5eDBHBvINSrSHA6wqgp5qaMa9TwkR/BsMSmbxdGsSketq/+bKNmjo6+rvOpOhNyjaztONW0fWN5gQ+DY/FJgCckzk2C4ZoCWW8xHCPzOMvsmjbE4dp7ylUxZ45yVW9dZFm0ALtx3UhCYDzP8AmPUPoWZHT5/MVm4LEKjlmtFPqT31wYj9dkaD3bqTvbe9z8RJYdC4r+rMb6OmmXSk5mq7JiWxuXrCBr5naQ/JghFCVFqRSBZuxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x6ZytdluvqGYN6PJFyaufF5Z3L305Uy8gNCAFbvQ9s=;
 b=pujp1BGwEPVgnp4mxQMG29Lfoxx/vjXDMNRyL9uOTdXF3THLzKJybFZwkwp4ZnP0MQTaVQU1/DJC8S7YsJ3yX+P7QL7qWQ/7fPwSdx0eWvvuKDhC71Jr/ybtOmJIhnliGQ7Ivj75GjLfQjG/fT0pJAg7iMvxvv/1+M2dZssOANYWHL10PdZBACaKthHF9kkRXLtyJfybo05BrlG6xwLmSgWFOzXd78gw/Iwc8rYsZXO+XW981echwxpPDr8xPJNLNsmY/Woa1EcH6G103mrjV/tM3d0vSxsrhcSoCRXcOUGa6PIaJV/cIueEiAMB+OTwDPPJq/pX2wHvSZMThcoRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x6ZytdluvqGYN6PJFyaufF5Z3L305Uy8gNCAFbvQ9s=;
 b=bbjw3h9KGMx6mpumTYUfczqREjVWha5j5mI5qmOFFvdRrdIqGiY7htr2kxdwPXVQPbUEfLHmE0JVj+VZ8bwHzWmcCN/wm/GJXGd5yr4CSRT1QCMzZfAVPbDgrYO8pG4YSYSLyourjwZpKQqn/l4oY8EpZSxwiLb3DvaMomCdvHg=
Received: from MW4PR04CA0032.namprd04.prod.outlook.com (2603:10b6:303:6a::7)
 by SJ0PR12MB8613.namprd12.prod.outlook.com (2603:10b6:a03:44d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Wed, 25 Jun
 2025 21:07:12 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::9c) by MW4PR04CA0032.outlook.office365.com
 (2603:10b6:303:6a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 26/30] drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
Date: Wed, 25 Jun 2025 17:06:34 -0400
Message-ID: <20250625210638.422479-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SJ0PR12MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 723aa2e3-b6d5-4f2a-5df9-08ddb42c40cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KG6+Oh08UWQ1QVulwlksze1GL3bUfx3bT6/AhV8VQDxeQHiW6o2ZLGMxYrUn?=
 =?us-ascii?Q?ntCgHjmsxV+ecF5Vo8/rskqWNn2kUn03spM3CM2tegsBzTVmihbgsCjh2QaL?=
 =?us-ascii?Q?6bRGHEMetqAapp33t6AtqSRaI1zPmo7UgcyC0T79inyX+Iuv4D307eo7QIXE?=
 =?us-ascii?Q?OY3LIvb6gVawKNPyUUgg/4JlEBBuIV25lZE7bfolhIAfb/3hlccHadQUbJzC?=
 =?us-ascii?Q?FPnIZ3OClSBdlkNaVhzQgkDscyZt9VgiNgC4RayCyV3UtUHqWUSSVjBMLxJ0?=
 =?us-ascii?Q?WAgr/nwASWHPfTmsv3tT1+EqXpdgIyqNex3i08nz72JCzjQZczkNs5rwES34?=
 =?us-ascii?Q?3HR/XR19vKIlk47rH9rCi+nrwi4nnC2GGdj9t9kwiWa8OP/dR5oPx2RG47k7?=
 =?us-ascii?Q?WbahRYG0HAT6j9BaPkxRP2/fm6KXxDaY3BTei7IyfP2NF39Ohn9f9Y6V4JGl?=
 =?us-ascii?Q?uuamaIg7u62zYNvjtqZtWrS3DijaexhzkyAl5195Q7QuSVVc03y7jD8nvYre?=
 =?us-ascii?Q?iReN53oh/4eTBuV0EelvNHweuxGESFpg0sBdWAVFuPpzlP+b1PQg3fSbstlP?=
 =?us-ascii?Q?Vkzfqdfz7HkDgrtpXNQD2CBBp1eouC2kZi0PR5pfwMbvYAqIRVuSE3IrHXUB?=
 =?us-ascii?Q?TlcIrS5NtwFR+XCDznqK1uHiIH7HGSl7qmwVuw/lhNBsGhtp5ci9Ngv2wxJP?=
 =?us-ascii?Q?c3AA5jmwMiEvuEFxq9tudTXqz0TZ0tgSWXOKBmj2FiMIWWQOlumKqZ+PELGv?=
 =?us-ascii?Q?UVfDylTrAhrvsoM0HGraIwZZkIyq+vQyITH3+5f1gjzsKcC4ffusNeMuMnOM?=
 =?us-ascii?Q?z7mjI/F/r08WBvWCnegEgE8Jz+/I7WDu5kqpnrKKNZAht80axNBqefSCLbSt?=
 =?us-ascii?Q?jLf8VcEi9pTepNqC2OI4Is++IruI7AFGeXhv4yXSIkK9HZMrzgixQ6iglIuT?=
 =?us-ascii?Q?Fa/2c3ygJMzixXcODx3bpgJvyT2nLCo5uTjN+l3cLZrWHbQrhVDK42yBRJCL?=
 =?us-ascii?Q?XgBRxZ9ZS6GwNxxbIDBwC2NcVW5UfNrkTkeIZzmTp86UqxLMnqROLnRnIOe1?=
 =?us-ascii?Q?ePK8DFqWKfSLtzCYiB9WLSmcWT3/VvOn+GyXJ6nblEeM0ctEFzTLSxgP2+XX?=
 =?us-ascii?Q?ESrwgET5Dzqy6buMBSGP0WEX4ogTgW2CjQ/gBXGmalcmw53YbPW0YkPgO/iy?=
 =?us-ascii?Q?/h0yOsUjY4LlzhLi9e44fqsIyZUli9PZeK0CIfXBxe6U88XiUQNnroSeES8j?=
 =?us-ascii?Q?R8iGFCpWfu4YHpQlPCCz7R01xqc/qBqDJYnQ+IOS99V7GUcxoHwOdxEFOoQu?=
 =?us-ascii?Q?ZahVDceAUbJis27LjB7zAut/9PD6J+x4ie9ZE+NrmNG2Y8Foh+BMvW4XMVUC?=
 =?us-ascii?Q?+i3rvag7sJHQjiIkux5YYNqgEZ8uCGUGhSZjUHCq0SQtwXKIsGYifaAq8iTj?=
 =?us-ascii?Q?cVv3WDD1B4UhA+nc1pVAjxv10qWiSwE/og5DblP+lMORcbx88nR+hLaBzJWS?=
 =?us-ascii?Q?21ukobDuPQ4iAlOeYm4/jTyraXfOQNPLZ3EL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:11.4027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 723aa2e3-b6d5-4f2a-5df9-08ddb42c40cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8613
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
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 47c0bcc9e7d80..5997927ac6db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1198,21 +1198,14 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
-- 
2.50.0

