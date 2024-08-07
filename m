Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F253C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 09:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E61110E4A0;
	Wed,  7 Aug 2024 09:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xC/qrmCp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E67110E4A0
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 09:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx2CBUesvR8ilVytYHWAditqZPBDfcwJ8aO+e15Olp/0ZFltPVmts8azJqhc3vFYxo7OpVgwE4/oo5UBLWNa+XMXkGERa1mZm6N30tcArD6FV39/+6y/KABG2+g1MuKNmeDGc6zvy4BkJa0xceew9tf+zTfF0hrCuNcjWpgFDeBNmAjk1i+/TPRCWMsMAyiMGsSQaWPvd8vGRP9nBbqT39qjxZChBmY0oMmom4U2BnVFZLWL6ILnjxQkbh6xBtc4DMKPjh6FTZYiJ6qPUX+6Ntlk8T4axWqF9Vd54E+rgBhqAWiZGxTi6oThUwyfFmfL7+jY3w9MtGbXN4cwq4wB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjP3vpPnF3QQQNS+sdE/7OUcaQuaT8h71otySK95KHg=;
 b=LOmtA3CQ+RA1v/zsdooBdMAQZOTXokGuBEQ9cHrlYVIoi4DOE9HV3fpi7cZBKFyuOqra7hX8ci9asaT3OAJzGQ5+3qDqdNzTBAQ7ZZkVHNsIoXp8Qgzcqu0mh+r7NFilhOcwWHZozG2X7zFs+JBryOfyBh0w/RsaVrA1mD/hi5M9zTquZ8gbEGHVbVMar3nuT1Yl3ZyfLGImBT7kBMX4l+CN2AE1s7nZtgluG5iZxC8/3JM/5RWTk5fS5Kpjd+d5RTyktNeG/5KDT7F8Mi+K3/+sfRixudiHnFs/UwP0+lcL0yQvKcfSj8zJm7k/hXOV9GVfQ/Ngt4UQEIUQtG+z6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjP3vpPnF3QQQNS+sdE/7OUcaQuaT8h71otySK95KHg=;
 b=xC/qrmCplrZ20TncDTUGiJnItXt6eC3MXEAd9nqPvSwt9C7M77fLxIWQNbPfdFGgMGKM9nGmQUSTvnrIm/KFB2YN/ZffZCP4qThB2C4/XNyrALGlkoBK4paT5QdSkJzm0UzqDxaxxmJmXf4dFX9vZmNVFBGytIe5IGa8pw+AcpM=
Received: from DM6PR21CA0020.namprd21.prod.outlook.com (2603:10b6:5:174::30)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 09:39:11 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::5c) by DM6PR21CA0020.outlook.office365.com
 (2603:10b6:5:174::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8 via Frontend
 Transport; Wed, 7 Aug 2024 09:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 09:39:10 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 04:39:09 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 1/8] drm/amdgpu/mes12: update mes_v12_api_def.h
