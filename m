Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC5FCF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 03:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D3310E1B7;
	Tue, 24 Sep 2024 03:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mQRH+yEC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D814310E1B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 03:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwQiY2nXn+QeoSYWVCTyk9xMm//CR0rXw31dcVtN8KwMfo++t1qX4uJgcZR9VyX/xXExTf6ERUKdRywCbWDRkYdFGDWUiiKYcInB99g71T5n9y8xwWBl6nOuldDxgpOZrNJuIlc/xED4Q7zt2mJjN5f9BqrdjvTqUUCfRTeID2uQs/zXikT7KGPZneqX5sAxo2fKybPBtega7FiDkmTnkkZ5huxbWcU31u/irKUAzPNM5Dj7O+GrBTJ4AyQ50Mt2XCbEhBF7/eUpPC+JuhSYy6cGgP+snPEdrfmc/KLrjS9XcMFqXNZ0JirZij5ZbrAGOBjXKbFkeMKD73YCSTz2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wET45GNja553kgurtQq2gNYWOJ6mSWBUsl7JPhDniA=;
 b=BSxpEY8m/7VX1geYcyTKECdRPKSnH7IgN2RT1vJj/ttPj6Lrq02Hcd+1ZSggcFQR2oZPRCXkoByByYEluT6EF5Z/37G7+utfcqgIvAEBOhCFU6U+tLOCMQ124teY+iOnLufi4wWtAK6/jx2akLQdqzklciZyCKa9AaU6ut6yXyno4dx2G1ZA1f8/sQIZfuahN8EwZK+MVI/N9H0MzEvnyMw68AfVE8BXpsenxe0xuL1i4AoJk9UCmY+xhA4rW3LLXHzllYVWsn9ntPnJof2rMQd90bLkQmTkC4wCevhCHli9mibrWj7PPomEw0TRDL+/ZxMXzrhfwRdNQI4jUwfHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wET45GNja553kgurtQq2gNYWOJ6mSWBUsl7JPhDniA=;
 b=mQRH+yECnFKFCkkDuRl4HjCjQL1hz3bsfgkgLnwUoqrdN9SuRuLFqP0L6uSG9RxcQ+GpjZys3glISaujPEwhr1YtFLGhhC9V7+jgxu/hvDUsMIYIEjIWVw4raWzrKfyQQxqW22E9QwshP184XcFKY39potUC1GWvZHRL1LAqGCs=
