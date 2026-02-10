Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD3FEA8118
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D4D10E585;
	Tue, 10 Feb 2026 13:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2jhqIE+F";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20D9210E585
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:56:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhSFY+7Unf/t2iGo+wXVg/fHIqaq/nBbomm903sLgAwwRz6wG15I1mmuo0kYe86LQT5ZofajZyufM/JSbgoM0n40nuhbkUwuU+DoAC1S5gt4Q/N0rm8k/jM1+Xu9RnnTiKE9CxYaAEPr7SoHZ10kFx9ENiN3qt8JrFGFWXa+R/BezYpq6I0RnnA2J25lOhWQR+LEHiSh0uABfe/tua5bGoMTYZ+DYh6FVLSDLOo2JdSo145F16vZ/pcd0taFDSw5JiRo5xTSZpCmuSQJrRF6YnU5CjIiyYo8gEgYSnwvepkxc7w4LIvE0ji1lZAIlKV90XvMX98hP6wwDp8rIPVYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGNZqrOTiTheYYRwVPvpPiWjPZEFUaCAnV2rygMg0jI=;
 b=J8aK3HaLm2nrUEHqHIz544oo2cLHHNg7EqWjyn8r0A3MNiNvY812EErA/9nTIdsRFRCfRNB/7vP5otyX32ftLOvoJ4PhOw/3PmJfXr3RZRJaxrD04teyg/7MNgG/iZy/KeFA0suQlb0L8D5GxJUL/bQH3umzKDaBzyFv7oCuaq/DTmgon0tU6XyOw/uRYivDax2wVsH/nvk/Ebv5NCeJd+OAw9wVJ8IMXlPboQcX5w6QLhoXNgbcgP2RkbIwN6dSYd32tuRQA/kOnp/vYIcRUm8sjEwRvtvyDz+k4ViPhvlbdq+m+07yNMouKR2KsZhjwgniV3l+JGYXorUpUUa9UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGNZqrOTiTheYYRwVPvpPiWjPZEFUaCAnV2rygMg0jI=;
 b=2jhqIE+FDAkWUTlWv41suHPSN8YsNAcK9jaW3nHmrjJjDfWzqRRD9p89Wrl5saH+N3RSNakZzuJRdAhThI1y4hO2FGs5ZebilmtLvT2kKiAwrIcY4TGVhNe6b18w2SBNHqAH+C3/0bwI2vfHsGiUL3rRUHGBaUf/FqbO4n+0cno=
Received: from DM6PR02CA0129.namprd02.prod.outlook.com (2603:10b6:5:1b4::31)
 by BN7PPFED9549B84.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 13:56:01 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::66) by DM6PR02CA0129.outlook.office365.com
 (2603:10b6:5:1b4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 13:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 13:56:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:56:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 05:56:01 -0800
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:55:52 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Saidireddy Yenugu <Saidireddy.Yenugu@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, ThummarDip Kishorbhai
 <ThummarDip.Kishorbhai@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 12/18] drm/amd/display: Skip eDP detection when no sink
