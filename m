Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22A5CF58F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 21:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8344310E690;
	Wed, 19 Nov 2025 21:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qX/xgj8Z";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9DF210E690
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 21:13:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkrDf9tRB9HjYdHigza0fjpS4NrXNRJrV+gXc3NqiOGOK24YYmRmTpIWwIBQPknkXTmRQ+vKyOpO3aWNWOJhfu/dMdREqe06ySZ1H9AmwcFyg+e69+wVoV/bjCtMoSEJmlngyxzDeNndoLSNH5+BPypMX+xbPyDmGTUtc9l+soPH4W27K/MEW8INp7+mQ3Gc7fKGaMqz0xfR/1EW7zHc9WSSDVm9mE4OGfgTiNUSAie5TGKGvZD6TcVkIdBwThSFVPYKzbjoi2xLYTybXFv50X45mK2cUaZGsJW2BcIzrzV3kXskHds/GRZbLn3cCnngShrbQ7trZ++2MYFfGHGIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0oPQ2aG+AXTcyllVJ7kM9Lh3yh2KgpC7p4g0wlgelc=;
 b=bpsThJYdS35vpiVBqm5olZ5sfywMLm08qLmmtBRqezrN9DPZkqER+nUh4l/mse+OSXX86FRaFAqv9xszq2/h/UUucceSMLeDKB+SFzIctaLegiW4w29lBW36pvz/sV0OaN8Sp/llQjlPNy7UbWB7KwOwcX2Vmir/a3loVlm2ZT1TcMz2n6JJxgl4zZldia22SyDIFPNUAjdKgsgR7feLWIOzwlUjBifUlI3WzNwYxJxW+7IMT3+S8CWCOqyuSbx72xSe/8M6QZ2l8mnw8WkF7N6QYFrEJbUhkkGKJCY9M/hRAchROvdzqDKQsaxyjZtPBjrvo9LPLwqc/gIexNSP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0oPQ2aG+AXTcyllVJ7kM9Lh3yh2KgpC7p4g0wlgelc=;
 b=qX/xgj8ZjBAtMrTIBW8hb9c+AqXvhDX1pTsR2w7zKA5o60FFQa+mnnM7CjmLiU2OwdRiepMOXCLd5kHaU+moqi2XhjuCRUV2g2A0ct6ONuptV7Bjoij7oWFgHBHXvo39YVYBtly45cXEBhRTKhWpwXF1kI8tyKAtUI0MINALCzY=
