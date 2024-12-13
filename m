Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8805EE7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 11:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C3710E1C5;
	Fri, 13 Dec 2024 11:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zEmeMob9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF3610E1C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 11:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9dqqmFFa86Zklv2S1jQCqeW98X+DAX9VIwfUcAZF4nz9sz0rhVa162xB9A+DzjKjZxM3i0NoxKN1dcEbQC8H/DwTdbb/X2YXXFdLCsUc+T15HRIjo9LxOWLUaOAs++CoZty8idcYjpEENIW77wT1H5HxpjmlAcbJ8E+P7MHug2Z/RFr8z1MiStF9rfXN0Lrv4m7HAli4gMOg49Sf9XWuC8wqQqUWKOMUk8mAYuBnvdETQBFVgbwUpMiRKrcYtX+CO4cjalVaIwRLd/GDf69/9dboLgMANSsHBUY3sNtZHdXJOXAqqSORZq6z848tY8T1PBL2uwNDSdgemTQoAr5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGs6mpP72I5I8oD+PjV6zVp50YZzflMRg+p8pPk+Y0Y=;
 b=DwNVa2k3zSU5YBA8m1aXXOi8EWOHqwmHIdCupT1qUTfG9vnGrBxdNRxx2jYHZy9qJnH4yMZZu+nd+GBq1CzmKclm1lsGtg2HlxCyjcs83jZlrYZ5Gka8aOCYC86neDuCWHZ9taFPHFubo0Gy0+KTeBd9Y1kY098WysKm+KH0IWqXXMqalTgcgLMMVLbiu8QjkyyrsBmvq7DBOCrFF1vB8n5bHNvOT//sH0QA5GGy6/mC7KKOKet+nYaLd6nrMHcI+5GPM6nTvdT/FkHrc6gQg1x8aozv4tQ31wBAx/lo0xL/daTHoUWyOUi4sT2IOl8lcLiApUqLEN0VZIOel35JBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGs6mpP72I5I8oD+PjV6zVp50YZzflMRg+p8pPk+Y0Y=;
 b=zEmeMob9HKqG5dW3mhhvwY2AYu3mdWdmyfWO5pIa8ABx3FdGVfmBbBRLOl2bL1POZXhda7qFyOtyW5xVzazMc2/YPlb9gb7S3Nk8Qc9kJvrNa5tjo24yxp9pLc98ooBNiFZYVjUJZgM2oW0XfLplZ4/fLf+R+eaCMVaJ1SVvr60=
