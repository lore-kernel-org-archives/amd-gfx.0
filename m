Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7B5C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 15:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547B910E171;
	Fri, 14 Mar 2025 15:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jQGjptBr";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A093610E171
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 15:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCwiZ9VA6hQvNhRsbvOT3AaMJKg6aO/bF7G9zNxi993anhzFSuViuI4hFhFMqlUpPihWDTEAoxF7L0XngCWBbnM0Fo7Yo5muLc1g5ssTz2xlFaFruFEDcDsix1/a5+C/fFajEQaTEKwbRsz/aYvmcti/JXn+20rAY74lufO9Ga4wRmjbq/iXG0Oc1S/ThjhwXZNF6y3aZSBmWzpwsUvMpIEXrhrMlldqe66jR+4mv00B59ac6xYoBTqUVF7BSB/KaUjXLCWnlo5lfM/GWhuieg86XJJqW34Y015AgJ3tmEIJy8F/MGZmIqJpI7q8OgEIIoaSQojJiGqveFS/IgK0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjS28yuRiIYll+u2KGzKJe/0C15GORYY9NCu6y2QgcE=;
 b=Y7D/YMLpPwo1nHeGxKwBUcUmrWLuY7BClsIa4eK5AYL3Of37Hf3yvHumyRdFyZ4+BOT4kJf50M8n88Q49Zcp53DLcl8Gg/NRX6qFzaoBsRkl9XTZt1jRBGsjxzu/G3vXJRvN2+/sQsSoL8xUpfjFJ4DXm39e/PnFXrRwLub7I40umMd0kuyD86YtfEazb5f+qRAj/GaOkAiCHrpoy+WkEoSuyADe1TATh+WjvhH/gfttSMXN16TxiLhiTlYItm6GcA96IgsGQKbNF17qlk2fqagfRpvOiAQ5xaTfiLIaVGyhb7k5TWoUfrP96Was/v4s/HU4kG3CW8iDkws6xOfjJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjS28yuRiIYll+u2KGzKJe/0C15GORYY9NCu6y2QgcE=;
 b=jQGjptBrMw10LyHURXJNG7saqFpcmyaQ2wTvAmGqrw9QcaJkVJxixb++/9klBoucSA0bB5O2T9iSOcdYdbFY8Sl0JflweFvBM+gjMYPzusvJl14dF7Ejb54KjKi7jy6+/pCPCvLoqHMf5n9XsaRBH9h+xBP/uU7SzvKMMW/wdbI=
