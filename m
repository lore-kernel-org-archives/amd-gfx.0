Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAE7C83F34
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 07:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A4110E608;
	Tue, 22 Jul 2025 07:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qPSc33ik";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B95F10E30A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 07:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wO/lMhuftzZzAgfBgWZ6uNt8XpiWBoodAVhoaRDyAwDZym57Vnld1IZe1hB5eBKBO4ki9G02/LpBeRjBB9WjDmTeGTauhmsVQnWhjZIhaaKFbSQMwqnFnrqV5MDcS53fh+psF05a5oT/HnBcPKPevM1iQpBAGNC9o30WqQ30PP5RPOy3XWGO2upFKyJR29Xil+Z/F5uvRoSsACB/PE0sdMXIJtRt+QtVntqtxT821VwwoRMDWz0u2kyIpnOOHWL4zrUlSdPci1OxWdysynU2a/owKKwvcDWcaQ1euZ/noNaxnVJ13GyoLKZFVA4YLZdKoEIhkXDzs/bkgLJd8o5Igw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fqXyZVQFX/ZBh/ML/luGKld4KvPRG9Mv56GshTOrbc=;
 b=cicKUHMTkJMxVmlnvrlxf1wPG62MeKkmD/cgS5QQKwKx/JTIMikrgcu2O6QUx/76iBYySE+94SjVoohnm/MsrvnMSugKNy8AMBBwisElbZSIvEupUEco5qDaqxxKiW/YwnrgP/ro9nsVITkwSeh+6dkS5l98O1c1HNfuB1UqWzWe6yldw4rQue8RFfonQe8tLHItwXD9oQeTvQOBa/TJamkcGzVDWTEbG50F/Xls9BmFuteC7p+USazDoNC5RGKEUhzSeaoG72GESoeFpvBocvHpajBZ/d+JV3Y/SZB/FZ7Shl/3ZF92h0Sd7TL60cBA9HCB4UZHqr+rLkGdrimINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fqXyZVQFX/ZBh/ML/luGKld4KvPRG9Mv56GshTOrbc=;
 b=qPSc33ikbeugO1Umua7Uu35oFszrk73JP/g9YPsYtYpLkm3AF4ngDiSG2An2Zz5YsXpLyEYal0ADUK0mQ/HiTGcD8qc3SPBrwSmdErudmYJZ5+FdI/fHa8OO1Tdk2ZBGJD32Muv6rYZyOGWQIXx15aWmi+z9wRtrWzgBwp+HNbA=
Received: from MN2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:208:23b::33)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 07:46:39 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::42) by MN2PR11CA0028.outlook.office365.com
 (2603:10b6:208:23b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 07:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:46:39 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:46:37 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v7 02/14] drm/amdgpu: validate userq hw unmap status for
 destroying userq