Received: from MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::8)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 11:41:14 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::5a) by MW4P220CA0003.outlook.office365.com
 (2603:10b6:303:115::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.24 via Frontend Transport; Fri,
 13 Dec 2024 11:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 11:41:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 05:41:12 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 05:41:11 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 13 Dec 2024 05:41:04 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, <Tim.Huang@amd.com>,
 "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/sdma4.4.2: add apu support in sdma queue reset
Date: Fri, 13 Dec 2024 19:40:57 +0800
Message-ID: <20241213114059.3170033-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: f703dcb6-5a12-4be6-dbcd-08dd1b6b0c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jD0LUMkAiR87hvqVEqITPXQPnWywJ/H2vqwfWlk098lCOTrJf2zrohnrIKWq?=
 =?us-ascii?Q?BaDLbXS0XFwX7VYWrVjW5SuIj73lwmpM8SFdiJ5ye7HVNSe27U81NlhKRlUy?=
 =?us-ascii?Q?GnjL7S45Ba7w9911MdALkAvLyJ4eOTT0VwzCBLigzAl5JDg4jjRgUIBjHo63?=
 =?us-ascii?Q?j4VXNqHKjg1RN60aSlRsVcVbLVE3qk009V2B5hLkKbqDC/lDw9naLe/O+rDu?=
 =?us-ascii?Q?2j/JR431HTu7M0BDEeklMHdkZWFiPLFH2Zzg5XzMk+bhbrs6Y92Ktj0lHSal?=
 =?us-ascii?Q?34p+SPDb3BaeG9hEvgFeGljK6kFTvK76niaSSKSR/T/QXGqVz4Ga3jMB9+sW?=
 =?us-ascii?Q?M426Q82emTRtDryVLS7nx/Op83dzZ4L2G6t4k7/NcZVTMnI2x3/uEuZiiPTY?=
 =?us-ascii?Q?HtKVywHvp0fQfIZyht75Wsc51c8OTlXnvjKu8qX5t4/iEkTxFpbCm8kHg64Z?=
 =?us-ascii?Q?uUBYbdQRR8RoEDazBMlFBNr380F+FUrNxKbm/L8TQWxe1+XEWv/tl82lJpBE?=
 =?us-ascii?Q?qU+UPm2kU95jSioD4up4lb9jiDJYG4Cn2w4C4rchwNTLEbKttc0UjqzLx2tu?=
 =?us-ascii?Q?KgFUy3hKjbTJlY1tyWj6kYWrHor74k1F9+y0B25qj88UOZ8WsF8+ypKS8hfX?=
 =?us-ascii?Q?tVhxpW0J/mDACwV3hOCdbZMqd5PQApsObR1rh9nomtS51JKFKRyzzJUHItk1?=
 =?us-ascii?Q?WgQuz/ARVey9rffVV+ky/oQacMOhMnkT5GsfaxGlisND6Fo1WROOt9+OUtka?=
 =?us-ascii?Q?CBKO+z1XGTAyjpuyyweYApdn5YlSo3oI8iGSTLfqXYgEpnWFg52SBgCfbIWO?=
 =?us-ascii?Q?d/gNDKhnPSEwy/D+fOarasaW8xn9eIIHOBFRS6CDXKh4vmedFwgnICWCW5Tb?=
 =?us-ascii?Q?iu07kFo6tZYd6KhVi5ocqRc2t5wcngoZNmSu/9aomLFWa5dw9xj4ociN9ug3?=
 =?us-ascii?Q?cYlY6AQjUM0r9bQeujpibNCsJgCcCUVAhbud+93353wgKkjjFRSnfMdH0rko?=
 =?us-ascii?Q?Vl0duSjG278+qUPIdFhMEGE6iyx0A86jxngw08MYsM9xmwK26YCRintj4Uw7?=
 =?us-ascii?Q?/NVirI8SYAEitwHVai6g3WkI+GYPOQWmnwMhxm/GwwY8KwdfCXvV2T+g6otz?=
 =?us-ascii?Q?u5rCoq514Pv4G9WBM+M8iPcN+TNy41sS1Shw+uBThhBiiVD/YPhhJ+BfGBfk?=
 =?us-ascii?Q?9WF3EwN7CaLPW9e8Hsnc3mCrhqwocpFLZr12DY+PEPPQF/ZVVoFG1jywZ0Y/?=
 =?us-ascii?Q?nLI9nrSf0y/PfdN2WJYRMpiG4+4DGzYIKfBUx56a5udk1UTkZZn1XQP2lD0M?=
 =?us-ascii?Q?D6FKOlP0PVwDDPD1IxXNxS9Esxf42xDZuujkOsIWuGixCMEq/0IDTFX8va45?=
 =?us-ascii?Q?0otsqRaE3m7hafMNFbYluvwBSIEJFZyJ3ofS8j4ElXrKmzkagkwyzQOIJdY9?=
 =?us-ascii?Q?9UUyy9fuLJyuhbSwMErj6rivZvK11sdvU7mxf4xMQVDuovxWBmA8SKh+GiHy?=
 =?us-ascii?Q?rdYuJPbB6vClGcc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 11:41:13.2964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f703dcb6-5a12-4be6-dbcd-08dd1b6b0c09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Remove apu check in sdma queue reset.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 5e1cb1c2c0f8..e39f1f495ea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1600,7 +1600,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	int i, r;
 	u32 inst_mask;
 
-	if ((adev->flags & AMD_IS_APU) || amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
 	/* stop queue */
-- 
2.25.1

