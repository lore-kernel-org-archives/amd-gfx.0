Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D67C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE45C10E584;
	Tue, 13 May 2025 11:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iPrJLjZh";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66DC110E584
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7PVD6R/AfAVuPafWQCLUAYfeDaujKbOfBfKbVUkvXTxubcTVnnmh19zyvEV5j8IFKSXqjf8JXad1ZTXJCfXDWXkoLYDwVpVuQ4b/iLLs82qk8PUMKtczugVVe/YHcRsPubIk5kE3WRw3saYXiErhJACIP1SkpLMDLkJik/puUy4TV02e8YdhqW5GtuQIrtq87kFvFtkUj7ouHaveULQn4hrsUQDbdaeaC5iNspzDPKdVicy3TZIH8/4kBLhQtGfeJlGKbMS3mD2q7DRj5/MSK9SV1++XVxmitTa4dPLp7qqXM3GJQ2I8Npf83pMVGNYnNp8DCA4E1Hy/ras9iNVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA8jjOBexYXriUY6Fys/BNPejKJuKKmSuF9/spJnoEg=;
 b=ph59fFXghkz5YxNJuwC6bYdfT5/yc3/Py0TFlDNI3d2LP2Keuo1rhNDj64Y4TuI6dSFmQ/Db19fZhcvWD2gcQz92h5CcY45MlZ5S0peHSrryqN2qdIFAjtCXrRSRl0TndbmDrQJSaVdAcIPhXKhTMnMfbTLpP+S8iR3V7xo4qaxMKnJ9Sbq8KWmhzrOAxj+vHDkXNJvTtNpUhHnWsddvZtXQiDivLD8x6rRwCvgwn2JxuVXR6AZItG+CX/IerNVBZ+EN/fb71Bh5C2IXGMfdu3B+4Aw04WE0Q+ijJT6iRvZB6obBR3SytdvaT6fFiYK7tjIH1qaXWRvxhhURHMHJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA8jjOBexYXriUY6Fys/BNPejKJuKKmSuF9/spJnoEg=;
 b=iPrJLjZhxeJXofqmVBg1jn2K5X94ZHeephq4gWv4ezGDk59RGwuLo6GV8jU40HetN6M+cjqktMTuMoWu5V2UnD8GGBT6VxFDNPzp8e5Xd9rzFfej6mOb4rvLt+3JQsCt55OCTwgQnNCuciQS5Ym8+zCIGEL1mNBXgb7gNfaXmEA=
