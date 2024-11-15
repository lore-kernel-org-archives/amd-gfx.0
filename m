Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA18BD6DDD8
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 06:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E33F10E39A;
	Fri, 15 Nov 2024 06:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sHwyopiK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E0A10E398
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 06:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfmqMmNoJNa5un9aAs4/h1b5AcLT3U/XjClUdLpl8lH96YqmIR0v9Vlv3+zhX9937tMKcxv7Ao7zSIqa1Te05VZZjurCS7mjo370zrdtYHGAPzwKsmu6ma26CSDGSCgb7FAsrKO3fulnIww7tlRAgTqvScf+aeooPNDQt0yjZJnk2KBW9FQSWhCFuFc3NIZ1CgUVKAC9HbUKmX+JqTuSrWvUPMTj8v8tCKFVLxl349YPg+OwKByMVYpinAspFH4R4Kin1VXWnssbGn8AwqyVpcsKQ/5YAmYyUP5A2ZYkJRR1j3OZsT24FsLh2pVRfK8I63TY7FUWZIYsf4E3ymJRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XUwUX9ndoZzQjML3DDssVqmGrg001hcoGWfhbVnzeY=;
 b=e5ZMxKUbK7P8hMOl8oYPGS6AJSP28yVYHU0qtIqsGez5NGvDDYxu/PJrCcqu2nx5V+oc63y5ntyZKDleycEDClrZ8NeSodtGJj7K5+APcW3LKHtkLtmZDsZ22eP9FU7715yg6aMP3GvozpcCOD0tg+BBFqpqeoDTu/0IiX+GjFkv1LakCr8L7VoD5YXSs73sWRvVLzakHsDw0/c6AeUjWiNxHCFYxXm1Me1/DX3N/ZOtFg0uXdllIb0ExshdGlJzSTnQY/0/YtuNPeg6EU+ZrryMfb0hCSmFSr3Nfe+hrF7th86boCBWxznNwZ/eZmJDztSz8viSqFMz/OF7lrVj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XUwUX9ndoZzQjML3DDssVqmGrg001hcoGWfhbVnzeY=;
 b=sHwyopiKP/cmC9SoNyd3DWnHQFA/ipxgqe+2Jrl31W+9IVEzFKgu4tXzkVY14ENJ9MVAAiFA98ikFZVHH1vwEkAMDUuw5BQ+OjtyIihWLBjD5gqnJZeuC4qOl5D0QGQgBAMRNKzDnxrNVEb9gpZWHwkF5S2nkcopzFvMwW7wElE=
Received: from SJ0PR13CA0103.namprd13.prod.outlook.com (2603:10b6:a03:2c5::18)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 06:09:43 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::ca) by SJ0PR13CA0103.outlook.office365.com
 (2603:10b6:a03:2c5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 06:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:09:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:09:38 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/5] drm/amd/display: Only free dm private atomic_obj if
 initialized
