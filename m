Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F732C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF48910E41B;
	Wed, 17 Jul 2024 20:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QDpFKCfg";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6FD10E419
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tn+yolsjUmt6GfSbs7kj8/Se2YXfvd/bjDrgmDnY9luH5ORLt6Q9qHWlhLwctruh8FRdLbBLv43++/xYbxOgv2RhvlbiN/rSorNUV9+is9eyyKso3XihtYu3PbKkYA7pTmBfEJn/SNTzMoYe0UBpsEXLZEK4FaYEdgT24eIH10oDLCLWESaYvAmelio7RIrD2/VhY4u3XtYdNXlbObUUnh4BUbJGpI3MoCSk/XPXlpC7PuFkrwtqdNPU7Fx+424R0DM8q0S7O9WOZ23AlZCh2m6eZ5NS8JiXgwmE7AdnejVX4vW3LJ4q4vCQF65L8XAqckILkHGPevqF5CtZInJeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9sgPpqYE+k+UVNJsocQ8+KQ7Kk9lRUeeryy6xsVR58=;
 b=EnOz81vqE/ZkSlmw7U+5nZs2bdlWYdkIgxH+lbeh2btrVsflKeHQ5zJhW1NA4t4pDE0oS08kJIILC44kR2xM+5ktGPybTwpJD8UphnQaUewRFVndPpPw/bSUPyx4WUJ/arGJIuZncQFW8QPESSNHEfbl0YCRrESPO/XJExNatJafRVnngxF29w2qG7C72+0QOrHpAQLOnW7eOYzwry2sPaV3lXJp7SrgmZ9feU+4VU4UDJpfy1TAkZGhOsS1jdHztGG5jbEsJSZ20HjBcCnRxWIyWx0/07CjlCT77y1/uqNxx1Wi+ZBAWRB3dUxv+t2r2DX5CHqribfzKWJ3ryNwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9sgPpqYE+k+UVNJsocQ8+KQ7Kk9lRUeeryy6xsVR58=;
 b=QDpFKCfgbdauctCfq4Oc5rnJLAnTrTQRl7LleapZ1B4Lb82GgXKXRqRKwqN9jYpXXDN4MqXZ0FyF3B9+ANcMNbd9ya9RQSekvcOv3HoldZEMZbUIMOr3uqd+lMk683oPXeU8poZXZExUB4GJj1x6x4H7+amxfBcaTBJb7TZ9mBk=