Received: from MN2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:208:120::22)
 by BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 11:25:29 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::60) by MN2PR10CA0009.outlook.office365.com
 (2603:10b6:208:120::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Tue,
 13 May 2025 11:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:25:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:25:28 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 13 May 2025 06:25:25 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>
Subject: [PATCH 11/11] drm/amd/display: Promote DAL to 3.2.334
Date: Tue, 13 May 2025 19:24:39 +0800
Message-ID: <20250513112439.2295366-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
References: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|BN5PR12MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: 316bb034-236f-4a68-afa1-08dd9210dd6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CUqHNXq59ePHJm7qQVRs+T3BIg4Y2AYGJs/Or0L/hnzJIE7ci2wwnvlbAPDO?=
 =?us-ascii?Q?E5ROuSQ5oyYYO+fFlLWSNE8HW781C5iQPHgD4rt8YPQg2tCbGSDQSyE2fDhv?=
 =?us-ascii?Q?7AE5XX6Fyj6eA8BiF33sKgvRrDDdJVCBN2GXwy3Po/IfPjM3z9/jC+taq2g2?=
 =?us-ascii?Q?aOLeCU8DSd6Ha2n2WQB/xaHE9mITy/w+sIPABJw6gsAJre7gBRnXE66WX2mt?=
 =?us-ascii?Q?aXUhQ7BuaLb2T4l2mvHH5N1+vGK7T6XHM62zLqOvHcIaL8886LNzj09pumN1?=
 =?us-ascii?Q?1PN0SlFV0PCI7X4gW5ktbmxVIpAO5u1SXveAnJdlKRaSVRGfe8u5VMDh2TwW?=
 =?us-ascii?Q?hD8zdB0hEzhtRTlyCrdKeP0kT4avJ1ddb+q7VYeEPlxc131RUBaIBgjGmkvK?=
 =?us-ascii?Q?Ub6ie8AAQ6z72t/0EdsTeA20yc6ah+o3ffSSngFvMkp1YhN8Gd/O+e7GhrEr?=
 =?us-ascii?Q?qpQuSnC0pcKnU3sNtZ0mxx0n/U5T68kOqhopgkl3/Utwyv4ndxripcSzASeF?=
 =?us-ascii?Q?Z2aIwnlf6aX57QL2EKzXrcdFICjtOEIQO+AuY1xY3K0ghf2OwDJe2j8+cjTY?=
 =?us-ascii?Q?V15b8C5B3vMjBZ16h7iBWajh/Fw9HkkT7pt0Y/cMWffNAoRF1/L/mQpJfK35?=
 =?us-ascii?Q?jeCEOgSRSUETtcSjQ20G5IjzIOoP26qFaolac3oAOm1NuZPBj+kXoReQMDGM?=
 =?us-ascii?Q?eHZsfA+kKYDx3vApqa/QL1s7vJBcFuM0F/x2cLCMBE9mnclQxYaRhgNzQ4wa?=
 =?us-ascii?Q?GMvXC9DUNrSj/GQRZuFdTSyr7+i/7hlFKC59Rs0dJtrsidjKsHTDXrjkjLxM?=
 =?us-ascii?Q?2QMqTIvLfNUjwX6VLocA3E6pseJ+lorY4g+KghHy7dGHYHCDVnaQMxDkYz+i?=
 =?us-ascii?Q?KYfAenJdDJyvCamDXhtKNNN8WXUHu8fJwyqtW0cA4v91sjoEdTTHISn+SQnH?=
 =?us-ascii?Q?jKA9QHHgJVMDtGtuWq8+sX1EAQjjR9xBu+jExvxMSoY+iN4FYbOb+0fJDmeD?=
 =?us-ascii?Q?GWG/SxETMHsB2wo91sUfwl/eli41g0rTipbqCEZFKHLOb4aZvVLCR7O/5Fr5?=
 =?us-ascii?Q?RCY2+E3wBBt0DXtPtVn8aJQf+xajPLTGH5Fh4fGhkhFuezhZg1jChS2VhO2Z?=
 =?us-ascii?Q?U/eEUrthiuPfwx3OkOkxETSNjM9PHSU55OjWiP1/hx4v2IW0+uTNKMLEAneQ?=
 =?us-ascii?Q?MEdy55DflfSDppxujbGXo/5TpGOMBOKV4CkkXzx4Gtqd/9VlSWp79esSjJ9C?=
 =?us-ascii?Q?vD+HeS+gT5XMLXukvs+vIo1jrewmjoprA8v2WJcqrQhrU70MyCAt7F39YqcV?=
 =?us-ascii?Q?/ZLnDoJCcKH97JoziZ/hyGl+rsDF5jBHPrS2bubmbJ4dmm+qhNQzWmrHpxMG?=
 =?us-ascii?Q?C3C27Xc7hLHK2jhE26C6pWAsRg0GgGE/eDV/OTIYa+F8JpbyMBX5fETAgIC3?=
 =?us-ascii?Q?PUqxoZ4fe1MD1Gt611bOD7vkMJqkqKxwcRD75CFXtwMS+VKGBFZxWxJ192P6?=
 =?us-ascii?Q?xv+xf5IKRSRVW/5wOObqjJsVU5nEvgP/zAwU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:25:28.8251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 316bb034-236f-4a68-afa1-08dd9210dd6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following update:
-Support external tunneling feature
-Modify DCN401 DMUB reset & halt sequence
-Fix the typo in dcn401 Hubp block
-Skip backend validation for virtual monitors

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c14390efe633..1d917be36fc4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.333"
+#define DC_VER "3.2.334"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.34.1

