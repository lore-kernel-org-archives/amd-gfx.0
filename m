Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DE8CCD18D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 16:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B626D10E493;
	Mon, 13 Oct 2025 16:14:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V6NOB37H";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3FFF10E466
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 16:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsrOADyXQb2PMnDVORbP8SJvU02c7bZfJtNQBCKQ9FbHoaWzTCHIf01m0gBWnQ9Awh+HVF3ZpCTVf7Xa1OXfxcdxJB+SdvFAjNl7OrV2EKaWs49/kURZVG6MV8U9I210P02lXGLzyZtF1iPofRt0gLzzbBWwARXdZz+YqGxRooam1USP87/0iB+QwHZC68qzhyGPUMBrU54JIpXbLfwfmtDLMgEdS0q3r5Rxl8aiwZkmM0pUpVfapMgQ4eiguvwPxA/oztC4sQzqwhLZF2dEKfEEx+s8TEPAfXJ3D+gH+l/40Vytx8suPGB4Vf5SQHHbw+tBiG9/lkijJjsEIY/vzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6DckX1tUy+T6nICuJkJ86S/2HsUc92L0Mpy8Xvvvv4=;
 b=urQnBf2/dKKtPZwv421m5E4D3jYoWHsagekmlZuphoibBJWUQHpgm9Rymwl0Qy3XLijCQgoS4CLJREez7VmS/WfoSwM7zIWPLOTgmdABQRbDkXE5qKIsnvc+0F7U6fKJVrdqJFK3pH1OVxehEs0nLrsXCwDNn3nBPlAMbM1fnrIPyVbzVg0rvjXCpDEe7MLg8LYoPZP9DLyJ6zMGz1dhpSQHso0wo6dKkJwf/MNMygWcNOJumVCCIMx99LieSb4isoSh70D6ndbwUPRE+MzFq+zJ/lVuvW94UO8IJDleKqFN4OsHuuEQyLLjBlPzvbTNaW9RfCW0UP5pQ8QJInzo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6DckX1tUy+T6nICuJkJ86S/2HsUc92L0Mpy8Xvvvv4=;
 b=V6NOB37HtqiGV4V115y+bQUL7XsE+J2fHnWEBp8hg7qwqWOoCEGZR8QhFIBjXNQSLtUHzC0+bsmKyeq++22JTxu+1nmPLf5z5qLhhmdrMZv/MGbmJiDu5cxtQH8jSIxWKZw6fNnlgv4uhIMNLok8pDYtWMSpuSYqhYCp9pCP/8U=
