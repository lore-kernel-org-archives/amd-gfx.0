Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F04FC3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D5A910E4DA;
	Tue, 13 May 2025 11:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oPrTx5zL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7492D10E4DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfiXd++SIDdOd+yjw+8xPmR38qoGaw+2Vs9ueSRw4LFfKWEEWHitmGKDPK+dVTefROrDnKQPR8brHnEu19ERXgue3nuyxPp7ikfJSJ4/q9VPIIfAUVCiv4xnYNgK4kmbJI7uEJM7Koy+uJ1w7zZWWqrsRs87dTwfesTTDSZmCIy/1NvhHg8OL7KWmMSXyV5iR7vs+uBouWUFf64hprVQ3ri+ikGgGe87T1524fSaH+4CpD/LxFQslwMiEGEeiPwHqhT/JCeZFzALTeM5GrRvnCEVhZqCIe7XDH2erzzx8K25zOYOF0/WBcIoV+DGYL7XcthzF8ZPkBB7Z2KXwvpJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuTLUWppkU3b3xk0p5/xavrAaB9VDkVESTS4oF7HOWk=;
 b=BB/RrG4rCiPdSFhlIEhrlhssU41pmX+1N/I16wjMyf7BsxYCCdqq8dv9pAuObxGPoVRiQ9fiRjtLtiBEV5KbNaccEtg6VgZAfLo2sKfngZOVh2o4/mhVJRXjONuAUo4ZKIPJP2t/DY/jkOreow7AegwWcY7c1v9vj4D+1J0FpnSLS0w7mTVj+g/+rIjuNaK8MrVKx0j4W+onLvjU60VcjpFbCPTtC+bMcwu7Ry8mQpBh1diojXyaSE7iCKVOjo8ppvydFYKfs39tvRQK0i9whCW2cEzr9dVpXx14FdsAKTjuMe1r7tyc8OK0wNdgeTvFiA8UOOn3wtvaspGQEzXN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuTLUWppkU3b3xk0p5/xavrAaB9VDkVESTS4oF7HOWk=;
 b=oPrTx5zLCxv2cRibj0iPScMSr0PXUzWJN3a5D1JnMQZnfPlsVhhHW9niGN2wChIMNbgEvWoBS8HlAjFkn+n8ew8nJSGUodiKh4zWy6dtvLWsvZlU01B6i7Nb0mg4ed4NWQRmhkBWyPK10lpY7xEkUqwG8xgJ81H4BT0gtK84P4c=
Received: from CH0P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::15)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 11:25:17 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::d0) by CH0P221CA0045.outlook.office365.com
 (2603:10b6:610:11d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Tue,
 13 May 2025 11:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:25:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:25:15 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 13 May 2025 06:25:12 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 07/11] drm/amd/display: add support for 2nd sharpening range
