Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F14C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC0410F350;
	Fri, 21 Aug 2026 16:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LX8ieRLn";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA2410F350
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkGd9ufxul5FGQ+fsR+yJW3e8/2BescjzW0kDT1xm+CZ6RMmjRYs6aPdOUNb6NdylJD+5gS/BRVPOvXFwUCG8xXWbVWRsQU8WCzU/CMOcvIz8csTLND3g3dW2qH684z5Nlrjnt2NBOQGAShVlPaP1CVzGGjwrRXuVmSOo/3MPjE+BjfayharEJ7e7i6tMU7fFw0pNF1xOtJYmpyuXrn8nyeHr+qGVYwW5T9VjY1WtyyWJdnqF1DigqzQa4ihpvpazvZh5eQ05IopHSjg/utSiPO4UGVRG6znYjeCETjFMb8tIBiEPfbqykzb3frop9y4yZsc66eF4RKD9vVwTE8b9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GwoPprDPSPhk8F3YuPyrSvWz7WI9wME9GasvvROouc=;
 b=mRWtm4xNM6rfniQ9abOW03/mgrj/AqX1YjP4F7Q90kZTmdIdB/qlag2IU78N14KdYvi5VgWSjhSead3nBZ9eeQZzgS3qXxJ4tngw08JtHKn3CCGxcVI0pFk/oB30ggh/4QrU5l5337nmpvDQ6hy2RFySxpKfMl6npOkZEX+iNzoo1ZoGSpkG9ZAZdNqkMc5nMIR12UjLzQM5TCIpWwqlQYS/oNGmc80b6I9vah3c7olLQHtso0KqdzHHb7HlBLRKnZ5a9BZgM0uWRs/XSBqAZcvfUUoBNEX4fdozPrdH93iT20rzio3/Ey8dt/Yt6N/Fw2GBLYaWPEbwXTOLXkaVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GwoPprDPSPhk8F3YuPyrSvWz7WI9wME9GasvvROouc=;
 b=LX8ieRLn4xKKEbI7Rc4DnDs17Herw/ccQ2arJOv5+sdNTGzuQgI+BJ+qyPhXxPib3rJYvW/OEE3nNFd3gVZ2o1GpSbIecW48+wi7ZS/tVlDeqy14cTV9MxkPkGPL/Da7Fgz0AQy1norNDAGVvh4gYkmxdDviUjouSFILV24cZV0=
Received: from BY3PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:217::12)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:07:28 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::44) by BY3PR04CA0007.outlook.office365.com
 (2603:10b6:a03:217::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:26 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/15] drm/amdgpu: Use max SA WGP count for GC info v1.5 CU
 config
