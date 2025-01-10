Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6A3E7719D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 20:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1096310F190;
	Fri, 10 Jan 2025 20:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UmvHI3AF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B992D10F185
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 20:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/dr0Qj2D6lw7orWgfdmx0EhrCq5VnZ2dvckli8B7aPj2Z2sv29BkXi4D/wWhT1J2XJBU58dwG9nqEdMHdThyM8RV1xmki5lag8gFMwpjGSQArmwVQNT0AGx44T2rHJ15F/YjmTCRFLpNejhgDn1BLoA72tfSP/K6yd0aQ672zfnuRVpKAEuhgTorNzyaIc9Wy2ChzDdTRHUr5wPpI8DOqGfnuZQYM8qZfdWKBRCf3fMNBCuz25wGJq6kLsiJr5GOG+75U1TsYtFs75wjBHIx4a9SiA0PLbA2v6vxnExdxBlD5GvJOiRES2QzcQNccerCFvEg13TCVf3jh78o7PcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdC2zaKqWapJhuuvuSPiP4FrQtndGDE5e5ObgpXKRUA=;
 b=VFyYyAUa4BLgSOULh56G2aobEVQWkN86TkhDPYM3Y8fEdH5GxT7/FLCBAlJsSEwFwYsJvE/lwJanlFGB84V+orYffszq4byHslNpkPEbPIrfYDyT1zDqpK8tGTff7OUudqof9DhqmTxhTiim6W4LbMsZ6TVCNz0yb7py9B/+mA98eE0fCF1lhG+/46VWtKaVOvPw6RT1uO88d3ZhSTVzxvF11ZFtCsO1h9oB9O5bMfiRdYmN9MgfffydByyO2sxCwaZlK0jvGLmqw8eYGPjWI3MgVG7Gqt9axHdewRaMs09rlYCjYcD/Zk6+OTzn9f4XLBmuxjR7WRhuG+2j2mztpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdC2zaKqWapJhuuvuSPiP4FrQtndGDE5e5ObgpXKRUA=;
 b=UmvHI3AFxI+Of9yWjMg3gryGyt6SWlnVJ7ADmEHXX2W3teEEYuV4NV9TuejE1GZc4y2BL/7puagRNU130S5MiB8Tq7RLJGyMMkSwrg31/1YNAJD+fQoQCnSmZbmSjvvyC6l3pM2zBcyeLKG9E9vrU/f/tDxzANKx1w1A+N4DiPA=
