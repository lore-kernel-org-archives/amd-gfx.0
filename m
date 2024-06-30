Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BBBC27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B47510E25C;
	Sun, 30 Jun 2024 14:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EXe9u8ot";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACEA10E28E
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iy6loLa4PoSc8GUpLOann9Czt8h11GoQCggppJSWyRdpGnyTe1n2Pevjtu1RrnrVWnsvYz+eXQfpW/zi/PK5B2MtiTNHm7L2k7BTYKFO8xop1TKupMjnIhleuimJT7K1QY1tsXlWHFccnuB+nqNAVM3D0RKQivs5k5aN6lP5ioFilJMMi3MmqPDCbBT38UhMdC74BJJ+rD4eUZ36B3ONxmBcYHI2MfYWKWUvOpgorhdyitm1BgFJsMGXF69I99BMAgSt0ANROFr0RwoPno5XovLfo9fQBTRIlrBHBqpP8kFbk+EEE4Pt4+UHojoeboRoNkP4D9pnkgbgg5s0ApeSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nje5VIH22YzoO9YnWqa+DaskbQRXfdPum2aclguAEwo=;
 b=Br4XtHMjkH945QwW7t91JvwKGETYaiZBAqFbQ1tTulqMy8qb1GYTvlXqk6ySdxGOoUzSPfTKsx42msFQWvfSjnsqdvgXHrqXw7QSXV+2cBsQiGI13w2Z7Irbts03KYQx4NM6MPqNsWmn6RehCXRWP8WqMz7LxujJ56Insvzu79uQf8q/rOVNm/K4TP+QDHHPiIK0S7DNB1Bu4Raz4DGct68p6mSsGaVid/mtnv3GHk90MPz6YxLdWv+F718pZeK0TwZEYEjM71aGZqFGrY+LpxD4YO0iQLPftrh4llA9cgATKMSLGF1S+X06iTjl8/u62ORUvWpNNARxTaeYZwwkdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nje5VIH22YzoO9YnWqa+DaskbQRXfdPum2aclguAEwo=;
 b=EXe9u8otktmanaV070QN61h6aGqcuXGN59vFC9L8WT1V7UaG1z5YkxUvkMJXDfVbAKB6vzb5Ludq98TcavZ8YNeWPXXTgdiJl9KwyMB/lq4P4wy2obsThvtFrxgHKFgKlMaGX1kvVIIyjDkvKhR7aJYwWomf3PN9mSlPZRWvrw0=
