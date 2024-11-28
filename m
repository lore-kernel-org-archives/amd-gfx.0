Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E953ED690ED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 09:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC1A10EC51;
	Thu, 28 Nov 2024 09:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PIsiXxoJ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BDC510EC51
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 09:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/Ivv5N7cMGMVvJ26guvxlYVQrcqnny12CkM9lmBFK8O7mfAtAlq1k8TFADY/52eZJ8HqHgU/Px9KlIKAV276/XwYoeOgmaynxmwzqJL3fQffhZutGnYNWG6grN2pq9Bgkk4bJ3c7V6aXAioKGVvjE23mrf24q+DfoE/0sEJrdnPC1HNEvml64D6xSYk8YQpkiHMhFUxgwFSlmHFPHMJm5n2Fc+NiVWJqR7vWCHglHLYuG8zXKzqoU+6VauKAhLb5+pehu16iDFrmLakaUc9Qb+Rn4QuNbtFlmUZLY2/oVO+QY5Eu3ee89bSXCRQKxJo3z8Px1eOKS9OXLCu0eH2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2OY0l6/H29MPkgHh2+OPW6pAbgwDh+xNv31KxrpPlQ=;
 b=iACNoa9hq59dHECGlXA8WTFM4f5iI5rGU6SL5gHLGyXAY9607UbQnQiTFM4lIjwCcqFY2zygsxYvY+OdEUiMrJZJwF4PGdsBqZQvq3RJbzowifGe+s6iH4Q6umxCmud/wxjDVlBTt80NxJUpnDbgQbz6vLn4m45ngYPiXLiHRs675JlLhb4cSnlOYVHR7EeaDAaJqpVaxoT/355R7Ag3C2YFFrWGKusQaT4VphzDWVZTAVS6AvgD8s24xzc+BAuYUd8dJDjdGl4w9nVW6yePINTwMgsv5arbOCvriPmlHTMZ468YMo9WszQJ3JMcvXqrJ3QbwjRHlAuRP2lAGJ/lmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2OY0l6/H29MPkgHh2+OPW6pAbgwDh+xNv31KxrpPlQ=;
 b=PIsiXxoJjA9MRMLI5FzKlSetc/igQIpvlPRA42bol8weT32dbDCiFSIO3UHUsxBTi8hcjU0A9GiZHv2wIjlF3iIdI05O8/tQJ0WpOzW+aj2rn6WqaHBHYNCozKYNDqgRosOUae58zMATKbJm6fHXXJI1SiDg//OobTc/PZGIfMY=
