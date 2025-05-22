Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FACC54ED1
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A36110E192;
	Thu, 22 May 2025 21:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EZvwaPyc";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A21EE10E710
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kp3hmpgBzagLJu2qJu4pa25LKx4XdUhIIa2hvCfmm9l5CnZiYNgXZe+byd9mxIHkn5chdZdRANAXMmS0gczclrrkTMurhR8a9nITjpq2+nXeM9loEDucJvAeEczdnpAFhiVc88mrA1QJwk8n8lzctIKTctqKlXf7xOXJiz680kLRvWpSlH4JZH8Jk4IX3TbeuViZU6kioiCcBq7YXRYi6JB9RgFwL+xTB85/8as6+8siLQmALh5u+7atkCcmMT9VeVose2dts2AXihUHOf8yyLArO921xa57qyzgtNpjhNPUh/UPQ9QRTy7awQnIW/4D3SkmCTHKSvkvj9y/QJr2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aqx7YWQn76m3DVUwRr4wiE4uRc1p+bXCRoSoyJ4HCdY=;
 b=jO3fRtRdwy/YKMU1IVvNGGyza6s1BqCe3mVDkvd4ImdBb7uo4CjE0B50VHusMBzAM3jFLBdsXw6qAEML3FK6UV0AT3OVMbhCiFgT1iWvGE3JZKFpNbFknmzEjQAuHFICimza7dKQKTL2PaDEmA1wm/PrSvGcxQWDdUuL1ZWKG+CVPVH23bCiBFl++kpu43zNBDVx5NlF3HaePw90hKH6bL+GIKL9gds//23jCF0Ab8ZH3fVXhw9OFHpTdrVYN20dDqB8bUP8/T8FMSZuwEC+3RVckco3cplesG2a0ZO2ICOfZS80lMbHVDKuevpHtzAj40iWlYyWQqpbA+Hbep4xbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aqx7YWQn76m3DVUwRr4wiE4uRc1p+bXCRoSoyJ4HCdY=;
 b=EZvwaPycNeejKTuK5sYqlcT+cvTeJcZyeq77M/XNN56LOP2rdDNtJhDzy9hEnUvxLzF7H5iQ4D/mfYwhq7+1jk8sQRTVOdcDXsDveOdtcmYneaowgJ6pmcICdPw1niseKKgOBYt7+dV+3pG5wzKnAzqICQnQhtdAzdt3aOyQ89g=
Received: from MN0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:208:530::7)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 21:56:17 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::2d) by MN0PR02CA0026.outlook.office365.com
 (2603:10b6:208:530::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 21:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:56:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:56:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/10] drm/amdgpu: set the exec flag on the IB fence