Received: from BYAPR06CA0061.namprd06.prod.outlook.com (2603:10b6:a03:14b::38)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Sun, 30 Jun
 2024 14:59:31 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::6d) by BYAPR06CA0061.outlook.office365.com
 (2603:10b6:a03:14b::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:59:30 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:59:27 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: add SMU IP v14.0.4 discovery support
Date: Sun, 30 Jun 2024 22:58:29 +0800
Message-ID: <20240630145831.2023399-5-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630145831.2023399-1-Tim.Huang@amd.com>
References: <20240630145831.2023399-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5073d3-fc18-41a0-c4db-08dc99153e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k9t3wDd1yArmyCA6jTNWElu7LavmpOPRMYpLlzRBX2JNZYYltBXz+2cLXbwv?=
 =?us-ascii?Q?uu/VwHOVxmVrPnD+z/zSev0wSFsEG94inlW0SFb2gTVXwZobENLBRZqog2CX?=
 =?us-ascii?Q?JhmiXyYWx3CwPP+W1gscTJuc0i0HHJ0JFoCjm7IBXdykq8I/8ajCr4pCVv+r?=
 =?us-ascii?Q?0kjqcpzIPgJYjD/DsG0zb++1tOe4zA+1HgQa4541t2kEVvrlTQ41ACTLsLVJ?=
 =?us-ascii?Q?NJtxkksem00MOFGuojf75rjqYFUQvRRP6V1qoqPCfveJqjsR1oZN1DDZNyaS?=
 =?us-ascii?Q?Rj/oG77ZeaZ8SReEPWH846RSn1eObTp9Wq/kq3wJnkTx3XrPzCr52UWyHMnH?=
 =?us-ascii?Q?hOBYvkO3afXlIMv8tTihobmYWSU5YifV/r1Zd7eiQTqv5FfFJxmlyZ2MB+xt?=
 =?us-ascii?Q?8cYdUCBoh1UAPQitLhg22WaW5BSxDrSDIaxzg1pg2B+XKrceq363s5GNpBBf?=
 =?us-ascii?Q?b2X4eTv+m2kwJXa6ca0tui2BSs3GSfLaKU6VltXbUYZAHXJhfGJDXlf7NAU0?=
 =?us-ascii?Q?3/0z4dgX+wODorCaVn1UzQuVwSmjo2jbCsxvT4yLnj4InqxDbdVZbQq/QSDE?=
 =?us-ascii?Q?IfQJZvXQ5FT6xEqnT4xbDK9CbRp/TGzwnwa8Qjg6jEbomK1tTE+6YEu5WGFX?=
 =?us-ascii?Q?+Hgh9hwvs0S61Go10iHe/izprFRmR+mDepGDehZmN0nrcGmKF2AdD1joSwW5?=
 =?us-ascii?Q?4YeNNoMwUOhL4NnX++qTFSAEyGeQFAe8JJbFFo/j78FlEm8aMXbIC7Orn8Ll?=
 =?us-ascii?Q?kuvQOxgV4Xf0ODq1VX8mTjGIP6Q+CqslZT6OlaTmA8I6putVuBQUoxYcJnQ0?=
 =?us-ascii?Q?NhM2ocahmn47gWIPASd62Jh6sc8xFoB2xeX4xTif2PsF+4EXqcM2I9scC0WJ?=
 =?us-ascii?Q?4vxWN7EWhxm7XwQdPLPR4TrwHtgtgTiLy9oD6gn2wVj0L5UmeGb3++OcDq/N?=
 =?us-ascii?Q?Y40rSjSF8qYcIm3W5wo/yzic0csw4M7t+4Yc9kvHMBLQN4t9P6mBUZFcfO82?=
 =?us-ascii?Q?/vLnom5dKfLVQAFjTCyOqd4HJUuUbe136J7JPFTTk06GA4dEF219r3Bk9ZmV?=
 =?us-ascii?Q?+PrXfxSZS78LuJgMoPnFlLnhHg6Bqa1i1PXl1jm9Ek44CjTGWY7ajb1Mc/w4?=
 =?us-ascii?Q?UV1bSYA4iDh+IFAPrREFMNxhagPJQNZkOYJlD/Pp1i6ZwarLSBtEre24rE4D?=
 =?us-ascii?Q?SjRd+EsrGZR/DTTl2BogYLyZtknQdIkE3UtH0LDw2rouEJkc2T4GOlUPsmq/?=
 =?us-ascii?Q?i+AwtlS2vY0M78KjFu1VpJWEhyfA/3CGQ3HzBH14rTTLTgMCIzw/b0xiQbiP?=
 =?us-ascii?Q?xP0EpS1b5GYTfosC5N9dI/JFAqhwf6DQRECp4rhzqXcbFiaEjkF8tkN8Pkn2?=
 =?us-ascii?Q?6eH82LDZvg51W5qEIp/O9qdcJA/a43IVz1vCPSFoPJYUyyH+40JjH4AND2/A?=
 =?us-ascii?Q?TpOsZRMaqi6XUbiJfuDV/6n7EhsNln9l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:59:30.0038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5073d3-fc18-41a0-c4db-08dc99153e80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316
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

This patch is to add SMU 14.0.4 support

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 43499789b6ec..b241f61fe9c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2028,6 +2028,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 1):
 	case IP_VERSION(14, 0, 2):
 	case IP_VERSION(14, 0, 3):
+	case IP_VERSION(14, 0, 4):
 		amdgpu_device_ip_block_add(adev, &smu_v14_0_ip_block);
 		break;
 	default:
-- 
2.43.0

