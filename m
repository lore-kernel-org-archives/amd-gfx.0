Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ABAD5E374
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34EBD10E883;
	Tue, 16 Dec 2025 21:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FAWL4/jB";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012023.outbound.protection.outlook.com
 [40.93.195.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD8610E856
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUcclpa7buWDHWVfzrNNsn9IcyklpeURBauGranmYbpDmAXFoVWzEjEbGhVYWICg21TtWRYqsZtsMaqidNCTA3/0zcW6vxnQyy2l2hVVwOITFlxkTZuEYsFy6hyBnbUMSb70QlG1l4Bgl5zkRzDO1R3cPC1iEUYRo19gC05T061xQHTmgxC5TWQIf92IEqHMlGy7qegZrWwO+NGE9dqFmQHWdL50viMTXc6zXdgEDTUTyECyWmhZ51OwOG6MEHVeN/k8TpDijHMVXQWk7H3+aJyJvL+6GdoIqkkDTUsl2jTeBTvTNViBOIsj+LgOjeDoUGvlMZ/xjGyOx/o0QEkxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o7fkccL4wmHkA7VMcCA/V/PlE2Z8uLVRr92MPsrCy4=;
 b=NkjCMY/kb0EOU36F1rDL+IOjNzzjlYMcR77yfIvs2rS7GEEYxQRHnOv3M3UW/E/O75rDMfmYlLOBdIZv22osEF5Ow2tFt7eMW5m1c7oqPSa90XqQUv9pe3YN/C9h9mXJ2dlEVyvk57YoRrX541908RnyCAV23mK2QoE8nCUVlVIZYbikcT5Lx1/YPe8l1E1RAuJTYD5kGajhYAVqPJtowNFTHX9zb6dQdX3kk7/CmgHmZa4FRuW+7TNRzQ3BK6uyH2TAnPEyFGSll7tBSAIUevd2LCF4sh0/cUwUTBFPSKJY30IdnGO2eWFEiKVipSVTv6CaoPigzqH3O8CSwmgbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o7fkccL4wmHkA7VMcCA/V/PlE2Z8uLVRr92MPsrCy4=;
 b=FAWL4/jBi37YZ9lWZkMcpOYOUYsB/BOtf8CDkDe9ZAu8IwbkcAJ7AWR8YUfBS/7z26XVykS8pRrXpTVjQcKOp9jYMQYZvCwiQlCgmKMlcoOJMxUkecDvvt6ctFnA+eFACNl6vJqHo5EAQiD0EckGSWbFClYRANvchQJc9aOMNBc=
Received: from MN0P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::14)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 21:04:10 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::2d) by MN0P223CA0004.outlook.office365.com
 (2603:10b6:208:52b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:10 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <jonathan.kim@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: enable precise memory operations for gfx1250
Date: Tue, 16 Dec 2025 16:03:35 -0500
Message-ID: <20251216210349.1963466-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a510548-6a60-4d5c-3cac-08de3ce6a885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4PK8otKnW48dSG1DzK0CqoKJoynaTl+TJBVz6yEoXMIyhezpq9cyujUGJpnS?=
 =?us-ascii?Q?B51aavLe8gIoNd58emo8wjaCr6rC91fD9rlDLC50LjAXPH8t9UideSQ2WpgI?=
 =?us-ascii?Q?vE1zUN1EKFEgE+2OrQNxoK5Qy3L6NxyJ5t0D8ITaiCajGa6jjoyil/NF7UzM?=
 =?us-ascii?Q?T6dKoz+PbaEdwpggQvO1Yk5g5rqpPlR700cxQNa9k6gYaf9J1EFznIf214eR?=
 =?us-ascii?Q?/9A7jzxgI8YthGFiMtdewGdNieJE2P5flUjc20oxuoGEyjAFjtPd+yr8ojs2?=
 =?us-ascii?Q?Oz3AI2rin99Hh9MfkfjGKLmoUvFivGNJT3YjdPo1jgXpeNrAlIRg8bUwk4HT?=
 =?us-ascii?Q?nBERykQRZaKxHDM1dBbAzk/Pool18UafO1GzkQ/V3JGEDjs+OBEUVg1/Vy0J?=
 =?us-ascii?Q?QcHZUbyuLI1d/W1jG9m8Kjkl9F+I/0yd47x79rfb9zvk5E4H+j0XbyGecK3R?=
 =?us-ascii?Q?VEnyRR83CVxzUnjILjEq7yyKDQ5pKcL3tSEHpqZzpEf3ViQuEFNNnLsH5y/Z?=
 =?us-ascii?Q?zT0YOQx3uU4nru7QjWklYZ6yQ2HR+e7+coQTrjAmsR1HWLgaiCHZvMPO2SDj?=
 =?us-ascii?Q?GaPTqlC3rYV7BC07QJhqi+CN6+Q5TLrv157zBvmktzA7s8Fg6/xi1cxmIFp8?=
 =?us-ascii?Q?kz9fmV0u/z6mCQa8Yzq08iCbFkhwtJlcOKz9V6Y8gaUMK4hAlUv7mqf1kRHN?=
 =?us-ascii?Q?oLsOv8CihQU6sd7SokPDG5h98hhqGPHwh4+PcjjdKqr1jJlxCEa+L5lgknkd?=
 =?us-ascii?Q?fIVYVWt9RaXkW8bcv36MuJAlgBg1bDWcvYNGcKzdme3j29NpvW/MYzrCHM/D?=
 =?us-ascii?Q?73nP0DldL5tmngWFnZbEJZblmUZyrHPg1NMzDsdQlpZpw31ihVyN5YSLnYk2?=
 =?us-ascii?Q?FfynQb85m1J58vuqU10l1klErbYmsrHNHweqFb04mAZrD5f9qH4NPMdmuN+3?=
 =?us-ascii?Q?b5T+Sr1Aw9qM2lwlRV+LFhN4L/aG/oY+fEqRMg/XxF0NcbISnKBnKPwsakQB?=
 =?us-ascii?Q?0X+zozowdwqrecKZong7+YZpsJMTKQ9Rng33pS/Jah52bIrGNIcsPy5NKolH?=
 =?us-ascii?Q?S6wMjGRW3trtD37Ko/ug0mocvwTItNfWWQqzFu1aD4pfDq9E8SEfFkWNrWBC?=
 =?us-ascii?Q?kJ4e2NnmwruWDwZCmzMd8xd10lDulQxaA4TvWPRoCqBokJk2wjox2Ga8jfRN?=
 =?us-ascii?Q?JiztevykUAOip6AckOr2/vEHRo0PcdDE8Qol1Nrpc9xJnugqwnS30oTzcIlJ?=
 =?us-ascii?Q?9nntyS69E+xb1+3RPCCoeuJe0Idr6qqAVHIe9q5kQQWgPJ4aB/pmT/kLqZx1?=
 =?us-ascii?Q?ZRt8tHY72SjEW4T8dg7VDEoDqqnJKY2CJFZpDxuakcFgI9NmNPfaI2vdvDVg?=
 =?us-ascii?Q?pRX6Z4KzBYQKGwYYEqvuz2d5xc0ov3cslU76EhT1MnRD9lJeIvX5+duKG8p3?=
 =?us-ascii?Q?C/BxLREKd9J0Wp/2tY508UtDrAyqOg5Gi0aXf1JeezbnnyPOPLWmvf1/vcGe?=
 =?us-ascii?Q?oj6ZOyq0OuAnQYJIEUMlHx2jn95EZBEgqB43UV4nu3TRLQVcvPxCb6jZtPPC?=
 =?us-ascii?Q?kzKPfcCQK2KbiJ3KEuc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:10.0195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a510548-6a60-4d5c-3cac-08de3ce6a885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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

From: Jonathan Kim <jonathan.kim@amd.com>

Enable precise memory for GFX 1250.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 7a402c9c1b6e6..da05b17835d74 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2029,9 +2029,12 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED;
 
-		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 1, 0))
+		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 1, 0)) {
+			dev->node_props.capability |=
+				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
 			dev->node_props.capability2 |=
 				HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED;
+		}
 	}
 
 	kfd_topology_set_dbg_firmware_support(dev);
-- 
2.52.0

