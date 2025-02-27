Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0746FC19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 15:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A680610EB25;
	Thu, 27 Feb 2025 15:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wh3pKZW4";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A5F10EB27
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 15:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5bO3oCWLWgZThN0HXX8ZxCba6dYswmnGt1a59HYsZBoBiGKHHIwxVaVd4/t2ye/2G3TJprVLJeMAtfR70ZWsSPIe/KcZ7ZCWLXPBvTMtsuvi2M7EnaARKMcZYkYor61yA5skjH8vGcgL01CwWBNlmOGkGOFNGlI99G9B3t9wP81OyVPHOpuajCRM2STPgpxxyTUzqE5KHIOXCeFFhLhS98uc4m7qAJy3Ajq/Pbnpgx/gITQ3MmqodA0Yza0Qk8nIGZX+lbXaPSp5riAIPx0d0Ew/GZcPDpp/y+OnJzf1kosKaPHyZvxaXG7cp8PJJIZtm89qiw4LoLJO73w+kxHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orsNDI9vtFoIZmWMcDk7EKOrV7ng/ChF6Y6SvCOYjuA=;
 b=B3iiF4I25d3WW6YtKIe1ReECWmheaZd4GUBh5ouwFkyOjrNiqCY97Vt2g49pmFTOmEoPCTSlPb0Ny9Cr24070q+t+9nRjsSf/qDlQG9E/I5bl+XHH2UVg9ZiPSW3enhutLAOLtGBSiuGfOCPtjpUOw5RU7CxBRshWGUzGL3YtqNlEzRDvEQl2dlTdvZoBqgl9weAQgUb5xT0N/TkFmzZuSsJIvBhxzFsGg22I7TGhbndK1t0kPGzBgRAyjP0tiIWHQQmAjiC9uBx1NC/ZYmJY1nQGrRSSdQn6FA2mebHWGm88QGlNJW4DBZHT2g9Ya/RjBnahR8bDiLWeRrpY9XlyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orsNDI9vtFoIZmWMcDk7EKOrV7ng/ChF6Y6SvCOYjuA=;
 b=wh3pKZW4xUZF4qXLawff5BukVmgB2Q9NZfAbyUmPw0eik6kdUFq7Q3MfM9T/ZVFwGkk5h+OJXAoOXPLAYcMDbxs0F5YYRvOsbr/dxKKf+EUt2BI+eeWLE4eCgy971WJ9Lc3fv0U1oehjLAH8VuS+lDsTDQpiExHNfMfdr8PouWI=
