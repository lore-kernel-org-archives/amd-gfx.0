Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFF8C3ABBC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 15:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E7110E6FB;
	Tue,  6 May 2025 15:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AteB4Tju";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0B610E6EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 15:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3b+SRzFESbxLycScoFbG+ME6Ir+pZHbb/NKwwKNo+9b8TIJafC605ZGsolx2v2ogq3P0rebA3/VRyBbWBaUWVVf5t1ftm25cvCFPsZZScQGdo1IBTdyH8WOMzmOvm51/6JZzjQdlzrP90vg9K+JqlL7gRO4rlggFZvQFSJWuihMLMBmB9w7I8g9H1sKgDf4G1i5ECIWDTFHzyDB4KeSwUW6Fs5P6eqZjLw7C1QOTa2rMinEaGMS/wn1AJwF5yHF1CwBh703CrQjKbaBPxnv45yym9u4MsuVfvCTHHfYuLrddRS2QWH8sC8MIYjjD1S9un2hP19yM1WfFkjZypJP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbkJK4/bcRM54nx/JSNN6XaCmLd9tjET6VH52W7ZEi4=;
 b=SvlCIsDNHM4yHTp3lVsXuVDFZyiwh3AaUq2LRXtAyoWWTX3BbkVWRO1iMrvQFhvfmcRl4Ns+yagJENU/LIInLcPiW/hk8X1/AcBxOx+MPR6f4dXUrxIGmKzpVz7Z6vlaiBM0nITCEGdfNdxEGVdYOhyLSOl4zFax8bCqcPiIm/SLqmunnE/cXpFJkJUToZnP+1D7e/8PBfY2xDWsXXlqoCZmo0H0vcCy52FM3nGmttgCF50hHcD5swKQp/HQyQK2MwOcHvt2ptM1JD9YG5D8mi//BCtW6MYs9uyLt84SZe35pySzCvOBOvVQKZGvR6D2H7Ly4lcO2khF4rRuxRIVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbkJK4/bcRM54nx/JSNN6XaCmLd9tjET6VH52W7ZEi4=;
 b=AteB4TjuTOGJCGhDWjaODnxpj0asKCtqwOqPzBQVa9o5P02Y+Qe86kSDMfvB4AuTqStgJcxe2tQJnSn05h/JB3P8AGKrOGNMkr3QGFu2mapr5seA3V8giptF4KxrtO6D34XnGtP1LiCQvy9t7PPlKfbX/Y6T7l/wkyTJtak5FbQ=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 15:59:17 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::52) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 6 May 2025 15:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 15:59:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 10:59:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: add mes userq reset callback