Received: from SJ0PR05CA0143.namprd05.prod.outlook.com (2603:10b6:a03:33d::28)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 15:14:31 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::ad) by SJ0PR05CA0143.outlook.office365.com
 (2603:10b6:a03:33d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 15:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 15:14:30 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 10:14:28 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lancelot.Six@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: set precise mem ops caps to disabled for gfx 11
 and 12
Date: Fri, 14 Mar 2025 11:14:16 -0400
Message-ID: <20250314151416.726789-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6ca56e-cf74-4728-7d4e-08dd630aeb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?posrhWDQ0TavJMzMyLiHPP79bn66YbJhcN9g+NVASpHAfUWVF9grR6P6AQX6?=
 =?us-ascii?Q?GRsfCi0tRomWo+sVa8SP4WsVIg/TZdynBc5LJxT/uyi5KIq4CSO2BdvrVaLY?=
 =?us-ascii?Q?zmddwJIcuTQL7l/D3Tv591RMBqyFUoV0OUCAbcK5Nbd1EEuPPAgsEPKUxTON?=
 =?us-ascii?Q?Y6HLKgrj7eRXG1wXD4QgFiii1yecelrUbeg498fQNW7vSyrZOgXvlVkATbFJ?=
 =?us-ascii?Q?YVgK/bHyJroQ9Y+Im9wT7RFYGEvYYePil4a6h+Sst0KkJGKCicH5Tkm+tJHQ?=
 =?us-ascii?Q?3f/nQP1u79fvJ9Ib5e9FXqpk0sSl6dNV+lCBMF6oYOJPDz715uhWL3ZP1Tb3?=
 =?us-ascii?Q?PjCuv4w0nZmRAL9y3ZROYFO5hAXN5zFrKyYXFhC4KtbzhD8AAiYUif2yy/cR?=
 =?us-ascii?Q?FySspe+gLDnEjuIhKYvS2Ppk28V77RLBXWkfG+InO8oRko3XXivEdxfH1kiN?=
 =?us-ascii?Q?zpT9a3R8YiKbGmZf9w5963FCCcJq7D3iQaPhLmo4/Ybl+yTWM+tmdBXOSR38?=
 =?us-ascii?Q?iYaCn/qRnrttKHSod6khyWe1rrlMoWCUR++nD7kksdhZJNcl4eTbOZqdoYx6?=
 =?us-ascii?Q?Cvq2uEcaD82grjrWuiIH8CwYUdoF6TfMGCfETcUf9bLWmuX+q5lQOWwE2Y4o?=
 =?us-ascii?Q?jqfmb+FNkXBtRCsLIa2Cuf34ZGO5nzXYMjwNmNbqqSCxNhCX5bO2zocKrl0U?=
 =?us-ascii?Q?T7aFZ8qOOwtVrk1udhTLGueFGJTztqCxVNaW2cXh4mBhEKjssiMOOx/QFd4C?=
 =?us-ascii?Q?LvfYExSstR2qpB2TLKuHqhTQ/+U5msnoQ/6jpU5xrlYSE2a/5KPg9wu+ifB7?=
 =?us-ascii?Q?fSLxtxwTf/603mYyhR62BtyXIYDxaVHS7e7luoBgOOFe25bsanqbXUnKotNd?=
 =?us-ascii?Q?C4S2SerGXDyHobarbeuagUwAfPNF/LgzWjEOS1WZSXy4r13mWBr9EOs9RCsa?=
 =?us-ascii?Q?zSj6CuLHC3dNKN9ivD0kYAVVDrQ0E7GCDsiVwcrsDyTByLqNSBFWscWFe8f+?=
 =?us-ascii?Q?Ramn7NnQkib+5Lh2L8u5Ze3qktFoXPPZAl3cOyvWf2YWew/wKav8lrPn817m?=
 =?us-ascii?Q?dLkY4HedazfKLKUrG9bX9yBSHwt9u96X87zImH22Mb21YQKdXy2aFzZ5LX8Y?=
 =?us-ascii?Q?GtyzZUpR4k8ix/9WCsaVJQf2kgo8Ia6Oagb3N8XNyrZEY1vwfn1ZVT0oA6lu?=
 =?us-ascii?Q?uY/VmxIiqrtFSfmkYSFWJsMJqqs5nQAr8xqvZr6chIsFZ/iwluc79uuuNoSg?=
 =?us-ascii?Q?eu9nrhcNVjR2nvqRhq2VtzVFbN1dsjBHoMlwCSZjq93Ejzv5HD9IRNWegfl8?=
 =?us-ascii?Q?q32okz8IKsIi2mQvbRXres0YH9DaKwlYRVtrFltisfmmwNQ6rABeBUX55ooS?=
 =?us-ascii?Q?Wa7zPiXek666BJEo6XzD0IxFd+IeZvvghtq8uCq1PaTNiu+BJTpvSiw6Br++?=
 =?us-ascii?Q?MdPyn3i2X/jVPG1kjTS1wmR1YbWXJoBAPJIkRAevX/j7otNSYkYEbslQEbF8?=
 =?us-ascii?Q?QHih2bBJozugEkM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:14:30.4339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6ca56e-cf74-4728-7d4e-08dd630aeb58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796
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

Clause instructions with precise memory enabled currently hang the
shader so set capabilities flag to disabled since it's unsafe to use
for debugging.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 27e7356eed6f..e477d7509646 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2006,10 +2006,6 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
 
-		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(11, 0, 0))
-			dev->node_props.capability |=
-				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
-
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 0, 0))
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED;
-- 
2.34.1

