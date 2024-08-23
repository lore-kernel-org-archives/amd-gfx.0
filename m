Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076D5C5321E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 23:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BFFC10E175;
	Fri, 23 Aug 2024 23:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bT7XhMxN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815AC10E175
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 23:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEo+9lUNeQJQPUaRViZTSXJawKFx4eNQStejd5vqpns6bM/uLpteA3i25gL5Z5SS1FQY06ZhCO4riRB7AzuUoM3N4bwN1Ts/1OZp8SwyABrDO8UXpmZMeJYaLcw/MaroDbwZUMx2v08DgE0PDWVNyUHwn6hTBnhbDKu9UE18iLYo+v2FY4C9lJ3f79s+NbMQza024qf7wnHnsGzDhhxLgXoXNxlB2mrLYt8T62vbQRUj3nYYRI8NM3ddU4EE8yNuLyA/mUEIQIXChD1wjQcovTQZwOikF34GHsZAW+qAbATJDUWBqZNvemdK6BWMgwIBec1uRMSum6cPbVMMtJq+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox8dZcSvmTJUp3OAw65JXeCkwgb/c2AJBJCrixmjyok=;
 b=bG7g6O8gJPs3XYuqAiOotO+wLNvhDV2TwiIKaDofHeMlPfp9Zjxz8oJRub8AVJwyXk37ZCZXE/KSpyDIVoldiMzs2uX5+icMRj2kK7SsT9UGxl2b22BfrwzThJNVknWQvshFSg1Nbz+trOVrmotXjYmsYaWp8Qiy27AlodX3IjuJtdauPjg6tNNa/tMfHx1+stIrRXk2vNr6+OCq07L/6wJEqhygUM50uailSBarJK9Rj06BL+uSL6S8mnd/QOlYmhBOlG4UeJSgEhBwpuuLpGy/kGun0ASmcIgTtYVQKINtlR0SrXkCFqZLhYbdSrobkI+c76S4BfLf5vLc0u1XMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox8dZcSvmTJUp3OAw65JXeCkwgb/c2AJBJCrixmjyok=;
 b=bT7XhMxNizKepvojQ6JLeHdYtFL4IuVQ+60OHaZ1qIWCYgVBRdbEhR3mCja4t2YaSrQyH2V/A6fAZNfiuEaS2xxoFoniKvXXNVBDsvCpZqjyCYDFZ411Y61Fpum3KnUvq0X8UOQ9nM3VfzAzR3U8925JkpXcmBLGbFQoXDI6H58=
