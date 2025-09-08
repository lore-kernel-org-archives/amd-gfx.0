Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54971CAC588
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 11:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E67510E4C7;
	Mon,  8 Sep 2025 11:03:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DEMQj26x";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF4010E4BD
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 11:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dA3qOuVoBPrmdEF1TCd4fst7+eqXLnx1tIIf0B0jKk+TEJ4YEd/JaD4ACfb1Nqm1Vd/jjnC7nbhxdweig/dW7eVyvZ5w9WEWLN+IQCLWAutKfIhzpGWa49u6glb9nBRPKVERIhLe27qpZdPExlEZ3v6XPuc7a5EEuxTCXUU+yVZG1AJZVS3j2AnC46k495L+ebJiaE1HrZecL88nv8MvXl5PQZeLQFlEAGLM0eGG+2W1LeQswYbk+L5ZlO+gkKgkt7Z+8VCqOSyfbKArBalS5CpRvbIooMoFJJeK8sD1qLnXXFa4TQoZ7QyxsYGogYuFPGJFFCJU/141nd6wCSdcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6lfTN2ez2zpQ90kmS4PaFRgLjNm5y1BKeBLj071csg=;
 b=R09LGyv/neyWSqeLLD3EQNGIsrXRJgiQpYG45ocZv4GwFsiggQq5UVLuDoo1rV/dlKfeQmcKi7bkSGW2c94EmW2z+M+0pbMd/3WN6RgMUgl3ngr/668QKCbe89hUJbpmbCvFA6T3ZZhKJOwpoF0pRlo5TmSiHsE77QZtnuWjtTASuuuoUQPgESx28E80R0cf/lCd9xlvKboxOTaAUSkt5kVvlX8qOxdvJPrkDvFUnrURnCnrVu9Pi2RI7msrIpGtOh6GACnVBYjxBda4NFbI60ZfpgNCyNfwJ0CHAWiQPhFuJqWEzhRE1vcPmWc85A4u5qiZbpv1of8sfsBMbKggIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6lfTN2ez2zpQ90kmS4PaFRgLjNm5y1BKeBLj071csg=;
 b=DEMQj26xLPKn4rUDOxqWnrYdmhmsICyqLzVE+7nj5HpcYAFf6KQLGdKxj8YogmrjMwyXkbUyU6ZCvi34QPeU8V214iM+NmaEWMUoTEHLql+6D7xOFcS2h8LGoUaVk2vRZyhR5uhsNpHi8BTerF1FCYI0uTgeyM0lYNB9tfT/ADQ=
Received: from MN0P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::12)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:03:05 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::9d) by MN0P223CA0026.outlook.office365.com
 (2603:10b6:208:52b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:03:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 04:03:02 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2 5/7] drm/amd/pm: Add schema v1.1 for parition metrics