Received: from SJ0PR13CA0054.namprd13.prod.outlook.com (2603:10b6:a03:2c2::29)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 09:16:22 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a4) by SJ0PR13CA0054.outlook.office365.com
 (2603:10b6:a03:2c2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Thu,
 28 Nov 2024 09:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 09:16:21 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 03:16:19 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu: Add mqd support for userq compute queue
Date: Thu, 28 Nov 2024 14:45:44 +0530
Message-ID: <20241128091546.462159-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128091546.462159-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241128091546.462159-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea3f7fb-8a24-4f34-391b-08dd0f8d5372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gh7PkDBM9Z+ixJz9e3PKr6zF4rzTdnzknlkarSetG9YIyvDCsSxeM8sbQfxR?=
 =?us-ascii?Q?xPW7Fbs/2iSdygRGyQh0dO0NHEqSzTeCMcBDcPFmVD2FIEW/WjOrEf+qWgnu?=
 =?us-ascii?Q?sj6gWz8MT+3l7ktZMsGfm4QDHo2kzFZTfVXLB3Vd8B0Wmr6S3ZivNgVQAXbN?=
 =?us-ascii?Q?QCwYfjcpbiGBi3YN7SggKffBT8/YUwwC0I0gkis85zPZ66/7I6P5CjBt8nYR?=
 =?us-ascii?Q?IfyT8EqrK+ZDDukWKS88J0oQ6qQSuZ/66UpMXZvaBtRWBmGLjucr/oY8tKzR?=
 =?us-ascii?Q?9AILaY5uIc9ZmvB4omeRQipoI420Tdzq5vkHojEIPJU1lDELVJ3KxOIg3ODg?=
 =?us-ascii?Q?3bGA4HevFBIl1QoKRZfR1aZ/Ds/ur2amHHNU9h1jlZjklB3N9Voh5jBJkry5?=
 =?us-ascii?Q?qXHE0yOQPbfZx/BIIyu4JhfpJNOqKmMXQ2+YX+u09n0+FdjryvCMtXd9PhhL?=
 =?us-ascii?Q?R0pahUZXe6ErdHUeK4yiUOyO7hw7OcTWxoct9nufdtzfworDJrr5hSbSNoBk?=
 =?us-ascii?Q?efg5AFq0yaMs/skys/OGdtOiwEqem75FpMXDJYZKOrCea5IN5mvwYsqaglVl?=
 =?us-ascii?Q?qfv0x+x29k8LhXrf89k/yOIsPl2e36aPXjto4AZEqSkoqLItbb15XEoYoLi5?=
 =?us-ascii?Q?A7u2/OkZ4WLfWwchxtIbIqvbZ7o5yXkR/X0ntXSWULy/eVSaB4NTc+TkURzl?=
 =?us-ascii?Q?0R+iti8W61tx86EJX0Wd307L6SuScvaFiLuUzoKhCcbnNeqJQduHCVoZyv27?=
 =?us-ascii?Q?IwAxTZJ8Mtc75NLbkOHn5EDjD1w8chgszIeJscCsyjPg/7B1VbSxCBpmc2Dn?=
 =?us-ascii?Q?k7LN+Z8mF+5139Nr9SCByrwdKen2BDRIoTLc4y324RTyCfz9z2AwAf7wU2cw?=
 =?us-ascii?Q?Svlox0KQX8rja6SJSm0I56uS25RRp29AkGeqUiFenzLI3zpKn8Ha7Mvdml49?=
 =?us-ascii?Q?f7x0oN+XwhIlFGU/L9gvCejfAIPN7jJWl4zm+I2n+BEC3JL1VEvDhZ9IrG75?=
 =?us-ascii?Q?Ymj7F1w048407+ytF6F4dBAzcS3b4Ts+eT4k0R/RzaFqm8k3B+VGmbcPQ5BA?=
 =?us-ascii?Q?aGCIP4DVnYrdHNWzMaDfdPRCOwHz6IgGqACo4Pz939tigiugaJZTU+8FCX0I?=
 =?us-ascii?Q?0ozmMFKDs/6ZurWTjW+umdOpdmMyTppiVJp91uryeppgNItjFJJm4RMFONIO?=
 =?us-ascii?Q?iBmGoJnBNCoNK+GtpBTv86WARQX3MxLbiltseumdGz9Zpi2H3AgNMnZSeOEQ?=
 =?us-ascii?Q?KJWSHN7gK+1z7Eysdoi0k+0uHo5+HLqzuwJj5UIoT/w+6EbmL+ityN+Ao1t9?=
 =?us-ascii?Q?/iPQhHQz+up0rC8EKNmZx/E/DPnVuuDcpC9sXJHsN42f6ajXP1vyiAPNW0Kb?=
 =?us-ascii?Q?mTypo1k3Uft/MNXimUA6ta3Nbf/52arsoFYx6pr50wjQO51T6thEHqsL7frq?=
 =?us-ascii?Q?2eYfji/m2Jyg0WOgjEQgAMjqZy/bSwrq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 09:16:21.9716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea3f7fb-8a24-4f34-391b-08dd0f8d5372
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
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

Add mqd support for userq compute queue.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 13 ++++++++++---
 drivers/gpu/drm/amd/include/v11_structs.h        |  4 ++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index b1b7bc47d39f..e4bd6ccf6c7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -234,10 +234,17 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 
 static void mes_v11_0_userq_set_fence_space(struct amdgpu_usermode_queue *queue)
 {
-	struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+	if (queue->queue_type == AMDGPU_HW_IP_GFX) {
+		struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+
+		mqd->fenceaddress_lo = lower_32_bits(queue->fence_drv->gpu_addr);
+		mqd->fenceaddress_hi = upper_32_bits(queue->fence_drv->gpu_addr);
+	} else if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
+		struct v11_compute_mqd *mqd = queue->mqd.cpu_ptr;
 
-	mqd->fenceaddress_lo = lower_32_bits(queue->fence_drv->gpu_addr);
-	mqd->fenceaddress_hi = upper_32_bits(queue->fence_drv->gpu_addr);
+		mqd->fenceaddress_lo = lower_32_bits(queue->fence_drv->gpu_addr);
+		mqd->fenceaddress_hi = upper_32_bits(queue->fence_drv->gpu_addr);
+	}
 }
 
 static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
index 797ce6a1e56e..beef3d203f3c 100644
--- a/drivers/gpu/drm/amd/include/v11_structs.h
+++ b/drivers/gpu/drm/amd/include/v11_structs.h
@@ -1118,8 +1118,8 @@ struct v11_compute_mqd {
 	uint32_t reserved_443; // offset: 443  (0x1BB)
 	uint32_t reserved_444; // offset: 444  (0x1BC)
 	uint32_t reserved_445; // offset: 445  (0x1BD)
-	uint32_t reserved_446; // offset: 446  (0x1BE)
-	uint32_t reserved_447; // offset: 447  (0x1BF)
+	uint32_t fenceaddress_lo; // offset: 446  (0x1BE)
+	uint32_t fenceaddress_hi; // offset: 447  (0x1BF)
 	uint32_t gws_0_val; // offset: 448  (0x1C0)
 	uint32_t gws_1_val; // offset: 449  (0x1C1)
 	uint32_t gws_2_val; // offset: 450  (0x1C2)
-- 
2.25.1

