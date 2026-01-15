Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CDBD3CCA5
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 02:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EDF910E0BB;
	Thu, 15 Jan 2026 02:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cCJ+DeCt";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8297810E0BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 02:56:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBxY1AFvgyFktmFdtkMDvgbV1OfxJZdCmyzuray9x5jrs8vL1G/OyMPJ4ZZ6riNNkPHCPaq9C/FDrcfNr/bfCrOEemPdEHgBsomvJOvmG1C4M7OfRROygus7TP3iTvhYiBUZDTMDRhXi8TD2AHqVKl0jgZ68En2s0GNNAmZmYgrmZKdGx77+XUFN/w6huixLJddLYuIxr+eaFyx4IgiWWFtDyO3FQZmsAtavtrVPsp5ZO6nMT9bOTTeki1OXtGngVhBwEpgs9h9Y4iqv2wVSz7hxNYefGogMDPziFpV3car7kbCGE3dR+NTiwUd2V7AP6P1ZagvDFlNmoJP/TGn6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydEEKDYPn3BK4/w5hpS/RNPWdiktn2dHtK1bQIdQlxI=;
 b=MkgFpj+IlQ8pr3s+Mn2DuxX4MwIKov68dUO2fcE+Pqi4ShXiWkQJAEFYWN2HScEucqpVYu9ibxPTknRspkxqn+uxfmy/IvbJ5++2dFg+/PMig2bB7UaGi9dBYK52TVwPKdEOYFgRXwcZ6fIwcGpqk3h1vzAfQVDacDJfVvYeJwUW2e67qVHhlpMkXfe191ukxQmqOmNAOUuyXKNZz2BLxsDMO2JzQDolUliicdDkDKg2HNUWw8IyyFdRVfXt+i9jXIy2inl6GuFLMyAT1JR7+subBXo0/BkIrffCnbFf9zU4DWYBSByqvb9fmALKoV6M8Fe1XgwScBX9Go9NuLZgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydEEKDYPn3BK4/w5hpS/RNPWdiktn2dHtK1bQIdQlxI=;
 b=cCJ+DeCtoC7A2FNqd2DdxiA7DqtpGiTC1UUhTNPBnyp+H81LYn6UmmBFj5rLsH6cAlgXonysvh9EymDwsBGWMAjdtiKSuJksgOLfjjTokQ7r8NdBq3yHepHko6bspiUY23lESiCeqi5ZSCF1oYkIfCt/8VtH7SzC9jYrH5v5YuY=
