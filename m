Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79D8CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 16:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85CB810EB5F;
	Fri, 22 Aug 2025 16:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0tIJrm0J";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91ED810EB5F
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 16:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pi2SqiN9uK5levWS3+3Iss9W6S5QgFGCnZrdlfB8VdBwa7NHesfmCrePqbHbkvFnM7v/v4MnmsJKT1CXcQmfv9pAYGyE/7DkvMh8Kfulx3IcsdgqygdZTL8ypzqqY9G6DQQI3xIoxGSgXe40ZDqGjLRyzadXfao2CIhEU40/hy+2xJy57OEyORPW5tgmSrVmYF7xpmN6IYHP9G8fBNhbpNzlFZvr1cE44xEQ5oT7Nuw+JMQAIKHparBnpf6n3Py1/OPs5VmWtA+Ds8Dhhd+khJJNbuuMVUoewXmQkTPqhq9KgbW+zo9DIzYcaJSFj1BFr6tmB38QEjI4zMFVcqKFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEOQOt7fXaleiYG41ABhPtF5u8YZPW6BDE2pOwxabAc=;
 b=Nvi8XwgyCL1Da4Z5DGZYQHYkECUMt5H/vkAViUR+avy6eRjrzIrSOy+AZ2lUK+H5v1z5cjildM01fOTnaX8vRpBUSME5q4jfuIsoUJBp2+dhgfJdy6ESAh6fRfdPUgtSs7nC8XertUJpvbii6yGtnup2bsS1GkYBr/ElrtOZ7nIxVSYxALkNFg8lpFWjWHheEn3SmEmtjiTRgrdi9Bx4IcdSA0qzsKI9bFyUO/FVzhbYIGbenCzNufjQL3NqQJ7Vj5ZCeHQcBhVmgP8wcABjxRnIoIHchMfXVvxigE2TJjsoBDigS5RA0ZoS9D/Gkj9yooMMREb3m5vHlqhgoOyaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEOQOt7fXaleiYG41ABhPtF5u8YZPW6BDE2pOwxabAc=;
 b=0tIJrm0JgjreUVQQFeVAiBU0Oy1poAfJV/svkclYhBpZfl9vt+4vhew4ztiTmZa8driggY3HIFj5tum55C6DqeFw9f69PTpt5waRZay7Wn3xYfUkeigjMNC1oOhbvJQYRAcmpAoeaTSLlWlc/6yYyvOxeNH4YR4WPtMFhMqRjEo=
