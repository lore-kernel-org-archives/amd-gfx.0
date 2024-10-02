Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43921CF3194
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2F3F10E6A1;
	Wed,  2 Oct 2024 04:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tgZZEtyz";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6619F10E6A8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o31D88cQAOu+q4CYzlVbilay+1myoHr0DVIB1y0c90QUBrz5iE4O4K5OgNWpivVEPzNw1in8FPbV2fYsBVEcgdZiGhRzllN6rrwvUIjTzdAmYYVXXNA9cTuPDJOyqBB1Vz9vnMOLeMYtpGYlSZshxVOjd84VVjf9fWQMHDaG97DOiYkGK9X6ynz2L6O+zU5rW2xoHUTiod1yMrPMOu22e+bpqcHaukrBSMhQ+PobmjVB4CmMWWV1QBZvzPKUu5AjLNM8iOrthclWrYfGaPPMt8PwrWuhEvPPuE6fXh+8eB8s+4jmJ6gucAgH0w7GUn0b2gzMKdtboWZS/C/AkBD7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIH2zD9UiwcRe7hV/Sv37zMa4N/14gGagFR4llZcr0s=;
 b=wWjpMN2juMQA5+ug9QnGaDatzetBQLQMfAsIGssK/5c8tLy3Dzwxl1h/NQQ3Ieo6dhgl6+YFSCQiprK1k5zM51bZ7BH37AV/m1sVcPevuj6QK3uFST/Fe6lijougFwBTbMwTLR+wN7hPRDpb231AmilxVRjKn4StQ/LlLtsBPOU02Q9fynPfSfr3YWVzfOqWSP9pNzteU3AvGsqU2oMGQhn4zYxnZNNlnaXqxBl28kwJ2aSLL6j0UMqAEZbVvr7z/DRj+xJHVC7XCGHRVWPyzyAxQjT1oaBPLpwfERl2JVx+VfkRh1WxW5AwkhuU8+q/2JQCUEWBGEug1/2qriotzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIH2zD9UiwcRe7hV/Sv37zMa4N/14gGagFR4llZcr0s=;
 b=tgZZEtyzpP80+S8f+C/FEJTsw+4uBiZBCl/2kYp8FlBTpgajAt+OStxr0wJl3IPRdmPh0yNcEWgxVaG7wNOWaeaZXa5BUaZ94QdMDLWUaYGJcekhdGwBTaRgTxMzwpCY0WcWE+1y1T41SgQNYOzBAh9crlwL/dpCOst5f+baQ3U=
