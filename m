Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A005E77199
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 10:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC68210E055;
	Thu,  9 Jan 2025 10:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iIM6nLni";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7FF010E055
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 10:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oY+EoF51fuTWdnxiyDFXPiA/BQ2ki7JHgs2LLQsd8yBI6Etu4OgZjgjemuScRNmHqe6ZBBS9NlCE75jrhKagp4EL8QWCUhDLqIL9LGwCOth9Ohd7KazSPJEYpKPgnRXvhP7oqZ/Y0uK/aWr3X5HCC+kYpOTMTfjpJKsvw7fXmT1mRVWGKsrfvxyRf6ry7RLTdbD56WyV73ZuDKe2MJULI34LhGmRD/Xceb9J6pdzWcR/cYlEgMO9te4t0vsj7kCWpW25b6Izd8a3tvJcuX58gPK/47YXXsLvhmB/vyje9k1T6i7Pe0W7B5iM3sWTGPTpOGitsdairKMoGiOfUhFQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHtvw6p8DLzzPFkjK6oXSSs40K6rRnXkBdwpO5e2o/s=;
 b=bswLCEKT3VQe5BDW2StChKxJ5RCIsGtuWzosNwONzg2U97uRMKlEVlHL9k6mUMgNrArUEFAAPeaeyVn3DTMsPgOOQTD7EBUhnQ1kDrwyJg+80jhr+sPZ+ZH10dGzJ5FsoLh6CZBjOClXE0lqE/+LZOibqCgMyPkTuTMxGRfON1o+bstTsSdd5xyc3sG/z99nUu0GOkNceFd8+q+MQSdZTtdaH38JKS8KUzYAiPAUYIieem/QkozClxlW+UYPctn6JjqdlYJq/nmozNddDN95rKvXyJWhs679ItT6uZ/9bw0fky/vcP1meHIQpgSy5/dTJ1F0bRHpsOXtLFkfZ8NuaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHtvw6p8DLzzPFkjK6oXSSs40K6rRnXkBdwpO5e2o/s=;
 b=iIM6nLniYiS6yMxVWdfOIGcMLVECjINb6TLNO0lJgnnHdkOCJBgGKqucQD/K3lXPkHgKFWz+hAMc3IClUbPaHbgXs1ciQyNQxJF8kKAkbFAtP7iU1iAljajJ9wwGq1B8hwWxXw+c2fNHoT9qu4gl3IHMo9Q7JSt/CEEN65wV4Eg=
Received: from BYAPR07CA0088.namprd07.prod.outlook.com (2603:10b6:a03:12b::29)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 10:35:30 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::6b) by BYAPR07CA0088.outlook.office365.com
 (2603:10b6:a03:12b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 10:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 10:35:29 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 04:35:26 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <saleemkhan.jamadar@amd.com>,
 <shashank.sharma@amd.com>, <veerabadhran.gopalakrishnan@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2 0/2] Allocate and map doorbell based on requests