Date: Tue, 6 May 2025 11:58:55 -0400
Message-ID: <20250506155900.3866874-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506155900.3866874-1-alexander.deucher@amd.com>
References: <20250506155900.3866874-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: bff7c73d-9b3e-409d-ee74-08dd8cb6f453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUc4OHJGK0JrNkxXb1gvbVE5RjBCTGswZlBlbWdiUnNmM0F6bnhnRmIwdURS?=
 =?utf-8?B?dUR1YzFidGZCMUQ0WmFTNE5PeUlHNmZVTzhCUW90Tk9xUHJYbE82THRQT1Rq?=
 =?utf-8?B?SWo2NGlaWG1NRWhaUkE1blQ4YXZ6WTRPRHYvdm9YbWVsNDFsMUFlZ3Bab3dr?=
 =?utf-8?B?WHp6WmZRNWpkNXZXUVc4bUVpVWhxU2h4YmFtTlBlL3FOcDhCc1ZiM2ZxMGl4?=
 =?utf-8?B?NXlIQVpqekNYZGpvZ1dNU0loeXZXNUt0SXl6d0V0eW1DWk5mVmhtR2doTFRy?=
 =?utf-8?B?UTlMa0dlbEMyQ3dwNUFWakxJYkpuS21TTEpXTGc0eEM4MmJrRUEwOVZFVEFh?=
 =?utf-8?B?K0RiWWxLNjcrYjQ1N0RaVU1IaUFlcXlMMDc5UGttTXNIYk04VUFPYVNBVmZj?=
 =?utf-8?B?SHhpRi9CRUFqSUZxOFBMSXJ0L0RYNXV3emU0VENWMVdEVlVXWkVwSnNkMnlX?=
 =?utf-8?B?eFB1UWRPdzdVWkViMjFiYjdhTUZOK0JUakRNdXliWjR4QU9Ra2Q1WnhKTTNM?=
 =?utf-8?B?Nm1maTFRbG1kZU11VjRPYUhGYU01Wnhvd0xxQTF5UzhLYVZ0WitaRG9MY2ZW?=
 =?utf-8?B?bS9RVHVzNThJaUt0NDNqaWZYaEQwTUdqREprUHFvMzVjbE54aTBqZzV2b2or?=
 =?utf-8?B?OC9kYTkrc1hzR3l4VTRFWEJGbHlIRmY2QXR3TXNTWk9NU3o5djk0VkFwN3g0?=
 =?utf-8?B?Q3BsU2xoRzUvcVAwbGY2UHd4cE8xcnpOS2FMTUdKTmU1T0RkM1cxVUZpT1Bo?=
 =?utf-8?B?d3VOU2p0MW1MVGUzSVBibVVlUnc2c2J3R2dxYkZ3eWtyN0tHOHArSjVSYnl6?=
 =?utf-8?B?V2tTdjBXc3YvOWdaSnBwUmJ2anJUUDQ2a1FDeW5jbVFzbkdYdVhnWEhSQVM0?=
 =?utf-8?B?TkFBMEFnejIwRzVOV2ZEQkhHSVl4VnlQaFJkdFFscnNnVnNUL1I3QjVGUlpk?=
 =?utf-8?B?YU1lcnVqRHBRWDBiWHRGOHc4SityV1pPRUpHb2dlV1hqWGgxc1JRL1prTkdm?=
 =?utf-8?B?SmN0Qzd0dG9zNGg4bGswc2lHelRjdmZuYnlVMDlhdk5jTE9UcW9rUDNUNUpi?=
 =?utf-8?B?Mit1Rm8rV0MwZkRCdVpYRnVwVFRzeHVRV1NZRkNzRnJVSkJhNFAwS2lILzRD?=
 =?utf-8?B?aWZWWW5HeTB3b0R6bSt0akFKcjNDN3UrSmY5S1pGRTEyWk9XU1hYak1tbGZY?=
 =?utf-8?B?T0Qrbkh4NGJQRGFlOHgySWJkL1NLWG92ZEtwS1V6RjE3QU54ZXcxL0J3bVYy?=
 =?utf-8?B?YkFlMWJQNXZ5enBnK0hHNDdlRWQ1Yk5HSHp1NzJzRGx1ek9LMlFHcWNIQVJy?=
 =?utf-8?B?UTE3T3NSRjhya2UrZlJvU3ZXUXhtQUhESXpkOXBITFI4ZnlNQ0JkRkI4MTl2?=
 =?utf-8?B?aVE5S1o4M3hCL2RkTjFTUEFSMVBqUzlZQndzQ3IwS1JZUk1NaldEczB2cFlx?=
 =?utf-8?B?NERlTXZQQ1ZCZURKU0VWSlpQc0UvU05JY2QxeENjWlVoNDVlZUdwYVRZK21l?=
 =?utf-8?B?TVg3bkJqV0JxL0NxMEhTek0wRlMvOFgzSVZRbUNCeUN5WGlEcnpHSE9ya2JD?=
 =?utf-8?B?QWRQWmRYK2hyT3FIaFJWZFlaQWNSQTRnOHlOaHVya2VOeWJNVjhvOWt5WWtz?=
 =?utf-8?B?U0NpUkszYWJDem43aHZqTk54emgwUUptSGhUL0FUd3E3VTFISDUzRFAxLzJU?=
 =?utf-8?B?dWNsMldtRm5IbUlMWUhrOG5IOUk4OG9XYllyMGRPSFVLSmI0cHBRN2EvM1dC?=
 =?utf-8?B?QXd5YTZRTDdGVEhPZEpEM0V3THN5elhJeW9iejMzaDcyY09oQjlFdmZ0aC9G?=
 =?utf-8?B?T3QyWU0wcjZRa3FMN1ZobUhONTlVcGNoZmpMVFpiSmZGcXg3TlljTDJGd3M2?=
 =?utf-8?B?MzUrcTdXb2lwVVZkOTV0aDhxWFZLMlNpUlNycVU4bkNKTU0zVWFJWlc0T2c1?=
 =?utf-8?B?SSs3ZHZaa2tYQ0VvM1dsSDY5b0EzK3JSWStsbTdWSkg2YWhhRnowaXUzcmVI?=
 =?utf-8?B?YmlKQm9IbnYxOHJyVG1jb1cvbmJDcG1GV3JXYjMyVnV3ZTkyU0JKQkM5UFcv?=
 =?utf-8?Q?o7nG9k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:59:16.7109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff7c73d-9b3e-409d-ee74-08dd8cb6f453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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

Used to reset a hung queue.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba0..650fdb68db127 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -347,9 +347,30 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_reset(struct amdgpu_userq_mgr *uq_mgr,
+			   struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
+
+	queue_input.doorbell_offset = queue->doorbell_index;
+	queue_input.queue_type = queue->queue_type;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to reset queue, err (%d)\n", r);
+	return r;
+}
+
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
+	.reset = mes_userq_reset,
 };
-- 
2.49.0

