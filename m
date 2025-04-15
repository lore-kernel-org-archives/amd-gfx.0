Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF942C369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8168310E7A2;
	Tue, 15 Apr 2025 14:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bUVLE1c1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D371810E7A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNUbZ9wDoyddV2cC7IqdV3CqjIBOmhPHbnS089gzalXKJHgrgqm0yF9XVHCQphY3/Q9ZFHIbQOXF+hCusxx+raghUvMDbb1j6FBKLxxfsdhZC5LbH5hKSltyjWA5GlASyAHwH3+vq5MU90hiSBjruPc43xr7dmmpl8NfOnj/SFe27sGQO7/nTMs7KcDI1j2hEWBuEcotJZZHzHkvlfdCE7qBzQKfbfuQOTEZQlY6nDdDkbS3ZX/ISxNU+PXGHukILgOUnb9HBO/HZYVUP1bRTkWQnz2z/3YItPte6wrZ/bRNTwFyDSncwDEfZQXaBkqZ7ZakfOflmAHsYVpQJ4JDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObdRtynHvGabNzBOQd2vfo1ScrlenwIGX+5qpSJh5oI=;
 b=XMTlQedRzRYOsOYOQlHLl0HQmZMTI43gLjejXTvStS3d8oFm1lMpsQfpouEi+xSZ1Evzr9hbak6IRKi0xORuNMBrPSFHzJXW74MsTMhrhuIMAzA/A8HHnQPtl797/R6GwVt8PrWZPntzyuuD7s0NG/DiFp/whtS6jx0cjgpg5kBsPvg5UY44Vq4PoWwm/6SIcCW71yVt9n9Yycw5Ysc2lLY2ArUNrg1PgphyD5bFK261jr1x2Mjvy7zu+Kkym87k68a5+KeDGfU6XQFVCBWO2dwAsYFvhn7vj681XjNwo4McMOtmIwbNiL0IT0q+QuEbFyVhPsqi7I+pOTO6F1UDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObdRtynHvGabNzBOQd2vfo1ScrlenwIGX+5qpSJh5oI=;
 b=bUVLE1c1HzGkQAQH75Bb89XwqwEgMTL8it4sKv87jUDn/k+vP0M59/r6G2hfGivPPucObZIAO9MULAKRzlRXJ51alS/QRDhMmIAprCArf0YYy9DDFPhcmSn7sYXYBGcVbH5P0qWqNIP5HtHf1Vmh0i3R8gt5DWcwn4dAD5yTgJc=
