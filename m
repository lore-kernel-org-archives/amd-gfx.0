Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF70D36139
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 20:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7032910E424;
	Tue,  5 Nov 2024 20:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ugSI8iJu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B1F710E60F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 20:24:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8ZB354ZW88CEkmctb1vTEei5IKJX9KcvfAB20KdzzbIoiJ5zl6VeIUqfgXOVVQF6uq0Aa8Yjc5cGsjMV11pmJCbQx5WtzHUU/iIb8iLGeA69eo8dn6htegjMaZQnqPB3vHTaBlQKLh7h5LgJBeAyclIsvUyEwU2BV1QVc6CrzqJnHocXvaGUWX1mqmYi+gLFSLfyrIDVoo7WaJhtGodlxQbsxjiVTANKV7fUH1bFMVvrOvYbtit0K1fw9vM3LUKUY0gy50Pfi7GfTGPDMczCKMTfiZ2QZhUt6FiPOFVFEuAUtZOR0+fqF49U4zIFtnS86cZE7qvbN+IQGYLDWVv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/jtngIt0cNKBYHd3vNdxGEWUQDOlbrO7Nq38oj3YnM=;
 b=vxl4k+eBGlDaK+fCE7/brrsSlT0BJd+PdqPVYQsdGgRqmP/we2UiC/TA9nd1ACsIFSIYT8N4BBUVOHHTaqczkttoXJc1UUaPEMxg9sFwyyeL+tyvfRn9KwjIdjcgvdTlYWtLAIdYMCnNy7mNZ8JGEfVUr71Z77vNJkGp+iv6UM+99GmdwNJ3JmzRf79gbXXYwQEHOrNGfe6RF2EJjLT6rairSHghwGyflReOGjBQucCoFvwS1/RGNieZM9oK1LZXQQVJuhrr5Fa3vJidFvvFLDX9f3wbUFUERS6c2ixLcpCjBW1DBf+/Jv56SfedSPCMFmJw8j1lnVW4bZj64r4nOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/jtngIt0cNKBYHd3vNdxGEWUQDOlbrO7Nq38oj3YnM=;
 b=ugSI8iJuMg1dE5A4A52t9qpXA++06j83owEDdvR8Pq+5Vnvc4HdFCvqzYMmttG+AYzMmeO+0/GgR0N3Ya7xcmgqfe15DOHS3FX0O/0R0+04iTDJ/yHVLeijuv7ViLlkuE0iIPwA0DM4b0uxkM5Bdb1u4EORoXl5RJu/EAaQoDnk=
Received: from BL0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:91::34)
 by SN7PR12MB7297.namprd12.prod.outlook.com (2603:10b6:806:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 20:24:38 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::18) by BL0PR05CA0024.outlook.office365.com
 (2603:10b6:208:91::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:38 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:34 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, JinZe Xu <jinze.xu@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 10/16] drm/amd/display: Use region6 size in fw_meta_info
