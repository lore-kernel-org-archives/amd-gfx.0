Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1DBE7719A
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2025 05:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4527410E554;
	Sat, 11 Jan 2025 05:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ykv6UaKP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF40510E12B
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2025 05:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucJgY3Sx9ZLSP4I965Ch+dJI5NICo6S5ke4asKxwjsRvsbEEYkcCD6PF8mXdH11lTFse/+gjwRTaT3p1FzN1FIckyMcdt6Z13GsFhq7H45Y3KCy/vVp44MYmmFWaXNyxxR2V06indnPeXToj/OzW1xKqnxzqwcclsXBdgXr/vUVvypAA/7BUDutt/A0yaoa3yxUXkeVL4FSFYeBFDeYX57n43Dj9EZXfBDParrs2k1XtmFOlnrVcBCEqS2GgVG+w5wNZIlMdzTRqL8Ipt9OVKtEZkol6y/diTe/fWYR9AFatErvIubVmGuNZ+SDxJB8yTAqfrefpCvfZnzBsAW7S3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/QctzwYmfsZaDxk+jct8wlLJ1PG09snFOcoT+Da0m4=;
 b=g6BPn1adCUSRYQbRILPW7Zvzm4ISzbOEtHa3t0lIMHdQNdJp7uOLGTQnJ+3VmGDViLCblNfF20iUKzTPL9wOFuwbS2aGsP/LpzEwzePpew2fZ3wmwQQUZvyMfonX3X92eEtsrtm79iVykuOVD3kyvoxQs3kraF0fl1l1bubYSJaP1Mepkb7Kc003kc4nEKssXrm+zpQ8Y61I/gJUA99uxUYTAKh0OLHC0JJ8i3LETada73/OuxDkbzMzXRuCURRzT988nv6kRv2d0+Y5BAr9W71xY91WdiYYxQxwn/L5ZMsfJRhKqzYGFJFAlFRzRx0lATnGPaaOQs2BdE8ME2fCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/QctzwYmfsZaDxk+jct8wlLJ1PG09snFOcoT+Da0m4=;
 b=Ykv6UaKPv4IT9+qrHvAsQO+k6VoV4AbgV6DWEGN4F73p+aNekRidbMwyxTsmaN+j9jEiSvWMMgRB2w8gWFS/Aj06T96CK4bMgIXo6F1bQo2VOMSjgboRNIIIzKgMftIoe98laj6HJha7B4ofvucmDL8qEq8xxN6XO+VGD+e6uQY=
Received: from BN9PR03CA0235.namprd03.prod.outlook.com (2603:10b6:408:f8::30)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Sat, 11 Jan
 2025 05:28:25 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::9) by BN9PR03CA0235.outlook.office365.com
 (2603:10b6:408:f8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Sat,
 11 Jan 2025 05:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 05:28:24 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Jan
 2025 23:28:22 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <alexander.deucher@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH v2] drm/amd/pm: Fill ip version for SMU v13.0.12
