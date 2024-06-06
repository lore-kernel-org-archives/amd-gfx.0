Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522B0C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E5F10EAEE;
	Thu,  6 Jun 2024 21:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u19p+X9p";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4E1B10EAEB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKw4SvbJ77LTK4YNfXvV5C/8t5fY7N2TSJw3vHUgWqgwEgF/xP3flgoGmFd3UJ7XvGv5WTNNnBH6TzyrE77qDjdsyN16FPl9tAjahshs85mfcVK9VV58iQc+MggNak4DSVcuuW5gotSMWGUT2/Fli/zD9NpuYi76mytSsOBxGqb+XSbPlh0NUWfl3MiIabXYf2pybPKccOmqLLNJ6UMavmDjx4Ly7J10L/FjvU7Jquxfu1Isw/qWgfnQDPFqZNjk687oiu/Xvoz+5XaiUoH+gUHee5ti4RrnVhZ6XNP+/CkAVpIQ0rzqkOG33+Qbv0H4i5PC5QJCuup21b+nwQS0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt7ti8/GhfBLcBb7mSOeDmLoc+/3lG3M7corYJi1DGY=;
 b=e+VwrT65vhR7BXWKr1D/ONcWY18qA6Nq1sBCwiRn98Fe2rByrBrZSubvWGaeiTHtD8dLLerfyHFmbrblChfPbmdxawJPXOAg6uH+z3qLfiw+1CHIANHPVGqSzmQUysrdTpQzPjZUZiH8Gp/Vag0Vn19iSM/Me5UeuFoy7ggoOXrtnzDeuVej8iV2eGL3niF3F7Ky5CuMTJRTZJ2soAlnmonIe2c0mWHmFNaHPu/YIPpg8DQEZCrDccxj6MWKrASk+bqtr0tZJI72xS0lbK6Hi7P+idDTcduF7OL+IRAzuxcls680mO0wkUdBF/+pPUvyElCsW004e4Vj5WUKxVGpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt7ti8/GhfBLcBb7mSOeDmLoc+/3lG3M7corYJi1DGY=;
 b=u19p+X9pPE9xgrj/OBjLjF7EOgBJRExv9nygHJ6Wu8YQZ8Lc/AQ2Qz19sSfKz7wZRWpU9QZW4JFdVwOCUuChpkFrz9NiiilZPbGaCkL/BAeDDvSN7IqpnbB0nrFsOv4YCQ1GTbrrxWIoCyV/UmnNAoUPpQEUkSdu8AgJvjnM4Vk=
Received: from MN2PR15CA0062.namprd15.prod.outlook.com (2603:10b6:208:237::31)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:57:49 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::8b) by MN2PR15CA0062.outlook.office365.com
 (2603:10b6:208:237::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:49 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:46 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 34/67] drm/amd/display: Correct the defined value for
 AMDGPU_DMUB_NOTIFICATION_MAX