Date: Thu, 22 May 2025 17:55:53 -0400
Message-ID: <20250522215559.14677-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522215559.14677-1-alexander.deucher@amd.com>
References: <20250522215559.14677-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5dd61c-7354-4801-ccfa-08dd997b7a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cWKIN8ZiLdG5bIP8wwNzxKC03dcRP0IvV0TR+BJi4tdlqp37aVRSA8Lbwbt/?=
 =?us-ascii?Q?4nz1ASyzvk/VuLKCp/cWwqYdKFU9joqSOdziL0fE68bQqmDaavlHbvZBX+5u?=
 =?us-ascii?Q?v0+xCr1i3w3t/DBPYKh7yFN2lZopN9eL2HiiYIc6ZX0ARent+guwLp/8ExBf?=
 =?us-ascii?Q?I9VduTI40v1VO2Yy7SvRLN5m9ADNVmDcTYBN7hqMAi+G4IvMrHfpo3VP6N0g?=
 =?us-ascii?Q?ZPm6oFPLFmiERZnnKqIdReD2jke8ESLWdkfoatMesBrng1chUnlbucEVqZVI?=
 =?us-ascii?Q?xdKjt+8Z1ycYQ2SHwo6PJZaBZAFC3lit0YdHujcoqF3WzkTt8m99PpgSQO34?=
 =?us-ascii?Q?ysgO7Ufhdp7PR7F2IJK+Wgy/UjPcBhts0gjEXPNtxeZsX9In1wM4C14MMHGB?=
 =?us-ascii?Q?HcmPgncbB1tqz+qZ48igTZIOP4NjQtq3R8hayXbZQ8122eoWc1PyNEMIw05I?=
 =?us-ascii?Q?G2fPveVbe77UTP6DKc3g7/551iPS2lcDrNK3QtpkNZWhHWV1YGVqIv90twUm?=
 =?us-ascii?Q?L2JYRFHeqq8ww5YrgiIfPvRUeIfCQ3/hdz/KKa+GRLaBrP1OGp1J2oLKpeHl?=
 =?us-ascii?Q?Vzh0+P3809tu+P7EQGg4WJP3/gybCeA21ufwFOFjVunwX/XwLXnE6MCMLzMf?=
 =?us-ascii?Q?1y7B9fvyQV+XL5F+yeJlu1+0D+vp5sOxKx8HlWLXwVsl0XSo4LGR2MVxY1Ts?=
 =?us-ascii?Q?gKrfNAGWcPpDH9FwYR2+WXqLT2yN/jSUjjdGFhysRMNTq+8PfiR0JR6WL8M0?=
 =?us-ascii?Q?Jzf4JQssY4sKV6PhmQ+c/RJOR00c8hpazdQ8b9oBK+HhPfHZhRxNHhiqjlfX?=
 =?us-ascii?Q?AGtS+s6fj9G/Se//LF+/vCNnvvRO7ks8C0cw+qkmbLwpGtqQ6tDW1G9YP3Wy?=
 =?us-ascii?Q?PHvTQ4wuP+cB7ie0sxZ+7L7cCXqWc988o/eH7yHwkilX6T1tOZNpkC5Smfhf?=
 =?us-ascii?Q?iFmxsp4xFJjk1aWOytf7YyDTXQ9AzqlE26+nPGfJy8+LY2EPIk8/APQy/Hua?=
 =?us-ascii?Q?zCvldlSgDHmn7RmXcIMP/5xBidNdQ4g8MkYoxY1gGXMJlrNgjcm7aXR2Ryjj?=
 =?us-ascii?Q?EZS69Cy/TzMVLnMsrlDqhSG0YvkjhMuTxPYIgc0XT9v9UWKo3Bi/s7pTvypA?=
 =?us-ascii?Q?wU/eKdvqAGNNw34mIQ9fb8RDAJIWWy1f+y3Dmy2bZ6T7VFyvRdmUAPJqImnc?=
 =?us-ascii?Q?8UYUjbNPRfDIlKOzAJKvf4LjzE0I6P7s43V8h22q6qVLceTBvzuXqE+XG0X8?=
 =?us-ascii?Q?yQlfHRQvY+eHQdLuzYqXAl5wCC4HPwy0h/IY+IBC+dzNoZlKi0zfk8B9kqYR?=
 =?us-ascii?Q?zemGjQSILlzqmiETZdS/UoUC50AYlyoQVIDZZuAZM7iccV+aJ3fUBCe/XEFv?=
 =?us-ascii?Q?iqPFg7WYdQQx+uhRmx2QxM7ZeZBl59DXqxOfg5CU4H49xU6xtnktLVEowReu?=
 =?us-ascii?Q?kI/oTVmeIgWY16Z2Z22o5hbl+MSNq05W/SjhQaMMpcH2MuE7eTVqgVjK4/Iv?=
 =?us-ascii?Q?kHrNlxNyI0vNJPppqXOci06dNP+YvMOE3W/3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:56:16.9256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5dd61c-7354-4801-ccfa-08dd997b7a60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689
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

This is to make sure the CP executes this packet in
the event of a preemption or reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 802743efa3b39..d74bd6dffcbd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -274,7 +274,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	/* wrap the last IB with fence */
 	if (job && job->uf_addr) {
 		amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
-				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
+				       fence_flags | AMDGPU_FENCE_FLAG_64BIT |
+				       AMDGPU_FENCE_FLAG_EXEC);
 	}
 
 	if (ring->funcs->emit_gfx_shadow && ring->funcs->init_cond_exec) {
-- 
2.49.0

