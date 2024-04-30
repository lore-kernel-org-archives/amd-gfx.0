Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16772C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 06:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF3210F23D;
	Tue, 30 Apr 2024 06:16:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kGMBqKOM";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D1710F1F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 06:16:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uc2x0OWhYj7q6Uwec7Y6pgj8NBwzn1kMfj+MN7vMLSgHkQvQ3glh0ZOIpr0LRnHHYIDs3EC+V+/HwrwBzCebtApvVCxiJjMyr5eDAvjC5NqqpJ9McnxecPYa5gK9kJHYObEDbdQlcSTTsX9JD5hJrsU1ZCJwwlm6pVcAOGPndiI9gHW+sSQTihEY9ivs15T8PoPLnM55vppyCdpHwe31VgejVbYscj0l0SiTp6nIrhH3QJ7+w4Y6nh0V8QNWQlgvIn/oasbAfX0Gv7pjlkMT41S1KjNMtrbvMhjOhU7oN6QBJcHUQ9/pxwnsbkUblcy9qvQ1+TV5CuoKQu6ETAkT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQM105e4dqXYxVt22oTdXpHenzqHadocCv0vBypMiYE=;
 b=Q0IC9FkYGMwffGvXQCRvsLtCfLzt74HujyaAn41QyggjqRiteLYebFGJRivw5kzcVmtvsv++DyrS1gw3i7/Bxd8osF84t2UnhGNZ2KbpUzz2EeLlPoBCAApOHJN8fPmdFYnub4GfSTmc8gAJyocZgu/33DBJVLCuLg3rsmDXkCRP1WAir2IiN0UVtaoK7a/R3ckNJLc6eY5CzBqSMH7jyy/XY9V61/+PmbE1I8C07V5IlieYxcVtnBPzJwAd34kdHuqPzi1/WwWvYP0RzTuWDi00aec0kDi523HAbGWU8RfWJhgrG865YFeHZcLB4sTb4XwLfupJLPML+mFuPr8cYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQM105e4dqXYxVt22oTdXpHenzqHadocCv0vBypMiYE=;
 b=kGMBqKOMPbsrlRu3gncvZdSUe52HXLH3VENGP49WrKuMDx0RX8sqojepp3rhovjTo5SrE2cV+QvlwaRpFGWOceXdPhKyBzYIeVmhRJgIxLP0mOjBUGQp/qsl3mzGLalsHpxHYxHV9UfDwiu7ktm9ifnXGbyOyBkHl1FhWdNPUlA=