Received: from MW4PR03CA0147.namprd03.prod.outlook.com (2603:10b6:303:8c::32)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 16:15:37 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::b0) by MW4PR03CA0147.outlook.office365.com
 (2603:10b6:303:8c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 16:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 16:15:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 11:15:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/userq: fix error handling of invalid doorbell
Date: Fri, 22 Aug 2025 12:15:15 -0400
Message-ID: <20250822161515.1089247-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 485a7ca3-187d-4837-f1e4-08dde1972070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4H4eQDW+Uw3lS9S2DPKnohpNOYBL/FyPCZDTr0Az3PGLGTos1o6nrZgqDdDV?=
 =?us-ascii?Q?tMOGHUvZ/Cuz+21ViTG+qeIWsaHqRKpgOJ8uEQW6sKpAC5FPSsgeJ+CU/WiB?=
 =?us-ascii?Q?an1js6crnU2LWvHPJyTHYX3kojNiWgcfNwT/mvXIH0aBbPSMB+cXj2Vp7cCc?=
 =?us-ascii?Q?BG2oUI+bjy2sWnkwo1MVsaSm/T3rLf4oeWfPEZw4Blk49XcN3cy1XyIktznC?=
 =?us-ascii?Q?v24N9Qj7H5wrRq16B+itizDSnYivBJ0ZHY5m+Ifi9H16GjkfSkczsEvvSyEl?=
 =?us-ascii?Q?qnya7brLb3eGnIrpTHS3rH0w2gpXIgx3P0nwtgKoQ9RCuRISIXqIPmiC3+6S?=
 =?us-ascii?Q?SWzDMPyuSX2yKCvN+0sFJwf/fMjGqpXk7dv3x5YvRUz+jQmX++UYbHza0Q4Y?=
 =?us-ascii?Q?QylXqF15XbdE/+Khdpdg28NZjRl6pG/bLfbravXV1x+PwvQaN4c/PVThyNde?=
 =?us-ascii?Q?Hrvi7jRbCIPL4f0l2ZpcBJP5hetC3QCsn6C3bycBWZR2UYeuq+IPGImPeLhg?=
 =?us-ascii?Q?ZE1fI8SANpcHOmOJv0HUO5fnvrRvqHm93mboiIrqCoo+ckgXghimMfglm+YN?=
 =?us-ascii?Q?RchIPYzBzx4biQFn/nk539conZpcnceSoYirN6WpKIQYsZgvFwHKNKsOkgzX?=
 =?us-ascii?Q?UmV2zzXU9LWHZLciNAqoNdWFBQs1ebmNAQPK5iEOplT8XpmmME2LhID0s5vm?=
 =?us-ascii?Q?26nELLFKZ8ztpF0EJa9WqqRGHqw4zYy5vYO/az5eaeBwWLAMQbKFKsxGeCBz?=
 =?us-ascii?Q?lSCWlJ3NLkh66FJl2p2inVZWfhbjf5K36CufIIoP7H6Na7aCCLvdqszkO2gd?=
 =?us-ascii?Q?Ahi9BtaiKUPugFqu1UY7kaEiJf3N+fAf7dxLGpHUCytBoaxvZDDsgmIBkqhK?=
 =?us-ascii?Q?+4dkYPQqsuY2wTMt2a38+kN25EWhX4/RAYFR2a0mjloPVpyLZ7R4aTk9p6Yj?=
 =?us-ascii?Q?P63TMpx0uqeoeqqltWRf2osQbeEFiRm94a8w2mxKxq4I0mnEE0Dpykr3rh1E?=
 =?us-ascii?Q?rS+ryruEyT8exBRarTy/hiaoM/JklrzBxnMBrUS/eEzdscJEch8pSm7IRNFs?=
 =?us-ascii?Q?Slugcy6q5yKzw7zA9rvZM13VCNIpYGbvJBvY+ouAIFcx+n5C1B99rKcIFZ76?=
 =?us-ascii?Q?ndqgswy4u4qXDUgGxeFK/Gc67D8ZJGXXzFDVSs8e5GuLkZpcWEV2ifbAIG98?=
 =?us-ascii?Q?8pLLKG/o1GekATK94X+wvmbMcajtjJywVEC8ugUAiEhvAyK2QVfV2BLC1pcO?=
 =?us-ascii?Q?rbiAXf6hA4O/k1twxavALjBpyPF5hcM01eEOJciqLuikDPHKfyprW70FSzBB?=
 =?us-ascii?Q?wgFeHXycT53cBSoyHD0UwB7W8h+Ip5HWBHWyWsweirH2KbhHK7Jq/G0iwPLg?=
 =?us-ascii?Q?sd9OK/wIVJrX9Xe0Np01p+xHwpYOR44aqCCS7m/XDyLmVhNMrwqutajHDwXN?=
 =?us-ascii?Q?fGE0FbZQMWsmW1czIiMBKCTAhhiRzXEPvEg4OJzqandb+Qzec/MwwBTvEBei?=
 =?us-ascii?Q?XcxqhTVYQxOH73Pkhd3Srlt+H0yX9d6dW8Nd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 16:15:35.5716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 485a7ca3-187d-4837-f1e4-08dde1972070
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
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

If the doorbell is invalid, be sure to set the r to an error
state so the function returns an error.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 424831997cb1a..28242ec2215da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -426,6 +426,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (index == (uint64_t)-EINVAL) {
 		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
 		kfree(queue);
+		r = -EINVAL;
 		goto unlock;
 	}
 
-- 
2.50.1

