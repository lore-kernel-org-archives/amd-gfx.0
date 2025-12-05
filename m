Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FBAD374AF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FDE910EBC8;
	Fri,  5 Dec 2025 21:49:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="blWl9wPT";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010022.outbound.protection.outlook.com
 [52.101.193.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE7110EBC8
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mys/G77dcDhKF7ykI35SVghiPC4lFoxhqPaA4Nnv5ppw4fmNi0YwREGIsWfC5+hojpDYvrIelRb+PTyM6dILVFN4q7JfQMlt0KmDBtDeee6cpKAs5hMxUnXHaun1iS4GMQ3VnLADtY1fG+dceJzB/9+bpAc4T5fKfIODOeJpgslFC3jS0pJawpzqKV94Jaw8EGY5EzlQGd2GxoTpMpOdnW584hrhB4WudFfh5ucQR4bcuJATl+1QiczBQWe0/EiJ/eB4SBocJ8m2voSVDNg94hpFGYlGaSLxuKzrrwIdVljbgsBeVW6ZWru7NI1yh/eAFNes/QK5zCAAuVNsFKZfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmLUzUyS3+Qas8uaFmgusx1hrSj3BB++acnj3fl32Tk=;
 b=XhNh6DECYwcmrZEj5XhoYQwwR3Dhz9wQ7+OjV49n1JLdb8XhFuo0hC37c0R+aVWV5PjYHC7e8v5MNiqFcg8dhKWtvVbo1mfabdjzyGer3T3kmill9inv2xpWxbXumyXv5i3z7F3FXOZODN55Q60kTHESKnRanXS/hIG8F2iL9PmKYTqp6tDtbEbRNG/V2NsoPAYG9aaLT9tdFOHXNmCmeiNN3Zxa81umMDvrZ/v3TNRJ5N3JNJoLEfKO9XoCnhVKIK0KWozFsrhjLuVQ/4OqMZ8pHwB9VZ+xYVH5WpcxiCHiIohUvxmi23a/hCmaNY2vUrSHxUatCEjcB+G2voUSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmLUzUyS3+Qas8uaFmgusx1hrSj3BB++acnj3fl32Tk=;
 b=blWl9wPTay+eB2SDChHMhy/Eef/259lwe/bGlkm9Y60E+vTX9CoQi7pEZIZ0UcycpGEnxcNF2T8pEdlua2R4z4S2qfAMlpI79ywqvgf6myK4ZD+ht3wLvrXkXJfvRGexeA0yzrXRM9t/0OdVKKCeDrURmV2rEjfd7lvPc2HoxRs=
Received: from DM6PR03CA0033.namprd03.prod.outlook.com (2603:10b6:5:40::46) by
 BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 21:49:50 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::41) by DM6PR03CA0033.outlook.office365.com
 (2603:10b6:5:40::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:50 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update sdma configuration for soc v1_0
Date: Fri, 5 Dec 2025 16:49:26 -0500
Message-ID: <20251205214926.146844-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205214926.146844-1-alexander.deucher@amd.com>
References: <20251205214926.146844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af09235-e1a4-4f00-9b79-08de34483743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qAWDLsbj/NYE2Ry+wMe/7rN1VJspJU9MS16U8bcpE3Xlmjm/4+GjW3H4AC1Q?=
 =?us-ascii?Q?FgJE7rROpiLd0t0WFkfNd1XUWkEuUTg5igk1230p87ZjOv6YRMFT9EX/fTnd?=
 =?us-ascii?Q?K0Dcrgxbz23TSdtIhsXSWbRLSoYHfio/AyrKCPWhX81JQ5KxjA5M6GB4v7pp?=
 =?us-ascii?Q?R+VBWFJwtWFhFzcYkQAMetX3eCDv5DTvLwCEgBQrkZTUVi386nbmXMECIqXL?=
 =?us-ascii?Q?EgLPjkBR0ksQFKSx9w94RUf7KiH32rdqlmy+TK+fbLVGjzoUsQkIySm4M4mf?=
 =?us-ascii?Q?0UxMIoDpWFWPNJhj9Zp3M/I/M3+McgQ5Q21+Dm/EkLKO95wGlv2NosVYqvAt?=
 =?us-ascii?Q?OvizjTT+UaxuiCgdbG5RJa+22YTFUQxhGW++8gXR7FHzVl9Dv6SY1Rm+y1zS?=
 =?us-ascii?Q?dbfvLS7/Qec5nsfh45cJUk9JteG79HVH0//F3Sh68O7Cg/ulC9JDwvhgr+0q?=
 =?us-ascii?Q?UQjX6o3/+fy8HopxjcxNmBevC2MKZNMqoqB9+eDpDK4FFQjBbfXks/YJgraq?=
 =?us-ascii?Q?7R+sKTLhtK/uqTfY667yIyLhdthaf1BGw5+0Uoq1NdsarBivMgX68qtEgTPJ?=
 =?us-ascii?Q?UYDEApLMRCTRK9gt6iCeT4B8FtBwnVBZZHIijFKgp5s1dTfmJWO5hx7pxPnU?=
 =?us-ascii?Q?HC9MyIuQBM4L75UmdXsfIc2vED2rx866YCCSQM91aoI1/XC1oaPoOrNRCPDI?=
 =?us-ascii?Q?gCK3c2ZsGE52AzAKy2S+M8o7mjOiG7cmNZB4OslxbpdavmsrMJNlu5gGZiFf?=
 =?us-ascii?Q?R1yAYhQo+7zSkEoOP3JCtCOzst/0x/e4SoZhr/zeYf5N4e3fHuu9ziyYWghY?=
 =?us-ascii?Q?ackH9BN0+rijg8Bi+BRsMiznGq+BfbqILO1Zy9tWQZmjTO4Gr8LhAJL05Zt/?=
 =?us-ascii?Q?XNbYC/5LKWXrEOTwbOp8ILIPFN5o9u069eMOwj/haVf389ebtbcpiNttaWbT?=
 =?us-ascii?Q?4eT9WPJhSbnw9eduJmibhWHmmmAJKbg3WOQWYzmvnn/pfniwzhPWodVtrGmx?=
 =?us-ascii?Q?jBYQMlzBjw8tNsZq0Zvrg7J/lNyAbSwm5zqGv3x9e9zbG+hB+B1FDNHSBX/6?=
 =?us-ascii?Q?kVMbQNVQUbZ7mAkwf/6nvcZXjscVeYw8RvuioLYyObV4v4lc9LaLK2Iq1VmX?=
 =?us-ascii?Q?dj5yKlAc2GMKy6GOG0o+3A3XQpAj6PmdDJpgKUKg6gbwfq4NB6ulccc40Ecg?=
 =?us-ascii?Q?sLumZvPkg7L4QzLbe31YfJmRIzk2lSRLcOqoVxErg3sVNL1gmMzKbjJW70oF?=
 =?us-ascii?Q?AlR3QItx9SLzYdTJeZZuvak8Mi/ddLqILoYkp6zgS+qB5Qv8zFH0xIeQ/Eh/?=
 =?us-ascii?Q?L/8KPwzjbySYSav8Prd8Sl4/FdkrQUdf0813wQXU8FwylRVeR2Hz+rZJT0yV?=
 =?us-ascii?Q?lTxwAWYjHzq8wgZxqIChOsC10aAND7fj8qRBHHg8m7hC1cwLxBFTYiP/n3vI?=
 =?us-ascii?Q?KMJ0/JdtS5IdbMsEtT5SPCmpiqhp4rkXU/vGNiQGB2IfPGcC6x6i/hd3PhW2?=
 =?us-ascii?Q?i5BfPwqkef+KURQY7pBCHRfVEDAZC4ySJ+e/dkO2H5kgPPI6c9rrwgPd4OrQ?=
 =?us-ascii?Q?QNRpHEwYjKPYtYKUfjU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:50.1851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af09235-e1a4-4f00-9b79-08de34483743
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
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

From: Likun Gao <Likun.Gao@amd.com>

Update SDMA instances/masks according to xcc num for
multi-xcc models on soc v1.0.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 66972b8aee505..7e96c6583aa97 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -771,6 +771,10 @@ int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 
 	/*TODO: init soc config */
 	adev->sdma.num_inst_per_xcc = 2;
+	adev->sdma.num_instances =
+		NUM_XCC(adev->gfx.xcc_mask) * adev->sdma.num_inst_per_xcc;
+	adev->sdma.sdma_mask =
+		GENMASK(adev->sdma.num_instances - 1, 0);
 
 	ret = soc_v1_0_xcp_mgr_init(adev);
 	if (ret)
-- 
2.51.1

