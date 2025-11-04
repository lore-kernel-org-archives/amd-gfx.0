Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE4ACCFA07
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 16:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025BB10E641;
	Tue,  4 Nov 2025 16:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XOTQu34h";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 133DF10E28E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 16:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afUTgEwfKnw05F/fKZfdpXssNivCTB/zhzqdqMyUFP7/fHzrOQd2bW24TjoANNAFf531xPtbcgjBQyPd0feGJZP/1vNRqEMnF+pgp7eWa9VxVra1j4xIyCShFyX42C9Xe6I4ni1eXge+eeN1qI7r3mhzNbX1wIb2QUwV2aRo7ZvTRwLw3X7/R1pULsXlyCTAlL8/Qlt42VnmRx8a0DmlKHRa5goxZotZT/GMDNTGri7vhcQiBHtubwj10xeBV8RmGkUh1o6wkN3pgzBjcJEQERNwqEq98Qy9o07slXGPueeXOcqy+TqI6OZIZ2DnzaDqlLFiGIEkRoPorHI3ZHkJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96fY8Lcu9NsAzW3YnCPZKuhYeQeNZxa3gp7eoVLzsy0=;
 b=PBurSpNpw/s7UhzGDGWst4Q0rhjr4sOEVPOLr0fyQKWKlWyflYwX3aUKqxy7fnw4DCwfE+2001sbbpIDx42G/vmerIQWbJr93n6ZUsWIMoD2dOrJ6ZGdFmnU1ItXjQEknpL8CpEekMelBoEniOrwSUzuiCV6zGj7LE/xImhPH6/xCg+pttcWx5uDHt9q/4cQxmu3mjL3IQsQXBr+8+1QhZNM2SsO3oD6u1WEfLU3WU6Jw5b+1/RxQQaaHm5MLLozn3T6Kh+DxAoS55jOt9pvdIonq86m5TvsSHu1FE5SKymvIRKHJ4RpdIXBt6QnfZfpgKuOW2F/sEuplqpqTpSHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96fY8Lcu9NsAzW3YnCPZKuhYeQeNZxa3gp7eoVLzsy0=;
 b=XOTQu34hO/q2ZzRWMzLcbQ/O+70n3EJFZdWg+s3jYJJI/6VDLjbB66SL7htrJOLGtJ6DgpwiRcLoHtF5V0yi90mW4a5UXeCmfips5+Bshtue3r6hQyl5PyohNQEF0Ad9TYLu/dXRtTcPTyPm2Et2/CrLp71x9DVE3bGOh8vUThQ=