Date: Sat, 11 Jan 2025 13:28:06 +0800
Message-ID: <20250111052806.36431-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecff768-3b4b-4384-5efd-08dd3200c566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XsyFtsGu70617ScD8JCidIJeGITsyHYUX9MRh18NcdAAPk3IbqTuWr7BDvk9?=
 =?us-ascii?Q?KVw81Q4fIZde0gsGbkhQug2OJLQxe7SwwcUTlwEJQxUl9VUGf2JGHZuwPszr?=
 =?us-ascii?Q?rzn9TnEB5XPeiKAnnh8nmq8f5wbpxDzORJLTgEeabeGvm1Hihem4rphacqFx?=
 =?us-ascii?Q?Nd0WN9goGxmgPulRNPBM5TdaGGA3vhJ00Tzx7HfW08hJ+y07NWyL05FTxJxH?=
 =?us-ascii?Q?sUiIt9QjKVj/lKjjqh/XBfm8G/3SPC/nZAPRrmIbahW8jj5cALaco4aq6BPm?=
 =?us-ascii?Q?u8CP999aVUv5Rt+xk4ohqGjD85UgeR2+WgOLZyrr2CQaYVz1NBWlZ11a5/iE?=
 =?us-ascii?Q?ZRIkKj8/dOAJ7CW9C9GJZtXXrSCkiGX0OBYarhz6BBZhOaQ5Oz11vIXTBPBK?=
 =?us-ascii?Q?GryhudwFYVib5nYKtvT0nfo9AspE70DccG3ZaKXV9sR0V+I8piLKew9K+ZPf?=
 =?us-ascii?Q?ANajrCEYJLgnSREREq5JuxwdVLjUZ+gQLyzokddMDcM5yc7H5/ezzdBQRv54?=
 =?us-ascii?Q?EJ3QYidDJgushBPa9SPzW3XfBdyl/XAXNederIR/kXJMNBdnRC8y6ipBhqiM?=
 =?us-ascii?Q?9PKS49XNUHLeccyAK6QgVugCqswOBTGAHJJLb5F2aubtTovmmWdkkO3f7Bwx?=
 =?us-ascii?Q?YQ7wg2U3ugn3fUBDX7g7z6bOskV91WaSllPgOPGqjbtZEOBaHYiRoMqXpDcq?=
 =?us-ascii?Q?MAC6CwSBpr1mOehP7dRoIwz+PLY1pO0A0BnIrdaxgokefCB6pLB6PAS3Z3jZ?=
 =?us-ascii?Q?MboC35T607iq7MN5nLhAfBa53vJIFlA5W4KbPYSWORV5cIhIgrE6fMB/04zM?=
 =?us-ascii?Q?b8gFTp+RGCqQlv5O7NUuYV/otLY5F9DbE30C7ZXMUlUk1mh6u/2W8s34DCrh?=
 =?us-ascii?Q?/vPe4o/rH6Vqljf7Wnmlr/zLL8EXKwaotyAphNrxzIUaa3K2NnC6qKpgnzNQ?=
 =?us-ascii?Q?pV/sC43zPHrwiEQkK0LRmxTAQeZZYb60m9luuOUlGyTuXPZa0wmEaF9Q8Dqf?=
 =?us-ascii?Q?bchYjvzX7Ddyn9xrGyFlYBQ7AXGSPJnpLKVJPNApa0MEIjGxFRs4H+jPxtil?=
 =?us-ascii?Q?Ryjp2/L6cq8UeP07vmCYETGNc3Gw8pkxQUn82w8Ol5IE3pSDd0F5ZoFCPOkj?=
 =?us-ascii?Q?ETTARvF1tQ0BistSlMp4ac1uW6k7Pm4k17VLni7vVz4vY+xlZiN0j5R7eQId?=
 =?us-ascii?Q?7OS+wEvlobBqDF0tV6BHC81DvvAWwB81XogTbJBj0YixhPJU56F6lXWjTAkl?=
 =?us-ascii?Q?/v5jW/kaLoNYQkIEjmIFxEGewqo/HVDjoxZlGdXP3G5X8wfUGNTPXgUkyp9f?=
 =?us-ascii?Q?aI0BlBCZAxVzBFjA/sGyGxjiwwrROGRqOfCr9RlPHA0DZwLSZfYzoqJBWNlx?=
 =?us-ascii?Q?HHaMrt9QJERoui9XjfDOnpSJ6pA9aQv+A5palTiZalj/4KR4+1aYbhg4DB75?=
 =?us-ascii?Q?Ml+9DHq92IYIgAD6RNVd4ksYlArnWsoUQi4lgUBoYxUTc8yVJ7H965Z4nKAF?=
 =?us-ascii?Q?/hp7KNyx6mn9RB0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 05:28:24.8906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecff768-3b4b-4384-5efd-08dd3200c566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979
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

Fill ip version in pm_metrics for SMU v13.0.12

v2: Remove ip version check(Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8ab30b2f7119..f358a8abe91e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -599,10 +599,8 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 
 	memset(&pm_metrics->common_header, 0,
 	       sizeof(pm_metrics->common_header));
-	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 6))
-		pm_metrics->common_header.mp1_ip_discovery_version = IP_VERSION(13, 0, 6);
-	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 14))
-		pm_metrics->common_header.mp1_ip_discovery_version = IP_VERSION(13, 0, 14);
+	pm_metrics->common_header.mp1_ip_discovery_version =
+		amdgpu_ip_version(smu->adev, MP1_HWIP, 0);
 	pm_metrics->common_header.pmfw_version = pmfw_version;
 	pm_metrics->common_header.pmmetrics_version = table_version;
 	pm_metrics->common_header.structure_size =
-- 
2.46.0

