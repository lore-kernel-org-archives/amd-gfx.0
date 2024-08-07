Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6329FC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 10:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F240510E48F;
	Wed,  7 Aug 2024 10:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h2lQkT+q";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43B110E48F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 10:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDpBO6tj9GIenSqV2FBWdgg4f+uD3q3Iqoek2ojoLLVztMppccZ4+u+RqkLweSvBqaHQmDNlqhY3AhEaTAP/k7JnbvA1w089uIvfQxW/VhUGRRIdtY9+kfykElb1ehknMZ0mDQi2OpwovIVp3E8qy/DlR3RiWe5mMStRAQOTUljIPXxMX0zVP0g0MDKna02pmI9veRvEe3rQ7Lr2IDnu1m5kn3C1hDQ/9oNtVKScEFzhwxeh6WlZfqZDX5mh9narK8bIJjurAmcM35LVuGPqg33eRl1INBAacO362wE3MTjRVYj+/uXdmhf3wGd4FTGd1Hh579sUwq5YkFuBJTvKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlntc+h3DQZm3sYeHTWaPiL5/HjQ1e7y9anRmscWa2o=;
 b=M4UQAMTwoCdoVcvtN1uPVagw92B0mjLH6B1pNWSFTKWu0kmubMs2mAjBZfFhWjfpWaXYSU9sHdaEmXMof7Lz5BO6np3Av1uKk+t+bsVl9lMh/1DuylFNrNF8z8pI4SBr0fV3kAM2zsWp7+kj9VasZAQHxVOqvPsgyTD0X3Nbdyh56a2xwnMKiInsYtVaC7fFqAuOT+pb+8iBWN0Sh5KlY8BQzt4Y/9jlDXksP0ZO6TGGlDecdgrlio+WMfPyxQqnpU1p82eXIn0N+KeGTT8iPkuNgCoJ9jMVWrCqOvdppJlsEOUNsFh9DcayOWQyGcIijjqliCWZARYYhhCtcNLVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlntc+h3DQZm3sYeHTWaPiL5/HjQ1e7y9anRmscWa2o=;
 b=h2lQkT+q9pbCsSSwLouUvkY+gMpb+51+OrrIMc+2lwzqEAU+5yGhVePEXqyyyEgCdl6WH9FMP87sHAeyczGNLocHR3JWp8aH6w3Nj3DZxNj2B6tTTOMZNxDMKcipOyZ5o9IWZa5U4b0AusOTjvrRyL54gVBZAG2B54CWleFtBnM=
Received: from SA1P222CA0119.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::18)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 7 Aug
 2024 10:26:32 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::19) by SA1P222CA0119.outlook.office365.com
 (2603:10b6:806:3c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Wed, 7 Aug 2024 10:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 10:26:31 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 05:26:29 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <ckoenig.leichtzumerken@gmail.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH v2] drm/amdgpu/mes: refine for maximum packet execution v2
