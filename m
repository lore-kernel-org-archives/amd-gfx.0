Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDAAC7115B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 14:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F1210EA68;
	Thu, 19 Jun 2025 14:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4oiPqGy/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5012C10EA70
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 14:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ry1J2QE2qva0GUAJi1l/FsAO7DOjszLgbGC3VzJpT2VOdpUm1KJRrSyXPKoIIgmNylD3CTNvcrThPQS4BXNNEXcmu92Ans3k9p5zaocNLP+KNQ5sDvcgPn9gxmd+5nKp9LtJoUvilBvKFLZ5DxfF2jyrxRioIjqZV7k8NXsBGBftO7CgJm4L0uOhLD8TIeCDU+72QCOrR0gTcjxgjWxcTg2Xm6GC3WG0OaQsQZYOUCbaZO0zFC5Op7qY0Nf1jLTb8UThWaAF99glcDE2BmIFjMBdX/4Y9GMfYwMqJ1p/JsCoofjMuiZ1WdnpsuSuipX75iE38rgP2pQTPv/NLG4X4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW9GUXS6hj4pm1kj2nVBespreKXc7maKft1MU3DGSKk=;
 b=L7NTKCqq6LWs5w7CC28Kcnmxxvzxnq3htwn4InaONxQVswS0ZwnBOq+gGDTrV3Q3Ps9MxgfSEy2HwFQQcNKUq1j//YanOsXYyne+gW1Fzdd2Fg/Rzz+TpX32xRNc7eOEyorFDItqo5yLspbfKE6ZfvP/clgNj6/HBMBSWJPAPHg0g6jxLOWr2NDJQWUtMaqmkSy23FC2Q7vfAY31FrIx8r6EXnjpZckSMmuKiGjxLuNeE+YmDZ6ztErWelauo9VyzWGRv9WHJXkqNdj87YEbv7A+EavUBnQIQUYobnuTy7pB3Q+k+rzmNhdo0s9sIelYRIUkrNwyETvRD/giqiEezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW9GUXS6hj4pm1kj2nVBespreKXc7maKft1MU3DGSKk=;
 b=4oiPqGy/BsIXc4dm9J/pl/YbkyCJd/jYoQBzWcTn3W3nZkiZzkHjApNEwbbwXpYGmJ3beanSRwz2/TAP/LvhNPX5T+MrrP2dpsH+a1Sp7gc2EGUFnVYN+ZhD9JPl+6HnC6YahKW3OW2aCCpDNnFeMppK5C5VcXeaGDJWhQX7QxA=