Received: from SN1PR12CA0098.namprd12.prod.outlook.com (2603:10b6:802:21::33)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 03:42:15 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::4a) by SN1PR12CA0098.outlook.office365.com
 (2603:10b6:802:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Tue, 24 Sep 2024 03:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 24 Sep 2024 03:42:13 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 22:40:22 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <yifan.zha@amd.com>, ZhenGuo Yin
 <zhenguo.yin@amd.com>
Subject: [PATCH] drm/amd/powerplay: skip enable mgpu fan boost in SRIOV
Date: Tue, 24 Sep 2024 11:40:12 +0800
Message-ID: <20240924034012.237955-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 544a67d4-f6f3-4734-a0f0-08dcdc4ae0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?86ghhj9CULR6SsxP6d7JY++Qwz50wE1d1Gwm0S4FAbjOvTys7Q1FNoBtPJAH?=
 =?us-ascii?Q?bLfVmqiiwl3kgmJvabqGJTCCzkiEc9F0fJEmHzX45lCiT8CPAEArTDPjQzZ7?=
 =?us-ascii?Q?xkOrNZ5CQNtIyItVEf8X5WOMxXm7hbofvkeSMLGfh3eFd8WlxuRE+sl2no0A?=
 =?us-ascii?Q?N0S5RDGL6hJWoZdbSFgL8x0XT+cOCHYePRkPA8AFH9rtcc2otAJeUkSVpCMM?=
 =?us-ascii?Q?L4PellNHyygeoF7SY5zS6e+zCNI2vc0anWrHye2T9R5JLU66uTApBvclMgqQ?=
 =?us-ascii?Q?5sk+3tp/t27k7yFkyjPKO1YKFYlOqi/6jo0DcENGXVj45qmph7ol4aTlKmZV?=
 =?us-ascii?Q?LxuJnicJunanahPMVIKnjX/Gmz71JoZNMyF6Xmc/PfN5dZQfVhEZfWjVrcqw?=
 =?us-ascii?Q?Oehvwy1BmHxRrz4NgKpORMMiUA2aCGfi6b5Rsoy1ToDbl7bEGVtZtiuoi2k6?=
 =?us-ascii?Q?r4GeaXPNmtxfbd+je5cQXiOO/1nea3JwE2R/ANnwSZOG9EkQXr3FTUbgYpQc?=
 =?us-ascii?Q?+U+jrdZk5YJzI3FVH8PidmsxFRWd8jT0ep6ckKeZ0M9hVtdS3ZE4PR+RlBAz?=
 =?us-ascii?Q?Ai+VqGZPl4x/MDKLygUO27Cb1ONpctFZvFgJOa0bNnhVSr1jBLwldhJJTdZG?=
 =?us-ascii?Q?hqGuqvZt/APZg0htFIpREQRXkj3WNhv3M+TMf036y6AaLvWV7cDGeufTF2pG?=
 =?us-ascii?Q?dzqe48sydBUvawD75p4jVmuwEl09yGrVMyBQuZMfT+zWMA0vduFuK98NDfV4?=
 =?us-ascii?Q?whQUGZSm4ckWChhYBuL3k/y4UHSRAISFrFkojOrASH4xefevtxDmmSoeMQ4D?=
 =?us-ascii?Q?kceV/X9q6wkYaS86ytQXcojGvB5OuYQ0a4yBfA184ClExenwWF8cb6g04u8X?=
 =?us-ascii?Q?NWx2rKzxFxgEtiXaXDHUfC2ecDNc3zqWqoHwG8F+SiMOJP19N78gO9hFL8gP?=
 =?us-ascii?Q?m4FqJzdNdKz8Xr5Wq/y/0IIE4Zmd8jv/bJTlgQRy8ALYlvPuQjWAbToJ9x94?=
 =?us-ascii?Q?yd5EkLa8mnp7xdSZEQ2jDx02QoZs0+OgBsi+JpPOvgAhmnEiOsjy8yry8TB0?=
 =?us-ascii?Q?j5TF8UBMrDz2fIVZHSD11BML8w56ovg5oOIKNNK1wezOehv1sOZV3KmG/6bD?=
 =?us-ascii?Q?TamWS2XVKA6LUW5oaC9Hptmy5L5msdwWiS20NqVu5qwvzWZekfPm5nssp6gC?=
 =?us-ascii?Q?nCM9lV9Y/W8KAvLUNVQR//vjCF8dfbOa5Q6CQnT2CWBF4IF5FnFqpbG6PomT?=
 =?us-ascii?Q?ElbMqnaVtM7NGjaU9K8IZrLMS7sMt11TW1BvlZi4WtZm/J9IzLUfVbibWuLr?=
 =?us-ascii?Q?mV29mbzk1+S1fHkFBCjlPvPo9DNBIMI0Pv/asBHfbt+6bGwEkWc8bL+036b0?=
 =?us-ascii?Q?mf+er4SUi7CtDEx6eaPIF0ihLZXP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 03:42:13.3315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 544a67d4-f6f3-4734-a0f0-08dcdc4ae0a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863
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

SMU_MSG_SetMGpuFanBoostLimitRpm is unsupported for VF,
skip enabling mgpu fan boost in SRIOV.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dee57f15719e..49f320fc974a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3178,7 +3178,7 @@ static int amdgpu_device_enable_mgpu_fan_boost(void)
 	for (i = 0; i < mgpu_info.num_dgpu; i++) {
 		gpu_ins = &(mgpu_info.gpu_ins[i]);
 		adev = gpu_ins->adev;
-		if (!(adev->flags & AMD_IS_APU) &&
+		if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev) &&
 		    !gpu_ins->mgpu_fan_enabled) {
 			ret = amdgpu_dpm_enable_mgpu_fan_boost(adev);
 			if (ret)
-- 
2.35.1