Received: from BYAPR05CA0073.namprd05.prod.outlook.com (2603:10b6:a03:e0::14)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 20:17:31 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::a9) by BYAPR05CA0073.outlook.office365.com
 (2603:10b6:a03:e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.6 via Frontend Transport; Fri,
 10 Jan 2025 20:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 20:17:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Jan
 2025 14:17:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Fill ip version for SMU v13.0.12
Date: Fri, 10 Jan 2025 15:17:14 -0500
Message-ID: <20250110201715.3828934-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f463583-0569-4684-1006-08dd31b3cfe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FE+PeOBVlwTWITqKF/6txE213cfPDu4sqqCICJFOZDQ70I4oF+rs77e6/h/o?=
 =?us-ascii?Q?vIuZaQ7xZD6xN2u9t6hWuq/VcLfHzP8QjtjcQwCi2WPCbOg/0TaTkWeWu2Dr?=
 =?us-ascii?Q?X/GyLLujBwYKgiXK0nAmGTbj0C7B2ww94WGrEDh8RNxjIOiBmvMc7flE4CzX?=
 =?us-ascii?Q?J7HKWzOgpLUhIPzrjUzXzEyG+Yn5XcVzRL3rklqaNjoDcCAcLNZWdNek02A1?=
 =?us-ascii?Q?nahOL1Fh5lh6okJ3eozq9bLUEaO47qeBsQ3lMGPupLvDlXFFiaDKYiQWdpA6?=
 =?us-ascii?Q?3u3kQpdXk08uKeW/EjWC9hHOVDsaJCNpefdCw5mLjOBPB85lmB6/y0xMfGS+?=
 =?us-ascii?Q?r+qhcYl3aR5mt1XQNWAEYWfK5iVfOM9u4kxx+INPA1mLg2u5t53f0/FX3O0H?=
 =?us-ascii?Q?9UMHed7LOso0S5Fm54DstOXcdYSR+S7b7qYWcZ/oZUzeovlHboAtrlE5gov+?=
 =?us-ascii?Q?NunhMfLd/v9OruRaTVwtVL1k50XYX1TtZGvFJeiLBVRN9nT/4WbcMKgatnos?=
 =?us-ascii?Q?E5PUH4Lq3QXLcRiORoKVURQM+Cyh8u18Y7yKxNcpFjz6bXJ7ck4vrHOWRyrR?=
 =?us-ascii?Q?OhKmWQIp1l/2Im7TvEk4Ez5MCs03BzCCCin0Ks+lQ0UOdkiJ0GWdxw1KA7Y/?=
 =?us-ascii?Q?oBwIp8eAivfjQ9rqYQ92XcMmj6fPheRJC7bwQNEHprGS3JXEvubZIgDKrAZ/?=
 =?us-ascii?Q?7JXhgexPykjapJknXRj9qeS8WhAzNrCNEZJEOHS0HNRTGjVm5zqbhnCTwBe/?=
 =?us-ascii?Q?N/3lw5MlTrEY30s/wCdI/2/32hG6W6aZrLiOSLd+LbVoggpIYLCJhLFKf434?=
 =?us-ascii?Q?aiWV+2uXRGG0nQwXMv6CbqYFevGlWDEUnwS5dJ/UxHqbK64uUFZrUmrE9LUI?=
 =?us-ascii?Q?p7W+LEqL475i5w+cW3IUD5mMh7MLJuN9eoh9Zf3ALbGAxJdL9TpeFSQFcR7i?=
 =?us-ascii?Q?tijYKzYMyAsz/lIn43RIqJrh165VBqi3a81xyMB+Tr/LXC+dIpFa5IyI9mJR?=
 =?us-ascii?Q?eJoyZP5WaaHhup9V91iGyqPYsi7og4eULbLlTYTKRYLGshTeaP5OUKIyDSJI?=
 =?us-ascii?Q?G0w74ZJZatNupnxaOW/xnGzS2OvUw9NqA2eRRNskErSP6yq+Itm/PkJBLzCb?=
 =?us-ascii?Q?bqyhAZDeh1Qt3SV5GowL6N1ucqDntLCpWzo+HETGjSeF5hi8W4k9PwzGQJnX?=
 =?us-ascii?Q?0xSiAO85kqG4TTPDm3/sr7wp6pEo3UVTugfqXm/y9xP5+PscSIxMSn2qBCJY?=
 =?us-ascii?Q?PJmLHgaCxjK3IZYs669gATmCXauhXY7tfyn58CkPsummtCwKjE1JMCHm2eCy?=
 =?us-ascii?Q?TXDK2P2OUjLad5oNMdkcm+3CF2a/Vxda60i4QGtdaCwJUCqxooxMAPyMD59W?=
 =?us-ascii?Q?VtfYC87E7E2nd5VMiH8X6oGREF0JyUcWvgn3Eff/gIgjhppSNu2YDBouCMIY?=
 =?us-ascii?Q?lkMzX4UqUFrDHVru5KeFIj59htrCCFr04pZPgvkkyTVDK1NNTk19G7b+U5IS?=
 =?us-ascii?Q?CAnVqhla26c7Wl0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 20:17:31.1849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f463583-0569-4684-1006-08dd31b3cfe7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417
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

From: Asad Kamal <asad.kamal@amd.com>

Fill ip version in pm_metrics for SMU v13.0.12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8ab30b2f7119e..045a1a814c2a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -603,6 +603,8 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 		pm_metrics->common_header.mp1_ip_discovery_version = IP_VERSION(13, 0, 6);
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 14))
 		pm_metrics->common_header.mp1_ip_discovery_version = IP_VERSION(13, 0, 14);
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
+		pm_metrics->common_header.mp1_ip_discovery_version = IP_VERSION(13, 0, 12);
 	pm_metrics->common_header.pmfw_version = pmfw_version;
 	pm_metrics->common_header.pmmetrics_version = table_version;
 	pm_metrics->common_header.structure_size =
-- 
2.47.1