Date: Tue, 10 Feb 2026 21:50:05 +0800
Message-ID: <20260210135353.848421-13-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6c25f8-29b9-42ef-81c5-08de68ac201f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q+QU33E+yThCHy05lFR+xgUsiMIjo/YBjw71YI8I2DJt3/9Z0ic3+8Dc3DWG?=
 =?us-ascii?Q?hkWeAViuAIg+Bce9dhIFWIloplqCajs7ssn0wcypIqYeTmWWe/UD6ryV75hL?=
 =?us-ascii?Q?PVLVu5CKzwaisnwKLvm8C9nUelgZI+LKHY9QiesNV8C830lxoqIAktLe5RPI?=
 =?us-ascii?Q?nJxI0C52g1kmEBTyIXzw4ku5I6ACBZGg7w5qtBlofvUL51AQ20po8kMODMyQ?=
 =?us-ascii?Q?oSuiKOFT/OZUvUIZxzFkhlMdATzzcjGf7bpCHXugz0RoQmoEFLiZ/BWTEOI/?=
 =?us-ascii?Q?URIoLRGmm0XSDJchNz3zsZRe6yYzxcquVHw8+bpt+l/4GB7MVX2URRhGlIgX?=
 =?us-ascii?Q?mNcbuETaMl6DeqkeqLOzTJxgdFtljIFnzg7Imp75Q9dg83H7XxlA6Kz/8E5a?=
 =?us-ascii?Q?zwus3DIbTAmmHGKMPI7rfq1S3TWqPh7fgs+LVJWlzoo/cl4JqTCTqXBy3veO?=
 =?us-ascii?Q?eQL7RMqnYb36hNgvBljRS8KwDWvHRV4x+Y/oYN4lS/N2GMfKTqz7lVeHw8je?=
 =?us-ascii?Q?7kpbyrS4zKg7QMrbjA9ansq8a2DpcAEJE6B6/7XAESHia5zB0/No6RBy+Kdn?=
 =?us-ascii?Q?rrSlx1/hXICNxvfkIejJOkYXOyJBK0raovLWJNCodZkBMCJNK2p7XLm1mZxJ?=
 =?us-ascii?Q?F+wKZ1izsgaInpAsU1dIbxn0BJyztdpEznq1V9RVqe3NaXWQxrXyOBSWgawO?=
 =?us-ascii?Q?eRQzB/1m0w61Ua5fPo+WGbJg0aczZ0894t7iGyQyfwwWLuyjFE5KQBni1gPS?=
 =?us-ascii?Q?ehBf1Q3PXf3X2TAvR2MMyx48TwGqxonU5WPzuxT2vm+GpjqbfzaG/6+DPmrq?=
 =?us-ascii?Q?yC19jVYseRLB+SINhW4itxPfvcEmOCKiZp06QxI6SVrRQRaOB2lZ5FIljOCZ?=
 =?us-ascii?Q?v7BBMhDnz7OoLmSHtzCMFdRYAkoBxZyi/TbqcuK5LQTuIRW8WLWB/y8/dwHv?=
 =?us-ascii?Q?RaIiBbInEx17voE9VWCYvYPwL35wDFttZUwfyKKSa1Kkwh1PUZqORNRH+yWK?=
 =?us-ascii?Q?ME8oIq2pDNz+AEEPWLDbut0CX6YRPVF7EKOryEGgqRSshmnbQntNPAWDDwYq?=
 =?us-ascii?Q?azkP/nK0IHdgwafnjXDlwWW+Biq/XnNMuOKXRYv9KSunzQPKqB3IyAqQhG7V?=
 =?us-ascii?Q?5h+tA5mcsBUpOYg+U9CCj5Td2ifwmQi5F0YYFwj87gk2CpEg+xeeIOM0JQcu?=
 =?us-ascii?Q?WPpbLnHAU+mm3I0AGPIy34APjLSswrX4UmXyghbuYcZkqR67iqEg/ai8DkKT?=
 =?us-ascii?Q?r4XOcL6+zXlAa8Uaj4PTu24bBCcZsBi0iBWAEaYXDENxd9CMuisxEykwoYIL?=
 =?us-ascii?Q?xaJyDq9IBfhLkZZ0tSHD9YUn2CHNNHi+2WiLoAEm9A+TJk6eF+7ONRPjlfRh?=
 =?us-ascii?Q?UjQ3LtOCQROmtCBJqv05dFdA7nIdYzRjSb7jNdAtm9xShowH6YCmPdnLr4Es?=
 =?us-ascii?Q?9YUKjJBayUvpDxWcaO0ARNYtwJkaEE51eTRTaAaUzBQsJV5yy4sH1hcbxCys?=
 =?us-ascii?Q?4zkhB8FudvaHYCPxu+oFoHdPRt+dtgwGp840qGQSoysxNx7CjbU9DcOc1l59?=
 =?us-ascii?Q?vHZqvAzhy/erCVy2MGp27GwJyk9ct+QAHwGXi1uloGFj4UTw7j63SOOP4TD+?=
 =?us-ascii?Q?q140PA0RWPP/UpGGqeiSlp4MAZsbPBsyVF9gSJzD5js6B0YnW/X1yYJfRYWc?=
 =?us-ascii?Q?pX7rRg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fAa+KDq5UdZ55+W939Y8BDPz8DDxB1wIIH8CUpRne2ayJUUMDotIWZMgNr7zZIgyAf8eAfzQjeFAAWAKT42m9JRqbT8zytK0evPw4Aj/nbHUn3aKM62RhSd/99zWC9XopS0JjKNEMBL9zPSvHbT6RfVjHMPlQp+Yn0tpIDAQ77LNo8+CEVEi2e6zNv3l7mfWBPg8jvoxRZi/bmg5a9X/owqVsVP5auVSi0M50rZa+ejbMRdbcUQQFU6ZfZrSmPyGlTHC4zarJrO4/mmLtGli4RLv1U943RjqaYYPkhX2Ze/KArwKKk4hdoVCP8kO1OxpdeQWc8SM5H766u0DJPkR5ByNujTjkk/4yIYgKPANhXrUqNzM6p7lNm09ACZloHGK2nPhJ3XBUgzoeHPEm8Rx3s6sBO6zYTt7u2k8rJ3O51Fiy/fsrWQcJUyzcltk6fbA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:56:01.4995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6c25f8-29b9-42ef-81c5-08de68ac201f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84
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

From: Saidireddy Yenugu <Saidireddy.Yenugu@amd.com>

[Why & How]
When there is no eDP panel connected and during
s0ix resume, unnecessary eDP power sequence and
HPD happening, resulting in ~2 seconds delay.

Fixed the issue by avoiding link detect for eDP
connection with no sink in dm_resume.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Saidireddy Yenugu <Saidireddy.Yenugu@amd.com>
Co-developed-by: ThummarDip Kishorbhai <ThummarDip.Kishorbhai@amd.com>
Signed-off-by: ThummarDip Kishorbhai <ThummarDip.Kishorbhai@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 10a234e7bae9..ee0f52eadc0c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3614,6 +3614,11 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		if (aconnector->mst_root)
 			continue;
 
+		/* Skip eDP detection, when there is no sink present */
+		if (aconnector->dc_link->connector_signal == SIGNAL_TYPE_EDP &&
+		    !aconnector->dc_link->edp_sink_present)
+			continue;
+
 		guard(mutex)(&aconnector->hpd_lock);
 		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
 			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
-- 
2.43.0