Date: Fri, 15 Nov 2024 00:09:22 -0600
Message-ID: <20241115060924.1805-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115060924.1805-1-mario.limonciello@amd.com>
References: <20241115060924.1805-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 4725ec5c-04d6-4428-8b92-08dd053c189b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CHqidJD62v0ERwZc0bhBa6Vyk7DcwDqq6Yy9PFR5DLZM3LAihDsnehUlRmBl?=
 =?us-ascii?Q?j7kWxM+rVwr7Di/qLfWFxtoOqrV2Z4N6LNo+iQuLu9JeHpl6GE1m8XbMYyya?=
 =?us-ascii?Q?IoA7UgR1HwgdxH02yemwqSjr+QO2tn1dgAETBn5mqLCB1rgAV4nglwGPtmFE?=
 =?us-ascii?Q?SeGPltRizltL2vnJ06H5liOSwsbMq4lPlLwdzfmsKTePbCTOkLpwAWTtqOOX?=
 =?us-ascii?Q?bqFSQDSiIOIoLRA/rO7Xdch5T7y4Ub90l3dWIQFz2BA/a9kYW6J3l1k/PphZ?=
 =?us-ascii?Q?QPw/mNZWxkN5s7Y88FYXD1BaPBLNWPRWTydnxEMoaxLD7hrFk34quyiQmMY8?=
 =?us-ascii?Q?rGtDeXF93CT2ImChdSEBB/Ut1ZplpxAdG6Tcf0NGcCWWYD9rHkwuSnDtAvM8?=
 =?us-ascii?Q?7+b198ALkIBKlDYs6ZCP7DG+80Il2h+hdX8ro5sGhKguPYjWq5FCRhhi57X2?=
 =?us-ascii?Q?/juj5zQMWxqsPyrCO9L8nckMoWd7gdBcKDBgwkFshiZdmbl7Qx1T4F9oSkqs?=
 =?us-ascii?Q?sZfbEV1Nkyz+ePJXk2PMVcpNrAZNjr0oHwz4ZzwB8CchMcfBAcwVn1AJbKo8?=
 =?us-ascii?Q?O6OBxF685lXvRD6Yx0X8I6S63APTBpQFYjvkAyl0HSz8sTz+5AVt+1z+VUQg?=
 =?us-ascii?Q?mGJbh9GRoj6hyLdmqCLopGW4lgrPAWvmcznHvuGXOc36GbJerwJpvQEe35Dg?=
 =?us-ascii?Q?czqm2jlc2nu7nDM610ZQwXURirdGObIH8SkMlMXSFBHPvfBVRo1k/EXB0jdL?=
 =?us-ascii?Q?42k5cTxipIaJ+jzYj2uttGsUdm9qaDVO6OP2jqbRDMscjOyoCSUZOANdgGmv?=
 =?us-ascii?Q?nTgFCb5cBxNrY1exzh6Qp0uvOF1nDN3pImeJ4YW3fpWdvRop7LiF+OPddZb5?=
 =?us-ascii?Q?kJubW+VQv6tupg0gEHyTjHC+5F804uJiD8FdzNYeBif9KYqNyCDs3hJo2box?=
 =?us-ascii?Q?DG87J8ObLaSlqPKTTdLmHogKqijDdyqQ9ELwEvFkkliN9+nGTrMXV3HrYpUs?=
 =?us-ascii?Q?bdkPEX0OGXzxpzmrQqaNGxTic1gC1Y3NSVLMLHH7Mu8PQZS/K+a9+RU9+hp3?=
 =?us-ascii?Q?Bpd9kUSEoxAnGDGMrWfdvLFP2caj54GSHm5mZ3TcWrucZp6BoZVUM4oprDuV?=
 =?us-ascii?Q?V8FKoQGSDHqMYIXeazvwUuarhHE4fub8sARVmrqQ1X9/IYIJRKdrdrrlccg+?=
 =?us-ascii?Q?PmgsGZszlZ+Y4JrVO1hn6zd/z7H87tNiRWVSHyDDGslRYtvJL4ikiPP04p5T?=
 =?us-ascii?Q?eiR/mP7ntIRpW8VDb5PNGhNtJIFym3tYkGcQB24PLeKr1T0XmYIOJ0k+Mb09?=
 =?us-ascii?Q?9O+mLgnuYMG25n4zONaad+PwehjbVg5iD2GH/lfZkStU229hYH0ty/c13hpJ?=
 =?us-ascii?Q?PkSazlX8od3+xX/ZGf/s2IzaGUvc3RMr0xCStPDzM+/3qQl53A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:09:42.2377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4725ec5c-04d6-4428-8b92-08dd053c189b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619
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

If DM init fails early then the dm private atomic_obj would not
have gotten setup.  Check for this problem.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5fd3d36964369..3081418fc255a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5181,7 +5181,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm)
 {
-	drm_atomic_private_obj_fini(&dm->atomic_obj);
+	if (dm->atomic_obj.funcs)
+		drm_atomic_private_obj_fini(&dm->atomic_obj);
 }
 
 /******************************************************************************
-- 
2.43.0