Received: from CY5PR19CA0064.namprd19.prod.outlook.com (2603:10b6:930:69::10)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 23:58:53 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::30) by CY5PR19CA0064.outlook.office365.com
 (2603:10b6:930:69::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Fri, 23 Aug 2024 23:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 23:58:53 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 18:58:52 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>
Subject: [PATCH] drm/amdkfd: Add cache line size info
Date: Fri, 23 Aug 2024 19:58:35 -0400
Message-ID: <20240823235835.2190295-1-david.belanger@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 08798f35-4598-489b-60d5-08dcc3cf8aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ni+K0u0u0jrFQdM+vAnhc1UaoD8vIhk6Pj2zr67R+bGldzr/fFQRMAMlfy+H?=
 =?us-ascii?Q?GApDU1XlTAF/BQfkMNBPT9FC6xTVLFPq60Mw4kLJRaHEAfTG+Hul7hKzEZCo?=
 =?us-ascii?Q?dmkSyDkk84d1NKlmUFyFhksxK/fnQpdFxtIhsICGQlp7kyDsYOME2Sa4IRCC?=
 =?us-ascii?Q?gmXphLwWWxeoisx/MPmpMkDx2GQUVIbVBbtJ3zvx62TaGW2n1j+uAXti7hxZ?=
 =?us-ascii?Q?5Ugg7RVOT6p9seVz0qjw65sJ8vPhTYNvPdCOyB4aqUU058s73gPBiGtleygI?=
 =?us-ascii?Q?LWF7Eet2CYUtLPf7Vur7ZRYMDZ686aTDjgCCeGwXdsnJ67MJLsRgJ4ZDBJSt?=
 =?us-ascii?Q?FJb74GsUW4/qehik9/PE+q1kA9tsF+t9gQU0H1oeEtCJviBhIGkaDn52JShc?=
 =?us-ascii?Q?DH+NWHJ1oBa8eEdp1g6Qm8C7rcfThDb47ajjNOBJE8hHFRqXlNFImfQRTOey?=
 =?us-ascii?Q?NOCcKjtDQqWeFH3mdqfys5OrwGaULhlCqmLuwGkTcQu34OOd5vvi35BU/8Iw?=
 =?us-ascii?Q?71WRPFezt/5DSGzk4T0tQZfl+XhlaG4JXyOEsAhr/QzOH+6DsnYL2jvJ+6od?=
 =?us-ascii?Q?OP+EY8CurGnUK9kkfK+nw8njpQH4A32mODihkIcccs5HG4v60X7K9M88V9Zm?=
 =?us-ascii?Q?S3WXMLcI4znzk6qBY/VfVTwJ3Yz6tGTO61C/UWkENNOgruo9NFlz5XrX1Sdn?=
 =?us-ascii?Q?nneKM1zfPK6rlnM7MjUzta8jdVyt2E/cS1JYOOKBiUJwIK50sZv2oAC7a1kL?=
 =?us-ascii?Q?bx35FfkbAQq7wQAMgz4Hejdhh7PmqTnKPAeT1rikAjPdGu0t8x4Qd6EtXWuJ?=
 =?us-ascii?Q?RrOPrz0cE2srdAAyWQIIw5P0QDQck5A4t5YN79+T11bX6GXEwRrKjZHc0Y6z?=
 =?us-ascii?Q?+lOUbg7GXN1vCyb2Nj3F0e+nB5N2UNYDKjPChwuZ0DbpGeWXgSqFzI2ojkne?=
 =?us-ascii?Q?7VSczE8+tThDbolyFDco5Guo1ZwnaehBfSnY51t8yrgUBg7CvdItjzWHqdm+?=
 =?us-ascii?Q?7c8O3I+oMopyw91bnKmbwAkA4JZ0TCfpxtZ+qa7bWtJz+8hqRik6uRnMeFD1?=
 =?us-ascii?Q?yjGAi+15eh4S+EyHaViONTrTru6aB0Awl60vW0EO5xvHvJekvW9OShQ5s7e4?=
 =?us-ascii?Q?OjVwNTDUSXFeNFZgG88OSP+TulNFZGrUr+jxXEUlciqG5vCeiB8W/NQcPfqC?=
 =?us-ascii?Q?mOFcnY1vDqbq5ziin7V0mbyhnMQZN4c4lMeJDwJ4LfQL7apUuk3abgYr+tKl?=
 =?us-ascii?Q?8dlRgZv39kQzTef3Bp3MkRUdo3pIu98StIeutLdi8akk7l7P2FAjfnu7eQH8?=
 =?us-ascii?Q?4sxaoxFk3nnpNA8ScXpjemWHpZdPVRObpwItCjceqGI24jv5zQoPmpKZgPvv?=
 =?us-ascii?Q?wKTYWUP8rslrLXSkfIajaPidtnD4wmAytsDwnqpf1VFWDWXs8yTmyPTHDtrf?=
 =?us-ascii?Q?U6tY9AmXDCayqgEOf8NyKmqf59GxCXeY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 23:58:53.4911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08798f35-4598-489b-60d5-08dcc3cf8aec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
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

Populate cache line size info in topology based on information from IP
discovery table.

Signed-off-by: David Belanger <david.belanger@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cd7b81b7b939..48caecf7e72e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1434,7 +1434,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
 					CRAT_CACHE_FLAGS_DATA_CACHE |
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
-		pcache_info[0].num_cu_shared = adev->gfx.config.gc_num_tcp_per_wpg / 2;
+		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_tcp_per_wpg / 2;
+		pcache_info[i].cache_line_size = adev->gfx.config.gc_tcp_cache_line_size;
 		i++;
 	}
 	/* Scalar L1 Instruction Cache per SQC */
@@ -1446,6 +1447,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 					CRAT_CACHE_FLAGS_INST_CACHE |
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
 		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_sqc_per_wgp * 2;
+		pcache_info[i].cache_line_size = adev->gfx.config.gc_instruction_cache_line_size;
 		i++;
 	}
 	/* Scalar L1 Data Cache per SQC */
@@ -1456,6 +1458,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 					CRAT_CACHE_FLAGS_DATA_CACHE |
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
 		pcache_info[i].num_cu_shared = adev->gfx.config.gc_num_sqc_per_wgp * 2;
+		pcache_info[i].cache_line_size = adev->gfx.config.gc_scalar_data_cache_line_size;
 		i++;
 	}
 	/* GL1 Data Cache per SA */
@@ -1468,6 +1471,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 					CRAT_CACHE_FLAGS_DATA_CACHE |
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
 		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
+		pcache_info[i].cache_line_size = 0;
 		i++;
 	}
 	/* L2 Data Cache per GPU (Total Tex Cache) */
@@ -1478,6 +1482,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 					CRAT_CACHE_FLAGS_DATA_CACHE |
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
 		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
+		pcache_info[i].cache_line_size = adev->gfx.config.gc_tcc_cache_line_size;
 		i++;
 	}
 	/* L3 Data Cache per GPU */
@@ -1488,6 +1493,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 					CRAT_CACHE_FLAGS_DATA_CACHE |
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
 		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
+		pcache_info[i].cache_line_size = 0;
 		i++;
 	}
 	return i;
-- 
2.41.0

