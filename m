Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE972C54FC6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 05:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5118710E065;
	Fri,  6 Sep 2024 05:53:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ke6iZDK7";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0070F10E065
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 05:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhHrJ2T27LQZ4mKdby7u7vFfJvVXPkWRB45+/zEK605Fr1MMuXyOJMs0EpvBMRwzNIj51tfNMWEC/mkwKC4+AXyFjTorBBz2rtOfrXXTtQ1n1+YwA5thARuKNJ6Oj7X7th7weQyhZdptr5K4Jyea10n5P5KThg9ExX/kWZSaV8NP+Z8fKTO17kUPbB0eVQ82/9kWnXg4ULDFcbnS7COrVYMNmh9K0Nxp859+GpPN5MXZ+hc8JQJQ58Wd5nbzFBOrT4PNmQTVl8Fe5lH6bZvEH8w47NaVXxpzMlMPYGJtz+zkDq3X5aNrhLQVtE2abStZQtzexFppoD1ROVXvOD3DJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+0HG446Y3Gof7Sxguguo6r2/vwRHdX7bG194DKMjcI=;
 b=tQYG7c6zICIOyvNyeYXRbj+2NMoGbJm966aXYBdhklwKgJcZza/+adoB6IciA2GoYkhrbtdyTIZ0V7QvHiEF3d6jG4YPmkUllBvoh9XHleIH9rRZ37b1U5BIh6g9D2zPZrYXBmI5FPESVTz9xOmInpAOkpWUd67jfUxHsj/ISbx67TGf4Jb1GLz1S2WChXG2sqVZ/lDiaiu0rH2sL9U4xTLY2pbc2mKsMae2iKTMVy93SBITOHlj3/3ueR2IpcM/b9y7f/jO+fT5a47QzQqBQPiwQfuT1Qeit3JwG/n7Q24JztM7hYUzXihcjJ++vqE3a1cwD7ncIi2xeouyhXNXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+0HG446Y3Gof7Sxguguo6r2/vwRHdX7bG194DKMjcI=;
 b=Ke6iZDK7ZHehknxEAT22s3Y4PAwqw2uJBXXhbFs9Co2gyUCb6y4k4bBO/FA0jTHBt5vTXU2dXqCLFa00fIpuaM6+lAJJXNM4GXBG7F685G+tsYudV2sL1SBQyk6i+F9Sj8s8/lSsoZopCubkDj5Yc9OqdZjlmCO9WOx3EAS2JS8=
