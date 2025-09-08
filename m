Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71442CA1013
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A9C810E491;
	Mon,  8 Sep 2025 08:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v6RY2CNF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5BB110E495
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkH/9Pu/XoSDFUlhT1RgChS8PGU+lRLemjNTV8P0INmxZL/8pZNUfuuCumyWfCQn0TwEPtD66+8UglG7WeooQ16Kjv7SC350zzbBG8nU2uyYA6yZabRng2gvUI/rM29zSpO6LGzmBWa9br5O4cRFgrx07UEgOc0M+tFJWF+P4DUw980tGsFjG4wyOxnsIPcRgiUMCuOap5dEYkXRk1IDgh0Zh1BzRhC20BeBpRcoh0333IXI/YBXlljJWo4iLCPva5VXhEOIEZYq8a7fIiderWPXQGmBwQcUCp/mQvbwqO0fK99TjG9h6jduhvu47kcPvbz77N+OmIHKgpu8s7YV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruOexe0KaTzXUBvui1LB3XclINBIMPdzRKfcXA8cTTk=;
 b=WBsUEIqk/HybbmiZNviDDeaT2mryAqBPL0oIIr3/1fwtF9i0ID4YDWPeIdQIfmV3RUU+RkQ/FRK53Ls7rWAHL/6lXp38lnBun76+S0PRMaGGbTdboI6/WamVJbiuWEDtA7XCewx0ztuNOJau/NHalFdMOcDReeGkBDzLC9Tu+xv5DRltvyItneNnxYG36FeSyQlLksxb/z+XHBaToil8yvuxlKQWI59B1itq4CZYp4hM22REOq+Flo1ipOT3OAoDjRbO9YgyK9nWleUmW6Lt1/ZNQRVDM6cuQrR12qZeV6UooYoZizlz6sNhNc8xuq65e3dVge02KyOdhzRN89YaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruOexe0KaTzXUBvui1LB3XclINBIMPdzRKfcXA8cTTk=;
 b=v6RY2CNF2a9ySLgihRD2g+Lwl2R40SKvqswdTOeGHzpdv3o7f1WoIwnGqC3eF/xb/bHFnWpxF2ukdTGiJ6kAzUgseu8xr9oAvS6Tx/XLcEJ1qWTSPYDGxNFK245KEjVIPp0sSG1nFpWhOcXAgDFhbNRRvv51A/ng5/Rjx3KJOu8=
Received: from SJ0PR03CA0237.namprd03.prod.outlook.com (2603:10b6:a03:39f::32)
 by SA1PR12MB9515.namprd12.prod.outlook.com (2603:10b6:806:45a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:49:21 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::78) by SJ0PR03CA0237.outlook.office365.com
 (2603:10b6:a03:39f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:20 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:49:12 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v10 09/14] drm/amdgpu: track the userq bo va for its obj
 management