Date: Mon, 8 Sep 2025 16:31:16 +0530
Message-ID: <20250908110231.2888628-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250908110231.2888628-1-lijo.lazar@amd.com>
References: <20250908110231.2888628-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: a4dd566b-f2c3-419d-143f-08ddeec748e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xTZnDSYtsLabf7UppkIPxH9R4jLbnYsjMv+d5RDyWA/13arFhV5RmOwpRFaI?=
 =?us-ascii?Q?UJxVM2P7WbT7v8ib/fBFynlq4g7d0Y7cDizTpk3hkFuLdturBqa0pfKqk2pw?=
 =?us-ascii?Q?Yo6nT5qE4qjIEIBInHpGxjQ9PL7tKZlry5SWTQNKy32b9ZPlBuGNs9nYrluA?=
 =?us-ascii?Q?onv7wGvDWyIYk8iVzt6AF8tL2wVqNSimn3/HNSovQ5lvLrOTEdM6849Kv+z+?=
 =?us-ascii?Q?bDDwhNO10dFCFiyomCaxpRCKXbrUhEJnmu89Cul7mURUv8mbs7c1jpdidv89?=
 =?us-ascii?Q?WEApd0bmu0T9wUuLAKyZJZPmIZPRXnXm1xTe2PH5acmdoT7pWtDcChediJEw?=
 =?us-ascii?Q?eoJtshQCp6fgN0Y6z1+Ix4OzE7AlD9vwL/XBTxr/ogHRL7XXsGhSajHrlpqd?=
 =?us-ascii?Q?RpgsMrOixsDR1P94QBvBl3Zr0JSZElq6CO0WQFFyqkJONDhYDo417FJcAxRD?=
 =?us-ascii?Q?aIZsTg4KizTVnSJ89M9/tmujDAv6ET70ZCTNkuP6q7kwMWE2E6EesDWT3gcg?=
 =?us-ascii?Q?lVuV9MptU4KZFHmi1WsxB3hH/eEZKRbOUb18rOkV8UZkDqH3yN3YmKjsaQxX?=
 =?us-ascii?Q?aqHpvnTFxSS9CRomE/7ckrMHKDgy75hOiis6mRNZ39qg9IZV0ktKYTrHNTlx?=
 =?us-ascii?Q?M2u85kjk0Hv1AcyOg4rOeqoaZQ15NM2m9vy+47kuHVPeS4ACillQHIAyMYAS?=
 =?us-ascii?Q?2YSH28CRZUFChoel0OH4/xXdCGvP8cc153eATPELF0DPrhccmZH5K7EagFc1?=
 =?us-ascii?Q?FsE9/6v+HcTw1EDcWvfhOuDv/Z8bAuIZ87gnXvJeQVvN19ZR354BXgIBG4Xf?=
 =?us-ascii?Q?CiGbMJZORE8xLLPfqIoSvVvDWrPLMJDfBIMUmba2MHDsTLP7IROcnhIRA2H8?=
 =?us-ascii?Q?A4HJTDkovxxnthA57rmdkStSNc6ZkbiBl+JQscXJ40cnBzbj/NocDjUTil64?=
 =?us-ascii?Q?7nEWC7t5G8jh3rCdGuMPLUt3AoqA+7KNW8OOVplAlAyOpRL3KNoupE/QFqoR?=
 =?us-ascii?Q?ZfiWko4zBejYa96gu9Ok3VsXxs0jthLxSCFXp+sK4V6c0nIP82r8kw3wfMH3?=
 =?us-ascii?Q?ty9ihJkKZoYzTPVIKgSCYMicfMKy8ykshR/uOrZckRfrR91IFHlKezjbm5WD?=
 =?us-ascii?Q?5mFSHkt66DAlSj0V9tNuWEBSu6hHVw+AVknzy6CsQTj5GtCEZmgC5kHlJ0YB?=
 =?us-ascii?Q?iz9mdK0xTNuiuyeIeOqQwZFjDP92ug7LUpS9hylEfnm8hxDo7ndlR+2zqR0U?=
 =?us-ascii?Q?b61r3sHRLbXFvQYIib2YQORHLCq/fwm4qZUarQ+sN+fNRGLv4iHbhOVLSlSn?=
 =?us-ascii?Q?u/oC8sI7tfMOQvOUUyIYKqOOjSpwL5cDtHxjjJkMguZARVKNDoVTtsJfVutd?=
 =?us-ascii?Q?+dsG6r59SB6SbWGcf0aKLgOHFfH4cwFd0fdv0JtS9pfgDwIVmt2pYNQ2IDbe?=
 =?us-ascii?Q?2KOF7chD0mroCtRhcoipD1yzBGkcgs+cyslwKvKuL83KyrADLhZU/R3Q5eVO?=
 =?us-ascii?Q?T+BJ4z0OaFBVJOYe3vHTq5N97/UCT51YO/EC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:03:04.5193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dd566b-f2c3-419d-143f-08ddeec748e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
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

Use a schema similar to gpu metrics v1.9 for partition metrics also. It
will have field type encoded followed by the field value(s). The
attribute ids used will be shared with gpu metrics. The structure
definition is only to distinguish between gpu metrics and partition
metrics though both gpu metrics v1.9 and partition metrics v1.1 follow
the same definition.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 424fd2f0cd51..620663a88164 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -1816,4 +1816,10 @@ struct amdgpu_partition_metrics_v1_0 {
 	uint64_t gfx_below_host_limit_total_acc[MAX_XCC];
 };
 
+struct amdgpu_partition_metrics_v1_1 {
+	struct metrics_table_header common_header;
+	int attr_count;
+	struct gpu_metrics_attr metrics_attrs[];
+};
+
 #endif
-- 
2.49.0