Received: from SJ0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:a03:3a0::27)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 05:53:35 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::87) by SJ0PR03CA0262.outlook.office365.com
 (2603:10b6:a03:3a0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 05:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 05:53:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 00:53:33 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 6 Sep 2024 00:53:32 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix resource leak in kriu rsetore queue
Date: Fri, 6 Sep 2024 13:53:31 +0800
Message-ID: <20240906055331.1271124-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbfd98a-7f63-44c7-c443-08dcce383ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PG9RODMAasLAGk7MnUfF5OlNIYUvv6Oiwq1gr50P1a/bwVgBKGXeovIA6njp?=
 =?us-ascii?Q?VDOfDQal6CdhrYL7nm0YVb22DyGJlP9ZQqGf1LemNXuzU/2KtM3owBxZ8OeO?=
 =?us-ascii?Q?MGKtWjbn/ihgXQIxubCpk/bamiBD8BCrUBFBA6ZmtvkGzKZlSl1iBGECk9EF?=
 =?us-ascii?Q?zh+h9keSZACEcRwn5zzr/tdDkPxkC/CTCiPLX2UUzn1zeUriyUaUwmSZFIPR?=
 =?us-ascii?Q?HmsKfKPGJobTSLCyWAWXouNvB2G9urevbtqxhp30pcr0+qRrUvC1/8G50qFS?=
 =?us-ascii?Q?02r0DCZS7Nq+2k+Vz/IfUDip4l1KRKXdvMBH17yjPPvwKf6DQ5/vQy2ngU+7?=
 =?us-ascii?Q?k1PO8bU0LUqMMH7SCbP7Cg4OpvrtTS1IXJKTvSe5Y2RmejRjX2tj9oj7N5Eb?=
 =?us-ascii?Q?3VXhOPJaCLGQjOkk67Jed7PAWpf0jvnWfwKktYPSXIEtiYZAIr8y5kMxeziz?=
 =?us-ascii?Q?5q5tqHjvPALEnasOpnMrEqisrtaTXidpdHVTL/B40ttFIIIV4kHUzXffyAtr?=
 =?us-ascii?Q?TQdVsQ+NyxIw+i+9elv2vakRC57hbQpLX0hFtT2+0dTnufLSXYfIGc14/q2B?=
 =?us-ascii?Q?7qVpP2MLUPYi+z2gpdTd4EeZ+RjxFnM/VPIA9268HcIiQ5u2FVUy5kZAz/Bw?=
 =?us-ascii?Q?o3cyZJkVRi5eovWRvtz6tQawhKeDTWiyIES1dcFeAJ4tg+e4ABfLHa5By3Q6?=
 =?us-ascii?Q?5Q0K5NvmbcWaO+6WTeTlqQ1R8HOjyqQEX1KPpt1fsEzwC8f7dpc3iKVhVcg6?=
 =?us-ascii?Q?Ih4F9hl9ENRKkcaMeYcQZzgXAmOE53wqkaNXDCLAe/w3H79YEszjt6vTWi8R?=
 =?us-ascii?Q?07y2AR4Q/WauoRWfxo2gB7eUxFbMJ0n7OR8eFGY6UB76ZohiYe/wrSrGtrHw?=
 =?us-ascii?Q?zAUb0jWBDG+0c8NTHdNAaKPFUq3D5uqgrnxAn+ZeKx1jihpUrSD/Tair3L8w?=
 =?us-ascii?Q?yd69xaSnSQlbeFtvOgdmmWlPXcvWF1qlmHC4s7iEgYwvoNDdpXSW/1zIb80F?=
 =?us-ascii?Q?z/o50x+3h6eyWiTUxPXLa9X9D5NuzeB6z8xVkkw8ZYjOErKd8Bs8fFtu7lId?=
 =?us-ascii?Q?iuBxFEI1mTbpJaHUgR3THETnl2k9+X23lVwxzIjWDhfarCLRW6PsmD4OBH0A?=
 =?us-ascii?Q?xZmGvwFTKUmJj+t5ru0ijSYu/plBgTpFhynWrcE2smzXCPT5+2ZIZcpNX0NG?=
 =?us-ascii?Q?B7rpb1zay2C8ITK/IraEc0NuMKsRVXhgtHYEQY/bDFwbti5lH9+dDUqdWaMN?=
 =?us-ascii?Q?jiPYJp+onlDOQB92zBYHyb6W3uXyDVdOeddCHGKXh7L7Yp+VMzMkUx+OEZKf?=
 =?us-ascii?Q?X814D5cxoH28DLCHFwMxjVUtXe6eWSzoYvqhSBT9l0qtiowpcfpm/Id3Sycn?=
 =?us-ascii?Q?Mjq3x4K6n6Pbh2EUtS7qJqMdcVV48tZlnaBd9ZrS1q2HcScLU88tv3tNl1v0?=
 =?us-ascii?Q?WnOQ6y9GUMCVAsDrfaxpQrF88xP69aMj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 05:53:34.6966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbfd98a-7f63-44c7-c443-08dcce383ee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295
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

From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>

To avoid memory leaks, release q_extra_data when exiting the restore queue.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 20ea745729ee..b439d4d0bd84 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1046,6 +1046,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		pr_debug("Queue id %d was restored successfully\n", queue_id);
 
 	kfree(q_data);
+	kfree(q_extra_data);
 
 	return ret;
 }
-- 
2.25.1