Date: Tue, 22 Jul 2025 15:46:11 +0800
Message-ID: <20250722074623.1464666-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722074623.1464666-1-Prike.Liang@amd.com>
References: <20250722074623.1464666-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: ee574d49-3257-4f3b-6083-08ddc8f3e4ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OZ3e+JPxzpGS5p+NOu7JiRQ9S6xg8+VLmwA3RH8cWRRdbWTYIxthsGUofAoG?=
 =?us-ascii?Q?U7/DAqUqLFVYY0tUPVhX1GR9+CUNoF0ffsBNxUlL8jUI3XSDvCq8ZAjLL97+?=
 =?us-ascii?Q?T9DxX5fc8qKTedLqqMRXkp0hFPhNGmmMojCFSCQow2wyukSbMr2YE6t+ywxu?=
 =?us-ascii?Q?encBbbcwtY/yx0337gq0SyIjFwg0n2J9NI5sK2fk9HXp7oY3mF4wwhIj+Q6S?=
 =?us-ascii?Q?Ltl/S2KdLW3cj0LLG+HSHmYVk4ttkYeNc8dUU8Nq7ndEvrq94QTJrU6aiWq9?=
 =?us-ascii?Q?RWHtJeO7Md2DndIattdAOArE0qwLi5c9a237RKZnpPuKAgfpgdJxY/sI6FVS?=
 =?us-ascii?Q?67ewqWx0chvDfchQsoctb//iyEIfK5evm+mryEFHlljbuyrSBtgg0Ai+rLhp?=
 =?us-ascii?Q?muNqewxP88mU1P5p5CF25Iuyj9XHb2dngA3nZuME60Unm6FeIoj3/iOVs+LR?=
 =?us-ascii?Q?j9ZlB7CXgmyX6MBz/uNF0T6GA1uXiLF6ZFV9HOafD71wPjmySUq5d62nD4FJ?=
 =?us-ascii?Q?+OqgWT8VxSxV5/IkRRAU6/E041OlmEGWm0G0PqaNdlViVCbRhDaWnvHCbZii?=
 =?us-ascii?Q?7ELsFwl6ImCIlNYVXS721c0p8U+s+l+iQR5ik46ppArBoJ3E6vRTd9+JadGr?=
 =?us-ascii?Q?JyD5w4TE6UrBtmdOS7TZVMpUAa80kFxIYNwFw8RvxFmej4iqvm6IA+YPznvS?=
 =?us-ascii?Q?xQuPaRV0b4SDODTQ49gFpfV2Tr/2TQi6oPPexARXdoSI9w8hBgHfUKqOL871?=
 =?us-ascii?Q?zpsKvlCzq/G4U1ZXfqiE2KgR+lA83cG7/9850lcHuRs+rtFLwM5pnwTUrXw1?=
 =?us-ascii?Q?9OLdLEcbO0a0+kAqe19hxIGhu/Cqci9JHrr93ES/rKCh4xmwymNN9/OJnR+D?=
 =?us-ascii?Q?6P60lMDdlYimR3B9pezMn2Q/pYgIoxoBV8eFjjTC6u9sZ3t/M/HpYj/f3ti7?=
 =?us-ascii?Q?j51wpzrHgXkc7rTEAVw3hDD77t6b4nhaoK6B9BGsjvhhidHypfMLvLtByVP9?=
 =?us-ascii?Q?khYqlOmeg1YpBfUE5e437DaAyBXeD+7wATK4IsNmlqJ4WACwGzaNUT0Mgq4y?=
 =?us-ascii?Q?zHyKOCMtE0LtjPcXafq5N/nui5+CZbAk0yvN039WDmHabQezpTLg7duYRNd2?=
 =?us-ascii?Q?InQJa97YCI69XkDm3MRvJ7rVjJSyJIH6jVLBq1ooTOSeQExnddyIMcGcqGJL?=
 =?us-ascii?Q?Lf6P0P1LiNjVVx9xrO8RS9dPfkYIFB9HszViP/FGAwPhi4fKC2eXhPVKVkr3?=
 =?us-ascii?Q?jFg8YIsC6RXtYW+JlWXtYUysTldeMOcMTHsmeLnU3kXtQO7UnyiAux3lAtdF?=
 =?us-ascii?Q?QiRBqx6SoUwQCNFIojruCay8s8NXBWuvN6zVHZAjNh5jEG/eiOpgh2f7YBJu?=
 =?us-ascii?Q?lZXBVsnyLFaqw0jgGLccZoiKpEVF7nNmnfeHpfUa/OfWvYJPDXbMCHdceDA7?=
 =?us-ascii?Q?b+RyRsx7cjvZCEEaGLzEBtl9E1BkKCxfXWUp2USc9X9x4eo3dZ6WdQI/KdtJ?=
 =?us-ascii?Q?EfyPMuREICq8Ph6Y+LpYn+oepv0SSHXIoorN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:46:39.5077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee574d49-3257-4f3b-6083-08ddc8f3e4ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
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

Before destroying the userq buffer object, it requires validating
the userq HW unmap status and ensuring the userq is unmapped from
hardware. If the user HW unmap failed, then it needs to reset the
queue for reusing.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7f9dfeae4322..2b35198608a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,6 +319,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+	/*TODO: It requires a reset for userq hw unmap error*/
+	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
+		queue->state = AMDGPU_USERQ_STATE_HUNG;
+	}
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.34.1

