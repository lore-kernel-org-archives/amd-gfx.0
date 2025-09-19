Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B20CAC5A5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 08:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E28B710E967;
	Fri, 19 Sep 2025 08:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JZeeJ3yI";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013025.outbound.protection.outlook.com
 [40.93.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261F910E966
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnxcWX0l4I3R/fgzeowcA2me1ULX2RMc3FG6kn9PPAFeR0xLyMH7W7HeFzkQP2kC6R2VGrjB5Jlk+Yx6retQ/I7+gRvi0Otg0ybVfp0ADW4aMnJddrZhIYxO4f1njCY+EDbiktulY7N2C5lkirayZrREuIMk1ItjlC62MeEVT2P/sLeiaftqDaY9EWX+vz4abdIdYiUSdEL9bZECCo3+bGnszE7OYcGTnra5nNCLR9bmkFbre03tYMC+ngG8TnOLFkasjywWcabNrycTGEGUlmi68wE3N8OJkpJ6P69ZAS6dTudStioWLdDsgwgACxDzeL04Q0dZ07fPhwvlyj5Vxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjxTl6cQrhaYCXuVM1rSVprcVp4YxESKnpmlTbd7ptU=;
 b=VJz9rQdG3Fck8bl+JHbG7Hv4qPXtHnPJsgGrWg8+bb4fh7EfwNIeJgRsKI4gacS475CO5eNn46J5VDlBT1yjSBCp4fspUBLeMaYbmgXPHOtNlRNf3CQXY0w1bm4NScF1Xix/HShWp1yu0hT9+VUCCvUoNcy2oB2bDAzplt/a8+qmM8HpKa5uTUWz8cdxpOKQ2OemASZKpI0GBIUjqDLQvHyJUs1zFK8MSLrAioVmzXc80N5Q2Jy9BKU8jPsN0n0ygS+PabP31zDbCCg5RkQADmtbupNgh02SU4QkKYhIQ1LRqGm+sligjxhyTf17cPg1mIpekrkojPQFyun4LcbO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjxTl6cQrhaYCXuVM1rSVprcVp4YxESKnpmlTbd7ptU=;
 b=JZeeJ3yIwNwIiqk1QyoUAQ9F/Y+Tg4sr9Q15YJizwJnbZwF1Ey7EUD+Ep769lw8OrzgG2djpjM/XMsaiDZeoiSJq4jVY7mf0O9wzX7AJsa0e/KRmz+mzIMr8wmR1fRMYqXl0OGLSO1KdMvE4btOxC5zMJFdfTATouXMEmabwUpM=
Received: from SN7PR04CA0010.namprd04.prod.outlook.com (2603:10b6:806:f2::15)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Fri, 19 Sep
 2025 08:11:47 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::e2) by SN7PR04CA0010.outlook.office365.com
 (2603:10b6:806:f2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 08:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 08:11:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 01:11:38 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 10/10] drm/amdgpu: add userq invalid VA query
