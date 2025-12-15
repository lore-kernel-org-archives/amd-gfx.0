Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC1AD5B865
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 668AD10E4D0;
	Mon, 15 Dec 2025 18:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qHF3RXwk";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA4010E4BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L44MZHkx6PVR3NCIIw89CMZTTGwSy2lkKMR0R5DsH5fCwewqYii50YpavIC79wskU9IhAFFS8jRY4Jk5Dm34ylEOtfdALm4YoEFo3TDkAMluABd2WQN/KQqRMKzIehuDdT09Eft/8NtnyL/C96dvHv9sW5//eMRVPkpRW3nQtvj+628tS8Vq0WTjcmzSyox7n8a6UJc8IDJLwfcDhFCdb5ZgjF/49XiZsNBfqci0Lz61lKirFVTKEzymNILayxgO63DFUnJsN1bCXm+AJCMPuUVop/AuLFMJO2Ac7mvr45WWoWwdEdTtgL9lYOlAVMVKRvJuof+yoomStImTMjawrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sktpI5vS1vg4DBKCwlHGcHR+qFi7cdGVb07du6k2Fis=;
 b=cXU5TcqpA2rAMFMqQtU/gGIqSZ8OUW+MewJMvvENwhQzayjPIQyowA8nbsuK2srItROzoVlMVIhssRSk2Q9SMVv1gQl3Oi8kD3NpruuSQQvAVZ0VcB8f39w1Tn9z/HVylvMPMcts+N5Mm1+MVEZtbiIUa7noU7KGhs2VYhWo9N8X0PpAxQZeE3nIWc5UW2z+rssmKiZTG2orbqBo4Hj16lqBX5gCEDIIaeBOehiput0BZqY9E1msd5SoJHCiSXheK9z9weP7VM5QhqJoEmmV3AwE8XlC0T2XcB/MClStAUPCVwimfvzdEH8NOshtu5r34WdN/7X0TTn7AYqZitd6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sktpI5vS1vg4DBKCwlHGcHR+qFi7cdGVb07du6k2Fis=;
 b=qHF3RXwkcbKgEPHyoxXFSi8349AkSSfxisMeF9vnDtwtK2jaGAiNXeZMqvlcTc0v3K1aiYTSZHKGrBqGIqKi6lWxLjnZ7zUyU264k5bdMCeB9kFTAw6HSDK8Bahw7iOPkDzHHk+EYbFYUKFR5LhW+NS1vNxeDoOyqgiDmXQbu5s=