Received: from CY5PR20CA0003.namprd20.prod.outlook.com (2603:10b6:930:3::27)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 21:13:24 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:3:cafe::2a) by CY5PR20CA0003.outlook.office365.com
 (2603:10b6:930:3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 21:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 21:13:23 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 19 Nov 2025 13:13:21 -0800
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: assign AID to uuid in topology for SPX mode
Date: Wed, 19 Nov 2025 16:13:07 -0500
Message-ID: <20251119211307.195615-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: ba54396a-b3ff-4c64-3250-08de27b07934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SkqU5l3H5rh6VlCqwy1yQDclFjZK7lsdVLv4etdhqkQmm4zZoXj652/JpcNM?=
 =?us-ascii?Q?dvB9U3spHiPElN8ZPsARsmt42F+f22ab7h/GKSOFXYotyW4WLCBYViJ9x/SO?=
 =?us-ascii?Q?khrRzJ0ouIe9enmy7dvAHJhVrjJTo91brqG6BKyuNOyxQeErdyjB5aLI1KvJ?=
 =?us-ascii?Q?xnDIKx+gcmP/bHXHOgXcYE+BEPPYuYCNRZHMM8Ayk55hjeyz3h+KKVlA+EQu?=
 =?us-ascii?Q?0v2flxuTR3ud4Lfz2T7Cgq6dprCfJ7+Wwuma4nWGjuHnT6tln86tWSG6X+FD?=
 =?us-ascii?Q?5uxIWWFURoQmsO9Qvkn7B7lQAMlnwJoDXVnEjhTQAG/sHVrmqUFC2ZzOHtoF?=
 =?us-ascii?Q?+whQRZJZWTvbVMqL4m9qjCzSHJb61pgFN3+XJy95mfTD9mOpL8okRFrDVutm?=
 =?us-ascii?Q?gzIPooSlwK21q6OQ/4QwVjgvrt9Ngb7Q8vtDRgMxrr9cIpJiLxjFxx1RPJ9r?=
 =?us-ascii?Q?05y7Kj3W+6eYNKWLTqIaZ3tf0EiUU1mZAume8hmvklCs1mDsWl0APhYooYdk?=
 =?us-ascii?Q?rWupmM9oXyb6MrXYXrdqDZb6irSU94J3XHnaVHbvTxtaNVcqBWUyW9twYLX7?=
 =?us-ascii?Q?2IZrctXOyEILKsg92JPjiB+0r5xwO7BUn1oQXH9j1r+yIkkk11nmuji4r9t+?=
 =?us-ascii?Q?04MXcLfGk/zkhdDd1f2Jd3CMxgJkHA/jHx3e3hiR15Jxhx45G6CYvE9ZkYLH?=
 =?us-ascii?Q?1SyzKsEbSMRiqfCfWUnyNXglJslHXzWef7kR1RZ0ftC5Gf+Bgj4hlWma3m2e?=
 =?us-ascii?Q?pTve3hOWHuSpiJnnQqNrrOG58fL+NDzAjriydvd2a9p5VFJgAkHkGTPYo4ng?=
 =?us-ascii?Q?9LHpAcI9Eg2xWgKgC8yo7LxWs4btpFt7iHon+z/18os0Ry6YTONVYl07qKBb?=
 =?us-ascii?Q?SBs0EbSCcSnaLxkxYi33R5v3MINSlsN5uSLIzoJmOk30jtEqjKjw9hdPaX/s?=
 =?us-ascii?Q?W4lsplmqBdtL1p3IHlvUxmXG8ufE9KEBxdUG/ymdF6FINWn2vWOa8kHo37cs?=
 =?us-ascii?Q?N8MVBz3wdDnUTjK2LlngVXO/5DKsFZRyehCiqJlEPxKq4HYrOyDoWzGdIR8D?=
 =?us-ascii?Q?eLYENEwRvyqrRmfMlCEQN5PHN7bNmpUEnOP1KQT+3sJAipyaqjAJfy2yuYiM?=
 =?us-ascii?Q?i+hi17vNWV/F52KG3LZ50n+TNTpir1L/oZo716zCgKsP0hK3+qEBPPVbZKfN?=
 =?us-ascii?Q?tsymiFXQp9Z5SESEdyi9cpj5IACfqh1iSwuEJmsbVT7Brrix2MGksawbAHBL?=
 =?us-ascii?Q?XwPisSm0jmAn3M0jEd30hfABJU57ZIgMuqYMmwP07k5iGYyeXeiIH3qD+pDY?=
 =?us-ascii?Q?oHh/nd7qC5QDWqBzKa7+2tpOWndyvgAItBkbz4v7ajZ2GC8BR4HjH5CpzTwF?=
 =?us-ascii?Q?nUl0YIoWvK5MQR+xsgQFnKxz9CcSdqMPITvKNJtGrjlU9UW5aVfc5pE/2h5s?=
 =?us-ascii?Q?osLINuEchtGBH4XD0/XVOQJvH9sPm43LKXSw0TjEi8ZdFgQz4+w/yAdLAn6N?=
 =?us-ascii?Q?54zJkq0Y6lPVuq4a+dlwtnsXOg7hEYDXrz6YSOZf7rHhWTD4Un37FBOb/Jyf?=
 =?us-ascii?Q?JfquHTh5XB8Z5XkgBEI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 21:13:23.3515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba54396a-b3ff-4c64-3250-08de27b07934
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
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

XCD id is assigned to uuid, which causes some performance
drop in SPX mode, assigning AID back will resolve the
issue.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 5c98746eb72d..525e70e45353 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -530,7 +530,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
 				      dev->gpu->kfd->sdma_fw_version);
 		sysfs_show_64bit_prop(buffer, offs, "unique_id",
-				      dev->gpu->xcp ?
+				      dev->gpu->xcp && dev->gpu->xcp->xcp_mgr->mode ?
 				      dev->gpu->xcp->unique_id :
 				      dev->gpu->adev->unique_id);
 		sysfs_show_32bit_prop(buffer, offs, "num_xcc",
-- 
2.34.1