Date: Wed, 7 Aug 2024 18:26:12 +0800
Message-ID: <20240807102612.2095510-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 3634b425-7a76-432c-d375-08dcb6cb67ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?It7cC6b/QM+nMfuTwUk3XX+1g0nyjf1+0/w9vNLyx//KT0nlnkG7Qyrfx+v0?=
 =?us-ascii?Q?qbj+GC8tgJIEei4r2VSbsDvAzOuWeupompSH0upOZQJV/XMwooSGSTC+1mhl?=
 =?us-ascii?Q?QEHen1XbjBvfEs3VgkWn2qLP1fgtGMwuMUd3pok4jQRKDUA4NIhwxIWSSj6g?=
 =?us-ascii?Q?oPZ1iRAb4KzcxnO2X2xMe69cLYO6ig4CCZ9hV72ShM/Lexro8nIYtFb+jJO1?=
 =?us-ascii?Q?QIBVbuWWZqilf7rqoKmKurqR5PfbrKf0EeljN9lMrBBcEs76iFYbsg8fGR9N?=
 =?us-ascii?Q?MIW59yCm9B7oOBs81NjB6zyuU6sdG1TaShu6n3eaTYh8TMsIziOQ7DErX1FB?=
 =?us-ascii?Q?+Frrggp8d/tJct3PMihps/cmy7XQe6DL8ESt5nftfLnGWsoHbOpjTtTHi5H1?=
 =?us-ascii?Q?v8gLENsaTVQjzdeytqisOMfdEhfEqY2ErCzA6AkGAnikMWcHyKXQPhdg7Nfk?=
 =?us-ascii?Q?NwivlRVArmLPU0TX8NV3exYOmpJNOvAJ8wYrg3uXebz+s4pjbVwusUJ2AM+U?=
 =?us-ascii?Q?TAYnQpkUdt/WouYyIKBNQBlEHZWnvWgG8VhMnF5Gh8X1mDdAuokI1R9rXYOT?=
 =?us-ascii?Q?6i+sLFvA9pwRV2o07/XGn6W/UJXB0fiWEcUhn7b3w7lkqbp/izqgQeRwbCXS?=
 =?us-ascii?Q?wKApxAGwfN2xkoCGTuzvc9ou8PlqqwZxh+iyjFV4NgNOekv8UiwK8JcdRH9F?=
 =?us-ascii?Q?txdIQ3g6vL+JqVSjzs/1bOxgFGcv9TJBF/5vwrfViy6YMo4jrvmwJXBSseOM?=
 =?us-ascii?Q?x6RJZjVGwu1Tb+5pIuWKQkIJFfLzPrOV9a+Wez6pvHew7tmfy7ST75cRDs7s?=
 =?us-ascii?Q?I2fCggvotlVTkvmd42+5bmwaDVDXsnBTgTwnZDyNBxttxwV0LlWRaBlsprF0?=
 =?us-ascii?Q?BsGTuRSKfTvOnx/l9cDUR2wpMNR3qkS1OO8vvaoqwOBZ7rVEGUQgXPXdTHUS?=
 =?us-ascii?Q?dedMqpy9yA2yjxVAK1iHJDfy5b9duTqm1sVH0hL2QGf7LA6XD+tjPCaI89Wo?=
 =?us-ascii?Q?gSL/aFuTOTUH/778Rle7yOf/G91KcBFKQE+p75Qjzar+ZJ7rIW5IsNxLlFT8?=
 =?us-ascii?Q?RHW5qOPxqjJ5JGK2PubYvoqKJqz0cbs+80ZcEaQ1GQPl9hYrJdfTlPLejv1G?=
 =?us-ascii?Q?8UPiwYnEu4a6csWH82K7yEgErGtNz6hL9xSLJ9WyWQiMZj8xydO2PgbMcTa1?=
 =?us-ascii?Q?W/j1IKA22VbECfyH3uYtFcBVR1gAwP1HOKN4u6YtULd8GaXM2LWIGPqGTnQs?=
 =?us-ascii?Q?9EWiQPhywqvgZgfGPqrVpYhU5Cgc5C+6KlhjhxmKzd3VFVamo4lehyrUIgyv?=
 =?us-ascii?Q?JMK1ML4d3/v1mLN4iiYQJPFZbPJNI9FRYw65/qGkXCEQ3snGhmfJu037Kius?=
 =?us-ascii?Q?qggyQfJ8a+9j4oqGGOig7gSwJWQTeLr2aLhqLTp3ZEBW713G2XQcCD8qvAru?=
 =?us-ascii?Q?N46G52m5zO8RqkfUEJ0CVyDmO1vueRpg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 10:26:31.3113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3634b425-7a76-432c-d375-08dcb6cb67ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968
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

Set sched_hw_submission=8 for mes maximum packet execution.

v2. Only set sched_hw_submission.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index afcfcb786eda..ae9567c51490 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -212,6 +212,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	 */
 	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		sched_hw_submission = max(sched_hw_submission, 256);
+	if (ring->funcs->type == AMDGPU_RING_TYPE_MES)
+		sched_hw_submission = 8;
 	else if (ring == &adev->sdma.instance[0].page)
 		sched_hw_submission = 256;
 
-- 
2.41.0