Date: Tue, 13 May 2025 19:24:35 +0800
Message-ID: <20250513112439.2295366-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
References: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ff5014-653c-4f53-e59f-08dd9210d638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gXb50AH3MMAuDKYpblqFTcmfiwTLWOQsxB6TmLGlM6zmYBMxYHwgmDvGvvV2?=
 =?us-ascii?Q?POujV+7QX6ykYdGl6XwIfoooezDFjXAZcoLx1QkRearXJ0+KN5aJgzmMaKKu?=
 =?us-ascii?Q?Dqz53hy0NkZdvyDisC11lK0mZcpMdMrJdO3dlodHO1jBRINKAtib0yhWmXj7?=
 =?us-ascii?Q?xVnN0OBQxbbk4OzCGVqsjblLRrghaKNWI1bBqQ/Gc8AJzWLtwj+pCZWZudAo?=
 =?us-ascii?Q?N5cEu/xvrp26/DzucxOiDzX8X4SU/7nTTYOp8CbRlG+hWR5JWcP73UN9Zg+E?=
 =?us-ascii?Q?EhhRE+QE4//0jBhZqlzqMvdgJn2Oh/4BHVMJfskwA5eILnPBrRhxf9OouwNc?=
 =?us-ascii?Q?J/c8S9r2DVTjgQJ5OZFivnkOBUmez9EM6UfuboSMR/QIheeniAJlMMdK62T+?=
 =?us-ascii?Q?hIYCMRrzSa9NspLEj8gjjz0kldqWnNBq33HJizQqC8ALBCwo8MqLnQqzlhDv?=
 =?us-ascii?Q?hXHR91+rC3HxXp77BA4GafvEFQZ/WL2pkuSgpuI1cd+wQu8s62gdQ6/ngsYq?=
 =?us-ascii?Q?tUCWwF/r2lQ72tGB6uu4Is4XR01tauHAjayzfrtwKMVnzeWuyc8vRONy3bb8?=
 =?us-ascii?Q?0TJuYgB88KocYfD4zqITklRFkhFz2a5yoYeQ8QRxkyi9Li8/O/mM3cf7AcHy?=
 =?us-ascii?Q?RB94VCtbF2ok2VFHDMlwVkOo5K0qiGTLtGRCOEDyP5tGRkqL1D0K7J+r0aOP?=
 =?us-ascii?Q?VdupZOxZA9aM0ZaHabokteIxbvVNjzTY5donPZ8ERC5D+zPQWotylLQx+OdN?=
 =?us-ascii?Q?Pj2k3GxYmpmKyRsEk2LsTBwT3Wh2xwNwNjdFhRrElIuJKV8Nbvr+vDUvhlNj?=
 =?us-ascii?Q?FhTRT+PDTYs/vyCLD6qJ7tJvtbZ52/QRnMC5541gzLNp5cjXEiCNcwyDGoGQ?=
 =?us-ascii?Q?sAnRl2S04V9o3LN/YgUlxl954udE+AfWipNAH2S8e9Vs2P2hziLsDQ9GZYEE?=
 =?us-ascii?Q?4Vh5w69RKb4iDh93aUga5zhxASqTdqV5WrLQI4ZkTp8kMw2D1fy2Jo1KD0wx?=
 =?us-ascii?Q?N18Yvonq7MikFW02fZ2mZ1uQE4YuL7Jsxq3P39/vWeW6syoBUfLOh6cX7ZpD?=
 =?us-ascii?Q?I3GdkIlFlYTHxj1mhByvkgRuU0yhIOff0uRW3sdYV3d2Cj+pX+8Sl1z+1eP5?=
 =?us-ascii?Q?6iTmPLgV6RZ+x5gE+6wBF+XbaBx3pBQ7BkRrhvg8vFCu7K65SDakX5gxlk9K?=
 =?us-ascii?Q?MdaO7w1h19BI/boqVPOL+Hc20EGIrxN/BvUdHHdZ72kADofY1cEgCl9lRfTV?=
 =?us-ascii?Q?UwEd26hoCWzaeTOpL9VUKp0H1NnJqHz7btZ4512JR6xGYin9yC3VPwGNd8f6?=
 =?us-ascii?Q?h/dv49lql8Ixra9TU76CgD876hATmSgk89gFBHtxeFMc5z7n/rhPGqN08+EP?=
 =?us-ascii?Q?tM+t0g9m652E55IECA9W+NtRr83ow1iuH6KMmnjX7ZNnOyQguWldNQ38rcq3?=
 =?us-ascii?Q?l2vKxMthqCUDgF1owx0ADP/rgAVmI88w0mqhvnAn6W0MaAnjC35rVd/LpSJ4?=
 =?us-ascii?Q?32HcvygXsYcSyYyE5YN/+cygR+8Xa1xhYyO6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:25:16.6906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ff5014-653c-4f53-e59f-08dd9210d638
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
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

From: Samson Tam <Samson.Tam@amd.com>

[Why & How]
Add support for 2nd sharpening range for cases where we want
override existing DCN sharpening range.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
index 1c3949b24611..36a284305a70 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
@@ -480,6 +480,10 @@ enum sharpness_setting	{
 	SHARPNESS_ZERO,
 	SHARPNESS_CUSTOM
 };
+enum sharpness_range_source	{
+	SHARPNESS_RANGE_DCN = 0,
+	SHARPNESS_RANGE_DCN_OVERRIDE
+};
 struct spl_sharpness_range {
 	int sdr_rgb_min;
 	int sdr_rgb_max;
-- 
2.34.1

