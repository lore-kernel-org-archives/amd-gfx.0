Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A493C07E8F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 08:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FB310EB61;
	Mon, 22 Apr 2024 08:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MQPsiYry";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5143910EB61
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 08:47:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfKGF6lAFEAYPSrGK194YnCtGvbjiaLtLfago0z5luQTvDaaf8C5ZmgJUcg5CI+oPwcg8KVCsKKsEMqBSjicN0N4RzKBlDufY5CakO2rF+mkKilKD7smJruOcy4pyq3aF2ZMAqYDVnW0HYowf3IvRtj7RPyGlsPQfApO6X3WMCmyIMEKY8PTqh1o210x7R+noL6Cj3lpMLAPsmxLsDtaYDIWN433Bh/ZpZxWP/liLTU94v4COiXKbF714lY3okJaQES+zda+ftLS+OrbrEPU5C9g1pMSc2MTYjgUseGQTSVZVtKkh5oHRkJhBiCYy2hQOPkLMV7qo6Ta/leUA7NvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li37giuK5a+EHzrfmKqEETv8tRqZ0r6Iu7hhei2H2fA=;
 b=J4HJ9RcRH6oFWk4hKckneB1lU5GBZ08zl+K9IsKaMSWht6HHE/BoWsAuc0zEimkPK5+XkhBq+LhCJX9Dz2IexFhUOnl53lo7zOXZsP9VF4SYg7UUdFnK0Y3X+5I4xaAtaRH5Kf44TSSTcVhZhctIKmEr0EBq9McaIwecdOmwXP38tRUFgPvlrXuN57wrPJZdn++zXF+bkVn6HWIgFZmP6tm0SzuABuWNzI7k8yOCj1nf2QiKR/EPk0b+qUsVumn638mIYWTiiDSXXUjktL/dlMoBQ5MmQh85mO6MWPhKRPSn8BF9pYWdRt2so7JbzvwE3GniTrODsRrXqtSnxOPM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li37giuK5a+EHzrfmKqEETv8tRqZ0r6Iu7hhei2H2fA=;
 b=MQPsiYry8u+GY9KFRqP4Oxko/KizZG5zxmGWNDNh/L8pbz66jGZ14RloiM6t4GKjUb6SyTxEC08KIUwvFMQ8Pck0bh0jWFRnXQEO3pwGhaiPBx4KFxSrCJ4gZKE8cOW9HKjYZAyYsTMFziz8sl9JFLg4Wkyr1INsGqwsBbKRAa4=
Received: from CH2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:610:50::26)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 08:47:32 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::82) by CH2PR16CA0016.outlook.office365.com
 (2603:10b6:610:50::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 08:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 08:47:32 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 03:47:29 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Christian.Koenig@amd.com>, <lijo.lazar@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu: fix use-after-free issue
Date: Mon, 22 Apr 2024 16:47:07 +0800
Message-ID: <20240422084707.3803306-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: a74187c2-2bfe-4b13-e6ed-08dc62a8d97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vNTlc1PiaVyzFba8cFBfNkyqi41GaNPDiVXbEaApgxtzZTpyIXfyuMyvfVCq?=
 =?us-ascii?Q?8gDVsM2XOg93qmPkQthS1uDVvMKemnYdWJMZdNkSZHRIRn5HDUanK1opBZlU?=
 =?us-ascii?Q?K27zZxEAajEPYHvfYq/J/yOS8wjsZ2Ey4/35FkKV+yfIG7vf3rtPYkVlJpAv?=
 =?us-ascii?Q?/fljLcveGktJlfoGJw00vcd0j+kkmVX/4NBP10U4fKePpEAfHuYAYshXrSoH?=
 =?us-ascii?Q?ASu5ozULrocE77XW3zySzZTp5Fmn2Je7CuOWc52sSAabMcyGwRqnFzQTcU7u?=
 =?us-ascii?Q?GjhgzKh4GTyEXDPYmMRZYpta+4oZEElnU5aQ9rUD4lJZZ7v/0xKK67ZlJc8l?=
 =?us-ascii?Q?4UQycpC+Fu+S3ucUtL3M4e8fyjdm13icQQlQyjdYhQ2SGdrFiOrTI0E27ebg?=
 =?us-ascii?Q?N6Gm0BxdhqAxLZUlSfr6p5iwlZSwsoUKcJmxp2BckswSoZOKYuTN7y/37KWc?=
 =?us-ascii?Q?LJouNgLfll1UpOtqC8NHivFt2q80s8YQi22ODUFRZOco+wkEI+l06wDwUw8U?=
 =?us-ascii?Q?pOt9sEBfevYB3WzKNkrIG5UYozwB+uzALYrsoyy3v3H5JGwQSbFNzEydnFc1?=
 =?us-ascii?Q?6YMl1TdYux1NuLvygppod3wS7jNXSuzKBgobGCdhvpYnQ+ugxscWAC/MX2zF?=
 =?us-ascii?Q?g2id1QKdXImNVW4N8FRFs1/mBJQEf1WfLs2xyn1uB272gtvzZ7uN2TjceT/D?=
 =?us-ascii?Q?GScL1lUtDygvvPPqKBCMd0EXRECjJTcgyOteFMD6VsL1soKIajaQtR3NV3bW?=
 =?us-ascii?Q?4h6726tAbN4U8/LgdI2nza/7IW0isK5aSbINY2a4Fsmp+yyJpCTdwNRk5iDK?=
 =?us-ascii?Q?sKpgAXt9YPkrlGhQ+zP7uWuMW251njsfzeqYbrd5wWLpsxtnvpfkQqqJjIuM?=
 =?us-ascii?Q?eb00Q1lgZ0XSW2wXo8qdsqP6ko+BLNqay9PjaIum8+5HOREKzDb6xRKIHB33?=
 =?us-ascii?Q?daXxhsyG9OueXlDwIi72FeBWldfNklz9aq8b5H4AOueenicJbt/y9fJLaaBO?=
 =?us-ascii?Q?woVKAIYfldyVwqR0DQoSEQHoqIUCWRgi7FqntrPUTztBkOtWfZj5o6Jp1Fe9?=
 =?us-ascii?Q?mwMI3Bt8xQAuMtXk1bcedCQ7IRdUJevkozNWqdNt4MXtzaB8zFzxad4zPccg?=
 =?us-ascii?Q?zZb0dqvzZbI1KzhmSw1ksAzFqtO3+J4pKK2yxJPVsf2Jdq6C0KIeKgFhQ63Q?=
 =?us-ascii?Q?l9fLLF+t+R37ruhr4w1V1ktvKIS4vJzS+B4y6d5A1LHhhG/TTrX6nNhCuAW0?=
 =?us-ascii?Q?AU0Zg9JatuzQCoSINnzsVXd2Ce1dsLQbevJCCcP+rj7xiHhQneRyzcFN8DXt?=
 =?us-ascii?Q?EnnIMSoa0n7Gb0e8yP9QQ0a2x2/E5m/uv+U/tqZrN1vq3r8DMisJWGnj3IlL?=
 =?us-ascii?Q?dVrbvR61MLRTP29ScLZdXDzWLmwb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 08:47:32.1880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a74187c2-2bfe-4b13-e6ed-08dc62a8d97a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
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

Delete fence fallback timer to fix the ramdom
use-after-free issue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 06f0a6534a94..93ab9faa2d72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -390,6 +390,7 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 				      &ring->gpu_addr,
 				      (void **)&ring->ring);
 	} else {
+		del_timer_sync(&ring->fence_drv.fallback_timer);
 		kfree(ring->fence_drv.fences);
 	}
 
-- 
2.41.0