Received: from PH0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:510:5::27)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 06:16:43 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::12) by PH0PR07CA0022.outlook.office365.com
 (2603:10b6:510:5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 06:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 06:16:42 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 01:16:39 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <likun.gao@amd.com>, <candice.li@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: fix kiq ring ready flag
Date: Tue, 30 Apr 2024 14:16:21 +0800
Message-ID: <20240430061621.1054787-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7a0210-b082-4e23-58a6-08dc68dd1a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?focSBo++ZuhWcicsUj2i1T1rv3+yfY2jbjLZeeaoAHqTLw7GrDkhxkii44rY?=
 =?us-ascii?Q?XwJEgJHJncdRMqbaAiwCqWze7HDVPguQXKUlikUUxhkiqwm/y35kB+bP/Ola?=
 =?us-ascii?Q?2vdA8Ng10Vx5+7+n+7DtKE7BARwAt0+fkHjo81bZ9pbM+zIAxWOXgkyw6Jby?=
 =?us-ascii?Q?nOLDjHCZfuMZupo132KLrhYwNm4eu0ySqP0RV7/PgU4cxNwO3/XqCNkgFN8s?=
 =?us-ascii?Q?Rrs24HMHodl1T6JLdg7EjMfC90RlbXgLwexFFyZYcFIPNgOH+theIbo07bqd?=
 =?us-ascii?Q?kM5Xp8hCr53RCwWQtRTRrYTi9pwKSOpk8I6Z8LqfoRvpNNxuV3EmwBWyshBw?=
 =?us-ascii?Q?wZ8OOFgoAYuTBoua1hsDc53UCGmZOUT+fK4mZ5cZ3pm3L4NXe9utyxpbccLA?=
 =?us-ascii?Q?TZCEB/SGfPVWCmT4iZYt/y4pzDtD5OJIiI9Nu8YMgRUH/5/uvlpd/FW/GsQo?=
 =?us-ascii?Q?9SIMyLHuDWWFw4Eg7cqvaWKv6RFjWxq48OE3wwRNqvxG5flil1uQ5nBEBlNj?=
 =?us-ascii?Q?SrVDRWJoVQ/7ijzrTpRJztX8poe/XFlD6CobuW2+FoMo/yUKeGw45AN+c0mT?=
 =?us-ascii?Q?iTisokmDXRoc/z1TeY7SI4x3vHvFsW/gd+lD7bEcbRnTuP4gpBGdFa1Vvrgz?=
 =?us-ascii?Q?+gx6ErUQRyPcKvdwNncaHwRsYQlxyDj5kLHYximKkxjWPFbbMrmiL087Oeg5?=
 =?us-ascii?Q?wC4MiYYg19sfwxRjzVSLDlrWKZwPMW4XobfNn7VvuURLDM2jJnQheb1TRkF8?=
 =?us-ascii?Q?gzEGPdxl61bClIbTimtkFzdAW+4QmgxoraRSMRERwNNHoDw+4oBniWcdsYcS?=
 =?us-ascii?Q?9XLikFNcFEqKX8zVSFY/qAyZJrzgkmbhL/RoeVrHC7JWTlOXIa02KJAGV0Zi?=
 =?us-ascii?Q?x8SWT/iyjtRMrGP7YxRTw9/V1oyrDeJ3TMcxNkM8Srp3bh34fUr6Gvhj0HLt?=
 =?us-ascii?Q?ii/GFnrfK/fK946xqFKyec9sTOkntG1G5HXCanfW9jJD7+wRIYVpXOBiSNBd?=
 =?us-ascii?Q?LHwB5U6MTcO3w9l0vR2zRnKb9j7HtNOLiYezAfJtu9Wn15zVouoocOqvq4hu?=
 =?us-ascii?Q?pTOjvDzxUl2ZgxfJsJuwbhKVG4ZLYST8yPOGlwxaT8FLQ0XuXB8bF6F+DY/v?=
 =?us-ascii?Q?m3lT6KW30ZeaPs98ejvCXFI55qtPqKxdutDLoJwEUGGLruU5mVaJA+YdkZAy?=
 =?us-ascii?Q?4pEBMgpi0mQXcE0K6PVUR4DJivIfXsAartJbndkY71lig5KqYTCILtw/2fj1?=
 =?us-ascii?Q?I7HwBi85c6W9Zg873i2MXJmft9Q7ZXWwlqYeL6gEdr6vPjk2hjgBOd11Uqv3?=
 =?us-ascii?Q?AcWE/LOTVGSYJgFl38NSTZoIWjAhFmstMF6irgU+giE8Vso7+7WwUJEm/Cft?=
 =?us-ascii?Q?qToaQXFXqkojMSjJo8me0Jg0/Eyi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 06:16:42.0837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7a0210-b082-4e23-58a6-08dc68dd1a85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
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

kiq ring test has overwitten ready flag,
need disable after gfx hw init.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index d98f6d282ae7..8263b97c4466 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1326,7 +1326,7 @@ static int mes_v11_0_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->mes.ring.sched.ready)
-		return 0;
+		goto out;
 
 	if (!adev->enable_mes_kiq) {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
@@ -1363,6 +1363,7 @@ static int mes_v11_0_hw_init(void *handle)
 		goto failure;
 	}
 
+out:
 	/*
 	 * Disable KIQ ring usage from the driver once MES is enabled.
 	 * MES uses KIQ ring exclusively so driver cannot access KIQ ring
-- 
2.41.0