Received: from SA0PR11CA0054.namprd11.prod.outlook.com (2603:10b6:806:d0::29)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 04:41:03 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::f3) by SA0PR11CA0054.outlook.office365.com
 (2603:10b6:806:d0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Wed, 2 Oct 2024 04:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:41:03 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 23:40:40 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/gfx10: Apply Isolation Enforcement to GFX &
 Compute rings
Date: Wed, 2 Oct 2024 10:09:32 +0530
Message-ID: <20241002043936.2960921-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
References: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6d01b4-d776-4bfc-98d1-08dce29c6bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDM2UHhTNjZScDlvK3RjRFBwSEFmckhObXpHSFpOci9IRlkwc0llaElSUTl4?=
 =?utf-8?B?UHRkK1Vrbkg3SERaZzU2VG1SSlJPd2V2VCt5MnZmcUxKQmd3dGo1dUlUTm1W?=
 =?utf-8?B?VXl6d0o4UFhXemg1ZXA5cUEvMDZDNytWdE1xUCs2RnYzWXFyMnJRRWZhUnQ4?=
 =?utf-8?B?Z2M4bWVLZElYNlFGK3RoVER3MUFWc2JpamxQa1dnMnBKWklXZ3NRUzAyWlU5?=
 =?utf-8?B?SHZEcW55R0E5a294NUhhNmFTMTlMUzlFTzdWRElvUW9TSGxFcUJMRDdzbDBB?=
 =?utf-8?B?clVIUjdONzVteG4vUHNuSjZmQ25wRi90R1dDOEhsVmI3Q1h0VGR5Qk5rSlpx?=
 =?utf-8?B?N2x1SjgvN2lwOFUrWFF1a0w3bkE3ZFY5b1Ira2FTcGw1Z01nWUxhcXFWb2JT?=
 =?utf-8?B?aDdHUFRKdVhBNklxNmJsV2tyQjFVQ094bURrOVBmZ3VMbG9qTXR2TllMcWRk?=
 =?utf-8?B?TWN2Q2o5T2x0eWJCL0FyR2U4TGpxMnovVjdhNFFQcWMyeWJyZEE3OWNld2xw?=
 =?utf-8?B?ZFNsc055YXJKT1lRRGRZTjNhejNENVd6QXgyWFl3emZreUR2blQrT1JvbVFY?=
 =?utf-8?B?bGcrSTM4M1VvdjI5WEtyd1JxTXVEa1Blc21za3V3ZktxMDNCRWRFYmQ3cHFZ?=
 =?utf-8?B?dXlSZzdTOWJ5VDlsanN3b2tFOEtHM0JDZk5uNy9GYXluT3NDU2ozKzRkNGJN?=
 =?utf-8?B?eG5vNHRURmZ2Z3h3TDVBcEl0VjcreXVFcCt2U0dTMlhPSmhLRVFhcGw2SSt4?=
 =?utf-8?B?ZzUzb1RDMHNySUxoNEN4UlJTUzNFL2NzMnl2UGVhbHo2dVhTbmtHbTdXRjF5?=
 =?utf-8?B?YTNVNzdQb3I4Zm84bHdyVUhtYnhBWVhUWEtWK0hwVUJsakFaUFl1aTVEb3hS?=
 =?utf-8?B?aEN2TkEvVXE1S3VhVzdRNFZlTngwWDlaMWt3T1hRKy85VG53cisyK09JeDJK?=
 =?utf-8?B?Q1NhYVlrT3E0L1dtNlJhYjluL1NpUjFsSGhhS3lZL0pPSml3bU1lVExyM2Q4?=
 =?utf-8?B?Y3U2amRoemw1cjhMV2U2M3l4eUMyT25BNmJKckhJSWtWcEpqSkpJQ3dhSXBp?=
 =?utf-8?B?elY4NzEvRlM0eXpzcnNCQjFMajVVMkV4Q3kvYmlnNzZFR0hvYU9uVWRTMnU3?=
 =?utf-8?B?eW90V1ZjY1M2dkpUejlXdmhZczR2RVBXMFBNN3h1SC85SlVTRVBsRGllbVJp?=
 =?utf-8?B?M1lFNk85MjZTSU11SU03MFRHU3FWb1R1d3JUZHd1Tisyb1lhcG9SUnZ4TXFJ?=
 =?utf-8?B?ZFVZakxTdUFydjJBeXRQOTZPQ3RaTXoxcXB1aHJIeWcyRVJnUERrMHZhd1dS?=
 =?utf-8?B?dmNGbmJVN0Y2WUdHNnIydHkvWHVOVk1FZG5lNXVSVkdraThSRTE1OU53TzJu?=
 =?utf-8?B?ckZwNTIyOEpVdWxGenBuQk50dXE2T1BkTk9ZZjZTZE9BWUlic2VER0ljakpT?=
 =?utf-8?B?QTYyTDd3SVByM21DMFpIY2tTcUpmT1ZyOGR3c1ZmM0plR2M3anY2Nm5KRTV2?=
 =?utf-8?B?NHQvb20ydzdoUnVkeWxpbHZFa2JJOWNUNGNLbUNDaXJTeVdDRytOU0JMdkM5?=
 =?utf-8?B?OStsYnpxVEt1dWFqZUpKMFJ1NjdYMjc4ZHJYNVRVZWZKVGRhcVJDN2FSRnRH?=
 =?utf-8?B?SVF4dk51U3JsNVdqWTlreFJsZTN1U2xRYUQ2VzA3b0ZmZTczTUI4RGY5Nk5R?=
 =?utf-8?B?enBha2VkQnhtYVNEd2hQelBYczQrbzBLNWlWL0FaY3l2MFlqMmJYWWkzVTZQ?=
 =?utf-8?B?UVcvWkV0NS9YTTZSTnJreDVvYk9kU1RRSzZFd04yV3hnaXhTMnpMczdGeUlH?=
 =?utf-8?B?c3lSQkVSaENHSFBLOFpQSmhHT2RwTHEyYW1XeXFmOHdzRVZ3REpPblk1dmVJ?=
 =?utf-8?B?eEhnUEVaRGFOOFkvSzdCSFBRM1AvKzZ6dmQvUHR4alh5d2hMQWdKT2kyUTgy?=
 =?utf-8?Q?qLjCHNqI8I3q0D/8imRd+NA5ffaN2gvC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:41:03.0423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6d01b4-d776-4bfc-98d1-08dce29c6bcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029
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

This commit applies isolation enforcement to the GFX and Compute rings
in the gfx_v10_0 module.

The commit sets `amdgpu_gfx_enforce_isolation_ring_begin_use` and
`amdgpu_gfx_enforce_isolation_ring_end_use` as the functions to be
called when a ring begins and ends its use, respectively.

`amdgpu_gfx_enforce_isolation_ring_begin_use` is called when a ring
begins its use. This function cancels any scheduled
`enforce_isolation_work` and, if necessary, signals the Kernel Fusion
Driver (KFD) to stop the runqueue.

`amdgpu_gfx_enforce_isolation_ring_end_use` is called when a ring ends
its use. This function schedules `enforce_isolation_work` to be run
after a delay.

These functions are part of the Enforce Isolation Handler, which
enforces shader isolation on AMD GPUs to prevent data leakage between
different processes.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2b230971c58a..57f28cb40913 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9802,6 +9802,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
+	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
+	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
@@ -9841,6 +9843,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
+	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
+	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
-- 
2.34.1

