Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FB7C282C6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 14:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F48710ECAD;
	Fri, 28 Feb 2025 14:51:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IdXeJy7B";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B57E10ECAD
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 14:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVMsiKHrS4+C1XZPpUZHBGHcmetOCI26dnLm/TejS+tPDnDndWPDNDSN82JVW0AYai2XpKuOobaijnWRaMH0kCN15oqwxmdKBi51hj2S4kLAVCgRb7MzoNUejzdTumdNSNMcNnIr/pB/LU2x39/kS1vx+ma2RBFjYIVfg1I4ajKYQHpB1yZCPhk8OXu86+TEXLi9YqBn+bVUzd0HmUshBAL/I+QeRGyz0OsLqIL1Fv5fXEzcEDjhpGBt7Zm1Q7Sebopa9eGPdmZiW7OnhJqDPb5zIdewMWkJpZGgqtBdEW6WEMcMc7ZIUmVIt4k21t7WnH5zWy8R+4X8Xwd+fFHHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlYnRI8Gk2xmmStJFHaUJbLzYhRmzEaWgwe52FXhPLQ=;
 b=BpDBy9T6eRA0LJkBRXUPZL8G7aEkM1lv/lB55k1z2OdMlu18wZHTCz5+67OGez7A56Lcximhi4iDvcoZkmFVMEZUU6fdiGF9wP/n1JI1fHXWxrO8nRhOgHQ1V9Y0g4gCiUSrcZvg9bhIxgUNigJVR754x94EbpzLkLI1lNI/xb6i4OlN+R1I+F3nsdPGkxJZbGO/FSvL+K+0xUxvsm+EFJm92rWL0qCGwd7wIsqU4VBx71lQ5EW+FYVwQf0ICy6Z3eJ7PVwUhlrx6OrWA1CCqvboeywliw2vJxHo8CxyXWXKS0fQfVRepU7HE0jSDoyM+PkVV2n6U0qCvMYOPuXAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlYnRI8Gk2xmmStJFHaUJbLzYhRmzEaWgwe52FXhPLQ=;
 b=IdXeJy7B2l6zaClG6se8Moff/BNMyTmUVhMI75hiRYu5ScTni8OM1g0NhMpJ/IyZkGVhJtev86I/fcYodmTVmS82tawxsQaCXL/XvLb0vQx8uHZsGPeAYJ3I4B0Azfz64/KwIP0ZiNbQeDVf9odoijoiGNuEXZNwk9lNNFFsBeE=