Date: Thu, 6 Jun 2024 17:55:59 -0400
Message-ID: <20240606215632.4061204-35-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: 01013029-660d-4ed1-5257-08dc8673b4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R0mcWQAXqupsQkBz6joWaTbsLvUs+cY/74ghGetkakAaGCy933cRemj2pf+R?=
 =?us-ascii?Q?LR/en+29r2bRXItZ5hnh5UectthK5fDXqSgnRxhb3ymHhgGw14eUTD7ezLOj?=
 =?us-ascii?Q?RERml2UDDsVXvUvleotKmI6igMtT+fxS3X3Qpaxi18UyBZE/zWwXzFaFubZO?=
 =?us-ascii?Q?tMN6HH6Q6Slqg84fEjlLd7Q2m5SHlQXyNY5Vi2Ye2TbuSg5btfWtcaAz3a9+?=
 =?us-ascii?Q?KC9pvn25gd0qA2lHTDo4YtXiYMLYJF6n+RvKMiPTSAaGBrfLPpT7RgVFZ0Wf?=
 =?us-ascii?Q?VIfxHYl4gtqHpg1DArP0wPrDN40wrSMbcwCrpHTCSK/Ox9qk0gayeVRNTcI/?=
 =?us-ascii?Q?2gLqJU1/1ikSKdFBMVEMpe7vDrJ4Cp1/SJK5PCVdwQ+JQxu7l6YvXK0LncjT?=
 =?us-ascii?Q?q4rAm3cSd5K4i7rj13cnta3O/PRvar041Xf3vJq7u7DrmTZgMmLvmh/UDmxX?=
 =?us-ascii?Q?6R6VvJY2cmWj5MnBBiQ8PnTe155+ZCea8bEHx16a/5cfeFDkYQUxQjB3fBmj?=
 =?us-ascii?Q?wQCwYNaocQIDDVucb0Jd15QCw3BVnPBo1Vxq3i47tKhkll5/w9uM/bdnmzlc?=
 =?us-ascii?Q?P2XLjkhq/J/E7fAeDc+Z7+B36I/yfVzaONUROHXYe4wC39sZ3ENDkINgMLnx?=
 =?us-ascii?Q?hYlBub6eLyCAE0vFcY14sDWCxfn2JXGtVA4kjiJax8ClPY7TFD6NS/Sw8/VM?=
 =?us-ascii?Q?lC/ufDmvm6TQfihCOl0nRIu0lP2t+zOOpTtx7dXHQJYRFL01es7NviPbsMrj?=
 =?us-ascii?Q?/GMzKyXpcqhrSRjVMTSEatEVEfCrei8hSv+eW4meMLDwVM5UTq2yHa9lJ0nc?=
 =?us-ascii?Q?Ju06Y2B0RgYACeAo1NA1E8IH+JJ1kdzNZxqfUlVAGYdWFHpNKxadW97eOQnv?=
 =?us-ascii?Q?1j85rm1YaVQ4lgSW8o9a1XGt2S8kbOCi52PutyIlnxcXiI8MtKbNE/+SYRDm?=
 =?us-ascii?Q?7Eee/N+6BNel8h3q3wux7VTdhYK9Ilp/rK9RfW40FMzhhEIoBOccM9kTcaZv?=
 =?us-ascii?Q?yTtO5VuPdsFidIgQnSlBfL/rawfxiHEZ/7jWwb1QsF6wVx5BCv2CKhDDJjbR?=
 =?us-ascii?Q?YMTtJUoAAZSyuNo/agEgTH/0nhp6oRqdZYgPqE8y7RS74MJpLHDuAudjaHxM?=
 =?us-ascii?Q?iFg/BkMNPPLsHlgwPcv09AR4aFxvEHCbgAxaNz5BG/KzM7OFyw0waRJ8gRTV?=
 =?us-ascii?Q?svv+Ioga7mvSHtz448cQ/r/w3rTrDCyhYJKvR473vHy2dTOQSfKkqjlcfXlF?=
 =?us-ascii?Q?vGEhhnbQlaB9Uir+PxYH0I7Qzfje1XeB+QQIc/tKW1zFZ7yDMf/MKd3wdfoI?=
 =?us-ascii?Q?2gNrS6aRpMh4UI+5F6trl/QWVC5eErQqMg9DmSFTlnIsrP7ROpj+njS1txPJ?=
 =?us-ascii?Q?2kEtUzO0aomngAQJlLMVS6tvSqapTaTGoanOCjrY9hMJt6xFBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:49.2251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01013029-660d-4ed1-5257-08dc8673b4d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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

From: Wayne Lin <wayne.lin@amd.com>

[Why & How]
It actually exposes '6' types in enum dmub_notification_type. Not 5. Using smaller
number to create array dmub_callback & dmub_thread_offload has potential to access
item out of array bound. Fix it.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 94fc4c15d2db..ca1867702742 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -50,7 +50,7 @@
 
 #define AMDGPU_DM_MAX_NUM_EDP 2
 
-#define AMDGPU_DMUB_NOTIFICATION_MAX 5
+#define AMDGPU_DMUB_NOTIFICATION_MAX 6
 
 #define HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION_ID 0x00001A
 #define AMD_VSDB_VERSION_3_FEATURECAP_REPLAYMODE 0x40
-- 
2.34.1