Date: Wed, 7 Aug 2024 17:38:40 +0800
Message-ID: <20240807093847.2084710-2-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240807093847.2084710-1-Jack.Xiao@amd.com>
References: <20240807093847.2084710-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: b5453341-24c4-4578-5dd7-08dcb6c4ca93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sy8nPLjvPYLMHxfhLLrVya75cdnvq7bSYIRDkuXKaXZtlDIS/fczTDvxzC1S?=
 =?us-ascii?Q?RtbzaPrb0avG1a+wEpTJUQWUp247HTam///mwGSALTcGMV0LMW5vAT7/lc7a?=
 =?us-ascii?Q?GtFUWRViYsoHUnUfYe8l7jlHbqzekAe8AfzLz5Arn3f+eqMRXe1dqGKOBN7W?=
 =?us-ascii?Q?lvNyLw2fi3Di/4VTi06n4hgGEVd6IG/VoYcd1G7VIFBeDSuqu65NIVoqmr3I?=
 =?us-ascii?Q?umzE7UNm/qbvKLJxLu0sqYyukcGnxy2viG3txlwjVzb2I+MhU20IGb+sdrjU?=
 =?us-ascii?Q?XpyKm57Jg50ta3z9wo/Pj1DqD3n4j1Ks6LQHejKP8CFn8sRZZMQAJRTOs/KJ?=
 =?us-ascii?Q?yg4cO6jfpWiWmCEbUQhndBlfUTRLkRJOI5ZUJwqASAD/fqoF9M+Ave6u6F5v?=
 =?us-ascii?Q?fCbdmRmOAvArLaOMO+yN4Ca4Zc1ydKnE9abVpLZJ/XYD5d4sqhOYuQG6oHRo?=
 =?us-ascii?Q?rief51eGWm89sVj5qYzY3lGgtO6NieEbl/eYMq2r/vfR7c2lEenRDbguZt6p?=
 =?us-ascii?Q?vxV0UY74mrN+XwTSRPyTBH2r93xLsKoIW+Rmz43V/Np8bBjedLZWtM5aia17?=
 =?us-ascii?Q?5+sUlE64RoOn0CREQRTF/f0Yuer1QIbOVHVmP+gc9LEL0uA6I3YH2UJNuku4?=
 =?us-ascii?Q?bv+ekmTvPvhc5mQ/d3f54pGxPEKv7kytC/tIJdb4SpOcKw9n2GTG0tesrKba?=
 =?us-ascii?Q?F+yp8YLh9T9EGmxJhhaekEf3a1ybM7tr2cA1fLa9Bl0+7WfCuPJGf7q+OxTH?=
 =?us-ascii?Q?mhp7nxifhnoinWvH8izOlsCZLWeYdZNwjiXdROPzeld4QZcAk5NUE8T3F4sz?=
 =?us-ascii?Q?uDbvh3/o7Zb1YUBPpq3B9Q31Uop1ckavEDtaEyhbwhLmze5++k9rtXHdeCls?=
 =?us-ascii?Q?379JBBpp+JwbviBuSSMkM+ZnRphdKJYOnx2yi95ZXC8MCJc3r7XlW1IDLKwU?=
 =?us-ascii?Q?betpdRYvuURe0syZXIUJsYgGiu/U3ZvrBKlfW8/QjIj4gzq/gate7ZpKVdwo?=
 =?us-ascii?Q?Qpn/tf/WVWqAwcdY6DOy2KBTAQ5vLquVAsEHXZySxboYisZ5mCJwmWbPHkqe?=
 =?us-ascii?Q?zNt3u6/NxZt+FLIeiFDgwacCipY7Aw9TaT5R1GZWmP6cAMPycLviBpWzOa/t?=
 =?us-ascii?Q?y8dFs7wNyuYUyURo6UJLOrtHhh6eJ/8HZBpgRdh0wZw7LlnGiglOab/qtrUV?=
 =?us-ascii?Q?mvze0IF/P6s/P6LRDCWZI2d4aIHFXWsOu2O/Ua2hQC5Ukb3+3aC3K/1dkKHL?=
 =?us-ascii?Q?Nje4pS7KfrMV8tcXfmovcJaYpxO5cQhvL4hPWzzlDY0lFbPUFUrLL/uRfI9n?=
 =?us-ascii?Q?An3iq0JmNUdhDBxPNcZD4sMUUj3Vl1FdhZbdLnze9r0XOPZmN4cxokribvoR?=
 =?us-ascii?Q?ucfYZPLVX4ft2n5gYFEmU5rP8dmSlljBBE/AhF3XPDk5D5hqjyvg84GmR2AX?=
 =?us-ascii?Q?Bo5F9Z+K+Ou3gF5n7hl/by/Gqyc98Fv/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:39:10.7174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5453341-24c4-4578-5dd7-08dcb6c4ca93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
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

Update mes12 api definition.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index ffd67c6ed9b3..30224bf7caeb 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -94,6 +94,7 @@ enum MES_QUEUE_TYPE {
 	MES_QUEUE_TYPE_SDMA,
 
 	MES_QUEUE_TYPE_MAX,
+	MES_QUEUE_TYPE_SCHQ = MES_QUEUE_TYPE_MAX,
 };
 
 struct MES_API_STATUS {
@@ -239,8 +240,12 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t send_write_data : 1;
 				uint32_t os_tdr_timeout_override : 1;
 				uint32_t use_rs64mem_for_proc_gang_ctx : 1;
+				uint32_t halt_on_misaligned_access : 1;
+				uint32_t use_add_queue_unmap_flag_addr : 1;
+				uint32_t enable_mes_sch_stb_log : 1;
+				uint32_t limit_single_process : 1;
 				uint32_t unmapped_doorbell_handling: 2;
-				uint32_t reserved : 15;
+				uint32_t reserved : 11;
 			};
 			uint32_t uint32_all;
 		};
-- 
2.41.0