Date: Fri, 21 Aug 2026 12:07:02 -0400
Message-ID: <20260821160710.752459-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3828d7-ad9f-473f-61df-08deff9e4c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 30i6gOfK+ofYgFVyZHf6eQ5uhEzNYzr/1are4rQOzFJM5SDouwpE8EjFiimQVx89nYdQq2HkNjCzXfw4+vO89xgNKMDw+5C7/DDybgAJ002V6kAm+xQgI5x2HVTHMyE69guU3gl33zZymkCHAb1nbxCQTcHDmZK/V8DvIdIn8e9sm/TO4oF7gU6w/9zGYQiy+yZ7Oe3YTdlK5ITErwE5n/3YjE2OZ6/Zhd/CHIFynNWsVSIQ/6TqyNkczRRceT3ts4OiRmKXfTBueevvRybPE8C3ia+mFXyiKgtMBlObOaKcSrKaywaB2bzhZIrPYbr2HU6S4srv3SXnFMQtG5t4t5TX7hGUVMCMFvt+g+pzcKww/HMQyy4fsjFYqvwY/0vx/dfQso/Uu4cnUBmQPeQAGvvXdY8lDYPiJWr5WmQvCC8ZOtCBGj93EOtvIPx+iWS7nuq6KNInU1mdqhQsdpYe8YSwgLU8KxFQ70UaMoMisfAaA4KZAtFUfMpCBd2o7V54S4+C3WwUGDWTK6rwt1TCJytsc7BY1oD/Axpy3vL74RuZpGyumRkYBMiikO7FcFbaoUzxzgVrlPEAbVwTGgqDmT0CQMywuX7wDfh48K7kCMOBEFoJRZTzF33aIGHiy5GEX175FzQpaJ3t7vg5IwU5xnHunRtBPTjMpBqmJ5sqWMnJ2/JDRk1k1jxHxyluN57S2TLDa9ZqIRemFkYbcIarDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ow10cb5GxFn03toUYdtl9zT5iKTnJ8I03Xg8fvuJZYbuTApLXYQOC7/hfKHAewEKw08AlP6Phn+J1fCTwBJwChKoBVbKZA1W3Hl4LJN2/rPJQCT/3xVk9fNbw7kFoNQqZcwyKZobfbC0l2yyi1brzPwK+oMWeqlp+Pj3vP+1ul8qSpIN3b8Ts30W7gGGmJNW6aPq6tSx9fnVM9euU1tgKf1e5Xi5CIppmObBSqdkChkJjUyEzXtxzApCBSwaBDQODgA8Tc4H4S4swPseGMlucCkDwUT6bFvKjo255wTjDihsqEnSxCUkXeJXp4uiPHrwp2zV7pVDiVdPPwWbvJfbiXe6xgRCu00nw371l9X00evR4xIg561oE/3DbNhk3M97MJuxfv5dA5xi+GCIJHlYnldeeI5WifQGxNErzrFd3+D8iQ1uU0ebMhcxpnyisxRL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:28.1645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3828d7-ad9f-473f-61df-08deff9e4c49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

For GC info table v1.5, calculate the WGP totals
for SA and SA1 independently, then initialize
max_cu_per_sh with the greater value.
If both totals are equal, keep the SA value.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b567860aa555a..5488715938b02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1997,6 +1997,7 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	uint8_t *discovery_bin = adev->discovery.bin;
 	struct table_info *info;
 	union gc_info *gc_info;
+	uint32_t num_wgps_per_sa, num_wgps_per_sa1;
 	u16 offset;
 
 	if (!discovery_bin) {
@@ -2070,11 +2071,13 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 			adev->gfx.config.gc_max_num_residency_ways = le32_to_cpu(gc_info->v1_5.gc_max_num_residency_ways);
 			adev->gfx.config.gc_cache_ways_size_in_bytes = le32_to_cpu(gc_info->v1_5.gc_cache_ways_size_in_bytes);
 			adev->gfx.config.gc_reserved = le32_to_cpu(gc_info->v1_5.gc_reserved);
-			/* GC info v1.5 derives max_cu_per_sh from the combined SA/SA1 WGP counts. */
-			adev->gfx.config.max_cu_per_sh = le32_to_cpu(gc_info->v1.gc_num_wgp0_per_sa) +
-						le32_to_cpu(gc_info->v1.gc_num_wgp1_per_sa) +
-						le32_to_cpu(gc_info->v1_5.gc_num_wgp0_per_sa1) +
-						le32_to_cpu(gc_info->v1_5.gc_num_wgp1_per_sa1);
+
+			num_wgps_per_sa = le32_to_cpu(gc_info->v1.gc_num_wgp0_per_sa) +
+					  le32_to_cpu(gc_info->v1.gc_num_wgp1_per_sa);
+			num_wgps_per_sa1 = le32_to_cpu(gc_info->v1_5.gc_num_wgp0_per_sa1) +
+					   le32_to_cpu(gc_info->v1_5.gc_num_wgp1_per_sa1);
+			adev->gfx.config.max_cu_per_sh = num_wgps_per_sa >= num_wgps_per_sa1 ?
+							 num_wgps_per_sa : num_wgps_per_sa1;
 		}
 		break;
 	case 2:
-- 
2.55.0

