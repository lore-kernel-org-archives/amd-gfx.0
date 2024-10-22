Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBF1D2C54B
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 12:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA45710E683;
	Tue, 22 Oct 2024 12:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e6kFQ0yH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2515510E683
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 12:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrDKQyAdixapAEAjLSDGc5gvtQqd2UCpXyndOxwChIqQbZji8b4EsLlDZhKSUYMmIyzs+c2kWvWJLzFSmfVapSSJfhMwS7uCXzhQcEnZSqWsFtYNbbr8h+gKNRFuVaNkV1W18vX6vNH1aNd1LMt14rIlzl6Uc9e5gVGCYIzI8sw+IquMliCLscMApkFdwGF+OGJvj/Txk7XWUKEErGGNC5smoVLgEZG8itY7/y0OINl1f509pFeajvtdZT3jZEW+vGlxsD9ZOvlquOejpVMR10HAoW07+c9nnqjey+M5lX+R8cQKYQYbnOqgKeCdSEdRcZG+/DrFp7o0GaLrl5a8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpLdcdMvayAEnZ7pysoyD/PspCDAoT9ZcnWkWSSyQTk=;
 b=KaPqt8Bq8UjkOXlwZOLP0eGPKo3iINYf4yKyggwb/HWKsmhwnsV4gxtO9jQesHOipGiMsnhVR8FzM3P1AX52TMyg+gyA5OkCJLFfh5AT5lsvFJYaY6ESoNWP4i2OxHME/Hv1M50t1be28cUfbvQzjWfoiyM57hhTkMymO+6effNLOar2CmVL4ereImMOGNOcyZ2WjCXOcGwvcSflrv93fRebR5y+WDMT0ccPMwgXo4VAyGy9QF0UUYCVhnpT23D8l0/aRdFtL8+Ma9nC5nJnCLmBmTBsCOGXXH0j0Ttyet+aBT4HJypNGB/vm1NvEtlr2e+SJSg5acUC4MCEuSbJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpLdcdMvayAEnZ7pysoyD/PspCDAoT9ZcnWkWSSyQTk=;
 b=e6kFQ0yHzY19/m+doPQBtBF0ZEpzTicnR0CMG5cF+qCZouDxOnNFja5ffwZ8dCuwzK+uyqhN4rUOKx+LBgT6jzdkuOpJ+tvyC1BoCiOPtmb5OJPb42k3eY1MgNvcGO+G/vBcCAdkGvf6oK3cJiOZAoPELv5fZ9KoAwewHIY3efQ=
Received: from BL1PR13CA0405.namprd13.prod.outlook.com (2603:10b6:208:2c2::20)
 by SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 12:58:38 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::54) by BL1PR13CA0405.outlook.office365.com
 (2603:10b6:208:2c2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 12:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 12:58:38 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 07:58:36 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <shashank.sharma@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <Arvind.Yadav@amd.com>, Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH] drm/amdgpu: Fix kernel config name for gfx-userqueue
