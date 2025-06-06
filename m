Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2D6C61DB8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28A1910E956;
	Fri,  6 Jun 2025 06:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bX3hrFC4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8ACB10E8A3
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZK2aSgQ+ZqE9aiqe+KJ9XdZqa4aTIwvpIBdRUMkxDpxR6tkdfHWrsZMaL6w2qfwSHo8MWohQ2QhwqcllUKk6Jb1sV8gpJYpIxfthByGlENMXemtiTKstI0/FihD7nBn6cu+sZvbQLKfyuAMW9qUqp/ZHm71Ce39oX2jBhjKSs+03KSNjx18RyE4DWb7MhkPVfXhvosLGUN89GFvgvcE2fwUM1qbEezvcD2W9g5S7fkTusALDr/RcqVZiVta6DVNzovFhBtbAiIWmk8P8koiXkYzrLcqIHrBswHpuImtBocXi2v0CPnD4HUi65c+WWan/sUhrq+ybZKpr78M+ZCv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vjLva+/ba3psXqdISn83jSajabWLGrHvS9aobd6Az4=;
 b=B/vLotUArr/Lw3sD/cs667HTw1iPJKmRhImr8rILTzv6sQOLbh1yuRGFyUXCdIX8oTUJqwt2wwiK4VnBrPpzVH/F6qWpUGsclm/fZiPhMHPUTU50e+wFAiGQCdD//5ivV68GbhkshjdgAVvMqyF9Kvv1jjanaC/4c07e5n6297gXAvytXN0VHlQ4syIa7cI/8NK7groakSbqLtfbXHjLB1QQhR241CVReXgWR+NuQbIRAqhyvuq5ioK5rgIoMJ52Yvc+49jkC+n30JPsWloXYjVALunuvf4o9Or/LfzlwSF4Bb/LjacWDA602Z4w5LpawK6LoHuVbo5fAjxyVGbwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vjLva+/ba3psXqdISn83jSajabWLGrHvS9aobd6Az4=;
 b=bX3hrFC4DZ4NhzftYAhFdJAjihGnzfmBbR5pXOKksOP28ydk91gQoq3fTry6ei5QvQrbkhT3DoyeMKWForarVGU9ohXGN2uJ8OAn8F32SstwGsrDXyK/cdny3BzXhDYshU/gDkzn1z/39LF24mySYAjtFCF5ohYdY0fQxNhg/k8=
Received: from SJ0PR05CA0082.namprd05.prod.outlook.com (2603:10b6:a03:332::27)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Fri, 6 Jun
 2025 06:44:21 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::52) by SJ0PR05CA0082.outlook.office365.com
 (2603:10b6:a03:332::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Fri, 6
 Jun 2025 06:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/29] drm/amdgpu/sdma7: re-emit unprocessed state on ring
 reset