Received: from MN2PR10CA0001.namprd10.prod.outlook.com (2603:10b6:208:120::14)
 by SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 14:50:57 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:120:cafe::af) by MN2PR10CA0001.outlook.office365.com
 (2603:10b6:208:120::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Fri,
 28 Feb 2025 14:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 14:50:57 +0000
Received: from work.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 08:50:56 -0600
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu: Remove JPEG from vega and carrizo video
 caps
Date: Fri, 28 Feb 2025 15:48:32 +0100
Message-ID: <20250228144832.50699-4-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228144832.50699-2-david.rosca@amd.com>
References: <20250228144832.50699-2-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SA1PR12MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 1686b873-824b-42b0-8ea9-08dd58074f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UrRiX5Gcg+5DUzgJHcu4LGLDngwaB3RH5+qlD/LCJGGblMUoqNIsMyqugt9l?=
 =?us-ascii?Q?R2ief5dbeNQtBiBC8NjrGgetX63JcAC7ix1MtHmHheMFW5X30/zGBh40EMeC?=
 =?us-ascii?Q?hAnxuoLjTiZwI1270e8RXlzG58WSwBryuWNWnOUQhIIkCJDfWFQqRlTj+yBs?=
 =?us-ascii?Q?i1jVPvZ0f9CUE+4NMgwJtBs9/htaDkSjhglkdR+Dz/2SSxIb/VQbOvUOgw6h?=
 =?us-ascii?Q?MW02dqxa8JFJi1QCZc5y9aKRz6ui+VeaTD0NB2roHOBh2sXA9bDvdDVQ9mLI?=
 =?us-ascii?Q?yVxZJb6eNXNfAH26PfBSzMaBSG3F6Qlyok25X5zMW9hEfhJlektKwALHmHPz?=
 =?us-ascii?Q?UiA7iPpAcd6QcvUQmJlKjH9kXKeyLPtJBNgbeI7BtN5goD18H/or6gDguikS?=
 =?us-ascii?Q?2UMQ0Z9O9iAYHMANbcKevlhSbsIomE9n+V3YNb9W+VjlxCGD8EaSdnz+7TLs?=
 =?us-ascii?Q?rgkerBWawNKfLRDKtYAHU1/3sYnLZ2XpszOXZnD6DUk3Y2G+MuDM2xKd9WqC?=
 =?us-ascii?Q?8p+AMdnnq4ytPIS44IF4pOQWhCL4zF+e+AAPIdw6sy7muiKM8GwW3agRx9RX?=
 =?us-ascii?Q?/hAkqx2ZeoCLC/3nVYFjeHHVTVei+KxkGZw/yVrFhlwvZmqi4+Dc+aotb/yN?=
 =?us-ascii?Q?Ab/6HM24NPtgjDK5ioTtZHP3XmA2iYbhC48MIvvcq4dAGR/S6n99m+lP2VW1?=
 =?us-ascii?Q?pg0mLzM/Bt+D0aAvGwdmgWkZuAjI9BwF/pa7qg7J9Xcjv63xrlbqmGkYuvh7?=
 =?us-ascii?Q?MdL3A3kPCVUVae3YYlZQb1kIiAkeu4mlRg5YUVjxz2S14S7TMnhI9dML/02R?=
 =?us-ascii?Q?oIWphJk6gjd/MZp2Oxcp9hZ3/Bm7Hz9cxBAUkN2Rljxq2wfhabCsGB0qO/6M?=
 =?us-ascii?Q?ZL51JvoZq6c/gMF3G699M7pFesxCRmNvnfDL3F2sbF/gvdVFDHRKmuuxO3oD?=
 =?us-ascii?Q?YR7D/Xweajae3UnPwAqNNP+/Mmah1WdxF/3kSBLlMighjvEMSSnVSGiY1JWn?=
 =?us-ascii?Q?HgvQxxQ5mWLGj+X206MLbUpy6DrNguux4I2IPLRMRtTjubaPYJptjn1vAHOi?=
 =?us-ascii?Q?5kPExkCOutXz7ud6WI+lULsk+v9j3FaVYqXNLgcOprG8cHF/cgw+0MqugcZ2?=
 =?us-ascii?Q?Cszx/gGgXsDBkpQCKG9EaTflRtijfgV3zPQCCgiONeG6smoTH7a4TH8O5tHA?=
 =?us-ascii?Q?zb6CQ3LRHUblQm4fG4WeELoWS9pSJ1LmVM4cPyC5vICMRRg/QA40zl+hK0T3?=
 =?us-ascii?Q?vqWPh2fz9Dv6Wy8YFfKmAAhEvf6LT62upmeUodqIg9WdN498w1rTdC/Boqne?=
 =?us-ascii?Q?AD9btRooj+0/YdCJlb+pbaaVv9X0HqmBFx3SLDIYoMW96ehPKvzm3ogDLaSc?=
 =?us-ascii?Q?WWYIsLXfFolfB+qncXd7oglYOcsFVdujsU/2nXg+w0yalRX/C+L8f6smpxsn?=
 =?us-ascii?Q?VDc9BrRg2CkJfe6C1V8Leu7H10r/1uVZTurC+a9D30vYx/lhLWhnvEIQYhwT?=
 =?us-ascii?Q?Ksha+W4Ew5pcvAs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:50:57.6080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1686b873-824b-42b0-8ea9-08dd58074f65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516
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

JPEG is only supported for VCN1+.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 -
 drivers/gpu/drm/amd/amdgpu/vi.c    | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index d6db75258e66..659eab9b90be 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -107,7 +107,6 @@ static const struct amdgpu_video_codec_info vega_video_codecs_decode_array[] =
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 };
 
 static const struct amdgpu_video_codecs vega_video_codecs_decode =
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 9b3510e53112..86d8bc10d90a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -239,13 +239,6 @@ static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 0,
-	},
 };
 
 static const struct amdgpu_video_codecs cz_video_codecs_decode =
-- 
2.43.0

