Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47B6C25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3587D10E1B9;
	Mon,  3 Jun 2024 01:42:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L8BfMhoN";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DBA410E1DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7owkOgbJzgPYzZmHrFSEpPwOVo0XHQhvi8+o+SUNTHswt6Um2jYc3Nk3acl5uA+UjZVs8Bl8SGJ0NciN53/qC0t1vbhLZP4YMA7DnQoTnK2yxxNHHK8O2AhPp9IMe7ulbrKCE1zBX9MMr1/6nlMbQHlG7nHK4ndGa2LJsMLjU6LrHdwRbObYTAoYPqFx/e1Gf3u6U5ybPV2z5OLWR2sR10C/ANW3wNv4E1zmAvHxi7YYLhbfemzcA5vY7Uoi+zpxZ6sH1nf9KtaAjhLurE+mvhhDTVjmZ2Z3EnJje0UDYX4V/lMMdGLnYgI+1EQ1T1LU4jmrlHeHFD+FiCcPSuWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2ZdccTH44gQ4cqFP/Kov8Y9M9ugs5IfZ5j9GkLiEug=;
 b=eEIPtOzOhR9lSovvvA5S/uVbmQyCl4XDI9SjC4miqGkVB1Y1lErXpWK30uyneTg5ugTnDe1JhTE+pPDGtRzev1AlbZrN5k9fQCD0bAcifEdgCvEZfgzc0e2zL0U9u3nEiHWVy20HW96pgrBPYPyFggO7RIiT8spfyO881YeiiNPPibUGIMTOO8BzcnDJd22+i3azYvbT9BPLRpHhyMhi26IhUIt+Dq3c8vQFz47si1987mjnBSA3NpmVEwLsu6mYDMaYLSDYd8z+8VBEnrtuPPZUjH0+VrqrYfG8U+oSw/nLQOd7z75ZLSfygwbVuybjdU02FeFUkVQph0m0PYEc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2ZdccTH44gQ4cqFP/Kov8Y9M9ugs5IfZ5j9GkLiEug=;
 b=L8BfMhoNh5xRfW1opiulPsL19YWK41cLQdpEOA7NVrqZ+3ekJBz1Pgj/cxDnlMzk4vF/GSvqzU0hiLjVP4MAfjaw6kQQqmqASZSBBY2+Qe+1TIzcAgLNBnomXYWgzipvGCLCXYbYjhK+iTxFqXvquoDLGHUzexBbP8cyZmUmXj4=
Received: from BYAPR02CA0038.namprd02.prod.outlook.com (2603:10b6:a03:54::15)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 01:42:47 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::a2) by BYAPR02CA0038.outlook.office365.com
 (2603:10b6:a03:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 01:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:42:46 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:44 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 04/18] drm/amdgpu: refine mes firmware loading