Date: Tue, 5 Nov 2024 15:22:11 -0500
Message-ID: <20241105202341.154036-11-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SN7PR12MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8f4f4d-7b1c-4572-e0f3-08dcfdd7df76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ZZw3eJLDaOr+7cv1ggcU6QOw8Ul5M3md4AfIDVWA/1jVz7PyyrTTuc/Q+bz?=
 =?us-ascii?Q?fO88uL2+xTjiJaij0fN23cLP/kIa3Lr0qgVzaYzEvXvGNFeJcpnzzaMXRTPo?=
 =?us-ascii?Q?RNmbGpKVdWJ4wDZXK0XFni1Na6h3kQ9bc/MGZqQbBHLRgC3bchtpORHflz5m?=
 =?us-ascii?Q?GNcJ1fZL/woWQ7uijKDc+7/FzFOOGrLkbPYf6QaJZo1lODFNcwPoCnN/zDRX?=
 =?us-ascii?Q?fSErl7PLUKu79HHGM8a0k93uZrggOr0vnswasbae+HvqWQtwCT4cuxi53kVv?=
 =?us-ascii?Q?sgWKMQma4z6JPfwR2beVjjuqiycoaN3uGQWkyKCX4fl4pzO1ttNIkpk8mN5M?=
 =?us-ascii?Q?6R3y8SsDqf+4S/3bSy8Gh82qqiQSHN+sQ1Z/wlYCcLdZ3P4bpz/FNkoQOcVd?=
 =?us-ascii?Q?AEE1iH0Jry6P4Eu5RHWGV72n4hN6paz/BfaoOEoYHcpk5uP0nSsUSW4barda?=
 =?us-ascii?Q?wfSIX/u3kSULtZAr+GEHBKuTv73U09vWAocCyMIb5QsuNKSawR7JTdl5jAa8?=
 =?us-ascii?Q?HtzDLAFqt2XGbnM8junRXNiKLz9IlLowg7fon3KhG76rhhliKIjHbmpe2507?=
 =?us-ascii?Q?Mw9MSUGaiXBfWJHaNT7gNv40NbeDjHSPK+XQwNP1psaDCZ0E52HyH/Y8CyvT?=
 =?us-ascii?Q?GY3iY8g3geoeVs2ZXhY7RKp/1+mYJOSrwsQRTxJ+xiD8cQsNx/KuuF5hUtOF?=
 =?us-ascii?Q?7EQdUTaWd/MXLbDviRCKUrB01fJHjaC+n7ys/wcsPQ/rbs41EhCXt1+hooMb?=
 =?us-ascii?Q?eAMT6Jd74aiKMAx1sa5ByB4Yz/98wjnkpq/6yAymFuKwXRWlxv9AeO/9x0Rl?=
 =?us-ascii?Q?/MIpxKlUDdVdpMThd1siQgZNo6j37Yg9NFoUAjyb2bgDtbJ69rgWtSAURsn4?=
 =?us-ascii?Q?jWDTzYHM6QTTV07XCwnjieN5mZikJUIrq/qbSL7cfD+2nRwIsSaSZVZgXHFm?=
 =?us-ascii?Q?xFy0HU77GZ2Pl66nUAyMsD+0NPotATSCG98Opi9GrKHuFA7Rh+9l0kGYQI14?=
 =?us-ascii?Q?zfwBIcTNum4NGWn+dNvCz26TAb86xfcsUP2rI7iCIAze//+EiNaoITgH0Ka7?=
 =?us-ascii?Q?tKURxHV/m2NgYDRYJxhvwaTiwYOFTKyR1O7LO3pf6mcvfVX8KlhXzw5nKsz0?=
 =?us-ascii?Q?pYekxQCVC7jVObxr61i1CrrzPC3rgHf7tF4DDgfOm+/RqN7EiaJ42n23UJJn?=
 =?us-ascii?Q?DUoHyeZcugabDGDQEA+gaN97HSUgf2V0PQqpDGWZS8frnyiaw5CBdIx5uoo1?=
 =?us-ascii?Q?UuQF1WHGXW0q6FZFPV2Uga5vYkKaLBXrmJJGQwhC2xNU2o+msmFIYzHxPCyg?=
 =?us-ascii?Q?QKvhcylmWPOmYUtUwfC9BuR/cnCxotzZf79mTtfvzb0GKtkIaIQ1rPXBg9Nw?=
 =?us-ascii?Q?PGokpKr8rrQycfUl4b2SvhKSbjbTsNGTslosJ8cmqQPXVOqgfg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:38.7892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8f4f4d-7b1c-4572-e0f3-08dcfdd7df76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297
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

From: JinZe Xu <jinze.xu@amd.com>

[Why]
If driver allocated region6 size is not same as the size in firmware,
dmcub won't enable region6.

[How]
Use region6 size in dmcub_fw_meta instead of a constant value.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: JinZe Xu <jinze.xu@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index db16066bc893..a3f3ff5d49ac 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -497,6 +497,7 @@ enum dmub_status
 	const struct dmub_fw_meta_info *fw_info;
 	uint32_t fw_state_size = DMUB_FW_STATE_SIZE;
 	uint32_t trace_buffer_size = DMUB_TRACE_BUFFER_SIZE;
+	uint32_t shared_state_size = DMUB_FW_HEADER_SHARED_STATE_SIZE;
 	uint32_t window_sizes[DMUB_WINDOW_TOTAL] = { 0 };
 
 	if (!dmub->sw_init)
@@ -514,6 +515,7 @@ enum dmub_status
 
 		fw_state_size = fw_info->fw_region_size;
 		trace_buffer_size = fw_info->trace_buffer_size;
+		shared_state_size = fw_info->shared_state_size;
 
 		/**
 		 * If DM didn't fill in a version, then fill it in based on
@@ -534,7 +536,7 @@ enum dmub_status
 	window_sizes[DMUB_WINDOW_5_TRACEBUFF] = trace_buffer_size;
 	window_sizes[DMUB_WINDOW_6_FW_STATE] = fw_state_size;
 	window_sizes[DMUB_WINDOW_7_SCRATCH_MEM] = DMUB_SCRATCH_MEM_SIZE;
-	window_sizes[DMUB_WINDOW_SHARED_STATE] = DMUB_FW_HEADER_SHARED_STATE_SIZE;
+	window_sizes[DMUB_WINDOW_SHARED_STATE] = max(DMUB_FW_HEADER_SHARED_STATE_SIZE, shared_state_size);
 
 	out->fb_size =
 		dmub_srv_calc_regions_for_memory_type(params, out, window_sizes, DMUB_WINDOW_MEMORY_TYPE_FB);
-- 
2.46.1