Date: Fri, 19 Sep 2025 16:11:13 +0800
Message-ID: <20250919081113.2797985-10-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919081113.2797985-1-Prike.Liang@amd.com>
References: <20250919081113.2797985-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: a955d350-8ba0-42ea-300b-08ddf7542d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BkKC8TgAd3321StEfDujWcY/r5OvkyNvod6u0X2Qtdon7yGrcaPsyS/8Dlbl?=
 =?us-ascii?Q?4QhkBVvCVPjVOFXXBFIVC5X+XnuBWblpWj3jeLCYL/AHaPD0y3VaBd6+BowL?=
 =?us-ascii?Q?UhzxQSa2+STkHd2h+WwQFiSzDZ3Jr5rkW+AuxIpYr+69FdNyZmIkNMQRQJMj?=
 =?us-ascii?Q?rJTZ3DjisPidQxkEkQ8IxVjGb+x4LXCMCctWbJS3a+glOKmvLhYjQJfnSFCq?=
 =?us-ascii?Q?488Ug/UlY81YCxDNeH4Jg4xv231Yyfft5TfUHeSEm73iOJgiKrzTnOQhShJd?=
 =?us-ascii?Q?xuOIm3eVGqOQ0vJjvEE+Gn7Tf9quD6mnTmO+E7O1Hgwuo38fx8mb2aVLM3Dj?=
 =?us-ascii?Q?cGVtEoCNel+5ddfdDe8LyYeIR9jKGze4q+dTOt7Bo6c/m2O3Abyp+vd5j3XF?=
 =?us-ascii?Q?Z6tRLGrzkTZk1unlZu/U1JXoJvdqJjDjjH9jmc0Jlc2BfRXMVVr7BxZgkvlr?=
 =?us-ascii?Q?iYiODZstRMgCq9d/hsV2XjjrpG4ZfY6pphwsHQ8ihQdd1RNip09R7wfB7fHd?=
 =?us-ascii?Q?d6QsTyx8I/b7qB4qWbLai6rc6440MDgUvf2X1d7QPuKXt8uuGEs8saF+hL6e?=
 =?us-ascii?Q?xP+uC0U09PXYcQcszMzJwp4pfdSd//DoY3SwpRgSkgsU6ml8SYfLwaFzYSU8?=
 =?us-ascii?Q?7birczp3I7piMzrE5X8qKB0+xkxi21xeIRHjzXL6HfU5OGuvyn9ML2czCldI?=
 =?us-ascii?Q?qWD+eVu0yCMT+aXGpM3oiT73SU4U4Ewa75dHWX3GD/MYNh/6tIzdsiJVGib/?=
 =?us-ascii?Q?Jt2Id+xLGunuYm4pCJf3P84g6vVhd2X42bimmsLwn0zs1dSRjIpHTYApFasr?=
 =?us-ascii?Q?nkldQW5HZwtHPK1TK/0AcgIMn3SYRWkuqMyW6Q5jvy5mrvBBzOqyQdfqwAme?=
 =?us-ascii?Q?W/uNN2EmM37nbSpjK6ZPZwjTtzezdoR6OypCsCLhNS63FWevZXRUmLphoUV3?=
 =?us-ascii?Q?eQuJ+0bIo0WhWd0XG4YkMbtuL56B/q5O4e9IEYZy1pwDlrUUg5HnrZQTT2M9?=
 =?us-ascii?Q?CvDtLKGOq7rl5KKd5G9kiOH09A3UoXcaDgyFl6CHodxHHLcgBeOz/fJ48zV2?=
 =?us-ascii?Q?nyb8QSO4vwBqHLWSX97HqWW8a8FG85cpAWqs+3LQxkGksobgG8mL79PDrgmx?=
 =?us-ascii?Q?oUjtHPvUpRVe/fsE0XROpeOxl26AtsMUf//i7GqAmYE/y3cCAYckc9+uQwA9?=
 =?us-ascii?Q?NeM+V+LwEfVi59mVo9K3WB2S8LPQt8Y/t99gvN+4GfyJMYW8XCtB1reXIg6E?=
 =?us-ascii?Q?u/pdlAemQNvkR4h+/Er9H4EQ1JlRkijRcLZZzV1TBVCQE9Tc+A9L2WVyuKu4?=
 =?us-ascii?Q?waiCESBVkn/MqBr5Ppuy6JFfITosqvDRbamUp19f4flWEy0AIpke95U3OgSr?=
 =?us-ascii?Q?bMxH5JorXzXk/pItVlWWSPeDfgC+7cjpKfKmj9vI8voE9bfZU0SNllT2ZW/G?=
 =?us-ascii?Q?TAgyflnXTmxfpnHpqCyCd32ZKVLzMTkiktF/wUkvexD481C7hqIA1rq0UWzH?=
 =?us-ascii?Q?IH6tuLe7wu/TePH8ut54cGBDG+9z2K50q8+a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:11:46.8569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a955d350-8ba0-42ea-300b-08ddf7542d82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
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

Add the userq invalid VA query interface.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8ac7236091fa..a5e7e279b78e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -723,6 +723,8 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
 
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	return 0;
-- 
2.34.1

