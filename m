Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F19CCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 14:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0D910EC20;
	Fri, 17 Oct 2025 14:32:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o1Qoi+JA";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7064D10EC20
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 14:32:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+nbWxBkMaNOKQ6uTj0ljeF1Yy73dJFAoYaoFOdhDIE0cvrXts7lW3ykrpWWFRlUNxJWl6mzfT4t0yhoVDlrtitntP7BMla+8mokZb5NDOhRSTrNcTp6RFhO1IdHi2oD6tldJFLtJ/6tYcilrYNlx7U0vNb0NiY03b0EJR/KmrwgkGxmf0hf2VFEeDs39Ib3RQc9lnXZGz97CEpOwQySjMgvgAnHME221JC5tM6uNVCtgfBc8G12Sm/NYd5tUlRO3egrtpRHBvPkjfwGuFmhtT56dj1icgyANfYLAVhL021go63bmVocnBbYcePIMKoS1sMcKGIbkCW9jjTh1mV1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkbI7WiAAAe9/j/tIRR4uO9oEhPlIjhtNpV90mYXhaQ=;
 b=eblOGUSNsCqYcWq9XUsu0Dul+Uvr2NUovQbz57UzZOHTZ2ha4gIV3JR+G6LkHVJtMzasXawcqZNMZzhbX7FmSaRYaHiVEAlnrbFxiIAuoFPH2crS+8x9hGzKYijUL5iyeuC1mCaJBpHUPU2nHy0lewi7ct7jMFds2ZOiiQ3b2w8WbczJ2BdPMNabf4ozGLwyNnMrSmysvBIKFZZReUEpFs9qaV8/cGuJbuqOlRN1nCJ0sz2uqFIWraJq4yTpza+ESpw1p4821qKPM0P1YD+hq6kQlzVgXJV5spOFdfhweAxjMSynZz+OuvidpL7WqbyYI+lYu4+TFKjNGtT+BO0eFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkbI7WiAAAe9/j/tIRR4uO9oEhPlIjhtNpV90mYXhaQ=;
 b=o1Qoi+JA43a1s6x/QSCoFH1smJfE5L9Jo2l8FQILoKRs39k4eZZFGt8YbKsYh+leOKLNyHRZBcgxDRqjZVcuQ+IJVlWjbSZqOfkBzwtaSCpVpZKg72mF1InwwUw5tMJLYL+9xlceL/60nCi7d7cEIUsyo4krXqGMNjxv5qrj4hM=
