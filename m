Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C80CCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 14:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A8BD10E775;
	Wed,  5 Nov 2025 14:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gs+iUNhA";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9788D10E761
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 14:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZQ6eFeut8HBMeJGP5c9fjih/Aw4R6v36cR1Ff7swEJm4kLDtByBaPC7h1gi1GP/rEcBr42BFLURnt/S/byXH+tFOpdkVtfHcLP+b5DD7LFQ+H3pP8KabJAr03JUdXDg/EuOs6lalPWzCk53fANB1hpZcfJwEtxCVLgrjrTFg6TIL8BPNxOv7Ubm3QCZCQV1FD6LvsrhTuB8rrOvbBwsgKBbLnjXA/SoMO6TdMUM1GR95gx2XJo8exl29YOrquzBFMRDQTpSzlfbu/eEK384/yAYReIrGTyQhn0ee0tPZvUWMLGwghHQPIbl5FtWHnQ5QthbCeu23jwQ0uFrEGWfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9vU3tDiy5AwyH0dKvyjIVzOX6uc9I+aiaoubefe+Og=;
 b=Yg6p2IC65OiqcfKKloJbe1v8i5UcxbdXRrcwrdyZjfjrUkKXA1NPQMH2lTc4b97Zs/JTLTYfM6byT7y8pF+nOkQvp8j/TWlUKxIeAOd4HZsY4yLtl9r4nOdvmJe1J6VYJ33DnLnBla96m9B4MVB0ketgb/IL3nVnImr6jrVtO4eNGak9GJxM4vw5cBRM1aUFkPeOY+82+xwLg+tjv8w+jo94B1znYvnsoqKs84uASdCP7zBUjAN9X2bGPbjPANaHXUKce2a6c6cMe9aZawpi+UKh5t+g8Lfxm/c1IhEKCYlsQFR8S/DZu5IWyoSqqXlynO3nHRr5WEB31tfb8titxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9vU3tDiy5AwyH0dKvyjIVzOX6uc9I+aiaoubefe+Og=;
 b=gs+iUNhAUJvaIgfkBQVDDQncfXZnqx4/1Ino60kact580VTO8d2o7dmVLDzdNDw/cKNO/9O1/9wfYiM6k4npX8l8A26XTPdXzmHY7qofhAWQivfaoD4qV7R1s+DForwYgPhdz2xUf+YLZzSZ/dAI2mfa4ZNNzxN0gwWG7bhavrE=