Received: from DS7PR03CA0105.namprd03.prod.outlook.com (2603:10b6:5:3b7::20)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 16:39:56 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::61) by DS7PR03CA0105.outlook.office365.com
 (2603:10b6:5:3b7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 16:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 16:39:56 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 4 Nov 2025 08:39:47 -0800
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/userq: need to unref bo
Date: Tue, 4 Nov 2025 11:39:32 -0500
Message-ID: <20251104163932.263193-2-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104163932.263193-1-David.Wu3@amd.com>
References: <20251104163932.263193-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|BL3PR12MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa0aa39-4fa7-44fe-2e34-08de1bc0c980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tv/TbsKNmO+Avjrh4S/FsRY3t9YKDkqwPZ73daSgqZACu719wiQhRn4UAQr0?=
 =?us-ascii?Q?B0C+z9YBsnuIwlLsgNFXs6LVKxioChC9ZuqUs8VpFE0IZ0S4A7LFTzQOoKlM?=
 =?us-ascii?Q?fH0npVHrPAN0eCGa22rIsOKqHLVUXwwu+mTdA4r49NYojlJs54g/kBMNBULu?=
 =?us-ascii?Q?9aPqI4dNnKEYBAaSUM3xI6sM6IrNbtCLerHHWVcGD/u+fQw8WwssgvviUBt2?=
 =?us-ascii?Q?us9YlyhOAQoyLv5+fGsJfF/TNWTuEQf3pCueES/bEOEgLAw94fk2WcmC3PQd?=
 =?us-ascii?Q?Jg7rsvyoFRs3QsAp5rWdopV0LBQ2zU2J6F1FIapUcJwjlm/GjAZiMICybKVa?=
 =?us-ascii?Q?tW5c7csusQs5iAO3f0Cnp90pFUt5ZOScGJeTd0PrpssIffx2tLs4h98BmZrj?=
 =?us-ascii?Q?kyVTK1Igx45046oQ50Eh4D/wMonr6dEi4GhlUTSqHGMSNEpbuVtoaf19jZ7c?=
 =?us-ascii?Q?VjAOcoEprCM9p//zXvryQPiYLyMmDohZfgND9YiDYls/umfK2F9F2gFYHw7L?=
 =?us-ascii?Q?knRq7W6nhh2O9ANglNVjGsdyDKCnnS87MjbH3KN43GUixA/Pu0eIsDfVG2z6?=
 =?us-ascii?Q?KGfdacrzmSWhXnGIVIJ65E23BNWRdRrjVm8rhJfAloOtB2ErkduGA0eTeYMH?=
 =?us-ascii?Q?/D6fQIrv/LaYR6oklmdAeg7sNs2gw6ic5NIWLx0Z0z+SqBXhIdRT7MQZjGpc?=
 =?us-ascii?Q?GPUGx7EEg+yFzRweeoBkub1/lOhNSaZ7lHvXBwu5gONvl8FMdcJqKkI19OIh?=
 =?us-ascii?Q?DJzJdOxFgB5ocoIgM/4Y4VKSVix2ObhtgwpKkwC9Dxm5RIdqTVYeotY+e92d?=
 =?us-ascii?Q?kwsdAerbvfCN+/VxSa4r8069crU+7VpuS0TWuVkIU5uX45ePzZHIz42/O9Mf?=
 =?us-ascii?Q?edxoSKmsUFRZ8CuvKlArVfnEHIUy46x9bzTToqwRJMIML17mz7LDJMSDKLEP?=
 =?us-ascii?Q?eX616+O7uWJH6Om6P57Ioe69NYxX3DhcefqDVOe/1DMyE7dq7RgNgYIs1JVq?=
 =?us-ascii?Q?fWJoTIjmE00lVTOAbBylElrf6HqsfrNQZhelj1HmZB8ubf1T+QIbk0c+qtoy?=
 =?us-ascii?Q?EeHS6k9sUmMeO4uFb/d5x7wKdiCsbZKdG5XE8dSc8EPGc4pLbzdWcDGNnTkK?=
 =?us-ascii?Q?lcLi47noaGvGSpJUO8NcH4sJd2rOuO+wGqDEny0JCd9cZNjMJMjEFT30qH5K?=
 =?us-ascii?Q?1SSuV880WzTQbhqVLTyy1SqDQbe6vZtfE3KgNZUxFdm1I/1JFSlL6ZjsF4us?=
 =?us-ascii?Q?sEXVzgz12tQPo1Ws671dixIub6PJKFSZRqvpqVHGuveQwdSAZJ+hnYZmSG+S?=
 =?us-ascii?Q?VxaknRBZBdP49CfvilBLZ1MVWkqrgT5bP/p/GCV0gtJba9C9F1NQezc0Pax7?=
 =?us-ascii?Q?aD/EYtC6bk8V5cMqW+i8PZ/YZzRUJfFe/zXXa4X/HZJcO2bKqKzcDrFpIN0K?=
 =?us-ascii?Q?GYblF5k7zsM+lVD/iCPqe8lbvTrAC4svmnmEzv84374a7iLtXAyo/6xdl/JN?=
 =?us-ascii?Q?PG2GyqbEEac0rFVvbhIONWjF/iLSYpOkn0Aii1IJ6m4KTsU1hzqgHB6RoeZj?=
 =?us-ascii?Q?4ULvMvS4ckDS3sZAH5Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:39:56.0672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa0aa39-4fa7-44fe-2e34-08de1bc0c980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572
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

unref bo after amdgpu_bo_unreserve() failure as it has
called amdgpu_bo_ref() already

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 2aeeaa954882..99ae1d19b751 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -386,6 +386,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_usermode_queue *queue,
 	amdgpu_bo_unreserve(queue->vm->root.bo);
 	r = amdgpu_bo_reserve(bo, true);
 	if (r) {
+		amdgpu_bo_unref(&bo);
 		DRM_ERROR("Failed to reserve userqueue wptr bo");
 		return r;
 	}
-- 
2.43.0