Received: from SN7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::18)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 14:32:55 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::9a) by SN7P222CA0004.outlook.office365.com
 (2603:10b6:806:124::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 14:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 14:32:55 +0000
Received: from sclement-ThinkStation-P8.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 17 Oct 2025 07:32:54 -0700
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, <Felix.Kuehling@amd.com>, Sunday Clement
 <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Fix nullpointer dereference
Date: Fri, 17 Oct 2025 10:32:39 -0400
Message-ID: <20251017143239.1483587-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc62a66-038b-49d1-5277-08de0d8a0f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NSmkbx3jttosxhQGVHsX0reNxOqQ8pkYnI/M5XJv5vClma8MFfhszodVcysZ?=
 =?us-ascii?Q?jzgeLtLVaHFRieNwPkltxcRhNmP/EwrJfgvcEL12cwGKgtcFjlC6mG16rs5Q?=
 =?us-ascii?Q?QudSsCXLXK2LeeaqxkKZkyDR67t63N+c6WDys14IsqrRKCfxPjv0MzwWujmh?=
 =?us-ascii?Q?DIT/kloEWHz5Ha82qJzXTSXg/IYxDLxxGbYakYFurw5XlNZ5pvW6MXaceehX?=
 =?us-ascii?Q?TX4AiAe0MGYV7lG1PVQEiuLTIRqO76sY4qtkWx021fDA9OYAgggdOr3O+CFA?=
 =?us-ascii?Q?gmOaS9ya7KvPVB1FEJUeOPZ/h/hCvt+xDEqYuE7MKmaorET1fK+cFRmRTYPL?=
 =?us-ascii?Q?Wbm93Q3N7A79XeMj2E5faN1rDYfwTdSgjganVujvlLFZIFUx8YJvmtBz2r5z?=
 =?us-ascii?Q?pA9/yQylfxwDf+QZSbwd+XliZWnpfzMXM3aAWBGqq8XlQpCFKpfboUvQ/kHh?=
 =?us-ascii?Q?IZgIbnOGX2s20XgQvjaaynM713Dphh7z0JJWqOlwQ+tL9cgsb7UZ73EjcLmM?=
 =?us-ascii?Q?ikuDMUQO4ZtDtdAp4dpVz2KAopm07ziqUer0ETwoIrfDU5NR97ao0U8wE3xK?=
 =?us-ascii?Q?6RkjX4GM/O6hhsRoFkm0qxWLyEGnOdSJpxMk6dAIcZ9Pzg47WRN4RSoUtwjW?=
 =?us-ascii?Q?y4qoSeNVUq5kem7UpFWlNHS1Id4H0Dm/qPaTjgEevViJrvH5NmdCgNY059pV?=
 =?us-ascii?Q?nBC4hq/xIJNLy2hNPPRiIOwG+4IXWz7cWbpzCxhel809P7gOAMRoUCrMqujF?=
 =?us-ascii?Q?mvLG9HMBO3xDTejAn6dD+NGm4eTFIo2cLLYJyZlLArCseXymkp/KM5EVFItK?=
 =?us-ascii?Q?wtvsLyWIQws1wU6Tao1w45Ax56fYQM24pNOfATm6QCLkwSqfolb6JyjuZUxa?=
 =?us-ascii?Q?mwoTI4JibczSmBZae/xhUWsT0Ngkquzl5JK5MeQ5IEqaWUKKOtME1A8nVnZj?=
 =?us-ascii?Q?dCY6fU2OZnjPVOPsORqL3VFJlVjkmQYDmL7mO7+vgeGtE7+56o2bzcmGsxZE?=
 =?us-ascii?Q?/BybcUd1npsGbDUdZ42diff0LlPVFCBYy76Cax+xTZkxr/iacFfRClX5QEVr?=
 =?us-ascii?Q?79m0G/xyOzVs9tizyDCcFSBL2JE8+6HlFJlgzRaHvXFU6IghBI/qZMiH8Zfe?=
 =?us-ascii?Q?8fA7mtXt8weyElZL6yXyXvJZrXMJrT9t2Xw2yn8vUFyeTRyoysk6q04GJEC6?=
 =?us-ascii?Q?qUTSthpwyXtgp/7PWFwP4lA/cuepv6qAIjT96yUteN2T3/rS5WQ2vf20KvsP?=
 =?us-ascii?Q?a1GnYisq11EkOg9wEvAyl7YFGeE/LoOe6o6WGMmWl+oEdFCDLEhEuGLQLFIB?=
 =?us-ascii?Q?jWeE5LrEajSdSUA1YFpWg50cKLno6FgAKq6jpPrJugkZg5zRX2lToynf+vLR?=
 =?us-ascii?Q?OM1QwtNvfT+Lp39uTq5UUl2RXjAn+YpsEu3FCdAD3AIusOkJ41ErVslNRvAu?=
 =?us-ascii?Q?syrTCqJvZMEeTtIG1+YFOtmZOyMoBmkNKVSIZ9VfzM2PqJBGAv3FsePC8D5J?=
 =?us-ascii?Q?Y6IBz8UeU7TZFjKWZ3Ao2Rn8mViuuXoT840JICvsiBMlTPjKfw/dS2FCcR9S?=
 =?us-ascii?Q?ZNdaiRtkP3Z5dFyJzsE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:32:55.1056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc62a66-038b-49d1-5277-08de0d8a0f9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
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

In the event no device is found with the given proximity domain and
kfd_topology_device_by_proximity_domain_no_lock() returns a null device
immediately checking !peer_Dev->gpu will result in a null pointer
dereference.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 4a7180b46b71..6093d96c5892 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2357,7 +2357,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	if (kdev->kfd->hive_id) {
 		for (nid = 0; nid < proximity_domain; ++nid) {
 			peer_dev = kfd_topology_device_by_proximity_domain_no_lock(nid);
-			if (!peer_dev->gpu)
+			if (!peer_dev || !peer_dev->gpu)
 				continue;
 			if (peer_dev->gpu->kfd->hive_id != kdev->kfd->hive_id)
 				continue;
-- 
2.43.0