Date: Mon, 3 Jun 2024 09:41:58 +0800
Message-ID: <20240603014212.1969546-5-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 31257529-f460-453d-ca36-08dc836e7846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FYtoKa1k4eGm8cXpBQfxcDkVhB4u6Nfru/cFZXyy7sYyP9stcfuPhu9uvf8t?=
 =?us-ascii?Q?EnGMFP7Rblorhp1XB3i/s1C75hVsdEwh9HLg/4GYaKK9K+L1IbOEZ8YVLzNC?=
 =?us-ascii?Q?ccRiC3J/tubLD2AcaIP4ynDb3vp7HwbtJvkqQeNInB5FhsqybCrlwJ/5abEK?=
 =?us-ascii?Q?ldHxQ6RDS9ymI3HscpdGrm3m+5s8504FBliCvEck2ptQYnKMPQfhNpU5s7iz?=
 =?us-ascii?Q?GRxdwvLY3tio9aCsfy8VgPXCQ8IxOuHJhw5aetBKSZ9XclwxljapG33zenFS?=
 =?us-ascii?Q?2TEynqXkMQT24OvZ0qMJJbP8++mwHJdzF1AAbgojLjrzIDLvO6EN0wN5a/5j?=
 =?us-ascii?Q?0t7qbNQu73TkGe5TeBtOKaHZaRHDbMWaRVbKMeH9W5fdfhusm8MCVS+q07ZV?=
 =?us-ascii?Q?zgtBsjMhC85HSApEuKhs+0/92y17Tb/Gimf/VFDIJV1/4l6WNd5/kAfYiuMg?=
 =?us-ascii?Q?wa5Fo+Hi5x+snf2m6/GfzQlzol7i9M7koLbm0HvmCeY3Q5HSt5l4GF1BETGN?=
 =?us-ascii?Q?HXIbmU4YA4+dYkC/R8iXfSfNUx3RDmODUWyTp+hvMQ9Ak4p9g0nuYBy6aF3A?=
 =?us-ascii?Q?qUqw1lNxxiYTwklh+akJpMYs9LqnMu6mev19V92k9WvsXOOijSHsv7BDVW8C?=
 =?us-ascii?Q?/V0RHufJ3ngUcHvMOEVyuTIK+fY+sJw99pAMSHTR+wAfPL4op0oqLBFW48Gu?=
 =?us-ascii?Q?znYr8VKprsfhmNo/UKP0IG9rJSu56ijB6QwPwQjLBmZ5VnmDeZjOQSjfVnDM?=
 =?us-ascii?Q?7CvKtgFUHqaDqioJ5WI9EM5jAi7wJEKSDSXIGHzVT2iEY12c6FTuVCiULsj4?=
 =?us-ascii?Q?TU1a0BGknCjINRIJxRSM+tZnZWNtdudc/7nEbX8kZp7i1RnDLdPswuirzQDw?=
 =?us-ascii?Q?o5bYKGThlXcusWsai/JuZcNMgPgi2a8GgAGxD7UusNw3ZOzkxMymFlIegOo0?=
 =?us-ascii?Q?cPaLSZWYbhI2iu/9eRALR5Ssco8ZL4CoXhhN47dbe+haSDgqF6ioEWhOTIqu?=
 =?us-ascii?Q?ULv7k4/XBpr+HNfC2IAec0NLKTkBrmjMyj7TkMNGss7zMKtn4O4gzw9+zFwA?=
 =?us-ascii?Q?4/BJxop0sVB435tTVMv2FoTDO0RLH91I9EKR14WJgsBduo+WJ5ekriflYnvt?=
 =?us-ascii?Q?aWYZgYr1M7+V1blqkBaf7PimwIDNGP9I2lgr0+dDDcjdnZ1wyz+Rwc76Ei86?=
 =?us-ascii?Q?l/bU8kHLL8hW5Vnd5wWr+8Wy/TxkNIJLlF/WFfj723naHI6t37J1ZlP8+qMq?=
 =?us-ascii?Q?oRNlUBBp3/eA4gf+fH89ksYTaO2gz8WPsFp3vOHt9QnFgkwqK9Slky6AmGE+?=
 =?us-ascii?Q?PBDO6vh0Y799QG81TAyH/jqms/gZB3MoA3JWqLHdhKA6U7UcqlIHByF+LFo4?=
 =?us-ascii?Q?1Bc80NbEDT27F6bN0FQR+LpRNlNX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:42:46.6064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31257529-f460-453d-ca36-08dc836e7846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
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

v1:
refine mes firmware loading

v2:
use dev_info instead of DRM_INFO

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 62edf6328566..48a5b0713fed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1528,11 +1528,9 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 
 	r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], fw_name);
 	if (r && need_retry && pipe == AMDGPU_MES_SCHED_PIPE) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
-			 ucode_prefix);
-		DRM_INFO("try to fall back to %s\n", fw_name);
+		dev_info(adev->dev, "try to fall back to %s_mes.bin\n", ucode_prefix);
 		r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe],
-					 fw_name);
+					 "amdgpu/%s_mes.bin", ucode_prefix);
 	}
 
 	if (r)
-- 
2.34.1

