Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F8CC3064D
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068DA10E162;
	Sun, 30 Jun 2024 14:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FBD11X8p";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD53B10E162
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5wm/Q5XIhh/wkmZ6YxS/kclHV8XGaKxtxonm6An64hG9lbl5BlY/b9x184jyanwN83mAomVRtedhJX8aptju9tz6be/O3KKBdH0Yz9Gn6jhcq6yV+r3eNtyCV5AjTpcBBf/uloUonS3ozYDqlw3Ac/OM63kCqgBkwv6IWI8kMy6ZwT2sDtQh5BJMs5dIlzqThMQKX/+LMM4f36fbn1HwpFRDGZe14b7nrw046ckujfnZJ6fZlW6fHbFurwOw3eDGQ9sfK4RKiGVRrJP14afaxnbVIq3XZRB6VIhAy1VexhW5GYysDifuDcV1yuyVVRbQ843emfl7KgKdFiE0uA15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCYU99xf88THixQlYhXlArLv/cF3onsSPO3nMrfqQsI=;
 b=Jeup9d38orlFHgEThmt97TFPAfXnjMErAmKXgNljf7NGBYM195XTa1lzU+mfs5JArRn+7xZ1M7zryhCsBgNuXaX0pyKCVCvqABZITc/2qvGFF6kaAk//PpbTj8sA0CjWaBSvkmiL+8juUNxWZnglDwP82geFtYIW4viNgaQZCc5f4sDrfPHXHczar+YnnZtwJxV2/Ta6TohHGpGw4yxU2Bw8eKXUptFpbim6faTK/cdk5+h+cNYjLP+vzTneOmuemurbTjVeMtzlGu/yOe1mAwnSIP3B4Vw+MW4lUhGa+zPtYfVKIadreRMCY9saS32Y2ZNxE2EtT5LRz8RtyYK4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCYU99xf88THixQlYhXlArLv/cF3onsSPO3nMrfqQsI=;
 b=FBD11X8pVy7C6iXifcp5XIeQGaXf4NjaIm1tuDDpNlUdwoCJCCozn1nfI8qVCLAj9Oc3W8+QiIO+Yh4ZuJOIOmspGgagGSf6k0L17KblecWCow3hP1sIZb5YxY8lze68RHiz+32R8k7GMzufVTXCH4x7zoOkJzd8labx3mhCrKo=