Date: Mon, 8 Sep 2025 16:48:41 +0800
Message-ID: <20250908084846.1873894-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SA1PR12MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: adad0dfa-6608-468c-a9bd-08ddeeb49a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x96NWY6aBrHnryb+pFPVC/8Ml1oOb5I7+fHOr2QXUGWZjTwWnxPXNm3TgZSQ?=
 =?us-ascii?Q?W8VCCEWlada/d9L6mjHJui9W262qjF1Pyzag31KT69Pwq2n1CuJExQXTyAmm?=
 =?us-ascii?Q?UZHRVQybcoEhZHuWmpV8LxSUcDi2JU2/u72zQ2IhiI0kpcJ1DlMhc+EP5C5M?=
 =?us-ascii?Q?cv6o6aecUcYmkjLPRfRIiT0EH4uFT/3jPxuN0qv6EaVm/w5rtgjw1HzpE8AF?=
 =?us-ascii?Q?7ujQDM83MRS0OyXOu+UGj4rdIFq9Y/xscM1dp4e37I2Lfq/+Gm4bxqlVA3Lp?=
 =?us-ascii?Q?KtD1I4obKRptwc+1tIfxz/etyTvjqpP+Zv1jfRFfbJmHnH80bQ9VxIgSC+HT?=
 =?us-ascii?Q?VJwysGiA1PEiqcvl9TL+3IRVH6BD0zor7lN2mAlysN2PejFq2r2SY6yr07he?=
 =?us-ascii?Q?xGYGCfYFSALAqnJZZxOYnQZ1Vtla1ISLIzYt7odOiZvl8MxGOk8tk7npr0Uj?=
 =?us-ascii?Q?/D2QxJ7dn7t0FQrlgSsxG524Q7GfIO+gkiu3Fp81jMpHepOM9r/2NEgRTcvo?=
 =?us-ascii?Q?iWQHoAgmDC+sXhevKz2mhfO2w32q/0OqC/WS5YFNFsRvY6FN0s0YCaArkMWS?=
 =?us-ascii?Q?bJR9g/xDi//xkiH8OmuXTK+kyYsoQKHND6SdYdFmJOe7Lt2uWSX2L7/Db9d5?=
 =?us-ascii?Q?pYu5q5bFTAYL6weHsfvUIhr9uZLrMjP6/HdJJ5GhxTphkG7cPEcYgP0Ju4p9?=
 =?us-ascii?Q?s+0MHY/LbdP79yqRaW/Rd34jjHN8nvvK4gAsycUH9W081dimj9cq6SEhvWFi?=
 =?us-ascii?Q?k79qc0V7XR+SRCdYjpsE2bw+7jfZgs7WKZBucQmfEGk/MTZbQ0VeGYibwOlB?=
 =?us-ascii?Q?NdZZLj09ogDYQXe/Ftgav9GtWMOga2j0jFMes1Sgw5ryplSpls3xGBEZhdSA?=
 =?us-ascii?Q?ircBWWfWysv7R1BZ5or/VmgieKfyNXuC4+yWdqwU1tBT1KMj3gpxqZXfrqbd?=
 =?us-ascii?Q?+O8SLHInKR2WTC9nMhKu3DLSUe9PhFhLvxrlJCnrziL0bHoj3hoGRNt491Pb?=
 =?us-ascii?Q?Pa1eKy1JxYXZs1fx7b1kYXky4I7dgjuX25xY/WRbj3o3Joks4U5Vq99/RhTh?=
 =?us-ascii?Q?AUbXiJI1i377+qpbRKEjy9ffQu6HimUALDJuKJw2J6GL1zlTdDwzLxunewSG?=
 =?us-ascii?Q?udPYlhB3Dsjg4ZfHInwr/ZJ0k4ZEmsaQlcNcKpb8t6jDTu8AhPtLk0N0Unhz?=
 =?us-ascii?Q?hIudreCBMuu1+lJA2aqfrelH5ZQxf0NKDqxV4QTUzy7ncfzHXCM+8voqFIpE?=
 =?us-ascii?Q?4uzKQ0VM0oxiYvTAqH4sWuRwjFHZlEtNd4qr9EYb3CDNFtmE7dQys+Qrmjfa?=
 =?us-ascii?Q?LXRjouw4ERh8jy7dc8SeXB0vjG9VXY+C+2ExYd+DD/3RStNbwEnUt46nOTct?=
 =?us-ascii?Q?qxe1MRWajYenAISqJJ4vTbIAsJX94ib9mfeMZknNwdFsYNgUO73WvRDwMIgh?=
 =?us-ascii?Q?YEZMOO7cuVyQyC/WgwozNtN1FOzaJmNnEP1rrEmzbaRqR4YS1W7yPkdjQC94?=
 =?us-ascii?Q?nf+ezCfJEL3ivuqcklAtmKMoiaaflUMhGsdy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:20.5400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adad0dfa-6608-468c-a9bd-08ddeeb49a45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9515
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

Track the userq obj for its life time, and reference and
dereference the buffer counter at its creating and destroying
period.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 5aebce63d86f..85df04e9ec3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -306,6 +306,8 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
+	/* Drop the userq reference. */
+	amdgpu_userq_buffer_vas_put(queue->vm, queue);
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
@@ -645,6 +647,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	/* refer to the userq objects vm bo*/
+	amdgpu_userq_buffer_vas_get(queue->vm, queue);
+
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
-- 
2.34.1