Date: Fri, 6 Jun 2025 02:43:42 -0400
Message-ID: <20250606064354.5858-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 9559cf7b-f32d-4aa4-6b83-08dda4c59166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KU9FesR7DMGT7eOIa1emRVNG0kVvl3c6mUJ35v5eTbYGdzy5FiH8C2bJJxQW?=
 =?us-ascii?Q?26R1OzdkdX/zxuF+SDC6r9GZKOXmr/oz+SjKjD5A8GabqkcEzVwb5LLFSeV7?=
 =?us-ascii?Q?x10Vu6vz1BmRy9Y/o4QDEugupEczSZqFmK4NN9KEehwsMuRocZV0ELjoNnjK?=
 =?us-ascii?Q?/nm1NQ572SbMJoKqaelkfEFFRpvdeuz+v9WeESHhhV0DkdfWC46JYHWaLVhv?=
 =?us-ascii?Q?zypUwrXOXyOauXV1bHZ2pezphJt7Es62gtT03ze7DnVQD3GQOUXC8kCyBd9R?=
 =?us-ascii?Q?qFClva34iOfsaIJ2NtpZOnbNhdWs5Rt4qC8Yl59MvK1XhUNj5/Sp0+bgaDUe?=
 =?us-ascii?Q?Z5CFkeVEKZQEouRLb/sHkEcuq8nkQeIq0zfhBwMYcoLHk8Z1vnonN+49FOgb?=
 =?us-ascii?Q?rzf99MQiLJVfE1+6eUsbSsp7M4d5EkNyMJD8QbjK6PNGsSX+HAYWnC3W5/JV?=
 =?us-ascii?Q?tcnhnjCSChbTaEKpoomZ8HHA6XNEhoURksg2UFK99KRK+Ghae+L2V7pNk8gv?=
 =?us-ascii?Q?+hHo7C+Wch5G3O+15Yaovv3k0HdfOpVJFqHBsrWefirDhVMWMqK5c3Ckz6Rq?=
 =?us-ascii?Q?xDBFOfGUbne6DIh8n4HOX2OylRflUCJ95CqDa9TCcl0T0MJbwA2NBIw6AYyq?=
 =?us-ascii?Q?hn761vkXEwZa26IxHsYPVSf2bq9IRqDuwAuDIzs0WskqZqIbeECjktxUzN+L?=
 =?us-ascii?Q?K5BQq+TPwB/4c+CacZufCCzTgwsG6fWmW41eT99Efd5tmnp0LI6XfHFLTHlF?=
 =?us-ascii?Q?kkWLvpXtZARlOQwWZ5aV+TsS0jS6y4mSl/rBeR3eCrrpDy+IeTsnnHHuTUhG?=
 =?us-ascii?Q?+PQTtyok4DEGxKiW++BlDRzUE1R3+nrX4qFZ1DwPLWQaqzafpmCe4mmZf8ZP?=
 =?us-ascii?Q?2cF2bCXJ9F6mVaG0xDFbeGJZsfUashmrJXZp2C/U6TfQ5/i/BRiD7Q4h7mX+?=
 =?us-ascii?Q?oM2TbUq+AOg7YiBcGM8vbgxW+cE0Q178V5LNEWI/yA2/4hOF9z2joCF19oFI?=
 =?us-ascii?Q?1AKt0BM+mqYLV+VwKBkgXUBYrupi2by9yUZFWXj/iJFYp7oLAoUK8U43JsiJ?=
 =?us-ascii?Q?yJpcCYoBvYMHl/iV5av30hLaEzzfocGD7gBwXwjB7SpIDNA2ucDsPAW0MZvH?=
 =?us-ascii?Q?wWG1njbZLzAPoupjnhYXBWfudIWgMs/G+Fowy07udkCraQKRvNfJVMu3Vi1D?=
 =?us-ascii?Q?EnmqLE1prUGw7sOEG3W/0yRFcFAnsaf/WkQRnHwhXCupWJYTOWdm7XK2/jGx?=
 =?us-ascii?Q?CpEoQrFy2dhuyF5oL9SbOBTdgPEt2iohddDr7tgEtH7enIMaydwrIGH6zWo+?=
 =?us-ascii?Q?KGdolfR/TxZ7T58pYjldymO7YheYcG0m7rlEXSO9+k9ZdguxNfsMdfNBJ7a9?=
 =?us-ascii?Q?ZkSvWebl5Op0pvjbfUdppn02gOloxtF0y8F0AH+MibbBjj4i9FaS9dtAmzqX?=
 =?us-ascii?Q?BhHly+/t6CttX4OENjDkuJdixrXqKeouwjUbGOmJZ5HFZ7Nsf2I9+nIT/w8M?=
 =?us-ascii?Q?n58eJ1ay4zLRHSabowns+9zsGx1MDozobOl5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:21.0136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9559cf7b-f32d-4aa4-6b83-08dda4c59166
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 76ae1a7849a56..318f446acce0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -821,6 +821,8 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
 	if (r)
 		return r;
@@ -828,9 +830,16 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

