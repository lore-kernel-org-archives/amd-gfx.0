Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A174CFA44F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 22:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03AE910E0BE;
	Thu, 20 Nov 2025 22:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z8AQL4Rq";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013016.outbound.protection.outlook.com
 [40.107.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3BDC10E0F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 22:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfyJBPp0x2j9Lsor/yXN1OUT/52fCBvk1mvP7a433T2WmF1QWlxrEoP3uYZMCnV3Tynwl4SzzL583Q4Y4yQ7dl+qNNit20qzIIG6HnsNmcapkm5jxjXagedQIQLsQDG9Q6qS2RT6iUvGPX00XtbXkjYxux8Y6l99Ytsq8LilZkBnFcpktJjDeqtrSmvwA4LxyfisNRsuK+N9Nwx0JhH6x68vyd0vbQMxGC5ytjXmpbPi40jbJaut42Cr+W7rOWfz4sJ8DshDum8tfIVTtYTyyVKYfZ53QrLxf7zZBISmj77KV/G1aKwST3TUwDEjQBG4rmEMJxSP0t1P+nCEObqnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chgnLP2Z213VQGk4dkNp1K6mBZTe+8uM+KtbRrYZQ5c=;
 b=mtc42W9oJWLEioaQWzleMH7Tw3iFcfkgxfHmxjt9R0NMxvjIFZpXH/O00UjtkN5fVFVpiJ7NiveCrxFq6oVVoKjmS8PIOtDPl3P1TFBAmTU+58mA5dmdAiq2TmOtmkDckW5Hziz/V505kyh7QfAxrmwiGXp1NbycUptDKEZVcJULV9q7HWjLq661M6qAKu3z7U9GSuoXrYHMXW6rNK78l38INesbm4sC4XWWJudY7wv0pfgYrSKOj7MHGLOeKgzShw/b2Flh9Nxgux1Tx7viOAUPUdRLJ3ySs4hKofEAs8Gk1qh/ab/FWIurZky4AU1jxIAbglEc35qfRADHlLy01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chgnLP2Z213VQGk4dkNp1K6mBZTe+8uM+KtbRrYZQ5c=;
 b=Z8AQL4RqpoAUQjmfCvVuINGkPZKgU3kiBHlPHyq6Dz8OrbZRXHBfyIXbMLCrcuuX7wBIIyCdEqKZodmtzksHV3dD6HPH36PX21pFad06Vq3G80iLfnB8kMPsNUsTbPw9YhMiB5tuVFag/P1fOKoJNbf9bmQPAnem0+21uIdqCW4=
Received: from BL1P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::24)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 22:52:07 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::f4) by BL1P223CA0019.outlook.office365.com
 (2603:10b6:208:2c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 22:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 22:52:07 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 14:52:04 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <Alex.Sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdkfd: Add SDMA 7.1.0 support in KFD
Date: Thu, 20 Nov 2025 17:51:47 -0500
Message-ID: <20251120225148.23345-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120225148.23345-1-alexander.deucher@amd.com>
References: <20251120225148.23345-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 954d66eb-328b-4280-0a77-08de28876eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mguqyE/5q2sZKjV1/HyEshNWQVjsmped+XIOGPEA8idjppz1jv5tMj+MC+Fq?=
 =?us-ascii?Q?QZdzZuLjhUuyJ3J/CNCpTODn34b9lFCaeZAjJoyVKLh4wDplj4lR3Vl4Szgf?=
 =?us-ascii?Q?Sm+KKUIisuQe2RrG5PHwmK4emBObEtGd/amBEJzbYW6aE/iOxclYjKUbcdGe?=
 =?us-ascii?Q?pcgSy7o+/IvJ9lLyaPJAbxC4J5rNoC9JcgPPUNzam6+ncpQINNhRM0eHipU+?=
 =?us-ascii?Q?Q7DkDyfoWzI8OEmFcmEKzB4UfCHZTigNvwFyyFf5R1TcfNizmD1SgpRq9nW/?=
 =?us-ascii?Q?Sdai6KTRRLiP9SGKN7xxewi0Wo6YUdl+aJuuNNeyWtlgpq1gstZi/RDLFQZE?=
 =?us-ascii?Q?g19Lyn8C5I5zynevmcDSX4avghEgao8ZM/rqPq0XMbrk2x4KXa5+S37olgAZ?=
 =?us-ascii?Q?VstAEhWdReFR6vGmwpvKqjsGYCmJjG8F08DfuIjkxBm7OBdhqOWr5IETORzS?=
 =?us-ascii?Q?HKScCHj1urVECfn8IrIICrGMskRgEFqoK3zDCQr/03P59GJfYhNQ/xrSLtzl?=
 =?us-ascii?Q?WAVyU1zdB4HjMzCLqrRnTwJF25c1O7rsw8qglsWELBncvP0hVQmFt6bIMyjn?=
 =?us-ascii?Q?/Z/ZHzvKoIYTVNrcIhJ4rXCv95zIMYOdqmpaMjQ+7Ek16QmaYdTGtgIjaxJw?=
 =?us-ascii?Q?4xf32aNW/98q8xqqPk+iHqbGmdS9jROjGeze6H2QvY207mIW2/qWKmf4Jdp/?=
 =?us-ascii?Q?ft8/zH7EntyIcCe9S6J3IdOCqXFGr6HdAJhkRpQsdCWUijsmxzM5pHtwTWn7?=
 =?us-ascii?Q?dbyz7c3JVxbxJzae/uKl1Ujyewxkdurfzpnzf4p78+lvIbs+FMQJBeUTaH4k?=
 =?us-ascii?Q?GEnfMI/PLnGXchrqxRhnIge6TeTUl+w2Jl5zHNW5HlZTo3+xKUhzXreR+TcX?=
 =?us-ascii?Q?BuaiDfDN9IxKSKEu5FRX9e209pwZLgi0GQmVr5+0go6R+BjXS9YJaBSjWYsd?=
 =?us-ascii?Q?98lhetagByRL6P3w1/zGLHnI9x9yHnhLDzRPCh3wiHwkXZeU/AVzz3pMe/01?=
 =?us-ascii?Q?piwTAQHVgpeIiLzmwxXQdAbCW08ccumU34k+ZBqKarV+N8Vd3g1/uImNSdQz?=
 =?us-ascii?Q?temPcZMIKk1Mv646FYa9NWUISu2eGVJlC7/r0jaZEdECBKR/abjFaz+W94ij?=
 =?us-ascii?Q?sV9hbJbvfW0OQKEPZBtZfmCGj1Vv04ZzsX3s4yPIpKn+MpPhr/ABSsT40qZp?=
 =?us-ascii?Q?LC2hqZQhwvA2lqCOGH69YVX3iuSQDxj4xtRibGEn7cpUuCIKna3FpOLp/BBY?=
 =?us-ascii?Q?YcrZSK9kb2V/ge4zha4KO0HDkoUzxaPxptvO9BOJLup50uLuIsHFuXg22byR?=
 =?us-ascii?Q?ovF/P8sT4gjEtCut1df3zx70ZwQRZ+601RnEQUVLCw66GPBgeY5o1iLHiWMt?=
 =?us-ascii?Q?Dat2G2S3/SyIIC5llHArxNYSzxLQ9zZAdUelx1iXrpRAV0EAva1wQ4PucdmI?=
 =?us-ascii?Q?pe8XWa1E6204P0Oj8Hw+ufyA3Cuknvf9j6nFXZfVePQhaxpLpZn/2cdz+XOL?=
 =?us-ascii?Q?fEdIpQWJvFCze7GBjqZJ7s817bsGgSMqDUazyKb+6VEPy5VticVCrpyRtIa2?=
 =?us-ascii?Q?66+ZM2sI+fC29NycQD8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 22:52:07.5409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 954d66eb-328b-4280-0a77-08de28876eaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add support for SDMA 7.1.0 in KFD.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <Alex.Sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e3da2f149ae6f..25d8f671915b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -106,6 +106,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(6, 1, 3):
 	case IP_VERSION(7, 0, 0):
 	case IP_VERSION(7, 0, 1):
+	case IP_VERSION(7, 1, 0):
 		kfd->device_info.num_sdma_queues_per_engine = 8;
 		/* Reserve 1 for paging and 1 for gfx */
 		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
-- 
2.51.1