Received: from BL1PR13CA0390.namprd13.prod.outlook.com (2603:10b6:208:2c0::35)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 02:56:10 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::4d) by BL1PR13CA0390.outlook.office365.com
 (2603:10b6:208:2c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.2 via Frontend Transport; Thu,
 15 Jan 2026 02:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 02:56:10 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 20:56:08 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>, "Jiqian
 Chen" <Jiqian.Chen@amd.com>
Subject: [PATCH v2 1/1] drm/amdgpu: free hw_vm_fence when fail in
 amdgpu_job_alloc
Date: Thu, 15 Jan 2026 10:55:48 +0800
Message-ID: <20260115025548.621264-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: cfba5a3c-35b6-4280-a385-08de53e1a31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9OXr4GqtGZqro1AhvgsB91IVCooInVkHfPMTi10ps/XPIpN1R7pAOFoXv49A?=
 =?us-ascii?Q?/tC6LIRqdDYJPJqsEe+hJH8QVjQk4lLN/Ypq3Df4LvPdXIEsaf/NF32xDkNf?=
 =?us-ascii?Q?AbA070LbqKpMug+SY09ibVKpJfeUR1TroN+mbjcIeeaMQQb33sO7WMDwmcJx?=
 =?us-ascii?Q?tCvkK787Pv6/EwY/Zw+t3bCzDbZhRl4pEywcioDniewFTVe+n2Dl2nPkuDYG?=
 =?us-ascii?Q?nknhqgIHSPXI9uVouubWRBcpFhBxneItf3yvGkBY3jf8RWSsov9kO5JwKeLG?=
 =?us-ascii?Q?gSBH7B2lGdkf7JoF7EwYcNAQ/X3EpcxtJIJWHJ/m1iCAlFMibo+u4uM9g50o?=
 =?us-ascii?Q?FBoousurZwD2NQ2a6DCOtv75mzeKsFMo1uNVvwVBGzizcBoJDmRoY669KrWE?=
 =?us-ascii?Q?1rMjT5D9S+MeODOhQyAItn++q/+XYNOMSoVsjJHfFt/RcevlcY5HpuOFASVt?=
 =?us-ascii?Q?GDfTtBZ7wOoPcalQMaWrIO7POhsKFpffJJEvWsEEDd8mpqwGnLL/IQlYYYTl?=
 =?us-ascii?Q?YbcNWWf9DRufCVts1numoh4Q6OYa9mdr3mhcPgWekwo48ikPM/IrLPrCC0Mq?=
 =?us-ascii?Q?9+MgUAfCpZTB30ennghGcC+p5Lh+FuHZ2O7/3QVFqDE//GyeDO9QkhDk4QSV?=
 =?us-ascii?Q?q1a+M0DR3S7TajIGzvMF44qLFswTWnAjkvIpa4D78+kl41IuW9KDUjkzCLav?=
 =?us-ascii?Q?+bGVDr6VKfBOez7nzIaGCVMYKlP1noaXUvQtKbBOB7WXRct7qCncBGR38J/J?=
 =?us-ascii?Q?3gnvSynUmR2j6mzu8alDb7ZqqNd8XYDDqmRtTSl8K3z0PZ0OVUjqfHdj8Tbv?=
 =?us-ascii?Q?UFjFo/EmOk+Br6CdHu0diGr46ZflZYM65k3bPVn8vM+DXYVsAClPibuXwi5D?=
 =?us-ascii?Q?dwAyt3VnLw2RWPdMH4ehWbx0ZqACOgQyczyYhe3wgEq0c+Lg//6QbO7sSfC9?=
 =?us-ascii?Q?Wt0giy34ucbcgdzM+ZQKEnZYASteefd54r9m9yP3wifwiyKxVUSkBfPhfdWS?=
 =?us-ascii?Q?p2tixFWCWGd9pYb9zEKgfi97FHcfb6LQuKaCpiSeuZWgvpeTq1npjEdLKWRQ?=
 =?us-ascii?Q?5/ELPRDLlnTDJ7TXdXaQ6askr5iKDRT2PaeAoA08xFle0gXxAKeKQ8GIm5Dv?=
 =?us-ascii?Q?KfchYweUmIJDcie+lAlhPEtTtJ5zuTYyfd9pylxeza/AsqFCEr+h64nCEPh0?=
 =?us-ascii?Q?+2ymXSkXjhmUCwe7IkGkCWpo7ic/sf0du1MB91BSW5hT+SzeShJJy12nhSfq?=
 =?us-ascii?Q?0ayBrS09bYshrGIrKMB5JcH4a64V8r3EOki9kvv00kfr2+qiDdWu2c9d7TJP?=
 =?us-ascii?Q?61OfBAEQYKsZvUICpRgkExs/McSpV6t62xW0qMJJKrYEkns1tdLzBglLbnz4?=
 =?us-ascii?Q?e4Bt/+HodDCDJV0yMH5InPo2p7ILZCuh+0qH5AJQq2X+UrwfO60zWU3gaPYV?=
 =?us-ascii?Q?qmJKLFavPTJ2k8nexiEJtWhVCpxB2HoGlpTjlxB9JsCEiDYHqu2O+/LAg2Is?=
 =?us-ascii?Q?opUaINZBg7oG/kE1+xcHSwhQUoIEzcuWO20NywECeNdxiNliRDFeTV6anORb?=
 =?us-ascii?Q?pSUHCNQDKV7v3YYkj197KBHHFmxOuTZC+/veF0cLAzGq+vht+lOZO00+c2aa?=
 =?us-ascii?Q?7Isk/OjHVXfM+6OvXLoOExz59P9jLolj1H4zwr+NiZLK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 02:56:10.1927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfba5a3c-35b6-4280-a385-08de53e1a31a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016
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

If drm_sched_job_init fails, hw_vm_fence is not freed currently,
then cause memory leak.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
v1->v2 changes:
* assign the return code of drm_sched_job_init and check that instead.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 7f5d01164897..1daa9145b217 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -219,8 +219,11 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!entity)
 		return 0;
 
-	return drm_sched_job_init(&(*job)->base, entity, 1, owner,
-				  drm_client_id);
+	r = drm_sched_job_init(&(*job)->base, entity, 1, owner, drm_client_id);
+	if (!r)
+		return 0;
+
+	kfree((*job)->hw_vm_fence);
 
 err_fence:
 	kfree((*job)->hw_fence);
-- 
2.34.1