Date: Tue, 22 Oct 2024 18:28:17 +0530
Message-ID: <20241022125817.13758-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|SN7PR12MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecc0a1a-ca2d-453b-6d8f-08dcf2993f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JlppnxxU0EoqGYkOnwiBUz/XCdj5LWKyx5V7pJqigEvKH3zHMAw67yMDXHdQ?=
 =?us-ascii?Q?pKfLWVe2h07Qo2cmrleP4B/m2dddgTmwI7a91WuuhdfMbFsauk1Vn4XUgktM?=
 =?us-ascii?Q?FI6vaBNkYNk4OehT118Bl4XMFoALVJqrlMGD4xtAb2Vm5/8+1Wc3Birmt2KR?=
 =?us-ascii?Q?eIUxaV0dRhXxpu3ewMh0duEdHDCTzAjOTiUNUu9HME+7xq7hM9iEpH3DKDVh?=
 =?us-ascii?Q?7jru+4c7M4Yi76+WPRcxhm2Bnm5lmjmtFV5BSl24G/DnnV7xeRWPajcTTNlW?=
 =?us-ascii?Q?ETOFCzOQSr5AmV3/uEQUTvGimgSxtzJC7MDO+dQjYb4tIhJ++viepBcx/41N?=
 =?us-ascii?Q?3HoaB1xL9e6G9jDVDdlbEJeND2FFzdUpcxTcckV9YEOzBOUOkmEODLJIsUkM?=
 =?us-ascii?Q?4tiwySeielQHiyNZXVnKW16Yo4R7T93q1WIUgmL5Z8a91iiNZt9JBFnSEGEM?=
 =?us-ascii?Q?SrYdLV3nQ49EAnpQY3KXxkGBo3fiLqRwWqhm+QyazCAwGIbwlzj80OfnHnmo?=
 =?us-ascii?Q?caorz7wblafJ6ixOgrC7YXa7+gL9xnLD1sEZuaRbP1dQRH9bpVgVjvfKCi8q?=
 =?us-ascii?Q?Kzv/pf2hivhpIJN3qqqnr7kWPYs5iVM+AvAp5vvrFNmacl17seLjY+/TWXJX?=
 =?us-ascii?Q?xph3IxEuIZA8uZZ69rXh3AFga4pZFsds/TOIxTmP1cuNiP7ESMs/WjHT7Adg?=
 =?us-ascii?Q?c+PPt2R1TVtMgFUyfiXyH8TbK/VOAFBaIso0277sdXDVyN9+jhVGWjy1WgQQ?=
 =?us-ascii?Q?KFvMrWRPC9cLykhdbS/6W0ynj3qHQoYNKT6LGr3TcFSxcXHODTDlzP+lu+NI?=
 =?us-ascii?Q?XQP5hMP898Ca2G9o73wRpvqBGWZSl2fVeAZIpxGC07wLzMFIreb2oY2m1EKp?=
 =?us-ascii?Q?y4bDXpku7CY2JwPKA8daXM+Icv2LsCjUCvlH4XNl2SkvSCjkVU5/nglv1vbk?=
 =?us-ascii?Q?41A49l9D+Y/ZwsDNJg4LRvnUWnrZrJIhHBBhMPAcS0KhbDQGSxH46krLAfGq?=
 =?us-ascii?Q?eUr5fvJumOlSekSaqMYz/+/ySWIWG2BmrWb1lFaZGACOMlxPNg7K8up4Kri3?=
 =?us-ascii?Q?yPGynHf6wO6PwSm4UmPGcNSDnROki+VmH+s5OV8OW2YhzD3a2CjN2Vd67uV2?=
 =?us-ascii?Q?kNxOPOnv7S+G9YmDwqU6Zuo43ZwHs3Hfiwr52uXEmDyLW51CyRctktVRJy0f?=
 =?us-ascii?Q?BryGHG/JATzGk/NHHncIlkILNJIAos/OCXZuulTY4gcB2Ze4+EEmzFjFQ5HA?=
 =?us-ascii?Q?NT0nGXQRB116vJslgJRE+TsIB62tkr7niFMcfPTfAKTBc2/gvKePbL3iUbpb?=
 =?us-ascii?Q?JDS53CarO4NLYwnuKmjOeukCEl90HIW9SJlQcDzof0XA66Ecz9bQPdAs664k?=
 =?us-ascii?Q?pQOZO27T4Inx8UMhzy1KDpdwpq6F8y2V9ctDUqfekEJbo2oNOg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 12:58:38.0618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecc0a1a-ca2d-453b-6d8f-08dcf2993f0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854
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

DRM_AMD_USERQ_GFX was an old config flag and the new config flag
name is updated later which was missing.

Cc: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5aff8f72de9c..a12ce58962bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1572,7 +1572,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
-#ifdef CONFIG_DRM_AMD_USERQ_GFX
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
 		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
 #endif
-- 
2.34.1