Received: from BL1PR13CA0214.namprd13.prod.outlook.com (2603:10b6:208:2bf::9)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:29 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::25) by BL1PR13CA0214.outlook.office365.com
 (2603:10b6:208:2bf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:28 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 Michael Chen <michael.chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Don't partition VMID space on GFX 12.1
Date: Mon, 15 Dec 2025 13:15:59 -0500
Message-ID: <20251215181607.29132-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b60fed-acda-4c34-831b-08de3c0610fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qbUihRwLTbi1HzUs1jn4HNhzSwCbktXVxvdUFyq+kWHanW3QB12LhQhQjiX0?=
 =?us-ascii?Q?KrY29hQby1n1HfWuC9DF0YexGxQWv18jHnv5KdYltd+d/o8cQtTszUfqQbkl?=
 =?us-ascii?Q?LwiMZL+1y67Yj6bcKCdATSxkNsuzQdEK6Cgiwu7d4rKNezz8dxt9cGvdIJ1w?=
 =?us-ascii?Q?Cyv6YBhWXtHRJCkdfjPdjmtWQL43doLdehIfMnCoqXhi+y4kS3+lw/EGN5ZX?=
 =?us-ascii?Q?bo5ya+/U/bTqrtQjQBgN0Q3KRW291X9enyu9e86vQB7wZA5DbsZFWCWU0VUY?=
 =?us-ascii?Q?S5f2OxOISXnNoTJkmsFJCak0BecUt2ewW3lT6z3xyRbihvlS3doOKSceGehL?=
 =?us-ascii?Q?YHvA7bvksCBS/k0NQKc3eSzE/GJ+itXny6USgCBAXqUoo0hO4GINSc9WE2Y+?=
 =?us-ascii?Q?fQPsoITPjBKse8xGbn6NQOSIt6CeIa1y5MGMl4077kVWb0jtOHhJ1GtZTbjK?=
 =?us-ascii?Q?e8tOSp/sG5y9Ii2qw1Fu/P4Cy75nvCDw1UJUfa8iOqnibzjQMisCqQZ6k6I9?=
 =?us-ascii?Q?dLFiViuU0FWtZdmGA27yi6ttZsXhuj4egYK8FHsrg34RGk0Au/gbGDIHGzw4?=
 =?us-ascii?Q?wH+ToBfLnB0uPc74irRgdZ8JdbRKjGTB7+xKY8OSd6bz/DwJQur0JOzJplnr?=
 =?us-ascii?Q?Sryekwo+h4e+7OOGOatkjMGcq/NGo+YItfrSxIU14XuSBfP40vko6yCzR8j3?=
 =?us-ascii?Q?qQwjwo9qHgEIuBHdqsqEvKNhzqt0c/XJjI932MjU0XF4nn+zhLPNMF7wERi5?=
 =?us-ascii?Q?MktoZtPpZfFXQP6Upl8aWF7ZJQN3K8GtWkNjwlavBfFYvtZVifRedJea2oXB?=
 =?us-ascii?Q?bRCtNXMr87xoQJtfeWMcmcToM4AwkJFDEfWDKeO4Su0Sse3TkHmcDxy4Hz+2?=
 =?us-ascii?Q?1fHD0wXG62sWKGa/D/p0U5zbSmmsMMMchn5hJmkzfn2xb38SoSnxo6wtqNcH?=
 =?us-ascii?Q?7Xl02Ei95lut4dAM+BZTlRCwq9nRqhNuyuyJJYKH3pGSxaX2cfC0/0Ie87gs?=
 =?us-ascii?Q?diBwYaRm7xMxZ6BluOvx+ibgv+suOfJWwYk+ZpKHrAo98/7CNltTSKiACTGp?=
 =?us-ascii?Q?gyiRuJqbTLgSlBKfPjL3URRksy1NRd7heoR4bBh3PY6FF9WQmQTzhpDeaW+D?=
 =?us-ascii?Q?h/FBmucbo/YTxPvaW+RDsLrU9xLrtZ3o/thYk2Nzp+w1MdEH+LuIx29tO2a5?=
 =?us-ascii?Q?fU6EydO5Mn249eDQkgYH83UMe+D5XJh90+zskZeX73bLQ0pPfS5miEAGoqDl?=
 =?us-ascii?Q?rnWL2LqB4+pg4LHvFecf9NFA64NprgRTcmZ/Cf+9ssh4DgQqejV3lnA3jVjF?=
 =?us-ascii?Q?ZZySEMVgIoveHAT90LnxgJ2lfQm4Ac2yfenip1/1LKm5S7Y6muYRxjavJcCv?=
 =?us-ascii?Q?hthqxAXZiSybvP0uT0suGG/IVa18jEIP+XjPK5/tGuQ86i//zja3GdHzZiS+?=
 =?us-ascii?Q?yRzPKtZcEB/PA9hC4MarxViiv+YIIqmdmujGguBryexYTEMk6MMoMUS4oe8X?=
 =?us-ascii?Q?IUp/qGoLw54CtBK3PJw98HlujdIIGAWDWV/z47DgwoA8f4wZ33tAYwa56Bnx?=
 =?us-ascii?Q?uwsMkLY7n29+I5oshQo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:28.5331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b60fed-acda-4c34-831b-08de3c0610fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781
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

From: Mukul Joshi <mukul.joshi@amd.com>

There is no need to partition VMID space on GFX 12.1 when
operating in CPX mode as SDMA is not sharing MMHUB on GFX 12.1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b91843b2af6a6..6d0b370b1644b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -878,7 +878,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		}
 
 		if (partition_mode == AMDGPU_CPX_PARTITION_MODE &&
-		    kfd->num_nodes != 1) {
+		    kfd->num_nodes != 1 &&
+		    (KFD_GC_VERSION(kfd) != IP_VERSION(12, 1, 0))) {
 			/* For multi-partition capable GPUs and CPX mode, first
 			 * XCD gets VMID range 4-9 and second XCD gets VMID
 			 * range 10-15.
@@ -899,6 +900,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			node->compute_vmid_bitmap =
 				gpu_resources->compute_vmid_bitmap;
 		}
+
 		node->max_proc_per_quantum = max_proc_per_quantum;
 		atomic_set(&node->sram_ecc_flag, 0);
 
-- 
2.52.0