Received: from SJ0PR13CA0082.namprd13.prod.outlook.com (2603:10b6:a03:2c4::27)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:49:29 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::cf) by SJ0PR13CA0082.outlook.office365.com
 (2603:10b6:a03:2c4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.24 via Frontend
 Transport; Sun, 30 Jun 2024 14:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:49:28 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:49:25 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add NBIO IP v7.11.3 discovery support
Date: Sun, 30 Jun 2024 22:48:51 +0800
Message-ID: <20240630144852.2018966-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 16fd558d-db03-4d83-03ce-08dc9913d7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cJ3ZFyzNEsV21x9g0urqBtBqlFEZte3pDHGTdh3eZFBj1zXfU6sphv9dndMo?=
 =?us-ascii?Q?d91Qa8Yi/A3y6nW/4G62NpNjnGuPEUF/21FDDP+q74OuSxiTfVVibFZt75vd?=
 =?us-ascii?Q?Tnm3WZjPHXRrWZtSC1ylrLmtxzMTGaiNqUaC6cJvxrDrYroE3fBdxIT1StP3?=
 =?us-ascii?Q?NPOZJUEYNYwkKUQ38hQd8F+2OZJ/6ZSSGf4vL5BWeqNZLZIZ1/0/va/1mQOH?=
 =?us-ascii?Q?J9hztcdWXxvCB8KeimlIl/b/qIVrDNHLAd+orplK9y9rZ4hfdFaUlDtN+NAc?=
 =?us-ascii?Q?/D1+j0sCf/FjEi+3r0YT1kbhVBQPw0WrqoAtpspCWL6+S7GVyycjBctlWRPz?=
 =?us-ascii?Q?pf7U5HqjZ9m829pPmhhjGOlG3tf+H1uENQkwkVWWyIdUXD1oEx4cjxvLz9b7?=
 =?us-ascii?Q?SrAJUsqAkaM9sNMAcnLymYquRBM3FLI3y/1aSop/EJivJFhN2oVnkVxNXZpX?=
 =?us-ascii?Q?63a//8wMxBtueXGS1Fsq5+s6WFVSw0PR2z+ZLxj8UnjRAoViuPIYyGofbccG?=
 =?us-ascii?Q?L/VFqX6uNLge7T0JEWa6rxI44XAEND4y+e7Ni7P3XwmkB5d3+9fN+cMEXyBM?=
 =?us-ascii?Q?wZy1O/3lKFHXi/mL0H2MxLVC8UDWMKO7CV/C9gjXrnnWWFoTdLMRd13b+pHn?=
 =?us-ascii?Q?NyeEupH9c6jKNgximQBSvVV7utegawCQu/PWf+7JtBzfrV/kbGfHemm913V4?=
 =?us-ascii?Q?EL8X8uOolKi50bW/fVqcpDGFVqlWydb1gcGABomBfJWVeqUy3fN5WU+WfFr4?=
 =?us-ascii?Q?wyWoDg1axrdNSy9FpeetKxcF0O4F4q2UzjnLBBiV4QodeV5g5fAxDOk+DGpH?=
 =?us-ascii?Q?hQuxY3Bm+gUF4UWW6ezC5YaXBBT2Gc2sdP8Ii/X6t6uKvj5pjhOvJ1Qy3nZ8?=
 =?us-ascii?Q?BC4HhUy4grH9bTFdqYnXwvW1ctYjE/klRw8CP42Rkvbqnh1jLrwGDmiDMXgT?=
 =?us-ascii?Q?i2lhuM+4ajoqzxr40d55ds02hHTyI9mxFkM6qRSK9nIttJBmk/9wXjdpwQF7?=
 =?us-ascii?Q?f8cxSMkk6aZUz0Iso8GPxSaVr3wHj1wxJqjdJ6Q+ojAJ7hILYtStOi75qjSz?=
 =?us-ascii?Q?+RZQvvUwMMQUy3cSZ/g3LjVsE9s5NAbqMmvNXptmzXiSIl5KkVbUUdDrmc3/?=
 =?us-ascii?Q?YEjJwJcQYLl2zf0fApcunwPQ15/RTZ6VP9wkSRD3KWuztii1hmmMcTSxAGmV?=
 =?us-ascii?Q?lgsyfWk3IV6Beutfl2Z+lEYf+Z3G+diwOVBkZKosq8KgZ8pfS4pu/IL5Gw2n?=
 =?us-ascii?Q?+wdYLB5m9SMYGgyAhKecuXDIo58wpT22WnFSMkgamw5DP/Cb+ecg1jaa396N?=
 =?us-ascii?Q?mJYPcKVsnzBfNfQu1puLtBnAAxI3FGK1iIMrkDZGwoal9d63ohz4AgGJOn4S?=
 =?us-ascii?Q?57FdhStxnpUM45h+0iJArBSXMQxizB6I3UL3FE0WQKLBaDKLMkXRhK7ckP2C?=
 =?us-ascii?Q?nkOvm27lgeRXxLKriispJxUn/pbmKrOs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:49:28.1319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fd558d-db03-4d83-03ce-08dc9913d7fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357
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

This patch is to add NBIO 7.11.3 support.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b1ee5bafa493..c9dc921d6a92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2701,6 +2701,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(7, 11, 0):
 	case IP_VERSION(7, 11, 1):
+	case IP_VERSION(7, 11, 3):
 		adev->nbio.funcs = &nbio_v7_11_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_11_hdp_flush_reg;
 		break;
-- 
2.43.0