Received: from MN2PR20CA0056.namprd20.prod.outlook.com (2603:10b6:208:235::25)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 19 Jun
 2025 14:05:45 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:235:cafe::6) by MN2PR20CA0056.outlook.office365.com
 (2603:10b6:208:235::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.34 via Frontend Transport; Thu,
 19 Jun 2025 14:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 14:05:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Jun
 2025 09:05:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: make compute timeouts consistent
Date: Thu, 19 Jun 2025 10:05:30 -0400
Message-ID: <20250619140530.5683-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d3cc85-d8f4-48b6-dc9f-08ddaf3a625a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dWDsIK93zPiWs+9v0VaiGT1Tj+VmlwPWNAF5jojumcF4Y7sb7tN3uib6kwTW?=
 =?us-ascii?Q?imfflI2loI6eApE3iPpkb/qAhVuBzHvwuNoCKkePR+A6LxtnydSgkq95h6UY?=
 =?us-ascii?Q?JMmFdaJWW2W6+HPtYWKj0N8TWr2IYtFovilMHyPqOt/3m6jt7pKRvXFW+eoM?=
 =?us-ascii?Q?2gbWV29+xCbWet63XaYbp5RlMeednjKEPRT9bGqlmYY7PeD97stFoeo5gowV?=
 =?us-ascii?Q?ZyyYAqGkny9RoCfL4aAhhDROK6xQ98H4+38346nnf6e8Z/dUDQFLLgM6B8tY?=
 =?us-ascii?Q?pWovJG6BW0hlcZDvdnvY2+a5Oogyy6sUHNJJV3j0uPMl824Dtjq2nAfODre+?=
 =?us-ascii?Q?F/rNJZykVdK2ZcXJML0zzoCJF8hkskGZ1xm2fIrleLP6hHBwmvShJtKPWxZB?=
 =?us-ascii?Q?Xqz0meSjxF2DS2qUce0LDrp6K2e/PJ1x3OXl1/FlCy8SSPq4C/xQuCj6Ac6Z?=
 =?us-ascii?Q?o5ScX4x3aNNd9n6q9qjHNWC9bLEZ/bNwpe4WE76wA78zzydSMuzS/uVv6I0g?=
 =?us-ascii?Q?CXorT8HdGDUbJ10P5iJArWXmPD5StQJ+z/k5xfbb4ajh232RTyQQY/dHgKO7?=
 =?us-ascii?Q?AvxsX86MS1XcoAl3l7X1PRfGzQihbCnxiByrwCf//IdnjuHshepg4MK3P31Z?=
 =?us-ascii?Q?XNep7hYMPHeJ0HKUTYdyHOmqT8PF3o14qgecjdPoIf6ZKXkmcfst+DWuqOR4?=
 =?us-ascii?Q?QyT72FS+cmCrfbo+eQVuM/UZnnTSYN6c2LG+yW8H1ejBOfmODCvYrqNUCqbG?=
 =?us-ascii?Q?v5U23BAaJNDQmzcg1PypoCuE+rdEo8vgNObACUEIGSLKyRbLK49jx3aSweXa?=
 =?us-ascii?Q?uo+TACHlMGZEhyX+KgR1G0pnA16gpyKIN0jfUJdhwNKEbi6HX1posH7yYCma?=
 =?us-ascii?Q?hvH/FXbUk74B7P4RIuodz4WpWwrJwLrlN/+/1KK4zxhGdtYgZXqGBvCRr42e?=
 =?us-ascii?Q?wlPv0oDiXfO8Yub4v6Sbd1SHgMpphrfGCVyKWjd/F+ivRBCTP7q1XUNjXa23?=
 =?us-ascii?Q?LaGXR1yqhrX/88bnNjx1+HKHeU+Pos8Oo2XdozRki6Px6Ntk60roPbk2nyQu?=
 =?us-ascii?Q?op9Vv7lvYmMsh2610piOZec55QKP7oWAV2SxgJjQMDghJhn5xWQtt0IPuFco?=
 =?us-ascii?Q?H1PZkKUABLP8klBjYbzvM8Vv7iQFHDMxnrr5aHlQQ8mYN744Ef3DaGRxp2Et?=
 =?us-ascii?Q?IpwTf18ptA+nJ+yspp2vEs+gHBSkDv02Csf2QjzLYhCqZ0ln+u1VXeIZ69Jx?=
 =?us-ascii?Q?ml0ZwQCOolw8slVzdkNHv9m3zYr/FAs6FgGQjCTi+uc/YPdRhJ4hb591DPwN?=
 =?us-ascii?Q?+saDZzlms/iGJ7scDWydgdPkgXDH592XMKVuukQfCFDAwrl1afY//FD/5zI/?=
 =?us-ascii?Q?/mqBH1xWhMGyZTURExv1xJ/pdKo60kDlIbh6FwiXP9ACmLDP3/WP66RwSQfQ?=
 =?us-ascii?Q?CD10qBSOThLTiFj9xN8Nen/Y7E2i+n9AXqtkVbZVuYKH8qRU6cK+TvOOeg6r?=
 =?us-ascii?Q?GYmkXeNKBNoeA79yrpAPN+QU1eyRGi0z06yD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 14:05:44.9132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d3cc85-d8f4-48b6-dc9f-08ddaf3a625a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177
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

For kernel compute queues, align the timeout with
other kernel queues (10 sec).  This had previously
been set higher for OpenCL when it used kernel
queues, but now OpenCL uses KFD user queues which
don't have a timeout limitation. This also aligns
with SR-IOV which already used a shorter timeout.

Additionally the longer timeout negatively impacts
the user experience with kernel queues for interactive
applications.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 571fe25a315f0..a91ff438672dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4179,18 +4179,10 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	int ret = 0;
 
 	/*
-	 * By default timeout for non compute jobs is 10000
-	 * and 60000 for compute jobs.
-	 * In SR-IOV or passthrough mode, timeout for compute
-	 * jobs are 60000 by default.
+	 * By default timeout for jobs is 10 sec
 	 */
-	adev->gfx_timeout = msecs_to_jiffies(10000);
+	adev->compute_timeout = adev->gfx_timeout = msecs_to_jiffies(10000);
 	adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
-	if (amdgpu_sriov_vf(adev))
-		adev->compute_timeout = amdgpu_sriov_is_pp_one_vf(adev) ?
-					msecs_to_jiffies(60000) : msecs_to_jiffies(10000);
-	else
-		adev->compute_timeout =  msecs_to_jiffies(60000);
 
 	if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 		while ((timeout_setting = strsep(&input, ",")) &&
-- 
2.49.0