Received: from BN9PR03CA0470.namprd03.prod.outlook.com (2603:10b6:408:139::25)
 by SA1PR12MB7366.namprd12.prod.outlook.com (2603:10b6:806:2b3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Thu, 27 Feb
 2025 15:12:45 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::9b) by BN9PR03CA0470.outlook.office365.com
 (2603:10b6:408:139::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Thu,
 27 Feb 2025 15:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 15:12:44 +0000
Received: from sriov-ubuntu-161.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 09:12:40 -0600
From: Tony Yi <Tony.Yi@amd.com>
To: <tony.yi@amd.com>, <victor.skvortsov@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <zhigang.luo@amd.com>
CC: Tony Yi <Tony.Yi@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Update headers for CPER support on SRIOV
Date: Thu, 27 Feb 2025 10:12:16 -0500
Message-ID: <20250227151217.2620348-1-Tony.Yi@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|SA1PR12MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: f5997b59-e23b-4c2f-1963-08dd5741302f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BjKDxZ8fAHplDmJMldmzfJPN+eX7Kq6kWi4g/07yDG3vyOyhg0x4Pf0GUAkI?=
 =?us-ascii?Q?FMYjOYnK9wbzHMFC2oIIBi8LtGDCnbXRR2A9fvHPBbslB8zK1uyCAvDIvWuO?=
 =?us-ascii?Q?61EuXhd4gMQM1V6nCUfU0U7cxPPM1f36DLJ6p5aJQJA3VpT5BaOq3mjY5an1?=
 =?us-ascii?Q?4iBG89cr+Q5KcHRXc/lYqRhC8QpBvva8cq1T90FRapdxjNHmR5LWBRzNGi6s?=
 =?us-ascii?Q?SHBH040Fndmk7jPcOMHByrx7Ny7QNpzbBxf+tuWlq/3nVfNq4AouO8UhBqok?=
 =?us-ascii?Q?JR0oONm05U5iZBPF8mbCb+rZmpMwO7A6sLrivXHgAlqWIRVF9I0ft9lT3fR8?=
 =?us-ascii?Q?CcJwmQETcNWcipKm7FHhJP6qsSY5FzuemhsbHYV/rLZ9bhv0G/rFeQqdLazo?=
 =?us-ascii?Q?JUJnkZlY4BJIAmHNVlz+K2ppx6ZqpuIosOOstwAYPceuwx6FHtXyunbNprHa?=
 =?us-ascii?Q?bpDs4ZcuD9mO6uUVQ3EYGMLAKs7utba1eKLxesedKDjRvQ7rdSFanKAvz1C0?=
 =?us-ascii?Q?fJleY9GG7ohx67/CElcY38F5kzcnlz2ZeWJunS5zoOvZzJ7t+MVJ+jfrdrta?=
 =?us-ascii?Q?f6744j2MYwK0LiUgJVSdnSiLhZHx0YziKfq9usaOOmN2is+X6fIWzU8EUNdp?=
 =?us-ascii?Q?LrCBVosyGDGCnF2LLu7UuvOZP8tw3+O/EVuwmU0vXanAX/fZaFoc0LcmAv5Z?=
 =?us-ascii?Q?dmSmS0W0xfzX0rT7OBFiFNq1th6uL2qy1S5RcEaYwOCz//26/NeB8pujoRrj?=
 =?us-ascii?Q?mi2kwIqexQID1+3VYsSZWfQV8mr508u7XuO4NaduBUnbiHHywAfoJKbLFQLe?=
 =?us-ascii?Q?ldtQVnYJKaaW1FdQVkeNoFo/6gWOSmFVenX2UAAOuDuh9x0XEIVBpI5kKZVb?=
 =?us-ascii?Q?/DdtiLDKDjiqEEWg3TY8YVkc8iAICcqSKRKs5hTobLkEP1Kcj2Hm+7vw88MO?=
 =?us-ascii?Q?A2DESx4Z7RbwDK1ImnTBB8N7BBxzF8UVftQi4WKaP3irkFNNY/0ukzJlJHaj?=
 =?us-ascii?Q?G02DwUdjBEJGXkv1YdzdTNIN9go64+bD5k8ujR89IvnUj88KMn91PV0drPdo?=
 =?us-ascii?Q?04LXCqAHhDaEXT9vVVdKSeX8+ZKOF5PYQ/5/76DZjMIZtY4eTtIAOO1YzcQG?=
 =?us-ascii?Q?GTSx6Kg52OxU9DYpxj/v112IBDdRW+J0mPPoTlDeHatqoN6BQdZWAXpumMw3?=
 =?us-ascii?Q?9se2e76Aq1JCGAsFpsCqbyRdWsCzNMe4Dd995gFeBOjpH+Vvkc9HIM16oOY+?=
 =?us-ascii?Q?RO2+o+n6EdEkHc5hCh5FBhTmQqUvyawt7zeGRljW0GUq+Xd/RjaWqBPz+Gvm?=
 =?us-ascii?Q?NLIrhWgEHB/GGArBUH9MSbFPCGW/K7OGIIaTl9ruC175Kgbci3YIeq3kMtp+?=
 =?us-ascii?Q?zSI2fVFGHoh/w33qEiswd+fcLG4PB4EBBayDi9liK/CzSUaclIMdAu0ywuT5?=
 =?us-ascii?Q?IvXlaipSnuRCB2zCMpPpUa4rMHnOY309HvyfGW4Gu96XvQkfw9Z/VA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:12:44.8894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5997b59-e23b-4c2f-1963-08dd5741302f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7366
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

Update amdgv_sriovmsg.h and mxgpu_nv.h to add new definitions for
CPER support on VFs. PMFW ACA messages are not available on VFs,
and VFs must query CPERs from host.

Signed-off-by: Tony Yi <Tony.Yi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 40 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h       |  2 ++
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index b4f9c2f4e92c..d6ac2652f0ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -97,11 +97,12 @@ union amd_sriov_msg_feature_flags {
 		uint32_t pp_one_vf_mode		: 1;
 		uint32_t reg_indirect_acc	: 1;
 		uint32_t av1_support		: 1;
-		uint32_t vcn_rb_decouple 	: 1;
+		uint32_t vcn_rb_decouple	: 1;
 		uint32_t mes_info_dump_enable	: 1;
 		uint32_t ras_caps		: 1;
 		uint32_t ras_telemetry		: 1;
-		uint32_t reserved		: 21;
+		uint32_t ras_cper		: 1;
+		uint32_t reserved		: 20;
 	} flags;
 	uint32_t all;
 };