Received: from MN2PR18CA0012.namprd18.prod.outlook.com (2603:10b6:208:23c::17)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Wed, 17 Jul
 2024 20:38:02 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::c5) by MN2PR18CA0012.outlook.office365.com
 (2603:10b6:208:23c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 20:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 17 Jul 2024 20:38:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:37:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/amdgpu/gfx10: enable wave kill for compute queues
Date: Wed, 17 Jul 2024 16:37:38 -0400
Message-ID: <20240717203740.14059-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717203740.14059-1-alexander.deucher@amd.com>
References: <20240717203740.14059-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b36b253-d3fb-4988-d4a3-08dca6a05aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CybJvdx2T6eZtLnUiQ0TXSfPiLRx8JXCEGhqtDuhilIx6IbZkfR4di2qJwJ7?=
 =?us-ascii?Q?HvXMM4ivf0x8QiAhv1aa7LXglu0AFgb3tkuy6f9OhREJlgd/Qs+PNQf/xlRy?=
 =?us-ascii?Q?3guzpiXeCJ5lcz6F1nr8fsxClRJbreProBv/QXd9gCzEhu/HH5XlXBIEdlM/?=
 =?us-ascii?Q?53Z1vHrX0xDVqFkAtj2eV0Y0thDqhyNtZAOifZinyCZbQpGpQnzU+eNJELSG?=
 =?us-ascii?Q?UQQtNXwA23Bh2FDHmi0DMrsRgiaqe7ht4kfKUYwQRfQR7owCCrEocWY46VKl?=
 =?us-ascii?Q?DMPcSgpTxFWk83AqNwzbMVdkH8YFWkYf25+HKtRdsfwlm2MjdRzCyJ3eiLss?=
 =?us-ascii?Q?trKhAvXjwNJvGO8WOaA4+ePLrl8T76O8sEndRSxOWDhaH/Xqpv6GtoY9MiD9?=
 =?us-ascii?Q?7AoOxDpzTCVdRrkV90TpO1lZshN5CuARuuyq/l7PIXch+Qe8XmwedscGBTki?=
 =?us-ascii?Q?/47z5RGVXm2+a6sX9oKO8jVHBP2Jri6qi4wjlISZkzIN+kNJ2P+E24FK6l+r?=
 =?us-ascii?Q?NuH3q4UezWUQbhc/jH4XygO+caNRjl/LR14wAn/yO1nu0l6uRGduOL+XaerT?=
 =?us-ascii?Q?2Sz+dF/mkk3PdkbtvlEVxRzJgyEpnYDSRY6HxEcnnya4PVAvUwb4geion6D7?=
 =?us-ascii?Q?UxxqoJiMqNOlkcFt+U+X8Tnd1yDwzsF9LWYmx1v/mbKHJDaxncyFCYRUIPqX?=
 =?us-ascii?Q?Dj0lIbdsEmDAGkzSGfhpESEHy3LG1DIO6pPYNnjRQmJikIGGkVwIC8/U4wc6?=
 =?us-ascii?Q?L5Wqt1liMQQMZCtfjiRXJlmiFSOfmgj1lubRblpvWI0tFvLIWEOW0O1vaRbB?=
 =?us-ascii?Q?3sHJQNbQo0kTPyo2LbC21wyllfluYx4+ldbkwzMelGImzRmI5CXLdgS3AOlZ?=
 =?us-ascii?Q?W21vc8P2wxuY9p9ZkWrp8BnYy1hbnq4vwczMP5VKQeNszn0CZ0MVgCFCYKv4?=
 =?us-ascii?Q?4EcLmnJI9XMGkczNYzAtIdK49fCexNecbmFlod31DxfcGFhnto4kOsYGmkld?=
 =?us-ascii?Q?QHvU/e+Tvjp0qADVCbQc+iyILhMcC2dMOVqGDQxgcUtHBiZ//By4uUpJVqwO?=
 =?us-ascii?Q?2ZO67i6vmr/BSylTEDffxRWzUFAhXZWuW1NdRWLFwXffCwvQng3q29PIo1OT?=
 =?us-ascii?Q?8JevtF5kpP8l7zzi79CdMimln6+EhTyBNREJQtvpzPNgKLhr5IqAuLRLt478?=
 =?us-ascii?Q?/3TIOnS2ci+8CvDQAHTKQ2yT9vV8JirTWzKlgMdjtuFr/+ppyyC8SpN+wA9Y?=
 =?us-ascii?Q?a6l6DXCfv5T4bWsg61xTbPpRCJvVyuoNU5LE6zu5a3dnt6aHib5VelxgV6Dp?=
 =?us-ascii?Q?AZJ5Iuh6ZUaW1tVKu8RkWnCyUR2fIfXdWMPofjQ0Hz+zTCVcGSGzdy0Ze6ZH?=
 =?us-ascii?Q?bWiGoDcnkIH0jUDu0tBgTq987NduHQyiUj2jXFgJezK3jJdNcBezUtbm8tpE?=
 =?us-ascii?Q?asTR8Mf4Pwq+BK2VKczo8IXp4lpYydk8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:38:02.5265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b36b253-d3fb-4988-d4a3-08dca6a05aaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551
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

It should work the same for compute as well as gfx.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2957702fca0c..c4002db6e569 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9480,6 +9480,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
+	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 };
 
-- 
2.45.2