Received: from MW4PR04CA0277.namprd04.prod.outlook.com (2603:10b6:303:89::12)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 14:51:03 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::96) by MW4PR04CA0277.outlook.office365.com
 (2603:10b6:303:89::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 14:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 14:51:02 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 5 Nov 2025 06:51:01 -0800
From: Ahmad Rehman <Ahmad.Rehman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <philip.yang@amd.com>, Ahmad Rehman
 <Ahmad.Rehman@amd.com>
Subject: [PATCH] amdkfd: Fixing the clang format
Date: Wed, 5 Nov 2025 09:50:47 -0500
Message-ID: <20251105145047.167807-1-Ahmad.Rehman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b44cbe-eb7c-4235-ade8-08de1c7abd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tu0zRhVGvBhNTgYEn8gBjybxLEiRE7wgyEF02Hewy3d1qKH3y8OFFmcloDiU?=
 =?us-ascii?Q?B+EMD/usvBDHzLfE6XbkJeSWdjKKc54ImSI1a2K+XBfB/bmuywsK9lEwMl3q?=
 =?us-ascii?Q?tXBP1n3pQmkaV82RsMPgo9w9TsoHmN8H2yDXNw37WhP1Bj1Vhyl4tPWs8HwP?=
 =?us-ascii?Q?+O7QfEyzk2dgmt0riq0BT+RGS8UdsxRpzm/DRkOuRX6gixveqhRfHP10Lh1G?=
 =?us-ascii?Q?F3/w+2ibUknVPj9CAWS5xM91LOw/AqmZ6TY3oTQioKkZkTAzzhEBXFB+PUwH?=
 =?us-ascii?Q?qAWlaWwvuc4Au41fcCmkGY8E0irYWVIlpcVXbrPd5kQUcbanA9NTO6zObFVD?=
 =?us-ascii?Q?Aj/PeDg73+5O2LtPMmESho69PqfkCzWxgjKFW2Y2dXINBd0pnK2vMkS2NyZY?=
 =?us-ascii?Q?NhWLb+Ca/+2oE2rcqtVKqT7J7xozaYEZMU9dNvIzDHJGegcuOS/djlXUYBeE?=
 =?us-ascii?Q?DHcnoeW+3Lo2ReuvC4Ypjqo2ugg10n3H7O8BULLOxODdJFgUPVPTvqyuzpzx?=
 =?us-ascii?Q?GafE4MI4pUeW70iPuXkG/Mmk7WJmVrdNUVhAZeTN0c+WuZVDiCgYh2SCRrj7?=
 =?us-ascii?Q?BC5SGCRtH9rTMNJYvTITzO3S/NMF5pzvYo1bSJIpA/EkRw0RIT3qlOA4m/2W?=
 =?us-ascii?Q?YSVWJSqcZF354V9uqdayD8cpHiMx1XQ3Ja7401jzpXuB5h9q97h6BVPnTe20?=
 =?us-ascii?Q?OhX+OXS3uXmCOadoEOdslLPhZ5OdkWEJ44AgvkfEEXwobak26A2IEinAlR+o?=
 =?us-ascii?Q?Z9oiZ5MPQRQH2uCzbsHOff9HJGjp4RNpFTKAqMm4m/yYr7l8a3GSDDli05tx?=
 =?us-ascii?Q?EtZmtIlnF/iX65rEnMZZe3H6ofo2dcITMVP8mgXIQVt1t7w6i2bt7eg7c9iz?=
 =?us-ascii?Q?QZUQ0ELuTcAZVfd5GaL9OwqCuJr677ineQFilJcC1XNxD/4Ro0j7fAs8ODSj?=
 =?us-ascii?Q?/Zpw84/ryIxuM3kTNWLelUxzSijoMZxZ81kEL+eCwXJ6U+ZR9soFhcI07fdJ?=
 =?us-ascii?Q?c8+zNTLfe5+P2TMrui/nJaNX8biVgj7ERW1xkrY6vkHC98Lb3wJkh55ukz86?=
 =?us-ascii?Q?h6fuORyqDnjT3Y41YkgNQjqvxXEtxr+48ktnu9fb47eTswVyERlmsbvnVEVP?=
 =?us-ascii?Q?lr1r+NPPIDRBn4W4ztZ5sNlt7TDL8RM9iEPOluagSKnV6ytZ+cvo3aGqH3Sl?=
 =?us-ascii?Q?4FHXcMJrL36/o84fyqTSOD57BkQa/88dxf3vLnY+Jf1wzNau2i4Ntfbk0CfV?=
 =?us-ascii?Q?xv/JUZP9uKwdti6Fmg5A//l1W+mKa1+TTTkEvHdExnn39Edp6KCgYt1o98CF?=
 =?us-ascii?Q?BBG00IuvmKQrQVv6ZLFuhGyPiVTo3Wak6nCQacV2kSV5oDWoT4r+jQD0MQTg?=
 =?us-ascii?Q?nKllpdR9VCAjksyw3DxodM9MM45yQZjufTfsY1kD1d36W6ATusxCg7FZliuv?=
 =?us-ascii?Q?bIgF2VUxzEPFcB9vYSIg39d5WzKoI6VWuc4DY2zEHPOMg25MeZpGyxqvFkl1?=
 =?us-ascii?Q?SXl/wYrPTnlLJWwZgfFH0MTpR1lSeIxVyCwCcq8TiHJ7Xnuujx6tDF3CISma?=
 =?us-ascii?Q?dSRwXObYlbJWj94pCcw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:51:02.3820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b44cbe-eb7c-4235-ade8-08de1c7abd9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212
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

This patch fixes the formatting in the patch
"amdkfd: Do nto wait for queue op response during reset"

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0904c36192c7..d7a2e7178ea9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2095,7 +2095,7 @@ int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
 	while (*fence_addr != fence_value) {
 		/* Fatal err detected, this response won't come */
 		if (amdgpu_amdkfd_is_fed(dqm->dev->adev) ||
-				amdgpu_in_reset(dqm->dev->adev))
+		    amdgpu_in_reset(dqm->dev->adev))
 			return -EIO;
 
 		if (time_after(jiffies, end_jiffies)) {
-- 
2.34.1