@@ -328,21 +329,25 @@ enum amd_sriov_mailbox_request_message {
 	MB_REQ_MSG_READY_TO_RESET = 201,
 	MB_REQ_MSG_RAS_POISON = 202,
 	MB_REQ_RAS_ERROR_COUNT = 203,
+	MB_REQ_RAS_CPER_DUMP = 204,
 };
 
 /* mailbox message send from host to guest  */
 enum amd_sriov_mailbox_response_message {
-	MB_RES_MSG_CLR_MSG_BUF = 0,
-	MB_RES_MSG_READY_TO_ACCESS_GPU = 1,
-	MB_RES_MSG_FLR_NOTIFICATION,
-	MB_RES_MSG_FLR_NOTIFICATION_COMPLETION,
-	MB_RES_MSG_SUCCESS,
-	MB_RES_MSG_FAIL,
-	MB_RES_MSG_QUERY_ALIVE,
-	MB_RES_MSG_GPU_INIT_DATA_READY,
-	MB_RES_MSG_RAS_ERROR_COUNT_READY = 11,
-
-	MB_RES_MSG_TEXT_MESSAGE = 255
+	MB_RES_MSG_CLR_MSG_BUF			= 0,
+	MB_RES_MSG_READY_TO_ACCESS_GPU		= 1,
+	MB_RES_MSG_FLR_NOTIFICATION		= 2,
+	MB_RES_MSG_FLR_NOTIFICATION_COMPLETION  = 3,
+	MB_RES_MSG_SUCCESS			= 4,
+	MB_RES_MSG_FAIL				= 5,
+	MB_RES_MSG_QUERY_ALIVE			= 6,
+	MB_RES_MSG_GPU_INIT_DATA_READY		= 7,
+	MB_RES_MSG_RAS_POISON_READY		= 8,
+	MB_RES_MSG_PF_SOFT_FLR_NOTIFICATION	= 9,
+	MB_RES_MSG_GPU_RMA			= 10,
+	MB_RES_MSG_RAS_ERROR_COUNT_READY	= 11,
+	MB_REQ_RAS_CPER_DUMP_READY		= 14,
+	MB_RES_MSG_TEXT_MESSAGE			= 255
 };
 
 enum amd_sriov_ras_telemetry_gpu_block {
@@ -386,11 +391,20 @@ struct amd_sriov_ras_telemetry_error_count {
 	} block[RAS_TELEMETRY_GPU_BLOCK_COUNT];
 };
 
+struct amd_sriov_ras_cper_dump {
+	uint32_t more;
+	uint64_t overflow_count;
+	uint64_t count;
+	uint64_t wptr;
+	uint32_t buf[];
+};
+
 struct amdsriov_ras_telemetry {
 	struct amd_sriov_ras_telemetry_header header;
 
 	union {
 		struct amd_sriov_ras_telemetry_error_count error_count;
+		struct amd_sriov_ras_cper_dump cper_dump;
 	} body;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 9d61d76e1bf9..72c9fceb9d79 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -41,6 +41,7 @@ enum idh_request {
 	IDH_READY_TO_RESET 	= 201,
 	IDH_RAS_POISON	= 202,
 	IDH_REQ_RAS_ERROR_COUNT = 203,
+	IDH_REQ_RAS_CPER_DUMP = 204,
 };
 
 enum idh_event {
@@ -56,6 +57,7 @@ enum idh_event {
 	IDH_PF_SOFT_FLR_NOTIFICATION,
 	IDH_RAS_ERROR_DETECTED,
 	IDH_RAS_ERROR_COUNT_READY = 11,
+	IDH_RAS_CPER_DUMP_READY = 14,
 
 	IDH_TEXT_MESSAGE = 255,
 };
-- 
2.34.1