Received: from CYXPR03CA0046.namprd03.prod.outlook.com (2603:10b6:930:d2::19)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 16:14:08 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::2d) by CYXPR03CA0046.outlook.office365.com
 (2603:10b6:930:d2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 16:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 16:14:07 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 09:14:07 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/userq: fix SDMA and compute validation
Date: Mon, 13 Oct 2025 12:13:47 -0400
Message-ID: <20251013161352.1628044-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 179e34a3-5d7d-4661-7528-08de0a73899d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9ObEnDiQ3Llr4XQb5noEfndGQOtQqdPGW5MrP7DdjL7YZZLt6Ofgb95kC+4B?=
 =?us-ascii?Q?4CJHOceYTlML0NARfSww1yPOUfprko5KmSpireJK51vzOffFk6u6Vk5Smioz?=
 =?us-ascii?Q?vdFxfYEl1F3zmW4BTBAAZ1nv4rwOp6WSt7kr39agVFgwx84Ti/NS68sddNPQ?=
 =?us-ascii?Q?eWi+JbPk31kxCmgWi2jc4qo4LGLHYSiNthISRIPQiQvt9umyiqzKxdLKz4i+?=
 =?us-ascii?Q?gEKq0GNib2Ipd+iuLSJ+cLqZr7vdEu+MDeEiYB4F9VladFxs5hgSQDsf85Xt?=
 =?us-ascii?Q?QPSSFZrDaQJa13Y9nP0j/w6mwBJT7lJCr99i3JEISl7jIcsVl44KuZzq9OW2?=
 =?us-ascii?Q?84D1GVrqUN3W0NZMUnuQJNjeIq1cLFPRlqguXh2dx/iQGik3myJ36fZcvzxW?=
 =?us-ascii?Q?5zewZIOlky40QNLL2gcoPcvWREzUG0NSdvFvWXH7O5lse55I9NJjGxOWXTrF?=
 =?us-ascii?Q?GA/+zTMmbVUp5QZKI2n3naFSBC14gtZ0Hj7k5xU5myrgV3vx7rC8MHRcPUIU?=
 =?us-ascii?Q?5V1g1ZOBgT1wIw/D03yFfrhlVr69Gbj5VreKcQSYia5hoOSg6YONWIGRPyJg?=
 =?us-ascii?Q?4UO1Gdz5Yg9XAhsrDZIgDUH3D55miZFpNBXiAiz7HcqTps5mrgnlzgMuiTZr?=
 =?us-ascii?Q?yE+Iw9uHuNzVlFtJ4lOCFaFeexT/lXVcqIhpWLnAl0edKPHT6P45xxQI9Cyk?=
 =?us-ascii?Q?mSh230DYgGiNk0dfxDn6ylkvTJ+GmFH7FatTJfD7Jhe2EMt/nXAQAD1yhfvh?=
 =?us-ascii?Q?QN3DaQhQsd6LSN0zEG5ES+TE46GQ4eQrDIA3iyZpyYT6g3MyoqUtxoLKsc68?=
 =?us-ascii?Q?fufM2SBLrTXugY8iq4Iz/neBfQErWle838Z8kr5LR2gnSVYj5FNeQm4MZFPP?=
 =?us-ascii?Q?j643I1Xlb7Jk7gT0+qWXLUQt75kFNORGqVgkOwcKC0Aled6ie2e8e5/u5cc+?=
 =?us-ascii?Q?7LWrzq/wJqytxeEf5yQ+fR0Bf7jXxtHpTgbFqX+/TAogHsYz0uqACCgivHxw?=
 =?us-ascii?Q?kJgkZm45Q15PawrLKZLfo2A/WCePpgmVLc3kJ3i7jjPq0BbgdhMSRgJ3MxVP?=
 =?us-ascii?Q?jbAtEq9HCuQbz0RYO39TS/R+adL/LL3nI+aOEdVLn1VCOiyJOpqdUyMzKxL7?=
 =?us-ascii?Q?4xDr9kRhfqBdep785iObigCgpdw7EW20VD9vij8yDa4bPZs53rX4FWYJQaSU?=
 =?us-ascii?Q?y+pZchklN0bEp1V2ibJcG8oxyA9PYknsckF/1UBjQaEYL2JIW56NShmTdG67?=
 =?us-ascii?Q?9DUwFxWqamSZXlbu6a+XMQzaQ41ijAR5Ajtr0dC+fThn8apqadhQxU0H/H+n?=
 =?us-ascii?Q?HFEq1wSCQxMj2RbjXV0kTGdZ0WbFVM3iQ4cNUah0sT+gax0I/6l2QMK4yNyl?=
 =?us-ascii?Q?TzJCCQuZrW5UpvRxm7kXF9+ggXXLXpibnNRx39gZPKUUt6FnR5+VcydoafmJ?=
 =?us-ascii?Q?1kTIc2VJywMfl64M9jByH+VvRiDYxdczmd4TUVvmLt/oAWVrxwiBIWSfGAl0?=
 =?us-ascii?Q?gn5Xt3dlQtiEa0kNEUSI7mYr0ZzRhTjEOmUyvhC7Vhd7YailrifYF9MH3/QN?=
 =?us-ascii?Q?kenjeEUiqn6ZGZ+rpd4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 16:14:07.8621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 179e34a3-5d7d-4661-7528-08de0a73899d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811
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

The CSA and EOP buffers have different alignement requirements.
Hardcode them for now as a bug fix.  A proper query will be added in
a subsequent patch.

v2: verify gfx shadow helper callback (Prike)

Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address and size")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 5c63480dda9c4..f5aa83ff57f35 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -254,7 +254,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
 	struct drm_amdgpu_userq_in *mqd_user = args_in;
 	struct amdgpu_mqd_prop *userq_props;
-	struct amdgpu_gfx_shadow_info shadow_info;
 	int r;
 
 	/* Structure to initialize MQD for userqueue using generic MQD init function */
@@ -280,8 +279,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props->doorbell_index = queue->doorbell_index;
 	userq_props->fence_address = queue->fence_drv->gpu_addr;
 
-	if (adev->gfx.funcs->get_gfx_shadow_info)
-		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
 
@@ -299,7 +296,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		}
 
 		r = amdgpu_userq_input_va_validate(queue, compute_mqd->eop_va,
-						   max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE));
+						   2048);
 		if (r)
 			goto free_mqd;
 
@@ -312,6 +309,14 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
+		struct amdgpu_gfx_shadow_info shadow_info;
+
+		if (adev->gfx.funcs->get_gfx_shadow_info) {
+			adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
+		} else {
+			r = -EINVAL;
+			goto free_mqd;
+		}
 
 		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
 			DRM_ERROR("Invalid GFX MQD\n");
@@ -335,6 +340,10 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 						   shadow_info.shadow_size);
 		if (r)
 			goto free_mqd;
+		r = amdgpu_userq_input_va_validate(queue, mqd_gfx_v11->csa_va,
+						   shadow_info.csa_size);
+		if (r)
+			goto free_mqd;
 
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
@@ -353,7 +362,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 		r = amdgpu_userq_input_va_validate(queue, mqd_sdma_v11->csa_va,
-						   shadow_info.csa_size);
+						   32);
 		if (r)
 			goto free_mqd;
 
-- 
2.51.0

