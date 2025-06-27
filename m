Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA11C8302A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D26DC10E959;
	Fri, 27 Jun 2025 03:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dO7n1sz2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA9810E944
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXZsntm/zFGtNbiQ3E4dDH3C2Cxo1c22WgxkCOmCFdaO2XyA6q8GtKoDRIPLmC24jlnVTf5jfO5LVP89DQaq48JsVo56n8GzP3eFyk120Qz72/PyCZvFXw8w8qjCDHPhNbNoB91iVOaSKFD3zwv+tZ1boFp8xedUb7sTM8tYJ76tdNmTeQyCOTvuqUWpiduVGXkw8PGbSlWTToOmGGHJ2G7sNM5jgKpNES01B6Vrg2Cq1Kdc71rqPAN1HOHLFdXM2dHOjKn+dgnBP00+KHvz/+XG1CgrLGsmNjpGPl7ydgrfx4ch8Gpt7VknY26XHyfxr7muTKh6Eft6S6M46gujww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3/pbIgpPGchOnymbkcc99Ow5ITUhhWBa5uaVPNniCM=;
 b=tb5Q8bbSeQeYTQUc6Cl7HXxePywU4QJKMV0IEvgwAD3xHXUEK5plh5v205U52UydPhCZwgzKvviB/COq0G3+Zfd0jXOdUflToQdd7fGi3PPPcxaL/nZINXljzO7YflbAYGXbGSikLMqwq16quTqNlMBl5wjVy92QleTXoNJI1+PIXI06lUbqFjMn+g9wI5qWaI/82pvBEHgVsazC2PYy8nJEkXjWctrulLpSWy9cl0OvGOPaIKUuZJH7ixIddOSeobpfLh/FvGYxbIdrEuUGGDT5O1u/6tyhFvKA9OgGWUpwROMET1iFXbXFz0wUfruDYjfDv1tpadyUQ6sfAlEl9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3/pbIgpPGchOnymbkcc99Ow5ITUhhWBa5uaVPNniCM=;
 b=dO7n1sz2AadQx3ag7OeHL+oVeHKHCRMIcm6iGsQK3q3Zb+jFBbeIB0O0EvRqDnHOEL1P8YgeLLABenyV7Qfdi8iPt/kDWcxvp6VGS48sLcME1depX0gl0eOsJqNjDuhFY3UJXweASLtvmnIv69elpZdBoVJQDuu9c6TQ4fT/vDo=
Received: from BL1PR13CA0182.namprd13.prod.outlook.com (2603:10b6:208:2be::7)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Fri, 27 Jun
 2025 03:40:38 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::3c) by BL1PR13CA0182.outlook.office365.com
 (2603:10b6:208:2be::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.7 via Frontend Transport; Fri,
 27 Jun 2025 03:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 25/33] drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:54 -0400
Message-ID: <20250627034002.5590-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 399f68fd-00b9-4ffe-34a6-08ddb52c61df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4dcwIrk6TOxLHFJ/LO9hu+ibNJ4UG0mzQOY0ZFygONbkinyRf8H/DfF9jn+Q?=
 =?us-ascii?Q?KsnC58DRMB6wRAwuPWH53sMPY3/fj9GqypkjujfCurSBXgv4YRzEcuc/sRlk?=
 =?us-ascii?Q?7Z4pDPNCExKiictPwfKNtdRjF74YPAAgxRZWsNsvionU7DyMuck7s5kGibe+?=
 =?us-ascii?Q?Sk5voL9riBUkVph4gOvRCypBzfuyV1f7tEoWvdYNQ9d/gL8jCQtqPgTLbKil?=
 =?us-ascii?Q?kqlLIAIqWs3xKwmlY0h8qx0cQPw5qH4M4hKaYJqteAodAEdQQL1TOIZHVVZh?=
 =?us-ascii?Q?ae9/TASbN/pWgcOAZSjKSKc1HB+0ZK/n9rB8o9LscTHtV8Yyzt/9xyTfZDo6?=
 =?us-ascii?Q?1yaj1WzkMIR06RZPeTBo0H2Qhs/w/e6/mpbW0Vgvrij+TzenUrQJ6s0+j09T?=
 =?us-ascii?Q?en+IR/cTXHEWGQww6Ox/dsQR6jIk3gej70RCr9tV/ZvQeCvmptYwrwGHolNa?=
 =?us-ascii?Q?KtjhICG5uzweXfvctzmb4DIAiDUNWk3Eb8et9Vvu1agb3A9CsiyBFosa9VQX?=
 =?us-ascii?Q?bA9rPXUhXVlF70wC+iL6ljAmuF30fygYNZ2cWIzBPpyh+8QgPMcnq5sn+wzS?=
 =?us-ascii?Q?liE4XNd89StxtBqC1bgx3BTwZRnXWSt+rEe3cgxVbZd8R11F5vBdyuf/wsWA?=
 =?us-ascii?Q?DVTL/c3VzgkVEJUqxkRPcD/s/8lR57QsvUOIIclPeNRVnxEjsVfhvarSRO4v?=
 =?us-ascii?Q?qY0G+PB5POdxvZkVG4Q9Zcwcv1VQDuVUYgY8oGpfXmwhjoDbAjexFCC1HeEs?=
 =?us-ascii?Q?2nP4We5YrYPz9U4HX135yXWBoIZCF3LQIkCwQl77PdjCnC2yiaCpyGQ4jWmr?=
 =?us-ascii?Q?jwm6rGH9xAPuidreyL2Kdca83PRgfkw9NDGIG8iPNQCOF+zBG009AurweVKa?=
 =?us-ascii?Q?Z5ur6jugNCB6tA5g4EcRrdmp81XPTTv9ybSYL2V1HhC7YiboAUYtoNjasbl/?=
 =?us-ascii?Q?c8GYnhek4td/Jp3yLLrjrr0KOvZ+uqD5sCe4zfaqwQEOSOcEW8chV6g9Lfe0?=
 =?us-ascii?Q?u3I2dbytYTdpmRsnLyyD5AsGrBZz///swWhnpiV4Kg9xGlgt3oV0nGFMDK2H?=
 =?us-ascii?Q?UBgd6gpypJie4Ara8FKW5PtgTYR4ucfTQ4rgFvJm6O005/GMREkEilsllbNA?=
 =?us-ascii?Q?+xW0WnX8ISAL8NT0R9j9YvP4qf3AzVP0TWjYTuwxNcXXc0hwQGPdWm6ISdLz?=
 =?us-ascii?Q?dW1ypVUjBO8BD15E1AKwY4Sy4uMUfaL996c4WOQInUuhQdwrDVIJRn5J6DSr?=
 =?us-ascii?Q?l00WtmATiQXi0dcrZTADjjeIxIe6NEvr00WV0u7+4FBD5av7OxB0/P6/xgdT?=
 =?us-ascii?Q?9ImZ2Vg5wvtW+x57jYTw8TI64sGubM38x3h4qr1rmyDYcCyQ0J6J7yL3YUsO?=
 =?us-ascii?Q?HeK7klto2ujEgF7FMGJLDO2IGPy16bisjt6i1Y1WLfPpVDZbTiwvkLDNyws9?=
 =?us-ascii?Q?s9s3Eb6JGrwxJeJxdR/0IAdYJuhsBOoPVtOLJzMNX7YY2y1V/GXCEPVnLpaz?=
 =?us-ascii?Q?ljI1O8aKkLG6SvbK554nrAMqx7HvZaUJB4dL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:38.1216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 399f68fd-00b9-4ffe-34a6-08ddb52c61df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
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