Date: Thu, 9 Jan 2025 16:04:48 +0530
Message-ID: <20250109103450.870169-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: edf32348-4035-45be-7621-08dd309956cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jd4RHm5kBaAoyP0YOKRtu2ptsJ1+H0vlBivIQ6FjDahEtkMoM1m6BcnIeJyi?=
 =?us-ascii?Q?kw/NasikqR5j23TWwAC24kj0iIIkHU39Ryf1Xoc019CXGQ+S/N6BYY9GJvrS?=
 =?us-ascii?Q?MjyQoEOIdWZqGBPxBSOo7fdsa3orrySgOb9JH4BMmF4wDaL82BbbhtEtP/D7?=
 =?us-ascii?Q?TY6DIuVVmUvVqUVKTRByK58ZFtZeSBXUKTN2rV/LXrqrD2s28ZwpaPpH8Bgw?=
 =?us-ascii?Q?EPc9NH5TZldz2rdM22Bo4dR0WdjYhG6ZpleOBkCa2HLMj1a33YClNT7I16Mg?=
 =?us-ascii?Q?38CO6X/BhlgEw8LVhY324hDofE9VQkGaFAyg9Zn9Qm/VbM8bG6dxuR+IV22s?=
 =?us-ascii?Q?9M3th6iiTDpaTCrfeiAkIxwVuXy1/1CTxPk9bBx6v7sJmDFqdQkIO/4FfA5J?=
 =?us-ascii?Q?XJiFb0Im94xCPrS/ORIpZlPKWRcPl7kgCK7i0kVaBnSsWs93mWkP6vuzXTq2?=
 =?us-ascii?Q?BDM5em0nt76sSMQPIRrGgjWFibXUpWWnLC23eQG4nLMzAjp9PciLFAwHoKih?=
 =?us-ascii?Q?HD/r+da2sfYcUyrgAI0qxQDicZlA6+YZ6qenzjvnJaCDJ3+qj0/4zthinh5A?=
 =?us-ascii?Q?bVhj3OuCrK9J+ByGa6rjJqRQ/RhP9FuzLteMPIGGceCC3mv8ePFghcya+rqV?=
 =?us-ascii?Q?Rj5iTZWG+D9Iro1IV9CEWJ/nxJjwnYXtGCq5+cUSFI6R5ldBNtbAwYnZ6KHJ?=
 =?us-ascii?Q?AWX032SRlyuCeJ49sC9pRMDQEZ1/DNeHH3pHvobPIaxaJ/O47GLFrCl3W2gs?=
 =?us-ascii?Q?fybeiPCWzYYx06Qyf5aMxuR3om7s8RkckGQ4AxnapyISrPXi6mc+kPYTqC5h?=
 =?us-ascii?Q?O9M0wDDaVwxVjuBagan+3FntiQ5ScVxTl0KEhRbaegUXkDxMlD/GyUL7/Zrm?=
 =?us-ascii?Q?oIErI0KwZY2yCZAF2Jz4Se5js9I8RXg+pV3kvZ1U4ywNfJsJjaU3j935ygqu?=
 =?us-ascii?Q?A+2TKPEa/MB58w39AXM9QWm9/H1zlMUza/YjuwDNWLPogoaFmBLy1UpNZeW9?=
 =?us-ascii?Q?NqNsp6FLqhU28hXAR8K/wIy5SMiErGlrlMyaf0hO3WjI9R29cHpDVw4YzjkJ?=
 =?us-ascii?Q?qZoNqmttB8VlSnGKChTQOemJ5LZJNh9jNT7YqTcy9Ju/Ii5RhiOydEB9R5tT?=
 =?us-ascii?Q?BdLQcdGfbNGXKnTP9AiL18K3ZLiRUKjJ+msSlh2bh0zH5RsarqBHzcamVIWs?=
 =?us-ascii?Q?kfoxr379ZG1aIln5HWmoMmUd30JGlWkH+2ovcOx8GcwIJQONd8MHgh36T2Xl?=
 =?us-ascii?Q?a5gq/rkJc9JKPanAc9pg3XjahTgfcxnUb4LXEQmesBrIO66DXs5qpQy5Nvf+?=
 =?us-ascii?Q?WbNxK7HlL/uub24j+iT/Eo0IJBfsmYhnTrLpRjSsdPXky8heHP2Qx3+H5G25?=
 =?us-ascii?Q?KT3/wBiCgBynTRyOd5XmnKwObp2s8f5h6VuSpGkSPW6LatgqjEV3+bN5JK09?=
 =?us-ascii?Q?RP+igYcaqffMcrYPmN4TY7N3L2CKHi/k5A5/NJNkU01WBzRQpQ8Rissv5Znf?=
 =?us-ascii?Q?VQidRLgHHKA6u6k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 10:35:29.9482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf32348-4035-45be-7621-08dd309956cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990
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

Hi,

Why:
The current implementation of doorbell mapping does not handle
the IP specific doorbell size and offset range. Multiple doorbell
allocation when requested cannot be allocated due hard use of
"struct amdgpu_usermode_queue" parameters. But these parameters
vary for each request of doorbell mapping. For example VCN needs
to allocate AGDB(Aggregate doorbell) and per instance doorbell.
Parameters db_handle buffer allocated in userspace)and db_offset
vary with respect to VCN AGDB and per instance doorbell.
When compared to GFX apart from above two parameters db_size
is also different.

How:
Introduce another structure to locally populate the varying parameters.
Modify the the door mapping api to use these structure parameters to get
db_size and offset range based on the queue type.
Regards,
Saleem


Saleemkhan Jamadar (2):
  drm/amdgpu: map doorbell for the requested userq
  drm/amdgpu: add doorbell size and offset range for VCN and VPE

 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 49 ++++++++++++++-----
 .../gpu/drm/amd/include/amdgpu_userqueue.h    | 12 +++++
 2 files changed, 50 insertions(+), 11 deletions(-)

-- 
2.34.1

