Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819D4D3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BED110E68E;
	Wed, 10 Dec 2025 07:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VAxqSrKF";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010006.outbound.protection.outlook.com
 [40.93.198.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2BFE10E68A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft5uQpcUrSlnm4CLU3yTZGA+FZNTLVLRPUntraoXXAadBMZHaSEyw/Fbv87Tuos7IDAKup9WjpinQu8yrd7tk8DRB3FwFfmC7x01nVshXCfQKnoEHXYOPH95zWcuTOV0mdGHt4G22eiDjlVu1vQq1bRgS1SNTOHh2gDG6MRgCPo6+QkUr37rqkq3ZLwRbF+mJiBfNaypGC7UlKnxX+M3QBb4VVKyB9uXkHxj8nAgsNrNNUyDzOb7unuQSFrh49ffnGUawo71et8KwIgkUhIH4b2nMc1xH0lDXUmmg9lFxX3CF3RxfVJ1JOlDuUSATZMMD019YLRKSpXBg5fdMiH7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j/ttSEKDMx4FBD+A7FlhsoncJCpWDkhFQxjBoawR00=;
 b=tLDt2qLQgdZ4ROVCmMQTvVHchIS/thodR804sgkhdaDCjoTsIVdeUa4/EQWQPuUDkucy1nzTJT2vyGzvlC3R4nC6fLqL86CoeV342uTcQB0MsE5dddkuwywvTcudxZGeRmKS6NrvQIZ8gA1uh1ECtqqlcx0r/mtkCE0sEksyNB8uKHUtDR/qLSvEvKRtRsSFUaizRYe+GThGiEGjQ1QRM4GvNCOK+u88oama5bQMG969m65c9lZjVtvXDP1YLTFIx50CmpGcvwsBKFBLqxVw26WoZGtF8tnL0fQrT2XbEtMRIOO4OQ3ZL3yKPbbiWmozAbTIG5Z8Sb7q6sm/5zRKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j/ttSEKDMx4FBD+A7FlhsoncJCpWDkhFQxjBoawR00=;
 b=VAxqSrKFLGKmzGEmZQsGqT+dFwT1BSIlhM3MXjkI4Zo97dw7E+FRVQUHRGo5KOBBf5vongXtiAgM/oM/qtr+4NWV0LVu2fkE+cVN+/w2JmOB+8kP6n3Goz5WzRgXq/xgh0QWxMjXSQYDuaOxhPtKeMCe7zntcFT4D7bf212kkMw=
Received: from SA9PR13CA0046.namprd13.prod.outlook.com (2603:10b6:806:22::21)
 by IA4PR12MB9835.namprd12.prod.outlook.com (2603:10b6:208:54f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 07:14:41 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::92) by SA9PR13CA0046.outlook.office365.com
 (2603:10b6:806:22::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 07:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:41 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: correct rlc autoload for xcc harvest
Date: Wed, 10 Dec 2025 02:14:12 -0500
Message-ID: <20251210071415.19983-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|IA4PR12MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abdd2c7-be4e-43d4-6886-08de37bbc96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1rbNTdGgfeWnkXJJSIn5LFCh9OG5q7z7MYDwm+WJL+ZMS9HDNBKjujrS/3oc?=
 =?us-ascii?Q?nO36tO7epmhtMtgoP4TqcNLU1htC4v9jJ8fX8cQhXARkFsWGzjNgrAR5nHXi?=
 =?us-ascii?Q?9PVTbsWKv+eMsx2AK4jMozSUySIovjNshs9nMikr8QJtjGc1+YpFnjjrJcRD?=
 =?us-ascii?Q?Wk/sPtGDFV/+YqBbnnpK9gfg9H9cyQuKxcRdihf0L4qK4vIjdnNhbzNmxATx?=
 =?us-ascii?Q?RRpnL2NyN7NtP+T117G/8haX2aK5csbo4nAdYdPk4oANBapJyFuvks4EoWWG?=
 =?us-ascii?Q?XWr7vV2cYIUI7vihBZZaPPZQzJ6x5DmnJ6HtLFr1XeGbXkIXQCmA06YoRsc5?=
 =?us-ascii?Q?9wpn4HZ7MEjX+khDg602KGVChEx/t+21TA7+/fv3It0dfJpV63uPSxcrexIT?=
 =?us-ascii?Q?d2kEmFjRSM/Nty29giWcUDJ+EPcznInO1axC2FCakBTBWumWdcVOG0/KxNqa?=
 =?us-ascii?Q?DvW0WfGnOxwI5cVJc4GZl3Z48wseCCEryEf2yP8qYO4IrF644CHBsn2xD+nC?=
 =?us-ascii?Q?Bdxnd0AV4tDbJ7zo9RQWwCTa78mTUxi1s+r2dVsvoSRdFLL+cdI1fgZf336/?=
 =?us-ascii?Q?0MZwa4dvT7/ADKrHjt+CzNcoQbpnsLEYJFzpzSaAtsxMb2iKoZhu8elPByZ/?=
 =?us-ascii?Q?BKKVwFLjekNttO3/UT+3KAxR9CR+2MyERvMuDX8cVfoiKLxT1vT9xePEUxac?=
 =?us-ascii?Q?q2Nshwz6Xi2v3wQJFu5kJ/qJyCPLtzJcNDM/oVKxzCo1+HjIq55iM5ezUazx?=
 =?us-ascii?Q?0drrVcNVGl9Wozm07pTVhOz5Q7S1z4asviIacTFnOqGtFBcDyj21anDOZMl7?=
 =?us-ascii?Q?AizWWVGsiJB9+zTNwTFCkCMmyhDSuvzAw2w6ayscdcY+sLFI+59tO+JTc6ng?=
 =?us-ascii?Q?XDYZVqGQ2muf3IYHX9bqhF2MN94mvJ7lEhyrPn0EOZ493uzhM3bLOo77GzOy?=
 =?us-ascii?Q?0F8QUfJB8dXJqZxc9xY23l1E4oEJjlPjzzzGMVvKOocQIjhQ+M5QGCBJosaQ?=
 =?us-ascii?Q?Q4SfT15vDdfMLUyzqlwIPsR0loWnxNodQDn9meMO8OL5IhwgBWZnw7bmRE6N?=
 =?us-ascii?Q?16AkGerbxO/3NCAJ2Djstxs6wic7iX244gVHvuUfqNVuOyQwDnqcURoNleIo?=
 =?us-ascii?Q?l0Zl4WsAMCCNinru5q3OGIZj37EttDW6yJ5Q+R2ziJ+d/6Czh3VDTjrqhYpF?=
 =?us-ascii?Q?sPr91ThqCgIP5VzrFhTaaxXAYMLRWvr6hNkWB7NEDPiG7Qv7XpYYCyojYWy/?=
 =?us-ascii?Q?RmObvM9XKWfuQFPd68hS6jJHcTSPte8rwxg6J35QpViL27VqDfN5JLJaozzO?=
 =?us-ascii?Q?h1zKRCuzVcOt15f0TF/eFTTNrDPH3aQRZHZ5Tj9dqYtZSUS2a+qcxzGciEaq?=
 =?us-ascii?Q?M2TqDM86k2Ti/PpIfpdyHrFmmFFjDGyW8YIF4PzpLhMSLLmJ1ptkydhc3hU/?=
 =?us-ascii?Q?YoOItMW1s+qn6f8RkwIPAEXV/m6SZxp/lItHYDsFL6iwaBcOHxoOtKiPdAjN?=
 =?us-ascii?Q?REzg2ho26fjB4jhlTdpMj5QWg9HjKSdyJWKuk9siPQMbI6p6/eaxMaERyjgZ?=
 =?us-ascii?Q?nRds5encDE6jhkCflhw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:41.0199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abdd2c7-be4e-43d4-6886-08de37bbc96b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9835
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

If the number instances of firmware is RLC_NUM_INS_CODE0(Only 1 inst),
need to copy it directly for rlcautolad.
For the firmware which instances number bigger than 1, only copy for
enabled XCC to save copy time.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 3a641d223ad68..96ca3648205d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -933,7 +933,8 @@ static void gfx_v12_1_rlc_backdoor_autoload_copy_ucode(struct amdgpu_device *ade
 		fw_size = toc_fw_inst_size;
 
 	for (i = 0; i < num_inst; i++) {
-		if ((1 << (i / 2)) & adev->gfx.xcc_mask) {
+		if ((num_inst == RLC_NUM_INS_CODE0) ||
+		    ((1 << (i / 2)) & adev->gfx.xcc_mask)) {
 			memcpy(ptr + toc_offset + i * toc_fw_inst_size, fw_data, fw_size);
 
 			if (fw_size < toc_fw_inst_size)
-- 
2.52.0