Received: from SJ0PR05CA0200.namprd05.prod.outlook.com (2603:10b6:a03:330::25)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 14:35:43 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::b2) by SJ0PR05CA0200.outlook.office365.com
 (2603:10b6:a03:330::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Tue,
 15 Apr 2025 14:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:35:43 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:35:40 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amd/pm: Add ip version check for smu_v13_0_12
 functions
Date: Tue, 15 Apr 2025 22:35:15 +0800
Message-ID: <20250415143521.367895-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db5fe48-e708-4de1-e598-08dd7c2acd7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xD564DRJHLYN7mRzDeicTqjV8Q50RSWFnzOfer/reyg3HsJy8NWDjzYnx4aM?=
 =?us-ascii?Q?8TpEEbcULdev+QVndoij8ScGXikeHRgg/sh/nUmw2tKerXs+bQgTeUzwqngC?=
 =?us-ascii?Q?viq1UtStWIB6GIHBhIuw+HsbSvGBimO6kKbeGoGcEtnsHjOtx69ghSdvqqPp?=
 =?us-ascii?Q?lvmRMaD+w/Pw8AIzE9G1dVeoxwDQ9ZOZpkKNfQ1E3NStnDVLe8RWLVU+YM//?=
 =?us-ascii?Q?vDFk2NoRSCdb/kFqrM3xpj3oQ44/YIHXWcxHgxreuZU5UxgSJ92X/2hKoP6x?=
 =?us-ascii?Q?YNJ8ey9YlBKxNCCkMtUhmfIL2WXGh7MbBkTPFNqTZUxh4EFh5kp+0SR06ZGT?=
 =?us-ascii?Q?2YNydsAL+D2w04B+sN+J4C3NN5uZcecfBAxlSzVfv4X5GRUOLkNK6XxAtLSj?=
 =?us-ascii?Q?QfzDRadYw3Jc/CdLKWovGF9jabOrG9bnwFVecO1eDTzWhz5saRHmTXsTMQaC?=
 =?us-ascii?Q?6556wiMbFoS8hJKQZEa7cukG877Zj9wCrNLLyqYkPtyZ9XuzLqH/Ue5P1c+t?=
 =?us-ascii?Q?bExWi7gmsATjEkU0dcr8KoHtOOxtSAa0iWJpBZcoNdVxjfKPg+uaPVHvN8HQ?=
 =?us-ascii?Q?tGDxtNnzOyG7mJ28jOwuyiyZ45mMdRf/nctPmWAroY970TPvbkY/Xm3XycEY?=
 =?us-ascii?Q?qqgQpowLzZqQfjMQvpTyx/BduHJTPOgyx1cyIdsl6O9njyzNvKZ/AK9ZtK1v?=
 =?us-ascii?Q?3aYvNKW8mpmdtzLf0Q+545Od+O7oDi6I9NQCiUzDu+opSIACnITGH0dFIn0i?=
 =?us-ascii?Q?k67i97rYwD2mpL+VUU9JpaVR7/RGUqH+bECqZ6FGjq2rp507nUfiwUdAUseC?=
 =?us-ascii?Q?Acl9EKM35Uw3RzKK15eyexX+ArCImIxJe2yY/cliPbb6g8Ac6dENNf9yE6HU?=
 =?us-ascii?Q?mMw2jlxfxYcjZCMot3DTVhLl04Mn6XI7j3iFhnAaeO2wCv37/79A1ZmO5yDT?=
 =?us-ascii?Q?JDi2eFn0A7cma1ViqlXGIreFgS8ggwx/kqjVYbje/pCsTqc56Q0b51HdsQ5A?=
 =?us-ascii?Q?9P+zu4TiECc0OaeR7hdQ+hbNdZpzBTTHhYRv9KD8ucMNpJw08U19kn8xBcrE?=
 =?us-ascii?Q?MZPGd/67L6F3xa4BhEXpPwABm2plvXbjVoegJZJo1hqoAcsHb8YyYiQshN6q?=
 =?us-ascii?Q?e0iFDrw2SZ3z/JWR/vIIj8g9CRVNmYswFQMhjdQU2wJrJFsRIQZV/04M6YKt?=
 =?us-ascii?Q?F/XHkDXfuTqa3A3ujl7KxRiFv8mSe4r9uKlaEc9Xts/A4DS4eh9L+KOmjzyq?=
 =?us-ascii?Q?bmLm7tvEUnmO2jHA1/O1D63vzD0YI6Ze+JUEwGfCYJrcqTtLiwxevFRnn5j6?=
 =?us-ascii?Q?JH5/rGv1Bx4JbqHyzJSM1C0bnbSTi0EiZ9o+ffWsTM/cw+MW7fgLmyVatb3Y?=
 =?us-ascii?Q?zdWNOC43o3PcxZ7HWL/F0nmDXk69sGGzwfaz+b4XWl+uFVhZnzMNrn5oBQem?=
 =?us-ascii?Q?qH1ctMl2ugt8LW6Ol5hB+dUw4COg4Ix3arRWCdBsFOnq1w90CsXx+ARuEvlV?=
 =?us-ascii?Q?amAaqZhmgGl//kF/qrEoJREx889nL0UavTSA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:35:43.3097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db5fe48-e708-4de1-e598-08dd7c2acd7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
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

Add ip version check to use smu_v13_0_12 specific functions

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6d84257b5301..177c55f457f4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -748,7 +748,8 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	int ret, i, retry = 100;
 	uint32_t table_version;
 
-	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
+	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
 		return smu_v13_0_12_setup_driver_pptable(smu);
 
 	/* Store one-time values in driver PPTable */
@@ -1131,7 +1132,8 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
+	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
 		return smu_v13_0_12_get_smu_metrics_data(smu, member, value);
 
 	/* For clocks with multiple instances, only report the first one */
@@ -2496,7 +2498,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		return ret;
 	}
 
-	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
+	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
 		return smu_v13_0_12_get_gpu_metrics(smu, table);
 
 	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
-- 
2.46.0

